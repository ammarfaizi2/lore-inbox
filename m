Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136492AbRD3REC>; Mon, 30 Apr 2001 13:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136496AbRD3RDu>; Mon, 30 Apr 2001 13:03:50 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:28173 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S136497AbRD3RDV>; Mon, 30 Apr 2001 13:03:21 -0400
Date: Mon, 30 Apr 2001 12:23:56 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, "Stephen C. Tweedie" <sct@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix fsync/fdatasync races 
Message-ID: <Pine.LNX.4.21.0104301213350.2097-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

The following patch implements a new super_operations "wait_inode"
operation on ext2 to fix the generic_osync_inode/fsync/fdatasync race I
mentioned sometime ago.

We still have to implement the wait_inode operation on _all_ block
filesystems to make them safe. 

Comments?

diff --exclude-from=exclude -Nur linux.orig/fs/ext2/fsync.c linux/fs/ext2/fsync.c
--- linux.orig/fs/ext2/fsync.c	Mon Apr 30 11:50:22 2001
+++ linux/fs/ext2/fsync.c	Mon Apr 30 13:26:22 2001
@@ -44,10 +44,15 @@
 	int err;
 	
 	err  = fsync_inode_buffers(inode);
-	if (!(inode->i_state & I_DIRTY))
+	if (!(inode->i_state & I_DIRTY)) {
+		wait_on_inode(inode);
+		wait_inode_bh(inode);
 		return err;
-	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
+	}
+	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC)) {
+		wait_on_inode(inode);
 		return err;
+	}
 	
 	err |= ext2_sync_inode(inode);
 	return err ? -EIO : 0;
diff --exclude-from=exclude -Nur linux.orig/fs/ext2/inode.c linux/fs/ext2/inode.c
--- linux.orig/fs/ext2/inode.c	Mon Apr 30 11:50:22 2001
+++ linux/fs/ext2/inode.c	Mon Apr 30 13:56:12 2001
@@ -1102,6 +1102,54 @@
 	return;
 }
 
+int ext2_wait_inode(struct inode * inode) 
+{
+	struct buffer_head *bh;
+	unsigned long block_group;
+	unsigned long group_desc;
+	unsigned long desc;
+	unsigned long block;
+	unsigned long offset;
+	struct ext2_group_desc * gdp;
+
+	if ((inode->i_ino != EXT2_ROOT_INO &&
+	     inode->i_ino < EXT2_FIRST_INO(inode->i_sb)) ||
+	    inode->i_ino > le32_to_cpu(inode->i_sb->u.ext2_sb.s_es->s_inodes_count)) {
+		ext2_error (inode->i_sb, "ext2_wait_inode",
+			    "bad inode number: %lu", inode->i_ino);
+		return -EIO;
+	}
+	block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
+	if (block_group >= inode->i_sb->u.ext2_sb.s_groups_count) {
+		ext2_error (inode->i_sb, "ext2_wait_inode",
+			    "group >= groups count");
+		return -EIO;
+	}
+	group_desc = block_group >> EXT2_DESC_PER_BLOCK_BITS(inode->i_sb);
+	desc = block_group & (EXT2_DESC_PER_BLOCK(inode->i_sb) - 1);
+	bh = inode->i_sb->u.ext2_sb.s_group_desc[group_desc];
+	if (!bh) {
+		ext2_error (inode->i_sb, "ext2_wait_inode",
+			    "Descriptor not loaded");
+		return -EIO;
+	}
+	gdp = (struct ext2_group_desc *) bh->b_data;
+
+	/*
+	 * Figure out the offset within the block group inode table
+	 */
+	offset = ((inode->i_ino - 1) % EXT2_INODES_PER_GROUP(inode->i_sb)) *
+		EXT2_INODE_SIZE(inode->i_sb);
+	block = le32_to_cpu(gdp[desc].bg_inode_table) +
+		(offset >> EXT2_BLOCK_SIZE_BITS(inode->i_sb));
+	bh = get_hash_table(inode->i_dev, block, inode->i_sb->s_blocksize);
+
+	if (bh)
+		wait_on_buffer(bh);
+
+	return 0;
+}
+
 static int ext2_update_inode(struct inode * inode, int do_sync)
 {
 	struct buffer_head * bh;
diff --exclude-from=exclude -Nur linux.orig/fs/ext2/super.c linux/fs/ext2/super.c
--- linux.orig/fs/ext2/super.c	Mon Apr 30 11:50:22 2001
+++ linux/fs/ext2/super.c	Mon Apr 30 13:31:12 2001
@@ -149,6 +149,7 @@
 static struct super_operations ext2_sops = {
 	read_inode:	ext2_read_inode,
 	write_inode:	ext2_write_inode,
+	wait_inode:	ext2_wait_inode,
 	put_inode:	ext2_put_inode,
 	delete_inode:	ext2_delete_inode,
 	put_super:	ext2_put_super,
diff --exclude-from=exclude -Nur linux.orig/fs/inode.c linux/fs/inode.c
--- linux.orig/fs/inode.c	Mon Apr 30 11:50:22 2001
+++ linux/fs/inode.c	Mon Apr 30 13:45:52 2001
@@ -155,7 +155,7 @@
 	spin_unlock(&inode_lock);
 }
 
-static void __wait_on_inode(struct inode * inode)
+void __wait_on_inode(struct inode * inode)
 {
 	DECLARE_WAITQUEUE(wait, current);
 
@@ -170,13 +170,6 @@
 	current->state = TASK_RUNNING;
 }
 
-static inline void wait_on_inode(struct inode *inode)
-{
-	if (inode->i_state & I_LOCK)
-		__wait_on_inode(inode);
-}
-
-
 static inline void write_inode(struct inode *inode, int sync)
 {
 	if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->write_inode && !is_bad_inode(inode))
@@ -406,8 +399,20 @@
 
 	if (sb) {
 		spin_lock(&inode_lock);
-		while (inode->i_state & I_DIRTY)
+		if (inode->i_state & I_DIRTY)
 			sync_one(inode, sync);
+		/* 
+		 * If its a synchronous inode write operation, 
+		 * and the inode is still locked, we have to wait
+		 * on the fs's underlying buffer_head to _guarantee_
+		 * that the inode data safely reached disk.
+		 */
+		else if ((inode->i_state & I_LOCK) && sync) {
+			spin_unlock(&inode_lock);
+			wait_on_inode(inode);
+			wait_inode_bh(inode);
+			return;
+		}
 		spin_unlock(&inode_lock);
 	}
 	else
@@ -453,18 +458,35 @@
 #else
 	err = fsync_inode_buffers(inode);
 #endif
-
+		
 	spin_lock(&inode_lock);
-	if (!(inode->i_state & I_DIRTY))
-		goto out;
-	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
-		goto out;
+	if (!(inode->i_state & I_DIRTY)) {
+		spin_unlock(&inode_lock);
+	/* 
+	 * Even if the inode is not "dirty", we have to:
+	 * 1) wait for it to become unlocked, guaranteeing that all 
+	 * inode dirty pages have been written to disk. and
+	 * 2) wait for the buffer_head which represents the inode metadata 
+	 * to get unlocked, guaranteeing that dirty inode metadata has been 
+	 * written to disk.
+	 *   
+	 *   - Marcelo
+	 */
+		wait_on_inode(inode);
+		wait_inode_bh(inode);
+		return err;
+	}
+	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC)) {
+		spin_unlock(&inode_lock);
+	/* 
+	 * Only rule #1 of the comment above is valid because here we
+	 * don't care about potential dirty metadata being synced.
+	 */
+		wait_on_inode(inode);
+		return err;
+	}
 	spin_unlock(&inode_lock);
 	write_inode_now(inode, 1);
