Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270544AbRHISfn>; Thu, 9 Aug 2001 14:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270548AbRHISfY>; Thu, 9 Aug 2001 14:35:24 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:55047
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S270544AbRHISfU>; Thu, 9 Aug 2001 14:35:20 -0400
Date: Thu, 09 Aug 2001 14:35:21 -0400
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com, viro@math.psu.edu, mge@sistina.com
Subject: [PATCH] LVM snapshot support for reiserfs and others
Message-ID: <190670000.997382121@tiny>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everyone,

This patch has been floating around for a while and is heavily used;
Heinz and I coded it last October or so.  Minor change in the port to
2.4.8-pre was moving the sync_supers call in fsync_dev_lockfs to match
the changes in fsync_dev.

It adds calls to make use of the write_super_lockfs and unlockfs 
callbacks, which allows the filesystem to do a full sync and block 
new writers while LVM creates a snapshot.  This way, the snapshot is actually 
consistent on creation.

There's one reiserfs hunk in there (also very old) to fix a
bug in my initial reiserfs_write_super_lockfs call.

Patch against 2.4.8-pre6, it won't apply on top of -ac due to
Al's changes.  I'm merging a bunch of stuff into -ac again,
I'll merge this as well.

Linus, please apply

-chris

diff -Nru a/drivers/md/lvm.c b/drivers/md/lvm.c
--- a/drivers/md/lvm.c	Thu Aug  9 14:28:30 2001
+++ b/drivers/md/lvm.c	Thu Aug  9 14:28:30 2001
@@ -162,7 +162,7 @@
 #define	DEVICE_OFF(device)
 
 /* lvm_do_lv_create calls fsync_dev_lockfs()/unlockfs() */
-/* #define	LVM_VFS_ENHANCEMENT */
+#define	LVM_VFS_ENHANCEMENT
 
 #include <linux/config.h>
 #include <linux/version.h>
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Thu Aug  9 14:28:30 2001
+++ b/fs/buffer.c	Thu Aug  9 14:28:30 2001
@@ -367,6 +367,33 @@
 	fsync_dev(dev);
 }
 
+int fsync_dev_lockfs(kdev_t dev)
+{
+	sync_buffers(dev, 0);
+
+	lock_kernel();
+	/* note, the FS might need to start transactions to 
+	** sync the inodes, or the quota, no locking until
+	** after these are done
+	*/
+	sync_inodes(dev);
+	DQUOT_SYNC(dev);
+	/* if inodes or quotas could be dirtied during the
+	** sync_supers_lockfs call, the FS is responsible for getting
+	** them on disk, without deadlocking against the lock
+	**
+	** we call sync_supers first so that 
+	** fsync_dev_lockfs == fsync_dev for filesystems that don't provide
+	** a lockfs call.  Yes, it could be done in sync_supers_lockfs
+	** instead, but this just makes it more explicit...
+	*/
+	sync_supers(dev) ;
+	sync_supers_lockfs(dev) ;
+	unlock_kernel();
+
+	return sync_buffers(dev, 1) ;
+}
+
 asmlinkage long sys_sync(void)
 {
 	fsync_dev(0);
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Thu Aug  9 14:28:30 2001
+++ b/fs/reiserfs/super.c	Thu Aug  9 14:28:30 2001
@@ -80,7 +80,7 @@
     reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1);
     journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
     reiserfs_block_writes(&th) ;
-    journal_end(&th, s, 1) ;
+    journal_end_sync(&th, s, 1) ;
   }
   s->s_dirt = dirty;
   unlock_kernel() ;
diff -Nru a/fs/super.c b/fs/super.c
--- a/fs/super.c	Thu Aug  9 14:28:30 2001
+++ b/fs/super.c	Thu Aug  9 14:28:30 2001
@@ -672,6 +672,46 @@
 	}
 }
 
+/*
+ * Note: don't check the dirty flag before waiting, we want the lock
+ * to happen every time this is called.
+ */
+void sync_supers_lockfs(kdev_t dev)
+{
+	struct super_block * sb;
+
+	for (sb = sb_entry(super_blocks.next);
+	     sb != sb_entry(&super_blocks); 
+	     sb = sb_entry(sb->s_list.next)) {
+		if (!sb->s_dev)
+			continue;
+		if (dev && sb->s_dev != dev)
+			continue;
+		lock_super(sb);
+		if (sb->s_dev && (!dev || dev == sb->s_dev))
+			if (sb->s_op && sb->s_op->write_super_lockfs)
+				sb->s_op->write_super_lockfs(sb);
+		unlock_super(sb);
+	}
+}
+
+void unlockfs(kdev_t dev)
+{
+	struct super_block * sb;
+
+	for (sb = sb_entry(super_blocks.next);
+	     sb != sb_entry(&super_blocks); 
+	     sb = sb_entry(sb->s_list.next)) {
+		if (!sb->s_dev)
+			continue;
+		if (dev && sb->s_dev != dev)
+			continue;
+		if (sb->s_dev && (!dev || dev == sb->s_dev))
+			if (sb->s_op && sb->s_op->unlockfs)
+				sb->s_op->unlockfs(sb);
+	}
+}
+
 /**
  *	get_super	-	get the superblock of a device
  *	@dev: device to get the superblock for
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Thu Aug  9 14:28:30 2001
+++ b/include/linux/fs.h	Thu Aug  9 14:28:30 2001
@@ -1160,6 +1160,7 @@
 extern void write_inode_now(struct inode *, int);
 extern void sync_dev(kdev_t);
 extern int fsync_dev(kdev_t);
+extern int fsync_dev_lockfs(kdev_t);
 extern int fsync_super(struct super_block *);
 extern void sync_inodes_sb(struct super_block *);
 extern int fsync_inode_buffers(struct inode *);
@@ -1168,6 +1169,8 @@
 extern void filemap_fdatasync(struct address_space *);
 extern void filemap_fdatawait(struct address_space *);
 extern void sync_supers(kdev_t);
+extern void sync_supers_lockfs(kdev_t);
+extern void unlockfs(kdev_t);
 extern int bmap(struct inode *, int);
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int);
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Thu Aug  9 14:28:30 2001
+++ b/kernel/ksyms.c	Thu Aug  9 14:28:30 2001
@@ -176,6 +176,8 @@
 EXPORT_SYMBOL(invalidate_inode_pages);
 EXPORT_SYMBOL(truncate_inode_pages);
 EXPORT_SYMBOL(fsync_dev);
+EXPORT_SYMBOL(fsync_dev_lockfs);
+EXPORT_SYMBOL(unlockfs);
 EXPORT_SYMBOL(permission);
 EXPORT_SYMBOL(vfs_permission);
 EXPORT_SYMBOL(inode_setattr);

