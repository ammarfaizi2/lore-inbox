Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273449AbRINTEE>; Fri, 14 Sep 2001 15:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273455AbRINTDx>; Fri, 14 Sep 2001 15:03:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:40102 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273449AbRINTDe>;
	Fri, 14 Sep 2001 15:03:34 -0400
Date: Fri, 14 Sep 2001 15:03:55 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] lazy umount (4/4)
In-Reply-To: <Pine.GSO.4.21.0109141502430.11172-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0109141503210.11172-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 4/4:
	Lazy umount itself. New functions - next_mnt() (walks the vfsmount
tree) and umount_tree() (detach all mounts in a subtree and do mntput() on
each vfsmonut there). do_umount() reorganized to use umount_tree() (if
vfsmount is not busy, it can't have anything mounted on it, so umount_tree()
does the right thing).  New flag to umount(2) - MNT_DETACH.  With that
flag we call umount_tree() even if vfsmount is busy - i.e. we undo all
mounts in a subtree and drop the references that pin vfsmounts down.
As soon as they are not busy they will be deactivated (by mntput()).

diff -urN S10-pre9-check_mnt/fs/super.c S10-pre9-lazy_umount/fs/super.c
--- S10-pre9-check_mnt/fs/super.c	Fri Sep 14 14:04:01 2001
+++ S10-pre9-lazy_umount/fs/super.c	Fri Sep 14 14:04:28 2001
@@ -356,6 +356,22 @@
 	nd->dentry->d_mounted++;
 }
 
+static struct vfsmount *next_mnt(struct vfsmount *p, struct vfsmount *root)
+{
+	struct list_head *next = p->mnt_mounts.next;
+	if (next == &p->mnt_mounts) {
+		while (1) {
+			if (p == root)
+				return NULL;
+			next = p->mnt_child.next;
+			if (next != &p->mnt_parent->mnt_mounts)
+				break;
+			p = p->mnt_parent;
+		}
+	}
+	return list_entry(next, struct vfsmount, mnt_child);
+}
+
 static struct vfsmount *clone_mnt(struct vfsmount *old, struct dentry *root)
 {
 	char *name = old->mnt_devname;
@@ -1124,10 +1140,52 @@
 	return 0;
 }
 
+void umount_tree(struct vfsmount *mnt)
+{
+	struct vfsmount *p;
+	LIST_HEAD(kill);
+
+	if (list_empty(&mnt->mnt_list))
+		return;
+
+	for (p = mnt; p; p = next_mnt(p, mnt)) {
+		list_del(&p->mnt_list);
+		list_add(&p->mnt_list, &kill);
+	}
+
+	while (!list_empty(&kill)) {
+		mnt = list_entry(kill.next, struct vfsmount, mnt_list);
+		list_del_init(&mnt->mnt_list);
+		if (mnt->mnt_parent == mnt) {
+			spin_unlock(&dcache_lock);
+		} else {
+			struct nameidata old_nd;
+			detach_mnt(mnt, &old_nd);
+			spin_unlock(&dcache_lock);
+			path_release(&old_nd);
+		}
+		mntput(mnt);
+		spin_lock(&dcache_lock);
+	}
+}
+
 static int do_umount(struct vfsmount *mnt, int flags)
 {
 	struct super_block * sb = mnt->mnt_sb;
-	struct nameidata parent_nd;
+	int retval = 0;
+
+	/*
+	 * If we may have to abort operations to get out of this
+	 * mount, and they will themselves hold resources we must
+	 * allow the fs to do things. In the Unix tradition of
+	 * 'Gee thats tricky lets do it in userspace' the umount_begin
+	 * might fail to complete on the first run through as other tasks
+	 * must return, and the like. Thats for the mount program to worry
+	 * about for the moment.
+	 */
+
+	if( (flags&MNT_FORCE) && sb->s_op->umount_begin)
+		sb->s_op->umount_begin(sb);
 
 	/*
 	 * No sense to grab the lock for this test, but test itself looks
@@ -1139,7 +1197,7 @@
 	 * /reboot - static binary that would close all descriptors and
 	 * call reboot(9). Then init(8) could umount root and exec /reboot.
 	 */
-	if (mnt == current->fs->rootmnt) {
+	if (mnt == current->fs->rootmnt && !(flags & MNT_DETACH)) {
 		int retval = 0;
 		/*
 		 * Special case for "unmounting" root ...
@@ -1155,57 +1213,20 @@
 
 	spin_lock(&dcache_lock);
 
-	if (atomic_read(&sb->s_active) > 1) {
-		if (atomic_read(&mnt->mnt_count) > 2) {
-			spin_unlock(&dcache_lock);
-			return -EBUSY;
-		}
-		detach_mnt(mnt, &parent_nd);
-		list_del(&mnt->mnt_list);
+	if (atomic_read(&sb->s_active) == 1) {
+		/* last instance - try to be smart */
 		spin_unlock(&dcache_lock);
-		mntput(mnt);
-		path_release(&parent_nd);
-		return 0;
+		DQUOT_OFF(sb);
+		acct_auto_close(sb->s_dev);
+		spin_lock(&dcache_lock);
 	}
-	spin_unlock(&dcache_lock);
-
-	/*
-	 * Before checking whether the filesystem is still busy,
-	 * make sure the kernel doesn't hold any quota files open
-	 * on the device. If the umount fails, too bad -- there
-	 * are no quotas running any more. Just turn them on again.
-	 */
-	DQUOT_OFF(sb);
-	acct_auto_close(sb->s_dev);
-
-	/*
-	 * If we may have to abort operations to get out of this
-	 * mount, and they will themselves hold resources we must
-	 * allow the fs to do things. In the Unix tradition of
-	 * 'Gee thats tricky lets do it in userspace' the umount_begin
-	 * might fail to complete on the first run through as other tasks
-	 * must return, and the like. Thats for the mount program to worry
-	 * about for the moment.
-	 */
-
-	if( (flags&MNT_FORCE) && sb->s_op->umount_begin)
-		sb->s_op->umount_begin(sb);
-
-	/* Something might grab it again - redo checks */
-
-	spin_lock(&dcache_lock);
-	if (atomic_read(&mnt->mnt_count) > 2) {
-		spin_unlock(&dcache_lock);
-		return -EBUSY;
+	retval = -EBUSY;
+	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH) {
+		umount_tree(mnt);
+		retval = 0;
 	}
-
-	/* OK, that's the point of no return */
-	detach_mnt(mnt, &parent_nd);
-	list_del(&mnt->mnt_list);
 	spin_unlock(&dcache_lock);
-	mntput(mnt);
-	path_release(&parent_nd);
-	return 0;
+	return retval;
 }
 
 /*
diff -urN S10-pre9-check_mnt/include/linux/fs.h S10-pre9-lazy_umount/include/linux/fs.h
--- S10-pre9-check_mnt/include/linux/fs.h	Fri Sep 14 12:58:46 2001
+++ S10-pre9-lazy_umount/include/linux/fs.h	Fri Sep 14 14:04:28 2001
@@ -635,6 +635,7 @@
  */
 
 #define MNT_FORCE	0x00000001	/* Attempt to forcibily umount */
+#define MNT_DETACH	0x00000002	/* Just detach from the tree */
 
 #include <linux/minix_fs_sb.h>
 #include <linux/ext2_fs_sb.h>


