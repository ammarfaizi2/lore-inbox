Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261897AbREPMNe>; Wed, 16 May 2001 08:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261896AbREPMNP>; Wed, 16 May 2001 08:13:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:32246 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261895AbREPMMy>;
	Wed, 16 May 2001 08:12:54 -0400
Date: Wed, 16 May 2001 08:12:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rootfs (part 1)
Message-ID: <Pine.GSO.4.21.0105160756210.24199-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Linus, patch is the first chunk of rootfs stuff. I've tried to
get it as small as possible - all it does is addition of absolute root
on ramfs and necessary changes to mount_root/change_root/sys_pivot_root
and follow_dotdot. Real root is mounted atop of the "absolute" one.

	More interesting stuff lives in the next parts - once we
have rootfs we can get rid of a lot of cruft in fs/super.c around
mounting real root and switching it after initrd. In particular,
we can get rid of the umount_root flag in do_umount() and kill_super()
which allows much cleaner handling of vfsmounts. I'll try to feed this
stuff in small and obvious pieces.

	It's transparent to userland - the only visible effect is
an extra line in /proc/mounts. Moreover, it's transparent to the
kernel - the only functions that really care are those that do
the first mount.

	One point that might be better done differently - since we
need ramfs for boot I've just made fs/Config.in declare CONFIG_RAMFS
as define_bool CONFIG_RAMFS y. If ramfs grows (e.g. gets resource
limits patches from -ac) we might be better off doing a minimal
variant permanently in kernel (calling it rootfs) and making
ramfs use rootfs methods. It's completely separate issue, so I've
done it the simplest way for the time being.

	And yes, patch got testing. Please, apply.
							Al

diff -urN S5-pre2-init/fs/Config.in S5-pre2-rootfs/fs/Config.in
--- S5-pre2-init/fs/Config.in	Sat Apr 28 02:12:55 2001
+++ S5-pre2-rootfs/fs/Config.in	Wed May 16 03:14:12 2001
@@ -32,7 +32,8 @@
 fi
 tristate 'Compressed ROM file system support' CONFIG_CRAMFS
 bool 'Virtual memory file system support (former shm fs)' CONFIG_TMPFS
-tristate 'Simple RAM-based file system support' CONFIG_RAMFS
+define_bool CONFIG_RAMFS y
+# tristate 'Simple RAM-based file system support' CONFIG_RAMFS
 
 tristate 'ISO 9660 CDROM file system support' CONFIG_ISO9660_FS
 dep_mbool '  Microsoft Joliet CDROM extensions' CONFIG_JOLIET $CONFIG_ISO9660_FS
diff -urN S5-pre2-init/fs/namei.c S5-pre2-rootfs/fs/namei.c
--- S5-pre2-init/fs/namei.c	Sat Apr 28 02:12:56 2001
+++ S5-pre2-rootfs/fs/namei.c	Wed May 16 02:06:02 2001
@@ -410,6 +410,8 @@
 		mntput(nd->mnt);
 		nd->mnt = parent;
 	}
+	while (d_mountpoint(nd->dentry) && __follow_down(&nd->mnt, &nd->dentry))
+		;
 }
 /*
  * Name resolution.
diff -urN S5-pre2-init/fs/super.c S5-pre2-rootfs/fs/super.c
--- S5-pre2-init/fs/super.c	Tue May 15 03:51:04 2001
+++ S5-pre2-rootfs/fs/super.c	Wed May 16 04:15:26 2001
@@ -1447,17 +1447,52 @@
 	return retval;
 }
 
-void __init mount_root(void)
+void __init mount_rootfs(void)
+{
+	struct file_system_type * fs_type;
+	struct super_block * sb;
+	struct vfsmount *vfsmnt;
+
+	fs_type = get_fs_type("ramfs");
+
+	if (!fs_type)
+		panic("ramfs not built in");
+
+	sb = get_sb_nodev(fs_type, 0, NULL);
+	put_filesystem(fs_type);
+
+	if (!sb) 
+		panic("unable to create rootfs");
+
+	vfsmnt = add_vfsmnt(NULL, sb->s_root, "rootfs");
+	if (!vfsmnt)
+		panic("can't create a single vfsmount");
+
+	up(&mount_sem);
+
+	set_fs_root(current->fs, vfsmnt, sb->s_root);
+	set_fs_pwd(current->fs, vfsmnt, sb->s_root);
+}
+
+void __init mount_root(char *to)
 {
 	struct file_system_type * fs_type;
 	struct super_block * sb;
 	struct vfsmount *vfsmnt;
 	struct block_device *bdev = NULL;
 	mode_t mode;
-	int retval;
+	int retval = 0;
 	void *handle;
 	char path[64];
 	int path_start = -1;
+	struct nameidata root_nd;
+
+	if (path_init(to, LOOKUP_POSITIVE|LOOKUP_DIRECTORY, &root_nd))
+		retval = path_walk(to, &root_nd);
+
+	if (retval)
+		panic("Where do I mount root?");
+
 
 #ifdef CONFIG_ROOT_NFS
 	void *data;
@@ -1591,10 +1626,11 @@
 		devfs_mk_symlink (NULL, "root", DEVFS_FL_DEFAULT,
 				  path + 5 + path_start, NULL, NULL);
 		memcpy (path + path_start, "/dev/", 5);
-		vfsmnt = add_vfsmnt(NULL, sb->s_root, path + path_start);
+		vfsmnt = add_vfsmnt(&root_nd, sb->s_root, path + path_start);
 	}
 	else
-		vfsmnt = add_vfsmnt(NULL, sb->s_root, "/dev/root");
+		vfsmnt = add_vfsmnt(&root_nd, sb->s_root, "/dev/root");
+	path_release(&root_nd);
 	/* FIXME: if something will try to umount us right now... */
 	if (vfsmnt) {
 		set_fs_root(current->fs, vfsmnt, sb->s_root);
@@ -1647,10 +1683,8 @@
 
 asmlinkage long sys_pivot_root(const char *new_root, const char *put_old)
 {
-	struct dentry *root;
-	struct vfsmount *root_mnt;
 	struct vfsmount *tmp;
-	struct nameidata new_nd, old_nd;
+	struct nameidata new_nd, old_nd, root_nd, parent_nd;
 	char *name;
 	int error;
 
@@ -1682,9 +1716,10 @@
 		goto out1;
 
 	read_lock(&current->fs->lock);
-	root_mnt = mntget(current->fs->rootmnt);
-	root = dget(current->fs->root);
+	root_nd.mnt = mntget(current->fs->rootmnt);
+	root_nd.dentry = dget(current->fs->root);
 	read_unlock(&current->fs->lock);
+
 	down(&mount_sem);
 	down(&old_nd.dentry->d_inode->i_zombie);
 	error = -ENOENT;
@@ -1695,7 +1730,7 @@
 	if (d_unhashed(old_nd.dentry) && !IS_ROOT(old_nd.dentry))
 		goto out2;
 	error = -EBUSY;
-	if (new_nd.mnt == root_mnt || old_nd.mnt == root_mnt)
+	if (new_nd.mnt == root_nd.mnt || old_nd.mnt == root_nd.mnt)
 		goto out2; /* loop */
 	error = -EINVAL;
 	tmp = old_nd.mnt; /* make sure we can reach put_old from new_root */
@@ -1714,15 +1749,20 @@
 		goto out3;
 	spin_unlock(&dcache_lock);
 
+	parent_nd.mnt = mntget(root_nd.mnt->mnt_parent);
+	parent_nd.dentry = dget(root_nd.mnt->mnt_mountpoint);
+
 	move_vfsmnt(new_nd.mnt, new_nd.dentry, NULL, NULL);
-	move_vfsmnt(root_mnt, old_nd.dentry, old_nd.mnt, NULL);
-	chroot_fs_refs(root,root_mnt,new_nd.dentry,new_nd.mnt);
+	move_vfsmnt(root_nd.mnt, old_nd.dentry, old_nd.mnt, NULL);
+	move_vfsmnt(new_nd.mnt, parent_nd.dentry, parent_nd.mnt, NULL);
+
+	path_release(&parent_nd);
+	chroot_fs_refs(root_nd.dentry,root_nd.mnt,new_nd.dentry,new_nd.mnt);
 	error = 0;
 out2:
 	up(&old_nd.dentry->d_inode->i_zombie);
 	up(&mount_sem);
-	dput(root);
-	mntput(root_mnt);
+	path_release(&root_nd);
 	path_release(&old_nd);
 out1:
 	path_release(&new_nd);
@@ -1760,8 +1800,13 @@
 		} else 
 			path_release(&devfs_nd);
 	}
+	/* chdir to the absolute root */
+	set_fs_pwd(current->fs, old_rootmnt->mnt_parent,
+				old_rootmnt->mnt_mountpoint);
+	/* detach initrd */
+	move_vfsmnt(old_rootmnt, old_rootmnt->mnt_root, NULL, NULL);
 	ROOT_DEV = new_root_dev;
-	mount_root();
+	mount_root(".");
 #if 1
 	shrink_dcache();
 	printk("change_root: old root has d_count=%d\n", 
@@ -1786,7 +1831,7 @@
 		printk(KERN_ERR "error %d\n", blivet);
 		return error;
 	}
-	/* FIXME: we should hold i_zombie on nd.dentry */
+	/* re-attach on put_old */
 	move_vfsmnt(old_rootmnt, nd.dentry, nd.mnt, "/dev/root.old");
 	mntput(old_rootmnt);
 	path_release(&nd);
diff -urN S5-pre2-init/include/linux/fs.h S5-pre2-rootfs/include/linux/fs.h
--- S5-pre2-init/include/linux/fs.h	Tue May 15 03:51:04 2001
+++ S5-pre2-rootfs/include/linux/fs.h	Wed May 16 03:24:37 2001
@@ -1308,7 +1308,8 @@
 
 
 extern void show_buffers(void);
-extern void mount_root(void);
+extern void mount_root(char *);
+extern void mount_rootfs(void);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 extern kdev_t real_root_dev;
diff -urN S5-pre2-init/init/main.c S5-pre2-rootfs/init/main.c
--- S5-pre2-init/init/main.c	Wed May 16 07:48:49 2001
+++ S5-pre2-rootfs/init/main.c	Wed May 16 07:49:16 2001
@@ -706,6 +706,7 @@
 
 	start_context_thread();
 	do_initcalls();
+	mount_rootfs();
 
 #ifdef CONFIG_IRDA
 	irda_proto_init();
@@ -744,7 +745,7 @@
 #endif
 
 	/* Mount the root filesystem.. */
-	mount_root();
+	mount_root("/");
 
 	mount_devfs_fs ();
 

