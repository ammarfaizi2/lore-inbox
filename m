Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316372AbSEZUhZ>; Sun, 26 May 2002 16:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316359AbSEZUgK>; Sun, 26 May 2002 16:36:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38416 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316372AbSEZUfB>;
	Sun, 26 May 2002 16:35:01 -0400
Message-ID: <3CF147B2.9D6D7C2F@zip.com.au>
Date: Sun, 26 May 2002 13:38:10 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 2/18] block_truncate_page fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fix bug in block_truncate_page().

When buffers are attached to an uptodate page, they are marked as
being uptodate.  To preserve buffer/page state coherency.  Dirtiness
is handled in the same way.

But block_truncate_page() assumes that a buffer which is unmapped and
uptodate is over a hole.  That's not the case, and the net effect is
that block_truncate_page() is failing to zero the block outside the
truncation point.

This only happens if the page has a disk mapping but has no attached
buffers on entry to block_truncate_page().  That's never the case in
current kernels, so the problem does not exhibit (it _does_ exhibit
with direct-to-BIO bypass-the-buffers I/O).

There are actually three possible states of buffer mappedness:

- Buffer has a disk mapping            (buffer_mapped(bh) == true)

- buffer is over a hole	               (buffer_mapped(bh) == false)

- don't know.  Need to run get_block() (buffer_mapped(bh) == false)

This ambiguity could be resolved by added another buffer state bit
(BH_mapping_state_known?) but given that we already elide the get_block
calls for the common case (buffer outside i_size) it is unlikely that
the complexity is worthwhile.


=====================================

--- 2.5.18/fs/buffer.c~block_truncate_page	Sun May 26 12:37:39 2002
+++ 2.5.18-akpm/fs/buffer.c	Sun May 26 12:37:39 2002
@@ -2079,11 +2079,10 @@ int block_truncate_page(struct address_s
 
 	err = 0;
 	if (!buffer_mapped(bh)) {
-		/* Hole? Nothing to do */
-		if (buffer_uptodate(bh))
+		err = get_block(inode, iblock, bh, 0);
+		if (err)
 			goto unlock;
-		get_block(inode, iblock, bh, 0);
-		/* Still unmapped? Nothing to do */
+		/* unmapped? It's a hole - nothing to do */
 		if (!buffer_mapped(bh))
 			goto unlock;
 	}
--- 2.5.18/fs/ext3/inode.c~block_truncate_page	Sun May 26 12:37:39 2002
+++ 2.5.18-akpm/fs/ext3/inode.c	Sun May 26 12:37:40 2002
@@ -1408,11 +1408,8 @@ static int ext3_block_truncate_page(hand
 
 	err = 0;
 	if (!buffer_mapped(bh)) {
-		/* Hole? Nothing to do */
-		if (buffer_uptodate(bh))
-			goto unlock;
 		ext3_get_block(inode, iblock, bh, 0);
-		/* Still unmapped? Nothing to do */
+		/* unmapped? It's a hole - nothing to do */
 		if (!buffer_mapped(bh))
 			goto unlock;
 	}


-
