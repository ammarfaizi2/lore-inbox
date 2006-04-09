Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWDIISK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWDIISK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 04:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWDIISK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 04:18:10 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:22707 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750702AbWDIISI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 04:18:08 -0400
Subject: [PATCH] read_mapping_page for address space
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date: Sun, 09 Apr 2006 11:18:05 +0300
Message-Id: <1144570685.11150.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch adds read_mapping_page function which is the used for
callers that pass mapping->a_ops->readpage as the filler for
read_cache_page. This removes some duplication from filesystem
code.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

---

 fs/afs/dir.c            |    4 +---
 fs/afs/mntpt.c          |   11 ++---------
 fs/cramfs/inode.c       |    4 +---
 fs/ext2/dir.c           |    3 +--
 fs/freevxfs/vxfs_subr.c |    3 +--
 fs/hfs/bnode.c          |    2 +-
 fs/hfs/btree.c          |    2 +-
 fs/hfsplus/bitmap.c     |   15 +++++++--------
 fs/hfsplus/bnode.c      |    2 +-
 fs/hfsplus/btree.c      |    2 +-
 fs/jfs/jfs_metapage.c   |    5 ++---
 fs/minix/dir.c          |    3 +--
 fs/namei.c              |    3 +--
 fs/ntfs/aops.h          |    3 +--
 fs/ntfs/attrib.c        |    6 ++----
 fs/ntfs/file.c          |    3 +--
 fs/ocfs2/symlink.c      |    3 +--
 fs/partitions/check.c   |    4 ++--
 fs/reiserfs/xattr.c     |    3 +--
 fs/sysv/dir.c           |    3 +--
 include/linux/pagemap.h |    7 +++++++
 mm/swapfile.c           |    3 +--
 22 files changed, 38 insertions(+), 56 deletions(-)

