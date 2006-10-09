Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932904AbWJIOLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932904AbWJIOLY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932861AbWJIOK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:10:56 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:28657 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932857AbWJIOKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:10:52 -0400
Date: Mon, 9 Oct 2006 07:10:08 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200610091410.k99EA8lZ026010@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 01/21] 2.6.18 perfmon2 : generic kernel modifications
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains all the modified generic files:

linux/Makefile:
	- create our own EXTRAVERSION

linux/include/linux/sched.h:
	- add pfm_context pointer to struct task_struct. This is used
	  to connect a perfmon2 context to a task when doing per-thread
	  monitoring.

linux/include/linux/syscalls.h:
	- declare prototypes of our new system calls


linux/kernel/sched.c:
	- add include perfmon.h to ensure pfm_ctxsw() has a defined prototype

linux/kernel/sys_ni.c:
	- add perfmon2 cond_syscall() definitions (when CONFIG_PERFMON is off)





diff -urp --exclude-from=/tmp/excl319979 linux-2.6.18.base/Makefile linux-2.6.18/Makefile
--- linux-2.6.18.base/Makefile	2006-09-21 23:45:08.000000000 -0700
+++ linux-2.6.18/Makefile	2006-09-22 05:47:31.000000000 -0700
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 18
-EXTRAVERSION =
+EXTRAVERSION = -perfmon2
 NAME=Avast! A bilge rat!
 
 # *DOCUMENTATION*
@@ -552,7 +552,7 @@ export mod_strip_cmd
 
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/
+core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/ perfmon/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
Only in linux-2.6.18/include/linux: perfmon.h
Only in linux-2.6.18/include/linux: perfmon_dfl_smpl.h
Only in linux-2.6.18/include/linux: perfmon_fmt.h
Only in linux-2.6.18/include/linux: perfmon_kernel.h
Only in linux-2.6.18/include/linux: perfmon_pmu.h
diff -urp --exclude-from=/tmp/excl319979 linux-2.6.18.base/include/linux/sched.h linux-2.6.18/include/linux/sched.h
--- linux-2.6.18.base/include/linux/sched.h	2006-09-21 23:45:40.000000000 -0700
+++ linux-2.6.18/include/linux/sched.h	2006-09-22 02:12:02.000000000 -0700
@@ -85,6 +85,7 @@ struct sched_param {
 
 struct exec_domain;
 struct futex_pi_state;
+struct pfm_context;
 
 /*
  * List of flags we want to share for kernel threads,
@@ -996,6 +997,9 @@ struct task_struct {
 #ifdef	CONFIG_TASK_DELAY_ACCT
 	struct task_delay_info *delays;
 #endif
+#ifdef CONFIG_PERFMON
+	struct pfm_context *pfm_context;
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
diff -urp --exclude-from=/tmp/excl319979 linux-2.6.18.base/include/linux/syscalls.h linux-2.6.18/include/linux/syscalls.h
--- linux-2.6.18.base/include/linux/syscalls.h	2006-09-21 23:45:40.000000000 -0700
+++ linux-2.6.18/include/linux/syscalls.h	2006-09-22 01:58:48.000000000 -0700
@@ -29,6 +29,13 @@ struct msqid_ds;
 struct new_utsname;
 struct nfsctl_arg;
 struct __old_kernel_stat;
+struct pfarg_ctx;
+struct pfarg_pmc;
+struct pfarg_pmd;
+struct pfarg_start;
+struct pfarg_load;
+struct pfarg_setinfo;
+struct pfarg_setdesc;
 struct pollfd;
 struct rlimit;
 struct rusage;
@@ -597,4 +604,27 @@ asmlinkage long sys_get_robust_list(int 
 asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 				    size_t len);
 
+asmlinkage long sys_pfm_create_context(struct pfarg_ctx __user *ureq,
+				       void __user *uarg, size_t smpl_size);
+asmlinkage long sys_pfm_write_pmcs(int fd, struct pfarg_pmc __user *ureq,
+				   int count);
+asmlinkage long sys_pfm_write_pmds(int fd, struct pfarg_pmd __user *ureq,
+				   int count);
+asmlinkage long sys_pfm_read_pmds(int fd, struct pfarg_pmd __user *ureq,
+				  int count);
+asmlinkage long sys_pfm_restart(int fd);
+asmlinkage long sys_pfm_stop(int fd);
+asmlinkage long sys_pfm_start(int fd, struct pfarg_start __user *ureq);
+asmlinkage long sys_pfm_load_context(int fd, struct pfarg_load __user *ureq);
+asmlinkage long sys_pfm_unload_context(int fd);
+asmlinkage long sys_pfm_delete_evtsets(int fd,
+				       struct pfarg_setinfo __user *ureq,
+				       int count);
+asmlinkage long sys_pfm_create_evtsets(int fd,
+				       struct pfarg_setdesc __user *ureq,
+				       int count);
+asmlinkage long sys_pfm_getinfo_evtsets(int fd,
+					struct pfarg_setinfo __user *ureq,
+					int count);
+
 #endif
diff -urp --exclude-from=/tmp/excl319979 linux-2.6.18.base/kernel/ptrace.c linux-2.6.18/kernel/ptrace.c
--- linux-2.6.18.base/kernel/ptrace.c	2006-09-21 23:45:41.000000000 -0700
+++ linux-2.6.18/kernel/ptrace.c	2006-09-25 07:19:53.000000000 -0700
@@ -113,7 +113,6 @@ int ptrace_check_attach(struct task_stru
 	if (!ret && !kill) {
 		wait_task_inactive(child);
 	}
-
 	/* All systems go.. */
 	return ret;
 }
diff -urp --exclude-from=/tmp/excl319979 linux-2.6.18.base/kernel/sched.c linux-2.6.18/kernel/sched.c
--- linux-2.6.18.base/kernel/sched.c	2006-09-21 23:45:41.000000000 -0700
+++ linux-2.6.18/kernel/sched.c	2006-09-22 02:45:28.000000000 -0700
@@ -52,6 +52,7 @@
 #include <linux/acct.h>
 #include <linux/kprobes.h>
 #include <linux/delayacct.h>
+#include <linux/perfmon.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
diff -urp --exclude-from=/tmp/excl319979 linux-2.6.18.base/kernel/sys_ni.c linux-2.6.18/kernel/sys_ni.c
--- linux-2.6.18.base/kernel/sys_ni.c	2006-09-21 23:45:41.000000000 -0700
+++ linux-2.6.18/kernel/sys_ni.c	2006-09-22 01:58:48.000000000 -0700
@@ -112,6 +112,19 @@ cond_syscall(sys_vm86);
 cond_syscall(compat_sys_ipc);
 cond_syscall(compat_sys_sysctl);
 
+cond_syscall(sys_pfm_create_context);
+cond_syscall(sys_pfm_write_pmcs);
+cond_syscall(sys_pfm_write_pmds);
+cond_syscall(sys_pfm_read_pmds);
+cond_syscall(sys_pfm_restart);
+cond_syscall(sys_pfm_start);
+cond_syscall(sys_pfm_stop);
+cond_syscall(sys_pfm_load_context);
+cond_syscall(sys_pfm_unload_context);
+cond_syscall(sys_pfm_create_evtsets);
+cond_syscall(sys_pfm_delete_evtsets);
+cond_syscall(sys_pfm_getinfo_evtsets);
+ 
 /* arch-specific weak syscall entries */
 cond_syscall(sys_pciconfig_read);
 cond_syscall(sys_pciconfig_write);
diff -urp --exclude-from=/tmp/excl319979 linux-2.6.18.base/lib/Makefile linux-2.6.18/lib/Makefile
--- linux-2.6.18.base/lib/Makefile	2006-09-21 23:45:41.000000000 -0700
+++ linux-2.6.18/lib/Makefile	2006-09-22 01:58:48.000000000 -0700
@@ -5,7 +5,7 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o carta_random32.o
 
 lib-$(CONFIG_SMP) += cpumask.o
 
Only in linux-2.6.18/lib: carta_random32.c
Only in linux-2.6.18: perfmon
