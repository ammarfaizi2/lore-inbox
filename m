Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbTBSXjC>; Wed, 19 Feb 2003 18:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbTBSXjC>; Wed, 19 Feb 2003 18:39:02 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:30482 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262452AbTBSXi6>;
	Wed, 19 Feb 2003 18:38:58 -0500
Date: Wed, 19 Feb 2003 15:42:03 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [PATCH] LSM changes for 2.5.62
Message-ID: <20030219234203.GB18590@kroah.com>
References: <20030219234140.GA18590@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219234140.GA18590@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.914.34.1, 2003/01/16 14:18:05-08:00, sds@epoch.ncsc.mil

[PATCH] Add LSM hook to do_kern_mount

This patch adds a security_sb_kern_mount hook call to the do_kern_mount
function.  This hook enables initialization of the superblock security
information of all superblock objects.  Placing a hook in do_kern_mount
was originally suggested by Al Viro.  This hook is used by SELinux to
setup the superblock security state and eliminated the need for the
superblock_precondition function.


diff -Nru a/fs/super.c b/fs/super.c
--- a/fs/super.c	Wed Feb 19 15:39:18 2003
+++ b/fs/super.c	Wed Feb 19 15:39:18 2003
@@ -610,6 +610,7 @@
 	struct file_system_type *type = get_fs_type(fstype);
 	struct super_block *sb = ERR_PTR(-ENOMEM);
 	struct vfsmount *mnt;
+	int error;
 
 	if (!type)
 		return ERR_PTR(-ENODEV);
@@ -620,6 +621,13 @@
 	sb = type->get_sb(type, flags, name, data);
 	if (IS_ERR(sb))
 		goto out_mnt;
+ 	error = security_sb_kern_mount(sb);
+ 	if (error) {
+ 		up_write(&sb->s_umount);
+ 		deactivate_super(sb);
+ 		sb = ERR_PTR(error);
+ 		goto out_mnt;
+ 	}
 	mnt->mnt_sb = sb;
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = sb->s_root;
diff -Nru a/include/linux/security.h b/include/linux/security.h
--- a/include/linux/security.h	Wed Feb 19 15:39:18 2003
+++ b/include/linux/security.h	Wed Feb 19 15:39:18 2003
@@ -814,6 +814,7 @@
 
 	int (*sb_alloc_security) (struct super_block * sb);
 	void (*sb_free_security) (struct super_block * sb);
+	int (*sb_kern_mount) (struct super_block *sb);
 	int (*sb_statfs) (struct super_block * sb);
 	int (*sb_mount) (char *dev_name, struct nameidata * nd,
 			 char *type, unsigned long flags, void *data);
@@ -1034,6 +1035,11 @@
 	security_ops->sb_free_security (sb);
 }
 
+static inline int security_sb_kern_mount (struct super_block *sb)
+{
+	return security_ops->sb_kern_mount (sb);
+}
+
 static inline int security_sb_statfs (struct super_block *sb)
 {
 	return security_ops->sb_statfs (sb);
@@ -1638,6 +1644,11 @@
 
 static inline void security_sb_free (struct super_block *sb)
 { }
+
+static inline int security_sb_kern_mount (struct super_block *sb)
+{
+	return 0;
+}
 
 static inline int security_sb_statfs (struct super_block *sb)
 {
diff -Nru a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	Wed Feb 19 15:39:18 2003
+++ b/security/dummy.c	Wed Feb 19 15:39:18 2003
@@ -120,6 +120,11 @@
 	return;
 }
 
+static int dummy_sb_kern_mount (struct super_block *sb)
+{
+	return 0;
+}
+
 static int dummy_sb_statfs (struct super_block *sb)
 {
 	return 0;
@@ -635,6 +640,7 @@
 	set_to_dummy_if_null(ops, bprm_check_security);
 	set_to_dummy_if_null(ops, sb_alloc_security);
 	set_to_dummy_if_null(ops, sb_free_security);
+	set_to_dummy_if_null(ops, sb_kern_mount);
 	set_to_dummy_if_null(ops, sb_statfs);
 	set_to_dummy_if_null(ops, sb_mount);
 	set_to_dummy_if_null(ops, sb_check_sb);
