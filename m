Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWCWOb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWCWOb5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 09:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWCWOb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 09:31:57 -0500
Received: from thunk.org ([69.25.196.29]:32180 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932181AbWCWOb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 09:31:56 -0500
To: akpm@osdl.org, linux-kernel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH] vfs: MS_VERBOSE should be MS_SILENT
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1FMQqv-0000qx-Cw@think.thunk.org>
Date: Thu, 23 Mar 2006 09:31:53 -0500
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The meaning of MS_VERBOSE is backwards; if the bit is set, it really
means, "don't be verbose".  This is confusing and counter-intuitive.

In addition, there is also no way to set the MS_VERBOSE flag in mount,
but interesting, the mount(8) program in util-linux, does define
expect the existence of an MS_SILENT, which unfortunately we don't
define:

#ifdef MS_SILENT
  { "quiet",    0, 0, MS_SILENT    },   /* be quiet  */
  { "loud",     0, 1, MS_SILENT    },   /* print out messages. */
#endif

So the obvious fix here is to deprecate the use of MS_VERBOSE and
replace it with MS_SILENT.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

Index: 2.6.16-rc5/include/linux/fs.h
===================================================================
--- 2.6.16-rc5.orig/include/linux/fs.h	2006-03-14 07:31:33.000000000 -0500
+++ 2.6.16-rc5/include/linux/fs.h	2006-03-14 07:32:10.000000000 -0500
@@ -102,7 +102,9 @@ extern int dir_notify_enable;
 #define MS_BIND		4096
 #define MS_MOVE		8192
 #define MS_REC		16384
-#define MS_VERBOSE	32768
+#define MS_VERBOSE	32768	/* War is peace. Verbosity is silence.
+				   MS_VERBOSE is deprecated. */
+#define MS_SILENT	32768
 #define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
 #define MS_UNBINDABLE	(1<<17)	/* change to unbindable */
 #define MS_PRIVATE	(1<<18)	/* change to private */
