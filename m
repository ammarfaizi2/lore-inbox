Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264304AbUEXPOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbUEXPOc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 11:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264306AbUEXPOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 11:14:32 -0400
Received: from cmlapp16.siteprotect.com ([64.41.126.229]:36313 "EHLO
	cmlapp16.siteprotect.com") by vger.kernel.org with ESMTP
	id S264304AbUEXPOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 11:14:01 -0400
Message-ID: <40B21139.8000606@serice.net>
Date: Mon, 24 May 2004 10:14:01 -0500
From: Paul Serice <paul@serice.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040127
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] iso9660 inodes Extended to 128GB
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses the problem that the iso9660 file system cannot
reach inode information unless the information is located in the first
4GBs.

This is needed by growisofs to allow it to start additional sessions
in the area after the first 4GBs:

     http://fy.chalmers.se/~appro/linux/DVD+RW/#isofs4gb

It is also needed by my pet project to write arbitrarily large streams
of data to multiple DVDs without the need for intermediate files:

     http://www.serice.net/shunt/

This patch works by incorporating an inode numbering scheme suggested
by Sergey Vlasov.  His scheme frees 5 bits of the inode number so that
they can be used to address the block where the inode information is
located.  After the patch is applied, the inode information can be
located anywhere in the first 128GB of the file system which is enough
to accommodate the current generation of DVDs.

I am currently looking into a final solution that allows the iso9660
file system to be able to address inode information anywhere within
its 32-bit address space, but I'm not sure how long it will take
because I think it might require implementing the export operations.
In the meantime, if this patch passes muster, please consider it as
final.


Thanks,
Paul Serice


