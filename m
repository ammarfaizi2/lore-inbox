Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUEDQ07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUEDQ07 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 12:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbUEDQ07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 12:26:59 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:22710 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264502AbUEDQ0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 12:26:04 -0400
Date: Tue, 4 May 2004 18:26:58 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Nivedita Singhvi <niv@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: TCP hangs
In-Reply-To: <4097B8D1.4010008@us.ibm.com>
Message-ID: <Pine.LNX.4.58.0405041811300.11971@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.58.0405021602120.20423@artax.karlin.mff.cuni.cz>
 <409583B1.5040906@us.ibm.com> <Pine.LNX.4.58.0405031238110.18691@artax.karlin.mff.cuni.cz>
 <4097B8D1.4010008@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 May 2004, Nivedita Singhvi wrote:

> Mikulas Patocka wrote:
>
> >>Which Linux kernel (distro, version)? What hangs?  Is it just that
> >>connection? All the kernel? Client end or remote server end?
>
> > I don't know what version is that. Have no access to it. Neither server
> > nor client crashes, it just stops receiving data in connection.
>
> That is strange - since your trace clearly showed the client
> sending a FIN and a reset, so the client socket should have
> gone away. Does netstat still show the connection? What state
> is it in?

TCP should send RST on received data after shutdown(SHUT_RD) ---
RFC2525, sections 2.16, 2.17.

