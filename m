Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291809AbSBYRUh>; Mon, 25 Feb 2002 12:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292996AbSBYRUa>; Mon, 25 Feb 2002 12:20:30 -0500
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:3712 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291809AbSBYRT5>;
	Mon, 25 Feb 2002 12:19:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: [PATCH] Son of Unbork (2 of 3)
Date: Sat, 23 Feb 2002 19:12:43 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16egf5-00006P-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The second patch of this set completes the removal of ext2-specific includes
from fs.h and makes various related changes to Ext2 as follows: 

  - Defines a struct ext2_super_info containing all the filesystem-private 
    super_block fields for ext2, and a complete instance of the generic 
    struct super_block.

  - Defines an inline function EXT2_SB(sb) that takes a generic super_block, 
    which is assumed to be part of an Ext2-specific super_block, and returns 
    a pointer to the enclosing Ext2-specific super_block.

  - Removes all references to the struct super_block union and replaces them 
    with calls to the above access function.

  - Defines ext2_alloc_super and ext2_destroy_super methods and places them
    in Ext2's file_system struct.

  - Since it is no longer required that ext2_fs_sb.h be included separately
    from the other ext2 headers, moves its contents into fs/ext2/ext2.h.

  - Moves the remainder of ext2_fs.h into fs/ext2/ext2.h.

  - Since the new ext2.h header will never be compiled as part of a user 
    space program, removes all occurances of __KERNEL__ from it.

  - Removes the include of ext2_fs_sb.h from fs.h and removes ext2_info from 
    the super_block union.

The bulk of this patch consists of the the more-or-less mechanical replacement
of "sb->u.ext2_sb." by "EXT2_SB(sb)->".

To apply:

    cd /your/source/tree/..
    patch -p1 <this/patch

-- 
Daniel

--- 2.5.5.clean/fs/ext2/balloc.c	Wed Feb 20 03:11:00 2002
+++ 2.5.5/fs/ext2/balloc.c	Sat Feb 23 15:52:00 2002
@@ -41,7 +41,7 @@
 	unsigned long group_desc;
 	unsigned long offset;
 	struct ext2_group_desc * desc;
-	struct ext2_sb_info *sbi = &sb->u.ext2_sb;
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
 
 	if (block_group >= sbi->s_groups_count) {
 		ext2_error (sb, "ext2_get_group_desc",
@@ -61,7 +61,7 @@
 			     block_group, group_desc, offset);
 		return NULL;
 	}
-	
+
 	desc = (struct ext2_group_desc *) sbi->s_group_desc[group_desc]->b_data;
 	if (bh)
 		*bh = sbi->s_group_desc[group_desc];
@@ -110,7 +110,7 @@
 static struct buffer_head *load_block_bitmap(struct super_block * sb,
 						unsigned int block_group)
 {
-	struct ext2_sb_info *sbi = &sb->u.ext2_sb;
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	int i, slot = 0;
 	struct buffer_head *bh = sbi->s_block_bitmap[0];
 
@@ -249,8 +249,8 @@
 	unsigned freed = 0, group_freed;
 
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
-	if (block < le32_to_cpu(es->s_first_data_block) || 
+	es = EXT2_SB(sb)->s_es;
+	if (block < le32_to_cpu(es->s_first_data_block) ||
 	    (block + count) > le32_to_cpu(es->s_blocks_count)) {
 		ext2_error (sb, "ext2_free_blocks",
 			    "Freeing blocks not in datazone - "
@@ -285,9 +285,9 @@
 	if (in_range (le32_to_cpu(desc->bg_block_bitmap), block, count) ||
 	    in_range (le32_to_cpu(desc->bg_inode_bitmap), block, count) ||
 	    in_range (block, le32_to_cpu(desc->bg_inode_table),
-		      sb->u.ext2_sb.s_itb_per_group) ||
+		      EXT2_SB(sb)->s_itb_per_group) ||
 	    in_range (block + count - 1, le32_to_cpu(desc->bg_inode_table),
-		      sb->u.ext2_sb.s_itb_per_group))
+		      EXT2_SB(sb)->s_itb_per_group))
 		ext2_error (sb, "ext2_free_blocks",
 			    "Freeing blocks in system zones - "
 			    "Block = %lu, count = %lu",
@@ -552,11 +552,11 @@
 	int i;
 	
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
+	es = EXT2_SB(sb)->s_es;
 	desc_count = 0;
 	bitmap_count = 0;
 	desc = NULL;
-	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
+	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
 		struct buffer_head *bh;
 		desc = ext2_get_group_desc (sb, i, NULL);
 		if (!desc)
@@ -576,7 +576,7 @@
 	unlock_super (sb);
 	return bitmap_count;
 #else
-	return le32_to_cpu(sb->u.ext2_sb.s_es->s_free_blocks_count);
+	return le32_to_cpu(EXT2_SB(sb)->s_es->s_free_blocks_count);
 #endif
 }
 
@@ -584,7 +584,7 @@
 				struct super_block * sb,
 				unsigned char * map)
 {
-	return ext2_test_bit ((block - le32_to_cpu(sb->u.ext2_sb.s_es->s_first_data_block)) %
+	return ext2_test_bit ((block - le32_to_cpu(EXT2_SB(sb)->s_es->s_first_data_block)) %
 			 EXT2_BLOCKS_PER_GROUP(sb), map);
 }
 
@@ -651,11 +651,11 @@
 	struct ext2_group_desc * desc;
 	int i;
 
-	es = sb->u.ext2_sb.s_es;
+	es = EXT2_SB(sb)->s_es;
 	desc_count = 0;
 	bitmap_count = 0;
 	desc = NULL;
-	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
+	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
 		desc = ext2_get_group_desc (sb, i, NULL);
 		if (!desc)
 			continue;
@@ -685,7 +685,7 @@
 				    "Inode bitmap for group %d is marked free",
 				    i);
 
