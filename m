Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030637AbWHIKQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030637AbWHIKQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 06:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030642AbWHIKQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 06:16:26 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:26078 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030637AbWHIKQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 06:16:24 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH -mm 2/5] swsusp: Use memory bitmaps during resume
Date: Wed, 9 Aug 2006 12:04:36 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@osdl.org>
References: <200608091152.49094.rjw@sisk.pl>
In-Reply-To: <200608091152.49094.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608091204.36186.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make swsusp use memory bitmaps to store its internal information during the
resume phase of the suspend-resume cycle.

If the pfns of saveable pages are saved during the suspend phase instead of
the kernel virtual addresses of these pages, we can use them during the resume
phase directly to set the corresponding bits in a memory bitmap.  Then, this
bitmap is used to mark the page frames corresponding to the pages that were
saveable before the suspend (aka "unsafe" page frames).

Next, we allocate as many page frames as needed to store the entire suspend
image and make sure that there will be some extra free "safe" page frames for
the list of PBEs constructed later.  Subsequently, the image is loaded and,
if possible, the data loaded from it are written into their "original" page frames
(ie. the ones they had occupied before the suspend).  The image data that
cannot be written into their "original" page frames are loaded into "safe" page
frames and their "original" kernel virtual addresses, as well as the addresses
of the "safe" pages containing their copies, are stored in a list of PBEs.
Finally, the list of PBEs is used to copy the remaining image data into their
"original" page frames (this is done atomically, by the architecture-dependent
parts of swsusp).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/suspend.h |   27 ---
 kernel/power/power.h    |   11 -
 kernel/power/snapshot.c |  421 ++++++++++++++++++++----------------------------
 kernel/power/swap.c     |    4 
 kernel/power/user.c     |    1 
 5 files changed, 195 insertions(+), 269 deletions(-)

Index: linux-2.6.18-rc3-mm2/kernel/power/snapshot.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/kernel/power/snapshot.c
+++ linux-2.6.18-rc3-mm2/kernel/power/snapshot.c
@@ -37,7 +37,7 @@
 struct pbe *pagedir_nosave;
 static unsigned int nr_copy_pages;
 static unsigned int nr_meta_pages;
-static unsigned long *buffer;
+static void *buffer;
 
 #ifdef CONFIG_HIGHMEM
 unsigned int count_highmem_pages(void)
@@ -165,7 +165,7 @@ static inline int restore_highmem(void) 
  *	and we count them using unsafe_pages
  */
 
