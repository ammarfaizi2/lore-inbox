Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290472AbSAQVTa>; Thu, 17 Jan 2002 16:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290471AbSAQVTX>; Thu, 17 Jan 2002 16:19:23 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:17909 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S290467AbSAQVTH>;
	Thu, 17 Jan 2002 16:19:07 -0500
Date: Thu, 17 Jan 2002 14:18:54 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Patrick Scharrenberg <pittipatti@web.de>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: 2.4.17 strange ext2 error
Message-ID: <20020117141853.I29178@lynx.adilger.int>
Mail-Followup-To: Patrick Scharrenberg <pittipatti@web.de>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <006701c19f97$5531f520$fd358286@koenigsnet.rwthaachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <006701c19f97$5531f520$fd358286@koenigsnet.rwthaachen.de>; from pittipatti@web.de on Thu, Jan 17, 2002 at 09:40:56PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 17, 2002  21:40 +0100, Patrick Scharrenberg wrote:
> yesterday I got a very strange ext2 error on my linux machine..
> The system has a 5-disk raid-5-software-raid and on top of this there is one
> ext2 fs which was clean when mounted 1 week ago..
> 
> kernel 2.4.17 (since 1 week)
> before it was 2.4.10

When you say it was "clean when mounted 1 week ago" does this mean that you
had run e2fsck on it at that time, or just that it did not report any
errors when you mounted it?  Sometimes it is possible to have corruption
in your fs for a while without noticing it if you don't run fsck on it.

   Jan 15 19:03:56 atlantis kernel: EXT2-fs error (device md(9,0)):
   ext2_free_blocks: Freeing blocks in system zones - Block = 71, count = 1
   Jan 15 19:14:45 atlantis kernel: EXT2-fs error (device md(9,0)):
   ext2_new_block:Allocating block in system zone - block = 71

This is a problem with the ext2 code that I have a fix for.  It is not
the _real_ cause of your problem, since this is already showing that
there was another error which caused this problem.

The issue that I have a fix for is that if there is a corrupt inode
somewhere, and you delete it, then it will happily mark metadata blocks
as unused, and as you can see it will also proceed to allocate that
block for something else.

My patch fixes both of these errors - if you try to free such a metadata
block, it will not clear it in the bitmap, and if you try to allocate a
"free" metadata block free in the bitmap it will mark it in use, but
continue to look for a different block which can be allocated.

This change has implications for ext2/ext3 forward/backward compatibility,
but it is much more robust in the face of any errors in an inodes block
list, which could cause cascading errors if you proceed to scribble over
the itable or free blocks list.  I'm CCing the ext2-devel list on this for
discussion, but it should strongly be considered for inclusion into the
official 2.4/2.5 ext2/ext3 code.

Cheers, Andreas

PS - as always, this patch is extracted from among other changes in my
     ext2 code, so it may apply with offsets or minor context issues.
====================== ext2-2.4.17-sysblk.diff =============================
--- linux-2.4.17.orig/fs/ext2/balloc.c	Thu Oct 25 02:02:41 2001
+++ linux/fs/ext2/balloc.c	Thu Dec 13 12:11:47 2001
@@ -302,22 +300,20 @@
 	if (!gdp)
 		goto error_return;
 
-	if (in_range (le32_to_cpu(gdp->bg_block_bitmap), block, count) ||
-	    in_range (le32_to_cpu(gdp->bg_inode_bitmap), block, count) ||
-	    in_range (block, le32_to_cpu(gdp->bg_inode_table),
-		      sb->u.ext2_sb.s_itb_per_group) ||
-	    in_range (block + count - 1, le32_to_cpu(gdp->bg_inode_table),
-		      sb->u.ext2_sb.s_itb_per_group))
-		ext2_error (sb, "ext2_free_blocks",
-			    "Freeing blocks in system zones - "
-			    "Block = %lu, count = %lu",
-			    block, count);
+	for (i = 0; i < count; i++, block++) {
+		if (block == le32_to_cpu(gdp->bg_block_bitmap) ||
+		    block == le32_to_cpu(gdp->bg_inode_bitmap) ||
+		    in_range(block, le32_to_cpu(gdp->bg_inode_table),
+			     sb->u.ext2_sb.s_itb_per_group)) {
+			ext2_error(sb, "ext2_free_blocks",
+				   "Freeing block in system zone - block = %lu",
+				   block);
+			continue;
+		}
 
-	for (i = 0; i < count; i++) {
 		if (!ext2_clear_bit (bit + i, bh->b_data))
-			ext2_error (sb, "ext2_free_blocks",
-				      "bit already cleared for block %lu",
-				      block + i);
+			ext2_error(sb, "ext2_free_blocks",
+				   "bit already cleared for block %lu", block);
 		else {
 			DQUOT_FREE_BLOCK(inode, 1);
 			gdp->bg_free_blocks_count =
@@ -336,7 +332,6 @@
 		wait_on_buffer (bh);
 	}
 	if (overflow) {
-		block += count;
 		count = overflow;
 		goto do_more;
 	}
@@ -522,8 +522,12 @@
 	    in_range (tmp, le32_to_cpu(gdp->bg_inode_table),
 		      sb->u.ext2_sb.s_itb_per_group))
 		ext2_error (sb, "ext2_new_block",
-			    "Allocating block in system zone - "
-			    "block = %u", tmp);
+			    "Allocating block in system zone - block = %u",
+			    tmp);
+		ext2_set_bit(j, bh->b_data);
+		DQUOT_FREE_BLOCK(inode, 1);
+		goto repeat;
+	}
 
 	if (ext2_set_bit (j, bh->b_data)) {
 		ext2_warning (sb, "ext2_new_block",
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

