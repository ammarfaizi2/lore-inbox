Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129517AbRCHUU3>; Thu, 8 Mar 2001 15:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbRCHUUR>; Thu, 8 Mar 2001 15:20:17 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:60540 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129667AbRCHUSi>; Thu, 8 Mar 2001 15:18:38 -0500
Message-Id: <200103082018.OAA00191@kenobi.americas.sgi.com>
To: linux-kernel@vger.kernel.org
From: kohnke@sgi.com (Marlys Kohnke)
Subject: PATCH [2.4.2] - CSA Job Accounting Infrastructure
Date: Thu, 08 Mar 2001 14:18:04 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch (linux-2.4.2-csa.patch) applies against the 2.4.2 kernel
with the PAGG linux-2.4.2-pagg.patch and linux-2.4.2-pagg-job.patch
patches applied first.  This CSA patch supports i386 and
ia64 platforms.

The patch provides the infrastructure to do CSA job accounting.
A new configuration variable, CONFIG_CSA_JOB_ACCT, has been
defined.  Additional I/O and memory resource usage counters were
added to the task struct and mm struct:

- number of characters read/written
- number of blocks read/written
- number of read/write syscalls
- block i/o wait time
- physical and virtual memory highwater values
- memory integrals (amount of memory used over cpu time)

A new system call has been added which provides functions to check
the status of job accounting; start and stop process, daemon and
record accounting; define thresholds for cpu and memory usage below which
records won't be written; start and stop user job accounting; and
write daemon accounting records.

I will send another patch in a following email which contains
the code which handles the CSA configuration and record
writing.  That code can be compiled as a module.  That patch
is linux-2.4.2-csa_module.patch.

For further information about CSA job accounting, please read
the overview and kernel changes documents available at
oss.sgi.com/projects/csa.  There is a download link at
that site to get the CSA kernel patches, commands packages
in rpm and tarball format, and an Admin Guide.

For further information about PAGG and jobs, please see the
oss.sgi.com/projects/pagg web site.

----
Marlys Kohnke			Silicon Graphics Inc.
kohnke@sgi.com			655F Lone Oak Drive
(651)683-5324			Eagan, MN 55121


linux-2.4.2-csa.patch follows:
------------------------------------------------------------------------------------

diff -urN linux-2.4.2.orig+pagg-patch/Documentation/Configure.help linux-2.4.2.csa+csa-patch/Documentation/Configure.help
--- linux-2.4.2.orig+pagg-patch/Documentation/Configure.help	Mon Mar  5 11:19:16 2001
+++ linux-2.4.2.csa+csa-patch/Documentation/Configure.help	Mon Mar  5 11:22:24 2001
@@ -2749,6 +2749,23 @@
   user level program to do useful things with this information. This
   is generally a good idea, so say Y.
   
+CSA Job Accounting
+CONFIG_CSA_JOB_ACCT
+  Comprehensive System Accounting (CSA) provides job level accounting
+  of resource usage.  The accounting records are written by the
+  kernel into a file.  CSA user level scripts and commands process
+  the binary accounting records and combine them by job identifier
+  within system boot uptime periods.  These accounting records are
+  then used to produce reports and charge fees to users.
+
+  Say Y here if you want job level accounting to be done by the
+  kernel.  The CSA module needs to be loaded to write the
+  accounting records to a file.  The CSA commands and scripts
+  package needs to be installed to process the CSA accounting
+  records.  See http://oss.sgi.com/projects/csa for further
+  information about CSA and download instructions for the CSA
+  module and commands package.
+
 Sysctl support
 CONFIG_SYSCTL
   The sysctl interface provides a means of dynamically changing
diff -urN linux-2.4.2.orig+pagg-patch/arch/i386/config.in linux-2.4.2.csa+csa-patch/arch/i386/config.in
--- linux-2.4.2.orig+pagg-patch/arch/i386/config.in	Mon Mar  5 11:19:16 2001
+++ linux-2.4.2.csa+csa-patch/arch/i386/config.in	Mon Mar  5 11:22:24 2001
@@ -217,6 +217,7 @@
 
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
+bool 'CSA Job Accounting' CONFIG_CSA_JOB_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
 bool 'Support for process aggregates (PAGGs)' CONFIG_PAGG
 if [ "$CONFIG_PAGG" = "y" ] ; then
