Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWFQKIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWFQKIs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 06:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWFQKIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 06:08:48 -0400
Received: from mx2.mail.ru ([194.67.23.122]:1892 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1751244AbWFQKIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 06:08:47 -0400
Date: Sat, 17 Jun 2006 14:14:04 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5]: ufs: missed brelse and wrong baseblk
Message-ID: <20060617101403.GA22098@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes two bugs, which introduced by previous
patches:
1)Missed "brelse"
2)Sometimes "baseblk" may be wrongly calculated, if 
i_size is equal to zero, which lead infinite cycle 
in "mpage_writepages".

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

Index: linux-2.6.17-rc6-mm2/fs/ufs/inode.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/ufs/inode.c
+++ linux-2.6.17-rc6-mm2/fs/ufs/inode.c
@@ -175,6 +175,7 @@ ufs_clear_frags(struct inode *inode, sec
 	for (++beg; beg < end; ++beg) {
 		bh = sb_getblk(inode->i_sb, beg);
 		ufs_clear_frag(inode, bh);
+		brelse(bh);
 	}
 	return res;
 }
Index: linux-2.6.17-rc6-mm2/fs/ufs/balloc.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/ufs/balloc.c
+++ linux-2.6.17-rc6-mm2/fs/ufs/balloc.c
@@ -269,20 +269,17 @@ out:
  * We can come here from ufs_writepage or ufs_prepare_write,
  * locked_page is argument of these functions, so we already lock it.
  */
-static void ufs_change_blocknr(struct inode *inode, unsigned int count,
-			       unsigned int oldb, unsigned int newb,
-			       struct page *locked_page)
+static void ufs_change_blocknr(struct inode *inode, unsigned int baseblk,
+			       unsigned int count, unsigned int oldb,
+			       unsigned int newb, struct page *locked_page)
 {
 	unsigned int blk_per_page = 1 << (PAGE_CACHE_SHIFT - inode->i_blkbits);
-	sector_t baseblk;
 	struct address_space *mapping = inode->i_mapping;
 	pgoff_t index, cur_index = locked_page->index;
 	unsigned int i, j;
 	struct page *page;
 	struct buffer_head *head, *bh;
 
-	baseblk = ((i_size_read(inode) - 1) >> inode->i_blkbits) + 1 - count;
-
 	UFSD("ENTER, ino %lu, count %u, oldb %u, newb %u\n",
 	      inode->i_ino, count, oldb, newb);
 
@@ -439,7 +436,8 @@ unsigned ufs_new_fragments(struct inode 
 	}
 	result = ufs_alloc_fragments (inode, cgno, goal, request, err);
 	if (result) {
-		ufs_change_blocknr(inode, oldcount, tmp, result, locked_page);
+		ufs_change_blocknr(inode, fragment - oldcount, oldcount, tmp,
+				   result, locked_page);
 
 		*p = cpu_to_fs32(sb, result);
 		*err = 0;

-- 
/Evgeniy

