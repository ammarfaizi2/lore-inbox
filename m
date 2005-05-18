Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVERN7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVERN7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 09:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVERN7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 09:59:02 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:55516 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262201AbVERNxs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 09:53:48 -0400
Subject: [RFC/PATCH 3/5] ext2: execute in place (V2)
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: cotte@freenet.de
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com, akpm@osdl.org
In-Reply-To: <1116422644.2202.1.camel@cotte.boeblingen.de.ibm.com>
References: <1116422644.2202.1.camel@cotte.boeblingen.de.ibm.com>
Content-Type: text/plain
Organization: IBM Deutschland Entwicklung
Date: Wed, 18 May 2005 15:53:43 +0200
Message-Id: <1116424424.2202.18.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[RFC/PATCH 3/5] ext2: execute in place (V2)
This patch adds support for execute in place in ext2. I've chosen this
filesystem because it is simple enough for me stupido to understand,
and well written. Afaics, other filesystems could be changed similar.
A new config option EXT2_FS_XIP is used to switch execute in place
support on/off. If turned on, a new mount option -o xip is available.
If ext2 is used with a block device that does support the
direct_access block device operation, and -o xip is used, ext2 does
provide different address space operations for regular files:
ext2_aops_xip, that do implement get_xip_page but not
readpage(s)/writepage(s).

This patch is fixed now, previous version did not build without
CONFIG_EXT2_FS_XIP.

Signed-off-by: Carsten Otte <cotte@de.ibm.com>
--- 
diff -ruN linux-git/fs/Kconfig linux-git-xip/fs/Kconfig
--- linux-git/fs/Kconfig	2005-05-17 14:23:26.000000000 +0200
+++ linux-git-xip/fs/Kconfig	2005-05-17 18:44:32.037031680 +0200
@@ -50,6 +50,23 @@
 	  If you are not using a security module that requires using
 	  extended attributes for file security labels, say N.
 
+config EXT2_FS_XIP
+	bool "Ext2 execute in place support"
+	depends on EXT2_FS
+	help
+	  Execute in place can be used on memory-backed block devices. If you
+	  enable this option, you can select to mount block devices which are
+	  capable of this feature without using the page cache.
+
+	  If you do not use a block device that is capable of using this, 
+	  or if unsure, say N.
+
+config FS_XIP
+# execute in place
+	bool
+	depends on EXT2_FS_XIP
+	default y
+
 config EXT3_FS
 	tristate "Ext3 journalling file system support"
 	help
diff -ruN linux-git/fs/ext2/Makefile linux-git-xip/fs/ext2/Makefile
--- linux-git/fs/ext2/Makefile	2005-05-17 14:23:29.000000000 +0200
+++ linux-git-xip/fs/ext2/Makefile	2005-05-17 18:44:32.113020128 +0200
@@ -10,3 +10,4 @@
 ext2-$(CONFIG_EXT2_FS_XATTR)	 += xattr.o xattr_user.o xattr_trusted.o
 ext2-$(CONFIG_EXT2_FS_POSIX_ACL) += acl.o
 ext2-$(CONFIG_EXT2_FS_SECURITY)	 += xattr_security.o
+ext2-$(CONFIG_EXT2_FS_XIP)	 += xip.o
diff -ruN linux-git/fs/ext2/ext2.h linux-git-xip/fs/ext2/ext2.h
--- linux-git/fs/ext2/ext2.h	2005-05-17 14:23:29.000000000 +0200
+++ linux-git-xip/fs/ext2/ext2.h	2005-05-17 18:44:32.180009944 +0200
@@ -150,6 +150,7 @@
 
 /* inode.c */
 extern struct address_space_operations ext2_aops;
+extern struct address_space_operations ext2_aops_xip;
 extern struct address_space_operations ext2_nobh_aops;
 
 /* namei.c */
diff -ruN linux-git/fs/ext2/inode.c linux-git-xip/fs/ext2/inode.c
--- linux-git/fs/ext2/inode.c	2005-05-17 14:23:29.000000000 +0200
+++ linux-git-xip/fs/ext2/inode.c	2005-05-17 18:44:32.182009640 +0200
@@ -33,6 +33,7 @@
 #include <linux/mpage.h>
 #include "ext2.h"
 #include "acl.h"
+#include "xip.h"
 
 MODULE_AUTHOR("Remy Card and others");
 MODULE_DESCRIPTION("Second Extended Filesystem");
@@ -594,6 +595,16 @@
 	if (err)
 		goto cleanup;
 
