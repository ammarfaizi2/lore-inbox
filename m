Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316057AbSEJQIK>; Fri, 10 May 2002 12:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316056AbSEJQIJ>; Fri, 10 May 2002 12:08:09 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:908 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S316057AbSEJQHb>; Fri, 10 May 2002 12:07:31 -0400
Date: Fri, 10 May 2002 12:07:30 -0400
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>,
        trond.myklebust@fys.uio.no, reiserfs-dev@namesys.com
Subject: [PATCH] iget-locked [2/6]
Message-ID: <20020510160730.GC18065@ravel.coda.cs.cmu.edu>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	Alexander Viro <viro@math.psu.edu>, trond.myklebust@fys.uio.no,
	reiserfs-dev@namesys.com
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
it is still pretty much identical except for function naming.

======

diff -urN iget_locked-1/fs/Makefile iget_locked-2/fs/Makefile
--- iget_locked-1/fs/Makefile	Wed May  1 00:27:34 2002
+++ iget_locked-2/fs/Makefile	Fri May 10 10:33:12 2002
@@ -7,7 +7,7 @@
 
 O_TARGET := fs.o
 
-export-objs :=	filesystems.o open.o dcache.o buffer.o bio.o
+export-objs :=	filesystems.o open.o dcache.o buffer.o bio.o inode.o
 mod-subdirs :=	nls
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
diff -urN iget_locked-1/fs/inode.c iget_locked-2/fs/inode.c
--- iget_locked-1/fs/inode.c	Fri May 10 10:32:03 2002
+++ iget_locked-2/fs/inode.c	Fri May 10 10:33:12 2002
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
@@ -527,7 +543,7 @@
 				inodes_stat.nr_inodes++;
 				list_add(&inode->i_list, &inode_in_use);
 				list_add(&inode->i_hash, head);
-				inode->i_state = I_LOCK;
+				inode->i_state = I_LOCK|I_NEW;
 			}
 			spin_unlock(&inode_lock);
 
@@ -536,28 +552,9 @@
 				return NULL;
 			}
 
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
 
@@ -637,8 +634,12 @@
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
@@ -658,6 +659,36 @@
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
--- iget_locked-1/include/linux/fs.h	Fri May 10 10:32:04 2002
+++ iget_locked-2/include/linux/fs.h	Fri May 10 10:33:12 2002
@@ -832,6 +832,7 @@
 #define I_LOCK			8
 #define I_FREEING		16
 #define I_CLEAR			32
+#define I_NEW			64
 
 #define I_DIRTY (I_DIRTY_SYNC | I_DIRTY_DATASYNC | I_DIRTY_PAGES)
 
@@ -1239,6 +1240,10 @@
 extern void force_delete(struct inode *);
 extern struct inode * igrab(struct inode *);
 extern ino_t iunique(struct super_block *, ino_t);
+
+extern struct inode * iget5_locked(struct super_block *, unsigned long, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *);
+extern struct inode * iget_locked(struct super_block *, unsigned long);
+extern void unlock_new_inode(struct inode *);
 
 extern struct inode * iget4(struct super_block *, unsigned long, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *);
 static inline struct inode *iget(struct super_block *sb, unsigned long ino)