-		for (j = 0; j < sb->u.ext2_sb.s_itb_per_group; j++)
+		for (j = 0; j < EXT2_SB(sb)->s_itb_per_group; j++)
 			if (!block_in_use (le32_to_cpu(desc->bg_inode_table) + j, sb, bh->b_data))
 				ext2_error (sb, "ext2_check_blocks_bitmap",
 					    "Block #%ld of the inode table in "
--- 2.5.5.clean/fs/ext2/dir.c	Wed Feb 20 03:10:53 2002
+++ 2.5.5/fs/ext2/dir.c	Sat Feb 23 15:52:00 2002
@@ -68,7 +68,7 @@
 	struct super_block *sb = dir->i_sb;
 	unsigned chunk_size = ext2_chunk_size(dir);
 	char *kaddr = page_address(page);
-	u32 max_inumber = le32_to_cpu(sb->u.ext2_sb.s_es->s_inodes_count);
+	u32 max_inumber = le32_to_cpu(EXT2_SB(sb)->s_es->s_inodes_count);
 	unsigned offs, rec_len;
 	unsigned limit = PAGE_CACHE_SIZE;
 	ext2_dirent *p;
--- 2.5.5.clean/fs/ext2/ext2.h	Wed Feb 20 03:11:02 2002
+++ 2.5.5/fs/ext2/ext2.h	Sat Feb 23 16:59:44 2002
@@ -1,8 +1,394 @@
 #include <linux/fs.h>
-#include <linux/ext2_fs.h>
 
 /*
- * second extended file system inode data in memory
+ * The second extended filesystem constants/structures
+ */
+
+/*
+ * Define EXT2FS_DEBUG to produce debug messages
+ */
+#undef EXT2FS_DEBUG
+
+/*
+ * Define EXT2_PREALLOCATE to preallocate data blocks for expanding files
+ */
+#define EXT2_PREALLOCATE
+#define EXT2_DEFAULT_PREALLOC_BLOCKS	8
+
+/*
+ * The second extended file system version
+ */
+#define EXT2FS_DATE		"95/08/09"
+#define EXT2FS_VERSION		"0.5b"
+
+/*
+ * Debug code
+ */
+#ifdef EXT2FS_DEBUG
+#	define ext2_debug(f, a...)	{ \
+					printk ("EXT2-fs DEBUG (%s, %d): %s:", \
+						__FILE__, __LINE__, __FUNCTION__); \
+				  	printk (f, ## a); \
+					}
+#else
+#	define ext2_debug(f, a...)	/**/
+#endif
+
+/*
+ * Special inode numbers
+ */
+#define	EXT2_BAD_INO		 1	/* Bad blocks inode */
+#define EXT2_ROOT_INO		 2	/* Root inode */
+#define EXT2_ACL_IDX_INO	 3	/* ACL inode */
+#define EXT2_ACL_DATA_INO	 4	/* ACL inode */
+#define EXT2_BOOT_LOADER_INO	 5	/* Boot loader inode */
+#define EXT2_UNDEL_DIR_INO	 6	/* Undelete directory inode */
+
+/* First non-reserved inode for old ext2 filesystems */
+#define EXT2_GOOD_OLD_FIRST_INO	11
+
+/*
+ * The second extended file system magic number
+ */
+#define EXT2_SUPER_MAGIC	0xEF53
+
+/*
+ * Maximal count of links to a file
+ */
+#define EXT2_LINK_MAX		32000
+
+/*
+ * Macro-instructions used to manage several block sizes
+ */
+#define EXT2_MIN_BLOCK_SIZE		1024
+#define	EXT2_MAX_BLOCK_SIZE		4096
+#define EXT2_MIN_BLOCK_LOG_SIZE		  10
+#define EXT2_BLOCK_SIZE(s)		((s)->s_blocksize)
+#define EXT2_ACLE_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (struct ext2_acl_entry))
+#define	EXT2_ADDR_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (__u32))
+#define EXT2_BLOCK_SIZE_BITS(s)	((s)->s_blocksize_bits)
+#define	EXT2_ADDR_PER_BLOCK_BITS(s)	(EXT2_SB(s)->s_addr_per_block_bits)
+#define EXT2_INODE_SIZE(s)		(EXT2_SB(s)->s_inode_size)
+#define EXT2_FIRST_INO(s)		(EXT2_SB(s)->s_first_ino)
+
+/*
+ * Macro-instructions used to manage fragments
+ */
+#define EXT2_MIN_FRAG_SIZE		1024
+#define	EXT2_MAX_FRAG_SIZE		4096
+#define EXT2_MIN_FRAG_LOG_SIZE		  10
+#define EXT2_FRAG_SIZE(s)		(EXT2_MIN_FRAG_SIZE << (s)->s_log_frag_size)
+#define EXT2_FRAGS_PER_BLOCK(s)	(EXT2_BLOCK_SIZE(s) / EXT2_FRAG_SIZE(s))
+
+/*
+ * ACL structures
+ */
+struct ext2_acl_header	/* Header of Access Control Lists */
+{
+	__u32	aclh_size;
+	__u32	aclh_file_count;
+	__u32	aclh_acle_count;
+	__u32	aclh_first_acle;
+};
+
+struct ext2_acl_entry	/* Access Control List Entry */
+{
+	__u32	acle_size;
+	__u16	acle_perms;	/* Access permissions */
+	__u16	acle_type;	/* Type of entry */
+	__u16	acle_tag;	/* User or group identity */
+	__u16	acle_pad1;
+	__u32	acle_next;	/* Pointer on next entry for the */
+					/* same inode or on next free entry */
+};
+
+/*
+ * Structure of a blocks group descriptor
+ */
+struct ext2_group_desc
+{
+	__u32	bg_block_bitmap;		/* Blocks bitmap block */
+	__u32	bg_inode_bitmap;		/* Inodes bitmap block */
+	__u32	bg_inode_table;		/* Inodes table block */
+	__u16	bg_free_blocks_count;	/* Free blocks count */
+	__u16	bg_free_inodes_count;	/* Free inodes count */
+	__u16	bg_used_dirs_count;	/* Directories count */
+	__u16	bg_pad;
+	__u32	bg_reserved[3];
+};
+
+/*
+ * Macro-instructions used to manage group descriptors
+ */
+#define EXT2_BLOCKS_PER_GROUP(s)	(EXT2_SB(s)->s_blocks_per_group)
+#define EXT2_DESC_PER_BLOCK(s)		(EXT2_SB(s)->s_desc_per_block)
+#define EXT2_INODES_PER_GROUP(s)	(EXT2_SB(s)->s_inodes_per_group)
+#define EXT2_DESC_PER_BLOCK_BITS(s)	(EXT2_SB(s)->s_desc_per_block_bits)
+
+/*
+ * Constants relative to the data blocks
+ */
+#define	EXT2_NDIR_BLOCKS		12
+#define	EXT2_IND_BLOCK			EXT2_NDIR_BLOCKS
+#define	EXT2_DIND_BLOCK			(EXT2_IND_BLOCK + 1)
+#define	EXT2_TIND_BLOCK			(EXT2_DIND_BLOCK + 1)
+#define	EXT2_N_BLOCKS			(EXT2_TIND_BLOCK + 1)
+
+/*
+ * Inode flags
+ */
+#define	EXT2_SECRM_FL			0x00000001 /* Secure deletion */
+#define	EXT2_UNRM_FL			0x00000002 /* Undelete */
+#define	EXT2_COMPR_FL			0x00000004 /* Compress file */
+#define EXT2_SYNC_FL			0x00000008 /* Synchronous updates */
+#define EXT2_IMMUTABLE_FL		0x00000010 /* Immutable file */
+#define EXT2_APPEND_FL			0x00000020 /* writes to file may only append */
+#define EXT2_NODUMP_FL			0x00000040 /* do not dump file */
+#define EXT2_NOATIME_FL			0x00000080 /* do not update atime */
+/* Reserved for compression usage... */
+#define EXT2_DIRTY_FL			0x00000100
+#define EXT2_COMPRBLK_FL		0x00000200 /* One or more compressed clusters */
+#define EXT2_NOCOMP_FL			0x00000400 /* Don't compress */
+#define EXT2_ECOMPR_FL			0x00000800 /* Compression error */
+/* End compression flags --- maybe not all used */
+#define EXT2_BTREE_FL			0x00001000 /* btree format dir */
+#define EXT2_RESERVED_FL		0x80000000 /* reserved for ext2 lib */
+
+#define EXT2_FL_USER_VISIBLE		0x00001FFF /* User visible flags */
+#define EXT2_FL_USER_MODIFIABLE		0x000000FF /* User modifiable flags */
+
+/*
+ * ioctl commands
+ */
+#define	EXT2_IOC_GETFLAGS		_IOR('f', 1, long)
+#define	EXT2_IOC_SETFLAGS		_IOW('f', 2, long)
+#define	EXT2_IOC_GETVERSION		_IOR('v', 1, long)
+#define	EXT2_IOC_SETVERSION		_IOW('v', 2, long)
+
+/*
+ * Structure of an inode on the disk
+ */
+struct ext2_inode {
+	__u16	i_mode;		/* File mode */
+	__u16	i_uid;		/* Low 16 bits of Owner Uid */
+	__u32	i_size;		/* Size in bytes */
+	__u32	i_atime;	/* Access time */
+	__u32	i_ctime;	/* Creation time */
+	__u32	i_mtime;	/* Modification time */
+	__u32	i_dtime;	/* Deletion Time */
+	__u16	i_gid;		/* Low 16 bits of Group Id */
+	__u16	i_links_count;	/* Links count */
+	__u32	i_blocks;	/* Blocks count */
+	__u32	i_flags;	/* File flags */
+	union {
+		struct {
+			__u32  l_i_reserved1;
+		} linux1;
+		struct {
+			__u32  h_i_translator;
+		} hurd1;
+		struct {
+			__u32  m_i_reserved1;
+		} masix1;
+	} osd1;				/* OS dependent 1 */
+	__u32	i_block[EXT2_N_BLOCKS];/* Pointers to blocks */
+	__u32	i_generation;	/* File version (for NFS) */
+	__u32	i_file_acl;	/* File ACL */
+	__u32	i_dir_acl;	/* Directory ACL */
+	__u32	i_faddr;	/* Fragment address */
+	union {
+		struct {
+			__u8	l_i_frag;	/* Fragment number */
+			__u8	l_i_fsize;	/* Fragment size */
+			__u16	i_pad1;
+			__u16	l_i_uid_high;	/* these 2 fields    */
+			__u16	l_i_gid_high;	/* were reserved2[0] */
+			__u32	l_i_reserved2;
+		} linux2;
+		struct {
+			__u8	h_i_frag;	/* Fragment number */
+			__u8	h_i_fsize;	/* Fragment size */
+			__u16	h_i_mode_high;
+			__u16	h_i_uid_high;
+			__u16	h_i_gid_high;
+			__u32	h_i_author;
+		} hurd2;
+		struct {
+			__u8	m_i_frag;	/* Fragment number */
+			__u8	m_i_fsize;	/* Fragment size */
+			__u16	m_pad1;
+			__u32	m_i_reserved2[2];
+		} masix2;
+	} osd2;				/* OS dependent 2 */
+};
+
+#define i_size_high	i_dir_acl
+
+#ifdef __linux__
+#define i_reserved1	osd1.linux1.l_i_reserved1
+#define i_frag		osd2.linux2.l_i_frag
+#define i_fsize		osd2.linux2.l_i_fsize
+#define i_uid_low	i_uid
+#define i_gid_low	i_gid
+#define i_uid_high	osd2.linux2.l_i_uid_high
+#define i_gid_high	osd2.linux2.l_i_gid_high
+#define i_reserved2	osd2.linux2.l_i_reserved2
+#endif
+
+#ifdef	__hurd__
+#define i_translator	osd1.hurd1.h_i_translator
+#define i_frag		osd2.hurd2.h_i_frag;
+#define i_fsize		osd2.hurd2.h_i_fsize;
+#define i_uid_high	osd2.hurd2.h_i_uid_high
+#define i_gid_high	osd2.hurd2.h_i_gid_high
+#define i_author	osd2.hurd2.h_i_author
+#endif
+
+#ifdef	__masix__
+#define i_reserved1	osd1.masix1.m_i_reserved1
+#define i_frag		osd2.masix2.m_i_frag
+#define i_fsize		osd2.masix2.m_i_fsize
+#define i_reserved2	osd2.masix2.m_i_reserved2
+#endif
+
+/*
+ * File system states
+ */
+#define	EXT2_VALID_FS			0x0001	/* Unmounted cleanly */
+#define	EXT2_ERROR_FS			0x0002	/* Errors detected */
+
+/*
+ * Mount flags
+ */
+#define EXT2_MOUNT_CHECK		0x0001	/* Do mount-time checks */
+#define EXT2_MOUNT_GRPID		0x0004	/* Create files with directory's group */
+#define EXT2_MOUNT_DEBUG		0x0008	/* Some debugging messages */
+#define EXT2_MOUNT_ERRORS_CONT		0x0010	/* Continue on errors */
+#define EXT2_MOUNT_ERRORS_RO		0x0020	/* Remount fs ro on errors */
+#define EXT2_MOUNT_ERRORS_PANIC		0x0040	/* Panic on errors */
+#define EXT2_MOUNT_MINIX_DF		0x0080	/* Mimics the Minix statfs */
+#define EXT2_MOUNT_NO_UID32		0x0200  /* Disable 32-bit UIDs */
+
+#define clear_opt(o, opt)		o &= ~EXT2_MOUNT_##opt
+#define set_opt(o, opt)			o |= EXT2_MOUNT_##opt
+#define test_opt(sb, opt)		(EXT2_SB(sb)->s_mount_opt & \
+					 EXT2_MOUNT_##opt)
+/*
+ * Maximal mount counts between two filesystem checks
+ */
+#define EXT2_DFL_MAX_MNT_COUNT		20	/* Allow 20 mounts */
+#define EXT2_DFL_CHECKINTERVAL		0	/* Don't use interval check */
+
+/*
+ * Behaviour when detecting errors
+ */
+#define EXT2_ERRORS_CONTINUE		1	/* Continue execution */
+#define EXT2_ERRORS_RO			2	/* Remount fs read-only */
+#define EXT2_ERRORS_PANIC		3	/* Panic */
+#define EXT2_ERRORS_DEFAULT		EXT2_ERRORS_CONTINUE
+
+/*
+ * Structure of the super block
+ */
+struct ext2_super_block {
+	__u32	s_inodes_count;		/* Inodes count */
+	__u32	s_blocks_count;		/* Blocks count */
+	__u32	s_r_blocks_count;	/* Reserved blocks count */
+	__u32	s_free_blocks_count;	/* Free blocks count */
+	__u32	s_free_inodes_count;	/* Free inodes count */
+	__u32	s_first_data_block;	/* First Data Block */
+	__u32	s_log_block_size;	/* Block size */
+	__s32	s_log_frag_size;	/* Fragment size */
+	__u32	s_blocks_per_group;	/* # Blocks per group */
+	__u32	s_frags_per_group;	/* # Fragments per group */
+	__u32	s_inodes_per_group;	/* # Inodes per group */
+	__u32	s_mtime;		/* Mount time */
+	__u32	s_wtime;		/* Write time */
+	__u16	s_mnt_count;		/* Mount count */
+	__s16	s_max_mnt_count;	/* Maximal mount count */
+	__u16	s_magic;		/* Magic signature */
+	__u16	s_state;		/* File system state */
+	__u16	s_errors;		/* Behaviour when detecting errors */
+	__u16	s_minor_rev_level; 	/* minor revision level */
+	__u32	s_lastcheck;		/* time of last check */
+	__u32	s_checkinterval;	/* max. time between checks */
+	__u32	s_creator_os;		/* OS */
+	__u32	s_rev_level;		/* Revision level */
+	__u16	s_def_resuid;		/* Default uid for reserved blocks */
+	__u16	s_def_resgid;		/* Default gid for reserved blocks */
+	/*
+	 * These fields are for EXT2_DYNAMIC_REV superblocks only.
+	 *
+	 * Note: the difference between the compatible feature set and
+	 * the incompatible feature set is that if there is a bit set
+	 * in the incompatible feature set that the kernel doesn't
+	 * know about, it should refuse to mount the filesystem.
+	 *
+	 * e2fsck's requirements are more strict; if it doesn't know
+	 * about a feature in either the compatible or incompatible
+	 * feature set, it must abort and not try to meddle with
+	 * things it doesn't understand...
+	 */
+	__u32	s_first_ino; 		/* First non-reserved inode */
+	__u16   s_inode_size; 		/* size of inode structure */
+	__u16	s_block_group_nr; 	/* block group # of this superblock */
+	__u32	s_feature_compat; 	/* compatible feature set */
+	__u32	s_feature_incompat; 	/* incompatible feature set */
+	__u32	s_feature_ro_compat; 	/* readonly-compatible feature set */
+	__u8	s_uuid[16];		/* 128-bit uuid for volume */
+	char	s_volume_name[16]; 	/* volume name */
+	char	s_last_mounted[64]; 	/* directory where last mounted */
+	__u32	s_algorithm_usage_bitmap; /* For compression */
+	/*
+	 * Performance hints.  Directory preallocation should only
+	 * happen if the EXT2_COMPAT_PREALLOC flag is on.
+	 */
+	__u8	s_prealloc_blocks;	/* Nr of blocks to try to preallocate*/
+	__u8	s_prealloc_dir_blocks;	/* Nr to preallocate for dirs */
+	__u16	s_padding1;
+	__u32	s_reserved[204];	/* Padding to the end of the block */
+};
+
+#define EXT2_MAX_GROUP_LOADED 8
+
+/*
+ * In-memory superblock
+ */
+struct ext2_sb_info {
+	unsigned long s_frag_size;	/* Size of a fragment in bytes */
+	unsigned long s_frags_per_block;/* Number of fragments per block */
+	unsigned long s_inodes_per_block;/* Number of inodes per block */
+	unsigned long s_frags_per_group;/* Number of fragments in a group */
+	unsigned long s_blocks_per_group;/* Number of blocks in a group */
+	unsigned long s_inodes_per_group;/* Number of inodes in a group */
+	unsigned long s_itb_per_group;	/* Number of inode table blocks per group */
+	unsigned long s_gdb_count;	/* Number of group descriptor blocks */
+	unsigned long s_desc_per_block;	/* Number of group descriptors per block */
+	unsigned long s_groups_count;	/* Number of groups in the fs */
+	struct buffer_head * s_sbh;	/* Buffer containing the super block */
+	struct ext2_super_block * s_es;	/* Pointer to the super block in the buffer */
+	struct buffer_head ** s_group_desc;
+	unsigned short s_loaded_inode_bitmaps;
+	unsigned short s_loaded_block_bitmaps;
+	unsigned long s_inode_bitmap_number[EXT2_MAX_GROUP_LOADED];
+	struct buffer_head * s_inode_bitmap[EXT2_MAX_GROUP_LOADED];
+	unsigned long s_block_bitmap_number[EXT2_MAX_GROUP_LOADED];
+	struct buffer_head * s_block_bitmap[EXT2_MAX_GROUP_LOADED];
+	unsigned long  s_mount_opt;
+	uid_t s_resuid;
+	gid_t s_resgid;
+	unsigned short s_mount_state;
+	unsigned short s_pad;
+	int s_addr_per_block_bits;
+	int s_desc_per_block_bits;
+	int s_inode_size;
+	int s_first_ino;
+	u32 s_next_generation;
+	struct super_block vfs_super;
+};
+
+/*
+ * In-memory inode
  */
 struct ext2_inode_info {
 	__u32	i_data[15];
@@ -24,19 +410,143 @@
 	struct inode	vfs_inode;
 };
 
+static inline struct ext2_inode_info *EXT2_I(struct inode *inode)
+{
+	return list_entry(inode, struct ext2_inode_info, vfs_inode);
+}
+
+static inline struct ext2_sb_info *EXT2_SB(struct super_block *sb)
+{
+	return list_entry(sb, struct ext2_sb_info, vfs_super);
+}
+
 /*
- * Function prototypes
+ * Codes for operating systems
  */
+#define EXT2_OS_LINUX		0
+#define EXT2_OS_HURD		1
+#define EXT2_OS_MASIX		2
+#define EXT2_OS_FREEBSD		3
+#define EXT2_OS_LITES		4
 
 /*
- * Ok, these declarations are also in <linux/kernel.h> but none of the
- * ext2 source programs needs to include it so they are duplicated here.
+ * Revision levels
  */
+#define EXT2_GOOD_OLD_REV	0	/* The good old (original) format */
+#define EXT2_DYNAMIC_REV	1 	/* V2 format w/ dynamic inode sizes */
 
-static inline struct ext2_inode_info *EXT2_I(struct inode *inode)
-{
-	return list_entry(inode, struct ext2_inode_info, vfs_inode);
-}
+#define EXT2_CURRENT_REV	EXT2_GOOD_OLD_REV
+#define EXT2_MAX_SUPP_REV	EXT2_DYNAMIC_REV
+
+#define EXT2_GOOD_OLD_INODE_SIZE 128
+
+/*
+ * Feature set definitions
+ */
+
+#define EXT2_HAS_COMPAT_FEATURE(sb,mask)			\
+	( EXT2_SB(sb)->s_es->s_feature_compat & cpu_to_le32(mask) )
+#define EXT2_HAS_RO_COMPAT_FEATURE(sb,mask)			\
+	( EXT2_SB(sb)->s_es->s_feature_ro_compat & cpu_to_le32(mask) )
+#define EXT2_HAS_INCOMPAT_FEATURE(sb,mask)			\
+	( EXT2_SB(sb)->s_es->s_feature_incompat & cpu_to_le32(mask) )
+#define EXT2_SET_COMPAT_FEATURE(sb,mask)			\
+	EXT2_SB(sb)->s_es->s_feature_compat |= cpu_to_le32(mask)
+#define EXT2_SET_RO_COMPAT_FEATURE(sb,mask)			\
+	EXT2_SB(sb)->s_es->s_feature_ro_compat |= cpu_to_le32(mask)
+#define EXT2_SET_INCOMPAT_FEATURE(sb,mask)			\
+	EXT2_SB(sb)->s_es->s_feature_incompat |= cpu_to_le32(mask)
+#define EXT2_CLEAR_COMPAT_FEATURE(sb,mask)			\
+	EXT2_SB(sb)->s_es->s_feature_compat &= ~cpu_to_le32(mask)
+#define EXT2_CLEAR_RO_COMPAT_FEATURE(sb,mask)			\
+	EXT2_SB(sb)->s_es->s_feature_ro_compat &= ~cpu_to_le32(mask)
+#define EXT2_CLEAR_INCOMPAT_FEATURE(sb,mask)			\
+	EXT2_SB(sb)->s_es->s_feature_incompat &= ~cpu_to_le32(mask)
+
+#define EXT2_FEATURE_COMPAT_DIR_PREALLOC	0x0001
+#define EXT2_FEATURE_COMPAT_IMAGIC_INODES	0x0002
+#define EXT3_FEATURE_COMPAT_HAS_JOURNAL		0x0004
+#define EXT2_FEATURE_COMPAT_EXT_ATTR		0x0008
+#define EXT2_FEATURE_COMPAT_RESIZE_INO		0x0010
+#define EXT2_FEATURE_COMPAT_DIR_INDEX		0x0020
+#define EXT2_FEATURE_COMPAT_ANY			0xffffffff
+
+#define EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
+#define EXT2_FEATURE_RO_COMPAT_LARGE_FILE	0x0002
+#define EXT2_FEATURE_RO_COMPAT_BTREE_DIR	0x0004
+#define EXT2_FEATURE_RO_COMPAT_ANY		0xffffffff
+
+#define EXT2_FEATURE_INCOMPAT_COMPRESSION	0x0001
+#define EXT2_FEATURE_INCOMPAT_FILETYPE		0x0002
+#define EXT3_FEATURE_INCOMPAT_RECOVER		0x0004
+#define EXT3_FEATURE_INCOMPAT_JOURNAL_DEV	0x0008
+#define EXT2_FEATURE_INCOMPAT_ANY		0xffffffff
+
+#define EXT2_FEATURE_COMPAT_SUPP	0
+#define EXT2_FEATURE_INCOMPAT_SUPP	EXT2_FEATURE_INCOMPAT_FILETYPE
+#define EXT2_FEATURE_RO_COMPAT_SUPP	(EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER| \
+					 EXT2_FEATURE_RO_COMPAT_LARGE_FILE| \
+					 EXT2_FEATURE_RO_COMPAT_BTREE_DIR)
+#define EXT2_FEATURE_RO_COMPAT_UNSUPPORTED	~EXT2_FEATURE_RO_COMPAT_SUPP
+#define EXT2_FEATURE_INCOMPAT_UNSUPPORTED	~EXT2_FEATURE_INCOMPAT_SUPP
+
+/*
+ * Default values for user and/or group using reserved blocks
+ */
+#define	EXT2_DEF_RESUID		0
+#define	EXT2_DEF_RESGID		0
+
+/*
+ * Structure of a directory entry
+ */
+#define EXT2_NAME_LEN 255
+
+struct ext2_dir_entry {
+	__u32	inode;			/* Inode number */
+	__u16	rec_len;		/* Directory entry length */
+	__u16	name_len;		/* Name length */
+	char	name[EXT2_NAME_LEN];	/* File name */
+};
+
+/*
+ * The new version of the directory entry.  Since EXT2 structures are
+ * stored in intel byte order, and the name_len field could never be
+ * bigger than 255 chars, it's safe to reclaim the extra byte for the
+ * file_type field.
+ */
+struct ext2_dir_entry_2 {
+	__u32	inode;			/* Inode number */
+	__u16	rec_len;		/* Directory entry length */
+	__u8	name_len;		/* Name length */
+	__u8	file_type;
+	char	name[EXT2_NAME_LEN];	/* File name */
+};
+
+/*
+ * Ext2 directory file types.  Only the low 3 bits are used.  The
+ * other bits are reserved for now.
+ */
+enum {
+	EXT2_FT_UNKNOWN,
+	EXT2_FT_REG_FILE,
+	EXT2_FT_DIR,
+	EXT2_FT_CHRDEV,
+	EXT2_FT_BLKDEV,
+	EXT2_FT_FIFO,
+	EXT2_FT_SOCK,
+	EXT2_FT_SYMLINK,
+	EXT2_FT_MAX
+};
+
+/*
+ * EXT2_DIR_PAD defines the directory entries boundaries
+ *
+ * NOTE: It must be a multiple of 4
+ */
+#define EXT2_DIR_PAD		 	4
+#define EXT2_DIR_ROUND 			(EXT2_DIR_PAD - 1)
+#define EXT2_DIR_REC_LEN(name_len)	(((name_len) + 8 + EXT2_DIR_ROUND) & \
+					 ~EXT2_DIR_ROUND)
 
 /* balloc.c */
 extern int ext2_bg_has_super(struct super_block *sb, int group);
