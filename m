Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262436AbRGNQ25>; Sat, 14 Jul 2001 12:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262568AbRGNQ2s>; Sat, 14 Jul 2001 12:28:48 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:52912 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S262436AbRGNQ2d>; Sat, 14 Jul 2001 12:28:33 -0400
Message-ID: <3B507380.79381536@uow.edu.au>
Date: Sun, 15 Jul 2001 02:29:52 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>, Mike Black <mblack@csihq.com>
CC: lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: raid5d, page_launder and scheduling latency
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ext3 on raid5 is showing very poor performance with some VM-intensive
workloads.  The reason for this is that page_launder is preventing
scheduling of the `raid5d' thread.

As the inactive_dirty list gets larger and larger, page_launder takes
longer and longer.  The latency between waking and running raid5d gets
longer and longer, so the disk write throughput gets lower and lower,
so the inactive_dirty list gets longer and longer, etc.  It's a
positive feedback loop which leads to collapse.

It is *much* worse on SMP - probably because I haven't found the right
workload to trigger it on UP.  It is much worse with highmem - I think
something's broken with page reclaim and highmem - Marcelo's stats show
it up.

The overall throughput seems to drop to about 1/20th of what it should
be, or worse.  The same could happen with ext2 or any other filesystem.

Here is a histogram of the time it takes between waking and actually
running the raid5d thread when things are gummed up.  For a five second
period:

Milliseconds		   # occurrences

	0   			132
	1   			3
	2   			1
	3   			1
	24  			1
	28  			1
	31  			1
	284 			1
	296 			1
	298 			1
	500 			1
	962 			1
	1161			1
	1297			1

This machine has only 512 megs of RAM.  The effect will presumably
be worse with more memory.

The raid5 code wakes up raid5d from interrupt context, and from inside
locks, so a sched_yield there is not a comfortable or general fix.

Adding a rescheduling point to page_launder fixes the gross congestion
and gets the histogram down to:

0   			529
1   			7
2   			13
3   			59
4   			44
5   			3
6   			3
7   			6
8   			7
9   			10
10  			10
11  			18
12  			11
13  			6
14  			1
15  			3

Which is still pretty bad - across a five-second run there is a lot of
time there not spent submitting IOs.

So flush_dirty_buffers() needs fixing as well and that brings the
raid5d stalls down to a few milliseconds with the tiobench workload.

With one-megabyte writes, raid5d is stalled by 10-20 milliseconds, so
we need to fix generic_file_read() and generic_file_write().

Happily, we've just fixed the four most gross sources of poor
interactivity in the kernel, so let's knock over some of the others as
well - a few /proc functions.  That mainly leaves zap_page_range() and
exit() with a lot of open files.

Neil, I'd be interested if this makes much difference with ext2 on
software RAID - the problem materialises under really heavy write pressure.
tiobench with a file twice the size of physical RAM shows it up.  




--- linux-2.4.7-pre6/mm/filemap.c	Thu Jul 12 11:09:53 2001
+++ linux-akpm/mm/filemap.c	Sun Jul 15 02:26:20 2001
@@ -1146,6 +1146,9 @@ found_page:
 		page_cache_get(page);
 		spin_unlock(&pagecache_lock);
 
+		if (current->need_resched)
+			schedule();
+
 		if (!Page_Uptodate(page))
 			goto page_not_up_to_date;
 		generic_file_readahead(reada_ok, filp, inode, page);
@@ -2642,6 +2645,9 @@ generic_file_write(struct file *file,con
 		if (!PageLocked(page)) {
 			PAGE_BUG(page);
 		}
+
+		if (current->need_resched)
+			schedule();
 
 		status = mapping->a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (status)
--- linux-2.4.7-pre6/mm/vmscan.c	Thu Jul 12 11:09:53 2001
+++ linux-akpm/mm/vmscan.c	Sun Jul 15 02:26:20 2001
@@ -439,8 +439,17 @@ int page_launder(int gfp_mask, int sync)
 dirty_page_rescan:
 	spin_lock(&pagemap_lru_lock);
 	maxscan = nr_inactive_dirty_pages;
+rescan:
 	while ((page_lru = inactive_dirty_list.prev) != &inactive_dirty_list &&
 				maxscan-- > 0) {
+		if (current->need_resched) {
+			spin_unlock(&pagemap_lru_lock);
+			__set_current_state(TASK_RUNNING);
+			schedule();
+			spin_lock(&pagemap_lru_lock);
+			maxscan++;
+			goto rescan;
+		}
 		page = list_entry(page_lru, struct page, lru);
 
 		/* Wrong page on list?! (list corruption, should not happen) */
--- linux-2.4.7-pre6/fs/buffer.c	Thu Jul 12 11:09:53 2001
+++ linux-akpm/fs/buffer.c	Sun Jul 15 02:26:20 2001
@@ -2552,13 +2552,27 @@ static int flush_dirty_buffers(int check
 {
 	struct buffer_head * bh, *next;
 	int flushed = 0, i;
+	int nr_todo = nr_buffers_type[BUF_DIRTY] * 2;
 
- restart:
+	__set_current_state(TASK_RUNNING);
+restart:
 	spin_lock(&lru_list_lock);
 	bh = lru_list[BUF_DIRTY];
 	if (!bh)
 		goto out_unlock;
 	for (i = nr_buffers_type[BUF_DIRTY]; i-- > 0; bh = next) {
+		/*
+		 * If dirty buffers are being added fast enough, this function
+		 * may never terminate.  Prevent that with `nr_todo'.
+		 */
+		if (nr_todo) {
+			if (current->need_resched) {
+				spin_unlock(&lru_list_lock);
+				schedule();
+				goto restart;
+			}
+			nr_todo--;
+		}
 		next = bh->b_next_free;
 
 		if (!buffer_dirty(bh)) {
@@ -2585,9 +2599,6 @@ static int flush_dirty_buffers(int check
 		spin_unlock(&lru_list_lock);
 		ll_rw_block(WRITE, 1, &bh);
 		put_bh(bh);
-
-		if (current->need_resched)
-			schedule();
 		goto restart;
 	}
  out_unlock:
--- linux-2.4.7-pre6/fs/proc/array.c	Wed Jul  4 18:21:31 2001
+++ linux-akpm/fs/proc/array.c	Sun Jul 15 02:26:20 2001
@@ -414,6 +414,9 @@ static inline void statm_pte_range(pmd_t
 		pte_t page = *pte;
 		struct page *ptpage;
 
+		if (current->need_resched)
+			schedule();	/* For `top' and `ps' */
+
 		address += PAGE_SIZE;
 		pte++;
 		if (pte_none(page))
--- linux-2.4.7-pre6/fs/proc/generic.c	Wed Jul  4 18:21:31 2001
+++ linux-akpm/fs/proc/generic.c	Sun Jul 15 02:26:20 2001
@@ -98,6 +98,9 @@ proc_file_read(struct file * file, char 
 				retval = n;
 			break;
 		}
+
+		if (current->need_resched)
+			schedule();	/* Some proc files are large */
 		
 		/* This is a hack to allow mangling of file pos independent
  		 * of actual bytes read.  Simply place the data at page,
