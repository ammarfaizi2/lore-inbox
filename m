Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292295AbSB0R7O>; Wed, 27 Feb 2002 12:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292846AbSB0R6q>; Wed, 27 Feb 2002 12:58:46 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:20919 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292380AbSB0R6Z>;
	Wed, 27 Feb 2002 12:58:25 -0500
Date: Wed, 27 Feb 2002 09:58:16 -0800
From: Dave Hansen <haveblue@us.ibm.com>
Message-Id: <200202271758.g1RHwGn17604@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] backport of 2.5 BKL removal from ext2_get_block
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the largest places for BKL contention in 2.4 is ext2_get_block().  On my 2-way, dbench causes around 4% of combined CPU time just spinning on the lock_kernel() in ext2_get_block().  On bigger machines it just gets worse.  Say what you will about dbench, I know it isn't the most real-world benchmark, but it does provide a quick and dirty method for producing a nasty amount of disk load.

Al Viro produced patch for 2.5 to address this problem:
http://linux.bkbits.net:8080/linux-2.5/cset@1.290?nav=index.html|ChangeSet@-3w

I've done a fairly straightforward backport to the 2.4 tree.  But, I'm not sure how it interacts with the VFS patches which came earlier in 2.5.  It is quite stable on my 2-way; definitely no deadlocks.  I'll be testing it on larger machines soon.  I don't expect it to go into the mainline kernel right away, but I would like the secondary tree maintainers to pick it up and let people pound on it.  

You can see the lockmeter data here:
http://www.sr71.net/ibm/bkl-ext2-dbench/
You may notice that the data from my patch show a slight drop in throughput (~2%).  However, my testing conditions were less than ideal and the drop can probably be attributed to statistical error. 

-- 
Dave Hansen
haveblue@us.ibm.com
diff -ur clean/fs/ext2/balloc.c linux/fs/ext2/balloc.c
--- clean/fs/ext2/balloc.c	Mon Feb 25 11:38:08 2002
+++ linux/fs/ext2/balloc.c	Wed Feb 27 09:11:39 2002
@@ -539,6 +539,7 @@
 	 */
 #ifdef EXT2_PREALLOCATE
 	/* Writer: ->i_prealloc* */
+	write_lock(&inode->u.ext2_i.i_meta_lock);
 	if (prealloc_count && !*prealloc_count) {
 		int	prealloc_goal;
 		unsigned long next_block = tmp + 1;
@@ -577,7 +578,7 @@
 			       (k - 1));
 	}
 #endif
-
+	write_unlock(&inode->u.ext2_i.i_meta_lock);
 	j = tmp;
 
 	mark_buffer_dirty(bh);
diff -ur clean/fs/ext2/ialloc.c linux/fs/ext2/ialloc.c
--- clean/fs/ext2/ialloc.c	Mon Feb 25 11:38:08 2002
+++ linux/fs/ext2/ialloc.c	Wed Feb 27 09:11:39 2002
@@ -392,6 +392,7 @@
 	inode->u.ext2_i.i_block_group = group;
 	if (inode->u.ext2_i.i_flags & EXT2_SYNC_FL)
 		inode->i_flags |= S_SYNC;
+	rwlock_init(&inode->u.ext2_i.i_meta_lock);
 	insert_inode_hash(inode);
 	inode->i_generation = event++;
 	mark_inode_dirty(inode);
Only in linux/fs/ext2: ialloc.c.orig
diff -ur clean/fs/ext2/inode.c linux/fs/ext2/inode.c
--- clean/fs/ext2/inode.c	Mon Feb 25 11:38:08 2002
+++ linux/fs/ext2/inode.c	Wed Feb 27 09:11:39 2002
@@ -51,8 +51,6 @@
  */
 void ext2_delete_inode (struct inode * inode)
 {
-	lock_kernel();
-
 	if (is_bad_inode(inode) ||
 	    inode->i_ino == EXT2_ACL_IDX_INO ||
 	    inode->i_ino == EXT2_ACL_DATA_INO)
@@ -60,6 +58,8 @@
 	inode->u.ext2_i.i_dtime	= CURRENT_TIME;
 	mark_inode_dirty(inode);
 	ext2_update_inode(inode, IS_SYNC(inode));
+	
+	lock_kernel();
 	inode->i_size = 0;
 	if (inode->i_blocks)
 		ext2_truncate (inode);
@@ -68,24 +68,26 @@
 	unlock_kernel();
 	return;
 no_delete:
-	unlock_kernel();
 	clear_inode(inode);	/* We must guarantee clearing of inode... */
 }
 
 void ext2_discard_prealloc (struct inode * inode)
 {
 #ifdef EXT2_PREALLOCATE
-	lock_kernel();
+	write_lock(&inode->u.ext2_i.i_meta_lock);
 	/* Writer: ->i_prealloc* */
 	if (inode->u.ext2_i.i_prealloc_count) {
 		unsigned short total = inode->u.ext2_i.i_prealloc_count;
 		unsigned long block = inode->u.ext2_i.i_prealloc_block;
 		inode->u.ext2_i.i_prealloc_count = 0;
 		inode->u.ext2_i.i_prealloc_block = 0;
+		write_unlock(&inode->u.ext2_i.i_meta_lock);
 		/* Writer: end */
 		ext2_free_blocks (inode, block, total);
+	} else {
+		write_unlock(&inode->u.ext2_i.i_meta_lock);
 	}
-	unlock_kernel();
+		
 #endif
 }
 
