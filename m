Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVFHRyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVFHRyT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVFHRyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:54:19 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:13325 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261452AbVFHRv6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:51:58 -0400
Message-ID: <42A73023.4040707@stud.feec.vutbr.cz>
Date: Wed, 08 Jun 2005 19:51:31 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050506)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
References: <20050608112801.GA31084@elte.hu>
In-Reply-To: <20050608112801.GA31084@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------010809000307030509040800"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010809000307030509040800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've made the soft IRQ flag feature work on x86_64. It compiles and 
boots for me.
Attached is the patch against -RT-2.6.12-rc6-V0.7.48-01.

Michal

--------------010809000307030509040800
Content-Type: text/plain;
 name="rt-x86_64-hard-irq-disable-removal.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt-x86_64-hard-irq-disable-removal.diff"

diff -Nurp -X linux-RT/Documentation/dontdiff linux-RT/arch/x86_64/kernel/apic.c linux-RT.mich/arch/x86_64/kernel/apic.c
--- linux-RT/arch/x86_64/kernel/apic.c	2005-06-07 14:05:16.000000000 +0200
+++ linux-RT.mich/arch/x86_64/kernel/apic.c	2005-06-08 18:51:21.000000000 +0200
@@ -478,10 +478,9 @@ static int lapic_suspend(struct sys_devi
 	apic_pm_state.apic_tmict = apic_read(APIC_TMICT);
 	apic_pm_state.apic_tdcr = apic_read(APIC_TDCR);
 	apic_pm_state.apic_thmr = apic_read(APIC_LVTTHMR);
-	local_save_flags(flags);
-	local_irq_disable();
+	raw_local_irq_save(flags);
 	disable_local_APIC();
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 	return 0;
 }
 
