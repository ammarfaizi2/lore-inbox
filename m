Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWBVUWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWBVUWF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWBVUWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:22:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10696 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751422AbWBVUWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:22:02 -0500
Date: Wed, 22 Feb 2006 20:21:42 GMT
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-fsdevel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 1/5] NFS: Permit filesystem to override root dentry on mount
Message-Id: <dhowells1140639702@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch extends the get_sb() filesystem operation to take an extra
argument that permits the default root dentry choice (sb->s_root) to be
overridden by the filesystem that owns the superblock.

If the dentry pointer pointed to by that argument is left unchanged, then
do_kern_mount() will use sb->s_root as the root of the mount. If the filesystem
sets the pointer to a dentry of its choice, then that will be used as the root
for that particular mount.

This patch permits a superblock to be implicitly shared amongst several mount
points, such as can be done with NFS to avoid potential inode aliasing (see
patch 5/5).

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 getsb-2616rc4.diff
 Documentation/filesystems/porting |    2 +-
 fs/super.c                        |   10 +++++++---
 include/linux/fs.h                |    2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff -uNrp linux-2.6.16-rc4/Documentation/filesystems/porting linux-2.6.16-rc4-getsb/Documentation/filesystems/porting
--- linux-2.6.16-rc4/Documentation/filesystems/porting	2004-06-18 13:42:30.000000000 +0100
+++ linux-2.6.16-rc4-getsb/Documentation/filesystems/porting	2006-02-22 17:11:59.000000000 +0000
@@ -51,7 +51,7 @@ success and negative number in case of e
 informative error value to report).  Call it foo_fill_super().  Now declare
 
 struct super_block foo_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, ext2_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/include/linux/fs.h linux-2.6.16-rc4-getsb/include/linux/fs.h
--- linux-2.6.16-rc4/include/linux/fs.h	2006-02-22 17:00:41.000000000 +0000
+++ linux-2.6.16-rc4-getsb/include/linux/fs.h	2006-02-22 17:08:45.000000000 +0000
@@ -1240,7 +1240,7 @@ struct file_system_type {
 	const char *name;
 	int fs_flags;
 	struct super_block *(*get_sb) (struct file_system_type *, int,
-				       const char *, void *);
+				       const char *, void *, struct dentry **);
 	void (*kill_sb) (struct super_block *);
 	struct module *owner;
 	struct file_system_type * next;
diff -uNrp linux-2.6.16-rc4/fs/super.c linux-2.6.16-rc4-getsb/fs/super.c
--- linux-2.6.16-rc4/fs/super.c	2006-02-22 17:00:38.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/super.c	2006-02-22 17:08:45.000000000 +0000
@@ -792,6 +792,7 @@ do_kern_mount(const char *fstype, int fl
 	struct file_system_type *type = get_fs_type(fstype);
 	struct super_block *sb = ERR_PTR(-ENOMEM);
 	struct vfsmount *mnt;
+	struct dentry *root;
 	int error;
 	char *secdata = NULL;
 
@@ -816,15 +817,18 @@ do_kern_mount(const char *fstype, int fl
 		}
 	}
 
-	sb = type->get_sb(type, flags, name, data);
+	root = NULL;
+	sb = type->get_sb(type, flags, name, data, &root);
 	if (IS_ERR(sb))
 		goto out_free_secdata;
+	if (!root)
+		root = dget(sb->s_root);
  	error = security_sb_kern_mount(sb, secdata);
  	if (error)
  		goto out_sb;
 	mnt->mnt_sb = sb;
-	mnt->mnt_root = dget(sb->s_root);
-	mnt->mnt_mountpoint = sb->s_root;
+	mnt->mnt_root = root;
+	mnt->mnt_mountpoint = root;
 	mnt->mnt_parent = mnt;
 	up_write(&sb->s_umount);
 	free_secdata(secdata);