--- 2.5.5.clean/fs/ext2/ialloc.c	Wed Feb 20 03:11:03 2002
+++ 2.5.5/fs/ext2/ialloc.c	Sat Feb 23 15:52:00 2002
@@ -77,7 +77,7 @@
 					      unsigned int block_group)
 {
 	int i, slot = 0;
-	struct ext2_sb_info *sbi = &sb->u.ext2_sb;
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	struct buffer_head *bh = sbi->s_inode_bitmap[0];
 
 	if (block_group >= sbi->s_groups_count)
@@ -171,7 +171,7 @@
 	}
 
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
+	es = EXT2_SB(sb)->s_es;
 	is_directory = S_ISDIR(inode->i_mode);
 
 	/* Do this BEFORE marking the inode not in use or returning an error */
@@ -205,7 +205,7 @@
 		mark_buffer_dirty(bh2);
 		es->s_free_inodes_count =
 			cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) + 1);
-		mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+		mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
 	}
 	mark_buffer_dirty(bh);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
@@ -230,8 +230,8 @@
 
 static int find_group_dir(struct super_block *sb, int parent_group)
 {
-	struct ext2_super_block * es = sb->u.ext2_sb.s_es;
-	int ngroups = sb->u.ext2_sb.s_groups_count;
+	struct ext2_super_block * es = EXT2_SB(sb)->s_es;
+	int ngroups = EXT2_SB(sb)->s_groups_count;
 	int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
 	struct ext2_group_desc *desc, *best_desc = NULL;
 	struct buffer_head *bh, *best_bh = NULL;
@@ -263,7 +263,7 @@
 
 static int find_group_other(struct super_block *sb, int parent_group)
 {
-	int ngroups = sb->u.ext2_sb.s_groups_count;
+	int ngroups = EXT2_SB(sb)->s_groups_count;
 	struct ext2_group_desc *desc;
 	struct buffer_head *bh;
 	int group, i;
@@ -330,7 +330,7 @@
 
 	ei = EXT2_I(inode);
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
+	es = EXT2_SB(sb)->s_es;
 repeat:
 	if (S_ISDIR(mode))
 		group = find_group_dir(sb, EXT2_I(dir)->i_block_group);
@@ -369,7 +369,7 @@
 
 	es->s_free_inodes_count =
 		cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) - 1);
