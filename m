Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWAVSih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWAVSih (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 13:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWAVSih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 13:38:37 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:56185 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751062AbWAVSig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 13:38:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type;
        b=MWNeCLRO7ISAVEM6g9MEN8Dn8rlPTPLm/KOHdrjVOfFP6CIIu7JohKhXqOci5s2FKNqp7WafSV7iQUXeOYthjOMQ4NeWfYKLZrdebkwzq9Pe4Vqt4uKKgUR5+Sd1YYUTAQ2oxEqLAoK4iuq+V9t000ZA8i4zFnx15A7MasElEsI=
Message-ID: <43D3D03C.6030504@gmail.com>
Date: Sun, 22 Jan 2006 19:34:36 +0100
From: =?ISO-8859-1?Q?Daniel_Aragon=E9s?= <danarag@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: es-ar, es, en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: [PATCH/RFC] minix filesystem: Corrected patch
Content-Type: multipart/mixed;
 boundary="------------030400020506010501080204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030400020506010501080204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Answering to the suggestion of Randy, here come the patches already corrected.

This patches concern the update for Minix V3 support for both kernels 2.6.x.y and 2.4.x.

Attached as text files  "V3_2dot6_patch.txt" and "V3_2dot4_patch.txt" are the corrected versions of my first post dated January 19. As I wrote there...

The modifications I have made to the preexistent code have been four:

1.- The layout of the superblock variables is different in version V3.

2.- Disable writings to "s_state" because it has been droped out from the superblock, and its former address is now used by another parameter.

3.- Change the references to the constant "BLOCK_SIZE" to the variables "s_blocksize" or "b_size", so allowing for multiple size blocks.

4.- Introduce the new structure "minix3_dir_entry" to cope with the 4 byte pointers employed in the new directory entries of 64 bytes.


--------------030400020506010501080204
Content-Type: text/plain;
 name="V3_2dot6_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="V3_2dot6_patch.txt"

diff -ur orig.linux-2.6.14.5/fs/minix/bitmap.c updated.linux-2.6.14.5/fs/minix/bitmap.c
--- orig.linux-2.6.14.5/fs/minix/bitmap.c	2005-12-27 01:26:33.000000000 +0100
+++ updated.linux-2.6.14.5/fs/minix/bitmap.c	2006-01-11 19:41:41.000000000 +0100
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
@@ -145,15 +145,15 @@
 		return NULL;
 	}
 	ino--;
-	block = 2 + sbi->s_imap_blocks + sbi->s_zmap_blocks +
-		 ino / MINIX2_INODES_PER_BLOCK;
+	block = 2 + sbi->s_imap_blocks + sbi->s_zmap_blocks + 
+		ino / MINIX2_INODES_PER_BLOCK(sb->s_blocksize);
 	*bh = sb_bread(sb, block);
 	if (!*bh) {
 		printk("unable to read i-node block\n");
 		return NULL;
 	}
 	p = (void *)(*bh)->b_data;
-	return p + ino % MINIX2_INODES_PER_BLOCK;
+	return p + ino % MINIX2_INODES_PER_BLOCK(sb->s_blocksize);
 }
 
 /* Clear the link count and mode of a deleted inode on disk. */
diff -ur orig.linux-2.6.14.5/fs/minix/dir.c updated.linux-2.6.14.5/fs/minix/dir.c
--- orig.linux-2.6.14.5/fs/minix/dir.c	2005-12-27 01:26:33.000000000 +0100
+++ updated.linux-2.6.14.5/fs/minix/dir.c	2006-01-11 19:41:41.000000000 +0100
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
 
