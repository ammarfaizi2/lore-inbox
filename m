Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273451AbRINTBf>; Fri, 14 Sep 2001 15:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273450AbRINTBZ>; Fri, 14 Sep 2001 15:01:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:9123 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273449AbRINTBJ>;
	Fri, 14 Sep 2001 15:01:09 -0400
Date: Fri, 14 Sep 2001 15:01:26 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] lazy umount (1/4)
Message-ID: <Pine.GSO.4.21.0109141427070.11172-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Patch below (and 3 incrementals to it) implement lazy-umount.

Some background: right now umount() does the following
	* find vfsmount
	* check if it's busy
	* detach from mountpoint and drop a reference
	* mntput() the sucker and return, letting the garbage collection to
do its job - free vfsmount and possibly deactivate and free superblock.

As the matter of fact, kernel will be quite happy to do the same for busy
vfsmounts - they will simply float around (not attached to anything)
until the become non-busy.  At that point they will be freed, etc.
Situation is analogous to unlinked but still busy files - detaching
the tree as analog of removing a link and deactivation (put_super()) as
analog of finally destroying the file.

There are only two things to take care of -
	a) if we detach a parent we should do it for all children
	b) we should not mount anything on "floating" vfsmounts.
Both are obviously staisfied for current code (presence of children
means that vfsmount is busy and we can't mount on something that
doesn't exist).

NOTE: default behaviour of umount(2) is not changed.  We have a new
flag (MNT_DETACH) that tells umount() to be lazy.  If it is absent -
everything works as usual.

It's _very_ useful in a lot of situations - basically, that's what
umount -f should have been.  E.g. suppose that /usr is kept busy
by something (NFS hard mount/hung process/fs bug/whatever).  Right now
we can't do anything about that - it will keep mountpoint busy.
umount("/usr", MNT_DETACH) will do the following:
	a) detach the damned thing from /usr. Nothing is mounted here
anymore.
	b) umount /usr/local, etc. - no matter what state /usr is in and
how badly it's b0rken.
	c) as soon as that fs becomes not busy it will be deactivated
(put_super(), etc.)
	d) if /usr/local wasn't busy - fine, it gets deactivated
immediately. If it was - no problem, it will be deactivated as soon
as it isn't busy anymore.

Code got a lot of beating here during the last 4 months - it's very
convenient when you are doing fs hacking ;-)  Actually I've got into
a habit of using that instead of normal umount in all cases except
the shutdown scripts - works just fine (for obvious reasons in case
of shutdown non-lazy behaviour is precisely what we want).

It had been in -ac since 2.4.8-ac8 (more than three weeks).  Also no
problems.  Please, apply.  Patch is split into 4 pieces, incremental
to each other.

Part 1/4:
	Killed move_vfsmnt(). change_root() does detach_mnt() and attach_mnt()
by hands.

diff -urN S10-pre9-inode/fs/super.c S10-pre9-move_vfsmnt/fs/super.c
--- S10-pre9-inode/fs/super.c	Fri Sep 14 12:58:45 2001
+++ S10-pre9-move_vfsmnt/fs/super.c	Fri Sep 14 14:02:32 2001
@@ -447,37 +447,6 @@
 	return -ENOENT;
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-static void move_vfsmnt(struct vfsmount *mnt,
-			struct nameidata *nd, 
-			const char *dev_name)
-{
-	struct nameidata parent_nd;
-	char *new_devname = NULL;
-
-	if (dev_name) {
-		new_devname = kmalloc(strlen(dev_name)+1, GFP_KERNEL);
-		if (new_devname)
-			strcpy(new_devname, dev_name);
-	}
-
-	spin_lock(&dcache_lock);
-	detach_mnt(mnt, &parent_nd);
-	attach_mnt(mnt, nd);
-
-	if (new_devname) {
-		if (mnt->mnt_devname)
-			kfree(mnt->mnt_devname);
-		mnt->mnt_devname = new_devname;
-	}
-	spin_unlock(&dcache_lock);
-
-	/* put the old stuff */
-	if (parent_nd.mnt != mnt)
-		path_release(&parent_nd);
-}
-#endif
-
 static void kill_super(struct super_block *);
 
 void __mntput(struct vfsmount *mnt)
@@ -1941,8 +1910,13 @@
 {
 	struct vfsmount *old_rootmnt;
 	struct nameidata devfs_nd, nd;
+	struct nameidata parent_nd;
+	char *new_devname = kmalloc(strlen("/dev/root.old")+1, GFP_KERNEL);
 	int error = 0;
 
+	if (new_devname)
+		strcpy(new_devname, "/dev/root.old");
+
 	read_lock(&current->fs->lock);
 	old_rootmnt = mntget(current->fs->rootmnt);
 	read_unlock(&current->fs->lock);
@@ -1959,6 +1933,9 @@
 		} else 
 			path_release(&devfs_nd);
 	}
+	spin_lock(&dcache_lock);
+	detach_mnt(old_rootmnt, &parent_nd);
+	spin_unlock(&dcache_lock);
 	ROOT_DEV = new_root_dev;
 	mount_root();
 #if 1
@@ -1980,9 +1957,18 @@
 		blivet = blkdev_get(ramdisk, FMODE_READ, 0, BDEV_FS);
 		printk(KERN_NOTICE "Trying to unmount old root ... ");
 		if (!blivet) {
-			blivet = do_umount(old_rootmnt, 0);
-			mntput(old_rootmnt);
-			if (!blivet) {
+			spin_lock(&dcache_lock);
+			list_del(&old_rootmnt->mnt_list);
+			if (atomic_read(&old_rootmnt->mnt_count) > 2) {
+				spin_unlock(&dcache_lock);
+				mntput(old_rootmnt);
+				blivet = -EBUSY;
+			} else {
+				spin_unlock(&dcache_lock);
+				mntput(old_rootmnt);
+				if (parent_nd.mnt != old_rootmnt)
+					path_release(&parent_nd);
+				mntput(old_rootmnt);
 				ioctl_by_bdev(ramdisk, BLKFLSBUF, 0);
 				printk("okay\n");
 				error = 0;
@@ -1991,10 +1977,22 @@
 		}
 		if (blivet)
 			printk(KERN_ERR "error %d\n", blivet);
+		kfree(new_devname);
 		return error;
 	}
-	/* FIXME: we should hold i_zombie on nd.dentry */
-	move_vfsmnt(old_rootmnt, &nd, "/dev/root.old");
+
+	spin_lock(&dcache_lock);
+	attach_mnt(old_rootmnt, &nd);
+	if (new_devname) {
+		if (old_rootmnt->mnt_devname)
+			kfree(old_rootmnt->mnt_devname);
+		old_rootmnt->mnt_devname = new_devname;
+	}
+	spin_unlock(&dcache_lock);
+
+	/* put the old stuff */
+	if (parent_nd.mnt != old_rootmnt)
+		path_release(&parent_nd);
 	mntput(old_rootmnt);
 	path_release(&nd);
 	return 0;