-	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
 	sb->s_dirt = 1;
 	inode->i_uid = current->fsuid;
 	if (test_opt (sb, GRPID))
@@ -405,7 +405,7 @@
 	ei->i_dir_start_lookup = 0;
 	if (ei->i_flags & EXT2_SYNC_FL)
 		inode->i_flags |= S_SYNC;
-	inode->i_generation = sb->u.ext2_sb.s_next_generation++;
+	inode->i_generation = EXT2_SB(sb)->s_next_generation++;
 	insert_inode_hash(inode);
 	mark_inode_dirty(inode);
 
@@ -457,8 +457,8 @@
 	int i;
 
 	lock_super (sb);
-	es = sb->u.ext2_sb.s_es;
-	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
+	es = EXT2_SB(sb)->s_es;
+	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
 		struct ext2_group_desc *desc = ext2_get_group_desc (sb, i, NULL);
 		struct buffer_head *bh;
 		unsigned x;
@@ -480,7 +480,7 @@
 	unlock_super (sb);
 	return desc_count;
 #else
-	return le32_to_cpu(sb->u.ext2_sb.s_es->s_free_inodes_count);
+	return le32_to_cpu(EXT2_SB(sb)->s_es->s_free_inodes_count);
 #endif
 }
 
@@ -488,11 +488,11 @@
 /* Called at mount-time, super-block is locked */
 void ext2_check_inodes_bitmap (struct super_block * sb)
 {
-	struct ext2_super_block * es = sb->u.ext2_sb.s_es;
+	struct ext2_super_block * es = EXT2_SB(sb)->s_es;
 	unsigned long desc_count = 0, bitmap_count = 0;
 	int i;
 
-	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
+	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
 		struct ext2_group_desc *desc = ext2_get_group_desc(sb, i, NULL);
 		struct buffer_head *bh;
 		unsigned x;
--- 2.5.5.clean/fs/ext2/inode.c	Wed Feb 20 03:10:55 2002
+++ 2.5.5/fs/ext2/inode.c	Sat Feb 23 15:52:00 2002
@@ -303,7 +303,7 @@
 	 * the same cylinder group then.
 	 */
 	return (ei->i_block_group * EXT2_BLOCKS_PER_GROUP(inode->i_sb)) +
-	       le32_to_cpu(inode->i_sb->u.ext2_sb.s_es->s_first_data_block);
+	       le32_to_cpu(EXT2_SB(inode->i_sb)->s_es->s_first_data_block);
 }
 
 /**
@@ -886,7 +886,7 @@
 	*p = NULL;
 	if ((ino != EXT2_ROOT_INO && ino != EXT2_ACL_IDX_INO &&
 	     ino != EXT2_ACL_DATA_INO && ino < EXT2_FIRST_INO(sb)) ||
-	    ino > le32_to_cpu(sb->u.ext2_sb.s_es->s_inodes_count))
+	    ino > le32_to_cpu(EXT2_SB(sb)->s_es->s_inodes_count))
 		goto Einval;
 
 	block_group = (ino - 1) / EXT2_INODES_PER_GROUP(sb);
--- 2.5.5.clean/fs/ext2/super.c	Wed Feb 20 03:11:04 2002
+++ 2.5.5/fs/ext2/super.c	Sat Feb 23 15:52:00 2002
@@ -40,7 +40,7 @@
 	struct ext2_super_block *es = EXT2_SB(sb)->s_es;
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		sb->u.ext2_sb.s_mount_state |= EXT2_ERROR_FS;
+		EXT2_SB(sb)->s_mount_state |= EXT2_ERROR_FS;
 		es->s_state =
 			cpu_to_le16(le16_to_cpu(es->s_state) | EXT2_ERROR_FS);
 		ext2_sync_super(sb, es);
@@ -49,14 +49,14 @@
 	vsprintf (error_buf, fmt, args);
 	va_end (args);
 	if (test_opt (sb, ERRORS_PANIC) ||
-	    (le16_to_cpu(sb->u.ext2_sb.s_es->s_errors) == EXT2_ERRORS_PANIC &&
+	    (le16_to_cpu(EXT2_SB(sb)->s_es->s_errors) == EXT2_ERRORS_PANIC &&
 	     !test_opt (sb, ERRORS_CONT) && !test_opt (sb, ERRORS_RO)))
 		panic ("EXT2-fs panic (device %s): %s: %s\n",
 		       sb->s_id, function, error_buf);
 	printk (KERN_CRIT "EXT2-fs error (device %s): %s: %s\n",
 		sb->s_id, function, error_buf);
 	if (test_opt (sb, ERRORS_RO) ||
-	    (le16_to_cpu(sb->u.ext2_sb.s_es->s_errors) == EXT2_ERRORS_RO &&
+	    (le16_to_cpu(EXT2_SB(sb)->s_es->s_errors) == EXT2_ERRORS_RO &&
 	     !test_opt (sb, ERRORS_CONT) && !test_opt (sb, ERRORS_PANIC))) {
 		printk ("Remounting filesystem read-only\n");
 		sb->s_flags |= MS_RDONLY;
@@ -69,10 +69,10 @@
 	va_list args;
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		sb->u.ext2_sb.s_mount_state |= EXT2_ERROR_FS;
-		sb->u.ext2_sb.s_es->s_state =
-			cpu_to_le16(le16_to_cpu(sb->u.ext2_sb.s_es->s_state) | EXT2_ERROR_FS);
-		mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+		EXT2_SB(sb)->s_mount_state |= EXT2_ERROR_FS;
+		EXT2_SB(sb)->s_es->s_state =
+			cpu_to_le16(le16_to_cpu(EXT2_SB(sb)->s_es->s_state) | EXT2_ERROR_FS);
+		mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
 		sb->s_dirt = 1;
 	}
 	va_start (args, fmt);
@@ -133,16 +133,16 @@
 	}
 	db_count = EXT2_SB(sb)->s_gdb_count;
 	for (i = 0; i < db_count; i++)
-		if (sb->u.ext2_sb.s_group_desc[i])
-			brelse (sb->u.ext2_sb.s_group_desc[i]);
-	kfree(sb->u.ext2_sb.s_group_desc);
+		if (EXT2_SB(sb)->s_group_desc[i])
+			brelse (EXT2_SB(sb)->s_group_desc[i]);
+	kfree(EXT2_SB(sb)->s_group_desc);
 	for (i = 0; i < EXT2_MAX_GROUP_LOADED; i++)
-		if (sb->u.ext2_sb.s_inode_bitmap[i])
-			brelse (sb->u.ext2_sb.s_inode_bitmap[i]);
+		if (EXT2_SB(sb)->s_inode_bitmap[i])
+			brelse (EXT2_SB(sb)->s_inode_bitmap[i]);
 	for (i = 0; i < EXT2_MAX_GROUP_LOADED; i++)
-		if (sb->u.ext2_sb.s_block_bitmap[i])
-			brelse (sb->u.ext2_sb.s_block_bitmap[i]);
-	brelse (sb->u.ext2_sb.s_sbh);
+		if (EXT2_SB(sb)->s_block_bitmap[i])
+			brelse (EXT2_SB(sb)->s_block_bitmap[i]);
+	brelse (EXT2_SB(sb)->s_sbh);
 
 	return;
 }
@@ -340,10 +340,10 @@
 	}
 	if (read_only)
 		return res;
-	if (!(sb->u.ext2_sb.s_mount_state & EXT2_VALID_FS))
+	if (!(EXT2_SB(sb)->s_mount_state & EXT2_VALID_FS))
 		printk ("EXT2-fs warning: mounting unchecked fs, "
 			"running e2fsck is recommended\n");
-	else if ((sb->u.ext2_sb.s_mount_state & EXT2_ERROR_FS))
+	else if ((EXT2_SB(sb)->s_mount_state & EXT2_ERROR_FS))
 		printk ("EXT2-fs warning: mounting fs with errors, "
 			"running e2fsck is recommended\n");
 	else if ((__s16) le16_to_cpu(es->s_max_mnt_count) >= 0 &&
@@ -363,11 +363,11 @@
 		printk ("[EXT II FS %s, %s, bs=%lu, fs=%lu, gc=%lu, "
 			"bpg=%lu, ipg=%lu, mo=%04lx]\n",
 			EXT2FS_VERSION, EXT2FS_DATE, sb->s_blocksize,
-			sb->u.ext2_sb.s_frag_size,
-			sb->u.ext2_sb.s_groups_count,
+			EXT2_SB(sb)->s_frag_size,
+			EXT2_SB(sb)->s_groups_count,
 			EXT2_BLOCKS_PER_GROUP(sb),
 			EXT2_INODES_PER_GROUP(sb),
-			sb->u.ext2_sb.s_mount_opt);
+			EXT2_SB(sb)->s_mount_opt);
 #ifdef CONFIG_EXT2_CHECK
 	if (test_opt (sb, CHECK)) {
 		ext2_check_blocks_bitmap (sb);
@@ -381,15 +381,15 @@
 {
 	int i;
 	int desc_block = 0;
-	unsigned long block = le32_to_cpu(sb->u.ext2_sb.s_es->s_first_data_block);
+	unsigned long block = le32_to_cpu(EXT2_SB(sb)->s_es->s_first_data_block);
 	struct ext2_group_desc * gdp = NULL;
 
 	ext2_debug ("Checking group descriptors");
 
-	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++)
+	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++)
 	{
 		if ((i % EXT2_DESC_PER_BLOCK(sb)) == 0)
-			gdp = (struct ext2_group_desc *) sb->u.ext2_sb.s_group_desc[desc_block++]->b_data;
+			gdp = (struct ext2_group_desc *) EXT2_SB(sb)->s_group_desc[desc_block++]->b_data;
 		if (le32_to_cpu(gdp->bg_block_bitmap) < block ||
 		    le32_to_cpu(gdp->bg_block_bitmap) >= block + EXT2_BLOCKS_PER_GROUP(sb))
 		{
@@ -409,7 +409,7 @@
 			return 0;
 		}
 		if (le32_to_cpu(gdp->bg_inode_table) < block ||
-		    le32_to_cpu(gdp->bg_inode_table) + sb->u.ext2_sb.s_itb_per_group >=
+		    le32_to_cpu(gdp->bg_inode_table) + EXT2_SB(sb)->s_itb_per_group >=
 		    block + EXT2_BLOCKS_PER_GROUP(sb))
 		{
 			ext2_error (sb, "ext2_check_descriptors",
@@ -464,9 +464,9 @@
 	 * sectorsize that is larger than the default.
 	 */
 
