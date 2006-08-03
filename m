Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWHCEX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWHCEX2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 00:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWHCEX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 00:23:27 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25266 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932341AbWHCEX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 00:23:27 -0400
Message-ID: <44D17A47.4010302@engr.sgi.com>
Date: Wed, 02 Aug 2006 21:23:35 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Jes Sorensen <jes@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Tony Ernst <tee@sgi.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: [patch 3/3] convert CONFIG tag for extended accounting routines
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060708010909000903010700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060708010909000903010700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch is to replace the "[patch 3/3] convert CONFIG
tag for a few accounting data used by CSA" posted on 7/31.

There were a few accounting data/macros that are used in CSA
but are #ifdef'ed inside CONFIG_BSD_PROCESS_ACCT. This patch is
to change those ifdef's from CONFIG_BSD_PROCESS_ACCT to
CONFIG_TASK_XACCT. A few defines are moved from kernel/acct.c and
include/linux/acct.h to kernel/tsacct.c and
include/linux/tsacct_kern.h.


Signed-off-by:  Jay Lan <jlan@sgi.com>



--------------060708010909000903010700
Content-Type: text/plain;
 name="bsd-to-xacct.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bsd-to-xacct.patch"

Index: linux/include/linux/acct.h
===================================================================
--- linux.orig/include/linux/acct.h	2006-08-02 18:39:58.000000000 -0700
+++ linux/include/linux/acct.h	2006-08-02 18:42:33.257363761 -0700
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
Index: linux/kernel/acct.c
===================================================================
--- linux.orig/kernel/acct.c	2006-08-02 18:39:58.000000000 -0700
+++ linux/kernel/acct.c	2006-08-02 18:42:33.261363809 -0700
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
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h	2006-08-02 18:39:58.000000000 -0700
+++ linux/include/linux/sched.h	2006-08-02 18:42:33.261363809 -0700
@@ -964,7 +964,7 @@ struct task_struct {
 	wait_queue_t *io_wait;
 /* i/o counters(bytes read/written, #syscalls */
 	u64 rchar, wchar, syscr, syscw;
-#if defined(CONFIG_BSD_PROCESS_ACCT)
+#if defined(CONFIG_TASK_XACCT)
 	u64 acct_rss_mem1;	/* accumulated rss usage */
 	u64 acct_vm_mem1;	/* accumulated virtual memory usage */
 	clock_t acct_stimexpd;	/* clock_t-converted stime since last update */
Index: linux/fs/compat.c
===================================================================
--- linux.orig/fs/compat.c	2006-08-02 18:39:58.000000000 -0700
+++ linux/fs/compat.c	2006-08-02 18:42:33.265363858 -0700
@@ -44,7 +44,7 @@
 #include <linux/nfsd/syscall.h>
 #include <linux/personality.h>
 #include <linux/rwsem.h>
-#include <linux/acct.h>
+#include <linux/tsacct_kern.h>
 #include <linux/mm.h>
 
 #include <net/sock.h>		/* siocdevprivate_ioctl */
Index: linux/fs/exec.c
===================================================================
--- linux.orig/fs/exec.c	2006-08-02 18:39:58.000000000 -0700
+++ linux/fs/exec.c	2006-08-02 18:42:33.265363858 -0700
@@ -46,7 +46,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/rmap.h>
-#include <linux/acct.h>
+#include <linux/tsacct_kern.h>
 #include <linux/cn_proc.h>
 #include <linux/audit.h>
 
Index: linux/kernel/exit.c
===================================================================
--- linux.orig/kernel/exit.c	2006-08-02 18:39:58.000000000 -0700
+++ linux/kernel/exit.c	2006-08-02 18:42:33.269363906 -0700
@@ -18,6 +18,7 @@
 #include <linux/security.h>
 #include <linux/cpu.h>
 #include <linux/acct.h>
+#include <linux/tsacct_kern.h>
 #include <linux/file.h>
 #include <linux/binfmts.h>
 #include <linux/ptrace.h>
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c	2006-08-02 18:39:58.000000000 -0700
+++ linux/kernel/fork.c	2006-08-02 18:42:33.269363906 -0700
@@ -42,6 +42,7 @@
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
+#include <linux/tsacct_kern.h>
 #include <linux/cn_proc.h>
 #include <linux/delayacct.h>
 #include <linux/taskstats_kern.h>
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c	2006-08-02 18:39:58.000000000 -0700
+++ linux/kernel/sched.c	2006-08-02 18:42:33.273363954 -0700
@@ -49,7 +49,7 @@
 #include <linux/seq_file.h>
 #include <linux/syscalls.h>
 #include <linux/times.h>
-#include <linux/acct.h>
+#include <linux/tsacct_kern.h>
 #include <linux/kprobes.h>
 #include <linux/delayacct.h>
 #include <asm/tlb.h>
Index: linux/include/linux/tsacct_kern.h
===================================================================
--- linux.orig/include/linux/tsacct_kern.h	2006-08-02 18:39:58.000000000 -0700
+++ linux/include/linux/tsacct_kern.h	2006-08-02 18:42:33.273363954 -0700
@@ -18,9 +18,15 @@ static inline void bacct_add_tsk(struct 
 
 #ifdef CONFIG_TASK_XACCT
 extern void xacct_add_tsk(struct taskstats *stats, struct task_struct *p);
+extern void acct_update_integrals(struct task_struct *tsk);
+extern void acct_clear_integrals(struct task_struct *tsk);
 #else
 static inline void xacct_add_tsk(struct taskstats *stats, struct task_struct *p)
 {}
+static inline void acct_update_integrals(struct task_struct *tsk)
+{}
+static inline void acct_clear_integrals(struct task_struct *tsk)
+{}
 #endif /* CONFIG_TASK_XACCT */
 
 #endif
Index: linux/kernel/tsacct.c
===================================================================
--- linux.orig/kernel/tsacct.c	2006-08-02 18:42:06.000000000 -0700
+++ linux/kernel/tsacct.c	2006-08-02 18:46:45.232406831 -0700
@@ -85,4 +85,34 @@ void xacct_add_tsk(struct taskstats *sta
 	stats->read_syscalls	= p->syscr;
 	stats->write_syscalls	= p->syscw;
 }
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
 #endif



--------------060708010909000903010700--
