Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUBSNJU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 08:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267246AbUBSNJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 08:09:20 -0500
Received: from kempelen.iit.bme.hu ([152.66.241.120]:56543 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP id S264479AbUBSNJS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 08:09:18 -0500
Date: Thu, 19 Feb 2004 14:09:06 +0100 (MET)
Message-Id: <200402191309.i1JD96r21651@kempelen.iit.bme.hu>
From: Miklos Szeredi <mszeredi@inf.bme.hu>
To: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] cleanup in do_kern_mount()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the error handling in do_kern_mount(), it also
helps me maintain the external user-mount patch.  Linus, please apply.

Thanks,
Miklos

diff -rup -X dontdiff /usr/src/linux-2.6.3/fs/super.c linux-2.6.3/fs/super.c
--- /usr/src/linux-2.6.3/fs/super.c	2004-02-18 14:25:11.000000000 +0100
+++ linux-2.6.3/fs/super.c	2004-02-19 13:34:28.000000000 +0100
@@ -705,9 +705,9 @@ struct vfsmount *
 do_kern_mount(const char *fstype, int flags, const char *name, void *data)
 {
 	struct file_system_type *type = get_fs_type(fstype);
-	struct super_block *sb = ERR_PTR(-ENOMEM);
+	struct super_block *sb;
 	struct vfsmount *mnt;
-	int error;
+	int error = -ENOMEM;
 	char *secdata = NULL;
 
 	if (!type)
@@ -719,19 +719,16 @@ do_kern_mount(const char *fstype, int fl
 
 	if (data) {
 		secdata = alloc_secdata();
-		if (!secdata) {
-			sb = ERR_PTR(-ENOMEM);
+		if (!secdata)
 			goto out_mnt;
-		}
 
 		error = security_sb_copy_data(fstype, data, secdata);
-		if (error) {
-			sb = ERR_PTR(error);
+		if (error)
 			goto out_free_secdata;
-		}
 	}
 
 	sb = type->get_sb(type, flags, name, data);
+	error = PTR_ERR(sb);
 	if (IS_ERR(sb))
 		goto out_free_secdata;
  	error = security_sb_kern_mount(sb, secdata);
@@ -747,14 +744,13 @@ do_kern_mount(const char *fstype, int fl
 out_sb:
 	up_write(&sb->s_umount);
 	deactivate_super(sb);
-	sb = ERR_PTR(error);
 out_free_secdata:
 	free_secdata(secdata);
 out_mnt:
 	free_vfsmnt(mnt);
 out:
 	put_filesystem(type);
-	return (struct vfsmount *)sb;
+	return ERR_PTR(error);
 }
 
 struct vfsmount *kern_mount(struct file_system_type *type)
