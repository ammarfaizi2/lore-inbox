Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWHWIQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWHWIQB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWHWIQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:16:01 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:9469 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932383AbWHWIP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:15:59 -0400
Date: Wed, 23 Aug 2006 01:05:53 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200608230805.k7N85rpj000360@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/18] 2.6.17.9 perfmon2 patch for review: generic kernel modifications
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





diff -urp --exclude-from=/tmp/excl31584 linux-2.6.17.9.base/Makefile linux-2.6.17.9/Makefile
--- linux-2.6.17.9.base/Makefile	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/Makefile	2006-08-21 03:37:57.000000000 -0700
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 17
-EXTRAVERSION = .9
+EXTRAVERSION = .9-perfmon2
 NAME=Crazed Snow-Weasel
 
 # *DOCUMENTATION*
@@ -518,7 +518,7 @@ export MODLIB
 
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/
+core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/ perfmon/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
Only in linux-2.6.17.9/include/linux: perfmon.h
Only in linux-2.6.17.9/include/linux: perfmon_dfl_smpl.h
Only in linux-2.6.17.9/include/linux: perfmon_fmt.h
Only in linux-2.6.17.9/include/linux: perfmon_kernel.h
Only in linux-2.6.17.9/include/linux: perfmon_pmu.h
diff -urp --exclude-from=/tmp/excl31584 linux-2.6.17.9.base/include/linux/sched.h linux-2.6.17.9/include/linux/sched.h
--- linux-2.6.17.9.base/include/linux/sched.h	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/include/linux/sched.h	2006-08-21 03:37:45.000000000 -0700
@@ -40,6 +40,7 @@
 #include <linux/auxvec.h>	/* For AT_VECTOR_SIZE */
 
 struct exec_domain;
+struct pfm_context;
 
 /*
  * cloning flags:
@@ -888,6 +889,10 @@ struct task_struct {
 	 * cache last used pipe for splice
 	 */
 	struct pipe_inode_info *splice_pipe;
+
+#ifdef CONFIG_PERFMON
+ 	struct pfm_context *pfm_context;
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
diff -urp --exclude-from=/tmp/excl31584 linux-2.6.17.9.base/include/linux/syscalls.h linux-2.6.17.9/include/linux/syscalls.h
--- linux-2.6.17.9.base/include/linux/syscalls.h	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/include/linux/syscalls.h	2006-08-21 03:37:45.000000000 -0700
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
@@ -588,4 +595,27 @@ asmlinkage long sys_get_robust_list(int 
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
diff -urp --exclude-from=/tmp/excl31584 linux-2.6.17.9.base/kernel/sched.c linux-2.6.17.9/kernel/sched.c
--- linux-2.6.17.9.base/kernel/sched.c	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/kernel/sched.c	2006-08-22 05:39:51.000000000 -0700
@@ -50,6 +50,7 @@
 #include <linux/times.h>
 #include <linux/acct.h>
 #include <linux/kprobes.h>
+#include <linux/perfmon.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
diff -urp --exclude-from=/tmp/excl31584 linux-2.6.17.9.base/kernel/sys_ni.c linux-2.6.17.9/kernel/sys_ni.c
--- linux-2.6.17.9.base/kernel/sys_ni.c	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/kernel/sys_ni.c	2006-08-21 03:37:45.000000000 -0700
@@ -111,6 +111,19 @@ cond_syscall(sys_vm86);
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

