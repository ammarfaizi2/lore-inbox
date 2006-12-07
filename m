Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031922AbWLGJui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031922AbWLGJui (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031923AbWLGJui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:50:38 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:46507 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031922AbWLGJuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:50:37 -0500
Date: Thu, 7 Dec 2006 10:49:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] lockdep: print irq-trace info on asserts
Message-ID: <20061207094943.GA4719@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] lockdep: print irq-trace info on asserts
From: Ingo Molnar <mingo@elte.hu>

when we print an assert due to scheduling-in-atomic bugs, and if lockdep 
is enabled, then the IRQ tracing information of lockdep can be printed 
to pinpoint the code location that disabled interrupts. This saved me 
quite a bit of debugging time in cases where the backtrace did not 
identify the irq-disabling site well enough.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/lockdep.h |   16 +++++++++++++---
 kernel/lockdep.c        |    6 +-----
 kernel/sched.c          |    4 ++++
 3 files changed, 18 insertions(+), 8 deletions(-)

Index: linux/include/linux/lockdep.h
===================================================================
--- linux.orig/include/linux/lockdep.h
+++ linux/include/linux/lockdep.h
@@ -282,15 +282,25 @@ struct lock_class_key { };
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_GENERIC_HARDIRQS)
 extern void early_init_irq_lock_class(void);
 #else
-# define early_init_irq_lock_class()		do { } while (0)
+static inline void early_init_irq_lock_class(void)
+{
+}
 #endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 extern void early_boot_irqs_off(void);
 extern void early_boot_irqs_on(void);
+extern void print_irqtrace_events(struct task_struct *curr);
 #else
-# define early_boot_irqs_off()			do { } while (0)
-# define early_boot_irqs_on()			do { } while (0)
+static inline void early_boot_irqs_off(void)
+{
+}
+static inline void early_boot_irqs_on(void)
+{
+}
+static inline void print_irqtrace_events(struct task_struct *curr)
+{
+}
 #endif
 
 /*
Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -1449,7 +1449,7 @@ check_usage_backwards(struct task_struct
 	return print_irq_inversion_bug(curr, backwards_match, this, 0, irqclass);
 }
 
-static inline void print_irqtrace_events(struct task_struct *curr)
+void print_irqtrace_events(struct task_struct *curr)
 {
 	printk("irq event stamp: %u\n", curr->irq_events);
 	printk("hardirqs last  enabled at (%u): ", curr->hardirq_enable_event);
@@ -1462,10 +1462,6 @@ static inline void print_irqtrace_events
 	print_ip_sym(curr->softirq_disable_ip);
 }
 
-#else
-static inline void print_irqtrace_events(struct task_struct *curr)
-{
-}
 #endif
 
 static int
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -3353,6 +3353,8 @@ asmlinkage void __sched schedule(void)
 			"%s/0x%08x/%d\n",
 			current->comm, preempt_count(), current->pid);
 		debug_show_held_locks(current);
+		if (irqs_disabled())
+			print_irqtrace_events(current);
 		dump_stack();
 	}
 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
@@ -6895,6 +6897,8 @@ void __might_sleep(char *file, int line)
 		printk("in_atomic():%d, irqs_disabled():%d\n",
 			in_atomic(), irqs_disabled());
 		debug_show_held_locks(current);
+		if (irqs_disabled())
+			print_irqtrace_events(current);
 		dump_stack();
 	}
 #endif
