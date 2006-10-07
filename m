Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWJGNRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWJGNRe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 09:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWJGNRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 09:17:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:13503 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932067AbWJGNRc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 09:17:32 -0400
Date: Sat, 7 Oct 2006 14:17:31 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] minimal alpha pt_regs fixes
Message-ID: <20061007131731.GC29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
6a50792270fe3fdcc835484ccf3de569b1d8162d
diff --git a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
index 729c475..dba4e70 100644
--- a/arch/alpha/kernel/irq.c
+++ b/arch/alpha/kernel/irq.c
@@ -129,6 +129,7 @@ #define MAX_ILLEGAL_IRQS 16
 void
 handle_irq(int irq, struct pt_regs * regs)
 {	
+	struct pt_regs *old_regs;
 	/* 
 	 * We ack quickly, we don't want the irq controller
 	 * thinking we're snobs just because some other CPU has
@@ -149,6 +150,7 @@ handle_irq(int irq, struct pt_regs * reg
 		return;
 	}
 
+	old_regs = set_irq_regs(regs);
 	irq_enter();
 	/*
 	 * __do_IRQ() must be called with IPL_MAX. Note that we do not
@@ -157,6 +159,7 @@ handle_irq(int irq, struct pt_regs * reg
 	 * at IPL 0.
 	 */
 	local_irq_disable();
-	__do_IRQ(irq, regs);
+	__do_IRQ(irq);
 	irq_exit();
+	set_irq_regs(old_regs);
 }
diff --git a/arch/alpha/kernel/proto.h b/arch/alpha/kernel/proto.h
index 21f7128..408bda2 100644
--- a/arch/alpha/kernel/proto.h
+++ b/arch/alpha/kernel/proto.h
@@ -133,7 +133,7 @@ extern void smp_percpu_timer_interrupt(s
 /* extern void reset_for_srm(void); */
 
 /* time.c */
-extern irqreturn_t timer_interrupt(int irq, void *dev, struct pt_regs * regs);
+extern irqreturn_t timer_interrupt(int irq, void *dev);
 extern void common_init_rtc(void);
 extern unsigned long est_cycle_freq;
 
diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 4dc273e..596780e 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -515,12 +515,15 @@ smp_cpus_done(unsigned int max_cpus)
 void
 smp_percpu_timer_interrupt(struct pt_regs *regs)
 {
+	struct pt_regs *old_regs;
 	int cpu = smp_processor_id();
 	unsigned long user = user_mode(regs);
 	struct cpuinfo_alpha *data = &cpu_data[cpu];
 
+	old_regs = set_irq_regs(regs);
+
 	/* Record kernel PC.  */
-	profile_tick(CPU_PROFILING, regs);
+	profile_tick(CPU_PROFILING);
 
 	if (!--data->prof_counter) {
 		/* We need to make like a normal interrupt -- otherwise
@@ -534,6 +537,7 @@ smp_percpu_timer_interrupt(struct pt_reg
 
 		irq_exit();
 	}
+	set_irq_regs(old_regs);
 }
 
 int __init
diff --git a/arch/alpha/kernel/time.c b/arch/alpha/kernel/time.c
index 581ddcc..cf06665 100644
--- a/arch/alpha/kernel/time.c
+++ b/arch/alpha/kernel/time.c
@@ -104,7 +104,7 @@ unsigned long long sched_clock(void)
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-irqreturn_t timer_interrupt(int irq, void *dev, struct pt_regs * regs)
+irqreturn_t timer_interrupt(int irq, void *dev)
 {
 	unsigned long delta;
 	__u32 now;
@@ -112,7 +112,7 @@ irqreturn_t timer_interrupt(int irq, voi
 
 #ifndef CONFIG_SMP
 	/* Not SMP, do kernel PC profiling here.  */
-	profile_tick(CPU_PROFILING, regs);
+	profile_tick(CPU_PROFILING);
 #endif
 
 	write_seqlock(&xtime_lock);
@@ -132,7 +132,7 @@ #endif
 	while (nticks > 0) {
 		do_timer(1);
 #ifndef CONFIG_SMP
-		update_process_times(user_mode(regs));
+		update_process_times(user_mode(get_irq_regs()));
 #endif
 		nticks--;
 	}
diff --git a/include/asm-alpha/irq_regs.h b/include/asm-alpha/irq_regs.h
new file mode 100644
index 0000000..3dd9c0b
--- /dev/null
+++ b/include/asm-alpha/irq_regs.h
@@ -0,0 +1 @@
+#include <asm-generic/irq_regs.h>
