Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311883AbSCOA4H>; Thu, 14 Mar 2002 19:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311884AbSCOAz7>; Thu, 14 Mar 2002 19:55:59 -0500
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:65003 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S311883AbSCOAzv>; Thu, 14 Mar 2002 19:55:51 -0500
Message-ID: <3C914679.9000509@didntduck.org>
Date: Thu, 14 Mar 2002 19:55:21 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] struct super_block cleanup - adfs
Content-Type: multipart/mixed;
 boundary="------------070700080505040809020705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070700080505040809020705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Seperate adfs_sb_info from struct super_block.

-- 

						Brian Gerst

--------------070700080505040809020705
Content-Type: text/plain;
 name="sb-adfs-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-adfs-1"

diff -urN linux-2.5.7-pre1/fs/adfs/adfs.h linux/fs/adfs/adfs.h
--- linux-2.5.7-pre1/fs/adfs/adfs.h	Thu Mar  7 21:18:57 2002
+++ linux/fs/adfs/adfs.h	Thu Mar 14 19:37:16 2002
@@ -130,7 +130,7 @@
 		unsigned int off;
 
 		off = (object_id & 255) - 1;
-		block += off << sb->u.adfs_sb.s_log2sharesize;
+		block += off << ADFS_SB(sb)->s_log2sharesize;
 	}
 
 	return adfs_map_lookup(sb, object_id >> 8, block);
diff -urN linux-2.5.7-pre1/fs/adfs/dir.c linux/fs/adfs/dir.c
--- linux-2.5.7-pre1/fs/adfs/dir.c	Thu Mar  7 21:18:12 2002
+++ linux/fs/adfs/dir.c	Thu Mar 14 19:37:16 2002
@@ -31,7 +31,7 @@
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct super_block *sb = inode->i_sb;
-	struct adfs_dir_ops *ops = sb->u.adfs_sb.s_dir;
+	struct adfs_dir_ops *ops = ADFS_SB(sb)->s_dir;
 	struct object_info obj;
 	struct adfs_dir dir;
 	int ret = 0;
