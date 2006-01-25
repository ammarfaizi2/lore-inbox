Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWAYQ5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWAYQ5J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 11:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWAYQ5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 11:57:09 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:47664 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750955AbWAYQ5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 11:57:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type;
        b=MdGtJuS7C3refonWDxEhVdb+c8YQ56MC5eMiV3S8KO/lO+INxvH/yJkS/veei4QTl0+/8Bh68yIjAW3yiGTZ4rKmaVozGlnhFbzNIAlAB4gi7mCUp3q4m04WFcrq5hvmlO9zSb5t4uWbY89cl0a0zwMQDNThBkTf4J1OYoXeGQ8=
Message-ID: <43D7AE58.3070007@gmail.com>
Date: Wed, 25 Jan 2006 17:59:04 +0100
From: =?ISO-8859-1?Q?Daniel_Aragon=E9s?= <danarag@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: es-ar, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: [PATCH/RFC] minix filesystem update to V3 for 2.6 kernels
Content-Type: multipart/mixed;
 boundary="------------060205070804020207070907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060205070804020207070907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

After 2 revisions incorporating the suggestions made from Pekka, here I attach as a text file "v3_2dot6_diff.txt" my patch for minix-fs version 3 support.

I first posted it in comp.os.minix in January 11. I have no received feedback at all. Can we trust the saying "no news, good news"?...

The modifications I have made to the preexistent code have been four:

1.- The layout of the superblock variables is different in version V3. Suggested by Pekka, the structure minix3_super_block has been introduced.

2.- Disable writings to "s_state" because it has been droped out from the superblock, and its former address is now used by another parameter.

3.- Change the references to the constant "BLOCK_SIZE" to the variables "s_blocksize" or "b_size", so allowing for multiple block sizes.

4.- Introduce the new structure "minix3_dir_entry" to employ 60 characters long names in the new directory entries of 64 bytes.

Signed-off-by: Daniel Aragones <danarag@gmail.com>




--------------060205070804020207070907
Content-Type: text/plain;
 name="v3_2dot6_diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v3_2dot6_diff.txt"

diff -ur orig.linux-2.6.15.1/fs/minix/bitmap.c updated.linux-2.6.15.1/fs/minix/bitmap.c
--- orig.linux-2.6.15.1/fs/minix/bitmap.c	2006-01-15 07:16:02.000000000 +0100
+++ updated.linux-2.6.15.1/fs/minix/bitmap.c	2006-01-25 16:41:32.000000000 +0100
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
+	i = ((numbits-(numblocks-1)*bh->b_size*8)/16)*2;
 	for (j=0; j<i; j++) {
 		sum += nibblemap[bh->b_data[j] & 0xf]
 			+ nibblemap[(bh->b_data[j]>>4) & 0xf];
@@ -113,6 +113,7 @@
 	int block;
 	struct minix_sb_info *sbi = minix_sb(sb);
 	struct minix_inode *p;
+	int minix_inodes_per_block = BLOCK_SIZE/sizeof(struct minix_inode);
 
 	if (!ino || ino > sbi->s_ninodes) {
 		printk("Bad inode number on dev %s: %ld is out of range\n",
@@ -121,14 +122,14 @@
 	}
 	ino--;
 	block = 2 + sbi->s_imap_blocks + sbi->s_zmap_blocks +
-		 ino / MINIX_INODES_PER_BLOCK;
+		 ino / minix_inodes_per_block;
 	*bh = sb_bread(sb, block);
 	if (!*bh) {
 		printk("unable to read i-node block\n");
 		return NULL;
 	}
 	p = (void *)(*bh)->b_data;
-	return p + ino % MINIX_INODES_PER_BLOCK;
+	return p + ino % minix_inodes_per_block;
 }
 
 struct minix2_inode *
@@ -137,6 +138,7 @@
 	int block;
 	struct minix_sb_info *sbi = minix_sb(sb);
 	struct minix2_inode *p;
+	int minix2_inodes_per_block = sb->s_blocksize/sizeof(struct minix2_inode);
 
 	*bh = NULL;
 	if (!ino || ino > sbi->s_ninodes) {
@@ -145,15 +147,15 @@
 		return NULL;
 	}
 	ino--;
-	block = 2 + sbi->s_imap_blocks + sbi->s_zmap_blocks +
-		 ino / MINIX2_INODES_PER_BLOCK;
+	block = 2 + sbi->s_imap_blocks + sbi->s_zmap_blocks + 
+		ino / minix2_inodes_per_block;
 	*bh = sb_bread(sb, block);
 	if (!*bh) {
 		printk("unable to read i-node block\n");
 		return NULL;
 	}
 	p = (void *)(*bh)->b_data;
-	return p + ino % MINIX2_INODES_PER_BLOCK;
+	return p + ino % minix2_inodes_per_block;
 }
 
 /* Clear the link count and mode of a deleted inode on disk. */
