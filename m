Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbTDOPAx (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 11:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTDOPAx 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 11:00:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46086 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261454AbTDOPAu (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 11:00:50 -0400
Date: Tue, 15 Apr 2003 17:12:41 +0200
From: Jan Kara <jack@suse.cz>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, sct@redhat.com, akpm@digeo.com
Subject: Deadlock fix for 2.4.20
Message-ID: <20030415151240.GA23547@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  I'm sending you a patch which fixes the deadlock when quota is used on
ext3. The problem is that in sync_dquots() first dqio_sem is acquired
and then transaction is started while in the other paths the order is
inverse... The patch introduces needed framework into quota to allow
ext3 start transaction before the semaphore is acquired. Please apply.

								Honza

diff -ruNX /home/jack/.kerndiffexclude linux-2.4.20/fs/dquot.c linux-2.4.20-1-ext3deadlock/fs/dquot.c
--- linux-2.4.20/fs/dquot.c	Tue Sep  3 22:49:36 2002
+++ linux-2.4.20-1-ext3deadlock/fs/dquot.c	Tue Apr 15 00:13:35 2003
@@ -61,6 +61,7 @@
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
+#include <linux/module.h>
 
 #include <asm/uaccess.h>
 
@@ -261,7 +262,7 @@
 /*
  *	We don't have to be afraid of deadlocks as we never have quotas on quota files...
  */
-static void write_dquot(struct dquot *dquot)
+static int write_dquot(struct dquot *dquot)
 {
 	short type = dquot->dq_type;
 	struct file *filp;
@@ -294,6 +295,7 @@
 	set_fs(fs);
 	up(sem);
 	dqstats.writes++;
+	return 0;
 }
 
 static void read_dquot(struct dquot *dquot)
@@ -381,7 +383,7 @@
 		if (dquot->dq_flags & DQ_LOCKED)
 			wait_on_dquot(dquot);
 		if (dquot->dq_flags & DQ_MOD)
-			write_dquot(dquot);
+			dquot->dq_sb->dq_op->sync_dquot(dquot);
 		dqput(dquot);
 		goto restart;
 	}
@@ -1237,9 +1239,16 @@
 	dquot_alloc_inode,
 	dquot_free_block,
 	dquot_free_inode,
-	dquot_transfer
+	dquot_transfer,
+	write_dquot
 };
 
+/* Function used by filesystems for initializing the dquot_operations structure */
+void init_dquot_operations(struct dquot_operations *fsdqops)
+{
+	memcpy(fsdqops, &dquot_operations, sizeof(dquot_operations));
+}
+
 static inline void set_enable_flags(struct quota_mount_options *dqopt, short type)
 {
 	switch (type) {
@@ -1476,3 +1485,5 @@
 	unlock_kernel();
 	return ret;
 }
+
+EXPORT_SYMBOL(init_dquot_operations);
diff -ruNX /home/jack/.kerndiffexclude linux-2.4.20/fs/ext3/super.c linux-2.4.20-1-ext3deadlock/fs/ext3/super.c
--- linux-2.4.20/fs/ext3/super.c	Wed Jan 22 23:28:57 2003
+++ linux-2.4.20-1-ext3deadlock/fs/ext3/super.c	Tue Apr 15 00:04:35 2003
@@ -446,6 +446,9 @@
 	return;
 }
 
+static struct dquot_operations ext3_qops;
+static int (*old_sync_dquot)(struct dquot *dquot);
+
 static struct super_operations ext3_sops = {
 	read_inode:	ext3_read_inode,	/* BKL held */
 	write_inode:	ext3_write_inode,	/* BKL not held.  Don't need */
@@ -1125,6 +1128,7 @@
 	 * set up enough so that it can read an inode
 	 */
 	sb->s_op = &ext3_sops;
+	sb->dq_op = &ext3_qops;
 	INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
 
 	sb->s_root = 0;
@@ -1757,10 +1761,51 @@
 	return 0;
 }
 
+/* Helper function for writing quotas on sync - we need to start transaction before quota file
+ * is locked for write. Otherwise the are possible deadlocks:
+ * Process 1                         Process 2
+ * ext3_create()                     quota_sync()
+ *   journal_start()                   write_dquot()
+ *   DQUOT_INIT()                        down(dqio_sem)
+ *     down(dqio_sem)                    journal_start()
+ *
+ */
+
+#ifdef CONFIG_QUOTA
+
+#define EXT3_OLD_QFMT_BLOCKS 2
+
+static int ext3_sync_dquot(struct dquot *dquot)
+{
+	int ret;
+	handle_t *handle;
+	struct inode *qinode;
+
+	lock_kernel();
+	qinode = dquot->dq_sb->s_dquot.files[dquot->dq_type]->f_dentry->d_inode;
+	handle = ext3_journal_start(qinode, EXT3_OLD_QFMT_BLOCKS);
+	if (IS_ERR(handle)) {
+		unlock_kernel();
+		return PTR_ERR(handle);
+	}
+	unlock_kernel();
+	ret = old_sync_dquot(dquot);
+	lock_kernel();
+	ret = ext3_journal_stop(handle, qinode);
+	unlock_kernel();
+	return ret;
+}
+#endif
+
 static DECLARE_FSTYPE_DEV(ext3_fs_type, "ext3", ext3_read_super);
 
 static int __init init_ext3_fs(void)
 {
+#ifdef CONFIG_QUOTA
+	init_dquot_operations(&ext3_qops);
+	old_sync_dquot = ext3_qops.sync_dquot;
+	ext3_qops.sync_dquot = ext3_sync_dquot;
+#endif
         return register_filesystem(&ext3_fs_type);
 }
 
diff -ruNX /home/jack/.kerndiffexclude linux-2.4.20/include/linux/fs.h linux-2.4.20-1-ext3deadlock/include/linux/fs.h
--- linux-2.4.20/include/linux/fs.h	Wed Jan 22 23:29:11 2003
+++ linux-2.4.20-1-ext3deadlock/include/linux/fs.h	Mon Apr 14 23:46:40 2003
@@ -962,6 +962,7 @@
 	void (*free_block) (struct inode *, unsigned long);
 	void (*free_inode) (const struct inode *, unsigned long);
 	int (*transfer) (struct inode *, struct iattr *);
+	int (*sync_dquot) (struct dquot *);
 };
 
 struct file_system_type {
diff -ruNX /home/jack/.kerndiffexclude linux-2.4.20/include/linux/quota.h linux-2.4.20-1-ext3deadlock/include/linux/quota.h
--- linux-2.4.20/include/linux/quota.h	Sun Sep 15 14:17:58 2002
+++ linux-2.4.20-1-ext3deadlock/include/linux/quota.h	Mon Apr 14 23:45:49 2003
@@ -187,6 +187,9 @@
 #define QUOTA_OK          0
 #define NO_QUOTA          1
 
+struct dquot_operations;
+void init_dquot_operations(struct dquot_operations *fsdqops);
+
 #else
 
 # /* nodep */ include <sys/cdefs.h>
