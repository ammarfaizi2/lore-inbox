Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265688AbSKFPCv>; Wed, 6 Nov 2002 10:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbSKFPCv>; Wed, 6 Nov 2002 10:02:51 -0500
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:26376 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id <S265688AbSKFPCu>;
	Wed, 6 Nov 2002 10:02:50 -0500
To: root@chaos.analogic.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Willy Tarreau <willy@w.ods.org>,
       Jim Paris <jim@jtan.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
References: <1036529824.6757.44.camel@irongate.swansea.linux.org.uk>
	<Pine.LNX.3.95.1021105153853.734C-100000@chaos.analogic.com>
From: Christer Weinigel <christer@weinigel.se>
Date: 06 Nov 2002 16:09:26 +0100
In-Reply-To: <Pine.LNX.3.95.1021105153853.734C-100000@chaos.analogic.com>
Message-ID: <87d6pienvd.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> > On Tue, 2002-11-05 at 20:23, Richard B. Johnson wrote:
> > > Hey, look. I can only warn. You do what you want. As far as I'm
> > > concerned support stopped at Linux 2.4.19 when poll got trashed.
> > > Nobody can use 2.4.19 or probably anything later unless they have
> > > powerful CPUs that can spin with 1000 SIGPOLL signals per second.
> 
> Enable SIGPOLL on STDIN_FILENO and connect from the network as previously
> shown. You will get 100% CPU time on the task with this enabled.

Can you please stop harping about this?  You have written essentially
the same mail over and over again without adding any new information.

First of all, your problem has nothing to do with networking, the same
thing will happen if you run your program from within screen, so it
seems to have more to do with ptys and how both screen and telnetd
sets them up.  

Second, it seems that your program does exactly what is expected.  Try
applying this patch to your example program and see what happens:

diff -u ./polltest.c.orig ./polltest.c
--- ./polltest.c.orig	Wed Nov  6 15:36:09 2002
+++ ./polltest.c	Wed Nov  6 15:35:54 2002
@@ -47,7 +47,7 @@
 {
     struct pollfd pf;
     pf.fd = STDIN_FILENO;
-    pf.events = POLLIN;
+    pf.events = POLLIN | POLLOUT | POLLERR;
     pf.revents = 0;
     (void)poll(&pf, 1, 0);
     if(pf.revents & POLLIN)

Each time you print the "POLLOUT = 3 POLLERR = 0" message, you fill up
the write buffer, and each time the write queue empties you will get
another SIGIO.  Now, this may not be what you want, but it seems to be
entirely within specs.

If you remove the fprintf(stderr, "POLLOUT... from your signal handler
you will not see the same effect as you are complaining about.  Your
measurements are interfering with what you are trying to measure.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
