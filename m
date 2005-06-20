Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVFUDmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVFUDmI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 23:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVFUDXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 23:23:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:3044 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261641AbVFTW7c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:32 -0400
Cc: maneesh@in.ibm.com
Subject: [PATCH] sysfs-iattr: attach sysfs_dirent before new inode
In-Reply-To: <111930836944@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:29 -0700
Message-Id: <1119308369583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] sysfs-iattr: attach sysfs_dirent before new inode

o The following patch makes sure to attach sysfs_dirent to the dentry before
  allocation a new inode through sysfs_create(). This change is done as
  preparatory work for implementing ->i_op->setattr() functionality for
  sysfs objects.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6fa5c828c7fb6beef7035864bd2b18e7386fbdd5
tree 88c7c0a03fe13ad802721dcd54b9b93733e964fe
parent 050480f12aeab62d39a1a07546606a47217ebefa
author Maneesh Soni <maneesh@in.ibm.com> Tue, 31 May 2005 10:38:12 +0530
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:36 -0700

 fs/sysfs/dir.c |   25 +++++++++++++++----------
 1 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -101,18 +101,19 @@ static int create_dir(struct kobject * k
 	down(&p->d_inode->i_sem);
 	*d = sysfs_get_dentry(p,n);
 	if (!IS_ERR(*d)) {
-		error = sysfs_create(*d, mode, init_dir);
+		error = sysfs_make_dirent(p->d_fsdata, *d, k, mode, SYSFS_DIR);
 		if (!error) {
-			error = sysfs_make_dirent(p->d_fsdata, *d, k, mode,
-						SYSFS_DIR);
+			error = sysfs_create(*d, mode, init_dir);
 			if (!error) {
 				p->d_inode->i_nlink++;
 				(*d)->d_op = &sysfs_dentry_ops;
 				d_rehash(*d);
 			}
 		}
-		if (error && (error != -EEXIST))
+		if (error && (error != -EEXIST)) {
+			sysfs_put((*d)->d_fsdata);
 			d_drop(*d);
+		}
 		dput(*d);
 	} else
 		error = PTR_ERR(*d);
@@ -171,17 +172,19 @@ static int sysfs_attach_attr(struct sysf
                 init = init_file;
         }
 
+	dentry->d_fsdata = sysfs_get(sd);
+	sd->s_dentry = dentry;
 	error = sysfs_create(dentry, (attr->mode & S_IALLUGO) | S_IFREG, init);
-	if (error)
+	if (error) {
+		sysfs_put(sd);
 		return error;
+	}
 
         if (bin_attr) {
 		dentry->d_inode->i_size = bin_attr->size;
 		dentry->d_inode->i_fop = &bin_fops;
 	}
 	dentry->d_op = &sysfs_dentry_ops;
-	dentry->d_fsdata = sysfs_get(sd);
-	sd->s_dentry = dentry;
 	d_rehash(dentry);
 
 	return 0;
@@ -191,13 +194,15 @@ static int sysfs_attach_link(struct sysf
 {
 	int err = 0;
 
+	dentry->d_fsdata = sysfs_get(sd);
+	sd->s_dentry = dentry;
 	err = sysfs_create(dentry, S_IFLNK|S_IRWXUGO, init_symlink);
 	if (!err) {
 		dentry->d_op = &sysfs_dentry_ops;
-		dentry->d_fsdata = sysfs_get(sd);
-		sd->s_dentry = dentry;
 		d_rehash(dentry);
-	}
+	} else
+		sysfs_put(sd);
+
 	return err;
 }
 

