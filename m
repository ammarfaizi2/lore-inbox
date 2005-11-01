Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbVKARhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbVKARhG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 12:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbVKARhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 12:37:06 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:54462 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751031AbVKARhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 12:37:04 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 1/2] swsusp: reduce code duplication (was: Re: [PATCH 2/3] swsusp: move snapshot-handling functions to snapshot.c)
Date: Tue, 1 Nov 2005 18:33:19 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200510301637.48842.rjw@sisk.pl> <20051031220233.GC14877@elf.ucw.cz> <200511011357.16995.rjw@sisk.pl>
In-Reply-To: <200511011357.16995.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511011833.19585.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 1 of November 2005 13:57, Rafael J. Wysocki wrote:
}-- snip --{ 
> > > Speaking of simplifications and having seen your code I hope you will agree with
> > > the appended patch against vanilla 2.6.14-git3 (it reduces the duplication of code,
> > > and replaces swsusp_pagedir_relocate with a simpler mechanism).
> > 
> > ...and also moves stuff around in a way
> > 
> > a) I don't like
> > 
> > and
> > 
> > b) is almost impossible to review
> 
> OK, I'll try to split it into two patches to make it cleaner.

The first patch is appended, the next one will be in the reply to this message.

The changes made by the appended patch are necessary for the relocation
simplification in the next patch.  Still, the changes allow us to drop
check_pagedir() and make get_safe_page() be a one-line wrapper around
alloc_image_page() (get_safe_page() goes to snapshot.c, because
alloc_image_page() is static and it does not make sense to export it).

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/power.h    |    3 +-
 kernel/power/snapshot.c |   62 +++++++++++++++++++++++++++++++++++++-----------
 kernel/power/swsusp.c   |   57 +-------------------------------------------
 3 files changed, 52 insertions(+), 70 deletions(-)

Index: linux-2.6.14-git4/kernel/power/power.h
===================================================================
--- linux-2.6.14-git4.orig/kernel/power/power.h	2005-11-01 18:18:31.000000000 +0100
+++ linux-2.6.14-git4/kernel/power/power.h	2005-11-01 18:20:28.000000000 +0100
@@ -66,7 +66,8 @@
 extern asmlinkage int swsusp_arch_resume(void);
 
 extern int restore_highmem(void);
-extern struct pbe * alloc_pagedir(unsigned nr_pages);
+extern struct pbe *alloc_pagedir(unsigned nr_pages, gfp_t gfp_mask, int safe_needed);
 extern void create_pbe_list(struct pbe *pblist, unsigned nr_pages);
 extern void swsusp_free(void);
+extern int alloc_data_pages(struct pbe *pblist, gfp_t gfp_mask, int safe_needed);
 extern int enough_swap(unsigned nr_pages);
Index: linux-2.6.14-git4/kernel/power/snapshot.c
===================================================================
--- linux-2.6.14-git4.orig/kernel/power/snapshot.c	2005-11-01 18:18:31.000000000 +0100
+++ linux-2.6.14-git4/kernel/power/snapshot.c	2005-11-01 18:20:28.000000000 +0100
@@ -270,9 +270,30 @@
 	pr_debug("create_pbe_list(): initialized %d PBEs\n", num);
 }
 
