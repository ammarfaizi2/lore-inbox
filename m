Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWHBRBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWHBRBT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 13:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWHBRAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 13:00:49 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:65444 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751255AbWHBRAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 13:00:47 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/3] swsusp: Reorder memory-allocating functions
Date: Wed, 2 Aug 2006 18:53:46 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200608021842.21774.rjw@sisk.pl>
In-Reply-To: <200608021842.21774.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608021853.47040.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move some functions in kernel/power/snapshot.c to a better place
(in the same file) and introduce free_image_page() (will be necessary in the
future).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/snapshot.c |   93 +++++++++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 40 deletions(-)

Index: linux-2.6.18-rc2-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/kernel/power/snapshot.c	2006-08-01 08:58:45.000000000 +0200
+++ linux-2.6.18-rc2-mm1/kernel/power/snapshot.c	2006-08-01 22:15:41.000000000 +0200
@@ -156,6 +156,58 @@ static inline int save_highmem(void) {re
 static inline int restore_highmem(void) {return 0;}
 #endif
 
+/**
+ *	@safe_needed - on resume, for storing the PBE list and the image,
+ *	we can only use memory pages that do not conflict with the pages
+ *	used before suspend.
+ *
+ *	The unsafe pages are marked with the PG_nosave_free flag
+ *	and we count them using unsafe_pages
+ */
+
+static unsigned int unsafe_pages;
+
+static void *alloc_image_page(gfp_t gfp_mask, int safe_needed)
+{
+	void *res;
+
+	res = (void *)get_zeroed_page(gfp_mask);
+	if (safe_needed)
+		while (res && PageNosaveFree(virt_to_page(res))) {
+			/* The page is unsafe, mark it for swsusp_free() */
+			SetPageNosave(virt_to_page(res));
+			unsafe_pages++;
+			res = (void *)get_zeroed_page(gfp_mask);
+		}
+	if (res) {
+		SetPageNosave(virt_to_page(res));
+		SetPageNosaveFree(virt_to_page(res));
+	}
+	return res;
+}
+
+unsigned long get_safe_page(gfp_t gfp_mask)
+{
+	return (unsigned long)alloc_image_page(gfp_mask, 1);
+}
+
+/**
+ *	free_image_page - free page represented by @addr, allocated with
+ *	alloc_image_page (page flags set by it must be cleared)
+ */
+
+static inline void free_image_page(void *addr, int clear_nosave_free)
+{
+	ClearPageNosave(virt_to_page(addr));
+	if (clear_nosave_free)
+		ClearPageNosaveFree(virt_to_page(addr));
+	free_page((unsigned long)addr);
+}
+
+/**
+ *	pfn_is_nosave - check if given pfn is in the 'nosave' section
+ */
+
 static inline int pfn_is_nosave(unsigned long pfn)
 {
 	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
@@ -245,7 +297,6 @@ static void copy_data_pages(struct pbe *
 	BUG_ON(pbe);
 }
 
-
 /**
  *	free_pagedir - free pages allocated with alloc_pagedir()
  */
@@ -256,10 +307,7 @@ static void free_pagedir(struct pbe *pbl
 
 	while (pblist) {
 		pbe = (pblist + PB_PAGE_SKIP)->next;
-		ClearPageNosave(virt_to_page(pblist));
-		if (clear_nosave_free)
-			ClearPageNosaveFree(virt_to_page(pblist));
-		free_page((unsigned long)pblist);
+		free_image_page(pblist, clear_nosave_free);
 		pblist = pbe;
 	}
 }
@@ -303,41 +351,6 @@ static inline void create_pbe_list(struc
 	}
 }
 
-static unsigned int unsafe_pages;
-
-/**
- *	@safe_needed - on resume, for storing the PBE list and the image,
- *	we can only use memory pages that do not conflict with the pages
- *	used before suspend.
- *
- *	The unsafe pages are marked with the PG_nosave_free flag
- *	and we count them using unsafe_pages
- */
-
-static void *alloc_image_page(gfp_t gfp_mask, int safe_needed)
-{
-	void *res;
-
-	res = (void *)get_zeroed_page(gfp_mask);
-	if (safe_needed)
-		while (res && PageNosaveFree(virt_to_page(res))) {
-			/* The page is unsafe, mark it for swsusp_free() */
-			SetPageNosave(virt_to_page(res));
-			unsafe_pages++;
-			res = (void *)get_zeroed_page(gfp_mask);
-		}
-	if (res) {
-		SetPageNosave(virt_to_page(res));
-		SetPageNosaveFree(virt_to_page(res));
-	}
-	return res;
-}
-
-unsigned long get_safe_page(gfp_t gfp_mask)
-{
-	return (unsigned long)alloc_image_page(gfp_mask, 1);
-}
-
 /**
  *	alloc_pagedir - Allocate the page directory.
  *
