Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422771AbWJPQ3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422771AbWJPQ3U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422757AbWJPQ3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:29:19 -0400
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:33466 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S1422767AbWJPQ2w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:28:52 -0400
Message-Id: <20061016162808.478173000@szeredi.hu>
References: <20061016162709.369579000@szeredi.hu>
User-Agent: quilt/0.45-1
Date: Mon, 16 Oct 2006 18:27:19 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [patch 10/12] fuse: add blksize option
Content-Disposition: inline; filename=fuse_blocksize.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'blksize' option for block device based filesystems.  During
initialization this is used to set the block size on the device and
the super block.  The default block size is 512bytes.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/Documentation/filesystems/fuse.txt
===================================================================
--- linux.orig/Documentation/filesystems/fuse.txt	2006-10-16 16:21:33.000000000 +0200
+++ linux/Documentation/filesystems/fuse.txt	2006-10-16 16:21:38.000000000 +0200
@@ -110,6 +110,11 @@ Mount options
   The default is infinite.  Note that the size of read requests is
   limited anyway to 32 pages (which is 128kbyte on i386).
 
+'blksize=N'
+
+  Set the block size for the filesystem.  The default is 512.  This
+  option is only valid for 'fuseblk' type mounts.
+
 Control filesystem
 ~~~~~~~~~~~~~~~~~~
 
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-10-16 16:21:33.000000000 +0200
+++ linux/fs/fuse/inode.c	2006-10-16 16:21:38.000000000 +0200
@@ -39,6 +39,7 @@ struct fuse_mount_data {
 	unsigned group_id_present : 1;
 	unsigned flags;
 	unsigned max_read;
+	unsigned blksize;
 };
 
 static struct inode *fuse_alloc_inode(struct super_block *sb)
@@ -274,6 +275,7 @@ enum {
 	OPT_DEFAULT_PERMISSIONS,
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
+	OPT_BLKSIZE,
 	OPT_ERR
 };
 
@@ -285,14 +287,16 @@ static match_table_t tokens = {
 	{OPT_DEFAULT_PERMISSIONS,	"default_permissions"},
 	{OPT_ALLOW_OTHER,		"allow_other"},
 	{OPT_MAX_READ,			"max_read=%u"},
+	{OPT_BLKSIZE,			"blksize=%u"},
 	{OPT_ERR,			NULL}
 };
 
-static int parse_fuse_opt(char *opt, struct fuse_mount_data *d)
+static int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev)
 {
 	char *p;
 	memset(d, 0, sizeof(struct fuse_mount_data));
 	d->max_read = ~0;
+	d->blksize = 512;
 
 	while ((p = strsep(&opt, ",")) != NULL) {
 		int token;
@@ -345,6 +349,12 @@ static int parse_fuse_opt(char *opt, str
 			d->max_read = value;
 			break;
 
+		case OPT_BLKSIZE:
+			if (!is_bdev || match_int(&args[0], &value))
+				return 0;
+			d->blksize = value;
+			break;
+
 		default:
 			return 0;
 		}
@@ -500,15 +510,21 @@ static int fuse_fill_super(struct super_
 	struct dentry *root_dentry;
 	struct fuse_req *init_req;
 	int err;
+	int is_bdev = sb->s_bdev != NULL;
 
 	if (sb->s_flags & MS_MANDLOCK)
 		return -EINVAL;
 
-	if (!parse_fuse_opt((char *) data, &d))
+	if (!parse_fuse_opt((char *) data, &d, is_bdev))
 		return -EINVAL;
 
-	sb->s_blocksize = PAGE_CACHE_SIZE;
-	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	if (is_bdev) {
+		if (!sb_set_blocksize(sb, d.blksize))
+			return -EINVAL;
+	} else {
+		sb->s_blocksize = PAGE_CACHE_SIZE;
+		sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	}
 	sb->s_magic = FUSE_SUPER_MAGIC;
 	sb->s_op = &fuse_super_operations;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;

--
