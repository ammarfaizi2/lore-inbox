Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318736AbSHERaG>; Mon, 5 Aug 2002 13:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318738AbSHERaG>; Mon, 5 Aug 2002 13:30:06 -0400
Received: from 216-42-72-141.ppp.netsville.net ([216.42.72.141]:45735 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S318736AbSHERaE>;
	Mon, 5 Aug 2002 13:30:04 -0400
Subject: [PATCH] write_super is not for syncing (take 3)
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Aug 2002 13:34:53 -0400
Message-Id: <1028568893.1805.270.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This patch has been floating around for some time, and I've been
building other reiserfs speedups on top of it.  It does two things:

1) allows the FS write_super function to leave the super dirty without
looping endlessly in sync_supers().  This is based on code sent to me by
Hugh Dickins, and it helps all the filesystems avoid looping in
sync_supers() under load.

2) adds a commit_super() call to struct super_operations().  This allows
the journaled filesystems to differentiate between calls from sync() and
calls from kupdated.

Below are just the hunks that change VFS code, against 2.4.19-final. 
The reiserfs bits will come once this gets accepted.  Please review and
throw something blunt at me if you don't want this in the kernel.

-chris

diff -urN --exclude *.orig --exclude *.rej parent/fs/buffer.c comp/fs/buffer.c
--- parent/fs/buffer.c	Sun Jun  2 23:14:55 2002
+++ comp/fs/buffer.c	Sun Jun  2 23:14:47 2002
@@ -328,6 +328,8 @@
 	lock_super(sb);
 	if (sb->s_dirt && sb->s_op && sb->s_op->write_super)
 		sb->s_op->write_super(sb);
+	if (sb->s_op && sb->s_op->commit_super)
+		sb->s_op->commit_super(sb);
 	unlock_super(sb);
 	unlock_kernel();
 
@@ -347,7 +349,7 @@
 	lock_kernel();
 	sync_inodes(dev);
 	DQUOT_SYNC(dev);
-	sync_supers(dev);
+	commit_supers(dev);
 	unlock_kernel();
 
 	return sync_buffers(dev, 1);
diff -urN --exclude *.orig --exclude *.rej parent/fs/super.c comp/fs/super.c
--- parent/fs/super.c	Sun Jun  2 23:14:54 2002
+++ comp/fs/super.c	Sun Jun  2 23:14:47 2002
@@ -396,6 +396,7 @@
 	struct file_system_type *fs = s->s_type;
 
 	spin_lock(&sb_lock);
+	s->s_type = NULL;
 	list_del(&s->s_list);
 	list_del(&s->s_instances);
 	spin_unlock(&sb_lock);
@@ -440,12 +441,23 @@
 	unlock_super(sb);
 }
 
+static inline void commit_super(struct super_block *sb)
+{
+	lock_super(sb);
+	if (sb->s_root && sb->s_dirt)
+		if (sb->s_op && sb->s_op->write_super)
+			sb->s_op->write_super(sb);
+		if (sb->s_op && sb->s_op->commit_super)
+			sb->s_op->commit_super(sb);
+	unlock_super(sb);
+}
+
 /*
  * Note: check the dirty flag before waiting, so we don't
  * hold up the sync while mounting a device. (The newly
  * mounted device won't need syncing.)
  */
-void sync_supers(kdev_t dev)
+static void dirty_super_op(kdev_t dev, void (*func)(struct super_block *))
 {
 	struct super_block * sb;
 
@@ -453,25 +465,41 @@
 		sb = get_super(dev);
 		if (sb) {
 			if (sb->s_dirt)
-				write_super(sb);
+				func(sb);
 			drop_super(sb);
 		}
 		return;
 	}
-restart:
 	spin_lock(&sb_lock);
+restart:
 	sb = sb_entry(super_blocks.next);
-	while (sb != sb_entry(&super_blocks))
+	while (sb != sb_entry(&super_blocks)) {
 		if (sb->s_dirt) {
 			sb->s_count++;
 			spin_unlock(&sb_lock);
 			down_read(&sb->s_umount);
-			write_super(sb);
-			drop_super(sb);
-			goto restart;
-		} else
-			sb = sb_entry(sb->s_list.next);
+			func(sb);
+			up_read(&sb->s_umount);
+			spin_lock(&sb_lock);
+			if (!--sb->s_count) {
+				destroy_super(sb);
+				goto restart;
+			} else if (!sb->s_type)
+				goto restart;
+		}
+		sb = sb_entry(sb->s_list.next);
+	}
 	spin_unlock(&sb_lock);
+}
+
+void sync_supers(kdev_t dev)
+{
+    dirty_super_op(dev, write_super);
+}
+
+void commit_supers(kdev_t dev)
+{
+    dirty_super_op(dev, commit_super);
 }
 
 /**
diff -urN --exclude *.orig --exclude *.rej parent/include/linux/fs.h comp/include/linux/fs.h
--- parent/include/linux/fs.h	Sun Jun  2 23:14:55 2002
+++ comp/include/linux/fs.h	Sun Jun  2 23:14:47 2002
@@ -920,6 +920,7 @@
 	struct dentry * (*fh_to_dentry)(struct super_block *sb, __u32 *fh, int len, int fhtype, int parent);
 	int (*dentry_to_fh)(struct dentry *, __u32 *fh, int *lenp, int need_parent);
 	int (*show_options)(struct seq_file *, struct vfsmount *);
+	void (*commit_super) (struct super_block *);
 };
 
 /* Inode state bits.. */
@@ -1236,6 +1237,7 @@
 extern int filemap_fdatasync(struct address_space *);
 extern int filemap_fdatawait(struct address_space *);
 extern void sync_supers(kdev_t);
+extern void commit_supers(kdev_t);
 extern int bmap(struct inode *, int);
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int);