diff -ur orig.linux-2.6.15.1/fs/minix/dir.c updated.linux-2.6.15.1/fs/minix/dir.c
--- orig.linux-2.6.15.1/fs/minix/dir.c	2006-01-15 07:16:02.000000000 +0100
+++ updated.linux-2.6.15.1/fs/minix/dir.c	2006-01-25 16:41:32.000000000 +0100
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
+	char *namx;
+	__u32 inodx;
 
 	lock_kernel();
 
@@ -107,15 +112,23 @@
 		p = kaddr+offset;
 		limit = kaddr + minix_last_byte(inode, n) - chunk_size;
 		for ( ; p <= limit ; p = minix_next_entry(p, sbi)) {
+			minix3_dirent *de3 = (minix3_dirent *)p;
 			minix_dirent *de = (minix_dirent *)p;
-			if (de->inode) {
+			if (sbi->s_version == MINIX_V3) {
+				namx = de3->name;
+				inodx = de3->inode;
+	 		} else {
+				namx = de->name;
+				inodx = de->inode;
+			}
+			if (inodx) {
 				int over;
-				unsigned l = strnlen(de->name,sbi->s_namelen);
 
+				unsigned l = strnlen(namx,sbi->s_namelen);
 				offset = p - kaddr;
-				over = filldir(dirent, de->name, l,
-						(n<<PAGE_CACHE_SHIFT) | offset,
-						de->inode, DT_UNKNOWN);
+				over = filldir(dirent, namx, l,
+					(n<<PAGE_CACHE_SHIFT) | offset,
+					inodx, DT_UNKNOWN);
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
+	__u32 inodx;
 
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
+		for ( ; (char *) de <= kaddr ;
+					de3 = minix_next_entry(de3,sbi),
+					de = minix_next_entry(de,sbi)) {
+			if (sbi->s_version == MINIX_V3) {
+				namx = de3->name;
+				inodx = de3->inode;
+ 			} else {
+				namx = de->name;
+				inodx = de->inode;
+			}
+			if (!inodx)
 				continue;
-			if (namecompare(namelen,sbi->s_namelen,name,de->name))
+			if (namecompare(namelen,sbi->s_namelen,name,namx))
 				goto found;
 		}
 		dir_put_page(page);
@@ -193,12 +219,15 @@
 	struct super_block * sb = dir->i_sb;
 	struct minix_sb_info * sbi = minix_sb(sb);
 	struct page *page = NULL;
+	struct minix3_dir_entry * de3;
 	struct minix_dir_entry * de;
 	unsigned long npages = dir_pages(dir);
 	unsigned long n;
 	char *kaddr;
 	unsigned from, to;
 	int err;
+	char *namx = NULL;
+	__u32 inodx;
 
 	/*
 	 * We take care of directory expansion in the same loop
@@ -215,19 +244,33 @@
 		lock_page(page);
 		kaddr = (char*)page_address(page);
 		dir_end = kaddr + minix_last_byte(dir, n);
+		de3 = (minix3_dirent *)kaddr;
 		de = (minix_dirent *)kaddr;
 		kaddr += PAGE_CACHE_SIZE - sbi->s_dirsize;
 		while ((char *)de <= kaddr) {
+			if (sbi->s_version == MINIX_V3) {
+				namx = de3->name;
+				inodx = de3->inode; 	
+		 	} else {
+  				namx = de->name;
+				inodx = de->inode;
+			}
 			if ((char *)de == dir_end) {
 				/* We hit i_size */
-				de->inode = 0;
+				if (sbi->s_version == MINIX_V3) {
+					de3->inode = 0;
+		 		} else {
+					de->inode = 0;
+				}
 				goto got_it;
 			}
-			if (!de->inode)
+			if (!inodx)
 				goto got_it;
 			err = -EEXIST;
-			if (namecompare(namelen,sbi->s_namelen,name,de->name))
+
+			if (namecompare(namelen,sbi->s_namelen,name,namx))
 				goto out_unlock;
+			de3 = minix_next_entry(de3, sbi);
 			de = minix_next_entry(de, sbi);
 		}
 		unlock_page(page);
@@ -242,9 +285,14 @@
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
@@ -286,6 +334,7 @@
 	struct page *page = grab_cache_page(mapping, 0);
 	struct minix_sb_info * sbi = minix_sb(inode->i_sb);
 	struct minix_dir_entry * de;
+	struct minix3_dir_entry * de3;
 	char *kaddr;
 	int err;
 
@@ -301,11 +350,21 @@
 	memset(kaddr, 0, PAGE_CACHE_SIZE);
 
 	de = (struct minix_dir_entry *)kaddr;
+	de3 = (struct minix3_dir_entry *)kaddr;
 	de->inode = inode->i_ino;
-	strcpy(de->name,".");
+	de3->inode = inode->i_ino;
+	if (sbi->s_version == MINIX_V3)
+		strcpy(de3->name,".");
+	else
+		strcpy(de->name,".");
 	de = minix_next_entry(de, sbi);
+	de3 = minix_next_entry(de3, sbi);
 	de->inode = dir->i_ino;
-	strcpy(de->name,"..");
+	de3->inode = dir->i_ino;
+	if (sbi->s_version == MINIX_V3)
+		strcpy(de3->name,"..");
+	else
+		strcpy(de->name,"..");
 	kunmap_atomic(kaddr, KM_USER0);
 
 	err = dir_commit_chunk(page, 0, 2 * sbi->s_dirsize);
@@ -322,9 +381,12 @@
 	struct page *page = NULL;
 	unsigned long i, npages = dir_pages(inode);
 	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
+	char *namx;
+	__u32 inodx;
 
 	for (i = 0; i < npages; i++) {
 		char *kaddr;
+		minix3_dirent * de3 = NULL;
 		minix_dirent * de;
 		page = dir_get_page(inode, i);
 
@@ -332,20 +394,29 @@
 			continue;
 
 		kaddr = (char *)page_address(page);
+		if (sbi->s_version == MINIX_V3)
+			de3 = (minix3_dirent *)kaddr;
 		de = (minix_dirent *)kaddr;
 		kaddr += minix_last_byte(inode, i) - sbi->s_dirsize;
 
+		if (sbi->s_version == MINIX_V3) {
+			namx = de3->name;
+			inodx = de3->inode;
+		} else {
+			namx = de->name;
+			inodx = de->inode;
+		}
 		while ((char *)de <= kaddr) {
-			if (de->inode != 0) {
+			if (inodx != 0) {
 				/* check for . and .. */
-				if (de->name[0] != '.')
+				if (namx[0] != '.')
 					goto not_empty;
-				if (!de->name[1]) {
-					if (de->inode != inode->i_ino)
+				if (!namx[1]) {
+					if (inodx != inode->i_ino)
 						goto not_empty;
-				} else if (de->name[1] != '.')
+				} else if (namx[1] != '.')
 					goto not_empty;
-				else if (de->name[2])
+				else if (namx[2])
 					goto not_empty;
 			}
 			de = minix_next_entry(de, sbi);
diff -ur orig.linux-2.6.15.1/fs/minix/inode.c updated.linux-2.6.15.1/fs/minix/inode.c
--- orig.linux-2.6.15.1/fs/minix/inode.c	2006-01-15 07:16:02.000000000 +0100
+++ updated.linux-2.6.15.1/fs/minix/inode.c	2006-01-25 16:41:32.000000000 +0100
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
@@ -117,21 +119,23 @@
 		    !(sbi->s_mount_state & MINIX_VALID_FS))
 			return 0;
 		/* Mounting a rw partition read-only. */
-		ms->s_state = sbi->s_mount_state;
+		if (sbi->s_version != MINIX_V3)
+			ms->s_state = sbi->s_mount_state;
 		mark_buffer_dirty(sbi->s_sbh);
 	} else {
 	  	/* Mount a partition which is read-only, read-write. */
 		sbi->s_mount_state = ms->s_state;
-		ms->s_state &= ~MINIX_VALID_FS;
+		if (sbi->s_version != MINIX_V3)
+			ms->s_state &= ~MINIX_VALID_FS;
 		mark_buffer_dirty(sbi->s_sbh);
 
-		if (!(sbi->s_mount_state & MINIX_VALID_FS))
-			printk ("MINIX-fs warning: remounting unchecked fs, "
-				"running fsck is recommended.\n");
-		else if ((sbi->s_mount_state & MINIX_ERROR_FS))
-			printk ("MINIX-fs warning: remounting fs with errors, "
-				"running fsck is recommended.\n");
-	}
+		if (!(sbi->s_mount_state & MINIX_VALID_FS) && (sbi->s_version != MINIX_V3))
+			printk ("MINIX-fs warning: remounting unchecked Minix filesystem V%i, "
+				"running fsck is recommended.\n", sbi->s_version);
+		else if ((sbi->s_mount_state & MINIX_ERROR_FS) && (sbi->s_version != MINIX_V3))
+			printk ("MINIX-fs warning: remounting Minix filesystem V%i with errors, "
+				"running fsck is recommended.\n", sbi->s_version);
+ 	}
 	return 0;
 }
 
