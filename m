Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269962AbRHNBcn>; Mon, 13 Aug 2001 21:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269963AbRHNBcf>; Mon, 13 Aug 2001 21:32:35 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:12761 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269962AbRHNBcZ>;
	Mon, 13 Aug 2001 21:32:25 -0400
Date: Mon, 13 Aug 2001 21:32:38 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (3/11) fs/super.c fixes
In-Reply-To: <Pine.GSO.4.21.0108132131590.10579-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0108132132230.10579-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Part 3/11

And now the second part - we expand the call of read_super() in get_sb_bdev()
and move superblock allocation in the beginning of the function. That
gets the search in super_blocks for existing superblocks from our device
together with insertion of new superblock into the list (if search fails, that
is). We hold sb_lock over that area, which makes the whole "add if we hadn't
one" thing atomic.

diff -urN S9-pre3-get_sb_bdev/fs/super.c S9-pre3-get_sb_bdev2/fs/super.c
--- S9-pre3-get_sb_bdev/fs/super.c	Mon Aug 13 21:21:26 2001
+++ S9-pre3-get_sb_bdev2/fs/super.c	Mon Aug 13 21:21:26 2001
@@ -898,7 +898,7 @@
 	struct inode *inode;
 	struct block_device *bdev;
 	struct block_device_operations *bdops;
-	struct super_block * sb;
+	struct super_block * s;
 	struct nameidata nd;
 	struct list_head *p;
 	kdev_t dev;
@@ -935,6 +935,12 @@
 	if (!(flags & MS_RDONLY) && is_read_only(dev))
 		goto out1;
 
+	error = -ENOMEM;
+	s = alloc_super();
+	if (!s)
+		goto out1;
+	down_write(&s->s_umount);
+
 	error = -EBUSY;
 restart:
 	spin_lock(&sb_lock);
@@ -946,22 +952,47 @@
 		if (old->s_type != fs_type ||
 		    ((flags ^ old->s_flags) & MS_RDONLY)) {
 			spin_unlock(&sb_lock);
+			atomic_dec(&s->s_active);
+			put_super(s);
 			goto out1;
 		}
 		if (!grab_super(old))
 			goto restart;
+		atomic_dec(&s->s_active);
+		put_super(s);
 		blkdev_put(bdev, BDEV_FS);
 		path_release(&nd);
 		return old;
 	}
+	s->s_dev = dev;
+	s->s_bdev = bdev;
+	s->s_flags = flags;
+	s->s_type = fs_type;
+	list_add (&s->s_list, super_blocks.prev);
+
 	spin_unlock(&sb_lock);
+
 	error = -EINVAL;
-	sb = read_super(dev, bdev, fs_type, flags, data, 0);
-	if (sb) {
-		get_filesystem(fs_type);
-		path_release(&nd);
-		return sb;
-	}
+	lock_super(s);
+	if (!fs_type->read_super(s, data, 0))
+		goto out_fail;
+	unlock_super(s);
+	/* tell bdcache that we are going to keep this one */
+	atomic_inc(&bdev->bd_count);
+	get_filesystem(fs_type);
+	path_release(&nd);
+	return s;
+
+out_fail:
+	s->s_dev = 0;
+	s->s_bdev = 0;
+	s->s_type = NULL;
+	unlock_super(s);
+	atomic_dec(&s->s_active);
+	spin_lock(&sb_lock);
+	list_del(&s->s_list);
+	spin_unlock(&sb_lock);
+	put_super(s);
 out1:
 	blkdev_put(bdev, BDEV_FS);
 out:


