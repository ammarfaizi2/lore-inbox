Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293253AbSCFG5d>; Wed, 6 Mar 2002 01:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293256AbSCFG5Y>; Wed, 6 Mar 2002 01:57:24 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:11145 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293253AbSCFG5R>; Wed, 6 Mar 2002 01:57:17 -0500
Message-ID: <3C85BDC6.7010601@us.ibm.com>
Date: Tue, 05 Mar 2002 22:57:10 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020227
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from ext2_get_block() version 2
In-Reply-To: <Pine.GSO.4.21.0203051935160.18755-100000@weyl.math.psu.edu>
Content-Type: multipart/mixed;
 boundary="------------040300050808090007050804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040300050808090007050804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alexander Viro wrote:
 > Denied.  You can trivially do that in ext2_read_inode() and
 > ext2_new_inode().

Is this the right way to do it?  I put the lock back in the 
ext2_inode_info structure, and moved the initialization from init_once() 
to ext2_read_inode() and ext2_new_inode().

-- 
Dave Hansen
haveblue@us.ibm.com

--------------040300050808090007050804
Content-Type: text/plain;
 name="ext2_get_block-bkl-removal-2.4.19-pre2.3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ext2_get_block-bkl-removal-2.4.19-pre2.3.patch"

diff -ur -X 2.5/exclude linux-2.4.19-pre2-clean/fs/ext2/balloc.c linux/fs/ext2/balloc.c
--- linux-2.4.19-pre2-clean/fs/ext2/balloc.c	Tue Mar  5 15:18:38 2002
+++ linux/fs/ext2/balloc.c	Tue Mar  5 17:04:32 2002
@@ -539,6 +539,7 @@
 	 */
 #ifdef EXT2_PREALLOCATE
 	/* Writer: ->i_prealloc* */
+	write_lock(&inode->u.ext2_i.i_meta_lock);
 	if (prealloc_count && !*prealloc_count) {
 		int	prealloc_goal;
 		unsigned long next_block = tmp + 1;
@@ -576,8 +577,8 @@
 		ext2_debug ("Preallocated a further %lu bits.\n",
 			       (k - 1));
 	}
+	write_unlock(&inode->u.ext2_i.i_meta_lock);
 #endif
-
 	j = tmp;
 
 	mark_buffer_dirty(bh);
diff -ur -X 2.5/exclude linux-2.4.19-pre2-clean/fs/ext2/ialloc.c linux/fs/ext2/ialloc.c
--- linux-2.4.19-pre2-clean/fs/ext2/ialloc.c	Tue Mar  5 15:18:38 2002
+++ linux/fs/ext2/ialloc.c	Tue Mar  5 17:05:29 2002
@@ -392,6 +392,7 @@
 	inode->u.ext2_i.i_block_group = group;
 	if (inode->u.ext2_i.i_flags & EXT2_SYNC_FL)
 		inode->i_flags |= S_SYNC;
+	rwlock_init(&inode->u.ext2_i.i_meta_lock);
 	insert_inode_hash(inode);
 	inode->i_generation = event++;
 	mark_inode_dirty(inode);
diff -ur -X 2.5/exclude linux-2.4.19-pre2-clean/fs/ext2/inode.c linux/fs/ext2/inode.c
--- linux-2.4.19-pre2-clean/fs/ext2/inode.c	Tue Mar  5 15:18:38 2002
+++ linux/fs/ext2/inode.c	Tue Mar  5 19:41:56 2002
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
+	write_lock(&inode->u.ext2_i.i_meta_lock);
 	if (inode->u.ext2_i.i_prealloc_count &&
 	    (goal == inode->u.ext2_i.i_prealloc_block ||
 	     goal + 1 == inode->u.ext2_i.i_prealloc_block))
@@ -106,9 +109,11 @@
 		result = inode->u.ext2_i.i_prealloc_block++;
 		inode->u.ext2_i.i_prealloc_count--;
 		/* Writer: end */
+		write_unlock(&inode->u.ext2_i.i_meta_lock);
 		ext2_debug ("preallocation hit (%lu/%lu).\n",
 			    ++alloc_hits, ++alloc_attempts);
 	} else {
+		write_unlock(&inode->u.ext2_i.i_meta_lock);
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
@@ -484,6 +497,7 @@
 	return 0;
 
 changed:
+	write_unlock(&inode->u.ext2_i.i_meta_lock);
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
@@ -942,6 +954,7 @@
 	inode->i_ctime = le32_to_cpu(raw_inode->i_ctime);
 	inode->i_mtime = le32_to_cpu(raw_inode->i_mtime);
 	inode->u.ext2_i.i_dtime = le32_to_cpu(raw_inode->i_dtime);
+	rwlock_init(&inode->u.ext2_i.i_meta_lock);
 	/* We now have enough fields to check if the inode was active or not.
 	 * This is needed because nfsd might try to access dead inodes
 	 * the test is that same one that e2fsck uses
@@ -1149,9 +1162,7 @@
 
 void ext2_write_inode (struct inode * inode, int wait)
 {
-	lock_kernel();
 	ext2_update_inode (inode, wait);
-	unlock_kernel();
 }
 
 int ext2_sync_inode (struct inode *inode)
diff -ur -X 2.5/exclude linux-2.4.19-pre2-clean/include/linux/ext2_fs_i.h linux/include/linux/ext2_fs_i.h
--- linux-2.4.19-pre2-clean/include/linux/ext2_fs_i.h	Mon Sep 17 13:16:30 2001
+++ linux/include/linux/ext2_fs_i.h	Tue Mar  5 16:57:25 2002
@@ -36,6 +36,7 @@
 	__u32	i_prealloc_count;
 	__u32	i_dir_start_lookup;
 	int	i_new_inode:1;	/* Is a freshly allocated inode */
+	rwlock_t	i_meta_lock;
 };
 
 #endif	/* _LINUX_EXT2_FS_I */

--------------040300050808090007050804--

