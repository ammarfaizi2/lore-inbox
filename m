Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268398AbRGXRxC>; Tue, 24 Jul 2001 13:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268403AbRGXRwy>; Tue, 24 Jul 2001 13:52:54 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:15885 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S268398AbRGXRwo>; Tue, 24 Jul 2001 13:52:44 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: axboe@suse.de (Jens Axboe), dougg@torque.net (Douglas Gilbert),
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: MO-Drive under 2.4.7 usinf vfat
In-Reply-To: <E15P5YA-0000NI-00@the-village.bc.nu>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: 25 Jul 2001 02:50:02 +0900
In-Reply-To: <E15P5YA-0000NI-00@the-village.bc.nu>
Message-ID: <87d76qnrn9.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.104
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > FAT oopses, right?
> > 
> > It will not be fixed (Logical sector size smaller than device sector
> > size) directly, there needs to be support for this type of thing. For
> > now folks should just use loop on top of DVD-RAM, for instance.
> 
> Oopses are bad. It means any random user can trick you into crashing your
> box just by swapping media around or you crash it in error
> 
> I/O error by all means - but oops is a bug
> 

Yes, I agree.

I finished now writing and testing the following patch which fixed
oops and some messages.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN linux-2.4.7/fs/fat/buffer.c fat-2.4.7/fs/fat/buffer.c
--- linux-2.4.7/fs/fat/buffer.c	Fri May 25 07:36:33 2001
+++ fat-2.4.7/fs/fat/buffer.c	Wed Jul 25 00:39:23 2001
@@ -100,62 +100,3 @@
 {
 	ll_rw_block(opr,nbreq,bh);
 }
-
-struct buffer_head *bigblock_fat_bread(struct super_block *sb, int block)
-{
-	unsigned int hardsect = get_hardsect_size(sb->s_dev);
-	int rblock, roffset;
-	struct buffer_head *real, *dummy;
-
-	if (hardsect <= sb->s_blocksize)
-		BUG();
-
-	dummy = NULL;
-	rblock = block / (hardsect / sb->s_blocksize);
-	roffset = (block % (hardsect / sb->s_blocksize)) * sb->s_blocksize;
-	real = bread(sb->s_dev, rblock, hardsect);
-	if (real != NULL) {
-		dummy = kmalloc(sizeof(struct buffer_head), GFP_KERNEL);
-		if (dummy != NULL) {
-			memset(dummy, 0, sizeof(*dummy));
-			dummy->b_data = real->b_data + roffset;
-			dummy->b_next = real;
-		} else
-			brelse(real);
-	}
-
-	return dummy;
-}
-
-void bigblock_fat_brelse(struct super_block *sb, struct buffer_head *bh)
-{
-	brelse(bh->b_next);
-	kfree(bh);
-}
-
-void bigblock_fat_mark_buffer_dirty(struct super_block *sb, struct buffer_head *bh)
-{
-	mark_buffer_dirty(bh->b_next);
-}
-
-void bigblock_fat_set_uptodate(struct super_block *sb, struct buffer_head *bh,
-			       int val)
-{
-	mark_buffer_uptodate(bh->b_next, val);
-}
-
-int bigblock_fat_is_uptodate(struct super_block *sb, struct buffer_head *bh)
-{
-	return buffer_uptodate(bh->b_next);
-}
-
-void bigblock_fat_ll_rw_block (struct super_block *sb, int opr, int nbreq,
-			       struct buffer_head *bh[32])
-{
-	struct buffer_head *tmp[32];
-	int i;
-
-	for (i = 0; i < nbreq; i++)
-		tmp[i] = bh[i]->b_next;
-	ll_rw_block(opr, nbreq, tmp);
-}
diff -urN linux-2.4.7/fs/fat/cvf.c fat-2.4.7/fs/fat/cvf.c
--- linux-2.4.7/fs/fat/cvf.c	Tue Oct 17 04:58:51 2000
+++ fat-2.4.7/fs/fat/cvf.c	Wed Jul 25 00:39:23 2001
@@ -23,79 +23,32 @@
 
 struct buffer_head *default_fat_bread(struct super_block *,int);
 struct buffer_head *default_fat_getblk(struct super_block *, int);
