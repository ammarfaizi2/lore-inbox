Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315975AbSETNJL>; Mon, 20 May 2002 09:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315974AbSETNJK>; Mon, 20 May 2002 09:09:10 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:48289 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S315975AbSETNJG>; Mon, 20 May 2002 09:09:06 -0400
Date: Mon, 20 May 2002 09:09:06 -0400
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.16 iget_locked [4/6]
Message-ID: <20020520130906.GC13865@ravel.coda.cs.cmu.edu>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020520130005.GA13816@ravel.coda.cs.cmu.edu> <20020520130435.GA13865@ravel.coda.cs.cmu.edu> <20020520130535.GB13865@ravel.coda.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now that we have no more users of iget4 we can kill the function and the
associated read_inode2 callback (i.e. the 'reiserfs specific hack').

Document iget5_locked as the replacement for iget4 in filesystems/porting.


diff -urN iget_locked-3/Documentation/filesystems/Locking iget_locked-4/Documentation/filesystems/Locking
--- iget_locked-3/Documentation/filesystems/Locking	Mon May  6 11:01:57 2002
+++ iget_locked-4/Documentation/filesystems/Locking	Sun May 19 18:11:28 2002
@@ -115,7 +115,7 @@
 remount_fs:	yes	yes	maybe		(see below)
 umount_begin:	yes	no	maybe		(see below)
 
-->read_inode() is not a method - it's a callback used in iget()/iget4().
+->read_inode() is not a method - it's a callback used in iget().
 rules for mount_sem are not too nice - it is going to die and be replaced
 by better scheme anyway.
 
diff -urN iget_locked-3/Documentation/filesystems/porting iget_locked-4/Documentation/filesystems/porting
--- iget_locked-3/Documentation/filesystems/porting	Sun May 19 17:52:42 2002
+++ iget_locked-4/Documentation/filesystems/porting	Sun May 19 18:12:14 2002
@@ -152,3 +152,36 @@
 s_export_op is now required for exporting a filesystem.
 isofs, ext2, ext3, resierfs, fat
 can be used as examples of very different filesystems.
+
+---
+[mandatory]
+
+iget4() and the read_inode2 callback have been superseded by iget5_locked()
+which has the following prototype,
+
+    struct inode *iget5_locked(struct super_block *sb, unsigned long ino,
+				int (*test)(struct inode *, void *),
+				int (*set)(struct inode *, void *),
+				void *data);
+
+'test' is an additional function that can be used when the inode
+number is not sufficient to identify the actual file object. 'set'
+should be a non-blocking function that initializes those parts of a
+newly created inode to allow the test function to succeed. 'data' is
+passed as an opaque value to both test and set functions.
+
+When the inode has been created by iget5_locked(), it will be returned with
+the I_NEW flag set and will still be locked. read_inode has not been
+called so the file system still has to finalize the initialization. Once
+the inode is initialized it must be unlocked by calling unlock_new_inode().
+
+There is also a simpler iget_locked function that just takes the
+superblock and inode number as arguments.
+
+e.g.
+       inode = iget_locked(sb, ino);
+       if (inode->i_state & I_NEW) {
+               read_inode_from_disk(inode);
+               unlock_new_inode(inode);
+       }
+
diff -urN iget_locked-3/fs/inode.c iget_locked-4/fs/inode.c
--- iget_locked-3/fs/inode.c	Sun May 19 18:02:54 2002
+++ iget_locked-4/fs/inode.c	Sun May 19 18:11:28 2002
@@ -669,27 +669,6 @@
 EXPORT_SYMBOL(iget_locked);
 EXPORT_SYMBOL(unlock_new_inode);
 
-struct inode *iget4(struct super_block *sb, unsigned long ino, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *data)
-{
-	struct inode *inode = iget5_locked(sb, ino, test, set, data);
-
-	if (inode && (inode->i_state & I_NEW)) {
-		/* reiserfs specific hack right here.  We don't
-		** want this to last, and are looking for VFS changes
-		** that will allow us to get rid of it.
-		** -- mason@suse.com 
-		*/
-		if (sb->s_op->read_inode2) {
-			sb->s_op->read_inode2(inode, data);
-		} else {
-			sb->s_op->read_inode(inode);
-		}
-		unlock_new_inode(inode);
-	}
-
-	return inode;
-}
-
 /**
  *	insert_inode_hash - hash an inode
  *	@inode: unhashed inode
diff -urN iget_locked-3/include/linux/fs.h iget_locked-4/include/linux/fs.h
--- iget_locked-3/include/linux/fs.h	Sun May 19 18:04:27 2002
+++ iget_locked-4/include/linux/fs.h	Sun May 19 18:11:28 2002
@@ -769,13 +769,6 @@
 
 	void (*read_inode) (struct inode *);
   
-  	/* reiserfs kludge.  reiserfs needs 64 bits of information to
-    	** find an inode.  We are using the read_inode2 call to get
-   	** that information.  We don't like this, and are waiting on some
-   	** VFS changes for the real solution.
-   	** iget4 calls read_inode2, iff it is defined
-   	*/
-    	void (*read_inode2) (struct inode *, void *) ;
    	void (*dirty_inode) (struct inode *);
 	void (*write_inode) (struct inode *, int);
 	void (*put_inode) (struct inode *);
@@ -1212,7 +1205,6 @@
 extern struct inode * iget_locked(struct super_block *, unsigned long);
 extern void unlock_new_inode(struct inode *);
 
-extern struct inode * iget4(struct super_block *, unsigned long, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *);
 static inline struct inode *iget(struct super_block *sb, unsigned long ino)
 {
 	struct inode *inode = iget_locked(sb, ino);
diff -urN iget_locked-3/kernel/ksyms.c iget_locked-4/kernel/ksyms.c
--- iget_locked-3/kernel/ksyms.c	Sun May 19 17:52:58 2002
+++ iget_locked-4/kernel/ksyms.c	Sun May 19 18:11:28 2002
@@ -137,7 +137,6 @@
 EXPORT_SYMBOL(fget);
 EXPORT_SYMBOL(igrab);
 EXPORT_SYMBOL(iunique);
-EXPORT_SYMBOL(iget4);
 EXPORT_SYMBOL(iput);
 EXPORT_SYMBOL(inode_init_once);
 EXPORT_SYMBOL(force_delete);