diff -urN linux-2.4.2.orig+pagg-patch/arch/i386/kernel/entry.S linux-2.4.2.csa+csa-patch/arch/i386/kernel/entry.S
--- linux-2.4.2.orig+pagg-patch/arch/i386/kernel/entry.S	Mon Mar  5 11:18:56 2001
+++ linux-2.4.2.csa+csa-patch/arch/i386/kernel/entry.S	Mon Mar  5 11:22:24 2001
@@ -651,6 +651,11 @@
 #else
 	.long SYMBOL_NAME(sys_ni_syscall)
 #endif
+#if defined(CONFIG_CSA_JOB_ACCT) || defined(CONFIG_CSA_JOB_ACCT_MODULE)
+	.long SYMBOL_NAME(sys_acctctl)
+#else
+	.long SYMBOL_NAME(sys_ni_syscall)
+#endif
 
 
 	/*
diff -urN linux-2.4.2.orig+pagg-patch/arch/ia64/config.in linux-2.4.2.csa+csa-patch/arch/ia64/config.in
--- linux-2.4.2.orig+pagg-patch/arch/ia64/config.in	Mon Mar  5 11:19:16 2001
+++ linux-2.4.2.csa+csa-patch/arch/ia64/config.in	Mon Mar  5 11:22:24 2001
@@ -92,6 +92,7 @@
 bool 'Networking support' CONFIG_NET
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
+bool 'CSA Job Accounting' CONFIG_CSA_JOB_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
 bool 'Support for process aggregates (PAGGs)' CONFIG_PAGG
 if [ "$CONFIG_PAGG" = "y" ] ; then
diff -urN linux-2.4.2.orig+pagg-patch/arch/ia64/kernel/entry.S linux-2.4.2.csa+csa-patch/arch/ia64/kernel/entry.S
--- linux-2.4.2.orig+pagg-patch/arch/ia64/kernel/entry.S	Mon Mar  5 11:18:56 2001
+++ linux-2.4.2.csa+csa-patch/arch/ia64/kernel/entry.S	Mon Mar  5 11:22:24 2001
@@ -1252,7 +1252,11 @@
 #else
 	data8 ia64_ni_syscall			// 1215
 #endif
+#if defined(CONFIG_CSA_JOB_ACCT) || defined(CONFIG_CSA_JOB_ACCT_MODULE)
+	data8 sys_acctctl
+#else
 	data8 ia64_ni_syscall
+#endif
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
diff -urN linux-2.4.2.orig+pagg-patch/drivers/block/ll_rw_blk.c linux-2.4.2.csa+csa-patch/drivers/block/ll_rw_blk.c
--- linux-2.4.2.orig+pagg-patch/drivers/block/ll_rw_blk.c	Thu Feb 15 18:58:34 2001
+++ linux-2.4.2.csa+csa-patch/drivers/block/ll_rw_blk.c	Mon Mar  5 11:22:24 2001
@@ -489,6 +489,7 @@
 static struct request *__get_request_wait(request_queue_t *q, int rw)
 {
 	register struct request *rq;
+	unsigned long start_wait = jiffies;
 	DECLARE_WAITQUEUE(wait, current);
 
 	add_wait_queue_exclusive(&q->wait_for_request, &wait);
@@ -504,6 +505,7 @@
 	}
 	remove_wait_queue(&q->wait_for_request, &wait);
 	current->state = TASK_RUNNING;
+	current->bwtime += jiffies - start_wait;
 	return rq;
 }
 
@@ -558,9 +560,11 @@
 	if (rw == READ) {
 		kstat.dk_drive_rio[major][index] += new_io;
 		kstat.dk_drive_rblk[major][index] += nr_sectors;
+		current->rblk += nr_sectors;
 	} else if (rw == WRITE) {
 		kstat.dk_drive_wio[major][index] += new_io;
 		kstat.dk_drive_wblk[major][index] += nr_sectors;
+		current->wblk += nr_sectors;
 	} else
 		printk(KERN_ERR "drive_stat_acct: cmd not R/W?\n");
 }
diff -urN linux-2.4.2.orig+pagg-patch/fs/exec.c linux-2.4.2.csa+csa-patch/fs/exec.c
--- linux-2.4.2.orig+pagg-patch/fs/exec.c	Fri Feb  9 21:03:39 2001
+++ linux-2.4.2.csa+csa-patch/fs/exec.c	Mon Mar  5 11:22:24 2001
@@ -36,6 +36,7 @@
 #include <linux/spinlock.h>
 #define __NO_VERSION__
 #include <linux/module.h>
+#include <linux/csa_internal.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -886,9 +887,13 @@
 		goto out; 
 
 	retval = search_binary_handler(&bprm,regs);
-	if (retval >= 0)
+	if (retval >= 0) {
 		/* execve success */