-	sb->u.ext2_sb.s_mount_opt = 0;
+	EXT2_SB(sb)->s_mount_opt = 0;
 	if (!parse_options ((char *) data, &sb_block, &resuid, &resgid,
-	    &sb->u.ext2_sb.s_mount_opt))
+	    &EXT2_SB(sb)->s_mount_opt))
 		return -EINVAL;
 
 	blocksize = sb_min_blocksize(sb, BLOCK_SIZE);
@@ -494,7 +494,7 @@
 	 *       some ext2 macro-instructions depend on its value
 	 */
 	es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
-	sb->u.ext2_sb.s_es = es;
+	EXT2_SB(sb)->s_es = es;
 	sb->s_magic = le16_to_cpu(es->s_magic);
 	if (sb->s_magic != EXT2_SUPER_MAGIC) {
 		if (!silent)
@@ -545,7 +545,7 @@
 			goto failed_mount;
 		}
 		es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
-		sb->u.ext2_sb.s_es = es;
+		EXT2_SB(sb)->s_es = es;
 		if (es->s_magic != le16_to_cpu(EXT2_SUPER_MAGIC)) {
 			printk ("EXT2-fs: Magic mismatch, very weird !\n");
 			goto failed_mount;
@@ -555,46 +555,46 @@
 	sb->s_maxbytes = ext2_max_size(sb->s_blocksize_bits);
 
 	if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV) {
-		sb->u.ext2_sb.s_inode_size = EXT2_GOOD_OLD_INODE_SIZE;
-		sb->u.ext2_sb.s_first_ino = EXT2_GOOD_OLD_FIRST_INO;
+		EXT2_SB(sb)->s_inode_size = EXT2_GOOD_OLD_INODE_SIZE;
+		EXT2_SB(sb)->s_first_ino = EXT2_GOOD_OLD_FIRST_INO;
 	} else {
-		sb->u.ext2_sb.s_inode_size = le16_to_cpu(es->s_inode_size);
-		sb->u.ext2_sb.s_first_ino = le32_to_cpu(es->s_first_ino);
-		if (sb->u.ext2_sb.s_inode_size != EXT2_GOOD_OLD_INODE_SIZE) {
+		EXT2_SB(sb)->s_inode_size = le16_to_cpu(es->s_inode_size);
+		EXT2_SB(sb)->s_first_ino = le32_to_cpu(es->s_first_ino);
+		if (EXT2_SB(sb)->s_inode_size != EXT2_GOOD_OLD_INODE_SIZE) {
 			printk ("EXT2-fs: unsupported inode size: %d\n",
-				sb->u.ext2_sb.s_inode_size);
+				EXT2_SB(sb)->s_inode_size);
 			goto failed_mount;
 		}
 	}
