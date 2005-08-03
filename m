Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVHCFTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVHCFTp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 01:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbVHCFTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 01:19:45 -0400
Received: from ozlabs.org ([203.10.76.45]:14726 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262059AbVHCFTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 01:19:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17136.21367.950042.434137@cargo.ozlabs.ibm.com>
Date: Wed, 3 Aug 2005 15:17:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org, akpm@osdl.org
CC: anton@samba.org, hbabu@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix for kexec boot issue
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kexec boot is not successful on some power machines since all CPUs 
are getting removed from global interrupt queue (GIQ) before kexec boot. 
Some systems always expect at least one CPU in GIQ. Hence, this patch 
will make sure that only secondary CPUs are removed from GIQ.

[This only affects kexec on ppc64 and should be safe to go in
2.6.13. -- paulus]

Signed-off-by: Haren Myneni <hbabu@us.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff -Naurp 2613-rc4-git4.orig/arch/ppc64/kernel/machine_kexec.c 2613-rc4-git4/arch/ppc64/kernel/machine_kexec.c
--- 2613-rc4-git4.orig/arch/ppc64/kernel/machine_kexec.c	2005-08-01 18:58:08.000000000 -0700
+++ 2613-rc4-git4/arch/ppc64/kernel/machine_kexec.c	2005-08-01 18:59:52.000000000 -0700
@@ -185,7 +185,7 @@ void kexec_copy_flush(struct kimage *ima
 void kexec_smp_down(void *arg)
 {
 	if (ppc_md.cpu_irq_down)
-		ppc_md.cpu_irq_down();
+		ppc_md.cpu_irq_down(1);
 
 	local_irq_disable();
 	kexec_smp_wait();
@@ -232,7 +232,7 @@ static void kexec_prepare_cpus(void)
 
 	/* after we tell the others to go down */
 	if (ppc_md.cpu_irq_down)
-		ppc_md.cpu_irq_down();
+		ppc_md.cpu_irq_down(0);
 
 	put_cpu();
 
@@ -251,7 +251,7 @@ static void kexec_prepare_cpus(void)
 	 */
 	smp_relase_cpus();
 	if (ppc_md.cpu_irq_down)
-		ppc_md.cpu_irq_down();
+		ppc_md.cpu_irq_down(0);
 	local_irq_disable();
 }
 
diff -Naurp 2613-rc4-git4.orig/arch/ppc64/kernel/mpic.c 2613-rc4-git4/arch/ppc64/kernel/mpic.c
--- 2613-rc4-git4.orig/arch/ppc64/kernel/mpic.c	2005-08-01 18:58:08.000000000 -0700
+++ 2613-rc4-git4/arch/ppc64/kernel/mpic.c	2005-08-01 19:00:01.000000000 -0700
@@ -794,10 +794,10 @@ void mpic_setup_this_cpu(void)
 
 /*
  * XXX: someone who knows mpic should check this.
- * do we need to eoi the ipi here (see xics comments)?
+ * do we need to eoi the ipi including for kexec cpu here (see xics comments)?
  * or can we reset the mpic in the new kernel?
  */
-void mpic_teardown_this_cpu(void)
+void mpic_teardown_this_cpu(int secondary)
 {
 	struct mpic *mpic = mpic_primary;
 	unsigned long flags;
diff -Naurp 2613-rc4-git4.orig/arch/ppc64/kernel/mpic.h 2613-rc4-git4/arch/ppc64/kernel/mpic.h
--- 2613-rc4-git4.orig/arch/ppc64/kernel/mpic.h	2005-08-01 18:58:14.000000000 -0700
+++ 2613-rc4-git4/arch/ppc64/kernel/mpic.h	2005-08-01 19:00:04.000000000 -0700
@@ -256,7 +256,7 @@ extern unsigned int mpic_irq_get_priorit
 extern void mpic_setup_this_cpu(void);
 
 /* Clean up for kexec (or cpu offline or ...) */
-extern void mpic_teardown_this_cpu(void);
+extern void mpic_teardown_this_cpu(int secondary);
 
 /* Request IPIs on primary mpic */
 extern void mpic_request_ipis(void);
diff -Naurp 2613-rc4-git4.orig/arch/ppc64/kernel/xics.c 2613-rc4-git4/arch/ppc64/kernel/xics.c
--- 2613-rc4-git4.orig/arch/ppc64/kernel/xics.c	2005-08-01 18:58:08.000000000 -0700
+++ 2613-rc4-git4/arch/ppc64/kernel/xics.c	2005-08-01 18:59:56.000000000 -0700
@@ -647,29 +647,30 @@ static void xics_set_affinity(unsigned i
 	}
 }
 
-void xics_teardown_cpu(void)
+void xics_teardown_cpu(int secondary)
 {
 	int cpu = smp_processor_id();
-	int status;
 
 	ops->cppr_info(cpu, 0x00);
 	iosync();
 
-	/*
-	 * we need to EOI the IPI if we got here from kexec down IPI
-	 *
-	 * xics doesn't care if we duplicate an EOI as long as we
-	 * don't EOI and raise priority.
-	 *
-	 * probably need to check all the other interrupts too
-	 * should we be flagging idle loop instead?
-	 * or creating some task to be scheduled?
+	/* 
+	 * Some machines need to have at least one cpu in the GIQ, 
+	 * so leave the master cpu in the group.
 	 */
-	ops->xirr_info_set(cpu, XICS_IPI);
-
-	status = rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE,
-		(1UL << interrupt_server_size) - 1 - default_distrib_server, 0);
-	WARN_ON(status != 0);
+	if (secondary) {
+		/*
+		 * we need to EOI the IPI if we got here from kexec down IPI
+		 *
+		 * probably need to check all the other interrupts too
+		 * should we be flagging idle loop instead?
+		 * or creating some task to be scheduled?
+		 */
+		ops->xirr_info_set(cpu, XICS_IPI);
+		rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE, 
+			(1UL << interrupt_server_size) - 1 -
+			default_distrib_server, 0);
+	}
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff -Naurp 2613-rc4-git4.orig/include/asm-ppc64/machdep.h 2613-rc4-git4/include/asm-ppc64/machdep.h
--- 2613-rc4-git4.orig/include/asm-ppc64/machdep.h	2005-08-01 18:59:05.000000000 -0700
+++ 2613-rc4-git4/include/asm-ppc64/machdep.h	2005-08-01 19:00:30.000000000 -0700
@@ -84,7 +84,7 @@ struct machdep_calls {
 
 	void		(*init_IRQ)(void);
 	int		(*get_irq)(struct pt_regs *);
-	void		(*cpu_irq_down)(void);
+	void		(*cpu_irq_down)(int secondary);
 
 	/* PCI stuff */
 	void		(*pcibios_fixup)(void);
diff -Naurp 2613-rc4-git4.orig/include/asm-ppc64/xics.h 2613-rc4-git4/include/asm-ppc64/xics.h
--- 2613-rc4-git4.orig/include/asm-ppc64/xics.h	2005-08-01 18:58:53.000000000 -0700
+++ 2613-rc4-git4/include/asm-ppc64/xics.h	2005-08-01 19:00:34.000000000 -0700
@@ -17,7 +17,7 @@
 void xics_init_IRQ(void);
 int xics_get_irq(struct pt_regs *);
 void xics_setup_cpu(void);
-void xics_teardown_cpu(void);
+void xics_teardown_cpu(int secondary);
 void xics_cause_IPI(int cpu);
 void xics_request_IPIs(void);
 void xics_migrate_irqs_away(void);
