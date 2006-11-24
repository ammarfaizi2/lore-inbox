Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935004AbWKXSuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935004AbWKXSuO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 13:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935007AbWKXSuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 13:50:13 -0500
Received: from tomts13-srv.bellnexxia.net ([209.226.175.34]:4001 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S935004AbWKXSuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 13:50:11 -0500
Date: Fri, 24 Nov 2006 13:50:09 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Greg KH <greg@kroah.com>
Cc: ltt-dev@shafik.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] DebugFS : file/directory creation error handling, 2.6.19-rc6
Message-ID: <20061124185009.GD8952@Krystal>
References: <20061120181838.GB7328@Krystal> <20061122052730.GD20836@kroah.com> <20061123081235.GE1703@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061123081235.GE1703@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 13:49:20 up 93 days, 15:57,  4 users,  load average: 1.12, 0.73, 0.41
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

---BEGIN---
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -161,6 +161,7 @@ static int debugfs_create_by_name(const 
 			error = debugfs_mkdir(parent->d_inode, *dentry, mode);
 		else 
 			error = debugfs_create(parent->d_inode, *dentry, mode);
+		dput(*dentry);
 	} else
 		error = PTR_ERR(*dentry);
 	mutex_unlock(&parent->d_inode->i_mutex);
@@ -272,6 +273,7 @@ EXPORT_SYMBOL_GPL(debugfs_create_dir);
 void debugfs_remove(struct dentry *dentry)
 {
 	struct dentry *parent;
+	int ret = 0;
 	
 	if (!dentry)
 		return;
@@ -283,11 +285,15 @@ void debugfs_remove(struct dentry *dentr
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
---END---

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