+		/* no-op if CONFIG_CSA_JOB_ACCT not set */
+		csa_update_integrals();
+		update_mem_hiwater();
 		return retval;
+	}
 
 out:
 	/* Something went wrong, return the inode and free the argument pages*/
diff -urN linux-2.4.2.orig+pagg-patch/fs/read_write.c linux-2.4.2.csa+csa-patch/fs/read_write.c
--- linux-2.4.2.orig+pagg-patch/fs/read_write.c	Fri Feb  9 13:29:44 2001
+++ linux-2.4.2.csa+csa-patch/fs/read_write.c	Mon Mar  5 11:22:24 2001
@@ -129,8 +129,13 @@
 			if (!ret) {
 				ssize_t (*read)(struct file *, char *, size_t, loff_t *);
 				ret = -EINVAL;
-				if (file->f_op && (read = file->f_op->read) != NULL)
+				if (file->f_op && (read = file->f_op->read) != NULL) {
 					ret = read(file, buf, count, &file->f_pos);
+					if (ret > 0) {
+						current->rchar += ret;
+					}
+					current->syscr++;
+				}
 			}
 		}
 		if (ret > 0)
@@ -156,8 +161,13 @@
 			if (!ret) {
 				ssize_t (*write)(struct file *, const char *, size_t, loff_t *);
 				ret = -EINVAL;
-				if (file->f_op && (write = file->f_op->write) != NULL)
+				if (file->f_op && (write = file->f_op->write) != NULL) {
 					ret = write(file, buf, count, &file->f_pos);
+					if (ret > 0) {
+						current->wchar += ret;
+					}
+					current->syscw++;
+				}
 			}
 		}
 		if (ret > 0)
@@ -286,6 +296,10 @@
 	    (file->f_op->readv || file->f_op->read))
 		ret = do_readv_writev(VERIFY_WRITE, file, vector, count);
 	fput(file);
+	if (ret > 0) {
+		current->rchar += ret;
+	}
+	current->syscr++;
 
 bad_file:
 	return ret;
@@ -306,6 +320,10 @@
 	    (file->f_op->writev || file->f_op->write))
 		ret = do_readv_writev(VERIFY_READ, file, vector, count);
 	fput(file);
+	if (ret > 0) {
+		current->wchar += ret;
+	}
+	current->syscw++;
 
 bad_file:
 	return ret;
@@ -338,8 +356,11 @@
 	if (pos < 0)
 		goto out;
 	ret = read(file, buf, count, &pos);
-	if (ret > 0)
+	if (ret > 0) {
 		inode_dir_notify(file->f_dentry->d_parent->d_inode, DN_ACCESS);
+		current->rchar += ret;
+	}
+	current->syscr++;
 out:
 	fput(file);
 bad_file:
@@ -370,8 +391,11 @@
 		goto out;
 
 	ret = write(file, buf, count, &pos);
-	if (ret > 0)
+	if (ret > 0) {
 		inode_dir_notify(file->f_dentry->d_parent->d_inode, DN_MODIFY);
+		current->wchar += ret;
+	}
+	current->syscw++;
 out:
 	fput(file);
 bad_file:
diff -urN linux-2.4.2.orig+pagg-patch/include/asm-i386/unistd.h linux-2.4.2.csa+csa-patch/include/asm-i386/unistd.h
--- linux-2.4.2.orig+pagg-patch/include/asm-i386/unistd.h	Mon Mar  5 11:18:56 2001
+++ linux-2.4.2.csa+csa-patch/include/asm-i386/unistd.h	Mon Mar  5 11:22:24 2001
@@ -230,6 +230,9 @@
 #if defined(CONFIG_PAGG)
 #define __NR_paggctl          	223 
 #endif
+#if defined(CONFIG_CSA_JOB_ACCT) || defined(CONFIG_CSA_JOB_ACCT_MODULE)
+#define __NR_acctctl		224
+#endif
 
 
 
