Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310545AbSCGVMC>; Thu, 7 Mar 2002 16:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310546AbSCGVLx>; Thu, 7 Mar 2002 16:11:53 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:50364 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S310545AbSCGVLq>; Thu, 7 Mar 2002 16:11:46 -0500
Date: Thu, 7 Mar 2002 16:11:40 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: [bkpatch] fs/inode.c sync fix and fs/ext2/inode.c tidy
Message-ID: <20020307161140.F17842@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches can be pulled from bk://bcrlbits.bkbits.net/linux-2.5
First one: in fs/ext2/inode.c merge ext2_fsync_inode into ext2_sync_file 
as that's the only place it can be called from.

Second one only touches fs/inode.c:sync_one to replace the if I_LOCK 
check with a while.  Basically, the inode sync could end up deferring 
to writeback if the inode is already locked.  This breaks things like 
O_SYNC which assume the inode sync is synchronous and only returns 
when the data is safely on disk.  This patch will need to go into 2.4 
after a bit of testing for unexpected interactions.

Patches are included below for reading.

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."

diff -Nru a/fs/ext2/ext2.h b/fs/ext2/ext2.h
--- a/fs/ext2/ext2.h	Thu Mar  7 16:02:59 2002
+++ b/fs/ext2/ext2.h	Thu Mar  7 16:02:59 2002
@@ -63,7 +63,6 @@
 
 /* fsync.c */
 extern int ext2_sync_file (struct file *, struct dentry *, int);
-extern int ext2_fsync_inode (struct inode *, int);
 
 /* ialloc.c */
 extern struct inode * ext2_new_inode (struct inode *, int);
diff -Nru a/fs/ext2/fsync.c b/fs/ext2/fsync.c
--- a/fs/ext2/fsync.c	Thu Mar  7 16:02:59 2002
+++ b/fs/ext2/fsync.c	Thu Mar  7 16:02:59 2002
@@ -35,11 +35,6 @@
 int ext2_sync_file(struct file * file, struct dentry *dentry, int datasync)
 {
 	struct inode *inode = dentry->d_inode;
-	return ext2_fsync_inode(inode, datasync);
-}
-
-int ext2_fsync_inode(struct inode *inode, int datasync)
-{
 	int err;
 	
 	err  = fsync_inode_buffers(inode);






diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Thu Mar  7 16:02:59 2002
+++ b/fs/inode.c	Thu Mar  7 16:02:59 2002
@@ -291,15 +291,15 @@
 
 static inline void sync_one(struct inode *inode, int sync)
 {
-	if (inode->i_state & I_LOCK) {
+	while (inode->i_state & I_LOCK) {
 		__iget(inode);
 		spin_unlock(&inode_lock);
 		__wait_on_inode(inode);
 		iput(inode);
 		spin_lock(&inode_lock);
-	} else {
-		__sync_one(inode, sync);
 	}
+
+	__sync_one(inode, sync);
 }
 
 static inline void sync_list(struct list_head *head)
