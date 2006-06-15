Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWFOJPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWFOJPi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 05:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWFOJPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 05:15:09 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:29146 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932415AbWFOJPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 05:15:04 -0400
Date: Thu, 15 Jun 2006 02:07:31 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200606150907.k5F97VMK008094@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/16] 2.6.17-rc6 perfmon2 patch for review: modified generic files
Cc: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains all the modified generic files.




diff -ur --exclude-from=/tmp/excl323292 linux-2.6.17-rc6.orig/Makefile linux-2.6.17-rc6/Makefile
--- linux-2.6.17-rc6.orig/Makefile	2006-06-08 01:42:30.000000000 -0700
+++ linux-2.6.17-rc6/Makefile	2006-06-08 01:49:37.000000000 -0700
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 17
-EXTRAVERSION =-rc6
+EXTRAVERSION =-rc6-perfmon2
 NAME=Crazed Snow-Weasel
 
 # *DOCUMENTATION*
@@ -518,7 +518,7 @@
 
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/
+core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/ perfmon/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
Only in linux-2.6.17-rc6/include/linux: perfmon.h
Only in linux-2.6.17-rc6/include/linux: perfmon_dfl_smpl.h
Only in linux-2.6.17-rc6/include/linux: perfmon_fmt.h
Only in linux-2.6.17-rc6/include/linux: perfmon_kernel.h
Only in linux-2.6.17-rc6/include/linux: perfmon_pmu.h
diff -ur --exclude-from=/tmp/excl323292 linux-2.6.17-rc6.orig/include/linux/sched.h linux-2.6.17-rc6/include/linux/sched.h
--- linux-2.6.17-rc6.orig/include/linux/sched.h	2006-06-08 01:42:36.000000000 -0700
+++ linux-2.6.17-rc6/include/linux/sched.h	2006-06-08 01:49:22.000000000 -0700
@@ -40,6 +40,7 @@
 #include <linux/auxvec.h>	/* For AT_VECTOR_SIZE */
 
 struct exec_domain;
+struct pfm_context;
 
 /*
  * cloning flags:
@@ -888,6 +889,10 @@
 	 * cache last used pipe for splice
 	 */
 	struct pipe_inode_info *splice_pipe;
+
+#ifdef CONFIG_PERFMON
+ 	struct pfm_context *pfm_context;
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
diff -ur --exclude-from=/tmp/excl323292 linux-2.6.17-rc6.orig/include/linux/syscalls.h linux-2.6.17-rc6/include/linux/syscalls.h
--- linux-2.6.17-rc6.orig/include/linux/syscalls.h	2006-06-08 01:42:36.000000000 -0700
+++ linux-2.6.17-rc6/include/linux/syscalls.h	2006-06-08 01:49:22.000000000 -0700
@@ -29,6 +29,13 @@
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
@@ -588,4 +595,27 @@
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
diff -ur --exclude-from=/tmp/excl323292 linux-2.6.17-rc6.orig/kernel/sched.c linux-2.6.17-rc6/kernel/sched.c
--- linux-2.6.17-rc6.orig/kernel/sched.c	2006-06-08 01:42:36.000000000 -0700
+++ linux-2.6.17-rc6/kernel/sched.c	2006-06-08 01:49:22.000000000 -0700
@@ -50,6 +50,7 @@
 #include <linux/times.h>
 #include <linux/acct.h>
 #include <linux/kprobes.h>
+#include <linux/perfmon.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
diff -ur --exclude-from=/tmp/excl323292 linux-2.6.17-rc6.orig/kernel/sys_ni.c linux-2.6.17-rc6/kernel/sys_ni.c
--- linux-2.6.17-rc6.orig/kernel/sys_ni.c	2006-06-08 01:42:36.000000000 -0700
+++ linux-2.6.17-rc6/kernel/sys_ni.c	2006-06-08 01:49:22.000000000 -0700
@@ -111,6 +111,19 @@
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
diff -ur --exclude-from=/tmp/excl323292 linux-2.6.17-rc6.orig/lib/Makefile linux-2.6.17-rc6/lib/Makefile
--- linux-2.6.17-rc6.orig/lib/Makefile	2006-06-08 01:42:36.000000000 -0700
+++ linux-2.6.17-rc6/lib/Makefile	2006-06-08 01:49:22.000000000 -0700
@@ -5,7 +5,7 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o carta_random32.o
 
 lib-$(CONFIG_SMP) += cpumask.o
 
Only in linux-2.6.17-rc6/lib: carta_random32.c
Only in linux-2.6.17-rc6: perfmon
