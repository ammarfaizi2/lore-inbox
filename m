Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266065AbUGZVVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266065AbUGZVVk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 17:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265938AbUGZVVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 17:21:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:4228 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265724AbUGZVNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 17:13:23 -0400
Date: Mon, 26 Jul 2004 14:11:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: rlrevell@joe-job.com, wli@holomorphy.com, lenar@vision.ee,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-J3
Message-Id: <20040726141143.6d8352b6.akpm@osdl.org>
In-Reply-To: <20040726203634.GA26096@elte.hu>
References: <20040713122805.GZ21066@holomorphy.com>
	<40F3F0A0.9080100@vision.ee>
	<20040713143947.GG21066@holomorphy.com>
	<1090732537.738.2.camel@mindpipe>
	<1090795742.719.4.camel@mindpipe>
	<20040726082330.GA22764@elte.hu>
	<1090830574.6936.96.camel@mindpipe>
	<20040726083537.GA24948@elte.hu>
	<20040726125750.5e467cfd.akpm@osdl.org>
	<20040726203634.GA26096@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> ...
> guaranteeing latencies on SMP is hard, because the latency of a CPU
> might depend on the latency of a task on another CPU - which CPU isnt
> notified of the rescheduling request.
> 
> one alternative technique to yours would be to notify _all_ CPUs that a
> high-prio RT task is ready to run (via a broadcast need-resched). That
> way the UP latency-break techniques map to SMP in a 1:1 way.

I did exactly that in the 2.4 ll patch.  It works, but doesn't seem very nice.

> non-RT tasks dont get this benefit, which is a difference to the UP
> situation, but i dont think it would be appropriate to use the UP
> behavior, due to the overhead of broadcasting.
> 
> a combination of the two techniques could be used too: a global 'break
> locks from now on' flag which gets set if a (RT?) task wants to
> reschedule. Normally this flag would be zero and the cacheline would be
> clean and shared between all CPUs, causing no overhead. Once a task
> wants to reschedule it would increase by 1 until that task has been
> scheduled.

Something like that.  The obscure livelock opportunities worry me.

> This would remove the ugliness factor too, your sample code
> would look:
> 
> > +			if (need_lock_break()) {
> > +				spin_unlock(&mm->page_table_lock);
> > +				cpu_relax();
> > +				spin_lock(&mm->page_table_lock);
> > +			}
> > +
> 
> or a shortcut:
> 
> > +			cond_lock_break(&mm->page_table_lock);

The usual problem is, of course, long-running loops under locks.  These
loops usually have some sort of counter (or you add one).  The below patch
changes cond_resched_lock() so that it takes the counter, and the tuned
upper-loop-count limit.  It also does the right thing on UP.  It needs
enhancements for the situations where we already have a counter in the
loop.

I dunno if it's sufficient, but I do think that we need to settle on some
infrastructure of this sort before proceeding too far into this thing.

> there are two problems with the unconditional lock-break:
> 
>  - i'm not sure cpu_relax() guarantees that another CPU can grab this 
>    lock. It all depends on whether the lock cacheline can bounce over 
>    to the other CPU faster than cpu_relax() finishes and this CPU
>    re-acquires the lock.

precisely.


