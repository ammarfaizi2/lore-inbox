Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266670AbUHIO1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266670AbUHIO1A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266633AbUHIOYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:24:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:8383 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266611AbUHIOUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:20:42 -0400
Date: Mon, 9 Aug 2004 16:01:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       Robert Love <rml@ximian.com>
Subject: [patch] preempt-smp.patch, 2.6.8-rc3-mm2
Message-ID: <20040809140103.GA18106@elte.hu>
References: <20040809102125.GA12391@elte.hu> <20040809032523.40250fe8.akpm@osdl.org> <20040809104533.GA13710@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20040809104533.GA13710@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Ingo Molnar <mingo@elte.hu> wrote:

> i believe we should 'ignore' SMP spinlock starvation for now: it will
> be fixed in a natural way with the most-spinlocks-are-mutexes
> solution, with that approach all preemption wishes of other CPUs are
> properly expressed in terms of need_resched().
> 
> alternatively the 'release the lock every 128 iterations and do a
> cpu_relax()' hack could be used - but i think that doesnt solve the
> SMP issues in a sufficient way.

i've attached preempt-smp.patch (against 2.6.8-rc3-mm) which cleans up
most of these scheduling issues. It does the loop counting within
cond_resched_lock(). [and uninlines those functions for smaller
footprint.]

[ the loop counter is free-running so the counts of different loops get
concatenated - this is not a big issue and i dont think we want to touch
the loop counter every time we disable preemption (or enter a loop). ]

this patch in essence recognizes the fact that the current preemption
design is broken on SMP. It works the issue around by adding the polling
component to need_resched_lock(). These loop-checks used to be
open-coded in quite ugly ways.

the patch shows all the variants that occur typically: locked loop that
can be broken without state worries, and locked loops that need to
modify state to preempt safely.

the patch also fixes all the open-coded paths that did either
loop-counting or need-resched-checking and fixes a number of bugs that
occur with such open-coding: either the loop-counting or the
need-resched checking was missing.

once the need_resched() problem is solved cleanly by using mutexes for
all exclusion activity on SMP, this polling component can be removed.

i've tested the patch on x86 UP and SMP. (CONFIG_PREEMPT enabled.)

	Ingo

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="preempt-smp.patch"


> alternatively the 'release the lock every 128 iterations and do a
> cpu_relax()' hack could be used - but i think that doesnt solve the
> SMP issues in a sufficient way.

i've attached preempt-smp.patch (against -mm) which cleans up most of
these scheduling issues. It does the loop counting within
cond_resched_lock(). [and uninlines those functions for smaller
footprint.]

[ the loop counter is free-running so the counts of different loops get
concatenated - this is not a big issue and i dont think we want to touch
the loop counter every time we disable preemption (or enter a loop). ]

this patch in essence recognizes the fact that the current preemption
design is broken on SMP. It works the issue around by adding the polling
component to need_resched_lock(). These loop-checks used to be
open-coded in quite ugly ways.

the patch shows all the variants that occur typically: locked loop that
can be broken without state worries, and locked loops that need to
modify state to preempt safely.

the patch also fixes all the open-coded paths that did either
loop-counting or need-resched-checking and fixes a number of bugs that
occur with such open-coding: either the loop-counting or the
need-resched checking was missing.

once the need_resched() problem is solved cleanly by using mutexes for
all exclusion activity on SMP, this polling component can be removed.

i've tested the patch on x86 UP and SMP. (CONFIG_PREEMPT enabled.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -966,12 +966,7 @@ static inline int need_resched(void)
 	return unlikely(test_thread_flag(TIF_NEED_RESCHED));
 }
 
-extern void __cond_resched(void);
-static inline void cond_resched(void)
-{
-	if (need_resched())
-		__cond_resched();
-}
+extern void cond_resched(void);
 
 /*
  * cond_resched_lock() - if a reschedule is pending, drop the given lock,
@@ -981,15 +976,8 @@ static inline void cond_resched(void)
  * operations here to prevent schedule() from being called twice (once via
  * spin_unlock(), once by hand).
  */
