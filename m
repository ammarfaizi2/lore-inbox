Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUFTRbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUFTRbu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUFTRbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:31:45 -0400
Received: from nl-ams-slo-l4-01-pip-3.chellonetwork.com.243.46.213.in-addr.arpa ([213.46.243.17]:13119 "EHLO amsfep12-int.chello.nl")
	by vger.kernel.org with ESMTP id S265805AbUFTRZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:25:56 -0400
Date: Sun, 20 Jun 2004 19:25:56 +0200
Message-Id: <200406201725.i5KHPuYc001500@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 454] affs remount
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AFFS: Fix oops on write after remount (from Roman Zippel):
  - Allocate/free bitmap as necessary
  - Remove last uses of SF_READONLY

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.7/fs/affs/amigaffs.c	2004-04-27 20:27:43.000000000 +0200
+++ linux-m68k-2.6.7/fs/affs/amigaffs.c	2004-06-18 11:17:49.000000000 +0200
@@ -458,7 +458,6 @@
 	if (!(sb->s_flags & MS_RDONLY))
 		printk(KERN_WARNING "AFFS: Remounting filesystem read-only\n");
 	sb->s_flags |= MS_RDONLY;
-	AFFS_SB(sb)->s_flags |= SF_READONLY;	/* Don't allow to remount rw */
 }
 
 void
--- linux-2.6.7/fs/affs/bitmap.c	2004-04-27 20:41:22.000000000 +0200
+++ linux-m68k-2.6.7/fs/affs/bitmap.c	2004-06-18 11:17:49.000000000 +0200
@@ -272,8 +272,7 @@
 	return 0;
 }
 
-int
-affs_init_bitmap(struct super_block *sb)
+int affs_init_bitmap(struct super_block *sb, int *flags)
 {
 	struct affs_bm_info *bm;
 	struct buffer_head *bmap_bh = NULL, *bh = NULL;
@@ -282,13 +281,13 @@
 	int i, res = 0;
 	struct affs_sb_info *sbi = AFFS_SB(sb);
 
-	if (sb->s_flags & MS_RDONLY)
+	if (*flags & MS_RDONLY)
 		return 0;
 
 	if (!AFFS_ROOT_TAIL(sb, sbi->s_root_bh)->bm_flag) {
 		printk(KERN_NOTICE "AFFS: Bitmap invalid - mounting %s read only\n",
 			sb->s_id);
-		sb->s_flags |= MS_RDONLY;
+		*flags |= MS_RDONLY;
 		return 0;
 	}
 
@@ -301,7 +300,7 @@
 	bm = sbi->s_bitmap = kmalloc(size, GFP_KERNEL);
 	if (!sbi->s_bitmap) {
 		printk(KERN_ERR "AFFS: Bitmap allocation failed\n");
-		return 1;
+		return -ENOMEM;
 	}
 	memset(sbi->s_bitmap, 0, size);
 
@@ -316,13 +315,13 @@
 		bh = affs_bread(sb, bm->bm_key);
 		if (!bh) {
 			printk(KERN_ERR "AFFS: Cannot read bitmap\n");
-			res = 1;
+			res = -EIO;
 			goto out;
 		}
 		if (affs_checksum_block(sb, bh)) {
 			printk(KERN_WARNING "AFFS: Bitmap %u invalid - mounting %s read only.\n",
 			       bm->bm_key, sb->s_id);
-			sb->s_flags |= MS_RDONLY;
+			*flags |= MS_RDONLY;
 			goto out;
 		}
 		pr_debug("AFFS: read bitmap block %d: %d\n", blk, bm->bm_key);
@@ -338,7 +337,7 @@
 		bmap_bh = affs_bread(sb, be32_to_cpu(bmap_blk[blk]));
 		if (!bmap_bh) {
 			printk(KERN_ERR "AFFS: Cannot read bitmap extension\n");
-			res = 1;
+			res = -EIO;
 			goto out;
 		}
 		bmap_blk = (u32 *)bmap_bh->b_data;
@@ -383,3 +382,17 @@
 	affs_brelse(bmap_bh);
 	return res;
 }
+
+void affs_free_bitmap(struct super_block *sb)
+{
+	struct affs_sb_info *sbi = AFFS_SB(sb);
+
+	if (!sbi->s_bitmap)
+		return;
+
+	affs_brelse(sbi->s_bmap_bh);
+	sbi->s_bmap_bh = NULL;
+	sbi->s_last_bmap = ~0;
+	kfree(sbi->s_bitmap);
+	sbi->s_bitmap = NULL;
+}
--- linux-2.6.7/fs/affs/super.c	2004-05-03 20:04:58.000000000 +0200
+++ linux-m68k-2.6.7/fs/affs/super.c	2004-06-18 11:17:49.000000000 +0200
@@ -51,10 +51,9 @@
 		mark_buffer_dirty(sbi->s_root_bh);
 	}
 
