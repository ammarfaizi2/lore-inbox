Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268114AbUILPpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268114AbUILPpo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 11:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUILPpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 11:45:44 -0400
Received: from outbound01.telus.net ([199.185.220.220]:14004 "EHLO
	priv-edtnes57.telusplanet.net") by vger.kernel.org with ESMTP
	id S268114AbUILPpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 11:45:34 -0400
From: "Wolfpaw - Dale Corse" <admin@wolfpaw.net>
To: <willy@w.ods.org>
Cc: <peter@mysql.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial of Service Attack
Date: Sun, 12 Sep 2004 09:45:38 -0600
Message-ID: <001c01c498df$8d2cd0f0$0200a8c0@wolf>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <029201c498d8$dff156f0$0300a8c0@s>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

 No problem :) I run the following, against SSH as the target, and I
can also kill it. (using telnet as the other side of the attack)

root@magik:/etc# telnet 0.0.0.0 22
Trying 0.0.0.0...
Connected to 0.0.0.0.
Escape character is '^]'.
Connection closed by foreign host.
root@magik:/etc# telnet 0.0.0.0 23
Trying 0.0.0.0...
Connected to 0.0.0.0.
Escape character is '^]'.
 
Magik login: Connection closed by foreign host.
root@magik:/etc# 

And from a remote host:

root@maximus:/home/admin# telnet XXXXXXXXXXXXXXX 22
Trying XXXXXXXXXXXXXX...
Connected to XXXXXXXXXXXXXXXXX.
Escape character is '^]'.
Connection closed by foreign host.
root@maximus:/home/admin# 

And it gets worse now..:

root@avalon:/root# telnet XXXXXXXXXXXXXXX
Trying XXXXXXXXXXXXX...
Connected to XXXXXXXXXXXXX.
Escape character is '^]'.
telnetd: All network ports in use.
Connection closed by foreign host.
root@avalon:/root# telnet XXXXXXXXXXXXXX 22
Trying XXXXXXXXXXXXXX...
Connected to XXXXXXXXXXXXXXXXX.
Escape character is '^]'.
Connection closed by foreign host.
root@avalon:/root# 

Well well.. We have ourselves a Remote Denial of Service tool.

Now.. Do you really want me to post the source code for it?

