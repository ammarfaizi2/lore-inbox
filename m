Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSETNEk>; Mon, 20 May 2002 09:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315961AbSETNEj>; Mon, 20 May 2002 09:04:39 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:45729 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S315942AbSETNEg>; Mon, 20 May 2002 09:04:36 -0400
Date: Mon, 20 May 2002 09:04:35 -0400
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.16 iget_locked [2/6]
Message-ID: <20020520130435.GA13865@ravel.coda.cs.cmu.edu>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020520130005.GA13816@ravel.coda.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now we introduce iget_locked and iget5_locked. These are similar to
iget, but return a locked inode and read_inode has not been called. So
the FS has to call read_inode to initialize the inode and then unlock
it with unlock_new_inode().

This patch is based on the icreate patch from the XFS group, i.e.
it is pretty much identical except for function naming.


diff -urN iget_locked-1/fs/Makefile iget_locked-2/fs/Makefile
--- iget_locked-1/fs/Makefile	Wed May  1 00:27:34 2002
+++ iget_locked-2/fs/Makefile	Sun May 19 18:02:05 2002
@@ -7,7 +7,7 @@
 
 O_TARGET := fs.o
 
-export-objs :=	filesystems.o open.o dcache.o buffer.o bio.o
+export-objs :=	filesystems.o open.o dcache.o buffer.o bio.o inode.o
 mod-subdirs :=	nls
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
diff -urN iget_locked-1/fs/inode.c iget_locked-2/fs/inode.c
--- iget_locked-1/fs/inode.c	Sun May 19 18:00:59 2002
+++ iget_locked-2/fs/inode.c	Sun May 19 18:02:54 2002
@@ -12,6 +12,7 @@
 #include <linux/quotaops.h>
 #include <linux/slab.h>
 #include <linux/writeback.h>
+#include <linux/module.h>
 
 /*
  * New inode.c implementation.
@@ -501,6 +502,21 @@
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
+
 /*
  * This is called without the inode lock held.. Be careful.
  *
@@ -527,31 +543,12 @@
 			inodes_stat.nr_inodes++;
 			list_add(&inode->i_list, &inode_in_use);
 			list_add(&inode->i_hash, head);
-			inode->i_state = I_LOCK;
+			inode->i_state = I_LOCK|I_NEW;
 			spin_unlock(&inode_lock);
 
-			/* reiserfs specific hack right here.  We don't
-			** want this to last, and are looking for VFS changes
-			** that will allow us to get rid of it.
-			** -- mason@suse.com 
-			*/
-			if (sb->s_op->read_inode2) {
-				sb->s_op->read_inode2(inode, data) ;
-			} else {
-				sb->s_op->read_inode(inode);
-			}
-
-			/*
-			 * This is special!  We do not need the spinlock
-			 * when clearing I_LOCK, because we're guaranteed
-			 * that nobody else tries to do anything about the
-			 * state of the inode when it is locked, as we
-			 * just created it (so there can be no old holders
-			 * that haven't tested I_LOCK).
+			/* Return the locked inode with I_NEW set, the
+			 * caller is responsible for filling in the contents
 			 */
-			inode->i_state &= ~I_LOCK;
-			wake_up(&inode->i_wait);
-
 			return inode;
 		}
 
@@ -636,8 +633,12 @@
 	return inode;
 }
 
-
-struct inode *iget4(struct super_block *sb, unsigned long ino, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *data)
+/*
+ * This is iget without the read_inode portion of get_new_inode
+ * the filesystem gets back a new locked and hashed inode and gets
+ * to fill it in before unlocking it via unlock_new_inode().
+ */
+struct inode *iget5_locked(struct super_block *sb, unsigned long ino, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *data)
 {
 	struct list_head * head = inode_hashtable + hash(sb,ino);
 	struct inode * inode;
@@ -657,6 +658,36 @@
 	 * in case it had to block at any point.
 	 */
 	return get_new_inode(sb, ino, head, test, set, data);
+}
+
+struct inode *iget_locked(struct super_block *sb, unsigned long ino)
+{
+	return iget5_locked(sb, ino, NULL, NULL, NULL);
+}
+
+EXPORT_SYMBOL(iget5_locked);
+EXPORT_SYMBOL(iget_locked);
+EXPORT_SYMBOL(unlock_new_inode);
+
+struct inode *iget4(struct super_block *sb, unsigned long ino, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *data)
+{
+	struct inode *inode = iget5_locked(sb, ino, test, set, data);
+
+	if (inode && (inode->i_state & I_NEW)) {
+		/* reiserfs specific hack right here.  We don't
+		** want this to last, and are looking for VFS changes
+		** that will allow us to get rid of it.
+		** -- mason@suse.com 
+		*/
+		if (sb->s_op->read_inode2) {
+			sb->s_op->read_inode2(inode, data);
+		} else {
+			sb->s_op->read_inode(inode);
+		}
+		unlock_new_inode(inode);
+	}
+
+	return inode;
 }
 
 /**
diff -urN iget_locked-1/include/linux/fs.h iget_locked-2/include/linux/fs.h
--- iget_locked-1/include/linux/fs.h	Sun May 19 17:55:27 2002
+++ iget_locked-2/include/linux/fs.h	Sun May 19 18:02:05 2002
@@ -799,6 +799,7 @@
 #define I_LOCK			8
 #define I_FREEING		16
 #define I_CLEAR			32
+#define I_NEW			64
 
 #define I_DIRTY (I_DIRTY_SYNC | I_DIRTY_DATASYNC | I_DIRTY_PAGES)
 
@@ -1206,6 +1207,10 @@
 extern void force_delete(struct inode *);
 extern struct inode * igrab(struct inode *);
 extern ino_t iunique(struct super_block *, ino_t);
+
+extern struct inode * iget5_locked(struct super_block *, unsigned long, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *);
+extern struct inode * iget_locked(struct super_block *, unsigned long);
+extern void unlock_new_inode(struct inode *);
 
 extern struct inode * iget4(struct super_block *, unsigned long, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *);
 static inline struct inode *iget(struct super_block *sb, unsigned long ino)