diff -puN include/linux/sched.h~cond_resched_lock-smp-fix include/linux/sched.h
--- 25/include/linux/sched.h~cond_resched_lock-smp-fix	2004-07-13 16:58:42.445155480 -0700
+++ 25-akpm/include/linux/sched.h	2004-07-13 17:02:56.194579704 -0700
@@ -1038,22 +1038,32 @@ static inline void cond_resched(void)
 }
 
 /*
- * cond_resched_lock() - if a reschedule is pending, drop the given lock,
- * call schedule, and on return reacquire the lock.
- *
  * This works OK both with and without CONFIG_PREEMPT.  We do strange low-level
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
+
+#ifdef CONFIG_SMP
+#define cond_resched_lock(lock, counter, limit)		\
+	do {						\
+		if (++(counter) >= limit) {		\
+			spin_unlock(lock);		\
+			cpu_relax();			\
+			spin_lock(lock);		\
+		}					\
+		(counter) = 0;				\
+	} while (0)
+#else
+#define cond_resched_lock(lock, counter, limit)		\
+	do {						\
+		if (need_resched()) {			\
+			_raw_spin_unlock(lock);		\
+			preempt_enable_no_resched();	\
+			__cond_resched();		\
+			spin_lock(lock);		\
+		}					\
+	} while (0)
+#endif
 
 /* Reevaluate whether the task has signals pending delivery.
    This is required every time the blocked sigset_t changes.
diff -puN fs/reiserfs/journal.c~cond_resched_lock-smp-fix fs/reiserfs/journal.c
--- 25/fs/reiserfs/journal.c~cond_resched_lock-smp-fix	2004-07-13 16:58:42.462152896 -0700
+++ 25-akpm/fs/reiserfs/journal.c	2004-07-13 17:03:43.131444216 -0700
@@ -796,6 +796,7 @@ static int write_ordered_buffers(spinloc
     struct buffer_chunk chunk;
     struct list_head tmp;
     INIT_LIST_HEAD(&tmp);
+    int resched_counter = 0;
 
     chunk.nr = 0;
     spin_lock(lock);
@@ -827,7 +828,7 @@ static int write_ordered_buffers(spinloc
 	}
 loop_next:
 	put_bh(bh);
-	cond_resched_lock(lock);
+	cond_resched_lock(lock, resched_counter, 64);
     }
     if (chunk.nr) {
 	spin_unlock(lock);
@@ -848,7 +849,7 @@ loop_next:
 	if (!buffer_uptodate(bh))
 	    ret = -EIO;
 	put_bh(bh);
-	cond_resched_lock(lock);
+	cond_resched_lock(lock, resched_counter, 64);
     }
     spin_unlock(lock);
     return ret;
diff -puN mm/shmem.c~cond_resched_lock-smp-fix mm/shmem.c
--- 25/mm/shmem.c~cond_resched_lock-smp-fix	2004-07-13 16:58:42.487149096 -0700
+++ 25-akpm/mm/shmem.c	2004-07-13 17:04:06.310920400 -0700
@@ -424,6 +424,7 @@ static void shmem_truncate(struct inode 
 	swp_entry_t *ptr;
 	int offset;
 	int freed;
+	int resched_counter = 0;
 
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	idx = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
@@ -496,7 +497,7 @@ static void shmem_truncate(struct inode 
 				shmem_free_block(inode);
 			}
 			empty = subdir;
-			cond_resched_lock(&info->lock);
+			cond_resched_lock(&info->lock, resched_counter, 32);
 			dir = shmem_dir_map(subdir);
 		}
 		subdir = *dir;
diff -puN mm/memory.c~cond_resched_lock-smp-fix mm/memory.c
--- 25/mm/memory.c~cond_resched_lock-smp-fix	2004-07-13 16:58:42.504146512 -0700
+++ 25-akpm/mm/memory.c	2004-07-13 17:05:43.943078056 -0700
@@ -224,6 +224,7 @@ int copy_page_range(struct mm_struct *ds
 	unsigned long address = vma->vm_start;
 	unsigned long end = vma->vm_end;
 	unsigned long cow;
+	int resched_counter = 0;
 
 	if (is_vm_hugetlb_page(vma))
 		return copy_hugetlb_page_range(dst, src, vma);
@@ -341,7 +342,8 @@ cont_copy_pte_range_noset:
 			pte_unmap_nested(src_pte-1);
 			pte_unmap(dst_pte-1);
 			spin_unlock(&src->page_table_lock);
-			cond_resched_lock(&dst->page_table_lock);
+			cond_resched_lock(&dst->page_table_lock,
+						resched_counter, 256);
 cont_copy_pmd_range:
 			src_pmd++;
 			dst_pmd++;
@@ -530,6 +532,7 @@ int unmap_vmas(struct mmu_gather **tlbp,
 	int tlb_start_valid = 0;
 	int ret = 0;
 	int atomic = details && details->atomic;
+	int resched_counter = 0;
 
 	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next) {
 		unsigned long start;
@@ -567,10 +570,11 @@ int unmap_vmas(struct mmu_gather **tlbp,
 			zap_bytes -= block;
 			if ((long)zap_bytes > 0)
 				continue;
-			if (!atomic && need_resched()) {
+			if (!atomic) {
 				int fullmm = tlb_is_full_mm(*tlbp);
 				tlb_finish_mmu(*tlbp, tlb_start, start);
-				cond_resched_lock(&mm->page_table_lock);
+				cond_resched_lock(&mm->page_table_lock,
+						resched_counter, 1);
 				*tlbp = tlb_gather_mmu(mm, fullmm);
 				tlb_start_valid = 0;
 			}
diff -puN mm/rmap.c~cond_resched_lock-smp-fix mm/rmap.c
--- 25/mm/rmap.c~cond_resched_lock-smp-fix	2004-07-13 16:58:42.521143928 -0700
+++ 25-akpm/mm/rmap.c	2004-07-13 17:06:59.866535936 -0700
@@ -661,6 +661,7 @@ static inline int try_to_unmap_file(stru
 	unsigned long max_nl_cursor = 0;
 	unsigned long max_nl_size = 0;
 	unsigned int mapcount;
+	int resched_counter = 0;
 
 	if (!spin_trylock(&mapping->i_mmap_lock))
 		return ret;
@@ -699,7 +700,7 @@ static inline int try_to_unmap_file(stru
 	 */
 	mapcount = page->mapcount;
 	page_map_unlock(page);
-	cond_resched_lock(&mapping->i_mmap_lock);
+	cond_resched_lock(&mapping->i_mmap_lock, resched_counter, 1);
 
 	max_nl_size = (max_nl_size + CLUSTER_SIZE - 1) & CLUSTER_MASK;
 	if (max_nl_cursor == 0)
@@ -728,7 +729,7 @@ static inline int try_to_unmap_file(stru
 					(void *) max_nl_cursor;
 			ret = SWAP_AGAIN;
 		}
-		cond_resched_lock(&mapping->i_mmap_lock);
+		cond_resched_lock(&mapping->i_mmap_lock, resched_counter, 8);
 		max_nl_cursor += CLUSTER_SIZE;
 	} while (max_nl_cursor <= max_nl_size);
 
_

