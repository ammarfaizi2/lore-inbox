Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289127AbSAGFhx>; Mon, 7 Jan 2002 00:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289128AbSAGFho>; Mon, 7 Jan 2002 00:37:44 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:62731 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289127AbSAGFhc>; Mon, 7 Jan 2002 00:37:32 -0500
Message-ID: <3C3932E5.7A7BE886@zip.com.au>
Date: Sun, 06 Jan 2002 21:32:21 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] mini-lowlatency
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a patch which improves the kernel's scheduling latency under
heavy filesystem activity.  I am proposing this for the 2.4 series.
Parts of it are from the -aa patchset.

It adds ten rescheduling points and pops spinlocks in two places.  It's
all pretty obvious and safe, apart from the ext3 chunk which required some
thought.

Testing was on an 850MHz PIII with 768 megabytes of RAM.  The workload
executed was:

cd /usr/src/linux
make -j3 bzImage
make clean
cd /mnt/hda7
tar xfz /nfs-mountpoint/linux-2.4.10.tar.gz
rm -rf linux
dd if=/dev/zero of=foo bs=1M count=400
rm foo
cvs co dbench
cd dbench
make
./dbench 40
sync
cd ..
rm -rf dbench

In conjunction with this, the `realfeel2' app from
http://www.zip.com.au/~akpm/linux/amlat.tar.gz was used to accumulate a
histogram of the latency between occurrence of an interrupt and the
scheduling of the userspace process which was woken as a result of that
interrupt.

Testing is against 2.4.18-pre1.  The table shows the number of times a
particular latency was encountered with this workload, for various
patchsets.  The filesystem was ext3.   ext2 does better.

                      Latency (milliseconds)
Kernel                0-1      1-2  2-4  4-8  8-16  16-32  32-64  64-128  128-256

Stock                 1.2e6    365  32   33   417    11     11     4

rml-preempt           5.0e6    119  26   22   11     8      13     3        1

mini-ll               1.8e6    217  15   15   8      9      1

mini-ll+rml-preempt   1.4e6    96   14   7    4      2      5      1

low-latency           1.3e6    18   1


The 5.0e6 count on the second row is due to extra idle time (I hadn't
scripted the test).

This is a logarithmic representation, so the mini-ll improvements do
not look really fantastic, but in fact it is a very considerable
improvement.  Worst-case latency is 36 milliseconds (versus 84 for the
stock kernel).

Bear in mind that the intent here is mouse-no-jerky and less
audio dropouts.  If the requirement is for very low worst-case,
you'll still need a low-latency patch.  Here's the full histogram
for the latest low-latency patch:

0.0 1271218
0.1 4554
0.2 472
0.3 78
0.4 10
0.5 5
0.6 24
0.7 27
0.8 20
0.9 10
1.0 15
1.1 1
1.2 1
1.7 1
3.2 1

Which is butt-kicking.  It can be improved by minimising the amount
of online swapspace.  scan_swap_map().


--- linux-2.4.18-pre1/fs/buffer.c	Fri Dec 21 11:19:14 2001
+++ linux-akpm/fs/buffer.c	Sun Jan  6 01:06:41 2002
@@ -249,12 +249,19 @@ static int wait_for_buffers(kdev_t dev, 
 	struct buffer_head * next;
 	int nr;
 
-	next = lru_list[index];
 	nr = nr_buffers_type[index];
+repeat:
+	next = lru_list[index];
 	while (next && --nr >= 0) {
 		struct buffer_head *bh = next;
 		next = bh->b_next_free;
 
+		if (dev == NODEV && current->need_resched) {
+			spin_unlock(&lru_list_lock);
+			conditional_schedule();
+			spin_lock(&lru_list_lock);
+			goto repeat;
+		}
 		if (!buffer_locked(bh)) {
 			if (refile)
 				__refile_buffer(bh);
@@ -1174,8 +1181,10 @@ struct buffer_head * bread(kdev_t dev, i
 
 	bh = getblk(dev, block, size);
 	touch_buffer(bh);
-	if (buffer_uptodate(bh))
+	if (buffer_uptodate(bh)) {
+		conditional_schedule();
 		return bh;
+	}
 	ll_rw_block(READ, 1, &bh);
 	wait_on_buffer(bh);
 	if (buffer_uptodate(bh))
--- linux-2.4.18-pre1/fs/dcache.c	Fri Dec 21 11:19:14 2001
+++ linux-akpm/fs/dcache.c	Sat Jan  5 23:49:00 2002
@@ -71,7 +71,7 @@ static inline void d_free(struct dentry 
  * d_iput() operation if defined.
  * Called with dcache_lock held, drops it.
  */
-static inline void dentry_iput(struct dentry * dentry)
+static void dentry_iput(struct dentry * dentry)
 {
 	struct inode *inode = dentry->d_inode;
 	if (inode) {
@@ -84,6 +84,7 @@ static inline void dentry_iput(struct de
 			iput(inode);
 	} else
 		spin_unlock(&dcache_lock);
+	conditional_schedule();
 }
 
 /* 
--- linux-2.4.18-pre1/fs/jbd/commit.c	Fri Dec 21 11:19:14 2001
+++ linux-akpm/fs/jbd/commit.c	Sun Jan  6 02:43:43 2002
@@ -212,6 +212,16 @@ write_out_data_locked:
 				__journal_remove_journal_head(bh);
 				refile_buffer(bh);
 				__brelse(bh);
+				if (current->need_resched) {
+					if (commit_transaction->t_sync_datalist)
+						commit_transaction->t_sync_datalist =
+							next_jh;
+					if (bufs)
+						break;
+					spin_unlock(&journal_datalist_lock);
+					conditional_schedule();
+					goto write_out_data;
+				}
 			}
 		}
 		if (bufs == ARRAY_SIZE(wbuf)) {
--- linux-2.4.18-pre1/fs/proc/array.c	Thu Oct 11 09:00:01 2001
+++ linux-akpm/fs/proc/array.c	Sat Jan  5 23:49:00 2002
@@ -415,6 +415,8 @@ static inline void statm_pte_range(pmd_t
 		pte_t page = *pte;
 		struct page *ptpage;
 
+		conditional_schedule();
+
 		address += PAGE_SIZE;
 		pte++;
 		if (pte_none(page))
--- linux-2.4.18-pre1/fs/proc/generic.c	Fri Sep  7 10:53:59 2001
+++ linux-akpm/fs/proc/generic.c	Sat Jan  5 23:49:00 2002
@@ -98,7 +98,9 @@ proc_file_read(struct file * file, char 
 				retval = n;
 			break;
 		}
-		
+
+		conditional_schedule();
+
 		/* This is a hack to allow mangling of file pos independent
  		 * of actual bytes read.  Simply place the data at page,
  		 * return the bytes, and set `start' to the desired offset
