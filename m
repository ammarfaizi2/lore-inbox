Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262487AbVBBPOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbVBBPOg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 10:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbVBBPOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 10:14:35 -0500
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:53185 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262492AbVBBPM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 10:12:58 -0500
Date: Wed, 2 Feb 2005 15:12:50 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
cc: Nathan Scott <nathans@sgi.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: RFC: [PATCH-2.6] Add helper function to lock multiple page cache
 pages.
Message-ID: <Pine.LNX.4.60.0502021354540.16084@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 27 Jan 2005, Andrew Morton wrote:
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > What would you propose can I do to perform the required zeroing in a
> > deadlock safe manner whilst also ensuring that it cannot happen that a
> > concurrent ->readpage() will cause me to miss a page and thus end up
> > with non-initialized/random data on disk for that page?
> 
> The only thing I can think of is to lock all the pages.
[snip discussion of how this can be done safely - for details see 
Andrew's post with the subject "Re: Advice sought on how to lock multiple 
pages in ->prepare_write and ->writepage"]

Below is a patch which adds a function 
mm/filemap.c::find_or_create_pages(), locks a range of pages.  Please see 
the function description in the patch for details.

Nathan, would this be useful to you?

Andrew, would this be acceptable?  And does it look right from a safety 
point of view?  I have added the try locks as you suggested.

Note, I have only compile tested this function as the NTFS code 
implementing hole filling is nowhere near ready to even test yet...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

--- ntfs-2.6-devel/mm/filemap.c.old	2005-02-01 16:19:13.000000000 +0000
+++ ntfs-2.6-devel/mm/filemap.c	2005-02-02 15:06:57.158759886 +0000
@@ -586,6 +586,123 @@
 EXPORT_SYMBOL(find_or_create_page);
 
 /**
+ * find_or_create_pages - locate and/or add a number of page cache pages
+ * @mapping:		address space in which to locate the pages
+ * @start:		starting page index
+ * @nr_pages:		number of pages to locate
+ * @pages:		where the resulting pages are placed
+ * @gfp_mask:		page allocation mode (for new pages)
+ * @locked_page:	already locked page in the range of pages to lock
+ * @wbc:		writeback control of @locked_page if applicable
+ *
+ * find_or_create_pages() locates @nr_pages starting at page index @start in
+ * the page cache described by the address space @mapping.  The pages are
+ * placed in @pages.  If any pages are not present in the page cache, new pages
+ * are allocated using @gfp_mask and are added to the page cache of @mapping as
+ * well as to the VM's LRU list.  The returned pages are locked and have their
+ * reference count incremented.  The locking is done in ascending page index
+ * order.
+ *
+ * @locked_page is a locked page in the requested range of pages.  A reference
+ * is not acquired for @locked_page as the caller is assumed to hold one
+ * already.  (Callers of ->prepare_write and ->writepage take a reference on
+ * the page.)
+ *
+ * @wbc is the writeback control of @locked_page if called from ->writepage and
+ * NULL otherwise (called from ->prepare_write()).
+ *
+ * Note, find_or_create_pages() may sleep, even if @gfp_flags specifies an
+ * atomic allocation!
+ *
+ * Return 0 on success and -errno on error.  Possible errors are:
+ *	-ENOMEM		memory exhaustion
+ *	-EDEADLK	could not safely acquire required locks
+ *	-ESTALE		@locked_page was truncated by a racing process
+ */
+int find_or_create_pages(struct address_space *mapping, pgoff_t start,
+		const unsigned int nr_pages, struct page **pages,
+		const unsigned int gfp_mask, struct page *locked_page,
+		const struct writeback_control *wbc)
+{
+	struct page *cached_page = NULL;
+	struct inode *inode = mapping->host;
+	pgoff_t lp_idx = locked_page->index;
+	int err, nr;
+
+	if (lp_idx != start) {
+		if (wbc && wbc->for_reclaim) {
+			if (!down_read_trylock(&inode->i_sb->s_umount))
+				return -EDEADLK;
+			if (down_trylock(&inode->i_sem)) {
+				up_read(&inode->i_sb->s_umount);
+				return -EDEADLK;
+			}
+		}
+		unlock_page(locked_page);
+	}
+	err = nr = 0;
+	while (nr < nr_pages) {
+		if (start == lp_idx) {
+			pages[nr] = locked_page;
+			if (nr) {
+				lock_page(locked_page);
+				if (wbc) {
+					if (wbc->for_reclaim) {
+						up(&inode->i_sem);
+						up_read(&inode->i_sb->s_umount);
+					}
+					/* Was the page truncated under us? */
+					if (page_mapping(locked_page) !=
+							mapping) {
+						err = -ESTALE;
+						goto err_out_locked;
+					}
+				}
+			}
+		} else {
+			pages[nr] = find_lock_page(mapping, start);
+			if (!pages[nr]) {
+				if (!cached_page) {
+					cached_page = alloc_page(gfp_mask);
+					if (!unlikely(cached_page))
+						goto err_out;
+				}
+				err = add_to_page_cache_lru(cached_page,
+						mapping, start, gfp_mask);
+				if (unlikely(err)) {
+					if (err == -EEXIST)
+						continue;
+					goto err_out;
+				}
+				pages[nr] = cached_page;
+				cached_page = NULL;
+			}
+		}
+		nr++;
+		start++;
+	}
+out:
+	if (unlikely(cached_page))
+		page_cache_release(cached_page);
+	return err;
+err_out:
+	err = -ENOMEM;
+	/* Relock the original page if it was unlocked and not yet relocked. */
+	if (!nr || pages[nr-1]->index < lp_idx)
+		lock_page(locked_page);
+err_out_locked:
+	while (nr > 0) {
+		if (pages[--nr] != locked_page) {
+			unlock_page(pages[nr]);
+			page_cache_release(pages[nr]);
+		}
+	}
+	goto out;
+}
+
+EXPORT_SYMBOL(find_or_create_pages);
+
+/**
  * find_get_pages - gang pagecache lookup
  * @mapping:	The address_space to search
  * @start:	The starting page index
--- ntfs-2.6-devel/include/linux/pagemap.h.old	2005-02-02 13:49:14.742362485 +0000
+++ ntfs-2.6-devel/include/linux/pagemap.h	2005-02-02 13:51:28.214387025 +0000
@@ -70,6 +70,10 @@
 				unsigned long index);
 extern struct page * find_or_create_page(struct address_space *mapping,
 				unsigned long index, unsigned int gfp_mask);
+extern int find_or_create_pages(struct address_space *mapping, pgoff_t start,
+		const unsigned int nr_pages, struct page **pages,
+		const unsigned int gfp_mask, struct page *locked_page,
+		const struct writeback_control *wbc);
 unsigned find_get_pages(struct address_space *mapping, pgoff_t start,
 			unsigned int nr_pages, struct page **pages);
 unsigned find_get_pages_tag(struct address_space *mapping, pgoff_t *index,