Index: 2.6.16-rc5/fs/super.c
===================================================================
--- 2.6.16-rc5.orig/fs/super.c	2006-03-14 07:31:33.000000000 -0500
+++ 2.6.16-rc5/fs/super.c	2006-03-14 07:54:38.000000000 -0500
@@ -712,7 +712,7 @@ struct super_block *get_sb_bdev(struct f
 		s->s_flags = flags;
 		strlcpy(s->s_id, bdevname(bdev, b), sizeof(s->s_id));
 		sb_set_blocksize(s, block_size(bdev));
-		error = fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
+		error = fill_super(s, data, flags & MS_SILENT ? 1 : 0);
 		if (error) {
 			up_write(&s->s_umount);
 			deactivate_super(s);
@@ -756,7 +756,7 @@ struct super_block *get_sb_nodev(struct 
 
 	s->s_flags = flags;
 
-	error = fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
+	error = fill_super(s, data, flags & MS_SILENT ? 1 : 0);
 	if (error) {
 		up_write(&s->s_umount);
 		deactivate_super(s);
@@ -785,7 +785,7 @@ struct super_block *get_sb_single(struct
 		return s;
 	if (!s->s_root) {
 		s->s_flags = flags;
-		error = fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
+		error = fill_super(s, data, flags & MS_SILENT ? 1 : 0);
 		if (error) {
 			up_write(&s->s_umount);
 			deactivate_super(s);
Index: 2.6.16-rc5/fs/afs/super.c
===================================================================
--- 2.6.16-rc5.orig/fs/afs/super.c	2006-03-14 07:31:33.000000000 -0500
+++ 2.6.16-rc5/fs/afs/super.c	2006-03-14 07:32:10.000000000 -0500
@@ -341,7 +341,7 @@ static struct super_block *afs_get_sb(st
 
 	sb->s_flags = flags;
 
-	ret = afs_fill_super(sb, &params, flags & MS_VERBOSE ? 1 : 0);
+	ret = afs_fill_super(sb, &params, flags & MS_SILENT ? 1 : 0);
 	if (ret < 0) {
 		up_write(&sb->s_umount);
 		deactivate_super(sb);
Index: 2.6.16-rc5/fs/cifs/cifsfs.c
===================================================================
--- 2.6.16-rc5.orig/fs/cifs/cifsfs.c	2006-03-14 07:31:33.000000000 -0500
+++ 2.6.16-rc5/fs/cifs/cifsfs.c	2006-03-14 07:32:10.000000000 -0500
@@ -479,7 +479,7 @@ cifs_get_sb(struct file_system_type *fs_
 
 	sb->s_flags = flags;
 
-	rc = cifs_read_super(sb, data, dev_name, flags & MS_VERBOSE ? 1 : 0);
+	rc = cifs_read_super(sb, data, dev_name, flags & MS_SILENT ? 1 : 0);
 	if (rc) {
 		up_write(&sb->s_umount);
 		deactivate_super(sb);
Index: 2.6.16-rc5/fs/jffs2/super.c
===================================================================
--- 2.6.16-rc5.orig/fs/jffs2/super.c	2006-03-14 07:31:33.000000000 -0500
+++ 2.6.16-rc5/fs/jffs2/super.c	2006-03-14 07:54:08.000000000 -0500
@@ -152,7 +152,7 @@ static struct super_block *jffs2_get_sb_
 	sb->s_op = &jffs2_super_operations;
 	sb->s_flags = flags | MS_NOATIME;
 
-	ret = jffs2_do_fill_super(sb, data, (flags&MS_VERBOSE)?1:0);
+	ret = jffs2_do_fill_super(sb, data, flags & MS_SILENT ? 1 : 0);
 
 	if (ret) {
 		/* Failure case... */
@@ -257,7 +257,7 @@ static struct super_block *jffs2_get_sb(
 	}
 
 	if (imajor(nd.dentry->d_inode) != MTD_BLOCK_MAJOR) {
-		if (!(flags & MS_VERBOSE)) /* Yes I mean this. Strangely */
+		if (!(flags & MS_SILENT))
 			printk(KERN_NOTICE "Attempt to mount non-MTD device \"%s\" as JFFS2\n",
 			       dev_name);
 		goto out;
Index: 2.6.16-rc5/fs/nfs/inode.c
===================================================================
--- 2.6.16-rc5.orig/fs/nfs/inode.c	2006-03-14 07:31:33.000000000 -0500
+++ 2.6.16-rc5/fs/nfs/inode.c	2006-03-14 07:53:28.000000000 -0500
@@ -1679,7 +1679,7 @@ static struct super_block *nfs_get_sb(st
 
 	s->s_flags = flags;
 
-	error = nfs_fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
+	error = nfs_fill_super(s, data, flags & MS_SILENT ? 1 : 0);
 	if (error) {
 		up_write(&s->s_umount);
 		deactivate_super(s);
@@ -1996,7 +1996,7 @@ static struct super_block *nfs4_get_sb(s
 
 	s->s_flags = flags;
 
-	error = nfs4_fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
+	error = nfs4_fill_super(s, data, flags & MS_SILENT ? 1 : 0);
 	if (error) {
 		up_write(&s->s_umount);
 		deactivate_super(s);
Index: 2.6.16-rc5/init/do_mounts.c
===================================================================
--- 2.6.16-rc5.orig/init/do_mounts.c	2006-03-11 22:17:00.000000000 -0500
+++ 2.6.16-rc5/init/do_mounts.c	2006-03-14 07:56:49.000000000 -0500
@@ -19,7 +19,7 @@ extern int get_filesystem_list(char * bu
 
 int __initdata rd_doload;	/* 1 = load RAM disk, 0 = don't load */
 
-int root_mountflags = MS_RDONLY | MS_VERBOSE;
+int root_mountflags = MS_RDONLY | MS_SILENT;
 char * __initdata root_device_name;
 static char __initdata saved_root_name[64];
 
