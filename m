Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbVJaTgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVJaTgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 14:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVJaTgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 14:36:16 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:185 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932251AbVJaTgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 14:36:15 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] swsusp: move snapshot-handling functions to snapshot.c
Date: Mon, 31 Oct 2005 20:36:36 +0100
User-Agent: KMail/1.8.2
Cc: Pavel Machek <pavel@suse.cz>
References: <200510301637.48842.rjw@sisk.pl> <200510301644.44874.rjw@sisk.pl> <20051030195254.GA1729@openzaurus.ucw.cz>
In-Reply-To: <20051030195254.GA1729@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510312036.36335.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 30 of October 2005 20:52, Pavel Machek wrote:
> Hi!
> 
> > This patch moves the snapshot-handling functions remaining in swsusp.c
> > to snapshot.c (ie. it moves the code without changing the functionality).
> >
> 
> I'm sorry, but I acked this one too quickly. I'd prefer to keep "relocate" code where
> it is, and define "must not collide" as a part of interface. That will keep snapshot.c
> smaller/simpler,

Speaking of simplifications and having seen your code I hope you will agree with
the appended patch against vanilla 2.6.14-git3 (it reduces the duplication of code,
and replaces swsusp_pagedir_relocate with a simpler mechanism).

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/power.h    |    6 +-
 kernel/power/snapshot.c |  121 +++++++++++++++++++++++++++++++++--------
 kernel/power/swsusp.c   |  139 ++----------------------------------------------
 3 files changed, 109 insertions(+), 157 deletions(-)

Index: linux-2.6.14-git3/kernel/power/power.h
===================================================================
--- linux-2.6.14-git3.orig/kernel/power/power.h	2005-10-31 20:27:30.000000000 +0100
+++ linux-2.6.14-git3/kernel/power/power.h	2005-10-31 20:29:31.000000000 +0100
@@ -66,7 +66,11 @@
 extern asmlinkage int swsusp_arch_resume(void);
 
 extern int restore_highmem(void);
-extern struct pbe * alloc_pagedir(unsigned nr_pages);
+extern void free_pagedir(struct pbe *pblist);
+extern struct pbe *alloc_pagedir(unsigned nr_pages, int need_safe);
 extern void create_pbe_list(struct pbe *pblist, unsigned nr_pages);
+extern int alloc_data_pages(struct pbe *pblist, int need_safe);
 extern void swsusp_free(void);
 extern int enough_swap(unsigned nr_pages);
+extern void mark_unsafe_pages(struct pbe *pblist);
+extern void copy_page_backup_list(struct pbe *dst, struct pbe *src);
Index: linux-2.6.14-git3/kernel/power/snapshot.c
===================================================================
--- linux-2.6.14-git3.orig/kernel/power/snapshot.c	2005-10-31 20:27:30.000000000 +0100
+++ linux-2.6.14-git3/kernel/power/snapshot.c	2005-10-31 20:29:31.000000000 +0100
@@ -212,12 +212,44 @@
 	BUG_ON(pbe);
 }
 
+/**
+ *	@safe_needed - on resume, for storing the PBE list and the image,
+ *	we can only use memory pages that do not conflict with the pages
+ *	which had been used before suspend.
+ *
+ *	The unsafe pages are marked with the help of SetPageNosaveFree()
+ *	in mark_unsafe_pages()
+ *
+ *	Allocated but unusable (ie eaten) memory pages should be marked
+ *	so that swsusp_free() can release them
+ */
+
+static inline unsigned long snapshot_get_page(gfp_t gfp_mask, int safe_needed)
+{
+	unsigned long m;
+
+	if (safe_needed)
+		do {
+			m = get_zeroed_page(gfp_mask);
+			if (m && PageNosaveFree(virt_to_page(m)))
+				/* This is for swsusp_free() */
+				SetPageNosave(virt_to_page(m));
+		} while (m && PageNosaveFree(virt_to_page(m)));
+	else
+		m = get_zeroed_page(gfp_mask);
+	if (m) {
+		/* This is for swsusp_free() */
+		SetPageNosave(virt_to_page(m));
+		SetPageNosaveFree(virt_to_page(m));
+	}
+	return m;
+}
 
 /**
  *	free_pagedir - free pages allocated with alloc_pagedir()
  */
 
-static void free_pagedir(struct pbe *pblist)
+void free_pagedir(struct pbe *pblist)
 {
 	struct pbe *pbe;
 
@@ -270,22 +302,14 @@
 	pr_debug("create_pbe_list(): initialized %d PBEs\n", num);
 }
 