diff -urN linux-2.4.2.orig+pagg-patch/include/asm-ia64/unistd.h linux-2.4.2.csa+csa-patch/include/asm-ia64/unistd.h
--- linux-2.4.2.orig+pagg-patch/include/asm-ia64/unistd.h	Mon Mar  5 11:18:56 2001
+++ linux-2.4.2.csa+csa-patch/include/asm-ia64/unistd.h	Mon Mar  5 11:22:24 2001
@@ -207,6 +207,9 @@
 #if defined(CONFIG_PAGG)
 #define __NR_paggctl			1215
 #endif
+#if defined(CONFIG_CSA_JOB_ACCT) || defined(CONFIG_CSA_JOB_ACCT_MODULE)
+#define __NR_acctctl			1216
+#endif
 
 
 
diff -urN linux-2.4.2.orig+pagg-patch/include/linux/csa_internal.h linux-2.4.2.csa+csa-patch/include/linux/csa_internal.h
--- linux-2.4.2.orig+pagg-patch/include/linux/csa_internal.h	Wed Dec 31 18:00:00 1969
+++ linux-2.4.2.csa+csa-patch/include/linux/csa_internal.h	Mon Mar  5 11:22:24 2001
@@ -0,0 +1,91 @@
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc and LANL  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Contact information:  Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
+ * Mountain View, CA  94043, or:
+ *
+ * http://www.sgi.com
+ */
+
+/*
+ *  CSA (Comprehensive System Accounting)
+ *  Job Accounting for Linux
+ *
+ *  This header file contains the definitions needed for communication
+ *  between the kernel and the CSA module.
+ */
+
+#ifndef _LINUX_CSA_INTERNAL_H
+#define _LINUX_CSA_INTERNAL_H
+
+#include <linux/config.h>
+
+#if defined (CONFIG_CSA_JOB_ACCT) || defined (CONFIG_CSA_JOB_ACCT_MODULE)
+
+#include <linux/linkage.h>
+#include <linux/ptrace.h>
+
+/*
+ *  Used by the CSA module to define the procedure callbacks into the
+ *  CSA module.  CSA module callbacks related to start-of-job and
+ *  end-of-job accounting records are defined in the job.h header file.
+ *
+ *  do_acctctl:		Procedure pointer to acctctl() syscall handler
+ *  do_csa_acct:	Procedure pointer to procedure which writes a CSA
+ *			  end-of-process record when a task exits
+ *  module:		Pointer to kernel module struct.  Used to
+ *			  increment/decrement the CSA module use count
+ */
+struct csa_module_s {
+	int	(*do_acctctl) (int, void *);
+	void	(*do_csa_acct) (int, struct task_struct *);
+	struct module	*module;
+};
+
+static inline void csa_update_integrals(void)
+{
+	long delta;
+
+	if (current->mm) {
+		delta = current->times.tms_stime - current->csa_stimexpd;
+		current->csa_stimexpd = current->times.tms_stime;
+		current->csa_rss_mem1 += delta * current->mm->rss;
+		current->csa_vm_mem1 += delta * current->mm->total_vm;
+	}
+}
+
+static inline void csa_clear_integrals(struct task_struct *tsk)
+{
+	if (tsk) {
+		tsk->csa_stimexpd = 0;
+		tsk->csa_rss_mem1 = 0;
+		tsk->csa_vm_mem1 = 0;
+	}	
+}
+
+extern int  register_csa(struct csa_module_s *);
+extern void unregister_csa(void);
+extern void csa_acct(int, struct task_struct *);
+
+#else
+
+#define csa_update_integrals()		do { } while (0);
+#define csa_clear_integrals(task)	do { } while (0);
+#define csa_acct(exitcode, task)	do { } while (0);
+#endif  /* CONFIG_CSA_JOB_ACCT */
+
+#endif	/* _LINUX_CSA_INTERNAL_H */
diff -urN linux-2.4.2.orig+pagg-patch/include/linux/mm.h linux-2.4.2.csa+csa-patch/include/linux/mm.h
--- linux-2.4.2.orig+pagg-patch/include/linux/mm.h	Wed Feb 21 18:09:58 2001
+++ linux-2.4.2.csa+csa-patch/include/linux/mm.h	Mon Mar  5 11:22:24 2001
@@ -10,6 +10,7 @@
 #include <linux/string.h>
 #include <linux/list.h>
 #include <linux/mmzone.h>
+#include <linux/csa_internal.h>
 
 extern unsigned long max_mapnr;
 extern unsigned long num_physpages;
