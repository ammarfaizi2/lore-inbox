Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289206AbSAGNXe>; Mon, 7 Jan 2002 08:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289199AbSAGNWh>; Mon, 7 Jan 2002 08:22:37 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37005 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S289190AbSAGNV1>;
	Mon, 7 Jan 2002 08:21:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: torvalds@transmeta.com, viro@math.psu.edu, phillips@bonn-fries.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: PATCH 2.5.2.9: ext2 unbork fs.h (part 5/7)
Message-Id: <20020107132122.9DBB71F6E@gtf.org>
Date: Mon,  7 Jan 2002 07:21:22 -0600 (CST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch5 desc: move include/linux/ext2*.h to fs/ext2




diff -Naur -X /g/g/lib/dontdiff linux-fs4/fs/ext2/balloc.c linux-fs5/fs/ext2/balloc.c
--- linux-fs4/fs/ext2/balloc.c	Mon Jan  7 01:53:43 2002
+++ linux-fs5/fs/ext2/balloc.c	Mon Jan  7 07:32:18 2002
@@ -13,8 +13,8 @@
 
 #include <linux/config.h>
 #include <linux/fs.h>
-#include <linux/ext2_fs.h>
-#include <linux/ext2_fs_sb.h>
+#include "ext2_fs.h"
+#include "ext2_fs_sb.h"
 #include <linux/locks.h>
 #include <linux/quotaops.h>
 
diff -Naur -X /g/g/lib/dontdiff linux-fs4/fs/ext2/bitmap.c linux-fs5/fs/ext2/bitmap.c
--- linux-fs4/fs/ext2/bitmap.c	Wed Sep 27 20:41:33 2000
+++ linux-fs5/fs/ext2/bitmap.c	Mon Jan  7 07:32:22 2002
@@ -8,7 +8,7 @@
  */
 
 #include <linux/fs.h>
-#include <linux/ext2_fs.h>
+#include "ext2_fs.h"
 
 
 static int nibblemap[] = {4, 3, 3, 2, 3, 2, 2, 1, 3, 2, 2, 1, 2, 1, 1, 0};
diff -Naur -X /g/g/lib/dontdiff linux-fs4/fs/ext2/dir.c linux-fs5/fs/ext2/dir.c
--- linux-fs4/fs/ext2/dir.c	Mon Jan  7 02:01:30 2002
+++ linux-fs5/fs/ext2/dir.c	Mon Jan  7 07:32:28 2002
@@ -22,9 +22,9 @@
  */
 
 #include <linux/fs.h>
-#include <linux/ext2_fs.h>
-#include <linux/ext2_fs_sb.h>
-#include <linux/ext2_fs_i.h>
+#include "ext2_fs.h"
+#include "ext2_fs_sb.h"
+#include "ext2_fs_i.h"
 #include <linux/pagemap.h>
 
 typedef struct ext2_dir_entry_2 ext2_dirent;
diff -Naur -X /g/g/lib/dontdiff linux-fs4/fs/ext2/ext2_fs.h linux-fs5/fs/ext2/ext2_fs.h
--- linux-fs4/fs/ext2/ext2_fs.h	Thu Jan  1 00:00:00 1970
+++ linux-fs5/fs/ext2/ext2_fs.h	Mon Jan  7 07:54:14 2002
@@ -0,0 +1,651 @@
+/*
+ *  linux/include/linux/ext2_fs.h
+ *
+ * Copyright (C) 1992, 1993, 1994, 1995
+ * Remy Card (card@masi.ibp.fr)
+ * Laboratoire MASI - Institut Blaise Pascal
+ * Universite Pierre et Marie Curie (Paris VI)
+ *
+ *  from
+ *
+ *  linux/include/linux/minix_fs.h
+ *
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ */
+
+#ifndef _LINUX_EXT2_FS_H
+#define _LINUX_EXT2_FS_H
+
+#include <linux/types.h>
+#include <linux/slab.h>
+
+/*
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
+#ifdef __KERNEL__
+# define EXT2_BLOCK_SIZE(s)		((s)->s_blocksize)
+#else
+# define EXT2_BLOCK_SIZE(s)		(EXT2_MIN_BLOCK_SIZE << (s)->s_log_block_size)
+#endif
+#define EXT2_ACLE_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (struct ext2_acl_entry))
+#define	EXT2_ADDR_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (__u32))
+#ifdef __KERNEL__
+# define EXT2_BLOCK_SIZE_BITS(s)	((s)->s_blocksize_bits)
+#else
+# define EXT2_BLOCK_SIZE_BITS(s)	((s)->s_log_block_size + 10)
+#endif
+#ifdef __KERNEL__
+#define	EXT2_ADDR_PER_BLOCK_BITS(s)	(ext2_sb(s)->s_addr_per_block_bits)
+#define EXT2_INODE_SIZE(s)		(ext2_sb(s)->s_inode_size)
+#define EXT2_FIRST_INO(s)		(ext2_sb(s)->s_first_ino)
+#else
+#define EXT2_INODE_SIZE(s)	(((s)->s_rev_level == EXT2_GOOD_OLD_REV) ? \
+				 EXT2_GOOD_OLD_INODE_SIZE : \
+				 (s)->s_inode_size)
+#define EXT2_FIRST_INO(s)	(((s)->s_rev_level == EXT2_GOOD_OLD_REV) ? \
+				 EXT2_GOOD_OLD_FIRST_INO : \
+				 (s)->s_first_ino)
+#endif
+
+/*
+ * Macro-instructions used to manage fragments
+ */
+#define EXT2_MIN_FRAG_SIZE		1024
+#define	EXT2_MAX_FRAG_SIZE		4096
+#define EXT2_MIN_FRAG_LOG_SIZE		  10
+#ifdef __KERNEL__
+# define EXT2_FRAG_SIZE(s)		(ext2_sb(s)->s_frag_size)
+# define EXT2_FRAGS_PER_BLOCK(s)	(ext2_sb(s)->s_frags_per_block)
+#else
+# define EXT2_FRAG_SIZE(s)		(EXT2_MIN_FRAG_SIZE << (s)->s_log_frag_size)
+# define EXT2_FRAGS_PER_BLOCK(s)	(EXT2_BLOCK_SIZE(s) / EXT2_FRAG_SIZE(s))
+#endif
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
+#ifdef __KERNEL__
+# define EXT2_BLOCKS_PER_GROUP(s)	(ext2_sb(s)->s_blocks_per_group)
+# define EXT2_DESC_PER_BLOCK(s)		(ext2_sb(s)->s_desc_per_block)
+# define EXT2_INODES_PER_GROUP(s)	(ext2_sb(s)->s_inodes_per_group)
+# define EXT2_DESC_PER_BLOCK_BITS(s)	(ext2_sb(s)->s_desc_per_block_bits)
+#else
+# define EXT2_BLOCKS_PER_GROUP(s)	((s)->s_blocks_per_group)
+# define EXT2_DESC_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (struct ext2_group_desc))
+# define EXT2_INODES_PER_GROUP(s)	((s)->s_inodes_per_group)
+#endif
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
+#if defined(__KERNEL__) || defined(__linux__)
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
+#define test_opt(sb, opt)		(ext2_sb(sb)->s_mount_opt & \
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
+#ifdef __KERNEL__
+#define EXT2_SB		ext2_sb	/* unused */
+#else
+/* Assume that user mode programs are passing in an ext2fs superblock, not
+ * a kernel struct super_block.  This will allow us to call the feature-test
+ * macros from user land. */
+#define EXT2_SB(sb)	(sb)
+#endif
+
+/*
+ * Codes for operating systems
+ */
+#define EXT2_OS_LINUX		0
+#define EXT2_OS_HURD		1
+#define EXT2_OS_MASIX		2
+#define EXT2_OS_FREEBSD		3
+#define EXT2_OS_LITES		4
+
+/*
+ * Revision levels
+ */
+#define EXT2_GOOD_OLD_REV	0	/* The good old (original) format */
+#define EXT2_DYNAMIC_REV	1 	/* V2 format w/ dynamic inode sizes */
+
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
+
+#ifdef __KERNEL__
+/*
+ * Function prototypes
+ */
+
+/*
+ * Ok, these declarations are also in <linux/kernel.h> but none of the
+ * ext2 source programs needs to include it so they are duplicated here.
+ */
+# define NORET_TYPE    /**/
+# define ATTRIB_NORET  __attribute__((noreturn))
+# define NORET_AND     noreturn,
+
+/* balloc.c */
+extern int ext2_bg_has_super(struct super_block *sb, int group);
+extern unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
+extern int ext2_new_block (struct inode *, unsigned long,
+			   __u32 *, __u32 *, int *);
+extern void ext2_free_blocks (struct inode *, unsigned long,
+			      unsigned long);
+extern unsigned long ext2_count_free_blocks (struct super_block *);
+extern void ext2_check_blocks_bitmap (struct super_block *);
+extern struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
+						    unsigned int block_group,
+						    struct buffer_head ** bh);
+
+/* dir.c */
+extern int ext2_add_link (struct dentry *, struct inode *);
+extern ino_t ext2_inode_by_name(struct inode *, struct dentry *);
+extern int ext2_make_empty(struct inode *, struct inode *);
+extern struct ext2_dir_entry_2 * ext2_find_entry (struct inode *,struct dentry *, struct page **);
+extern int ext2_delete_entry (struct ext2_dir_entry_2 *, struct page *);
+extern int ext2_empty_dir (struct inode *);
+extern struct ext2_dir_entry_2 * ext2_dotdot (struct inode *, struct page **);
+extern void ext2_set_link(struct inode *, struct ext2_dir_entry_2 *, struct page *, struct inode *);
+
+/* fsync.c */
+extern int ext2_sync_file (struct file *, struct dentry *, int);
+extern int ext2_fsync_inode (struct inode *, int);
+
+/* ialloc.c */
+extern struct inode * ext2_new_inode (const struct inode *, int);
+extern void ext2_free_inode (struct inode *);
+extern unsigned long ext2_count_free_inodes (struct super_block *);
+extern void ext2_check_inodes_bitmap (struct super_block *);
+extern unsigned long ext2_count_free (struct buffer_head *, unsigned);
+
+/* inode.c */
+
+static inline struct ext2_inode_info *ext2_i(struct inode *inode)
+{
+	if (!inode->u.ext2_ip)
+		BUG();
+	return inode->u.ext2_ip;
+}
+
+extern void ext2_read_inode (struct inode *);
+extern void ext2_write_inode (struct inode *, int);
+extern void ext2_put_inode (struct inode *);
+extern void ext2_delete_inode (struct inode *);
+extern int ext2_sync_inode (struct inode *);
+extern void ext2_discard_prealloc (struct inode *);
+extern void ext2_truncate (struct inode *);
+extern void ext2_clear_inode (struct inode *inode);
+
+/* ioctl.c */
+extern int ext2_ioctl (struct inode *, struct file *, unsigned int,
+		       unsigned long);
+
+/* super.c */
+
+static inline struct ext2_sb_info *ext2_sb(struct super_block *sb)
+{
+	if (!sb->u.ext2_sbp)
+		BUG();
+	return sb->u.ext2_sbp;
+}
+
+extern kmem_cache_t *ext2_ino_cache;
+extern void ext2_error (struct super_block *, const char *, const char *, ...)
+	__attribute__ ((format (printf, 3, 4)));
+extern NORET_TYPE void ext2_panic (struct super_block *, const char *,
+				   const char *, ...)
+	__attribute__ ((NORET_AND format (printf, 3, 4)));
+extern void ext2_warning (struct super_block *, const char *, const char *, ...)
+	__attribute__ ((format (printf, 3, 4)));
+extern void ext2_update_dynamic_rev (struct super_block *sb);
+extern void ext2_put_super (struct super_block *);
+extern void ext2_write_super (struct super_block *);
+extern int ext2_remount (struct super_block *, int *, char *);
+extern struct super_block * ext2_read_super (struct super_block *,void *,int);
+extern int ext2_statfs (struct super_block *, struct statfs *);
+
+/*
+ * Inodes and files operations
+ */
+
+/* dir.c */
+extern struct file_operations ext2_dir_operations;
+
+/* file.c */
+extern struct inode_operations ext2_file_inode_operations;
+extern struct file_operations ext2_file_operations;
+
+/* inode.c */
+extern struct address_space_operations ext2_aops;
+
+/* namei.c */
+extern struct inode_operations ext2_dir_inode_operations;
+
+/* symlink.c */
+extern struct inode_operations ext2_fast_symlink_inode_operations;
+
+#endif	/* __KERNEL__ */
+
+#endif	/* _LINUX_EXT2_FS_H */
diff -Naur -X /g/g/lib/dontdiff linux-fs4/fs/ext2/ext2_fs_i.h linux-fs5/fs/ext2/ext2_fs_i.h
--- linux-fs4/fs/ext2/ext2_fs_i.h	Thu Jan  1 00:00:00 1970
+++ linux-fs5/fs/ext2/ext2_fs_i.h	Mon Sep 17 20:16:30 2001
@@ -0,0 +1,41 @@
+/*
+ *  linux/include/linux/ext2_fs_i.h
+ *
+ * Copyright (C) 1992, 1993, 1994, 1995
+ * Remy Card (card@masi.ibp.fr)
+ * Laboratoire MASI - Institut Blaise Pascal
+ * Universite Pierre et Marie Curie (Paris VI)
+ *
+ *  from
+ *
+ *  linux/include/linux/minix_fs_i.h
+ *
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ */
+
+#ifndef _LINUX_EXT2_FS_I
+#define _LINUX_EXT2_FS_I
+
+/*
+ * second extended file system inode data in memory
+ */
+struct ext2_inode_info {
+	__u32	i_data[15];
+	__u32	i_flags;
+	__u32	i_faddr;
+	__u8	i_frag_no;
+	__u8	i_frag_size;
+	__u16	i_osync;
+	__u32	i_file_acl;
+	__u32	i_dir_acl;
+	__u32	i_dtime;
+	__u32	i_block_group;
+	__u32	i_next_alloc_block;
+	__u32	i_next_alloc_goal;
+	__u32	i_prealloc_block;
+	__u32	i_prealloc_count;
+	__u32	i_dir_start_lookup;
+	int	i_new_inode:1;	/* Is a freshly allocated inode */
+};
+
+#endif	/* _LINUX_EXT2_FS_I */
diff -Naur -X /g/g/lib/dontdiff linux-fs4/fs/ext2/ext2_fs_sb.h linux-fs5/fs/ext2/ext2_fs_sb.h
--- linux-fs4/fs/ext2/ext2_fs_sb.h	Thu Jan  1 00:00:00 1970
+++ linux-fs5/fs/ext2/ext2_fs_sb.h	Sun Jan  6 23:29:25 2002
@@ -0,0 +1,62 @@
+/*
+ *  linux/include/linux/ext2_fs_sb.h
+ *
+ * Copyright (C) 1992, 1993, 1994, 1995
+ * Remy Card (card@masi.ibp.fr)
+ * Laboratoire MASI - Institut Blaise Pascal
+ * Universite Pierre et Marie Curie (Paris VI)
+ *
+ *  from
+ *
+ *  linux/include/linux/minix_fs_sb.h
+ *
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ */
+
+#ifndef _LINUX_EXT2_FS_SB
+#define _LINUX_EXT2_FS_SB
+
+/*
+ * The following is not needed anymore since the descriptors buffer
+ * heads are now dynamically allocated
+ */
+/* #define EXT2_MAX_GROUP_DESC	8 */
+
+#define EXT2_MAX_GROUP_LOADED	8
+
+/*
+ * second extended-fs super-block data in memory
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
+};
+
+#endif	/* _LINUX_EXT2_FS_SB */
diff -Naur -X /g/g/lib/dontdiff linux-fs4/fs/ext2/file.c linux-fs5/fs/ext2/file.c
--- linux-fs4/fs/ext2/file.c	Thu Oct 11 15:05:18 2001
+++ linux-fs5/fs/ext2/file.c	Mon Jan  7 07:32:31 2002
@@ -19,7 +19,7 @@
  */
 
 #include <linux/fs.h>