-	affs_brelse(sbi->s_bmap_bh);
 	if (sbi->s_prefix)
 		kfree(sbi->s_prefix);
-	kfree(sbi->s_bitmap);
+	affs_free_bitmap(sb);
 	affs_brelse(sbi->s_root_bh);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
@@ -288,6 +287,7 @@
 	gid_t			 gid;
 	int			 reserved;
 	unsigned long		 mount_flags;
+	int			 tmp_flags;	/* fix remount prototype... */
 
 	pr_debug("AFFS: read_super(%s)\n",data ? (const char *)data : "no options");
 
@@ -399,7 +399,6 @@
 		printk(KERN_NOTICE "AFFS: Dircache FS - mounting %s read only\n",
 			sb->s_id);
 		sb->s_flags |= MS_RDONLY;
-		sbi->s_flags |= SF_READONLY;
 	}
 	switch (chksum) {
 		case MUFS_FS:
@@ -455,8 +454,10 @@
 	sbi->s_root_bh = root_bh;
 	/* N.B. after this point s_root_bh must be released */
 
-	if (affs_init_bitmap(sb))
+	tmp_flags = sb->s_flags;
+	if (affs_init_bitmap(sb, &tmp_flags))
 		goto out_error;
+	sb->s_flags = tmp_flags;
 
 	/* set up enough so that it can read an inode */
 
@@ -498,7 +499,7 @@
 	int			 reserved;
 	int			 root_block;
 	unsigned long		 mount_flags;
-	unsigned long		 read_only = sbi->s_flags & SF_READONLY;
+	int			 res = 0;
 
 	pr_debug("AFFS: remount(flags=0x%x,opts=\"%s\")\n",*flags,data);
 
@@ -507,7 +508,7 @@
 	if (!parse_options(data,&uid,&gid,&mode,&reserved,&root_block,
 	    &blocksize,&sbi->s_prefix,sbi->s_volume,&mount_flags))
 		return -EINVAL;
-	sbi->s_flags = mount_flags | read_only;
+	sbi->s_flags = mount_flags;
 	sbi->s_mode  = mode;
 	sbi->s_uid   = uid;
 	sbi->s_gid   = gid;
@@ -518,14 +519,11 @@
 		sb->s_dirt = 1;
 		while (sb->s_dirt)
 			affs_write_super(sb);
-		sb->s_flags |= MS_RDONLY;
-	} else if (!(sbi->s_flags & SF_READONLY)) {
-		sb->s_flags &= ~MS_RDONLY;
-	} else {
-		affs_warning(sb,"remount","Cannot remount fs read/write because of errors");
-		return -EINVAL;
-	}
-	return 0;
+		affs_free_bitmap(sb);
+	} else
+		res = affs_init_bitmap(sb, flags);
+
+	return res;
 }
 
 static int
--- linux-2.6.7/include/linux/affs_fs.h	2004-04-27 20:50:48.000000000 +0200
+++ linux-m68k-2.6.7/include/linux/affs_fs.h	2004-06-18 11:18:33.000000000 +0200
@@ -36,7 +36,8 @@
 extern u32	affs_count_free_blocks(struct super_block *s);
 extern void	affs_free_block(struct super_block *sb, u32 block);
 extern u32	affs_alloc_block(struct inode *inode, u32 goal);
-extern int	affs_init_bitmap(struct super_block *sb);
+extern int	affs_init_bitmap(struct super_block *sb, int *flags);
+extern void	affs_free_bitmap(struct super_block *sb);
 
 /* namei.c */
 
--- linux-2.6.7/include/linux/affs_fs_sb.h	2004-04-27 20:24:33.000000000 +0200
+++ linux-m68k-2.6.7/include/linux/affs_fs_sb.h	2004-06-18 11:18:33.000000000 +0200
@@ -47,7 +47,6 @@
 #define SF_OFS		0x0200		/* Old filesystem */
 #define SF_PREFIX	0x0400		/* Buffer for prefix is allocated */
 #define SF_VERBOSE	0x0800		/* Talk about fs when mounting */
-#define SF_READONLY	0x1000		/* Don't allow to remount rw */
 
 /* short cut to get to the affs specific sb data */
 static inline struct affs_sb_info *AFFS_SB(struct super_block *sb)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
