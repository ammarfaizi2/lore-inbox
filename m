Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265306AbUFBBHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265306AbUFBBHz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 21:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265293AbUFBBHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 21:07:55 -0400
Received: from cmlapp16.siteprotect.com ([64.41.126.229]:12751 "EHLO
	cmlapp16.siteprotect.com") by vger.kernel.org with ESMTP
	id S265306AbUFBBGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 21:06:42 -0400
Message-ID: <40BD2841.2050509@serice.net>
Date: Tue, 01 Jun 2004 20:07:13 -0500
From: Paul Serice <paul@serice.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040127
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] iso9660 Inodes Anywhere and NFS
Content-Type: multipart/mixed;
 boundary="------------020503010208080108060702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020503010208080108060702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is my fourth attempt to patch the isofs code.  It is similar to
the last posting except this one implements the NFS get_parent()
method which has always been missing.

The original problem I set out to addresses is that the current
iso9660 file system cannot reach inodes located beyond the 4GB
barrier.  This is caused by using the inode number as the byte offset
of the inode data.  Being 32-bits wide, the inode number is unable to
reach inode data that does not reside on the first 4GB of the file
system.

This causes real problems with "growisofs"

     http://fy.chalmers.se/~appro/linux/DVD+RW/#isofs4gb

and my pet project "shunt"

     http://www.serice.net/shunt/

This patch switches the isofs code from iget() to iget5_locked() which
allows extra data to be passed into isofs_read_inode() so that inode
data anywhere on the disk can be reached.

The inode number scheme was also changed.  Continuing to use the byte
offset would have resulted in non-unique inodes in many common
situations, but because the inode number no longer plays any role in
reading the meta-data off the disk, I was free to set the inode number
to some unique characteristic of the file.  I have chosen to use the
block offset which is also 32-bits wide.

Lastly, the pre-patch code uses the default export_operations to
handle accessing the file system through NFS.  The problem with this
is that the default NFS operations assume that iget() works which is
no longer the case because of the necessity of switching to
iget5_locked().  So, I had to implement the NFS operations too.  As a
bonus, I went ahead and implemented the NFS get_parent() method which
has always been missing.

Thanks,
Paul Serice

--------------020503010208080108060702
Content-Type: text/plain;
 name="linux-2.6.7-rc2-isofs.3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.7-rc2-isofs.3.patch"

diff -uprN -X dontdiff linux-2.6.7-rc2/fs/isofs/Makefile linux-2.6.7-rc2-isofs.3/fs/isofs/Makefile
--- linux-2.6.7-rc2/fs/isofs/Makefile	2004-04-03 21:38:26.000000000 -0600
+++ linux-2.6.7-rc2-isofs.3/fs/isofs/Makefile	2004-05-31 05:52:45.000000000 -0500
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_ISO9660_FS) += isofs.o
 
-isofs-objs-y 			:= namei.o inode.o dir.o util.o rock.o
+isofs-objs-y 			:= namei.o inode.o dir.o util.o rock.o export.o
 isofs-objs-$(CONFIG_JOLIET)	+= joliet.o
 isofs-objs-$(CONFIG_ZISOFS)	+= compress.o
 isofs-objs			:= $(isofs-objs-y)
