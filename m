Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVJKSAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVJKSAp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 14:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVJKSAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 14:00:19 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:37800 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932256AbVJKSAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 14:00:13 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/3] swsusp: rework memory freeing on resume
Date: Tue, 11 Oct 2005 19:56:38 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <200510111948.11242.rjw@sisk.pl>
In-Reply-To: <200510111948.11242.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510111956.39405.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch makes swsusp use the PG_nosave and PG_nosave_free flags
to mark pages that should be freed in case of an error during resume.

This allows us to simplify the code and to use swsusp_free() in all of the swsusp's
resume error paths, which makes them actually work.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Index: linux-2.6.14-rc4/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc4.orig/kernel/power/swsusp.c	2005-10-11 19:38:48.000000000 +0200
+++ linux-2.6.14-rc4/kernel/power/swsusp.c	2005-10-11 19:38:56.000000000 +0200
@@ -630,6 +630,11 @@
 	 * execution continues at place where swsusp_arch_suspend was called
          */
 	BUG_ON(!error);
+	/* The only reason why swsusp_arch_resume() can fail is memory being
+	 * very tight, so we have to free it as soon as we can to avoid
+	 * subsequent failures
+	 */
+	swsusp_free();
 	restore_processor_state();
 	restore_highmem();
 	touch_softlockup_watchdog();
@@ -645,54 +650,28 @@
  *
  *	We don't know which pages are usable until we allocate them.
  *
- *	Allocated but unusable (ie eaten) memory pages are linked together
- *	to create a list, so that we can free them easily
- *
- *	We could have used a type other than (void *)
- *	for this purpose, but ...
+ *	Allocated but unusable (ie eaten) memory pages are marked so that
+ *	swsusp_free() can release them
  */
-static void **eaten_memory = NULL;
-
-static inline void eat_page(void *page)
-{
-	void **c;
-
-	c = eaten_memory;
-	eaten_memory = page;
-	*eaten_memory = c;
-}
 