--- linux-2.4.18-pre1/include/linux/condsched.h	Thu Jan  1 00:00:00 1970
+++ linux-akpm/include/linux/condsched.h	Sat Jan  5 23:49:00 2002
@@ -0,0 +1,18 @@
+#ifndef _LINUX_CONDSCHED_H
+#define _LINUX_CONDSCHED_H
+
+#ifndef __LINUX_COMPILER_H
+#include <linux/compiler.h>
+#endif
+
+#ifndef __ASSEMBLY__
+#define conditional_schedule()				\
+do {							\
+	if (unlikely(current->need_resched)) {		\
+		__set_current_state(TASK_RUNNING);	\
+		schedule();				\
+	}						\
+} while(0)
+#endif
+
+#endif
--- linux-2.4.18-pre1/include/linux/sched.h	Fri Dec 21 11:19:23 2001
+++ linux-akpm/include/linux/sched.h	Sun Jan  6 02:44:06 2002
@@ -13,6 +13,7 @@ extern unsigned long event;
 #include <linux/times.h>
 #include <linux/timex.h>
 #include <linux/rbtree.h>
+#include <linux/condsched.h>
 
 #include <asm/system.h>
 #include <asm/semaphore.h>
--- linux-2.4.18-pre1/mm/filemap.c	Wed Dec 26 11:47:41 2001
+++ linux-akpm/mm/filemap.c	Sat Jan  5 23:49:00 2002
@@ -296,10 +296,7 @@ static int truncate_list_pages(struct li
 
 			page_cache_release(page);
 
-			if (current->need_resched) {
-				__set_current_state(TASK_RUNNING);
-				schedule();
-			}
+			conditional_schedule();
 
 			spin_lock(&pagecache_lock);
 			goto restart;
@@ -609,6 +606,7 @@ void filemap_fdatasync(struct address_sp
 			UnlockPage(page);
 
 		page_cache_release(page);
+		conditional_schedule();
 		spin_lock(&pagecache_lock);
 	}
 	spin_unlock(&pagecache_lock);
@@ -1392,6 +1390,9 @@ page_ok:
 		offset &= ~PAGE_CACHE_MASK;
 
 		page_cache_release(page);
+
+		conditional_schedule();
+
 		if (ret == nr && desc->count)
 			continue;
 		break;
@@ -3025,6 +3026,8 @@ unlock:
 		SetPageReferenced(page);
 		UnlockPage(page);
 		page_cache_release(page);
+
+		conditional_schedule();
 
 		if (status < 0)
 			break;
--- linux-2.4.18-pre1/drivers/block/ll_rw_blk.c	Mon Nov  5 21:01:11 2001
+++ linux-akpm/drivers/block/ll_rw_blk.c	Sat Jan  5 23:49:00 2002
@@ -913,6 +913,7 @@ void submit_bh(int rw, struct buffer_hea
 			kstat.pgpgin += count;
 			break;
 	}
+	conditional_schedule();
 }
 
 /**