-static unsigned int unsafe_pages;
+static unsigned int allocated_unsafe_pages;
 
 static void *alloc_image_page(gfp_t gfp_mask, int safe_needed)
 {
@@ -176,7 +176,7 @@ static void *alloc_image_page(gfp_t gfp_
 		while (res && PageNosaveFree(virt_to_page(res))) {
 			/* The page is unsafe, mark it for swsusp_free() */
 			SetPageNosave(virt_to_page(res));
-			unsafe_pages++;
+			allocated_unsafe_pages++;
 			res = (void *)get_zeroed_page(gfp_mask);
 		}
 	if (res) {
@@ -765,101 +765,10 @@ copy_data_pages(struct memory_bitmap *co
 }
 
 /**
- *	free_pagedir - free pages allocated with alloc_pagedir()
- */
-
-static void free_pagedir(struct pbe *pblist, int clear_nosave_free)
-{
-	struct pbe *pbe;
-
-	while (pblist) {
-		pbe = (pblist + PB_PAGE_SKIP)->next;
-		free_image_page(pblist, clear_nosave_free);
-		pblist = pbe;
-	}
-}
-
-/**
- *	fill_pb_page - Create a list of PBEs on a given memory page
- */
-
-static inline void fill_pb_page(struct pbe *pbpage, unsigned int n)
-{
-	struct pbe *p;
-
-	p = pbpage;
-	pbpage += n - 1;
-	do
-		p->next = p + 1;
-	while (++p < pbpage);
-}
-
-/**
- *	create_pbe_list - Create a list of PBEs on top of a given chain
- *	of memory pages allocated with alloc_pagedir()
- *
- *	This function assumes that pages allocated by alloc_image_page() will
- *	always be zeroed.
- */
-
-static inline void create_pbe_list(struct pbe *pblist, unsigned int nr_pages)
-{
-	struct pbe *pbpage;
-	unsigned int num = PBES_PER_PAGE;
-
-	for_each_pb_page (pbpage, pblist) {
-		if (num >= nr_pages)
-			break;
-
-		fill_pb_page(pbpage, PBES_PER_PAGE);
-		num += PBES_PER_PAGE;
-	}
-	if (pbpage) {
-		num -= PBES_PER_PAGE;
-		fill_pb_page(pbpage, nr_pages - num);
-	}
-}
-
-/**
- *	alloc_pagedir - Allocate the page directory.
- *
- *	First, determine exactly how many pages we need and
- *	allocate them.
+ *	swsusp_free - free pages allocated for the suspend.
  *
- *	We arrange the pages in a chain: each page is an array of PBES_PER_PAGE
- *	struct pbe elements (pbes) and the last element in the page points
- *	to the next page.
- *
- *	On each page we set up a list of struct_pbe elements.
- */
-
-static struct pbe *alloc_pagedir(unsigned int nr_pages, gfp_t gfp_mask,
-				 int safe_needed)
-{
-	unsigned int num;
-	struct pbe *pblist, *pbe;
-
-	if (!nr_pages)
-		return NULL;
-
-	pblist = alloc_image_page(gfp_mask, safe_needed);
-	pbe = pblist;
-	for (num = PBES_PER_PAGE; num < nr_pages; num += PBES_PER_PAGE) {
-		if (!pbe) {
-			free_pagedir(pblist, 1);
-			return NULL;
-		}
-		pbe += PB_PAGE_SKIP;
-		pbe->next = alloc_image_page(gfp_mask, safe_needed);
-		pbe = pbe->next;
-	}
-	create_pbe_list(pblist, nr_pages);
-	return pblist;
-}
-
-/**
- * Free pages we allocated for suspend. Suspend pages are alocated
- * before atomic copy, so we need to free them after resume.
+ *	Suspend pages are alocated before the atomic copy is made, so we
+ *	need to release them after the resume.
  */
 
 void swsusp_free(void)
@@ -897,14 +806,18 @@ void swsusp_free(void)
 static int enough_free_mem(unsigned int nr_pages)
 {
 	struct zone *zone;
-	unsigned int n = 0;
+	unsigned int free = 0, meta = 0;
 
 	for_each_zone (zone)
-		if (!is_highmem(zone))
-			n += zone->free_pages;
-	pr_debug("swsusp: available memory: %u pages\n", n);
-	return n > (nr_pages + PAGES_FOR_IO +
-		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
+		if (!is_highmem(zone)) {
+			free += zone->free_pages;
+			meta += snapshot_additional_pages(zone);
+		}
+
+	pr_debug("swsusp: pages needed: %u + %u + %u, available pages: %u\n",
+		nr_pages, PAGES_FOR_IO, meta, free);
+
+	return free > nr_pages + PAGES_FOR_IO + meta;
 }
 
 static int
@@ -954,11 +867,6 @@ asmlinkage int swsusp_save(void)
 	nr_pages = count_data_pages();
 	printk("swsusp: Need to copy %u pages\n", nr_pages);
 
-	pr_debug("swsusp: pages needed: %u + %lu + %u, free: %u\n",
-		 nr_pages,
-		 (nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE,
-		 PAGES_FOR_IO, nr_free_pages());
-
 	if (!enough_free_mem(nr_pages)) {
 		printk(KERN_ERR "swsusp: Not enough free memory\n");
 		return -ENOMEM;
@@ -1000,22 +908,19 @@ static void init_header(struct swsusp_in
 }
 
 /**
- *	pack_addresses - the addresses corresponding to pfns found in the
- *	bitmap @bm are stored in the array @buf[] (1 page)
+ *	pack_pfns - pfns corresponding to the set bits found in the bitmap @bm
+ *	are stored in the array @buf[] (1 page at a time)
  */
 
 static inline void
-pack_addresses(unsigned long *buf, struct memory_bitmap *bm)
+pack_pfns(unsigned long *buf, struct memory_bitmap *bm)
 {
 	int j;
 
 	for (j = 0; j < PAGE_SIZE / sizeof(long); j++) {
-		unsigned long pfn = memory_bm_next_pfn(bm);
-
-		if (unlikely(pfn == BM_END_OF_MAP))
+		buf[j] = memory_bm_next_pfn(bm);
+		if (unlikely(buf[j] == BM_END_OF_MAP))
 			break;
-
-		buf[j] = (unsigned long)page_address(pfn_to_page(pfn));
 	}
 }
 
@@ -1061,7 +966,7 @@ int snapshot_read_next(struct snapshot_h
 	if (handle->prev < handle->cur) {
 		if (handle->cur <= nr_meta_pages) {
 			memset(buffer, 0, PAGE_SIZE);
-			pack_addresses(buffer, &orig_bm);
+			pack_pfns(buffer, &orig_bm);
 		} else {
 			unsigned long pfn = memory_bm_next_pfn(&copy_bm);
 
@@ -1087,14 +992,10 @@ int snapshot_read_next(struct snapshot_h
  *	had been used before suspend
  */
 
-static int mark_unsafe_pages(struct pbe *pblist)
+static int mark_unsafe_pages(struct memory_bitmap *bm)
 {
 	struct zone *zone;
 	unsigned long pfn, max_zone_pfn;
-	struct pbe *p;
-
-	if (!pblist) /* a sanity check */
-		return -EINVAL;
 
 	/* Clear page flags */
 	for_each_zone (zone) {
@@ -1104,30 +1005,37 @@ static int mark_unsafe_pages(struct pbe 
 				ClearPageNosaveFree(pfn_to_page(pfn));
 	}
 
-	/* Mark orig addresses */
-	for_each_pbe (p, pblist) {
-		if (virt_addr_valid(p->orig_address))
-			SetPageNosaveFree(virt_to_page(p->orig_address));
-		else
-			return -EFAULT;
-	}
+	/* Mark pages that correspond to the "original" pfns as "unsafe" */
+	bm_position_reset(bm);
+	do {
+		pfn = memory_bm_next_pfn(bm);
+		if (likely(pfn != BM_END_OF_MAP)) {
+			if (likely(pfn_valid(pfn)))
+				SetPageNosaveFree(pfn_to_page(pfn));
+			else
+				return -EFAULT;
+		}
+	} while (pfn != BM_END_OF_MAP);
 
-	unsafe_pages = 0;
+	allocated_unsafe_pages = 0;
 
 	return 0;
 }
 
-static void copy_page_backup_list(struct pbe *dst, struct pbe *src)
+static void
+duplicate_memory_bitmap(struct memory_bitmap *dst, struct memory_bitmap *src)
 {
-	/* We assume both lists contain the same number of elements */
-	while (src) {
-		dst->orig_address = src->orig_address;
-		dst = dst->next;
-		src = src->next;
+	unsigned long pfn;
+
+	bm_position_reset(src);
+	pfn = memory_bm_next_pfn(src);
+	while (pfn != BM_END_OF_MAP) {
+		memory_bm_set_bit(dst, pfn);
+		pfn = memory_bm_next_pfn(src);
 	}
 }
 
-static int check_header(struct swsusp_info *info)
+static inline int check_header(struct swsusp_info *info)
 {
 	char *reason = NULL;
 
@@ -1154,19 +1062,14 @@ static int check_header(struct swsusp_in
  *	load header - check the image header and copy data from it
  */
 
-static int load_header(struct snapshot_handle *handle,
-                              struct swsusp_info *info)
+static int
+load_header(struct swsusp_info *info)
 {
 	int error;
-	struct pbe *pblist;
 
+	pagedir_nosave = NULL;
 	error = check_header(info);
 	if (!error) {
-		pblist = alloc_pagedir(info->image_pages, GFP_ATOMIC, 0);
-		if (!pblist)
-			return -ENOMEM;
-		pagedir_nosave = pblist;
-		handle->pbe = pblist;
 		nr_copy_pages = info->image_pages;
 		nr_meta_pages = info->pages - info->image_pages - 1;
 	}
@@ -1174,108 +1077,137 @@ static int load_header(struct snapshot_h
 }
 
 /**
- *	unpack_orig_addresses - copy the elements of @buf[] (1 page) to
- *	the PBEs in the list starting at @pbe
+ *	unpack_orig_pfns - for each element of @buf[] (1 page at a time) set
+ *	the corresponding bit in the memory bitmap @bm
  */
 
-static inline struct pbe *unpack_orig_addresses(unsigned long *buf,
-                                                struct pbe *pbe)
+static inline void
+unpack_orig_pfns(unsigned long *buf, struct memory_bitmap *bm)
 {
 	int j;
 
-	for (j = 0; j < PAGE_SIZE / sizeof(long) && pbe; j++) {
-		pbe->orig_address = buf[j];
-		pbe = pbe->next;
+	for (j = 0; j < PAGE_SIZE / sizeof(long); j++) {
+		if (unlikely(buf[j] == BM_END_OF_MAP))
+			break;
+
+		memory_bm_set_bit(bm, buf[j]);
 	}
-	return pbe;
 }
 
 /**
- *	prepare_image - use metadata contained in the PBE list
- *	pointed to by pagedir_nosave to mark the pages that will
- *	be overwritten in the process of restoring the system
- *	memory state from the image ("unsafe" pages) and allocate
- *	memory for the image
+ *	prepare_image - use the memory bitmap @bm to mark the pages that will
+ *	be overwritten in the process of restoring the system memory state
+ *	from the suspend image ("unsafe" pages) and allocate memory for the
+ *	image.
  *
- *	The idea is to allocate the PBE list first and then
- *	allocate as many pages as it's needed for the image data,
- *	but not to assign these pages to the PBEs initially.
- *	Instead, we just mark them as allocated and create a list
- *	of "safe" which will be used later
+ *	The idea is to allocate a new memory bitmap first and then allocate
+ *	as many pages as needed for the image data, but not to assign these
+ *	pages to specific tasks initially.  Instead, we just mark them as
+ *	allocated and create a list of "safe" pages that will be used later.
  */
 
-static struct linked_page *safe_pages;
+#define PBES_PER_LINKED_PAGE	(LINKED_PAGE_DATA_SIZE / sizeof(struct pbe))
 
-static int prepare_image(struct snapshot_handle *handle)
+static struct linked_page *safe_pages_list;
+
+static int
+prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm)
 {
-	int error = 0;
-	unsigned int nr_pages = nr_copy_pages;
-	struct pbe *p, *pblist = NULL;
+	unsigned int nr_pages;
+	struct linked_page *sp_list, *lp;
+	int error;
 
-	p = pagedir_nosave;
-	error = mark_unsafe_pages(p);
-	if (!error) {
-		pblist = alloc_pagedir(nr_pages, GFP_ATOMIC, 1);
-		if (pblist)
-			copy_page_backup_list(pblist, p);
-		free_pagedir(p, 0);
-		if (!pblist)
+	error = mark_unsafe_pages(bm);
+	if (error)
+		goto Free;
+
+	error = create_memory_bm(new_bm, GFP_ATOMIC, 1);
+	if (error)
+		goto Free;
+
+	duplicate_memory_bitmap(new_bm, bm);
+	free_memory_bm(bm, 0);
+	/* Reserve some safe pages for potential later use.
+	 *
+	 * NOTE: This way we make sure there will be enough safe pages for the
+	 * chain_alloc() in get_buffer().  It is a bit wasteful, but
+	 * nr_copy_pages cannot be greater than 50% of the memory anyway.
+	 */
+	sp_list = NULL;
+	/* nr_copy_pages cannot be lesser than allocated_unsafe_pages */
+	nr_pages = nr_copy_pages - allocated_unsafe_pages;
+	nr_pages = DIV_ROUND_UP(nr_pages, PBES_PER_LINKED_PAGE);
+	while (nr_pages > 0) {
+		lp = alloc_image_page(GFP_ATOMIC, 1);
+		if (!lp) {
 			error = -ENOMEM;
-	}
-	safe_pages = NULL;
-	if (!error && nr_pages > unsafe_pages) {
-		nr_pages -= unsafe_pages;
-		while (nr_pages--) {
-			struct linked_page *ptr;
-
-			ptr = (void *)get_zeroed_page(GFP_ATOMIC);
-			if (!ptr) {
-				error = -ENOMEM;
-				break;
-			}
-			if (!PageNosaveFree(virt_to_page(ptr))) {
-				/* The page is "safe", add it to the list */
-				ptr->next = safe_pages;
-				safe_pages = ptr;
-			}
-			/* Mark the page as allocated */
-			SetPageNosave(virt_to_page(ptr));
-			SetPageNosaveFree(virt_to_page(ptr));
+			goto Free;
 		}
+		lp->next = sp_list;
+		sp_list = lp;
+		nr_pages--;
+	}
+	/* Preallocate memory for the image */
+	safe_pages_list = NULL;
+	nr_pages = nr_copy_pages - allocated_unsafe_pages;
+	while (nr_pages > 0) {
+		lp = (struct linked_page *)get_zeroed_page(GFP_ATOMIC);
+		if (!lp) {
+			error = -ENOMEM;
+			goto Free;
+		}
+		if (!PageNosaveFree(virt_to_page(lp))) {
+			/* The page is "safe", add it to the list */
+			lp->next = safe_pages_list;
+			safe_pages_list = lp;
+		}
+		/* Mark the page as allocated */
+		SetPageNosave(virt_to_page(lp));
+		SetPageNosaveFree(virt_to_page(lp));
+		nr_pages--;
+	}
+	/* Free the reserved safe pages so that chain_alloc() can use them */
+	while (sp_list) {
+		lp = sp_list->next;
+		free_image_page(sp_list, 1);
+		sp_list = lp;
 	}
-	if (!error) {
-		pagedir_nosave = pblist;
-	} else {
-		handle->pbe = NULL;
-		swsusp_free();
-	}
+	return 0;
+
+Free:
+	swsusp_free();
 	return error;
 }
 
-static void *get_buffer(struct snapshot_handle *handle)
+/**
+ *	get_buffer - compute the address that snapshot_write_next() should
+ *	set for its caller to write to.
+ */
+
+static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
 {
-	struct pbe *pbe = handle->pbe, *last = handle->last_pbe;
-	struct page *page = virt_to_page(pbe->orig_address);
+	struct pbe *pbe;
+	struct page *page = pfn_to_page(memory_bm_next_pfn(bm));
 
-	if (PageNosave(page) && PageNosaveFree(page)) {
-		/*
-		 * We have allocated the "original" page frame and we can
-		 * use it directly to store the read page
+	if (PageNosave(page) && PageNosaveFree(page))
+		/* We have allocated the "original" page frame and we can
+		 * use it directly to store the loaded page.
 		 */
-		pbe->address = 0;
-		if (last && last->next)
-			last->next = NULL;
-		return (void *)pbe->orig_address;
-	}
-	/*
-	 * The "original" page frame has not been allocated and we have to
-	 * use a "safe" page frame to store the read page
+		return page_address(page);
+
+	/* The "original" page frame has not been allocated and we have to
+	 * use a "safe" page frame to store the loaded page.
 	 */
-	pbe->address = (unsigned long)safe_pages;
-	safe_pages = safe_pages->next;
-	if (last)
-		last->next = pbe;
-	handle->last_pbe = pbe;
+	pbe = chain_alloc(ca, sizeof(struct pbe));
+	if (!pbe) {
+		swsusp_free();
+		return NULL;
+	}
+	pbe->orig_address = (unsigned long)page_address(page);
+	pbe->address = (unsigned long)safe_pages_list;
+	safe_pages_list = safe_pages_list->next;
+	pbe->next = pagedir_nosave;
+	pagedir_nosave = pbe;
 	return (void *)pbe->address;
 }
 
@@ -1303,10 +1235,13 @@ static void *get_buffer(struct snapshot_
 
 int snapshot_write_next(struct snapshot_handle *handle, size_t count)
 {
+	static struct chain_allocator ca;
 	int error = 0;
 
+	/* Check if we have already loaded the entire image */
 	if (handle->prev && handle->cur > nr_meta_pages + nr_copy_pages)
 		return 0;
+
 	if (!buffer) {
 		/* This makes the buffer be freed by swsusp_free() */
 		buffer = alloc_image_page(GFP_ATOMIC, 0);
@@ -1317,27 +1252,32 @@ int snapshot_write_next(struct snapshot_
 		handle->buffer = buffer;
 	handle->sync_read = 1;
 	if (handle->prev < handle->cur) {
-		if (!handle->prev) {
-			error = load_header(handle,
-					(struct swsusp_info *)buffer);
+		if (handle->prev == 0) {
+			error = load_header(buffer);
+			if (error)
+				return error;
+
+			error = create_memory_bm(&copy_bm, GFP_ATOMIC, 0);
 			if (error)
 				return error;
+
 		} else if (handle->prev <= nr_meta_pages) {
-			handle->pbe = unpack_orig_addresses(buffer,
-							handle->pbe);
-			if (!handle->pbe) {
-				error = prepare_image(handle);
+			unpack_orig_pfns(buffer, &copy_bm);
+			if (handle->prev == nr_meta_pages) {
+				error = prepare_image(&orig_bm, &copy_bm);
 				if (error)
 					return error;
-				handle->pbe = pagedir_nosave;
-				handle->last_pbe = NULL;
-				handle->buffer = get_buffer(handle);
+
+				chain_init(&ca, GFP_ATOMIC, 1);
+				bm_position_reset(&orig_bm);
+				pagedir_nosave = NULL;
 				handle->sync_read = 0;
+				handle->buffer = get_buffer(&orig_bm, &ca);
+				if (!handle->buffer)
+					return -ENOMEM;
 			}
 		} else {
-			handle->pbe = handle->pbe->next;
-			handle->buffer = get_buffer(handle);
-			handle->sync_read = 0;
+			handle->buffer = get_buffer(&orig_bm, &ca);
 		}
 		handle->prev = handle->cur;
 	}
@@ -1355,6 +1295,13 @@ int snapshot_write_next(struct snapshot_
 
 int snapshot_image_loaded(struct snapshot_handle *handle)
 {
-	return !(!handle->pbe || handle->pbe->next || !nr_copy_pages ||
-		handle->cur <= nr_meta_pages + nr_copy_pages);
+	return !(!nr_copy_pages ||
+			handle->cur <= nr_meta_pages + nr_copy_pages);
+}
+
+void snapshot_free_unused_memory(struct snapshot_handle *handle)
+{
+	/* Free only if we have loaded the image entirely */
+	if (handle->prev && handle->cur > nr_meta_pages + nr_copy_pages)
+		free_memory_bm(&orig_bm, 1);
 }
Index: linux-2.6.18-rc3-mm2/kernel/power/power.h
===================================================================
--- linux-2.6.18-rc3-mm2.orig/kernel/power/power.h
+++ linux-2.6.18-rc3-mm2/kernel/power/power.h
@@ -83,16 +83,6 @@ struct snapshot_handle {
 	unsigned int	prev;	/* number of the block of PAGE_SIZE bytes that
 				 * was the current one previously
 				 */
-	struct pbe	*pbe;	/* PBE that corresponds to 'buffer' */
-	struct pbe	*last_pbe;	/* When the image is restored (eg. read
-					 * from disk) we can store some image
-					 * data directly in the page frames
-					 * in which they were before suspend.
-					 * In such a case the PBEs that
-					 * correspond to them will be unused.
-					 * This is the last PBE, so far, that
-					 * does not correspond to such data.
-					 */
 	void		*buffer;	/* address of the block to read from
 					 * or write to
 					 */
@@ -115,6 +105,7 @@ extern unsigned int snapshot_additional_
 extern int snapshot_read_next(struct snapshot_handle *handle, size_t count);
 extern int snapshot_write_next(struct snapshot_handle *handle, size_t count);
 extern int snapshot_image_loaded(struct snapshot_handle *handle);
+extern void snapshot_free_unused_memory(struct snapshot_handle *handle);
 
 #define SNAPSHOT_IOC_MAGIC	'3'
 #define SNAPSHOT_FREEZE			_IO(SNAPSHOT_IOC_MAGIC, 1)
Index: linux-2.6.18-rc3-mm2/kernel/power/swap.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/kernel/power/swap.c
+++ linux-2.6.18-rc3-mm2/kernel/power/swap.c
@@ -332,8 +332,7 @@ static int enough_swap(unsigned int nr_p
 	unsigned int free_swap = count_swap_pages(root_swap, 1);
 
 	pr_debug("swsusp: free swap pages: %u\n", free_swap);
-	return free_swap > (nr_pages + PAGES_FOR_IO +
-		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
+	return free_swap > nr_pages + PAGES_FOR_IO;
 }
 
 /**
@@ -548,6 +547,7 @@ static int load_image(struct swap_map_ha
 		error = err2;
 	if (!error) {
 		printk("\b\b\b\bdone\n");
+		snapshot_free_unused_memory(snapshot);
 		if (!snapshot_image_loaded(snapshot))
 			error = -ENODATA;
 	}
Index: linux-2.6.18-rc3-mm2/kernel/power/user.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/kernel/power/user.c
+++ linux-2.6.18-rc3-mm2/kernel/power/user.c
@@ -193,6 +193,7 @@ static int snapshot_ioctl(struct inode *
 			error = -EPERM;
 			break;
 		}
+		snapshot_free_unused_memory(&data->handle);
 		down(&pm_sem);
 		pm_prepare_console();
 		error = device_suspend(PMSG_PRETHAW);
Index: linux-2.6.18-rc3-mm2/include/linux/suspend.h
===================================================================
--- linux-2.6.18-rc3-mm2.orig/include/linux/suspend.h
+++ linux-2.6.18-rc3-mm2/include/linux/suspend.h
@@ -9,30 +9,17 @@
 #include <linux/init.h>
 #include <linux/pm.h>
 
-/* page backup entry */
-typedef struct pbe {
+/* struct pbe is used for creating the list of pages that should be restored
+ * atomically during the resume from disk, because the page frames they have
+ * occupied before the suspend are in use.
+ */
+struct pbe {
 	unsigned long address;		/* address of the copy */
 	unsigned long orig_address;	/* original address of page */
 	struct pbe *next;
-} suspend_pagedir_t;
-
-#define for_each_pbe(pbe, pblist) \
-	for (pbe = pblist ; pbe ; pbe = pbe->next)
-
-#define PBES_PER_PAGE      (PAGE_SIZE/sizeof(struct pbe))
-#define PB_PAGE_SKIP       (PBES_PER_PAGE-1)
-
-#define for_each_pb_page(pbe, pblist) \
-	for (pbe = pblist ; pbe ; pbe = (pbe+PB_PAGE_SKIP)->next)
-
-
-#define SWAP_FILENAME_MAXLENGTH	32
-
+};
 
 extern dev_t swsusp_resume_device;
-   
-/* mm/vmscan.c */
-extern int shrink_mem(void);
 
 /* mm/page_alloc.c */
 extern void drain_local_pages(void);
@@ -53,7 +40,7 @@ static inline void pm_restore_console(vo
 static inline int software_suspend(void)
 {
 	printk("Warning: fake suspend called\n");
-	return -EPERM;
+	return -ENOSYS;
 }
 #endif /* CONFIG_PM */
 

