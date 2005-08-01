Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVHAILi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVHAILi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 04:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVHAILi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 04:11:38 -0400
Received: from mail.renesas.com ([202.234.163.13]:8889 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261888AbVHAILf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 04:11:35 -0400
Date: Mon, 01 Aug 2005 17:00:40 +0900 (JST)
Message-Id: <20050801.170040.550145772.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hitoshiy@isl.melco.co.jp,
       takata@linux-m32r.org
Subject: [PATCH 2.6.13-rc4] m32r: Fix local-timer event handling
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

There was a scheduling problem of the m32r SMP kernel;
A process rarely stopped and gave no responding but the other process
have been handled by the other CPU still lives, then if we did something
in the other terminal or something like that, the stopped process came back
to life and continued its operation...
(ex. LMbench: lat_sig)


In the m32r SMP kernel, a local-timer event is delivered by using
an IPI(inter processor interrupts); LOCAL_TIMER_IPI.
And a function smp_send_timer() is prepared to send the LOCAL_TIMER_IPI
from the current CPU to the other CPUs.

The funtion smp_send_timer() was placed and used in do_IRQ() in 
former times (before 2.6.10-rc3-mm1 kernel), however, it was 
unintentionally removed when arch/m32r/kernel/irq.c was modified to
employ the generic hardirq framework (CONFIG_GENERIC_HARDIRQ) in
my previous patch.
  [PATCH 2.6.10-rc3-mm1] m32r: Use generic hardirq framework
  http://www.ussg.iu.edu/hypermail/linux/kernel/0412.2/0358.html


The following patch fixes the above problem.
I hope this will be merged in 2.6.13.

Thanks,

Signed-off-by: Hitoshi Yamamoto <hitoshiy@isl.melco.co.jp>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/time.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

Index: linux-2.6.13-rc4/arch/m32r/kernel/time.c
===================================================================
--- linux-2.6.13-rc4.orig/arch/m32r/kernel/time.c	2005-08-01 16:58:47.000000000 +0900
+++ linux-2.6.13-rc4/arch/m32r/kernel/time.c	2005-08-01 16:58:53.000000000 +0900
@@ -205,8 +205,7 @@ static long last_rtc_update = 0;
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-static inline void
-do_timer_interrupt(int irq, void *dev_id, struct pt_regs * regs)
+irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 #ifndef CONFIG_SMP
 	profile_tick(CPU_PROFILING, regs);
@@ -221,6 +220,7 @@ do_timer_interrupt(int irq, void *dev_id
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
+	write_seqlock(&xtime_lock);
 	if ((time_status & STA_UNSYNC) == 0
 		&& xtime.tv_sec > last_rtc_update + 660
 		&& (xtime.tv_nsec / 1000) >= 500000 - ((unsigned)TICK_SIZE) / 2
@@ -231,6 +231,7 @@ do_timer_interrupt(int irq, void *dev_id
 		else	/* do it again in 60 s */
 			last_rtc_update = xtime.tv_sec - 600;
 	}
+	write_sequnlock(&xtime_lock);
 	/* As we return to user mode fire off the other CPU schedulers..
 	   this is basically because we don't yet share IRQ's around.
 	   This message is rigged to be safe on the 386 - basically it's
@@ -238,14 +239,8 @@ do_timer_interrupt(int irq, void *dev_id
 
 #ifdef CONFIG_SMP
 	smp_local_timer_interrupt(regs);
+	smp_send_timer();
 #endif
-}
-
-irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
-{
-	write_seqlock(&xtime_lock);
-	do_timer_interrupt(irq, NULL, regs);
-	write_sequnlock(&xtime_lock);
 
 	return IRQ_HANDLED;
 }

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
