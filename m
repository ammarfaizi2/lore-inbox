Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268337AbUIKVmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268337AbUIKVmv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 17:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268342AbUIKVmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 17:42:50 -0400
Received: from admin.wolfpaw.net ([204.209.44.9]:48819 "HELO admin.wolfpaw.net")
	by vger.kernel.org with SMTP id S268337AbUIKVlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 17:41:49 -0400
From: "Wolfpaw - Dale Corse" <admin-lists@wolfpaw.net>
To: <linux-kernel@vger.kernel.org>
Cc: <grsecurity@grsecurity.net>, <bugtraq@securityfocus.com>
Subject: Linux 2.4.27 SECURITY BUG - TCP Local (probable Remote) Denial of Service
Date: Sat, 11 Sep 2004 15:41:51 -0600
Message-ID: <004c01c49848$2608e180$0200a8c0@wolf>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

 My apologies if this is to the wrong place - it happens to be the
first kernel bug I have found (or what appears to be one), and I'm
not entirely sure how to properly inform the Linux community about
it. 

Anyway - on to the bug :)
==========================
Severity: HIGH
Title: KERNEL: TCP Local (probable remote) Denial of Service
Date: September 11, 2004

Synopsis
========
It appears there is a problem with sockets being reused before
they are actually closed. 

Description
============
I have intentionally not included very much detail, because it appears 
to me this could cause some serious havoc, and I'd rather not be responsible 
for the results. Details are available to kernel developers upon request 
to admin@wolfpaw.com.

It appears there is a problem with sockets being reused before they are
actually closed. Leaving them in TIME_WAIT until they expire. We were also
able to leave them in CLOSE_WAIT, and they remained for days (assumably 
indefinitely)

The result of this ends up a bit unpredictable (or rather irreproducible).
We are working on a commercial product including a proxy server, which
ends up leaving the connections in CLOSE_WAIT state forever. When I wrote
some proof of concept code, I was able to create a DOS condition, but I
was only able to get the sockets to sit in TIME_WAIT state, so the kernel
eventually cleared them. This is likely because I spent about 20 minutes
on the proof of concept code, and have determined it can be abused, which
is really all I was trying to accomplish :)

IMPACT:
=======
The issue ends up in the end that the kernel lets the connections sit in
this state for a while, so once a ton of slots are taken up, it doesn't
take much to keep the table full (several attempts every 10 - 20 seconds).
occasionally the machine catches up, and the attack has to restart. The
result however, is a 10 - 30 second delay in web transactions, and that
was on a server with just me hitting it. On a busy web server, I wouldn't
want to guess what it would be :)

** I was able to launch this attack as a regular user, and this machine
** has GrSecurity installed on it (CC'd to them too)
** You could compile this as a CGI, and take out about any Linux based
** web host (thus the reason for not releasing the PoC code.)

I tested it against telnetd (vulnerable), and sshd (didn't seem affected)
mysqld (with the commercial product, it would run out of sockets, and require
the offending process to be restarted to accept more), and Apache 1.3.29 
(vulnerable)

The socket table looks like this while it is going on:

http://www.ancients.org/LG.txt
(it is 29,000+ lines, so I didn't put it here)

The bug doesn't appear to completely kill the ability to serve, but it slows
it down to almost nothing.. On a busy web server, it would be virtually dead.

Proof of concept code:
======================
I will not be releasing this for the script kiddies to use :) If any of the
kernel dev team wish to have it, please contact me. So long as I can verify
you are a kernel maintainer, its all yours.

NOTE: Please send ALL correspondence regarding this to [admin <A>
wolfpaw.com], do
      not reply to this message, this address is simply one which receives a 
      ton of list traffic. I could of course be off my rocker, and this not
      be a bug, but I don't think so :)

Regards,
D.
--------------------------------
Dale Corse
System Administrator
Wolfpaw Services Inc.
http://www.wolfpaw.net
(780) 474-4095

