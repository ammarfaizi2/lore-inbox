Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269963AbRHNBgG>; Mon, 13 Aug 2001 21:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269978AbRHNBfZ>; Mon, 13 Aug 2001 21:35:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:60636 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269974AbRHNBe4>;
	Mon, 13 Aug 2001 21:34:56 -0400
Date: Mon, 13 Aug 2001 21:35:09 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (10/11) fs/super.c fixes
In-Reply-To: <Pine.GSO.4.21.0108132134360.10579-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0108132134550.10579-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Part 10/11

Long-promised cleanup: lock_super(sb);unlock_super(sb); is gone from
get_super(). ->s_umount gives all needed exclusion.

And here comes the rest of ->s_count story: we lump all permanent references
together, but now we count them as 1+BIGNUM. Now conversion of temporary
reference to permanent one can recognize dying superblocks by s_count alone.
We don't have to rely on mount_sem for that. Check grab_super() and the very
beginning of kill_super() for details - it's quite straightforward. That's
where we need atomicity of s_active, BTW.

diff -urN S9-pre3-dquot/fs/super.c S9-pre3-s_count/fs/super.c
--- S9-pre3-dquot/fs/super.c	Mon Aug 13 21:21:28 2001
+++ S9-pre3-s_count/fs/super.c	Mon Aug 13 21:21:29 2001
@@ -732,10 +732,6 @@
 	s = find_super(dev);
 	if (s) {
 		spin_unlock(&sb_lock);
-		/* Yes, it sucks. As soon as we get refcounting... */
-		/* Almost there - next two lines will go away RSN */
-		lock_super(s);
-		unlock_super(s);
 		down_read(&s->s_umount);
 		if (s->s_root)
 			return s;
@@ -818,6 +814,7 @@
 	spin_lock(&sb_lock);
 	list_add (&s->s_list, super_blocks.prev);
 	list_add (&s->s_instances, &type->fs_supers);
+	s->s_count += S_BIAS;
 	spin_unlock(&sb_lock);
 	down_write(&s->s_umount);
 	lock_super(s);
@@ -839,6 +836,7 @@
 	spin_lock(&sb_lock);
 	list_del(&s->s_list);
 	list_del(&s->s_instances);
+	s->s_count -= S_BIAS;
 	spin_unlock(&sb_lock);
 	put_super(s);
 	return NULL;
@@ -879,13 +877,13 @@
 	spin_unlock(&sb_lock);
 	down_write(&sb->s_umount);
 	if (sb->s_root) {
-		/* Still relying on mount_sem */
-		if (atomic_read(&sb->s_active) > 1) {
-			spin_lock(&sb_lock);
+		spin_lock(&sb_lock);
+		if (sb->s_count > S_BIAS) {
 			sb->s_count--;
 			spin_unlock(&sb_lock);
 			return 1;
 		}
+		spin_unlock(&sb_lock);
 	}
 	atomic_dec(&sb->s_active);
 	put_super(sb);
@@ -970,6 +968,7 @@
 	s->s_type = fs_type;
 	list_add (&s->s_list, super_blocks.prev);
 	list_add (&s->s_instances, &fs_type->fs_supers);
+	s->s_count += S_BIAS;
 
 	spin_unlock(&sb_lock);
 
@@ -993,6 +992,7 @@
 	spin_lock(&sb_lock);
 	list_del(&s->s_list);
 	list_del(&s->s_instances);
+	s->s_count -= S_BIAS;
 	spin_unlock(&sb_lock);
 	put_super(s);
 out1:
@@ -1061,6 +1061,7 @@
 		s->s_type = fs_type;
 		list_add (&s->s_list, super_blocks.prev);
 		list_add (&s->s_instances, &fs_type->fs_supers);
+		s->s_count += S_BIAS;
 		spin_unlock(&sb_lock);
 		lock_super(s);
 		if (!fs_type->read_super(s, data, 0))
@@ -1078,6 +1079,7 @@
 		spin_lock(&sb_lock);
 		list_del(&s->s_list);
 		list_del(&s->s_instances);
+		s->s_count -= S_BIAS;
 		spin_unlock(&sb_lock);
 		put_super(s);
 		put_unnamed_dev(dev);
@@ -1094,8 +1096,12 @@
 	struct file_system_type *fs = sb->s_type;
 	struct super_operations *sop = sb->s_op;
 
-	if (!atomic_dec_and_test(&sb->s_active))
+	if (!atomic_dec_and_lock(&sb->s_active, &sb_lock))
 		return;
+
+	sb->s_count -= S_BIAS;
+	spin_unlock(&sb_lock);
+
 	down_write(&sb->s_umount);
 	lock_kernel();
 	sb->s_root = NULL;
diff -urN S9-pre3-dquot/include/linux/fs.h S9-pre3-s_count/include/linux/fs.h
--- S9-pre3-dquot/include/linux/fs.h	Mon Aug 13 21:21:28 2001
+++ S9-pre3-s_count/include/linux/fs.h	Mon Aug 13 21:21:29 2001
@@ -660,6 +660,7 @@
 extern spinlock_t sb_lock;
 
 #define sb_entry(list)	list_entry((list), struct super_block, s_list)
+#define S_BIAS (1<<30)
 struct super_block {
 	struct list_head	s_list;		/* Keep this first */
 	kdev_t			s_dev;