diff -uprN -X dontdiff linux-2.6.6/fs/isofs/dir.c linux-2.6.6-isofs.2/fs/isofs/dir.c
--- linux-2.6.6/fs/isofs/dir.c	2004-05-09 21:33:13.000000000 -0500
+++ linux-2.6.6-isofs.2/fs/isofs/dir.c	2004-05-24 09:06:49.795758208 -0500
@@ -106,7 +106,7 @@ static int do_isofs_readdir(struct inode
  {
  	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
  	unsigned char bufbits = ISOFS_BUFFER_BITS(inode);
-	unsigned int block, offset;
+	unsigned long block, offset;
  	int inode_number = 0;	/* Quiet GCC */
  	struct buffer_head *bh = NULL;
  	int len;
@@ -116,8 +116,9 @@ static int do_isofs_readdir(struct inode
  	struct iso_directory_record *de;
  	struct isofs_sb_info *sbi = ISOFS_SB(inode->i_sb);

-	offset = filp->f_pos & (bufsize - 1);
-	block = filp->f_pos >> bufbits;
+	/* ISO 9660 limits file sizes to 32 bits. */
+	offset = (unsigned long)(filp->f_pos & (bufsize - 1));
+	block = (unsigned long)(filp->f_pos >> bufbits);

  	while (filp->f_pos < inode->i_size) {
  		int de_len;
@@ -129,8 +130,15 @@ static int do_isofs_readdir(struct inode
  		}

  		de = (struct iso_directory_record *) (bh->b_data + offset);
-		if (first_de)
-			inode_number = (bh->b_blocknr << bufbits) + offset;
+		if (first_de) {
+			if (bh->b_blocknr > ISOFS_BLOCK_MAX) {
+				printk(KERN_ERR "isofs: dir.c: Attempt to set "
+				       "inode to an unsupported block.\n");
+				break;
+			}
+			inode_number = (bh->b_blocknr << 6)
+				       + isofs_offset_to_nrec(bh, offset);
+		}

  		de_len = *(unsigned char *) de;

diff -uprN -X dontdiff linux-2.6.6/fs/isofs/inode.c linux-2.6.6-isofs.2/fs/isofs/inode.c
--- linux-2.6.6/fs/isofs/inode.c	2004-05-09 21:33:20.000000000 -0500
+++ linux-2.6.6-isofs.2/fs/isofs/inode.c	2004-05-24 12:18:38.956009752 -0500
@@ -7,6 +7,7 @@
   *      1995  Mark Dobie - allow mounting of some weird VideoCDs and PhotoCDs.
   *	1997  Gordon Chaffee - Joliet CDs
   *	1998  Eric Lammerts - ISO 9660 Level 3
+ *	2004  Paul Serice - Inodes up to 128GB
   */

  #include <linux/config.h>
@@ -737,20 +738,37 @@ root_found:

  	/* Set this for reference. Its not currently used except on write
  	   which we don't have .. */
-	
-	/* RDE: data zone now byte offset! */

-	first_data_zone = ((isonum_733 (rootp->extent) +
-			  isonum_711 (rootp->ext_attr_length))
-			 << sbi->s_log_zone_size);
+	/* The inode number is encoded with the lower 6 bits dedicated
+	 * to storing the relative count of the directory record that
+	 * holds the meta-data for this directory entry.  The
+	 * remaining bits hold the block number where the directory
+	 * record can be found.  The relative count of the directory
+	 * record is zero-based.  Thus, the first directory record is
+	 * given a relative count of 0.  The second directory record
+	 * is given a relative count of 1 and so on.
+	 *
+	 * This scheme (suggested by Sergey Vlasov) allows us to
+	 * access meta-data up to the first 128GB in the common case
+	 * where the logical block size is 2048 bytes and an inode
+	 * number is 32 bits.  This is an improvement over the old
+	 * scheme where the meta-data could only live in the first
+	 * 4GB.  This should buy us a number of years. */
+	first_data_zone = isonum_733 (rootp->extent) +
+			  isonum_711 (rootp->ext_attr_length);
  	sbi->s_firstdatazone = first_data_zone;
+	if (first_data_zone > ISOFS_BLOCK_MAX) {
+		printk(KERN_ERR "isofs: inode.c: Attempt to set "
+		       "root inode to an unsupported block.\n");
+		goto out_freebh;
+	}
  #ifndef BEQUIET
  	printk(KERN_DEBUG "Max size:%ld   Log zone size:%ld\n",
  	       sbi->s_max_size,
  	       1UL << sbi->s_log_zone_size);
  	printk(KERN_DEBUG "First datazone:%ld   Root inode number:%ld\n",
-	       sbi->s_firstdatazone >> sbi->s_log_zone_size,
-	       sbi->s_firstdatazone);
+	       sbi->s_firstdatazone,
+	       sbi->s_firstdatazone << 6);
  	if(sbi->s_high_sierra)
  		printk(KERN_DEBUG "Disc in High Sierra format.\n");
  #endif
@@ -767,9 +785,13 @@ root_found:
  		pri = (struct iso_primary_descriptor *) sec;
  		rootp = (struct iso_directory_record *)
  			pri->root_directory_record;
-		first_data_zone = ((isonum_733 (rootp->extent) +
-			  	isonum_711 (rootp->ext_attr_length))
-				 << sbi->s_log_zone_size);
+		first_data_zone = isonum_733 (rootp->extent) +
+				  isonum_711 (rootp->ext_attr_length);
+		if (first_data_zone > ISOFS_BLOCK_MAX) {
+			printk(KERN_ERR "isofs: inode.c: Attempt to set "
+			       "root inode to an unsupported block.\n");
+			goto out_freebh;
+		}
  	}

  	/*
@@ -835,7 +857,7 @@ root_found:
  	 * the s_rock flag. Once we have the final s_rock value,
  	 * we then decide whether to use the Joliet descriptor.
  	 */
-	inode = iget(s, sbi->s_firstdatazone);
+	inode = iget(s, sbi->s_firstdatazone << 6);

  	/*
  	 * If this disk has both Rock Ridge and Joliet on it, then we
@@ -854,7 +876,7 @@ root_found:
  			printk(KERN_DEBUG
  				"ISOFS: changing to secondary root\n");
  			iput(inode);
-			inode = iget(s, sbi->s_firstdatazone);
+			inode = iget(s, sbi->s_firstdatazone << 6);
  		}
  	}

@@ -1044,7 +1066,7 @@ static int isofs_get_block(struct inode
  	return isofs_get_blocks(inode, iblock, &bh_result, 1) ? 0 : -EIO;
  }

-static int isofs_bmap(struct inode *inode, int block)
+static int isofs_bmap(struct inode *inode, sector_t block)
  {
  	struct buffer_head dummy;
  	int error;
@@ -1097,11 +1119,10 @@ static inline void test_and_set_gid(gid_

  static int isofs_read_level3_size(struct inode * inode)
  {
-	unsigned long f_pos = inode->i_ino;
  	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
  	int high_sierra = ISOFS_SB(inode->i_sb)->s_high_sierra;
  	struct buffer_head * bh = NULL;
-	unsigned long block, offset;
+	unsigned long block, offset, nrec, first_block;
  	int i = 0;
  	int more_entries = 0;
  	struct iso_directory_record * tmpde = NULL;
@@ -1110,8 +1131,9 @@ static int isofs_read_level3_size(struct
  	inode->i_size = 0;
  	ei->i_next_section_ino = 0;

-	block = f_pos >> ISOFS_BUFFER_BITS(inode);
-	offset = f_pos & (bufsize-1);
+	block = inode->i_ino >> 6;
+	nrec = inode->i_ino & 63;
+	offset = 0;  /* Quiet GCC */

  	do {
  		struct iso_directory_record * de;
@@ -1121,6 +1143,7 @@ static int isofs_read_level3_size(struct
  			bh = sb_bread(inode->i_sb, block);
  			if (!bh)
  				goto out_noread;
+			offset = isofs_nrec_to_offset(bh, nrec);
  		}
  		de = (struct iso_directory_record *) (bh->b_data + offset);
  		de_len = *(unsigned char *) de;
@@ -1128,12 +1151,16 @@ static int isofs_read_level3_size(struct
  		if (de_len == 0) {
  			brelse(bh);
  			bh = NULL;
-			f_pos = (f_pos + ISOFS_BLOCK_SIZE) & ~(ISOFS_BLOCK_SIZE - 1);
-			block = f_pos >> ISOFS_BUFFER_BITS(inode);
-			offset = 0;
+			++block;
+			nrec = 0;
  			continue;
  		}

+		if (block > ISOFS_BLOCK_MAX) {
+			goto out_toofar;
+		}
+
+		first_block = block;
  		offset += de_len;

  		/* Make sure we have a full directory entry */
@@ -1160,11 +1187,11 @@ static int isofs_read_level3_size(struct

  		inode->i_size += isonum_733(de->size);
  		if (i == 1)
-			ei->i_next_section_ino = f_pos;
+			ei->i_next_section_ino = (first_block << 6) + nrec;

  		more_entries = de->flags[-high_sierra] & 0x80;

-		f_pos += de_len;
+		nrec++;
  		i++;
  		if(i > 100)
  			goto out_toomany;
@@ -1176,6 +1203,13 @@ out:
  		brelse(bh);
  	return 0;

+out_toofar:
+	printk(KERN_ERR "isofs: inode.c: Attempt to set "
+	       "inode to unsupported block.\n");
+	if (bh)
+		brelse(bh);
+	return -EIO;
+
  out_nomem:
  	if (bh)
  		brelse(bh);
@@ -1191,7 +1225,7 @@ out_toomany:
  	printk(KERN_INFO "isofs_read_level3_size: "
  		"More than 100 file sections ?!?, aborting...\n"
  	  	"isofs_read_level3_size: inode=%lu ino=%lu\n",
-		inode->i_ino, f_pos);
+		inode->i_ino, ((first_block << 6) + nrec));
  	goto out;
  }

@@ -1200,7 +1234,8 @@ static void isofs_read_inode(struct inod
  	struct super_block *sb = inode->i_sb;
  	struct isofs_sb_info *sbi = ISOFS_SB(sb);
  	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
-	int block = inode->i_ino >> ISOFS_BUFFER_BITS(inode);
+	unsigned long block = inode->i_ino >> 6;
+	unsigned long nrec = inode->i_ino & 63;
  	int high_sierra = sbi->s_high_sierra;
  	struct buffer_head * bh = NULL;
  	struct iso_directory_record * de;
@@ -1214,7 +1249,8 @@ static void isofs_read_inode(struct inod
  	if (!bh)
  		goto out_badread;

-	offset = (inode->i_ino & (bufsize - 1));
+	offset = isofs_nrec_to_offset(bh, nrec);
+
  	de = (struct iso_directory_record *) (bh->b_data + offset);
  	de_len = *(unsigned char *) de;

diff -uprN -X dontdiff linux-2.6.6/fs/isofs/namei.c linux-2.6.6-isofs.2/fs/isofs/namei.c
--- linux-2.6.6/fs/isofs/namei.c	2004-05-09 21:32:54.000000000 -0500
+++ linux-2.6.6-isofs.2/fs/isofs/namei.c	2004-05-24 09:05:27.471273432 -0500
@@ -63,8 +63,7 @@ isofs_find_entry(struct inode *dir, stru
  {
  	unsigned long inode_number;
  	unsigned long bufsize = ISOFS_BUFFER_SIZE(dir);
-	unsigned char bufbits = ISOFS_BUFFER_BITS(dir);
-	unsigned int block, f_pos, offset;
+	unsigned long block, f_pos, offset, nrec;
  	struct buffer_head * bh = NULL;
  	struct isofs_sb_info *sbi = ISOFS_SB(dir->i_sb);

@@ -74,6 +73,7 @@ isofs_find_entry(struct inode *dir, stru
  	f_pos = 0;
  	offset = 0;
  	block = 0;
+        nrec = 0;   /* zero-based */

  	while (f_pos < dir->i_size) {
  		struct iso_directory_record * de;
@@ -86,21 +86,29 @@ isofs_find_entry(struct inode *dir, stru
  				return 0;
  		}

+                if (bh->b_blocknr > ISOFS_BLOCK_MAX) {
+			printk(KERN_ERR "isofs: namei.c: Attempt to set "
+			       "inode to an unsupported block.\n");
+			break;
+                }
+
  		de = (struct iso_directory_record *) (bh->b_data + offset);
-		inode_number = (bh->b_blocknr << bufbits) + offset;
+		inode_number = (bh->b_blocknr << 6) + nrec;

  		de_len = *(unsigned char *) de;
  		if (!de_len) {
  			brelse(bh);
  			bh = NULL;
  			f_pos = (f_pos + ISOFS_BLOCK_SIZE) & ~(ISOFS_BLOCK_SIZE - 1);
-			block = f_pos >> bufbits;
+			++block;
  			offset = 0;
+                        nrec = 0;
  			continue;
  		}

  		offset += de_len;
  		f_pos += de_len;
+                ++nrec;

  		/* Make sure we have a full directory entry */
  		if (offset >= bufsize) {
diff -uprN -X dontdiff linux-2.6.6/fs/isofs/rock.c linux-2.6.6-isofs.2/fs/isofs/rock.c
--- linux-2.6.6/fs/isofs/rock.c	2004-05-09 21:32:37.000000000 -0500
+++ linux-2.6.6-isofs.2/fs/isofs/rock.c	2004-05-24 12:29:10.914937392 -0500
@@ -306,9 +306,7 @@ int parse_rock_ridge_inode_internal(stru
  	goto out;
        case SIG('C','L'):
  	ISOFS_I(inode)->i_first_extent = isonum_733(rr->u.CL.location);
-	reloc = iget(inode->i_sb,
-		     (ISOFS_I(inode)->i_first_extent <<
-		      ISOFS_SB(inode->i_sb)->s_log_zone_size));
+	reloc = iget(inode->i_sb, (ISOFS_I(inode)->i_first_extent << 6));
  	if (!reloc)
  		goto out;
  	inode->i_mode = reloc->i_mode;
@@ -449,13 +447,13 @@ static int rock_ridge_symlink_readpage(s
  	struct inode *inode = page->mapping->host;
  	char *link = kmap(page);
  	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
-	unsigned char bufbits = ISOFS_BUFFER_BITS(inode);
  	struct buffer_head *bh;
  	char *rpnt = link;
  	unsigned char *pnt;
  	struct iso_directory_record *raw_inode;
  	CONTINUE_DECLS;
-	int block;
+	unsigned long block;
+        unsigned long offset;
  	int sig;
  	int len;
  	unsigned char *chr;
@@ -464,20 +462,22 @@ static int rock_ridge_symlink_readpage(s
  	if (!ISOFS_SB(inode->i_sb)->s_rock)
  		panic ("Cannot have symlink with high sierra variant of iso filesystem\n");

-	block = inode->i_ino >> bufbits;
+	block = inode->i_ino >> 6;
  	lock_kernel();
  	bh = sb_bread(inode->i_sb, block);
  	if (!bh)
  		goto out_noread;

-	pnt = (unsigned char *) bh->b_data + (inode->i_ino & (bufsize - 1));
+        offset = isofs_nrec_to_offset(bh, inode->i_ino & 63);
+
+	pnt = (unsigned char *) bh->b_data + offset;

  	raw_inode = (struct iso_directory_record *) pnt;

  	/*
  	 * If we go past the end of the buffer, there is some sort of error.
  	 */
-	if ((inode->i_ino & (bufsize - 1)) + *pnt > bufsize)
+	if (offset + *pnt > bufsize)
  		goto out_bad_span;

  	/* Now test for possible Rock Ridge extensions which will override
diff -uprN -X dontdiff linux-2.6.6/include/linux/iso_fs.h linux-2.6.6-isofs.2/include/linux/iso_fs.h
--- linux-2.6.6/include/linux/iso_fs.h	2004-05-09 21:32:52.000000000 -0500
+++ linux-2.6.6-isofs.2/include/linux/iso_fs.h	2004-05-24 09:46:21.247242784 -0500
@@ -3,6 +3,7 @@
  #define _ISOFS_FS_H

  #include <linux/types.h>
+#include <linux/buffer_head.h>
  /*
   * The isofs filesystem constants/structures
   */
@@ -158,6 +159,9 @@ struct iso_directory_record {
  #define ISOFS_BLOCK_BITS 11
  #define ISOFS_BLOCK_SIZE 2048

+/* The current implementation can only address ISOFS_BLOCK_MAX blocks. */
+#define ISOFS_BLOCK_MAX 0x3ffffff
+
  #define ISOFS_BUFFER_SIZE(INODE) ((INODE)->i_sb->s_blocksize)
  #define ISOFS_BUFFER_BITS(INODE) ((INODE)->i_sb->s_blocksize_bits)

@@ -216,6 +220,52 @@ static inline int isonum_733(char *p)
  	/* Ignore bigendian datum due to broken mastering programs */
  	return le32_to_cpu(get_unaligned((u32 *)p));
  }
+
+/* Find the offset into the buffer "bh" where this directory record is
+ * located given the record number "nrec". */
+static inline unsigned long isofs_nrec_to_offset(struct buffer_head *bh,
+						 unsigned long nrec)
+{
+	unsigned long rv = 0;
+	for ( ; nrec && (rv < bh->b_size) ; --nrec) {
+		rv += (unsigned char)bh->b_data[rv];
+	}
+	/* See the comment below in isofs_offset_to_nrec() regarding
+	 * BUG_ON(rv > 60). */
+	BUG_ON(rv > 2014);
+	BUG_ON(rv >= bh->b_size);
+	return rv;
+}
+
+/* Find the record number "nrec" given the offset into the buffer "bh"
+ * where this directory record is located.  Remember that "nrec" is
+ * zero-based. */
+static inline unsigned long isofs_offset_to_nrec(struct buffer_head *bh,
+						 unsigned long offset)
+{
+	unsigned long i = 0;
+	unsigned long rv = 0;
+	for ( i = 0 ;
+	      (i < offset) && (i < bh->b_size) ;
+	      i += (unsigned char)bh->b_data[i] )
+	{
+		++rv;		
+	}
+	/* If you trip the BUG_ON(rv > 60) bug, it probably means your
+	 * block size is greater than 2048 bytes.  You will want to
+	 * read Section 6.1 of the ISO 9660 standard.  I think it is
+	 * technically possible for the block size to be greater than
+	 * 2048 bytes.  Our inode scheme of using the lower 6 bits to
+	 * store the count of the directory record depends on this as
+	 * the limiting factor that 6 bits is enough to address each
+	 * directory record in a single block.  However at this time,
+	 * conventional wisdom says iso9660 blocks are always 2048
+	 * bytes so maybe I've misread the standard. */
+	BUG_ON(rv > 60);
+	BUG_ON(i != offset);
+	return rv;
+}
+
  extern int iso_date(char *, int);

  struct inode;		/* To make gcc happy */
diff -uprN -X dontdiff linux-2.6.6/include/linux/iso_fs_i.h linux-2.6.6-isofs.2/include/linux/iso_fs_i.h
--- linux-2.6.6/include/linux/iso_fs_i.h	2004-05-09 21:32:28.000000000 -0500
+++ linux-2.6.6-isofs.2/include/linux/iso_fs_i.h	2004-05-24 08:21:49.418277984 -0500
@@ -13,7 +13,7 @@ enum isofs_file_format {
   * iso fs inode data in memory
   */
  struct iso_inode_info {
-	unsigned int i_first_extent;
+	unsigned long i_first_extent;
  	unsigned char i_file_format;
  	unsigned char i_format_parm[3];
  	unsigned long i_next_section_ino;

