Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWIHQS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWIHQS0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 12:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWIHQS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 12:18:26 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:53964 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750884AbWIHQSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 12:18:25 -0400
Date: Fri, 8 Sep 2006 18:18:14 +0200
From: Alexandre Ratchov <alexandre.ratchov@bull.net>
To: Mingming Cao <cmm@us.ibm.com>
Cc: akpm@osdl.org, shaggy@us.ibm.com, linux-ext4@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [patch 2/2] Re: Updated ext4 patches for 2.6.18-rc6
Message-ID: <20060908161814.GA19789@openx1.frec.bull.fr>
References: <20060908131144sho@rifu.tnes.nec.co.jp> <1157698868.8616.20.camel@localhost.localdomain> <20060908161324.GA19256@openx1.frec.bull.fr>
Mime-Version: 1.0
In-Reply-To: <20060908161324.GA19256@openx1.frec.bull.fr>
User-Agent: Mutt/1.4.1i
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/09/2006 18:23:55,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/09/2006 18:23:57,
	Serialize complete at 08/09/2006 18:23:57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.6.18-rc6/fs/ext4/balloc.c
===================================================================
--- linux-2.6.18-rc6.orig/fs/ext4/balloc.c	2006-09-08 18:29:57.000000000 +0200
+++ linux-2.6.18-rc6/fs/ext4/balloc.c	2006-09-08 18:30:17.000000000 +0200
@@ -66,10 +66,12 @@ struct ext4_group_desc * ext4_get_group_
 		return NULL;
 	}
 
-	desc = (struct ext4_group_desc *) sbi->s_group_desc[group_desc]->b_data;
+	desc = (struct ext4_group_desc *)(
+		(__u8 *)sbi->s_group_desc[group_desc]->b_data +
+		offset * EXT4_DESC_SIZE(sb));
 	if (bh)
 		*bh = sbi->s_group_desc[group_desc];
-	return desc + offset;
+	return desc;
 }
 
 /*
Index: linux-2.6.18-rc6/fs/ext4/inode.c
===================================================================
--- linux-2.6.18-rc6.orig/fs/ext4/inode.c	2006-09-08 18:29:57.000000000 +0200
+++ linux-2.6.18-rc6/fs/ext4/inode.c	2006-09-08 18:34:34.000000000 +0200
@@ -2428,14 +2428,16 @@ static ext4_fsblk_t ext4_get_inode_block
 		return 0;
 	}
 
-	gdp = (struct ext4_group_desc *)bh->b_data;
+	gdp = (struct ext4_group_desc *)((__u8 *)bh->b_data + 
+		desc * EXT4_DESC_SIZE(sb));
 	/*
 	 * Figure out the offset within the block group inode table
 	 */
 	offset = ((ino - 1) % EXT4_INODES_PER_GROUP(sb)) *
 		EXT4_INODE_SIZE(sb);
-	block = ext4_inode_table(gdp + desc) +
-			(offset >> EXT4_BLOCK_SIZE_BITS(sb));
+	block = ext4_inode_table(gdp) + (offset >> EXT4_BLOCK_SIZE_BITS(sb));
+
+
 
 	iloc->block_group = block_group;
 	iloc->offset = offset & (EXT4_BLOCK_SIZE(sb) - 1);
Index: linux-2.6.18-rc6/include/linux/ext4_fs.h
===================================================================
--- linux-2.6.18-rc6.orig/include/linux/ext4_fs.h	2006-09-08 18:29:57.000000000 +0200
+++ linux-2.6.18-rc6/include/linux/ext4_fs.h	2006-09-08 18:30:17.000000000 +0200
@@ -146,6 +146,9 @@ struct ext4_group_desc
 /*
  * Macro-instructions used to manage group descriptors
  */
+#define EXT4_MIN_DESC_SIZE		32
+#define	EXT4_MAX_DESC_SIZE		EXT4_MIN_BLOCK_SIZE
+#define EXT4_DESC_SIZE(s)		(EXT4_SB(s)->s_desc_size)
 #ifdef __KERNEL__
 # define EXT4_BLOCKS_PER_GROUP(s)	(EXT4_SB(s)->s_blocks_per_group)
 # define EXT4_DESC_PER_BLOCK(s)		(EXT4_SB(s)->s_desc_per_block)
@@ -153,7 +156,7 @@ struct ext4_group_desc
 # define EXT4_DESC_PER_BLOCK_BITS(s)	(EXT4_SB(s)->s_desc_per_block_bits)
 #else
 # define EXT4_BLOCKS_PER_GROUP(s)	((s)->s_blocks_per_group)
