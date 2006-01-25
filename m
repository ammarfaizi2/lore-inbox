Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWAYUwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWAYUwi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 15:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWAYUwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 15:52:37 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:10893 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750814AbWAYUwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 15:52:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type;
        b=euLzRBG5IE66oqRDk9+9/JHgg/yDT4CO+MdNaLPcDUu3PHvOa7E1pINouQLlTnbqrqZzEyaiWvmG6A3jw0egrrPX8wmCSWWrOWoHD1jOP7YalCKWCvgiSOoj+OuL41xu60hlGbYBsFkouBK496ivXJVUgjxZA3xBDPQqzrUY9jo=
Message-ID: <43D7E588.1030501@gmail.com>
Date: Wed, 25 Jan 2006 21:54:32 +0100
From: =?ISO-8859-1?Q?Daniel_Aragon=E9s?= <danarag@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: es-ar, es, en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tossati@cyclades.com>
CC: Andrew Morton <akpm@osdl.org>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org
Subject: [PATCH/RFC] minix filesystem update to V3 for 2.4 kernels
Content-Type: multipart/mixed;
 boundary="------------000300010009020002030709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000300010009020002030709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcelo,

This is a copy of my previous message wrongly sent to your old address. I am sorry.

After 2 revisions incorporating the suggestions made by Pekka, here I attach as a text file "v3_2dot4_diff.txt" my patch for minix-fs version 3 support.

I first posted it in comp.os.minix in January 11. I have no received feedback at all. Can we trust the saying "no news, good news"?...

I have sent the same patch for 2.6 kernels to Andrew today. The present one is a port or adaptation of the 2.6 one, which was the first that I started, to the 2.4 peculiarities.

The modifications I have made to the preexistent code have been four:

1.- The layout of the superblock variables is different in version V3. Suggested by Pekka, the structure minix3_super_block has been introduced.

2.- Disable writings to "s_state" because it has been droped out from the superblock, and its former address is now used by another parameter.

3.- Change the references to the constant "BLOCK_SIZE" to the variables "s_blocksize" or "b_size", so allowing for multiple block sizes.

4.- Introduce the new structure "minix3_dir_entry" to employ 60 characters long names in the new directory entries of 64 bytes.

Signed-off-by: Daniel Aragones <danarag@gmail.com>









--------------000300010009020002030709
Content-Type: text/plain;
 name="v3_2dot4_diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v3_2dot4_diff.txt"

diff -ur orig.linux-2.4.32/fs/minix/bitmap.c updated.linux-2.4.32/fs/minix/bitmap.c
--- orig.linux-2.4.32/fs/minix/bitmap.c	2002-02-25 20:38:09.000000000 +0100
+++ updated.linux-2.4.32/fs/minix/bitmap.c	2006-01-25 16:07:08.000000000 +0100
@@ -27,14 +27,14 @@
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
@@ -124,6 +124,7 @@
 	int block;
 	struct minix_sb_info *sbi = &sb->u.minix_sb;
 	struct minix_inode *p;
