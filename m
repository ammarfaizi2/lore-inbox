Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310507AbSCCKIm>; Sun, 3 Mar 2002 05:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293551AbSCCKIa>; Sun, 3 Mar 2002 05:08:30 -0500
Received: from relay01.valueweb.net ([216.219.253.235]:43270 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S293552AbSCCJ5C>; Sun, 3 Mar 2002 04:57:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: Quota patches for 2.5 -11
Date: Sun, 3 Mar 2002 04:57:19 -0500
X-Mailer: KMail [version 1.3.1]
Cc: jack@suse.cz, Alexander Viro <viro@math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020303095640Z293039-31625+8@thor.valueweb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the eleventh of 13 patches.

	This adds write out primitives and the wrappers for the quota code.  
changing DQUOT_SYNC to DQUOT_SYNC_DEV and DQUOT_SYNC_SB  (don't worry 
DQUOT_SYNC_DEV changes to DQUOT_SYNC_ALL in the future.)




diff -urN -X txt/diff-exclude linux-2.5-linus/fs/buffer.c 
linux-2.5/fs/buffer.c
--- linux-2.5-linus/fs/buffer.c	Sat Mar  2 16:40:20 2002
+++ linux-2.5/fs/buffer.c	Sun Mar  3 03:36:50 2002
@@ -345,7 +345,7 @@
 
 	lock_kernel();
 	sync_inodes_sb(sb);
-	DQUOT_SYNC(sb);
+	DQUOT_SYNC_SB(sb);
 	lock_super(sb);
 	if (sb->s_dirt && sb->s_op && sb->s_op->write_super)
 		sb->s_op->write_super(sb);
@@ -389,7 +389,7 @@
 
 	lock_kernel();
 	sync_inodes();
-	DQUOT_SYNC(NULL);
+	DQUOT_SYNC_DEV(val_to_kdev(0));
 	sync_supers();
 	unlock_kernel();
 
diff -urN -X txt/diff-exclude linux-2.5-linus/fs/dquot.c linux-2.5/fs/dquot.c
--- linux-2.5-linus/fs/dquot.c	Sun Mar  3 03:41:13 2002
+++ linux-2.5/fs/dquot.c	Sun Mar  3 03:38:31 2002
@@ -368,12 +368,13 @@
 	}
 }
 
-int sync_dquots(struct super_block *sb, int type)
+int vfs_quota_sync(struct super_block *sb, int type)
 {
 	struct list_head *head;
 	struct dquot *dquot;
+	struct quota_info *dqopt = sb_dqopt(sb);
+	int cnt;
 
-	lock_kernel();
 restart:
 	for (head = inuse_list.next; head != &inuse_list; head = head->next) {
 		dquot = list_entry(head, struct dquot, dq_inuse);
@@ -396,12 +397,74 @@
 		dqput(dquot);
 		goto restart;
 	}
-	/* FIXME: Here we should also sync all file info */
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
+		if ((cnt == type || type == -1) && sb_has_quota_enabled(sb, cnt))
+			dqopt->info[cnt].dqi_flags &= ~DQF_ANY_DQUOT_DIRTY;
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
+		if ((cnt == type || type == -1) && sb_has_quota_enabled(sb, cnt) && 
info_dirty(&dqopt->info[cnt]))
+			dqopt->ops[cnt]->write_file_info(sb, cnt);
 	dqstats.syncs++;
-	unlock_kernel();
 	return 0;
 }
 
