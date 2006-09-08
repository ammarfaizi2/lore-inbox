Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752117AbWIHEQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbWIHEQN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 00:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbWIHEQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 00:16:13 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:15031 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1752117AbWIHEQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 00:16:11 -0400
To: cmm@us.ibm.com, adilger@clusterfs.com, johann.lombardi@bull.net
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][4/4] ext4: fix rec_len overflow
Message-Id: <20060908131604sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Fri, 8 Sep 2006 13:16:04 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  [4/4]  ext4: fix rec_len overflow
         - prevent rec_len from overflow with 64KB blocksize


Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.18-rc4-mingming/Documentation/dontdiff linux-2.6.18-rc4-mingming/fs/ext4/dir.c linux-2.6.18-rc4-mingming-tnes-no_compile/fs/ext4/dir.c
--- linux-2.6.18-rc4-mingming/fs/ext4/dir.c	2006-08-29 16:28:53.000000000 +0900
+++ linux-2.6.18-rc4-mingming-tnes-no_compile/fs/ext4/dir.c	2006-09-04 11:15:16.000000000 +0900
@@ -98,12 +98,11 @@ static int ext4_readdir(struct file * fi
 	unsigned long offset;
 	int i, stored;
 	struct ext4_dir_entry_2 *de;
-	struct super_block *sb;
 	int err;
 	struct inode *inode = filp->f_dentry->d_inode;
+	struct super_block *sb = inode->i_sb;
 	int ret = 0;
-
-	sb = inode->i_sb;
+	unsigned tail = sb->s_blocksize;
 
 #ifdef CONFIG_EXT4_INDEX
 	if (EXT4_HAS_COMPAT_FEATURE(inode->i_sb,
@@ -159,8 +158,11 @@ revalidate:
 		 * readdir(2), then we might be pointing to an invalid
 		 * dirent right now.  Scan from the start of the block
 		 * to make sure. */
+		if (tail >  EXT4_DIR_MAX_REC_LEN) {
+			tail = EXT4_DIR_MAX_REC_LEN;
+		}
 		if (filp->f_version != inode->i_version) {
-			for (i = 0; i < sb->s_blocksize && i < offset; ) {
+			for (i = 0; i < tail && i < offset; ) {
 				de = (struct ext4_dir_entry_2 *)
 					(bh->b_data + i);
 				/* It's too expensive to do a full
@@ -181,7 +183,7 @@ revalidate:
 		}
 
 		while (!error && filp->f_pos < inode->i_size
-		       && offset < sb->s_blocksize) {
+		       && offset < tail) {
 			de = (struct ext4_dir_entry_2 *) (bh->b_data + offset);
 			if (!ext4_check_dir_entry ("ext4_readdir", inode, de,
 						   bh, offset)) {
@@ -217,6 +219,7 @@ revalidate:
 			}
 			filp->f_pos += le16_to_cpu(de->rec_len);
 		}
+		filp->f_pos = EXT4_DIR_ADJUST_TAIL_OFFS(filp->f_pos, sb->s_blocksize);
 		offset = 0;
 		brelse (bh);
 	}
diff -upNr -X linux-2.6.18-rc4-mingming/Documentation/dontdiff linux-2.6.18-rc4-mingming/fs/ext4/namei.c linux-2.6.18-rc4-mingming-tnes-no_compile/fs/ext4/namei.c
--- linux-2.6.18-rc4-mingming/fs/ext4/namei.c	2006-08-29 16:28:47.000000000 +0900
+++ linux-2.6.18-rc4-mingming-tnes-no_compile/fs/ext4/namei.c	2006-09-04 11:15:16.000000000 +0900
@@ -262,9 +262,13 @@ static struct stats dx_show_leaf(struct 
 	unsigned names = 0, space = 0;
 	char *base = (char *) de;
 	struct dx_hash_info h = *hinfo;
+	unsigned tail = size;
 
 	printk("names: ");
-	while ((char *) de < base + size)
+	if (tail > EXT4_DIR_MAX_REC_LEN) {
+		tail = EXT4_DIR_MAX_REC_LEN;
+	}
+	while ((char *) de < base + tail)
 	{
 		if (de->inode)
 		{
@@ -668,8 +672,12 @@ static int dx_make_map (struct ext4_dir_
 	int count = 0;
 	char *base = (char *) de;
 	struct dx_hash_info h = *hinfo;
+	unsigned tail = size;
 
-	while ((char *) de < base + size)
+	if (tail > EXT4_DIR_MAX_REC_LEN) {
+		tail = EXT4_DIR_MAX_REC_LEN;
+	}
+	while ((char *) de < base + tail)
 	{
 		if (de->name_len && de->inode) {
 			ext4fs_dirhash(de->name, de->name_len, &h);
@@ -766,9 +774,13 @@ static inline int search_dirblock(struct
 	int de_len;
 	const char *name = dentry->d_name.name;
 	int namelen = dentry->d_name.len;
+	unsigned tail = dir->i_sb->s_blocksize;
 
 	de = (struct ext4_dir_entry_2 *) bh->b_data;
-	dlimit = bh->b_data + dir->i_sb->s_blocksize;
+	if (tail > EXT4_DIR_MAX_REC_LEN) {
+		tail = EXT4_DIR_MAX_REC_LEN;
+	}
+	dlimit = bh->b_data + tail;
 	while ((char *) de < dlimit) {
 		/* this code is executed quadratically often */
 		/* do minimal checking `by hand' */
@@ -1084,6 +1096,9 @@ static struct ext4_dir_entry_2* dx_pack_
 	unsigned rec_len = 0;
 
 	prev = to = de;
+	if (size > EXT4_DIR_MAX_REC_LEN) {
+		size = EXT4_DIR_MAX_REC_LEN;
+	}
 	while ((char*)de < base + size) {
 		next = (struct ext4_dir_entry_2 *) ((char *) de +
 						    le16_to_cpu(de->rec_len));
@@ -1154,8 +1169,15 @@ static struct ext4_dir_entry_2 *do_split
 	/* Fancy dance to stay within two buffers */
 	de2 = dx_move_dirents(data1, data2, map + split, count - split);
 	de = dx_pack_dirents(data1,blocksize);
-	de->rec_len = cpu_to_le16(data1 + blocksize - (char *) de);
-	de2->rec_len = cpu_to_le16(data2 + blocksize - (char *) de2);
+	if (blocksize < EXT4_DIR_MAX_REC_LEN) {
+		de->rec_len = cpu_to_le16(data1 + blocksize - (char *) de);
+		de2->rec_len = cpu_to_le16(data2 + blocksize - (char *) de2);
+	} else {
+		de->rec_len = cpu_to_le16(data1 + EXT4_DIR_MAX_REC_LEN -
+							(char *) de);
+		de2->rec_len = cpu_to_le16(data2 + EXT4_DIR_MAX_REC_LEN -
+							(char *) de2);
+	}
 	dxtrace(dx_show_leaf (hinfo, (struct ext4_dir_entry_2 *) data1, blocksize, 1));
 	dxtrace(dx_show_leaf (hinfo, (struct ext4_dir_entry_2 *) data2, blocksize, 1));
 
@@ -1202,11 +1224,15 @@ static int add_dirent_to_buf(handle_t *h
 	unsigned short	reclen;
 	int		nlen, rlen, err;
 	char		*top;
+	unsigned        tail = dir->i_sb->s_blocksize;
 
+	if (tail > EXT4_DIR_MAX_REC_LEN) {
+		tail = EXT4_DIR_MAX_REC_LEN;
+	}
 	reclen = EXT4_DIR_REC_LEN(namelen);
 	if (!de) {
 		de = (struct ext4_dir_entry_2 *)bh->b_data;
-		top = bh->b_data + dir->i_sb->s_blocksize - reclen;
+		top = bh->b_data + tail - reclen;
 		while ((char *) de <= top) {
 			if (!ext4_check_dir_entry("ext4_add_entry", dir, de,
 						  bh, offset)) {
@@ -1320,13 +1346,21 @@ static int make_indexed_dir(handle_t *ha
 	/* The 0th block becomes the root, move the dirents out */
 	fde = &root->dotdot;
 	de = (struct ext4_dir_entry_2 *)((char *)fde + le16_to_cpu(fde->rec_len));
-	len = ((char *) root) + blocksize - (char *) de;
+	if (blocksize < EXT4_DIR_MAX_REC_LEN) {
+		len = ((char *) root) + blocksize - (char *) de;
+	} else {
+		len = ((char *) root) + EXT4_DIR_MAX_REC_LEN - (char *) de;
+	}
 	memcpy (data1, de, len);
 	de = (struct ext4_dir_entry_2 *) data1;
 	top = data1 + len;
 	while ((char *)(de2=(void*)de+le16_to_cpu(de->rec_len)) < top)
 		de = de2;
-	de->rec_len = cpu_to_le16(data1 + blocksize - (char *) de);
+	if (blocksize < EXT4_DIR_MAX_REC_LEN) {
+		de->rec_len = cpu_to_le16(data1 + blocksize - (char *) de);
+	} else {
+		de->rec_len = cpu_to_le16(data1 + EXT4_DIR_MAX_REC_LEN - (char *) de);
+	}
 	/* Initialize the root; the dot dirents already exist */
 	de = (struct ext4_dir_entry_2 *) (&root->dotdot);
 	de->rec_len = cpu_to_le16(blocksize - EXT4_DIR_REC_LEN(2));
@@ -1416,7 +1450,11 @@ static int ext4_add_entry (handle_t *han
 		return retval;
 	de = (struct ext4_dir_entry_2 *) bh->b_data;
 	de->inode = 0;
-	de->rec_len = cpu_to_le16(blocksize);
+	if (blocksize < EXT4_DIR_MAX_REC_LEN) {
+		de->rec_len = cpu_to_le16(blocksize);
+	} else {
+		de->rec_len = cpu_to_le16(EXT4_DIR_MAX_REC_LEN);
+	}
 	return add_dirent_to_buf(handle, dentry, inode, de, bh);
 }
 
@@ -1480,7 +1518,12 @@ static int ext4_dx_add_entry(handle_t *h
 			goto cleanup;
 		node2 = (struct dx_node *)(bh2->b_data);
 		entries2 = node2->entries;
-		node2->fake.rec_len = cpu_to_le16(sb->s_blocksize);
+		if (sb->s_blocksize < EXT4_DIR_MAX_REC_LEN) {
+			node2->fake.rec_len = cpu_to_le16(sb->s_blocksize);
+		} else {
+			node2->fake.rec_len =
+				cpu_to_le16(EXT4_DIR_MAX_REC_LEN);
+		}
 		node2->fake.inode = 0;
 		BUFFER_TRACE(frame->bh, "get_write_access");
 		err = ext4_journal_get_write_access(handle, frame->bh);
@@ -1568,11 +1611,15 @@ static int ext4_delete_entry (handle_t *
 {
 	struct ext4_dir_entry_2 * de, * pde;
 	int i;
+	unsigned tail = bh->b_size;
 
 	i = 0;
 	pde = NULL;
 	de = (struct ext4_dir_entry_2 *) bh->b_data;
-	while (i < bh->b_size) {
+	if (tail > EXT4_DIR_MAX_REC_LEN) {
+		tail = EXT4_DIR_MAX_REC_LEN;
+	}
+	while (i < tail) {
 		if (!ext4_check_dir_entry("ext4_delete_entry", dir, de, bh, i))
 			return -EIO;
 		if (de == de_del)  {
@@ -1747,7 +1794,11 @@ retry:
 	de = (struct ext4_dir_entry_2 *)
 			((char *) de + le16_to_cpu(de->rec_len));
 	de->inode = cpu_to_le32(dir->i_ino);
-	de->rec_len = cpu_to_le16(inode->i_sb->s_blocksize-EXT4_DIR_REC_LEN(1));
+	if (inode->i_sb->s_blocksize < EXT4_DIR_MAX_REC_LEN) {
+		de->rec_len = cpu_to_le16(inode->i_sb->s_blocksize-EXT4_DIR_REC_LEN(1));
+	} else  {   
+		de->rec_len = cpu_to_le16(EXT4_DIR_MAX_REC_LEN-EXT4_DIR_REC_LEN(1));
+	}
 	de->name_len = 2;
 	strcpy (de->name, "..");
 	ext4_set_de_type(dir->i_sb, de, S_IFDIR);
@@ -1782,10 +1833,10 @@ static int empty_dir (struct inode * ino
 	unsigned long offset;
 	struct buffer_head * bh;
 	struct ext4_dir_entry_2 * de, * de1;
-	struct super_block * sb;
+	struct super_block * sb = inode->i_sb;
 	int err = 0;
+	unsigned tail = sb->s_blocksize;
 
-	sb = inode->i_sb;
 	if (inode->i_size < EXT4_DIR_REC_LEN(1) + EXT4_DIR_REC_LEN(2) ||
 	    !(bh = ext4_bread (NULL, inode, 0, 0, &err))) {
 		if (err)
@@ -1812,11 +1863,17 @@ static int empty_dir (struct inode * ino
 		return 1;
 	}
 	offset = le16_to_cpu(de->rec_len) + le16_to_cpu(de1->rec_len);
+	if (offset == EXT4_DIR_MAX_REC_LEN) {
+		offset += sb->s_blocksize - EXT4_DIR_MAX_REC_LEN;
+	}
 	de = (struct ext4_dir_entry_2 *)
 			((char *) de1 + le16_to_cpu(de1->rec_len));
+	if (tail > EXT4_DIR_MAX_REC_LEN) {
+		tail = EXT4_DIR_MAX_REC_LEN;
+	}
 	while (offset < inode->i_size ) {
 		if (!bh ||
-			(void *) de >= (void *) (bh->b_data+sb->s_blocksize)) {
+			(void *) de >= (void *) (bh->b_data + tail)) {
 			err = 0;
 			brelse (bh);
 			bh = ext4_bread (NULL, inode,
@@ -1843,6 +1900,7 @@ static int empty_dir (struct inode * ino
 			return 0;
 		}
 		offset += le16_to_cpu(de->rec_len);
+		offset = EXT4_DIR_ADJUST_TAIL_OFFS(offset, sb->s_blocksize);
 		de = (struct ext4_dir_entry_2 *)
 				((char *) de + le16_to_cpu(de->rec_len));
 	}
diff -upNr -X linux-2.6.18-rc4-mingming/Documentation/dontdiff linux-2.6.18-rc4-mingming/include/linux/ext4_fs.h linux-2.6.18-rc4-mingming-tnes-no_compile/include/linux/ext4_fs.h
--- linux-2.6.18-rc4-mingming/include/linux/ext4_fs.h	2006-08-29 16:29:05.000000000 +0900
+++ linux-2.6.18-rc4-mingming-tnes-no_compile/include/linux/ext4_fs.h	2006-09-04 11:27:13.000000000 +0900
@@ -727,6 +727,15 @@ struct ext4_dir_entry_2 {
 #define EXT4_DIR_ROUND			(EXT4_DIR_PAD - 1)
 #define EXT4_DIR_REC_LEN(name_len)	(((name_len) + 8 + EXT4_DIR_ROUND) & \
 					 ~EXT4_DIR_ROUND)
+#define	EXT4_DIR_MAX_REC_LEN		65532
+
+/*
+ * Align a tail offset to the end of a directory block
+ */
+#define EXT4_DIR_ADJUST_TAIL_OFFS(offs, bsize) \
+	((((offs) & ((bsize) -1)) == EXT4_DIR_MAX_REC_LEN) ? \
+	((offs) + (bsize) - EXT4_DIR_MAX_REC_LEN):(offs))
+
 /*
  * Hash Tree Directory indexing
  * (c) Daniel Phillips, 2001