-	sb->u.ext2_sb.s_frag_size = EXT2_MIN_FRAG_SIZE <<
+	EXT2_SB(sb)->s_frag_size = EXT2_MIN_FRAG_SIZE <<
 				   le32_to_cpu(es->s_log_frag_size);
-	if (sb->u.ext2_sb.s_frag_size)
-		sb->u.ext2_sb.s_frags_per_block = sb->s_blocksize /
-						  sb->u.ext2_sb.s_frag_size;
+	if (EXT2_SB(sb)->s_frag_size)
+		EXT2_SB(sb)->s_frags_per_block = sb->s_blocksize /
+						  EXT2_SB(sb)->s_frag_size;
 	else
 		sb->s_magic = 0;
-	sb->u.ext2_sb.s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
-	sb->u.ext2_sb.s_frags_per_group = le32_to_cpu(es->s_frags_per_group);
-	sb->u.ext2_sb.s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
-	sb->u.ext2_sb.s_inodes_per_block = sb->s_blocksize /
+	EXT2_SB(sb)->s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
+	EXT2_SB(sb)->s_frags_per_group = le32_to_cpu(es->s_frags_per_group);
+	EXT2_SB(sb)->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
+	EXT2_SB(sb)->s_inodes_per_block = sb->s_blocksize /
 					   EXT2_INODE_SIZE(sb);