+	if (ext2_use_xip(inode->i_sb)) {
+		/*
+		 * we need to clear the block
+		 */
+		err = ext2_clear_xip_target (inode,
+			le32_to_cpu(chain[depth-1].key));
+		if (err)
+			goto cleanup;
+	}
+
 	if (ext2_splice_branch(inode, iblock, chain, partial, left) < 0)
 		goto changed;
 
@@ -691,6 +702,11 @@
 	.writepages		= ext2_writepages,
 };
 
+struct address_space_operations ext2_aops_xip = {
+	.bmap			= ext2_bmap,
+	.get_xip_page		= ext2_get_xip_page,
+};
+
 struct address_space_operations ext2_nobh_aops = {
 	.readpage		= ext2_readpage,
 	.readpages		= ext2_readpages,
@@ -910,7 +926,9 @@
 	iblock = (inode->i_size + blocksize-1)
 					>> EXT2_BLOCK_SIZE_BITS(inode->i_sb);
 
-	if (test_opt(inode->i_sb, NOBH))
+	if (mapping_is_xip(inode->i_mapping))
+		xip_truncate_page(inode->i_mapping, inode->i_size);
+	else if (test_opt(inode->i_sb, NOBH))
 		nobh_truncate_page(inode->i_mapping, inode->i_size);
 	else
 		block_truncate_page(inode->i_mapping,
@@ -1111,7 +1129,9 @@
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &ext2_file_inode_operations;
 		inode->i_fop = &ext2_file_operations;
-		if (test_opt(inode->i_sb, NOBH))
+		if (ext2_use_xip(inode->i_sb))
+			inode->i_mapping->a_ops = &ext2_aops_xip;
+		else if (test_opt(inode->i_sb, NOBH))
 			inode->i_mapping->a_ops = &ext2_nobh_aops;
 		else
 			inode->i_mapping->a_ops = &ext2_aops;
diff -ruN linux-git/fs/ext2/namei.c linux-git-xip/fs/ext2/namei.c
--- linux-git/fs/ext2/namei.c	2005-05-17 14:23:29.000000000 +0200
+++ linux-git-xip/fs/ext2/namei.c	2005-05-17 18:44:32.183009488 +0200
@@ -34,6 +34,7 @@
 #include "ext2.h"
 #include "xattr.h"
 #include "acl.h"
+#include "xip.h"
 
 /*
  * Couple of helper functions - make the code slightly cleaner.
@@ -128,7 +129,9 @@
 	if (!IS_ERR(inode)) {
 		inode->i_op = &ext2_file_inode_operations;
 		inode->i_fop = &ext2_file_operations;
-		if (test_opt(inode->i_sb, NOBH))
+		if (ext2_use_xip(inode->i_sb))
+			inode->i_mapping->a_ops = &ext2_aops_xip;
+		else if (test_opt(inode->i_sb, NOBH))
 			inode->i_mapping->a_ops = &ext2_nobh_aops;
 		else
 			inode->i_mapping->a_ops = &ext2_aops;
diff -ruN linux-git/fs/ext2/super.c linux-git-xip/fs/ext2/super.c
--- linux-git/fs/ext2/super.c	2005-05-17 14:23:29.000000000 +0200
+++ linux-git-xip/fs/ext2/super.c	2005-05-17 18:44:32.185009184 +0200
@@ -31,6 +31,7 @@
 #include "ext2.h"
 #include "xattr.h"
 #include "acl.h"
+#include "xip.h"
 
 static void ext2_sync_super(struct super_block *sb,
 			    struct ext2_super_block *es);
@@ -257,7 +258,7 @@
 	Opt_bsd_df, Opt_minix_df, Opt_grpid, Opt_nogrpid,
 	Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont, Opt_err_panic, Opt_err_ro,
 	Opt_nouid32, Opt_check, Opt_nocheck, Opt_debug, Opt_oldalloc, Opt_orlov, Opt_nobh,
-	Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl,
+	Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl, Opt_xip,
 	Opt_ignore, Opt_err,
 };
 
@@ -286,6 +287,7 @@
 	{Opt_nouser_xattr, "nouser_xattr"},
 	{Opt_acl, "acl"},
 	{Opt_noacl, "noacl"},
+	{Opt_xip, "xip"},
 	{Opt_ignore, "grpquota"},
 	{Opt_ignore, "noquota"},
 	{Opt_ignore, "quota"},
@@ -397,6 +399,13 @@
 			printk("EXT2 (no)acl options not supported\n");
 			break;
 #endif
+		case Opt_xip:
+#ifdef CONFIG_EXT2_FS_XIP
+			set_opt (sbi->s_mount_opt, XIP);
+#else
+			printk("EXT2 xip option not supported\n");
+#endif
+			break;
 		case Opt_ignore:
 			break;
 		default:
@@ -640,6 +649,9 @@
 		((EXT2_SB(sb)->s_mount_opt & EXT2_MOUNT_POSIX_ACL) ?
 		 MS_POSIXACL : 0);
 
+	ext2_xip_verify_sb(sb); /* see if bdev supports xip, unset
+				    EXT2_MOUNT_XIP if not */
+
 	if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV &&
 	    (EXT2_HAS_COMPAT_FEATURE(sb, ~0U) ||
 	     EXT2_HAS_RO_COMPAT_FEATURE(sb, ~0U) ||
@@ -668,6 +680,13 @@
 
 	blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
 
+	if ((ext2_use_xip(sb)) && ((blocksize != PAGE_SIZE) ||
+				  (sb->s_blocksize != blocksize))) {
+		if (!silent)
+			printk("XIP: Unsupported blocksize\n");
+		goto failed_mount;
+	}
+
 	/* If the blocksize doesn't match, re-read the thing.. */
 	if (sb->s_blocksize != blocksize) {
 		brelse(bh);
@@ -916,6 +935,7 @@
 {
 	struct ext2_sb_info * sbi = EXT2_SB(sb);
 	struct ext2_super_block * es;
+	unsigned long old_mount_opt = sbi->s_mount_opt;
 
 	/*
 	 * Allow the "check" option to be passed as a remount option.
@@ -927,6 +947,11 @@
 		((sbi->s_mount_opt & EXT2_MOUNT_POSIX_ACL) ? MS_POSIXACL : 0);
 
 	es = sbi->s_es;
+	if (((sbi->s_mount_opt & EXT2_MOUNT_XIP) != 
+	    (old_mount_opt & EXT2_MOUNT_XIP)) &&
+	    invalidate_inodes(sb))
+		ext2_warning(sb, __FUNCTION__, "busy inodes while remounting "\
+			     "xip remain in cache (no functional problem)");
 	if ((*flags & MS_RDONLY) == (sb->s_flags & MS_RDONLY))
 		return 0;
 	if (*flags & MS_RDONLY) {
diff -ruN linux-git/fs/ext2/xip.c linux-git-xip/fs/ext2/xip.c
--- linux-git/fs/ext2/xip.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-git-xip/fs/ext2/xip.c	2005-05-17 18:44:32.186009032 +0200
@@ -0,0 +1,80 @@
+/*
+ *  linux/fs/ext2/xip.c
+ *
+ * Copyright (C) 2005 IBM Corporation
+ * Author: Carsten Otte (cotte@de.ibm.com)
+ */
+
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/genhd.h>
+#include <linux/buffer_head.h>
+#include <linux/ext2_fs_sb.h>
+#include <linux/ext2_fs.h>
+#include "ext2.h"
+#include "xip.h"
+
+static inline int
+__inode_direct_access(struct inode *inode, sector_t sector, unsigned long *data) {
+	BUG_ON(!inode->i_sb->s_bdev->bd_disk->fops->direct_access);
+	return inode->i_sb->s_bdev->bd_disk->fops
+		->direct_access(inode,sector,data);
+}
+
+int
+ext2_clear_xip_target(struct inode *inode, int block) {
+	sector_t sector = block*(PAGE_SIZE/512);
+	unsigned long data;
+	int rc;
+
+	rc = __inode_direct_access(inode, sector, &data);
+	if (rc)
+		return rc;
+	clear_page((void*)data);
+	return 0;
+}
+
+void ext2_xip_verify_sb(struct super_block *sb)
+{
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
+	
+	if ((sbi->s_mount_opt & EXT2_MOUNT_XIP)) {
+		if ((sb->s_bdev == NULL) ||
+			sb->s_bdev->bd_disk == NULL ||
+			sb->s_bdev->bd_disk->fops == NULL ||
+			sb->s_bdev->bd_disk->fops->direct_access == NULL) {
+			sbi->s_mount_opt &= (~EXT2_MOUNT_XIP);
+			ext2_warning(sb, __FUNCTION__,
+				"ignoring xip option - not supported by bdev");
+		}
+	}
+}
+
+struct page* 
+ext2_get_xip_page(struct address_space *mapping, sector_t blockno,
+		   int create)
+{
+	int rc;
+	unsigned long data;
+	struct buffer_head tmp;
+
+	tmp.b_state = 0;
+	tmp.b_blocknr = 0;
+	rc = ext2_get_block(mapping->host, blockno/(PAGE_SIZE/512) , &tmp,
+				create);
+	if (rc)
+		return ERR_PTR(rc);
+	if (tmp.b_blocknr == 0) {
+		/* SPARSE block */
+		BUG_ON(create);
+		return ERR_PTR(-ENODATA);
+	}
+
+	rc = __inode_direct_access
+		(mapping->host,tmp.b_blocknr*(PAGE_SIZE/512) ,&data);
+	if (rc)
+		return ERR_PTR(rc);
+
+	SetPageUptodate(virt_to_page(data));
+	return virt_to_page(data);
+}
diff -ruN linux-git/fs/ext2/xip.h linux-git-xip/fs/ext2/xip.h
--- linux-git/fs/ext2/xip.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-git-xip/fs/ext2/xip.h	2005-05-17 18:44:32.186009032 +0200
@@ -0,0 +1,25 @@
+/*
+ *  linux/fs/ext2/xip.h
+ *
+ * Copyright (C) 2005 IBM Corporation
+ * Author: Carsten Otte (cotte@de.ibm.com)
+ */
+
+#ifdef CONFIG_EXT2_FS_XIP
+extern void ext2_xip_verify_sb (struct super_block *);
+extern int ext2_clear_xip_target (struct inode *, int);
+
+static inline int ext2_use_xip (struct super_block *sb)
+{
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
+	return (sbi->s_mount_opt & EXT2_MOUNT_XIP);
+}
+struct page* ext2_get_xip_page (struct address_space *, sector_t, int);
+#define mapping_is_xip(map) unlikely(map->a_ops->get_xip_page)
+#else
+#define mapping_is_xip(map) 0
+#define ext2_xip_verify_sb(sb)              do { } while (0)
+#define ext2_use_xip(sb)	            0
+#define ext2_clear_xip_target(inode, chain) 0
+#define ext2_get_xip_page                   NULL
+#endif
diff -ruN linux-git/include/linux/ext2_fs.h linux-git-xip/include/linux/ext2_fs.h
--- linux-git/include/linux/ext2_fs.h	2005-05-17 14:23:35.000000000 +0200
+++ linux-git-xip/include/linux/ext2_fs.h	2005-05-17 18:44:32.195007664 +0200
@@ -300,18 +300,19 @@
 /*
  * Mount flags
  */
-#define EXT2_MOUNT_CHECK		0x0001	/* Do mount-time checks */
-#define EXT2_MOUNT_OLDALLOC		0x0002  /* Don't use the new Orlov allocator */
-#define EXT2_MOUNT_GRPID		0x0004	/* Create files with directory's group */
-#define EXT2_MOUNT_DEBUG		0x0008	/* Some debugging messages */
-#define EXT2_MOUNT_ERRORS_CONT		0x0010	/* Continue on errors */
-#define EXT2_MOUNT_ERRORS_RO		0x0020	/* Remount fs ro on errors */
-#define EXT2_MOUNT_ERRORS_PANIC		0x0040	/* Panic on errors */
-#define EXT2_MOUNT_MINIX_DF		0x0080	/* Mimics the Minix statfs */
-#define EXT2_MOUNT_NOBH			0x0100	/* No buffer_heads */
-#define EXT2_MOUNT_NO_UID32		0x0200  /* Disable 32-bit UIDs */
-#define EXT2_MOUNT_XATTR_USER		0x4000	/* Extended user attributes */
-#define EXT2_MOUNT_POSIX_ACL		0x8000	/* POSIX Access Control Lists */
+#define EXT2_MOUNT_CHECK		0x000001  /* Do mount-time checks */
+#define EXT2_MOUNT_OLDALLOC		0x000002  /* Don't use the new Orlov allocator */
+#define EXT2_MOUNT_GRPID		0x000004  /* Create files with directory's group */
+#define EXT2_MOUNT_DEBUG		0x000008  /* Some debugging messages */
+#define EXT2_MOUNT_ERRORS_CONT		0x000010  /* Continue on errors */
+#define EXT2_MOUNT_ERRORS_RO		0x000020  /* Remount fs ro on errors */
+#define EXT2_MOUNT_ERRORS_PANIC		0x000040  /* Panic on errors */
+#define EXT2_MOUNT_MINIX_DF		0x000080  /* Mimics the Minix statfs */
+#define EXT2_MOUNT_NOBH			0x000100  /* No buffer_heads */
+#define EXT2_MOUNT_NO_UID32		0x000200  /* Disable 32-bit UIDs */
+#define EXT2_MOUNT_XATTR_USER		0x004000  /* Extended user attributes */
+#define EXT2_MOUNT_POSIX_ACL		0x008000  /* POSIX Access Control Lists */
+#define EXT2_MOUNT_XIP			0x010000  /* Execute in place */
 
 #define clear_opt(o, opt)		o &= ~EXT2_MOUNT_##opt
 #define set_opt(o, opt)			o |= EXT2_MOUNT_##opt