-unsigned long get_usable_page(unsigned gfp_mask)
+unsigned long get_safe_page(unsigned gfp_mask)
 {
 	unsigned long m;
 
-	m = get_zeroed_page(gfp_mask);
-	while (!PageNosaveFree(virt_to_page(m))) {
-		eat_page((void *)m);
+	do {
 		m = get_zeroed_page(gfp_mask);
-		if (!m)
-			break;
+		if (m && PageNosaveFree(virt_to_page(m)))
+			/* This is for swsusp_free() */
+			SetPageNosave(virt_to_page(m));
+	} while (m && PageNosaveFree(virt_to_page(m)));
+	if (m) {
+		/* This is for swsusp_free() */
+		SetPageNosave(virt_to_page(m));
+		SetPageNosaveFree(virt_to_page(m));
 	}
 	return m;
 }
 
-void free_eaten_memory(void)
-{
-	unsigned long m;
-	void **c;
-	int i = 0;
-
-	c = eaten_memory;
-	while (c) {
-		m = (unsigned long)c;
-		c = *c;
-		free_page(m);
-		i++;
-	}
-	eaten_memory = NULL;
-	pr_debug("swsusp: %d unused pages freed\n", i);
-}
-
 /**
  *	check_pagedir - We ensure here that pages that the PBEs point to
  *	won't collide with pages where we're going to restore from the loaded
@@ -710,7 +689,7 @@
 		p->address = 0UL;
 
 	for_each_pbe (p, pblist) {
-		p->address = get_usable_page(GFP_ATOMIC);
+		p->address = get_safe_page(GFP_ATOMIC);
 		if (!p->address)
 			return -ENOMEM;
 	}
@@ -729,7 +708,7 @@
 	unsigned long zone_pfn;
 	struct pbe *pbpage, *tail, *p;
 	void *m;
-	int rel = 0, error = 0;
+	int rel = 0;
 
 	if (!pblist) /* a sanity check */
 		return NULL;
@@ -737,41 +716,37 @@
 	pr_debug("swsusp: Relocating pagedir (%lu pages to check)\n",
 			swsusp_info.pagedir_pages);
 
-	/* Set page flags */
+	/* Clear page flags */
 
 	for_each_zone (zone) {
         	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
-                	SetPageNosaveFree(pfn_to_page(zone_pfn +
+        		if (pfn_valid(zone_pfn + zone->zone_start_pfn))
+                		ClearPageNosaveFree(pfn_to_page(zone_pfn +
 					zone->zone_start_pfn));
 	}
 
-	/* Clear orig addresses */
+	/* Mark orig addresses */
 
 	for_each_pbe (p, pblist)
-		ClearPageNosaveFree(virt_to_page(p->orig_address));
+		SetPageNosaveFree(virt_to_page(p->orig_address));
 
 	tail = pblist + PB_PAGE_SKIP;
 
 	/* Relocate colliding pages */
 
 	for_each_pb_page (pbpage, pblist) {
-		if (!PageNosaveFree(virt_to_page((unsigned long)pbpage))) {
-			m = (void *)get_usable_page(GFP_ATOMIC | __GFP_COLD);
-			if (!m) {
-				error = -ENOMEM;
-				break;
-			}
+		if (PageNosaveFree(virt_to_page((unsigned long)pbpage))) {
+			m = (void *)get_safe_page(GFP_ATOMIC | __GFP_COLD);
+			if (!m)
+				return NULL;
 			memcpy(m, (void *)pbpage, PAGE_SIZE);
 			if (pbpage == pblist)
 				pblist = (struct pbe *)m;
 			else
 				tail->next = (struct pbe *)m;
-
-			eat_page((void *)pbpage);
 			pbpage = (struct pbe *)m;
 
 			/* We have to link the PBEs again */
-
 			for (p = pbpage; p < pbpage + PB_PAGE_SKIP; p++)
 				if (p->next) /* needed to save the end */
 					p->next = p + 1;
@@ -781,15 +756,13 @@
 		tail = pbpage + PB_PAGE_SKIP;
 	}
 
-	if (error) {
-		printk("\nswsusp: Out of memory\n\n");
-		free_pagedir(pblist);
-		free_eaten_memory();
-		pblist = NULL;
-		/* Is this even worth handling? It should never ever happen, and we
-		   have just lost user's state, anyway... */
-	} else
-		printk("swsusp: Relocated %d pages\n", rel);
+	/* This is for swsusp_free() */
+	for_each_pb_page (pbpage, pblist) {
+		SetPageNosave(virt_to_page(pbpage));
+		SetPageNosaveFree(virt_to_page(pbpage));
+	}
+
+	printk("swsusp: Relocated %d pages\n", rel);
 
 	return pblist;
 }
@@ -1007,9 +980,7 @@
 			break;
 	}
 
-	if (error)
-		free_pagedir(pblist);
-	else
+	if (!error)
 		BUG_ON(i != swsusp_info.pagedir_pages);
 
 	return error;
@@ -1052,15 +1023,6 @@
 	if (!error)
 		error = data_read(pagedir_nosave);
 
-	if (error) { /* We fail cleanly */
-		free_eaten_memory();
-		for_each_pbe (p, pagedir_nosave)
-			if (p->address) {
-				free_page(p->address);
-				p->address = 0UL;
-			}
-		free_pagedir(pagedir_nosave);
-	}
 	return error;
 }
 
Index: linux-2.6.14-rc4/kernel/power/disk.c
===================================================================
--- linux-2.6.14-rc4.orig/kernel/power/disk.c	2005-10-11 19:38:17.000000000 +0200
+++ linux-2.6.14-rc4/kernel/power/disk.c	2005-10-11 19:38:56.000000000 +0200
@@ -30,7 +30,6 @@
 extern int swsusp_read(void);
 extern void swsusp_close(void);
 extern int swsusp_resume(void);
-extern int swsusp_free(void);
 
 
 static int noresume = 0;
@@ -252,14 +251,17 @@
 
 	pr_debug("PM: Reading swsusp image.\n");
 
-	if ((error = swsusp_read()))
-		goto Cleanup;
+	if ((error = swsusp_read())) {
+		swsusp_free();
+		goto Thaw;
+	}
 
 	pr_debug("PM: Preparing devices for restore.\n");
 
 	if ((error = device_suspend(PMSG_FREEZE))) {
 		printk("Some devices failed to suspend\n");
-		goto Free;
+		swsusp_free();
+		goto Thaw;
 	}
 
 	mb();
@@ -268,9 +270,7 @@
 	swsusp_resume();
 	pr_debug("PM: Restore failed, recovering.n");
 	device_resume();
- Free:
-	swsusp_free();
- Cleanup:
+ Thaw:
 	unprepare_processes();
  Done:
 	/* For success case, the suspend path will release the lock */
Index: linux-2.6.14-rc4/kernel/power/power.h
===================================================================
--- linux-2.6.14-rc4.orig/kernel/power/power.h	2005-10-11 19:38:48.000000000 +0200
+++ linux-2.6.14-rc4/kernel/power/power.h	2005-10-11 19:38:56.000000000 +0200
@@ -66,7 +66,7 @@
 extern asmlinkage int swsusp_arch_resume(void);
 
 extern int restore_highmem(void);
-extern void free_pagedir(struct pbe *pblist);
 extern struct pbe * alloc_pagedir(unsigned nr_pages);
 extern void create_pbe_list(struct pbe *pblist, unsigned nr_pages);
+extern void swsusp_free(void);
 extern int enough_swap(void);
Index: linux-2.6.14-rc4/kernel/power/snapshot.c
===================================================================
--- linux-2.6.14-rc4.orig/kernel/power/snapshot.c	2005-10-11 19:38:48.000000000 +0200
+++ linux-2.6.14-rc4/kernel/power/snapshot.c	2005-10-11 19:38:56.000000000 +0200
@@ -239,7 +239,7 @@
  *	free_pagedir - free pages allocated with alloc_pagedir()
  */
 
-void free_pagedir(struct pbe *pblist)
+static void free_pagedir(struct pbe *pblist)
 {
 	struct pbe *pbe;
 
Index: linux-2.6.14-rc4/arch/x86_64/kernel/suspend.c
===================================================================
--- linux-2.6.14-rc4.orig/arch/x86_64/kernel/suspend.c	2005-10-11 19:38:17.000000000 +0200
+++ linux-2.6.14-rc4/arch/x86_64/kernel/suspend.c	2005-10-11 19:38:56.000000000 +0200
@@ -148,57 +148,7 @@
 
 pgd_t *temp_level4_pgt;
 
-static void **pages;
-
-static inline void *__add_page(void)
-{
-	void **c;
-
-	c = (void **)get_usable_page(GFP_ATOMIC);
-	if (c) {
-		*c = pages;
-		pages = c;
-	}
-	return c;
-}
-
-static inline void *__next_page(void)
-{
-	void **c;
-
-	c = pages;
-	if (c) {
-		pages = *c;
-		*c = NULL;
-	}
-	return c;
-}
-
-/*
- * Try to allocate as many usable pages as needed and daisy chain them.
- * If one allocation fails, free the pages allocated so far
- */
-static int alloc_usable_pages(unsigned long n)
-{
-	void *p;
-
-	pages = NULL;
-	do
-		if (!__add_page())
-			break;
-	while (--n);
-	if (n) {
-		p = __next_page();
-		while (p) {
-			free_page((unsigned long)p);
-			p = __next_page();
-		}
-		return -ENOMEM;
-	}
-	return 0;
-}
-
-static void res_phys_pud_init(pud_t *pud, unsigned long address, unsigned long end)
+static int res_phys_pud_init(pud_t *pud, unsigned long address, unsigned long end)
 {
 	long i, j;
 
@@ -212,7 +162,9 @@
 		if (paddr >= end)
 			break;
 
-		pmd = (pmd_t *)__next_page();
+		pmd = (pmd_t *)get_safe_page(GFP_ATOMIC);
+		if (!pmd)
+			return -ENOMEM;
 		set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
 		for (j = 0; j < PTRS_PER_PMD; pmd++, j++, paddr += PMD_SIZE) {
 			unsigned long pe;
@@ -224,13 +176,17 @@
 			set_pmd(pmd, __pmd(pe));
 		}
 	}
+	return 0;
 }
 
-static void set_up_temporary_mappings(void)
+static int set_up_temporary_mappings(void)
 {
 	unsigned long start, end, next;
+	int error;
 
-	temp_level4_pgt = (pgd_t *)__next_page();
+	temp_level4_pgt = (pgd_t *)get_safe_page(GFP_ATOMIC);
+	if (!temp_level4_pgt)
+		return -ENOMEM;
 
 	/* It is safe to reuse the original kernel mapping */
 	set_pgd(temp_level4_pgt + pgd_index(__START_KERNEL_map),
@@ -241,29 +197,27 @@
 	end = (unsigned long)pfn_to_kaddr(end_pfn);
 
 	for (; start < end; start = next) {
-		pud_t *pud = (pud_t *)__next_page();
+		pud_t *pud = (pud_t *)get_safe_page(GFP_ATOMIC);
+		if (!pud)
+			return -ENOMEM;
 		next = start + PGDIR_SIZE;
 		if (next > end)
 			next = end;
-		res_phys_pud_init(pud, __pa(start), __pa(next));
+		if ((error = res_phys_pud_init(pud, __pa(start), __pa(next))))
+			return error;
 		set_pgd(temp_level4_pgt + pgd_index(start),
 			mk_kernel_pgd(__pa(pud)));
 	}
+	return 0;
 }
 
 int swsusp_arch_resume(void)
 {
-	unsigned long n;
+	int error;
 
-	n = ((end_pfn << PAGE_SHIFT) + PUD_SIZE - 1) >> PUD_SHIFT;
-	n += (n + PTRS_PER_PUD - 1) / PTRS_PER_PUD + 1;
-	pr_debug("swsusp_arch_resume(): pages needed = %lu\n", n);
-	if (alloc_usable_pages(n)) {
-		free_eaten_memory();
-		return -ENOMEM;
-	}
 	/* We have got enough memory and from now on we cannot recover */
-	set_up_temporary_mappings();
+	if ((error = set_up_temporary_mappings()))
+		return error;
 	restore_image();
 	return 0;
 }
Index: linux-2.6.14-rc4/include/linux/suspend.h
===================================================================
--- linux-2.6.14-rc4.orig/include/linux/suspend.h	2005-10-11 19:38:48.000000000 +0200
+++ linux-2.6.14-rc4/include/linux/suspend.h	2005-10-11 19:38:56.000000000 +0200
@@ -71,8 +71,7 @@
 struct saved_context;
 void __save_processor_state(struct saved_context *ctxt);
 void __restore_processor_state(struct saved_context *ctxt);
-extern unsigned long get_usable_page(unsigned gfp_mask);
-extern void free_eaten_memory(void);
+extern unsigned long get_safe_page(unsigned gfp_mask);
 
 /*
  * XXX: We try to keep some more pages free so that I/O operations succeed
