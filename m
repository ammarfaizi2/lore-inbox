Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbTHYOIf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 10:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbTHYOIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 10:08:35 -0400
Received: from verein.lst.de ([212.34.189.10]:37277 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261828AbTHYOIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 10:08:21 -0400
Date: Mon, 25 Aug 2003 16:07:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: marcelo@hera.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] backport iget_locked from 2.5/2.6
Message-ID: <20030825140714.GA17359@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, marcelo@hera.kernel.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3 () PATCH_UNIFIED_DIFF,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an iget variant without unlocking the inode and ->read_inode
call.  This is needed for XFS and IIRC the reiserfs folks wanted it,
too.

Tested in 2.5 for more than half a year and in 2.4-ac/-aa, and
the varoius vendor trees for a long time.


--- 1.37/fs/inode.c	Thu Jul 10 11:51:08 2003
+++ edited/fs/inode.c	Tue Aug  5 01:42:38 2003
@@ -834,6 +839,20 @@
 	return inode;
 }
 
+void unlock_new_inode(struct inode *inode)
+{
+	/*
+	 * This is special!  We do not need the spinlock
+	 * when clearing I_LOCK, because we're guaranteed
+	 * that nobody else tries to do anything about the
+	 * state of the inode when it is locked, as we
+	 * just created it (so there can be no old holders
+	 * that haven't tested I_LOCK).
+	 */
+	inode->i_state &= ~(I_LOCK|I_NEW);
+	wake_up(&inode->i_wait);
+}
+
 /*
  * This is called without the inode lock held.. Be careful.
  *
@@ -856,31 +875,13 @@
 			list_add(&inode->i_list, &inode_in_use);
 			list_add(&inode->i_hash, head);
 			inode->i_ino = ino;
-			inode->i_state = I_LOCK;
+			inode->i_state = I_LOCK|I_NEW;
 			spin_unlock(&inode_lock);
 
-			/* reiserfs specific hack right here.  We don't
-			** want this to last, and are looking for VFS changes
-			** that will allow us to get rid of it.
-			** -- mason@suse.com 
-			*/
-			if (sb->s_op->read_inode2) {
-				sb->s_op->read_inode2(inode, opaque) ;
-			} else {
-				sb->s_op->read_inode(inode);
-			}
-
 			/*
-			 * This is special!  We do not need the spinlock
-			 * when clearing I_LOCK, because we're guaranteed
-			 * that nobody else tries to do anything about the
-			 * state of the inode when it is locked, as we
-			 * just created it (so there can be no old holders
-			 * that haven't tested I_LOCK).
+			 * Return the locked inode with I_NEW set, the
+			 * caller is responsible for filling in the contents
 			 */
-			inode->i_state &= ~I_LOCK;
-			wake_up(&inode->i_wait);
-
 			return inode;
 		}
 
@@ -960,8 +961,7 @@
 	return inode;
 }
 
-
-struct inode *iget4(struct super_block *sb, unsigned long ino, find_inode_t find_actor, void *opaque)
+struct inode *iget4_locked(struct super_block *sb, unsigned long ino, find_inode_t find_actor, void *opaque)
 {
 	struct list_head * head = inode_hashtable + hash(sb,ino);
 	struct inode * inode;
--- 1.73/include/linux/fs.h	Sun Aug  3 16:50:01 2003
+++ edited/include/linux/fs.h	Thu Aug  7 12:44:44 2003
@@ -966,6 +969,7 @@
 #define I_LOCK			8
 #define I_FREEING		16
 #define I_CLEAR			32
+#define I_NEW			64
 
 #define I_DIRTY (I_DIRTY_SYNC | I_DIRTY_DATASYNC | I_DIRTY_PAGES)
 
@@ -1391,12 +1396,47 @@
 extern void force_delete(struct inode *);
 extern struct inode * igrab(struct inode *);
 extern ino_t iunique(struct super_block *, ino_t);
+extern void unlock_new_inode(struct inode *);
 
 typedef int (*find_inode_t)(struct inode *, unsigned long, void *);
-extern struct inode * iget4(struct super_block *, unsigned long, find_inode_t, void *);
+
+extern struct inode * iget4_locked(struct super_block *, unsigned long,
+				   find_inode_t, void *);
+
+static inline struct inode *iget4(struct super_block *sb, unsigned long ino,
+				  find_inode_t find_actor, void *opaque)
+{
+	struct inode *inode = iget4_locked(sb, ino, find_actor, opaque);
+
+	if (inode && (inode->i_state & I_NEW)) {
+		/*
+		 * reiserfs-specific kludge that is expected to go away ASAP.
+		 */
+		if (sb->s_op->read_inode2)
+			sb->s_op->read_inode2(inode, opaque);
+		else
+			sb->s_op->read_inode(inode);
+		unlock_new_inode(inode);
+	}
+
+	return inode;
+}
+
 static inline struct inode *iget(struct super_block *sb, unsigned long ino)
 {
-	return iget4(sb, ino, NULL, NULL);
+	struct inode *inode = iget4_locked(sb, ino, NULL, NULL);
+
+	if (inode && (inode->i_state & I_NEW)) {
+		sb->s_op->read_inode(inode);
+		unlock_new_inode(inode);
+	}
+
+	return inode;
+}
+
+static inline struct inode *iget_locked(struct super_block *sb, unsigned long ino)
+{
+	return iget4_locked(sb, ino, NULL, NULL);
 }
 
 extern void clear_inode(struct inode *);
--- 1.67/kernel/ksyms.c	Sun Aug  3 16:50:01 2003
+++ edited/kernel/ksyms.c	Tue Aug  5 01:44:42 2003
@@ -143,7 +143,8 @@
 EXPORT_SYMBOL(fget);
 EXPORT_SYMBOL(igrab);
 EXPORT_SYMBOL(iunique);
-EXPORT_SYMBOL(iget4);
+EXPORT_SYMBOL(iget4_locked);
+EXPORT_SYMBOL(unlock_new_inode);
 EXPORT_SYMBOL(iput);
 EXPORT_SYMBOL(inode_init_once);
 EXPORT_SYMBOL(force_delete);
