Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292379AbSCFAYG>; Tue, 5 Mar 2002 19:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292456AbSCFAX7>; Tue, 5 Mar 2002 19:23:59 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:26289 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292379AbSCFAX2>; Tue, 5 Mar 2002 19:23:28 -0500
Date: Tue, 5 Mar 2002 16:23:18 -0800
From: Dave Hansen <haveblue@us.ibm.com>
Message-Id: <200203060023.g260NIB09974@localhost.localdomain>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] remove BKL from ext2_get_block() version 2
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted the initial version of this last week.  There was no discussion about the patch itself.  I can only hope that no news is good news :)

My first version of the patch reinitialized i_meta_lock for every read_inode call.  This is not a correct way to do it.  However, 2.4 does not have the capability to have fs-specific init_inode_once() functions.  This probably meant altering the sb_ops structure if I wanted ext2_inode_info-specific initialization.  To make the patch less intrusive, I put i_meta_lock right into the inode structure.  I think that this is a good compromize between keeping ext2 code separated from VFS and patch simplicity.  The lock is now initialized once per inode in fs/inode.c's init_once(). 

I noticed the extra lock initializations because I was using lockmeter and kernprof while running dbench.  I was seeing a large throughput decrease when my patch was applied, and kernprof told me that a big chunk of CPU time was being spent in lockmeter's rwlock_alloc.  I have the feeling that I've hit a bottleneck in lockmeter's code spinning on locks which protect lockmeter's data structures.  

The patch is against 2.4.19-pre2.  The patch significantly lowers BKL contention (50%) on a 2-way PII-300 running dbench 4.  Dbench throughput is not significantly affected, but that is probably a function of my puny little machine more than the effectiveness of the patch.  I'll have some results on a much more beefy 8-way PIII tomorrow.  Earlier versions of the patch reduced BKL contention during dbench by 60% on the 8-way.  CPU utilization spinning on the BKL has been as high as 40%.

--
Dave Hansen
haveblue@us.ibm.com


diff -ur -X 2.5/exclude linux-2.4.19-pre2-clean/fs/ext2/balloc.c linux/fs/ext2/balloc.c
--- linux-2.4.19-pre2-clean/fs/ext2/balloc.c	Tue Mar  5 15:18:38 2002
+++ linux/fs/ext2/balloc.c	Tue Mar  5 15:16:57 2002
@@ -539,6 +539,7 @@
 	 */
 #ifdef EXT2_PREALLOCATE
 	/* Writer: ->i_prealloc* */
+	write_lock(&inode->i_meta_lock);
 	if (prealloc_count && !*prealloc_count) {
 		int	prealloc_goal;
 		unsigned long next_block = tmp + 1;
@@ -576,8 +577,8 @@
 		ext2_debug ("Preallocated a further %lu bits.\n",
 			       (k - 1));
 	}
+	write_unlock(&inode->i_meta_lock);
 #endif
-
 	j = tmp;
 
 	mark_buffer_dirty(bh);
diff -ur -X 2.5/exclude linux-2.4.19-pre2-clean/fs/ext2/inode.c linux/fs/ext2/inode.c
--- linux-2.4.19-pre2-clean/fs/ext2/inode.c	Tue Mar  5 15:18:38 2002
+++ linux/fs/ext2/inode.c	Tue Mar  5 15:16:57 2002
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
+	write_lock(&inode->i_meta_lock);
 	/* Writer: ->i_prealloc* */
 	if (inode->u.ext2_i.i_prealloc_count) {
 		unsigned short total = inode->u.ext2_i.i_prealloc_count;
 		unsigned long block = inode->u.ext2_i.i_prealloc_block;
 		inode->u.ext2_i.i_prealloc_count = 0;
 		inode->u.ext2_i.i_prealloc_block = 0;
+		write_unlock(&inode->i_meta_lock);
 		/* Writer: end */
 		ext2_free_blocks (inode, block, total);
+	} else {
+		write_unlock(&inode->i_meta_lock);
 	}
-	unlock_kernel();
+		
 #endif
 }
 
@@ -99,6 +101,7 @@
 
 #ifdef EXT2_PREALLOCATE
 	/* Writer: ->i_prealloc* */
+	write_lock(&inode->i_meta_lock);
 	if (inode->u.ext2_i.i_prealloc_count &&
 	    (goal == inode->u.ext2_i.i_prealloc_block ||
 	     goal + 1 == inode->u.ext2_i.i_prealloc_block))
@@ -106,9 +109,11 @@
 		result = inode->u.ext2_i.i_prealloc_block++;
 		inode->u.ext2_i.i_prealloc_count--;
 		/* Writer: end */