+static struct super_block *get_super_to_sync(int type)
+{
+	struct list_head *head;
+	int cnt, dirty;
+
+restart:
+	spin_lock(&sb_lock);
+	list_for_each(head, &super_blocks) {
+		struct super_block *sb = list_entry(head, struct super_block, s_list);
+
+		for (cnt = 0, dirty = 0; cnt < MAXQUOTAS; cnt++)
+			if ((type == cnt || type == -1) && sb_has_quota_enabled(sb, cnt)
+			    && sb_dqopt(sb)->info[cnt].dqi_flags & DQF_ANY_DQUOT_DIRTY)
+				dirty = 1;
+		if (!dirty)
+			continue;
+		sb->s_count++;
+		spin_unlock(&sb_lock);
+		down_read(&sb->s_umount);
+		if (!sb->s_root) {
+			drop_super(sb);
+			goto restart;
+		}
+		return sb;
+	}
+	spin_unlock(&sb_lock);
+	return NULL;
+}
+
+void sync_dquots_dev(kdev_t dev, int type)
+{
+	struct super_block *sb;
+
+	if (dev) {
+		if ((sb = get_super(dev))) {
+			lock_kernel();
+			sb->s_qcop->quota_sync(sb, type);
+			unlock_kernel();
+			drop_super(sb);
+		}
+	}
+	else {
+		while ((sb = get_super_to_sync(type))) {
+			lock_kernel();
+			sb->s_qcop->quota_sync(sb, type);
+			unlock_kernel();
+			drop_super(sb);
+		}
+	}
+}
+
+void sync_dquots_sb(struct super_block *sb, int type)
+{
+	lock_kernel();
+	sb->s_qcop->quota_sync(sb, type);
+	unlock_kernel();
+}
+
 /* Free unused dquots from cache */
 static void prune_dqcache(int count)
 {
@@ -1213,7 +1276,7 @@
 		/* Note: these are blocking operations */
 		remove_dquot_ref(sb, cnt);
 		invalidate_dquots(sb, cnt);
-                if (info_dirty(&dqopt->info[cnt]))
+		if (info_dirty(&dqopt->info[cnt]))
 			dqopt->ops[cnt]->write_file_info(sb, cnt);
 		if (dqopt->ops[cnt]->free_file_info)
 			dqopt->ops[cnt]->free_file_info(sb, cnt);
@@ -1290,11 +1353,6 @@
 	put_quota_format(fmt);
 
 	return error; 
-}
-
-int vfs_quota_sync(struct super_block *sb, int type)
-{
-	return sync_dquots(sb->s_dev, type);
 }
 
 /* Generic routine for getting common part of quota stucture */
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/fs.h 
linux-2.5/include/linux/fs.h
--- linux-2.5-linus/include/linux/fs.h	Sun Mar  3 03:17:15 2002
+++ linux-2.5/include/linux/fs.h	Sun Mar  3 03:35:07 2002
@@ -661,18 +661,6 @@
 	int last_type;
 };
 
-#define DQUOT_USR_ENABLED	0x01		/* User diskquotas enabled */
-#define DQUOT_GRP_ENABLED	0x02		/* Group diskquotas enabled */
-
-struct quota_info {
-	unsigned int flags;			/* Flags for diskquotas on this device */
-	struct semaphore dqio_sem;		/* lock device while I/O in progress */
-	struct semaphore dqoff_sem;		/* serialize quota_off() and quota_on() on 
device */
-	struct file *files[MAXQUOTAS];		/* fp's to quotafiles */
-	struct mem_dqinfo info[MAXQUOTAS];	/* Information for each quota type */
-	struct quota_format_ops *ops[MAXQUOTAS];	/* Operations for each type */
-};
-
 /*
  *	Umount options
  */
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/quota.h 
linux-2.5/include/linux/quota.h
--- linux-2.5-linus/include/linux/quota.h	Sun Mar  3 03:41:13 2002
+++ linux-2.5/include/linux/quota.h	Sun Mar  3 03:35:07 2002
@@ -170,6 +170,7 @@
 
 #define DQF_MASK 0xffff		/* Mask for format specific flags */
 #define DQF_INFO_DIRTY 0x10000  /* Is info dirty? */
+#define DQF_ANY_DQUOT_DIRTY 0x20000	/* Is any dquot dirty? */
 
 extern inline void mark_info_dirty(struct mem_dqinfo *info)
 {
@@ -178,6 +179,9 @@
 
 #define info_dirty(info) ((info)->dqi_flags & DQF_INFO_DIRTY)
 
+#define info_any_dirty(info) ((info)->dqi_flags & DQF_INFO_DIRTY ||\
+			      (info)->dqi_flags & DQF_ANY_DQUOT_DIRTY)
+
 #define sb_dqopt(sb) (&(sb)->s_dquot)
 
 extern int nr_dquots, nr_free_dquots;
