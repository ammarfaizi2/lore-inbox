Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131171AbRCWQMa>; Fri, 23 Mar 2001 11:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131194AbRCWQMK>; Fri, 23 Mar 2001 11:12:10 -0500
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:50052 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S131171AbRCWQMB>; Fri, 23 Mar 2001 11:12:01 -0500
Date: Fri, 23 Mar 2001 11:10:56 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Adding just a pinch of icache/dcache pressure...
Message-ID: <20010323111056.A9332@cs.cmu.edu>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20010323015358Z129164-406+3041@vger.kernel.org> <Pine.LNX.4.21.0103230403370.29682-100000@imladris.rielhome.conectiva> <20010323122815.A6428@win.tue.nl> <m1hf0k1qvi.fsf@frodo.biederman.org> <3ABB6833.183E9188@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3ABB6833.183E9188@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Mar 23, 2001 at 10:13:55AM -0500
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2001 at 10:13:55AM -0500, Jeff Garzik wrote:
> Personally I think the OOM killer itself is fine.  I think there are
> problems elsewhere which are triggering the OOM killer when it should
> not be triggered, ie. a leak like Doug Ledford was reporting.
> 
> I definitely see heavier page/dcache usage in 2.4 -- but that is to be
> expected due to 2.4 changes!  So it is incredibily difficult to quantify
> if something is wrong, and if so, where...
> 
> My own impressions of 2.4 are that it "feels faster" for my own uses and
> it's stable.  The downsides I find are that heavy fs activity seems to
> imply increased swapping, which jibes with a guess that the page/dcache
> is exceptionally greedy with releasing pages under memory pressure.
> 
> </unquantified vague ramble>

Like I said earlier, I should stop theorizing and write the code. Here
is a teeny little patch that adds a bit of pressure to the inode and
dentry slabcaches during inactive shortage.

On the 512MB desktop without the change, the inode+dentry slabs
typically used up about 300MB after running my normal day-to-day
workload for about 24 hours. Now, the inode+dentry slabs are using
only 90MB.

As there is more memory available for the buffer and page caches, kswapd
seems to have less trouble keeping up with my typical workload.


btw. There definitely is a network receive buffer leak somewhere in
either the 3c905C path or higher up in the network layers (2.4.0 or
2.4.1). The normal path does not leak anything.

I was seeing it only for a couple of days when there was a failing
switch that must have randomly corrupted packets. The switch got
replaced and the leakage disappeared, so I went back into a non-ikd
kernel and stopped looking for the problem.

Jan


=================
--- linux/fs/inode.c.orig	Thu Mar 22 13:20:55 2001
+++ linux/fs/inode.c	Thu Mar 22 14:00:10 2001
@@ -270,19 +270,6 @@
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
@@ -507,8 +494,6 @@
 	struct inode * inode;
 
 	spin_lock(&inode_lock);
-	/* go simple and safe syncing everything before starting */
-	sync_all_inodes();
 
 	entry = inode_unused.prev;
 	while (entry != &inode_unused)
@@ -554,6 +539,9 @@
 
 	if (priority)
 		count = inodes_stat.nr_unused / priority;
+
+	if (priority < 6)
+		sync_inodes(0);
 
 	prune_icache(count);
 	kmem_cache_shrink(inode_cachep);
--- linux/mm/vmscan.c.orig	Thu Mar 22 14:00:41 2001
+++ linux/mm/vmscan.c	Thu Mar 22 14:35:26 2001
@@ -845,9 +845,11 @@
 	 * reclaim unused slab cache if memory is low.
 	 */
 	if (free_shortage()) {
+		shrink_dcache_memory(5, gfp_mask);
+		shrink_icache_memory(5, gfp_mask);
+	} else {
 		shrink_dcache_memory(DEF_PRIORITY, gfp_mask);
 		shrink_icache_memory(DEF_PRIORITY, gfp_mask);
-	} else {
 		/*
 		 * Illogical, but true. At least for now.
 		 *
