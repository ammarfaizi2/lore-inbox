Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270423AbRHNE3M>; Tue, 14 Aug 2001 00:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270429AbRHNE3D>; Tue, 14 Aug 2001 00:29:03 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:28116 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270423AbRHNE2v>;
	Tue, 14 Aug 2001 00:28:51 -0400
Date: Tue, 14 Aug 2001 00:29:03 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (1/11) fs/super.c fixes
In-Reply-To: <Pine.LNX.4.33.0108132112180.1277-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0108140023480.10579-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Aug 2001, Linus Torvalds wrote:

> I suspect that you may have generated the diffs in a different order than
> the subject lines imply (ie maybe 3/11 should be 4/11 and vice versa).

Damn. No, it's even dumber - cat desc-$i B$i*-S9-pre3 > $(($i+1) doesn't do
anything good when $i is 1 and we have more than 10 chunks.

IOW, 2/11 got patch from 11/11 added to its tail. Sorry. Correct (== truncated)
variant follows - the rest is OK (checked, applies as posted). If you want
me to resend them too - tell and I'll do that.

Part 2/11

First part of get_sb_bdev() rewrite. We move opening the device to the
beginning of the function. If we already have a superblock from that device
- well, no problem. That, BTW, fixes a buglet with permissions: suppose
we mount /dev/foo, chmod it to 0 and say mount /dev/foo again. Old code
merrily didn't notice that permissions had been revoked and allowed mount.
Main reason for the change is different, though - we are getting the
blocking operations from the area we want to protect with sb_lock (see
the next chunk).


Cleanup: we move decrementing ->s_active into put_super(). Callers updated.

diff -urN S9-pre3-s_umount/fs/super.c S9-pre3-get_sb_bdev/fs/super.c
--- S9-pre3-s_umount/fs/super.c	Mon Aug 13 21:21:26 2001
+++ S9-pre3-get_sb_bdev/fs/super.c	Mon Aug 13 21:21:26 2001
@@ -872,6 +872,26 @@
 			kdevname(dev));
 }
 
+static int grab_super(struct super_block *sb)
+{
+	sb->s_count++;
+	atomic_inc(&sb->s_active);
+	spin_unlock(&sb_lock);
+	down_write(&sb->s_umount);
+	if (sb->s_root) {
+		/* Still relying on mount_sem */
+		if (atomic_read(&sb->s_active) > 1) {
+			spin_lock(&sb_lock);
+			sb->s_count--;
+			spin_unlock(&sb_lock);
+			return 1;
+		}
+	}
+	atomic_dec(&sb->s_active);
+	put_super(sb);
+	return 0;
+}
+
 static struct super_block *get_sb_bdev(struct file_system_type *fs_type,
 	char *dev_name, int flags, void * data)
 {
@@ -880,8 +900,11 @@
 	struct block_device_operations *bdops;
 	struct super_block * sb;
 	struct nameidata nd;
+	struct list_head *p;
 	kdev_t dev;
 	int error = 0;
+	mode_t mode = FMODE_READ; /* we always need it ;-) */
+
 	/* What device it is? */
 	if (!dev_name || !*dev_name)
 		return ERR_PTR(-EINVAL);
@@ -902,52 +925,45 @@
 	/* Done with lookups, semaphore down */
 	down(&mount_sem);
 	dev = to_kdev_t(bdev->bd_dev);
-	sb = get_super(dev);
-	if (sb) {
-		if (fs_type == sb->s_type &&
-		    ((flags ^ sb->s_flags) & MS_RDONLY) == 0) {
-/*
- * We are heavily relying on mount_sem here. We _will_ get rid of that
- * ugliness RSN (and then atomicity of ->s_active will play), but first
- * we need to get rid of "reuse" branch of get_empty_super() and that
- * requires reference counters. Chicken and egg problem, but fortunately
- * we can use the fact that right now all accesses to ->s_active are
- * under mount_sem.
- */
-			if (atomic_read(&sb->s_active)) {
-				spin_lock(&sb_lock);
-				sb->s_count--;
-				spin_unlock(&sb_lock);
-			}
-			atomic_inc(&sb->s_active);
-			/* Next chunk will drop it */
-			up_read(&sb->s_umount);
-			down_write(&sb->s_umount);
-			path_release(&nd);
-			return sb;
-		}
-		drop_super(sb);
-	} else {
-		mode_t mode = FMODE_READ; /* we always need it ;-) */
-		if (!(flags & MS_RDONLY))
-			mode |= FMODE_WRITE;
-		error = blkdev_get(bdev, mode, 0, BDEV_FS);
-		if (error)
-			goto out;
-		check_disk_change(dev);
-		error = -EACCES;
-		if (!(flags & MS_RDONLY) && is_read_only(dev))
+	if (!(flags & MS_RDONLY))
+		mode |= FMODE_WRITE;
+	error = blkdev_get(bdev, mode, 0, BDEV_FS);
+	if (error)
+		goto out;
+	check_disk_change(dev);
+	error = -EACCES;
+	if (!(flags & MS_RDONLY) && is_read_only(dev))
+		goto out1;
+
+	error = -EBUSY;
+restart:
+	spin_lock(&sb_lock);
+
+	list_for_each(p, &super_blocks) {
+		struct super_block *old = sb_entry(p);
+		if (old->s_dev != dev)
+			continue;
+		if (old->s_type != fs_type ||
+		    ((flags ^ old->s_flags) & MS_RDONLY)) {
+			spin_unlock(&sb_lock);
 			goto out1;
-		error = -EINVAL;
-		sb = read_super(dev, bdev, fs_type, flags, data, 0);
-		if (sb) {
-			get_filesystem(fs_type);
-			path_release(&nd);
-			return sb;
 		}
-out1:
+		if (!grab_super(old))
+			goto restart;
 		blkdev_put(bdev, BDEV_FS);
+		path_release(&nd);
+		return old;
 	}
+	spin_unlock(&sb_lock);
+	error = -EINVAL;
+	sb = read_super(dev, bdev, fs_type, flags, data, 0);
+	if (sb) {
+		get_filesystem(fs_type);
+		path_release(&nd);
+		return sb;
+	}
+out1:
+	blkdev_put(bdev, BDEV_FS);
 out:
 	path_release(&nd);
 	up(&mount_sem);

