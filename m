Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWELGKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWELGKS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 02:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWELGIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 02:08:13 -0400
Received: from ns.suse.de ([195.135.220.2]:51874 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750949AbWELGIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 02:08:04 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 12 May 2006 16:07:48 +1000
Message-Id: <1060512060748.8036@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       Paul Clements <paul.clements@steeleye.com>
Subject: [PATCH 004 of 8] md/bitmap: Use set_bit etc for bitmap page attributes.
References: <20060512160121.7872.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In particular, this means that we use 4 bits per page instead of a
whole unsigned long.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/bitmap.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff ./drivers/md/bitmap.c~current~ ./drivers/md/bitmap.c
--- ./drivers/md/bitmap.c~current~	2006-05-12 15:56:51.000000000 +1000
+++ ./drivers/md/bitmap.c	2006-05-12 15:58:22.000000000 +1000
@@ -700,27 +700,27 @@ static void bitmap_file_kick(struct bitm
 }
 
 enum bitmap_page_attr {
-	BITMAP_PAGE_DIRTY = 1, // there are set bits that need to be synced
-	BITMAP_PAGE_CLEAN = 2, // there are bits that might need to be cleared
-	BITMAP_PAGE_NEEDWRITE=4, // there are cleared bits that need to be synced
+	BITMAP_PAGE_DIRTY = 0, // there are set bits that need to be synced
+	BITMAP_PAGE_CLEAN = 1, // there are bits that might need to be cleared
+	BITMAP_PAGE_NEEDWRITE=2, // there are cleared bits that need to be synced
 };
 
 static inline void set_page_attr(struct bitmap *bitmap, struct page *page,
 				enum bitmap_page_attr attr)
 {
-	bitmap->filemap_attr[page->index] |= attr;
+	__set_bit((page->index<<2) + attr, bitmap->filemap_attr);
 }
 
 static inline void clear_page_attr(struct bitmap *bitmap, struct page *page,
 				enum bitmap_page_attr attr)
 {
-	bitmap->filemap_attr[page->index] &= ~attr;
+	__clear_bit((page->index<<2) + attr, bitmap->filemap_attr);
 }
 
 static inline unsigned long test_page_attr(struct bitmap *bitmap, struct page *page,
 					   enum bitmap_page_attr attr)
 {
-	return bitmap->filemap_attr[page->index] & attr;
+	return test_bit((page->index<<2) + attr, bitmap->filemap_attr);
 }
 
 /*
@@ -872,7 +872,12 @@ static int bitmap_init_from_disk(struct 
 	if (!bitmap->filemap)
 		goto out;
 
-	bitmap->filemap_attr = kzalloc(sizeof(long) * num_pages, GFP_KERNEL);
+	/* We need 4 bits per page, rounded up to a multiple of sizeof(unsigned long) */
+	bitmap->filemap_attr = kzalloc(
+		(((num_pages*4/8)+sizeof(unsigned long)-1)
+		 /sizeof(unsigned long))
+		*sizeof(unsigned long),
+		GFP_KERNEL);
 	if (!bitmap->filemap_attr)
 		goto out;
 
