Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262068AbREWGKx>; Wed, 23 May 2001 02:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262138AbREWGKn>; Wed, 23 May 2001 02:10:43 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:32138 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262068AbREWGK3>;
	Wed, 23 May 2001 02:10:29 -0400
Date: Wed, 23 May 2001 02:10:28 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (part 3) fs/super.c cleanups
In-Reply-To: <Pine.GSO.4.21.0105222359430.17373-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0105230138420.18319-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	OK, chunk #3: beginnings of garbage collection for vfsmounts
and cleanup of do_umount() path.

	* kill_super() had always been conditional on the
list_empty(&s->s_mounts). Check had been pulled inside kill_super(),
if we still have other mounts of that superblock kill_super() simply
returns.  All callers of kill_super() call it unconditionally now.

	* remove_vfsmnt() was an interesting (and obnoxious) beast.
It used to do the following: we called it with dcache_lock held and
passed it the last reference to struct vfsmount *. It detached the
thing from the tree, dropped dcache_lock, freed vfsmount and returned,
leaving us to call kill_super() (if that was the last vfsmount over
that superblock, that is). Ugly and I'm the one to blame here - I
plead the bad taste attack.  It's gone now.  First of all, detaching
from the tree is done by callers of remove_vfsmnt() now. The rest +
call of kill_super() became __mntput(mnt) - it frees the thing and
kills superblock if needed.
	Notice that last reference to vfsmount was _always_ dropped that way.
mntput() called BUG(); if the reference dropped to 0.  The next step is
obvious - now we call __mntput() instead.

	* rules for mntput() had been changed: instead of old "thou shalt
not give the last reference up with mntput()" it's "the last reference
should be killed by mntput() from fs/super.c (old remove_vfsmount() callers)."
	That restriction will be lifted as soon as we get sane locking
(->s_umount instead of the mount_sem crap) on read_super() and friends.
For the time being we simply extend the definition of mntput() - all old
callers never hit the last reference, new ones always do.

	* do_umount() leaves the final call of mntput() to its callers
(each exit path used to end either on remove_vfsmnt() or on mntput()).
As the result we got rid of
	dput(nd.dentry);
	/* It drops nd.mnt */
	do_umount(nd.mnt, 0);
stuff - now it's nice and sane
	do_umount(nd.mnt, 0);
	path_release(&nd);

So there... BTW, kern_umount() turned into mntput()

Linus, if you feel that this one would be better off split into several
steps - please, tell, if it's clean enough - please apply ;-)
								Al
PS: I'm holding the next chunk in case if you have objections to ones
that had been sent so far or want to split the last one.  If you are
OK with these - the next step is saner exclusion (based on ->s_umount).
That will remove all limitations from mntput() and close a bunch of existing
races.

diff -urN S5-pre5-mnt_detach/fs/super.c S5-pre5-GC/fs/super.c
--- S5-pre5-mnt_detach/fs/super.c	Wed May 23 00:19:59 2001
+++ S5-pre5-GC/fs/super.c	Wed May 23 01:21:30 2001
@@ -407,24 +407,20 @@
 		path_release(&parent_nd);
 }
 
-/*
- * Called with spinlock held, releases it.
- */
-static void remove_vfsmnt(struct vfsmount *mnt)
+static void kill_super(struct super_block *);
+
+void __mntput(struct vfsmount *mnt)
 {
-	struct nameidata parent_nd;
-	/* First of all, remove it from all lists */
-	detach_mnt(mnt, &parent_nd);
+	struct super_block *sb = mnt->mnt_sb;
+
+	dput(mnt->mnt_root);
+	spin_lock(&dcache_lock);
 	list_del(&mnt->mnt_instances);
-	list_del(&mnt->mnt_list);
 	spin_unlock(&dcache_lock);
-	/* Now we can work safely */
-	dput(mnt->mnt_root);
-	if (parent_nd.mnt != mnt)
-		path_release(&parent_nd);
 	if (mnt->mnt_devname)
 		kfree(mnt->mnt_devname);
 	kfree(mnt);
+	kill_super(sb);
 }
 
 
@@ -872,6 +868,12 @@
 	struct file_system_type *fs = sb->s_type;
 	struct super_operations *sop = sb->s_op;
 
+	spin_lock(&dcache_lock);
+	if (!list_empty(&sb->s_mounts)) {
+		spin_unlock(&dcache_lock);
+		return;
+	}
+	spin_unlock(&dcache_lock);
 	down_write(&sb->s_umount);
 	sb->s_root = NULL;
 	/* Need to clean after the sucker */
@@ -964,16 +966,6 @@
 	return mnt;
 }
 
-/* Call only after unregister_filesystem() - it's a final cleanup */
-
-void kern_umount(struct vfsmount *mnt)
-{
-	struct super_block *sb = mnt->mnt_sb;
-	spin_lock(&dcache_lock);
-	remove_vfsmnt(mnt);
-	kill_super(sb);
-}
-
 /*
  * Doesn't take quota and stuff into account. IOW, in some cases it will
  * give false negatives. The main reason why it's here is that we need
@@ -989,6 +981,7 @@
 static int do_umount(struct vfsmount *mnt, int flags)
 {
 	struct super_block * sb = mnt->mnt_sb;
+	struct nameidata parent_nd;
 
 	/*
 	 * No sense to grab the lock for this test, but test itself looks
@@ -1005,7 +998,6 @@
 		 * Special case for "unmounting" root ...
 		 * we just try to remount it readonly.
 		 */
-		mntput(mnt);
 		return do_remount("/", MS_RDONLY, NULL);
 	}
 