-struct buffer_head *bigblock_fat_bread(struct super_block *, int);
 void default_fat_brelse(struct super_block *, struct buffer_head *);
-void bigblock_fat_brelse(struct super_block *, struct buffer_head *);
-void default_fat_mark_buffer_dirty (struct super_block *,
-	struct buffer_head *);
-void bigblock_fat_mark_buffer_dirty (struct super_block *,
-	struct buffer_head *);
+void default_fat_mark_buffer_dirty (struct super_block *, struct buffer_head *);
 void default_fat_set_uptodate (struct super_block *, struct buffer_head *,int);
-void bigblock_fat_set_uptodate (struct super_block *, struct buffer_head *,int);
 int default_fat_is_uptodate(struct super_block *, struct buffer_head *);
-int bigblock_fat_is_uptodate(struct super_block *, struct buffer_head *);
 int default_fat_access(struct super_block *sb,int nr,int new_value);
-void default_fat_ll_rw_block (
-	struct super_block *sb,
-	int opr,
-	int nbreq,
-	struct buffer_head *bh[32]);
-void bigblock_fat_ll_rw_block (
-	struct super_block *sb,
-	int opr,
-	int nbreq,
-	struct buffer_head *bh[32]);
+void default_fat_ll_rw_block (struct super_block *sb, int opr, int nbreq,
+			      struct buffer_head *bh[32]);
 int default_fat_bmap(struct inode *inode,int block);
-ssize_t default_fat_file_write(
-	struct file *filp,
-	const char *buf,
-	size_t count,
-	loff_t *ppos);
+ssize_t default_fat_file_write(struct file *filp, const char *buf,
+			       size_t count, loff_t *ppos);
 
 struct cvf_format default_cvf = {
-	0,	/* version - who cares? */	
-	"plain",
-	0,	/* flags - who cares? */
-	NULL,
-	NULL,
-	NULL,
-	default_fat_bread,
-	default_fat_getblk,
-	default_fat_brelse,
-	default_fat_mark_buffer_dirty,
-	default_fat_set_uptodate,
-	default_fat_is_uptodate,
-	default_fat_ll_rw_block,
-	default_fat_access,
-	NULL,
-	default_fat_bmap,
-	generic_file_read,
-	default_fat_file_write,
-	NULL,
-	NULL
-};
-
-struct cvf_format bigblock_cvf = {
-	0,	/* version - who cares? */	
-	"big_blocks",
-	0,	/* flags - who cares? */
-	NULL,
-	NULL,
-	NULL,
-	bigblock_fat_bread,
-	bigblock_fat_bread,
-	bigblock_fat_brelse,
-	bigblock_fat_mark_buffer_dirty,
-	bigblock_fat_set_uptodate,
-	bigblock_fat_is_uptodate,
-	bigblock_fat_ll_rw_block,
-	default_fat_access,
-	NULL,
-	default_fat_bmap,
-	NULL,
-	default_fat_file_write,
-	NULL,
-	NULL
+	cvf_version: 		0,	/* version - who cares? */	
+	cvf_version_text: 	"plain",
+	flags:			0,	/* flags - who cares? */
+	cvf_bread:		default_fat_bread,
+	cvf_getblk:		default_fat_getblk,
+	cvf_brelse:		default_fat_brelse,
+	cvf_mark_buffer_dirty:	default_fat_mark_buffer_dirty,
+	cvf_set_uptodate:	default_fat_set_uptodate,
+	cvf_is_uptodate:	default_fat_is_uptodate,
+	cvf_ll_rw_block:	default_fat_ll_rw_block,
+	fat_access:		default_fat_access,
+	cvf_bmap:		default_fat_bmap,
+	cvf_file_read:		generic_file_read,
+	cvf_file_write:		default_fat_file_write,
 };
 
 struct cvf_format *cvf_formats[MAX_CVF_FORMATS];
