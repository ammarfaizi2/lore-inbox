Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbVKPRo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbVKPRo1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 12:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbVKPRo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 12:44:27 -0500
Received: from pat.uio.no ([129.240.130.16]:65010 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030285AbVKPRo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 12:44:26 -0500
Subject: Re: mmap over nfs leads to excessive system load
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051116150141.29549.qmail@web34113.mail.mud.yahoo.com>
References: <20051116150141.29549.qmail@web34113.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 12:44:17 -0500
Message-Id: <1132163057.8811.15.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.958, required 12,
	autolearn=disabled, AWL 1.04, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 07:01 -0800, Kenny Simpson wrote:
> --- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > Anyhow, does the following patch help?
> 
> Unfortunately, not:
> 
> samples  %        symbol name
> 545009   15.2546  find_get_pages_tag

Argh... I totally missed the point there with the last patch. We should
be resyncing the page tag with the value of the PG_dirty flag...

OK, please back out the patch that I sent you, and try this one instead.

Cheers,
 Trond

------
NFS: resync to yet more writepage() changes...

 Ensure that we call clear_page_dirty() for pages that have been written
 via writepage().

 Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/write.c      |    2 ++
 include/linux/mm.h  |    1 +
 mm/page-writeback.c |   20 ++++++++++++++++++++
 3 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 8f71e76..61ec355 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -213,6 +213,7 @@ static int nfs_writepage_sync(struct nfs
 	} while (count);
 	/* Update file length */
 	nfs_grow_file(page, offset, written);
+	clear_page_dirty_tag(page);
 	/* Set the PG_uptodate flag? */
 	nfs_mark_uptodate(page, offset, written);
 
@@ -238,6 +239,7 @@ static int nfs_writepage_async(struct nf
 		goto out;
 	/* Update file length */
 	nfs_grow_file(page, offset, count);
+	clear_page_dirty_tag(page);
 	/* Set the PG_uptodate flag? */
 	nfs_mark_uptodate(page, offset, count);
 	nfs_unlock_request(req);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1013a42..cb1cfe1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -730,6 +730,7 @@ int redirty_page_for_writepage(struct wr
 int FASTCALL(set_page_dirty(struct page *page));
 int set_page_dirty_lock(struct page *page);
 int clear_page_dirty_for_io(struct page *page);
+int clear_page_dirty_tag(struct page *page);
 
 extern unsigned long do_mremap(unsigned long addr,
 			       unsigned long old_len, unsigned long new_len,
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 74138c9..65c58fa 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -751,6 +751,26 @@ int clear_page_dirty_for_io(struct page 
 	return TestClearPageDirty(page);
 }
 
+/*
+ * Clears the page dirty tag. See comment in clear_page_dirty_for_io()
+ */
+int clear_page_dirty_tag(struct page *page)
+{
+	struct address_space *mapping = page_mapping(page);
+
+	if (mapping) {
+		unsigned long flags;
+
+		write_lock_irqsave(&mapping->tree_lock, flags);
+		if (!PageDirty(page))
+			radix_tree_tag_clear(&mapping->page_tree,
+						page_index(page),
+						PAGECACHE_TAG_DIRTY);
+		write_unlock_irqrestore(&mapping->tree_lock, flags);
+	}
+}
+EXPORT_SYMBOL(clear_page_dirty_tag);
+
 int test_clear_page_writeback(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);


