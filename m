Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129778AbRABAco>; Mon, 1 Jan 2001 19:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129798AbRABAce>; Mon, 1 Jan 2001 19:32:34 -0500
Received: from mx03.uni-tuebingen.de ([134.2.3.13]:56330 "EHLO
	mx03.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S129778AbRABAcX>; Mon, 1 Jan 2001 19:32:23 -0500
Date: Tue, 2 Jan 2001 00:56:02 +0100 (CET)
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Reply-To: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Al Viro <viro@math.psu.edu>, Desert Dragon <thoth@leapdragon.net>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-prerelease & 2048-byte FAT sectors
In-Reply-To: <E14Cw0L-0000RZ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1010102003746.2527A-100000@yksi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 1 Jan 2001, Alan Cox wrote:

> > Just installed 2.4.0-prerelease, and it looks like FAT
> > filesystems on hardware 2048-byte sectors are still not
> > working.
> > Are there any plans to fix this, or should I consider
> 
> Jens was fixing it for CD-ROM devices. I dont know if anyone was fixing
> for M/O devices currently
> 
> > such devices obsolete? I'm keeping 2.2.17 around and
> 
> Far from obsolete - its a bug. 

This patch works good enough for me to get at the data on my MOs. Buyers
beware! I'm completely ignorant to fs issues, so the implementation is
not only dog slow but very probably also buggy. Anyway, it works for me,
and it should be better than the current oops on read(). Maybe Al can have
a quick look at it?

I also disabled mmap for large hw-block devices because the current
implementation yields incorrect results. 

Regards,

Daniel.

--[snip]--

--- fs/fat/cvf.c.vanilla	Mon Jan  1 22:46:20 2001
+++ fs/fat/cvf.c	Mon Jan  1 23:31:23 2001
@@ -51,6 +51,9 @@
 	const char *buf,
 	size_t count,
 	loff_t *ppos);
+ssize_t bigblock_fat_file_read(struct file *filp, char *buf, size_t count,
+                               loff_t *ppos);
+
 
 struct cvf_format default_cvf = {
 	0,	/* version - who cares? */	
@@ -92,7 +95,7 @@
 	default_fat_access,
 	NULL,
 	default_fat_bmap,
-	NULL,
+	bigblock_fat_file_read,
 	default_fat_file_write,
 	NULL,
 	NULL
--- fs/fat/file.c.vanilla	Mon Jan  1 22:46:26 2001
+++ fs/fat/file.c	Tue Jan  2 00:11:01 2001
@@ -4,6 +4,9 @@
  *  Written 1992,1993 by Werner Almesberger
  *
  *  regular file handling primitives for fat-based filesystems
+ *
+ *  2001-1-1 Daniel Kobras <kobras@linux.de>:
+ *  Added quick&dirty read operation for large sector media.
  */
 
 #define ASC_LINUX_VERSION(V, P, S)	(((V) * 65536) + ((P) * 256) + (S))
@@ -114,6 +117,54 @@
 	return retval;
 }
 
+/* This is a hack. No readahead and other fancy stuff, but hopefully enough
+ * to get MOs working again. [dk]
+ * FIXME: Not sure whether I got error checking right.
+ */
+ssize_t bigblock_fat_file_read(struct file *filp, char *buf, size_t count, 
+                           loff_t *ppos)
+{
+	struct inode *inode = filp->f_dentry->d_inode;
+	int phys, pos;
+	struct buffer_head *bh;
+	size_t to_go, done;
+	char *buf_start = buf;
+
+	/* Taken from 2.2 source. */
+	if (!S_ISREG(inode->i_mode) && !S_ISLNK(inode->i_mode))
+		return -EINVAL;
+	
+	if (*ppos > inode->i_size || !count)
+		return 0;
+
+	if (inode->i_size - *ppos < count) 
+		count = inode->i_size - *ppos;
+
+	pos = *ppos>>SECTOR_BITS;
+	to_go = SECTOR_SIZE - (*ppos&(SECTOR_SIZE-1));
+	goto _start;
+	
+	do {
+		to_go = SECTOR_SIZE;
+_start:
+		phys = fat_bmap(inode, pos++);
+		if (!phys)
+			return -EIO;
+		bh = fat_bread(inode->i_sb, phys);
+		if (!bh)
+			return -EIO;
+		done = to_go > count ? count : to_go;
+		if (copy_to_user(buf, bh->b_data, done))
+			return -EFAULT;
+		fat_brelse(inode->i_sb, bh);
+		buf += done;
+		*ppos += done;
+	} while ((count -= done));
+
+	return buf - buf_start;
+}	
+	
+	
 void fat_truncate(struct inode *inode)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
--- fs/fat/inode.c.vanilla	Tue Jan  2 00:36:18 2001
+++ fs/fat/inode.c	Tue Jan  2 00:22:04 2001
@@ -820,6 +820,9 @@
 		inode->i_size = CF_LE_L(de->size);
 	        inode->i_op = &fat_file_inode_operations;
 	        inode->i_fop = &fat_file_operations;
+		/* FIXME: mmap is broken with large hwblocks! [dk] */
+		if (sb->s_blocksize > 512)
+			inode->i_fop->mmap = NULL;
 		inode->i_mapping->a_ops = &fat_aops;
 		MSDOS_I(inode)->mmu_private = inode->i_size;
 	}


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
