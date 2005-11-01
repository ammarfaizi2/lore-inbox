Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbVKAX5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbVKAX5B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 18:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbVKAXzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 18:55:52 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:54976 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751453AbVKAXzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 18:55:50 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/3] swsusp: simplify pagedir relocation
Date: Wed, 2 Nov 2005 00:07:25 +0100
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <200511020000.11183.rjw@sisk.pl>
In-Reply-To: <200511020000.11183.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511020007.26004.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simplifies the relocation of the page backup list (aka pagedir)
during resume.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/power.h    |    1 
 kernel/power/snapshot.c |    2 -
 kernel/power/swsusp.c   |   78 ++++++++++++++++--------------------------------
 3 files changed, 28 insertions(+), 53 deletions(-)

Index: linux-2.6.14-git4/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-git4.orig/kernel/power/swsusp.c	2005-11-01 18:20:28.000000000 +0100
+++ linux-2.6.14-git4/kernel/power/swsusp.c	2005-11-01 18:22:12.000000000 +0100
@@ -636,74 +636,43 @@
 }
 
 /**
- *	swsusp_pagedir_relocate - It is possible, that some memory pages
- *	occupied by the list of PBEs collide with pages where we're going to
- *	restore from the loaded pages later.  We relocate them here.
+ *	mark_unsafe_pages - mark the pages that cannot be used for storing
+ *	the image during resume, because they conflict with the pages that
+ *	had been used before suspend
  */
 
-static struct pbe * swsusp_pagedir_relocate(struct pbe *pblist)
+static void mark_unsafe_pages(struct pbe *pblist)
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
-	struct pbe *pbpage, *tail, *p;
-	void *m;
-	int rel = 0;
+	struct pbe *p;
 
 	if (!pblist) /* a sanity check */
-		return NULL;
-
-	pr_debug("swsusp: Relocating pagedir (%lu pages to check)\n",
-			swsusp_info.pagedir_pages);
+		return;
 
 	/* Clear page flags */
-
 	for_each_zone (zone) {
-        	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
-        		if (pfn_valid(zone_pfn + zone->zone_start_pfn))
-                		ClearPageNosaveFree(pfn_to_page(zone_pfn +
+		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
+			if (pfn_valid(zone_pfn + zone->zone_start_pfn))
+				ClearPageNosaveFree(pfn_to_page(zone_pfn +
 					zone->zone_start_pfn));
 	}
 
 	/* Mark orig addresses */
-
 	for_each_pbe (p, pblist)
 		SetPageNosaveFree(virt_to_page(p->orig_address));
 
-	tail = pblist + PB_PAGE_SKIP;
-
-	/* Relocate colliding pages */
-
-	for_each_pb_page (pbpage, pblist) {
-		if (PageNosaveFree(virt_to_page((unsigned long)pbpage))) {
-			m = (void *)get_safe_page(GFP_ATOMIC | __GFP_COLD);
-			if (!m)
-				return NULL;
-			memcpy(m, (void *)pbpage, PAGE_SIZE);
-			if (pbpage == pblist)
-				pblist = (struct pbe *)m;
-			else
-				tail->next = (struct pbe *)m;
-			pbpage = (struct pbe *)m;
-
-			/* We have to link the PBEs again */
-			for (p = pbpage; p < pbpage + PB_PAGE_SKIP; p++)
-				if (p->next) /* needed to save the end */
-					p->next = p + 1;
-
-			rel++;
-		}
-		tail = pbpage + PB_PAGE_SKIP;
-	}
+}
 
-	/* This is for swsusp_free() */
-	for_each_pb_page (pbpage, pblist) {
-		SetPageNosave(virt_to_page(pbpage));
-		SetPageNosaveFree(virt_to_page(pbpage));
+static void copy_page_backup_list(struct pbe *dst, struct pbe *src)
+{
+	/* We assume both lists contain the same number of elements */
+	while (src) {
+		dst->orig_address = src->orig_address;
+		dst->swap_address = src->swap_address;
+		dst = dst->next;
+		src = src->next;
 	}
-
-	printk("swsusp: Relocated %d pages\n", rel);
-
-	return pblist;
 }
 
 /*
@@ -949,10 +918,15 @@
 
 	if ((error = read_pagedir(p)))
 		return error;
-
 	create_pbe_list(p, nr_copy_pages);
-
-	if (!(pagedir_nosave = swsusp_pagedir_relocate(p)))
+	mark_unsafe_pages(p);
+	pagedir_nosave = alloc_pagedir(nr_copy_pages, GFP_ATOMIC, 1);
+	if (pagedir_nosave) {
+		create_pbe_list(pagedir_nosave, nr_copy_pages);
+		copy_page_backup_list(pagedir_nosave, p);
+	}
+	free_pagedir(p);
+	if (!pagedir_nosave)
 		return -ENOMEM;
 
 	/* Allocate memory for the image and read the data from swap */
Index: linux-2.6.14-git4/kernel/power/power.h
===================================================================
--- linux-2.6.14-git4.orig/kernel/power/power.h	2005-11-01 18:20:28.000000000 +0100
+++ linux-2.6.14-git4/kernel/power/power.h	2005-11-01 18:22:12.000000000 +0100
@@ -66,6 +66,7 @@
 extern asmlinkage int swsusp_arch_resume(void);
 
 extern int restore_highmem(void);
+extern void free_pagedir(struct pbe *pblist);
 extern struct pbe *alloc_pagedir(unsigned nr_pages, gfp_t gfp_mask, int safe_needed);
 extern void create_pbe_list(struct pbe *pblist, unsigned nr_pages);
 extern void swsusp_free(void);
Index: linux-2.6.14-git4/kernel/power/snapshot.c
===================================================================
--- linux-2.6.14-git4.orig/kernel/power/snapshot.c	2005-11-01 18:20:28.000000000 +0100
+++ linux-2.6.14-git4/kernel/power/snapshot.c	2005-11-01 18:22:12.000000000 +0100
@@ -217,7 +217,7 @@
  *	free_pagedir - free pages allocated with alloc_pagedir()
  */
 
-static void free_pagedir(struct pbe *pblist)
+void free_pagedir(struct pbe *pblist)
 {
 	struct pbe *pbe;
 