@@ -108,14 +111,22 @@
 		limit = kaddr + minix_last_byte(inode, n) - chunk_size;
 		for ( ; p <= limit ; p = minix_next_entry(p, sbi)) {
 			minix_dirent *de = (minix_dirent *)p;
+			minix3_dirent *de3 = (minix3_dirent *)p;
 			if (de->inode) {
 				int over;
-				unsigned l = strnlen(de->name,sbi->s_namelen);
-
-				offset = p - kaddr;
-				over = filldir(dirent, de->name, l,
-						(n<<PAGE_CACHE_SHIFT) | offset,
-						de->inode, DT_UNKNOWN);
+				if (!(sbi->s_version == MINIX_V3)) {
+					unsigned l = strnlen(de->name,sbi->s_namelen);
+					offset = p - kaddr;
+					over = filldir(dirent, de->name, l,
+					(n<<PAGE_CACHE_SHIFT) | offset,
+					de->inode, DT_UNKNOWN);
+				} else {
+					unsigned l = strnlen(de3->name,sbi->s_namelen);
+					offset = p - kaddr;
+					over = filldir(dirent, de3->name, l,
+					(n<<PAGE_CACHE_SHIFT) | offset,
+					de3->inode, DT_UNKNOWN);
+				}
 				if (over) {
 					dir_put_page(page);
 					goto done;
@@ -158,7 +169,7 @@
 	unsigned long npages = dir_pages(dir);
 	struct page *page = NULL;
 	struct minix_dir_entry *de;
-
+	struct minix3_dir_entry *de3;
 	*res_page = NULL;
 
 	for (n = 0; n < npages; n++) {
@@ -169,17 +180,26 @@
 
 		kaddr = (char*)page_address(page);
 		de = (struct minix_dir_entry *) kaddr;
+		de3 = (struct minix3_dir_entry *) kaddr;
 		kaddr += minix_last_byte(dir, n) - sbi->s_dirsize;
-		for ( ; (char *) de <= kaddr ; de = minix_next_entry(de,sbi)) {
-			if (!de->inode)
-				continue;
-			if (namecompare(namelen,sbi->s_namelen,name,de->name))
-				goto found;
+		for ( ; (char *) de <= kaddr ;
+					de = minix_next_entry(de,sbi),
+					de3 = minix_next_entry(de3,sbi)) {
+			if (!(sbi->s_version == MINIX_V3)) {
+				if (!de->inode)
+					continue;
+				if (namecompare(namelen,sbi->s_namelen,name,de->name))
+					goto found;
+			} else {
+				if (!de3->inode)
+					continue;
+				if (namecompare(namelen,sbi->s_namelen,name,de3->name))
+					goto found;
+			}
 		}
 		dir_put_page(page);
 	}
 	return NULL;
-
 found:
 	*res_page = page;
 	return de;
@@ -194,6 +214,7 @@
 	struct minix_sb_info * sbi = minix_sb(sb);
 	struct page *page = NULL;
 	struct minix_dir_entry * de;
+	struct minix3_dir_entry * de3;
 	unsigned long npages = dir_pages(dir);
 	unsigned long n;
 	char *kaddr;
@@ -216,6 +237,7 @@
 		kaddr = (char*)page_address(page);
 		dir_end = kaddr + minix_last_byte(dir, n);
 		de = (minix_dirent *)kaddr;
+		de3 = (minix3_dirent *)kaddr;
 		kaddr += PAGE_CACHE_SIZE - sbi->s_dirsize;
 		while ((char *)de <= kaddr) {
 			if ((char *)de == dir_end) {
@@ -226,9 +248,16 @@
 			if (!de->inode)
 				goto got_it;
 			err = -EEXIST;
-			if (namecompare(namelen,sbi->s_namelen,name,de->name))
-				goto out_unlock;
-			de = minix_next_entry(de, sbi);
+			if (!(sbi->s_version == MINIX_V3)) {
+				if (namecompare(namelen,sbi->s_namelen,name,de->name))
+					goto out_unlock;
+				de = minix_next_entry(de, sbi);
+			} else {
+				if (namecompare(namelen,sbi->s_namelen,name,de3->name))
+					goto out_unlock;
+				de = minix_next_entry(de, sbi);
+				de3 = minix_next_entry(de3, sbi);
+			}
 		}
 		unlock_page(page);
 		dir_put_page(page);
@@ -242,9 +271,15 @@
 	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
 	if (err)
 		goto out_unlock;
-	memcpy (de->name, name, namelen);
-	memset (de->name + namelen, 0, sbi->s_dirsize - namelen - 2);
-	de->inode = inode->i_ino;
+		if (!(sbi->s_version == MINIX_V3)) {
+		memcpy (de->name, name, namelen);
+		memset (de->name + namelen, 0, sbi->s_dirsize - namelen - 2);
+		de->inode = inode->i_ino;
+		} else {
+		memcpy (de3->name, name, namelen);
+		memset (de3->name + namelen, 0, sbi->s_dirsize - namelen - 4);
+		de3->inode = inode->i_ino;
+		}
 	err = dir_commit_chunk(page, from, to);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
@@ -286,6 +321,7 @@
 	struct page *page = grab_cache_page(mapping, 0);
 	struct minix_sb_info * sbi = minix_sb(inode->i_sb);
 	struct minix_dir_entry * de;
+	struct minix3_dir_entry * de3;
 	char *kaddr;
 	int err;
 
@@ -301,11 +337,13 @@
 	memset(kaddr, 0, PAGE_CACHE_SIZE);
 
 	de = (struct minix_dir_entry *)kaddr;
-	de->inode = inode->i_ino;
-	strcpy(de->name,".");
+	de3 = (struct minix3_dir_entry *)kaddr;
+	de->inode = de3->inode = inode->i_ino;
+	(sbi->s_version == MINIX_V3) ? strcpy(de3->name,".") : strcpy(de->name,".");
 	de = minix_next_entry(de, sbi);
-	de->inode = dir->i_ino;
-	strcpy(de->name,"..");
+	de3 = minix_next_entry(de3, sbi);
+	de->inode = de3->inode = dir->i_ino;
+	(sbi->s_version == MINIX_V3) ? strcpy(de3->name,"..") : strcpy(de->name,"..");
 	kunmap_atomic(kaddr, KM_USER0);
 
 	err = dir_commit_chunk(page, 0, 2 * sbi->s_dirsize);
@@ -326,27 +364,42 @@
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
 		kaddr += minix_last_byte(inode, i) - sbi->s_dirsize;
 
 		while ((char *)de <= kaddr) {
 			if (de->inode != 0) {
 				/* check for . and .. */
-				if (de->name[0] != '.')
-					goto not_empty;
-				if (!de->name[1]) {
-					if (de->inode != inode->i_ino)
+				if (!(sbi->s_version == MINIX_V3)) {
+					if (de->name[0] != '.')
+						goto not_empty;
+					if (!de->name[1]) {
+						if (de->inode != inode->i_ino)
+						goto not_empty;
+					} else if (de->name[1] != '.')
+						goto not_empty;
+					else if (de->name[2])
+						goto not_empty;
+				} else {
+					if (de3->name[0] != '.')
 						goto not_empty;
-				} else if (de->name[1] != '.')
-					goto not_empty;
-				else if (de->name[2])
-					goto not_empty;
+					if (!de3->name[1]) {
+						if (de3->inode != inode->i_ino)
+						goto not_empty;
+					} else if (de3->name[1] != '.')
+						goto not_empty;
+					else if (de3->name[2])
+						goto not_empty;
+				}
 			}
 			de = minix_next_entry(de, sbi);
 		}
diff -ur orig.linux-2.6.14.5/fs/minix/inode.c updated.linux-2.6.14.5/fs/minix/inode.c
--- orig.linux-2.6.14.5/fs/minix/inode.c	2005-12-27 01:26:33.000000000 +0100
+++ updated.linux-2.6.14.5/fs/minix/inode.c	2006-01-11 19:41:41.000000000 +0100
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
 
@@ -197,6 +201,23 @@
 		sbi->s_dirsize = 32;
 		sbi->s_namelen = 30;
 		sbi->s_link_max = MINIX2_LINK_MAX;
+	} else if ( *(__u16 *)(bh->b_data + 24) == MINIX3_SUPER_MAGIC) {
+
+		s->s_magic = MINIX3_SUPER_MAGIC;
+		sbi->s_imap_blocks = *(__u16 *)(bh->b_data + 6);
+		sbi->s_zmap_blocks = *(__u16 *)(bh->b_data + 8);
+		sbi->s_firstdatazone = *(__u16 *)(bh->b_data + 10);
+		sbi->s_log_zone_size = *(__u16 *)(bh->b_data + 12);
+		sbi->s_max_size = *(__u32 *)(bh->b_data + 16);
+		sbi->s_nzones = *(__u32 *)(bh->b_data + 20);
+		sbi->s_dirsize = 64;
+		sbi->s_namelen = 60;
+		sbi->s_version = MINIX_V3;
+		sbi->s_link_max = MINIX2_LINK_MAX;
+			if ( *(__u16 *)(bh->b_data + 28) != 1024) {
+				if (!sb_set_blocksize(s,( *(__u16 *)(bh->b_data + 28))))
+ 				goto out_bad_hblock;
+		}
 	} else
 		goto out_no_fs;
 
@@ -240,15 +261,16 @@
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
@@ -277,8 +299,8 @@
 
 out_no_fs:
 	if (!silent)
-		printk("VFS: Can't find a Minix or Minix V2 filesystem on device "
-		       "%s.\n", s->s_id);
+		printk("VFS: Can't find a Minix filesystem V1 | V2 | V3 on device "
+ 		       "%s.\n", s->s_id);
     out_release:
 	brelse(bh);
 	goto out;
@@ -536,12 +558,14 @@
 
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
 
diff -ur orig.linux-2.6.14.5/fs/minix/itree_common.c updated.linux-2.6.14.5/fs/minix/itree_common.c
--- orig.linux-2.6.14.5/fs/minix/itree_common.c	2005-12-27 01:26:33.000000000 +0100
+++ updated.linux-2.6.14.5/fs/minix/itree_common.c	2006-01-11 19:41:41.000000000 +0100
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
diff -ur orig.linux-2.6.14.5/fs/minix/minix.h updated.linux-2.6.14.5/fs/minix/minix.h
--- orig.linux-2.6.14.5/fs/minix/minix.h	2005-12-27 01:26:33.000000000 +0100
+++ updated.linux-2.6.14.5/fs/minix/minix.h	2006-01-11 19:41:41.000000000 +0100
@@ -12,6 +12,7 @@
 
 #define MINIX_V1		0x0001		/* original minix fs */
 #define MINIX_V2		0x0002		/* minix V2 fs */
+#define MINIX_V3		0x0003		/* minix V3 fs */
 
 /*
  * minix fs inode data in memory
diff -ur orig.linux-2.6.14.5/include/linux/minix_fs.h updated.linux-2.6.14.5/include/linux/minix_fs.h
--- orig.linux-2.6.14.5/include/linux/minix_fs.h	2005-12-27 01:26:33.000000000 +0100
+++ updated.linux-2.6.14.5/include/linux/minix_fs.h	2006-01-11 19:41:41.000000000 +0100
@@ -23,11 +23,12 @@
 #define MINIX_SUPER_MAGIC2	0x138F		/* minix fs, 30 char names */
 #define MINIX2_SUPER_MAGIC	0x2468		/* minix V2 fs */
 #define MINIX2_SUPER_MAGIC2	0x2478		/* minix V2 fs, 30 char names */
+#define MINIX3_SUPER_MAGIC	0x4d5a		/* minix V3 fs */ 
 #define MINIX_VALID_FS		0x0001		/* Clean fs. */
 #define MINIX_ERROR_FS		0x0002		/* fs has errors. */
 
 #define MINIX_INODES_PER_BLOCK ((BLOCK_SIZE)/(sizeof (struct minix_inode)))
-#define MINIX2_INODES_PER_BLOCK ((BLOCK_SIZE)/(sizeof (struct minix2_inode)))
+#define MINIX2_INODES_PER_BLOCK(b) ((b)/(sizeof (struct minix2_inode)))
 
 /*
  * This is the original minix inode layout on disk.
@@ -82,4 +83,9 @@
 	char name[0];
 };
 
+struct minix3_dir_entry {
+	__u32 inode;
+	char name[0];
+};
 #endif

--------------030400020506010501080204
Content-Type: text/plain;
 name="V3_2dot4_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="V3_2dot4_patch.txt"

diff -ur orig.linux-2.4.32/fs/minix/bitmap.c updated.linux-2.4.32/fs/minix/bitmap.c
--- orig.linux-2.4.32/fs/minix/bitmap.c	2002-02-25 20:38:09.000000000 +0100
+++ updated.linux-2.4.32/fs/minix/bitmap.c	2006-01-14 20:57:54.000000000 +0100
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
@@ -157,14 +157,14 @@
 	}
 	ino--;
 	block = 2 + sbi->s_imap_blocks + sbi->s_zmap_blocks +
-		 ino / MINIX2_INODES_PER_BLOCK;
+		 ino / MINIX2_INODES_PER_BLOCK(sb->s_blocksize);
 	*bh = sb_bread(sb, block);
 	if (!*bh) {
 		printk("unable to read i-node block\n");
 		return NULL;
 	}
 	p = (void *)(*bh)->b_data;
-	return p + ino % MINIX2_INODES_PER_BLOCK;
+	return p + ino % MINIX2_INODES_PER_BLOCK(sb->s_blocksize);
 }
 
 /* Clear the link count and mode of a deleted inode on disk. */
diff -ur orig.linux-2.4.32/fs/minix/dir.c updated.linux-2.4.32/fs/minix/dir.c
--- orig.linux-2.4.32/fs/minix/dir.c	2002-02-25 20:38:09.000000000 +0100
+++ updated.linux-2.4.32/fs/minix/dir.c	2006-01-14 20:57:54.000000000 +0100
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
 
@@ -95,14 +99,22 @@
 		limit = kaddr + PAGE_CACHE_SIZE - chunk_size;
 		for ( ; p <= limit ; p = minix_next_entry(p, sbi)) {
 			minix_dirent *de = (minix_dirent *)p;
+			minix3_dirent *de3 = (minix3_dirent *)p;
 			if (de->inode) {
 				int over;
-				unsigned l = strnlen(de->name,sbi->s_namelen);
-
-				offset = p - kaddr;
-				over = filldir(dirent, de->name, l,
-						(n<<PAGE_CACHE_SHIFT) | offset,
-						de->inode, DT_UNKNOWN);
+				if (!(sbi->s_version == MINIX_V3)) {
+					unsigned l = strnlen(de->name,sbi->s_namelen);
+					offset = p - kaddr;
+					over = filldir(dirent, de->name, l,
+					(n<<PAGE_CACHE_SHIFT) | offset,
+					de->inode, DT_UNKNOWN);
+				} else {
+					unsigned l = strnlen(de3->name,sbi->s_namelen);
+					offset = p - kaddr;
+					over = filldir(dirent, de3->name, l,
+					(n<<PAGE_CACHE_SHIFT) | offset,
+					de3->inode, DT_UNKNOWN);
+				}
 				if (over) {
 					dir_put_page(page);
 					goto done;
@@ -145,7 +157,7 @@
 	unsigned long npages = dir_pages(dir);
 	struct page *page = NULL;
 	struct minix_dir_entry *de;
-
+	struct minix3_dir_entry *de3;
 	*res_page = NULL;
 
 	for (n = 0; n < npages; n++) {
@@ -156,12 +168,22 @@
 
 		kaddr = (char*)page_address(page);
 		de = (struct minix_dir_entry *) kaddr;
+		de3 = (struct minix3_dir_entry *) kaddr;
 		kaddr += PAGE_CACHE_SIZE - sbi->s_dirsize;
-		for ( ; (char *) de <= kaddr ; de = minix_next_entry(de,sbi)) {
-			if (!de->inode)
-				continue;
-			if (namecompare(namelen,sbi->s_namelen,name,de->name))
-				goto found;
+		for ( ; (char *) de <= kaddr ;
+					de = minix_next_entry(de,sbi),
+					de3 = minix_next_entry(de3,sbi)) {
+			if (!(sbi->s_version == MINIX_V3)) {
+				if (!de->inode)
+					continue;
+				if (namecompare(namelen,sbi->s_namelen,name,de->name))
+					goto found; 		
+			} else {
+				if (!de3->inode)
+					continue;
+				if (namecompare(namelen,sbi->s_namelen,name,de3->name))
+					goto found;
+			}
 		}
 		dir_put_page(page);
 	}
@@ -181,6 +203,7 @@
 	struct minix_sb_info * sbi = &sb->u.minix_sb;
 	struct page *page = NULL;
 	struct minix_dir_entry * de;
+	struct minix3_dir_entry * de3;
 	unsigned long npages = dir_pages(dir);
 	unsigned long n;
 	char *kaddr;
@@ -195,14 +218,22 @@
 			goto out;
 		kaddr = (char*)page_address(page);
 		de = (minix_dirent *)kaddr;
+		de3 = (minix3_dirent *)kaddr;
 		kaddr += PAGE_CACHE_SIZE - sbi->s_dirsize;
 		while ((char *)de <= kaddr) {
 			if (!de->inode)
 				goto got_it;
 			err = -EEXIST;
-			if (namecompare(namelen,sbi->s_namelen,name,de->name))
-				goto out_page;
-			de = minix_next_entry(de, sbi);
+			if (!(sbi->s_version == MINIX_V3)) {
+				if (namecompare(namelen,sbi->s_namelen,name,de->name)) 		
+					goto out_page;
+ 				de = minix_next_entry(de, sbi);
+			} else {
+				if (namecompare(namelen,sbi->s_namelen,name,de3->name))
+					goto out_unlock;
+				de = minix_next_entry(de, sbi);
+				de3 = minix_next_entry(de3, sbi);
+			}
 		}
 		dir_put_page(page);
 	}
@@ -216,9 +247,15 @@
 	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
 	if (err)
 		goto out_unlock;
-	memcpy (de->name, name, namelen);
-	memset (de->name + namelen, 0, sbi->s_dirsize - namelen - 2);
-	de->inode = inode->i_ino;
+		if (!(sbi->s_version == MINIX_V3)) {
+		memcpy (de->name, name, namelen);
+		memset (de->name + namelen, 0, sbi->s_dirsize - namelen - 2);
+		de->inode = inode->i_ino;
+		} else {
+		memcpy (de3->name, name, namelen);
+		memset (de3->name + namelen, 0, sbi->s_dirsize - namelen - 4);
+		de3->inode = inode->i_ino;
+		}
 	err = dir_commit_chunk(page, from, to);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(dir);
@@ -258,6 +295,7 @@
 	struct page *page = grab_cache_page(mapping, 0);
 	struct minix_sb_info * sbi = &inode->i_sb->u.minix_sb;
 	struct minix_dir_entry * de;
+	struct minix3_dir_entry * de3;
 	char *base;
 	int err;
 
@@ -269,13 +307,14 @@
 
 	base = (char*)page_address(page);
 	memset(base, 0, PAGE_CACHE_SIZE);
-
-	de = (struct minix_dir_entry *) base;
-	de->inode = inode->i_ino;
-	strcpy(de->name,".");
+	de = (struct minix_dir_entry *)base;
+	de3 = (struct minix3_dir_entry *)base;
+	de->inode = de3->inode = inode->i_ino;
+	(sbi->s_version == MINIX_V3) ? strcpy(de3->name,".") : strcpy(de->name,".");
 	de = minix_next_entry(de, sbi);
-	de->inode = dir->i_ino;
-	strcpy(de->name,"..");
+	de3 = minix_next_entry(de3, sbi);
+	de->inode = de3->inode = dir->i_ino;
+	(sbi->s_version == MINIX_V3) ? strcpy(de3->name,"..") : strcpy(de->name,"..");
 
 	err = dir_commit_chunk(page, 0, 2 * sbi->s_dirsize);
 fail:
@@ -296,27 +335,42 @@
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
 
 		while ((char *)de <= kaddr) {
 			if (de->inode != 0) {
 				/* check for . and .. */
-				if (de->name[0] != '.')
-					goto not_empty;
-				if (!de->name[1]) {
-					if (de->inode != inode->i_ino)
+				if (!(sbi->s_version == MINIX_V3)) {
+					if (de->name[0] != '.')
+						goto not_empty;
+					if (!de->name[1]) {
+						if (de->inode != inode->i_ino)
+							goto not_empty;
+					} else if (de->name[1] != '.')
+						goto not_empty;
+					else if (de->name[2])
 						goto not_empty;
-				} else if (de->name[1] != '.')
-					goto not_empty;
-				else if (de->name[2])
-					goto not_empty;
+				} else {
+					if (de3->name[0] != '.')
+						goto not_empty;
+					if (!de3->name[1]) {
+						if (de3->inode != inode->i_ino)
+							goto not_empty;
+					} else if (de3->name[1] != '.')
+						goto not_empty;
+					else if (de3->name[2])
+						goto not_empty;
+				}
 			}
 			de = minix_next_entry(de, sbi);
 		}
diff -ur orig.linux-2.4.32/fs/minix/inode.c updated.linux-2.4.32/fs/minix/inode.c
--- orig.linux-2.4.32/fs/minix/inode.c	2003-11-28 19:26:21.000000000 +0100
+++ updated.linux-2.4.32/fs/minix/inode.c	2006-01-14 20:57:55.000000000 +0100
@@ -7,6 +7,7 @@
  *	Minix V2 fs support.
  *
  *  Modified for 680x0 by Andreas Schwab
+ *  Updated to filesystem version 3 by Daniel Aragones
  */
 
 #include <linux/module.h>
@@ -28,7 +29,7 @@
 static void minix_delete_inode(struct inode *inode)
 {
 	lock_kernel();
-
+	truncate_inode_pages(&inode->i_data, 0);
 	inode->i_size = 0;
 	minix_truncate(inode);
 	minix_free_inode(inode);
@@ -45,23 +46,24 @@
 static void minix_write_super(struct super_block * sb)
 {
 	struct minix_super_block * ms;
+	struct minix_sb_info *sbi = &sb->u.minix_sb;
 
 	if (!(sb->s_flags & MS_RDONLY)) {
 		ms = sb->u.minix_sb.s_ms;
-
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
 
-
 static void minix_put_super(struct super_block *sb)
 {
 	int i;
-
-	if (!(sb->s_flags & MS_RDONLY)) {
+	struct minix_sb_info *sbi = &sb->u.minix_sb;
+	if (!(sb->s_flags & MS_RDONLY) && (sbi->s_version != MINIX_V3)) {
 		sb->u.minix_sb.s_ms->s_state = sb->u.minix_sb.s_mount_state;
 		mark_buffer_dirty(sb->u.minix_sb.s_sbh);
 	}
@@ -88,11 +90,12 @@
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
@@ -102,20 +105,21 @@
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
 
@@ -182,6 +186,23 @@
 		sbi->s_dirsize = 32;
 		sbi->s_namelen = 30;
 		sbi->s_link_max = MINIX2_LINK_MAX;
+	} else if ( *(__u16 *)(bh->b_data + 24) == MINIX3_SUPER_MAGIC) {
+
+		s->s_magic = MINIX3_SUPER_MAGIC;
+		sbi->s_imap_blocks = *(__u16 *)(bh->b_data + 6);
+		sbi->s_zmap_blocks = *(__u16 *)(bh->b_data + 8);
+		sbi->s_firstdatazone = *(__u16 *)(bh->b_data + 10);
+		sbi->s_log_zone_size = *(__u16 *)(bh->b_data + 12);
+		sbi->s_max_size = *(__u32 *)(bh->b_data + 16);
+		sbi->s_nzones = *(__u32 *)(bh->b_data + 20);
+		sbi->s_dirsize = 64;
+		sbi->s_namelen = 60;
+		sbi->s_version = MINIX_V3;
+		sbi->s_link_max = MINIX2_LINK_MAX;
+			if ( *(__u16 *)(bh->b_data + 28) != 1024) {
+				if (!sb_set_blocksize(s,( *(__u16 *)(bh->b_data + 28))))
+ 				goto out_bad_hblock;
+		}
 	} else
 		goto out_no_fs;
 
@@ -224,17 +245,17 @@
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
@@ -263,7 +284,7 @@
 
 out_no_fs:
 	if (!silent)
-		printk("VFS: Can't find a Minix or Minix V2 filesystem on device "
+		printk("VFS: Can't find a Minix filesystem V1 | V2 | V3 on device "
 		       "%s.\n", kdevname(dev));
     out_release:
 	brelse(bh);
diff -ur orig.linux-2.4.32/fs/minix/itree_common.c updated.linux-2.4.32/fs/minix/itree_common.c
--- orig.linux-2.4.32/fs/minix/itree_common.c	2002-02-25 20:38:09.000000000 +0100
+++ updated.linux-2.4.32/fs/minix/itree_common.c	2006-01-14 20:57:54.000000000 +0100
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
+++ updated.linux-2.4.32/include/linux/minix_fs.h	2006-01-14 20:57:55.000000000 +0100
@@ -23,14 +23,16 @@
 #define MINIX_SUPER_MAGIC2	0x138F		/* minix fs, 30 char names */
 #define MINIX2_SUPER_MAGIC	0x2468		/* minix V2 fs */
 #define MINIX2_SUPER_MAGIC2	0x2478		/* minix V2 fs, 30 char names */
+#define MINIX3_SUPER_MAGIC	0x4d5a		/* minix V3 fs */ 
 #define MINIX_VALID_FS		0x0001		/* Clean fs. */
 #define MINIX_ERROR_FS		0x0002		/* fs has errors. */
 
 #define MINIX_INODES_PER_BLOCK ((BLOCK_SIZE)/(sizeof (struct minix_inode)))
-#define MINIX2_INODES_PER_BLOCK ((BLOCK_SIZE)/(sizeof (struct minix2_inode)))
+#define MINIX2_INODES_PER_BLOCK(b) ((b)/(sizeof (struct minix2_inode)))
 
 #define MINIX_V1		0x0001		/* original minix fs */
 #define MINIX_V2		0x0002		/* minix V2 fs */
+#define MINIX_V3		0x0003		/* minix V3 fs */
 
 #define INODE_VERSION(inode)	inode->i_sb->u.minix_sb.s_version
 
@@ -87,6 +89,12 @@
 	char name[0];
 };
 
+struct minix3_dir_entry {
+	__u32 inode;
+	char name[0];
+};
+
 #ifdef __KERNEL__
 
 /*

--------------030400020506010501080204--
