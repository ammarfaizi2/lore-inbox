Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266377AbTAKK5i>; Sat, 11 Jan 2003 05:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266560AbTAKK5i>; Sat, 11 Jan 2003 05:57:38 -0500
Received: from dp.samba.org ([66.70.73.150]:59274 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266377AbTAKK5g>;
	Sat, 11 Jan 2003 05:57:36 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Clean up refcounting on filesystems
Date: Sat, 11 Jan 2003 22:03:24 +1100
Message-Id: <20030111110623.08E2B2C0BC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

	This gets rid of the hacky module count reentry, by holding a
reference count per mount, rather than per superblock.  The additional
field to struct vfsmount is slightly gratuitous, but nice and
explicit.  Minor collateral cleanups.

Lightly tested here, seems to work.

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: get_filesystem patch
Author: Rusty Russell
Status: Tested on 2.5.55

D: This attaches the reference count of filesystem to the number of
D: mounts, not the superblocks.  This avoids the horrible re-entry
D: hack in get_filesystem, and has the added bonus of being clearer to
D: the user reading the reference count.
D:
D: It also renames put_filesystem to put_fs_type, to match get_fs_type.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/fs/filesystems.c working-2.5.55-mountref/fs/filesystems.c
--- linux-2.5.55/fs/filesystems.c	2003-01-02 14:48:00.000000000 +1100
+++ working-2.5.55-mountref/fs/filesystems.c	2003-01-10 14:19:31.000000000 +1100
@@ -28,27 +28,6 @@
 static struct file_system_type *file_systems;
 static rwlock_t file_systems_lock = RW_LOCK_UNLOCKED;
 
-/* WARNING: This can be used only if we _already_ own a reference */
-void get_filesystem(struct file_system_type *fs)
-{
-	if (!try_module_get(fs->owner)) {
-#ifdef CONFIG_MODULE_UNLOAD
-		unsigned int cpu = get_cpu();
-		local_inc(&fs->owner->ref[cpu].count);
-		put_cpu();
-#else
-		/* Getting filesystem while it's starting up?  We're
-                   already supposed to have a reference. */
-		BUG();
-#endif
-	}
-}
-
-void put_filesystem(struct file_system_type *fs)
-{
-	module_put(fs->owner);
-}
-
 static struct file_system_type **find_filesystem(const char *name)
 {
 	struct file_system_type **p;
@@ -162,7 +141,7 @@ static int fs_name(unsigned int index, c
 	/* OK, we got the reference, so we can safely block */
 	len = strlen(tmp->name) + 1;
 	res = copy_to_user(buf, tmp->name, len) ? -EFAULT : 0;
-	put_filesystem(tmp);
+	put_fs_type(tmp);
 	return res;
 }
 
@@ -234,3 +213,8 @@ struct file_system_type *get_fs_type(con
 	}
 	return fs;
 }
+
+void put_fs_type(struct file_system_type *fs)
+{
+	module_put(fs->owner);
+}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/fs/namespace.c working-2.5.55-mountref/fs/namespace.c
--- linux-2.5.55/fs/namespace.c	2003-01-02 12:45:27.000000000 +1100
+++ working-2.5.55-mountref/fs/namespace.c	2003-01-10 14:13:54.000000000 +1100
@@ -152,6 +152,7 @@ void __mntput(struct vfsmount *mnt)
 {
 	struct super_block *sb = mnt->mnt_sb;
 	dput(mnt->mnt_root);
+	put_fs_type(mnt->type);
 	free_vfsmnt(mnt);
 	deactivate_super(sb);
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/fs/super.c working-2.5.55-mountref/fs/super.c
--- linux-2.5.55/fs/super.c	2003-01-02 14:48:00.000000000 +1100
+++ working-2.5.55-mountref/fs/super.c	2003-01-10 14:16:02.000000000 +1100
@@ -31,13 +31,9 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/vfs.h>
+#include <linux/fs.h>
 #include <asm/uaccess.h>
 
-
-void get_filesystem(struct file_system_type *fs);
-void put_filesystem(struct file_system_type *fs);
-struct file_system_type *get_fs_type(const char *name);
-
 LIST_HEAD(super_blocks);
 spinlock_t sb_lock = SPIN_LOCK_UNLOCKED;
 
@@ -127,7 +123,6 @@ void deactivate_super(struct super_block
 		spin_unlock(&sb_lock);
 		down_write(&s->s_umount);
 		fs->kill_sb(s);
-		put_filesystem(fs);
 		put_super(s);
 	}
 }
@@ -253,7 +248,6 @@ retry:
 	list_add(&s->s_list, super_blocks.prev);
 	list_add(&s->s_instances, &type->fs_supers);
 	spin_unlock(&sb_lock);
-	get_filesystem(type);
 	return s;
 }
 
@@ -624,13 +618,13 @@ do_kern_mount(const char *fstype, int fl
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = sb->s_root;
 	mnt->mnt_parent = mnt;
+	mnt->type = type;
 	up_write(&sb->s_umount);
-	put_filesystem(type);
 	return mnt;
 out_mnt:
 	free_vfsmnt(mnt);
 out:
-	put_filesystem(type);
+	put_fs_type(type);
 	return (struct vfsmount *)sb;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/include/linux/fs.h working-2.5.55-mountref/include/linux/fs.h
--- linux-2.5.55/include/linux/fs.h	2003-01-10 10:55:43.000000000 +1100
+++ working-2.5.55-mountref/include/linux/fs.h	2003-01-10 14:19:47.000000000 +1100
@@ -1289,6 +1289,7 @@ extern int vfs_lstat(char *, struct ksta
 extern int vfs_fstat(unsigned int, struct kstat *);
 
 extern struct file_system_type *get_fs_type(const char *name);
+extern void put_fs_type(struct file_system_type *fs);
 extern struct super_block *get_super(struct block_device *);
 extern struct super_block *user_get_super(dev_t);
 extern void drop_super(struct super_block *sb);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/include/linux/mount.h working-2.5.55-mountref/include/linux/mount.h
--- linux-2.5.55/include/linux/mount.h	2003-01-02 12:04:35.000000000 +1100
+++ working-2.5.55-mountref/include/linux/mount.h	2003-01-10 14:07:51.000000000 +1100
@@ -30,6 +30,7 @@ struct vfsmount
 	atomic_t mnt_count;
 	int mnt_flags;
 	char *mnt_devname;		/* Name of device e.g. /dev/dsk/hda1 */
+	struct file_system_type *type;	/* Type (we hold a reference). */
 	struct list_head mnt_list;
 };
 