@@ -496,7 +495,7 @@ static int lapic_resume(struct sys_devic
 	/* XXX: Pavel needs this for S3 resume, but can't explain why */
 	set_fixmap_nocache(FIX_APIC_BASE, APIC_DEFAULT_PHYS_BASE);
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	rdmsr(MSR_IA32_APICBASE, l, h);
 	l &= ~MSR_IA32_APICBASE_BASE;
 	l |= MSR_IA32_APICBASE_ENABLE | APIC_DEFAULT_PHYS_BASE;
@@ -519,7 +518,7 @@ static int lapic_resume(struct sys_devic
 	apic_write(APIC_LVTERR, apic_pm_state.apic_lvterr);
 	apic_write(APIC_ESR, 0);
 	apic_read(APIC_ESR);
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 	return 0;
 }
 
@@ -676,7 +675,7 @@ static void setup_APIC_timer(unsigned in
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 
 	/* For some reasons this doesn't work on Simics, so fake it for now */ 
 	if (!strstr(boot_cpu_data.x86_model_id, "Screwdriver")) { 
@@ -706,7 +705,7 @@ static void setup_APIC_timer(unsigned in
 
 	__setup_APIC_LVTT(clocks);
 
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 
 /*
@@ -763,7 +762,7 @@ void __init setup_boot_APIC_clock (void)
 	printk(KERN_INFO "Using local APIC timer interrupts.\n");
 	using_apic_timer = 1;
 
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	calibration_result = calibrate_APIC_clock();
 	/*
@@ -771,14 +770,14 @@ void __init setup_boot_APIC_clock (void)
 	 */
 	setup_APIC_timer(calibration_result);
 
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 void __init setup_secondary_APIC_clock(void)
 {
-	local_irq_disable(); /* FIXME: Do we need this? --RR */
+	raw_local_irq_disable(); /* FIXME: Do we need this? --RR */
 	setup_APIC_timer(calibration_result);
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 void __init disable_APIC_timer(void)
diff -Nurp -X linux-RT/Documentation/dontdiff linux-RT/arch/x86_64/kernel/irq.c linux-RT.mich/arch/x86_64/kernel/irq.c
--- linux-RT/arch/x86_64/kernel/irq.c	2005-03-02 08:38:07.000000000 +0100
+++ linux-RT.mich/arch/x86_64/kernel/irq.c	2005-06-08 19:13:26.000000000 +0200
@@ -43,7 +43,8 @@ int show_interrupts(struct seq_file *p, 
 	}
 
 	if (i < NR_IRQS) {
-		spin_lock_irqsave(&irq_desc[i].lock, flags);
+		raw_local_irq_save(flags);
+		spin_lock(&irq_desc[i].lock);
 		action = irq_desc[i].action;
 		if (!action) 
 			goto skip;
@@ -63,7 +64,8 @@ int show_interrupts(struct seq_file *p, 
 			seq_printf(p, ", %s", action->name);
 		seq_putc(p, '\n');
 skip:
-		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
+		spin_unlock(&irq_desc[i].lock);
+		raw_local_irq_restore(flags);
 	} else if (i == NR_IRQS) {
 		seq_printf(p, "NMI: ");
 		for (j = 0; j < NR_CPUS; j++)
diff -Nurp -X linux-RT/Documentation/dontdiff linux-RT/arch/x86_64/kernel/process.c linux-RT.mich/arch/x86_64/kernel/process.c
--- linux-RT/arch/x86_64/kernel/process.c	2005-06-08 19:28:13.000000000 +0200
+++ linux-RT.mich/arch/x86_64/kernel/process.c	2005-06-08 19:01:05.000000000 +0200
@@ -85,13 +85,13 @@ EXPORT_SYMBOL(enable_hlt);
 void default_idle(void)
 {
 	if (!atomic_read(&hlt_counter)) {
-		local_irq_disable();
+		raw_local_irq_disable();
 		if (!need_resched())
-			safe_halt();
+			raw_safe_halt();
 		else
-			local_irq_enable();
+			raw_local_irq_enable();
 	} else
-		local_irq_enable();
+		raw_local_irq_enable();
 }
 
 /*
@@ -103,7 +103,7 @@ static void poll_idle (void)
 {
 	int oldval;
 
-	local_irq_enable();
+	raw_local_irq_enable();
 
 	/*
 	 * Deal with another CPU just having chosen a thread to
@@ -164,6 +164,8 @@ void cpu_idle (void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
+		BUG_ON(raw_irqs_disabled());
+
 		while (!need_resched()) {
 			void (*idle)(void);
 
@@ -178,7 +180,9 @@ void cpu_idle (void)
 			propagate_preempt_locks_value();
 			idle();
 		}
+		raw_local_irq_disable();
 		__schedule();
+		raw_local_irq_enable();
 	}
 }
 
@@ -191,7 +195,7 @@ void cpu_idle (void)
  */
 static void mwait_idle(void)
 {
-	local_irq_enable();
+	raw_local_irq_enable();
 
 	if (!need_resched()) {
 		set_thread_flag(TIF_POLLING_NRFLAG);
diff -Nurp -X linux-RT/Documentation/dontdiff linux-RT/arch/x86_64/kernel/signal.c linux-RT.mich/arch/x86_64/kernel/signal.c
--- linux-RT/arch/x86_64/kernel/signal.c	2005-06-07 14:05:16.000000000 +0200
+++ linux-RT.mich/arch/x86_64/kernel/signal.c	2005-06-08 18:53:24.000000000 +0200
@@ -411,6 +411,13 @@ int do_signal(struct pt_regs *regs, sigs
 	siginfo_t info;
 	int signr;
 
+#ifdef CONFIG_PREEMPT_RT
+	/*
+	 * Fully-preemptible kernel does not need interrupts disabled:
+	 */
+	raw_local_irq_enable();
+	preempt_check_resched();
+#endif
 	/*
 	 * We want the common case to go fast, which
 	 * is why we may in certain cases get here from
diff -Nurp -X linux-RT/Documentation/dontdiff linux-RT/arch/x86_64/kernel/smpboot.c linux-RT.mich/arch/x86_64/kernel/smpboot.c
--- linux-RT/arch/x86_64/kernel/smpboot.c	2005-06-07 14:05:16.000000000 +0200
+++ linux-RT.mich/arch/x86_64/kernel/smpboot.c	2005-06-08 19:23:36.000000000 +0200
@@ -207,7 +207,7 @@ static __cpuinit void sync_master(void *
 
 	go[MASTER] = 0;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	{
 		for (i = 0; i < NUM_ROUNDS*NUM_ITERS; ++i) {
 			while (!go[MASTER])
@@ -216,7 +216,7 @@ static __cpuinit void sync_master(void *
 			rdtscll(go[SLAVE]);
 		}
 	}
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 
 /*
diff -Nurp -X linux-RT/Documentation/dontdiff linux-RT/arch/x86_64/kernel/smp.c linux-RT.mich/arch/x86_64/kernel/smp.c
--- linux-RT/arch/x86_64/kernel/smp.c	2005-06-08 19:28:13.000000000 +0200
+++ linux-RT.mich/arch/x86_64/kernel/smp.c	2005-06-08 19:10:50.000000000 +0200
@@ -359,9 +359,9 @@ void smp_stop_cpu(void)
 	 * Remove this CPU:
 	 */
 	cpu_clear(smp_processor_id(), cpu_online_map);
-	local_irq_disable();
+	raw_local_irq_disable();
 	disable_local_APIC();
-	local_irq_enable(); 
+	raw_local_irq_enable(); 
 }
 
 static void smp_really_stop_cpu(void *dummy)
@@ -385,9 +385,9 @@ void smp_send_stop(void)
 	if (!nolock)
 		spin_unlock(&call_lock);
 
-	local_irq_disable();
+	raw_local_irq_disable();
 	disable_local_APIC();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /*
diff -Nurp -X linux-RT/Documentation/dontdiff linux-RT/arch/x86_64/kernel/traps.c linux-RT.mich/arch/x86_64/kernel/traps.c
--- linux-RT/arch/x86_64/kernel/traps.c	2005-06-08 19:28:13.000000000 +0200
+++ linux-RT.mich/arch/x86_64/kernel/traps.c	2005-06-08 19:09:25.000000000 +0200
@@ -90,7 +90,7 @@ int register_die_notifier(struct notifie
 static inline void conditional_sti(struct pt_regs *regs)
 {
 	if (regs->eflags & X86_EFLAGS_IF)
-		local_irq_enable();
+		raw_local_irq_enable();
 }
 
 static int kstack_depth_to_print = 10;
@@ -347,7 +347,7 @@ void oops_begin(void)
 {
 	int cpu = safe_smp_processor_id(); 
 	/* racy, but better than risking deadlock. */ 
-	local_irq_disable();
+	raw_local_irq_disable();
 	if (!spin_trylock(&die_lock)) { 
 		if (cpu == die_owner) 
 			/* nested oops. should stop eventually */;
diff -Nurp -X linux-RT/Documentation/dontdiff linux-RT/arch/x86_64/mm/fault.c linux-RT.mich/arch/x86_64/mm/fault.c
--- linux-RT/arch/x86_64/mm/fault.c	2005-06-08 19:28:13.000000000 +0200
+++ linux-RT.mich/arch/x86_64/mm/fault.c	2005-06-08 18:47:49.000000000 +0200
@@ -327,7 +327,7 @@ asmlinkage void do_page_fault(struct pt_
 		return;
 
 	if (likely(regs->eflags & X86_EFLAGS_IF))
-		local_irq_enable();
+		raw_local_irq_enable();
 
 	if (unlikely(page_fault_trace))
 		printk("pagefault rip:%lx rsp:%lx cs:%lu ss:%lu address %lx error %lx\n",
diff -Nurp -X linux-RT/Documentation/dontdiff linux-RT/include/asm-x86_64/system.h linux-RT.mich/include/asm-x86_64/system.h
--- linux-RT/include/asm-x86_64/system.h	2005-06-08 19:28:13.000000000 +0200
+++ linux-RT.mich/include/asm-x86_64/system.h	2005-06-08 19:22:44.000000000 +0200
@@ -309,27 +309,31 @@ static inline unsigned long __cmpxchg(vo
 #define warn_if_not_ulong(x) do { unsigned long foo; (void) (&(x) == &foo); } while (0)
 
 /* interrupt control.. */
-#define local_save_flags(x)	do { warn_if_not_ulong(x); __asm__ __volatile__("# save_flags \n\t pushfq ; popq %q0":"=g" (x): /* no input */ :"memory"); } while (0)
-#define local_irq_restore(x) 	__asm__ __volatile__("# restore_flags \n\t pushq %0 ; popfq": /* no output */ :"g" (x):"memory", "cc")
-#define local_irq_disable() 	__asm__ __volatile__("cli": : :"memory")
-#define local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
+#define __raw_local_save_flags(x)	do { warn_if_not_ulong(x); __asm__ __volatile__("# save_flags \n\t pushfq ; popq %q0":"=g" (x): /* no input */ :"memory"); } while (0)
+#define __raw_local_irq_restore(x) 	__asm__ __volatile__("# restore_flags \n\t pushq %0 ; popfq": /* no output */ :"g" (x):"memory", "cc")
+#define __raw_local_irq_disable() 	__asm__ __volatile__("cli": : :"memory")
+#define __raw_local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
 /* used in the idle loop; sti takes one instruction cycle to complete */
-#define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
+#define __raw_safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
 
-#define irqs_disabled_flags(flags)	\
-({					\
-	!(flags & (1<<9));		\
+#define __raw_irqs_disabled_flags(flags)	\
+({						\
+	!(flags & (1<<9));			\
 })
 
-#define irqs_disabled()			\
-({					\
-	unsigned long flags;		\
-	local_save_flags(flags);	\
-	irqs_disabled_flags(flags);	\
+#define __raw_irqs_disabled()			\
+({						\
+	unsigned long flags;			\
+	__raw_local_save_flags(flags);		\
+	__raw_irqs_disabled_flags(flags);		\
 })
 
 /* For spinlocks etc */
-#define local_irq_save(x) 	do { warn_if_not_ulong(x); __asm__ __volatile__("# local_irq_save \n\t pushfq ; popq %0 ; cli":"=g" (x): /* no input */ :"memory"); } while (0)
+#define __raw_local_irq_save(x) 	do { warn_if_not_ulong(x); __asm__ __volatile__("# local_irq_save \n\t pushfq ; popq %0 ; cli":"=g" (x): /* no input */ :"memory"); } while (0)
+
+#include <linux/rt_irq.h>
+
+#define safe_halt()	do { local_irq_enable(); __asm__ __volatile__("hlt": : :"memory"); } while (0)
 
 void cpu_idle_wait(void);
 

--------------010809000307030509040800--
