Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278103AbRJaAdF>; Tue, 30 Oct 2001 19:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278189AbRJaAcq>; Tue, 30 Oct 2001 19:32:46 -0500
Received: from ilm.mech.unsw.EDU.AU ([129.94.171.100]:19719 "EHLO
	ilm.mech.unsw.edu.au") by vger.kernel.org with ESMTP
	id <S278103AbRJaAcj>; Tue, 30 Oct 2001 19:32:39 -0500
Date: Wed, 31 Oct 2001 11:33:12 +1100
To: linux-kernel@vger.kernel.org
Cc: Ian Maclaine-cross <iml@debian.org>
Subject: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <20011031113312.A8738@ilm.mech.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
From: Ian Maclaine-cross <iml@ilm.mech.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PROBLEM: Linux updates RTC secretly when clock synchronizes.

Please CC replies etc to Ian Maclaine-cross <iml@debian.org>.

When /usr/sbin/ntpd synchronizes the Linux kernel (or system) clock
using the Network Time Protocol the kernel time is accurate to a few
milliseconds. Linux then sets the Real Time (or Hardware or CMOS)
Clock to this time at approximately 11 minute intervals. Typical RTCs
drift less than 10 s/day so rebooting causes only millisecond errors.

Linux currently does not record the 11 minute updates to a log file.
Clock programs (like hwclock) cannot correct RTC drift at boot without
knowing when the RTC was last set. If NTP service is available after a
long shutdown, ntpd may step the time.  Worse after a longer shutdown
ntpd may drop out or even synchronize to the wrong time zone.  The
workarounds are clumsy.

Please find following my small patch for linux/arch/i386/kernel/time.c
which adds a KERN_NOTICE of each 11 minute update to the RTC. This is
just for i386 machines at present. A script can search the logs for
the last set time of the RTC and update /etc/adjtime.  Hwclock can
then correct the RTC for drift and set the kernel clock.

I patched Linux 2.2.19 and 2.4.12 then compiled, installed and
rebooted on Pentium MMX and AMD K6-III machines respectively. When the
kernel clock synchronized "...: Real Time Clock set at xxx s" appeared
in the kernel log every 661 s where "xxx" was the current system
time. Messages ceased whenever the clock was unsynchronized.  Ntpd
produces typically four log lines in 661 s so the increase in log
volume is small for ntpd users and nothing for nonusers. The patch
added 11 bytes to the size of my compressed kernel.

diff -u --recursive linux.old/arch/i386/kernel/time.c linux/arch/i386/kernel/time.c
--- linux.old/arch/i386/kernel/time.c	Mon Oct 29 16:37:19 2001
+++ linux/arch/i386/kernel/time.c	Mon Oct 29 16:42:03 2001
@@ -28,6 +28,9 @@
  * 1998-12-24 Copyright (C) 1998  Andrea Arcangeli
  *	Fixed a xtime SMP race (we need the xtime_lock rw spinlock to
  *	serialize accesses to xtime/lost_ticks).
+ * 2001-10-28 Ian Maclaine-cross
+ *	Added KERN_NOTICE of each ~11 minute update to RTC.  If no time source
+ *	on boot hwclock etc can correct RTC drift error with last logged time.
  */
 
 #include <linux/errno.h>
@@ -435,8 +438,12 @@
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    xtime.tv_usec >= 500000 - ((unsigned) tick) / 2 &&
 	    xtime.tv_usec <= 500000 + ((unsigned) tick) / 2) {
-		if (set_rtc_mmss(xtime.tv_sec) == 0)
+		if (set_rtc_mmss(xtime.tv_sec) == 0) {
 			last_rtc_update = xtime.tv_sec;
+			printk(KERN_NOTICE
+				"Real Time Clock set at %d s\n",
+				last_rtc_update);
+		}
 		else
 			last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
 	}

-- 
Regards,
Ian Maclaine-cross (iml@debian.org)
