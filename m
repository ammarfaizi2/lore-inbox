Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbVJJX5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVJJX5Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 19:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVJJX5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 19:57:24 -0400
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:48549 "EHLO
	tux06.ltc.ic.unicamp.br") by vger.kernel.org with ESMTP
	id S1751215AbVJJX5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 19:57:23 -0400
Date: Mon, 10 Oct 2005 21:07:34 -0300
From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, glommer@br.ibm.com,
       mikulas@artax.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       hirofumi@mail.parknet.co.jp, linux-ntfs-dev@lists.sourceforge.net,
       aia21@cantab.net, hch@infradead.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] Use of getblk differs between locations
Message-ID: <20051011000734.GC13399@br.ibm.com>
References: <20051010204517.GA30867@br.ibm.com> <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk> <20051010214605.GA11427@br.ibm.com> <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz> <20051010223636.GB11427@br.ibm.com> <Pine.LNX.4.64.0510102328110.6247@hermes-1.csi.cam.ac.uk> <20051010163648.3e305b63.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20051010163648.3e305b63.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Andrew,

I'm providing a patch that puts the test in some more or less trivial
cases.
Maybe putting them in -mm tree could give them the test environment they
need.
But even if the patch gets in, there are still some cases that I don't
feel comfortable with right now to fix.


