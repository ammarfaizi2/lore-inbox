Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269975AbRHNBfO>; Mon, 13 Aug 2001 21:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269971AbRHNBe0>; Mon, 13 Aug 2001 21:34:26 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:18395 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269975AbRHNBdd>;
	Mon, 13 Aug 2001 21:33:33 -0400
Date: Mon, 13 Aug 2001 21:33:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (6/11) fs/super.c fixes
In-Reply-To: <Pine.GSO.4.21.0108132133110.10579-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0108132133340.10579-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Part 6/11

	* get_sb_single() doesn't rely on kern_mount() being already done.
It simply checks list_empty(&type->fs_supers) and if we already have a
superblocks - grabs and returns it. If we don't have one it does the
right thing - inserts preallocated superblock into the ->fs_supers (and
super_blocks, indeed) and does ->read_super() on it, etc.

	It means that get_sb_single() works regardless of the kern_mount() -
if the latter had been done the thing will pick the superblock as it used
to do, if not - no problems.

diff -urN S9-pre3-fs_supers/fs/super.c S9-pre3-get_sb_single/fs/super.c
--- S9-pre3-fs_supers/fs/super.c	Mon Aug 13 21:21:27 2001
+++ S9-pre3-get_sb_single/fs/super.c	Mon Aug 13 21:21:27 2001
@@ -1031,19 +1031,62 @@
 static struct super_block *get_sb_single(struct file_system_type *fs_type,
 	int flags, void *data)
 {
-	struct super_block * sb;
+	struct super_block * s = alloc_super();
+	if (!s)
+		return ERR_PTR(-ENOMEM);
+	down_write(&s->s_umount);
 	/*
 	 * Get the superblock of kernel-wide instance, but
 	 * keep the reference to fs_type.
 	 */
 	down(&mount_sem);
-	sb = fs_type->kern_mnt->mnt_sb;
-	if (!sb)
-		BUG();
-	atomic_inc(&sb->s_active);
-	down_write(&sb->s_umount);
-	do_remount_sb(sb, flags, data);
-	return sb;
+retry:
+	spin_lock(&sb_lock);
+	if (!list_empty(&fs_type->fs_supers)) {
+		struct super_block *old;
+		old = list_entry(fs_type->fs_supers.next, struct super_block,
+				s_instances);
+		if (!grab_super(old))
+			goto retry;
+		atomic_dec(&s->s_active);
+		put_super(s);
+		do_remount_sb(old, flags, data);
+		return old;
+	} else {
+		kdev_t dev = get_unnamed_dev();
+		if (!dev) {
+			atomic_dec(&s->s_active);
+			put_super(s);
+			up(&mount_sem);
+			return ERR_PTR(-EMFILE);
+		}
+		s->s_dev = dev;
+		s->s_flags = flags;
+		s->s_type = fs_type;
+		list_add (&s->s_list, super_blocks.prev);
+		list_add (&s->s_instances, &fs_type->fs_supers);
+		spin_unlock(&sb_lock);
+		lock_super(s);
+		if (!fs_type->read_super(s, data, 0))
+			goto out_fail;
+		unlock_super(s);
+		return s;
+
+	out_fail:
+		s->s_dev = 0;
+		s->s_bdev = 0;
+		s->s_type = NULL;
+		unlock_super(s);
+		atomic_dec(&s->s_active);
+		spin_lock(&sb_lock);
+		list_del(&s->s_list);
+		list_del(&s->s_instances);
+		spin_unlock(&sb_lock);
+		put_super(s);
+		put_unnamed_dev(dev);
+		up(&mount_sem);
+		return ERR_PTR(-EINVAL);
+	}
 }
 
 static void kill_super(struct super_block *sb)