> > Yes. So if client receives ACK, it should respond with other ACK?
> > How does the TCP prevent ping-pong effect --- clients sending ACKs to each
> > other indefinitely? How should the client know if the ACK is window probe
> > (to which it should respond) or normal ACK (to which it shoudn't respond).
> > What RFC part does say that?
>
> You are right, it should send data. What the implementations
> do (at least recent Linux 2.4, 2.6) is send an out of window
> sequence number (just the previous one acked by the client)
> to force the receiver to ack. Not sure why its not doing
> that in this case - but could be an old Linux. Its confusing
> since in the trace, the window seems to open up again (2 + scale).
> I'll check to see if we send acks or zerop probes under any
> circumstances in this way in the current code again, but don't
> think so.

It happens that the stack at the client ignores seq number if packet
doesn't contain any data. I fixed the client so that it replies with ack,
if sequence number doesn't match. Is it correct fix?

> But since the client kernel has seen the app go away, and

The app didn't go away, it just called close.

> has sent resets to the server, and presumably the server tears
> down the connection when it gets the reset and never sends
> anything again, why is the client having a problem at all?
> Nothing need hang here, or even seems to from the kernel
> point of view.
>
> Note that the window scale factor of 10 implies a pretty
> big window, and so for that to come down to zero implies
> the app has really crashed or aborted..

It has initial window just 8kb (8 << 10), lets it slightly close if app
doesn't read data, and opens it up to 512kb proportinaly to the rate at
which app is reading data. I think Linux is doing something similar.

What happened at the trace was, that the app was receiving data aith
read() slower than the server sent them.

> Can you recreate the problem?

Probably not --- it happens once in few days. Maybe I could recreate it
artifically by modifying the client to not send open-window ACKs. But I
think now it's not necessary, because I know what caused it and fixed it.

> What was happening in user space?

App was just not receiving any data, until I stopped the connection in
browser.

Mikulas


> thanks,
> Nivedita
>
>
> > Mikulas
> >
> >
> >>thanks,
> >>Nivedita
> >>
> >>Edited trace:
> >>
> >>par = paranoia.kolej.mff.cuni.cz.65461
> >>http = 213.29.7.213.http	[Linux box]
> >>
> >>1.
> >>16:34:49.832097  par > http: SWE 1711254266:1711254266(0)
> >>win 8192 <mss 1460,sackOK,wscale 10,eol>
> >>
> >>2.
> >>16:34:49.838957  http > par: S 1163781419:1163781419(0)
> >>ack 1711254267 win 5840 <mss 1460,nop,nop,sackOK,nop,wscale 0>
> >>
> >>3.
> >>16:34:49.838968  par > http: P ack 1 win 8
> >>
> >>4.
> >>16:34:49.840002  par > http: P 1:500(499) ack 1 win 8
> >>
> >>5.
> >>16:34:49.847349  http > par: . ack 500 win 6432
> >>
> >>6.
> >>16:34:49.863592  http > par: . 1:1461(1460) ack 500 win 6432
> >>
> >>7.
> >>16:34:49.863651  par > http: P ack 1461 win 6
> >>
> >>8.
> >>16:34:49.867490  http > par: . 1461:2921(1460) ack 500 win 6432
> >>
> >>9.
> >>16:34:49.867558  par > http: P ack 2921 win 6
> >>
> >>10.
> >>16:34:49.871498  http > par: . 2921:4381(1460) ack 500 win 6432
> >>
> >>11.
> >>16:34:49.871567  par > http: P ack 4381 win 5
> >>
> >>12.
> >>16:34:49.872729  http > par: . 4381:5841(1460) ack 500 win 6432
> >>
> >>13.
> >>16:34:49.872777  par > http: P ack 5841 win 3
> >>
> >>14.
> >>16:34:49.875631  http > par: . 7301:8761(1460) ack 500 win 6432
> >>
> >>15.
> >>16:34:49.875714  par > http: P ack 5841 win 3 <nop,nop,sack sack 1 {7301:8761} >
> >>
> >>16.
> >>16:34:49.876881  http > par: . 5841:7301(1460) ack 500 win 6432
> >>
> >>17.
> >>16:34:49.876953  par > http: P ack 8761 win 0
> >>
> >>18.
> >>16:34:49.907290  par > http: P ack 8761 win 2
> >>^^^^ this packet was probably lost or the last two were reordered
> >>
> >>19.
> >>16:34:50.088544  http > par: . ack 500 win 6432
> >>
> >>20.
> >>16:34:50.512936  http > par: . ack 500 win 6432
> >>^^^ this looks to me like a bug --- window probe doesn't contain data
> >>==> not a problem, the receiving client should respond
> >>==> with an ack and updated window. But why is not the
> >>==> client responding to the window probes?
> >>
> >>21.
> >>16:34:51.348911  http > par: . ack 500 win 6432
> >>
> >>22.
> >>16:34:53.028754  http > par: . ack 500 win 6432
> >>
> >>23.
> >>16:34:56.389624  http > par: . ack 500 win 6432
> >>
> >>24.
> >>16:35:03.110512  http > par: . ack 500 win 6432
> >>^^^ exponential backoff on window probes is fine, except that
> >>the packets are pure acks
> >>
> >>25.
> >>16:35:16.552095  http > par: . ack 500 win 6432
> >>
> >>26.
> >>16:35:43.435482  http > par: . ack 500 win 6432
> >>
> >>27.
> >>16:35:58.706896  par > http: FP 500:500(0) ack 8761 win 17
> >>^^^ paranoia closed the connection without receiving any data
> >>
> >>==> So presumably the client application did a close or
> >>==> has gone away?
> >
> >
> > Did close().
> >
> >
> >>28.
> >>16:35:58.717487  http > par: . 10221:11681(1460) ack 501 win 6432
> >>==> missing/expected 8761:10221
> >>
> >>29.
> >>16:35:58.717569  par > http: R 501:501(0) ack 11681 win 0
> >>==> clearly reordered trace since client is acking 11681
> >>==> which we have not yet seen arrive in the trace
> >
> >
> > This is reset, not ack. It just means that client is not willing to
> > receive more data after shutdown(SHUT_RD).
> >
> >
> >>30.
> >>16:35:58.718673  http > par: . 8761:10221(1460) ack 501 win 6432
> >>==> Nooo, if the previous reset (R) reached http, it
> >>==> should not be barfing more data at us. Going by
> >>==> the ack from the client above, this was sent first.
> >>
> >>31.
> >>16:35:58.718692  par > http: R 501:501(0) ack 10221 win 0
> >>==> reset, continued window of 0, implies no socket
> >>==> remaining here (?).
> >>
> >>32.
> >>16:35:58.720054  http > par: . 11681:13141(1460) ack 501 win 6432
> >>
> >>33.
> >>16:35:58.720074  par > http: R 501:501(0) ack 13141 win 0
> >>
> >>==> A more likely sequence of events is:
> >>==> packet #30, #28, #32 are sent by the http server, and
> >>==> packets #31, #29, #33 are sent in response when they
> >>==> reach the client.
> >>
> >>
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>
