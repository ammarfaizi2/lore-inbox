Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbVJ3Pwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVJ3Pwn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 10:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbVJ3Pwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 10:52:42 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:31409 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932102AbVJ3PwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 10:52:23 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/3] swsusp: move snapshot-handling functions to snapshot.c
Date: Sun, 30 Oct 2005 16:44:44 +0100
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <200510301637.48842.rjw@sisk.pl>
In-Reply-To: <200510301637.48842.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510301644.44874.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the snapshot-handling functions remaining in swsusp.c
to snapshot.c (ie. it moves the code without changing the functionality).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/power.h    |    2 
 kernel/power/snapshot.c |  121 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/power/swsusp.c   |  126 ------------------------------------------------
 3 files changed, 125 insertions(+), 124 deletions(-)

Index: linux-2.6.14-rc5-mm1/kernel/power/power.h
===================================================================
--- linux-2.6.14-rc5-mm1.orig/kernel/power/power.h	2005-10-28 23:49:15.000000000 +0200
+++ linux-2.6.14-rc5-mm1/kernel/power/power.h	2005-10-28 23:50:11.000000000 +0200
@@ -69,4 +69,6 @@
 extern int restore_highmem(void);
 extern struct pbe * alloc_pagedir(unsigned nr_pages);
 extern void create_pbe_list(struct pbe *pblist, unsigned nr_pages);
+extern int check_pagedir(struct pbe *pblist);
+extern struct pbe * swsusp_pagedir_relocate(struct pbe *pblist);
 extern void swsusp_free(void);
Index: linux-2.6.14-rc5-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/kernel/power/snapshot.c	2005-10-28 23:49:15.000000000 +0200
+++ linux-2.6.14-rc5-mm1/kernel/power/snapshot.c	2005-10-28 23:50:11.000000000 +0200
@@ -423,3 +423,124 @@
 	printk("swsusp: critical section/: done (%d pages copied)\n", nr_pages);
 	return 0;
 }
