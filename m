Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751534AbWHaOui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbWHaOui (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 10:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbWHaOui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 10:50:38 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:53700 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1751534AbWHaOuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 10:50:37 -0400
Date: Thu, 31 Aug 2006 07:40:11 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@hpl.hp.com>
Subject: [PATCH] x86_64 fix idle notifier
Message-ID: <20060831144011.GA26187@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a patch against Linus GIT tree that fixes the idle notifier
for the X86-64 tree. With this notifiier you can get called when
entering/exiting the core of the idle loop. I don't think it is used
yet but I am planning to leverage it for perfmon. 

There was an issue in that it would not capture all re-entries into the
idle loop because of missing hooks on the return from interrupt path.

I have also modified the header file (idle.h) to avoid branching in
case this is not needed. The enter_idle()/exit_idle() calls are not
integrated into irq_enter()/irq_exit() because those are generic and
for now the idle notifier is arch specific.

Changelog:
	- fix the x86-64 idle notifier to cover all re-entries into the
	  core idle loop after an interrupt.
	- define enter_idle/exit_idle in idle.h to avoid branching when
	  not needed

Signed-off-by: Stephane Eranian <eranain@hpl.hp.com>


diff --git a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
--- a/arch/i386/kernel/apic.c
+++ b/arch/i386/kernel/apic.c
@@ -1230,9 +1230,11 @@ fastcall void smp_apic_timer_interrupt(s
 	 * Besides, if we don't timer interrupts ignore the global
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
+	exit_idle();
 	irq_enter();
 	smp_local_timer_interrupt(regs);
 	irq_exit();
+	enter_idle();
 }
 
 #ifndef CONFIG_SMP
@@ -1279,6 +1281,7 @@ fastcall void smp_spurious_interrupt(str
 {
 	unsigned long v;
 
+	exit_idle();
 	irq_enter();
 	/*
 	 * Check if this really is a spurious interrupt and ACK it
@@ -1293,6 +1296,7 @@ fastcall void smp_spurious_interrupt(str
 	printk(KERN_INFO "spurious APIC interrupt on CPU#%d, should never happen.\n",
 			smp_processor_id());
 	irq_exit();
+	enter_idle();
 }
 
 /*
@@ -1303,6 +1307,7 @@ fastcall void smp_error_interrupt(struct
 {
 	unsigned long v, v1;
 
+	exit_idle();
 	irq_enter();
 	/* First tickle the hardware, only then report what went on. -- REW */
 	v = apic_read(APIC_ESR);
@@ -1324,6 +1329,7 @@ fastcall void smp_error_interrupt(struct
 	printk (KERN_DEBUG "APIC error on CPU%d: %02lx(%02lx)\n",
 	        smp_processor_id(), v , v1);
 	irq_exit();
+	enter_idle();
 }
 
 /*
diff --git a/arch/i386/kernel/cpu/mcheck/p4.c b/arch/i386/kernel/cpu/mcheck/p4.c
--- a/arch/i386/kernel/cpu/mcheck/p4.c
+++ b/arch/i386/kernel/cpu/mcheck/p4.c
@@ -70,9 +70,11 @@ static void (*vendor_thermal_interrupt)(
 
 fastcall void smp_thermal_interrupt(struct pt_regs *regs)
 {
+	exit_idle();
 	irq_enter();
 	vendor_thermal_interrupt(regs);
 	irq_exit();
+	enter_idle();
 }
 
 /* P4/Xeon Thermal regulation detect and init */
diff --git a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c
+++ b/arch/i386/kernel/process.c
@@ -78,6 +78,35 @@ void (*pm_idle)(void);
 EXPORT_SYMBOL(pm_idle);
 static DEFINE_PER_CPU(unsigned int, cpu_idle_state);
 
+static ATOMIC_NOTIFIER_HEAD(idle_notifier);
+
+void idle_notifier_register(struct notifier_block *n)
+{
+	atomic_notifier_chain_register(&idle_notifier, n);
+}
+EXPORT_SYMBOL_GPL(idle_notifier_register);
+
+void idle_notifier_unregister(struct notifier_block *n)
+{
+	atomic_notifier_chain_unregister(&idle_notifier, n);
+}
+EXPORT_SYMBOL(idle_notifier_unregister);
+
+enum idle_state { CPU_IDLE, CPU_NOT_IDLE };
+static DEFINE_PER_CPU(enum idle_state, idle_state) = CPU_NOT_IDLE;
+
+void __enter_idle(void)
+{
+	__get_cpu_var(idle_state) = CPU_IDLE;
+	atomic_notifier_call_chain(&idle_notifier, IDLE_START, NULL);
+}
+
+void __exit_idle(void)
+{
+	__get_cpu_var(idle_state) = CPU_NOT_IDLE;
+	atomic_notifier_call_chain(&idle_notifier, IDLE_END, NULL);
+}
+
 void disable_hlt(void)
 {
 	hlt_counter++;
@@ -193,7 +222,9 @@ void cpu_idle(void)
 				play_dead();
 
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
+			__enter_idle();
 			idle();
+			__exit_idle();
 		}
 		preempt_enable_no_resched();
 		schedule();
diff --git a/arch/i386/kernel/smp.c b/arch/i386/kernel/smp.c
--- a/arch/i386/kernel/smp.c
+++ b/arch/i386/kernel/smp.c
@@ -624,6 +624,7 @@ fastcall void smp_call_function_interrup
 	/*
 	 * At this point the info structure may be out of scope unless wait==1
 	 */
+	exit_idle();
 	irq_enter();
 	(*func)(info);
 	irq_exit();
@@ -632,5 +633,6 @@ fastcall void smp_call_function_interrup
 		mb();
 		atomic_inc(&call_data->finished);
 	}
+	enter_idle();
 }
 
diff --git a/arch/x86_64/kernel/apic.c b/arch/x86_64/kernel/apic.c
--- a/arch/x86_64/kernel/apic.c
+++ b/arch/x86_64/kernel/apic.c
@@ -988,6 +988,7 @@ void smp_apic_timer_interrupt(struct pt_
 	irq_enter();
 	smp_local_timer_interrupt(regs);
 	irq_exit();
+	enter_idle();
 }
 
 /*
@@ -1069,6 +1070,7 @@ asmlinkage void smp_spurious_interrupt(v
 	} 
 #endif 
 	irq_exit();
+	enter_idle();
 }
 
 /*
@@ -1101,6 +1103,7 @@ asmlinkage void smp_error_interrupt(void
 	printk (KERN_DEBUG "APIC error on CPU%d: %02x(%02x)\n",
 	        smp_processor_id(), v , v1);
 	irq_exit();
+	enter_idle();
 }
 
 int disable_apic; 
diff --git a/arch/x86_64/kernel/irq.c b/arch/x86_64/kernel/irq.c
--- a/arch/x86_64/kernel/irq.c
+++ b/arch/x86_64/kernel/irq.c
@@ -131,6 +131,7 @@ asmlinkage unsigned int do_IRQ(struct pt
 #endif
 	__do_IRQ(irq, regs);
 	irq_exit();
+	enter_idle();
 
 	return 1;
 }
diff --git a/arch/x86_64/kernel/mce_amd.c b/arch/x86_64/kernel/mce_amd.c
--- a/arch/x86_64/kernel/mce_amd.c
+++ b/arch/x86_64/kernel/mce_amd.c
@@ -224,6 +224,7 @@ asmlinkage void mce_threshold_interrupt(
 	}
 out:
 	irq_exit();
+	enter_idle();
 }
 
 /*
diff --git a/arch/x86_64/kernel/mce_intel.c b/arch/x86_64/kernel/mce_intel.c
--- a/arch/x86_64/kernel/mce_intel.c
+++ b/arch/x86_64/kernel/mce_intel.c
@@ -42,6 +42,7 @@ asmlinkage void smp_thermal_interrupt(vo
 	mce_log(&m);
 done:
 	irq_exit();
+	enter_idle();
 }
 
 static void __cpuinit intel_init_thermal(struct cpuinfo_x86 *c)
diff --git a/arch/x86_64/kernel/process.c b/arch/x86_64/kernel/process.c
--- a/arch/x86_64/kernel/process.c
+++ b/arch/x86_64/kernel/process.c
@@ -83,26 +83,18 @@ EXPORT_SYMBOL(idle_notifier_unregister);
 enum idle_state { CPU_IDLE, CPU_NOT_IDLE };
 static DEFINE_PER_CPU(enum idle_state, idle_state) = CPU_NOT_IDLE;
 
-void enter_idle(void)
+void __enter_idle(void)
 {
 	__get_cpu_var(idle_state) = CPU_IDLE;
 	atomic_notifier_call_chain(&idle_notifier, IDLE_START, NULL);
 }
 
-static void __exit_idle(void)
+void __exit_idle(void)
 {
 	__get_cpu_var(idle_state) = CPU_NOT_IDLE;
 	atomic_notifier_call_chain(&idle_notifier, IDLE_END, NULL);
 }
 
-/* Called from interrupts to signify idle end */
-void exit_idle(void)
-{
-	if (current->pid | read_pda(irqcount))
-		return;
-	__exit_idle();
-}
-
 /*
  * We use this if we don't have any better
  * idle routine..
@@ -218,7 +210,7 @@ void cpu_idle (void)
 				idle = default_idle;
 			if (cpu_is_offline(smp_processor_id()))
 				play_dead();
-			enter_idle();
+			__enter_idle();
 			idle();
 			__exit_idle();
 		}
diff --git a/arch/x86_64/kernel/smp.c b/arch/x86_64/kernel/smp.c
--- a/arch/x86_64/kernel/smp.c
+++ b/arch/x86_64/kernel/smp.c
@@ -520,6 +520,7 @@ asmlinkage void smp_call_function_interr
 		mb();
 		atomic_inc(&call_data->finished);
 	}
+	enter_idle();
 }
 
 int safe_smp_processor_id(void)
diff --git a/include/asm-x86_64/idle.h b/include/asm-x86_64/idle.h
--- a/include/asm-x86_64/idle.h
+++ b/include/asm-x86_64/idle.h
@@ -8,7 +8,25 @@ struct notifier_block;
 void idle_notifier_register(struct notifier_block *n);
 void idle_notifier_unregister(struct notifier_block *n);
 
-void enter_idle(void);
-void exit_idle(void);
+void __exit_idle(void);
+void __enter_idle(void);
+
+/* Called from interrupts to signify back to idle */
+static inline void enter_idle(void)
+{
+	/* bitwise or is intentional */
+	if (current->pid | read_pda(irqcount))
+		return;
+	__enter_idle();
+}
+
+/* Called from interrupts to signify idle end */
+static inline void exit_idle(void)
+{
+	/* bitwise or is intentional */
+	if (current->pid | read_pda(irqcount))
+		return;
+	__exit_idle();
+}
 
 #endif
