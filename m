Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVBIV4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVBIV4z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 16:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVBIV4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 16:56:55 -0500
Received: from ozlabs.org ([203.10.76.45]:16297 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261945AbVBIV4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 16:56:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16906.34562.379000.336836@cargo.ozlabs.ibm.com>
Date: Thu, 10 Feb 2005 08:56:18 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, ahuja@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 collect and export low-level cpu usage statistics
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

POWER5 machines have a per-hardware-thread register which counts at a
rate which is proportional to the percentage of cycles on which the
cpu dispatches an instruction for this thread (if the thread gets all
the dispatch cycles it counts at the same rate as the timebase
register).  This register is also context-switched by the hypervisor.
Thus it gives a fine-grained measure of the actual cpu usage by the
thread over time.

This patch adds code to read this register every timer interrupt and
on every context switch.  The total over all virtual processors is
available through the existing /proc/ppc64/lparcfg file, giving a
way to measure the total cpu usage over the whole partition.

Andrew, this is relatively non-invasive, but nevertheless you may
prefer to put it in -mm until 2.6.11 is out.

Signed-off-by: Manish Ahuja <ahuja@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/lparcfg.c test/arch/ppc64/kernel/lparcfg.c
--- linux-2.5/arch/ppc64/kernel/lparcfg.c	2005-01-06 13:13:08.000000000 +1100
+++ test/arch/ppc64/kernel/lparcfg.c	2005-02-09 22:38:05.508190616 +1100
@@ -33,8 +33,9 @@
 #include <asm/cputable.h>
 #include <asm/rtas.h>
 #include <asm/system.h>
+#include <asm/time.h>
 
-#define MODULE_VERS "1.5"
+#define MODULE_VERS "1.6"
 #define MODULE_NAME "lparcfg"
 
 /* #define LPARCFG_DEBUG */
@@ -214,13 +215,20 @@
 }
 
 static unsigned long get_purr(void);
-/* ToDo:  get sum of purr across all processors.  The purr collection code
- * is coming, but at this time is still problematic, so for now this
- * function will return 0.
- */
+
+/* Track sum of all purrs across all processors. This is used to further */
+/* calculate usage values by different applications                       */
+
 static unsigned long get_purr(void)
 {
 	unsigned long sum_purr = 0;
+	int cpu;
+	struct cpu_usage *cu;
+
+	for_each_cpu(cpu) {
+		cu = &per_cpu(cpu_usage_array, cpu);
+		sum_purr += cu->current_tb;
+	}
 	return sum_purr;
 }
 
diff -urN linux-2.5/arch/ppc64/kernel/process.c test/arch/ppc64/kernel/process.c
--- linux-2.5/arch/ppc64/kernel/process.c	2005-01-29 09:58:49.000000000 +1100
+++ test/arch/ppc64/kernel/process.c	2005-02-10 08:09:22.428216944 +1100
@@ -51,6 +51,7 @@
 #include <asm/cputable.h>
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
+#include <asm/time.h>
 
 #ifndef CONFIG_SMP
 struct task_struct *last_task_used_math = NULL;
@@ -168,6 +169,8 @@
 
 #endif /* CONFIG_ALTIVEC */
 
+DEFINE_PER_CPU(struct cpu_usage, cpu_usage_array);
+
 struct task_struct *__switch_to(struct task_struct *prev,
 				struct task_struct *new)
 {
@@ -206,6 +209,21 @@
 	new_thread = &new->thread;
 	old_thread = &current->thread;
 
+/* Collect purr utilization data per process and per processor wise */
+/* purr is nothing but processor time base                          */
+
+#if defined(CONFIG_PPC_PSERIES)
+	if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR) {
+		struct cpu_usage *cu = &__get_cpu_var(cpu_usage_array);
+		long unsigned start_tb, current_tb;
+		start_tb = old_thread->start_tb;
+		cu->current_tb = current_tb = mfspr(SPRN_PURR);
+		old_thread->accum_tb += (current_tb - start_tb);
+		new_thread->start_tb = current_tb;
+	}
+#endif
+
+
 	local_irq_save(flags);
 	last = _switch(old_thread, new_thread);
 
diff -urN linux-2.5/arch/ppc64/kernel/time.c test/arch/ppc64/kernel/time.c
--- linux-2.5/arch/ppc64/kernel/time.c	2005-01-22 09:25:41.000000000 +1100
+++ test/arch/ppc64/kernel/time.c	2005-02-10 08:09:34.412257896 +1100
@@ -334,6 +334,14 @@
 	}
 #endif
 
+/* collect purr register values often, for accurate calculations */
+#if defined(CONFIG_PPC_PSERIES)
+	if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR) {
+		struct cpu_usage *cu = &__get_cpu_var(cpu_usage_array);
+		cu->current_tb = mfspr(SPRN_PURR);
+	}
+#endif
+
 	irq_exit();
 
 	return 1;
diff -urN linux-2.5/include/asm-ppc64/processor.h test/include/asm-ppc64/processor.h
--- linux-2.5/include/asm-ppc64/processor.h	2005-01-17 08:47:37.000000000 +1100
+++ test/include/asm-ppc64/processor.h	2005-02-09 22:38:05.528187576 +1100
@@ -562,7 +562,9 @@
 	double		fpr[32];	/* Complete floating point set */
 	unsigned long	fpscr;		/* Floating point status (plus pad) */
 	unsigned long	fpexc_mode;	/* Floating-point exception mode */
-	unsigned long	pad[3];		/* was saved_msr, saved_softe */
+	unsigned long	start_tb;	/* Start purr when proc switched in */
+	unsigned long	accum_tb;	/* Total accumilated purr for process */
+	unsigned long	pad;		/* was saved_msr, saved_softe */
 #ifdef CONFIG_ALTIVEC
 	/* Complete AltiVec register set */
 	vector128	vr[32] __attribute((aligned(16)));
diff -urN linux-2.5/include/asm-ppc64/time.h test/include/asm-ppc64/time.h
--- linux-2.5/include/asm-ppc64/time.h	2005-01-06 13:13:10.000000000 +1100
+++ test/include/asm-ppc64/time.h	2005-02-09 22:38:05.529187424 +1100
@@ -102,5 +102,14 @@
 unsigned mulhwu_scale_factor(unsigned, unsigned);
 void div128_by_32( unsigned long dividend_high, unsigned long dividend_low,
 		   unsigned divisor, struct div_result *dr );
+
+/* Used to store Processor Utilization register (purr) values */
+
+struct cpu_usage {
+        u64 current_tb;  /* Holds the current purr register values */
+};
+
+DECLARE_PER_CPU(struct cpu_usage, cpu_usage_array);
+
 #endif /* __KERNEL__ */
 #endif /* __PPC64_TIME_H */
