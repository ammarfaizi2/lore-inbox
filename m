Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbTDOF5o (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 01:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbTDOF5o (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 01:57:44 -0400
Received: from holomorphy.com ([66.224.33.161]:6277 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264274AbTDOF5k (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 01:57:40 -0400
Date: Mon, 14 Apr 2003 23:09:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.67-mm3
Message-ID: <20030415060907.GB12487@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030414015313.4f6333ad.akpm@digeo.com> <20030415020057.GC706@holomorphy.com> <20030415041759.GA12487@holomorphy.com> <20030414213114.37dc7879.akpm@digeo.com> <20030415043947.GD706@holomorphy.com> <20030414215541.0aff47bc.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030414215541.0aff47bc.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

william Lee Irwin III <wli@holomorphy.com> wrote:
>> I'm just going down the list of FIXME's in the VM I turned up by grepping.
>> Should we do the following instead?

On Mon, Apr 14, 2003 at 09:55:41PM -0700, Andrew Morton wrote:
> OK ;)

Okay, these don't get us all the way there, but at least it gets us
closer: there are "FIXME" things associated with intrusions of the
old buffer_cache (as opposed to the new buffer cache a.k.a. pagecache)
into the core VM.

The first is simply:


Move __set_page_dirty_buffers() to fs/buffer.c, as per the FIXME.


diff -urpN mm3-2.5.67-1/fs/buffer.c mm3-2.5.67-2B/fs/buffer.c
--- mm3-2.5.67-1/fs/buffer.c	2003-04-14 18:08:14.000000000 -0700
+++ mm3-2.5.67-2B/fs/buffer.c	2003-04-14 22:21:19.000000000 -0700
@@ -779,6 +779,85 @@ void mark_buffer_dirty_inode(struct buff
 EXPORT_SYMBOL(mark_buffer_dirty_inode);
 
 /*
+ * Add a page to the dirty page list.
+ *
+ * It is a sad fact of life that this function is called from several places
+ * deeply under spinlocking.  It may not sleep.
+ *
+ * If the page has buffers, the uptodate buffers are set dirty, to preserve
+ * dirty-state coherency between the page and the buffers.  It the page does
+ * not have buffers then when they are later attached they will all be set
+ * dirty.
+ *
+ * The buffers are dirtied before the page is dirtied.  There's a small race
+ * window in which a writepage caller may see the page cleanness but not the
+ * buffer dirtiness.  That's fine.  If this code were to set the page dirty
+ * before the buffers, a concurrent writepage caller could clear the page dirty
+ * bit, see a bunch of clean buffers and we'd end up with dirty buffers/clean
+ * page on the dirty page list.
+ *
+ * There is also a small window where the page is dirty, and not on dirty_pages.
+ * Also a possibility that by the time the page is added to dirty_pages, it has
+ * been set clean.  The page lists are somewhat approximate in this regard.
+ * It's better to have clean pages accidentally attached to dirty_pages than to
+ * leave dirty pages attached to clean_pages.
+ *
+ * We use private_lock to lock against try_to_free_buffers while using the
+ * page's buffer list.  Also use this to protect against clean buffers being
+ * added to the page after it was set dirty.
+ *
+ * FIXME: may need to call ->reservepage here as well.  That's rather up to the
+ * address_space though.
+ *
+ * For now, we treat swapper_space specially.  It doesn't use the normal
+ * block a_ops.
+ */
+int __set_page_dirty_buffers(struct page *page)
+{
+	struct address_space * const mapping = page->mapping;
+	int ret = 0;
+
+	if (mapping == NULL) {
+		SetPageDirty(page);
+		goto out;
+	}
+
+	if (!PageUptodate(page))
+		buffer_error();
+
+	spin_lock(&mapping->private_lock);
+	if (page_has_buffers(page)) {
+		struct buffer_head *head = page_buffers(page);
+		struct buffer_head *bh = head;
+
+		do {
+			if (buffer_uptodate(bh))
+				set_buffer_dirty(bh);
+			else
+				buffer_error();
+			bh = bh->b_this_page;
+		} while (bh != head);
+	}
+	spin_unlock(&mapping->private_lock);
+
+	if (!TestSetPageDirty(page)) {
+		spin_lock(&mapping->page_lock);
+		if (page->mapping) {	/* Race with truncate? */
+			if (!mapping->backing_dev_info->memory_backed)
+				inc_page_state(nr_dirty);
+			list_del(&page->list);
+			list_add(&page->list, &mapping->dirty_pages);
+		}
+		spin_unlock(&mapping->page_lock);
+		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
+	}
+	
+out:
+	return ret;
+}
+EXPORT_SYMBOL(__set_page_dirty_buffers);
+
+/*
  * Write out and wait upon a list of buffers.
  *
  * We have conflicting pressures: we want to make sure that all
diff -urpN mm3-2.5.67-1/mm/page-writeback.c mm3-2.5.67-2B/mm/page-writeback.c
--- mm3-2.5.67-1/mm/page-writeback.c	2003-04-14 18:08:15.000000000 -0700
+++ mm3-2.5.67-2B/mm/page-writeback.c	2003-04-14 22:20:23.000000000 -0700
@@ -462,88 +462,6 @@ int write_one_page(struct page *page, in
 EXPORT_SYMBOL(write_one_page);
 
 /*
- * Add a page to the dirty page list.
- *
- * It is a sad fact of life that this function is called from several places
- * deeply under spinlocking.  It may not sleep.
- *
- * If the page has buffers, the uptodate buffers are set dirty, to preserve
- * dirty-state coherency between the page and the buffers.  It the page does
- * not have buffers then when they are later attached they will all be set
- * dirty.
- *
- * The buffers are dirtied before the page is dirtied.  There's a small race
- * window in which a writepage caller may see the page cleanness but not the
- * buffer dirtiness.  That's fine.  If this code were to set the page dirty
- * before the buffers, a concurrent writepage caller could clear the page dirty
- * bit, see a bunch of clean buffers and we'd end up with dirty buffers/clean
- * page on the dirty page list.
- *
- * There is also a small window where the page is dirty, and not on dirty_pages.
- * Also a possibility that by the time the page is added to dirty_pages, it has
- * been set clean.  The page lists are somewhat approximate in this regard.
- * It's better to have clean pages accidentally attached to dirty_pages than to
- * leave dirty pages attached to clean_pages.
- *
- * We use private_lock to lock against try_to_free_buffers while using the
- * page's buffer list.  Also use this to protect against clean buffers being
- * added to the page after it was set dirty.
- *
- * FIXME: may need to call ->reservepage here as well.  That's rather up to the
- * address_space though.
- *
- * For now, we treat swapper_space specially.  It doesn't use the normal
- * block a_ops.
- *
- * FIXME: this should move over to fs/buffer.c - buffer_heads have no business in mm/
- */
-#include <linux/buffer_head.h>
-int __set_page_dirty_buffers(struct page *page)
-{
-	struct address_space * const mapping = page->mapping;
-	int ret = 0;
-
-	if (mapping == NULL) {
-		SetPageDirty(page);
-		goto out;
-	}
-
-	if (!PageUptodate(page))
-		buffer_error();
-
-	spin_lock(&mapping->private_lock);
-	if (page_has_buffers(page)) {
-		struct buffer_head *head = page_buffers(page);
-		struct buffer_head *bh = head;
-
-		do {
-			if (buffer_uptodate(bh))
-				set_buffer_dirty(bh);
-			else
-				buffer_error();
-			bh = bh->b_this_page;
-		} while (bh != head);
-	}
-	spin_unlock(&mapping->private_lock);
-
-	if (!TestSetPageDirty(page)) {
-		spin_lock(&mapping->page_lock);
-		if (page->mapping) {	/* Race with truncate? */
-			if (!mapping->backing_dev_info->memory_backed)
-				inc_page_state(nr_dirty);
-			list_del(&page->list);
-			list_add(&page->list, &mapping->dirty_pages);
-		}
-		spin_unlock(&mapping->page_lock);
-		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
-	}
-	
-out:
-	return ret;
-}
-EXPORT_SYMBOL(__set_page_dirty_buffers);
-
-/*
  * For address_spaces which do not use buffers.  Just set the page's dirty bit
  * and move it to the dirty_pages list.  Also perform space reservation if
  * required.
