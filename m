Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273927AbRIXOwR>; Mon, 24 Sep 2001 10:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273928AbRIXOwI>; Mon, 24 Sep 2001 10:52:08 -0400
Received: from mx3.arach.net.au ([203.30.44.5]:29413 "HELO
	mandible.arach.net.au") by vger.kernel.org with SMTP
	id <S273927AbRIXOwA>; Mon, 24 Sep 2001 10:52:00 -0400
X-Qmail-Scanner-Mail-From: kuib-kl@ljbc.wa.edu.au via mandible.arach.net.au
X-Qmail-Scanner: 1.01 (Clean. Processed in 0.260928 secs)
Message-ID: <B0005839606@gollum.logi.net.au>
From: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Date: Mon, 24 Sep 2001 22:54:10 +0800
X-Mailer: KMail [version 1.3]
Cc: reiserfs-list@namesys.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_AE96Y9V4DEWF27WNIAOZ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_AE96Y9V4DEWF27WNIAOZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit


> Thanks to everyone who has helped me so far, and I look forward to further
> comments and assistance,
> Beau Kuiper
> kuib-kl@ljbc.wa.edu.au

And I should attach the patch :-) Sorry about that

Beau Kuiper
kuib-kl@ljbc.wa.edu.au


--------------Boundary-00=_AE96Y9V4DEWF27WNIAOZ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="kupdated-patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="kupdated-patch"

--- v2.4.10/linux/fs/buffer.c	Mon Sep 24 14:04:05 2001
+++ linux/fs/buffer.c	Mon Sep 24 14:00:14 2001
@@ -359,7 +359,7 @@
 	lock_kernel();
 	sync_inodes(dev);
 	DQUOT_SYNC(dev);
-	sync_supers(dev);
+	sync_supers(dev, 0);
 	unlock_kernel();

 	return sync_buffers(dev, 1);
@@ -2753,7 +2753,7 @@
 {
 	lock_kernel();
 	sync_unlocked_inodes();
-	sync_supers(0);
+	sync_supers(0, 1);
 	unlock_kernel();

 	for (;;) {
--- v2.4.10/linux/fs/super.c	Mon Sep 24 14:04:07 2001
+++ linux/fs/super.c	Mon Sep 24 13:40:45 2001
@@ -688,13 +688,32 @@
 			sb->s_op->write_super(sb);
 	unlock_super(sb);
 }
-
+
+/* This is used for kupdated super-block updating
+ * it trys to use the specific super update function,
+ * and if it fails, falls back to using write_super
+ */
+
+static inline void update_super(struct super_block *sb)
+{
+	lock_super(sb);
+	if (sb->s_root && sb->s_dirt)
+		if (sb->s_op)
+		{
+			if (sb->s_op->write_super_kupdated)
+				sb->s_op->write_super_kupdated(sb);
+			else if (sb->s_op->write_super)
+				sb->s_op->write_super(sb);
+		}
+	unlock_super(sb);
+}
+
 /*
  * Note: check the dirty flag before waiting, so we don't
  * hold up the sync while mounting a device. (The newly
  * mounted device won't need syncing.)
  */
-void sync_supers(kdev_t dev)
+void sync_supers(kdev_t dev, int kupdated)
 {
 	struct super_block * sb;

@@ -708,18 +727,34 @@
 		return;
 	}
 restart:
+	// since reiserfs does not garrentee super is not dirty (journal may
+	// be dirty still with kupdated), have to do this the hard way
 	spin_lock(&sb_lock);
 	sb = sb_entry(super_blocks.next);
 	while (sb != sb_entry(&super_blocks))
-		if (sb->s_dirt) {
+		if (sb->s_dirt && !(sb->s_flushed)) {
 			sb->s_count++;
+			sb->s_flushed = 1;
 			spin_unlock(&sb_lock);
 			down_read(&sb->s_umount);
-			write_super(sb);
+			if (kupdated)
+				update_super(sb);
+			else
+				write_super(sb);
 			drop_super(sb);
 			goto restart;
 		} else
 			sb = sb_entry(sb->s_list.next);
+
+	// now unflush all supers
+
+	sb = sb_entry(super_blocks.next);
+	while (sb != sb_entry(&super_blocks))
+	{
+		sb->s_flushed = 0;
+		sb = sb_entry(sb->s_list.next);
+	}
+
 	spin_unlock(&sb_lock);
 }

@@ -805,6 +840,7 @@
 		sema_init(&s->s_dquot.dqio_sem, 1);
 		sema_init(&s->s_dquot.dqoff_sem, 1);
 		s->s_maxbytes = MAX_NON_LFS;
+		s->s_flushed = 0;
 	}
 	return s;
 }
--- v2.4.10/linux/include/linux/fs.h	Mon Sep 24 14:04:10 2001
+++ linux/include/linux/fs.h	Mon Sep 24 13:01:34 2001
@@ -689,6 +689,7 @@
 	unsigned long		s_blocksize;
 	unsigned char		s_blocksize_bits;
 	unsigned char		s_dirt;
+	unsigned char		s_flushed;
 	unsigned long long	s_maxbytes;	/* Max file size */
 	struct file_system_type	*s_type;
 	struct super_operations	*s_op;
@@ -859,6 +860,7 @@
 	void (*delete_inode) (struct inode *);
 	void (*put_super) (struct super_block *);
 	void (*write_super) (struct super_block *);
+	void (*write_super_kupdated) (struct super_block *);
 	void (*write_super_lockfs) (struct super_block *);
 	void (*unlockfs) (struct super_block *);
 	int (*statfs) (struct super_block *, struct statfs *);
@@ -1198,7 +1200,7 @@
 extern int inode_has_buffers(struct inode *);
 extern void filemap_fdatasync(struct address_space *);
 extern void filemap_fdatawait(struct address_space *);
-extern void sync_supers(kdev_t);
+extern void sync_supers(kdev_t, int);
 extern int bmap(struct inode *, int);
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int);
--- v2.4.10/linux/fs/reiserfs/super.c	Mon Sep 24 14:04:07 2001
+++ linux/fs/reiserfs/super.c	Mon Sep 24 13:08:05 2001
@@ -32,18 +31,28 @@
 // at the ext2 code and comparing. It's subfunctions contain no code
 // used as a template unless they are so labeled.
 //
-void reiserfs_write_super (struct super_block * s)
+void reiserfs_write_super_ex (struct super_block * s, int immediate)
 {

   int dirty = 0 ;
   lock_kernel() ;
   if (!(s->s_flags & MS_RDONLY)) {
-    dirty = flush_old_commits(s, 1) ;
+    dirty = flush_old_commits(s, immediate) ;
   }
   s->s_dirt = dirty;
   unlock_kernel() ;
 }

+void reiserfs_write_super_kupdated (struct super_block * s)
+{
+	reiserfs_write_super_ex(s, 0);
+}
+
+void reiserfs_write_super (struct super_block * s)
+{
+	reiserfs_write_super_ex(s, 1);
+}
+
 //
 // a portion of this function, particularly the VFS interface portion,
 // was derived from minix or ext2's analog and evolved as the
@@ -125,6 +134,7 @@
   dirty_inode: reiserfs_dirty_inode,
   delete_inode: reiserfs_delete_inode,
   put_super: reiserfs_put_super,
+  write_super_kupdated: reiserfs_write_super_kupdated,
   write_super: reiserfs_write_super,
   write_super_lockfs: reiserfs_write_super_lockfs,
   unlockfs: reiserfs_unlockfs,

--------------Boundary-00=_AE96Y9V4DEWF27WNIAOZ--
