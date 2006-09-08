Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752098AbWIHEOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbWIHEOa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 00:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbWIHEOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 00:14:30 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:48344 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1752098AbWIHEO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 00:14:28 -0400
To: cmm@us.ibm.com, adilger@clusterfs.com, johann.lombardi@bull.net
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][2/4] ext2: fix rec_len overflow
Message-Id: <20060908131421sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Fri, 8 Sep 2006 13:14:21 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  [2/4]  ext2: fix rec_len overflow
         - prevent rec_len from overflow with 64KB blocksize


Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.18-rc4-mingming/Documentation/dontdiff linux-2.6.18-rc4-mingming/fs/ext2/dir.c linux-2.6.18-rc4-mingming-tnes-no_compile/fs/ext2/dir.c
--- linux-2.6.18-rc4-mingming/fs/ext2/dir.c	2006-08-07 03:20:11.000000000 +0900
+++ linux-2.6.18-rc4-mingming-tnes-no_compile/fs/ext2/dir.c	2006-09-05 14:26:34.000000000 +0900
@@ -95,9 +95,9 @@ static void ext2_check_page(struct page 
 			goto out;
 	}
 	for (offs = 0; offs <= limit - EXT2_DIR_REC_LEN(1); offs += rec_len) {
+		offs = EXT2_DIR_ADJUST_TAIL_OFFS(offs, chunk_size);
 		p = (ext2_dirent *)(kaddr + offs);
 		rec_len = le16_to_cpu(p->rec_len);
-
 		if (rec_len < EXT2_DIR_REC_LEN(1))
 			goto Eshort;
 		if (rec_len & 3)
@@ -109,6 +109,7 @@ static void ext2_check_page(struct page 
 		if (le32_to_cpu(p->inode) > max_inumber)
 			goto Einumber;
 	}
+	offs = EXT2_DIR_ADJUST_TAIL_OFFS(offs, chunk_size);
 	if (offs != limit)
 		goto Eend;
 out:
@@ -287,6 +288,7 @@ ext2_readdir (struct file * filp, void *
 		de = (ext2_dirent *)(kaddr+offset);
 		limit = kaddr + ext2_last_byte(inode, n) - EXT2_DIR_REC_LEN(1);
 		for ( ;(char*)de <= limit; de = ext2_next_entry(de)) {
+			de = EXT2_DIR_ADJUST_TAIL_ADDR(kaddr, de, sb->s_blocksize);
 			if (de->rec_len == 0) {
 				ext2_error(sb, __FUNCTION__,
 					"zero-length directory entry");
@@ -309,8 +311,10 @@ ext2_readdir (struct file * filp, void *
 					return 0;
 				}
 			}
+			filp->f_pos = EXT2_DIR_ADJUST_TAIL_OFFS(filp->f_pos, sb->s_blocksize);
 			filp->f_pos += le16_to_cpu(de->rec_len);
 		}
+		filp->f_pos = EXT2_DIR_ADJUST_TAIL_OFFS(filp->f_pos, sb->s_blocksize);
 		ext2_put_page(page);
 	}
 	return 0;
@@ -347,13 +351,14 @@ struct ext2_dir_entry_2 * ext2_find_entr
 		start = 0;
 	n = start;
 	do {
-		char *kaddr;
+		char *kaddr, *page_start;
 		page = ext2_get_page(dir, n);
 		if (!IS_ERR(page)) {
-			kaddr = page_address(page);
+			kaddr = page_start = page_address(page);
 			de = (ext2_dirent *) kaddr;
 			kaddr += ext2_last_byte(dir, n) - reclen;
 			while ((char *) de <= kaddr) {
+				de = EXT2_DIR_ADJUST_TAIL_ADDR(page_start, de, dir->i_sb->s_blocksize);
 				if (de->rec_len == 0) {
 					ext2_error(dir->i_sb, __FUNCTION__,
 						"zero-length directory entry");
@@ -412,6 +417,7 @@ void ext2_set_link(struct inode *dir, st
 	unsigned to = from + le16_to_cpu(de->rec_len);
 	int err;
 
+	to = EXT2_DIR_ADJUST_TAIL_OFFS(to, inode->i_sb->s_blocksize);
 	lock_page(page);
 	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
 	BUG_ON(err);
@@ -442,6 +448,7 @@ int ext2_add_link (struct dentry *dentry
 	char *kaddr;
 	unsigned from, to;
 	int err;
+	char *page_start = NULL;
 
 	/*
 	 * We take care of directory expansion in the same loop.
@@ -456,16 +463,28 @@ int ext2_add_link (struct dentry *dentry
 		if (IS_ERR(page))
 			goto out;
 		lock_page(page);
-		kaddr = page_address(page);
+		kaddr = page_start = page_address(page);
 		dir_end = kaddr + ext2_last_byte(dir, n);
 		de = (ext2_dirent *)kaddr;
-		kaddr += PAGE_CACHE_SIZE - reclen;
+		if (chunk_size < EXT2_DIR_MAX_REC_LEN) {
+			kaddr += PAGE_CACHE_SIZE - reclen;
+		} else {
+			kaddr += PAGE_CACHE_SIZE - 
+				(chunk_size - EXT2_DIR_MAX_REC_LEN) - reclen;
+		}
 		while ((char *)de <= kaddr) {
+			de = EXT2_DIR_ADJUST_TAIL_ADDR(page_start, de, chunk_size);	
 			if ((char *)de == dir_end) {
 				/* We hit i_size */
 				name_len = 0;
-				rec_len = chunk_size;
-				de->rec_len = cpu_to_le16(chunk_size);
+				if (chunk_size  < EXT2_DIR_MAX_REC_LEN) {
+					rec_len = chunk_size;
+					de->rec_len = cpu_to_le16(chunk_size);
+				} else {
+					rec_len = EXT2_DIR_MAX_REC_LEN;
+					de->rec_len =
+					cpu_to_le16(EXT2_DIR_MAX_REC_LEN);
+				}
 				de->inode = 0;
 				goto got_it;
 			}
@@ -495,6 +514,7 @@ int ext2_add_link (struct dentry *dentry
 got_it:
 	from = (char*)de - (char*)page_address(page);
 	to = from + rec_len;
+	to = EXT2_DIR_ADJUST_TAIL_OFFS(to, chunk_size);
 	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
 	if (err)
 		goto out_unlock;
@@ -537,6 +557,7 @@ int ext2_delete_entry (struct ext2_dir_e
 	ext2_dirent * de = (ext2_dirent *) (kaddr + from);
 	int err;
 
+	to = EXT2_DIR_ADJUST_TAIL_OFFS(to, inode->i_sb->s_blocksize);
 	while ((char*)de < (char*)dir) {
 		if (de->rec_len == 0) {
 			ext2_error(inode->i_sb, __FUNCTION__,
@@ -594,7 +615,11 @@ int ext2_make_empty(struct inode *inode,
 
 	de = (struct ext2_dir_entry_2 *)(kaddr + EXT2_DIR_REC_LEN(1));
 	de->name_len = 2;
-	de->rec_len = cpu_to_le16(chunk_size - EXT2_DIR_REC_LEN(1));
+	if (chunk_size < EXT2_DIR_MAX_REC_LEN) {
+		de->rec_len = cpu_to_le16(chunk_size - EXT2_DIR_REC_LEN(1));
+	} else {
+		de->rec_len = cpu_to_le16(EXT2_DIR_MAX_REC_LEN - EXT2_DIR_REC_LEN(1));
+	}
 	de->inode = cpu_to_le32(parent->i_ino);
 	memcpy (de->name, "..\0", 4);
 	ext2_set_de_type (de, inode);
@@ -614,18 +639,19 @@ int ext2_empty_dir (struct inode * inode
 	unsigned long i, npages = dir_pages(inode);
 
 	for (i = 0; i < npages; i++) {
-		char *kaddr;
+		char *kaddr, *page_start;
 		ext2_dirent * de;
 		page = ext2_get_page(inode, i);
 
 		if (IS_ERR(page))
 			continue;
 
-		kaddr = page_address(page);
+		kaddr = page_start = page_address(page);
 		de = (ext2_dirent *)kaddr;
 		kaddr += ext2_last_byte(inode, i) - EXT2_DIR_REC_LEN(1);
 
 		while ((char *)de <= kaddr) {
+			de = EXT2_DIR_ADJUST_TAIL_ADDR(page_start, de, inode->i_sb->s_blocksize);
 			if (de->rec_len == 0) {
 				ext2_error(inode->i_sb, __FUNCTION__,
 					"zero-length directory entry");
diff -upNr -X linux-2.6.18-rc4-mingming/Documentation/dontdiff linux-2.6.18-rc4-mingming/include/linux/ext2_fs.h linux-2.6.18-rc4-mingming-tnes-no_compile/include/linux/ext2_fs.h
--- linux-2.6.18-rc4-mingming/include/linux/ext2_fs.h	2006-08-07 03:20:11.000000000 +0900
+++ linux-2.6.18-rc4-mingming-tnes-no_compile/include/linux/ext2_fs.h	2006-09-04 11:26:26.000000000 +0900
@@ -553,5 +553,18 @@ enum {
 #define EXT2_DIR_ROUND 			(EXT2_DIR_PAD - 1)
 #define EXT2_DIR_REC_LEN(name_len)	(((name_len) + 8 + EXT2_DIR_ROUND) & \
 					 ~EXT2_DIR_ROUND)
+#define	EXT2_DIR_MAX_REC_LEN		65532
+
+/*
+ * Align a tail offset(address) to the end of a directory block
+ */
+#define EXT2_DIR_ADJUST_TAIL_OFFS(offs, bsize) \
+	((((offs) & ((bsize) -1)) == EXT2_DIR_MAX_REC_LEN) ? \
+	((offs) + (bsize) - EXT2_DIR_MAX_REC_LEN):(offs))
+
+#define EXT2_DIR_ADJUST_TAIL_ADDR(page, de, bsize) \
+	(((((char*)(de) - (page)) & ((bsize) - 1)) == EXT2_DIR_MAX_REC_LEN) ? \
+	((ext2_dirent*)((char*)(de) + (bsize) - EXT2_DIR_MAX_REC_LEN)):(de))
 
 #endif	/* _LINUX_EXT2_FS_H */
+
