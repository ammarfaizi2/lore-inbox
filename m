Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269676AbRHMBaf>; Sun, 12 Aug 2001 21:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269646AbRHMBa3>; Sun, 12 Aug 2001 21:30:29 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:49040 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269669AbRHMB3n>;
	Sun, 12 Aug 2001 21:29:43 -0400
Date: Sun, 12 Aug 2001 21:29:55 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/super.c fixes - second series (11/11)
In-Reply-To: <Pine.GSO.4.21.0108122129210.7092-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0108122129420.7092-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Part 11/11

Cleanup: we move decrementing ->s_active into put_super(). Callers updated.

diff -urN S9-pre1-s_count/fs/super.c S9-pre1-put_super/fs/super.c
--- S9-pre1-s_count/fs/super.c	Sun Aug 12 20:45:52 2001
+++ S9-pre1-put_super/fs/super.c	Sun Aug 12 20:45:52 2001
@@ -666,6 +666,7 @@
 
 static void put_super(struct super_block *sb)
 {
+	atomic_dec(&sb->s_active);
 	up_write(&sb->s_umount);
 	__put_super(sb);
 }
@@ -832,7 +833,6 @@
 	s->s_bdev = 0;
 	s->s_type = NULL;
 	unlock_super(s);
-	atomic_dec(&s->s_active);
 	spin_lock(&sb_lock);
 	list_del(&s->s_list);
 	list_del(&s->s_instances);
@@ -885,7 +885,6 @@
 		}
 		spin_unlock(&sb_lock);
 	}
-	atomic_dec(&sb->s_active);
 	put_super(sb);
 	return 0;
 }
@@ -950,13 +949,11 @@
 		if (old->s_type != fs_type ||
 		    ((flags ^ old->s_flags) & MS_RDONLY)) {
 			spin_unlock(&sb_lock);
-			atomic_dec(&s->s_active);
 			put_super(s);
 			goto out1;
 		}
 		if (!grab_super(old))
 			goto restart;
-		atomic_dec(&s->s_active);
 		put_super(s);
 		blkdev_put(bdev, BDEV_FS);
 		path_release(&nd);
@@ -988,7 +985,6 @@
 	s->s_bdev = 0;
 	s->s_type = NULL;
 	unlock_super(s);
-	atomic_dec(&s->s_active);
 	spin_lock(&sb_lock);
 	list_del(&s->s_list);
 	list_del(&s->s_instances);
@@ -1044,14 +1040,12 @@
 				s_instances);
 		if (!grab_super(old))
 			goto retry;
-		atomic_dec(&s->s_active);
 		put_super(s);
 		do_remount_sb(old, flags, data);
 		return old;
 	} else {
 		kdev_t dev = get_unnamed_dev();
 		if (!dev) {
-			atomic_dec(&s->s_active);
 			put_super(s);
 			up(&mount_sem);
 			return ERR_PTR(-EMFILE);
@@ -1075,7 +1069,6 @@
 		s->s_bdev = 0;
 		s->s_type = NULL;
 		unlock_super(s);
-		atomic_dec(&s->s_active);
 		spin_lock(&sb_lock);
 		list_del(&s->s_list);
 		list_del(&s->s_instances);
@@ -1142,6 +1135,7 @@
 	list_del(&sb->s_list);
 	list_del(&sb->s_instances);
 	spin_unlock(&sb_lock);
+	atomic_inc(&sb->s_active);
 	put_super(sb);
 }
 


