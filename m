Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWGaTXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWGaTXl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWGaTXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:23:41 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5578 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030346AbWGaTXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:23:40 -0400
Message-ID: <44CE58AF.7030200@sgi.com>
Date: Mon, 31 Jul 2006 12:23:27 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Jes Sorensen <jes@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Tony Ernst <tee@sgi.com>
Subject: [patch 3/3] convert CONFIG tag for a few accounting data used by
 CSA
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030803070107030604020502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030803070107030604020502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

There were a few accounting data/macros that are used in CSA
but are #ifdef'ed inside CONFIG_BSD_PROCESS_ACCT. This patch is
to change those ifdef's from CONFIG_BSD_PROCESS_ACCT to
CONFIG_CSA_ACCT. A few defines are moved from kernel/acct.c and
include/linux/acct.h to kernel/csa.c and include/linux/csa_kern.h.


Signed-off-by:  Jay Lan <jlan@sgi.com>


--------------030803070107030604020502
Content-Type: text/plain;
 name="csa-bsd-acct-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="csa-bsd-acct-update.patch"

Index: linux/include/linux/acct.h
===================================================================
--- linux.orig/include/linux/acct.h	2006-07-20 11:38:51.956204769 -0700
+++ linux/include/linux/acct.h	2006-07-20 11:45:32.469053105 -0700
@@ -124,16 +124,12 @@ extern void acct_auto_close(struct super
 extern void acct_init_pacct(struct pacct_struct *pacct);
 extern void acct_collect(long exitcode, int group_dead);
 extern void acct_process(void);
-extern void acct_update_integrals(struct task_struct *tsk);
-extern void acct_clear_integrals(struct task_struct *tsk);
 #else
 #define acct_auto_close_mnt(x)	do { } while (0)
 #define acct_auto_close(x)	do { } while (0)
 #define acct_init_pacct(x)	do { } while (0)
 #define acct_collect(x,y)	do { } while (0)
 #define acct_process()		do { } while (0)
-#define acct_update_integrals(x)		do { } while (0)
-#define acct_clear_integrals(task)	do { } while (0)
 #endif
 
 /*
Index: linux/include/linux/csa_kern.h
===================================================================
--- linux.orig/include/linux/csa_kern.h	2006-07-20 11:44:05.079993220 -0700
+++ linux/include/linux/csa_kern.h	2006-07-20 11:47:16.266315471 -0700
@@ -28,4 +28,12 @@ extern void csa_add_tsk(struct taskstats
  */
 #define REV_CSA		07000	/* Kernel: CSA base record */
 
+#ifdef CONFIG_CSA_ACCT
+extern void acct_update_integrals(struct task_struct *tsk);
+extern void acct_clear_integrals(struct task_struct *tsk);
+#else
+#define acct_update_integrals(x)	do { } while (0)
+#define acct_clear_integrals(task)	do { } while (0)
+#endif
+
 #endif	/* _CSA_KERN_H */
Index: linux/kernel/acct.c
===================================================================
--- linux.orig/kernel/acct.c	2006-07-20 11:38:51.956204769 -0700
+++ linux/kernel/acct.c	2006-07-20 11:45:32.477053203 -0700
@@ -598,33 +598,3 @@ void acct_process(void)
 	do_acct_process(file);
 	fput(file);
 }
-
-
-/**
- * acct_update_integrals - update mm integral fields in task_struct
- * @tsk: task_struct for accounting
- */
-void acct_update_integrals(struct task_struct *tsk)
-{
-	if (likely(tsk->mm)) {
-		long delta =
-			cputime_to_jiffies(tsk->stime) - tsk->acct_stimexpd;
-
-		if (delta == 0)
-			return;
-		tsk->acct_stimexpd = tsk->stime;
-		tsk->acct_rss_mem1 += delta * get_mm_rss(tsk->mm);
-		tsk->acct_vm_mem1 += delta * tsk->mm->total_vm;
-	}
-}
-
-/**
- * acct_clear_integrals - clear the mm integral fields in task_struct
- * @tsk: task_struct whose accounting fields are cleared
- */
-void acct_clear_integrals(struct task_struct *tsk)
-{
-	tsk->acct_stimexpd = 0;
-	tsk->acct_rss_mem1 = 0;
-	tsk->acct_vm_mem1 = 0;
-}
Index: linux/kernel/csa.c
===================================================================
--- linux.orig/kernel/csa.c	2006-07-20 11:45:18.364881535 -0700
+++ linux/kernel/csa.c	2006-07-20 11:45:32.477053203 -0700
@@ -44,3 +44,35 @@ void csa_add_tsk(struct taskstats *stats
 	stats->ac_scr	= p->syscr;
 	stats->ac_scw	= p->syscw;
 }
+
+
+
+
+/**
+ * acct_update_integrals - update mm integral fields in task_struct
+ * @tsk: task_struct for accounting
+ */
+void acct_update_integrals(struct task_struct *tsk)
+{
+	if (likely(tsk->mm)) {
+		long delta =
+			cputime_to_jiffies(tsk->stime) - tsk->acct_stimexpd;
+
+		if (delta == 0)
+			return;
+		tsk->acct_stimexpd = tsk->stime;
+		tsk->acct_rss_mem1 += delta * get_mm_rss(tsk->mm);
+		tsk->acct_vm_mem1 += delta * tsk->mm->total_vm;
+	}
+}
+
+/**
+ * acct_clear_integrals - clear the mm integral fields in task_struct
+ * @tsk: task_struct whose accounting fields are cleared
+ */
+void acct_clear_integrals(struct task_struct *tsk)
+{
+	tsk->acct_stimexpd = 0;
+	tsk->acct_rss_mem1 = 0;
+	tsk->acct_vm_mem1 = 0;
+}
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h	2006-07-20 11:38:51.956204769 -0700
+++ linux/include/linux/sched.h	2006-07-20 11:45:32.481053251 -0700
@@ -964,7 +964,7 @@ struct task_struct {
 	wait_queue_t *io_wait;
 /* i/o counters(bytes read/written, #syscalls */
 	u64 rchar, wchar, syscr, syscw;
-#if defined(CONFIG_BSD_PROCESS_ACCT)
+#if defined(CONFIG_CSA_ACCT)
 	u64 acct_rss_mem1;	/* accumulated rss usage */
 	u64 acct_vm_mem1;	/* accumulated virtual memory usage */
 	clock_t acct_stimexpd;	/* clock_t-converted stime since last update */
Index: linux/fs/compat.c
===================================================================
--- linux.orig/fs/compat.c	2006-07-20 11:38:52.028205640 -0700
+++ linux/fs/compat.c	2006-07-20 11:45:32.481053251 -0700
@@ -44,7 +44,7 @@
 #include <linux/nfsd/syscall.h>
 #include <linux/personality.h>
 #include <linux/rwsem.h>
-#include <linux/acct.h>
+#include <linux/csa_kern.h>
 #include <linux/mm.h>
 
 #include <net/sock.h>		/* siocdevprivate_ioctl */
Index: linux/fs/exec.c
===================================================================
--- linux.orig/fs/exec.c	2006-07-20 11:38:52.056205979 -0700
+++ linux/fs/exec.c	2006-07-20 11:45:32.485053300 -0700
@@ -46,7 +46,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/rmap.h>
-#include <linux/acct.h>
+#include <linux/csa_kern.h>
 #include <linux/cn_proc.h>
 #include <linux/audit.h>
 
Index: linux/kernel/exit.c
===================================================================
--- linux.orig/kernel/exit.c	2006-07-20 11:38:51.956204769 -0700
+++ linux/kernel/exit.c	2006-07-20 11:45:32.489053349 -0700
@@ -18,6 +18,7 @@
 #include <linux/security.h>
 #include <linux/cpu.h>
 #include <linux/acct.h>
+#include <linux/csa_kern.h>
 #include <linux/file.h>
 #include <linux/binfmts.h>
 #include <linux/ptrace.h>
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c	2006-07-20 11:38:51.956204769 -0700
+++ linux/kernel/fork.c	2006-07-20 11:45:32.489053349 -0700
@@ -42,6 +42,7 @@
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
+#include <linux/csa_kern.h>
 #include <linux/cn_proc.h>
 #include <linux/delayacct.h>
 #include <linux/taskstats_kern.h>
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c	2006-07-20 11:38:51.956204769 -0700
+++ linux/kernel/sched.c	2006-07-20 11:45:32.493053397 -0700
@@ -49,7 +49,7 @@
 #include <linux/seq_file.h>
 #include <linux/syscalls.h>
 #include <linux/times.h>
-#include <linux/acct.h>
+#include <linux/csa_kern.h>
 #include <linux/kprobes.h>
 #include <linux/delayacct.h>
 #include <asm/tlb.h>


--------------030803070107030604020502--
