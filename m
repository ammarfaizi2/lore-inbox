Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUFTRXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUFTRXi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265803AbUFTRXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:23:38 -0400
Received: from nl-ams-slo-l4-01-pip-5.chellonetwork.com ([213.46.243.21]:42043
	"EHLO amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S265795AbUFTRUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:20:51 -0400
Date: Sun, 20 Jun 2004 19:20:38 +0200
Message-Id: <200406201720.i5KHKcQB001332@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 154] affs remount
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AFFS: Fix oops on write after remount (from Roman Zippel):
  - Allocate/free bitmap as necessary
  - Remove last uses of SF_READONLY

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.4.27-rc1/fs/affs/amigaffs.c	2004-04-27 16:45:03.000000000 +0200
+++ linux-m68k-2.4.27-rc1/fs/affs/amigaffs.c	2004-06-18 11:07:08.000000000 +0200
@@ -458,7 +458,6 @@
 	if (!(sb->s_flags & MS_RDONLY))
 		printk(KERN_WARNING "AFFS: Remounting filesystem read-only\n");
 	sb->s_flags |= MS_RDONLY;
-	AFFS_SB->s_flags |= SF_READONLY;	/* Don't allow to remount rw */
 }
 
 void
--- linux-2.4.27-rc1/fs/affs/bitmap.c	2004-04-27 17:05:21.000000000 +0200
+++ linux-m68k-2.4.27-rc1/fs/affs/bitmap.c	2004-06-18 11:07:08.000000000 +0200
@@ -268,8 +268,7 @@
 	return 0;
 }
 
-int
-affs_init_bitmap(struct super_block *sb)
+int affs_init_bitmap(struct super_block *sb, int *flags)
 {
 	struct affs_bm_info *bm;
 	struct buffer_head *bmap_bh = NULL, *bh = NULL;
@@ -277,13 +276,13 @@
 	u32 size, blk, end, offset, mask;
 	int i, res = 0;
 
-	if (sb->s_flags & MS_RDONLY)
+	if (*flags & MS_RDONLY)
 		return 0;
 
 	if (!AFFS_ROOT_TAIL(sb, AFFS_SB->s_root_bh)->bm_flag) {
 		printk(KERN_NOTICE "AFFS: Bitmap invalid - mounting %s read only\n",
 			kdevname(sb->s_dev));
-		sb->s_flags |= MS_RDONLY;
+		*flags |= MS_RDONLY;
 		return 0;
 	}
 
@@ -296,7 +295,7 @@
 	bm = AFFS_SB->s_bitmap = kmalloc(size, GFP_KERNEL);
 	if (!AFFS_SB->s_bitmap) {
 		printk(KERN_ERR "AFFS: Bitmap allocation failed\n");
-		return 1;
+		return -ENOMEM;
 	}
 	memset(AFFS_SB->s_bitmap, 0, size);
 
@@ -311,13 +310,13 @@
 		bh = affs_bread(sb, bm->bm_key);
 		if (!bh) {
 			printk(KERN_ERR "AFFS: Cannot read bitmap\n");
-			res = 1;
+			res = -EIO;
 			goto out;
 		}
 		if (affs_checksum_block(sb, bh)) {
 			printk(KERN_WARNING "AFFS: Bitmap %u invalid - mounting %s read only.\n",
 			       bm->bm_key, kdevname(sb->s_dev));
-			sb->s_flags |= MS_RDONLY;
+			*flags |= MS_RDONLY;
 			goto out;
 		}
 		pr_debug("AFFS: read bitmap block %d: %d\n", blk, bm->bm_key);
@@ -333,7 +332,7 @@
 		bmap_bh = affs_bread(sb, be32_to_cpu(bmap_blk[blk]));
 		if (!bmap_bh) {
 			printk(KERN_ERR "AFFS: Cannot read bitmap extension\n");
-			res = 1;
+			res = -EIO;
 			goto out;
 		}
 		bmap_blk = (u32 *)bmap_bh->b_data;
@@ -378,3 +377,15 @@
 	affs_brelse(bmap_bh);
 	return res;
 }
