Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbVAPF7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbVAPF7P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 00:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVAPF7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 00:59:14 -0500
Received: from ozlabs.org ([203.10.76.45]:36738 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262438AbVAPF5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 00:57:38 -0500
Date: Sun, 16 Jan 2005 16:55:23 +1100
From: Anton Blanchard <anton@samba.org>
To: Adrian Bunk <bunk@stusta.de>, akpm@osdl.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH] ppc64: Remove CONFIG_IRQ_ALL_CPUS
Message-ID: <20050116055523.GQ6309@krispykreme.ozlabs.ibm.com>
References: <20050116043356.GM4274@stusta.de> <20050116051904.GP6309@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116051904.GP6309@krispykreme.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Replace CONFIG_IRQ_ALL_CPUS with a boot option (noirqdistrib). Compile
options arent much use on a distro kernel. This also removes the ppc64
use of smp_threads_ready.

I considered removing the option completely but we have had problems in
the past with firmware bugs. In those cases the boot option would have
helped. 

Signed-off-by: Anton Blanchard <anton@samba.org>

===== arch/ppc64/Kconfig 1.76 vs edited =====
--- 1.76/arch/ppc64/Kconfig	2005-01-16 09:31:06 +11:00
+++ edited/arch/ppc64/Kconfig	2005-01-16 16:48:43 +11:00
@@ -186,14 +186,6 @@
 
 	  If you don't know what to do here, say Y.
 
-config IRQ_ALL_CPUS
-	bool "Distribute interrupts on all CPUs by default"
-	depends on SMP && PPC_MULTIPLATFORM
-	help
-	  This option gives the kernel permission to distribute IRQs across
-	  multiple CPUs.  Saying N here will route all IRQs to the first
-	  CPU.
-
 config NR_CPUS
 	int "Maximum number of CPUs (2-128)"
 	range 2 128
===== arch/ppc64/kernel/irq.c 1.74 vs edited =====
--- 1.74/arch/ppc64/kernel/irq.c	2005-01-05 13:48:02 +11:00
+++ edited/arch/ppc64/kernel/irq.c	2005-01-16 16:48:47 +11:00
@@ -62,6 +62,7 @@
 
 extern irq_desc_t irq_desc[NR_IRQS];
 
+int distribute_irqs = 1;
 int __irq_offset_value;
 int ppc_spurious_interrupts;
 unsigned long lpevent_count;
@@ -479,3 +480,10 @@
 
 #endif /* CONFIG_IRQSTACKS */
 
+static int __init setup_noirqdistrib(char *str)
+{
+	distribute_irqs = 0;
+	return 1;
+}
+
+__setup("noirqdistrib", setup_noirqdistrib);
===== arch/ppc64/kernel/mpic.c 1.3 vs edited =====
--- 1.3/arch/ppc64/kernel/mpic.c	2004-11-16 14:29:10 +11:00
+++ edited/arch/ppc64/kernel/mpic.c	2005-01-16 16:48:44 +11:00
@@ -765,10 +765,8 @@
 #ifdef CONFIG_SMP
 	struct mpic *mpic = mpic_primary;
 	unsigned long flags;
-#ifdef CONFIG_IRQ_ALL_CPUS
 	u32 msk = 1 << hard_smp_processor_id();
 	unsigned int i;
-#endif
 
 	BUG_ON(mpic == NULL);
 
@@ -776,16 +774,16 @@
 
 	spin_lock_irqsave(&mpic_lock, flags);
 
-#ifdef CONFIG_IRQ_ALL_CPUS
  	/* let the mpic know we want intrs. default affinity is 0xffffffff
 	 * until changed via /proc. That's how it's done on x86. If we want
 	 * it differently, then we should make sure we also change the default
 	 * values of irq_affinity in irq.c.
  	 */