@@ -502,6 +503,9 @@
 	vma->vm_mm->total_vm += grow;
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm += grow;
+	/* no-op if CONFIG_CSA_JOB_ACCT not set */
+	csa_update_integrals();
+	update_mem_hiwater();
 	return 0;
 }
 
diff -urN linux-2.4.2.orig+pagg-patch/include/linux/sched.h linux-2.4.2.csa+csa-patch/include/linux/sched.h
--- linux-2.4.2.orig+pagg-patch/include/linux/sched.h	Mon Mar  5 11:18:56 2001
+++ linux-2.4.2.csa+csa-patch/include/linux/sched.h	Mon Mar  5 11:22:24 2001
@@ -224,6 +224,7 @@
 
 	/* Architecture-specific MM context */
 	mm_context_t context;
+	unsigned long hiwater_rss, hiwater_vm;
 };
 
 extern int mmlist_nr;
@@ -400,6 +401,12 @@
 /* List of pagg (process aggregate) attachments */
 	struct list_head pagg_list;
 #endif
+/* i/o counters(bytes read/written, blocks read/written, #syscalls, waittime */
+	unsigned long rchar, wchar, rblk, wblk, syscr, syscw, bwtime;
+#if defined(CONFIG_CSA_JOB_ACCT) || defined(CONFIG_CSA_JOB_ACCT_MODULE)
+	unsigned long csa_rss_mem1, csa_vm_mem1;
+	clock_t csa_stimexpd;
+#endif
 };
 
 /*
@@ -729,6 +736,19 @@
 extern void mmput(struct mm_struct *);
 /* Remove the current tasks stale references to the old mm_struct */
 extern void mm_release(void);
