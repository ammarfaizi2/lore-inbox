Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWFCOZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWFCOZA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 10:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWFCOY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 10:24:59 -0400
Received: from mx1.mail.ru ([194.67.23.121]:59501 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S1030286AbWFCOY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 10:24:57 -0400
Date: Sat, 3 Jun 2006 18:29:23 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5]: ufs: i_blocks wrong count
Message-ID: <20060603142923.GA16350@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At now UFS code uses DQUOT_* mechanism, but it also
update inode->i_blocks manually, this cause wrong 
i_blocks value.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

Index: linux-2.6.17-rc5-mm1/fs/ufs/balloc.c
===================================================================
--- linux-2.6.17-rc5-mm1.orig/fs/ufs/balloc.c
+++ linux-2.6.17-rc5-mm1/fs/ufs/balloc.c
@@ -395,7 +395,6 @@ unsigned ufs_new_fragments(struct inode 
 		if (result) {
 			*p = cpu_to_fs32(sb, result);
 			*err = 0;
-			inode->i_blocks += count << uspi->s_nspfshift;
 			UFS_I(inode)->i_lastfrag = max_t(u32, UFS_I(inode)->i_lastfrag, fragment + count);
 		}
 		unlock_super(sb);
@@ -409,7 +408,6 @@ unsigned ufs_new_fragments(struct inode 
 	result = ufs_add_fragments (inode, tmp, oldcount, newcount, err);
 	if (result) {
 		*err = 0;
-		inode->i_blocks += count << uspi->s_nspfshift;
 		UFS_I(inode)->i_lastfrag = max_t(u32, UFS_I(inode)->i_lastfrag, fragment + count);
 		unlock_super(sb);
 		UFSD("EXIT, result %u\n", result);
@@ -444,7 +442,6 @@ unsigned ufs_new_fragments(struct inode 
 
 		*p = cpu_to_fs32(sb, result);
 		*err = 0;
-		inode->i_blocks += count << uspi->s_nspfshift;
 		UFS_I(inode)->i_lastfrag = max_t(u32, UFS_I(inode)->i_lastfrag, fragment + count);
 		unlock_super(sb);
 		if (newcount < request)
Index: linux-2.6.17-rc5-mm1/fs/ufs/truncate.c
===================================================================
--- linux-2.6.17-rc5-mm1.orig/fs/ufs/truncate.c
+++ linux-2.6.17-rc5-mm1/fs/ufs/truncate.c
@@ -112,9 +112,8 @@ static int ufs_trunc_direct (struct inod
 	frag1 = ufs_fragnum (frag1);
 	frag2 = ufs_fragnum (frag2);
 
-	inode->i_blocks -= (frag2-frag1) << uspi->s_nspfshift;
-	mark_inode_dirty(inode);
 	ufs_free_fragments (inode, tmp + frag1, frag2 - frag1);
+	mark_inode_dirty(inode);
 	frag_to_free = tmp + frag1;
 
 next1:
@@ -128,8 +127,7 @@ next1:
 			continue;
 
 		*p = 0;
-		inode->i_blocks -= uspi->s_nspb;
-		mark_inode_dirty(inode);
+
 		if (free_count == 0) {
 			frag_to_free = tmp;
 			free_count = uspi->s_fpb;
@@ -140,6 +138,7 @@ next1:
 			frag_to_free = tmp;
 			free_count = uspi->s_fpb;
 		}
+		mark_inode_dirty(inode);
 	}
 	
 	if (free_count > 0)
@@ -158,9 +157,9 @@ next1:
 	frag4 = ufs_fragnum (frag4);
 
 	*p = 0;
-	inode->i_blocks -= frag4 << uspi->s_nspfshift;
-	mark_inode_dirty(inode);
+
 	ufs_free_fragments (inode, tmp, frag4);
+	mark_inode_dirty(inode);
  next3:
 
 	UFSD("EXIT\n");
@@ -219,7 +218,7 @@ static int ufs_trunc_indirect (struct in
 			frag_to_free = tmp;
 			free_count = uspi->s_fpb;
 		}
-		inode->i_blocks -= uspi->s_nspb;
+
 		mark_inode_dirty(inode);
 	}
 
@@ -232,9 +231,9 @@ static int ufs_trunc_indirect (struct in
 	if (i >= uspi->s_apb) {
 		tmp = fs32_to_cpu(sb, *p);
 		*p = 0;
-		inode->i_blocks -= uspi->s_nspb;
-		mark_inode_dirty(inode);
+
 		ufs_free_blocks (inode, tmp, uspi->s_fpb);
+		mark_inode_dirty(inode);
 		ubh_bforget(ind_ubh);
 		ind_ubh = NULL;
 	}
@@ -295,9 +294,9 @@ static int ufs_trunc_dindirect (struct i
 	if (i >= uspi->s_apb) {
 		tmp = fs32_to_cpu(sb, *p);
 		*p = 0;
-		inode->i_blocks -= uspi->s_nspb;
+
+		ufs_free_blocks(inode, tmp, uspi->s_fpb);
 		mark_inode_dirty(inode);
-		ufs_free_blocks (inode, tmp, uspi->s_fpb);
 		ubh_bforget(dind_bh);
 		dind_bh = NULL;
 	}
@@ -355,9 +354,9 @@ static int ufs_trunc_tindirect (struct i
 	if (i >= uspi->s_apb) {
 		tmp = fs32_to_cpu(sb, *p);
 		*p = 0;
-		inode->i_blocks -= uspi->s_nspb;
+
+		ufs_free_blocks(inode, tmp, uspi->s_fpb);
 		mark_inode_dirty(inode);
-		ufs_free_blocks (inode, tmp, uspi->s_fpb);
 		ubh_bforget(tind_bh);
 		tind_bh = NULL;
 	}

-- 
/Evgeniy