caac39476851978a912f8837aa5fd5e92fa2213f
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index a6dff6a..2fc9987 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -185,9 +185,7 @@ static struct page *afs_dir_get_page(str
 
 	_enter("{%lu},%lu", dir->i_ino, index);
 
-	page = read_cache_page(dir->i_mapping,index,
-			       (filler_t *) dir->i_mapping->a_ops->readpage,
-			       NULL);
+	page = read_mapping_page(dir->i_mapping, index, NULL);
 	if (!IS_ERR(page)) {
 		wait_on_page_locked(page);
 		kmap(page);
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 4e6eeb5..b5cf9e1 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -63,7 +63,6 @@ unsigned long afs_mntpt_expiry_timeout =
 int afs_mntpt_check_symlink(struct afs_vnode *vnode)
 {
 	struct page *page;
-	filler_t *filler;
 	size_t size;
 	char *buf;
 	int ret;
@@ -71,10 +70,7 @@ int afs_mntpt_check_symlink(struct afs_v
 	_enter("{%u,%u}", vnode->fid.vnode, vnode->fid.unique);
 
 	/* read the contents of the symlink into the pagecache */
-	filler = (filler_t *) AFS_VNODE_TO_I(vnode)->i_mapping->a_ops->readpage;
-
-	page = read_cache_page(AFS_VNODE_TO_I(vnode)->i_mapping, 0,
-			       filler, NULL);
+	page = read_mapping_page(AFS_VNODE_TO_I(vnode)->i_mapping, 0, NULL);
 	if (IS_ERR(page)) {
 		ret = PTR_ERR(page);
 		goto out;
@@ -160,7 +156,6 @@ static struct vfsmount *afs_mntpt_do_aut
 	struct page *page = NULL;
 	size_t size;
 	char *buf, *devname = NULL, *options = NULL;
-	filler_t *filler;
 	int ret;
 
 	kenter("{%s}", mntpt->d_name.name);
@@ -182,9 +177,7 @@ static struct vfsmount *afs_mntpt_do_aut
 		goto error;
 
 	/* read the contents of the AFS special symlink */
-	filler = (filler_t *)mntpt->d_inode->i_mapping->a_ops->readpage;
-
-	page = read_cache_page(mntpt->d_inode->i_mapping, 0, filler, NULL);
+	page = read_mapping_page(mntpt->d_inode->i_mapping, 0, NULL);
 	if (IS_ERR(page)) {
 		ret = PTR_ERR(page);
 		goto error;
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 9efcc3a..ccd3f96 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -181,9 +181,7 @@ static void *cramfs_read(struct super_bl
 		struct page *page = NULL;
 
 		if (blocknr + i < devsize) {
-			page = read_cache_page(mapping, blocknr + i,
-				(filler_t *)mapping->a_ops->readpage,
-				NULL);
+			page = read_mapping_page(mapping, blocknr + i, NULL);
 			/* synchronous error? */
 			if (IS_ERR(page))
 				page = NULL;
diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index d672aa9..3c1c9aa 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -159,8 +159,7 @@ fail:
 static struct page * ext2_get_page(struct inode *dir, unsigned long n)
 {
 	struct address_space *mapping = dir->i_mapping;
-	struct page *page = read_cache_page(mapping, n,
-				(filler_t*)mapping->a_ops->readpage, NULL);
+	struct page *page = read_mapping_page(mapping, n, NULL);
 	if (!IS_ERR(page)) {
 		wait_on_page_locked(page);
 		kmap(page);
diff --git a/fs/freevxfs/vxfs_subr.c b/fs/freevxfs/vxfs_subr.c
index 50aae77..c1be118 100644
--- a/fs/freevxfs/vxfs_subr.c
+++ b/fs/freevxfs/vxfs_subr.c
@@ -71,8 +71,7 @@ vxfs_get_page(struct address_space *mapp
 {
 	struct page *			pp;
 
-	pp = read_cache_page(mapping, n,
-			(filler_t*)mapping->a_ops->readpage, NULL);
+	pp = read_mapping_page(mapping, n, NULL);
 
 	if (!IS_ERR(pp)) {
 		wait_on_page_locked(pp);
diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 1e44dcf..13231dd 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -280,7 +280,7 @@ static struct hfs_bnode *__hfs_bnode_cre
 	block = off >> PAGE_CACHE_SHIFT;
 	node->page_offset = off & ~PAGE_CACHE_MASK;
 	for (i = 0; i < tree->pages_per_bnode; i++) {
-		page = read_cache_page(mapping, block++, (filler_t *)mapping->a_ops->readpage, NULL);
+		page = read_mapping_page(mapping, block++, NULL);
 		if (IS_ERR(page))
 			goto fail;
 		if (PageError(page)) {
diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index d20131c..4003579 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -59,7 +59,7 @@ struct hfs_btree *hfs_btree_open(struct 
 	unlock_new_inode(tree->inode);
 
 	mapping = tree->inode->i_mapping;
-	page = read_cache_page(mapping, 0, (filler_t *)mapping->a_ops->readpage, NULL);
+	page = read_mapping_page(mapping, 0, NULL);
 	if (IS_ERR(page))
 		goto free_tree;
 
diff --git a/fs/hfsplus/bitmap.c b/fs/hfsplus/bitmap.c
index 9fb5163..d128a25 100644
--- a/fs/hfsplus/bitmap.c
+++ b/fs/hfsplus/bitmap.c
@@ -31,8 +31,7 @@ int hfsplus_block_allocate(struct super_
 	dprint(DBG_BITMAP, "block_allocate: %u,%u,%u\n", size, offset, len);
 	mutex_lock(&HFSPLUS_SB(sb).alloc_file->i_mutex);
 	mapping = HFSPLUS_SB(sb).alloc_file->i_mapping;
-	page = read_cache_page(mapping, offset / PAGE_CACHE_BITS,
-			       (filler_t *)mapping->a_ops->readpage, NULL);
+	page = read_mapping_page(mapping, offset / PAGE_CACHE_BITS, NULL);
 	pptr = kmap(page);
 	curr = pptr + (offset & (PAGE_CACHE_BITS - 1)) / 32;
 	i = offset % 32;
@@ -72,8 +71,8 @@ int hfsplus_block_allocate(struct super_
 		offset += PAGE_CACHE_BITS;
 		if (offset >= size)
 			break;
-		page = read_cache_page(mapping, offset / PAGE_CACHE_BITS,
-				       (filler_t *)mapping->a_ops->readpage, NULL);
+		page = read_mapping_page(mapping, offset / PAGE_CACHE_BITS,
+					 NULL);
 		curr = pptr = kmap(page);
 		if ((size ^ offset) / PAGE_CACHE_BITS)
 			end = pptr + PAGE_CACHE_BITS / 32;
@@ -119,8 +118,8 @@ found:
 		set_page_dirty(page);
 		kunmap(page);
 		offset += PAGE_CACHE_BITS;
-		page = read_cache_page(mapping, offset / PAGE_CACHE_BITS,
-				       (filler_t *)mapping->a_ops->readpage, NULL);
+		page = read_mapping_page(mapping, offset / PAGE_CACHE_BITS,
+					 NULL);
 		pptr = kmap(page);
 		curr = pptr;
 		end = pptr + PAGE_CACHE_BITS / 32;
@@ -167,7 +166,7 @@ int hfsplus_block_free(struct super_bloc
 	mutex_lock(&HFSPLUS_SB(sb).alloc_file->i_mutex);
 	mapping = HFSPLUS_SB(sb).alloc_file->i_mapping;
 	pnr = offset / PAGE_CACHE_BITS;
-	page = read_cache_page(mapping, pnr, (filler_t *)mapping->a_ops->readpage, NULL);
+	page = read_mapping_page(mapping, pnr, NULL);
 	pptr = kmap(page);
 	curr = pptr + (offset & (PAGE_CACHE_BITS - 1)) / 32;
 	end = pptr + PAGE_CACHE_BITS / 32;
@@ -199,7 +198,7 @@ int hfsplus_block_free(struct super_bloc
 			break;
 		set_page_dirty(page);
 		kunmap(page);
-		page = read_cache_page(mapping, ++pnr, (filler_t *)mapping->a_ops->readpage, NULL);
+		page = read_mapping_page(mapping, ++pnr, NULL);
 		pptr = kmap(page);
 		curr = pptr;
 		end = pptr + PAGE_CACHE_BITS / 32;
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 746abc9..77bf434 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -440,7 +440,7 @@ static struct hfs_bnode *__hfs_bnode_cre
 	block = off >> PAGE_CACHE_SHIFT;
 	node->page_offset = off & ~PAGE_CACHE_MASK;
 	for (i = 0; i < tree->pages_per_bnode; block++, i++) {
-		page = read_cache_page(mapping, block, (filler_t *)mapping->a_ops->readpage, NULL);
+		page = read_mapping_page(mapping, block, NULL);
 		if (IS_ERR(page))
 			goto fail;
 		if (PageError(page)) {
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index effa899..cfc852f 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -38,7 +38,7 @@ struct hfs_btree *hfs_btree_open(struct 
 		goto free_tree;
 
 	mapping = tree->inode->i_mapping;
-	page = read_cache_page(mapping, 0, (filler_t *)mapping->a_ops->readpage, NULL);
+	page = read_mapping_page(mapping, 0, NULL);
 	if (IS_ERR(page))
 		goto free_tree;
 
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index f28696f..e5cc762 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -642,10 +642,9 @@ struct metapage *__get_metapage(struct i
 		}
 		SetPageUptodate(page);
 	} else {
-		page = read_cache_page(mapping, page_index,
-			    (filler_t *)mapping->a_ops->readpage, NULL);
+		page = read_mapping_page(mapping, page_index, NULL);
 		if (IS_ERR(page) || !PageUptodate(page)) {
-			jfs_err("read_cache_page failed!");
+			jfs_err("read_mapping_page failed!");
 			return NULL;
 		}
 		lock_page(page);
diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index 69224d1..2b0a389 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -60,8 +60,7 @@ static int dir_commit_chunk(struct page 
 static struct page * dir_get_page(struct inode *dir, unsigned long n)
 {
 	struct address_space *mapping = dir->i_mapping;
-	struct page *page = read_cache_page(mapping, n,
-				(filler_t*)mapping->a_ops->readpage, NULL);
+	struct page *page = read_mapping_page(mapping, n, NULL);
 	if (!IS_ERR(page)) {
 		wait_on_page_locked(page);
 		kmap(page);
diff --git a/fs/namei.c b/fs/namei.c
index 96723ae..71f48fa 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2576,8 +2576,7 @@ static char *page_getlink(struct dentry 
 {
 	struct page * page;
 	struct address_space *mapping = dentry->d_inode->i_mapping;
-	page = read_cache_page(mapping, 0, (filler_t *)mapping->a_ops->readpage,
-				NULL);
+	page = read_mapping_page(mapping, 0, NULL);
 	if (IS_ERR(page))
 		goto sync_fail;
 	wait_on_page_locked(page);
diff --git a/fs/ntfs/aops.h b/fs/ntfs/aops.h
index 3b74e66..325ce26 100644
--- a/fs/ntfs/aops.h
+++ b/fs/ntfs/aops.h
@@ -86,8 +86,7 @@ static inline void ntfs_unmap_page(struc
 static inline struct page *ntfs_map_page(struct address_space *mapping,
 		unsigned long index)
 {
-	struct page *page = read_cache_page(mapping, index,
-			(filler_t*)mapping->a_ops->readpage, NULL);
+	struct page *page = read_mapping_page(mapping, index, NULL);
 
 	if (!IS_ERR(page)) {
 		wait_on_page_locked(page);
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 1663f5c..6708e1d 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -2529,8 +2529,7 @@ int ntfs_attr_set(ntfs_inode *ni, const 
 	end >>= PAGE_CACHE_SHIFT;
 	/* If there is a first partial page, need to do it the slow way. */
 	if (start_ofs) {
-		page = read_cache_page(mapping, idx,
-				(filler_t*)mapping->a_ops->readpage, NULL);
+		page = read_mapping_page(mapping, idx, NULL);
 		if (IS_ERR(page)) {
 			ntfs_error(vol->sb, "Failed to read first partial "
 					"page (sync error, index 0x%lx).", idx);
@@ -2600,8 +2599,7 @@ int ntfs_attr_set(ntfs_inode *ni, const 
 	}
 	/* If there is a last partial page, need to do it the slow way. */
 	if (end_ofs) {
-		page = read_cache_page(mapping, idx,
-				(filler_t*)mapping->a_ops->readpage, NULL);
+		page = read_mapping_page(mapping, idx, NULL);
 		if (IS_ERR(page)) {
 			ntfs_error(vol->sb, "Failed to read last partial page "
 					"(sync error, index 0x%lx).", idx);
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index c63a83e..05a2d83 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -231,8 +231,7 @@ do_non_resident_extend:
 		 * Read the page.  If the page is not present, this will zero
 		 * the uninitialized regions for us.
 		 */
-		page = read_cache_page(mapping, index,
-				(filler_t*)mapping->a_ops->readpage, NULL);
+		page = read_mapping_page(mapping, index, NULL);
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
 			goto init_err_out;
diff --git a/fs/ocfs2/symlink.c b/fs/ocfs2/symlink.c
index f6986bd..0c8a129 100644
--- a/fs/ocfs2/symlink.c
+++ b/fs/ocfs2/symlink.c
@@ -64,8 +64,7 @@ static char *ocfs2_page_getlink(struct d
 {
 	struct page * page;
 	struct address_space *mapping = dentry->d_inode->i_mapping;
-	page = read_cache_page(mapping, 0,
-			       (filler_t *)mapping->a_ops->readpage, NULL);
+	page = read_mapping_page(mapping, 0, NULL);
 	if (IS_ERR(page))
 		goto sync_fail;
 	wait_on_page_locked(page);
diff --git a/fs/partitions/check.c b/fs/partitions/check.c
index af0cb4b..31b923c 100644
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -469,8 +469,8 @@ unsigned char *read_dev_sector(struct bl
 	struct address_space *mapping = bdev->bd_inode->i_mapping;
 	struct page *page;
 
-	page = read_cache_page(mapping, (pgoff_t)(n >> (PAGE_CACHE_SHIFT-9)),
-			(filler_t *)mapping->a_ops->readpage, NULL);
+	page = read_mapping_page(mapping, (pgoff_t)(n >> (PAGE_CACHE_SHIFT-9)),
+				 NULL);
 	if (!IS_ERR(page)) {
 		wait_on_page_locked(page);
 		if (!PageUptodate(page))
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index ffb79c4..39fedaa 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -452,8 +452,7 @@ static struct page *reiserfs_get_page(st
 	/* We can deadlock if we try to free dentries,
 	   and an unlink/rmdir has just occured - GFP_NOFS avoids this */
 	mapping_set_gfp_mask(mapping, GFP_NOFS);
-	page = read_cache_page(mapping, n,
-			       (filler_t *) mapping->a_ops->readpage, NULL);
+	page = read_mapping_page(mapping, n, NULL);
 	if (!IS_ERR(page)) {
 		wait_on_page_locked(page);
 		kmap(page);
diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index d707434..f2bef96 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -53,8 +53,7 @@ static int dir_commit_chunk(struct page 
 static struct page * dir_get_page(struct inode *dir, unsigned long n)
 {
 	struct address_space *mapping = dir->i_mapping;
-	struct page *page = read_cache_page(mapping, n,
-				(filler_t*)mapping->a_ops->readpage, NULL);
+	struct page *page = read_mapping_page(mapping, n, NULL);
 	if (!IS_ERR(page)) {
 		wait_on_page_locked(page);
 		kmap(page);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 9539efd..7815154 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -97,6 +97,13 @@ extern struct page * read_cache_page(str
 extern int read_cache_pages(struct address_space *mapping,
 		struct list_head *pages, filler_t *filler, void *data);
 
+static inline struct page *read_mapping_page(struct address_space *mapping,
+					     unsigned long index, void *data)
+{
+	filler_t *filler = (filler_t *) mapping->a_ops->readpage;
+	return read_cache_page(mapping, index, filler, data);
+}
+
 int add_to_page_cache(struct page *page, struct address_space *mapping,
 				unsigned long index, gfp_t gfp_mask);
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e5fd538..b01b827 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1504,8 +1504,7 @@ asmlinkage long sys_swapon(const char __
 		error = -EINVAL;
 		goto bad_swap;
 	}
-	page = read_cache_page(mapping, 0,
-			(filler_t *)mapping->a_ops->readpage, swap_file);
+	page = read_mapping_page(mapping, 0, swap_file);
 	if (IS_ERR(page)) {
 		error = PTR_ERR(page);
 		goto bad_swap;
-- 
1.2.4



