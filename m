Return-Path: <linux-kernel-owner+willy=40w.ods.org-S770134AbUKBEyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S770134AbUKBEyo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 23:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268510AbUKBEyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 23:54:43 -0500
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:59074 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S378061AbUKAWm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 17:42:27 -0500
Date: Mon, 1 Nov 2004 22:42:23 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] Re: RFC: Changes to fs/buffer.c?
In-Reply-To: <Pine.LNX.4.60.0410292237170.24884@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0411012236040.6889@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410291516580.19494@hermes-1.csi.cam.ac.uk>
 <20041029133420.76a758b3.akpm@osdl.org> <Pine.LNX.4.60.0410292237170.24884@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Hi Linus,

On Fri, 29 Oct 2004, Anton Altaparmakov wrote:
> On Fri, 29 Oct 2004, Andrew Morton wrote:
> > Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > >
> > > Is it ok to export 
> > >  create_buffers() and to make __set_page_buffers() static inline and move 
> > >  it to include/linux/buffer.h?
> > 
> > ho, hum - if you must ;)

Ok, below is the patch, as requested I renamed the functions to more 
descriptive names:

	create_buffers -> alloc_page_buffers
	__set_page_buffers -> attach_page_buffers

And I added a EXPORT_SYMBOL_GPL for alloc_page_buffers and made
attach_page_buffers static inline and moved it to <linux/buffer_head.h>.

Assuming you are both happy with it, please apply.  Thanks!

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton

PS. If you prefer me to submit this as part of the next ntfs update just 
let me know...

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

---------- buffer-stuff2.diff ----------

--- ntfs-2.6-devel/include/linux/buffer_head.h.old	2004-11-01 22:30:58.854166673 +0000
+++ ntfs-2.6-devel/include/linux/buffer_head.h	2004-11-01 22:27:22.722940892 +0000
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/fs.h>
 #include <linux/linkage.h>
+#include <linux/pagemap.h>
 #include <linux/wait.h>
 #include <asm/atomic.h>
 
@@ -136,6 +137,8 @@ void init_buffer(struct buffer_head *, b
 void set_bh_page(struct buffer_head *bh,
 		struct page *page, unsigned long offset);
 int try_to_free_buffers(struct page *);
+struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
+		int retry);
 void create_empty_buffers(struct page *, unsigned long,
 			unsigned long b_state);
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
@@ -205,6 +208,14 @@ int nobh_truncate_page(struct address_sp
  * inline definitions
  */
 
+static inline void attach_page_buffers(struct page *page,
+		struct buffer_head *head)
+{
+	page_cache_get(page);
+	SetPagePrivate(page);
+	page->private = (unsigned long)head;
+}
+
 static inline void get_bh(struct buffer_head *bh)
 {
         atomic_inc(&bh->b_count);
--- ntfs-2.6-devel/fs/buffer.c.old	2004-11-01 22:29:29.423590168 +0000
+++ ntfs-2.6-devel/fs/buffer.c	2004-11-01 22:27:57.582267689 +0000
@@ -91,14 +91,6 @@ void __wait_on_buffer(struct buffer_head
 }
 
 static void
-__set_page_buffers(struct page *page, struct buffer_head *head)
-{
-	page_cache_get(page);
-	SetPagePrivate(page);
-	page->private = (unsigned long)head;
-}
-
-static void
 __clear_page_buffers(struct page *page)
 {
 	ClearPagePrivate(page);
@@ -1013,8 +1005,8 @@ int remove_inode_buffers(struct inode *i
  * The retry flag is used to differentiate async IO (paging, swapping)
  * which may not fail from ordinary buffer allocations.
  */
-static struct buffer_head *
-create_buffers(struct page * page, unsigned long size, int retry)
+struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
+		int retry)
 {
 	struct buffer_head *bh, *head;
 	long offset;
@@ -1072,6 +1064,7 @@ no_grow:
 	free_more_memory();
 	goto try_again;
 }
+EXPORT_SYMBOL_GPL(alloc_page_buffers);
 
 static inline void
 link_dev_buffers(struct page *page, struct buffer_head *head)
@@ -1084,7 +1077,7 @@ link_dev_buffers(struct page *page, stru
 		bh = bh->b_this_page;
 	} while (bh);
 	tail->b_this_page = head;
-	__set_page_buffers(page, head);
+	attach_page_buffers(page, head);
 }
 
 /*
@@ -1145,7 +1138,7 @@ grow_dev_page(struct block_device *bdev,
 	/*
 	 * Allocate some buffers for this page
 	 */
-	bh = create_buffers(page, size, 0);
+	bh = alloc_page_buffers(page, size, 0);
 	if (!bh)
 		goto failed;
 
@@ -1651,7 +1644,7 @@ void create_empty_buffers(struct page *p
 {
 	struct buffer_head *bh, *head, *tail;
 
-	head = create_buffers(page, blocksize, 1);
+	head = alloc_page_buffers(page, blocksize, 1);
 	bh = head;
 	do {
 		bh->b_state |= b_state;
@@ -1671,7 +1664,7 @@ void create_empty_buffers(struct page *p
 			bh = bh->b_this_page;
 		} while (bh != head);
 	}
-	__set_page_buffers(page, head);
+	attach_page_buffers(page, head);
 	spin_unlock(&page->mapping->private_lock);
 }
 EXPORT_SYMBOL(create_empty_buffers);