@@ -85,7 +85,7 @@
 {
 	int ret = -EINVAL;
 #ifdef CONFIG_ADFS_FS_RW
-	struct adfs_dir_ops *ops = sb->u.adfs_sb.s_dir;
+	struct adfs_dir_ops *ops = ADFS_SB(sb)->s_dir;
 	struct adfs_dir dir;
 
 	printk(KERN_INFO "adfs_dir_update: object %06X in dir %06X\n",
@@ -139,7 +139,7 @@
 adfs_dir_lookup_byname(struct inode *inode, struct qstr *name, struct object_info *obj)
 {
 	struct super_block *sb = inode->i_sb;
-	struct adfs_dir_ops *ops = sb->u.adfs_sb.s_dir;
+	struct adfs_dir_ops *ops = ADFS_SB(sb)->s_dir;
 	struct adfs_dir dir;
 	int ret;
 
@@ -202,7 +202,7 @@
 static int
 adfs_hash(struct dentry *parent, struct qstr *qstr)
 {
-	const unsigned int name_len = parent->d_sb->u.adfs_sb.s_namelen;
+	const unsigned int name_len = ADFS_SB(parent->d_sb)->s_namelen;
 	const unsigned char *name;
 	unsigned long hash;
 	int i;
diff -urN linux-2.5.7-pre1/fs/adfs/file.c linux/fs/adfs/file.c
--- linux-2.5.7-pre1/fs/adfs/file.c	Thu Mar  7 21:18:16 2002
+++ linux/fs/adfs/file.c	Thu Mar 14 19:51:02 2002
@@ -25,6 +25,7 @@
 #include <linux/fcntl.h>
 #include <linux/time.h>
 #include <linux/stat.h>
+#include <linux/adfs_fs.h>
 
 #include "adfs.h"
 
diff -urN linux-2.5.7-pre1/fs/adfs/inode.c linux/fs/adfs/inode.c
--- linux-2.5.7-pre1/fs/adfs/inode.c	Thu Mar  7 21:18:22 2002
+++ linux/fs/adfs/inode.c	Thu Mar 14 19:51:43 2002
@@ -103,9 +103,10 @@
 {
 	unsigned int filetype, attr = ADFS_I(inode)->attr;
 	umode_t mode, rmask;
+	struct adfs_sb_info *asb = ADFS_SB(sb);
 
 	if (attr & ADFS_NDA_DIRECTORY) {
-		mode = S_IRUGO & sb->u.adfs_sb.s_owner_mask;
+		mode = S_IRUGO & asb->s_owner_mask;
 		return S_IFDIR | S_IXUGO | mode;
 	}
 
@@ -126,16 +127,16 @@
 	mode = S_IFREG;
 
 	if (attr & ADFS_NDA_OWNER_READ)
-		mode |= rmask & sb->u.adfs_sb.s_owner_mask;
+		mode |= rmask & asb->s_owner_mask;
 
 	if (attr & ADFS_NDA_OWNER_WRITE)
-		mode |= S_IWUGO & sb->u.adfs_sb.s_owner_mask;
+		mode |= S_IWUGO & asb->s_owner_mask;
 
 	if (attr & ADFS_NDA_PUBLIC_READ)
-		mode |= rmask & sb->u.adfs_sb.s_other_mask;
+		mode |= rmask & asb->s_other_mask;
 
 	if (attr & ADFS_NDA_PUBLIC_WRITE)
-		mode |= S_IWUGO & sb->u.adfs_sb.s_other_mask;
+		mode |= S_IWUGO & asb->s_other_mask;
 	return mode;
 }
 
@@ -148,6 +149,7 @@
 {
 	umode_t mode;
 	int attr;
+	struct adfs_sb_info *asb = ADFS_SB(sb);
 
 	/* FIXME: should we be able to alter a link? */
 	if (S_ISLNK(inode->i_mode))
@@ -158,14 +160,14 @@
 	else
 		attr = 0;
 
-	mode = inode->i_mode & sb->u.adfs_sb.s_owner_mask;
+	mode = inode->i_mode & asb->s_owner_mask;
 	if (mode & S_IRUGO)
 		attr |= ADFS_NDA_OWNER_READ;
 	if (mode & S_IWUGO)
 		attr |= ADFS_NDA_OWNER_WRITE;
 
-	mode = inode->i_mode & sb->u.adfs_sb.s_other_mask;
-	mode &= ~sb->u.adfs_sb.s_owner_mask;
+	mode = inode->i_mode & asb->s_other_mask;
+	mode &= ~asb->s_owner_mask;
 	if (mode & S_IRUGO)
 		attr |= ADFS_NDA_PUBLIC_READ;
 	if (mode & S_IWUGO)
@@ -248,8 +250,8 @@
 	if (!inode)
 		goto out;
 
-	inode->i_uid	 = sb->u.adfs_sb.s_uid;
-	inode->i_gid	 = sb->u.adfs_sb.s_gid;
+	inode->i_uid	 = ADFS_SB(sb)->s_uid;
+	inode->i_gid	 = ADFS_SB(sb)->s_gid;
 	inode->i_ino	 = obj->file_id;
 	inode->i_size	 = obj->size;
 	inode->i_nlink	 = 2;
@@ -309,8 +311,8 @@
 	 * we can't change the UID or GID of any file -
 	 * we have a global UID/GID in the superblock
 	 */
-	if ((ia_valid & ATTR_UID && attr->ia_uid != sb->u.adfs_sb.s_uid) ||
-	    (ia_valid & ATTR_GID && attr->ia_gid != sb->u.adfs_sb.s_gid))
+	if ((ia_valid & ATTR_UID && attr->ia_uid != ADFS_SB(sb)->s_uid) ||
+	    (ia_valid & ATTR_GID && attr->ia_gid != ADFS_SB(sb)->s_gid))
 		error = -EPERM;
 
 	if (error)
diff -urN linux-2.5.7-pre1/fs/adfs/map.c linux/fs/adfs/map.c
--- linux-2.5.7-pre1/fs/adfs/map.c	Thu Mar  7 21:18:30 2002
+++ linux/fs/adfs/map.c	Thu Mar 14 19:37:16 2002
@@ -197,7 +197,7 @@
 unsigned int
 adfs_map_free(struct super_block *sb)
 {
-	struct adfs_sb_info *asb = &sb->u.adfs_sb;
+	struct adfs_sb_info *asb = ADFS_SB(sb);
 	struct adfs_discmap *dm;
 	unsigned int total = 0;
 	unsigned int zone;
@@ -214,7 +214,7 @@
 
 int adfs_map_lookup (struct super_block *sb, int frag_id, int offset)
 {
-	struct adfs_sb_info *asb = &sb->u.adfs_sb;
+	struct adfs_sb_info *asb = ADFS_SB(sb);
 	unsigned int zone, mapoff;
 	int result;
 
diff -urN linux-2.5.7-pre1/fs/adfs/super.c linux/fs/adfs/super.c
--- linux-2.5.7-pre1/fs/adfs/super.c	Tue Mar 12 22:44:12 2002
+++ linux/fs/adfs/super.c	Thu Mar 14 19:52:00 2002
@@ -139,7 +139,7 @@
 	unsigned char crosscheck = 0, zonecheck = 1;
 	int i;
 
-	for (i = 0; i < sb->u.adfs_sb.s_map_size; i++) {
+	for (i = 0; i < ADFS_SB(sb)->s_map_size; i++) {
 		unsigned char *map;
 
 		map = dm[i].dm_bh->b_data;
@@ -158,15 +158,19 @@
 static void adfs_put_super(struct super_block *sb)
 {
 	int i;
+	struct adfs_sb_info *asb = ADFS_SB(sb);
 
-	for (i = 0; i < sb->u.adfs_sb.s_map_size; i++)
-		brelse(sb->u.adfs_sb.s_map[i].dm_bh);
-	kfree(sb->u.adfs_sb.s_map);
+	for (i = 0; i < asb->s_map_size; i++)
+		brelse(asb->s_map[i].dm_bh);
+	kfree(asb->s_map);
+	kfree(asb);
+	sb->u.generic_sbp = NULL;
 }
 
 static int parse_options(struct super_block *sb, char *options)
 {
 	char *value, *opt;
+	struct adfs_sb_info *asb = ADFS_SB(sb);
 
 	if (!options)
 		return 0;
@@ -179,28 +183,28 @@
 		if (!strcmp(opt, "uid")) {	/* owner of all files */
 			if (!value || !*value)
 				return -EINVAL;
-			sb->u.adfs_sb.s_uid = simple_strtoul(value, &value, 0);
+			asb->s_uid = simple_strtoul(value, &value, 0);
 			if (*value)
 				return -EINVAL;
 		} else
 		if (!strcmp(opt, "gid")) {	/* group owner of all files */
 			if (!value || !*value)
 				return -EINVAL;
-			sb->u.adfs_sb.s_gid = simple_strtoul(value, &value, 0);
+			asb->s_gid = simple_strtoul(value, &value, 0);
 			if (*value)
 				return -EINVAL;
 		} else
 		if (!strcmp(opt, "ownmask")) {	/* owner permission mask */
 			if (!value || !*value)
 				return -EINVAL;
-			sb->u.adfs_sb.s_owner_mask = simple_strtoul(value, &value, 8);
+			asb->s_owner_mask = simple_strtoul(value, &value, 8);
 			if (*value)
 				return -EINVAL;
 		} else
 		if (!strcmp(opt, "othmask")) {	/* others permission mask */
 			if (!value || !*value)
 				return -EINVAL;
-			sb->u.adfs_sb.s_other_mask = simple_strtoul(value, &value, 8);
+			asb->s_other_mask = simple_strtoul(value, &value, 8);
 			if (*value)
 				return -EINVAL;
 		} else {			/* eh? say again. */
@@ -218,7 +222,7 @@
 
 static int adfs_statfs(struct super_block *sb, struct statfs *buf)
 {
-	struct adfs_sb_info *asb = &sb->u.adfs_sb;
+	struct adfs_sb_info *asb = ADFS_SB(sb);
 
 	buf->f_type    = ADFS_SUPER_MAGIC;
 	buf->f_namelen = asb->s_namelen;
@@ -288,14 +292,15 @@
 	struct adfs_discmap *dm;
 	unsigned int map_addr, zone_size, nzones;
 	int i, zone;
+	struct adfs_sb_info *asb = ADFS_SB(sb);
 
-	nzones    = sb->u.adfs_sb.s_map_size;
+	nzones    = asb->s_map_size;
 	zone_size = (8 << dr->log2secsize) - le16_to_cpu(dr->zone_spare);
 	map_addr  = (nzones >> 1) * zone_size -
 		     ((nzones > 1) ? ADFS_DR_SIZE_BITS : 0);
-	map_addr  = signed_asl(map_addr, sb->u.adfs_sb.s_map2blk);
+	map_addr  = signed_asl(map_addr, asb->s_map2blk);
 
-	sb->u.adfs_sb.s_ids_per_zone = zone_size / (sb->u.adfs_sb.s_idlen + 1);
+	asb->s_ids_per_zone = zone_size / (asb->s_idlen + 1);
 
 	dm = kmalloc(nzones * sizeof(*dm), GFP_KERNEL);
 	if (dm == NULL) {
@@ -352,12 +357,19 @@
 	struct buffer_head *bh;
 	struct object_info root_obj;
 	unsigned char *b_data;
+	struct adfs_sb_info *asb;
+
+	asb = kmalloc(sizeof(struct adfs_sb_info), GFP_KERNEL);
+	if (!asb)
+		return -ENOMEM;
+	sb->u.generic_sbp = asb;
+	memset(asb, 0, sizeof(struct adfs_sb_info));
 
 	/* set default options */
-	sb->u.adfs_sb.s_uid = 0;
-	sb->u.adfs_sb.s_gid = 0;
-	sb->u.adfs_sb.s_owner_mask = S_IRWXU;
-	sb->u.adfs_sb.s_other_mask = S_IRWXG | S_IRWXO;
+	asb->s_uid = 0;
+	asb->s_gid = 0;
+	asb->s_owner_mask = S_IRWXU;
+	asb->s_other_mask = S_IRWXG | S_IRWXO;
 
 	if (parse_options(sb, data))
 		goto error;
@@ -414,16 +426,16 @@
 	 * blocksize on this device should now be set to the ADFS log2secsize
 	 */
 
-	sb->s_magic		 = ADFS_SUPER_MAGIC;
-	sb->u.adfs_sb.s_idlen	 = dr->idlen;
-	sb->u.adfs_sb.s_map_size = dr->nzones | (dr->nzones_high << 8);
-	sb->u.adfs_sb.s_map2blk	 = dr->log2bpmb - dr->log2secsize;
-	sb->u.adfs_sb.s_size     = adfs_discsize(dr, sb->s_blocksize_bits);
-	sb->u.adfs_sb.s_version  = dr->format_version;
-	sb->u.adfs_sb.s_log2sharesize = dr->log2sharesize;
+	sb->s_magic		= ADFS_SUPER_MAGIC;
+	asb->s_idlen		= dr->idlen;
+	asb->s_map_size		= dr->nzones | (dr->nzones_high << 8);
+	asb->s_map2blk		= dr->log2bpmb - dr->log2secsize;
+	asb->s_size    		= adfs_discsize(dr, sb->s_blocksize_bits);
+	asb->s_version 		= dr->format_version;
+	asb->s_log2sharesize	= dr->log2sharesize;
 	
-	sb->u.adfs_sb.s_map = adfs_read_map(sb, dr);
-	if (!sb->u.adfs_sb.s_map)
+	asb->s_map = adfs_read_map(sb, dr);
+	if (!asb->s_map)
 		goto error_free_bh;
 
 	brelse(bh);
@@ -433,7 +445,7 @@
 	 */
 	sb->s_op = &adfs_sops;
 
-	dr = (struct adfs_discrecord *)(sb->u.adfs_sb.s_map[0].dm_bh->b_data + 4);
+	dr = (struct adfs_discrecord *)(asb->s_map[0].dm_bh->b_data + 4);
 
 	root_obj.parent_id = root_obj.file_id = le32_to_cpu(dr->root);
 	root_obj.name_len  = 0;
@@ -447,22 +459,22 @@
 	 * If this is a F+ disk with variable length directories,
 	 * get the root_size from the disc record.
 	 */
-	if (sb->u.adfs_sb.s_version) {
+	if (asb->s_version) {
 		root_obj.size = dr->root_size;
-		sb->u.adfs_sb.s_dir     = &adfs_fplus_dir_ops;
-		sb->u.adfs_sb.s_namelen = ADFS_FPLUS_NAME_LEN;
+		asb->s_dir     = &adfs_fplus_dir_ops;
+		asb->s_namelen = ADFS_FPLUS_NAME_LEN;
 	} else {
-		sb->u.adfs_sb.s_dir     = &adfs_f_dir_ops;
-		sb->u.adfs_sb.s_namelen = ADFS_F_NAME_LEN;
+		asb->s_dir     = &adfs_f_dir_ops;
+		asb->s_namelen = ADFS_F_NAME_LEN;
 	}
 
 	sb->s_root = d_alloc_root(adfs_iget(sb, &root_obj));
 	if (!sb->s_root) {
 		int i;
 
-		for (i = 0; i < sb->u.adfs_sb.s_map_size; i++)
-			brelse(sb->u.adfs_sb.s_map[i].dm_bh);
-		kfree(sb->u.adfs_sb.s_map);
+		for (i = 0; i < asb->s_map_size; i++)
+			brelse(asb->s_map[i].dm_bh);
+		kfree(asb->s_map);
 		adfs_error(sb, "get root inode failed\n");
 		goto error;
 	} else
@@ -472,6 +484,8 @@
 error_free_bh:
 	brelse(bh);
 error:
+	sb->u.generic_sbp = NULL;
+	kfree(asb);
 	return -EINVAL;
 }
 
diff -urN linux-2.5.7-pre1/include/linux/adfs_fs.h linux/include/linux/adfs_fs.h
--- linux-2.5.7-pre1/include/linux/adfs_fs.h	Thu Mar 14 19:08:20 2002
+++ linux/include/linux/adfs_fs.h	Thu Mar 14 19:49:24 2002
@@ -42,6 +42,7 @@
 
 #ifdef __KERNEL__
 #include <linux/adfs_fs_i.h>
+#include <linux/adfs_fs_sb.h>
 /*
  * Calculate the boot block checksum on an ADFS drive.  Note that this will
  * appear to be correct if the sector contains all zeros, so also check that
@@ -60,6 +61,11 @@
 	return (result & 0xff) != ptr[511];
 }
 
+static inline struct adfs_sb_info *ADFS_SB(struct super_block *sb)
+{
+	return sb->u.generic_sbp;
+}
+
 static inline struct adfs_inode_info *ADFS_I(struct inode *inode)
 {
 	return list_entry(inode, struct adfs_inode_info, vfs_inode);
diff -urN linux-2.5.7-pre1/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.5.7-pre1/include/linux/fs.h	Tue Mar 12 22:44:13 2002
+++ linux/include/linux/fs.h	Thu Mar 14 19:49:24 2002
@@ -662,7 +662,6 @@
 #include <linux/romfs_fs_sb.h>
 #include <linux/smb_fs_sb.h>
 #include <linux/hfs_fs_sb.h>
-#include <linux/adfs_fs_sb.h>
 #include <linux/qnx4_fs_sb.h>
 #include <linux/reiserfs_fs_sb.h>
 #include <linux/bfs_fs_sb.h>
@@ -719,7 +718,6 @@
 		struct romfs_sb_info	romfs_sb;
 		struct smb_sb_info	smbfs_sb;
 		struct hfs_sb_info	hfs_sb;
-		struct adfs_sb_info	adfs_sb;
 		struct qnx4_sb_info	qnx4_sb;
 		struct reiserfs_sb_info	reiserfs_sb;
 		struct bfs_sb_info	bfs_sb;

--------------070700080505040809020705--

