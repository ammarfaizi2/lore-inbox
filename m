Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264435AbTDXFLI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 01:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264440AbTDXFLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 01:11:08 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:9114 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264435AbTDXFLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 01:11:01 -0400
Date: Thu, 24 Apr 2003 10:58:05 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: bcrl@redhat.com, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/7] Filesystem AIO rdwr: async get block for ext2
Message-ID: <20030424105805.G2288@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030424102221.A2166@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030424102221.A2166@in.ibm.com>; from suparna@in.ibm.com on Thu, Apr 24, 2003 at 10:22:22AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 10:22:22AM +0530, Suparna Bhattacharya wrote:
> Here is a revised version of the filesystem AIO patches
> for 2.5.68.
> 
> 07ext2getblk_wq.patch	: Async get block support for 
> 			  the ext2 filesystem

ext2_get_block_wq() is used only by ext2_prepare_write().
All other cases still use the synchronous get block
version.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

07ext2getblk_wq.patch
.....................
 fs/ext2/inode.c |   44 +++++++++++++++++++++++++++++++++++---------
 1 files changed, 35 insertions(+), 9 deletions(-)


diff -ur -X /home/kiran/dontdiff linux-2.5.68/fs/ext2/inode.c linux-aio-2568/fs/ext2/inode.c
--- linux-2.5.68/fs/ext2/inode.c	Fri Apr 11 21:10:49 2003
+++ linux-aio-2568/fs/ext2/inode.c	Wed Apr 16 22:48:49 2003
@@ -257,11 +258,12 @@
  *	or when it reads all @depth-1 indirect blocks successfully and finds
  *	the whole chain, all way to the data (returns %NULL, *err == 0).
  */
-static Indirect *ext2_get_branch(struct inode *inode,
+static Indirect *ext2_get_branch_wq(struct inode *inode,
 				 int depth,
 				 int *offsets,
 				 Indirect chain[4],
-				 int *err)
+				 int *err,
+				 wait_queue_t *wait)
 {
 	struct super_block *sb = inode->i_sb;
 	Indirect *p = chain;
@@ -273,8 +275,8 @@
 	if (!p->key)
 		goto no_block;
 	while (--depth) {
-		bh = sb_bread(sb, le32_to_cpu(p->key));
-		if (!bh)
+		bh = sb_bread_wq(sb, le32_to_cpu(p->key), wait);
+		if (!bh || IS_ERR(bh))
 			goto failure;
 		read_lock(&EXT2_I(inode)->i_meta_lock);
 		if (!verify_chain(chain, p))
@@ -292,11 +294,21 @@
 	*err = -EAGAIN;
 	goto no_block;
 failure:
-	*err = -EIO;
+	*err = IS_ERR(bh) ? PTR_ERR(bh) : -EIO;
 no_block:
 	return p;
 }
 
+static Indirect *ext2_get_branch(struct inode *inode,
+				 int depth,
+				 int *offsets,
+				 Indirect chain[4],
+				 int *err)
+{
+	return ext2_get_branch_wq(inode, depth, offsets, chain, 
+		err, NULL);
+}
+
 /**
  *	ext2_find_near - find a place for allocation with sufficient locality
  *	@inode: owner
@@ -536,7 +548,8 @@
  * reachable from inode.
  */
 
-static int ext2_get_block(struct inode *inode, sector_t iblock, struct buffer_head *bh_result, int create)
+static int ext2_get_block_wq(struct inode *inode, sector_t iblock, 
+	struct buffer_head *bh_result, int create, wait_queue_t *wait)
 {
 	int err = -EIO;
 	int offsets[4];
@@ -551,7 +564,8 @@
 		goto out;
 
 reread:
-	partial = ext2_get_branch(inode, depth, offsets, chain, &err);
+	partial = ext2_get_branch_wq(inode, depth, offsets, chain, &err, 
+		wait);
 
 	/* Simplest case - block found, no allocation needed */
 	if (!partial) {
@@ -565,7 +579,7 @@
 	}
 
 	/* Next simple case - plain lookup or failed read of indirect block */
-	if (!create || err == -EIO) {
+	if (!create || err == -EIO || err == -EIOCBRETRY) {
 cleanup:
 		while (partial > chain) {
 			brelse(partial->bh);
@@ -606,6 +620,19 @@
 	goto reread;
 }
 
+static int ext2_get_block_async(struct inode *inode, sector_t iblock, 
+	struct buffer_head *bh_result, int create)
+{
+	return ext2_get_block_wq(inode, iblock, bh_result, create, 
+		current->io_wait);
+}
+
+static int ext2_get_block(struct inode *inode, sector_t iblock, 
+	struct buffer_head *bh_result, int create)
+{
+	return ext2_get_block_wq(inode, iblock, bh_result, create, NULL);
+}
+
 static int ext2_writepage(struct page *page, struct writeback_control *wbc)
 {
 	return block_write_full_page(page, ext2_get_block, wbc);
@@ -627,7 +654,7 @@
 ext2_prepare_write(struct file *file, struct page *page,
 			unsigned from, unsigned to)
 {
-	return block_prepare_write(page,from,to,ext2_get_block);
+	return block_prepare_write(page,from,to,ext2_get_block_async);
 }
 
 static int
