Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWHWGTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWHWGTK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 02:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWHWGTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 02:19:10 -0400
Received: from mx1.mail.ru ([194.67.23.121]:51026 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S1751379AbWHWGTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 02:19:07 -0400
Date: Wed, 23 Aug 2006 10:28:22 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2]: ufs: write to hole in big file
Message-ID: <20060823062822.GA8311@rain>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Such scenario:
open(O_TRUNC)
lseek(1024 * 1024 * 80)
write("A")
lseek(1024 * 2)
write("A")

may cause access to invalid address.
This happened because of "goal" is calculated in wrong way 
in block allocation path, as I see this problem exists also in 2.4.
We use construction like
this i_data[lastfrag], i_data array of pointers to direct
blocks, indirect and so on, it has ceratain size ~20 elements,
and lastfrag may have value for example 40000.
Also this patch fixes related to handling such scenario issues,
wrong zeroing metadata, in case of block(not fragment) allocation,
and wrong goal calculation, when we allocate block

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

Index: linux-2.6.18-rc4-mm1/fs/ufs/inode.c
===================================================================
--- linux-2.6.18-rc4-mm1.orig/fs/ufs/inode.c
+++ linux-2.6.18-rc4-mm1/fs/ufs/inode.c
@@ -169,18 +169,20 @@ static void ufs_clear_frag(struct inode 
 
 static struct buffer_head *
 ufs_clear_frags(struct inode *inode, sector_t beg,
-		unsigned int n)
+		unsigned int n, sector_t want)
 {
-	struct buffer_head *res, *bh;
+	struct buffer_head *res = NULL, *bh;
 	sector_t end = beg + n;
 
-	res = sb_getblk(inode->i_sb, beg);
-	ufs_clear_frag(inode, res);
-	for (++beg; beg < end; ++beg) {
+	for (; beg < end; ++beg) {
 		bh = sb_getblk(inode->i_sb, beg);
 		ufs_clear_frag(inode, bh);
-		brelse(bh);
+		if (want != beg)
+			brelse(bh);
+		else
+			res = bh;
 	}
+	BUG_ON(!res);
 	return res;
 }
 
@@ -265,7 +267,9 @@ repeat:
 			lastfrag = ufsi->i_lastfrag;
 			
 		}
-		goal = fs32_to_cpu(sb, ufsi->i_u1.i_data[lastblock]) + uspi->s_fpb;
+		tmp = fs32_to_cpu(sb, ufsi->i_u1.i_data[lastblock]);
+		if (tmp)
+			goal = tmp + uspi->s_fpb;
 		tmp = ufs_new_fragments (inode, p, fragment - blockoff, 
 					 goal, required + blockoff,
 					 err, locked_page);
@@ -277,13 +281,15 @@ repeat:
 		tmp = ufs_new_fragments(inode, p, fragment - (blockoff - lastblockoff),
 					fs32_to_cpu(sb, *p), required +  (blockoff - lastblockoff),
 					err, locked_page);
-	}
+	} else /* (lastblock > block) */ {
 	/*
 	 * We will allocate new block before last allocated block
 	 */
-	else /* (lastblock > block) */ {
-		if (lastblock && (tmp = fs32_to_cpu(sb, ufsi->i_u1.i_data[lastblock-1])))
-			goal = tmp + uspi->s_fpb;
+		if (block) {
+			tmp = fs32_to_cpu(sb, ufsi->i_u1.i_data[block-1]);
+			if (tmp)
+				goal = tmp + uspi->s_fpb;
+		}
 		tmp = ufs_new_fragments(inode, p, fragment - blockoff,
 					goal, uspi->s_fpb, err, locked_page);
 	}
@@ -296,7 +302,7 @@ repeat:
 	}
 
 	if (!phys) {
-		result = ufs_clear_frags(inode, tmp + blockoff, required);
+		result = ufs_clear_frags(inode, tmp, required, tmp + blockoff);
 	} else {
 		*phys = tmp + blockoff;
 		result = NULL;
@@ -383,7 +389,7 @@ repeat:
 		}
 	}
 
-	if (block && (tmp = fs32_to_cpu(sb, ((__fs32*)bh->b_data)[block-1]) + uspi->s_fpb))
+	if (block && (tmp = fs32_to_cpu(sb, ((__fs32*)bh->b_data)[block-1])))
 		goal = tmp + uspi->s_fpb;
 	else
 		goal = bh->b_blocknr + uspi->s_fpb;
@@ -397,7 +403,8 @@ repeat:
 
 
 	if (!phys) {
-		result = ufs_clear_frags(inode, tmp + blockoff, uspi->s_fpb);
+		result = ufs_clear_frags(inode, tmp, uspi->s_fpb,
+					 tmp + blockoff);
 	} else {
 		*phys = tmp + blockoff;
 		*new = 1;


-- 
/Evgeniy