-static void *alloc_image_page(void)
+static inline void *alloc_image_page(int safe_needed)
 {
-	void *res = (void *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
-	if (res) {
-		SetPageNosave(virt_to_page(res));
-		SetPageNosaveFree(virt_to_page(res));
-	}
-	return res;
+	return (void *)snapshot_get_page(GFP_ATOMIC | __GFP_COLD, safe_needed);
 }
 
 /**
  *	alloc_pagedir - Allocate the page directory.
  *
- *	First, determine exactly how many pages we need and
- *	allocate them.
- *
  *	We arrange the pages in a chain: each page is an array of PBES_PER_PAGE
  *	struct pbe elements (pbes) and the last element in the page points
  *	to the next page.
@@ -293,7 +317,7 @@
  *	On each page we set up a list of struct_pbe elements.
  */
 
-struct pbe *alloc_pagedir(unsigned nr_pages)
+struct pbe *alloc_pagedir(unsigned nr_pages, int safe_needed)
 {
 	unsigned num;
 	struct pbe *pblist, *pbe;
@@ -302,12 +326,12 @@
 		return NULL;
 
 	pr_debug("alloc_pagedir(): nr_pages = %d\n", nr_pages);
-	pblist = alloc_image_page();
+	pblist = alloc_image_page(safe_needed);
 	/* FIXME: rewrite this ugly loop */
 	for (pbe = pblist, num = PBES_PER_PAGE; pbe && num < nr_pages;
         		pbe = pbe->next, num += PBES_PER_PAGE) {
 		pbe += PB_PAGE_SKIP;
-		pbe->next = alloc_image_page();
+		pbe->next = alloc_image_page(safe_needed);
 	}
 	if (!pbe) { /* get_zeroed_page() failed */
 		free_pagedir(pblist);
@@ -316,6 +340,18 @@
 	return pblist;
 }
 
+int alloc_data_pages(struct pbe *pblist, int safe_needed)
+{
+	struct pbe *p;
+
+	for_each_pbe (p, pblist) {
+		p->address = (unsigned long)alloc_image_page(safe_needed);
+		if (!p->address)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
 /**
  * Free pages we allocated for suspend. Suspend pages are alocated
  * before atomic copy, so we need to free them after resume.
@@ -355,24 +391,20 @@
 		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
 }
 
-
 static struct pbe *swsusp_alloc(unsigned nr_pages)
 {
-	struct pbe *pblist, *p;
+	struct pbe *pblist;
 
-	if (!(pblist = alloc_pagedir(nr_pages))) {
+	if (!(pblist = alloc_pagedir(nr_pages, 0))) {
 		printk(KERN_ERR "suspend: Allocating pagedir failed.\n");
 		return NULL;
 	}
 	create_pbe_list(pblist, nr_pages);
 
-	for_each_pbe (p, pblist) {
-		p->address = (unsigned long)alloc_image_page();
-		if (!p->address) {
-			printk(KERN_ERR "suspend: Allocating image pages failed.\n");
-			swsusp_free();
-			return NULL;
-		}
+	if (alloc_data_pages(pblist, 0)) {
+		printk(KERN_ERR "suspend: Allocating image pages failed.\n");
+		swsusp_free();
+		return NULL;
 	}
 
 	return pblist;
@@ -433,3 +465,44 @@
 	printk("swsusp: critical section/: done (%d pages copied)\n", nr_pages);
 	return 0;
 }
+
+/* Resume-related functions */
+
+void mark_unsafe_pages(struct pbe *pblist)
+{
+	struct zone *zone;
+	unsigned long zone_pfn;
+	struct pbe *p;
+
+	if (!pblist) /* a sanity check */
+		return;
+
+	/* Clear page flags */
+	for_each_zone (zone) {
+        	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
+        		if (pfn_valid(zone_pfn + zone->zone_start_pfn))
+                		ClearPageNosaveFree(pfn_to_page(zone_pfn +
+					zone->zone_start_pfn));
+	}
+
+	/* Mark orig addresses */
+	for_each_pbe (p, pblist)
+		SetPageNosaveFree(virt_to_page(p->orig_address));
+
+}
+
+void copy_page_backup_list(struct pbe *dst, struct pbe *src)
+{
+	/* We assume both lists contain the same number of elements */
+	while (src) {
+		dst->orig_address = src->orig_address;
+		dst->swap_address = src->swap_address;
+		dst = dst->next;
+		src = src->next;
+	}
+}
+
+unsigned long get_safe_page(gfp_t gfp_mask)
+{
+	return (unsigned long)snapshot_get_page(gfp_mask, 1);
+}
Index: linux-2.6.14-git3/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-git3.orig/kernel/power/swsusp.c	2005-10-31 20:27:30.000000000 +0100
+++ linux-2.6.14-git3/kernel/power/swsusp.c	2005-10-31 20:29:31.000000000 +0100
@@ -635,130 +635,6 @@
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
-unsigned long get_safe_page(gfp_t gfp_mask)
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
@@ -905,9 +781,6 @@
 
 /**
  *	data_read - Read image pages from swap.
- *
- *	You do not need to check for overlaps, check_pagedir()
- *	already did that.
  */
 
 static int data_read(struct pbe *pblist)
@@ -997,20 +870,22 @@
 	int error = 0;
 	struct pbe *p;
 
-	if (!(p = alloc_pagedir(nr_copy_pages)))
+	if (!(p = alloc_pagedir(nr_copy_pages, 0)))
 		return -ENOMEM;
 
 	if ((error = read_pagedir(p)))
 		return error;
-
 	create_pbe_list(p, nr_copy_pages);
-
-	if (!(pagedir_nosave = swsusp_pagedir_relocate(p)))
+	mark_unsafe_pages(p);
+	if (!(pagedir_nosave = alloc_pagedir(nr_copy_pages, 1)))
 		return -ENOMEM;
+	create_pbe_list(pagedir_nosave, nr_copy_pages);
+	copy_page_backup_list(pagedir_nosave, p);
+	free_pagedir(p);
 
 	/* Allocate memory for the image and read the data from swap */
 
-	error = check_pagedir(pagedir_nosave);
+	error = alloc_data_pages(pagedir_nosave, 1);
 
 	if (!error)
 		error = data_read(pagedir_nosave);
