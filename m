Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161313AbWHJN15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161313AbWHJN15 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 09:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161312AbWHJN1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 09:27:53 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:61162 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161315AbWHJN1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 09:27:31 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 3/5] swsusp: Introduce some helpful constants
Date: Thu, 10 Aug 2006 15:18:10 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200608101510.40544.rjw@sisk.pl>
In-Reply-To: <200608101510.40544.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608101518.10060.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce some constants that hopefully will help improve the readability of
code in kernel/power/snapshot.c.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/snapshot.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

Index: linux-2.6.18-rc3-mm2/kernel/power/snapshot.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/kernel/power/snapshot.c	2006-08-10 08:09:26.000000000 +0200
+++ linux-2.6.18-rc3-mm2/kernel/power/snapshot.c	2006-08-10 08:09:56.000000000 +0200
@@ -167,6 +167,11 @@ static inline int restore_highmem(void) 
  *	and we count them using unsafe_pages
  */
 
+#define PG_ANY		0
+#define PG_SAFE		1
+#define PG_UNSAFE_CLEAR	1
+#define PG_UNSAFE_KEEP	0
+
 static unsigned int unsafe_pages;
 
 static void *alloc_image_page(gfp_t gfp_mask, int safe_needed)
@@ -190,7 +195,7 @@ static void *alloc_image_page(gfp_t gfp_
 
 unsigned long get_safe_page(gfp_t gfp_mask)
 {
-	return (unsigned long)alloc_image_page(gfp_mask, 1);
+	return (unsigned long)alloc_image_page(gfp_mask, PG_SAFE);
 }
 
 /**
@@ -381,7 +386,7 @@ static struct pbe *alloc_pagedir(unsigne
 	pbe = pblist;
 	for (num = PBES_PER_PAGE; num < nr_pages; num += PBES_PER_PAGE) {
 		if (!pbe) {
-			free_pagedir(pblist, 1);
+			free_pagedir(pblist, PG_UNSAFE_CLEAR);
 			return NULL;
 		}
 		pbe += PB_PAGE_SKIP;
@@ -458,12 +463,13 @@ static struct pbe *swsusp_alloc(unsigned
 {
 	struct pbe *pblist;
 
-	if (!(pblist = alloc_pagedir(nr_pages, GFP_ATOMIC | __GFP_COLD, 0))) {
+	pblist = alloc_pagedir(nr_pages, GFP_ATOMIC | __GFP_COLD, PG_ANY);
+	if (!pblist) {
 		printk(KERN_ERR "suspend: Allocating pagedir failed.\n");
 		return NULL;
 	}
 
-	if (alloc_data_pages(pblist, GFP_ATOMIC | __GFP_COLD, 0)) {
+	if (alloc_data_pages(pblist, GFP_ATOMIC | __GFP_COLD, PG_ANY)) {
 		printk(KERN_ERR "suspend: Allocating image pages failed.\n");
 		swsusp_free();
 		return NULL;
@@ -575,7 +581,7 @@ int snapshot_read_next(struct snapshot_h
 		return 0;
 	if (!buffer) {
 		/* This makes the buffer be freed by swsusp_free() */
-		buffer = alloc_image_page(GFP_ATOMIC, 0);
+		buffer = alloc_image_page(GFP_ATOMIC, PG_ANY);
 		if (!buffer)
 			return -ENOMEM;
 	}
@@ -688,7 +694,7 @@ static int load_header(struct snapshot_h
 
 	error = check_header(info);
 	if (!error) {
-		pblist = alloc_pagedir(info->image_pages, GFP_ATOMIC, 0);
+		pblist = alloc_pagedir(info->image_pages, GFP_ATOMIC, PG_ANY);
 		if (!pblist)
 			return -ENOMEM;
 		restore_pblist = pblist;
@@ -746,10 +752,10 @@ static int prepare_image(struct snapshot
 	p = restore_pblist;
 	error = mark_unsafe_pages(p);
 	if (!error) {
-		pblist = alloc_pagedir(nr_pages, GFP_ATOMIC, 1);
+		pblist = alloc_pagedir(nr_pages, GFP_ATOMIC, PG_SAFE);
 		if (pblist)
 			copy_page_backup_list(pblist, p);
-		free_pagedir(p, 0);
+		free_pagedir(p, PG_UNSAFE_KEEP);
 		if (!pblist)
 			error = -ENOMEM;
 	}
@@ -840,7 +846,7 @@ int snapshot_write_next(struct snapshot_
 		return 0;
 	if (!buffer) {
 		/* This makes the buffer be freed by swsusp_free() */
-		buffer = alloc_image_page(GFP_ATOMIC, 0);
+		buffer = alloc_image_page(GFP_ATOMIC, PG_ANY);
 		if (!buffer)
 			return -ENOMEM;
 	}
