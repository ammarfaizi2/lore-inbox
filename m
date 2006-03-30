Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWC3Ah1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWC3Ah1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 19:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWC3Ah1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 19:37:27 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:11034 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751309AbWC3Ah1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 19:37:27 -0500
Message-ID: <442B2836.2020708@watson.ibm.com>
Date: Wed, 29 Mar 2006 19:37:10 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 2/8] Block I/O, swapin delays
References: <442B271D.10208@watson.ibm.com>
In-Reply-To: <442B271D.10208@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

 include/linux/delayacct.h |   16 ++++++++++++++++
 include/linux/sched.h     |    7 +++++++
 kernel/delayacct.c        |   18 ++++++++++++++++++
 kernel/sched.c            |    5 +++++
 mm/memory.c               |    4 ++++
 5 files changed, 50 insertions(+)

Index: linux-2.6.16/include/linux/delayacct.h
===================================================================
--- linux-2.6.16.orig/include/linux/delayacct.h	2006-03-29 18:12:57.000000000 -0500
+++ linux-2.6.16/include/linux/delayacct.h	2006-03-29 18:13:13.000000000 -0500
@@ -25,6 +25,8 @@ extern kmem_cache_t *delayacct_cache;
 extern void delayacct_init(void);
 extern void __delayacct_tsk_init(struct task_struct *);
 extern void __delayacct_tsk_exit(struct task_struct *);
+extern void __delayacct_blkio_start(void);
+extern void __delayacct_blkio_end(void);

 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {
@@ -40,6 +42,16 @@ static inline void delayacct_tsk_exit(st
 		__delayacct_tsk_exit(tsk);
 }

+static inline void delayacct_blkio_start(void)
+{
+	if (current->delays)
+		__delayacct_blkio_start();
+}
+static inline void delayacct_blkio_end(void)
+{
+	if (current->delays)
+		__delayacct_blkio_end();
+}
 #else
 static inline void delayacct_init(void)
 {}
@@ -47,5 +59,9 @@ static inline void delayacct_tsk_init(st
 {}
 static inline void delayacct_tsk_exit(struct task_struct *tsk)
 {}
+static inline void delayacct_blkio_start(void)
+{}
+static inline void delayacct_blkio_end(void)
+{}
 #endif /* CONFIG_TASK_DELAY_ACCT */
 #endif /* _LINUX_TASKDELAYS_H */
Index: linux-2.6.16/kernel/delayacct.c
===================================================================
--- linux-2.6.16.orig/kernel/delayacct.c	2006-03-29 18:12:57.000000000 -0500
+++ linux-2.6.16/kernel/delayacct.c	2006-03-29 18:13:13.000000000 -0500
@@ -90,3 +90,21 @@ static inline void delayacct_end(struct
 	spin_unlock(&current->delays->lock);
 }

+void __delayacct_blkio_start(void)
+{
+	delayacct_start(&current->delays->blkio_start);
+}
+
+void __delayacct_blkio_end(void)
+{
+	if (current->flags & PF_SWAPIN)	/* Swapping a page in */
+		delayacct_end(&current->delays->blkio_start,
+			      &current->delays->blkio_end,
+			      &current->delays->swapin_delay,
+			      &current->delays->swapin_count);
+	else	/* Other block I/O */
+		delayacct_end(&current->delays->blkio_start,
+			      &current->delays->blkio_end,
+			      &current->delays->blkio_delay,
+			      &current->delays->blkio_count);
+}
Index: linux-2.6.16/include/linux/sched.h
===================================================================
--- linux-2.6.16.orig/include/linux/sched.h	2006-03-29 18:12:57.000000000 -0500
+++ linux-2.6.16/include/linux/sched.h	2006-03-29 18:13:13.000000000 -0500
@@ -550,6 +550,12 @@ struct task_delay_info {
 	 * u64 XXX_delay;
 	 * u32 XXX_count;
 	 */
+
+	struct timespec blkio_start, blkio_end;	/* Shared by blkio, swapin */
+	u64 blkio_delay;	/* wait for sync block io completion */
+	u64 swapin_delay;	/* wait for sync block io completion */
+	u32 blkio_count;
+	u32 swapin_count;
 };
 #endif

@@ -945,6 +951,7 @@ static inline void put_task_struct(struc
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
 #define PF_RANDOMIZE	0x00800000	/* randomize virtual address space */
 #define PF_SWAPWRITE	0x01000000	/* Allowed to write to swap */
+#define PF_SWAPIN	0x02000000	/* I am doing a swap in */

 /*
  * Only the _current_ task can read/write to tsk->flags, but other
Index: linux-2.6.16/kernel/sched.c
===================================================================
--- linux-2.6.16.orig/kernel/sched.c	2006-03-29 18:12:54.000000000 -0500
+++ linux-2.6.16/kernel/sched.c	2006-03-29 18:13:13.000000000 -0500
@@ -49,6 +49,7 @@
 #include <linux/syscalls.h>
 #include <linux/times.h>
 #include <linux/acct.h>
+#include <linux/delayacct.h>
 #include <asm/tlb.h>

 #include <asm/unistd.h>
@@ -4112,9 +4113,11 @@ void __sched io_schedule(void)
 {
 	struct runqueue *rq = &per_cpu(runqueues, raw_smp_processor_id());

+	delayacct_blkio_start();
 	atomic_inc(&rq->nr_iowait);
 	schedule();
 	atomic_dec(&rq->nr_iowait);
+	delayacct_blkio_end();
 }

 EXPORT_SYMBOL(io_schedule);
@@ -4124,9 +4127,11 @@ long __sched io_schedule_timeout(long ti
 	struct runqueue *rq = &per_cpu(runqueues, raw_smp_processor_id());
 	long ret;

+	delayacct_blkio_start();
 	atomic_inc(&rq->nr_iowait);
 	ret = schedule_timeout(timeout);
 	atomic_dec(&rq->nr_iowait);
+	delayacct_blkio_end();
 	return ret;
 }

Index: linux-2.6.16/mm/memory.c
===================================================================
--- linux-2.6.16.orig/mm/memory.c	2006-03-29 18:12:54.000000000 -0500
+++ linux-2.6.16/mm/memory.c	2006-03-29 18:13:13.000000000 -0500
@@ -1883,6 +1883,7 @@ static int do_swap_page(struct mm_struct

 	entry = pte_to_swp_entry(orig_pte);
 again:
+	current->flags |= PF_SWAPIN;
 	page = lookup_swap_cache(entry);
 	if (!page) {
  		swapin_readahead(entry, address, vma);
@@ -1895,6 +1896,7 @@ again:
 			page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 			if (likely(pte_same(*page_table, orig_pte)))
 				ret = VM_FAULT_OOM;
+			current->flags &= ~PF_SWAPIN;
 			goto unlock;
 		}

@@ -1906,6 +1908,8 @@ again:

 	mark_page_accessed(page);
 	lock_page(page);
+	current->flags &= ~PF_SWAPIN;
+
 	if (!PageSwapCache(page)) {
 		/* Page migration has occured */
 		unlock_page(page);
