Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268341AbRGWVO5>; Mon, 23 Jul 2001 17:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268344AbRGWVOr>; Mon, 23 Jul 2001 17:14:47 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:38217
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S268341AbRGWVOe>; Mon, 23 Jul 2001 17:14:34 -0400
Date: Mon, 23 Jul 2001 23:14:32 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: bfennema@falcon.csc.calpoly.edu, dave@trylinux.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make udf/{file,super}.c check return codes (247)
Message-ID: <20010723231432.C1223@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi.

The following patch makes fs/udf/{file,super}.c check the
return code of bread and udf_read_tagged. Comments welcome
as I never felt real sure on this. It applies against
246ac5 and 247. These unguarded dereferences were reported
by the Stanford team a while back.


diff -ur linux-247-clean/fs/udf/file.c linux-247/fs/udf/file.c
--- linux-247-clean/fs/udf/file.c	Tue Jun 12 04:15:27 2001
+++ linux-247/fs/udf/file.c	Mon Jul 23 22:33:39 2001
@@ -50,6 +50,7 @@
 	struct buffer_head *bh;
 	int block;
 	char *kaddr;
+	int ret = 0;
 
 	if (!PageLocked(page))
 		PAGE_BUG(page);
@@ -58,13 +59,18 @@
 	memset(kaddr, 0, PAGE_CACHE_SIZE);
 	block = udf_get_lb_pblock(inode->i_sb, UDF_I_LOCATION(inode), 0);
 	bh = bread (inode->i_dev, block, inode->i_sb->s_blocksize);
+	if (!bh) {
+		ret = - EIO;
+		goto err_out;
+	}
 	memcpy(kaddr, bh->b_data + udf_ext0_offset(inode), inode->i_size);
 	brelse(bh);
 	flush_dcache_page(page);
 	SetPageUptodate(page);
+err_out:
 	kunmap(page);
 	UnlockPage(page);
-	return 0;
+	return ret;
 }
 
 static int udf_adinicb_writepage(struct page *page)
@@ -74,6 +80,7 @@
 	struct buffer_head *bh;
 	int block;
 	char *kaddr;
+	int ret = 0;
 
 	if (!PageLocked(page))
 		PAGE_BUG(page);
@@ -81,13 +88,18 @@
 	kaddr = kmap(page);
 	block = udf_get_lb_pblock(inode->i_sb, UDF_I_LOCATION(inode), 0);
 	bh = bread (inode->i_dev, block, inode->i_sb->s_blocksize);
+	if (!bh) {
+		ret = -EIO;
+		goto err_out;
+	}
 	memcpy(bh->b_data + udf_ext0_offset(inode), kaddr, inode->i_size);
 	mark_buffer_dirty(bh);
 	brelse(bh);
 	SetPageUptodate(page);
+err_out:
 	kunmap(page);
 	UnlockPage(page);
-	return 0;
+	return ret;
 }
 
 static int udf_adinicb_prepare_write(struct file *file, struct page *page, unsigned offset, unsigned to)
@@ -103,19 +115,25 @@
 	struct buffer_head *bh;
 	int block;
 	char *kaddr = page_address(page);
+	int ret = 0;
 
 	block = udf_get_lb_pblock(inode->i_sb, UDF_I_LOCATION(inode), 0);
 	bh = bread (inode->i_dev, block, inode->i_sb->s_blocksize);
+	if (!bh) {
+		ret = -EIO;
+		goto err_out;
+	}
 	memcpy(bh->b_data + udf_file_entry_alloc_offset(inode) + offset,
 		kaddr + offset, to-offset);
 	mark_buffer_dirty(bh);
 	brelse(bh);
 	SetPageUptodate(page);
-	kunmap(page);
 	/* only one page here */
 	if (to > inode->i_size)
 		inode->i_size = to;
-	return 0;
+err_out:
+	kunmap(page);
+	return ret;
 }
 
 struct address_space_operations udf_adinicb_aops = {
diff -ur linux-247-clean/fs/udf/super.c linux-247/fs/udf/super.c
--- linux-247-clean/fs/udf/super.c	Tue Jun 12 04:15:27 2001
+++ linux-247/fs/udf/super.c	Mon Jul 23 22:57:49 2001
@@ -1121,6 +1121,8 @@
 				for (j=vds[i].block+1; j<vds[VDS_POS_TERMINATING_DESC].block; j++)
 				{
 					bh2 = udf_read_tagged(sb, j, j, &ident);
+					if (!bh2)
+						break;
 					gd = (struct GenericDesc *)bh2->b_data;
 					if (ident == TID_PARTITION_DESC)
 						udf_load_partdesc(sb, bh2);
@@ -1255,6 +1257,8 @@
 
 					pos = udf_block_map(UDF_SB_VAT(sb), 0);
 					bh = bread(sb->s_dev, pos, sb->s_blocksize);
+					if (!bh)
+						return 1;
 					UDF_SB_TYPEVIRT(sb,i).s_start_offset =
 						le16_to_cpu(((struct VirtualAllocationTable20 *)bh->b_data + udf_ext0_offset(UDF_SB_VAT(sb)))->lengthHeader) +
 							udf_ext0_offset(UDF_SB_VAT(sb));

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"Women are like a beer. They look good,
they taste good, and as soon as you've
had one, you want another." -Homer Simpson
