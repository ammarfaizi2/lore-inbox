Return-Path: <linux-kernel-owner+w=401wt.eu-S1751402AbXAINvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbXAINvM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 08:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbXAINvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 08:51:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:9894 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbXAINvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 08:51:11 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=lWGT1Rrtjmm+fWDd9BrXj8P+YSql++45p8yOqBxibHJAvMvVmu8V56Lvqz0VwidOEkjjSzkAGWkE4OW6k2QQV0SXlSuqCiAY1gCF0PtAl2176Z0i1tMF0Jz1QDZkWQqfqdB7i1rZxtrsc0quPL4vp+VEtnRCpW8wSUgRfZhfRpk=
Message-ID: <45A39D95.90702@gmail.com>
Date: Tue, 09 Jan 2007 14:50:13 +0100
From: =?ISO-8859-1?Q?Daniel_Aragon=E9s?= <danarag@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: es-ar, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: minix-v3-support.patch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Jan 08, 2007 at 04:06:53PM -0800, Andrew Morton wrote:

>> Daniel, it'd be good if you could review and test these changes please.
>>
>> Also, a signed-off-by from yourself and from Andries, please...

Thanks a lot to Andries! The patch looks much more elegant now than before. And
it continues performing well, as before.

Signed-off-by: Daniel Aragones <danarag@gmail.com>

---

  fs/minix/bitmap.c        |   69 +++++++++------
  fs/minix/dir.c           |  162 +++++++++++++++++++++++++------------
  fs/minix/inode.c         |   49 ++++++++---
  fs/minix/itree_common.c  |   16 ++-
  fs/minix/itree_v1.c      |    4
  fs/minix/itree_v2.c      |    7 -
  fs/minix/minix.h         |   12 --
  include/linux/magic.h    |    1
  include/linux/minix_fs.h |   25 +++++
  9 files changed, 233 insertions(+), 112 deletions(-)

