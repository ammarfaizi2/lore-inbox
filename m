Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWELQkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWELQkl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 12:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWELQkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 12:40:24 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:25999 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932152AbWELQkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 12:40:11 -0400
Date: Fri, 12 May 2006 09:33:50 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200605121633.k4CGXofF027370@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 9/11] perfmon2 patch for review: modified powerpc files
Cc: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the modified files for powerpc.




diff -ur linux-2.6.17-rc4.orig/arch/powerpc/Kconfig linux-2.6.17-rc4/arch/powerpc/Kconfig
--- linux-2.6.17-rc4.orig/arch/powerpc/Kconfig	2006-05-12 03:16:10.000000000 -0700
+++ linux-2.6.17-rc4/arch/powerpc/Kconfig	2006-05-12 03:18:52.000000000 -0700
@@ -299,6 +299,18 @@
 	bool
 	depends on 4xx || 8xx || E200
 	default y
+
+menu "Hardware Performance Monitoring support"
+config PERFMON
+	bool "Perfmon2 performance monitoring interface"
+	default y
+	help
+	include the perfmon2 performance monitoring interface
+	in the kernel.  See <http://www.hpl.hp.com/research/linux/perfmon> for
+	more details.  If you're unsure, say Y.
+source "arch/powerpc/perfmon/Kconfig"
+endmenu
+
 endmenu
 
 source "init/Kconfig"
diff -ur linux-2.6.17-rc4.orig/arch/powerpc/Makefile linux-2.6.17-rc4/arch/powerpc/Makefile
--- linux-2.6.17-rc4.orig/arch/powerpc/Makefile	2006-05-12 03:16:10.000000000 -0700
+++ linux-2.6.17-rc4/arch/powerpc/Makefile	2006-05-12 03:18:52.000000000 -0700
@@ -135,6 +135,7 @@
 				   arch/powerpc/platforms/
 core-$(CONFIG_MATH_EMULATION)	+= arch/powerpc/math-emu/
 core-$(CONFIG_XMON)		+= arch/powerpc/xmon/
+core-$(CONFIG_PERFMON)		+= arch/powerpc/perfmon/
 
 drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 
diff -ur linux-2.6.17-rc4.orig/arch/powerpc/kernel/entry_64.S linux-2.6.17-rc4/arch/powerpc/kernel/entry_64.S
--- linux-2.6.17-rc4.orig/arch/powerpc/kernel/entry_64.S	2006-05-12 03:16:10.000000000 -0700
+++ linux-2.6.17-rc4/arch/powerpc/kernel/entry_64.S	2006-05-12 03:18:52.000000000 -0700
@@ -569,6 +569,9 @@
 	b	.ret_from_except_lite
 
 1:	bl	.save_nvgprs
+#ifdef CONFIG_PERFMON
+	bl	.ppc64_pfm_handle_work
+#endif /* CONFIG_PERFMON */
 	li	r3,0
 	addi	r4,r1,STACK_FRAME_OVERHEAD
 	bl	.do_signal
diff -ur linux-2.6.17-rc4.orig/arch/powerpc/kernel/process.c linux-2.6.17-rc4/arch/powerpc/kernel/process.c
--- linux-2.6.17-rc4.orig/arch/powerpc/kernel/process.c	2006-05-12 03:16:10.000000000 -0700
+++ linux-2.6.17-rc4/arch/powerpc/kernel/process.c	2006-05-12 03:18:52.000000000 -0700
@@ -35,6 +35,7 @@
 #include <linux/mqueue.h>
 #include <linux/hardirq.h>
 #include <linux/utsname.h>
+#include <linux/perfmon.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -465,6 +466,7 @@
 void exit_thread(void)
 {
 	discard_lazy_cpu_state();
+	pfm_exit_thread(current);
 }
 
 void flush_thread(void)
@@ -576,6 +578,7 @@
 	kregs->nip = (unsigned long)ret_from_fork;
 	p->thread.last_syscall = -1;
 #endif
+	pfm_copy_thread(p, childregs);
 
 	return 0;
 }
diff -ur linux-2.6.17-rc4.orig/arch/powerpc/kernel/systbl.S linux-2.6.17-rc4/arch/powerpc/kernel/systbl.S
--- linux-2.6.17-rc4.orig/arch/powerpc/kernel/systbl.S	2006-05-12 03:16:10.000000000 -0700
+++ linux-2.6.17-rc4/arch/powerpc/kernel/systbl.S	2006-05-12 03:20:18.000000000 -0700
@@ -338,6 +338,18 @@
 SYSCALL(readlinkat)
 SYSCALL(fchmodat)
 SYSCALL(faccessat)
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
 
 /*
  * please add new calls to arch/powerpc/platforms/cell/spu_callbacks.c
diff -ur linux-2.6.17-rc4.orig/include/asm-powerpc/processor.h linux-2.6.17-rc4/include/asm-powerpc/processor.h
--- linux-2.6.17-rc4.orig/include/asm-powerpc/processor.h	2006-05-12 03:16:14.000000000 -0700
+++ linux-2.6.17-rc4/include/asm-powerpc/processor.h	2006-05-12 03:18:52.000000000 -0700
@@ -169,6 +169,7 @@
 	unsigned long	spefscr;	/* SPE & eFP status */
 	int		used_spe;	/* set if process has used spe */
 #endif /* CONFIG_SPE */
+	void *pfm_context;
 };
 
 #define ARCH_MIN_TASKALIGN 16
diff -ur linux-2.6.17-rc4.orig/include/asm-powerpc/unistd.h linux-2.6.17-rc4/include/asm-powerpc/unistd.h
--- linux-2.6.17-rc4.orig/include/asm-powerpc/unistd.h	2006-05-12 03:16:14.000000000 -0700
+++ linux-2.6.17-rc4/include/asm-powerpc/unistd.h	2006-05-12 03:23:11.000000000 -0700
@@ -321,8 +321,20 @@
 #define __NR_readlinkat		296
 #define __NR_fchmodat		297
 #define __NR_faccessat		298
-
-#define __NR_syscalls		299
+#define __NR_pfm_create_context	299
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
+ 
+#define __NR_syscalls		310
 
 #ifdef __KERNEL__
 #define __NR__exit __NR_exit