+
+/* Update highwater values */
+static inline void update_mem_hiwater(void)
+{
+	if (current->mm) {
+		if (current->mm->hiwater_rss < current->mm->rss) {
+			current->mm->hiwater_rss = current->mm->rss;
+		}
+		if (current->mm->hiwater_vm < current->mm->total_vm) {
+			current->mm->hiwater_vm = current->mm->total_vm;
+		}
+	}
+}
 
 /*
  * Routines for handling the fd arrays
diff -urN linux-2.4.2.orig+pagg-patch/kernel/Makefile linux-2.4.2.csa+csa-patch/kernel/Makefile
--- linux-2.4.2.orig+pagg-patch/kernel/Makefile	Mon Mar  5 11:18:56 2001
+++ linux-2.4.2.csa+csa-patch/kernel/Makefile	Mon Mar  5 11:22:24 2001
@@ -15,7 +15,7 @@
 	    pagg.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o
+	    signal.o sys.o kmod.o context.o csa.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -urN linux-2.4.2.orig+pagg-patch/kernel/csa.c linux-2.4.2.csa+csa-patch/kernel/csa.c
--- linux-2.4.2.orig+pagg-patch/kernel/csa.c	Wed Dec 31 18:00:00 1969
+++ linux-2.4.2.csa+csa-patch/kernel/csa.c	Mon Mar  5 11:22:24 2001
@@ -0,0 +1,158 @@
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc and LANL  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Contact information:  Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
+ * Mountain View, CA  94043, or:
+ *
+ * http://www.sgi.com
+ */
+
+/*
+ *  Description:
+ *	This file (kernel/csa.c) contains the procedures to handle kernel CSA
+ *	job accounting. The drivers/misc/csa_job_acct.c code does the real work.
+ *	That code can be either built into the kernel or compiled as a loadable
+ *	module.  When that code is initialized, it registers here with its
+ *	procedure callbacks.  The acctctl syscall processing and
+ *	the request to write CSA accounting records comes into here
+ *	and is handed off to the csa_job_acct.c code via the procedure
+ *	callbacks.
+ *
+ *  Author:
+ *	Marlys Kohnke (kohnke@sgi.com)
+ *
+ *  Contributors:
+ *
+ *  Changes:
+ *	February 2, 2001  (kohnke)  Modified to handle the csa_job_acct.c code
+ *	compiled into the kernel or compiled as a loadable module
+ */
+
+#include <linux/config.h>
+
+#if defined (CONFIG_CSA_JOB_ACCT) || defined (CONFIG_CSA_JOB_ACCT_MODULE)
+
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/csa_internal.h>
+
+static struct csa_module_s csa_operations = {
+	NULL,	/* do_acctctl */
+	NULL,	/* do_csa_acct */
+	NULL	/* pointer to kernel module struct for CSA module */
+};
+static struct csa_module_s *csa_op = &csa_operations;
+static int csa_registered = 0;
+
+/*
+ *  register_csa
+ *
+ *  The CSA csa_job_acct.c code calls this during initialization to set its 
+ *  procedure callback addresses:
+ *
+ *  do_acctctl():     processing of the acctctl syscall
+ *  do_csa_acct():    write a CSA record when a task exits
+ */
+int
+register_csa(struct csa_module_s *csa_callbacks)
+{
+
+	char *func_id = "register_csa";
+
+	if (csa_callbacks == (struct csa_module_s *)NULL) {
+		return -EINVAL;
+	}
+
+	if (csa_registered) {
+		/*
+		 * incorrectly using csa_job_acct.c as a loadable module and
+		 * compiled into the kernel??
+		 */
+		printk(KERN_WARNING "%s: %s\n",
+		       func_id, "Multiple attempts to register CSA support\n");
+		return -EBUSY;
+	} else {
+		csa_registered = 1;
+	}
+		
+	memcpy((char *)csa_op, (char *)csa_callbacks, 
+		sizeof(struct csa_module_s));
+
+	printk(KERN_INFO "%s: %s\n", func_id, "CSA support registered");
+
+	return 0;
+}
+
+void
+unregister_csa()
+{
+	char *func_id = "unregister_csa";
+
+	memset((char *)csa_op, 0, sizeof(struct csa_module_s));
+	csa_registered = 0;
+
+	printk(KERN_INFO "%s: %s\n", func_id, "CSA support unregistered");
+}
+
+/*
+ *  This is the acctctl syscall.  The two arguments are passed to the CSA
+ *  csa_job_acct.c code for processing. Use the module use count to prevent the
+ *  CSA module from being unloaded during processing.
+ */
+asmlinkage int
+sys_acctctl(int req, void *act)
+{
+	int ret;
+
+	if (csa_op->do_acctctl == NULL) {
+		/* the CSA csa_job_acct.c code hasn't registered yet */
+		return -ENOSYS;
+	} else {
+		if (csa_op->module) {
+			__MOD_INC_USE_COUNT(csa_op->module);
+		}
+		ret = csa_op->do_acctctl(req, act);
+		if (csa_op->module) {
+			__MOD_DEC_USE_COUNT(csa_op->module);
+		}
+	}
+	return ret;
+}
+
+/*
+ *  This is the wrapper for the CSA end-of-process accounting record, which
+ *  is written by the CSA csa_job_acct.c code when a task within a job exits.
+ *  Use the module use count to prevent the CSA module from being
+ *  unloaded during processing.
+ */
+void
+csa_acct(int exitcode, struct task_struct *p)
+{
+
+	if (csa_op->do_csa_acct != NULL) {
+		if (csa_op->module) {
+			__MOD_INC_USE_COUNT(csa_op->module);
+		}
+		csa_op->do_csa_acct(exitcode, p);
+		if (csa_op->module) {
+			__MOD_DEC_USE_COUNT(csa_op->module);
+		}
+	}
+}
+
+#endif
diff -urN linux-2.4.2.orig+pagg-patch/kernel/exit.c linux-2.4.2.csa+csa-patch/kernel/exit.c
--- linux-2.4.2.orig+pagg-patch/kernel/exit.c	Mon Mar  5 11:18:56 2001
+++ linux-2.4.2.csa+csa-patch/kernel/exit.c	Mon Mar  5 11:22:24 2001
@@ -14,6 +14,7 @@
 #ifdef CONFIG_BSD_PROCESS_ACCT
 #include <linux/acct.h>
 #endif
+#include <linux/csa_internal.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -434,9 +435,14 @@
 	del_timer_sync(&tsk->real_timer);
 
 fake_volatile:
+	/* no-op if CONFIG_CSA_JOB_ACCT not set */
+	csa_update_integrals();
+	update_mem_hiwater();
 #ifdef CONFIG_BSD_PROCESS_ACCT
 	acct_process(code);
 #endif
+	/* no-op if CONFIG_CSA_JOB_ACCT not set */
+	csa_acct(code, tsk);
 	__exit_mm(tsk);
 
 	lock_kernel();
