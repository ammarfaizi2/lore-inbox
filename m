Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267604AbSLFFp1>; Fri, 6 Dec 2002 00:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267605AbSLFFp1>; Fri, 6 Dec 2002 00:45:27 -0500
Received: from packet.digeo.com ([12.110.80.53]:8363 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267604AbSLFFpY>;
	Fri, 6 Dec 2002 00:45:24 -0500
Message-ID: <3DF03B35.AA5858DC@digeo.com>
Date: Thu, 05 Dec 2002 21:52:53 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: [patch] fix the ext3 data=journal unmount bug
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Dec 2002 05:52:53.0713 (UTC) FILETIME=[B7F1F410:01C29CEB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch fixes the data loss which can occur when unmounting a
data=journal ext3 filesystem.

The core problem is that the VFS doesn't tell the filesystem enough
about what is happening.  ext3 _needs_ to know the difference between
regular memory-cleansing writeback and sync-for-data-integrity
purposes.

(These two operations are really quite distinct, and the kernel has got
it wrong for ages.  Even now, kupdate is running filemap_fdatawait()
quite needlessly)

In the early days, ext3 would assume that a write_super() call meant
"sync".  That worked OK.

But that slowed down the kupdate function - it doesn't need to wait on
the writeout.  So we took the `wait' out of ext3_write_super().  And
that worked OK too, because the VFS would later write back all the
dirty data for us.

But then an unrelated optimisation to the truncate path caused that to
not work any more, and we were exposed.



This patch adds a new super_block operation `sync_fs', whose mandate is
to "sync the filesystem" for data-integrity purposes.  ie: it is a
synchronous writeout, whereas write_super is an asynchronous flush.

It is a minimal fix.  Really all the `sync' code in the VFS needs a
rethink.  It is _very_ ext2-centric, and needs to be redesigned to
provide more information to sophisticated filesystems about what is
going on.

But that's not a 2.4 project.  And it's not looking like a 2.5 project
either - I shall be proposing the same fix for 2.5.



 fs/buffer.c        |    6 ++++--
 fs/ext3/super.c    |   25 +++++++++++++------------
 fs/super.c         |    6 +++++-
 include/linux/fs.h |    3 ++-
 4 files changed, 24 insertions(+), 16 deletions(-)

--- linux-akpm/fs/buffer.c~sync_fs	Thu Dec  5 21:33:56 2002
+++ linux-akpm-akpm/fs/buffer.c	Thu Dec  5 21:33:56 2002
@@ -327,6 +327,8 @@ int fsync_super(struct super_block *sb)
 	lock_super(sb);
 	if (sb->s_dirt && sb->s_op && sb->s_op->write_super)
 		sb->s_op->write_super(sb);
+	if (sb->s_op && sb->s_op->sync_fs)
+		sb->s_op->sync_fs(sb);
 	unlock_super(sb);
 	unlock_kernel();
 
@@ -346,7 +348,7 @@ int fsync_dev(kdev_t dev)
 	lock_kernel();
 	sync_inodes(dev);
 	DQUOT_SYNC(dev);
-	sync_supers(dev);
+	sync_supers(dev, 1);
 	unlock_kernel();
 
 	return sync_buffers(dev, 1);
@@ -2833,7 +2835,7 @@ static int sync_old_buffers(void)
 {
 	lock_kernel();
 	sync_unlocked_inodes();
-	sync_supers(0);
+	sync_supers(0, 0);
 	unlock_kernel();
 
 	for (;;) {
--- linux-akpm/include/linux/fs.h~sync_fs	Thu Dec  5 21:33:56 2002
+++ linux-akpm-akpm/include/linux/fs.h	Thu Dec  5 21:33:56 2002
@@ -894,6 +894,7 @@ struct super_operations {
 	void (*delete_inode) (struct inode *);
 	void (*put_super) (struct super_block *);
 	void (*write_super) (struct super_block *);
+	int (*sync_fs) (struct super_block *);
 	void (*write_super_lockfs) (struct super_block *);
 	void (*unlockfs) (struct super_block *);
 	int (*statfs) (struct super_block *, struct statfs *);
@@ -1240,7 +1241,7 @@ static inline int fsync_inode_data_buffe
 extern int inode_has_buffers(struct inode *);
 extern int filemap_fdatasync(struct address_space *);
 extern int filemap_fdatawait(struct address_space *);
-extern void sync_supers(kdev_t);
+extern void sync_supers(kdev_t dev, int wait);
 extern int bmap(struct inode *, int);
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int);
--- linux-akpm/fs/super.c~sync_fs	Thu Dec  5 21:33:56 2002
+++ linux-akpm-akpm/fs/super.c	Thu Dec  5 21:33:56 2002
@@ -445,7 +445,7 @@ static inline void write_super(struct su
  * hold up the sync while mounting a device. (The newly
  * mounted device won't need syncing.)
  */
-void sync_supers(kdev_t dev)
+void sync_supers(kdev_t dev, int wait)
 {
 	struct super_block * sb;
 
@@ -454,6 +454,8 @@ void sync_supers(kdev_t dev)
 		if (sb) {
 			if (sb->s_dirt)
 				write_super(sb);
+			if (wait && sb->s_op && sb->s_op->sync_fs)
+				sb->s_op->sync_fs(sb);
 			drop_super(sb);
 		}
 		return;
@@ -467,6 +469,8 @@ restart:
 			spin_unlock(&sb_lock);
 			down_read(&sb->s_umount);
 			write_super(sb);
+			if (wait && sb->s_op && sb->s_op->sync_fs)
+				sb->s_op->sync_fs(sb);
 			drop_super(sb);
 			goto restart;
 		} else
--- linux-akpm/fs/ext3/super.c~sync_fs	Thu Dec  5 21:33:56 2002
+++ linux-akpm-akpm/fs/ext3/super.c	Thu Dec  5 21:33:56 2002
@@ -47,6 +47,8 @@ static void ext3_mark_recovery_complete(
 static void ext3_clear_journal_err(struct super_block * sb,
 				   struct ext3_super_block * es);
 
+static int ext3_sync_fs(struct super_block * sb);
+
 #ifdef CONFIG_JBD_DEBUG
 int journal_no_write[2];
 
@@ -454,6 +456,7 @@ static struct super_operations ext3_sops
 	delete_inode:	ext3_delete_inode,	/* BKL not held.  We take it */
 	put_super:	ext3_put_super,		/* BKL held */
 	write_super:	ext3_write_super,	/* BKL held */
+	sync_fs:	ext3_sync_fs,
 	write_super_lockfs: ext3_write_super_lockfs, /* BKL not held. Take it */
 	unlockfs:	ext3_unlockfs,		/* BKL not held.  We take it */
 	statfs:		ext3_statfs,		/* BKL held */
@@ -1577,24 +1580,22 @@ int ext3_force_commit(struct super_block
  * This implicitly triggers the writebehind on sync().
  */
 
-static int do_sync_supers = 0;
-MODULE_PARM(do_sync_supers, "i");
-MODULE_PARM_DESC(do_sync_supers, "Write superblocks synchronously");
-
 void ext3_write_super (struct super_block * sb)
 {
+	if (down_trylock(&sb->s_lock) == 0)
+		BUG();
+	sb->s_dirt = 0;
+	log_start_commit(EXT3_SB(sb)->s_journal, NULL);
+}
+
+static int ext3_sync_fs(struct super_block *sb)
+{
 	tid_t target;
 	
-	if (down_trylock(&sb->s_lock) == 0)
-		BUG();		/* aviro detector */
 	sb->s_dirt = 0;
 	target = log_start_commit(EXT3_SB(sb)->s_journal, NULL);
-
-	if (do_sync_supers) {
-		unlock_super(sb);
-		log_wait_commit(EXT3_SB(sb)->s_journal, target);
-		lock_super(sb);
-	}
+	log_wait_commit(EXT3_SB(sb)->s_journal, target);
+	return 0;
 }
 
 /*

_
