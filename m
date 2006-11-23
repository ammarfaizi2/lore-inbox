Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933168AbWKWIMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933168AbWKWIMj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 03:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933187AbWKWIMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 03:12:38 -0500
Received: from tomts43.bellnexxia.net ([209.226.175.110]:19949 "EHLO
	tomts43-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S933168AbWKWIMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 03:12:37 -0500
Date: Thu, 23 Nov 2006 03:12:35 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Greg KH <greg@kroah.com>
Cc: ltt-dev@shafik.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] DebugFS : file/directory creation error handling, 2.6.18
Message-ID: <20061123081235.GE1703@Krystal>
References: <20061120181838.GB7328@Krystal> <20061122052730.GD20836@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061122052730.GD20836@kroah.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 03:00:11 up 92 days,  5:08,  3 users,  load average: 0.15, 0.26, 0.24
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct dentry count to handle creation errors.

This patch puts a dput at the file creation instead of the file removal :
lookup_one_len already returns a dentry with reference count of 1. Then, 
the dget() in simple_mknod increments it when the dentry is associated with a
file. In a scenario where simple_create or simple_mkdir returns an error, this
would lead to an unwanted increment of the reference counter, therefore making
file removal impossible.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>


--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -153,10 +153,10 @@
 			error = debugfs_mkdir(parent->d_inode, *dentry, mode);
 		else 
 			error = debugfs_create(parent->d_inode, *dentry, mode);
+		dput(*dentry);
 	} else
 		error = PTR_ERR(dentry);
 	mutex_unlock(&parent->d_inode->i_mutex);
-
 	return error;
 }
 
@@ -265,6 +265,7 @@
 void debugfs_remove(struct dentry *dentry)
 {
 	struct dentry *parent;
+	int ret = 0;
 	
 	if (!dentry)
 		return;
@@ -276,11 +277,15 @@
 	mutex_lock(&parent->d_inode->i_mutex);
 	if (debugfs_positive(dentry)) {
 		if (dentry->d_inode) {
-			if (S_ISDIR(dentry->d_inode->i_mode))
-				simple_rmdir(parent->d_inode, dentry);
-			else
+			if (S_ISDIR(dentry->d_inode->i_mode)) {
+				ret = simple_rmdir(parent->d_inode, dentry);
+				if (ret)
+					printk(KERN_ERR
+						"DebugFS rmdir on %s failed : "
+						"directory not empty.\n",
+						dentry->d_name.name);
+			} else
 				simple_unlink(parent->d_inode, dentry);
-		dput(dentry);
 		}
 	}
 	mutex_unlock(&parent->d_inode->i_mutex);

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