diff -uprN -X dontdiff linux-2.6.7-rc2/fs/isofs/dir.c linux-2.6.7-rc2-isofs.3/fs/isofs/dir.c
--- linux-2.6.7-rc2/fs/isofs/dir.c	2004-04-03 21:37:59.000000000 -0600
+++ linux-2.6.7-rc2-isofs.3/fs/isofs/dir.c	2004-05-31 05:49:43.000000000 -0500
@@ -106,8 +106,8 @@ static int do_isofs_readdir(struct inode
 {
 	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
 	unsigned char bufbits = ISOFS_BUFFER_BITS(inode);
-	unsigned int block, offset;
-	int inode_number = 0;	/* Quiet GCC */
+	unsigned long block, offset;
+	unsigned long inode_number = 0;	/* Quiet GCC */
 	struct buffer_head *bh = NULL;
 	int len;
 	int map;
@@ -130,7 +130,7 @@ static int do_isofs_readdir(struct inode
 
 		de = (struct iso_directory_record *) (bh->b_data + offset);
 		if (first_de)
-			inode_number = (bh->b_blocknr << bufbits) + offset;
+			inode_number = isofs_get_ino(de);
 
 		de_len = *(unsigned char *) de;
 
diff -uprN -X dontdiff linux-2.6.7-rc2/fs/isofs/export.c linux-2.6.7-rc2-isofs.3/fs/isofs/export.c
--- linux-2.6.7-rc2/fs/isofs/export.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.7-rc2-isofs.3/fs/isofs/export.c	2004-06-01 15:42:51.000000000 -0500
@@ -0,0 +1,231 @@
+/*
+ * fs/isofs/export.c
+ *
+ *  (C) 2004  Paul Serice - The new inode scheme requires switching
+ *                          from iget() to iget5_locked() which means
+ *                          the NFS export operations have to be hand
+ *                          coded because the default routines rely on
+ *                          iget().
+ *
+ * The following files are helpful:
+ *
+ *     Documentation/filesystems/Exporting
+ *     fs/exportfs/expfs.c.
+ */
+
+#include <linux/buffer_head.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/iso_fs.h>
+#include <linux/kernel.h>
+
+static struct dentry *
+isofs_export_iget(struct super_block *sb,
+		  unsigned long block,
+		  unsigned long offset,
+		  __u32 generation)
+{
+	struct inode *inode;
+	struct dentry *result;
+	if (block == 0)
+		return ERR_PTR(-ESTALE);
+	inode = isofs_iget(sb, block, offset);
+	if (inode == NULL)
+		return ERR_PTR(-ENOMEM);
+	if (is_bad_inode(inode)
+	    || (generation && inode->i_generation != generation))
+	{
+		iput(inode);
+		return ERR_PTR(-ESTALE);
+	}
+	result = d_alloc_anon(inode);
+	if (!result) {
+		iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
+	return result;
+}
+
+static struct dentry *
+isofs_export_get_dentry(struct super_block *sb, void *vobjp)
+{
+	__u32 *objp = vobjp;
+	unsigned long block = objp[0];
+	unsigned long offset = objp[1];
+	__u32 generation = objp[2];
+	return isofs_export_iget(sb, block, offset, generation);
+}
+
+/* This function is surprisingly simple.  The trick is understanding
+ * that "child" is always a directory. So, to find its parent, you
+ * simply need to find its ".." entry, normalize its block and offset,
+ * and return the underlying inode.  See the comments for
+ * isofs_normalize_block_and_offset(). */
+static struct dentry *isofs_export_get_parent(struct dentry *child)
+{
+	unsigned long parent_block = 0;
+	unsigned long parent_offset = 0;
+	struct inode *child_inode = child->d_inode;
+	struct iso_inode_info *e_child_inode = ISOFS_I(child_inode);
+	struct inode *parent_inode = NULL;
+	struct iso_directory_record *de = NULL;
+	struct buffer_head * bh = NULL;
+	struct dentry *rv = NULL;
+
+	/* "child" must always be a directory. */
+	if (!S_ISDIR(child_inode->i_mode)) {
+		printk(KERN_ERR "isofs: isofs_export_get_parent(): "
+		       "child is not a directory!\n");
+		rv = ERR_PTR(-EACCES);
+		goto out;
+	}
+
+	/* It is an invariant that the directory offset is zero.  If
+	 * it is not zero, it means the directory failed to be
+	 * normalized for some reason. */
+	if (e_child_inode->i_iget5_offset != 0) {
+		printk(KERN_ERR "isofs: isofs_export_get_parent(): "
+		       "child directory not normalized!\n");
+		rv = ERR_PTR(-EACCES);
+		goto out;
+	}
+
+	/* The child inode has been normalized such that its
+	 * i_iget5_block value points to the "." entry.  Fortunately,
+	 * the ".." entry is located in the same block. */
+	parent_block = e_child_inode->i_iget5_block;
+
+	/* Get the block in question. */
+	bh = sb_bread(child_inode->i_sb, parent_block);
+	if (bh == NULL) {
+		rv = ERR_PTR(-EACCES);
+		goto out;
+	}
+
+	/* This is the "." entry. */
+	de = (struct iso_directory_record*)bh->b_data;
+
+	/* The ".." entry is always the second entry. */
+	parent_offset = (unsigned long)isonum_711(de->length);
+	de = (struct iso_directory_record*)(bh->b_data + parent_offset);
+
+	/* Verify it is in fact the ".." entry. */
+	if ((isonum_711(de->name_len) != 1) || (de->name[0] != 1)) {
+		printk(KERN_ERR "isofs: Unable to find the \"..\" "
+		       "directory for NFS.\n");
+		rv = ERR_PTR(-EACCES);
+		goto out;
+	}
+
+	/* Normalize */
+	isofs_normalize_block_and_offset(de, &parent_block, &parent_offset);
+
+	/* Get the inode. */
+	parent_inode = isofs_iget(child_inode->i_sb,
+				  parent_block,
+				  parent_offset);
+	if (parent_inode == NULL) {
+		rv = ERR_PTR(-EACCES);
+		goto out;
+	}
+
+	/* Allocate the dentry. */
+	rv = d_alloc_anon(parent_inode);
+	if (rv == NULL) {
+		rv = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+ out:
+	if (bh) {
+		brelse(bh);
+	}
+	return rv;
+}
+
+static int
+isofs_export_encode_fh(struct dentry *dentry,
+		       __u32 *fh32,
+		       int *max_len,
+		       int connectable)
+{
+	struct inode * inode = dentry->d_inode;
+	struct iso_inode_info * ei = ISOFS_I(inode);
+	int len = *max_len;
+	int type = 1;
+	__u16 *fh16 = (__u16*)fh32;
+
+	/* 
+	 * WARNING: max_len is 5 for NFSv2.  Because of this
+	 * limitation, we use the lower 16 bits of fh32[1] to hold the
+	 * offset of the inode and the upper 16 bits of fh32[1] to
+	 * hold the offset of the parent.
+	 */
+
+	if (len < 3 || (connectable && len < 5))
+		return 255;
+
+	len = 3;
+	fh32[0] = ei->i_iget5_block;
+ 	fh16[2] = (__u16)ei->i_iget5_offset;  /* fh16 [sic] */
+	fh32[2] = inode->i_generation;
+	if (connectable && !S_ISDIR(inode->i_mode)) {
+		struct inode *parent;
+		struct iso_inode_info *eparent;
+		spin_lock(&dentry->d_lock);
+		parent = dentry->d_parent->d_inode;
+		eparent = ISOFS_I(parent);
+		fh32[3] = eparent->i_iget5_block;
+		fh16[3] = (__u16)eparent->i_iget5_offset;  /* fh16 [sic] */
+		fh32[4] = parent->i_generation;
+		spin_unlock(&dentry->d_lock);
+		len = 5;
+		type = 2;
+	}
+	*max_len = len;
+	return type;
+}
+
+
+static struct dentry *
+isofs_export_decode_fh(struct super_block *sb,
+		       __u32 *fh32,
+		       int fh_len,
+		       int fileid_type,
+		       int (*acceptable)(void *context, struct dentry *de),
+		       void *context)
+{
+	__u16 *fh16 = (__u16*)fh32;
+	__u32 child[3];   /* The child is what triggered all this. */
+	__u32 parent[3];  /* The parent is just along for the ride. */
+
+	if (fh_len < 3 || fileid_type > 2)
+		return NULL;
+
+	child[0] = fh32[0];
+	child[1] = fh16[2];  /* fh16 [sic] */
+	child[2] = fh32[2];
+	
+	parent[0] = 0;
+	parent[1] = 0;
+	parent[2] = 0;
+	if (fileid_type == 2) {
+		if (fh_len > 2) parent[0] = fh32[3];
+		parent[1] = fh16[3];  /* fh16 [sic] */
+		if (fh_len > 4) parent[2] = fh32[4];
+	}
+
+	return sb->s_export_op->find_exported_dentry(sb, child, parent,
+						     acceptable, context);
+}
+
+
+/* The .get_parent method should be added, but .get_parent has never
+ * been implemented in the isofs code.  So, its absence will not be
+ * sorely missed. */
+struct export_operations isofs_export_ops = {
+	.decode_fh	= isofs_export_decode_fh,
+	.encode_fh	= isofs_export_encode_fh,
+	.get_dentry	= isofs_export_get_dentry,
+	.get_parent     = isofs_export_get_parent,
+};
diff -uprN -X dontdiff linux-2.6.7-rc2/fs/isofs/inode.c linux-2.6.7-rc2-isofs.3/fs/isofs/inode.c
--- linux-2.6.7-rc2/fs/isofs/inode.c	2004-05-31 03:53:07.000000000 -0500
+++ linux-2.6.7-rc2-isofs.3/fs/isofs/inode.c	2004-06-01 16:39:10.000000000 -0500
@@ -7,6 +7,8 @@
  *      1995  Mark Dobie - allow mounting of some weird VideoCDs and PhotoCDs.
  *	1997  Gordon Chaffee - Joliet CDs
  *	1998  Eric Lammerts - ISO 9660 Level 3
+ *	2004  Paul Serice - Comprehensive Inode Scheme
+ *	2004  Paul Serice - NFS Export Operations
  */
 
 #include <linux/config.h>
@@ -135,20 +137,6 @@ static struct super_operations isofs_sop
 	.remount_fs	= isofs_remount,
 };
 
-/* the export_operations structure for describing
- * how to export (e.g. via kNFSd) is deliberately
- * empty.
- * This means that the filesystem want to use iget
- * to map an inode number into an inode.
- * The lack of a get_parent operation means that 
- * if something isn't in the cache, then you cannot
- * access it.
- * It should be possible to write a get_parent,
- * but it would be a bit hairy...
- */
-static struct export_operations isofs_export_ops = {
-};
-
 
 static struct dentry_operations isofs_dentry_ops[] = {
 	{
@@ -740,17 +728,14 @@ root_found:
 	   
 	/* RDE: data zone now byte offset! */
 
-	first_data_zone = ((isonum_733 (rootp->extent) +
-			  isonum_711 (rootp->ext_attr_length))
-			 << sbi->s_log_zone_size);
+	first_data_zone = isonum_733 (rootp->extent) +
+			  isonum_711 (rootp->ext_attr_length);
 	sbi->s_firstdatazone = first_data_zone;
 #ifndef BEQUIET
 	printk(KERN_DEBUG "Max size:%ld   Log zone size:%ld\n",
 	       sbi->s_max_size,
 	       1UL << sbi->s_log_zone_size);
-	printk(KERN_DEBUG "First datazone:%ld   Root inode number:%ld\n",
-	       sbi->s_firstdatazone >> sbi->s_log_zone_size,
-	       sbi->s_firstdatazone);
+	printk(KERN_DEBUG "First datazone:%ld\n", sbi->s_firstdatazone);
 	if(sbi->s_high_sierra)
 		printk(KERN_DEBUG "Disc in High Sierra format.\n");
 #endif
@@ -767,9 +752,8 @@ root_found:
 		pri = (struct iso_primary_descriptor *) sec;
 		rootp = (struct iso_directory_record *)
 			pri->root_directory_record;
-		first_data_zone = ((isonum_733 (rootp->extent) +
-			  	isonum_711 (rootp->ext_attr_length))
-				 << sbi->s_log_zone_size);
+		first_data_zone = isonum_733 (rootp->extent) +
+			  	isonum_711 (rootp->ext_attr_length);
 	}
 
 	/*
@@ -835,7 +819,7 @@ root_found:
 	 * the s_rock flag. Once we have the final s_rock value,
 	 * we then decide whether to use the Joliet descriptor.
 	 */
-	inode = iget(s, sbi->s_firstdatazone);
+	inode = isofs_iget(s, sbi->s_firstdatazone, 0);
 
 	/*
 	 * If this disk has both Rock Ridge and Joliet on it, then we
@@ -854,7 +838,7 @@ root_found:
 			printk(KERN_DEBUG 
 				"ISOFS: changing to secondary root\n");
 			iput(inode);
-			inode = iget(s, sbi->s_firstdatazone);
+			inode = isofs_iget(s, sbi->s_firstdatazone, 0);
 		}
 	}
 
@@ -952,7 +936,7 @@ int isofs_get_blocks(struct inode *inode
 	unsigned long b_off;
 	unsigned offset, sect_size;
 	unsigned int firstext;
-	unsigned long nextino;
+	unsigned long nextblk, nextoff;
 	long iblock = (long)iblock_s;
 	int section, rv;
 	struct iso_inode_info *ei = ISOFS_I(inode);
@@ -970,7 +954,8 @@ int isofs_get_blocks(struct inode *inode
 	offset    = 0;
 	firstext  = ei->i_first_extent;
 	sect_size = ei->i_section_size >> ISOFS_BUFFER_BITS(inode);
-	nextino   = ei->i_next_section_ino;
+	nextblk   = ei->i_next_section_block;
+	nextoff   = ei->i_next_section_offset;
 	section   = 0;
 
 	while ( nblocks ) {
@@ -987,25 +972,28 @@ int isofs_get_blocks(struct inode *inode
 			goto abort;
 		}
 		
-		if (nextino) {
+		if (nextblk) {
 			while (b_off >= (offset + sect_size)) {
 				struct inode *ninode;
 				
 				offset += sect_size;
-				if (nextino == 0)
+				if (nextblk == 0)
 					goto abort;
-				ninode = iget(inode->i_sb, nextino);
+				ninode = isofs_iget(inode->i_sb, nextblk, nextoff);
 				if (!ninode)
 					goto abort;
 				firstext  = ISOFS_I(ninode)->i_first_extent;
-				sect_size = ISOFS_I(ninode)->i_section_size;
-				nextino   = ISOFS_I(ninode)->i_next_section_ino;
+				sect_size = ISOFS_I(ninode)->i_section_size >> ISOFS_BUFFER_BITS(ninode);
+				nextblk   = ISOFS_I(ninode)->i_next_section_block;
+				nextoff   = ISOFS_I(ninode)->i_next_section_offset;
 				iput(ninode);
 				
 				if (++section > 100) {
 					printk("isofs_get_blocks: More than 100 file sections ?!?, aborting...\n");
-					printk("isofs_get_blocks: ino=%lu block=%ld firstext=%u sect_size=%u nextino=%lu\n",
-					       inode->i_ino, iblock, firstext, (unsigned) sect_size, nextino);
+					printk("isofs_get_blocks: block=%ld firstext=%u sect_size=%u "
+					       "nextblk=%lu nextoff=%lu\n",
+					       iblock, firstext, (unsigned) sect_size,
+					       nextblk, nextoff);
 					goto abort;
 				}
 			}
@@ -1044,7 +1032,7 @@ static int isofs_get_block(struct inode 
 	return isofs_get_blocks(inode, iblock, &bh_result, 1) ? 0 : -EIO;
 }
 
-static int isofs_bmap(struct inode *inode, int block)
+static int isofs_bmap(struct inode *inode, sector_t block)
 {
 	struct buffer_head dummy;
 	int error;
@@ -1097,21 +1085,25 @@ static inline void test_and_set_gid(gid_
 
 static int isofs_read_level3_size(struct inode * inode)
 {
-	unsigned long f_pos = inode->i_ino;
 	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
 	int high_sierra = ISOFS_SB(inode->i_sb)->s_high_sierra;
 	struct buffer_head * bh = NULL;
-	unsigned long block, offset;
+	unsigned long block, offset, block_saved, offset_saved;
 	int i = 0;
 	int more_entries = 0;
 	struct iso_directory_record * tmpde = NULL;
 	struct iso_inode_info *ei = ISOFS_I(inode);
 
 	inode->i_size = 0;
-	ei->i_next_section_ino = 0;
 
-	block = f_pos >> ISOFS_BUFFER_BITS(inode);
-	offset = f_pos & (bufsize-1);
+	/* The first 16 blocks are reserved as the System Area.  Thus,
+	 * no inodes can appear in block 0.  We use this to flag that
+	 * this is the last section. */
+	ei->i_next_section_block = 0;
+	ei->i_next_section_offset = 0;
+
+	block = ei->i_iget5_block;
+	offset = ei->i_iget5_offset;
 
 	do {
 		struct iso_directory_record * de;
@@ -1128,12 +1120,13 @@ static int isofs_read_level3_size(struct
 		if (de_len == 0) {
 			brelse(bh);
 			bh = NULL;
-			f_pos = (f_pos + ISOFS_BLOCK_SIZE) & ~(ISOFS_BLOCK_SIZE - 1);
-			block = f_pos >> ISOFS_BUFFER_BITS(inode);
+			++block;
 			offset = 0;
 			continue;
 		}
 
+		block_saved = block;
+		offset_saved = offset;
 		offset += de_len;
 
 		/* Make sure we have a full directory entry */
@@ -1159,12 +1152,13 @@ static int isofs_read_level3_size(struct
 		}
 
 		inode->i_size += isonum_733(de->size);
-		if (i == 1)
-			ei->i_next_section_ino = f_pos;
+		if (i == 1) {
+			ei->i_next_section_block = block_saved;
+			ei->i_next_section_offset = offset_saved;			
+		}
 
 		more_entries = de->flags[-high_sierra] & 0x80;
 
-		f_pos += de_len;
 		i++;
 		if(i > 100)
 			goto out_toomany;
@@ -1190,8 +1184,8 @@ out_noread:
 out_toomany:
 	printk(KERN_INFO "isofs_read_level3_size: "
 		"More than 100 file sections ?!?, aborting...\n"
-	  	"isofs_read_level3_size: inode=%lu ino=%lu\n",
-		inode->i_ino, f_pos);
+	  	"isofs_read_level3_size: inode=%lu\n",
+		inode->i_ino);
 	goto out;
 }
 
@@ -1200,7 +1194,7 @@ static void isofs_read_inode(struct inod
 	struct super_block *sb = inode->i_sb;
 	struct isofs_sb_info *sbi = ISOFS_SB(sb);
 	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
-	int block = inode->i_ino >> ISOFS_BUFFER_BITS(inode);
+	unsigned long block;
 	int high_sierra = sbi->s_high_sierra;
 	struct buffer_head * bh = NULL;
 	struct iso_directory_record * de;
@@ -1210,11 +1204,13 @@ static void isofs_read_inode(struct inod
 	int i;
 	struct iso_inode_info *ei = ISOFS_I(inode);
 
+	block = ei->i_iget5_block;
 	bh = sb_bread(inode->i_sb, block);
 	if (!bh)
 		goto out_badread;
 
-	offset = (inode->i_ino & (bufsize - 1));
+	offset = ei->i_iget5_offset;
+
 	de = (struct iso_directory_record *) (bh->b_data + offset);
 	de_len = *(unsigned char *) de;
 
@@ -1235,6 +1231,8 @@ static void isofs_read_inode(struct inod
 		de = tmpde;
 	}
 
+	inode->i_ino = isofs_get_ino(de);
+
 	/* Assume it is a normal-format file unless told otherwise */
 	ei->i_file_format = isofs_file_normal;
 
@@ -1271,7 +1269,8 @@ static void isofs_read_inode(struct inod
 	if(de->flags[-high_sierra] & 0x80) {
 		if(isofs_read_level3_size(inode)) goto fail;
 	} else {
-		ei->i_next_section_ino = 0;
+		ei->i_next_section_block = 0;
+		ei->i_next_section_offset = 0;
 		inode->i_size = isonum_733 (de->size);
 	}
 
@@ -1385,6 +1384,61 @@ static void isofs_read_inode(struct inod
 	goto out;
 }
 
+struct isofs_iget5_callback_data {
+	unsigned long block;
+	unsigned long offset;
+};
+
+static int isofs_iget5_test(struct inode *ino, void *data)
+{
+	struct iso_inode_info *i = ISOFS_I(ino);
+	struct isofs_iget5_callback_data *d =
+		(struct isofs_iget5_callback_data*)data;
+	return (i->i_iget5_block == d->block)
+	       && (i->i_iget5_offset == d->offset);
+}
+
+static int isofs_iget5_set(struct inode *ino, void *data)
+{
+	struct iso_inode_info *i = ISOFS_I(ino);
+	struct isofs_iget5_callback_data *d =
+		(struct isofs_iget5_callback_data*)data;
+	i->i_iget5_block = d->block;
+	i->i_iget5_offset = d->offset;
+	return 0;
+}
+
+/* Store, in the inode's containing structure, the block and block
+ * offset that point to the underlying meta-data for the inode.  The
+ * code below is otherwise similar to the iget() code in
+ * include/linux/fs.h */
+struct inode *isofs_iget(struct super_block *sb,
+			 unsigned long block,
+			 unsigned long offset)
+{
+	unsigned long hashval;
+	struct inode *inode;
+	struct isofs_iget5_callback_data data;
+
+	data.block = block;
+	data.offset = offset;
+
+	hashval = (block << sb->s_blocksize_bits) | offset;
+
+	inode = iget5_locked(sb,
+			     hashval,
+			     &isofs_iget5_test,
+			     &isofs_iget5_set,
+			     &data);
+	
+	if (inode && (inode->i_state & I_NEW)) {
+		sb->s_op->read_inode(inode);
+		unlock_new_inode(inode);
+	}
+
+	return inode;
+}
+
 #ifdef LEAK_CHECK
 #undef malloc
 #undef free_s
diff -uprN -X dontdiff linux-2.6.7-rc2/fs/isofs/namei.c linux-2.6.7-rc2-isofs.3/fs/isofs/namei.c
--- linux-2.6.7-rc2/fs/isofs/namei.c	2004-04-03 21:37:38.000000000 -0600
+++ linux-2.6.7-rc2-isofs.3/fs/isofs/namei.c	2004-06-01 13:08:10.000000000 -0500
@@ -17,6 +17,7 @@
 #include <linux/config.h>	/* Joliet? */
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
+#include <linux/dcache.h>
 
 #include <asm/uaccess.h>
 
@@ -59,12 +60,12 @@ isofs_cmp(struct dentry * dentry, const 
  */
 static unsigned long
 isofs_find_entry(struct inode *dir, struct dentry *dentry,
+	unsigned long *block_rv, unsigned long* offset_rv,
 	char * tmpname, struct iso_directory_record * tmpde)
 {
-	unsigned long inode_number;
 	unsigned long bufsize = ISOFS_BUFFER_SIZE(dir);
 	unsigned char bufbits = ISOFS_BUFFER_BITS(dir);
-	unsigned int block, f_pos, offset;
+	unsigned long block, f_pos, offset, block_saved, offset_saved;
 	struct buffer_head * bh = NULL;
 	struct isofs_sb_info *sbi = ISOFS_SB(dir->i_sb);
 
@@ -87,7 +88,6 @@ isofs_find_entry(struct inode *dir, stru
 		}
 
 		de = (struct iso_directory_record *) (bh->b_data + offset);
-		inode_number = (bh->b_blocknr << bufbits) + offset;
 
 		de_len = *(unsigned char *) de;
 		if (!de_len) {
@@ -99,6 +99,8 @@ isofs_find_entry(struct inode *dir, stru
 			continue;
 		}
 
+		block_saved = bh->b_blocknr;
+		offset_saved = offset;
 		offset += de_len;
 		f_pos += de_len;
 
@@ -150,8 +152,13 @@ isofs_find_entry(struct inode *dir, stru
 			match = (isofs_cmp(dentry,dpnt,dlen) == 0);
 		}
 		if (match) {
+			isofs_normalize_block_and_offset(de,
+							 &block_saved,
+							 &offset_saved);
+                        *block_rv = block_saved;
+                        *offset_rv = offset_saved;
 			if (bh) brelse(bh);
-			return inode_number;
+			return 1;
 		}
 	}
 	if (bh) brelse(bh);
@@ -160,7 +167,8 @@ isofs_find_entry(struct inode *dir, stru
 
 struct dentry *isofs_lookup(struct inode * dir, struct dentry * dentry, struct nameidata *nd)
 {
-	unsigned long ino;
+	int found;
+	unsigned long block, offset;
 	struct inode *inode;
 	struct page *page;
 
@@ -171,19 +179,23 @@ struct dentry *isofs_lookup(struct inode
 		return ERR_PTR(-ENOMEM);
 
 	lock_kernel();
-	ino = isofs_find_entry(dir, dentry, page_address(page),
-			       1024 + page_address(page));
+	found = isofs_find_entry(dir, dentry,
+				 &block, &offset,
+				 page_address(page),
+				 1024 + page_address(page));
 	__free_page(page);
 
 	inode = NULL;
-	if (ino) {
-		inode = iget(dir->i_sb, ino);
+	if (found) {
+		inode = isofs_iget(dir->i_sb, block, offset);
 		if (!inode) {
 			unlock_kernel();
 			return ERR_PTR(-EACCES);
 		}
 	}
 	unlock_kernel();
+	if (inode)
+		return d_splice_alias(inode, dentry);
 	d_add(dentry, inode);
 	return NULL;
 }
diff -uprN -X dontdiff linux-2.6.7-rc2/fs/isofs/rock.c linux-2.6.7-rc2-isofs.3/fs/isofs/rock.c
--- linux-2.6.7-rc2/fs/isofs/rock.c	2004-05-31 03:38:20.000000000 -0500
+++ linux-2.6.7-rc2-isofs.3/fs/isofs/rock.c	2004-06-01 07:48:46.000000000 -0500
@@ -306,9 +306,7 @@ int parse_rock_ridge_inode_internal(stru
 	goto out;
       case SIG('C','L'):
 	ISOFS_I(inode)->i_first_extent = isonum_733(rr->u.CL.location);
-	reloc = iget(inode->i_sb,
-		     (ISOFS_I(inode)->i_first_extent <<
-		      ISOFS_SB(inode->i_sb)->s_log_zone_size));
+	reloc = isofs_iget(inode->i_sb, ISOFS_I(inode)->i_first_extent, 0);
 	if (!reloc)
 		goto out;
 	inode->i_mode = reloc->i_mode;
@@ -447,15 +445,15 @@ int parse_rock_ridge_inode(struct iso_di
 static int rock_ridge_symlink_readpage(struct file *file, struct page *page)
 {
 	struct inode *inode = page->mapping->host;
+        struct iso_inode_info *ei = ISOFS_I(inode);
 	char *link = kmap(page);
 	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
-	unsigned char bufbits = ISOFS_BUFFER_BITS(inode);
 	struct buffer_head *bh;
 	char *rpnt = link;
 	unsigned char *pnt;
 	struct iso_directory_record *raw_inode;
 	CONTINUE_DECLS;
-	int block;
+	unsigned long block, offset;
 	int sig;
 	int len;
 	unsigned char *chr;
@@ -464,20 +462,21 @@ static int rock_ridge_symlink_readpage(s
 	if (!ISOFS_SB(inode->i_sb)->s_rock)
 		panic ("Cannot have symlink with high sierra variant of iso filesystem\n");
 
-	block = inode->i_ino >> bufbits;
+	block = ei->i_iget5_block;
 	lock_kernel();
 	bh = sb_bread(inode->i_sb, block);
 	if (!bh)
 		goto out_noread;
 
-	pnt = (unsigned char *) bh->b_data + (inode->i_ino & (bufsize - 1));
+        offset = ei->i_iget5_offset;
+	pnt = (unsigned char *) bh->b_data + offset;
 
 	raw_inode = (struct iso_directory_record *) pnt;
 
 	/*
 	 * If we go past the end of the buffer, there is some sort of error.
 	 */
-	if ((inode->i_ino & (bufsize - 1)) + *pnt > bufsize)
+	if (offset + *pnt > bufsize)
 		goto out_bad_span;
 
 	/* Now test for possible Rock Ridge extensions which will override
diff -uprN -X dontdiff linux-2.6.7-rc2/include/linux/iso_fs.h linux-2.6.7-rc2-isofs.3/include/linux/iso_fs.h
--- linux-2.6.7-rc2/include/linux/iso_fs.h	2004-04-03 21:37:24.000000000 -0600
+++ linux-2.6.7-rc2-isofs.3/include/linux/iso_fs.h	2004-06-01 17:02:13.000000000 -0500
@@ -231,9 +231,75 @@ extern struct dentry *isofs_lookup(struc
 extern struct buffer_head *isofs_bread(struct inode *, sector_t);
 extern int isofs_get_blocks(struct inode *, sector_t, struct buffer_head **, unsigned long);
 
+extern struct inode *isofs_iget(struct super_block *sb,
+                                unsigned long block,
+                                unsigned long offset);
+
+/* Because the inode number is no longer relevant to finding the
+ * underlying meta-data for an inode, we are free to choose a more
+ * convenient 32-bit number as the inode number.  Because directories
+ * and files are block aligned (except in a few very unusual cases)
+ * and because blocks are limited to 32-bits, I've chosen the starting
+ * block that holds the file or directory data as the inode number.
+ *
+ * One nice side effect of this is that you can use "ls -i" to get the
+ * inode number which will tell you exactly where you need to start a
+ * hex dump if you want to see the contents of the directory or
+ * file. */
+static inline unsigned long isofs_get_ino(struct iso_directory_record *d)
+{
+	return (unsigned long)isonum_733(d->extent)
+		+ (unsigned long)isonum_711(d->ext_attr_length);
+}
+
+/* Every directory can have many redundant directory entries scattered
+ * throughout the directory tree.  First there is the directory entry
+ * with the name of the directory stored in the parent directory.
+ * Then, there is the "." directory entry stored in the directory
+ * itself.  Finally, there are possibly many ".." directory entries
+ * stored in all the subdirectories.
+ *
+ * In order for the NFS get_parent() method to work and for the
+ * general consistency of the dcache, we need to make sure the
+ * "i_iget5_block" and "i_iget5_offset" all point to exactly one of
+ * the many redundant entries for each directory.  We normalize the
+ * block and offset by always making them point to the "."  directory.
+ *
+ * Notice that we do not use the entry for the directory with the name
+ * that is located in the parent directory.  Even though choosing this
+ * first directory is more natural, it is much easier to find the "."
+ * entry in the NFS get_parent() method because it is implicitly
+ * encoded in the "extent + ext_attr_length" fields of _all_ the
+ * redundant entries for the directory.  Thus, it can always be
+ * reached regardless of which directory entry you have in hand.
+ *
+ * This works because the "." entry is simply the first directory
+ * record when you start reading the file that holds all the directory
+ * records, and this file starts at "extent + ext_attr_length" blocks.
+ * Because the "." entry is always the first entry listed in the
+ * directories file, the normalized "offset" value is always 0.
+ *
+ * You should pass the directory entry in "de".  On return, "block"
+ * and "offset" will hold normalized values.  Only directories are
+ * affected making it safe to call even for non-directory file
+ * types. */
+static void inline
+isofs_normalize_block_and_offset(struct iso_directory_record* de,
+				 unsigned long *block,
+				 unsigned long *offset)
+{
+	/* Only directories are normalized. */
+	if (de->flags[0] & 2) {
+		*offset = 0;
+		*block = (unsigned long)isonum_733(de->extent)
+			+ (unsigned long)isonum_711(de->ext_attr_length);
+	}
+}
+
 extern struct inode_operations isofs_dir_inode_operations;
 extern struct file_operations isofs_dir_operations;
 extern struct address_space_operations isofs_symlink_aops;
+extern struct export_operations isofs_export_ops;
 
 /* The following macros are used to check for memory leaks. */
 #ifdef LEAK_CHECK
diff -uprN -X dontdiff linux-2.6.7-rc2/include/linux/iso_fs_i.h linux-2.6.7-rc2-isofs.3/include/linux/iso_fs_i.h
--- linux-2.6.7-rc2/include/linux/iso_fs_i.h	2004-04-03 21:36:56.000000000 -0600
+++ linux-2.6.7-rc2-isofs.3/include/linux/iso_fs_i.h	2004-06-01 08:48:22.000000000 -0500
@@ -13,10 +13,13 @@ enum isofs_file_format {
  * iso fs inode data in memory
  */
 struct iso_inode_info {
+	unsigned long i_iget5_block;
+	unsigned long i_iget5_offset;
 	unsigned int i_first_extent;
 	unsigned char i_file_format;
 	unsigned char i_format_parm[3];
-	unsigned long i_next_section_ino;
+	unsigned long i_next_section_block;
+	unsigned long i_next_section_offset;
 	off_t i_section_size;
 	struct inode vfs_inode;
 };

--------------020503010208080108060702--