+
+void affs_free_bitmap(struct super_block *sb)
+{
+	if (!AFFS_SB->s_bitmap)
+		return;
+
+	affs_brelse(AFFS_SB->s_bmap_bh);
+	AFFS_SB->s_bmap_bh = NULL;
+	AFFS_SB->s_last_bmap = ~0;
+	kfree(AFFS_SB->s_bitmap);
+	AFFS_SB->s_bitmap = NULL;
+}
--- linux-2.4.27-rc1/fs/affs/super.c	2004-04-27 17:05:21.000000000 +0200
+++ linux-m68k-2.4.27-rc1/fs/affs/super.c	2004-06-18 11:07:09.000000000 +0200
@@ -48,10 +48,9 @@
 		mark_buffer_dirty(AFFS_SB->s_root_bh);
 	}
 
-	affs_brelse(AFFS_SB->s_bmap_bh);
 	if (AFFS_SB->s_prefix)
 		kfree(AFFS_SB->s_prefix);
-	kfree(AFFS_SB->s_bitmap);
+	affs_free_bitmap(sb);
 	affs_brelse(AFFS_SB->s_root_bh);
 
 	return;
@@ -235,6 +234,7 @@
 	gid_t			 gid;
 	int			 reserved;
 	unsigned long		 mount_flags;
+	int			 tmp_flags;	/* fix remount prototype... */
 
 	pr_debug("AFFS: read_super(%s)\n",data ? (const char *)data : "no options");
 
@@ -349,7 +349,6 @@
 		printk(KERN_NOTICE "AFFS: Dircache FS - mounting %s read only\n",
 			kdevname(dev));
 		sb->s_flags |= MS_RDONLY;
-		AFFS_SB->s_flags |= SF_READONLY;
 	}
 	switch (chksum) {
 		case MUFS_FS:
@@ -405,8 +404,10 @@
 	AFFS_SB->s_root_bh = root_bh;
 	/* N.B. after this point s_root_bh must be released */
 
-	if (affs_init_bitmap(sb))
+	tmp_flags = sb->s_flags;
+	if (affs_init_bitmap(sb, &tmp_flags))
 		goto out_error;
+	sb->s_flags = tmp_flags;
 
 	/* set up enough so that it can read an inode */
 
@@ -445,14 +446,14 @@
 	int			 reserved;
 	int			 root_block;
 	unsigned long		 mount_flags;
-	unsigned long		 read_only = AFFS_SB->s_flags & SF_READONLY;
+	int			 res = 0;
 
 	pr_debug("AFFS: remount(flags=0x%x,opts=\"%s\")\n",*flags,data);
 
 	if (!parse_options(data,&uid,&gid,&mode,&reserved,&root_block,
 	    &blocksize,&AFFS_SB->s_prefix,AFFS_SB->s_volume,&mount_flags))
 		return -EINVAL;
-	AFFS_SB->s_flags = mount_flags | read_only;
+	AFFS_SB->s_flags = mount_flags;
 	AFFS_SB->s_mode  = mode;
 	AFFS_SB->s_uid   = uid;
 	AFFS_SB->s_gid   = gid;
@@ -463,14 +464,11 @@
 		sb->s_dirt = 1;
 		while (sb->s_dirt)
 			affs_write_super(sb);
-		sb->s_flags |= MS_RDONLY;
-	} else if (!(AFFS_SB->s_flags & SF_READONLY)) {
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
--- linux-2.4.27-rc1/include/linux/affs_fs.h	2004-04-27 16:25:20.000000000 +0200
+++ linux-m68k-2.4.27-rc1/include/linux/affs_fs.h	2004-06-18 11:08:06.000000000 +0200
@@ -33,7 +33,8 @@
 extern u32	affs_count_free_blocks(struct super_block *s);
 extern void	affs_free_block(struct super_block *sb, u32 block);
 extern u32	affs_alloc_block(struct inode *inode, u32 goal);
-extern int	affs_init_bitmap(struct super_block *sb);
+extern int	affs_init_bitmap(struct super_block *sb, int *flags);
+extern void	affs_free_bitmap(struct super_block *sb);
 
 /* namei.c */
 
--- linux-2.4.27-rc1/include/linux/affs_fs_sb.h	2004-04-27 16:25:20.000000000 +0200
+++ linux-m68k-2.4.27-rc1/include/linux/affs_fs_sb.h	2004-06-18 11:08:06.000000000 +0200
@@ -47,7 +47,6 @@
 #define SF_OFS		0x0200		/* Old filesystem */
 #define SF_PREFIX	0x0400		/* Buffer for prefix is allocated */
 #define SF_VERBOSE	0x0800		/* Talk about fs when mounting */
-#define SF_READONLY	0x1000		/* Don't allow to remount rw */
 
 /* short cut to get to the affs specific sb data */
 #define AFFS_SB		(&sb->u.affs_sb)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
