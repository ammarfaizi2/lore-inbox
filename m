Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293565AbSCLWCK>; Tue, 12 Mar 2002 17:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293630AbSCLWCB>; Tue, 12 Mar 2002 17:02:01 -0500
Received: from 216-42-72-143.ppp.netsville.net ([216.42.72.143]:20878 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S293565AbSCLWBo>; Tue, 12 Mar 2002 17:01:44 -0500
Date: Tue, 12 Mar 2002 17:00:53 -0500
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
cc: aviro@math.psu.edu, akpm@zip.com.au
Subject: [RFC] write_super is for syncing
Message-ID: <205630000.1015970453@tiny>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everyone,

The fact that write_super gets called for both syncs and periodic
commits causes problems for the journaled filesystems, since we
need to trigger commits on write_super to have sync() behave
properly.

So, this patch adds a new super operation called commit_super,
and extends struct super.s_dirt a little so the filesystem
can say: call me on sync() but don't call me from kupdate.

if (s_dirt & S_SUPER_DIRTY) call me from kupdate and on sync
if (s_dirt & S_SUPER_DIRTY_COMMIT) call me on sync only.

If the commit_super operation is not provided, fs/super.c goes
back to the old s_dirt usage.

I've got reiserfs bits to make use of this, they increase our
streaming write performance by ~30%.  This patch is against 2.4.19-pre1,
it applies cleanly to pre3 but I haven't tested that yet.  I'll port
to 2.5 if we agree the patch is a good idea.

-chris

--- linus.25/fs/super.c Mon, 28 Jan 2002 09:51:50 -0500 
+++ speedup.1/fs/super.c Sun, 12 May 2002 10:54:29 -0400 
@@ -453,15 +453,68 @@
 	put_super(sb);
 }
 
+/* since we've added the idea of comit_dirty vs regular dirty with
+ * commit_super operation, only use the S_SUPER_DIRTY mask if 
+ * the FS has a commit_super op.
+ */
+static inline int super_dirty(struct super_block *sb)
+{
+	if (sb->s_op && sb->s_op->commit_super) {
+		return sb->s_dirt & S_SUPER_DIRTY;
+	}
+	return sb->s_dirt;
+}
+
+
 static inline void write_super(struct super_block *sb)
 {
 	lock_super(sb);
-	if (sb->s_root && sb->s_dirt)
+	if (sb->s_root && super_dirty(sb))
 		if (sb->s_op && sb->s_op->write_super)
 			sb->s_op->write_super(sb);
 	unlock_super(sb);
 }
 
+static inline void commit_super(struct super_block *sb)
+{
+	lock_super(sb);
+	if (sb->s_root && sb->s_dirt) {
+		if (sb->s_op && sb->s_op->write_super)
+			sb->s_op->write_super(sb);
+		if (sb->s_op && sb->s_op->commit_super)
+			sb->s_op->commit_super(sb);
+	}
+	unlock_super(sb);
+}
+
+void commit_supers(kdev_t dev)
+{
+	struct super_block * sb;
+
+	if (dev) {
+		sb = get_super(dev);
+		if (sb) {
+			if (sb->s_dirt)
+				commit_super(sb);
+			drop_super(sb);
+		}
+	}
+restart:
+	spin_lock(&sb_lock);
+	sb = sb_entry(super_blocks.next);
+	while (sb != sb_entry(&super_blocks))
+		if (sb->s_dirt) {
+			sb->s_count++;
+			spin_unlock(&sb_lock);
+			down_read(&sb->s_umount);
+			commit_super(sb);
+			drop_super(sb);
+			goto restart;
+		} else
+			sb = sb_entry(sb->s_list.next);
+	spin_unlock(&sb_lock);
+}
+
 /*
  * Note: check the dirty flag before waiting, so we don't
  * hold up the sync while mounting a device. (The newly
@@ -484,7 +537,7 @@
 	spin_lock(&sb_lock);
 	sb = sb_entry(super_blocks.next);
 	while (sb != sb_entry(&super_blocks))
-		if (sb->s_dirt) {
+		if (super_dirty(sb)) {
 			sb->s_count++;
 			spin_unlock(&sb_lock);
 			down_read(&sb->s_umount);
--- linus.25/fs/buffer.c Mon, 11 Feb 2002 12:21:42 -0500 
+++ speedup.1/fs/buffer.c Sun, 12 May 2002 10:54:29 -0400 
@@ -327,6 +327,8 @@
 	lock_super(sb);
 	if (sb->s_dirt && sb->s_op && sb->s_op->write_super)
 		sb->s_op->write_super(sb);
+	if (sb->s_op && sb->s_op->commit_super)
+		sb->s_op->commit_super(sb);
 	unlock_super(sb);
 	unlock_kernel();
 
@@ -346,7 +348,7 @@
 	lock_kernel();
 	sync_inodes(dev);
 	DQUOT_SYNC(dev);
-	sync_supers(dev);
+	commit_supers(dev);
 	unlock_kernel();
 
 	return sync_buffers(dev, 1);
--- linus.25/include/linux/fs.h Mon, 28 Jan 2002 09:51:50 -0500 
+++ speedup.1/include/linux/fs.h Sun, 12 May 2002 10:54:29 -0400 
@@ -697,6 +697,10 @@
 
 #define sb_entry(list)	list_entry((list), struct super_block, s_list)
 #define S_BIAS (1<<30)
+
+/* flags for the s_dirt field */
+#define S_SUPER_DIRTY 1
+#define S_SUPER_DIRTY_COMMIT 2
 struct super_block {
 	struct list_head	s_list;		/* Keep this first */
 	kdev_t			s_dev;
@@ -909,6 +913,7 @@
 	struct dentry * (*fh_to_dentry)(struct super_block *sb, __u32 *fh, int len, int fhtype, int parent);
 	int (*dentry_to_fh)(struct dentry *, __u32 *fh, int *lenp, int need_parent);
 	int (*show_options)(struct seq_file *, struct vfsmount *);
+	void (*commit_super) (struct super_block *);
 };
 
 /* Inode state bits.. */
@@ -1216,6 +1221,7 @@
 extern int filemap_fdatasync(struct address_space *);
 extern int filemap_fdatawait(struct address_space *);
 extern void sync_supers(kdev_t);
+extern void commit_supers(kdev_t);
 extern int bmap(struct inode *, int);
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int);