-# define EXT4_DESC_PER_BLOCK(s)		(EXT4_BLOCK_SIZE(s) / sizeof (struct ext4_group_desc))
+# define EXT4_DESC_PER_BLOCK(s)		(EXT4_BLOCK_SIZE(s) / EXT4_DESC_SIZE(s))
 # define EXT4_INODES_PER_GROUP(s)	((s)->s_inodes_per_group)
 #endif
 
@@ -461,7 +464,7 @@ struct ext4_super_block {
 	 * things it doesn't understand...
 	 */
 	__le32	s_first_ino;		/* First non-reserved inode */
-	__le16   s_inode_size;		/* size of inode structure */
+	__le16  s_inode_size;		/* size of inode structure */
 	__le16	s_block_group_nr;	/* block group # of this superblock */
 	__le32	s_feature_compat;	/* compatible feature set */
 /*60*/	__le32	s_feature_incompat;	/* incompatible feature set */
@@ -487,7 +490,7 @@ struct ext4_super_block {
 	__le32	s_hash_seed[4];		/* HTREE hash seed */
 	__u8	s_def_hash_version;	/* Default hash version to use */
 	__u8	s_reserved_char_pad;
-	__u16	s_reserved_word_pad;
+	__le16  s_desc_size;		/* size of group descriptor */
 /*100*/	__le32	s_default_mount_opts;
 	__le32	s_first_meta_bg; 	/* First metablock block group */
 	__le32	s_mkfs_time;		/* When the filesystem was created */
Index: linux-2.6.18-rc6/fs/ext4/super.c
===================================================================
--- linux-2.6.18-rc6.orig/fs/ext4/super.c	2006-09-08 18:29:57.000000000 +0200
+++ linux-2.6.18-rc6/fs/ext4/super.c	2006-09-08 18:30:17.000000000 +0200
@@ -1233,7 +1233,8 @@ static int ext4_check_descriptors (struc
 			return 0;
 		}
 		block += EXT4_BLOCKS_PER_GROUP(sb);
-		gdp++;
+		gdp = (struct ext4_group_desc *)
+			((__u8 *)gdp + EXT4_DESC_SIZE(sb));
 	}
 
 	ext4_free_blocks_count_set(sbi->s_es, ext4_count_free_blocks(sb));
@@ -1585,7 +1586,18 @@ static int ext4_fill_super (struct super
 		       sbi->s_frag_size, blocksize);
 		goto failed_mount;
 	}
-	sbi->s_frags_per_block = 1;
+	sbi->s_desc_size = le16_to_cpu(es->s_desc_size);
+	if (EXT4_HAS_INCOMPAT_FEATURE(sb, EXT4_FEATURE_INCOMPAT_64BIT)) {
+		if (sbi->s_desc_size < EXT4_MIN_DESC_SIZE ||
+		    sbi->s_desc_size > EXT4_MAX_DESC_SIZE ||
+		    sbi->s_desc_size & (sbi->s_desc_size - 1)) {
+			printk(KERN_ERR
+			       "EXT4-fs: unsupported descriptor size %d\n",
+			       sbi->s_desc_size);
+			goto failed_mount;
+		}
+	} else
+		sbi->s_desc_size = EXT4_MIN_DESC_SIZE;
 	sbi->s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
 	sbi->s_frags_per_group = le32_to_cpu(es->s_frags_per_group);
 	sbi->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
@@ -1596,7 +1608,7 @@ static int ext4_fill_super (struct super
 		goto cantfind_ext4;
 	sbi->s_itb_per_group = sbi->s_inodes_per_group /
 					sbi->s_inodes_per_block;
-	sbi->s_desc_per_block = blocksize / sizeof(struct ext4_group_desc);
+	sbi->s_desc_per_block = blocksize / EXT4_DESC_SIZE(sb);
 	sbi->s_sbh = bh;
 	sbi->s_mount_state = le16_to_cpu(es->s_state);
 	sbi->s_addr_per_block_bits = log2(EXT4_ADDR_PER_BLOCK(sb));
Index: linux-2.6.18-rc6/include/linux/ext4_fs_sb.h
===================================================================
--- linux-2.6.18-rc6.orig/include/linux/ext4_fs_sb.h	2006-09-08 18:29:57.000000000 +0200
+++ linux-2.6.18-rc6/include/linux/ext4_fs_sb.h	2006-09-08 18:30:17.000000000 +0200
@@ -29,6 +29,7 @@
  */
 struct ext4_sb_info {
 	unsigned long s_frag_size;	/* Size of a fragment in bytes */
+	unsigned long s_desc_size;	/* Size of a group descriptor in bytes */
 	unsigned long s_frags_per_block;/* Number of fragments per block */
 	unsigned long s_inodes_per_block;/* Number of inodes per block */
 	unsigned long s_frags_per_group;/* Number of fragments in a group */
