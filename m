Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316055AbSEJQJK>; Fri, 10 May 2002 12:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316054AbSEJQIr>; Fri, 10 May 2002 12:08:47 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:3468 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S316055AbSEJQIA>; Fri, 10 May 2002 12:08:00 -0400
Date: Fri, 10 May 2002 12:07:57 -0400
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>,
        trond.myklebust@fys.uio.no, reiserfs-dev@namesys.com
Subject: [PATCH] iget_locked [4/6]
Message-ID: <20020510160757.GE18065@ravel.coda.cs.cmu.edu>
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


Now that we have no more users of iget4 we can kill the function and the
associated read_inode2 callback (i.e. the 'reiserfs specific hack').

Document iget5_locked as the replacement for iget4 in filesystems/porting.

======

diff -urN iget_locked-3/Documentation/filesystems/Locking iget_locked-4/Documentation/filesystems/Locking
--- iget_locked-3/Documentation/filesystems/Locking	Mon May  6 11:01:57 2002
+++ iget_locked-4/Documentation/filesystems/Locking	Fri May 10 10:34:17 2002
@@ -115,7 +115,7 @@
 remount_fs:	yes	yes	maybe		(see below)
 umount_begin:	yes	no	maybe		(see below)
 
-->read_inode() is not a method - it's a callback used in iget()/iget4().
+->read_inode() is not a method - it's a callback used in iget().
 rules for mount_sem are not too nice - it is going to die and be replaced
 by better scheme anyway.
 
diff -urN iget_locked-3/Documentation/filesystems/porting iget_locked-4/Documentation/filesystems/porting
--- iget_locked-3/Documentation/filesystems/porting	Mon Apr 29 10:23:27 2002
+++ iget_locked-4/Documentation/filesystems/porting	Fri May 10 10:34:17 2002
@@ -146,3 +146,36 @@
 
 It is planned that this will be required for exporting once the code
 settles down a bit.
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
--- iget_locked-3/fs/inode.c	Fri May 10 10:33:12 2002
+++ iget_locked-4/fs/inode.c	Fri May 10 10:34:17 2002
@@ -670,27 +670,6 @@
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
--- iget_locked-3/include/linux/fs.h	Fri May 10 10:33:31 2002
+++ iget_locked-4/include/linux/fs.h	Fri May 10 10:34:17 2002
@@ -778,13 +778,6 @@
 
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
@@ -1245,7 +1238,6 @@
 extern struct inode * iget_locked(struct super_block *, unsigned long);
 extern void unlock_new_inode(struct inode *);
 
-extern struct inode * iget4(struct super_block *, unsigned long, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *);
 static inline struct inode *iget(struct super_block *sb, unsigned long ino)
 {
 	struct inode *inode = iget_locked(sb, ino);
diff -urN iget_locked-3/kernel/ksyms.c iget_locked-4/kernel/ksyms.c
--- iget_locked-3/kernel/ksyms.c	Sat May  4 19:25:54 2002
+++ iget_locked-4/kernel/ksyms.c	Fri May 10 10:34:17 2002
@@ -137,7 +137,6 @@
 EXPORT_SYMBOL(fget);
 EXPORT_SYMBOL(igrab);
 EXPORT_SYMBOL(iunique);
-EXPORT_SYMBOL(iget4);
 EXPORT_SYMBOL(iput);
 EXPORT_SYMBOL(inode_init_once);
 EXPORT_SYMBOL(force_delete);
