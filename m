Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932895AbWJIOQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932895AbWJIOQE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932890AbWJIOPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:15:37 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:61695 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932874AbWJIOLc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:11:32 -0400
Date: Mon, 9 Oct 2006 07:10:25 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200610091410.k99EAORY026218@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 17/21] 2.6.18 perfmon2 : modified powerpc files
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the modified powerpc files.


The modified files are as follows:

arch/powerpc/Kconfig:
	- add link to perfmon menuconfig options

arch/powerpc/Makefile:
	- add perfmon subdir

arch/powerpc/kernel/entry_64.S:
	- add hook for extra work before kernel exit. Need to block a thread after a overflow with
	  user level notification. Also needed to do some bookeeeping, such as reset certain counters
	  and cleanup in some difficult corner cases

arch/powerpc/kernel/process.c:
	- add hook in exit_thread() to cleanup perfmon2 context
	- add hook in copy_thread() to cleanup perfmon2 context in child (perfmon2 context
	  is never inherited)
	- add hook in __switch_to() for PMU state save/restore

arch/powerpc/kernel/systbl.S:
	- add new system calls definitions

include/asm-powerpc/thread_info.h:
	- add TIF_PERFMON which is used for PMU context switching in __switch_to()

include/asm-powerpc/unistd.h:
	- add new system calls




diff -urp linux-2.6.18.base/arch/powerpc/Kconfig linux-2.6.18/arch/powerpc/Kconfig
--- linux-2.6.18.base/arch/powerpc/Kconfig	2006-09-21 23:45:09.000000000 -0700
+++ linux-2.6.18/arch/powerpc/Kconfig	2006-09-22 01:58:48.000000000 -0700
@@ -320,6 +320,9 @@ config NOT_COHERENT_CACHE
 	bool
 	depends on 4xx || 8xx || E200
 	default y
+
+source "arch/powerpc/perfmon/Kconfig"
+
 endmenu
 
 source "init/Kconfig"
diff -urp linux-2.6.18.base/arch/powerpc/Makefile linux-2.6.18/arch/powerpc/Makefile
--- linux-2.6.18.base/arch/powerpc/Makefile	2006-09-21 23:45:09.000000000 -0700
+++ linux-2.6.18/arch/powerpc/Makefile	2006-09-22 01:58:48.000000000 -0700
@@ -134,6 +134,7 @@ core-y				+= arch/powerpc/kernel/ \
 				   arch/powerpc/platforms/
 core-$(CONFIG_MATH_EMULATION)	+= arch/powerpc/math-emu/
 core-$(CONFIG_XMON)		+= arch/powerpc/xmon/
+core-$(CONFIG_PERFMON)		+= arch/powerpc/perfmon/
 
 drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 
diff -urp linux-2.6.18.base/arch/powerpc/kernel/entry_64.S linux-2.6.18/arch/powerpc/kernel/entry_64.S
--- linux-2.6.18.base/arch/powerpc/kernel/entry_64.S	2006-09-21 23:45:09.000000000 -0700
+++ linux-2.6.18/arch/powerpc/kernel/entry_64.S	2006-09-22 01:58:48.000000000 -0700
@@ -568,6 +568,9 @@ user_work:
 	b	.ret_from_except_lite
 
 1:	bl	.save_nvgprs
+#ifdef CONFIG_PERFMON
+	bl	.ppc64_pfm_handle_work
+#endif /* CONFIG_PERFMON */
 	li	r3,0
 	addi	r4,r1,STACK_FRAME_OVERHEAD
 	bl	.do_signal
diff -urp linux-2.6.18.base/arch/powerpc/kernel/process.c linux-2.6.18/arch/powerpc/kernel/process.c
--- linux-2.6.18.base/arch/powerpc/kernel/process.c	2006-09-21 23:45:09.000000000 -0700
+++ linux-2.6.18/arch/powerpc/kernel/process.c	2006-09-22 01:58:48.000000000 -0700
@@ -34,6 +34,7 @@
 #include <linux/mqueue.h>
 #include <linux/hardirq.h>
 #include <linux/utsname.h>