diff -urN linux-2.4.2.orig+pagg-patch/kernel/fork.c linux-2.4.2.csa+csa-patch/kernel/fork.c
--- linux-2.4.2.orig+pagg-patch/kernel/fork.c	Mon Mar  5 11:18:56 2001
+++ linux-2.4.2.csa+csa-patch/kernel/fork.c	Mon Mar  5 11:22:24 2001
@@ -342,6 +342,9 @@
 	if (init_new_context(tsk,mm))
 		goto free_pt;
 
+	mm->hiwater_rss = mm->rss;
+	mm->hiwater_vm = mm->total_vm;	
+
 good_mm:
 	tsk->mm = mm;
 	tsk->active_mm = mm;
@@ -627,6 +630,10 @@
 	p->tty_old_pgrp = 0;
 	p->times.tms_utime = p->times.tms_stime = 0;
 	p->times.tms_cutime = p->times.tms_cstime = 0;
+	p->rchar = p->wchar = p->rblk = p->wblk = p->syscr = p->syscw = 0;
+	p->bwtime = 0;
+	/* no-op if CONFIG_CSA_JOB_ACCT not set */
+	csa_clear_integrals(p);
 #ifdef CONFIG_SMP
 	{
 		int i;
diff -urN linux-2.4.2.orig+pagg-patch/kernel/ksyms.c linux-2.4.2.csa+csa-patch/kernel/ksyms.c
--- linux-2.4.2.orig+pagg-patch/kernel/ksyms.c	Mon Mar  5 11:18:56 2001
+++ linux-2.4.2.csa+csa-patch/kernel/ksyms.c	Mon Mar  5 11:22:24 2001
@@ -47,6 +47,7 @@
 #include <linux/fs.h>
 #include <linux/tty.h>
 #include <linux/pagg.h>
+#include <linux/csa_internal.h>
 
 #if defined(CONFIG_PROC_FS)
 #include <linux/proc_fs.h>
@@ -482,6 +483,14 @@
 EXPORT_SYMBOL(attach_pagg);
 EXPORT_SYMBOL(detach_pagg);
 #endif
+
+/* job accounting */
+#if defined(CONFIG_CSA_JOB_ACCT) || defined(CONFIG_CSA_JOB_ACCT_MODULE)
+EXPORT_SYMBOL(register_csa);
+EXPORT_SYMBOL(unregister_csa);
+EXPORT_SYMBOL(csa_acct);
+#endif
+
 
 
 /* Added to make file system as module */
diff -urN linux-2.4.2.orig+pagg-patch/mm/memory.c linux-2.4.2.csa+csa-patch/mm/memory.c
--- linux-2.4.2.orig+pagg-patch/mm/memory.c	Wed Feb  7 00:49:21 2001
+++ linux-2.4.2.csa+csa-patch/mm/memory.c	Mon Mar  5 11:22:24 2001
@@ -46,6 +46,7 @@
 #include <asm/pgalloc.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
+#include <linux/csa_internal.h>
 
 
 unsigned long max_mapnr;
@@ -386,6 +387,8 @@
 		mm->rss -= freed;
 	else
 		mm->rss = 0;
+	/* no-op unless CONFIG_CSA_JOB_ACCT is set */
+	csa_update_integrals();
 }
 
 
@@ -879,8 +882,12 @@
 	 * Re-check the pte - we dropped the lock
 	 */
 	if (pte_same(*page_table, pte)) {
-		if (PageReserved(old_page))
+		if (PageReserved(old_page)) {
 			++mm->rss;
+			/* no-op if CONFIG_CSA_JOB_ACCT not set */
+			csa_update_integrals();
+			update_mem_hiwater();
+		}
 		break_cow(vma, old_page, new_page, address, page_table);
 
 		/* Free the old page.. */
@@ -1041,6 +1048,9 @@
 	}
 
 	mm->rss++;
+	/* no-op if CONFIG_CSA_JOB_ACCT not set */
+	csa_update_integrals();
+	update_mem_hiwater();
 
 	pte = mk_pte(page, vma->vm_page_prot);
 
@@ -1075,6 +1085,9 @@
 		clear_user_highpage(page, addr);
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 		mm->rss++;
+		/* no-op if CONFIG_CSA_JOB_ACCT not set */
+		csa_update_integrals();
+		update_mem_hiwater();
 		flush_page_to_ram(page);
 	}
 	set_pte(page_table, entry);
@@ -1114,6 +1127,9 @@
 	if (new_page == NOPAGE_OOM)
 		return -1;
 	++mm->rss;
