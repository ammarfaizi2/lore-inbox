Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269970AbRHNBeO>; Mon, 13 Aug 2001 21:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269967AbRHNBdk>; Mon, 13 Aug 2001 21:33:40 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:26586 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269974AbRHNBdO>;
	Mon, 13 Aug 2001 21:33:14 -0400
Date: Mon, 13 Aug 2001 21:33:26 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (5/11) fs/super.c fixes
In-Reply-To: <Pine.GSO.4.21.0108132132470.10579-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0108132133110.10579-100000@weyl.math.psu.edu>
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

diff -urN S9-pre3-do_remount_sb/fs/super.c S9-pre3-fs_supers/fs/super.c
--- S9-pre3-do_remount_sb/fs/super.c	Mon Aug 13 21:21:27 2001
+++ S9-pre3-fs_supers/fs/super.c	Mon Aug 13 21:21:27 2001
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
diff -urN S9-pre3-do_remount_sb/include/linux/fs.h S9-pre3-fs_supers/include/linux/fs.h
--- S9-pre3-do_remount_sb/include/linux/fs.h	Mon Aug 13 21:16:35 2001
+++ S9-pre3-fs_supers/include/linux/fs.h	Mon Aug 13 21:21:27 2001
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


