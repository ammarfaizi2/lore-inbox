Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311458AbSCNArh>; Wed, 13 Mar 2002 19:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311460AbSCNAr2>; Wed, 13 Mar 2002 19:47:28 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:57272 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S311458AbSCNArM>; Wed, 13 Mar 2002 19:47:12 -0500
Message-ID: <3C8FF2F5.4060100@didntduck.org>
Date: Wed, 13 Mar 2002 19:46:45 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] struct super_block cleanup - shmfs
Content-Type: multipart/mixed;
 boundary="------------000001000803010704080600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000001000803010704080600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Seperates shmem_sb_info from struct super_block.

-- 

						Brian Gerst

--------------000001000803010704080600
Content-Type: text/plain;
 name="sb-shmem-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-shmem-1"

diff -urN linux-2.5.7-pre1/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.5.7-pre1/include/linux/fs.h	Tue Mar 12 22:44:13 2002
+++ linux/include/linux/fs.h	Wed Mar 13 19:33:09 2002
@@ -474,7 +474,6 @@
 	return &list_entry(socket, struct socket_alloc, socket)->vfs_inode;
 }
 
-#include <linux/shmem_fs.h>
 /* will die */
 #include <linux/coda_fs_i.h>
 #include <linux/ext3_fs_i.h>
@@ -715,7 +714,6 @@
 		struct affs_sb_info	affs_sb;
 		struct ufs_sb_info	ufs_sb;
 		struct efs_sb_info	efs_sb;
-		struct shmem_sb_info	shmem_sb;
 		struct romfs_sb_info	romfs_sb;
 		struct smb_sb_info	smbfs_sb;
 		struct hfs_sb_info	hfs_sb;
diff -urN linux-2.5.7-pre1/ipc/shm.c linux/ipc/shm.c
--- linux-2.5.7-pre1/ipc/shm.c	Thu Mar  7 21:18:32 2002
+++ linux/ipc/shm.c	Wed Mar 13 19:20:49 2002
@@ -23,6 +23,7 @@
 #include <linux/file.h>
 #include <linux/mman.h>
 #include <linux/proc_fs.h>
+#include <linux/shmem_fs.h>
 #include <asm/uaccess.h>
 
 #include "util.h"
diff -urN linux-2.5.7-pre1/mm/shmem.c linux/mm/shmem.c
--- linux-2.5.7-pre1/mm/shmem.c	Tue Mar 12 22:44:13 2002
+++ linux/mm/shmem.c	Wed Mar 13 19:15:15 2002
@@ -28,6 +28,7 @@
 #include <linux/locks.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
+#include <linux/shmem_fs.h>
 
 #include <asm/uaccess.h>
 
@@ -36,7 +37,10 @@
 
 #define ENTRIES_PER_PAGE (PAGE_CACHE_SIZE/sizeof(unsigned long))
 
-#define SHMEM_SB(sb) (&sb->u.shmem_sb)
+static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
+{
+	return sb->u.generic_sbp;
+}
 
 static struct super_operations shmem_ops;
 static struct address_space_operations shmem_aops;
@@ -1255,7 +1259,7 @@
 
 static int shmem_remount_fs (struct super_block *sb, int *flags, char *data)
 {
-	struct shmem_sb_info *sbinfo = &sb->u.shmem_sb;
+	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 	unsigned long max_blocks = sbinfo->max_blocks;
 	unsigned long max_inodes = sbinfo->max_inodes;
 
@@ -1276,8 +1280,15 @@
 	struct dentry * root;
 	unsigned long blocks, inodes;
 	int mode   = S_IRWXUGO | S_ISVTX;
-	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
+	struct shmem_sb_info *sbinfo;
 	struct sysinfo si;
+	int err;
+
+	sbinfo = kmalloc(sizeof(struct shmem_sb_info), GFP_KERNEL);
+	if (!sbinfo)
+		return -ENOMEM;
+	sb->u.generic_sbp = sbinfo;
+	memset(sbinfo, 0, sizeof(struct shmem_sb_info));
 
 	/*
 	 * Per default we only allow half of the physical ram per
@@ -1289,7 +1300,8 @@
 #ifdef CONFIG_TMPFS
 	if (shmem_parse_options (data, &mode, &blocks, &inodes)) {
 		printk(KERN_ERR "tmpfs invalid option\n");
-		return -EINVAL;
+		err = -EINVAL;
+		goto out_sbinfo;
 	}
 #endif
 
@@ -1304,16 +1316,30 @@
 	sb->s_magic = TMPFS_MAGIC;
 	sb->s_op = &shmem_ops;
 	inode = shmem_get_inode(sb, S_IFDIR | mode, 0);
-	if (!inode)
-		return -ENOMEM;
+	if (!inode) {
+		err = -ENOMEM;
+		goto out_sbinfo;
+	}
 
 	root = d_alloc_root(inode);
 	if (!root) {
-		iput(inode);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto out_iput;
 	}
 	sb->s_root = root;
 	return 0;
+out_iput:
+	iput(inode);
+out_sbinfo:
+	sb->u.generic_sbp = NULL;
+	kfree(sbinfo);
+	return err;
+}
+
+static void shmem_put_super(struct super_block *sb)
+{
+	kfree(sb->u.generic_sbp);
+	sb->u.generic_sbp = NULL;
 }
 
 static kmem_cache_t * shmem_inode_cachep;
@@ -1407,6 +1433,7 @@
 #endif
 	delete_inode:	shmem_delete_inode,
 	put_inode:	force_delete,	
+	put_super:	shmem_put_super,
 };
 
 static struct vm_operations_struct shmem_vm_ops = {

--------------000001000803010704080600--