@@ -1014,14 +1006,16 @@
 	if (mnt->mnt_instances.next != mnt->mnt_instances.prev) {
 		if (atomic_read(&mnt->mnt_count) > 2) {
 			spin_unlock(&dcache_lock);
-			mntput(mnt);
 			return -EBUSY;
 		}
 		if (sb->s_type->fs_flags & FS_SINGLE)
 			put_filesystem(sb->s_type);
-		/* We hold two references, so mntput() is safe */
+		detach_mnt(mnt, &parent_nd);
+		list_del(&mnt->mnt_list);
+		spin_unlock(&dcache_lock);
 		mntput(mnt);
-		remove_vfsmnt(mnt);
+		if (parent_nd.mnt != mnt)
+			path_release(&parent_nd);
 		return 0;
 	}
 	spin_unlock(&dcache_lock);
@@ -1053,15 +1047,16 @@
 	spin_lock(&dcache_lock);
 	if (atomic_read(&mnt->mnt_count) > 2) {
 		spin_unlock(&dcache_lock);
-		mntput(mnt);
 		return -EBUSY;
 	}
 
 	/* OK, that's the point of no return */
+	detach_mnt(mnt, &parent_nd);
+	list_del(&mnt->mnt_list);
+	spin_unlock(&dcache_lock);
 	mntput(mnt);
-	remove_vfsmnt(mnt);
-
-	kill_super(sb);
+	if (parent_nd.mnt != mnt)
+		path_release(&parent_nd);
 	return 0;
 }
 
@@ -1079,7 +1074,6 @@
 	char *kname;
 	int retval;
 
-	lock_kernel();
 	kname = getname(name);
 	retval = PTR_ERR(kname);
 	if (IS_ERR(kname))
@@ -1098,16 +1092,16 @@
 	if (!capable(CAP_SYS_ADMIN) && current->uid!=nd.mnt->mnt_owner)
 		goto dput_and_out;
 
-	dput(nd.dentry);
-	/* puts nd.mnt */
 	down(&mount_sem);
+	lock_kernel();
 	retval = do_umount(nd.mnt, flags);
+	unlock_kernel();
+	path_release(&nd);
 	up(&mount_sem);
 	goto out;
 dput_and_out:
 	path_release(&nd);
 out:
-	unlock_kernel();
 	return retval;
 }
 
@@ -1370,8 +1364,7 @@
 fail:
 	if (fstype->fs_flags & FS_SINGLE)
 		put_filesystem(fstype);
-	if (list_empty(&sb->s_mounts))
-		kill_super(sb);
+	kill_super(sb);
 	goto unlock_out;
 }
 
@@ -1732,10 +1725,9 @@
 	if (!error) {
 		if (devfs_nd.mnt->mnt_sb->s_magic == DEVFS_SUPER_MAGIC &&
 		    devfs_nd.dentry == devfs_nd.mnt->mnt_root) {
-			dput(devfs_nd.dentry);
 			down(&mount_sem);
-			/* puts devfs_nd.mnt */
 			do_umount(devfs_nd.mnt, 0);
+			path_release(&devfs_nd);
 			up(&mount_sem);
 		} else 
 			path_release(&devfs_nd);
@@ -1762,6 +1754,7 @@
 		printk(KERN_NOTICE "Trying to unmount old root ... ");
 		if (!blivet) {
 			blivet = do_umount(old_rootmnt, 0);
+			mntput(old_rootmnt);
 			if (!blivet) {
 				ioctl_by_bdev(ramdisk, BLKFLSBUF, 0);
 				printk("okay\n");
diff -urN S5-pre5-mnt_detach/include/linux/fs.h S5-pre5-GC/include/linux/fs.h
--- S5-pre5-mnt_detach/include/linux/fs.h	Tue May 22 16:44:21 2001
+++ S5-pre5-GC/include/linux/fs.h	Wed May 23 01:18:03 2001
@@ -908,10 +908,10 @@
 extern int register_filesystem(struct file_system_type *);
 extern int unregister_filesystem(struct file_system_type *);
 extern struct vfsmount *kern_mount(struct file_system_type *);
-extern void kern_umount(struct vfsmount *);
 extern int may_umount(struct vfsmount *);
 extern long do_mount(char *, char *, char *, unsigned long, void *);
 
+#define kern_umount mntput
 
 extern int vfs_statfs(struct super_block *, struct statfs *);
 
diff -urN S5-pre5-mnt_detach/include/linux/mount.h S5-pre5-GC/include/linux/mount.h
--- S5-pre5-mnt_detach/include/linux/mount.h	Fri Feb 16 18:33:56 2001
+++ S5-pre5-GC/include/linux/mount.h	Wed May 23 01:11:04 2001
@@ -39,11 +39,13 @@
 	return mnt;
 }
 
+extern void __mntput(struct vfsmount *mnt);
+
 static inline void mntput(struct vfsmount *mnt)
 {
 	if (mnt) {
 		if (atomic_dec_and_test(&mnt->mnt_count))
-			BUG();
+			__mntput(mnt);
 	}
 }
 
diff -urN S5-pre5-mnt_detach/kernel/ksyms.c S5-pre5-GC/kernel/ksyms.c
--- S5-pre5-mnt_detach/kernel/ksyms.c	Tue May 22 16:44:21 2001
+++ S5-pre5-GC/kernel/ksyms.c	Wed May 23 01:12:06 2001
@@ -320,7 +320,7 @@
 EXPORT_SYMBOL(register_filesystem);
 EXPORT_SYMBOL(unregister_filesystem);
 EXPORT_SYMBOL(kern_mount);
-EXPORT_SYMBOL(kern_umount);
+EXPORT_SYMBOL(__mntput);
 EXPORT_SYMBOL(may_umount);
 
 /* executable format registration */

