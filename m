Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269106AbUIBVSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269106AbUIBVSE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267804AbUIBVRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:17:39 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:53745 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S269100AbUIBVPH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:15:07 -0400
Subject: [RFC][PATCH] new timeofday i386 hooks (v.A0)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: tim@physik3.uni-rostock.de, george anzinger <george@mvista.com>,
       albert@users.sourceforge.net, Ulrich.Windl@rz.uni-regensburg.de,
       clameter@sgi.com, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <1094159379.14662.322.camel@cog.beaverton.ibm.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1094159492.14662.325.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 02 Sep 2004 14:11:33 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch implements the minimal i386 architecture hooks to enable the
new time of day subsystem code. It applies on top of my
linux-2.6.9-rc1_timeofday-core_A0 patch and with this patch applied, you
can test the new time of day subsystem on i386. Basically it adds the
call to timeofday_interrupt_hook() and cuts alot of code out of the
build. The only new code is the sync_persistant_clock() function which
is mostly ripped out of do_timer_interrupt(). Pretty un-interesting.

I look forward to your comments and feedback.

thanks
-john

linux-2.6.9-rc1_timeofday-i386_A0.patch
=======================================
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2004-09-02 13:29:59 -07:00
+++ b/arch/i386/Kconfig	2004-09-02 13:29:59 -07:00
@@ -14,6 +14,10 @@
 	  486, 586, Pentiums, and various instruction-set-compatible chips by
 	  AMD, Cyrix, and others.
 
+config NEWTOD
+	bool
+	default y
+
 config MMU
 	bool
 	default y
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	2004-09-02 13:29:59 -07:00
+++ b/arch/i386/kernel/time.c	2004-09-02 13:29:59 -07:00
@@ -67,6 +67,8 @@
 
 #include "io_ports.h"
 
+#include <linux/timeofday.h>
+
 extern spinlock_t i8259A_lock;
 int pit_latch_buggy;              /* extern */
 
@@ -87,6 +89,7 @@
 
 struct timer_opts *cur_timer = &timer_none;
 
+#ifndef CONFIG_NEWTOD
 /*
  * This version of gettimeofday has microsecond resolution
  * and better than microsecond precision on fast x86 machines with TSC.
@@ -169,6 +172,7 @@
 }
 
 EXPORT_SYMBOL(do_settimeofday);
+#endif
 
 static int set_rtc_mmss(unsigned long nowtime)
 {
@@ -194,12 +198,39 @@
  *		Note: This function is required to return accurate
  *		time even in the absence of multiple timer ticks.
  */
+#ifndef CONFIG_NEWTOD
 unsigned long long monotonic_clock(void)
 {
 	return cur_timer->monotonic_clock();
 }
 EXPORT_SYMBOL(monotonic_clock);
+#endif
 
+void sync_persistant_clock(struct timespec ts)
+{
+	/*
+	 * If we have an externally synchronized Linux clock, then update
+	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
+	 * called as close as possible to 500 ms before the new second starts.
+	 */
+	if (ts.tv_sec > last_rtc_update + 660 &&
+	    (ts.tv_nsec / 1000)
+			>= USEC_AFTER - ((unsigned) TICK_SIZE) / 2 &&
+	    (ts.tv_nsec / 1000)
+			<= USEC_BEFORE + ((unsigned) TICK_SIZE) / 2) {
+		/* horrible...FIXME */
+		if (efi_enabled) {
+	 		if (efi_set_rtc_mmss(ts.tv_sec) == 0)
+				last_rtc_update = ts.tv_sec;
+			else
+				last_rtc_update = ts.tv_sec - 600;
+		} else if (set_rtc_mmss(ts.tv_sec) == 0)
+			last_rtc_update = ts.tv_sec;
+		else
+			last_rtc_update = ts.tv_sec - 600; /* do it again in 60 s */
+	}
+
+}
 
 /*
  * timer_interrupt() needs to keep up the real-time clock,
@@ -226,6 +257,7 @@
 
 	do_timer_interrupt_hook(regs);
 
+#ifndef CONFIG_NEWTOD
 	/*
 	 * If we have an externally synchronized Linux clock, then update
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
@@ -248,6 +280,7 @@
 		else
 			last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
 	}
+#endif
 
 #ifdef CONFIG_MCA
 	if( MCA_bus ) {
@@ -282,11 +315,15 @@
 	 */
 	write_seqlock(&xtime_lock);
 
+#ifndef CONFIG_NEWTOD
 	cur_timer->mark_offset();
+#endif
  
 	do_timer_interrupt(irq, NULL, regs);
 
 	write_sequnlock(&xtime_lock);
+
+	timeofday_interrupt_hook();
 	return IRQ_HANDLED;
 }
 