-	return err;
-
- out:
-	spin_unlock(&inode_lock);
 	return err;
 }
 
diff --exclude-from=exclude -Nur linux.orig/include/linux/ext2_fs.h linux/include/linux/ext2_fs.h
--- linux.orig/include/linux/ext2_fs.h	Mon Apr 30 11:50:24 2001
+++ linux/include/linux/ext2_fs.h	Mon Apr 30 13:35:46 2001
@@ -577,6 +577,7 @@
 
 extern void ext2_read_inode (struct inode *);
 extern void ext2_write_inode (struct inode *, int);
+extern int ext2_wait_inode (struct inode *);
 extern void ext2_put_inode (struct inode *);
 extern void ext2_delete_inode (struct inode *);
 extern int ext2_sync_inode (struct inode *);
diff --exclude-from=exclude -Nur linux.orig/include/linux/fs.h linux/include/linux/fs.h
--- linux.orig/include/linux/fs.h	Mon Apr 30 11:50:24 2001
+++ linux/include/linux/fs.h	Mon Apr 30 13:32:34 2001
@@ -810,6 +810,7 @@
     	void (*read_inode2) (struct inode *, void *) ;
    	void (*dirty_inode) (struct inode *);
 	void (*write_inode) (struct inode *, int);
+	int (*wait_inode) (struct inode *);
 	void (*put_inode) (struct inode *);
 	void (*delete_inode) (struct inode *);
 	void (*put_super) (struct super_block *);
@@ -831,6 +832,19 @@
 #define I_CLEAR			32
 
 #define I_DIRTY (I_DIRTY_SYNC | I_DIRTY_DATASYNC | I_DIRTY_PAGES)
+
+extern void __wait_on_inode(struct inode * inode);
+static inline void wait_on_inode(struct inode *inode)
+{
+        if (inode->i_state & I_LOCK)
+                __wait_on_inode(inode);
+}
+
+static inline void wait_inode_bh(struct inode *inode)
+{
+        if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->wait_inode)
+                inode->i_sb->s_op->wait_inode(inode);
+}
 
 extern void __mark_inode_dirty(struct inode *, int);
 static inline void mark_inode_dirty(struct inode *inode)