+#include <linux/perfmon.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -325,6 +326,9 @@ struct task_struct *__switch_to(struct t
 		new_thread->start_tb = current_tb;
 	}
 #endif
+	if (test_tsk_thread_flag(new, TIF_PERFMON_CTXSW)
+	    || test_tsk_thread_flag(prev, TIF_PERFMON_CTXSW))
+		pfm_ctxsw(prev, new);
 
 	local_irq_save(flags);
 
@@ -464,6 +468,7 @@ void show_regs(struct pt_regs * regs)
 void exit_thread(void)
 {
 	discard_lazy_cpu_state();
+	pfm_exit_thread(current);
 }
 
 void flush_thread(void)
@@ -575,6 +580,7 @@ int copy_thread(int nr, unsigned long cl
 	kregs->nip = (unsigned long)ret_from_fork;
 	p->thread.last_syscall = -1;
 #endif
+	pfm_copy_thread(p);
 
 	return 0;
 }
Only in linux-2.6.18/arch/powerpc: perfmon
Only in linux-2.6.18/include/asm-powerpc: perfmon.h
diff -urp linux-2.6.18.base/include/asm-powerpc/systbl.h linux-2.6.18/include/asm-powerpc/systbl.h
--- linux-2.6.18.base/include/asm-powerpc/systbl.h	2006-09-21 23:45:36.000000000 -0700
+++ linux-2.6.18/include/asm-powerpc/systbl.h	2006-09-22 02:27:07.000000000 -0700
@@ -304,3 +304,15 @@ SYSCALL_SPU(fchmodat)
 SYSCALL_SPU(faccessat)
 COMPAT_SYS_SPU(get_robust_list)
 COMPAT_SYS_SPU(set_robust_list)
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
diff -urp linux-2.6.18.base/include/asm-powerpc/thread_info.h linux-2.6.18/include/asm-powerpc/thread_info.h
--- linux-2.6.18.base/include/asm-powerpc/thread_info.h	2006-09-21 23:45:36.000000000 -0700
+++ linux-2.6.18/include/asm-powerpc/thread_info.h	2006-09-22 01:58:48.000000000 -0700
@@ -122,6 +122,8 @@ static inline struct thread_info *curren
 #define TIF_RESTOREALL		12	/* Restore all regs (implies NOERROR) */
 #define TIF_NOERROR		14	/* Force successful syscall return */
 #define TIF_RESTORE_SIGMASK	15	/* Restore signal mask in do_signal */
+#define TIF_PERFMON_WORK	10	/* work for pfm_handle_work() */
+#define TIF_PERFMON_CTXSW	20	/* perfmon needs ctxsw calls */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -139,9 +141,12 @@ static inline struct thread_info *curren
 #define _TIF_NOERROR		(1<<TIF_NOERROR)
 #define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
 #define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP)
+#define _TIF_PERFMON_WORK	(1<<TIF_PERFMON_WORK)
+#define _TIF_PERFMON_CTXSW	(1<<TIF_PERFMON_CTXSW)
 
 #define _TIF_USER_WORK_MASK	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | \
-				 _TIF_NEED_RESCHED | _TIF_RESTORE_SIGMASK)
+				 _TIF_NEED_RESCHED | _TIF_RESTORE_SIGMASK | \
+				 _TIF_PERFMON_WORK)
 #define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR)
 
 /* Bits in local_flags */
diff -urp linux-2.6.18.base/include/asm-powerpc/unistd.h linux-2.6.18/include/asm-powerpc/unistd.h
--- linux-2.6.18.base/include/asm-powerpc/unistd.h	2006-09-21 23:45:36.000000000 -0700
+++ linux-2.6.18/include/asm-powerpc/unistd.h	2006-09-22 02:04:28.000000000 -0700
@@ -323,10 +323,22 @@
 #define __NR_faccessat		298
 #define __NR_get_robust_list	299
 #define __NR_set_robust_list	300
-
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
+ 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		301
+#define __NR_syscalls		312
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
