Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262835AbVG3BRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbVG3BRO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 21:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbVG3Auk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 20:50:40 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:43394 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261563AbVG3AuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 20:50:23 -0400
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: S3 and sigwait (was Re: 2.6.13-rc3: swsusp works (TP 600X))
In-Reply-To: Your message of "Sat, 23 Jul 2005 02:35:44 +0200."
             <20050723003544.GC1988@elf.ucw.cz> 
Date: Sat, 30 Jul 2005 01:50:16 +0100
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1DyfYO-0006oI-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> One other glitch is that pdnsd (a nameserver caching daemon) has crashed
>> when the system wakes up from swsusp.  It also happens when waking up
>> from S3, which was working with 2.6.11.4 although not with 2.6.13-rc3.
>> Many people have said mysql also does not suspend well.  Is their use of
>> a named pipe or socket causing the problem?

> No idea, strace?

The upshot of stracing is in tthe Debian BTS <bugs.debian.org>
#319572.  Paul Rombouts, an author of pdnsd, reproduced the strace
crash and found the problem:

> Apparently strace causes sigwait to return EINTR, which is
> inconsistent with the documentation I could find on sigwait.

Which is true.  The sigwait man entry (Debian 'etch') says:
       The !sigwait! function never returns an error.

His patch (available in the BTS and included below) fixed the problem
of strace or S3 sleep crashing pdnsd.

Shouldn't sleeping and suspension be invisible to user-space processes
such as pdnsd?  Drivers and other kernel code need rewriting so that
devices and buses are not abandoned in a weird state, but going to
sleep should just pull the rug out from under the entire user space.
Then no user space process would need rewriting to survive a
sleep/wake, as long as the deep-freeze were cold enough.  Or is there
a subtlety with threads that I'm missing?

With APM, maybe such transparency was more possible since going to bed
was arranged by the firmware rather than by the OS, and the firmware
would pull out the rug from under the entire user and kernel space
(after maybe a bit of kernel prep).

-Sanjoy

--- src/main.c~	2005-07-08 20:13:14.000000000 +0200
+++ src/main.c	2005-07-29 16:16:12.000000000 +0200
@@ -659,11 +659,20 @@
 	pthread_sigmask(SIG_BLOCK,&sigs_msk,NULL);
 	waiting=1;
 #endif
-	sigwait(&sigs_msk,&sig);
-	DEBUG_MSG("Signal %i caught.\n",sig);
+	{
+		int err;
+		while ((err=sigwait(&sigs_msk,&sig))) {
+			if(err!=EINTR) {
+				log_warn("sigwait failed: %s",strerror(err));
+				sig=0;
+				break;
+			}
+		}
+	}
+	if(sig) DEBUG_MSG("Signal %i caught.\n",sig);
 	write_disk_cache();
 	destroy_cache();
-	log_warn("Caught signal %i. Exiting.",sig);
+	if(sig) log_warn("Caught signal %i. Exiting.",sig);
 	if (sig==SIGSEGV || sig==SIGILL || sig==SIGBUS)
 		crash_msg("This is a fatal signal probably triggered by a bug.");
 	if (ping_isocket!=-1)

