Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266094AbUFJDX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266094AbUFJDX4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 23:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266108AbUFJDX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 23:23:56 -0400
Received: from cmlapp16.siteprotect.com ([64.41.126.229]:46543 "EHLO
	cmlapp16.siteprotect.com") by vger.kernel.org with ESMTP
	id S266094AbUFJDXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 23:23:51 -0400
Message-ID: <40C7D44E.4000605@serice.net>
Date: Wed, 09 Jun 2004 22:23:58 -0500
From: Paul Serice <paul@serice.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040127
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Lammerts <eric@lammerts.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] iso9660 Inodes Anywhere and NFS
References: <40BD2841.2050509@serice.net>    <54574.67.8.218.172.1086758675.squirrel@webmail.krabbendam.net>    <40C6E07C.6060609@serice.net> <55780.67.8.218.172.1086786707.squirrel@webmail.krabbendam.net>
In-Reply-To: <55780.67.8.218.172.1086786707.squirrel@webmail.krabbendam.net>
Content-Type: multipart/mixed;
 boundary="------------000105020109060902060608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000105020109060902060608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

 > Tar uses inode numbers to determine which files are hardlinked. So
 > if you tar up a tree containing 0-byte files, then untar it
 > somewhere, all 0-byte files will end up being hardlinked to each
 > other. The same happens when you use cp -a.

Ahhh!  O.k., that changes everything.

 > Or take a hybrid approach: use your scheme for directories and my
 > scheme for files; use bit 0 or bit 31 to indicate what scheme is
 > used. Then directories have unique inode numbers, and files too as
 > long as their directory records are in the first 64Gb of the disc.

An incremental patch is attached that should apply cleanly to the
latest -mm tree.  It's not a hybrid.  It is a straight implementation
of your suggestion.  Hopefully this will make all inode numbers unique
for images less than 128GB in size.

Thanks


--------------000105020109060902060608
Content-Type: text/plain;
 name="linux-2.6.7-rc3-mm1-isofs.3.3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.7-rc3-mm1-isofs.3.3.patch"

diff -uprN -X dontdiff linux-2.6.7-rc3-mm1/fs/isofs/dir.c linux-2.6.7-rc3-mm1-isofs.3/fs/isofs/dir.c
--- linux-2.6.7-rc3-mm1/fs/isofs/dir.c	2004-06-09 19:30:29.000000000 -0500
+++ linux-2.6.7-rc3-mm1-isofs.3/fs/isofs/dir.c	2004-06-09 19:43:15.000000000 -0500
@@ -106,7 +106,7 @@ static int do_isofs_readdir(struct inode
 {
 	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
 	unsigned char bufbits = ISOFS_BUFFER_BITS(inode);
-	unsigned long block, offset;
+	unsigned long block, offset, block_saved, offset_saved;
 	unsigned long inode_number = 0;	/* Quiet GCC */
 	struct buffer_head *bh = NULL;
 	int len;
@@ -129,8 +129,6 @@ static int do_isofs_readdir(struct inode
 		}
 
 		de = (struct iso_directory_record *) (bh->b_data + offset);
-		if (first_de)
-			inode_number = isofs_get_ino(de);
 
 		de_len = *(unsigned char *) de;
 
@@ -147,6 +145,8 @@ static int do_isofs_readdir(struct inode
 			continue;
 		}
 
+		block_saved = block;
+		offset_saved = offset;
 		offset += de_len;
 
 		/* Make sure we have a full directory entry */
@@ -166,6 +166,15 @@ static int do_isofs_readdir(struct inode
 			de = tmpde;
 		}
 
+		if (first_de) {
+			isofs_normalize_block_and_offset(de,
+							 &block_saved,
+							 &offset_saved);
+			inode_number = isofs_get_ino(block_saved,
+						     offset_saved,
+						     bufbits);
+		}
+
 		if (de->flags[-sbi->s_high_sierra] & 0x80) {
 			first_de = 0;
 			filp->f_pos += de_len;
diff -uprN -X dontdiff linux-2.6.7-rc3-mm1/fs/isofs/inode.c linux-2.6.7-rc3-mm1-isofs.3/fs/isofs/inode.c
--- linux-2.6.7-rc3-mm1/fs/isofs/inode.c	2004-06-09 19:30:29.000000000 -0500
+++ linux-2.6.7-rc3-mm1-isofs.3/fs/isofs/inode.c	2004-06-09 19:43:15.000000000 -0500
@@ -7,7 +7,7 @@
  *      1995  Mark Dobie - allow mounting of some weird VideoCDs and PhotoCDs.
  *	1997  Gordon Chaffee - Joliet CDs
  *	1998  Eric Lammerts - ISO 9660 Level 3
- *	2004  Paul Serice - Comprehensive Inode Scheme
+ *	2004  Paul Serice - Inode Support pushed out from 4GB to 128GB
  *	2004  Paul Serice - NFS Export Operations
  */
 
@@ -1229,7 +1229,9 @@ static void isofs_read_inode(struct inod
 		de = tmpde;
 	}
 
-	inode->i_ino = isofs_get_ino(de);
+	inode->i_ino = isofs_get_ino(ei->i_iget5_block,
+				     ei->i_iget5_offset,
+				     ISOFS_BUFFER_BITS(inode));
 
 	/* Assume it is a normal-format file unless told otherwise */
 	ei->i_file_format = isofs_file_normal;
diff -uprN -X dontdiff linux-2.6.7-rc3-mm1/include/linux/iso_fs.h linux-2.6.7-rc3-mm1-isofs.3/include/linux/iso_fs.h
--- linux-2.6.7-rc3-mm1/include/linux/iso_fs.h	2004-06-09 19:30:29.000000000 -0500
+++ linux-2.6.7-rc3-mm1-isofs.3/include/linux/iso_fs.h	2004-06-09 19:43:15.000000000 -0500
@@ -237,19 +237,13 @@ extern struct inode *isofs_iget(struct s
 
 /* Because the inode number is no longer relevant to finding the
  * underlying meta-data for an inode, we are free to choose a more
- * convenient 32-bit number as the inode number.  Because directories
- * and files are block aligned (except in a few very unusual cases)
- * and because blocks are limited to 32-bits, I've chosen the starting
- * block that holds the file or directory data as the inode number.
- *
- * One nice side effect of this is that you can use "ls -i" to get the
- * inode number which will tell you exactly where you need to start a
- * hex dump if you want to see the contents of the directory or
- * file. */
-static inline unsigned long isofs_get_ino(struct iso_directory_record *d)
+ * convenient 32-bit number as the inode number.  The inode numbering
+ * scheme was recommended by Sergey Vlasov and Eric Lammerts. */
+static inline unsigned long isofs_get_ino(unsigned long block,
+					  unsigned long offset,
+					  unsigned long bufbits)
 {
-	return (unsigned long)isonum_733(d->extent)
-		+ (unsigned long)isonum_711(d->ext_attr_length);
+	return (block << (bufbits - 5)) | (offset >> 5);
 }
 
 /* Every directory can have many redundant directory entries scattered

--------------000105020109060902060608--