-	sb->u.ext2_sb.s_itb_per_group = sb->u.ext2_sb.s_inodes_per_group /
-				        sb->u.ext2_sb.s_inodes_per_block;
-	sb->u.ext2_sb.s_desc_per_block = sb->s_blocksize /
+	EXT2_SB(sb)->s_itb_per_group = EXT2_SB(sb)->s_inodes_per_group /
+				        EXT2_SB(sb)->s_inodes_per_block;
+	EXT2_SB(sb)->s_desc_per_block = sb->s_blocksize /
 					 sizeof (struct ext2_group_desc);
-	sb->u.ext2_sb.s_sbh = bh;
+	EXT2_SB(sb)->s_sbh = bh;
 	if (resuid != EXT2_DEF_RESUID)
-		sb->u.ext2_sb.s_resuid = resuid;
+		EXT2_SB(sb)->s_resuid = resuid;
 	else
-		sb->u.ext2_sb.s_resuid = le16_to_cpu(es->s_def_resuid);
+		EXT2_SB(sb)->s_resuid = le16_to_cpu(es->s_def_resuid);
 	if (resgid != EXT2_DEF_RESGID)
-		sb->u.ext2_sb.s_resgid = resgid;
+		EXT2_SB(sb)->s_resgid = resgid;
 	else
-		sb->u.ext2_sb.s_resgid = le16_to_cpu(es->s_def_resgid);
-	sb->u.ext2_sb.s_mount_state = le16_to_cpu(es->s_state);
-	sb->u.ext2_sb.s_addr_per_block_bits =
+		EXT2_SB(sb)->s_resgid = le16_to_cpu(es->s_def_resgid);
+	EXT2_SB(sb)->s_mount_state = le16_to_cpu(es->s_state);
+	EXT2_SB(sb)->s_addr_per_block_bits =
 		log2 (EXT2_ADDR_PER_BLOCK(sb));
-	sb->u.ext2_sb.s_desc_per_block_bits =
+	EXT2_SB(sb)->s_desc_per_block_bits =
 		log2 (EXT2_DESC_PER_BLOCK(sb));
 	if (sb->s_magic != EXT2_SUPER_MAGIC) {
 		if (!silent)
@@ -610,45 +610,45 @@
 		goto failed_mount;
 	}
 
-	if (sb->s_blocksize != sb->u.ext2_sb.s_frag_size) {
+	if (sb->s_blocksize != EXT2_SB(sb)->s_frag_size) {
 		printk ("EXT2-fs: fragsize %lu != blocksize %lu (not supported yet)\n",
-			sb->u.ext2_sb.s_frag_size, sb->s_blocksize);
+			EXT2_SB(sb)->s_frag_size, sb->s_blocksize);
 		goto failed_mount;
 	}
 
-	if (sb->u.ext2_sb.s_blocks_per_group > sb->s_blocksize * 8) {
+	if (EXT2_SB(sb)->s_blocks_per_group > sb->s_blocksize * 8) {
 		printk ("EXT2-fs: #blocks per group too big: %lu\n",
-			sb->u.ext2_sb.s_blocks_per_group);
+			EXT2_SB(sb)->s_blocks_per_group);
 		goto failed_mount;
 	}
-	if (sb->u.ext2_sb.s_frags_per_group > sb->s_blocksize * 8) {
+	if (EXT2_SB(sb)->s_frags_per_group > sb->s_blocksize * 8) {
 		printk ("EXT2-fs: #fragments per group too big: %lu\n",
-			sb->u.ext2_sb.s_frags_per_group);
+			EXT2_SB(sb)->s_frags_per_group);
 		goto failed_mount;
 	}
-	if (sb->u.ext2_sb.s_inodes_per_group > sb->s_blocksize * 8) {
+	if (EXT2_SB(sb)->s_inodes_per_group > sb->s_blocksize * 8) {
 		printk ("EXT2-fs: #inodes per group too big: %lu\n",
-			sb->u.ext2_sb.s_inodes_per_group);
+			EXT2_SB(sb)->s_inodes_per_group);
 		goto failed_mount;
 	}
 
