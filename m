Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUD0EvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUD0EvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 00:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbUD0EvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 00:51:08 -0400
Received: from thunk.org ([140.239.227.29]:12715 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S263448AbUD0Eur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 00:50:47 -0400
To: bart@samwel.tk
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Improve laptop mode's block_dump output
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1BIIf0-00010P-Oz@thunk.org>
Date: Mon, 26 Apr 2004 22:49:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch versus 2.6.6-rc2 improves the output produced by 
"echo 1 > /proc/sys/vm/block_dump", in the following ways:

1)  The messages are printed with KERN_DEBUG, so that even if sysklogd
is running, if configured appropriately, it will not need to write to
log files.

2) The inode which is dirtied by a process is now identified more
precisely by inode number and filesystem ID, and by a dcache name if
present.

3) In the generic filesystem sget function, the superblock id (s_id)
is filled in with the filesystem type by default.  Filesystems which
are block-device based will override s_id, but this allows pseudo
filesystems such as tmpfs, procfs, etc. to be identified in (2).

						- Ted



===== drivers/block/ll_rw_blk.c 1.243 vs edited =====
--- 1.243/drivers/block/ll_rw_blk.c	Sun Apr 18 12:13:18 2004
+++ edited/drivers/block/ll_rw_blk.c	Mon Apr 26 21:09:23 2004
@@ -2443,7 +2443,7 @@
 
 	if (unlikely(block_dump)) {
 		char b[BDEVNAME_SIZE];
-		printk("%s(%d): %s block %Lu on %s\n",
+		printk(KERN_DEBUG "%s(%d): %s block %Lu on %s\n",
 			current->comm, current->pid,
 			(rw & WRITE) ? "WRITE" : "READ",
 			(unsigned long long)bio->bi_sector,
===== fs/fs-writeback.c 1.51 vs edited =====
--- 1.51/fs/fs-writeback.c	Mon Apr 12 13:54:44 2004
+++ edited/fs/fs-writeback.c	Mon Apr 26 21:09:25 2004
@@ -75,8 +75,23 @@
 	if ((inode->i_state & flags) == flags)
 		return;
 
-	if (unlikely(block_dump))
-		printk("%s(%d): dirtied file\n", current->comm, current->pid);
+	if (unlikely(block_dump)) {
+		struct dentry *dentry = NULL;
+		const char *name = "?";
+		
+		if (!list_empty(&inode->i_dentry)) {
+			dentry = list_entry(inode->i_dentry.next, 
+					    struct dentry, d_alias);
+			if (dentry && dentry->d_name.name)
+				name = (const char *) dentry->d_name.name;
+		}
+
+		if (inode->i_ino || strcmp(inode->i_sb->s_id, "bdev"))
+			printk(KERN_DEBUG 
+			       "%s(%d): dirtied inode %lu (%s) on %s\n", 
+			       current->comm, current->pid, inode->i_ino,
+			       name, inode->i_sb->s_id);
+	}
 
 	spin_lock(&inode_lock);
 	if ((inode->i_state & flags) != flags) {
===== fs/super.c 1.118 vs edited =====
--- 1.118/fs/super.c	Wed Apr 21 05:13:46 2004
+++ edited/fs/super.c	Mon Apr 26 21:09:26 2004
@@ -266,6 +266,7 @@
 		return ERR_PTR(err);
 	}
 	s->s_type = type;
+	strlcpy(s->s_id, type->name, sizeof(s->s_id));
 	list_add(&s->s_list, super_blocks.prev);
 	list_add(&s->s_instances, &type->fs_supers);
 	spin_unlock(&sb_lock);
