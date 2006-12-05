Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968114AbWLELHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968114AbWLELHZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 06:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967999AbWLELHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 06:07:25 -0500
Received: from gundega.hpl.hp.com ([192.6.19.190]:59798 "EHLO
	gundega.hpl.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968114AbWLELHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 06:07:23 -0500
Date: Tue, 5 Dec 2006 03:07:02 -0800
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200612051107.kB5B72gD017482@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 02/21] 2.6.19 perfmon2 : generic kernel modifications
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains all the modified generic files:

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





diff --exclude=.git -urp --exclude-from=/tmp/excl37722 linux-2.6.19.base/Makefile linux-2.6.19/Makefile
--- linux-2.6.19.base/Makefile	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/Makefile	2006-12-03 14:15:47.000000000 -0800
@@ -559,7 +559,7 @@ export mod_strip_cmd
 
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/
+core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/ perfmon/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
Only in linux-2.6.19/include/linux: perfmon.h
Only in linux-2.6.19/include/linux: perfmon_dfl_smpl.h
Only in linux-2.6.19/include/linux: perfmon_fmt.h
Only in linux-2.6.19/include/linux: perfmon_pmu.h
diff --exclude=.git -urp --exclude-from=/tmp/excl37722 linux-2.6.19.base/include/linux/sched.h linux-2.6.19/include/linux/sched.h
--- linux-2.6.19.base/include/linux/sched.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/include/linux/sched.h	2006-12-03 14:15:47.000000000 -0800
@@ -87,6 +87,7 @@ struct sched_param {
 
 struct exec_domain;
 struct futex_pi_state;
+struct pfm_context;
 
 /*
  * List of flags we want to share for kernel threads,
@@ -1023,6 +1024,9 @@ struct task_struct {
 #ifdef	CONFIG_TASK_DELAY_ACCT
 	struct task_delay_info *delays;
 #endif
+#ifdef CONFIG_PERFMON
+	struct pfm_context *pfm_context;
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
diff --exclude=.git -urp --exclude-from=/tmp/excl37722 linux-2.6.19.base/include/linux/syscalls.h linux-2.6.19/include/linux/syscalls.h
--- linux-2.6.19.base/include/linux/syscalls.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/include/linux/syscalls.h	2006-12-03 14:15:47.000000000 -0800
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
@@ -605,4 +612,27 @@ asmlinkage long sys_getcpu(unsigned __us
 
 int kernel_execve(const char *filename, char *const argv[], char *const envp[]);
 
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
diff --exclude=.git -urp --exclude-from=/tmp/excl37722 linux-2.6.19.base/kernel/sched.c linux-2.6.19/kernel/sched.c
--- linux-2.6.19.base/kernel/sched.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/kernel/sched.c	2006-12-03 14:15:47.000000000 -0800
@@ -52,6 +52,7 @@
 #include <linux/tsacct_kern.h>
 #include <linux/kprobes.h>
 #include <linux/delayacct.h>
+#include <linux/perfmon.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
diff --exclude=.git -urp --exclude-from=/tmp/excl37722 linux-2.6.19.base/kernel/sys_ni.c linux-2.6.19/kernel/sys_ni.c
--- linux-2.6.19.base/kernel/sys_ni.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/kernel/sys_ni.c	2006-12-03 14:15:47.000000000 -0800
@@ -113,6 +113,19 @@ cond_syscall(sys_vm86);
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
Only in linux-2.6.19: perfmon