-static inline void cond_resched_lock(spinlock_t * lock)
-{
-	if (need_resched()) {
-		_raw_spin_unlock(lock);
-		preempt_enable_no_resched();
-		__cond_resched();
-		spin_lock(lock);
-	}
-}
+extern int cond_resched_lock(spinlock_t *lock);
+extern int need_resched_lock(void);
 
 /* Reevaluate whether the task has signals pending delivery.
    This is required every time the blocked sigset_t changes.
--- linux/fs/jbd/checkpoint.c.orig	
+++ linux/fs/jbd/checkpoint.c	
@@ -504,7 +504,7 @@ int __journal_clean_checkpoint_list(jour
 		 * We don't test cond_resched() here because another CPU could
 		 * be waiting on j_list_lock() while holding a different lock.
 		 */
-		if (journal->j_checkpoint_transactions && (ret & 127) == 127) {
+		if (journal->j_checkpoint_transactions && need_resched_lock()) {
 			/*
 			 * We need to schedule away.  Rotate both this
 			 * transaction's buffer list and the checkpoint list to
--- linux/fs/jbd/commit.c.orig	
+++ linux/fs/jbd/commit.c	
@@ -271,9 +271,8 @@ write_out_data:
 						BJ_Locked);
 			jbd_unlock_bh_state(bh);
 			nr_buffers++;
-			if ((nr_buffers & 15) == 0 || need_resched()) {
+			if (cond_resched_lock(&journal->j_list_lock)) {
 				spin_unlock(&journal->j_list_lock);
-				cpu_relax();
 				goto write_out_data;
 			}
 		} else {
@@ -299,9 +298,8 @@ write_out_data:
 				journal_remove_journal_head(bh);
 				put_bh(bh);
 				nr_buffers++;
-				if ((nr_buffers & 15) == 0 || need_resched()) {
+				if (cond_resched_lock(&journal->j_list_lock)) {
 					spin_unlock(&journal->j_list_lock);
-					cpu_relax();
 					goto write_out_data;
 				}
 			}
@@ -346,11 +344,7 @@ write_out_data:
 		}
 		put_bh(bh);
 		nr_buffers++;
-		if ((nr_buffers & 15) == 0 || need_resched()) {
-			spin_unlock(&journal->j_list_lock);
-			cond_resched();
-			spin_lock(&journal->j_list_lock);
-		}
+		cond_resched_lock(&journal->j_list_lock);
 	}
 	spin_unlock(&journal->j_list_lock);
 
--- linux/fs/inode.c.orig	
+++ linux/fs/inode.c	
@@ -296,7 +296,7 @@ static void dispose_list(struct list_hea
 /*
  * Invalidate all inodes for a device.
  */
-static int invalidate_list(struct list_head *head, struct list_head *dispose)
+static int invalidate_list(struct list_head *head, struct list_head *dispose, struct list_head *mark)
 {
 	struct list_head *next;
 	int busy = 0, count = 0;
@@ -306,6 +306,21 @@ static int invalidate_list(struct list_h
 		struct list_head * tmp = next;
 		struct inode * inode;
 
+		/*
+		 * Preempt if necessary. To make this safe we use a dummy
+		 * inode as a marker - we can continue off that point.
+		 * We rely on this sb's inodes (including the marker) not
+		 * getting reordered within the list during umount. Other
+		 * inodes might get reordered.
+		 */
+		if (need_resched_lock()) {
+			list_add_tail(mark, next);
+			spin_unlock(&inode_lock);
+			cond_resched();
+			spin_lock(&inode_lock);
+			tmp = next = mark->next;
+			list_del(mark);
+		}
 		next = next->next;
 		if (tmp == head)
 			break;
@@ -346,15 +361,21 @@ int invalidate_inodes(struct super_block
 {
 	int busy;
 	LIST_HEAD(throw_away);
+	struct inode *marker;
+
+	marker = kmalloc(sizeof(*marker), GFP_KERNEL|__GFP_REPEAT);
+	memset(marker, 0, sizeof(*marker));
 
 	down(&iprune_sem);
 	spin_lock(&inode_lock);
-	busy = invalidate_list(&sb->s_inodes, &throw_away);
+	busy = invalidate_list(&sb->s_inodes, &throw_away, &marker->i_list);
 	spin_unlock(&inode_lock);
 
 	dispose_list(&throw_away);
 	up(&iprune_sem);
 
+	kfree(marker);
+
 	return busy;
 }
 
@@ -425,6 +446,8 @@ static void prune_icache(int nr_to_scan)
 	for (nr_scanned = 0; nr_scanned < nr_to_scan; nr_scanned++) {
 		struct inode *inode;
 
+		cond_resched_lock(&inode_lock);
+
 		if (list_empty(&inode_unused))
 			break;
 
--- linux/net/ipv4/tcp_minisocks.c.orig	
+++ linux/net/ipv4/tcp_minisocks.c	
@@ -511,13 +511,8 @@ static void twkill_work(void *dummy)
 			if (!(twkill_thread_slots & (1 << i)))
 				continue;
 
-			while (tcp_do_twkill_work(i, TCP_TWKILL_QUOTA) != 0) {
-				if (need_resched()) {
-					spin_unlock_bh(&tw_death_lock);
-					schedule();
-					spin_lock_bh(&tw_death_lock);
-				}
-			}
+			while (tcp_do_twkill_work(i, TCP_TWKILL_QUOTA) != 0)
+				cond_resched_lock(&tw_death_lock);
 
 			twkill_thread_slots &= ~(1 << i);
 		}
--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -3459,13 +3459,64 @@ asmlinkage long sys_sched_yield(void)
 	return 0;
 }
 
-void __sched __cond_resched(void)
+void __sched cond_resched(void)
 {
-	set_current_state(TASK_RUNNING);
-	schedule();
+	if (need_resched()) {
+		set_current_state(TASK_RUNNING);
+		schedule();
+	}
 }
 
-EXPORT_SYMBOL(__cond_resched);
+EXPORT_SYMBOL(cond_resched);
+
+/*
+ * break out of a lock if preemption is necessary.
+ *
+ * cond_resched_lock() is also used to ensure spinlock fairness
+ * on SMP, we break out of the lock every now and then, to handle
+ * the possibility of another CPU waiting for us:
+ */
+#ifdef CONFIG_SMP
+static DEFINE_PER_CPU(unsigned long, preempt_check_count);
+#endif
+
+int __sched cond_resched_lock(spinlock_t * lock)
+{
+	if (need_resched()) {
+		_raw_spin_unlock(lock);
+		preempt_enable_no_resched();
+		set_current_state(TASK_RUNNING);
+		schedule();
+		spin_lock(lock);
+		return 1;
+	}
+#ifdef CONFIG_SMP
+	if (!(__get_cpu_var(preempt_check_count)++ & 63)) {
+		spin_unlock(lock);
+		cpu_relax();
+		spin_lock(lock);
+		return 1;
+	}
+#endif
+	return 0;
+}
+
+EXPORT_SYMBOL(cond_resched_lock);
+
+int __sched need_resched_lock(void)
+{
+	if (need_resched())
+		return 1;
+#ifdef CONFIG_SMP
+	if (!(__get_cpu_var(preempt_check_count)++ & 63))
+		return 1;
+#endif
+	return 0;
+}
+
+EXPORT_SYMBOL(need_resched_lock);
+
+
 
 /**
  * yield - yield the current processor to other threads.
--- linux/mm/memory.c.orig	
+++ linux/mm/memory.c	
@@ -710,7 +710,6 @@ int get_user_pages(struct task_struct *t
 	int i;
 	int vm_io;
 	unsigned int flags;
-	int nr_pages = 0;
 
 	/* 
 	 * Require read or write permissions.
@@ -774,12 +773,7 @@ int get_user_pages(struct task_struct *t
 			struct page *map = NULL;
 			int lookup_write = write;
 
-			if ((++nr_pages & 63) == 0) {
-				spin_unlock(&mm->page_table_lock);
-				cpu_relax();
-				spin_lock(&mm->page_table_lock);
-			}
-
+			cond_resched_lock(&mm->page_table_lock);
 			/*
 			 * We don't follow pagetables for VM_IO regions - they
 			 * may have no pageframes.

--y0ulUmNC+osPPQO6--
