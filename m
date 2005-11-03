Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbVKCQfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbVKCQfB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 11:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbVKCQfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 11:35:01 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37390 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030376AbVKCQfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 11:35:00 -0500
Date: Thu, 3 Nov 2005 17:34:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: p_gortmaker@yahoo.com
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, lethal@linux-sh.org,
       rc@rc0.org.uk, linuxsh-shmedia-dev@lists.sourceforge.net
Subject: [RFC: 2.6 patch] move rtc_interrupt() prototype to rtc.h
Message-ID: <20051103163449.GC23366@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the rtc_interrupt() prototype to rtc.h and removes the 
prototypes from C files.

It also renames static rtc_interrupt() functions in 
arch/arm/mach-integrator/time.c and arch/sh64/kernel/time.c to avoid 
compile problems.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/arm/mach-integrator/time.c |    5 +++--
 arch/i386/kernel/time_hpet.c    |    2 --
 arch/sh64/kernel/time.c         |    7 ++++---
 arch/x86_64/kernel/time.c       |    2 --
 include/linux/rtc.h             |    3 +++
 5 files changed, 10 insertions(+), 9 deletions(-)

--- linux-2.6.14-rc5-mm1-full/include/linux/rtc.h.old	2005-11-03 16:44:09.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/include/linux/rtc.h	2005-11-03 16:52:58.000000000 +0100
@@ -11,6 +11,8 @@
 #ifndef _LINUX_RTC_H_
 #define _LINUX_RTC_H_
 
+#include <linux/interrupt.h>
+
 /*
  * The struct used to pass data via the following ioctl. Similar to the
  * struct tm in <time.h>, but it needs to be here so that the kernel 
@@ -102,6 +104,7 @@
 int rtc_unregister(rtc_task_t *task);
 int rtc_control(rtc_task_t *t, unsigned int cmd, unsigned long arg);
 void rtc_get_rtc_time(struct rtc_time *rtc_tm);
+irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
 #endif /* __KERNEL__ */
 
--- linux-2.6.14-rc5-mm1-full/arch/i386/kernel/time_hpet.c.old	2005-11-03 16:48:34.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/arch/i386/kernel/time_hpet.c	2005-11-03 16:48:41.000000000 +0100
@@ -259,8 +259,6 @@
 #include <linux/mc146818rtc.h>
 #include <linux/rtc.h>
 
-extern irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs);
-
 #define DEFAULT_RTC_INT_FREQ 	64
 #define RTC_NUM_INTS 		1
 
--- linux-2.6.14-rc5-mm1-full/arch/x86_64/kernel/time.c.old	2005-11-03 16:49:00.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/arch/x86_64/kernel/time.c	2005-11-03 16:49:05.000000000 +0100
@@ -1083,8 +1083,6 @@
  */
 #include <linux/rtc.h>
 
-extern irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs);
-
 #define DEFAULT_RTC_INT_FREQ 	64
 #define RTC_NUM_INTS 		1
 
--- linux-2.6.14-rc5-mm1-full/arch/arm/mach-integrator/time.c.old	2005-11-03 16:49:42.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/arch/arm/mach-integrator/time.c	2005-11-03 16:50:07.000000000 +0100
@@ -96,7 +96,8 @@
 	.set_alarm	= rtc_set_alarm,
 };
 
-static irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t arm_rtc_interrupt(int irq, void *dev_id,
+				     struct pt_regs *regs)
 {
 	writel(0, rtc_base + RTC_EOI);
 	return IRQ_HANDLED;
@@ -124,7 +125,7 @@
 
 	xtime.tv_sec = __raw_readl(rtc_base + RTC_DR);
 
-	ret = request_irq(dev->irq[0], rtc_interrupt, SA_INTERRUPT,
+	ret = request_irq(dev->irq[0], arm_rtc_interrupt, SA_INTERRUPT,
 			  "rtc-pl030", dev);
 	if (ret)
 		goto map_out;
--- linux-2.6.14-rc5-mm1-full/arch/sh64/kernel/time.c.old	2005-11-03 16:50:23.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/arch/sh64/kernel/time.c	2005-11-03 16:50:54.000000000 +0100
@@ -416,7 +416,7 @@
 	/*
 	** Regardless the toolchain, force the compiler to use the
 	** arbitrary register r3 as a clock tick counter.
-	** NOTE: r3 must be in accordance with rtc_interrupt()
+	** NOTE: r3 must be in accordance with sh64_rtc_interrupt()
 	*/
 	register unsigned long long  __rtc_irq_flag __asm__ ("r3");
 
@@ -481,7 +481,8 @@
 #endif
 }
 
-static irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t sh64_rtc_interrupt(int irq, void *dev_id,
+				      struct pt_regs *regs)
 {
 	ctrl_outb(0, RCR1);	/* Disable Carry Interrupts */
 	regs->regs[3] = 1;	/* Using r3 */
@@ -490,7 +491,7 @@
 }
 
 static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL};
-static struct irqaction irq1  = { rtc_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "rtc", NULL, NULL};
+static struct irqaction irq1  = { sh64_rtc_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "rtc", NULL, NULL};
 
 void __init time_init(void)
 {

