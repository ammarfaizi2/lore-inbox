Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWAUIl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWAUIl3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 03:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWAUIl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 03:41:29 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:26813 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751179AbWAUIl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 03:41:28 -0500
Date: Sat, 21 Jan 2006 09:41:27 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] vfs: propagate vfsmount into chown_common()
Message-ID: <20060121084126.GD10044@MAIL.13thfloor.at>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20060121083843.GA10044@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060121083843.GA10044@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


;
; Bind Mount Extensions
;
; Copyright (C) 2003-2006 Herbert Pötzl <herbert@13thfloor.at>
;
; the vfsmount is propagated into chown_common() to allow
; for vfsmount based checks there, in this case the
; MNT_IS_RDONLY() check to disallow changes
;
;
; Changelog:
;
;   0.01  - broken out from bme0.05
;

Signed-off-by: Herbert Pötzl <herbert@13thfloor.at>

diff -NurpP --minimal linux-2.6.16-rc1/fs/open.c linux-2.6.16-rc1-bme0.06.2-cc0.01/fs/open.c
--- linux-2.6.16-rc1/fs/open.c	2006-01-18 06:08:34 +0100
+++ linux-2.6.16-rc1-bme0.06.2-cc0.01/fs/open.c	2006-01-21 09:08:38 +0100
@@ -669,7 +669,8 @@ out:
 	return error;
 }
 
-static int chown_common(struct dentry * dentry, uid_t user, gid_t group)
+static int chown_common(struct dentry *dentry, struct vfsmount *mnt,
+	uid_t user, gid_t group)
 {
 	struct inode * inode;
 	int error;
@@ -681,7 +682,7 @@ static int chown_common(struct dentry * 
 		goto out;
 	}
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(mnt))
 		goto out;
 	error = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
@@ -711,7 +712,7 @@ asmlinkage long sys_chown(const char __u
 
 	error = user_path_walk(filename, &nd);
 	if (!error) {
-		error = chown_common(nd.dentry, user, group);
+		error = chown_common(nd.dentry, nd.mnt, user, group);
 		path_release(&nd);
 	}
 	return error;
@@ -724,7 +725,7 @@ asmlinkage long sys_lchown(const char __
 
 	error = user_path_walk_link(filename, &nd);
 	if (!error) {
-		error = chown_common(nd.dentry, user, group);
+		error = chown_common(nd.dentry, nd.mnt, user, group);
 		path_release(&nd);
 	}
 	return error;
@@ -738,7 +739,7 @@ asmlinkage long sys_fchown(unsigned int 
 
 	file = fget(fd);
 	if (file) {
-		error = chown_common(file->f_dentry, user, group);
+		error = chown_common(file->f_dentry, file->f_vfsmnt, user, group);
 		fput(file);
 	}
 	return error;