+	int minix_inodes_per_block = BLOCK_SIZE/sizeof(struct minix_inode);
 
 	if (!ino || ino > sbi->s_ninodes) {
 		printk("Bad inode number on dev %s: %ld is out of range\n",
@@ -132,14 +133,14 @@
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
@@ -148,6 +149,7 @@
 	int block;
 	struct minix_sb_info *sbi = &sb->u.minix_sb;
 	struct minix2_inode *p;
+	int minix2_inodes_per_block = sb->s_blocksize/sizeof(struct minix2_inode);
 
 	*bh = NULL;
 	if (!ino || ino > sbi->s_ninodes) {
@@ -157,14 +159,14 @@
 	}
 	ino--;
 	block = 2 + sbi->s_imap_blocks + sbi->s_zmap_blocks +
-		 ino / MINIX2_INODES_PER_BLOCK;
+		 ino / minix2_inodes_per_block;
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
diff -ur orig.linux-2.4.32/fs/minix/dir.c updated.linux-2.4.32/fs/minix/dir.c
--- orig.linux-2.4.32/fs/minix/dir.c	2002-02-25 20:38:09.000000000 +0100
+++ updated.linux-2.4.32/fs/minix/dir.c	2006-01-25 16:07:08.000000000 +0100
@@ -4,6 +4,9 @@
  *  Copyright (C) 1991, 1992 Linus Torvalds
  *
  *  minix directory handling functions
+ *
+ *  Updated to filesystem version 3 by Daniel Aragones
+ *
  */
 
 #include <linux/fs.h>
@@ -11,6 +14,7 @@
 #include <linux/pagemap.h>
 
 typedef struct minix_dir_entry minix_dirent;
+typedef struct minix3_dir_entry minix3_dirent;
 
 static int minix_readdir(struct file *, void *, filldir_t);
 
@@ -80,6 +84,8 @@
 	struct minix_sb_info *sbi = &sb->u.minix_sb;
 	unsigned chunk_size = sbi->s_dirsize;
 
+	char *namx;
+	__u32 inodx;
 	pos = (pos + chunk_size-1) & ~(chunk_size-1);
 	if (pos >= inode->i_size)
 		goto done;
@@ -95,14 +101,22 @@
 		limit = kaddr + PAGE_CACHE_SIZE - chunk_size;
 		for ( ; p <= limit ; p = minix_next_entry(p, sbi)) {
 			minix_dirent *de = (minix_dirent *)p;
-			if (de->inode) {
+			minix3_dirent *de3 = (minix3_dirent *)p;
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
@@ -145,8 +159,11 @@
 	unsigned long npages = dir_pages(dir);
 	struct page *page = NULL;
 	struct minix_dir_entry *de;
+	struct minix3_dir_entry *de3;
 
 	*res_page = NULL;
+	char *namx;
+	__u32 inodx;
 
 	for (n = 0; n < npages; n++) {
 		char *kaddr;
@@ -156,11 +173,21 @@
 
 		kaddr = (char*)page_address(page);
 		de = (struct minix_dir_entry *) kaddr;
+		de3 = (struct minix3_dir_entry *) kaddr;
 		kaddr += PAGE_CACHE_SIZE - sbi->s_dirsize;
-		for ( ; (char *) de <= kaddr ; de = minix_next_entry(de,sbi)) {
-			if (!de->inode)
+		for ( ; (char *) de <= kaddr ;
+					de = minix_next_entry(de,sbi),
+					de3 = minix_next_entry(de3,sbi)) {
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
@@ -181,11 +208,14 @@
 	struct minix_sb_info * sbi = &sb->u.minix_sb;
 	struct page *page = NULL;
 	struct minix_dir_entry * de;
+	struct minix3_dir_entry * de3;
 	unsigned long npages = dir_pages(dir);
 	unsigned long n;
 	char *kaddr;
 	unsigned from, to;
 	int err;
+	char *namx = NULL;
+	__u32 inodx;
 
 	/* We take care of directory expansion in the same loop */
 	for (n = 0; n <= npages; n++) {
@@ -195,13 +225,22 @@
 			goto out;
 		kaddr = (char*)page_address(page);
 		de = (minix_dirent *)kaddr;
+		de3 = (minix3_dirent *)kaddr;
 		kaddr += PAGE_CACHE_SIZE - sbi->s_dirsize;
 		while ((char *)de <= kaddr) {
-			if (!de->inode)
+			if (sbi->s_version == MINIX_V3) {
+				namx = de3->name;
+				inodx = de3->inode; 	
+		 	} else {
+  				namx = de->name;
+				inodx = de->inode;
+			}
+			if (!inodx)
 				goto got_it;
 			err = -EEXIST;
-			if (namecompare(namelen,sbi->s_namelen,name,de->name))
+			if (namecompare(namelen,sbi->s_namelen,name,namx))
 				goto out_page;
+			de3 = minix_next_entry(de3, sbi);
 			de = minix_next_entry(de, sbi);
 		}
 		dir_put_page(page);
@@ -216,9 +255,14 @@
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
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(dir);
@@ -258,6 +302,7 @@
 	struct page *page = grab_cache_page(mapping, 0);
 	struct minix_sb_info * sbi = &inode->i_sb->u.minix_sb;
 	struct minix_dir_entry * de;
+	struct minix3_dir_entry * de3;
 	char *base;
 	int err;
 
@@ -270,12 +315,22 @@
 	base = (char*)page_address(page);
 	memset(base, 0, PAGE_CACHE_SIZE);
 
-	de = (struct minix_dir_entry *) base;
+	de = (struct minix_dir_entry *)base;
+	de3 = (struct minix3_dir_entry *)base;
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
 
 	err = dir_commit_chunk(page, 0, 2 * sbi->s_dirsize);
 fail:
@@ -292,30 +347,42 @@
 	struct page *page = NULL;
 	unsigned long i, npages = dir_pages(inode);
 	struct minix_sb_info *sbi = &inode->i_sb->u.minix_sb;
+	char *namx;
+	__u32 inodx;
 
 	for (i = 0; i < npages; i++) {
 		char *kaddr;
 		minix_dirent * de;
+		minix3_dirent * de3 = NULL;
 		page = dir_get_page(inode, i);
 
 		if (IS_ERR(page))
 			continue;
 
 		kaddr = (char *)page_address(page);
+		if (sbi->s_version == MINIX_V3)
+			de3 = (minix3_dirent *)kaddr;
 		de = (minix_dirent *)kaddr;
 		kaddr += PAGE_CACHE_SIZE - sbi->s_dirsize;
 
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
diff -ur orig.linux-2.4.32/fs/minix/inode.c updated.linux-2.4.32/fs/minix/inode.c
--- orig.linux-2.4.32/fs/minix/inode.c	2003-11-28 19:26:21.000000000 +0100
+++ updated.linux-2.4.32/fs/minix/inode.c	2006-01-25 16:07:08.000000000 +0100
@@ -7,6 +7,7 @@
  *	Minix V2 fs support.
  *
  *  Modified for 680x0 by Andreas Schwab
+ *  Updated to filesystem version 3 by Daniel Aragones
  */
 
 #include <linux/module.h>
@@ -29,6 +30,7 @@
 {
 	lock_kernel();
 
+	truncate_inode_pages(&inode->i_data, 0);
 	inode->i_size = 0;
 	minix_truncate(inode);
 	minix_free_inode(inode);
@@ -45,13 +47,16 @@
 static void minix_write_super(struct super_block * sb)
 {
 	struct minix_super_block * ms;
+	struct minix_sb_info *sbi = &sb->u.minix_sb;
 
 	if (!(sb->s_flags & MS_RDONLY)) {
 		ms = sb->u.minix_sb.s_ms;
 
-		if (ms->s_state & MINIX_VALID_FS)
-			ms->s_state &= ~MINIX_VALID_FS;
-		minix_commit_super(sb);
+		if (sbi->s_version != MINIX_V3) { /* s_state is out from V3 sb */
+			if (ms->s_state & MINIX_VALID_FS)
+				ms->s_state &= ~MINIX_VALID_FS;
+			minix_commit_super(sb);
+		}
 	}
 	sb->s_dirt = 0;
 }
@@ -61,7 +66,8 @@
 {
 	int i;
 
-	if (!(sb->s_flags & MS_RDONLY)) {
+	struct minix_sb_info *sbi = &sb->u.minix_sb;
+	if (!(sb->s_flags & MS_RDONLY) && (sbi->s_version != MINIX_V3)) {
 		sb->u.minix_sb.s_ms->s_state = sb->u.minix_sb.s_mount_state;
 		mark_buffer_dirty(sb->u.minix_sb.s_sbh);
 	}
@@ -88,11 +94,12 @@
 static int minix_remount (struct super_block * sb, int * flags, char * data)
 {
 	struct minix_super_block * ms;
+	struct minix_sb_info *sbi = &sb->u.minix_sb;
 
 	ms = sb->u.minix_sb.s_ms;
 	if ((*flags & MS_RDONLY) == (sb->s_flags & MS_RDONLY))
 		return 0;
-	if (*flags & MS_RDONLY) {
+	if ((*flags & MS_RDONLY) && (sbi->s_version != MINIX_V3)){
 		if (ms->s_state & MINIX_VALID_FS ||
 		    !(sb->u.minix_sb.s_mount_state & MINIX_VALID_FS))
 			return 0;
@@ -102,20 +109,21 @@
 		sb->s_dirt = 1;
 		minix_commit_super(sb);
 	}
-	else {
+	else if (sbi->s_version != MINIX_V3){
 	  	/* Mount a partition which is read-only, read-write. */
 		sb->u.minix_sb.s_mount_state = ms->s_state;
 		ms->s_state &= ~MINIX_VALID_FS;
 		mark_buffer_dirty(sb->u.minix_sb.s_sbh);
 		sb->s_dirt = 1;
+		}
+
+		if (!(sb->u.minix_sb.s_mount_state & MINIX_VALID_FS) && (sbi->s_version != MINIX_V3))
+			printk ("MINIX-fs warning: remounting unchecked Minix filesystem V%i, "
+				"running fsck is recommended.\n", sbi->s_version);
+		else if ((sb->u.minix_sb.s_mount_state & MINIX_ERROR_FS) && (sbi->s_version != MINIX_V3))
+			printk ("MINIX-fs warning: remounting Minix filesystem V%i with errors, "
+				"running fsck is recommended.\n", sbi->s_version);
 
-		if (!(sb->u.minix_sb.s_mount_state & MINIX_VALID_FS))
-			printk ("MINIX-fs warning: remounting unchecked fs, "
-				"running fsck is recommended.\n");
-		else if ((sb->u.minix_sb.s_mount_state & MINIX_ERROR_FS))
-			printk ("MINIX-fs warning: remounting fs with errors, "
-				"running fsck is recommended.\n");
-	}
 	return 0;
 }
 
@@ -125,6 +133,7 @@
 	struct buffer_head *bh;
 	struct buffer_head **map;
 	struct minix_super_block *ms;
+	struct minix3_super_block *m3s = NULL;
 	int i, block;
 	kdev_t dev = s->s_dev;
 	struct inode *root_inode;
@@ -182,6 +191,20 @@
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
+		sbi->s_nzones = m3s->s_zones;
+		sbi->s_dirsize = 64;
+		sbi->s_namelen = 60;
+		sbi->s_version = MINIX_V3;
+		sbi->s_link_max = MINIX2_LINK_MAX;
+		sb_set_blocksize(s, m3s->s_blocksize);
 	} else
 		goto out_no_fs;
 
@@ -224,17 +247,17 @@
 	if (!NO_TRUNCATE)
 		s->s_root->d_op = &minix_dentry_operations;
 
-	if (!(s->s_flags & MS_RDONLY)) {
-		ms->s_state &= ~MINIX_VALID_FS;
+	if (!(s->s_flags & MS_RDONLY) && (sbi->s_version != MINIX_V3)) {
+		ms->s_state &= ~MINIX_VALID_FS; /* s_state is out from V3 sb */
 		mark_buffer_dirty(bh);
 		s->s_dirt = 1;
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
 	return s;
 
 out_iput:
@@ -263,7 +286,7 @@
 
 out_no_fs:
 	if (!silent)
-		printk("VFS: Can't find a Minix or Minix V2 filesystem on device "
+		printk("VFS: Can't find a Minix filesystem V1 | V2 | V3 on device "
 		       "%s.\n", kdevname(dev));
     out_release:
 	brelse(bh);
diff -ur orig.linux-2.4.32/fs/minix/itree_common.c updated.linux-2.4.32/fs/minix/itree_common.c
--- orig.linux-2.4.32/fs/minix/itree_common.c	2002-02-25 20:38:09.000000000 +0100
+++ updated.linux-2.4.32/fs/minix/itree_common.c	2006-01-25 16:07:08.000000000 +0100
@@ -21,7 +21,7 @@
 
 static inline block_t *block_end(struct buffer_head *bh)
 {
-	return (block_t *)((char*)bh->b_data + BLOCK_SIZE);
+	return (block_t *)((char*)bh->b_data + bh->b_size);
 }
 
 static inline Indirect *get_branch(struct inode *inode,
@@ -81,7 +81,7 @@
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
diff -ur orig.linux-2.4.32/include/linux/minix_fs.h updated.linux-2.4.32/include/linux/minix_fs.h
--- orig.linux-2.4.32/include/linux/minix_fs.h	2001-09-07 18:45:51.000000000 +0200
+++ updated.linux-2.4.32/include/linux/minix_fs.h	2006-01-25 16:07:08.000000000 +0100
@@ -23,14 +23,13 @@
 #define MINIX_SUPER_MAGIC2	0x138F		/* minix fs, 30 char names */
 #define MINIX2_SUPER_MAGIC	0x2468		/* minix V2 fs */
 #define MINIX2_SUPER_MAGIC2	0x2478		/* minix V2 fs, 30 char names */
+#define MINIX3_SUPER_MAGIC	0x4d5a		/* minix V3 fs */ 
 #define MINIX_VALID_FS		0x0001		/* Clean fs. */
 #define MINIX_ERROR_FS		0x0002		/* fs has errors. */
 
-#define MINIX_INODES_PER_BLOCK ((BLOCK_SIZE)/(sizeof (struct minix_inode)))
-#define MINIX2_INODES_PER_BLOCK ((BLOCK_SIZE)/(sizeof (struct minix2_inode)))
-
 #define MINIX_V1		0x0001		/* original minix fs */
 #define MINIX_V2		0x0002		/* minix V2 fs */
+#define MINIX_V3		0x0003		/* minix V3 fs */
 
 #define INODE_VERSION(inode)	inode->i_sb->u.minix_sb.s_version
 
@@ -82,11 +81,36 @@
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
+
 #ifdef __KERNEL__
 
 /*

--------------000300010009020002030709--
