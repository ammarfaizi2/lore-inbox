Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVBIJXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVBIJXv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 04:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVBIJXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 04:23:51 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54683 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261613AbVBIJX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 04:23:28 -0500
Date: Wed, 9 Feb 2005 10:23:26 +0100
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Update locking doc
Message-ID: <20050209092326.GC27328@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello Andrew!

  Attached patch updates documentation in
Documentation/filesystems/Locking to match the current state of quota
code. Also a few comments in quota code are updated. Please apply.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.6.11-rc2-docupdate.diff"

Updated locking documentation with new information about quota code.
Added a few comments.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -ruX /home/jack/.kerndiffexclude linux-2.6.11-rc2/Documentation/filesystems/Locking linux-2.6.11-rc2-docupdate/Documentation/filesystems/Locking
--- linux-2.6.11-rc2/Documentation/filesystems/Locking	2005-01-27 12:55:49.000000000 +0100
+++ linux-2.6.11-rc2-docupdate/Documentation/filesystems/Locking	2005-02-06 17:21:58.000000000 +0100
@@ -104,6 +104,8 @@
 	void (*clear_inode) (struct inode *);
 	void (*umount_begin) (struct super_block *);
 	int (*show_options)(struct seq_file *, struct vfsmount *);
+	ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
+	ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
 
 locking rules:
 	All may block.
@@ -126,10 +128,17 @@
 clear_inode:		no
 umount_begin:		yes	no	no
 show_options:		no				(vfsmount->sem)
+quota_read:		no	no	no		(see below)
+quota_write:		no	no	no		(see below)
 
 ->read_inode() is not a method - it's a callback used in iget().
 ->remount_fs() will have the s_umount lock if it's already mounted.
 When called from get_sb_single, it does NOT have the s_umount lock.
+->quota_read() and ->quota_write() functions are both guaranteed to
+be the only ones operating on the quota file by the quota code (via
+dqio_sem) (unless an admin really wants to screw up something and
+writes to quota files with quotas on). For other details about locking
+see also dquot_operations section.
 
 --------------------------- file_system_type ---------------------------
 prototypes:
@@ -442,23 +451,46 @@
 
 --------------------------- dquot_operations -------------------------------
 prototypes:
-	void (*initialize) (struct inode *, short);
-	void (*drop) (struct inode *);
-	int (*alloc_block) (const struct inode *, unsigned long, char);
+	int (*initialize) (struct inode *, int);
+	int (*drop) (struct inode *);
+	int (*alloc_space) (struct inode *, qsize_t, int);
 	int (*alloc_inode) (const struct inode *, unsigned long);
-	void (*free_block) (const struct inode *, unsigned long);
-	void (*free_inode) (const struct inode *, unsigned long);
-	int (*transfer) (struct dentry *, struct iattr *);
+	int (*free_space) (struct inode *, qsize_t);
+	int (*free_inode) (const struct inode *, unsigned long);
+	int (*transfer) (struct inode *, struct iattr *);
+	int (*write_dquot) (struct dquot *);
+	int (*acquire_dquot) (struct dquot *);
+	int (*release_dquot) (struct dquot *);
+	int (*mark_dirty) (struct dquot *);
+	int (*write_info) (struct super_block *, int);
+
+These operations are intended to be more or less wrapping functions that ensure
+a proper locking wrt the filesystem and call the generic quota operations.
+
+What filesystem should expect from the generic quota functions:
+
+		FS recursion	Held locks when called
+initialize:	yes		maybe dqonoff_sem
+drop:		yes		-
+alloc_space:	->mark_dirty()	-
+alloc_inode:	->mark_dirty()	-
+free_space:	->mark_dirty()	-
+free_inode:	->mark_dirty()	-
+transfer:	yes		-
+write_dquot:	yes		dqonoff_sem or dqptr_sem
+acquire_dquot:	yes		dqonoff_sem or dqptr_sem
+release_dquot:	yes		dqonoff_sem or dqptr_sem
+mark_dirty:	no		-
+write_info:	yes		dqonoff_sem 
+
+FS recursion means calling ->quota_read() and ->quota_write() from superblock
+operations.
+
+->alloc_space(), ->alloc_inode(), ->free_space(), ->free_inode() are called
+only directly by the filesystem and do not call any fs functions only
+the ->mark_dirty() operation.
 
-locking rules:
-		BKL
-initialize:	no
-drop:		no
-alloc_block:	yes
-alloc_inode:	yes
-free_block:	yes
-free_inode:	yes
-transfer:	no
+More details about quota locking can be found in fs/dquot.c.
 
 --------------------------- vm_operations_struct -----------------------------
 prototypes:
diff -ruX /home/jack/.kerndiffexclude linux-2.6.11-rc2/fs/dquot.c linux-2.6.11-rc2-docupdate/fs/dquot.c
--- linux-2.6.11-rc2/fs/dquot.c	2005-01-27 12:56:25.000000000 +0100
+++ linux-2.6.11-rc2-docupdate/fs/dquot.c	2005-02-06 16:45:59.000000000 +0100
@@ -1092,7 +1092,7 @@
 }
 
 /*
- * This is a non-blocking operation.
+ * This operation can block, but only after everything is updated
  */
 int dquot_free_space(struct inode *inode, qsize_t number)
 {
@@ -1128,7 +1128,7 @@
 }
 
 /*
- * This is a non-blocking operation.
+ * This operation can block, but only after everything is updated
  */
 int dquot_free_inode(const struct inode *inode, unsigned long number)
 {
@@ -1163,6 +1163,7 @@
  * Transfer the number of inode and blocks from one diskquota to an other.
  *
  * This operation can block, but only after everything is updated
+ * A transaction must be started when entering this function.
  */
 int dquot_transfer(struct inode *inode, struct iattr *iattr)
 {

--s9fJI615cBHmzTOP--
