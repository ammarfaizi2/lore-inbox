Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTHBKrF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 06:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTHBKrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 06:47:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:50911 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263062AbTHBKq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 06:46:58 -0400
Date: Sat, 2 Aug 2003 03:47:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [1/3] writes: report truncate and io errors on async
 writes
Message-Id: <20030802034756.11c7287c.akpm@osdl.org>
In-Reply-To: <20030802041731.GA22824@waste.org>
References: <20030802041731.GA22824@waste.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron <oxymoron@waste.org> wrote:
>
> These patches add the missing infrastructure for reporting
> asynchronous write errors to block devices to userspace. Errors are
> reported at the next fsync, fdatasync, or msync on the given file, and
> on close if the error occurs in time.

Thank you for persisting with this.  I won't lose the patches this time.

I made some adjustments...



- code simplifications

- No need to lock the page to stabilise ->mapping in mpage.c


 fs/mpage.c   |   29 +++++++----------------------
 fs/open.c    |   10 ++++------
 mm/filemap.c |    6 +++---
 mm/vmscan.c  |   38 +++++++++++++++++++++++---------------
 4 files changed, 37 insertions(+), 46 deletions(-)

diff -puN fs/open.c~awe-core-fixes fs/open.c
--- 25/fs/open.c~awe-core-fixes	2003-08-02 03:33:28.000000000 -0700
+++ 25-akpm/fs/open.c	2003-08-02 03:33:28.000000000 -0700
@@ -955,20 +955,18 @@ int filp_close(struct file *filp, fl_own
 	}
 
 	err = mapping->error;
-	if (err && !retval) {
-		mapping->error = 0;
+	if (!retval)
 		retval = err;
-	}
+	mapping->error = 0;
 
 	if (!file_count(filp)) {
 		printk(KERN_ERR "VFS: Close: file count is 0\n");
 		return retval;
 	}
 
-	if (filp->f_op && filp->f_op->flush)
-	{
+	if (filp->f_op && filp->f_op->flush) {
 		err = filp->f_op->flush(filp);
-		if (err && !retval)
+		if (!retval)
 			retval = err;
 	}
 
diff -puN mm/vmscan.c~awe-core-fixes mm/vmscan.c
--- 25/mm/vmscan.c~awe-core-fixes	2003-08-02 03:33:28.000000000 -0700
+++ 25-akpm/mm/vmscan.c	2003-08-02 03:33:37.000000000 -0700
@@ -236,6 +236,27 @@ static int may_write_to_queue(struct bac
 }
 
 /*
+ * We detected a synchronous write error writing a page out.  Probably
+ * -ENOSPC.  We need to propagate that into the address_space for a subsequent
+ * fsync(), msync() or close().
+ *
+ * The tricky part is that after writepage we cannot touch the mapping: nothing
+ * prevents it from being freed up.  But we have a ref on the page and once
+ * that page is locked, the mapping is pinned.
+ *
+ * We're allowed to run sleeping lock_page() here because we know the caller has
+ * __GFP_FS.
+ */
+static void handle_write_error(struct address_space *mapping,
+				struct page *page, int error)
+{
+	lock_page(page);
+	if (page->mapping == mapping)
+		mapping->error = error;
+	unlock_page(page);
+}
+
+/*
  * shrink_list returns the number of reclaimed pages
  */
 static int
@@ -362,21 +383,8 @@ shrink_list(struct list_head *page_list,
 
 				SetPageReclaim(page);
 				res = mapping->a_ops->writepage(page, &wbc);
-
-				if (res < 0) {
-					/*
-					 * lock the page to keep truncate away
-					 * then check that it is still on the
-					 * mapping.
-					 */
-					lock_page(page);
-					if (page->mapping == mapping)
-						mapping->error = res;
-					unlock_page(page);
-				}
-				if (res < 0) {
-					mapping->error = res;
-				}
+				if (res < 0)
+					handle_write_error(mapping, page, res);
 				if (res == WRITEPAGE_ACTIVATE) {
 					ClearPageReclaim(page);
 					goto activate_locked;
diff -puN mm/filemap.c~awe-core-fixes mm/filemap.c
--- 25/mm/filemap.c~awe-core-fixes	2003-08-02 03:33:28.000000000 -0700
+++ 25-akpm/mm/filemap.c	2003-08-02 03:33:28.000000000 -0700
@@ -199,9 +199,9 @@ restart:
 	spin_unlock(&mapping->page_lock);
 
 	/* Check for outstanding write errors */
-	if (mapping->error)
-	{
-		ret = mapping->error;
+	if (mapping->error) {
+		if (!ret)
+			ret = mapping->error;
 		mapping->error = 0;
 	}
 
diff -puN fs/mpage.c~awe-core-fixes fs/mpage.c
--- 25/fs/mpage.c~awe-core-fixes	2003-08-02 03:33:28.000000000 -0700
+++ 25-akpm/fs/mpage.c	2003-08-02 03:33:28.000000000 -0700
@@ -563,17 +563,11 @@ confused:
 	if (bio)
 		bio = mpage_bio_submit(WRITE, bio);
 	*ret = page->mapping->a_ops->writepage(page, wbc);
-	if (*ret < 0) {
-		/*
-		 * lock the page to keep truncate away
-		 * then check that it is still on the
-		 * mapping.
-		 */
-		lock_page(page);
-		if (page->mapping == mapping)
-			mapping->error = *ret;
-		unlock_page(page);
-	}
+	/*
+	 * The caller has a ref on the inode, so *mapping is stable
+	 */
+	if (*ret < 0)
+		mapping->error = *ret;
 out:
 	return bio;
 }
@@ -675,17 +669,8 @@ mpage_writepages(struct address_space *m
 					test_clear_page_dirty(page)) {
 			if (writepage) {
 				ret = (*writepage)(page, wbc);
-				if (ret < 0) {
-					/*
-					 * lock the page to keep truncate away
-					 * then check that it is still on the
-					 * mapping.
-					 */
-					lock_page(page);
-					if (page->mapping == mapping)
-						mapping->error = ret;
-					unlock_page(page);
-				}
+				if (ret < 0)
+					mapping->error = ret;
 			} else {
 				bio = mpage_writepage(bio, page, get_block,
 					&last_block_in_bio, &ret, wbc);

_

