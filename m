Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268759AbUILR3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268759AbUILR3y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 13:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268760AbUILR3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 13:29:54 -0400
Received: from defout.telus.net ([199.185.220.240]:17830 "EHLO
	priv-edtnes84.telusplanet.net") by vger.kernel.org with ESMTP
	id S268759AbUILR3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 13:29:51 -0400
From: "Wolfpaw - Dale Corse" <admin@wolfpaw.net>
To: <kaukasoi@elektroni.ee.tut.fi>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial of Service Attack
Date: Sun, 12 Sep 2004 11:29:55 -0600
Message-ID: <002301c498ee$1e81d4c0$0200a8c0@wolf>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <02a401c498e9$9167aff0$0300a8c0@s>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Sep 12, 2004 at 09:45:38AM -0600, Wolfpaw - Dale Corse wrote:
> >  No problem :) I run the following, against SSH as the target, and I
> > can also kill it. (using telnet as the other side of the attack)
> > 
> > root@maximus:/home/admin# telnet XXXXXXXXXXXXXXX 22
> > Trying XXXXXXXXXXXXXX...
> > Connected to XXXXXXXXXXXXXXXXX.
> > Escape character is '^]'.
> > Connection closed by foreign host.
> > root@maximus:/home/admin#
> 
> > Now.. Do you really want me to post the source code for it?
> 
> With default sshd_config you can DOS sshd trivially by 
> opening ten connections using ten times "telnet XXXXXXXXXXXXXXX 22".

A fair comment :) But look at it this way:

- The TCP RFC was last updated when?
- What is the average time for a tcp packet to fly even across
  the world these days? Maybe 300 ms? 1 second? 5?
- It is not a secret that the TCP protocol has flaws, take for
  example the RST bug, which required among other things, BGP4
  to use MD5 encryption to avoid being potentially attacked.

So this brings me to:

A) Why are the timeouts so long?
B) CLOSE_WAIT having _no timeout at all_ is still using the
   assumption the other side is honest, and will actually
   reply. This is a very bad assumption.
C) Socket still re-uses an FD before it is actually completely
   closed. This is bad, because by calling a second close in
   the case of mysql, you can get the connection to go away,
   but in that case, it closes whatever else is on that FD
   too. (A more likely analysis is that it closes the current
   connection, and then cleans the CLOSE_WAIT on that FD out
   of the other pool)

All I am trying to point out is that the Internet in general, and
The Open Source movement has survived, and evolved because of innovation,
and the ability to meet upcoming threats quickly. TCP has some issues
which are blindingly obvious, and they are issues that, in my view (flawed
as it may be) can be at least somewhat minimized by a few simple changes.

I realize daemons have connection queues, and timeouts for a reason, but
really, if a daemon wishes to close a connection, for whatever reason,
sending something to the other side is required, but I can't see why having
the other side send something back is part of the protocol. This could be
implemented with KEEPALIVE much easier, and would avoid the flaws.. No reply
from the host in say 10 seconds, then drop the connection. You could still
clog queues, to which I would say the application needs to cope with one
client
filling the whole queue as best it can, and it wouldn't stop a DDOS (not much
does), but it might help some at least.

Anyway.. That's my 2 cents. I will continue my conversation with Peter from
mysql in regards to mysql_close, which was really, the entire point. It is
sad however to see a maintainer come across in the manner which David has
during the course of this discussion. It doesn't bode well for the future
of open source to tell someone off, whom likely has a valid point.. whether
or not it is a repairable fault.

Regards,
Dale.
--------------------------------
Dale Corse
System Administrator
Wolfpaw Services Inc.
http://www.wolfpaw.net
(780) 474-4095