diff -urN linux-2.4.7/fs/fat/inode.c fat-2.4.7/fs/fat/inode.c
--- linux-2.4.7/fs/fat/inode.c	Tue Jun 12 11:15:27 2001
+++ fat-2.4.7/fs/fat/inode.c	Wed Jul 25 01:22:35 2001
@@ -36,7 +36,7 @@
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>
 
-extern struct cvf_format default_cvf, bigblock_cvf;
+extern struct cvf_format default_cvf;
 
 /* #define FAT_PARANOIA 1 */
 #define DEBUG_LEVEL 0
@@ -448,8 +448,6 @@
 	hard_blksize = get_hardsect_size(sb->s_dev);
 	if (!hard_blksize)
 		hard_blksize = 512;
-	if (hard_blksize != 512)
-		printk("MSDOS: Hardware sector size is %d\n", hard_blksize);
 
 	opts.isvfat = sbi->options.isvfat;
 	if (!parse_options((char *) data, &fat, &debug, &opts,
@@ -464,8 +462,8 @@
 	set_blocksize(sb->s_dev, hard_blksize);
 	bh = bread(sb->s_dev, 0, sb->s_blocksize);
 	if (bh == NULL) {
-		brelse (bh);
-		goto out_no_bread;
+		printk("FAT: unable to read boot sector\n");
+		goto out_fail;
 	}
 
 /*
@@ -489,15 +487,23 @@
 		CF_LE_W(get_unaligned((unsigned short *) &b->sector_size));
 	if (!logical_sector_size
 	    || (logical_sector_size & (logical_sector_size - 1))) {
-		printk("fatfs: bogus logical sector size %d\n",
+		printk("FAT: bogus logical sector size %d\n",
 		       logical_sector_size);
 		brelse(bh);
 		goto out_invalid;
 	}
 
 	sbi->cluster_size = b->cluster_size;
-	if (!sbi->cluster_size || (sbi->cluster_size & (sbi->cluster_size - 1))) {
-		printk("fatfs: bogus cluster size %d\n", sbi->cluster_size);
+	if (!sbi->cluster_size
+	    || (sbi->cluster_size & (sbi->cluster_size - 1))) {
+		printk("FAT: bogus cluster size %d\n", sbi->cluster_size);
+		brelse(bh);
+		goto out_invalid;
+	}
+
+	if (logical_sector_size < hard_blksize) {
+		printk("FAT: logical sector size too small for device"
+		       " (logical sector size = %d)\n", logical_sector_size);
 		brelse(bh);
 		goto out_invalid;
 	}
@@ -528,8 +534,8 @@
 		if (bh->b_blocknr != fsinfo_block) {
 			fsinfo_bh = bread(sb->s_dev, fsinfo_block, hard_blksize);
 			if (fsinfo_bh == NULL) {
-				printk("FAT: bread failed, fsinfo block %d\n",
-				       fsinfo_block);
+				printk("FAT: bread failed, FSINFO block"
+				       " (blocknr = %d)\n", fsinfo_block);
 				brelse(bh);
 				goto out_invalid;
 			}
@@ -585,20 +591,14 @@
 
 	sb->s_blocksize = logical_sector_size;
 	sb->s_blocksize_bits = ffs(logical_sector_size) - 1;
-	if (sb->s_blocksize >= hard_blksize) {
-		set_blocksize(sb->s_dev, sb->s_blocksize);
-		sbi->cvf_format = &default_cvf;
-	} else {
-		set_blocksize(sb->s_dev, hard_blksize);
-		sbi->cvf_format = &bigblock_cvf;
-	}
-
-	if (!strcmp(cvf_format,"none"))
+	set_blocksize(sb->s_dev, sb->s_blocksize);
+	sbi->cvf_format = &default_cvf;
+	if (!strcmp(cvf_format, "none"))
 		i = -1;
 	else
 		i = detect_cvf(sb,cvf_format);
 	if (i >= 0)
-		error = cvf_formats[i]->mount_cvf(sb,cvf_options);
+		error = cvf_formats[i]->mount_cvf(sb, cvf_options);
 	if (error || debug) {
 		/* The MSDOS_CAN_BMAP is obsolete, but left just to remember */
 		printk("[MS-DOS FS Rel. 12,FAT %d,check=%c,conv=%c,"
@@ -607,16 +607,14 @@
 		       opts.conversion,opts.fs_uid,opts.fs_gid,opts.fs_umask,
 		       MSDOS_CAN_BMAP(sbi) ? ",bmap" : "");
 		printk("[me=0x%x,cs=%d,#f=%d,fs=%d,fl=%ld,ds=%ld,de=%d,data=%ld,"
-		       "se=%d,ts=%ld,ls=%d,rc=%ld,fc=%u]\n",
-		       b->media,sbi->cluster_size,
-		       sbi->fats,sbi->fat_start,
-		       sbi->fat_length,
-		       sbi->dir_start,sbi->dir_entries,
-		       sbi->data_start,
-		       CF_LE_W(*(unsigned short *) &b->sectors),
-		       (unsigned long)b->total_sect,logical_sector_size,
-		       sbi->root_cluster,sbi->free_clusters);
-		printk ("Transaction block size = %d\n", hard_blksize);
+		       "se=%u,ts=%u,ls=%d,rc=%ld,fc=%u]\n",
+		       b->media, sbi->cluster_size, sbi->fats,
+		       sbi->fat_start, sbi->fat_length, sbi->dir_start,
+		       sbi->dir_entries, sbi->data_start,
+		       CF_LE_W(get_unaligned((unsigned short *)&b->sectors)),
+		       CF_LE_L(b->total_sect), logical_sector_size,
+		       sbi->root_cluster, sbi->free_clusters);
+		printk ("hard sector size = %d\n", hard_blksize);
 	}
 	if (i < 0)
 		if (sbi->clusters + 2 > fat_clusters)
