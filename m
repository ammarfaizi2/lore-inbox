Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269670AbRHMB35>; Sun, 12 Aug 2001 21:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269649AbRHMB2E>; Sun, 12 Aug 2001 21:28:04 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:42637 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269645AbRHMB1g>;
	Sun, 12 Aug 2001 21:27:36 -0400
Date: Sun, 12 Aug 2001 21:27:47 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/super.c fixes - second series (5/11)
In-Reply-To: <Pine.GSO.4.21.0108122127030.7092-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0108122127320.7092-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Part 5/11

First step of 4-parter that corrects the idiotic misdesign I've done a
year ago when I was doing FS_SINGLE/kern_mount()/kern_umount(). Here we
go:
	* all superblocks of given type are placed on a list anchored in
struct file_system_type. It starts at ->fs_supers and goes through the
->s_instances of superblocks in question. Protected by sb_lock.

diff -urN S9-pre1-do_remount_sb/fs/super.c S9-pre1-fs_supers/fs/super.c
--- S9-pre1-do_remount_sb/fs/super.c	Sun Aug 12 20:45:50 2001
+++ S9-pre1-fs_supers/fs/super.c	Sun Aug 12 20:45:50 2001
@@ -122,6 +122,7 @@
 		return -EINVAL;
 	if (fs->next)
 		return -EBUSY;
+	INIT_LIST_HEAD(&fs->fs_supers);
 	write_lock(&file_systems_lock);
 	p = find_filesystem(fs->name);
 	if (*p)
@@ -792,6 +793,7 @@
 		INIT_LIST_HEAD(&s->s_dirty);
 		INIT_LIST_HEAD(&s->s_locked_inodes);
 		INIT_LIST_HEAD(&s->s_files);
+		INIT_LIST_HEAD(&s->s_instances);
 		init_rwsem(&s->s_umount);
 		sema_init(&s->s_lock, 1);
 		s->s_count = 1;
@@ -819,6 +821,7 @@
 	s->s_type = type;
 	spin_lock(&sb_lock);
 	list_add (&s->s_list, super_blocks.prev);
+	list_add (&s->s_instances, &type->fs_supers);
 	spin_unlock(&sb_lock);
 	down_write(&s->s_umount);
 	lock_super(s);
@@ -839,6 +842,7 @@
 	atomic_dec(&s->s_active);
 	spin_lock(&sb_lock);
 	list_del(&s->s_list);
+	list_del(&s->s_instances);
 	spin_unlock(&sb_lock);
 	put_super(s);
 	return NULL;
@@ -969,6 +973,7 @@
 	s->s_flags = flags;
 	s->s_type = fs_type;
 	list_add (&s->s_list, super_blocks.prev);
+	list_add (&s->s_instances, &fs_type->fs_supers);
 
 	spin_unlock(&sb_lock);
 
@@ -991,6 +996,7 @@
 	atomic_dec(&s->s_active);
 	spin_lock(&sb_lock);
 	list_del(&s->s_list);
+	list_del(&s->s_instances);
 	spin_unlock(&sb_lock);
 	put_super(s);
 out1:
@@ -1088,6 +1094,7 @@
 		put_unnamed_dev(dev);
 	spin_lock(&sb_lock);
 	list_del(&sb->s_list);
+	list_del(&sb->s_instances);
 	spin_unlock(&sb_lock);
 	put_super(sb);
 }
diff -urN S9-pre1-do_remount_sb/include/linux/fs.h S9-pre1-fs_supers/include/linux/fs.h
--- S9-pre1-do_remount_sb/include/linux/fs.h	Sun Aug 12 20:22:36 2001
+++ S9-pre1-fs_supers/include/linux/fs.h	Sun Aug 12 20:45:50 2001
@@ -688,6 +688,7 @@
 	struct list_head	s_files;
 
 	struct block_device	*s_bdev;
+	struct list_head	s_instances;
 	struct quota_mount_options s_dquot;	/* Diskquota specific options */
 
 	union {
@@ -915,6 +916,7 @@
 	struct module *owner;
 	struct vfsmount *kern_mnt; /* For kernel mount, if it's FS_SINGLE fs */
 	struct file_system_type * next;
+	struct list_head fs_supers;
 };
 
 #define DECLARE_FSTYPE(var,type,read,flags) \


