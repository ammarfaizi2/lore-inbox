Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWEGM6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWEGM6P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 08:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWEGM6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 08:58:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:63922 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932145AbWEGM6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 08:58:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type;
        b=IQK435C5rZ0ADwKNtxl/nH+sBkF3oQjG3OXb5NG8msTCtL1RXUzYFSlWMQ4TjDX5+yNX6i2Wye5sRtyMQ05UMLqDVUKg9XdctlwRCkg08di0qc1cAPL3auDX4UysPU9Mq2RqmSuwv34B3HlOXkUqm1H6aG4DU6Mx5ip4XcjXQAk=
Message-ID: <445DEEAC.9060004@gmail.com>
Date: Sun, 07 May 2006 14:57:16 +0200
From: =?ISO-8859-1?Q?Daniel_Aragon=E9s?= <danarag@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: es-ar, es, en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Jiri Slaby <jirislaby@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH/RFC] minix_fs_v3 update corrected according to Al Viro
Content-Type: multipart/mixed;
 boundary="------------040403080606050205080907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040403080606050205080907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Al,

Thank you very much for your suggestions!

I have included the function ffs() and  renamed namx to name (where possible), 
and inodx to inumber.

You can see that kmalloc was suppressed already in my former release
v3_6dot17-rc3-3.diff few days ago.

The apparent complication in bitmap.c is that I have kept the architecture
dependent operations within the range of 1K size to avoid unexpected trouble in
some of them.

Regards,

Daniel


--------------040403080606050205080907
Content-Type: text/plain;
 name="v3_6dot17-rc3-4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v3_6dot17-rc3-4.diff"

diff -ur orig.Linux-2.6.17-rc3/fs/minix/bitmap.c updated.Linux-2.6.17-rc3/fs/minix/bitmap.c
--- orig.Linux-2.6.17-rc3/fs/minix/bitmap.c	2006-04-27 04:19:25.000000000 +0200
+++ updated.Linux-2.6.17-rc3/fs/minix/bitmap.c	2006-05-07 14:21:33.000000000 +0200
@@ -26,14 +26,14 @@
 	for (i=0; i<numblocks-1; i++) {
 		if (!(bh=map[i])) 
 			return(0);
-		for (j=0; j<BLOCK_SIZE; j++)
+		for (j=0; j<bh->b_size; j++)
 			sum += nibblemap[bh->b_data[j] & 0xf]
 				+ nibblemap[(bh->b_data[j]>>4) & 0xf];
 	}
 
 	if (numblocks==0 || !(bh=map[numblocks-1]))
 		return(0);
-	i = ((numbits-(numblocks-1)*BLOCK_SIZE*8)/16)*2;
+	i = ((numbits-(numblocks-1) * bh->b_size * 8) / 16) * 2;
 	for (j=0; j<i; j++) {
 		sum += nibblemap[bh->b_data[j] & 0xf]
 			+ nibblemap[(bh->b_data[j]>>4) & 0xf];
@@ -48,12 +48,22 @@
 	return(sum);
 }
 
