Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936945AbWLDOzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936945AbWLDOzT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936941AbWLDOzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:55:15 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:22436 "EHLO
	mtagate5.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936954AbWLDOzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:55:04 -0500
Date: Mon, 4 Dec 2006 15:54:58 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] pfault code cleanup.
Message-ID: <20061204145458.GV32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] pfault code cleanup.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/machine_kexec.c |    8 +-------
 arch/s390/kernel/smp.c           |   13 +++----------
 arch/s390/kernel/traps.c         |   25 +------------------------
 arch/s390/mm/fault.c             |   28 +++++++++++++++++++++++++---
 include/asm-s390/system.h        |   10 ++++++++++
 5 files changed, 40 insertions(+), 44 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/machine_kexec.c linux-2.6-patched/arch/s390/kernel/machine_kexec.c
--- linux-2.6/arch/s390/kernel/machine_kexec.c	2006-12-04 14:50:51.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/machine_kexec.c	2006-12-04 14:50:53.000000000 +0100
@@ -49,18 +49,12 @@ void machine_shutdown(void)
 	printk(KERN_INFO "kexec: machine_shutdown called\n");
 }
 
-extern void pfault_fini(void);
-
 void machine_kexec(struct kimage *image)
 {
 	relocate_kernel_t data_mover;
 
-	preempt_disable();
-#ifdef CONFIG_PFAULT
-	if (MACHINE_IS_VM)
-		pfault_fini();
-#endif
 	smp_send_stop();
+	pfault_fini();
 	s390_reset_system();
 
 	data_mover = (relocate_kernel_t) page_to_phys(image->control_code_page);
diff -urpN linux-2.6/arch/s390/kernel/smp.c linux-2.6-patched/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	2006-12-04 14:50:51.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/smp.c	2006-12-04 14:50:53.000000000 +0100
@@ -460,8 +460,6 @@ __init smp_count_cpus(void)
  */
 extern void init_cpu_timer(void);
 extern void init_cpu_vtimer(void);
-extern int pfault_init(void);
-extern void pfault_fini(void);
 
 int __devinit start_secondary(void *cpuvoid)
 {
@@ -473,11 +471,9 @@ int __devinit start_secondary(void *cpuv
 #ifdef CONFIG_VIRT_TIMER
         init_cpu_vtimer();
 #endif
-#ifdef CONFIG_PFAULT
 	/* Enable pfault pseudo page faults on this cpu. */
-	if (MACHINE_IS_VM)
-		pfault_init();
-#endif
+	pfault_init();
+
 	/* Mark this cpu as online */
 	cpu_set(smp_processor_id(), cpu_online_map);
 	/* Switch on interrupts */
@@ -667,11 +663,8 @@ __cpu_disable(void)
 	}
 	cpu_clear(cpu, cpu_online_map);
 
-#ifdef CONFIG_PFAULT
 	/* Disable pfault pseudo page faults on this cpu. */
-	if (MACHINE_IS_VM)
-		pfault_fini();
-#endif
+	pfault_fini();
 
 	memset(&cr_parms.orvals, 0, sizeof(cr_parms.orvals));
 	memset(&cr_parms.andvals, 0xff, sizeof(cr_parms.andvals));
diff -urpN linux-2.6/arch/s390/kernel/traps.c linux-2.6-patched/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/traps.c	2006-12-04 14:50:53.000000000 +0100
@@ -58,12 +58,6 @@ int sysctl_userprocess_debug = 0;
 
 extern pgm_check_handler_t do_protection_exception;
 extern pgm_check_handler_t do_dat_exception;
-#ifdef CONFIG_PFAULT
-extern int pfault_init(void);
-extern void pfault_fini(void);
-extern void pfault_interrupt(__u16 error_code);
-static ext_int_info_t ext_int_pfault;
-#endif
 extern pgm_check_handler_t do_monitor_call;
 
 #define stack_pointer ({ void **sp; asm("la %0,0(15)" : "=&d" (sp)); sp; })
@@ -739,22 +733,5 @@ void __init trap_init(void)
         pgm_check_table[0x1C] = &space_switch_exception;
         pgm_check_table[0x1D] = &hfp_sqrt_exception;
 	pgm_check_table[0x40] = &do_monitor_call;
-
-	if (MACHINE_IS_VM) {
-#ifdef CONFIG_PFAULT
-		/*
-		 * Try to get pfault pseudo page faults going.
-		 */
-		if (register_early_external_interrupt(0x2603, pfault_interrupt,
-						      &ext_int_pfault) != 0)
-			panic("Couldn't request external interrupt 0x2603");
-
-		if (pfault_init() == 0) 
-			return;
-		
-		/* Tough luck, no pfault. */
-		unregister_early_external_interrupt(0x2603, pfault_interrupt,
-						    &ext_int_pfault);
-#endif
-	}
+	pfault_irq_init();
 }
diff -urpN linux-2.6/arch/s390/mm/fault.c linux-2.6-patched/arch/s390/mm/fault.c
--- linux-2.6/arch/s390/mm/fault.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/fault.c	2006-12-04 14:50:53.000000000 +0100
@@ -31,6 +31,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/kdebug.h>
+#include <asm/s390_ext.h>
 
 #ifndef CONFIG_64BIT
 #define __FAIL_ADDR_MASK 0x7ffff000
@@ -394,6 +395,7 @@ void do_dat_exception(struct pt_regs *re
 /*
  * 'pfault' pseudo page faults routines.
  */
+static ext_int_info_t ext_int_pfault;
 static int pfault_disable = 0;
 
 static int __init nopfault(char *str)
@@ -422,7 +424,7 @@ int pfault_init(void)
 		  __PF_RES_FIELD };
         int rc;
 
-	if (pfault_disable)
+	if (!MACHINE_IS_VM || pfault_disable)
 		return -1;
 	asm volatile(
 		"	diag	%1,%0,0x258\n"
@@ -440,7 +442,7 @@ void pfault_fini(void)
 	pfault_refbk_t refbk =
 	{ 0x258, 1, 5, 2, 0ULL, 0ULL, 0ULL, 0ULL };
 
-	if (pfault_disable)
+	if (!MACHINE_IS_VM || pfault_disable)
 		return;
 	__ctl_clear_bit(0,9);
 	asm volatile(
@@ -500,5 +502,25 @@ pfault_interrupt(__u16 error_code)
 			set_tsk_need_resched(tsk);
 	}
 }
-#endif
 
+void __init pfault_irq_init(void)
+{
+	if (!MACHINE_IS_VM)
+		return;
+
+	/*
+	 * Try to get pfault pseudo page faults going.
+	 */
+	if (register_early_external_interrupt(0x2603, pfault_interrupt,
+					      &ext_int_pfault) != 0)
+		panic("Couldn't request external interrupt 0x2603");
+
+	if (pfault_init() == 0)
+		return;
+
+	/* Tough luck, no pfault. */
+	pfault_disable = 1;
+	unregister_early_external_interrupt(0x2603, pfault_interrupt,
+					    &ext_int_pfault);
+}
+#endif
diff -urpN linux-2.6/include/asm-s390/system.h linux-2.6-patched/include/asm-s390/system.h
--- linux-2.6/include/asm-s390/system.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/system.h	2006-12-04 14:50:53.000000000 +0100
@@ -115,6 +115,16 @@ extern void account_system_vtime(struct 
 #define account_vtime(x) do { /* empty */ } while (0)
 #endif
 
+#ifdef CONFIG_PFAULT
+extern void pfault_irq_init(void);
+extern int pfault_init(void);
+extern void pfault_fini(void);
+#else /* CONFIG_PFAULT */
+#define pfault_irq_init()	do { } while (0)
+#define pfault_init()		({-1;})
+#define pfault_fini()		do { } while (0)
+#endif /* CONFIG_PFAULT */
+
 #define finish_arch_switch(prev) do {					     \
 	set_fs(current->thread.mm_segment);				     \
 	account_vtime(prev);						     \
