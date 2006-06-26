Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWFZNmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWFZNmt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 09:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWFZNmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 09:42:49 -0400
Received: from mx2.mail.ru ([194.67.23.122]:41768 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S964889AbWFZNmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 09:42:47 -0400
Date: Mon, 26 Jun 2006 17:48:36 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC] [PATCH 2/3]: ufs: track i_size
Message-ID: <20060626134836.GA8400@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To make possible proper work of `ufs_truncate'(see the next patch),
I need to know old size of file in` ufs_truncate',
but for some unknown for me reason VFS layer doesn't tell
old size to file system, or at least I don't find way to get
this information. 
So I have to add per each inode `loff_t' field and update it
in
- alloc inode
- read inode
- commit write
- truncate(see the next patch)
is this right way to know "old size" in truncate method?

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

Index: linux-2.6.17-mm2/fs/ufs/ialloc.c
===================================================================
--- linux-2.6.17-mm2.orig/fs/ufs/ialloc.c
+++ linux-2.6.17-mm2/fs/ufs/ialloc.c
@@ -265,6 +265,7 @@ cg_found:
 	ufsi->i_osync = 0;
 	ufsi->i_oeftflag = 0;
 	ufsi->i_dir_start_lookup = 0;
+	ufsi->i_size = 0;
 	memset(&ufsi->i_u1, 0, sizeof(ufsi->i_u1));
 
 	insert_inode_hash(inode);
Index: linux-2.6.17-mm2/fs/ufs/inode.c
===================================================================
--- linux-2.6.17-mm2.orig/fs/ufs/inode.c
+++ linux-2.6.17-mm2/fs/ufs/inode.c
@@ -574,12 +574,25 @@ static sector_t ufs_bmap(struct address_
 {
 	return generic_block_bmap(mapping,block,ufs_getfrag_block);
 }
+
+/*
+ * we have to update our internal i_size holder,
+ * because of we want know old size in truncate
+ */
+static int ufs_commit_write(struct file *file, struct page *page,
+			    unsigned from, unsigned to)
+{
+	UFS_I(page->mapping->host)->i_size =
+		((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
+	return generic_commit_write(file, page, from, to);
+}
+
 const struct address_space_operations ufs_aops = {
 	.readpage = ufs_readpage,
 	.writepage = ufs_writepage,
 	.sync_page = block_sync_page,
 	.prepare_write = ufs_prepare_write,
-	.commit_write = generic_commit_write,
+	.commit_write = ufs_commit_write,
 	.bmap = ufs_bmap
 };
 
@@ -738,6 +751,7 @@ void ufs_read_inode(struct inode * inode
 		(inode->i_size + uspi->s_fsize - 1) >> uspi->s_fshift;
 	ufsi->i_dir_start_lookup = 0;
 	ufsi->i_osync = 0;
+	ufsi->i_size = inode->i_size;
 
 	ufs_set_inode_ops(inode);
 
Index: linux-2.6.17-mm2/include/linux/ufs_fs_i.h
===================================================================
--- linux-2.6.17-mm2.orig/include/linux/ufs_fs_i.h
+++ linux-2.6.17-mm2/include/linux/ufs_fs_i.h
@@ -28,6 +28,7 @@ struct ufs_inode_info {
 	__u16	i_osync;
 	__u32	i_lastfrag;
 	__u32   i_dir_start_lookup;
+	loff_t	i_size;
 	struct inode vfs_inode;
 };
 


-- 
/Evgeniy

