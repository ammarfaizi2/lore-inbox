Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266473AbRGCIPJ>; Tue, 3 Jul 2001 04:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266477AbRGCIO7>; Tue, 3 Jul 2001 04:14:59 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:35993 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S266473AbRGCIOw>; Tue, 3 Jul 2001 04:14:52 -0400
From: Christoph Rohland <cr@sap.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch] tmpfs fixes against 2.4.6-pre
Organisation: SAP LinuxLab
Date: 03 Jul 2001 10:14:11 +0200
Message-ID: <m3itha2zvw.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I split up my previous patch into two. Hopefully this is more
acceptable for you or will trigger some comments.

This is the first part:

1) shmem_remount_fs garbles parameters which are not supplied
2) shmem_truncate should check the maximum size else we get ugly
   oopses
3) shmem_file_setup should give an error if the size is too big. So
   the application will fail early. I also cleaned up the error
   handling a bit. 
4) We should recalculate the inode on page allocation. Else we get
   really weird sizes on sparse files.

Please apply
		Christoph

diff -uNr 6-pre8/mm/shmem.c 6-pre8-fix1/mm/shmem.c
--- 6-pre8/mm/shmem.c	Tue Jun 12 09:49:28 2001
+++ 6-pre8-fix1/mm/shmem.c	Tue Jul  3 08:55:20 2001
@@ -3,7 +3,8 @@
  *
  * Copyright (C) 2000 Linus Torvalds.
  *		 2000 Transmeta Corp.
- *		 2000 Christoph Rohland
+ *		 2000-2001 Christoph Rohland
+ *		 2000-2001 SAP AG
  * 
  * This file is released under the GPL.
  */
@@ -33,7 +34,7 @@
 #define TMPFS_MAGIC	0x01021994
 
 #define ENTRIES_PER_PAGE (PAGE_SIZE/sizeof(unsigned long))
-#define NR_SINGLE (ENTRIES_PER_PAGE + SHMEM_NR_DIRECT)
+#define SHMEM_MAX_BLOCKS (SHMEM_NR_DIRECT + ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)
 
 static struct super_operations shmem_ops;
 static struct address_space_operations shmem_aops;
@@ -193,7 +194,14 @@
 	}
 
 out:
-	info->max_index = index;
+	/*
+	 * We have no chance to give an error, so we limit it to max
+	 * size here and the application will fail later
+	 */
+	if (index > SHMEM_MAX_BLOCKS) 
+		info->max_index = SHMEM_MAX_BLOCKS;
+	else
+		info->max_index = index;
 	info->swapped -= freed;
 	shmem_recalc_inode(inode);
 	spin_unlock (&info->lock);
@@ -314,6 +322,7 @@
 		return page;
 	}
 	
+	shmem_recalc_inode(inode);
 	if (entry->val) {
 		unsigned long flags;
 
@@ -1027,6 +1036,8 @@
 	unsigned long max_inodes, inodes;
 	struct shmem_sb_info *info = &sb->u.shmem_sb;
 
+	max_blocks = info->max_blocks;
+	max_inodes = info->max_inodes;
 	if (shmem_parse_options (data, NULL, &max_blocks, &max_inodes))
 		return -EINVAL;
 
@@ -1074,7 +1085,7 @@
 	sb->u.shmem_sb.free_blocks = blocks;
 	sb->u.shmem_sb.max_inodes = inodes;
 	sb->u.shmem_sb.free_inodes = inodes;
-	sb->s_maxbytes = (unsigned long long)(SHMEM_NR_DIRECT + (ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)) << PAGE_CACHE_SHIFT;
+	sb->s_maxbytes = (unsigned long long)SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT;
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = TMPFS_MAGIC;
@@ -1282,9 +1293,11 @@
 	struct qstr this;
 	int vm_enough_memory(long pages);
 
-	error = -ENOMEM;
+	if (size > (unsigned long long) SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT)
+		return ERR_PTR(-EINVAL);
+
 	if (!vm_enough_memory((size) >> PAGE_SHIFT))
-		goto out;
+		return ERR_PTR(-ENOMEM);
 
 	this.name = name;
 	this.len = strlen(name);
@@ -1292,7 +1305,7 @@
 	root = tmpfs_fs_type.kern_mnt->mnt_root;
 	dentry = d_alloc(root, &this);
 	if (!dentry)
-		goto out;
+		return ERR_PTR(-ENOMEM);
 
 	error = -ENFILE;
 	file = get_empty_filp();
@@ -1318,7 +1331,6 @@
 	put_filp(file);
 put_dentry:
 	dput (dentry);
-out:
 	return ERR_PTR(error);	
 }
 /*

