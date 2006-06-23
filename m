Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWFWJVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWFWJVY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWFWJVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:21:18 -0400
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:63163 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751270AbWFWJVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:21:07 -0400
Date: Fri, 23 Jun 2006 02:13:12 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200606230913.k5N9DC8s032445@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 15/17] 2.6.17.1 perfmon2 patch for review: modified powerpc files
Cc: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the modified powerpc files.




diff -urp linux-2.6.17.1.orig/arch/powerpc/Kconfig linux-2.6.17.1/arch/powerpc/Kconfig
--- linux-2.6.17.1.orig/arch/powerpc/Kconfig	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/powerpc/Kconfig	2006-06-21 04:22:51.000000000 -0700
@@ -299,6 +299,9 @@ config NOT_COHERENT_CACHE
 	bool
 	depends on 4xx || 8xx || E200
 	default y
+
+source "arch/powerpc/perfmon/Kconfig"
+
 endmenu
 
 source "init/Kconfig"
diff -urp linux-2.6.17.1.orig/arch/powerpc/Makefile linux-2.6.17.1/arch/powerpc/Makefile
--- linux-2.6.17.1.orig/arch/powerpc/Makefile	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/powerpc/Makefile	2006-06-21 04:22:51.000000000 -0700
@@ -135,6 +135,7 @@ core-y				+= arch/powerpc/kernel/ \
 				   arch/powerpc/platforms/
 core-$(CONFIG_MATH_EMULATION)	+= arch/powerpc/math-emu/
 core-$(CONFIG_XMON)		+= arch/powerpc/xmon/
+core-$(CONFIG_PERFMON)		+= arch/powerpc/perfmon/
 
 drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 
diff -urp linux-2.6.17.1.orig/arch/powerpc/kernel/entry_64.S linux-2.6.17.1/arch/powerpc/kernel/entry_64.S
--- linux-2.6.17.1.orig/arch/powerpc/kernel/entry_64.S	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/powerpc/kernel/entry_64.S	2006-06-21 04:22:51.000000000 -0700
@@ -569,6 +569,9 @@ user_work:
 	b	.ret_from_except_lite
 
 1:	bl	.save_nvgprs
+#ifdef CONFIG_PERFMON
+	bl	.ppc64_pfm_handle_work
+#endif /* CONFIG_PERFMON */
 	li	r3,0
 	addi	r4,r1,STACK_FRAME_OVERHEAD
 	bl	.do_signal
diff -urp linux-2.6.17.1.orig/arch/powerpc/kernel/process.c linux-2.6.17.1/arch/powerpc/kernel/process.c
--- linux-2.6.17.1.orig/arch/powerpc/kernel/process.c	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/powerpc/kernel/process.c	2006-06-21 04:22:51.000000000 -0700
@@ -35,6 +35,7 @@
 #include <linux/mqueue.h>
 #include <linux/hardirq.h>
 #include <linux/utsname.h>
+#include <linux/perfmon.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -465,6 +466,7 @@ void show_regs(struct pt_regs * regs)
 void exit_thread(void)
 {
 	discard_lazy_cpu_state();
+	pfm_exit_thread(current);
 }
 
 void flush_thread(void)
@@ -576,6 +578,7 @@ int copy_thread(int nr, unsigned long cl
 	kregs->nip = (unsigned long)ret_from_fork;
 	p->thread.last_syscall = -1;
 #endif
+	pfm_copy_thread(p, childregs);
 
 	return 0;
 }
diff -urp linux-2.6.17.1.orig/arch/powerpc/kernel/systbl.S linux-2.6.17.1/arch/powerpc/kernel/systbl.S
--- linux-2.6.17.1.orig/arch/powerpc/kernel/systbl.S	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/powerpc/kernel/systbl.S	2006-06-21 04:22:51.000000000 -0700
@@ -340,7 +340,19 @@ SYSCALL(fchmodat)
 SYSCALL(faccessat)
 COMPAT_SYS(get_robust_list)
 COMPAT_SYS(set_robust_list)
-
+SYSCALL(pfm_create_context)
+SYSCALL(pfm_write_pmcs)
+SYSCALL(pfm_write_pmds)
+SYSCALL(pfm_read_pmds)
+SYSCALL(pfm_load_context)
+SYSCALL(pfm_start)
+SYSCALL(pfm_stop)
+SYSCALL(pfm_restart)
+SYSCALL(pfm_create_evtsets)
+SYSCALL(pfm_getinfo_evtsets)
+SYSCALL(pfm_delete_evtsets)
+SYSCALL(pfm_unload_context)
+ 
 /*
  * please add new calls to arch/powerpc/platforms/cell/spu_callbacks.c
  * as well when appropriate.
Only in linux-2.6.17.1/arch/powerpc: perfmon
Only in linux-2.6.17.1/include/asm-powerpc: perfmon.h
diff -urp linux-2.6.17.1.orig/include/asm-powerpc/processor.h linux-2.6.17.1/include/asm-powerpc/processor.h
--- linux-2.6.17.1.orig/include/asm-powerpc/processor.h	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/include/asm-powerpc/processor.h	2006-06-21 04:22:51.000000000 -0700
@@ -169,6 +169,7 @@ struct thread_struct {
 	unsigned long	spefscr;	/* SPE & eFP status */
 	int		used_spe;	/* set if process has used spe */
 #endif /* CONFIG_SPE */
+	void *pfm_context;
 };
 
 #define ARCH_MIN_TASKALIGN 16
diff -urp linux-2.6.17.1.orig/include/asm-powerpc/unistd.h linux-2.6.17.1/include/asm-powerpc/unistd.h
--- linux-2.6.17.1.orig/include/asm-powerpc/unistd.h	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/include/asm-powerpc/unistd.h	2006-06-21 04:22:51.000000000 -0700
@@ -323,8 +323,20 @@
 #define __NR_faccessat		298
 #define __NR_get_robust_list	299
 #define __NR_set_robust_list	300
+#define __NR_pfm_create_context	301
+#define __NR_pfm_write_pmcs	(__NR_pfm_create_context+1)
+#define __NR_pfm_write_pmds	(__NR_pfm_create_context+2)
+#define __NR_pfm_read_pmds	(__NR_pfm_create_context+3)
+#define __NR_pfm_load_context	(__NR_pfm_create_context+4)
+#define __NR_pfm_start		(__NR_pfm_create_context+5)
+#define __NR_pfm_stop		(__NR_pfm_create_context+6)
+#define __NR_pfm_restart	(__NR_pfm_create_context+7)
+#define __NR_pfm_create_evtsets	(__NR_pfm_create_context+8)
+#define __NR_pfm_getinfo_evtsets (__NR_pfm_create_context+9)
+#define __NR_pfm_delete_evtsets (__NR_pfm_create_context+10)
+#define __NR_pfm_unload_context	(__NR_pfm_create_context+11)
 
-#define __NR_syscalls		301
+#define __NR_syscalls		312
 
 #ifdef __KERNEL__
 #define __NR__exit __NR_exit
