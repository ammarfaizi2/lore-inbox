Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWELGIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWELGIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 02:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWELGIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 02:08:16 -0400
Received: from mx1.suse.de ([195.135.220.2]:50082 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750934AbWELGH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 02:07:59 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 12 May 2006 16:07:42 +1000
Message-Id: <1060512060742.8024@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       Paul Clements <paul.clements@steeleye.com>
Subject: [PATCH 003 of 8] md/bitmap: Cleaner separation of page attribute handlers in md/bitmap.
References: <20060512160121.7872.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


md/bitmap has some attributes per-page.  Handling of these
attributes in largely abstracted in set_page_attr and
clear_page_attr.  However get_page_attr exposes the 
format used to store them.  So prior to changing that
format, introduce test_page_attr instead of get_page_attr,
and make appropriate usage changes.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/bitmap.c |   41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff ./drivers/md/bitmap.c~current~ ./drivers/md/bitmap.c
--- ./drivers/md/bitmap.c~current~	2006-05-12 15:55:37.000000000 +1000
+++ ./drivers/md/bitmap.c	2006-05-12 15:56:51.000000000 +1000
@@ -717,9 +717,10 @@ static inline void clear_page_attr(struc
 	bitmap->filemap_attr[page->index] &= ~attr;
 }
 
-static inline unsigned long get_page_attr(struct bitmap *bitmap, struct page *page)
+static inline unsigned long test_page_attr(struct bitmap *bitmap, struct page *page,
+					   enum bitmap_page_attr attr)
 {
-	return bitmap->filemap_attr[page->index];
+	return bitmap->filemap_attr[page->index] & attr;
 }
 
 /*
@@ -745,7 +746,7 @@ static void bitmap_file_set_bit(struct b
 
 
 	/* make sure the page stays cached until it gets written out */
-	if (! (get_page_attr(bitmap, page) & BITMAP_PAGE_DIRTY))
+	if (! test_page_attr(bitmap, page, BITMAP_PAGE_DIRTY))
 		get_page(page);
 
  	/* set the bit */
@@ -769,7 +770,8 @@ static void bitmap_writeback(struct bitm
  * sync the dirty pages of the bitmap file to disk */
 int bitmap_unplug(struct bitmap *bitmap)
 {
-	unsigned long i, attr, flags;
+	unsigned long i, flags;
+	int dirty, need_write;
 	struct page *page;
 	int wait = 0;
 	int err;
@@ -786,17 +788,18 @@ int bitmap_unplug(struct bitmap *bitmap)
 			return 0;
 		}
 		page = bitmap->filemap[i];
-		attr = get_page_attr(bitmap, page);
+		dirty = test_page_attr(bitmap, page, BITMAP_PAGE_DIRTY);
+		need_write = test_page_attr(bitmap, page, BITMAP_PAGE_NEEDWRITE);
 		clear_page_attr(bitmap, page, BITMAP_PAGE_DIRTY);
 		clear_page_attr(bitmap, page, BITMAP_PAGE_NEEDWRITE);
-		if ((attr & BITMAP_PAGE_DIRTY))
+		if (dirty)
 			wait = 1;
 		spin_unlock_irqrestore(&bitmap->lock, flags);
 
-		if (attr & (BITMAP_PAGE_DIRTY | BITMAP_PAGE_NEEDWRITE)) {
+		if (dirty | need_write) {
 			err = write_page(bitmap, page, 0);
 			if (err == -EAGAIN) {
-				if (attr & BITMAP_PAGE_DIRTY)
+				if (dirty)
 					err = write_page(bitmap, page, 1);
 				else
 					err = 0;
@@ -961,12 +964,11 @@ void bitmap_write_all(struct bitmap *bit
 	/* We don't actually write all bitmap blocks here,
 	 * just flag them as needing to be written
 	 */
+	int i;
 
-	unsigned long chunks = bitmap->chunks;
-	unsigned long bytes = (chunks+7)/8 + sizeof(bitmap_super_t);
-	unsigned long num_pages = (bytes + PAGE_SIZE-1) / PAGE_SIZE;
-	while (num_pages--)
-		bitmap->filemap_attr[num_pages] |= BITMAP_PAGE_NEEDWRITE;
+	for (i=0; i < bitmap->file_pages; i++)
+		set_page_attr(bitmap, bitmap->filemap[i],
+			      BITMAP_PAGE_NEEDWRITE);
 }
 
 
@@ -997,7 +999,6 @@ int bitmap_daemon_work(struct bitmap *bi
 	struct page *page = NULL, *lastpage = NULL;
 	int err = 0;
 	int blocks;
-	int attr;
 	void *paddr;
 
 	if (bitmap == NULL)
@@ -1019,13 +1020,15 @@ int bitmap_daemon_work(struct bitmap *bi
 
 		if (page != lastpage) {
 			/* skip this page unless it's marked as needing cleaning */
-			if (!((attr=get_page_attr(bitmap, page)) & BITMAP_PAGE_CLEAN)) {
-				if (attr & BITMAP_PAGE_NEEDWRITE) {
+			if (!test_page_attr(bitmap, page, BITMAP_PAGE_CLEAN)) {
+				int need_write = test_page_attr(bitmap, page,
+								BITMAP_PAGE_NEEDWRITE);
+				if (need_write) {
 					get_page(page);
 					clear_page_attr(bitmap, page, BITMAP_PAGE_NEEDWRITE);
 				}
 				spin_unlock_irqrestore(&bitmap->lock, flags);
-				if (attr & BITMAP_PAGE_NEEDWRITE) {
+				if (need_write) {
 					switch (write_page(bitmap, page, 0)) {
 					case -EAGAIN:
 						set_page_attr(bitmap, page, BITMAP_PAGE_NEEDWRITE);
@@ -1043,7 +1046,7 @@ int bitmap_daemon_work(struct bitmap *bi
 			/* grab the new page, sync and release the old */
 			get_page(page);
 			if (lastpage != NULL) {
-				if (get_page_attr(bitmap, lastpage) & BITMAP_PAGE_NEEDWRITE) {
+				if (test_page_attr(bitmap, lastpage, BITMAP_PAGE_NEEDWRITE)) {
 					clear_page_attr(bitmap, lastpage, BITMAP_PAGE_NEEDWRITE);
 					spin_unlock_irqrestore(&bitmap->lock, flags);
 					err = write_page(bitmap, lastpage, 0);
@@ -1097,7 +1100,7 @@ int bitmap_daemon_work(struct bitmap *bi
 	/* now sync the final page */
 	if (lastpage != NULL) {
 		spin_lock_irqsave(&bitmap->lock, flags);
-		if (get_page_attr(bitmap, lastpage) &BITMAP_PAGE_NEEDWRITE) {
+		if (test_page_attr(bitmap, lastpage, BITMAP_PAGE_NEEDWRITE)) {
 			clear_page_attr(bitmap, lastpage, BITMAP_PAGE_NEEDWRITE);
 			spin_unlock_irqrestore(&bitmap->lock, flags);
 			err = write_page(bitmap, lastpage, 0);
