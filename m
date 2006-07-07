Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWGGLwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWGGLwG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 07:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWGGLwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 07:52:05 -0400
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:29855 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932132AbWGGLwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 07:52:01 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, johann.lombardi@bull.net
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][PATCH 1/2] ext3: enlarge blocksize and fix rec_lenoverflow
Message-Id: <20060707205146sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Fri, 7 Jul 2006 20:51:45 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Jun 29, 2006, Andreas wrote:
> On Jun 28, 2006  17:50 +0200, Johann Lombardi wrote:
> > ext2/ext3_dir_entry_2 has a 16-bit entry(rec_len) and it 
> would overflow
> > with 64KB blocksize.  This patch prevent from overflow by limiting
> > rec_len to 65532.
> 
> Having a max rec_len of 65532 is rather unfortunate, since the dir
> blocks always need to filled with dir entries.  65536 - 65532 = 4, and
> the minimum ext3_dir_entry size is 8 bytes.  I would instead make this
> maybe 64 bytes less so that there is room for a filename in the "tail"
> dir_entry.

The fix, adding dummy entry at the tail of a directory block, needs to
regenerate dummy entry when all of the entries are removed in  kernel.
While in e2fsprogs, e2fsck needs to do the same when destroyed by some
reason.  Thus procedures get more complicated.

Then I updated the patch to limit rec_len to 65532(64K - 4).  The
difference from the previous patch is that the end of a directory
block is changed to 65532(64K - 4) with 64K blocksize.
This is more simple and less tweaky.  This necessarily makes 4-bytes
from the end of a directory block useless, but 4-bytes is negligible
compared to 64KB, who cares?

This patch applies on top of Mingming's patches(against 2.6.17-git13)
which were posted at:
	http://ext2.sourceforge.net/48bitext3/patches/latest/

If everything is OK, I'll post a patch for e2fsprogs later.
Any comments are welcome.