-void minix_free_block(struct inode * inode, int block)
+int minix3_block_size_shift(struct super_block *sb)
+{
+	int k = ffs(sb->s_blocksize) - 11 ;
+	return k;
+}
+
+void minix_free_block(struct inode *inode, unsigned long block)
 {
 	struct super_block * sb = inode->i_sb;
 	struct minix_sb_info * sbi = minix_sb(sb);
 	struct buffer_head * bh;
-	unsigned int bit,zone;
+	int k = minix3_block_size_shift(sb);
+	int mask = 15;
+	unsigned long bit, zone;
+	char *offset;
+	offset = NULL;
 
 	if (block < sbi->s_firstdatazone || block >= sbi->s_nzones) {
 		printk("Trying to free block not in datazone\n");
@@ -62,14 +72,18 @@
 	zone = block - sbi->s_firstdatazone + 1;
 	bit = zone & 8191;
 	zone >>= 13;
-	if (zone >= sbi->s_zmap_blocks) {
+	if ((zone >> k) >= sbi->s_zmap_blocks) {
 		printk("minix_free_block: nonexistent bitmap buffer\n");
 		return;
 	}
-	bh = sbi->s_zmap[zone];
+	/* keeping within 1K scope in all architectures to avoid trouble */
+	bh = sbi->s_zmap[zone >> k];
+	mask >>= (4 - k);
+	offset = (char *)bh->b_data;
+	offset += (zone & mask) * 1024;
 	lock_kernel();
-	if (!minix_test_and_clear_bit(bit,bh->b_data))
-		printk("free_block (%s:%d): bit already cleared\n",
+	if (!minix_test_and_clear_bit(bit, offset))
+		printk("free_block (%s:%lu): bit already cleared\n",
 		       sb->s_id, block);
 	unlock_kernel();
 	mark_buffer_dirty(bh);
@@ -79,24 +93,34 @@
 int minix_new_block(struct inode * inode)
 {
 	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
-	int i;
+	int num_1K_blocks = inode->i_sb->s_blocksize / 1024;
+	int bits_per_zone = 8 * inode->i_sb->s_blocksize;
+	int i, k;
+	char *offset;
+	offset = NULL;
 
 	for (i = 0; i < sbi->s_zmap_blocks; i++) {
 		struct buffer_head *bh = sbi->s_zmap[i];
-		int j;
+		for (k = 0; k < num_1K_blocks; k++) {
+			int j;
 
-		lock_kernel();
-		if ((j = minix_find_first_zero_bit(bh->b_data, 8192)) < 8192) {
-			minix_set_bit(j,bh->b_data);
-			unlock_kernel();
-			mark_buffer_dirty(bh);
-			j += i*8192 + sbi->s_firstdatazone-1;
-			if (j < sbi->s_firstdatazone || j >= sbi->s_nzones)
-				break;
-			return j;
+			offset = (char *)bh->b_data;
+			offset += k * 1024;
+			lock_kernel();
+			if ((j = minix_find_first_zero_bit(offset, 8192))
+				< 8192) {
+				minix_set_bit(j, offset);
+				unlock_kernel();
+				mark_buffer_dirty(bh);
+				j += k * 8192 + i * bits_per_zone + sbi->s_firstdatazone-1;
+				if (j <sbi->s_firstdatazone || j >= sbi->s_nzones)
+	 	 			goto break_both;
+ 				return j;
+ 			}
 		}
 		unlock_kernel();
 	}
+break_both:
 	return 0;
 }
 
@@ -113,6 +137,7 @@
 	int block;
 	struct minix_sb_info *sbi = minix_sb(sb);
 	struct minix_inode *p;
+	int minix_inodes_per_block = BLOCK_SIZE / sizeof(struct minix_inode);
 
 	if (!ino || ino > sbi->s_ninodes) {
 		printk("Bad inode number on dev %s: %ld is out of range\n",
@@ -121,14 +146,14 @@
 	}
 	ino--;
 	block = 2 + sbi->s_imap_blocks + sbi->s_zmap_blocks +
-		 ino / MINIX_INODES_PER_BLOCK;
+		 ino / minix_inodes_per_block;
 	*bh = sb_bread(sb, block);
 	if (!*bh) {
 		printk("Unable to read inode block\n");
 		return NULL;
 	}
 	p = (void *)(*bh)->b_data;
-	return p + ino % MINIX_INODES_PER_BLOCK;
+	return p + ino % minix_inodes_per_block;
 }
 
 struct minix2_inode *
@@ -137,6 +162,7 @@
 	int block;
 	struct minix_sb_info *sbi = minix_sb(sb);
 	struct minix2_inode *p;
+	int minix2_inodes_per_block = sb->s_blocksize / sizeof(struct minix2_inode);
 
 	*bh = NULL;
 	if (!ino || ino > sbi->s_ninodes) {
@@ -146,14 +172,14 @@
 	}
 	ino--;
 	block = 2 + sbi->s_imap_blocks + sbi->s_zmap_blocks +
-		 ino / MINIX2_INODES_PER_BLOCK;
+		 ino / minix2_inodes_per_block;
 	*bh = sb_bread(sb, block);
 	if (!*bh) {
 		printk("Unable to read inode block\n");
 		return NULL;
 	}
 	p = (void *)(*bh)->b_data;
-	return p + ino % MINIX2_INODES_PER_BLOCK;
+	return p + ino % minix2_inodes_per_block;
 }
 
 /* Clear the link count and mode of a deleted inode on disk. */
@@ -187,24 +213,33 @@
 {
 	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
 	struct buffer_head * bh;
-	unsigned long ino;
+	int k = minix3_block_size_shift(inode->i_sb);
+	int mask = 15;
+	unsigned long ino, bit;
+	char *offset;
+	offset = NULL;
 
 	ino = inode->i_ino;
 	if (ino < 1 || ino > sbi->s_ninodes) {
 		printk("minix_free_inode: inode 0 or nonexistent inode\n");
 		goto out;
 	}
-	if ((ino >> 13) >= sbi->s_imap_blocks) {
+	bit = ino & 8191;
+	ino >>= 13;
+	mask >>= (4 - k);
+	if ((ino >> k) >= sbi->s_imap_blocks) {
 		printk("minix_free_inode: nonexistent imap in superblock\n");
 		goto out;
 	}
 
 	minix_clear_inode(inode);	/* clear on-disk copy */
 
-	bh = sbi->s_imap[ino >> 13];
+	bh = sbi->s_imap[ino >> k];
+	offset = (char *)bh->b_data;
+	offset += (ino & mask) * 1024;
 	lock_kernel();
-	if (!minix_test_and_clear_bit(ino & 8191, bh->b_data))
-		printk("minix_free_inode: bit %lu already cleared\n", ino);
+	if (!minix_test_and_clear_bit(bit, offset))
+		printk("minix_free_inode: bit %lu already cleared\n", bit);
 	unlock_kernel();
 	mark_buffer_dirty(bh);
  out:
@@ -217,7 +252,12 @@
 	struct minix_sb_info *sbi = minix_sb(sb);
 	struct inode *inode = new_inode(sb);
 	struct buffer_head * bh;
-	int i,j;
+	unsigned long j;
+	int num_1K_blocks = inode->i_sb->s_blocksize / 1024;
+	int bits_per_zone = 8 * sb->s_blocksize;
+	int i, k;
+	char *offset;
+	offset = NULL;
 
 	if (!inode) {
 		*error = -ENOMEM;
@@ -229,15 +269,21 @@
 	lock_kernel();
 	for (i = 0; i < sbi->s_imap_blocks; i++) {
 		bh = sbi->s_imap[i];
-		if ((j = minix_find_first_zero_bit(bh->b_data, 8192)) < 8192)
-			break;
+		for (k = 0; k < num_1K_blocks; k++) {
+			offset = (char *)bh->b_data;
+			offset += k * 1024;
+			if ((j = minix_find_first_zero_bit(offset, 8192))
+				< 8192)
+				goto break_both;
+		}
 	}
+break_both:
 	if (!bh || j >= 8192) {
 		unlock_kernel();
 		iput(inode);
 		return NULL;
 	}
-	if (minix_test_and_set_bit(j,bh->b_data)) {	/* shouldn't happen */
+	if (minix_test_and_set_bit(j, offset)) {	/* shouldn't happen */
 		printk("new_inode: bit already set\n");
 		unlock_kernel();
 		iput(inode);
@@ -245,7 +291,7 @@
 	}
 	unlock_kernel();
 	mark_buffer_dirty(bh);
-	j += i*8192;
+	j += i * bits_per_zone + k * 8192;
 	if (!j || j > sbi->s_ninodes) {
 		iput(inode);
 		return NULL;
diff -ur orig.Linux-2.6.17-rc3/fs/minix/dir.c updated.Linux-2.6.17-rc3/fs/minix/dir.c
--- orig.Linux-2.6.17-rc3/fs/minix/dir.c	2006-04-27 04:19:25.000000000 +0200
+++ updated.Linux-2.6.17-rc3/fs/minix/dir.c	2006-05-07 14:00:28.000000000 +0200
@@ -4,12 +4,15 @@
  *  Copyright (C) 1991, 1992 Linus Torvalds
  *
  *  minix directory handling functions
+ *
+ *  Updated to filesystem version 3 by Daniel Aragones
  */
 
 #include "minix.h"
 #include <linux/highmem.h>
 #include <linux/smp_lock.h>
 
+typedef struct minix3_dir_entry minix3_dirent;
 typedef struct minix_dir_entry minix_dirent;
 
 static int minix_readdir(struct file *, void *, filldir_t);
@@ -90,6 +93,8 @@
 	unsigned long npages = dir_pages(inode);
 	struct minix_sb_info *sbi = minix_sb(sb);
 	unsigned chunk_size = sbi->s_dirsize;
+	char *name;
+	__u32 inumber;
 
 	lock_kernel();
 
@@ -107,15 +112,23 @@
 		p = kaddr+offset;
 		limit = kaddr + minix_last_byte(inode, n) - chunk_size;
 		for ( ; p <= limit ; p = minix_next_entry(p, sbi)) {
+			minix3_dirent *de3 = (minix3_dirent *)p;
 			minix_dirent *de = (minix_dirent *)p;
-			if (de->inode) {
+			if (sbi->s_version == MINIX_V3) {
+				name = de3->name;
+				inumber = de3->inode;
+	 		} else {
+				name = de->name;
+				inumber = de->inode;
+			}
+			if (inumber) {
 				int over;
-				unsigned l = strnlen(de->name,sbi->s_namelen);
 
+				unsigned l = strnlen(name, sbi->s_namelen);
 				offset = p - kaddr;
-				over = filldir(dirent, de->name, l,
-						(n<<PAGE_CACHE_SHIFT) | offset,
-						de->inode, DT_UNKNOWN);
+				over = filldir(dirent, name, l,
+					(n << PAGE_CACHE_SHIFT) | offset,
+					inumber, DT_UNKNOWN);
 				if (over) {
 					dir_put_page(page);
 					goto done;
@@ -157,9 +170,12 @@
 	unsigned long n;
 	unsigned long npages = dir_pages(dir);
 	struct page *page = NULL;
+	struct minix3_dir_entry *de3;
 	struct minix_dir_entry *de;
 
 	*res_page = NULL;
+	char *namx;
+	__u32 inumber;
 
 	for (n = 0; n < npages; n++) {
 		char *kaddr;
@@ -168,12 +184,22 @@
 			continue;
 
 		kaddr = (char*)page_address(page);
+		de3 = (struct minix3_dir_entry *) kaddr;
 		de = (struct minix_dir_entry *) kaddr;
 		kaddr += minix_last_byte(dir, n) - sbi->s_dirsize;
-		for ( ; (char *) de <= kaddr ; de = minix_next_entry(de,sbi)) {
-			if (!de->inode)
+		for ( ; (char *)de <= kaddr;
+					de3 = minix_next_entry(de3, sbi),
+					de = minix_next_entry(de, sbi)) {
+			if (sbi->s_version == MINIX_V3) {
+				namx = de3->name;
+				inumber = de3->inode;
+ 			} else {
+				namx = de->name;
+				inumber = de->inode;
+			}
+			if (!inumber)
 				continue;
-			if (namecompare(namelen,sbi->s_namelen,name,de->name))
+			if (namecompare(namelen, sbi->s_namelen, name, namx))
 				goto found;
 		}
 		dir_put_page(page);
@@ -193,12 +219,15 @@
 	struct super_block * sb = dir->i_sb;
 	struct minix_sb_info * sbi = minix_sb(sb);
 	struct page *page = NULL;
-	struct minix_dir_entry * de;
+	struct minix3_dir_entry *de3;
+	struct minix_dir_entry *de;
 	unsigned long npages = dir_pages(dir);
 	unsigned long n;
 	char *kaddr;
 	unsigned from, to;
 	int err;
+	char *namx = NULL;
+	__u32 inumber;
 
 	/*
 	 * We take care of directory expansion in the same loop
@@ -215,19 +244,32 @@
 		lock_page(page);
 		kaddr = (char*)page_address(page);
 		dir_end = kaddr + minix_last_byte(dir, n);
+		de3 = (minix3_dirent *)kaddr;
 		de = (minix_dirent *)kaddr;
 		kaddr += PAGE_CACHE_SIZE - sbi->s_dirsize;
 		while ((char *)de <= kaddr) {
+			if (sbi->s_version == MINIX_V3) {
+				namx = de3->name;
+				inumber = de3->inode; 	
+		 	} else {
+  				namx = de->name;
+				inumber = de->inode;
+			}
 			if ((char *)de == dir_end) {
 				/* We hit i_size */
-				de->inode = 0;
+				if (sbi->s_version == MINIX_V3)
+					de3->inode = 0;
+		 		else
+					de->inode = 0;
+
 				goto got_it;
 			}
-			if (!de->inode)
+			if (!inumber)
 				goto got_it;
 			err = -EEXIST;
-			if (namecompare(namelen,sbi->s_namelen,name,de->name))
+			if (namecompare(namelen, sbi->s_namelen, name, namx))
 				goto out_unlock;
+			de3 = minix_next_entry(de3, sbi);
 			de = minix_next_entry(de, sbi);
 		}
 		unlock_page(page);
@@ -242,9 +284,14 @@
 	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
 	if (err)
 		goto out_unlock;
-	memcpy (de->name, name, namelen);
-	memset (de->name + namelen, 0, sbi->s_dirsize - namelen - 2);
-	de->inode = inode->i_ino;
+	memcpy (namx, name, namelen);
+	if (sbi->s_version == MINIX_V3) {
+		memset (namx + namelen, 0, sbi->s_dirsize - namelen - 4);
+		de3->inode = inode->i_ino;
+	} else {
+		memset (namx + namelen, 0, sbi->s_dirsize - namelen - 2);
+		de->inode = inode->i_ino;
+	}
 	err = dir_commit_chunk(page, from, to);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
@@ -284,8 +331,9 @@
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct page *page = grab_cache_page(mapping, 0);
-	struct minix_sb_info * sbi = minix_sb(inode->i_sb);
-	struct minix_dir_entry * de;
+	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
+	struct minix_dir_entry *de;
+	struct minix3_dir_entry *de3;
 	char *kaddr;
 	int err;
 
@@ -301,11 +349,21 @@
 	memset(kaddr, 0, PAGE_CACHE_SIZE);
 
 	de = (struct minix_dir_entry *)kaddr;
+	de3 = (struct minix3_dir_entry *)kaddr;
 	de->inode = inode->i_ino;
-	strcpy(de->name,".");
+	de3->inode = inode->i_ino;
+	if (sbi->s_version == MINIX_V3)
+		strcpy(de3->name, ".");
+	else
+		strcpy(de->name, ".");
 	de = minix_next_entry(de, sbi);
+	de3 = minix_next_entry(de3, sbi);
 	de->inode = dir->i_ino;
-	strcpy(de->name,"..");
+	de3->inode = dir->i_ino;
+	if (sbi->s_version == MINIX_V3)
+		strcpy(de3->name, "..");
+	else
+		strcpy(de->name, "..");
 	kunmap_atomic(kaddr, KM_USER0);
 
 	err = dir_commit_chunk(page, 0, 2 * sbi->s_dirsize);
@@ -322,30 +380,42 @@
 	struct page *page = NULL;
 	unsigned long i, npages = dir_pages(inode);
 	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
+	char *name;
+	__u32 inumber;
 
 	for (i = 0; i < npages; i++) {
 		char *kaddr;
-		minix_dirent * de;
+		minix3_dirent *de3 = NULL;
+		minix_dirent *de;
 		page = dir_get_page(inode, i);
 
 		if (IS_ERR(page))
 			continue;
 
 		kaddr = (char *)page_address(page);
+		if (sbi->s_version == MINIX_V3)
+			de3 = (minix3_dirent *)kaddr;
 		de = (minix_dirent *)kaddr;
 		kaddr += minix_last_byte(inode, i) - sbi->s_dirsize;
 
+		if (sbi->s_version == MINIX_V3) {
+			name = de3->name;
+			inumber = de3->inode;
+		} else {
+			name = de->name;
+			inumber = de->inode;
+		}
 		while ((char *)de <= kaddr) {
-			if (de->inode != 0) {
+			if (inumber != 0) {
 				/* check for . and .. */
-				if (de->name[0] != '.')
+				if (name[0] != '.')
 					goto not_empty;
-				if (!de->name[1]) {
-					if (de->inode != inode->i_ino)
+				if (!name[1]) {
+					if (inumber != inode->i_ino)
 						goto not_empty;
-				} else if (de->name[1] != '.')
+				} else if (name[1] != '.')
 					goto not_empty;
-				else if (de->name[2])
+				else if (name[2])
 					goto not_empty;
 			}
 			de = minix_next_entry(de, sbi);
diff -ur orig.Linux-2.6.17-rc3/fs/minix/inode.c updated.Linux-2.6.17-rc3/fs/minix/inode.c
--- orig.Linux-2.6.17-rc3/fs/minix/inode.c	2006-04-27 04:19:25.000000000 +0200
+++ updated.Linux-2.6.17-rc3/fs/minix/inode.c	2006-05-01 16:20:23.000000000 +0200
@@ -7,6 +7,7 @@
  *	Minix V2 fs support.
  *
  *  Modified for 680x0 by Andreas Schwab
+ *  Updated to filesystem version 3 by Daniel Aragones
  */
 
 #include <linux/module.h>
@@ -36,7 +37,8 @@
 	struct minix_sb_info *sbi = minix_sb(sb);
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		sbi->s_ms->s_state = sbi->s_mount_state;
+		if (sbi->s_version != MINIX_V3)	 /* s_state is now out from V3 sb */
+			sbi->s_ms->s_state = sbi->s_mount_state;
 		mark_buffer_dirty(sbi->s_sbh);
 	}
 	for (i = 0; i < sbi->s_imap_blocks; i++)
@@ -118,12 +120,17 @@
 		    !(sbi->s_mount_state & MINIX_VALID_FS))
 			return 0;
 		/* Mounting a rw partition read-only. */
-		ms->s_state = sbi->s_mount_state;
+		if (sbi->s_version != MINIX_V3)
+			ms->s_state = sbi->s_mount_state;
 		mark_buffer_dirty(sbi->s_sbh);
 	} else {
 	  	/* Mount a partition which is read-only, read-write. */
-		sbi->s_mount_state = ms->s_state;
-		ms->s_state &= ~MINIX_VALID_FS;
+		if (sbi->s_version != MINIX_V3) {
+			sbi->s_mount_state = ms->s_state;
+			ms->s_state &= ~MINIX_VALID_FS;
+		} else {
+			sbi->s_mount_state = MINIX_VALID_FS;
+		}
 		mark_buffer_dirty(sbi->s_sbh);
 
 		if (!(sbi->s_mount_state & MINIX_VALID_FS))
@@ -141,7 +148,8 @@
 	struct buffer_head *bh;
 	struct buffer_head **map;
 	struct minix_super_block *ms;
-	int i, block;
+	struct minix3_super_block *m3s = NULL;
+	unsigned long i, block;
 	struct inode *root_inode;
 	struct minix_sb_info *sbi;
 
@@ -198,7 +206,23 @@
 		sbi->s_dirsize = 32;
 		sbi->s_namelen = 30;
 		sbi->s_link_max = MINIX2_LINK_MAX;
-	} else
+	} else if ( *(__u16 *)(bh->b_data + 24) == MINIX3_SUPER_MAGIC) {
+		m3s = (struct minix3_super_block *) bh->b_data;
+		s->s_magic = m3s->s_magic;
+		sbi->s_imap_blocks = m3s->s_imap_blocks;
+		sbi->s_zmap_blocks = m3s->s_zmap_blocks;
+		sbi->s_firstdatazone = m3s->s_firstdatazone;
+		sbi->s_log_zone_size = m3s->s_log_zone_size;
+		sbi->s_max_size = m3s->s_max_size;
+		sbi->s_ninodes = m3s->s_ninodes;
+		sbi->s_nzones = m3s->s_zones;
+		sbi->s_dirsize = 64;
+		sbi->s_namelen = 60;
+		sbi->s_version = MINIX_V3;
+		sbi->s_link_max = MINIX2_LINK_MAX;
+		sbi->s_mount_state = MINIX_VALID_FS;
+		sb_set_blocksize(s, m3s->s_blocksize);
+	} else 
 		goto out_no_fs;
 
 	/*
@@ -241,7 +265,8 @@
 		s->s_root->d_op = &minix_dentry_operations;
 
 	if (!(s->s_flags & MS_RDONLY)) {
-		ms->s_state &= ~MINIX_VALID_FS;
+		if (sbi->s_version != MINIX_V3) /* s_state is now out from V3 sb */
+			ms->s_state &= ~MINIX_VALID_FS;
 		mark_buffer_dirty(bh);
 	}
 	if (!(sbi->s_mount_state & MINIX_VALID_FS))
@@ -278,8 +303,8 @@
 
 out_no_fs:
 	if (!silent)
-		printk("VFS: Can't find a Minix or Minix V2 filesystem "
-			"on device %s\n", s->s_id);
+		printk("VFS: Can't find a Minix filesystem V1 | V2 | V3 on device "
+		       "%s.\n", s->s_id);
     out_release:
 	brelse(bh);
 	goto out;
@@ -373,8 +398,8 @@
  */
 static void V1_minix_read_inode(struct inode * inode)
 {
-	struct buffer_head * bh;
-	struct minix_inode * raw_inode;
+	struct buffer_head *bh;
+	struct minix_inode *raw_inode;
 	struct minix_inode_info *minix_inode = minix_i(inode);
 	int i;
 
@@ -404,8 +429,8 @@
  */
 static void V2_minix_read_inode(struct inode * inode)
 {
-	struct buffer_head * bh;
-	struct minix2_inode * raw_inode;
+	struct buffer_head *bh;
+	struct minix2_inode *raw_inode;
 	struct minix_inode_info *minix_inode = minix_i(inode);
 	int i;
 
@@ -448,8 +473,8 @@
  */
 static struct buffer_head * V1_minix_update_inode(struct inode * inode)
 {
-	struct buffer_head * bh;
-	struct minix_inode * raw_inode;
+	struct buffer_head *bh;
+	struct minix_inode *raw_inode;
 	struct minix_inode_info *minix_inode = minix_i(inode);
 	int i;
 
@@ -475,8 +500,8 @@
  */
 static struct buffer_head * V2_minix_update_inode(struct inode * inode)
 {
-	struct buffer_head * bh;
-	struct minix2_inode * raw_inode;
+	struct buffer_head *bh;
+	struct minix2_inode *raw_inode;
 	struct minix_inode_info *minix_inode = minix_i(inode);
 	int i;
 
@@ -507,13 +532,13 @@
 		return V2_minix_update_inode(inode);
 }
 
-static int minix_write_inode(struct inode * inode, int wait)
+static int minix_write_inode(struct inode *inode, int wait)
 {
 	brelse(minix_update_inode(inode));
 	return 0;
 }
 
-int minix_sync_inode(struct inode * inode)
+int minix_sync_inode(struct inode *inode)
 {
 	int err = 0;
 	struct buffer_head *bh;
@@ -537,12 +562,14 @@
 
 int minix_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat)
 {
+	struct inode *dir = dentry->d_parent->d_inode;
+	struct super_block *sb = dir->i_sb;
 	generic_fillattr(dentry->d_inode, stat);
 	if (INODE_VERSION(dentry->d_inode) == MINIX_V1)
-		stat->blocks = (BLOCK_SIZE / 512) * V1_minix_blocks(stat->size);
+		stat->blocks = (BLOCK_SIZE / 512) * V1_minix_blocks(stat->size, dentry);
 	else
-		stat->blocks = (BLOCK_SIZE / 512) * V2_minix_blocks(stat->size);
-	stat->blksize = BLOCK_SIZE;
+		stat->blocks = (sb->s_blocksize / 512) * V2_minix_blocks(stat->size, dentry);
+	stat->blksize = sb->s_blocksize;
 	return 0;
 }
 
diff -ur orig.Linux-2.6.17-rc3/fs/minix/itree_common.c updated.Linux-2.6.17-rc3/fs/minix/itree_common.c
--- orig.Linux-2.6.17-rc3/fs/minix/itree_common.c	2006-04-27 04:19:25.000000000 +0200
+++ updated.Linux-2.6.17-rc3/fs/minix/itree_common.c	2006-05-07 14:23:18.000000000 +0200
@@ -23,7 +23,7 @@
 
 static inline block_t *block_end(struct buffer_head *bh)
 {
-	return (block_t *)((char*)bh->b_data + BLOCK_SIZE);
+	return (block_t *)((char*)bh->b_data + bh->b_size);
 }
 
 static inline Indirect *get_branch(struct inode *inode,
@@ -85,7 +85,7 @@
 		branch[n].key = cpu_to_block(nr);
 		bh = sb_getblk(inode->i_sb, parent);
 		lock_buffer(bh);
-		memset(bh->b_data, 0, BLOCK_SIZE);
+		memset(bh->b_data, 0, bh->b_size);
 		branch[n].bh = bh;
 		branch[n].p = (block_t*) bh->b_data + offsets[n];
 		*branch[n].p = branch[n].key;
@@ -268,7 +268,7 @@
 
 static void free_branches(struct inode *inode, block_t *p, block_t *q, int depth)
 {
-	struct buffer_head * bh;
+	struct buffer_head *bh;
 	unsigned long nr;
 
 	if (depth--) {
@@ -292,6 +292,7 @@
 
 static inline void truncate (struct inode * inode)
 {
+	struct super_block *sb = inode->i_sb;
 	block_t *idata = i_data(inode);
 	int offsets[DEPTH];
 	Indirect chain[DEPTH];
@@ -301,7 +302,7 @@
 	int first_whole;
 	long iblock;
 
-	iblock = (inode->i_size + BLOCK_SIZE-1) >> 10;
+	iblock = (inode->i_size + sb->s_blocksize -1) >> (ffs(sb->s_blocksize) - 1);
 	block_truncate_page(inode->i_mapping, inode->i_size, get_block);
 
 	n = block_to_path(inode, iblock, offsets);
@@ -346,15 +347,18 @@
 	mark_inode_dirty(inode);
 }
 
-static inline unsigned nblocks(loff_t size)
+static inline unsigned nblocks(loff_t size, struct dentry *dentry)
 {
+	struct inode *dir = dentry->d_parent->d_inode;
+	struct super_block *sb = dir->i_sb;
+	int k = minix3_block_size_shift(sb);
 	unsigned blocks, res, direct = DIRECT, i = DEPTH;
-	blocks = (size + BLOCK_SIZE - 1) >> BLOCK_SIZE_BITS;
+	blocks = (size + sb->s_blocksize - 1) >> (BLOCK_SIZE_BITS + k);
 	res = blocks;
 	while (--i && blocks > direct) {
 		blocks -= direct;
-		blocks += BLOCK_SIZE/sizeof(block_t) - 1;
-		blocks /= BLOCK_SIZE/sizeof(block_t);
+		blocks += sb->s_blocksize/sizeof(block_t) - 1;
+		blocks /= sb->s_blocksize/sizeof(block_t);
 		res += blocks;
 		direct = 1;
 	}
diff -ur orig.Linux-2.6.17-rc3/fs/minix/itree_v1.c updated.Linux-2.6.17-rc3/fs/minix/itree_v1.c
--- orig.Linux-2.6.17-rc3/fs/minix/itree_v1.c	2006-04-27 04:19:25.000000000 +0200
+++ updated.Linux-2.6.17-rc3/fs/minix/itree_v1.c	2006-05-01 16:24:36.000000000 +0200
@@ -50,12 +50,12 @@
 	return get_block(inode, block, bh_result, create);
 }
 
-void V1_minix_truncate(struct inode * inode)
+void V1_minix_truncate(struct inode *inode)
 {
 	truncate(inode);
 }
 
-unsigned V1_minix_blocks(loff_t size)
+unsigned V1_minix_blocks(loff_t size, struct dentry *dentry)
 {
-	return nblocks(size);
+	return nblocks(size, dentry);
 }
diff -ur orig.Linux-2.6.17-rc3/fs/minix/itree_v2.c updated.Linux-2.6.17-rc3/fs/minix/itree_v2.c
--- orig.Linux-2.6.17-rc3/fs/minix/itree_v2.c	2006-04-27 04:19:25.000000000 +0200
+++ updated.Linux-2.6.17-rc3/fs/minix/itree_v2.c	2006-05-01 16:25:48.000000000 +0200
@@ -23,10 +23,11 @@
 static int block_to_path(struct inode * inode, long block, int offsets[DEPTH])
 {
 	int n = 0;
+	struct super_block *sb = inode->i_sb;
 
 	if (block < 0) {
 		printk("minix_bmap: block<0\n");
-	} else if (block >= (minix_sb(inode->i_sb)->s_max_size/BLOCK_SIZE)) {
+	} else if (block >= (minix_sb(inode->i_sb)->s_max_size/sb->s_blocksize)) {
 		printk("minix_bmap: block>big\n");
 	} else if (block < 7) {
 		offsets[n++] = block;
@@ -49,18 +50,18 @@
 
 #include "itree_common.c"
 
-int V2_minix_get_block(struct inode * inode, long block,
+int V2_minix_get_block(struct inode *inode, long block,
 			struct buffer_head *bh_result, int create)
 {
 	return get_block(inode, block, bh_result, create);
 }
 
-void V2_minix_truncate(struct inode * inode)
+void V2_minix_truncate(struct inode *inode)
 {
 	truncate(inode);
 }
 
-unsigned V2_minix_blocks(loff_t size)
+unsigned V2_minix_blocks(loff_t size, struct dentry *dentry)
 {
-	return nblocks(size);
+	return nblocks(size, dentry);
 }
diff -ur orig.Linux-2.6.17-rc3/fs/minix/minix.h updated.Linux-2.6.17-rc3/fs/minix/minix.h
--- orig.Linux-2.6.17-rc3/fs/minix/minix.h	2006-04-27 04:19:25.000000000 +0200
+++ updated.Linux-2.6.17-rc3/fs/minix/minix.h	2006-05-01 16:32:55.000000000 +0200
@@ -7,11 +7,10 @@
  * truncated. Else they will be disallowed (ENAMETOOLONG).
  */
 #define NO_TRUNCATE 1
-
 #define INODE_VERSION(inode)	minix_sb(inode->i_sb)->s_version
-
 #define MINIX_V1		0x0001		/* original minix fs */
 #define MINIX_V2		0x0002		/* minix V2 fs */
+#define MINIX_V3		0x0003		/* minix V3 fs */
 
 /*
  * minix fs inode data in memory
@@ -51,13 +50,11 @@
 extern struct inode * minix_new_inode(const struct inode * dir, int * error);
 extern void minix_free_inode(struct inode * inode);
 extern unsigned long minix_count_free_inodes(struct minix_sb_info *sbi);
-extern int minix_new_block(struct inode * inode);
-extern void minix_free_block(struct inode * inode, int block);
+extern int minix_new_block(struct inode *inode);
+extern void minix_free_block(struct inode *inode, unsigned long block);
 extern unsigned long minix_count_free_blocks(struct minix_sb_info *sbi);
-
 extern int minix_getattr(struct vfsmount *, struct dentry *, struct kstat *);
 
-extern void V2_minix_truncate(struct inode *);
 extern void V1_minix_truncate(struct inode *);
 extern void V2_minix_truncate(struct inode *);
 extern void minix_truncate(struct inode *);
@@ -65,10 +62,10 @@
 extern void minix_set_inode(struct inode *, dev_t);
 extern int V1_minix_get_block(struct inode *, long, struct buffer_head *, int);
 extern int V2_minix_get_block(struct inode *, long, struct buffer_head *, int);
-extern unsigned V1_minix_blocks(loff_t);
-extern unsigned V2_minix_blocks(loff_t);
+extern unsigned V1_minix_blocks(loff_t, struct dentry *);
+extern unsigned V2_minix_blocks(loff_t, struct dentry *);
 
-extern struct minix_dir_entry *minix_find_entry(struct dentry*, struct page**);
+extern struct minix_dir_entry *minix_find_entry(struct dentry *, struct page **);
 extern int minix_add_link(struct dentry*, struct inode*);
 extern int minix_delete_entry(struct minix_dir_entry*, struct page*);
 extern int minix_make_empty(struct inode*, struct inode*);
@@ -76,8 +73,8 @@
 extern void minix_set_link(struct minix_dir_entry*, struct page*, struct inode*);
 extern struct minix_dir_entry *minix_dotdot(struct inode*, struct page**);
 extern ino_t minix_inode_by_name(struct dentry*);
-
 extern int minix_sync_file(struct file *, struct dentry *, int);
+extern int minix3_block_size_shift(struct super_block *sb);
 
 extern struct inode_operations minix_file_inode_operations;
 extern struct inode_operations minix_dir_inode_operations;
diff -ur orig.Linux-2.6.17-rc3/include/linux/minix_fs.h updated.Linux-2.6.17-rc3/include/linux/minix_fs.h
--- orig.Linux-2.6.17-rc3/include/linux/minix_fs.h	2006-04-27 04:19:25.000000000 +0200
+++ updated.Linux-2.6.17-rc3/include/linux/minix_fs.h	2006-05-01 13:32:23.000000000 +0200
@@ -23,11 +23,10 @@
 #define MINIX_SUPER_MAGIC2	0x138F		/* minix fs, 30 char names */
 #define MINIX2_SUPER_MAGIC	0x2468		/* minix V2 fs */
 #define MINIX2_SUPER_MAGIC2	0x2478		/* minix V2 fs, 30 char names */
+#define MINIX3_SUPER_MAGIC	0x4d5a		/* minix V3 fs */ 
 #define MINIX_VALID_FS		0x0001		/* Clean fs. */
 #define MINIX_ERROR_FS		0x0002		/* fs has errors. */
 
-#define MINIX_INODES_PER_BLOCK ((BLOCK_SIZE)/(sizeof (struct minix_inode)))
-#define MINIX2_INODES_PER_BLOCK ((BLOCK_SIZE)/(sizeof (struct minix2_inode)))
 
 /*
  * This is the original minix inode layout on disk.
@@ -77,9 +76,33 @@
 	__u32 s_zones;
 };
 
+/*
+ * V3 minix super-block data on disk
+ */
+struct minix3_super_block {
+	__u16 s_ninodes;
+	__u16 s_nzones;
+	__u16 s_pad0;
+	__u16 s_imap_blocks;
+	__u16 s_zmap_blocks;
+	__u16 s_firstdatazone;
+	__u16 s_log_zone_size;
+	__u16 s_pad1;
+	__u32 s_max_size;
+	__u32 s_zones;
+	__u16 s_magic;
+	__u16 s_pad2;
+	__u16 s_blocksize;
+	__u8  s_disk_version;
+};
+
 struct minix_dir_entry {
 	__u16 inode;
 	char name[0];
 };
 
+struct minix3_dir_entry {
+	__u32 inode;
+	char name[0];
+};
 #endif


--------------040403080606050205080907--
