Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131633AbRAOXgK>; Mon, 15 Jan 2001 18:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131455AbRAOXft>; Mon, 15 Jan 2001 18:35:49 -0500
Received: from mx03.uni-tuebingen.de ([134.2.3.13]:9477 "EHLO
	mx03.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S131365AbRAOXfk>; Mon, 15 Jan 2001 18:35:40 -0500
Date: Tue, 16 Jan 2001 00:28:59 +0100 (CET)
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
To: Robert Reither <e8925573@student.tuwien.ac.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with bigblock support of fat
In-Reply-To: <Pine.HPX.4.10.10101152002410.23822-100000@stud4.tuwien.ac.at>
Message-ID: <Pine.LNX.3.96.1010116000553.327D-100000@yksi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 Jan 2001, Robert Reither wrote:

> I encounted really bad problems with 2048 Bytes/sec MO-Drive.
> I'm using an Olympus PowerMO 640.
> MO was formated with FAT32.
> 
> i try to read a file from it (used : 'pico /mo/file.txt') ...
> And got a nice crash : Segmentation Fault

Even worse. Trying to read any file on a 2k hwblk FAT yields an oops
actually.

> OK, was easy to find this bug, fs/fat/cvf.c has a bug in bigblock_cvf struct
> the field with the read function was a NULL.
> I changed this to generic_file_read (like with default blocksize), and
> tested it. First seemed to work fine, but :
> 
> If i write a file to an empty MO-Disk, the start-cluster is 2 in the 
> table. But the real data was written to (and also read from)
> cluster 33 by linux !

The generic routines do not handle the (rather braindead) case of
hwblksize > logical blksize. FAT uses a logical block (sector/whatever
you like to name it) size of 512 byte, which obviously sucks. Now,
generic_file_read miscalculates the blocks it has to get, but in the same
way as generic_file_write, so two errors yield a working setup, but only
for data you wrote with a buggy kernel. You won't be able to access any
previously written data in this way.

A few days ago, I posted the below patch as a quick band-aid to get at
least the read() part back to a working state again. It also disables the
equally dysfunctional mmap() on 2k media. It ought to disable write() as
well, but I didn't bother. Just don't do it. It's probably best to use the
patch to backup your data and reformat your MOs with a sane fs. Run, don't
walk. ;-)

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