On Mon, Oct 10, 2005 at 04:36:48PM -0700, Andrew Morton wrote:
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> >
> >  > Maybe the best solution is neither one nor another. Testing and failing
> >  > gracefully seems better.
> >  > 
> >  > What do you think?
> > 
> >  I certainly agree with you there.  I neither want a deadlock nor 
> >  corruption.  (-:
> 
> Yup.  In the present implementation __getblk_slow() "cannot fail".  It's
> conceivable that at some future stage we'll change __getblk_slow() so that
> it returns NULL on an out-of-memory condition.  Anyone making such a change
> would have to audit all callers to make sure that they handle the NULL
> correctly.
> 
> It is appropriate at this time to fix the callers so that they correctly
> handle the NULL return.  However, it is non-trivial to actually _test_ such
> changes, and such changes should be tested.  Or at least, they should be
> done with considerable care and knowledge of the specific filesystems.  
> 

-- 
=====================================
Glauber de Oliveira Costa
IBM Linux Technology Center - Brazil
glommer@br.ibm.com
=====================================

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch_test_getblk

diff -Naurp linux-2.6.14-rc2-orig/fs/affs/affs.h linux-2.6.14-rc2-cleanp/fs/affs/affs.h
--- linux-2.6.14-rc2-orig/fs/affs/affs.h	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/affs/affs.h	2005-10-10 22:28:30.000000000 +0000
@@ -230,6 +230,8 @@ affs_getzeroblk(struct super_block *sb, 
 	pr_debug("affs_getzeroblk: %d\n", block);
 	if (block >= AFFS_SB(sb)->s_reserved && block < AFFS_SB(sb)->s_partition_size) {
 		bh = sb_getblk(sb, block);
+		if (!bh)
+			return NULL;
 		lock_buffer(bh);
 		memset(bh->b_data, 0 , sb->s_blocksize);
 		set_buffer_uptodate(bh);
@@ -245,6 +247,8 @@ affs_getemptyblk(struct super_block *sb,
 	pr_debug("affs_getemptyblk: %d\n", block);
 	if (block >= AFFS_SB(sb)->s_reserved && block < AFFS_SB(sb)->s_partition_size) {
 		bh = sb_getblk(sb, block);
+		if (!bh)
+			return NULL;
 		wait_on_buffer(bh);
 		set_buffer_uptodate(bh);
 		return bh;
diff -Naurp linux-2.6.14-rc2-orig/fs/bfs/file.c linux-2.6.14-rc2-cleanp/fs/bfs/file.c
--- linux-2.6.14-rc2-orig/fs/bfs/file.c	2005-09-26 13:58:15.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/bfs/file.c	2005-10-10 21:58:23.000000000 +0000
@@ -33,6 +33,8 @@ static int bfs_move_block(unsigned long 
 	if (!bh)
 		return -EIO;
 	new = sb_getblk(sb, to);
+	if (!new)
+		return -EIO;
 	memcpy(new->b_data, bh->b_data, bh->b_size);
 	mark_buffer_dirty(new);
 	bforget(bh);
diff -Naurp linux-2.6.14-rc2-orig/fs/ext2/inode.c linux-2.6.14-rc2-cleanp/fs/ext2/inode.c
--- linux-2.6.14-rc2-orig/fs/ext2/inode.c	2005-09-26 13:58:15.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/ext2/inode.c	2005-10-10 22:31:12.000000000 +0000
@@ -440,6 +440,8 @@ static int ext2_alloc_branch(struct inod
 		 * the pointer to new one, then send parent to disk.
 		 */
 		bh = sb_getblk(inode->i_sb, parent);
+		if (!bh)
+			break;
 		lock_buffer(bh);
 		memset(bh->b_data, 0, blocksize);
 		branch[n].bh = bh;
diff -Naurp linux-2.6.14-rc2-orig/fs/ext3/inode.c linux-2.6.14-rc2-cleanp/fs/ext3/inode.c
--- linux-2.6.14-rc2-orig/fs/ext3/inode.c	2005-10-09 20:26:54.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/ext3/inode.c	2005-10-10 22:38:05.000000000 +0000
@@ -532,6 +532,8 @@ static int ext3_alloc_branch(handle_t *h
 			 */
 			bh = sb_getblk(inode->i_sb, parent);
 			branch[n].bh = bh;
+			if (!bh)
+				break;
 			lock_buffer(bh);
 			BUFFER_TRACE(bh, "call get_create_access");
 			err = ext3_journal_get_create_access(handle, bh);
@@ -864,7 +866,7 @@ struct buffer_head *ext3_getblk(handle_t
 	if (!*errp && buffer_mapped(&dummy)) {
 		struct buffer_head *bh;
 		bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
-		if (buffer_new(&dummy)) {
+		if (bh && buffer_new(&dummy)) {
 			J_ASSERT(create != 0);
 			J_ASSERT(handle != 0);
 
diff -Naurp linux-2.6.14-rc2-orig/fs/minix/itree_common.c linux-2.6.14-rc2-cleanp/fs/minix/itree_common.c
--- linux-2.6.14-rc2-orig/fs/minix/itree_common.c	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/minix/itree_common.c	2005-10-10 22:59:31.000000000 +0000
@@ -84,6 +84,8 @@ static int alloc_branch(struct inode *in
 			break;
 		branch[n].key = cpu_to_block(nr);
 		bh = sb_getblk(inode->i_sb, parent);
+		if (!bh)
+			break;
 		lock_buffer(bh);
 		memset(bh->b_data, 0, BLOCK_SIZE);
 		branch[n].bh = bh;
diff -Naurp linux-2.6.14-rc2-orig/fs/reiserfs/journal.c linux-2.6.14-rc2-cleanp/fs/reiserfs/journal.c
--- linux-2.6.14-rc2-orig/fs/reiserfs/journal.c	2005-09-26 13:58:16.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/reiserfs/journal.c	2005-10-10 22:44:31.000000000 +0000
@@ -2120,7 +2120,7 @@ static int journal_read_transaction(stru
 				      le32_to_cpu(commit->
 						  j_realblock[i - trans_half]));
 		}
-		if (real_blocks[i]->b_blocknr > SB_BLOCK_COUNT(p_s_sb)) {
+		if (real_blocks[i] && real_blocks[i]->b_blocknr > SB_BLOCK_COUNT(p_s_sb)) {
 			reiserfs_warning(p_s_sb,
 					 "journal-1207: REPLAY FAILURE fsck required! Block to replay is outside of filesystem");
 			goto abort_replay;
diff -Naurp linux-2.6.14-rc2-orig/fs/reiserfs/stree.c linux-2.6.14-rc2-cleanp/fs/reiserfs/stree.c
--- linux-2.6.14-rc2-orig/fs/reiserfs/stree.c	2005-09-01 14:26:04.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/reiserfs/stree.c	2005-10-10 22:56:14.000000000 +0000
@@ -664,7 +664,7 @@ int search_by_key(struct super_block *p_
 		   have a pointer to it. */
 		if ((p_s_bh = p_s_last_element->pe_buffer =
 		     sb_getblk(p_s_sb, n_block_number))) {
-			if (!buffer_uptodate(p_s_bh) && reada_count > 1) {
+			if (p_s_sb && !buffer_uptodate(p_s_bh) && reada_count > 1) {
 				search_by_key_reada(p_s_sb, reada_bh,
 						    reada_blocks, reada_count);
 			}
diff -Naurp linux-2.6.14-rc2-orig/fs/sysv/itree.c linux-2.6.14-rc2-cleanp/fs/sysv/itree.c
--- linux-2.6.14-rc2-orig/fs/sysv/itree.c	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/sysv/itree.c	2005-10-10 22:41:35.000000000 +0000
@@ -144,6 +144,8 @@ static int alloc_branch(struct inode *in
 		 */
 		parent = block_to_cpu(SYSV_SB(inode->i_sb), branch[n-1].key);
 		bh = sb_getblk(inode->i_sb, parent);
+		if (!bh)
+			break;
 		lock_buffer(bh);
 		memset(bh->b_data, 0, blocksize);
 		branch[n].bh = bh;

--DocE+STaALJfprDB--