-#include <linux/ext2_fs.h>
+#include "ext2_fs.h"
 #include <linux/sched.h>
 
 /*
diff -Naur -X /g/g/lib/dontdiff linux-fs4/fs/ext2/fsync.c linux-fs5/fs/ext2/fsync.c
--- linux-fs4/fs/ext2/fsync.c	Mon Sep 17 20:16:30 2001
+++ linux-fs5/fs/ext2/fsync.c	Mon Jan  7 07:32:34 2002
@@ -23,7 +23,7 @@
  */
 
 #include <linux/fs.h>
-#include <linux/ext2_fs.h>
+#include "ext2_fs.h"
 #include <linux/locks.h>
 #include <linux/smp_lock.h>
 
diff -Naur -X /g/g/lib/dontdiff linux-fs4/fs/ext2/ialloc.c linux-fs5/fs/ext2/ialloc.c
--- linux-fs4/fs/ext2/ialloc.c	Mon Jan  7 08:57:52 2002
+++ linux-fs5/fs/ext2/ialloc.c	Mon Jan  7 08:58:14 2002
@@ -14,9 +14,9 @@
 
 #include <linux/config.h>
 #include <linux/fs.h>
-#include <linux/ext2_fs.h>
-#include <linux/ext2_fs_sb.h>
-#include <linux/ext2_fs_i.h>
+#include "ext2_fs.h"
+#include "ext2_fs_sb.h"
+#include "ext2_fs_i.h"
 #include <linux/locks.h>
 #include <linux/quotaops.h>
 
