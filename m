Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271182AbRICDxe>; Sun, 2 Sep 2001 23:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271186AbRICDxZ>; Sun, 2 Sep 2001 23:53:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:61612 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271182AbRICDxN>;
	Sun, 2 Sep 2001 23:53:13 -0400
Date: Sun, 2 Sep 2001 23:53:31 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mount_sem cleanup
Message-ID: <Pine.GSO.4.21.0109022346590.22951-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need mount_sem to be held for get_sb_*/do_kern_mount anymore.
The only thing it actually protects now is the mount tree.

Patch takes aforementioned functions (i.e. work with superblocks) out
of mount_sem.   For one thing, that allows ->read_super() to do filp_open()
and its ilk if we want to do that - we don't have to be afraid of
automounter being triggered and deadlocked on mount_sem.  Moreover, it
makes locking in fs/super.c simpler - mount_sem now has well-defined
object of protection (mount tree).

Patch had been in -ac for several weeks and got decent beating locally
(several months).  No complaints so far.  Please, apply (it's incremental
to do_kern_mount() one).

diff -urN S10-pre4-do_kern_mount/fs/super.c S10-pre4-mount_sem/fs/super.c
--- S10-pre4-do_kern_mount/fs/super.c	Sun Sep  2 23:28:26 2001
+++ S10-pre4-mount_sem/fs/super.c	Sun Sep  2 23:28:49 2001
@@ -923,7 +923,6 @@
 	bdops = devfs_get_ops ( devfs_get_handle_from_inode (inode) );
 	if (bdops) bdev->bd_op = bdops;
 	/* Done with lookups, semaphore down */
-	down(&mount_sem);
 	dev = to_kdev_t(bdev->bd_dev);
 	if (!(flags & MS_RDONLY))
 		mode |= FMODE_WRITE;
@@ -998,7 +997,6 @@
 	blkdev_put(bdev, BDEV_FS);
 out:
 	path_release(&nd);
-	up(&mount_sem);
 	return ERR_PTR(error);
 }
 
@@ -1007,7 +1005,6 @@
 {
 	kdev_t dev;
 	int error = -EMFILE;
-	down(&mount_sem);
 	dev = get_unnamed_dev();
 	if (dev) {
 		struct super_block * sb;
@@ -1019,7 +1016,6 @@
 		}
 		put_unnamed_dev(dev);
 	}
-	up(&mount_sem);
 	return ERR_PTR(error);
 }
 
@@ -1034,7 +1030,6 @@
 	 * Get the superblock of kernel-wide instance, but
 	 * keep the reference to fs_type.
 	 */
-	down(&mount_sem);
 retry:
 	spin_lock(&sb_lock);
 	if (!list_empty(&fs_type->fs_supers)) {
@@ -1050,7 +1045,6 @@
 		kdev_t dev = get_unnamed_dev();
 		if (!dev) {
 			put_super(s);
-			up(&mount_sem);
 			return ERR_PTR(-EMFILE);
 		}
 		s->s_dev = dev;
@@ -1079,7 +1073,6 @@
 		spin_unlock(&sb_lock);
 		put_super(s);
 		put_unnamed_dev(dev);
-		up(&mount_sem);
 		return ERR_PTR(-EINVAL);
 	}
 }
@@ -1436,7 +1429,7 @@
 			strcpy(mnt->mnt_devname, name);
 	}
 
-	/* get superblock, locks mount_sem on success */
+	/* get locked superblock */
 	if (fstype->fs_flags & FS_REQUIRES_DEV)
 		sb = get_sb_bdev(fstype, name, flags, data);
 	else if (fstype->fs_flags & FS_SINGLE)
@@ -1466,10 +1459,7 @@
 
 struct vfsmount *kern_mount(struct file_system_type *type)
 {
-	char *name = (char *)type->name;
-	struct vfsmount *mnt = do_kern_mount(name, 0, name, NULL);
-	up(&mount_sem);
-	return mnt;
+	return do_kern_mount((char *)type->name, 0, (char *)type->name, NULL);
 }
 
 static int do_add_mount(struct nameidata *nd, char *type, int flags,
@@ -1481,6 +1471,7 @@
 	if (IS_ERR(mnt))
 		goto out;
 
+	down(&mount_sem);
 	/* Something was mounted here while we slept */
 	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
 		;
@@ -1490,8 +1481,8 @@
 		retval = -EBUSY;
 	else
 		retval = graft_tree(mnt, nd);
-	mntput(mnt);
 	up(&mount_sem);
+	mntput(mnt);
 out:
 	return retval;
 }