@@ -99,6 +101,7 @@
 
 #ifdef EXT2_PREALLOCATE
 	/* Writer: ->i_prealloc* */
+        write_lock(&inode->u.ext2_i.i_meta_lock);
 	if (inode->u.ext2_i.i_prealloc_count &&
 	    (goal == inode->u.ext2_i.i_prealloc_block ||
 	     goal + 1 == inode->u.ext2_i.i_prealloc_block))
@@ -106,9 +109,11 @@
 		result = inode->u.ext2_i.i_prealloc_block++;
 		inode->u.ext2_i.i_prealloc_count--;
 		/* Writer: end */
+                write_unlock(&inode->u.ext2_i.i_meta_lock);
 		ext2_debug ("preallocation hit (%lu/%lu).\n",
 			    ++alloc_hits, ++alloc_attempts);
 	} else {
+                write_unlock(&inode->u.ext2_i.i_meta_lock);
 		ext2_discard_prealloc (inode);
 		ext2_debug ("preallocation miss (%lu/%lu).\n",
 			    alloc_hits, ++alloc_attempts);
@@ -253,9 +258,11 @@
 		if (!bh)
 			goto failure;
 		/* Reader: pointers */
+		read_lock(&inode->u.ext2_i.i_meta_lock);	
 		if (!verify_chain(chain, p))
 			goto changed;
 		add_chain(++p, bh, (u32*)bh->b_data + *++offsets);
+		read_unlock(&inode->u.ext2_i.i_meta_lock);
 		/* Reader: end */
 		if (!p->key)
 			goto no_block;
@@ -263,6 +270,7 @@
 	return NULL;
 
 changed:
+	read_unlock(&inode->u.ext2_i.i_meta_lock);
 	*err = -EAGAIN;
 	goto no_block;
 failure:
@@ -328,6 +336,8 @@
 				 unsigned long *goal)
 {
 	/* Writer: ->i_next_alloc* */
+	
+	write_lock(&inode->u.ext2_i.i_meta_lock);
 	if (block == inode->u.ext2_i.i_next_alloc_block + 1) {
 		inode->u.ext2_i.i_next_alloc_block++;
 		inode->u.ext2_i.i_next_alloc_goal++;
@@ -343,9 +353,11 @@
 			*goal = inode->u.ext2_i.i_next_alloc_goal;
 		if (!*goal)
 			*goal = ext2_find_near(inode, partial);
+		write_unlock(&inode->u.ext2_i.i_meta_lock);
 		return 0;
 	}
 	/* Reader: end */
+	write_unlock(&inode->u.ext2_i.i_meta_lock);
 	return -EAGAIN;
 }
 
@@ -451,6 +463,7 @@
 
 	/* Verify that place we are splicing to is still there and vacant */
 
+	write_lock(&inode->u.ext2_i.i_meta_lock);
 	/* Writer: pointers, ->i_next_alloc* */
 	if (!verify_chain(chain, where-1) || *where->p)
 		/* Writer: end */
@@ -461,7 +474,7 @@
 	*where->p = where->key;
 	inode->u.ext2_i.i_next_alloc_block = block;
 	inode->u.ext2_i.i_next_alloc_goal = le32_to_cpu(where[num-1].key);
-
+	write_unlock(&inode->u.ext2_i.i_meta_lock);
 	/* Writer: end */
 
 	/* We are done with atomic stuff, now do the rest of housekeeping */
@@ -517,7 +530,6 @@
 	if (depth == 0)
 		goto out;
 
-	lock_kernel();
 reread:
 	partial = ext2_get_branch(inode, depth, offsets, chain, &err);
 
@@ -539,7 +551,6 @@
 			brelse(partial->bh);
 			partial--;
 		}
-		unlock_kernel();
 out:
 		return err;
 	}
@@ -967,6 +978,7 @@
 	inode->i_generation = le32_to_cpu(raw_inode->i_generation);
 	inode->u.ext2_i.i_prealloc_count = 0;
 	inode->u.ext2_i.i_block_group = block_group;
+	rwlock_init(&inode->u.ext2_i.i_meta_lock);
 
 	/*
 	 * NOTE! The in-memory inode i_data array is in little-endian order
@@ -1149,9 +1161,7 @@
 
 void ext2_write_inode (struct inode * inode, int wait)
 {
-	lock_kernel();
 	ext2_update_inode (inode, wait);
-	unlock_kernel();
 }
 
 int ext2_sync_inode (struct inode *inode)
Only in linux/fs/ext2: inode.c.orig
diff -ur clean/include/linux/ext2_fs_i.h linux/include/linux/ext2_fs_i.h
--- clean/include/linux/ext2_fs_i.h	Mon Sep 17 13:16:30 2001
+++ linux/include/linux/ext2_fs_i.h	Wed Feb 27 09:11:39 2002
@@ -36,6 +36,7 @@
 	__u32	i_prealloc_count;
 	__u32	i_dir_start_lookup;
 	int	i_new_inode:1;	/* Is a freshly allocated inode */
+	rwlock_t	i_meta_lock;
 };
 
 #endif	/* _LINUX_EXT2_FS_I */
