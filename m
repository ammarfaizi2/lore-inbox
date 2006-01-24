Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWAXWgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWAXWgB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 17:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWAXWgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 17:36:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:8202 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750799AbWAXWf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 17:35:59 -0500
Date: Tue, 24 Jan 2006 23:35:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jes Sorensen <jes@sgi.com>
Subject: [2.6 patch] remove unused acct variables from task_struct
Message-ID: <20060124223558.GK3590@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jes Sorensen <jes@sgi.com>

This patch removes three acct related variables from struct
task_struct which are no longer in use. Their values were calculated
in acct_update_integrals, but never read back by anything.

Adrian Bunk:
I've added the missing removal of the prototypes from acct.h

Signed-off-by: Jes Sorensen <jes@sgi.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

----

This patch was sent by Jes Sorensen on:
- 5 Jan 2006

 fs/compat.c           |    2 --
 fs/exec.c             |    2 --
 include/linux/acct.h  |    4 ----
 include/linux/sched.h |    5 -----
 kernel/acct.c         |   32 --------------------------------
 kernel/exit.c         |    1 -
 kernel/fork.c         |    1 -
 kernel/sched.c        |    3 ---
 8 files changed, 50 deletions(-)

Index: linux-2.6.15/fs/compat.c
===================================================================
--- linux-2.6.15.orig/fs/compat.c
+++ linux-2.6.15/fs/compat.c
@@ -44,7 +44,6 @@
 #include <linux/nfsd/syscall.h>
 #include <linux/personality.h>
 #include <linux/rwsem.h>
-#include <linux/acct.h>
 #include <linux/mm.h>
 
 #include <net/sock.h>		/* siocdevprivate_ioctl */
@@ -1482,7 +1481,6 @@
 
 		/* execve success */
 		security_bprm_free(bprm);
-		acct_update_integrals(current);
 		kfree(bprm);
 		return retval;
 	}
Index: linux-2.6.15/fs/exec.c
===================================================================
--- linux-2.6.15.orig/fs/exec.c
+++ linux-2.6.15/fs/exec.c
@@ -47,7 +47,6 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/rmap.h>
-#include <linux/acct.h>
 #include <linux/cn_proc.h>
 
 #include <asm/uaccess.h>
@@ -1198,7 +1197,6 @@
 
 		/* execve success */
 		security_bprm_free(bprm);
-		acct_update_integrals(current);
 		kfree(bprm);
 		return retval;
 	}
Index: linux-2.6.15/include/linux/sched.h
===================================================================
--- linux-2.6.15.orig/include/linux/sched.h
+++ linux-2.6.15/include/linux/sched.h
@@ -842,11 +842,6 @@
 	wait_queue_t *io_wait;
 /* i/o counters(bytes read/written, #syscalls */
 	u64 rchar, wchar, syscr, syscw;
-#if defined(CONFIG_BSD_PROCESS_ACCT)
-	u64 acct_rss_mem1;	/* accumulated rss usage */
-	u64 acct_vm_mem1;	/* accumulated virtual memory usage */
-	clock_t acct_stimexpd;	/* clock_t-converted stime since last update */
-#endif
 #ifdef CONFIG_NUMA
   	struct mempolicy *mempolicy;
 	short il_next;
Index: linux-2.6.15/kernel/acct.c
===================================================================
--- linux-2.6.15.orig/kernel/acct.c
+++ linux-2.6.15/kernel/acct.c
@@ -571,35 +571,3 @@
 	do_acct_process(exitcode, file);
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
-	if (tsk) {
-		tsk->acct_stimexpd = 0;
-		tsk->acct_rss_mem1 = 0;
-		tsk->acct_vm_mem1 = 0;
-	}
-}
Index: linux-2.6.15/kernel/exit.c
===================================================================
--- linux-2.6.15.orig/kernel/exit.c
+++ linux-2.6.15/kernel/exit.c
@@ -835,7 +835,6 @@
 				current->comm, current->pid,
 				preempt_count());
 
-	acct_update_integrals(tsk);
 	if (tsk->mm) {
 		update_hiwater_rss(tsk->mm);
 		update_hiwater_vm(tsk->mm);
Index: linux-2.6.15/kernel/fork.c
===================================================================
--- linux-2.6.15.orig/kernel/fork.c
+++ linux-2.6.15/kernel/fork.c
@@ -949,7 +949,6 @@
 	p->wchar = 0;		/* I/O counter: bytes written */
 	p->syscr = 0;		/* I/O counter: read syscalls */
 	p->syscw = 0;		/* I/O counter: write syscalls */
-	acct_clear_integrals(p);
 
  	p->it_virt_expires = cputime_zero;
 	p->it_prof_expires = cputime_zero;
Index: linux-2.6.15/kernel/sched.c
===================================================================
--- linux-2.6.15.orig/kernel/sched.c
+++ linux-2.6.15/kernel/sched.c
@@ -46,7 +46,6 @@
 #include <linux/seq_file.h>
 #include <linux/syscalls.h>
 #include <linux/times.h>
-#include <linux/acct.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -2608,8 +2607,6 @@
 		cpustat->iowait = cputime64_add(cpustat->iowait, tmp);
 	else
 		cpustat->idle = cputime64_add(cpustat->idle, tmp);
-	/* Account for system time used */
-	acct_update_integrals(p);
 }
 
 /*
--- linux-2.6.16-rc1-mm2-full/include/linux/acct.h.old	2006-01-24 22:18:17.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/include/linux/acct.h	2006-01-24 22:18:39.000000000 +0100
@@ -124,14 +124,10 @@
 extern void acct_auto_close_mnt(struct vfsmount *m);
 extern void acct_auto_close(struct super_block *sb);
 extern void acct_process(long exitcode);
-extern void acct_update_integrals(struct task_struct *tsk);
-extern void acct_clear_integrals(struct task_struct *tsk);
 #else
 #define acct_auto_close_mnt(x)	do { } while (0)
 #define acct_auto_close(x)	do { } while (0)
 #define acct_process(x)		do { } while (0)
-#define acct_update_integrals(x)		do { } while (0)
-#define acct_clear_integrals(task)	do { } while (0)
 #endif
 
 /*