-static void *alloc_image_page(void)
+/**
+ *	@safe_needed - on resume, for storing the PBE list and the image,
+ *	we can only use memory pages that do not conflict with the pages
+ *	which had been used before suspend.
+ *
+ *	The unsafe pages are marked with the PG_nosave_free flag
+ *
+ *	Allocated but unusable (ie eaten) memory pages should be marked
+ *	so that swsusp_free() can release them
+ */
+
+static inline void *alloc_image_page(gfp_t gfp_mask, int safe_needed)
 {
-	void *res = (void *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+	void *res;
+
+	if (safe_needed)
+		do {
+			res = (void *)get_zeroed_page(gfp_mask);
+			if (res && PageNosaveFree(virt_to_page(res)))
+				/* This is for swsusp_free() */
+				SetPageNosave(virt_to_page(res));
+		} while (res && PageNosaveFree(virt_to_page(res)));
+	else
+		res = (void *)get_zeroed_page(gfp_mask);
 	if (res) {
 		SetPageNosave(virt_to_page(res));
 		SetPageNosaveFree(virt_to_page(res));
@@ -280,6 +301,11 @@
 	return res;
 }
 
+unsigned long get_safe_page(gfp_t gfp_mask)
+{
+	return (unsigned long)alloc_image_page(gfp_mask, 1);
+}
+
 /**
  *	alloc_pagedir - Allocate the page directory.
  *
@@ -293,7 +319,7 @@
  *	On each page we set up a list of struct_pbe elements.
  */
 
-struct pbe *alloc_pagedir(unsigned nr_pages)
+struct pbe *alloc_pagedir(unsigned nr_pages, gfp_t gfp_mask, int safe_needed)
 {
 	unsigned num;
 	struct pbe *pblist, *pbe;
@@ -302,12 +328,12 @@
 		return NULL;
 
 	pr_debug("alloc_pagedir(): nr_pages = %d\n", nr_pages);
-	pblist = alloc_image_page();
+	pblist = alloc_image_page(gfp_mask, safe_needed);
 	/* FIXME: rewrite this ugly loop */
 	for (pbe = pblist, num = PBES_PER_PAGE; pbe && num < nr_pages;
         		pbe = pbe->next, num += PBES_PER_PAGE) {
 		pbe += PB_PAGE_SKIP;
-		pbe->next = alloc_image_page();
+		pbe->next = alloc_image_page(gfp_mask, safe_needed);
 	}
 	if (!pbe) { /* get_zeroed_page() failed */
 		free_pagedir(pblist);
@@ -355,24 +381,32 @@
 		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
 }
 
+int alloc_data_pages(struct pbe *pblist, gfp_t gfp_mask, int safe_needed)
+{
+	struct pbe *p;
+
+	for_each_pbe (p, pblist) {
+		p->address = (unsigned long)alloc_image_page(gfp_mask, safe_needed);
+		if (!p->address)
+			return -ENOMEM;
+	}
+	return 0;
+}
 
 static struct pbe *swsusp_alloc(unsigned nr_pages)
 {
-	struct pbe *pblist, *p;
+	struct pbe *pblist;
 
-	if (!(pblist = alloc_pagedir(nr_pages))) {
+	if (!(pblist = alloc_pagedir(nr_pages, GFP_ATOMIC | __GFP_COLD, 0))) {
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
+	if (alloc_data_pages(pblist, GFP_ATOMIC | __GFP_COLD, 0)) {
+		printk(KERN_ERR "suspend: Allocating image pages failed.\n");
+		swsusp_free();
+		return NULL;
 	}
 
 	return pblist;
Index: linux-2.6.14-git4/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-git4.orig/kernel/power/swsusp.c	2005-11-01 18:18:31.000000000 +0100
+++ linux-2.6.14-git4/kernel/power/swsusp.c	2005-11-01 18:20:28.000000000 +0100
@@ -636,59 +636,6 @@
 }
 
 /**
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
  *	swsusp_pagedir_relocate - It is possible, that some memory pages
  *	occupied by the list of PBEs collide with pages where we're going to
  *	restore from the loaded pages later.  We relocate them here.
@@ -997,7 +944,7 @@
 	int error = 0;
 	struct pbe *p;
 
-	if (!(p = alloc_pagedir(nr_copy_pages)))
+	if (!(p = alloc_pagedir(nr_copy_pages, GFP_ATOMIC, 0)))
 		return -ENOMEM;
 
 	if ((error = read_pagedir(p)))
@@ -1010,7 +957,7 @@
 
 	/* Allocate memory for the image and read the data from swap */
 
-	error = check_pagedir(pagedir_nosave);
+	error = alloc_data_pages(pagedir_nosave, GFP_ATOMIC, 1);
 
 	if (!error)
 		error = data_read(pagedir_nosave);

