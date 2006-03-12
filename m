Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWCLXyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWCLXyy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 18:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWCLXys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 18:54:48 -0500
Received: from mx1.suse.de ([195.135.220.2]:42887 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932280AbWCLXyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 18:54:36 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 13 Mar 2006 10:53:26 +1100
Message-Id: <1060312235326.15972@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 003 of 4] Make address_space_operations->sync_page return void.
References: <20060313104910.15881.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The only user ignores the return value, and the only 
instanace (block_sync_page) always returns 0...


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/buffer.c                 |    3 +--
 ./fs/cifs/file.c              |    6 ++++--
 ./include/linux/buffer_head.h |    2 +-
 ./include/linux/fs.h          |    2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff ./fs/buffer.c~current~ ./fs/buffer.c
--- ./fs/buffer.c~current~	2006-03-09 17:29:35.000000000 +1100
+++ ./fs/buffer.c	2006-03-13 10:46:35.000000000 +1100
@@ -3024,7 +3024,7 @@ out:
 }
 EXPORT_SYMBOL(try_to_free_buffers);
 
-int block_sync_page(struct page *page)
+void block_sync_page(struct page *page)
 {
 	struct address_space *mapping;
 
@@ -3032,7 +3032,6 @@ int block_sync_page(struct page *page)
 	mapping = page_mapping(page);
 	if (mapping)
 		blk_run_backing_dev(mapping->backing_dev_info, page);
-	return 0;
 }
 
 /*

diff ./fs/cifs/file.c~current~ ./fs/cifs/file.c
--- ./fs/cifs/file.c~current~	2006-03-09 17:29:35.000000000 +1100
+++ ./fs/cifs/file.c	2006-03-13 10:46:35.000000000 +1100
@@ -1377,7 +1377,7 @@ int cifs_fsync(struct file *file, struct
 	return rc;
 }
 
-/* static int cifs_sync_page(struct page *page)
+/* static void cifs_sync_page(struct page *page)
 {
 	struct address_space *mapping;
 	struct inode *inode;
@@ -1391,16 +1391,18 @@ int cifs_fsync(struct file *file, struct
 		return 0;
 	inode = mapping->host;
 	if (!inode)
-		return 0; */
+		return; */
 
 /*	fill in rpages then 
 	result = cifs_pagein_inode(inode, index, rpages); */ /* BB finish */
 
 /*	cFYI(1, ("rpages is %d for sync page of Index %ld ", rpages, index));
 
+#if 0
 	if (rc < 0)
 		return rc;
 	return 0;
+#endif
 } */
 
 /*

diff ./include/linux/buffer_head.h~current~ ./include/linux/buffer_head.h
--- ./include/linux/buffer_head.h~current~	2006-03-09 17:29:35.000000000 +1100
+++ ./include/linux/buffer_head.h	2006-03-13 10:46:35.000000000 +1100
@@ -203,7 +203,7 @@ int cont_prepare_write(struct page*, uns
 int generic_cont_expand(struct inode *inode, loff_t size);
 int generic_cont_expand_simple(struct inode *inode, loff_t size);
 int block_commit_write(struct page *page, unsigned from, unsigned to);
-int block_sync_page(struct page *);
+void block_sync_page(struct page *);
 sector_t generic_block_bmap(struct address_space *, sector_t, get_block_t *);
 int generic_commit_write(struct file *, struct page *, unsigned, unsigned);
 int block_truncate_page(struct address_space *, loff_t, get_block_t *);

diff ./include/linux/fs.h~current~ ./include/linux/fs.h
--- ./include/linux/fs.h~current~	2006-03-09 17:29:35.000000000 +1100
+++ ./include/linux/fs.h	2006-03-13 10:46:35.000000000 +1100
@@ -345,7 +345,7 @@ struct writeback_control;
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
 	int (*readpage)(struct file *, struct page *);
-	int (*sync_page)(struct page *);
+	void (*sync_page)(struct page *);
 
 	/* Write back some dirty pages from this mapping. */
 	int (*writepages)(struct address_space *, struct writeback_control *);
