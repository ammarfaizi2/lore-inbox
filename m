Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287425AbSALU3b>; Sat, 12 Jan 2002 15:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287429AbSALU3W>; Sat, 12 Jan 2002 15:29:22 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:13578 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287425AbSALU3L>; Sat, 12 Jan 2002 15:29:11 -0500
Message-ID: <3C409B2D.DB95D659@zip.com.au>
Date: Sat, 12 Jan 2002 12:23:09 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Sweetman <ed.sweetman@wmich.edu>
CC: Andrea Arcangeli <andrea@suse.de>, yodaiken@fsmlabs.com,
        jogi@planetzork.ping.de, Robert Love <rml@tech9.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020112121315.B1482@inspiron.school.suse.de> <20020112160714.A10847@planetzork.spacenet> <20020112095209.A5735@hq.fsmlabs.com> <20020112180016.T1482@inspiron.school.suse.de> <005301c19b9b$6acc61e0$0501a8c0@psuedogod>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:
> 
> If you want to test the preempt kernel you're going to need something that
> can find the mean latancy or "time to action" for a particular program or
> all programs being run at the time and then run multiple programs that you
> would find on various peoples' systems.   That is the "feel" people talk
> about when they praise the preempt patch.

Right.  And that is precisely why I created the "mini-ll" patch.  To
give the improved "feel" in a way which is acceptable for merging into
the 2.4 kernel.

And guess what?   Nobody has tested the damn thing, so it's going
nowhere.

Here it is again:



--- linux-2.4.18-pre3/fs/buffer.c	Fri Dec 21 11:19:14 2001
+++ linux-akpm/fs/buffer.c	Sat Jan 12 12:22:29 2002
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
--- linux-2.4.18-pre3/fs/dcache.c	Fri Dec 21 11:19:14 2001
+++ linux-akpm/fs/dcache.c	Sat Jan 12 12:22:29 2002
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
--- linux-2.4.18-pre3/fs/jbd/commit.c	Fri Dec 21 11:19:14 2001
+++ linux-akpm/fs/jbd/commit.c	Sat Jan 12 12:22:29 2002
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
--- linux-2.4.18-pre3/fs/proc/array.c	Thu Oct 11 09:00:01 2001
+++ linux-akpm/fs/proc/array.c	Sat Jan 12 12:22:29 2002
@@ -415,6 +415,8 @@ static inline void statm_pte_range(pmd_t
 		pte_t page = *pte;
 		struct page *ptpage;
 
+		conditional_schedule();
+
 		address += PAGE_SIZE;
 		pte++;
 		if (pte_none(page))
--- linux-2.4.18-pre3/fs/proc/generic.c	Fri Sep  7 10:53:59 2001
+++ linux-akpm/fs/proc/generic.c	Sat Jan 12 12:22:29 2002
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
--- linux-2.4.18-pre3/include/linux/condsched.h	Thu Jan  1 00:00:00 1970
+++ linux-akpm/include/linux/condsched.h	Sat Jan 12 12:22:29 2002
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
--- linux-2.4.18-pre3/include/linux/sched.h	Fri Dec 21 11:19:23 2001
+++ linux-akpm/include/linux/sched.h	Sat Jan 12 12:22:29 2002
@@ -13,6 +13,7 @@ extern unsigned long event;
 #include <linux/times.h>
 #include <linux/timex.h>
 #include <linux/rbtree.h>
+#include <linux/condsched.h>
 
 #include <asm/system.h>
 #include <asm/semaphore.h>
--- linux-2.4.18-pre3/mm/filemap.c	Thu Jan 10 13:39:50 2002
+++ linux-akpm/mm/filemap.c	Sat Jan 12 12:22:29 2002
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
--- linux-2.4.18-pre3/drivers/block/ll_rw_blk.c	Thu Jan 10 13:39:49 2002
+++ linux-akpm/drivers/block/ll_rw_blk.c	Sat Jan 12 12:22:29 2002
@@ -917,6 +917,7 @@ void submit_bh(int rw, struct buffer_hea
 			kstat.pgpgin += count;
 			break;
 	}
+	conditional_schedule();
 }
 
 /**