- 	for (i = 0; i < mpic->num_sources ; i++)
-		mpic_irq_write(i, MPIC_IRQ_DESTINATION,
-			mpic_irq_read(i, MPIC_IRQ_DESTINATION) | msk);
-#endif /* CONFIG_IRQ_ALL_CPUS */
+	if (distribute_irqs) {
+	 	for (i = 0; i < mpic->num_sources ; i++)
+			mpic_irq_write(i, MPIC_IRQ_DESTINATION,
+				mpic_irq_read(i, MPIC_IRQ_DESTINATION) | msk);
+	}
 
 	/* Set current processor priority to 0 */
 	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0);
===== arch/ppc64/kernel/pSeries_smp.c 1.9 vs edited =====
--- 1.9/arch/ppc64/kernel/pSeries_smp.c	2005-01-12 11:42:40 +11:00
+++ edited/arch/ppc64/kernel/pSeries_smp.c	2005-01-16 16:48:44 +11:00
@@ -259,7 +259,6 @@
 	if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR)
 		vpa_init(cpu);
 
-#ifdef CONFIG_IRQ_ALL_CPUS
 	/*
 	 * Put the calling processor into the GIQ.  This is really only
 	 * necessary from a secondary thread as the OF start-cpu interface
@@ -267,7 +266,6 @@
 	 */
 	rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE,
 		(1UL << interrupt_server_size) - 1 - default_distrib_server, 1);
-#endif
 }
 
 static spinlock_t timebase_lock = SPIN_LOCK_UNLOCKED;
===== arch/ppc64/kernel/smp.c 1.104 vs edited =====
--- 1.104/arch/ppc64/kernel/smp.c	2005-01-12 11:42:39 +11:00
+++ edited/arch/ppc64/kernel/smp.c	2005-01-16 16:48:45 +11:00
@@ -526,9 +526,6 @@
 	
 	smp_ops->setup_cpu(boot_cpuid);
 
-	/* XXX fix this, xics currently relies on it - Anton */
-	smp_threads_ready = 1;
-
 	set_cpus_allowed(current, old_mask);
 
 	/*
===== arch/ppc64/kernel/xics.c 1.57 vs edited =====
--- 1.57/arch/ppc64/kernel/xics.c	2005-01-12 11:42:40 +11:00
+++ edited/arch/ppc64/kernel/xics.c	2005-01-16 16:48:45 +11:00
@@ -242,28 +242,24 @@
 static int get_irq_server(unsigned int irq)
 {
 	unsigned int server;
-
-#ifdef CONFIG_IRQ_ALL_CPUS
 	/* For the moment only implement delivery to all cpus or one cpu */
-	if (smp_threads_ready) {
-		cpumask_t cpumask = irq_affinity[irq];
-		cpumask_t tmp = CPU_MASK_NONE;
-		if (cpus_equal(cpumask, CPU_MASK_ALL)) {
-			server = default_distrib_server;
-		} else {
-			cpus_and(tmp, cpu_online_map, cpumask);
+	cpumask_t cpumask = irq_affinity[irq];
+	cpumask_t tmp = CPU_MASK_NONE;
+
+	if (!distribute_irqs)
+		return default_server;
 
-			if (cpus_empty(tmp))
-				server = default_distrib_server;
-			else
-				server = get_hard_smp_processor_id(first_cpu(tmp));
-		}
+	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
+		server = default_distrib_server;
 	} else {
-		server = default_server;
+		cpus_and(tmp, cpu_online_map, cpumask);
+
+		if (cpus_empty(tmp))
+			server = default_distrib_server;
+		else
+			server = get_hard_smp_processor_id(first_cpu(tmp));
 	}
-#else
-	server = default_server;
-#endif
+
 	return server;
 
 }
===== include/asm-ppc64/irq.h 1.11 vs edited =====
--- 1.11/include/asm-ppc64/irq.h	2004-10-23 11:44:19 +10:00
+++ edited/include/asm-ppc64/irq.h	2005-01-16 16:48:47 +11:00
@@ -87,6 +87,8 @@
 	return irq;
 }
 
+extern int distribute_irqs;
+
 struct irqaction;
 struct pt_regs;
 