@@ -224,13 +228,6 @@
 	struct mem_dqblk dq_dqb;	/* Diskquota usage */
 };
 
-extern inline void mark_dquot_dirty(struct dquot *dquot)
-{
-	dquot->dq_flags |= DQ_MOD;
-}
-
-#define dquot_dirty(dquot) ((dquot)->dq_flags & DQ_MOD)
-
 #define NODQUOT (struct dquot *)NULL
 
 #define QUOTA_OK          0
@@ -278,6 +275,26 @@
 	struct module *qf_owner;		/* Module implementing quota format */
 	struct quota_format_type *qf_next;
 };
+
+#define DQUOT_USR_ENABLED	0x01		/* User diskquotas enabled */
+#define DQUOT_GRP_ENABLED	0x02		/* Group diskquotas enabled */
+
+struct quota_info {
+	unsigned int flags;			/* Flags for diskquotas on this device */
+	struct semaphore dqio_sem;		/* lock device while I/O in progress */
+	struct semaphore dqoff_sem;		/* serialize quota_off() and quota_on() on 
device */
+	struct file *files[MAXQUOTAS];		/* fp's to quotafiles */
+	struct mem_dqinfo info[MAXQUOTAS];	/* Information for each quota type */
+	struct quota_format_ops *ops[MAXQUOTAS];	/* Operations for each type */
+};
+
+/* Inline would be better but we need to dereference super_block which is 
not defined yet */
+#define mark_dquot_dirty(dquot) do {\
+	dquot->dq_flags |= DQ_MOD;\
+	sb_dqopt(dquot->dq_sb)->info[dquot->dq_type].dqi_flags |= 
DQF_ANY_DQUOT_DIRTY;\
+} while (0)
+
+#define dquot_dirty(dquot) ((dquot)->dq_flags & DQ_MOD)
 
 int register_quota_format(struct quota_format_type *fmt);
 void unregister_quota_format(struct quota_format_type *fmt);
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/quotaops.h 
linux-2.5/include/linux/quotaops.h
--- linux-2.5-linus/include/linux/quotaops.h	Sun Mar  3 03:41:13 2002
+++ linux-2.5/include/linux/quotaops.h	Sun Mar  3 03:40:51 2002
@@ -40,7 +40,8 @@
  * declaration of quota_function calls in kernel.
  */
 /* Al this will be changed as soon as I release the first patch */
-extern int sync_dquots(struct super_block *sb, int type);
+extern void sync_dquots_dev(kdev_t dev, int type);
+extern void sync_dquots_sb(struct super_block *sb, int type);
 
 extern void dquot_initialize(struct inode *inode, int type);
 extern void dquot_drop(struct inode *inode);
@@ -183,8 +184,9 @@
 	return 0;
 }
 
-#define DQUOT_SYNC(sb)	sync_dquots(sb, -1)
-#define DQUOT_OFF(sb)	((sb)->s_qcop->quota_off(sb, -1))
+#define DQUOT_SYNC_DEV(dev)	sync_dquots_dev(dev, -1)
+#define DQUOT_SYNC_SB(sb)	sync_dquots_sb(sb, -1)
+#define DQUOT_OFF(sb)		((sb)->s_qcop->quota_off(sb, -1))
 
 #else
 
@@ -197,7 +199,8 @@
 #define DQUOT_DROP(inode)			do { } while(0)
 #define DQUOT_ALLOC_INODE(inode)		(0)
 #define DQUOT_FREE_INODE(inode)			do { } while(0)
-#define DQUOT_SYNC(sb)				do { } while(0)
+#define DQUOT_SYNC_DEV(dev)			do { } while(0)
+#define DQUOT_SYNC_SB(sb)			do { } while(0)
 #define DQUOT_OFF(sb)				do { } while(0)
 #define DQUOT_TRANSFER(inode, iattr)		(0)
 extern __inline__ int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, 
qsize_t nr)