diff -Naur -X /g/g/lib/dontdiff linux-fs4/fs/ext2/inode.c linux-fs5/fs/ext2/inode.c
--- linux-fs4/fs/ext2/inode.c	Mon Jan  7 09:19:50 2002
+++ linux-fs5/fs/ext2/inode.c	Mon Jan  7 09:20:03 2002
@@ -23,9 +23,9 @@
  */
 
 #include <linux/fs.h>
-#include <linux/ext2_fs.h>
-#include <linux/ext2_fs_sb.h>
-#include <linux/ext2_fs_i.h>
+#include "ext2_fs.h"
+#include "ext2_fs_sb.h"
+#include "ext2_fs_i.h"
 #include <linux/locks.h>
 #include <linux/smp_lock.h>
 #include <linux/sched.h>
diff -Naur -X /g/g/lib/dontdiff linux-fs4/fs/ext2/ioctl.c linux-fs5/fs/ext2/ioctl.c
--- linux-fs4/fs/ext2/ioctl.c	Mon Jan  7 02:01:46 2002
+++ linux-fs5/fs/ext2/ioctl.c	Mon Jan  7 07:32:43 2002
@@ -8,8 +8,8 @@
  */
 
 #include <linux/fs.h>
-#include <linux/ext2_fs.h>
-#include <linux/ext2_fs_i.h>
+#include "ext2_fs.h"
+#include "ext2_fs_i.h"
 #include <linux/sched.h>
 #include <asm/uaccess.h>
 
diff -Naur -X /g/g/lib/dontdiff linux-fs4/fs/ext2/namei.c linux-fs5/fs/ext2/namei.c
--- linux-fs4/fs/ext2/namei.c	Mon Jan  7 02:01:49 2002
+++ linux-fs5/fs/ext2/namei.c	Mon Jan  7 07:32:47 2002
@@ -30,8 +30,8 @@
  */
 
 #include <linux/fs.h>
-#include <linux/ext2_fs.h>
-#include <linux/ext2_fs_i.h>
+#include "ext2_fs.h"
+#include "ext2_fs_i.h"
 #include <linux/pagemap.h>
 
 /*
diff -Naur -X /g/g/lib/dontdiff linux-fs4/fs/ext2/super.c linux-fs5/fs/ext2/super.c
--- linux-fs4/fs/ext2/super.c	Mon Jan  7 07:03:16 2002
+++ linux-fs5/fs/ext2/super.c	Mon Jan  7 07:32:50 2002
@@ -20,9 +20,9 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/fs.h>
-#include <linux/ext2_fs.h>
-#include <linux/ext2_fs_sb.h>
-#include <linux/ext2_fs_i.h>
+#include "ext2_fs.h"
+#include "ext2_fs_sb.h"
+#include "ext2_fs_i.h"
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/locks.h>
diff -Naur -X /g/g/lib/dontdiff linux-fs4/fs/ext2/symlink.c linux-fs5/fs/ext2/symlink.c
--- linux-fs4/fs/ext2/symlink.c	Mon Jan  7 02:01:55 2002
+++ linux-fs5/fs/ext2/symlink.c	Mon Jan  7 07:32:54 2002
@@ -18,8 +18,8 @@
  */
 
 #include <linux/fs.h>
