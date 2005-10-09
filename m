Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbVJIVE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVJIVE6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 17:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbVJIVE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 17:04:58 -0400
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:31372 "EHLO
	tux06.ltc.ic.unicamp.br") by vger.kernel.org with ESMTP
	id S932209AbVJIVE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 17:04:57 -0400
Date: Sun, 9 Oct 2005 18:12:50 -0300
From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, adilger@clusterfs.com, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH] Locking problems while EXT3FS_DEBUG on
Message-ID: <20051009211250.GA28213@br.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I noticed some problems while running ext3 with the debug flag set on.
More precisely, I was unable to umount the filesystem. 
Some investigation took me to the patch that follows.

At a first glance , the lock/unlock I've taken out seems really not 
necessary, as the main code (outside debug) does not lock the super. 
The only additional danger operations that debug code introduces seems
to be related to bitmap, but bitmap operations tends to be all atomic 
anyway.

I also took the opportunity to fix 2 spell errors :-)

patch follows


diff -up linux-2.6.14-rc2-orig/fs/ext3/balloc.c linux/fs/ext3/balloc.c
--- linux-2.6.14-rc2-orig/fs/ext3/balloc.c	2005-10-09 19:58:40.000000000 +0000
+++ linux/fs/ext3/balloc.c	2005-10-09 20:24:23.000000000 +0000
@@ -1010,7 +1010,7 @@ retry:
  * allocation within the reservation window.
  *
  * This will avoid keeping on searching the reservation list again and
- * again when someboday is looking for a free block (without
+ * again when somebody is looking for a free block (without
  * reservation), and there are lots of free blocks, but they are all
  * being reserved.
  *
@@ -1416,12 +1416,12 @@ unsigned long ext3_count_free_blocks(str
 	unsigned long bitmap_count, x;
 	struct buffer_head *bitmap_bh = NULL;
 
-	lock_super(sb);
 	es = EXT3_SB(sb)->s_es;
 	desc_count = 0;
 	bitmap_count = 0;
 	gdp = NULL;
 
+	smp_rmb();
 	for (i = 0; i < ngroups; i++) {
 		gdp = ext3_get_group_desc(sb, i, NULL);
 		if (!gdp)
@@ -1440,7 +1440,6 @@ unsigned long ext3_count_free_blocks(str
 	brelse(bitmap_bh);
 	printk("ext3_count_free_blocks: stored = %u, computed = %lu, %lu\n",
 	       le32_to_cpu(es->s_free_blocks_count), desc_count, bitmap_count);
-	unlock_super(sb);
 	return bitmap_count;
 #else
 	desc_count = 0;
diff -up linux-2.6.14-rc2-orig/fs/ext3/ialloc.c linux/fs/ext3/ialloc.c
--- linux-2.6.14-rc2-orig/fs/ext3/ialloc.c	2005-09-26 13:58:15.000000000 +0000
+++ linux/fs/ext3/ialloc.c	2005-10-09 20:16:30.000000000 +0000
@@ -705,7 +705,6 @@ unsigned long ext3_count_free_inodes (st
 	unsigned long bitmap_count, x;
 	struct buffer_head *bitmap_bh = NULL;
 
-	lock_super (sb);
 	es = EXT3_SB(sb)->s_es;
 	desc_count = 0;
 	bitmap_count = 0;
@@ -728,7 +727,6 @@ unsigned long ext3_count_free_inodes (st
 	brelse(bitmap_bh);
 	printk("ext3_count_free_inodes: stored = %u, computed = %lu, %lu\n",
 		le32_to_cpu(es->s_free_inodes_count), desc_count, bitmap_count);
-	unlock_super(sb);
 	return desc_count;
 #else
 	desc_count = 0;
diff -up linux-2.6.14-rc2-orig/fs/ext3/inode.c linux/fs/ext3/inode.c
--- linux-2.6.14-rc2-orig/fs/ext3/inode.c	2005-09-26 13:58:15.000000000 +0000
+++ linux/fs/ext3/inode.c	2005-10-05 16:39:32.000000000 +0000
@@ -491,7 +491,7 @@ static unsigned long ext3_find_goal(stru
  *	the same format as ext3_get_branch() would do. We are calling it after
  *	we had read the existing part of chain and partial points to the last
  *	triple of that (one with zero ->key). Upon the exit we have the same
- *	picture as after the successful ext3_get_block(), excpet that in one
+ *	picture as after the successful ext3_get_block(), except that in one
  *	place chain is disconnected - *branch->p is still zero (we did not
  *	set the last link), but branch->key contains the number that should
  *	be placed into *branch->p to fill that gap.

-- 
=====================================
Glauber de Oliveira Costa
IBM Linux Technology Center - Brazil
glommer@br.ibm.com
=====================================
