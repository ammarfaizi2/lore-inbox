Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263365AbUEBX1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbUEBX1T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 19:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbUEBX1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 19:27:19 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:59101 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263365AbUEBX1C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 19:27:02 -0400
Message-ID: <409583B1.5040906@us.ibm.com>
Date: Sun, 02 May 2004 16:26:41 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: TCP hangs
References: <Pine.LNX.4.58.0405021602120.20423@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.58.0405021602120.20423@artax.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka wrote:

> Hi
> 
> This is tcpdump of hung TCP connection (from paranoia.kolej.mff.cuni.cz's
> point of view). What do you think, which machine did misbehave?
> 
> 213.29.7.213 is a Linux box and I think it misbehaved because it didn't
> send data in zero-window probe.
> 
> Or am I wrong and did I misunderstood RFC793? (page 41: "The sending TCP
> must regularly retransmit to the receiving TCP even when the window is zero.")


Which Linux kernel (distro, version)? What hangs?  Is it just that
connection? All the kernel? Client end or remote server end?

It is not wrong to send no data in a zero window probe. TCP MUST,
however, continue sending the probes while the window is zero.

Assuming some reordering (see embedded comments in the trace,
below), all of the following looks correct on the Linux end.
Also, since the client side responds to the data coming
in with resets and zero windows, the client socket has gone
away too.

Once the resets reach the server, it presumably has torn down its
socket - and there are no more packets exchanged. All done.

So nothing in the trace looks like a hang or an incorrect
resolution. (other than the fact that the app seems to have died,
and it doesn't respond to the zero window probes as it should).
Client/app broken, seems like.

thanks,
Nivedita

Edited trace:

par = paranoia.kolej.mff.cuni.cz.65461
http = 213.29.7.213.http	[Linux box]

1.
16:34:49.832097  par > http: SWE 1711254266:1711254266(0)
win 8192 <mss 1460,sackOK,wscale 10,eol>

2.
16:34:49.838957  http > par: S 1163781419:1163781419(0)
ack 1711254267 win 5840 <mss 1460,nop,nop,sackOK,nop,wscale 0>

3.
16:34:49.838968  par > http: P ack 1 win 8

4.
16:34:49.840002  par > http: P 1:500(499) ack 1 win 8

5.
16:34:49.847349  http > par: . ack 500 win 6432

6.
16:34:49.863592  http > par: . 1:1461(1460) ack 500 win 6432

7.
16:34:49.863651  par > http: P ack 1461 win 6

8.
16:34:49.867490  http > par: . 1461:2921(1460) ack 500 win 6432

9.
16:34:49.867558  par > http: P ack 2921 win 6

10.
16:34:49.871498  http > par: . 2921:4381(1460) ack 500 win 6432

11.
16:34:49.871567  par > http: P ack 4381 win 5

12.
16:34:49.872729  http > par: . 4381:5841(1460) ack 500 win 6432

13.
16:34:49.872777  par > http: P ack 5841 win 3

14.
16:34:49.875631  http > par: . 7301:8761(1460) ack 500 win 6432

15.
16:34:49.875714  par > http: P ack 5841 win 3 <nop,nop,sack sack 1 {7301:8761} >

16.
16:34:49.876881  http > par: . 5841:7301(1460) ack 500 win 6432

17.
16:34:49.876953  par > http: P ack 8761 win 0

18.
16:34:49.907290  par > http: P ack 8761 win 2
^^^^ this packet was probably lost or the last two were reordered

19.
16:34:50.088544  http > par: . ack 500 win 6432

20.
16:34:50.512936  http > par: . ack 500 win 6432
^^^ this looks to me like a bug --- window probe doesn't contain data
==> not a problem, the receiving client should respond
==> with an ack and updated window. But why is not the
==> client responding to the window probes?

21.
16:34:51.348911  http > par: . ack 500 win 6432

22.
16:34:53.028754  http > par: . ack 500 win 6432

23.
16:34:56.389624  http > par: . ack 500 win 6432

24.
16:35:03.110512  http > par: . ack 500 win 6432
^^^ exponential backoff on window probes is fine, except that
the packets are pure acks

25.
16:35:16.552095  http > par: . ack 500 win 6432

26.
16:35:43.435482  http > par: . ack 500 win 6432

27.
16:35:58.706896  par > http: FP 500:500(0) ack 8761 win 17
^^^ paranoia closed the connection without receiving any data

==> So presumably the client application did a close or
==> has gone away?

28.
16:35:58.717487  http > par: . 10221:11681(1460) ack 501 win 6432
==> missing/expected 8761:10221

29.
16:35:58.717569  par > http: R 501:501(0) ack 11681 win 0
==> clearly reordered trace since client is acking 11681
==> which we have not yet seen arrive in the trace

30.
16:35:58.718673  http > par: . 8761:10221(1460) ack 501 win 6432
==> Nooo, if the previous reset (R) reached http, it
==> should not be barfing more data at us. Going by
==> the ack from the client above, this was sent first.

31.
16:35:58.718692  par > http: R 501:501(0) ack 10221 win 0
==> reset, continued window of 0, implies no socket
==> remaining here (?).

32.
16:35:58.720054  http > par: . 11681:13141(1460) ack 501 win 6432

33.
16:35:58.720074  par > http: R 501:501(0) ack 13141 win 0

==> A more likely sequence of events is:
==> packet #30, #28, #32 are sent by the http server, and
==> packets #31, #29, #33 are sent in response when they
==> reach the client.