+	/* no-op if CONFIG_CSA_JOB_ACCT not set */
+	csa_update_integrals();
+	update_mem_hiwater();
 	/*
 	 * This silly early PAGE_DIRTY setting removes a race
 	 * due to the bad i386 page protection. But it's valid
diff -urN linux-2.4.2.orig+pagg-patch/mm/mmap.c linux-2.4.2.csa+csa-patch/mm/mmap.c
--- linux-2.4.2.orig+pagg-patch/mm/mmap.c	Wed Feb  7 00:04:12 2001
+++ linux-2.4.2.csa+csa-patch/mm/mmap.c	Mon Mar  5 11:22:24 2001
@@ -365,6 +365,9 @@
 		mm->locked_vm += len >> PAGE_SHIFT;
 		make_pages_present(addr, addr + len);
 	}
+	/* no-op if CONFIG_CSA_JOB_ACCT not set */
+	csa_update_integrals();
+	update_mem_hiwater();
 	return addr;
 
 unmap_and_free_vma:
@@ -867,6 +870,9 @@
 		mm->locked_vm += len >> PAGE_SHIFT;
 		make_pages_present(addr, addr + len);
 	}
+	/* no-op if CONFIG_CSA_JOB_ACCT not set */
+	csa_update_integrals();
+	update_mem_hiwater();
 	return addr;
 }
 
diff -urN linux-2.4.2.orig+pagg-patch/mm/mremap.c linux-2.4.2.csa+csa-patch/mm/mremap.c
--- linux-2.4.2.orig+pagg-patch/mm/mremap.c	Fri Dec 29 16:07:24 2000
+++ linux-2.4.2.csa+csa-patch/mm/mremap.c	Mon Mar  5 11:22:25 2001
@@ -9,6 +9,7 @@
 #include <linux/shm.h>
 #include <linux/mman.h>
 #include <linux/swap.h>
+#include <linux/csa_internal.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -149,6 +150,9 @@
 				make_pages_present(new_vma->vm_start,
 						   new_vma->vm_end);
 			}
+			/* no-op if CONFIG_CSA_JOB_ACCT not set */
+			csa_update_integrals();
+			update_mem_hiwater();
 			return new_addr;
 		}
 		kmem_cache_free(vm_area_cachep, new_vma);
@@ -264,6 +268,9 @@
 				make_pages_present(addr + old_len,
 						   addr + new_len);
 			}
+			/* no-op if CONFIG_CSA_JOB_ACCT not set */
+			csa_update_integrals();
+			update_mem_hiwater();
 			ret = addr;
 			goto out;
 		}
diff -urN linux-2.4.2.orig+pagg-patch/mm/swapfile.c linux-2.4.2.csa+csa-patch/mm/swapfile.c
--- linux-2.4.2.orig+pagg-patch/mm/swapfile.c	Fri Feb  9 13:29:44 2001
+++ linux-2.4.2.csa+csa-patch/mm/swapfile.c	Mon Mar  5 11:22:25 2001
@@ -14,6 +14,7 @@
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
 #include <linux/shm.h>
+#include <linux/csa_internal.h>
 
 #include <asm/pgtable.h>
 
@@ -232,6 +233,9 @@
 	swap_free(entry);
 	get_page(page);
 	++vma->vm_mm->rss;
+	/* no-op if CONFIG_CSA_JOB_ACCT not set */
+	csa_update_integrals();
+	update_mem_hiwater();
 }
 
 static inline void unuse_pmd(struct vm_area_struct * vma, pmd_t *dir,
diff -urN linux-2.4.2.orig+pagg-patch/mm/vmscan.c linux-2.4.2.csa+csa-patch/mm/vmscan.c
--- linux-2.4.2.orig+pagg-patch/mm/vmscan.c	Mon Jan 15 14:36:49 2001
+++ linux-2.4.2.csa+csa-patch/mm/vmscan.c	Mon Mar  5 11:22:25 2001
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/highmem.h>
 #include <linux/file.h>
+#include <linux/csa_internal.h>
 
 #include <asm/pgalloc.h>
 
@@ -73,6 +74,8 @@
 		set_pte(page_table, swp_entry_to_pte(entry));
 drop_pte:
 		mm->rss--;
+		/* no-op if CONFIG_CSA_JOB_ACCT not set */
+		csa_update_integrals();
 		if (!page->age)
 			deactivate_page(page);
 		UnlockPage(page);
