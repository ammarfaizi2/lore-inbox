Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130735AbRBNSkI>; Wed, 14 Feb 2001 13:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130736AbRBNSj6>; Wed, 14 Feb 2001 13:39:58 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:2533 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S130735AbRBNSjw>; Wed, 14 Feb 2001 13:39:52 -0500
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org,
        "Andreas J. Koenig" <andreas.koenig@anima.de>
Subject: [Patch] make file times work in tmpfs
Organisation: SAP LinuxLab
Message-ID: <m3hf1x16ed.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 14 Feb 2001 19:45:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

here is a patch that makes the different file timestamps work on
tmpfs.

Greetings
		Christoph

--- mac10/mm/shmem.c.orig	Wed Feb 14 14:39:46 2001
+++ mac10/mm/shmem.c	Wed Feb 14 15:30:09 2001
@@ -160,6 +160,7 @@
 	swp_entry_t **base, **ptr, **last;
 	struct shmem_inode_info * info = &inode->u.shmem_i;
 
+	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	spin_lock (&info->lock);
 	index = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	if (index > info->max_index)
@@ -734,6 +735,7 @@
 	struct inode * inode = shmem_get_inode(dir->i_sb, mode, dev);
 	int error = -ENOSPC;
 
+	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	if (inode) {
 		d_instantiate(dentry, inode);
 		dget(dentry); /* Extra count - pin the dentry in core */
@@ -767,6 +769,7 @@
 	if (S_ISDIR(inode->i_mode))
 		return -EPERM;
 
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	inode->i_nlink++;
 	atomic_inc(&inode->i_count);	/* New dentry reference */
 	dget(dentry);		/* Extra pinning count for the created dentry */
@@ -809,7 +812,9 @@
 
 static int shmem_unlink(struct inode * dir, struct dentry *dentry)
 {
-	dentry->d_inode->i_nlink--;
+	struct inode *inode = dentry->d_inode;
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	inode->i_nlink--;
 	dput(dentry);	/* Undo the count from "create" - this does all the work */
 	return 0;
 }
@@ -836,10 +841,12 @@
 	if (shmem_empty(new_dentry)) {
 		struct inode *inode = new_dentry->d_inode;
 		if (inode) {
+			inode->i_ctime = CURRENT_TIME;
 			inode->i_nlink--;
 			dput(new_dentry);
 		}
 		error = 0;
+		old_dentry->d_inode->i_ctime = old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
 	}
 	return error;
 }
@@ -873,6 +880,7 @@
 	UnlockPage(page);
 	page_cache_release(page);
 	up(&inode->i_sem);
+	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	return 0;
 fail:
 	up(&inode->i_sem);