+
+/**
+ *	On resume, for storing the PBE list and the image,
+ *	we can only use memory pages that do not conflict with the pages
+ *	which had been used before suspend.
+ *
+ *	We don't know which pages are usable until we allocate them.
+ *
+ *	Allocated but unusable (ie eaten) memory pages are marked so that
+ *	swsusp_free() can release them
+ */
+
+unsigned long get_safe_page(unsigned gfp_mask)
+{
+	unsigned long m;
+
+	do {
+		m = get_zeroed_page(gfp_mask);
+		if (m && PageNosaveFree(virt_to_page(m)))
+			/* This is for swsusp_free() */
+			SetPageNosave(virt_to_page(m));
+	} while (m && PageNosaveFree(virt_to_page(m)));
+	if (m) {
+		/* This is for swsusp_free() */
+		SetPageNosave(virt_to_page(m));
+		SetPageNosaveFree(virt_to_page(m));
+	}
+	return m;
+}
+
+/**
+ *	check_pagedir - We ensure here that pages that the PBEs point to
+ *	won't collide with pages where we're going to restore from the loaded
+ *	pages later
+ */
+
+int check_pagedir(struct pbe *pblist)
+{
+	struct pbe *p;
+
+	/* This is necessary, so that we can free allocated pages
+	 * in case of failure
+	 */
+	for_each_pbe (p, pblist)
+		p->address = 0UL;
+
+	for_each_pbe (p, pblist) {
+		p->address = get_safe_page(GFP_ATOMIC);
+		if (!p->address)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+/**
+ *	swsusp_pagedir_relocate - It is possible, that some memory pages
+ *	occupied by the list of PBEs collide with pages where we're going to
+ *	restore from the loaded pages later.  We relocate them here.
+ */
+
+struct pbe * swsusp_pagedir_relocate(struct pbe *pblist)
+{
+	struct zone *zone;
+	unsigned long zone_pfn;
+	struct pbe *pbpage, *tail, *p;
+	void *m;
+	int rel = 0;
+
+	if (!pblist) /* a sanity check */
+		return NULL;
+
+	/* Clear page flags */
+
+	for_each_zone (zone) {
+        	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
+        		if (pfn_valid(zone_pfn + zone->zone_start_pfn))
+                		ClearPageNosaveFree(pfn_to_page(zone_pfn +
+					zone->zone_start_pfn));
+	}
+
+	/* Mark orig addresses */
+
+	for_each_pbe (p, pblist)
+		SetPageNosaveFree(virt_to_page(p->orig_address));
+
+	tail = pblist + PB_PAGE_SKIP;
+
+	/* Relocate colliding pages */
+
+	for_each_pb_page (pbpage, pblist) {
+		if (PageNosaveFree(virt_to_page((unsigned long)pbpage))) {
+			m = (void *)get_safe_page(GFP_ATOMIC | __GFP_COLD);
+			if (!m)
+				return NULL;
+			memcpy(m, (void *)pbpage, PAGE_SIZE);
+			if (pbpage == pblist)
+				pblist = (struct pbe *)m;
+			else
+				tail->next = (struct pbe *)m;
+			pbpage = (struct pbe *)m;
+
+			/* We have to link the PBEs again */
+			for (p = pbpage; p < pbpage + PB_PAGE_SKIP; p++)
+				if (p->next) /* needed to save the end */
+					p->next = p + 1;
+
+			rel++;
+		}
+		tail = pbpage + PB_PAGE_SKIP;
+	}
+
+	/* This is for swsusp_free() */
+	for_each_pb_page (pbpage, pblist) {
+		SetPageNosave(virt_to_page(pbpage));
+		SetPageNosaveFree(virt_to_page(pbpage));
+	}
+
+	printk("swsusp: Relocated %d pages\n", rel);
+
+	return pblist;
+}
Index: linux-2.6.14-rc5-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/kernel/power/swsusp.c	2005-10-28 23:49:15.000000000 +0200
+++ linux-2.6.14-rc5-mm1/kernel/power/swsusp.c	2005-10-28 23:50:11.000000000 +0200
@@ -645,130 +645,6 @@
 	return error;
 }
 
-/**
- *	On resume, for storing the PBE list and the image,
- *	we can only use memory pages that do not conflict with the pages
- *	which had been used before suspend.
- *
- *	We don't know which pages are usable until we allocate them.
- *
- *	Allocated but unusable (ie eaten) memory pages are marked so that
- *	swsusp_free() can release them
- */
-
-unsigned long get_safe_page(unsigned gfp_mask)
-{
-	unsigned long m;
-
-	do {
-		m = get_zeroed_page(gfp_mask);
-		if (m && PageNosaveFree(virt_to_page(m)))
-			/* This is for swsusp_free() */
-			SetPageNosave(virt_to_page(m));
-	} while (m && PageNosaveFree(virt_to_page(m)));
-	if (m) {
-		/* This is for swsusp_free() */
-		SetPageNosave(virt_to_page(m));
-		SetPageNosaveFree(virt_to_page(m));
-	}
-	return m;
-}
-
-/**
- *	check_pagedir - We ensure here that pages that the PBEs point to
- *	won't collide with pages where we're going to restore from the loaded
- *	pages later
- */
-
-static int check_pagedir(struct pbe *pblist)
-{
-	struct pbe *p;
-
-	/* This is necessary, so that we can free allocated pages
-	 * in case of failure
-	 */
-	for_each_pbe (p, pblist)
-		p->address = 0UL;
-
-	for_each_pbe (p, pblist) {
-		p->address = get_safe_page(GFP_ATOMIC);
-		if (!p->address)
-			return -ENOMEM;
-	}
-	return 0;
-}
-
-/**
- *	swsusp_pagedir_relocate - It is possible, that some memory pages
- *	occupied by the list of PBEs collide with pages where we're going to
- *	restore from the loaded pages later.  We relocate them here.
- */
-
-static struct pbe * swsusp_pagedir_relocate(struct pbe *pblist)
-{
-	struct zone *zone;
-	unsigned long zone_pfn;
-	struct pbe *pbpage, *tail, *p;
-	void *m;
-	int rel = 0;
-
-	if (!pblist) /* a sanity check */
-		return NULL;
-
-	pr_debug("swsusp: Relocating pagedir (%lu pages to check)\n",
-			swsusp_info.pagedir_pages);
-
-	/* Clear page flags */
-
-	for_each_zone (zone) {
-        	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
-        		if (pfn_valid(zone_pfn + zone->zone_start_pfn))
-                		ClearPageNosaveFree(pfn_to_page(zone_pfn +
-					zone->zone_start_pfn));
-	}
-
-	/* Mark orig addresses */
-
-	for_each_pbe (p, pblist)
-		SetPageNosaveFree(virt_to_page(p->orig_address));
-
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
-
-	/* This is for swsusp_free() */
-	for_each_pb_page (pbpage, pblist) {
-		SetPageNosave(virt_to_page(pbpage));
-		SetPageNosaveFree(virt_to_page(pbpage));
-	}
-
-	printk("swsusp: Relocated %d pages\n", rel);
-
-	return pblist;
-}
-
 /*
  *	Using bio to read from swap.
  *	This code requires a bit more work than just using buffer heads
@@ -1015,6 +891,8 @@
 
 	create_pbe_list(p, nr_copy_pages);
 
+	pr_debug("swsusp: Relocating pagedir (%lu pages to check)\n",
+			swsusp_info.pagedir_pages);
 	if (!(pagedir_nosave = swsusp_pagedir_relocate(p)))
 		return -ENOMEM;
 

