Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133000AbRDLOec>; Thu, 12 Apr 2001 10:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133045AbRDLOeX>; Thu, 12 Apr 2001 10:34:23 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:16052 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S133000AbRDLOeN>; Thu, 12 Apr 2001 10:34:13 -0400
Date: Thu, 12 Apr 2001 10:34:04 -0400
To: Alexander Viro <viro@math.psu.edu>
Cc: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Fwd: Re: memory usage - dentry_cacheg
Message-ID: <20010412103404.D13778@cs.cmu.edu>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Andreas Dilger <adilger@turbolinux.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200104120448.f3C4mtlD016247@webber.adilger.int> <Pine.GSO.4.21.0104120110210.18135-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.GSO.4.21.0104120110210.18135-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Apr 12, 2001 at 01:45:08AM -0400
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2001 at 01:45:08AM -0400, Alexander Viro wrote:
> On Wed, 11 Apr 2001, Andreas Dilger wrote:
> 
> > I just discovered a similar problem when testing Daniel Philip's new ext2
> > directory indexing code with bonnie++.  I was running bonnie under single
> > user mode (basically nothing else running) to create 100k files with 1 data
> > block each (in a single directory).  This would create a directory about
> > 8MB in size, 32MB of dirty inode tables, and about 400M of dirty buffers.
> > I have 128MB RAM, no swap for the testing.
> > 
> > In short order, my single user shell was OOM killed, and in another test
> > bonnie was OOM-killed (even though the process itself is only 8MB in size).
> > There were 80k entries each of icache and dcache (38MB and 10MB respectively)
> > and only dirty buffers otherwise.  Clearly we need some VM pressure on the
> > icache and dcache in this case.  Probably also need more agressive flushing
> > of dirty buffers before invoking OOM.
> 
> We _have_ VM pressure there. However, such loads had never been used, so
> there's no wonder that system gets unbalanced under them.

But the VM pressure on the dcache and icache only comes into play once
the system still has a free_shortage _after_ other attempts of freeing
up memory in do_try_to_free_pages.

sync_all_inodes, which is called from shrink_icache_memory is
counterproductive at this point. Writing dirty inodes to disk,
especially when there is a lot of them, requires additional page
allocations.

I have a patch that avoids unconditionally puts pressure on the dcache
and icache, and avoids sync_all_inodes in shrink_icache_memory. An
additional wakeup for the kupdate thread makes sure that inodes are more
frequently written when there is no more free shortage. Maybe kupdated
should be always get woken up.

btw. Alexander, is the following a valid optimization to improve
write-coalescing when calling sync_one for several inodes?

inode.c:sync_one

-    filemap_fdatawait(inode->i_mapping);
+    if (sync) filemap_fdatawait(inode->i_mapping);

Jan

================================================
--- fs/buffer.c.orig	Mon Mar 26 10:47:09 2001
+++ fs/buffer.c	Mon Mar 26 10:48:33 2001
@@ -2593,7 +2593,7 @@
 	return flushed;
 }
 
-struct task_struct *bdflush_tsk = 0;
+struct task_struct *bdflush_tsk = 0, *kupdate_tsk = 0;
 
 void wakeup_bdflush(int block)
 {
@@ -2605,6 +2605,12 @@
 	}
 }
 
+void wakeup_kupdate(void)
+{
+	if (current != kupdate_tsk)
+		wake_up_process(kupdate_tsk);
+}
+
 /* 
  * Here we attempt to write back old buffers.  We also try to flush inodes 
  * and supers as well, since this function is essentially "update", and 
@@ -2751,6 +2757,7 @@
 	tsk->session = 1;
 	tsk->pgrp = 1;
 	strcpy(tsk->comm, "kupdated");
+	kupdate_tsk = tsk;
 
 	/* sigstop and sigcont will stop and wakeup kupdate */
 	spin_lock_irq(&tsk->sigmask_lock);
--- fs/inode.c.orig	Thu Mar 22 13:20:55 2001
+++ fs/inode.c	Mon Mar 26 10:48:33 2001
@@ -224,7 +224,8 @@
 		if (dirty & (I_DIRTY_SYNC | I_DIRTY_DATASYNC))
 			write_inode(inode, sync);
 
-		filemap_fdatawait(inode->i_mapping);
+		if (sync)
+			filemap_fdatawait(inode->i_mapping);
 
 		spin_lock(&inode_lock);
 		inode->i_state &= ~I_LOCK;
@@ -270,19 +271,6 @@
 	spin_unlock(&inode_lock);
 }
 
-/*
- * Called with the spinlock already held..
- */
-static void sync_all_inodes(void)
-{
-	struct super_block * sb = sb_entry(super_blocks.next);
-	for (; sb != sb_entry(&super_blocks); sb = sb_entry(sb->s_list.next)) {
-		if (!sb->s_dev)
-			continue;
-		sync_list(&sb->s_dirty);
-	}
-}
-
 /**
  *	write_inode_now	-	write an inode to disk
  *	@inode: inode to write to disk
@@ -507,8 +495,6 @@
 	struct inode * inode;
 
 	spin_lock(&inode_lock);
-	/* go simple and safe syncing everything before starting */
-	sync_all_inodes();
 
 	entry = inode_unused.prev;
 	while (entry != &inode_unused)
--- mm/vmscan.c.orig	Thu Mar 22 14:00:41 2001
+++ mm/vmscan.c	Mon Mar 26 10:48:33 2001
@@ -840,14 +840,7 @@
 	if (inactive_shortage())
 		ret += refill_inactive(gfp_mask, user);
 
-	/* 	
-	 * Delete pages from the inode and dentry caches and 
-	 * reclaim unused slab cache if memory is low.
-	 */
-	if (free_shortage()) {
-		shrink_dcache_memory(DEF_PRIORITY, gfp_mask);
-		shrink_icache_memory(DEF_PRIORITY, gfp_mask);
-	} else {
+	if (!free_shortage()) {
 		/*
 		 * Illogical, but true. At least for now.
 		 *
@@ -857,7 +850,14 @@
 		 * which we'll want to keep if under shortage.
 		 */
 		kmem_cache_reap(gfp_mask);
+		wakeup_kupdate();
 	} 
+
+	/* 
+	 * Delete pages from the inode and dentry caches.
+	 */
+	shrink_dcache_memory(DEF_PRIORITY, gfp_mask);
+	shrink_icache_memory(DEF_PRIORITY, gfp_mask);
 
 	return ret;
 }
--- include/linux/fs.h.orig	Mon Mar 26 10:48:56 2001
+++ include/linux/fs.h	Mon Mar 26 10:48:33 2001
@@ -1248,6 +1248,7 @@
 extern unsigned int get_hardblocksize(kdev_t);
 extern struct buffer_head * bread(kdev_t, int, int);
 extern void wakeup_bdflush(int wait);
+extern void wakeup_kupdate(void);
 
 extern int brw_page(int, struct page *, kdev_t, int [], int);
 
