Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbUCRSCr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 13:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbUCRSCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 13:02:47 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:27054 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262831AbUCRSB2
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Thu, 18 Mar 2004 13:01:28 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16473.58358.202765.974382@laputa.namesys.com>
Date: Thu, 18 Mar 2004 21:01:26 +0300
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Cc: Andrew Morton <AKPM@Osdl.ORG>, Linus Torvalds <Torvalds@Osdl.ORG>
Subject: [PATCH] remove_suid() should return error code
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

remove_suid() ignores return value of
notify_change()->i_op->setattr(). This mean, that even if file system
fails to clear suid bit, generic_file_aio_write_nolock() proceeds with
write, which is unsafe.

Actually, even ext2's ->setattr() can fail, when trying to update ACL,
for example.

Attached patch modifies remove_suid() to return result of ->setattr(),
and updates in-tree callers.

Nikita.
----------------------------------------------------------------------
diff -puN -b mm/filemap.c~remove_suid-return mm/filemap.c
--- i386/mm/filemap.c~remove_suid-return	Thu Mar 18 20:33:41 2004
+++ i386-god/mm/filemap.c	Thu Mar 18 20:36:05 2004
@@ -1506,10 +1506,11 @@ repeat:
  *	if suid or (sgid and xgrp)
  *		remove privs
  */
-void remove_suid(struct dentry *dentry)
+int remove_suid(struct dentry *dentry)
 {
 	mode_t mode = dentry->d_inode->i_mode;
 	int kill = 0;
+	int result = 0;
 
 	/* suid always must be killed */
 	if (unlikely(mode & S_ISUID))
@@ -1526,8 +1527,9 @@ void remove_suid(struct dentry *dentry)
 		struct iattr newattrs;
 
 		newattrs.ia_valid = ATTR_FORCE | kill;
-		notify_change(dentry, &newattrs);
+		result = notify_change(dentry, &newattrs);
 	}
+	return result;
 }
 EXPORT_SYMBOL(remove_suid);
 
@@ -1785,7 +1787,10 @@ generic_file_aio_write_nolock(struct kio
 	if (count == 0)
 		goto out;
 
-	remove_suid(file->f_dentry);
+	err = remove_suid(file->f_dentry);
+	if (err)
+		goto out;
+
 	inode_update_time(inode, 1);
 
 	/* coalesce the iovecs and go direct-to-BIO for O_DIRECT */
diff -puN -b mm/shmem.c~remove_suid-return mm/shmem.c
--- i386/mm/shmem.c~remove_suid-return	Thu Mar 18 20:33:41 2004
+++ i386-god/mm/shmem.c	Thu Mar 18 20:35:35 2004
@@ -1215,7 +1215,10 @@ shmem_file_write(struct file *file, cons
 		}
 	}
 
-	remove_suid(file->f_dentry);
+	err = remove_suid(file->f_dentry);
+	if (err)
+		goto out;
+
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 
 	do {
diff -puN -b include/linux/fs.h~remove_suid-return include/linux/fs.h
--- i386/include/linux/fs.h~remove_suid-return	Thu Mar 18 20:33:41 2004
+++ i386-god/include/linux/fs.h	Thu Mar 18 20:35:44 2004
@@ -1282,7 +1282,7 @@ extern void __iget(struct inode * inode)
 extern void clear_inode(struct inode *);
 extern void destroy_inode(struct inode *);
 extern struct inode *new_inode(struct super_block *);
-extern void remove_suid(struct dentry *);
+extern int remove_suid(struct dentry *);
 
 extern void __insert_inode_hash(struct inode *, unsigned long hashval);
 extern void remove_inode_hash(struct inode *);
diff -puN -b fs/reiserfs/file.c~remove_suid-return fs/reiserfs/file.c
--- i386/fs/reiserfs/file.c~remove_suid-return	Thu Mar 18 20:34:33 2004
+++ i386-god/fs/reiserfs/file.c	Thu Mar 18 20:35:00 2004
@@ -1060,7 +1060,10 @@ ssize_t reiserfs_file_write( struct file
     if ( count == 0 )
 	goto out;
 
-    remove_suid(file->f_dentry);
+    res = remove_suid(file->f_dentry);
+    if (res)
+	goto out;
+
     inode_update_time(inode, 1); /* Both mtime and ctime */
 
     // Ok, we are done with all the checks.

_