@@ -653,7 +651,7 @@
 	if (! sbi->nls_io)
 		sbi->nls_io = load_nls_default();
 
-	root_inode=new_inode(sb);
+	root_inode = new_inode(sb);
 	if (!root_inode)
 		goto out_unload_nls;
 	root_inode->i_ino = MSDOS_ROOT_INO;
@@ -662,29 +660,27 @@
 	sb->s_root = d_alloc_root(root_inode);
 	if (!sb->s_root)
 		goto out_no_root;
-	if(i>=0) {
+	if(i >= 0) {
 		sbi->cvf_format = cvf_formats[i];
 		++cvf_format_use_count[i];
 	}
 	return sb;
 
 out_no_root:
-	printk("get root inode failed\n");
+	printk("FAT: get root inode failed\n");
 	iput(root_inode);
 	unload_nls(sbi->nls_io);
 out_unload_nls:
 	unload_nls(sbi->nls_disk);
 	goto out_fail;
 out_invalid:
-	if (!silent)
-		printk("VFS: Can't find a valid MSDOS filesystem on dev %s.\n",
+	if (!silent) {
+		printk("VFS: Can't find a valid FAT filesystem on dev %s.\n",
 			kdevname(sb->s_dev));
-	goto out_fail;
-out_no_bread:
-	printk("FAT bread failed\n");
+	}
 out_fail:
 	if (opts.iocharset) {
-		printk("VFS: freeing iocharset=%s\n", opts.iocharset);
+		printk("FAT: freeing iocharset=%s\n", opts.iocharset);
 		kfree(opts.iocharset);
 	}
 	if(sbi->private_data)

