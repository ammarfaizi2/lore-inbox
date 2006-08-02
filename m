Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWHBRBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWHBRBM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 13:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWHBRAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 13:00:51 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:165 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751269AbWHBRAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 13:00:48 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/3] swsusp: Fix alloc_pagedir
Date: Wed, 2 Aug 2006 18:57:34 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200608021842.21774.rjw@sisk.pl>
In-Reply-To: <200608021842.21774.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608021857.35042.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of the FIXME in kernel/power/snapshot.c#alloc_pagedir() and
simplify the functions called by it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/snapshot.c |   32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

Index: linux-2.6.18-rc2-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/kernel/power/snapshot.c	2006-08-01 22:15:41.000000000 +0200
+++ linux-2.6.18-rc2-mm1/kernel/power/snapshot.c	2006-08-01 22:24:57.000000000 +0200
@@ -316,12 +316,12 @@ static void free_pagedir(struct pbe *pbl
  *	fill_pb_page - Create a list of PBEs on a given memory page
  */
 
-static inline void fill_pb_page(struct pbe *pbpage)
+static inline void fill_pb_page(struct pbe *pbpage, unsigned int n)
 {
 	struct pbe *p;
 
 	p = pbpage;
-	pbpage += PB_PAGE_SKIP;
+	pbpage += n - 1;
 	do
 		p->next = p + 1;
 	while (++p < pbpage);
@@ -330,24 +330,26 @@ static inline void fill_pb_page(struct p
 /**
  *	create_pbe_list - Create a list of PBEs on top of a given chain
  *	of memory pages allocated with alloc_pagedir()
+ *
+ *	This function assumes that pages allocated by alloc_image_page() will
+ *	always be zeroed.
  */
 
 static inline void create_pbe_list(struct pbe *pblist, unsigned int nr_pages)
 {
-	struct pbe *pbpage, *p;
+	struct pbe *pbpage;
 	unsigned int num = PBES_PER_PAGE;
 
 	for_each_pb_page (pbpage, pblist) {
 		if (num >= nr_pages)
 			break;
 
-		fill_pb_page(pbpage);
+		fill_pb_page(pbpage, PBES_PER_PAGE);
 		num += PBES_PER_PAGE;
 	}
 	if (pbpage) {
-		for (num -= PBES_PER_PAGE - 1, p = pbpage; num < nr_pages; p++, num++)
-			p->next = p + 1;
-		p->next = NULL;
+		num -= PBES_PER_PAGE;
+		fill_pb_page(pbpage, nr_pages - num);
 	}
 }
 
@@ -374,17 +376,17 @@ static struct pbe *alloc_pagedir(unsigne
 		return NULL;
 
 	pblist = alloc_image_page(gfp_mask, safe_needed);
-	/* FIXME: rewrite this ugly loop */
-	for (pbe = pblist, num = PBES_PER_PAGE; pbe && num < nr_pages;
-        		pbe = pbe->next, num += PBES_PER_PAGE) {
+	pbe = pblist;
+	for (num = PBES_PER_PAGE; num < nr_pages; num += PBES_PER_PAGE) {
+		if (!pbe) {
+			free_pagedir(pblist, 1);
+			return NULL;
+		}
 		pbe += PB_PAGE_SKIP;
 		pbe->next = alloc_image_page(gfp_mask, safe_needed);
+		pbe = pbe->next;
 	}
-	if (!pbe) { /* get_zeroed_page() failed */
-		free_pagedir(pblist, 1);
-		pblist = NULL;
-        } else
-		create_pbe_list(pblist, nr_pages);
+	create_pbe_list(pblist, nr_pages);
 	return pblist;
 }
 