-	sb->u.ext2_sb.s_groups_count = (le32_to_cpu(es->s_blocks_count) -
+	EXT2_SB(sb)->s_groups_count = (le32_to_cpu(es->s_blocks_count) -
 				        le32_to_cpu(es->s_first_data_block) +
 				       EXT2_BLOCKS_PER_GROUP(sb) - 1) /
 				       EXT2_BLOCKS_PER_GROUP(sb);
-	db_count = (sb->u.ext2_sb.s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1) /
+	db_count = (EXT2_SB(sb)->s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1) /
 		   EXT2_DESC_PER_BLOCK(sb);
-	sb->u.ext2_sb.s_group_desc = kmalloc (db_count * sizeof (struct buffer_head *), GFP_KERNEL);
-	if (sb->u.ext2_sb.s_group_desc == NULL) {
+	EXT2_SB(sb)->s_group_desc = kmalloc (db_count * sizeof (struct buffer_head *), GFP_KERNEL);
+	if (EXT2_SB(sb)->s_group_desc == NULL) {
 		printk ("EXT2-fs: not enough memory\n");
 		goto failed_mount;
 	}
 	for (i = 0; i < db_count; i++) {
-		sb->u.ext2_sb.s_group_desc[i] = sb_bread(sb, logic_sb_block + i + 1);
-		if (!sb->u.ext2_sb.s_group_desc[i]) {
+		EXT2_SB(sb)->s_group_desc[i] = sb_bread(sb, logic_sb_block + i + 1);
+		if (!EXT2_SB(sb)->s_group_desc[i]) {
 			for (j = 0; j < i; j++)
-				brelse (sb->u.ext2_sb.s_group_desc[j]);
-			kfree(sb->u.ext2_sb.s_group_desc);
+				brelse (EXT2_SB(sb)->s_group_desc[j]);
+			kfree(EXT2_SB(sb)->s_group_desc);
 			printk ("EXT2-fs: unable to read group descriptors\n");
 			goto failed_mount;
 		}
@@ -659,15 +659,15 @@
 		goto failed_mount2;
 	}
 	for (i = 0; i < EXT2_MAX_GROUP_LOADED; i++) {
-		sb->u.ext2_sb.s_inode_bitmap_number[i] = 0;
-		sb->u.ext2_sb.s_inode_bitmap[i] = NULL;
-		sb->u.ext2_sb.s_block_bitmap_number[i] = 0;
-		sb->u.ext2_sb.s_block_bitmap[i] = NULL;
-	}
-	sb->u.ext2_sb.s_loaded_inode_bitmaps = 0;
-	sb->u.ext2_sb.s_loaded_block_bitmaps = 0;
-	sb->u.ext2_sb.s_gdb_count = db_count;
-	get_random_bytes(&sb->u.ext2_sb.s_next_generation, sizeof(u32));
+		EXT2_SB(sb)->s_inode_bitmap_number[i] = 0;
+		EXT2_SB(sb)->s_inode_bitmap[i] = NULL;
+		EXT2_SB(sb)->s_block_bitmap_number[i] = 0;
+		EXT2_SB(sb)->s_block_bitmap[i] = NULL;
+	}
+	EXT2_SB(sb)->s_loaded_inode_bitmaps = 0;
+	EXT2_SB(sb)->s_loaded_block_bitmaps = 0;
+	EXT2_SB(sb)->s_gdb_count = db_count;
+	get_random_bytes(&EXT2_SB(sb)->s_next_generation, sizeof(u32));
 	/*
 	 * set up enough so that it can read an inode
 	 */
@@ -687,8 +687,8 @@
 	return 0;
 failed_mount2:
 	for (i = 0; i < db_count; i++)
-		brelse(sb->u.ext2_sb.s_group_desc[i]);
-	kfree(sb->u.ext2_sb.s_group_desc);
+		brelse(EXT2_SB(sb)->s_group_desc[i]);
+	kfree(EXT2_SB(sb)->s_group_desc);
 failed_mount:
 	brelse(bh);
 	return -EINVAL;
@@ -698,7 +698,7 @@
 			       struct ext2_super_block * es)
 {
 	es->s_wtime = cpu_to_le32(CURRENT_TIME);
-	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
 	sb->s_dirt = 0;
 }
 
@@ -727,7 +727,7 @@
 	struct ext2_super_block * es;
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		es = sb->u.ext2_sb.s_es;
+		es = EXT2_SB(sb)->s_es;
 
 		if (le16_to_cpu(es->s_state) & EXT2_VALID_FS) {
 			ext2_debug ("setting valid to 0\n");
@@ -744,34 +744,34 @@
 int ext2_remount (struct super_block * sb, int * flags, char * data)
 {
 	struct ext2_super_block * es;
-	unsigned short resuid = sb->u.ext2_sb.s_resuid;
-	unsigned short resgid = sb->u.ext2_sb.s_resgid;
+	unsigned short resuid = EXT2_SB(sb)->s_resuid;
+	unsigned short resgid = EXT2_SB(sb)->s_resgid;
 	unsigned long new_mount_opt;
 	unsigned long tmp;
 
 	/*
 	 * Allow the "check" option to be passed as a remount option.
 	 */
-	new_mount_opt = sb->u.ext2_sb.s_mount_opt;
+	new_mount_opt = EXT2_SB(sb)->s_mount_opt;
 	if (!parse_options (data, &tmp, &resuid, &resgid,
 			    &new_mount_opt))
 		return -EINVAL;
 
-	sb->u.ext2_sb.s_mount_opt = new_mount_opt;
-	sb->u.ext2_sb.s_resuid = resuid;
-	sb->u.ext2_sb.s_resgid = resgid;
-	es = sb->u.ext2_sb.s_es;
+	EXT2_SB(sb)->s_mount_opt = new_mount_opt;
+	EXT2_SB(sb)->s_resuid = resuid;
+	EXT2_SB(sb)->s_resgid = resgid;
+	es = EXT2_SB(sb)->s_es;
 	if ((*flags & MS_RDONLY) == (sb->s_flags & MS_RDONLY))
 		return 0;
 	if (*flags & MS_RDONLY) {
 		if (le16_to_cpu(es->s_state) & EXT2_VALID_FS ||
-		    !(sb->u.ext2_sb.s_mount_state & EXT2_VALID_FS))
+		    !(EXT2_SB(sb)->s_mount_state & EXT2_VALID_FS))
 			return 0;
 		/*
 		 * OK, we are remounting a valid rw partition rdonly, so set
 		 * the rdonly flag and then mark the partition as valid again.
 		 */
-		es->s_state = cpu_to_le16(sb->u.ext2_sb.s_mount_state);
+		es->s_state = cpu_to_le16(EXT2_SB(sb)->s_mount_state);
 		es->s_mtime = cpu_to_le32(CURRENT_TIME);
 	} else {
 		int ret;
@@ -787,7 +787,7 @@
 		 * store the current valid flag.  (It may have been changed
 		 * by e2fsck since we originally mounted the partition.)
 		 */
-		sb->u.ext2_sb.s_mount_state = le16_to_cpu(es->s_state);
+		EXT2_SB(sb)->s_mount_state = le16_to_cpu(es->s_state);
 		if (!ext2_setup_super (sb, es, 0))
 			sb->s_flags &= ~MS_RDONLY;
 	}
@@ -811,7 +811,7 @@
 		 * All of the blocks before first_data_block are
 		 * overhead
 		 */
-		overhead = le32_to_cpu(sb->u.ext2_sb.s_es->s_first_data_block);
+		overhead = le32_to_cpu(EXT2_SB(sb)->s_es->s_first_data_block);
 
 		/*
 		 * Add the overhead attributed to the superblock and
@@ -826,18 +826,18 @@
 		 * Every block group has an inode bitmap, a block
 		 * bitmap, and an inode table.
 		 */
-		overhead += (sb->u.ext2_sb.s_groups_count *
-			     (2 + sb->u.ext2_sb.s_itb_per_group));
+		overhead += (EXT2_SB(sb)->s_groups_count *
+			     (2 + EXT2_SB(sb)->s_itb_per_group));
 	}
 
 	buf->f_type = EXT2_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
-	buf->f_blocks = le32_to_cpu(sb->u.ext2_sb.s_es->s_blocks_count) - overhead;
+	buf->f_blocks = le32_to_cpu(EXT2_SB(sb)->s_es->s_blocks_count) - overhead;
 	buf->f_bfree = ext2_count_free_blocks (sb);
-	buf->f_bavail = buf->f_bfree - le32_to_cpu(sb->u.ext2_sb.s_es->s_r_blocks_count);
-	if (buf->f_bfree < le32_to_cpu(sb->u.ext2_sb.s_es->s_r_blocks_count))
+	buf->f_bavail = buf->f_bfree - le32_to_cpu(EXT2_SB(sb)->s_es->s_r_blocks_count);
+	if (buf->f_bfree < le32_to_cpu(EXT2_SB(sb)->s_es->s_r_blocks_count))
 		buf->f_bavail = 0;
-	buf->f_files = le32_to_cpu(sb->u.ext2_sb.s_es->s_inodes_count);
+	buf->f_files = le32_to_cpu(EXT2_SB(sb)->s_es->s_inodes_count);
 	buf->f_ffree = ext2_count_free_inodes (sb);
 	buf->f_namelen = EXT2_NAME_LEN;
 	return 0;
@@ -849,9 +849,26 @@
 	return get_sb_bdev(fs_type, flags, dev_name, data, ext2_fill_super);
 }
 
+static struct super_block *ext2_alloc_super(void)
+{
+	struct ext2_sb_info *sbi = (struct ext2_sb_info *)
+		kmalloc(sizeof(struct ext2_sb_info), GFP_USER);
+	if (!sbi)
+		return NULL;
+	memset(sbi, 0, sizeof(struct ext2_sb_info));
+	return &sbi->vfs_super;
+}
+
+static inline void ext2_destroy_super(struct super_block *sb)
+{
+	kfree(EXT2_SB(sb));
+}
+
 static struct file_system_type ext2_fs_type = {
 	owner:		THIS_MODULE,
 	name:		"ext2",
+	alloc_super:	ext2_alloc_super,
+	destroy_super:	ext2_destroy_super,
 	get_sb:		ext2_get_sb,
 	fs_flags:	FS_REQUIRES_DEV,
 };
--- 2.5.5.clean/include/linux/fs.h	Sat Feb 23 15:52:25 2002
+++ 2.5.5/include/linux/fs.h	Sat Feb 23 15:52:01 2002
@@ -649,7 +649,6 @@
 #define MNT_DETACH	0x00000002	/* Just detach from the tree */
 
 #include <linux/minix_fs_sb.h>
-#include <linux/ext2_fs_sb.h>
 #include <linux/ext3_fs_sb.h>
 #include <linux/hpfs_fs_sb.h>
 #include <linux/ntfs_fs_sb.h>
@@ -707,7 +706,6 @@
 
 	union {
 		struct minix_sb_info	minix_sb;
-		struct ext2_sb_info	ext2_sb;
 		struct ext3_sb_info	ext3_sb;
 		struct hpfs_sb_info	hpfs_sb;
 		struct ntfs_sb_info	ntfs_sb;


