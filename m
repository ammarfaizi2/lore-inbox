Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWAQLel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWAQLel (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 06:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWAQLel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 06:34:41 -0500
Received: from mx2.mail.ru ([194.67.23.122]:1885 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1750731AbWAQLej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 06:34:39 -0500
Date: Tue, 17 Jan 2006 14:21:43 +0300
From: Evgeniy Dushistov <dushistov@mail.ru>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] ufs: rm hang up the kernel
Message-ID: <20060117112143.GA18927@rain.homenetwork>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix the code like this:
bh = sb_find_get_block (sb, tmp + j);
if ((bh && DATA_BUFFER_USED(bh)) || tmp != fs32_to_cpu(sb, *p)) {
	retry = 1;
	brelse (bh);
	goto next1;
}
bforget (bh);

sb_find_get_block ordinary return buffer_head with b_count>=2,
and this code assume that in case if "b_count>1" buffer is used,
so this caused infinite loop.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

diff -uprN -X linux-2.6.15-git11-vanilla/Documentation/dontdiff linux-2.6.15-git11-vanilla/fs/ufs/inode.c linux-2.6.15-git11/fs/ufs/inode.c
--- linux-2.6.15-git11-vanilla/fs/ufs/inode.c	2006-01-17 13:31:27.076516250 +0300
+++ linux-2.6.15-git11/fs/ufs/inode.c	2006-01-17 13:11:37.038143500 +0300
@@ -376,7 +376,7 @@ out:
  * This function gets the block which contains the fragment.
  */
 
-static int ufs_getfrag_block (struct inode *inode, sector_t fragment, struct buffer_head *bh_result, int create)
+int ufs_getfrag_block (struct inode *inode, sector_t fragment, struct buffer_head *bh_result, int create)
 {
 	struct super_block * sb = inode->i_sb;
 	struct ufs_sb_private_info * uspi = UFS_SB(sb)->s_uspi;
diff -uprN -X linux-2.6.15-git11-vanilla/Documentation/dontdiff linux-2.6.15-git11-vanilla/fs/ufs/truncate.c linux-2.6.15-git11/fs/ufs/truncate.c
--- linux-2.6.15-git11-vanilla/fs/ufs/truncate.c	2006-01-17 13:31:27.088517000 +0300
+++ linux-2.6.15-git11/fs/ufs/truncate.c	2006-01-17 13:38:11.861813750 +0300
@@ -29,6 +29,11 @@
  * Idea from Pierre del Perugia <delperug@gla.ecoledoc.ibp.fr>
  */
 
+/*
+ * Modified to avoid infinite loop on 2006 by
+ * Evgeniy Dushistov <dushistov@mail.ru>
+ */
+
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/ufs_fs.h>
@@ -65,19 +70,16 @@
 #define DIRECT_BLOCK ((inode->i_size + uspi->s_bsize - 1) >> uspi->s_bshift)
 #define DIRECT_FRAGMENT ((inode->i_size + uspi->s_fsize - 1) >> uspi->s_fshift)
 
-#define DATA_BUFFER_USED(bh) \
-	(atomic_read(&bh->b_count)>1 || buffer_locked(bh))
 
 static int ufs_trunc_direct (struct inode * inode)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
 	struct super_block * sb;
-	struct ufs_sb_private_info * uspi;
-	struct buffer_head * bh;
+	struct ufs_sb_private_info * uspi;	
 	__fs32 * p;
 	unsigned frag1, frag2, frag3, frag4, block1, block2;
 	unsigned frag_to_free, free_count;
-	unsigned i, j, tmp;
+	unsigned i, tmp;
 	int retry;
 	
 	UFSD(("ENTER\n"))
@@ -117,15 +119,7 @@ static int ufs_trunc_direct (struct inod
 		ufs_panic (sb, "ufs_trunc_direct", "internal error");
 	frag1 = ufs_fragnum (frag1);
 	frag2 = ufs_fragnum (frag2);
-	for (j = frag1; j < frag2; j++) {
-		bh = sb_find_get_block (sb, tmp + j);
-		if ((bh && DATA_BUFFER_USED(bh)) || tmp != fs32_to_cpu(sb, *p)) {
-			retry = 1;
-			brelse (bh);
-			goto next1;
-		}
-		bforget (bh);
-	}
+
 	inode->i_blocks -= (frag2-frag1) << uspi->s_nspfshift;
 	mark_inode_dirty(inode);
 	ufs_free_fragments (inode, tmp + frag1, frag2 - frag1);
@@ -140,15 +134,7 @@ next1:
 		tmp = fs32_to_cpu(sb, *p);
 		if (!tmp)
 			continue;
-		for (j = 0; j < uspi->s_fpb; j++) {
-			bh = sb_find_get_block(sb, tmp + j);
-			if ((bh && DATA_BUFFER_USED(bh)) || tmp != fs32_to_cpu(sb, *p)) {
-				retry = 1;
-				brelse (bh);
-				goto next2;
-			}
-			bforget (bh);
-		}
+
 		*p = 0;
 		inode->i_blocks -= uspi->s_nspb;
 		mark_inode_dirty(inode);
@@ -162,7 +148,6 @@ next1:
 			frag_to_free = tmp;
 			free_count = uspi->s_fpb;
 		}
-next2:;
 	}
 	
 	if (free_count > 0)
@@ -179,15 +164,7 @@ next2:;
 	if (!tmp )
 		ufs_panic(sb, "ufs_truncate_direct", "internal error");
 	frag4 = ufs_fragnum (frag4);
-	for (j = 0; j < frag4; j++) {
-		bh = sb_find_get_block (sb, tmp + j);
-		if ((bh && DATA_BUFFER_USED(bh)) || tmp != fs32_to_cpu(sb, *p)) {
-			retry = 1;
-			brelse (bh);
-			goto next1;
-		}
-		bforget (bh);
-	}
+
 	*p = 0;
 	inode->i_blocks -= frag4 << uspi->s_nspfshift;
 	mark_inode_dirty(inode);
@@ -203,10 +180,9 @@ static int ufs_trunc_indirect (struct in
 {
 	struct super_block * sb;
 	struct ufs_sb_private_info * uspi;
-	struct ufs_buffer_head * ind_ubh;
-	struct buffer_head * bh;
+	struct ufs_buffer_head * ind_ubh;	
 	__fs32 * ind;
-	unsigned indirect_block, i, j, tmp;
+	unsigned indirect_block, i, tmp;
 	unsigned frag_to_free, free_count;
 	int retry;
 
@@ -238,15 +214,7 @@ static int ufs_trunc_indirect (struct in
 		tmp = fs32_to_cpu(sb, *ind);
 		if (!tmp)
 			continue;
-		for (j = 0; j < uspi->s_fpb; j++) {
-			bh = sb_find_get_block(sb, tmp + j);
-			if ((bh && DATA_BUFFER_USED(bh)) || tmp != fs32_to_cpu(sb, *ind)) {
-				retry = 1;
-				brelse (bh);
-				goto next;
-			}
-			bforget (bh);
-		}	
+
 		*ind = 0;
 		ubh_mark_buffer_dirty(ind_ubh);
 		if (free_count == 0) {
@@ -261,7 +229,6 @@ static int ufs_trunc_indirect (struct in
 		}
 		inode->i_blocks -= uspi->s_nspb;
 		mark_inode_dirty(inode);
-next:;
 	}
 
 	if (free_count > 0) {
@@ -429,10 +396,8 @@ void ufs_truncate (struct inode * inode)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
 	struct super_block * sb;
-	struct ufs_sb_private_info * uspi;
-	struct buffer_head * bh;
-	unsigned offset;
-	int err, retry;
+	struct ufs_sb_private_info * uspi;		
+	int retry;
 	
 	UFSD(("ENTER\n"))
 	sb = inode->i_sb;
@@ -442,6 +407,9 @@ void ufs_truncate (struct inode * inode)
 		return;
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
 		return;
+
+	block_truncate_page(inode->i_mapping,	inode->i_size, ufs_getfrag_block);
+
 	lock_kernel();
 	while (1) {
 		retry = ufs_trunc_direct(inode);
@@ -457,15 +425,7 @@ void ufs_truncate (struct inode * inode)
 		blk_run_address_space(inode->i_mapping);
 		yield();
 	}
-	offset = inode->i_size & uspi->s_fshift;
-	if (offset) {
-		bh = ufs_bread (inode, inode->i_size >> uspi->s_fshift, 0, &err);
-		if (bh) {
-			memset (bh->b_data + offset, 0, uspi->s_fsize - offset);
-			mark_buffer_dirty (bh);
-			brelse (bh);
-		}
-	}
+	
 	inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
 	ufsi->i_lastfrag = DIRECT_FRAGMENT;
 	unlock_kernel();
diff -uprN -X linux-2.6.15-git11-vanilla/Documentation/dontdiff linux-2.6.15-git11-vanilla/include/linux/ufs_fs.h linux-2.6.15-git11/include/linux/ufs_fs.h
--- linux-2.6.15-git11-vanilla/include/linux/ufs_fs.h	2006-01-17 13:32:40.765121500 +0300
+++ linux-2.6.15-git11/include/linux/ufs_fs.h	2006-01-17 12:57:14.668248750 +0300
@@ -912,6 +912,7 @@ extern int ufs_sync_inode (struct inode 
 extern void ufs_delete_inode (struct inode *);
 extern struct buffer_head * ufs_getfrag (struct inode *, unsigned, int, int *);
 extern struct buffer_head * ufs_bread (struct inode *, unsigned, int, int *);
+extern int ufs_getfrag_block (struct inode *inode, sector_t fragment, struct buffer_head *bh_result, int create);
 
 /* namei.c */
 extern struct file_operations ufs_dir_operations;

-- 
/Evgeniy

