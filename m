Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269651AbRHMBa0>; Sun, 12 Aug 2001 21:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269644AbRHMBaP>; Sun, 12 Aug 2001 21:30:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:63118 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269646AbRHMB2V>;
	Sun, 12 Aug 2001 21:28:21 -0400
Date: Sun, 12 Aug 2001 21:28:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/super.c fixes - second series (7/11)
In-Reply-To: <Pine.GSO.4.21.0108122127560.7092-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0108122128190.7092-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Part 7/11

	* Now we can drop kern_mount() from the places that don't need it.
I.e. unless the kernel itself needs private vfsmount - no need to bother.
	* kern_mount() itself is simplified - it calls get_sb_nodev() or
get_sb_single() instead of doing stuff by hands. As the matter of fact,
it's quite similar to part of do_add_mount(). It's really "get the
private vfsmount, but don't bother attaching it" - what kern_mount()
was always supposed to be.
	* Refcounting for FS_SINGLE filesystems is not different from the
rest now. As the matter of fact, the only difference between "single" and
"nodev" is that the former refuses to have multiple instances and returns
an existing one if found. All special-casing is gone.
	* shmfs explicitly stores result of its kern_mount() in variable
instead of using ->kern_mnt (preparation to the next step).

BTW, now we can call kern_mount() several times on the same fs if we find
it convenient for some reason.

In short, lots of crap is gone now. I should've done it that way from the
very beginning and life would be easier for everyone.

diff -urN S9-pre1-get_sb_single/drivers/usb/inode.c S9-pre1-kern_mount/drivers/usb/inode.c
--- S9-pre1-get_sb_single/drivers/usb/inode.c	Sun Jul 29 01:54:47 2001
+++ S9-pre1-kern_mount/drivers/usb/inode.c	Sun Aug 12 20:45:51 2001
@@ -751,7 +751,6 @@
 		usb_deregister(&usbdevfs_driver);
 		return ret;
 	}
-	kern_mount(&usbdevice_fs_type);
 #ifdef CONFIG_PROC_FS		
 	/* create mount point for usbdevfs */
 	usbdir = proc_mkdir("usb", proc_bus);
@@ -763,7 +762,6 @@
 {
 	usb_deregister(&usbdevfs_driver);
 	unregister_filesystem(&usbdevice_fs_type);
-	kern_umount(usbdevice_fs_type.kern_mnt);
 #ifdef CONFIG_PROC_FS	
         if (usbdir)
                 remove_proc_entry("usb", proc_bus);
diff -urN S9-pre1-get_sb_single/fs/pipe.c S9-pre1-kern_mount/fs/pipe.c
--- S9-pre1-get_sb_single/fs/pipe.c	Fri Feb 16 22:52:04 2001
+++ S9-pre1-kern_mount/fs/pipe.c	Sun Aug 12 20:45:51 2001
@@ -630,8 +630,7 @@
 	return sb;
 }
 
-static DECLARE_FSTYPE(pipe_fs_type, "pipefs", pipefs_read_super,
-	FS_NOMOUNT|FS_SINGLE);
+static DECLARE_FSTYPE(pipe_fs_type, "pipefs", pipefs_read_super, FS_NOMOUNT);
 
 static int __init init_pipe_fs(void)
 {
@@ -650,7 +649,7 @@
 static void __exit exit_pipe_fs(void)
 {
 	unregister_filesystem(&pipe_fs_type);
-	kern_umount(pipe_mnt);
+	mntput(pipe_mnt);
 }
 
 module_init(init_pipe_fs)
diff -urN S9-pre1-get_sb_single/fs/super.c S9-pre1-kern_mount/fs/super.c
--- S9-pre1-get_sb_single/fs/super.c	Sun Aug 12 20:45:50 2001
+++ S9-pre1-kern_mount/fs/super.c	Sun Aug 12 20:45:51 2001
@@ -388,8 +388,6 @@
 	spin_lock(&dcache_lock);
 	list_add(&mnt->mnt_list, vfsmntlist.prev);
 	spin_unlock(&dcache_lock);
-	if (sb->s_type->fs_flags & FS_SINGLE)
-		get_filesystem(sb->s_type);
 out:
 	return mnt;
 }
@@ -436,8 +434,6 @@
 	list_add(&mnt->mnt_list, vfsmntlist.prev);
 	spin_unlock(&dcache_lock);
 	up(&nd->dentry->d_inode->i_zombie);
-	if (mnt->mnt_sb->s_type->fs_flags & FS_SINGLE)
-		get_filesystem(mnt->mnt_sb->s_type);
 	mntget(mnt);
 	return 0;
 fail:
@@ -1070,6 +1066,7 @@
 		if (!fs_type->read_super(s, data, 0))
 			goto out_fail;
 		unlock_super(s);