diff -puN fs/minix/bitmap.c~minix-v3-support fs/minix/bitmap.c
--- a/fs/minix/bitmap.c~minix-v3-support
+++ a/fs/minix/bitmap.c
@@ -26,14 +26,14 @@ static unsigned long count_free(struct b
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
+	i = ((numbits - (numblocks-1) * bh->b_size * 8) / 16) * 2;
  	for (j=0; j<i; j++) {
  		sum += nibblemap[bh->b_data[j] & 0xf]
  			+ nibblemap[(bh->b_data[j]>>4) & 0xf];
@@ -48,28 +48,29 @@ static unsigned long count_free(struct b
  	return(sum);
  }

-void minix_free_block(struct inode * inode, int block)
+void minix_free_block(struct inode *inode, unsigned long block)
  {
-	struct super_block * sb = inode->i_sb;
-	struct minix_sb_info * sbi = minix_sb(sb);
-	struct buffer_head * bh;
-	unsigned int bit,zone;
+	struct super_block *sb = inode->i_sb;
+	struct minix_sb_info *sbi = minix_sb(sb);
+	struct buffer_head *bh;
+	int k = sb->s_blocksize_bits + 3;
+	unsigned long bit, zone;

  	if (block < sbi->s_firstdatazone || block >= sbi->s_nzones) {
  		printk("Trying to free block not in datazone\n");
  		return;
  	}
  	zone = block - sbi->s_firstdatazone + 1;
-	bit = zone & 8191;
-	zone >>= 13;
+	bit = zone & ((1<<k) - 1);
+	zone >>= k;
  	if (zone >= sbi->s_zmap_blocks) {
  		printk("minix_free_block: nonexistent bitmap buffer\n");
  		return;
  	}
  	bh = sbi->s_zmap[zone];
  	lock_kernel();
-	if (!minix_test_and_clear_bit(bit,bh->b_data))
-		printk("free_block (%s:%d): bit already cleared\n",
+	if (!minix_test_and_clear_bit(bit, bh->b_data))
+		printk("minix_free_block (%s:%lu): bit already cleared\n",
  		       sb->s_id, block);
  	unlock_kernel();
  	mark_buffer_dirty(bh);
@@ -79,6 +80,7 @@ void minix_free_block(struct inode * ino
  int minix_new_block(struct inode * inode)
  {
  	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
+	int bits_per_zone = 8 * inode->i_sb->s_blocksize;
  	int i;

  	for (i = 0; i < sbi->s_zmap_blocks; i++) {
@@ -86,11 +88,12 @@ int minix_new_block(struct inode * inode
  		int j;

  		lock_kernel();
-		if ((j = minix_find_first_zero_bit(bh->b_data, 8192)) < 8192) {
-			minix_set_bit(j,bh->b_data);
+		j = minix_find_first_zero_bit(bh->b_data, bits_per_zone);
+		if (j < bits_per_zone) {
+			minix_set_bit(j, bh->b_data);
  			unlock_kernel();
  			mark_buffer_dirty(bh);
-			j += i*8192 + sbi->s_firstdatazone-1;
+			j += i * bits_per_zone + sbi->s_firstdatazone-1;
  			if (j < sbi->s_firstdatazone || j >= sbi->s_nzones)
  				break;
  			return j;
@@ -137,6 +140,7 @@ minix_V2_raw_inode(struct super_block *s
  	int block;
  	struct minix_sb_info *sbi = minix_sb(sb);
  	struct minix2_inode *p;
+	int minix2_inodes_per_block = sb->s_blocksize / sizeof(struct minix2_inode);

  	*bh = NULL;
  	if (!ino || ino > sbi->s_ninodes) {
@@ -146,14 +150,14 @@ minix_V2_raw_inode(struct super_block *s
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
@@ -185,26 +189,30 @@ static void minix_clear_inode(struct ino

  void minix_free_inode(struct inode * inode)
  {
+	struct super_block *sb = inode->i_sb;
  	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
-	struct buffer_head * bh;
-	unsigned long ino;
+	struct buffer_head *bh;
+	int k = sb->s_blocksize_bits + 3;
+	unsigned long ino, bit;

  	ino = inode->i_ino;
  	if (ino < 1 || ino > sbi->s_ninodes) {
  		printk("minix_free_inode: inode 0 or nonexistent inode\n");
  		goto out;
  	}
-	if ((ino >> 13) >= sbi->s_imap_blocks) {
+	bit = ino & ((1<<k) - 1);
+	ino >>= k;
+	if (ino >= sbi->s_imap_blocks) {
  		printk("minix_free_inode: nonexistent imap in superblock\n");
  		goto out;
  	}

  	minix_clear_inode(inode);	/* clear on-disk copy */

-	bh = sbi->s_imap[ino >> 13];
+	bh = sbi->s_imap[ino];
  	lock_kernel();
-	if (!minix_test_and_clear_bit(ino & 8191, bh->b_data))
-		printk("minix_free_inode: bit %lu already cleared\n", ino);
+	if (!minix_test_and_clear_bit(bit, bh->b_data))
+		printk("minix_free_inode: bit %lu already cleared\n", bit);
  	unlock_kernel();
  	mark_buffer_dirty(bh);
   out:
@@ -217,35 +225,38 @@ struct inode * minix_new_inode(const str
  	struct minix_sb_info *sbi = minix_sb(sb);
  	struct inode *inode = new_inode(sb);
  	struct buffer_head * bh;
-	int i,j;
+	int bits_per_zone = 8 * sb->s_blocksize;
+	unsigned long j;
+	int i;

  	if (!inode) {
  		*error = -ENOMEM;
  		return NULL;
  	}
-	j = 8192;
+	j = bits_per_zone;
  	bh = NULL;
  	*error = -ENOSPC;
  	lock_kernel();
  	for (i = 0; i < sbi->s_imap_blocks; i++) {
  		bh = sbi->s_imap[i];
-		if ((j = minix_find_first_zero_bit(bh->b_data, 8192)) < 8192)
+		j = minix_find_first_zero_bit(bh->b_data, bits_per_zone);
+		if (j < bits_per_zone)
  			break;
  	}
-	if (!bh || j >= 8192) {
+	if (!bh || j >= bits_per_zone) {
  		unlock_kernel();
  		iput(inode);
  		return NULL;
  	}
-	if (minix_test_and_set_bit(j,bh->b_data)) {	/* shouldn't happen */
-		printk("new_inode: bit already set\n");
+	if (minix_test_and_set_bit(j, bh->b_data)) {	/* shouldn't happen */
  		unlock_kernel();
+		printk("minix_new_inode: bit already set\n");
  		iput(inode);
  		return NULL;
  	}
  	unlock_kernel();
  	mark_buffer_dirty(bh);
-	j += i*8192;
+	j += i * bits_per_zone;
  	if (!j || j > sbi->s_ninodes) {
  		iput(inode);
  		return NULL;
diff -puN fs/minix/dir.c~minix-v3-support fs/minix/dir.c
--- a/fs/minix/dir.c~minix-v3-support
+++ a/fs/minix/dir.c
@@ -4,6 +4,8 @@
   *  Copyright (C) 1991, 1992 Linus Torvalds
   *
   *  minix directory handling functions
+ *
+ *  Updated to filesystem version 3 by Daniel Aragones
   */

  #include "minix.h"
@@ -11,6 +13,7 @@
  #include <linux/smp_lock.h>

  typedef struct minix_dir_entry minix_dirent;
+typedef struct minix3_dir_entry minix3_dirent;

  static int minix_readdir(struct file *, void *, filldir_t);

@@ -89,6 +92,8 @@ static int minix_readdir(struct file * f
  	unsigned long npages = dir_pages(inode);
  	struct minix_sb_info *sbi = minix_sb(sb);
  	unsigned chunk_size = sbi->s_dirsize;
+	char *name;
+	__u32 inumber;

  	lock_kernel();

@@ -105,16 +110,24 @@ static int minix_readdir(struct file * f
  		kaddr = (char *)page_address(page);
  		p = kaddr+offset;
  		limit = kaddr + minix_last_byte(inode, n) - chunk_size;
-		for ( ; p <= limit ; p = minix_next_entry(p, sbi)) {
-			minix_dirent *de = (minix_dirent *)p;
-			if (de->inode) {
+		for ( ; p <= limit; p = minix_next_entry(p, sbi)) {
+			if (sbi->s_version == MINIX_V3) {
+				minix3_dirent *de3 = (minix3_dirent *)p;
+				name = de3->name;
+				inumber = de3->inode;
+	 		} else {
+				minix_dirent *de = (minix_dirent *)p;
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
@@ -156,23 +169,34 @@ minix_dirent *minix_find_entry(struct de
  	unsigned long n;
  	unsigned long npages = dir_pages(dir);
  	struct page *page = NULL;
-	struct minix_dir_entry *de;
+	char *p;

+	char *namx;
+	__u32 inumber;
  	*res_page = NULL;

  	for (n = 0; n < npages; n++) {
-		char *kaddr;
+		char *kaddr, *limit;
+
  		page = dir_get_page(dir, n);
  		if (IS_ERR(page))
  			continue;

  		kaddr = (char*)page_address(page);
-		de = (struct minix_dir_entry *) kaddr;
-		kaddr += minix_last_byte(dir, n) - sbi->s_dirsize;
-		for ( ; (char *) de <= kaddr ; de = minix_next_entry(de,sbi)) {
-			if (!de->inode)
+		limit = kaddr + minix_last_byte(dir, n) - sbi->s_dirsize;
+		for (p = kaddr; p <= limit; p = minix_next_entry(p, sbi)) {
+			if (sbi->s_version == MINIX_V3) {
+				minix3_dirent *de3 = (minix3_dirent *)p;
+				namx = de3->name;
+				inumber = de3->inode;
+ 			} else {
+				minix_dirent *de = (minix_dirent *)p;
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
@@ -181,7 +205,7 @@ minix_dirent *minix_find_entry(struct de

  found:
  	*res_page = page;
-	return de;
+	return (minix_dirent *)p;
  }

  int minix_add_link(struct dentry *dentry, struct inode *inode)
@@ -192,12 +216,15 @@ int minix_add_link(struct dentry *dentry
  	struct super_block * sb = dir->i_sb;
  	struct minix_sb_info * sbi = minix_sb(sb);
  	struct page *page = NULL;
-	struct minix_dir_entry * de;
  	unsigned long npages = dir_pages(dir);
  	unsigned long n;
-	char *kaddr;
+	char *kaddr, *p;
+	minix_dirent *de;
+	minix3_dirent *de3;
  	unsigned from, to;
  	int err;
+	char *namx = NULL;
+	__u32 inumber;

  	/*
  	 * We take care of directory expansion in the same loop
@@ -205,7 +232,7 @@ int minix_add_link(struct dentry *dentry
  	 * to protect that region.
  	 */
  	for (n = 0; n <= npages; n++) {
-		char *dir_end;
+		char *limit, *dir_end;

  		page = dir_get_page(dir, n);
  		err = PTR_ERR(page);
@@ -214,20 +241,30 @@ int minix_add_link(struct dentry *dentry
  		lock_page(page);
  		kaddr = (char*)page_address(page);
  		dir_end = kaddr + minix_last_byte(dir, n);
-		de = (minix_dirent *)kaddr;
-		kaddr += PAGE_CACHE_SIZE - sbi->s_dirsize;
-		while ((char *)de <= kaddr) {
-			if ((char *)de == dir_end) {
+		limit = kaddr + PAGE_CACHE_SIZE - sbi->s_dirsize;
+		for (p = kaddr; p <= limit; p = minix_next_entry(p, sbi)) {
+			de = (minix_dirent *)p;
+			de3 = (minix3_dirent *)p;
+			if (sbi->s_version == MINIX_V3) {
+				namx = de3->name;
+				inumber = de3->inode;
+		 	} else {
+  				namx = de->name;
+				inumber = de->inode;
+			}
+			if (p == dir_end) {
  				/* We hit i_size */
-				de->inode = 0;
+				if (sbi->s_version == MINIX_V3)
+					de3->inode = 0;
+		 		else
+					de->inode = 0;
  				goto got_it;
  			}
-			if (!de->inode)
+			if (!inumber)
  				goto got_it;
  			err = -EEXIST;
-			if (namecompare(namelen,sbi->s_namelen,name,de->name))
+			if (namecompare(namelen, sbi->s_namelen, name, namx))
  				goto out_unlock;
-			de = minix_next_entry(de, sbi);
  		}
  		unlock_page(page);
  		dir_put_page(page);
@@ -236,14 +273,19 @@ int minix_add_link(struct dentry *dentry
  	return -EINVAL;

  got_it:
-	from = (char*)de - (char*)page_address(page);
+	from = p - (char*)page_address(page);
  	to = from + sbi->s_dirsize;
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
@@ -283,8 +325,7 @@ int minix_make_empty(struct inode *inode
  {
  	struct address_space *mapping = inode->i_mapping;
  	struct page *page = grab_cache_page(mapping, 0);
-	struct minix_sb_info * sbi = minix_sb(inode->i_sb);
-	struct minix_dir_entry * de;
+	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
  	char *kaddr;
  	int err;

@@ -299,12 +340,23 @@ int minix_make_empty(struct inode *inode
  	kaddr = kmap_atomic(page, KM_USER0);
  	memset(kaddr, 0, PAGE_CACHE_SIZE);

-	de = (struct minix_dir_entry *)kaddr;
-	de->inode = inode->i_ino;
-	strcpy(de->name,".");
-	de = minix_next_entry(de, sbi);
-	de->inode = dir->i_ino;
-	strcpy(de->name,"..");
+	if (sbi->s_version == MINIX_V3) {
+		minix3_dirent *de3 = (minix3_dirent *)kaddr;
+
+		de3->inode = inode->i_ino;
+		strcpy(de3->name, ".");
+		de3 = minix_next_entry(de3, sbi);
+		de3->inode = dir->i_ino;
+		strcpy(de3->name, "..");
+	} else {
+		minix_dirent *de = (minix_dirent *)kaddr;
+
+		de->inode = inode->i_ino;
+		strcpy(de->name, ".");
+		de = minix_next_entry(de, sbi);
+		de->inode = dir->i_ino;
+		strcpy(de->name, "..");
+	}
  	kunmap_atomic(kaddr, KM_USER0);

  	err = dir_commit_chunk(page, 0, 2 * sbi->s_dirsize);
@@ -321,33 +373,41 @@ int minix_empty_dir(struct inode * inode
  	struct page *page = NULL;
  	unsigned long i, npages = dir_pages(inode);
  	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
+	char *name;
+	__u32 inumber;

  	for (i = 0; i < npages; i++) {
-		char *kaddr;
-		minix_dirent * de;
-		page = dir_get_page(inode, i);
+		char *p, *kaddr, *limit;

+		page = dir_get_page(inode, i);
  		if (IS_ERR(page))
  			continue;

  		kaddr = (char *)page_address(page);
-		de = (minix_dirent *)kaddr;
-		kaddr += minix_last_byte(inode, i) - sbi->s_dirsize;
+		limit = kaddr + minix_last_byte(inode, i) - sbi->s_dirsize;
+		for (p = kaddr; p <= limit; p = minix_next_entry(p, sbi)) {
+			if (sbi->s_version == MINIX_V3) {
+				minix3_dirent *de3 = (minix3_dirent *)p;
+				name = de3->name;
+				inumber = de3->inode;
+			} else {
+				minix_dirent *de = (minix_dirent *)p;
+				name = de->name;
+				inumber = de->inode;
+			}

-		while ((char *)de <= kaddr) {
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
-			de = minix_next_entry(de, sbi);
  		}
  		dir_put_page(page);
  	}
diff -puN fs/minix/inode.c~minix-v3-support fs/minix/inode.c
--- a/fs/minix/inode.c~minix-v3-support
+++ a/fs/minix/inode.c
@@ -7,6 +7,7 @@
   *	Minix V2 fs support.
   *
   *  Modified for 680x0 by Andreas Schwab
+ *  Updated to filesystem version 3 by Daniel Aragones
   */

  #include <linux/module.h>
@@ -36,7 +37,8 @@ static void minix_put_super(struct super
  	struct minix_sb_info *sbi = minix_sb(sb);

  	if (!(sb->s_flags & MS_RDONLY)) {
-		sbi->s_ms->s_state = sbi->s_mount_state;
+		if (sbi->s_version != MINIX_V3)	 /* s_state is now out from V3 sb */
+			sbi->s_ms->s_state = sbi->s_mount_state;
  		mark_buffer_dirty(sbi->s_sbh);
  	}
  	for (i = 0; i < sbi->s_imap_blocks; i++)
@@ -117,12 +119,17 @@ static int minix_remount (struct super_b
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
@@ -140,7 +147,8 @@ static int minix_fill_super(struct super
  	struct buffer_head *bh;
  	struct buffer_head **map;
  	struct minix_super_block *ms;
-	int i, block;
+	struct minix3_super_block *m3s = NULL;
+	unsigned long i, block;
  	struct inode *root_inode;
  	struct minix_sb_info *sbi;

@@ -192,6 +200,22 @@ static int minix_fill_super(struct super
  		sbi->s_dirsize = 32;
  		sbi->s_namelen = 30;
  		sbi->s_link_max = MINIX2_LINK_MAX;
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
  	} else
  		goto out_no_fs;

@@ -236,7 +260,8 @@ static int minix_fill_super(struct super
  		s->s_root->d_op = &minix_dentry_operations;

  	if (!(s->s_flags & MS_RDONLY)) {
-		ms->s_state &= ~MINIX_VALID_FS;
+		if (sbi->s_version != MINIX_V3) /* s_state is now out from V3 sb */
+			ms->s_state &= ~MINIX_VALID_FS;
  		mark_buffer_dirty(bh);
  	}
  	if (!(sbi->s_mount_state & MINIX_VALID_FS))
@@ -278,8 +303,8 @@ out_illegal_sb:

  out_no_fs:
  	if (!silent)
-		printk("VFS: Can't find a Minix or Minix V2 filesystem "
-			"on device %s\n", s->s_id);
+		printk("VFS: Can't find a Minix filesystem V1 | V2 | V3 "
+		       "on device %s.\n", s->s_id);
  out_release:
  	brelse(bh);
  	goto out;
@@ -536,12 +561,14 @@ int minix_sync_inode(struct inode * inod

  int minix_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat)
  {
+	struct inode *dir = dentry->d_parent->d_inode;
+	struct super_block *sb = dir->i_sb;
  	generic_fillattr(dentry->d_inode, stat);
  	if (INODE_VERSION(dentry->d_inode) == MINIX_V1)
-		stat->blocks = (BLOCK_SIZE / 512) * V1_minix_blocks(stat->size);
+		stat->blocks = (BLOCK_SIZE / 512) * V1_minix_blocks(stat->size, sb);
  	else
-		stat->blocks = (BLOCK_SIZE / 512) * V2_minix_blocks(stat->size);
-	stat->blksize = BLOCK_SIZE;
+		stat->blocks = (sb->s_blocksize / 512) * V2_minix_blocks(stat->size, sb);
+	stat->blksize = sb->s_blocksize;
  	return 0;
  }

diff -puN fs/minix/itree_common.c~minix-v3-support fs/minix/itree_common.c
--- a/fs/minix/itree_common.c~minix-v3-support
+++ a/fs/minix/itree_common.c
@@ -23,7 +23,7 @@ static inline int verify_chain(Indirect

  static inline block_t *block_end(struct buffer_head *bh)
  {
-	return (block_t *)((char*)bh->b_data + BLOCK_SIZE);
+	return (block_t *)((char*)bh->b_data + bh->b_size);
  }

  static inline Indirect *get_branch(struct inode *inode,
@@ -85,7 +85,7 @@ static int alloc_branch(struct inode *in
  		branch[n].key = cpu_to_block(nr);
  		bh = sb_getblk(inode->i_sb, parent);
  		lock_buffer(bh);
-		memset(bh->b_data, 0, BLOCK_SIZE);
+		memset(bh->b_data, 0, bh->b_size);
  		branch[n].bh = bh;
  		branch[n].p = (block_t*) bh->b_data + offsets[n];
  		*branch[n].p = branch[n].key;
@@ -292,6 +292,7 @@ static void free_branches(struct inode *

  static inline void truncate (struct inode * inode)
  {
+	struct super_block *sb = inode->i_sb;
  	block_t *idata = i_data(inode);
  	int offsets[DEPTH];
  	Indirect chain[DEPTH];
@@ -301,7 +302,7 @@ static inline void truncate (struct inod
  	int first_whole;
  	long iblock;

-	iblock = (inode->i_size + BLOCK_SIZE-1) >> 10;
+	iblock = (inode->i_size + sb->s_blocksize -1) >> sb->s_blocksize_bits;
  	block_truncate_page(inode->i_mapping, inode->i_size, get_block);

  	n = block_to_path(inode, iblock, offsets);
@@ -346,15 +347,16 @@ do_indirects:
  	mark_inode_dirty(inode);
  }

-static inline unsigned nblocks(loff_t size)
+static inline unsigned nblocks(loff_t size, struct super_block *sb)
  {
+	int k = sb->s_blocksize_bits - 10;
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
diff -puN fs/minix/itree_v1.c~minix-v3-support fs/minix/itree_v1.c
--- a/fs/minix/itree_v1.c~minix-v3-support
+++ a/fs/minix/itree_v1.c
@@ -55,7 +55,7 @@ void V1_minix_truncate(struct inode * in
  	truncate(inode);
  }

-unsigned V1_minix_blocks(loff_t size)
+unsigned V1_minix_blocks(loff_t size, struct super_block *sb)
  {
-	return nblocks(size);
+	return nblocks(size, sb);
  }
diff -puN fs/minix/itree_v2.c~minix-v3-support fs/minix/itree_v2.c
--- a/fs/minix/itree_v2.c~minix-v3-support
+++ a/fs/minix/itree_v2.c
@@ -23,10 +23,11 @@ static inline block_t *i_data(struct ino
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
@@ -60,7 +61,7 @@ void V2_minix_truncate(struct inode * in
  	truncate(inode);
  }

-unsigned V2_minix_blocks(loff_t size)
+unsigned V2_minix_blocks(loff_t size, struct super_block *sb)
  {
-	return nblocks(size);
+	return nblocks(size, sb);
  }
diff -puN fs/minix/minix.h~minix-v3-support fs/minix/minix.h
--- a/fs/minix/minix.h~minix-v3-support
+++ a/fs/minix/minix.h
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
@@ -52,12 +51,10 @@ extern struct inode * minix_new_inode(co
  extern void minix_free_inode(struct inode * inode);
  extern unsigned long minix_count_free_inodes(struct minix_sb_info *sbi);
  extern int minix_new_block(struct inode * inode);
-extern void minix_free_block(struct inode * inode, int block);
+extern void minix_free_block(struct inode *inode, unsigned long block);
  extern unsigned long minix_count_free_blocks(struct minix_sb_info *sbi);
-
  extern int minix_getattr(struct vfsmount *, struct dentry *, struct kstat *);

-extern void V2_minix_truncate(struct inode *);
  extern void V1_minix_truncate(struct inode *);
  extern void V2_minix_truncate(struct inode *);
  extern void minix_truncate(struct inode *);
@@ -65,8 +62,8 @@ extern int minix_sync_inode(struct inode
  extern void minix_set_inode(struct inode *, dev_t);
  extern int V1_minix_get_block(struct inode *, long, struct buffer_head *, int);
  extern int V2_minix_get_block(struct inode *, long, struct buffer_head *, int);
-extern unsigned V1_minix_blocks(loff_t);
-extern unsigned V2_minix_blocks(loff_t);
+extern unsigned V1_minix_blocks(loff_t, struct super_block *);
+extern unsigned V2_minix_blocks(loff_t, struct super_block *);

  extern struct minix_dir_entry *minix_find_entry(struct dentry*, struct page**);
  extern int minix_add_link(struct dentry*, struct inode*);
@@ -76,7 +73,6 @@ extern int minix_empty_dir(struct inode*
  extern void minix_set_link(struct minix_dir_entry*, struct page*, struct inode*);
  extern struct minix_dir_entry *minix_dotdot(struct inode*, struct page**);
  extern ino_t minix_inode_by_name(struct dentry*);
-
  extern int minix_sync_file(struct file *, struct dentry *, int);

  extern struct inode_operations minix_file_inode_operations;
diff -puN include/linux/magic.h~minix-v3-support include/linux/magic.h
--- a/include/linux/magic.h~minix-v3-support
+++ a/include/linux/magic.h
@@ -18,6 +18,7 @@
  #define MINIX_SUPER_MAGIC2	0x138F		/* minix fs, 30 char names */
  #define MINIX2_SUPER_MAGIC	0x2468		/* minix V2 fs */
  #define MINIX2_SUPER_MAGIC2	0x2478		/* minix V2 fs, 30 char names */
+#define MINIX3_SUPER_MAGIC	0x4d5a		/* minix V3 fs */

  #define MSDOS_SUPER_MAGIC	0x4d44		/* MD */
  #define NCP_SUPER_MAGIC		0x564c		/* Guess, what 0x564c is  :-)  */
diff -puN include/linux/minix_fs.h~minix-v3-support include/linux/minix_fs.h
--- a/include/linux/minix_fs.h~minix-v3-support
+++ a/include/linux/minix_fs.h
@@ -25,7 +25,6 @@
  #define MINIX_ERROR_FS		0x0002		/* fs has errors. */

  #define MINIX_INODES_PER_BLOCK ((BLOCK_SIZE)/(sizeof (struct minix_inode)))
-#define MINIX2_INODES_PER_BLOCK ((BLOCK_SIZE)/(sizeof (struct minix2_inode)))

  /*
   * This is the original minix inode layout on disk.
@@ -75,9 +74,33 @@ struct minix_super_block {
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

---

minix-v3-support.patch