-#include <linux/ext2_fs.h>
-#include <linux/ext2_fs_i.h>
+#include "ext2_fs.h"
+#include "ext2_fs_i.h"
 
 static int ext2_readlink(struct dentry *dentry, char *buffer, int buflen)
 {
diff -Naur -X /g/g/lib/dontdiff linux-fs4/include/linux/ext2_fs.h linux-fs5/include/linux/ext2_fs.h
--- linux-fs4/include/linux/ext2_fs.h	Mon Jan  7 07:06:38 2002
+++ linux-fs5/include/linux/ext2_fs.h	Thu Jan  1 00:00:00 1970
@@ -1,651 +0,0 @@
-/*
- *  linux/include/linux/ext2_fs.h
- *
- * Copyright (C) 1992, 1993, 1994, 1995
- * Remy Card (card@masi.ibp.fr)
- * Laboratoire MASI - Institut Blaise Pascal
- * Universite Pierre et Marie Curie (Paris VI)
- *
- *  from
- *
- *  linux/include/linux/minix_fs.h
- *
- *  Copyright (C) 1991, 1992  Linus Torvalds
- */
-
-#ifndef _LINUX_EXT2_FS_H
-#define _LINUX_EXT2_FS_H
-
-#include <linux/types.h>
-#include <linux/slab.h>
-
-/*
- * The second extended filesystem constants/structures
- */
-
-/*
- * Define EXT2FS_DEBUG to produce debug messages
- */
-#undef EXT2FS_DEBUG
-
-/*
- * Define EXT2_PREALLOCATE to preallocate data blocks for expanding files
- */
-#define EXT2_PREALLOCATE
-#define EXT2_DEFAULT_PREALLOC_BLOCKS	8
-
-/*
- * The second extended file system version
- */
-#define EXT2FS_DATE		"95/08/09"
-#define EXT2FS_VERSION		"0.5b"
-
-/*
- * Debug code
- */
-#ifdef EXT2FS_DEBUG
-#	define ext2_debug(f, a...)	{ \
-					printk ("EXT2-fs DEBUG (%s, %d): %s:", \
-						__FILE__, __LINE__, __FUNCTION__); \
-				  	printk (f, ## a); \
-					}
-#else
-#	define ext2_debug(f, a...)	/**/
-#endif
-
-/*
- * Special inode numbers
- */
-#define	EXT2_BAD_INO		 1	/* Bad blocks inode */
-#define EXT2_ROOT_INO		 2	/* Root inode */
-#define EXT2_ACL_IDX_INO	 3	/* ACL inode */
-#define EXT2_ACL_DATA_INO	 4	/* ACL inode */
-#define EXT2_BOOT_LOADER_INO	 5	/* Boot loader inode */
-#define EXT2_UNDEL_DIR_INO	 6	/* Undelete directory inode */
-
-/* First non-reserved inode for old ext2 filesystems */
-#define EXT2_GOOD_OLD_FIRST_INO	11
-
-/*
- * The second extended file system magic number
- */
-#define EXT2_SUPER_MAGIC	0xEF53
-
-/*
- * Maximal count of links to a file
- */
-#define EXT2_LINK_MAX		32000
-
-/*
- * Macro-instructions used to manage several block sizes
- */
-#define EXT2_MIN_BLOCK_SIZE		1024
-#define	EXT2_MAX_BLOCK_SIZE		4096
-#define EXT2_MIN_BLOCK_LOG_SIZE		  10
-#ifdef __KERNEL__
-# define EXT2_BLOCK_SIZE(s)		((s)->s_blocksize)
-#else
-# define EXT2_BLOCK_SIZE(s)		(EXT2_MIN_BLOCK_SIZE << (s)->s_log_block_size)
-#endif
-#define EXT2_ACLE_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (struct ext2_acl_entry))
-#define	EXT2_ADDR_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (__u32))
-#ifdef __KERNEL__
-# define EXT2_BLOCK_SIZE_BITS(s)	((s)->s_blocksize_bits)
-#else
-# define EXT2_BLOCK_SIZE_BITS(s)	((s)->s_log_block_size + 10)
-#endif
-#ifdef __KERNEL__
-#define	EXT2_ADDR_PER_BLOCK_BITS(s)	(ext2_sb(s)->s_addr_per_block_bits)
-#define EXT2_INODE_SIZE(s)		(ext2_sb(s)->s_inode_size)
-#define EXT2_FIRST_INO(s)		(ext2_sb(s)->s_first_ino)
-#else
-#define EXT2_INODE_SIZE(s)	(((s)->s_rev_level == EXT2_GOOD_OLD_REV) ? \
-				 EXT2_GOOD_OLD_INODE_SIZE : \
-				 (s)->s_inode_size)
-#define EXT2_FIRST_INO(s)	(((s)->s_rev_level == EXT2_GOOD_OLD_REV) ? \
-				 EXT2_GOOD_OLD_FIRST_INO : \
-				 (s)->s_first_ino)
-#endif
-
-/*
- * Macro-instructions used to manage fragments
- */
-#define EXT2_MIN_FRAG_SIZE		1024
-#define	EXT2_MAX_FRAG_SIZE		4096
-#define EXT2_MIN_FRAG_LOG_SIZE		  10
-#ifdef __KERNEL__
-# define EXT2_FRAG_SIZE(s)		(ext2_sb(s)->s_frag_size)
-# define EXT2_FRAGS_PER_BLOCK(s)	(ext2_sb(s)->s_frags_per_block)
-#else
-# define EXT2_FRAG_SIZE(s)		(EXT2_MIN_FRAG_SIZE << (s)->s_log_frag_size)
-# define EXT2_FRAGS_PER_BLOCK(s)	(EXT2_BLOCK_SIZE(s) / EXT2_FRAG_SIZE(s))
-#endif
-
-/*
- * ACL structures
- */
-struct ext2_acl_header	/* Header of Access Control Lists */
-{
-	__u32	aclh_size;
-	__u32	aclh_file_count;
-	__u32	aclh_acle_count;
-	__u32	aclh_first_acle;
-};
-
-struct ext2_acl_entry	/* Access Control List Entry */
-{
-	__u32	acle_size;
-	__u16	acle_perms;	/* Access permissions */
-	__u16	acle_type;	/* Type of entry */
-	__u16	acle_tag;	/* User or group identity */
-	__u16	acle_pad1;
-	__u32	acle_next;	/* Pointer on next entry for the */
-					/* same inode or on next free entry */
-};
-
-/*
- * Structure of a blocks group descriptor
- */
-struct ext2_group_desc
-{
-	__u32	bg_block_bitmap;		/* Blocks bitmap block */
-	__u32	bg_inode_bitmap;		/* Inodes bitmap block */
-	__u32	bg_inode_table;		/* Inodes table block */
-	__u16	bg_free_blocks_count;	/* Free blocks count */
-	__u16	bg_free_inodes_count;	/* Free inodes count */
-	__u16	bg_used_dirs_count;	/* Directories count */
-	__u16	bg_pad;
-	__u32	bg_reserved[3];
-};
-
-/*
- * Macro-instructions used to manage group descriptors
- */
-#ifdef __KERNEL__
-# define EXT2_BLOCKS_PER_GROUP(s)	(ext2_sb(s)->s_blocks_per_group)
-# define EXT2_DESC_PER_BLOCK(s)		(ext2_sb(s)->s_desc_per_block)
-# define EXT2_INODES_PER_GROUP(s)	(ext2_sb(s)->s_inodes_per_group)
-# define EXT2_DESC_PER_BLOCK_BITS(s)	(ext2_sb(s)->s_desc_per_block_bits)
-#else
-# define EXT2_BLOCKS_PER_GROUP(s)	((s)->s_blocks_per_group)
-# define EXT2_DESC_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (struct ext2_group_desc))
-# define EXT2_INODES_PER_GROUP(s)	((s)->s_inodes_per_group)
-#endif
-
-/*
- * Constants relative to the data blocks
- */
-#define	EXT2_NDIR_BLOCKS		12
-#define	EXT2_IND_BLOCK			EXT2_NDIR_BLOCKS
-#define	EXT2_DIND_BLOCK			(EXT2_IND_BLOCK + 1)
-#define	EXT2_TIND_BLOCK			(EXT2_DIND_BLOCK + 1)
-#define	EXT2_N_BLOCKS			(EXT2_TIND_BLOCK + 1)
-
-/*
- * Inode flags
- */
-#define	EXT2_SECRM_FL			0x00000001 /* Secure deletion */
-#define	EXT2_UNRM_FL			0x00000002 /* Undelete */
-#define	EXT2_COMPR_FL			0x00000004 /* Compress file */
-#define EXT2_SYNC_FL			0x00000008 /* Synchronous updates */
-#define EXT2_IMMUTABLE_FL		0x00000010 /* Immutable file */
-#define EXT2_APPEND_FL			0x00000020 /* writes to file may only append */
-#define EXT2_NODUMP_FL			0x00000040 /* do not dump file */
-#define EXT2_NOATIME_FL			0x00000080 /* do not update atime */
-/* Reserved for compression usage... */
-#define EXT2_DIRTY_FL			0x00000100
-#define EXT2_COMPRBLK_FL		0x00000200 /* One or more compressed clusters */
-#define EXT2_NOCOMP_FL			0x00000400 /* Don't compress */
-#define EXT2_ECOMPR_FL			0x00000800 /* Compression error */
-/* End compression flags --- maybe not all used */	
-#define EXT2_BTREE_FL			0x00001000 /* btree format dir */
-#define EXT2_RESERVED_FL		0x80000000 /* reserved for ext2 lib */
-
-#define EXT2_FL_USER_VISIBLE		0x00001FFF /* User visible flags */
-#define EXT2_FL_USER_MODIFIABLE		0x000000FF /* User modifiable flags */
-
-/*
- * ioctl commands
- */
-#define	EXT2_IOC_GETFLAGS		_IOR('f', 1, long)
-#define	EXT2_IOC_SETFLAGS		_IOW('f', 2, long)
-#define	EXT2_IOC_GETVERSION		_IOR('v', 1, long)
-#define	EXT2_IOC_SETVERSION		_IOW('v', 2, long)
-
-/*
- * Structure of an inode on the disk
- */
-struct ext2_inode {
-	__u16	i_mode;		/* File mode */
-	__u16	i_uid;		/* Low 16 bits of Owner Uid */
-	__u32	i_size;		/* Size in bytes */
-	__u32	i_atime;	/* Access time */
-	__u32	i_ctime;	/* Creation time */
-	__u32	i_mtime;	/* Modification time */
-	__u32	i_dtime;	/* Deletion Time */
-	__u16	i_gid;		/* Low 16 bits of Group Id */
-	__u16	i_links_count;	/* Links count */
-	__u32	i_blocks;	/* Blocks count */
-	__u32	i_flags;	/* File flags */
-	union {
-		struct {
-			__u32  l_i_reserved1;
-		} linux1;
-		struct {
-			__u32  h_i_translator;
-		} hurd1;
-		struct {
-			__u32  m_i_reserved1;
-		} masix1;
-	} osd1;				/* OS dependent 1 */
-	__u32	i_block[EXT2_N_BLOCKS];/* Pointers to blocks */
-	__u32	i_generation;	/* File version (for NFS) */
-	__u32	i_file_acl;	/* File ACL */
-	__u32	i_dir_acl;	/* Directory ACL */
-	__u32	i_faddr;	/* Fragment address */
-	union {
-		struct {
-			__u8	l_i_frag;	/* Fragment number */
-			__u8	l_i_fsize;	/* Fragment size */
-			__u16	i_pad1;
-			__u16	l_i_uid_high;	/* these 2 fields    */
-			__u16	l_i_gid_high;	/* were reserved2[0] */
-			__u32	l_i_reserved2;
-		} linux2;
-		struct {
-			__u8	h_i_frag;	/* Fragment number */
-			__u8	h_i_fsize;	/* Fragment size */
-			__u16	h_i_mode_high;
-			__u16	h_i_uid_high;
-			__u16	h_i_gid_high;
-			__u32	h_i_author;
-		} hurd2;
-		struct {
-			__u8	m_i_frag;	/* Fragment number */
-			__u8	m_i_fsize;	/* Fragment size */
-			__u16	m_pad1;
-			__u32	m_i_reserved2[2];
-		} masix2;
-	} osd2;				/* OS dependent 2 */
-};
-
-#define i_size_high	i_dir_acl
-
-#if defined(__KERNEL__) || defined(__linux__)
-#define i_reserved1	osd1.linux1.l_i_reserved1
-#define i_frag		osd2.linux2.l_i_frag
-#define i_fsize		osd2.linux2.l_i_fsize
-#define i_uid_low	i_uid
-#define i_gid_low	i_gid
-#define i_uid_high	osd2.linux2.l_i_uid_high
-#define i_gid_high	osd2.linux2.l_i_gid_high
-#define i_reserved2	osd2.linux2.l_i_reserved2
-#endif
-
-#ifdef	__hurd__
-#define i_translator	osd1.hurd1.h_i_translator
-#define i_frag		osd2.hurd2.h_i_frag;
-#define i_fsize		osd2.hurd2.h_i_fsize;
-#define i_uid_high	osd2.hurd2.h_i_uid_high
-#define i_gid_high	osd2.hurd2.h_i_gid_high
-#define i_author	osd2.hurd2.h_i_author
-#endif
-
-#ifdef	__masix__
-#define i_reserved1	osd1.masix1.m_i_reserved1
-#define i_frag		osd2.masix2.m_i_frag
-#define i_fsize		osd2.masix2.m_i_fsize
-#define i_reserved2	osd2.masix2.m_i_reserved2
-#endif
-
-/*
- * File system states
- */
-#define	EXT2_VALID_FS			0x0001	/* Unmounted cleanly */
-#define	EXT2_ERROR_FS			0x0002	/* Errors detected */
-
-/*
- * Mount flags
- */
-#define EXT2_MOUNT_CHECK		0x0001	/* Do mount-time checks */
-#define EXT2_MOUNT_GRPID		0x0004	/* Create files with directory's group */
-#define EXT2_MOUNT_DEBUG		0x0008	/* Some debugging messages */
-#define EXT2_MOUNT_ERRORS_CONT		0x0010	/* Continue on errors */
-#define EXT2_MOUNT_ERRORS_RO		0x0020	/* Remount fs ro on errors */
-#define EXT2_MOUNT_ERRORS_PANIC		0x0040	/* Panic on errors */
-#define EXT2_MOUNT_MINIX_DF		0x0080	/* Mimics the Minix statfs */
-#define EXT2_MOUNT_NO_UID32		0x0200  /* Disable 32-bit UIDs */
-
-#define clear_opt(o, opt)		o &= ~EXT2_MOUNT_##opt
-#define set_opt(o, opt)			o |= EXT2_MOUNT_##opt
-#define test_opt(sb, opt)		(ext2_sb(sb)->s_mount_opt & \
-					 EXT2_MOUNT_##opt)
-/*
- * Maximal mount counts between two filesystem checks
- */
-#define EXT2_DFL_MAX_MNT_COUNT		20	/* Allow 20 mounts */
-#define EXT2_DFL_CHECKINTERVAL		0	/* Don't use interval check */
-
-/*
- * Behaviour when detecting errors
- */
-#define EXT2_ERRORS_CONTINUE		1	/* Continue execution */
-#define EXT2_ERRORS_RO			2	/* Remount fs read-only */
-#define EXT2_ERRORS_PANIC		3	/* Panic */
-#define EXT2_ERRORS_DEFAULT		EXT2_ERRORS_CONTINUE
-
-/*
- * Structure of the super block
- */
-struct ext2_super_block {
-	__u32	s_inodes_count;		/* Inodes count */
-	__u32	s_blocks_count;		/* Blocks count */
-	__u32	s_r_blocks_count;	/* Reserved blocks count */
-	__u32	s_free_blocks_count;	/* Free blocks count */
-	__u32	s_free_inodes_count;	/* Free inodes count */
-	__u32	s_first_data_block;	/* First Data Block */
-	__u32	s_log_block_size;	/* Block size */
-	__s32	s_log_frag_size;	/* Fragment size */
-	__u32	s_blocks_per_group;	/* # Blocks per group */
-	__u32	s_frags_per_group;	/* # Fragments per group */
-	__u32	s_inodes_per_group;	/* # Inodes per group */
-	__u32	s_mtime;		/* Mount time */
-	__u32	s_wtime;		/* Write time */
-	__u16	s_mnt_count;		/* Mount count */
-	__s16	s_max_mnt_count;	/* Maximal mount count */
-	__u16	s_magic;		/* Magic signature */
-	__u16	s_state;		/* File system state */
-	__u16	s_errors;		/* Behaviour when detecting errors */
-	__u16	s_minor_rev_level; 	/* minor revision level */
-	__u32	s_lastcheck;		/* time of last check */
-	__u32	s_checkinterval;	/* max. time between checks */
-	__u32	s_creator_os;		/* OS */
-	__u32	s_rev_level;		/* Revision level */
-	__u16	s_def_resuid;		/* Default uid for reserved blocks */
-	__u16	s_def_resgid;		/* Default gid for reserved blocks */
-	/*
-	 * These fields are for EXT2_DYNAMIC_REV superblocks only.
-	 *
-	 * Note: the difference between the compatible feature set and
-	 * the incompatible feature set is that if there is a bit set
-	 * in the incompatible feature set that the kernel doesn't
-	 * know about, it should refuse to mount the filesystem.
-	 * 
-	 * e2fsck's requirements are more strict; if it doesn't know
-	 * about a feature in either the compatible or incompatible
-	 * feature set, it must abort and not try to meddle with
-	 * things it doesn't understand...
-	 */
-	__u32	s_first_ino; 		/* First non-reserved inode */
-	__u16   s_inode_size; 		/* size of inode structure */
-	__u16	s_block_group_nr; 	/* block group # of this superblock */
-	__u32	s_feature_compat; 	/* compatible feature set */
-	__u32	s_feature_incompat; 	/* incompatible feature set */
-	__u32	s_feature_ro_compat; 	/* readonly-compatible feature set */
-	__u8	s_uuid[16];		/* 128-bit uuid for volume */
-	char	s_volume_name[16]; 	/* volume name */
-	char	s_last_mounted[64]; 	/* directory where last mounted */
-	__u32	s_algorithm_usage_bitmap; /* For compression */
-	/*
-	 * Performance hints.  Directory preallocation should only
-	 * happen if the EXT2_COMPAT_PREALLOC flag is on.
-	 */
-	__u8	s_prealloc_blocks;	/* Nr of blocks to try to preallocate*/
-	__u8	s_prealloc_dir_blocks;	/* Nr to preallocate for dirs */
-	__u16	s_padding1;
-	__u32	s_reserved[204];	/* Padding to the end of the block */
-};
-
-#ifdef __KERNEL__
-#define EXT2_SB		ext2_sb	/* unused */
-#else
-/* Assume that user mode programs are passing in an ext2fs superblock, not
- * a kernel struct super_block.  This will allow us to call the feature-test
- * macros from user land. */
-#define EXT2_SB(sb)	(sb)
-#endif
-
-/*
- * Codes for operating systems
- */
-#define EXT2_OS_LINUX		0
-#define EXT2_OS_HURD		1
-#define EXT2_OS_MASIX		2
-#define EXT2_OS_FREEBSD		3
-#define EXT2_OS_LITES		4
-
-/*
- * Revision levels
- */
-#define EXT2_GOOD_OLD_REV	0	/* The good old (original) format */
-#define EXT2_DYNAMIC_REV	1 	/* V2 format w/ dynamic inode sizes */
-
-#define EXT2_CURRENT_REV	EXT2_GOOD_OLD_REV
-#define EXT2_MAX_SUPP_REV	EXT2_DYNAMIC_REV
-
-#define EXT2_GOOD_OLD_INODE_SIZE 128
-
-/*
- * Feature set definitions
- */
-
-#define EXT2_HAS_COMPAT_FEATURE(sb,mask)			\
-	( EXT2_SB(sb)->s_es->s_feature_compat & cpu_to_le32(mask) )
-#define EXT2_HAS_RO_COMPAT_FEATURE(sb,mask)			\
-	( EXT2_SB(sb)->s_es->s_feature_ro_compat & cpu_to_le32(mask) )
-#define EXT2_HAS_INCOMPAT_FEATURE(sb,mask)			\
-	( EXT2_SB(sb)->s_es->s_feature_incompat & cpu_to_le32(mask) )
-#define EXT2_SET_COMPAT_FEATURE(sb,mask)			\
-	EXT2_SB(sb)->s_es->s_feature_compat |= cpu_to_le32(mask)
-#define EXT2_SET_RO_COMPAT_FEATURE(sb,mask)			\
-	EXT2_SB(sb)->s_es->s_feature_ro_compat |= cpu_to_le32(mask)
-#define EXT2_SET_INCOMPAT_FEATURE(sb,mask)			\
-	EXT2_SB(sb)->s_es->s_feature_incompat |= cpu_to_le32(mask)
-#define EXT2_CLEAR_COMPAT_FEATURE(sb,mask)			\
-	EXT2_SB(sb)->s_es->s_feature_compat &= ~cpu_to_le32(mask)
-#define EXT2_CLEAR_RO_COMPAT_FEATURE(sb,mask)			\
-	EXT2_SB(sb)->s_es->s_feature_ro_compat &= ~cpu_to_le32(mask)
-#define EXT2_CLEAR_INCOMPAT_FEATURE(sb,mask)			\
-	EXT2_SB(sb)->s_es->s_feature_incompat &= ~cpu_to_le32(mask)
-
-#define EXT2_FEATURE_COMPAT_DIR_PREALLOC	0x0001
-#define EXT2_FEATURE_COMPAT_IMAGIC_INODES	0x0002
-#define EXT3_FEATURE_COMPAT_HAS_JOURNAL		0x0004
-#define EXT2_FEATURE_COMPAT_EXT_ATTR		0x0008
-#define EXT2_FEATURE_COMPAT_RESIZE_INO		0x0010
-#define EXT2_FEATURE_COMPAT_DIR_INDEX		0x0020
-#define EXT2_FEATURE_COMPAT_ANY			0xffffffff
-
-#define EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
-#define EXT2_FEATURE_RO_COMPAT_LARGE_FILE	0x0002
-#define EXT2_FEATURE_RO_COMPAT_BTREE_DIR	0x0004
-#define EXT2_FEATURE_RO_COMPAT_ANY		0xffffffff
-
-#define EXT2_FEATURE_INCOMPAT_COMPRESSION	0x0001
-#define EXT2_FEATURE_INCOMPAT_FILETYPE		0x0002
-#define EXT3_FEATURE_INCOMPAT_RECOVER		0x0004
-#define EXT3_FEATURE_INCOMPAT_JOURNAL_DEV	0x0008
-#define EXT2_FEATURE_INCOMPAT_ANY		0xffffffff
-
-#define EXT2_FEATURE_COMPAT_SUPP	0
-#define EXT2_FEATURE_INCOMPAT_SUPP	EXT2_FEATURE_INCOMPAT_FILETYPE
-#define EXT2_FEATURE_RO_COMPAT_SUPP	(EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER| \
-					 EXT2_FEATURE_RO_COMPAT_LARGE_FILE| \
-					 EXT2_FEATURE_RO_COMPAT_BTREE_DIR)
-#define EXT2_FEATURE_RO_COMPAT_UNSUPPORTED	~EXT2_FEATURE_RO_COMPAT_SUPP
-#define EXT2_FEATURE_INCOMPAT_UNSUPPORTED	~EXT2_FEATURE_INCOMPAT_SUPP
-
-/*
- * Default values for user and/or group using reserved blocks
- */
-#define	EXT2_DEF_RESUID		0
-#define	EXT2_DEF_RESGID		0
-
-/*
- * Structure of a directory entry
- */
-#define EXT2_NAME_LEN 255
-
-struct ext2_dir_entry {
-	__u32	inode;			/* Inode number */
-	__u16	rec_len;		/* Directory entry length */
-	__u16	name_len;		/* Name length */
-	char	name[EXT2_NAME_LEN];	/* File name */
-};
-
-/*
- * The new version of the directory entry.  Since EXT2 structures are
- * stored in intel byte order, and the name_len field could never be
- * bigger than 255 chars, it's safe to reclaim the extra byte for the
- * file_type field.
- */
-struct ext2_dir_entry_2 {
-	__u32	inode;			/* Inode number */
-	__u16	rec_len;		/* Directory entry length */
-	__u8	name_len;		/* Name length */
-	__u8	file_type;
-	char	name[EXT2_NAME_LEN];	/* File name */
-};
-
-/*
- * Ext2 directory file types.  Only the low 3 bits are used.  The
- * other bits are reserved for now.
- */
-enum {
-	EXT2_FT_UNKNOWN,
-	EXT2_FT_REG_FILE,
-	EXT2_FT_DIR,
-	EXT2_FT_CHRDEV,
-	EXT2_FT_BLKDEV,
-	EXT2_FT_FIFO,
-	EXT2_FT_SOCK,
-	EXT2_FT_SYMLINK,
-	EXT2_FT_MAX
-};
-
-/*
- * EXT2_DIR_PAD defines the directory entries boundaries
- *
- * NOTE: It must be a multiple of 4
- */
-#define EXT2_DIR_PAD		 	4
-#define EXT2_DIR_ROUND 			(EXT2_DIR_PAD - 1)
-#define EXT2_DIR_REC_LEN(name_len)	(((name_len) + 8 + EXT2_DIR_ROUND) & \
-					 ~EXT2_DIR_ROUND)
-
-#ifdef __KERNEL__
-/*
- * Function prototypes
- */
-
-/*
- * Ok, these declarations are also in <linux/kernel.h> but none of the
- * ext2 source programs needs to include it so they are duplicated here.
- */
-# define NORET_TYPE    /**/
-# define ATTRIB_NORET  __attribute__((noreturn))
-# define NORET_AND     noreturn,
-
-/* balloc.c */
-extern int ext2_bg_has_super(struct super_block *sb, int group);
-extern unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
-extern int ext2_new_block (struct inode *, unsigned long,
-			   __u32 *, __u32 *, int *);
-extern void ext2_free_blocks (struct inode *, unsigned long,
-			      unsigned long);
-extern unsigned long ext2_count_free_blocks (struct super_block *);
-extern void ext2_check_blocks_bitmap (struct super_block *);
-extern struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
-						    unsigned int block_group,
-						    struct buffer_head ** bh);
-
-/* dir.c */
-extern int ext2_add_link (struct dentry *, struct inode *);
-extern ino_t ext2_inode_by_name(struct inode *, struct dentry *);
-extern int ext2_make_empty(struct inode *, struct inode *);
-extern struct ext2_dir_entry_2 * ext2_find_entry (struct inode *,struct dentry *, struct page **);
-extern int ext2_delete_entry (struct ext2_dir_entry_2 *, struct page *);
-extern int ext2_empty_dir (struct inode *);
-extern struct ext2_dir_entry_2 * ext2_dotdot (struct inode *, struct page **);
-extern void ext2_set_link(struct inode *, struct ext2_dir_entry_2 *, struct page *, struct inode *);
-
-/* fsync.c */
-extern int ext2_sync_file (struct file *, struct dentry *, int);
-extern int ext2_fsync_inode (struct inode *, int);
-
-/* ialloc.c */
-extern struct inode * ext2_new_inode (const struct inode *, int);
-extern void ext2_free_inode (struct inode *);
-extern unsigned long ext2_count_free_inodes (struct super_block *);
-extern void ext2_check_inodes_bitmap (struct super_block *);
-extern unsigned long ext2_count_free (struct buffer_head *, unsigned);
-
-/* inode.c */
-
-static inline struct ext2_inode_info *ext2_i(struct inode *inode)
-{
-	if (!inode->u.ext2_ip)
-		BUG();
-	return inode->u.ext2_ip;
-}
-
-extern void ext2_read_inode (struct inode *);
-extern void ext2_write_inode (struct inode *, int);
-extern void ext2_put_inode (struct inode *);
-extern void ext2_delete_inode (struct inode *);
-extern int ext2_sync_inode (struct inode *);
-extern void ext2_discard_prealloc (struct inode *);
-extern void ext2_truncate (struct inode *);
-extern void ext2_clear_inode (struct inode *inode);
-
-/* ioctl.c */
-extern int ext2_ioctl (struct inode *, struct file *, unsigned int,
-		       unsigned long);
-
-/* super.c */
-
-static inline struct ext2_sb_info *ext2_sb(struct super_block *sb)
-{
-	if (!sb->u.ext2_sbp)
-		BUG();
-	return sb->u.ext2_sbp;
-}
-
-extern kmem_cache_t *ext2_ino_cache;
-extern void ext2_error (struct super_block *, const char *, const char *, ...)
-	__attribute__ ((format (printf, 3, 4)));
-extern NORET_TYPE void ext2_panic (struct super_block *, const char *,
-				   const char *, ...)
-	__attribute__ ((NORET_AND format (printf, 3, 4)));
-extern void ext2_warning (struct super_block *, const char *, const char *, ...)
-	__attribute__ ((format (printf, 3, 4)));
-extern void ext2_update_dynamic_rev (struct super_block *sb);
-extern void ext2_put_super (struct super_block *);
-extern void ext2_write_super (struct super_block *);
-extern int ext2_remount (struct super_block *, int *, char *);
-extern struct super_block * ext2_read_super (struct super_block *,void *,int);
-extern int ext2_statfs (struct super_block *, struct statfs *);
-
-/*
- * Inodes and files operations
- */
-
-/* dir.c */
-extern struct file_operations ext2_dir_operations;
-
-/* file.c */
-extern struct inode_operations ext2_file_inode_operations;
-extern struct file_operations ext2_file_operations;
-
-/* inode.c */
-extern struct address_space_operations ext2_aops;
-
-/* namei.c */
-extern struct inode_operations ext2_dir_inode_operations;
-
-/* symlink.c */
-extern struct inode_operations ext2_fast_symlink_inode_operations;
-
-#endif	/* __KERNEL__ */
-
-#endif	/* _LINUX_EXT2_FS_H */
diff -Naur -X /g/g/lib/dontdiff linux-fs4/include/linux/ext2_fs_i.h linux-fs5/include/linux/ext2_fs_i.h
--- linux-fs4/include/linux/ext2_fs_i.h	Mon Sep 17 20:16:30 2001
+++ linux-fs5/include/linux/ext2_fs_i.h	Thu Jan  1 00:00:00 1970
@@ -1,41 +0,0 @@
-/*
- *  linux/include/linux/ext2_fs_i.h
- *
- * Copyright (C) 1992, 1993, 1994, 1995
- * Remy Card (card@masi.ibp.fr)
- * Laboratoire MASI - Institut Blaise Pascal
- * Universite Pierre et Marie Curie (Paris VI)
- *
- *  from
- *
- *  linux/include/linux/minix_fs_i.h
- *
- *  Copyright (C) 1991, 1992  Linus Torvalds
- */
-
-#ifndef _LINUX_EXT2_FS_I
-#define _LINUX_EXT2_FS_I
-
-/*
- * second extended file system inode data in memory
- */
-struct ext2_inode_info {
-	__u32	i_data[15];
-	__u32	i_flags;
-	__u32	i_faddr;
-	__u8	i_frag_no;
-	__u8	i_frag_size;
-	__u16	i_osync;
-	__u32	i_file_acl;
-	__u32	i_dir_acl;
-	__u32	i_dtime;
-	__u32	i_block_group;
-	__u32	i_next_alloc_block;
-	__u32	i_next_alloc_goal;
-	__u32	i_prealloc_block;
-	__u32	i_prealloc_count;
-	__u32	i_dir_start_lookup;
-	int	i_new_inode:1;	/* Is a freshly allocated inode */
-};
-
-#endif	/* _LINUX_EXT2_FS_I */
diff -Naur -X /g/g/lib/dontdiff linux-fs4/include/linux/ext2_fs_sb.h linux-fs5/include/linux/ext2_fs_sb.h
--- linux-fs4/include/linux/ext2_fs_sb.h	Sun Jan  6 23:29:25 2002
+++ linux-fs5/include/linux/ext2_fs_sb.h	Thu Jan  1 00:00:00 1970
@@ -1,62 +0,0 @@
-/*
- *  linux/include/linux/ext2_fs_sb.h
- *
- * Copyright (C) 1992, 1993, 1994, 1995
- * Remy Card (card@masi.ibp.fr)
- * Laboratoire MASI - Institut Blaise Pascal
- * Universite Pierre et Marie Curie (Paris VI)
- *
- *  from
- *
- *  linux/include/linux/minix_fs_sb.h
- *
- *  Copyright (C) 1991, 1992  Linus Torvalds
- */
-
-#ifndef _LINUX_EXT2_FS_SB
-#define _LINUX_EXT2_FS_SB
-
-/*
- * The following is not needed anymore since the descriptors buffer
- * heads are now dynamically allocated
- */
-/* #define EXT2_MAX_GROUP_DESC	8 */
-
-#define EXT2_MAX_GROUP_LOADED	8
-
-/*
- * second extended-fs super-block data in memory
- */
-struct ext2_sb_info {
-	unsigned long s_frag_size;	/* Size of a fragment in bytes */
-	unsigned long s_frags_per_block;/* Number of fragments per block */
-	unsigned long s_inodes_per_block;/* Number of inodes per block */
-	unsigned long s_frags_per_group;/* Number of fragments in a group */
-	unsigned long s_blocks_per_group;/* Number of blocks in a group */
-	unsigned long s_inodes_per_group;/* Number of inodes in a group */
-	unsigned long s_itb_per_group;	/* Number of inode table blocks per group */
-	unsigned long s_gdb_count;	/* Number of group descriptor blocks */
-	unsigned long s_desc_per_block;	/* Number of group descriptors per block */
-	unsigned long s_groups_count;	/* Number of groups in the fs */
-	struct buffer_head * s_sbh;	/* Buffer containing the super block */
-	struct ext2_super_block * s_es;	/* Pointer to the super block in the buffer */
-	struct buffer_head ** s_group_desc;
-	unsigned short s_loaded_inode_bitmaps;
-	unsigned short s_loaded_block_bitmaps;
-	unsigned long s_inode_bitmap_number[EXT2_MAX_GROUP_LOADED];
-	struct buffer_head * s_inode_bitmap[EXT2_MAX_GROUP_LOADED];
-	unsigned long s_block_bitmap_number[EXT2_MAX_GROUP_LOADED];
-	struct buffer_head * s_block_bitmap[EXT2_MAX_GROUP_LOADED];
-	unsigned long  s_mount_opt;
-	uid_t s_resuid;
-	gid_t s_resgid;
-	unsigned short s_mount_state;
-	unsigned short s_pad;
-	int s_addr_per_block_bits;
-	int s_desc_per_block_bits;
-	int s_inode_size;
-	int s_first_ino;
-	u32 s_next_generation;
-};
-
-#endif	/* _LINUX_EXT2_FS_SB */