+		write_unlock(&inode->i_meta_lock);
 		ext2_debug ("preallocation hit (%lu/%lu).\n",
 			    ++alloc_hits, ++alloc_attempts);
 	} else {
+		write_unlock(&inode->i_meta_lock);
 		ext2_discard_prealloc (inode);
 		ext2_debug ("preallocation miss (%lu/%lu).\n",
 			    alloc_hits, ++alloc_attempts);
@@ -253,9 +258,11 @@
 		if (!bh)
 			goto failure;
 		/* Reader: pointers */
+		read_lock(&inode->i_meta_lock);	
 		if (!verify_chain(chain, p))
 			goto changed;
 		add_chain(++p, bh, (u32*)bh->b_data + *++offsets);
+		read_unlock(&inode->i_meta_lock);
 		/* Reader: end */
 		if (!p->key)
 			goto no_block;
@@ -263,6 +270,7 @@
 	return NULL;
 
 changed:
+	read_unlock(&inode->i_meta_lock);
 	*err = -EAGAIN;
 	goto no_block;
 failure:
@@ -328,6 +336,8 @@
 				 unsigned long *goal)
 {
 	/* Writer: ->i_next_alloc* */
+	
+	write_lock(&inode->i_meta_lock);
 	if (block == inode->u.ext2_i.i_next_alloc_block + 1) {
 		inode->u.ext2_i.i_next_alloc_block++;
 		inode->u.ext2_i.i_next_alloc_goal++;
@@ -343,9 +353,11 @@
 			*goal = inode->u.ext2_i.i_next_alloc_goal;
 		if (!*goal)
 			*goal = ext2_find_near(inode, partial);
+		write_unlock(&inode->i_meta_lock);
 		return 0;
 	}
 	/* Reader: end */
+	write_unlock(&inode->i_meta_lock);
 	return -EAGAIN;
 }
 
@@ -451,6 +463,7 @@
 
 	/* Verify that place we are splicing to is still there and vacant */
 
+	write_lock(&inode->i_meta_lock);
 	/* Writer: pointers, ->i_next_alloc* */
 	if (!verify_chain(chain, where-1) || *where->p)
 		/* Writer: end */
@@ -461,7 +474,7 @@
 	*where->p = where->key;
 	inode->u.ext2_i.i_next_alloc_block = block;
 	inode->u.ext2_i.i_next_alloc_goal = le32_to_cpu(where[num-1].key);
-
+	write_unlock(&inode->i_meta_lock);
 	/* Writer: end */
 
 	/* We are done with atomic stuff, now do the rest of housekeeping */
@@ -484,6 +497,7 @@
 	return 0;
 
 changed:
+	write_unlock(&inode->i_meta_lock);
 	for (i = 1; i < num; i++)
 		bforget(where[i].bh);
 	for (i = 0; i < num; i++)
@@ -517,7 +531,6 @@
 	if (depth == 0)
 		goto out;
 
-	lock_kernel();
 reread:
 	partial = ext2_get_branch(inode, depth, offsets, chain, &err);
 
@@ -539,7 +552,6 @@
 			brelse(partial->bh);
 			partial--;
 		}
-		unlock_kernel();
 out:
 		return err;
 	}
@@ -1149,9 +1161,7 @@
 
 void ext2_write_inode (struct inode * inode, int wait)
 {
-	lock_kernel();
 	ext2_update_inode (inode, wait);
-	unlock_kernel();
 }
 
 int ext2_sync_inode (struct inode *inode)
diff -ur -X 2.5/exclude linux-2.4.19-pre2-clean/fs/inode.c linux/fs/inode.c
--- linux-2.4.19-pre2-clean/fs/inode.c	Fri Dec 21 09:41:55 2001
+++ linux/fs/inode.c	Fri Mar  1 14:47:32 2002
@@ -110,6 +110,7 @@
 		sema_init(&inode->i_sem, 1);
 		sema_init(&inode->i_zombie, 1);
 		spin_lock_init(&inode->i_data.i_shared_lock);
+		rwlock_init(&inode->i_meta_lock);
 	}
 }
 
diff -ur -X 2.5/exclude linux-2.4.19-pre2-clean/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.4.19-pre2-clean/include/linux/fs.h	Tue Mar  5 15:19:42 2002
+++ linux/include/linux/fs.h	Tue Mar  5 15:17:47 2002
@@ -452,6 +452,7 @@
 	unsigned long		i_version;
 	struct semaphore	i_sem;
 	struct semaphore	i_zombie;
+	rwlock_t		i_meta_lock;
 	struct inode_operations	*i_op;
 	struct file_operations	*i_fop;	/* former ->i_op->default_file_ops */
 	struct super_block	*i_sb;
