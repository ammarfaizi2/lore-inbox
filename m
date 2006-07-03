Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWGCAQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWGCAQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 20:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWGCAQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 20:16:26 -0400
Received: from www.osadl.org ([213.239.205.134]:61368 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750744AbWGCAQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 20:16:25 -0400
Subject: [PATCH] genirq: ARM dyntick cleanup
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 02:18:48 +0200
Message-Id: <1151885928.24611.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus: "The hacks in kernel/irq/handle.c are really horrid. REALLY
horrid."

They are indeed. Move the dyntick quirks to ARM where they belong.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Index: linux-2.6.git/include/asm-arm/hw_irq.h
===================================================================
--- linux-2.6.git.orig/include/asm-arm/hw_irq.h	2006-07-03 00:13:24.000000000 +0200
+++ linux-2.6.git/include/asm-arm/hw_irq.h	2006-07-03 00:52:04.000000000 +0200
@@ -6,4 +6,15 @@
 
 #include <asm/mach/irq.h>
 
+#if defined(CONFIG_NO_IDLE_HZ)
+# include <asm/dyntick.h>
+# define handle_dynamic_tick(action)					\
+	if (!(action->flags & SA_TIMER) && system_timer->dyn_tick) {	\
+		write_seqlock(&xtime_lock);				\
+		if (system_timer->dyn_tick->state & DYN_TICK_ENABLED)	\
+			system_timer->dyn_tick->handler(irq, 0, regs);	\
+		write_sequnlock(&xtime_lock);				\
+	}
+#endif
+
 #endif
Index: linux-2.6.git/include/linux/irq.h
===================================================================
--- linux-2.6.git.orig/include/linux/irq.h	2006-07-03 00:13:24.000000000 +0200
+++ linux-2.6.git/include/linux/irq.h	2006-07-03 00:49:01.000000000 +0200
@@ -182,6 +182,10 @@ extern int setup_irq(unsigned int irq, s
 
 #ifdef CONFIG_GENERIC_HARDIRQS
 
+#ifndef handle_dynamic_tick
+# define handle_dynamic_tick(a)		do { } while (0)
+#endif
+
 #ifdef CONFIG_SMP
 static inline void set_native_irq_info(int irq, cpumask_t mask)
 {
Index: linux-2.6.git/kernel/irq/handle.c
===================================================================
--- linux-2.6.git.orig/kernel/irq/handle.c	2006-07-03 00:13:24.000000000 +0200
+++ linux-2.6.git/kernel/irq/handle.c	2006-07-03 00:47:47.000000000 +0200
@@ -16,10 +16,6 @@
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 
-#if defined(CONFIG_NO_IDLE_HZ) && defined(CONFIG_ARM)
-#include <asm/dyntick.h>
-#endif
-
 #include "internals.h"
 
 /**
@@ -133,14 +129,7 @@ irqreturn_t handle_IRQ_event(unsigned in
 	irqreturn_t ret, retval = IRQ_NONE;
 	unsigned int status = 0;
 
-#if defined(CONFIG_NO_IDLE_HZ) && defined(CONFIG_ARM)
-	if (!(action->flags & SA_TIMER) && system_timer->dyn_tick != NULL) {
-		write_seqlock(&xtime_lock);
-		if (system_timer->dyn_tick->state & DYN_TICK_ENABLED)
-			system_timer->dyn_tick->handler(irq, 0, regs);
-		write_sequnlock(&xtime_lock);
-	}
-#endif
+	handle_dynamic_tick(action);
 
 	if (!(action->flags & IRQF_DISABLED))
 		local_irq_enable();
Index: linux-2.6.git/include/asm-arm/mach/time.h
===================================================================
--- linux-2.6.git.orig/include/asm-arm/mach/time.h	2006-06-21 08:32:46.000000000 +0200
+++ linux-2.6.git/include/asm-arm/mach/time.h	2006-07-03 00:54:07.000000000 +0200
@@ -69,6 +69,7 @@ extern void timer_tick(struct pt_regs *)
 /*
  * Kernel time keeping support.
  */
+struct timespec;
 extern int (*set_rtc)(void);
 extern void save_time_delta(struct timespec *delta, struct timespec *rtc);
 extern void restore_time_delta(struct timespec *delta, struct timespec *rtc);


