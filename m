Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBMRnB>; Tue, 13 Feb 2001 12:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129101AbRBMRmv>; Tue, 13 Feb 2001 12:42:51 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:59117 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129027AbRBMRmj>; Tue, 13 Feb 2001 12:42:39 -0500
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org,
        "Andreas J. Koenig" <andreas.koenig@anima.de>
Subject: [Patch] correct tmpfs link count for directories
Organisation: SAP LinuxLab
Date: 13 Feb 2001 18:47:43 +0100
Message-ID: <m3zofq3268.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

The attached patch makes tmpfs behave more like other fs's. Apparently
perl expects this.

Greetings
		Christoph

diff -uNr 2.4.1-ac10/mm/shmem.c 2.4.1-ac10-nlink/mm/shmem.c
--- 2.4.1-ac10/mm/shmem.c	Mon Feb 12 15:01:47 2001
+++ 2.4.1-ac10-nlink/mm/shmem.c	Tue Feb 13 13:48:49 2001
@@ -465,6 +465,7 @@
 			inode->i_fop = &shmem_file_operations;
 			break;
 		case S_IFDIR:
+			inode->i_nlink++;
 			inode->i_op = &shmem_dir_inode_operations;
 			inode->i_fop = &shmem_dir_operations;
 			break;
@@ -743,7 +744,12 @@
 
 static int shmem_mkdir(struct inode * dir, struct dentry * dentry, int mode)
 {
-	return shmem_mknod(dir, dentry, mode | S_IFDIR, 0);
+	int error;
+
+	if ((error = shmem_mknod(dir, dentry, mode | S_IFDIR, 0)))
+		return error;
+	dir->i_nlink++;
+	return 0;
 }
 
 static int shmem_create(struct inode *dir, struct dentry *dentry, int mode)
@@ -801,25 +807,21 @@
 	return 1;
 }
 
-/*
- * This works for both directories and regular files.
- * (non-directories will always have empty subdirs)
- */
 static int shmem_unlink(struct inode * dir, struct dentry *dentry)
 {
-	int retval = -ENOTEMPTY;
+	dentry->d_inode->i_nlink--;
+	dput(dentry);	/* Undo the count from "create" - this does all the work */
+	return 0;
+}
 
-	if (shmem_empty(dentry)) {
-		struct inode *inode = dentry->d_inode;
+static int shmem_rmdir(struct inode * dir, struct dentry *dentry)
+{
+	if (!shmem_empty(dentry))
+		return -ENOTEMPTY;
 
-		inode->i_nlink--;
-		dput(dentry);	/* Undo the count from "create" - this does all the work */
-		retval = 0;
-	}
-	return retval;
+	dir->i_nlink--;
+	return shmem_unlink(dir, dentry);
 }
-
-#define shmem_rmdir shmem_unlink
 
 /*
  * The VFS layer already does all the dentry stuff for rename,


