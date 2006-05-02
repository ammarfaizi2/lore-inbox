Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWEBGRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWEBGRE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWEBGRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:17:04 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:49539 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932391AbWEBGRB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:17:01 -0400
Date: Tue, 2 May 2006 11:44:08 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net, jlan@engr.sgi.com
Subject: [Patch 2/8] Sync block I/O and swapin delay collection
Message-ID: <20060502061408.GM13962@in.ibm.com>
Reply-To: balbir@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changelog

Fixes comments by akpm
- avoid creating new per-process flag PF_SWAPIN

Other changes
- do not mix spaces and tabs

delayacct-blkio-swapin.patch

Collect per-task block I/O delay statistics.

Unlike earlier iterations of the delay accounting
patches, now delays are only collected for the actual
I/O waits rather than try and cover the delays seen in
I/O submission paths.

Account separately for block I/O delays
incurred as a result of swapin page faults whose
frequency can be affected by the task/process' rss limit.
Hence swapin delays can act as feedback for rss limit changes
independent of I/O priority changes.

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>
Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 include/linux/delayacct.h |   25 +++++++++++++++++++++++++
 include/linux/sched.h     |    6 ++++++
 kernel/delayacct.c        |   19 +++++++++++++++++++
 kernel/sched.c            |    5 +++++
 mm/memory.c               |    4 ++++
 5 files changed, 59 insertions(+)

diff -puN include/linux/delayacct.h~delayacct-blkio-swapin include/linux/delayacct.h
--- linux-2.6.17-rc3/include/linux/delayacct.h~delayacct-blkio-swapin	2006-04-28 23:48:43.000000000 +0530
+++ linux-2.6.17-rc3-balbir/include/linux/delayacct.h	2006-05-02 07:05:21.000000000 +0530
@@ -19,6 +19,13 @@
 
 #include <linux/sched.h>
 
+/*
+ * Per-task flags relevant to delay accounting
+ * maintained privately to avoid exhausting similar flags in sched.h:PF_*
+ * Used to set current->delays->flags
+ */
+#define DELAYACCT_PF_SWAPIN	0x00000001	/* I am doing a swapin */
+
 #ifdef CONFIG_TASK_DELAY_ACCT
 
 extern int delayacct_on;	/* Delay accounting turned on/off */
@@ -26,6 +33,8 @@ extern kmem_cache_t *delayacct_cache;
 extern void delayacct_init(void);
 extern void __delayacct_tsk_init(struct task_struct *);
 extern void __delayacct_tsk_exit(struct task_struct *);
