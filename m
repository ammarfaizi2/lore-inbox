Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424055AbWKIPZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424055AbWKIPZP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424052AbWKIPYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:24:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63190 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1424047AbWKIPYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:24:50 -0500
Subject: [PATCH 1/3] new_inode_autonum: add per-sb lastino counter and add
	new_inode_autonum function that guarantees i_ino uniqueness
From: Jeff Layton <jlayton@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Date: Thu, 09 Nov 2006 10:24:39 -0500
Message-Id: <1163085879.21469.45.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- add a new per superblock s_nextino counter and change iunique to use it
  instead of its global inode counter
- make the size of the counter conditional on CONFIG_COMPAT. This is to try
  prevent userspace EOVERFLOWs when 32-bit programs not compiled with large
  offsets are run on 64-bit kernels
- add new_inode_autonum which guarantees that i_ino is assigned a unique val
  on the filesystem.
- Change new_inode to assign i_ino to 0 to catch filesystems that use it and
  don't reset it to a unique value.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
Acked-by: Joern Engel <joern@wh.fh-wedel.de>

diff --git a/fs/inode.c b/fs/inode.c
index 26cdb11..cbe466f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -517,14 +517,14 @@ repeat:
 }
 
 /**
- *	new_inode 	- obtain an inode
+ *	__new_inode 	- obtain an inode
  *	@sb: superblock
+ *      @autonum: if true, make sure that i_ino is unique
  *
  *	Allocates a new inode for given superblock.
  */
-struct inode *new_inode(struct super_block *sb)
+static struct inode *__new_inode(struct super_block *sb)
 {
-	static unsigned long last_ino;
 	struct inode * inode;
 
 	spin_lock_prefetch(&inode_lock);
@@ -535,13 +535,46 @@ struct inode *new_inode(struct super_blo
 		inodes_stat.nr_inodes++;
 		list_add(&inode->i_list, &inode_in_use);
 		list_add(&inode->i_sb_list, &sb->s_inodes);
-		inode->i_ino = ++last_ino;
 		inode->i_state = 0;
 		spin_unlock(&inode_lock);
 	}
 	return inode;
 }
 
+/**
+ *	new_inode_autonum 	- obtain an inode with a unique i_ino value
+ *	@sb: superblock
+ *
+ *	Allocates a new inode for given superblock. Ensures that i_ino is
+ *	unique on the filesystem.
+ */
+struct inode *new_inode_autonum(struct super_block *sb)
+{
+	struct inode *inode;
+
+	inode = __new_inode(sb);
+	inode->i_ino = iunique(sb, 0);
+	return inode;
+}
+
+EXPORT_SYMBOL(new_inode_autonum);
+
+/**
+ *	new_inode 	- obtain an inode -- i_ino not guaranteed unique
+ *	@sb: superblock
+ *
+ *	Allocates a new inode for given superblock. i_ino is not guaranteed to
+ *	be unique. Should only be used when i_ino is going to be clobbered.
+ */
+struct inode *new_inode(struct super_block *sb)
+{
+	struct inode *inode;
+
+	inode = __new_inode(sb);
+	inode->i_ino = 0; /* 0 to try to catch callers that don't reset it */
+	return inode;
+}
+
 EXPORT_SYMBOL(new_inode);
 
 void unlock_new_inode(struct inode *inode)
@@ -683,22 +716,21 @@ static unsigned long hash(struct super_b
  */
 ino_t iunique(struct super_block *sb, ino_t max_reserved)
 {
-	static ino_t counter;
 	struct inode *inode;
 	struct hlist_head * head;
 	ino_t res;
 	spin_lock(&inode_lock);
 retry:
-	if (counter > max_reserved) {
-		head = inode_hashtable + hash(sb,counter);
-		res = counter++;
+	if (sb->s_nextino > max_reserved) {
+		head = inode_hashtable + hash(sb,sb->s_nextino);
+		res = sb->s_nextino++;
 		inode = find_inode_fast(sb, head, res);
 		if (!inode) {
 			spin_unlock(&inode_lock);
 			return res;
 		}
 	} else {
-		counter = max_reserved + 1;
+		sb->s_nextino = max_reserved + 1;
 	}
 	goto retry;
 	
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2fe6e3f..3dd0e0f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -961,6 +961,14 @@ #endif
 	/* Granularity of c/m/atime in ns.
 	   Cannot be worse than a second */
 	u32		   s_time_gran;
+
+	/* per-sb inode counter for new_inode. Make it a 32-bit counter when
+	   we have the possibility of dealing with 32-bit apps */
+#ifdef CONFIG_COMPAT
+	unsigned int		s_nextino;
+#else
+	unsigned long		s_nextino;
+#endif
 };
 
 extern struct timespec current_fs_time(struct super_block *sb);
@@ -1712,6 +1720,7 @@ extern void __iget(struct inode * inode)
 extern void clear_inode(struct inode *);
 extern void destroy_inode(struct inode *);
 extern struct inode *new_inode(struct super_block *);
+extern struct inode *new_inode_autonum(struct super_block *);
 extern int __remove_suid(struct dentry *, int);
 extern int should_remove_suid(struct dentry *);
 extern int remove_suid(struct dentry *);


