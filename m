Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUKVVyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUKVVyy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 16:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbUKVVyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 16:54:05 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:56752 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262398AbUKVVvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 16:51:03 -0500
Date: Mon, 22 Nov 2004 13:50:55 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Hugh Dickins <hugh@veritas.com>
cc: torvalds@osdl.org, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: deferred rss update instead of sloppy rss
In-Reply-To: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One way to solve the rss issues is--as discussed--to put rss into the
task structure and then have the page fault increment that rss.

The problem is then that the proc filesystem must do an extensive scan
over all threads to find users of a certain mm_struct.

The following patch does put the rss into task_struct. The page fault
handler is then incrementing current->rss if the page_table_lock is not
held.

The timer interrupt checks if task->rss is non zero (when doing
stime/utime updates. rss is defined near those so its hopefully on the
same cacheline and has a minimal impact).

If rss is non zero and the page_table_lock and the mmap_sem can be taken
then the mm->rss will be updated by the value of the task->rss and
task->rss will be zeroed. This avoids all proc issues. The only
disadvantage is that rss may be inaccurate for a couple of clock ticks.

This also adds some performance (sorry only a 4p system):

sloppy rss:

Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  4  10    1    0.593s     29.897s  30.050s 85973.585  85948.565
  4  10    2    0.616s     42.184s  22.045s 61247.450 116719.558
  4  10    4    0.559s     44.918s  14.076s 57641.255 177553.945

deferred rss:
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  4  10    1    0.565s     29.429s  30.000s 87395.518  87366.580
  4  10    2    0.500s     33.514s  18.002s 77067.935 145426.659
  4  10    4    0.533s     44.455s  14.085s 58269.368 176413.196

Index: linux-2.6.9/include/linux/sched.h
===================================================================
--- linux-2.6.9.orig/include/linux/sched.h	2004-11-15 11:13:39.000000000 -0800
+++ linux-2.6.9/include/linux/sched.h	2004-11-22 13:18:58.000000000 -0800
@@ -584,6 +584,10 @@
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
 	unsigned long utime, stime;
+	long rss;	/* rss counter when mm->rss is not usable. mm->page_table_lock
+			 * not held but mm->mmap_sem must be held for sync with
+			 * the timer interrupt which clears rss and updates mm->rss.
+			 */
 	unsigned long nvcsw, nivcsw; /* context switch counts */
 	struct timespec start_time;
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
Index: linux-2.6.9/mm/rmap.c
===================================================================
--- linux-2.6.9.orig/mm/rmap.c	2004-11-22 09:51:58.000000000 -0800
+++ linux-2.6.9/mm/rmap.c	2004-11-22 11:16:02.000000000 -0800
@@ -263,8 +263,6 @@
 	pte_t *pte;
 	int referenced = 0;

-	if (!mm->rss)
-		goto out;
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
 		goto out;
@@ -507,8 +505,6 @@
 	pte_t pteval;
 	int ret = SWAP_AGAIN;

-	if (!mm->rss)
-		goto out;
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
 		goto out;
@@ -791,8 +787,7 @@
 			if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
 				continue;
 			cursor = (unsigned long) vma->vm_private_data;
-			while (vma->vm_mm->rss &&
-				cursor < max_nl_cursor &&
+			while (cursor < max_nl_cursor &&
 				cursor < vma->vm_end - vma->vm_start) {
 				try_to_unmap_cluster(cursor, &mapcount, vma);
 				cursor += CLUSTER_SIZE;
Index: linux-2.6.9/kernel/fork.c
===================================================================
--- linux-2.6.9.orig/kernel/fork.c	2004-11-22 09:51:58.000000000 -0800
+++ linux-2.6.9/kernel/fork.c	2004-11-22 11:16:02.000000000 -0800
@@ -876,6 +876,7 @@
 	p->io_context = NULL;
 	p->io_wait = NULL;
 	p->audit_context = NULL;
+	p->rss = 0;
 #ifdef CONFIG_NUMA
  	p->mempolicy = mpol_copy(p->mempolicy);
  	if (IS_ERR(p->mempolicy)) {
Index: linux-2.6.9/kernel/exit.c
===================================================================
--- linux-2.6.9.orig/kernel/exit.c	2004-11-22 09:51:58.000000000 -0800
+++ linux-2.6.9/kernel/exit.c	2004-11-22 11:16:02.000000000 -0800
@@ -501,6 +501,9 @@
 	/* more a memory barrier than a real lock */
 	task_lock(tsk);
 	tsk->mm = NULL;
+	/* only holding mmap_sem here maybe get page_table_lock too? */
+	mm->rss += tsk->rss;
+	tsk->rss = 0;
 	up_read(&mm->mmap_sem);
 	enter_lazy_tlb(mm, current);
 	task_unlock(tsk);
Index: linux-2.6.9/kernel/timer.c
===================================================================
--- linux-2.6.9.orig/kernel/timer.c	2004-11-22 09:51:58.000000000 -0800
+++ linux-2.6.9/kernel/timer.c	2004-11-22 11:42:12.000000000 -0800
@@ -815,6 +815,15 @@
 		if (psecs / HZ >= p->signal->rlim[RLIMIT_CPU].rlim_max)
 			send_sig(SIGKILL, p, 1);
 	}
+	/* Update mm->rss if necessary */
+	if (p->rss && p->mm && down_write_trylock(&p->mm->mmap_sem)) {
+		if (spin_trylock(&p->mm->page_table_lock)) {
+			p->mm->rss += p->rss;
+			p->rss = 0;
+			spin_unlock(&p->mm->page_table_lock);
+		}
+		up_write(&p->mm->mmap_sem);
+	}
 }

 static inline void do_it_virt(struct task_struct * p, unsigned long ticks)