I wouldn't want to upset David again. This has basically
disabled interactive administration on that machine, by taking
out both ssh and telnet at the same time. If you want to demo
it, I can send it to you privately.. I'm a bit apprehensive
about releasing a 'ready-to-rock' remote DoS exploit on a
list though :(

Just think here a moment.. Lets say I modify it a bit more,
and turn it into a DDOS utility, so now you have (pardon my
language) .. An assload of these coming at your server, how
are you going to stop it? Simply - you can't, and your server
will run out of sockets long before all the remote hosts do.

This one in essence takes a nice working tcp connection application,
and removes the close statements, which as you mentioned will cause
the sockets to end up in that state. What I am attempting to demonstrate
here, is the fact it can relatively easily take out any tcp based app,
and simply saying, something should be done about it. What the actual
bug is, I think I know (and have said), but I will leave that determination 
to the actual kernel developers.

I was not attempting to say you should break TCP with the timeouts, or
even make them short, I just would tend to think no timeout at ALL is
a bit of a design flaw, because if the other end is no longer there,
the work will never get done, but one of the ends expects the response
indefinitely, which to me looks like an assumption. I think we have all
learned these days that you can't make anymore assumptions, people use
those to break things.

I also would like to thank you for engaging in a discussion about the
bug with me, in a polite manner, instead of simply writing me off as
some loud mouth neophyte.

Anyway - from my view, this is a bug in the OS, because it should not
occur, if it does, we need to find a way to ensure it doesn't. I know
a few firewall tricks that might stop it, but I'm not sure. If a regular
user can invoke this kind of response so easily, I would say it's a bad
thing.

Regards,
Dale.
> -----Original Message-----
> From: Dale Corse [mailto:admin@wolfpaw.net] 
> Sent: Sunday, September 12, 2004 8:58 AM
> To: Dale
> Subject: FW: Linux 2.4.27 SECURITY BUG - TCP Local (probable 
> Remote) Denial of Service
> 
> 
> 
> 
> -----Original Message-----
> From: Willy Tarreau [mailto:willy@w.ods.org] 
> Sent: Sunday, September 12, 2004 4:36 AM
> To: Wolfpaw - Dale Corse
> Cc: peter@mysql.com; linux-kernel@vger.kernel.org
> Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local (probable 
> Remote) Denial of Service
> 
> 
> On Sun, Sep 12, 2004 at 03:24:11AM -0600, Wolfpaw - Dale Corse wrote:
>  
> > This is the odd part, try the exploit,
> 
> I have nothing to try it right here.
> 
> > they are detached in
> > the list, but it appears apache isn't aware of that. If you run the
> > code, and do multiple telnets from another window, you will 
> see that 
> > there are occurrences where a connection can't be established, and 
> > this is where the problem is. I used a stock version of Mysql 3 
> > (latest stable), stock apache, on an unmoded Linux box 
> (except it had 
> > GrSecurity) and I was able to see a noticeable slowdown in web 
> > transactions with a browser. I was also the only person hitting the 
> > machine.
> 
> How can you be sure that your problem is not simply related 
> to either apache or mysql not freeing the connection fast 
> enough ? Apache is very limited in terms of simultaneous 
> connections, and it is trivial for anyone to block an apache 
> server by establishing as many connections as it can handle, 
> sending the start of a request and doing nothing more (and it 
> has a very long default time out BTW). It might be the same 
> with mysql.
> 
> > I am not saying you are incorrect, I'm simply clarifying 
> what seems to
> > be occurring with the issue I found.
> > 
> > Do you happen to know of any solution for sockets stuck in 
> CLOSE_WAIT,
> > they seem to stick around forever.
> 
> Yes, the only solution is to debug the process and make it 
> sanely close the socket once it does not need it anymore. 
> Usually, in such circumstances, you'll find that an strace on 
> the process shows either :
>   - a select loop with your socket in the list of the active FDs, but
>     nothing in the process will do anything on this FD and the process
>     will go back to the select loop => bug in FD handling
>  - a select loop which does not include the FD while it has 
> not been released
>    => bug in FD releasing code (usually a missing close).
> 
> > This bug may be more Mysql then kernel, I don't know - I still would
> > tend to think these connections should not be clogging up the 
> > applications connection queue, and that CLOSE_WAIT should have a 
> > settable timeout, regardless of what the RFC says about it.
> 
> No, CLOSE_WAIT means that the application still has some work 
> to do. Under no circumstances, the kernel should destroy its 
> ability to work normally !
> 
> > I did experience more CLOSE_WAIT's stuck at one point with 
> Mysql.. we
> > had an issue wherein after calling mysql_close with the C 
> API it was 
> > still leaving the sessions established, so I had moved the 
> timeout on 
> > that sql daemon to 20 seconds (its all fast transactions) .. This 
> > caused a lot of CLOSE_WAIT issues for some reason.
> 
> So you've just demonstrated that it's mysql_close which is 
> the culprit. If it does not really close the connection while 
> you expected it to, it is the real problem. If you lower the 
> mysql timeout, mysql will close on its end, but as long as 
> the code using mysql_close() will not close, of course the 
> socket will remain close_wait. And to be clear, even if you 
> would have a short CLOSE_WAIT time-out, it would not help 
> because you would still be running out of file-descriptors 
> after a moment.
> 
> > We then
> > added something that would go through and use 'close' on 
> the fd of the
> > Mysql connection, after mysql_close was called. This had the odd 
> > effect of the fd being reused by a connection, before it was out of 
> > CLOSE_WAIT and actually closed, so it would close the new 
> Connection, 
> > and also the old one :P which led us to this discovery that 
> connect() 
> > appears to reuse FD's before they are actually fully 
> closed.. This is 
> > how it appears anyway. Thus my use of specifically mysql 
> and connect 
> > in the PoC code.
> 
> If you manage to write a PoC code which does not involve 
> either apache not mysql, and which still exhibits the 
> described behaviour, then perhaps kernel developpers will 
> listen a bit more, but at the moment, you only showed us how 
> you could trigger a DoS by connecting to a buggy application.
> 
> Cheers,
> Willy
> 
> 
> --------------------------------------------------------------
> --------------
> -
> This message has been scanned for Spam and Viruses by ClamAV 
> and SpamAssassin
> --------------------------------------------------------------
> --------------
> -
> 
> 
> 
> 
> 

