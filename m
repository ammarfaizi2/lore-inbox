Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136330AbRA1BUC>; Sat, 27 Jan 2001 20:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136333AbRA1BTx>; Sat, 27 Jan 2001 20:19:53 -0500
Received: from mx03.uni-tuebingen.de ([134.2.3.13]:63758 "EHLO
	mx03.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S136330AbRA1BTq>; Sat, 27 Jan 2001 20:19:46 -0500
Date: Sun, 28 Jan 2001 02:12:38 +0100 (CET)
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
To: Stefan Meyknecht <sm@voyager.ping.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Oops accessing file on 2048 bytes/sector vfat MO in 2.4.0
In-Reply-To: <20010126214058.A400@voyager.ping.de>
Message-ID: <Pine.LNX.3.96.1010128020616.3321A-100000@yksi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moi!

On Fri, 26 Jan 2001, Stefan Meyknecht wrote:

> I receive a Kernel oops while copying a file from MO-drive (vfat) with
> 2048 bytes sector size. There is no problen with ext2 formatted MOs.
> 
> I think it happens because the function pointer cfv_file_read of the
> struct cvf_format is initialized with null.

Yup, that's the cause.

> This oops is 100% reproducable with the kernels: 2.4.0, 2.4.1-pre3,
> 2.4.1-pre7 and 2.4.0-ac11 (probably all >= 2.4.0).

... and on a fair number < 2.4.0. The patch below will give you (dog slow)
read access to your FAT MOs. Apply in fs/fat/. And don't even think about
write() and mmap().

Regards,

Daniel.

--[snip]--
--- cvf.c.vanilla	Mon Jan  1 22:46:20 2001
+++ cvf.c	Mon Jan  1 23:31:23 2001
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
--- file.c.vanilla	Mon Jan  1 22:46:26 2001
+++ file.c	Tue Jan 16 00:15:16 2001
@@ -4,6 +4,9 @@
  *  Written 1992,1993 by Werner Almesberger
  *
  *  regular file handling primitives for fat-based filesystems
+ *
+ *  2001-1-1 Daniel Kobras <kobras@linux.de>:
+ *  Added quick&dirty read operation for large sector media.
  */
 
 #define ASC_LINUX_VERSION(V, P, S)	(((V) * 65536) + ((P) * 256) + (S))
@@ -114,6 +117,56 @@
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
+		if (copy_to_user(buf, bh->b_data, done)) {
+			fat_brelse(inode->i_sb, bh);
+			return -EFAULT;
+		}
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
--- inode.c.vanilla	Tue Jan  2 00:36:18 2001
+++ inode.c	Tue Jan  2 00:22:04 2001
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
