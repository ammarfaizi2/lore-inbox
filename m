Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVATX63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVATX63 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 18:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVATX6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 18:58:21 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:42225 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261364AbVATX5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 18:57:44 -0500
Message-ID: <41F04573.7070508@mvista.com>
Date: Thu, 20 Jan 2005 15:57:39 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] to fix xtime lock for in the RT kernel patch
Content-Type: multipart/mixed;
 boundary="------------020409040306050901040002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------020409040306050901040002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

It seems to me that we need to either do the attached or to rewrite the timer 
front end code to just gather the offset info and defer to the timer irq thread 
to update jiffies and the offset stuff.  In either case we really can not split 
the two and we do need the xtime_lock protection.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

--------------020409040306050901040002
Content-Type: text/plain;
 name="timefixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="timefixes.patch"

Source: MontaVista Software, Inc.  George Anzinger <george@mvista.com>
Type: Defect Fix 
Keywords:
Signed-off-by: George Anzinger <george@mvista.com>
Description:
	This patch changes the timer interrupt code for the RT patch to 
	respect the xtime_lock which should protect jiffies and to collect
	offset information on jiffies interrupts.  This offset info must
	be collected as soon as possible during the jiffies interrupt and 
	also needs to be protected by the xtime_lock.

	The xtime_lock is thus a "raw" lock.

 arch/i386/kernel/time.c |    8 +++++---
 include/linux/time.h    |    2 +-
 kernel/timer.c          |    2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

Index: topdir/kernel/timer.c
===================================================================
--- topdir.orig/kernel/timer.c
+++ topdir/kernel/timer.c
@@ -946,7 +946,7 @@ unsigned long wall_jiffies = INITIAL_JIF
  * playing with xtime and avenrun.
  */
 #ifndef ARCH_HAVE_XTIME_LOCK
-DECLARE_SEQLOCK(xtime_lock);
+DECLARE_RAW_SEQLOCK(xtime_lock);
 
 EXPORT_SYMBOL(xtime_lock);
 #endif
Index: topdir/include/linux/time.h
===================================================================
--- topdir.orig/include/linux/time.h
+++ topdir/include/linux/time.h
@@ -80,7 +80,7 @@ mktime (unsigned int year, unsigned int 
 
 extern struct timespec xtime;
 extern struct timespec wall_to_monotonic;
-extern seqlock_t xtime_lock;
+extern raw_seqlock_t xtime_lock;
 
 static inline unsigned long get_seconds(void)
 { 
Index: topdir/arch/i386/kernel/time.c
===================================================================
--- topdir.orig/arch/i386/kernel/time.c
+++ topdir/arch/i386/kernel/time.c
@@ -20,7 +20,7 @@
  *	monotonic gettimeofday() with fast_get_timeoffset(),
  *	drift-proof precision TSC calibration on boot
  *	(C. Scott Ananian <cananian@alumni.princeton.edu>, Andrew D.
- *	Balsa <andrebalsa@altern.org>, Philip Gladstone <philip@raptor.com>;
+ * 	Balsa <andrebalsa@altern.org>, Philip Gladstone <philip@raptor.com>;
  *	ported from 2.0.35 Jumbo-9 by Michael Krause <m.krause@tu-harburg.de>).
  * 1998-12-16    Andrea Arcangeli
  *	Fixed Jumbo-9 code in 2.1.131: do_gettimeofday was missing 1 jiffy
@@ -224,7 +224,10 @@ EXPORT_SYMBOL(profile_pc);
  */
 void direct_timer_interrupt(struct pt_regs *regs)
 {
+	write_seqlock(&xtime_lock);
+	cur_timer->mark_offset();
 	do_timer_interrupt_hook(regs);
+	write_sequnlock(&xtime_lock);
 }
 
 #endif
@@ -254,6 +257,7 @@ static inline void do_timer_interrupt(in
 #endif
 
 #ifndef CONFIG_PREEMPT_HARDIRQS
+	cur_timer->mark_offset();
 	do_timer_interrupt_hook(regs);
 #endif
 
@@ -312,8 +316,6 @@ irqreturn_t timer_interrupt(int irq, voi
 	 * locally disabled. -arca
 	 */
 	write_seqlock(&xtime_lock);
-
-	cur_timer->mark_offset();
  
 	do_timer_interrupt(irq, NULL, regs);
 

--------------020409040306050901040002--

