Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129321AbRBPPDJ>; Fri, 16 Feb 2001 10:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129639AbRBPPDA>; Fri, 16 Feb 2001 10:03:00 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:48913 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129321AbRBPPCu>; Fri, 16 Feb 2001 10:02:50 -0500
Date: Fri, 16 Feb 2001 10:02:37 -0500
From: Chris Mason <mason@suse.com>
To: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: [PATCH] reiserfs fix for null bytes in small files
Message-ID: <823240000.982335757@tiny>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everyone,

I think Alexander Zarochentcev and I have finally figured out
cause for null bytes in small reiserfs files.  reiserfs stores
parts of these files packed together in the tree, and the
packed bytes can shift around as the tree is balanced.

When converting from the packed bytes to a full block, the
full block is inserted, and the packed bytes are removed.  If 
the packed bytes are split between two tree blocks, and then
merged by a different process balancing the tree, the conversion
code might remove too many bytes from the file.  This creates
a hole in the file, which is why people see null bytes.

If anyone wants more details, drop a line to me or the reiserfs
list ;-)  This patch against 2.4.1 (will work on any 2.4.1ac or
2.4.2pre as well) should fix it, please try it on your
non-production machines, we are still running it through tests
here.

-chris

--- linux/fs/reiserfs/tail_conversion.c.old	Thu Feb 15 13:16:47 2001
+++ linux/fs/reiserfs/tail_conversion.c	Thu Feb 15 13:10:23 2001
@@ -92,7 +92,7 @@
     /* Move bytes from the direct items to the new unformatted node
        and delete them. */
     while (1)  {
-	int item_len, first_direct;
+	int tail_size;
 
 	/* end_key.k_offset is set so, that we will always have found
            last item of the file */
@@ -103,13 +103,11 @@
 #ifdef CONFIG_REISERFS_CHECK
 	if (!is_direct_le_ih (p_le_ih))
 	    reiserfs_panic (sb, "vs-14055: direct2indirect: "
-			    "direct item expected, found %h", p_le_ih);
+			    "direct item expected(%k), found %h", 
+				&end_key, p_le_ih);
 #endif
-	if ((le_ih_k_offset (p_le_ih) & (n_blk_size - 1)) == 1)
-	    first_direct = 1;
-	else
-	    first_direct = 0;
-	item_len = le16_to_cpu (p_le_ih->ih_item_len);
+	tail_size = (le_ih_k_offset (p_le_ih) & (n_blk_size - 1))
+	    + ih_item_len(p_le_ih) - 1;
 
 	/* we only send the unbh pointer if the buffer is not up to date.
 	** this avoids overwriting good data from writepage() with old data
@@ -123,7 +121,7 @@
 	n_retval = reiserfs_delete_item (th, path, &end_key, inode, 
 	                                 up_to_date_bh) ;
 
-	if (first_direct && item_len == n_retval)
+	if (tail_size == n_retval)
 	    // done: file does not have direct items anymore
 	    break;
 





