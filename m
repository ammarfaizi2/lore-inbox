Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263431AbRFKFkl>; Mon, 11 Jun 2001 01:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263430AbRFKFkb>; Mon, 11 Jun 2001 01:40:31 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:11191 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263433AbRFKFkO>;
	Mon, 11 Jun 2001 01:40:14 -0400
Date: Mon, 11 Jun 2001 01:40:11 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/super.c stuff (10/10)
In-Reply-To: <Pine.GSO.4.21.0106110138470.24249-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0106110139490.24249-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN S6-pre2-alloc_super/fs/inode.c S6-pre2-current/fs/inode.c
--- S6-pre2-alloc_super/fs/inode.c	Sun Jun 10 19:09:35 2001
+++ S6-pre2-current/fs/inode.c	Sun Jun 10 19:26:27 2001
@@ -357,11 +357,7 @@
 		spin_unlock(&inode_lock);
 		down_read(&s->s_umount);
 		if (!s->s_root) {
-			up_read(&s->s_umount);
-			spin_lock(&sb_lock);
-			if (!--s->s_count)
-				kfree(s);
-			spin_unlock(&sb_lock);
+			drop_super(s);
 			goto restart;
 		}
 		return s;
@@ -388,23 +384,13 @@
 	 */
 	if (dev) {
 		if ((s = get_super(dev)) != NULL) {
-			down_read(&s->s_umount);
-			if (s->s_root)
-				sync_inodes_sb(s);
-			up_read(&s->s_umount);
-			spin_lock(&sb_lock);
-			if (!--s->s_count)
-				kfree(s);
-			spin_unlock(&sb_lock);
+			sync_inodes_sb(s);
+			drop_super(s);
 		}
 	} else {
 		while ((s = get_super_to_sync()) != NULL) {
 			sync_inodes_sb(s);
-			up_read(&s->s_umount);
-			spin_lock(&sb_lock);
-			if (!--s->s_count)
-				kfree(s);
-			spin_unlock(&sb_lock);
+			drop_super(s);
 		}
 	}
 }
@@ -636,13 +622,14 @@
  
 int invalidate_device(kdev_t dev, int do_sync)
 {
-	struct super_block *sb = get_super(dev);
+	struct super_block *sb;
 	int res;
 
 	if (do_sync)
 		fsync_dev(dev);
 
 	res = 0;
+	sb = get_super(dev);
 	if (sb) {
 		res = invalidate_inodes(sb);
 		drop_super(sb);
diff -urN S6-pre2-alloc_super/fs/super.c S6-pre2-current/fs/super.c
--- S6-pre2-alloc_super/fs/super.c	Sun Jun 10 19:09:39 2001
+++ S6-pre2-current/fs/super.c	Sun Jun 10 19:36:51 2001
@@ -647,8 +647,23 @@
 	spin_unlock(&sb_lock);
 }
 
+static inline struct super_block * find_super(kdev_t dev)
+{
+	struct list_head *p;
+
+	list_for_each(p, &super_blocks) {
+		struct super_block * s = sb_entry(p);
+		if (s->s_dev == dev) {
+			s->s_count++;
+			return s;
+		}
+	}
+	return NULL;
+}
+
 void drop_super(struct super_block *sb)
 {
+	up_read(&sb->s_umount);
 	__put_super(sb);
 }
 
@@ -681,8 +696,7 @@
 		if (sb) {
 			if (sb->s_dirt)
 				write_super(sb);
-			up_read(&sb->s_umount);
-			__put_super(sb);
+			drop_super(sb);
 		}
 		return;
 	}
@@ -695,8 +709,7 @@
 			spin_unlock(&sb_lock);
 			down_read(&sb->s_umount);
 			write_super(sb);
-			up_read(&sb->s_umount);
-			__put_super(sb);
+			drop_super(sb);
 			goto restart;
 		} else
 			sb = sb_entry(sb->s_list.next);
@@ -719,21 +732,19 @@
 		return NULL;
 restart:
 	spin_lock(&sb_lock);
-	s = sb_entry(super_blocks.next);
-	while (s != sb_entry(&super_blocks))
-		if (s->s_dev == dev) {
-			/* Yes, it sucks. As soon as we get refcounting... */
-			/* Almost there */
-			s->s_count++;
-			spin_unlock(&sb_lock);
-			lock_super(s);
-			unlock_super(s);
-			if (s->s_dev == dev)
-				return s;
-			drop_super(s);
-			goto restart;
-		} else
-			s = sb_entry(s->s_list.next);
+	s = find_super(dev);
+	if (s) {
+		spin_unlock(&sb_lock);
+		/* Yes, it sucks. As soon as we get refcounting... */
+		/* Almost there - next two lines will go away RSN */
+		lock_super(s);
+		unlock_super(s);
+		down_read(&s->s_umount);
+		if (s->s_root)
+			return s;
+		drop_super(s);
+		goto restart;
+	}
 	spin_unlock(&sb_lock);
 	return NULL;
 }
@@ -905,10 +916,11 @@
 				spin_unlock(&sb_lock);
 			}
 			atomic_inc(&sb->s_active);
+			up_read(&sb->s_umount);
 			path_release(&nd);
 			return sb;
 		}
-		__put_super(sb);
+		drop_super(sb);
 	} else {
 		mode_t mode = FMODE_READ; /* we always need it ;-) */
 		if (!(flags & MS_RDONLY))
@@ -1623,6 +1635,7 @@
 		/* FIXME */
 		fs_type = sb->s_type;
 		atomic_inc(&sb->s_active);
+		up_read(&sb->s_umount);
 		goto mount_it;
 	}
 