+		get_filesystem(fs_type);
 		return s;
 
 	out_fail:
@@ -1184,21 +1181,17 @@
 {
 	struct super_block *sb;
 	struct vfsmount *mnt = alloc_vfsmnt();
-	kdev_t dev;
 
 	if (!mnt)
 		return ERR_PTR(-ENOMEM);
 
-	dev = get_unnamed_dev();
-	if (!dev) {
+	if (type->fs_flags & FS_SINGLE)
+		sb = get_sb_single(type, 0, NULL);
+	else
+		sb = get_sb_nodev(type, 0, NULL);
+	if (IS_ERR(sb)) {
 		kmem_cache_free(mnt_cache, mnt);
-		return ERR_PTR(-EMFILE);
-	}
-	sb = read_super(dev, NULL, type, 0, NULL, 0);
-	if (!sb) {
-		put_unnamed_dev(dev);
-		kmem_cache_free(mnt_cache, mnt);
-		return ERR_PTR(-EINVAL);
+		return (struct vfsmount *)sb;
 	}
 	mnt->mnt_sb = sb;
 	mnt->mnt_root = dget(sb->s_root);
@@ -1206,6 +1199,7 @@
 	mnt->mnt_parent = mnt;
 	type->kern_mnt = mnt;
 	up_write(&sb->s_umount);
+	up(&mount_sem);
 	return mnt;
 }
 
@@ -1257,8 +1251,6 @@
 			spin_unlock(&dcache_lock);
 			return -EBUSY;
 		}
-		if (sb->s_type->fs_flags & FS_SINGLE)
-			put_filesystem(sb->s_type);
 		detach_mnt(mnt, &parent_nd);
 		list_del(&mnt->mnt_list);
 		spin_unlock(&dcache_lock);
diff -urN S9-pre1-get_sb_single/mm/shmem.c S9-pre1-kern_mount/mm/shmem.c
--- S9-pre1-get_sb_single/mm/shmem.c	Sat Aug 11 14:59:25 2001
+++ S9-pre1-kern_mount/mm/shmem.c	Sun Aug 12 20:45:51 2001
@@ -1158,6 +1158,7 @@
 #else
 static DECLARE_FSTYPE(tmpfs_fs_type, "tmpfs", shmem_read_super, FS_LITTER|FS_NOMOUNT);
 #endif
+static struct vfsmount *shm_mnt;
 
 static int __init init_shmem_fs(void)
 {
@@ -1181,6 +1182,7 @@
 		unregister_filesystem(&tmpfs_fs_type);
 		return PTR_ERR(res);
 	}
+	shm_mnt = res;
 
 	/* The internal instance should not do size checking */
 	if ((error = shmem_set_size(&res->mnt_sb->u.shmem_sb, ULONG_MAX, ULONG_MAX)))
@@ -1195,6 +1197,7 @@
 	unregister_filesystem(&shmem_fs_type);
 #endif
 	unregister_filesystem(&tmpfs_fs_type);
+	mntput(shm_mnt);
 }
 
 module_init(init_shmem_fs)
@@ -1292,7 +1295,7 @@
 	this.name = name;
 	this.len = strlen(name);
 	this.hash = 0; /* will go */
-	root = tmpfs_fs_type.kern_mnt->mnt_root;
+	root = shm_mnt->mnt_root;
 	dentry = d_alloc(root, &this);
 	if (!dentry)
 		return ERR_PTR(-ENOMEM);
@@ -1310,7 +1313,7 @@
 	d_instantiate(dentry, inode);
 	dentry->d_inode->i_size = size;
 	shmem_truncate(inode);
-	file->f_vfsmnt = mntget(tmpfs_fs_type.kern_mnt);
+	file->f_vfsmnt = mntget(shm_mnt);
 	file->f_dentry = dentry;
 	file->f_op = &shmem_file_operations;
 	file->f_mode = FMODE_WRITE | FMODE_READ;
diff -urN S9-pre1-get_sb_single/net/socket.c S9-pre1-kern_mount/net/socket.c
--- S9-pre1-get_sb_single/net/socket.c	Sun Jul 29 01:54:49 2001
+++ S9-pre1-kern_mount/net/socket.c	Sun Aug 12 20:45:51 2001
@@ -303,8 +303,7 @@
 }
 
 static struct vfsmount *sock_mnt;
-static DECLARE_FSTYPE(sock_fs_type, "sockfs", sockfs_read_super,
-	FS_NOMOUNT|FS_SINGLE);
+static DECLARE_FSTYPE(sock_fs_type, "sockfs", sockfs_read_super, FS_NOMOUNT);
 static int sockfs_delete_dentry(struct dentry *dentry)
 {
 	return 1;