+extern void __delayacct_blkio_start(void);
+extern void __delayacct_blkio_end(void);
 
 static inline void delayacct_set_flag(int flag)
 {
@@ -53,6 +62,18 @@ static inline void delayacct_tsk_exit(st
 		__delayacct_tsk_exit(tsk);
 }
 
+static inline void delayacct_blkio_start(void)
+{
+	if (current->delays)
+		__delayacct_blkio_start();
+}
+
+static inline void delayacct_blkio_end(void)
+{
+	if (current->delays)
+		__delayacct_blkio_end();
+}
+
 #else
 static inline void delayacct_set_flag(int flag)
 {}
@@ -64,6 +85,10 @@ static inline void delayacct_tsk_init(st
 {}
 static inline void delayacct_tsk_exit(struct task_struct *tsk)
 {}
+static inline void delayacct_blkio_start(void)
+{}
+static inline void delayacct_blkio_end(void)
+{}
 #endif /* CONFIG_TASK_DELAY_ACCT */
 
 #endif
diff -puN include/linux/sched.h~delayacct-blkio-swapin include/linux/sched.h
--- linux-2.6.17-rc3/include/linux/sched.h~delayacct-blkio-swapin	2006-04-28 23:48:43.000000000 +0530
+++ linux-2.6.17-rc3-balbir/include/linux/sched.h	2006-05-02 07:05:25.000000000 +0530
@@ -550,6 +550,12 @@ struct task_delay_info {
 	 * Atomicity of updates to XXX_delay, XXX_count protected by
 	 * single lock above (split into XXX_lock if contention is an issue).
 	 */
+
+	struct timespec blkio_start, blkio_end;	/* Shared by blkio, swapin */
+	u64 blkio_delay;	/* wait for sync block io completion */
+	u64 swapin_delay;	/* wait for swapin block io completion */
+	u32 blkio_count;
+	u32 swapin_count;
 };
 #endif
 
diff -puN kernel/delayacct.c~delayacct-blkio-swapin kernel/delayacct.c
--- linux-2.6.17-rc3/kernel/delayacct.c~delayacct-blkio-swapin	2006-04-28 23:48:43.000000000 +0530
+++ linux-2.6.17-rc3-balbir/kernel/delayacct.c	2006-05-02 07:27:03.000000000 +0530
@@ -85,3 +85,22 @@ static inline void delayacct_end(struct 
 	spin_unlock(&current->delays->lock);
 }
 
+void __delayacct_blkio_start(void)
+{
+	delayacct_start(&current->delays->blkio_start);
+}
+
+void __delayacct_blkio_end(void)
+{
+	if (current->delays->flags & DELAYACCT_PF_SWAPIN)
+		/* Swapin block I/O */
+		delayacct_end(&current->delays->blkio_start,
+			&current->delays->blkio_end,
+			&current->delays->swapin_delay,
+			&current->delays->swapin_count);
+	else	/* Other block I/O */
+		delayacct_end(&current->delays->blkio_start,
+			&current->delays->blkio_end,
+			&current->delays->blkio_delay,
+			&current->delays->blkio_count);
+}
diff -puN kernel/sched.c~delayacct-blkio-swapin kernel/sched.c
--- linux-2.6.17-rc3/kernel/sched.c~delayacct-blkio-swapin	2006-04-28 23:48:43.000000000 +0530
+++ linux-2.6.17-rc3-balbir/kernel/sched.c	2006-05-02 07:05:25.000000000 +0530
@@ -50,6 +50,7 @@
 #include <linux/times.h>
 #include <linux/acct.h>
 #include <linux/kprobes.h>
+#include <linux/delayacct.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -4170,9 +4171,11 @@ void __sched io_schedule(void)
 {
 	struct runqueue *rq = &per_cpu(runqueues, raw_smp_processor_id());
 
+	delayacct_blkio_start();
 	atomic_inc(&rq->nr_iowait);
 	schedule();
 	atomic_dec(&rq->nr_iowait);
+	delayacct_blkio_end();
 }
 
 EXPORT_SYMBOL(io_schedule);
@@ -4182,9 +4185,11 @@ long __sched io_schedule_timeout(long ti
 	struct runqueue *rq = &per_cpu(runqueues, raw_smp_processor_id());
 	long ret;
 
+	delayacct_blkio_start();
 	atomic_inc(&rq->nr_iowait);
 	ret = schedule_timeout(timeout);
 	atomic_dec(&rq->nr_iowait);
+	delayacct_blkio_end();
 	return ret;
 }
 
diff -puN mm/memory.c~delayacct-blkio-swapin mm/memory.c
--- linux-2.6.17-rc3/mm/memory.c~delayacct-blkio-swapin	2006-04-28 23:48:43.000000000 +0530
+++ linux-2.6.17-rc3-balbir/mm/memory.c	2006-04-28 23:48:43.000000000 +0530
@@ -48,6 +48,7 @@
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/delayacct.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -1880,6 +1881,7 @@ static int do_swap_page(struct mm_struct
 
 	entry = pte_to_swp_entry(orig_pte);
 again:
+	delayacct_set_flag(DELAYACCT_PF_SWAPIN);
 	page = lookup_swap_cache(entry);
 	if (!page) {
  		swapin_readahead(entry, address, vma);
@@ -1892,6 +1894,7 @@ again:
 			page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 			if (likely(pte_same(*page_table, orig_pte)))
 				ret = VM_FAULT_OOM;
+			delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
 			goto unlock;
 		}
 
@@ -1903,6 +1906,7 @@ again:
 
 	mark_page_accessed(page);
 	lock_page(page);
+	delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
 	if (!PageSwapCache(page)) {
 		/* Page migration has occured */
 		unlock_page(page);
_
