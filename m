Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311786AbSCXVq6>; Sun, 24 Mar 2002 16:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311929AbSCXVqs>; Sun, 24 Mar 2002 16:46:48 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:32007 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311786AbSCXVqb>; Sun, 24 Mar 2002 16:46:31 -0500
Message-ID: <3C9E48D9.6D7A2729@zip.com.au>
Date: Sun, 24 Mar 2002 13:44:57 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: [patch] speed up ext2 synchronous mounts
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



At present, when mounted synchronously or with `chattr +S' in effect,
ext2 syncs the indirect blocks for every new block when extending a
file.

This is not necessary, because a sync is performed on the way out of
generic_file_write().  This will pick up all necessary data from
inode->i_dirty_buffers and inode->i_dirty_data_buffers, and is
sufficient.

The patch removes all the syncing of indirect blocks.

On a non-write-caching scsi disk, an untar of the util-linux tarball
runs three times faster.  Writing a 100 megabyte file in one megabyte
chunks speeds up ten times.

The patch also removes the intermediate indirect block syncing on the
truncate() path.  Instead, we sync the indirects at a single place, via
inode->i_dirty_buffers.  This not only means that the writes (may)
cluster better.  It means that we perform much, much less actual I/O
during truncate, because most or all of the indirects will no longer be
needed for the file, and will be invalidated.

fsync() and msync() still work correctly.  One side effect of this
patch is that VM-initiated writepage() against a file hole will no
longer block on writeout of indirect blocks.  This is good.




=====================================

--- 2.4.19-pre4/include/linux/ext2_fs_i.h~ext2-sync-mounts	Sun Mar 24 13:07:16 2002
+++ 2.4.19-pre4-akpm/include/linux/ext2_fs_i.h	Sun Mar 24 13:07:16 2002
@@ -25,7 +25,6 @@ struct ext2_inode_info {
 	__u32	i_faddr;
 	__u8	i_frag_no;
 	__u8	i_frag_size;
-	__u16	i_osync;
 	__u32	i_file_acl;
 	__u32	i_dir_acl;
 	__u32	i_dtime;
--- 2.4.19-pre4/fs/ext2/inode.c~ext2-sync-mounts	Sun Mar 24 13:07:16 2002
+++ 2.4.19-pre4-akpm/fs/ext2/inode.c	Sun Mar 24 13:07:16 2002
@@ -407,10 +407,10 @@ static int ext2_alloc_branch(struct inod
 		mark_buffer_uptodate(bh, 1);
 		unlock_buffer(bh);
 		mark_buffer_dirty_inode(bh, inode);
-		if (IS_SYNC(inode) || inode->u.ext2_i.i_osync) {
-			ll_rw_block (WRITE, 1, &bh);
-			wait_on_buffer (bh);
-		}
+		/* We used to sync bh here if IS_SYNC(inode).
+		 * But we now rely upon generic_osync_inode()
+		 * and b_inode_buffers
+		 */
 		parent = nr;
 	}
 	if (n == num)
@@ -469,18 +469,10 @@ static inline int ext2_splice_branch(str
 	inode->i_ctime = CURRENT_TIME;
 
 	/* had we spliced it onto indirect block? */
-	if (where->bh) {
+	if (where->bh)
 		mark_buffer_dirty_inode(where->bh, inode);
-		if (IS_SYNC(inode) || inode->u.ext2_i.i_osync) {
-			ll_rw_block (WRITE, 1, &where->bh);
-			wait_on_buffer(where->bh);
-		}
-	}
 
-	if (IS_SYNC(inode) || inode->u.ext2_i.i_osync)
-		ext2_sync_inode (inode);
-	else
-		mark_inode_dirty(inode);
+	mark_inode_dirty(inode);
 	return 0;
 
 changed:
@@ -837,10 +829,6 @@ void ext2_truncate (struct inode * inode
 				   (u32*)partial->bh->b_data + addr_per_block,
 				   (chain+n-1) - partial);
 		mark_buffer_dirty_inode(partial->bh, inode);
-		if (IS_SYNC(inode)) {
-			ll_rw_block (WRITE, 1, &partial->bh);
-			wait_on_buffer (partial->bh);
-		}
 		brelse (partial->bh);
 		partial--;
 	}
@@ -872,10 +860,12 @@ do_indirects:
 			;
 	}
 	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-	if (IS_SYNC(inode))
+	if (IS_SYNC(inode)) {
+		fsync_inode_buffers(inode);
 		ext2_sync_inode (inode);
-	else
+	} else {
 		mark_inode_dirty(inode);
+	}
 }
 
 void ext2_read_inode (struct inode * inode)


-