@@ -140,6 +144,7 @@
 	struct buffer_head *bh;
 	struct buffer_head **map;
 	struct minix_super_block *ms;
+	struct minix3_super_block *m3s = NULL;
 	int i, block;
 	struct inode *root_inode;
 	struct minix_sb_info *sbi;
@@ -197,7 +202,21 @@
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
+		sbi->s_nzones = m3s->s_zones;
+		sbi->s_dirsize = 64;
+		sbi->s_namelen = 60;
+		sbi->s_version = MINIX_V3;
+		sbi->s_link_max = MINIX2_LINK_MAX;
+		sb_set_blocksize(s, m3s->s_blocksize);
+	} else 
 		goto out_no_fs;
 
 	/*
@@ -240,15 +259,16 @@
 		s->s_root->d_op = &minix_dentry_operations;
 
 	if (!(s->s_flags & MS_RDONLY)) {
-		ms->s_state &= ~MINIX_VALID_FS;
+		if(sbi->s_version != MINIX_V3) /* s_state is now out from V3 sb */
+			ms->s_state &= ~MINIX_VALID_FS;
 		mark_buffer_dirty(bh);
 	}
-	if (!(sbi->s_mount_state & MINIX_VALID_FS))
-		printk ("MINIX-fs: mounting unchecked file system, "
-			"running fsck is recommended.\n");
- 	else if (sbi->s_mount_state & MINIX_ERROR_FS)
-		printk ("MINIX-fs: mounting file system with errors, "
-			"running fsck is recommended.\n");
+	if (!(sbi->s_mount_state & MINIX_VALID_FS) && (sbi->s_version != MINIX_V3))
+		printk ("MINIX-fs: mounting unchecked Minix filesystem V%i, "
+			"running fsck is recommended.\n", sbi->s_version);
+ 	else if ((sbi->s_mount_state & MINIX_ERROR_FS) && (sbi->s_version != MINIX_V3))
+		printk ("MINIX-fs: mounting Minix filesystem V%i with errors, "
+			"running fsck is recommended.\n", sbi->s_version);
 	return 0;
 
 out_iput:
@@ -277,8 +297,8 @@
 
 out_no_fs:
 	if (!silent)
-		printk("VFS: Can't find a Minix or Minix V2 filesystem on device "
-		       "%s.\n", s->s_id);
+		printk("VFS: Can't find a Minix filesystem V1 | V2 | V3 on device "
+ 		       "%s.\n", s->s_id);
     out_release:
 	brelse(bh);
 	goto out;
@@ -536,12 +556,14 @@
 
 int minix_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat)
 {
+	struct inode * dir = dentry->d_parent->d_inode;
+	struct super_block * sb = dir->i_sb;
 	generic_fillattr(dentry->d_inode, stat);
 	if (INODE_VERSION(dentry->d_inode) == MINIX_V1)
 		stat->blocks = (BLOCK_SIZE / 512) * V1_minix_blocks(stat->size);
 	else
-		stat->blocks = (BLOCK_SIZE / 512) * V2_minix_blocks(stat->size);
-	stat->blksize = BLOCK_SIZE;
+		stat->blocks = (sb->s_blocksize / 512) * V2_minix_blocks(stat->size);
+	stat->blksize = sb->s_blocksize;
 	return 0;
 }
 
diff -ur orig.linux-2.6.15.1/fs/minix/itree_common.c updated.linux-2.6.15.1/fs/minix/itree_common.c
--- orig.linux-2.6.15.1/fs/minix/itree_common.c	2006-01-15 07:16:02.000000000 +0100
+++ updated.linux-2.6.15.1/fs/minix/itree_common.c	2006-01-25 16:41:32.000000000 +0100
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
@@ -292,6 +292,7 @@
 
 static inline void truncate (struct inode * inode)
 {
+	struct super_block * sb = inode->i_sb;
 	block_t *idata = i_data(inode);
 	int offsets[DEPTH];
 	Indirect chain[DEPTH];
@@ -301,7 +302,7 @@
 	int first_whole;
 	long iblock;
 
-	iblock = (inode->i_size + BLOCK_SIZE-1) >> 10;
+	iblock = (inode->i_size + sb->s_blocksize -1) >> 10;
 	block_truncate_page(inode->i_mapping, inode->i_size, get_block);
 
 	n = block_to_path(inode, iblock, offsets);
diff -ur orig.linux-2.6.15.1/fs/minix/minix.h updated.linux-2.6.15.1/fs/minix/minix.h
--- orig.linux-2.6.15.1/fs/minix/minix.h	2006-01-15 07:16:02.000000000 +0100
+++ updated.linux-2.6.15.1/fs/minix/minix.h	2006-01-25 16:41:32.000000000 +0100
@@ -12,6 +12,7 @@
 
 #define MINIX_V1		0x0001		/* original minix fs */
 #define MINIX_V2		0x0002		/* minix V2 fs */
+#define MINIX_V3		0x0003		/* minix V3 fs */
 
 /*
  * minix fs inode data in memory
diff -ur orig.linux-2.6.15.1/include/linux/minix_fs.h updated.linux-2.6.15.1/include/linux/minix_fs.h
--- orig.linux-2.6.15.1/include/linux/minix_fs.h	2006-01-15 07:16:02.000000000 +0100
+++ updated.linux-2.6.15.1/include/linux/minix_fs.h	2006-01-25 16:41:32.000000000 +0100
@@ -23,12 +23,10 @@
 #define MINIX_SUPER_MAGIC2	0x138F		/* minix fs, 30 char names */
 #define MINIX2_SUPER_MAGIC	0x2468		/* minix V2 fs */
 #define MINIX2_SUPER_MAGIC2	0x2478		/* minix V2 fs, 30 char names */
+#define MINIX3_SUPER_MAGIC	0x4d5a		/* minix V3 fs */ 
 #define MINIX_VALID_FS		0x0001		/* Clean fs. */
 #define MINIX_ERROR_FS		0x0002		/* fs has errors. */
 
-#define MINIX_INODES_PER_BLOCK ((BLOCK_SIZE)/(sizeof (struct minix_inode)))
-#define MINIX2_INODES_PER_BLOCK ((BLOCK_SIZE)/(sizeof (struct minix2_inode)))
-
 /*
  * This is the original minix inode layout on disk.
  * Note the 8-bit gid and atime and ctime.
@@ -77,9 +75,33 @@
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


--------------060205070804020207070907--