Patch-set consists of the following 2 patches.
  [1/2]  ext3: enlarge blocksize and fix rec_len overflow
          - Allow blocksize up to 64KB.
          - prevent rec_len from overflow with 64KB blocksize

  [2/2]  ext2: fix rec_len overflow
          - prevent rec_len from overflow with 64KB blocksize


Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -Nupr -X linux-2.6.17-git13-Mingming/Documentation/dontdiff linux-2.6.17-git13-Mingming/fs/ext3/dir.c linux-2.6.17-git13-Mingming-reclen/fs/ext3/dir.c
--- linux-2.6.17-git13-Mingming/fs/ext3/dir.c	2006-07-07 17:26:22.000000000 +0900
+++ linux-2.6.17-git13-Mingming-reclen/fs/ext3/dir.c	2006-07-07 17:38:44.000000000 +0900
@@ -98,12 +98,11 @@ static int ext3_readdir(struct file * fi
 	unsigned long offset;
 	int i, stored;
 	struct ext3_dir_entry_2 *de;
-	struct super_block *sb;
 	int err;
 	struct inode *inode = filp->f_dentry->d_inode;
+	struct super_block *sb = inode->i_sb;
 	int ret = 0;
-
-	sb = inode->i_sb;
+	unsigned tail = sb->s_blocksize;
 
 #ifdef CONFIG_EXT3_INDEX
 	if (EXT3_HAS_COMPAT_FEATURE(inode->i_sb,
@@ -159,8 +158,10 @@ revalidate:
 		 * readdir(2), then we might be pointing to an invalid
 		 * dirent right now.  Scan from the start of the block
 		 * to make sure. */
+		if (tail >  EXT3_DIR_MAX_REC_LEN) 
+			tail = EXT3_DIR_MAX_REC_LEN;
 		if (filp->f_version != inode->i_version) {
-			for (i = 0; i < sb->s_blocksize && i < offset; ) {
+			for (i = 0; i < tail && i < offset; ) {
 				de = (struct ext3_dir_entry_2 *) 
 					(bh->b_data + i);
 				/* It's too expensive to do a full
@@ -181,7 +182,7 @@ revalidate:
 		}
 
 		while (!error && filp->f_pos < inode->i_size 
-		       && offset < sb->s_blocksize) {
+		       && offset < tail) {
 			de = (struct ext3_dir_entry_2 *) (bh->b_data + offset);
 			if (!ext3_check_dir_entry ("ext3_readdir", inode, de,
 						   bh, offset)) {
@@ -203,7 +204,6 @@ revalidate:
 				 * during the copy operation.
 				 */
 				unsigned long version = filp->f_version;
-
 				error = filldir(dirent, de->name,
 						de->name_len,
 						filp->f_pos,
diff -Nupr -X linux-2.6.17-git13-Mingming/Documentation/dontdiff linux-2.6.17-git13-Mingming/fs/ext3/namei.c linux-2.6.17-git13-Mingming-reclen/fs/ext3/namei.c
--- linux-2.6.17-git13-Mingming/fs/ext3/namei.c	2006-07-07 17:24:11.000000000 +0900
+++ linux-2.6.17-git13-Mingming-reclen/fs/ext3/namei.c	2006-07-07 17:18:32.000000000 +0900
@@ -262,9 +262,12 @@ static struct stats dx_show_leaf(struct 
 	unsigned names = 0, space = 0;
 	char *base = (char *) de;
 	struct dx_hash_info h = *hinfo;
+	unsigned tail = size;
 
 	printk("names: ");
-	while ((char *) de < base + size)
+	if (tail >  EXT3_DIR_MAX_REC_LEN)
+		tail = EXT3_DIR_MAX_REC_LEN;
+	while ((char *) de < base + tail)
 	{
 		if (de->inode)
 		{
@@ -668,8 +671,11 @@ static int dx_make_map (struct ext3_dir_
 	int count = 0;
 	char *base = (char *) de;
 	struct dx_hash_info h = *hinfo;
+	unsigned tail = size;
 
-	while ((char *) de < base + size)
+	if (tail > EXT3_DIR_MAX_REC_LEN)
+		tail = EXT3_DIR_MAX_REC_LEN;
+	while ((char *) de < base + tail)
 	{
 		if (de->name_len && de->inode) {
 			ext3fs_dirhash(de->name, de->name_len, &h);
@@ -766,9 +772,12 @@ static inline int search_dirblock(struct
 	int de_len;
 	const char *name = dentry->d_name.name;
 	int namelen = dentry->d_name.len;
+	unsigned tail = dir->i_sb->s_blocksize;
 
 	de = (struct ext3_dir_entry_2 *) bh->b_data;
-	dlimit = bh->b_data + dir->i_sb->s_blocksize;
+	if (tail > EXT3_DIR_MAX_REC_LEN)
+		tail = EXT3_DIR_MAX_REC_LEN;
+	dlimit = bh->b_data + tail;
 	while ((char *) de < dlimit) {
 		/* this code is executed quadratically often */
 		/* do minimal checking `by hand' */
@@ -1154,8 +1163,15 @@ static struct ext3_dir_entry_2 *do_split
 	/* Fancy dance to stay within two buffers */
 	de2 = dx_move_dirents(data1, data2, map + split, count - split);
 	de = dx_pack_dirents(data1,blocksize);
-	de->rec_len = cpu_to_le16(data1 + blocksize - (char *) de);
-	de2->rec_len = cpu_to_le16(data2 + blocksize - (char *) de2);
+	if (blocksize < EXT3_DIR_MAX_REC_LEN) {
+		de->rec_len = cpu_to_le16(data1 + blocksize - (char *) de);
+		de2->rec_len = cpu_to_le16(data2 + blocksize - (char *) de2);
+	} else {
+		de->rec_len = cpu_to_le16(data1 + EXT3_DIR_MAX_REC_LEN -
+							(char *) de);
+		de2->rec_len = cpu_to_le16(data2 + EXT3_DIR_MAX_REC_LEN -
+							(char *) de2);
+	}
 	dxtrace(dx_show_leaf (hinfo, (struct ext3_dir_entry_2 *) data1, blocksize, 1));
 	dxtrace(dx_show_leaf (hinfo, (struct ext3_dir_entry_2 *) data2, blocksize, 1));
 
@@ -1202,11 +1218,14 @@ static int add_dirent_to_buf(handle_t *h
 	unsigned short	reclen;
 	int		nlen, rlen, err;
 	char		*top;
+	unsigned	tail = dir->i_sb->s_blocksize;
 
+	if (tail > EXT3_DIR_MAX_REC_LEN)
+		tail = EXT3_DIR_MAX_REC_LEN;
 	reclen = EXT3_DIR_REC_LEN(namelen);
 	if (!de) {
 		de = (struct ext3_dir_entry_2 *)bh->b_data;
-		top = bh->b_data + dir->i_sb->s_blocksize - reclen;
+		top = bh->b_data + tail - reclen;
 		while ((char *) de <= top) {
 			if (!ext3_check_dir_entry("ext3_add_entry", dir, de,
 						  bh, offset)) {
@@ -1480,7 +1499,12 @@ static int ext3_dx_add_entry(handle_t *h
 			goto cleanup;
 		node2 = (struct dx_node *)(bh2->b_data);
 		entries2 = node2->entries;
-		node2->fake.rec_len = cpu_to_le16(sb->s_blocksize);
+		if (sb->s_blocksize < EXT3_MAX_BLOCK_SIZE) {
+			node2->fake.rec_len = cpu_to_le16(sb->s_blocksize);
+		} else {
+			node2->fake.rec_len = 
+					cpu_to_le16(EXT3_DIR_MAX_REC_LEN);
+		}
 		node2->fake.inode = 0;
 		BUFFER_TRACE(frame->bh, "get_write_access");
 		err = ext3_journal_get_write_access(handle, frame->bh);
@@ -1568,11 +1592,14 @@ static int ext3_delete_entry (handle_t *
 {
 	struct ext3_dir_entry_2 * de, * pde;
 	int i;
+	unsigned tail = bh->b_size;
 
 	i = 0;
 	pde = NULL;
 	de = (struct ext3_dir_entry_2 *) bh->b_data;
-	while (i < bh->b_size) {
+	if (tail > EXT3_DIR_MAX_REC_LEN)
+		tail = EXT3_DIR_MAX_REC_LEN;
+	while (i < tail) {
 		if (!ext3_check_dir_entry("ext3_delete_entry", dir, de, bh, i))
 			return -EIO;
 		if (de == de_del)  {
@@ -1782,10 +1809,10 @@ static int empty_dir (struct inode * ino
 	unsigned long offset;
 	struct buffer_head * bh;
 	struct ext3_dir_entry_2 * de, * de1;
-	struct super_block * sb;
+	struct super_block * sb = inode->i_sb;
 	int err = 0;
+	unsigned tail = sb->s_blocksize;
 
-	sb = inode->i_sb;
 	if (inode->i_size < EXT3_DIR_REC_LEN(1) + EXT3_DIR_REC_LEN(2) ||
 	    !(bh = ext3_bread (NULL, inode, 0, 0, &err))) {
 		if (err)
@@ -1814,9 +1841,11 @@ static int empty_dir (struct inode * ino
 	offset = le16_to_cpu(de->rec_len) + le16_to_cpu(de1->rec_len);
 	de = (struct ext3_dir_entry_2 *)
 			((char *) de1 + le16_to_cpu(de1->rec_len));
+	if (tail > EXT3_DIR_MAX_REC_LEN)
+		tail = EXT3_DIR_MAX_REC_LEN;
 	while (offset < inode->i_size ) {
 		if (!bh ||
-			(void *) de >= (void *) (bh->b_data+sb->s_blocksize)) {
+			(void *) de >= (void *) (bh->b_data + tail)) {
 			err = 0;
 			brelse (bh);
 			bh = ext3_bread (NULL, inode,
diff -Nupr -X linux-2.6.17-git13-Mingming/Documentation/dontdiff linux-2.6.17-git13-Mingming/include/linux/ext3_fs.h linux-2.6.17-git13-Mingming-reclen/include/linux/ext3_fs.h
--- linux-2.6.17-git13-Mingming/include/linux/ext3_fs.h	2006-07-07 17:26:57.000000000 +0900
+++ linux-2.6.17-git13-Mingming-reclen/include/linux/ext3_fs.h	2006-07-07 14:43:34.000000000 +0900
@@ -81,8 +81,8 @@
  * Macro-instructions used to manage several block sizes
  */
 #define EXT3_MIN_BLOCK_SIZE		1024
-#define	EXT3_MAX_BLOCK_SIZE		4096
-#define EXT3_MIN_BLOCK_LOG_SIZE		  10
+#define	EXT3_MAX_BLOCK_SIZE		65536
+#define EXT3_MIN_BLOCK_LOG_SIZE		10
 #ifdef __KERNEL__
 # define EXT3_BLOCK_SIZE(s)		((s)->s_blocksize)
 #else
@@ -727,6 +727,7 @@ struct ext3_dir_entry_2 {
 #define EXT3_DIR_ROUND			(EXT3_DIR_PAD - 1)
 #define EXT3_DIR_REC_LEN(name_len)	(((name_len) + 8 + EXT3_DIR_ROUND) & \
 					 ~EXT3_DIR_ROUND)
+#define EXT3_DIR_MAX_REC_LEN		65532
 /*
  * Hash Tree Directory indexing
  * (c) Daniel Phillips, 2001


Cheers sho

