Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130023AbQKVLvl>; Wed, 22 Nov 2000 06:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129582AbQKVLvc>; Wed, 22 Nov 2000 06:51:32 -0500
Received: from zeus.kernel.org ([209.10.41.242]:55054 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129150AbQKVLvW>;
	Wed, 22 Nov 2000 06:51:22 -0500
Date: Wed, 22 Nov 2000 11:18:20 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>, Ben LaHaise <bcrl@redhat.com>
Subject: [patch] O_SYNC patch 1/3: Fix fdatasync
Message-ID: <20001122111820.B6516@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the first patch out of 3 to fix O_SYNC and fdatasync for
2.4.0-test11.

The patch below fixes fdatasync (at least for ext2) so that it does
not flush the inode to disk for purely timestamp updates.  It splits
I_DIRTY into two bits, one bit (I_DIRTY_DATASYNC) which is set only
for dirty state requiring inode sync for datasync, and I_DIRTY_SYNC
which marks inodes being dirty at all.  I_DIRTY is the union of the
two.

When setting the bits, only the timestamp updates distinguish between
the two, setting I_DIRTY_SYNC but not _DATASYNC.  All other updates
set both bits.  All tests for I_DIRTY naturally test both bits and
return (dirty==true) if either bit is set, except for ext2_fsync which
checks the datasync argument and skips the inode flush if only
I_DIRTY_SYNC is set.

The only impact of this change should be to skip the inode update in
fdatasync() of an ext2 file if the inode's timestamp, but no other
field, has been modified.

--Stephen

2.4.0test11.00.idirty.diff:

--- linux-2.4.0-test11/fs/ext2/fsync.c.~1~	Tue Nov 21 15:47:35 2000
+++ linux-2.4.0-test11/fs/ext2/fsync.c	Tue Nov 21 15:47:48 2000
@@ -152,7 +152,9 @@
 				      wait);
 	}
 skip:
-	err |= ext2_sync_inode (inode);
+	if ((inode->i_state & I_DIRTY_DATASYNC) || 
+	    ((inode->i_state & I_DIRTY) && !datasync))
+		err |= ext2_sync_inode (inode);
 	unlock_kernel();
 	return err ? -EIO : 0;
 }
--- linux-2.4.0-test11/fs/inode.c.~1~	Tue Nov 21 15:47:35 2000
+++ linux-2.4.0-test11/fs/inode.c	Tue Nov 21 15:47:48 2000
@@ -122,14 +122,14 @@
  *	Mark an inode as dirty. Callers should use mark_inode_dirty.
  */
  
-void __mark_inode_dirty(struct inode *inode)
+void __mark_inode_dirty(struct inode *inode, int flags)
 {
 	struct super_block * sb = inode->i_sb;
 
 	if (sb) {
 		spin_lock(&inode_lock);
-		if (!(inode->i_state & I_DIRTY)) {
-			inode->i_state |= I_DIRTY;
+		if ((inode->i_state & flags) != flags) {
+			inode->i_state |= flags;
 			/* Only add valid (ie hashed) inodes to the dirty list */
 			if (!list_empty(&inode->i_hash)) {
 				list_del(&inode->i_list);
@@ -196,7 +196,8 @@
 							? &inode_in_use
 							: &inode_unused);
 		/* Set I_LOCK, reset I_DIRTY */
-		inode->i_state ^= I_DIRTY | I_LOCK;
+		inode->i_state |= I_LOCK;
+		inode->i_state &= ~I_DIRTY;
 		spin_unlock(&inode_lock);
 
 		write_inode(inode, sync);
@@ -911,7 +912,7 @@
 	if ( IS_NODIRATIME (inode) && S_ISDIR (inode->i_mode) ) return;
 	if ( IS_RDONLY (inode) ) return;
 	inode->i_atime = CURRENT_TIME;
-	mark_inode_dirty (inode);
+	mark_inode_dirty_sync (inode);
 }   /*  End Function update_atime  */
 
 
--- linux-2.4.0-test11/include/linux/fs.h.~1~	Tue Nov 21 15:47:35 2000
+++ linux-2.4.0-test11/include/linux/fs.h	Tue Nov 21 15:47:48 2000
@@ -452,16 +452,25 @@
 };
 
 /* Inode state bits.. */
-#define I_DIRTY		1
-#define I_LOCK		2
-#define I_FREEING	4
-#define I_CLEAR		8
+#define I_DIRTY_SYNC		1 /* Not dirty enough for O_DATASYNC */
+#define I_DIRTY_DATASYNC	2 /* Data-related inode changes pending */
+#define I_LOCK			4
+#define I_FREEING		8
+#define I_CLEAR			16
 
-extern void __mark_inode_dirty(struct inode *);
+#define I_DIRTY (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
+
+extern void __mark_inode_dirty(struct inode *, int);
 static inline void mark_inode_dirty(struct inode *inode)
 {
-	if (!(inode->i_state & I_DIRTY))
-		__mark_inode_dirty(inode);
+	if ((inode->i_state & I_DIRTY) != I_DIRTY)
+		__mark_inode_dirty(inode, I_DIRTY);
+}
+
+static inline void mark_inode_dirty_sync(struct inode *inode)
+{
+	if (!(inode->i_state & I_DIRTY_SYNC))
+		__mark_inode_dirty(inode, I_DIRTY_SYNC);
 }
 
 struct fown_struct {
--- linux-2.4.0-test11/mm/filemap.c.~1~	Tue Nov 21 15:47:35 2000
+++ linux-2.4.0-test11/mm/filemap.c	Tue Nov 21 15:47:48 2000
@@ -2462,7 +2462,7 @@
 	if (count) {
 		remove_suid(inode);
 		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-		mark_inode_dirty(inode);
+		mark_inode_dirty_sync(inode);
 	}
 
 	while (count) {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
