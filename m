Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbULZWNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbULZWNh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 17:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbULZWNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 17:13:36 -0500
Received: from gprs215-133.eurotel.cz ([160.218.215.133]:7808 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261171AbULZWMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 17:12:09 -0500
Date: Sun, 26 Dec 2004 23:10:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Wichert Akkerman <wichert@wiggy.net>, hugang@soulinfo.com
Subject: Re: Ho ho ho - Linux v2.6.10
Message-ID: <20041226221046.GA1406@elf.ucw.cz>
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org> <200412261445.09336.Rafal.Wysocki@fuw.edu.pl> <20041226193943.GE1661@elf.ucw.cz> <200412262127.49897.Rafal.Wysocki@fuw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412262127.49897.Rafal.Wysocki@fuw.edu.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Usually, it resumes sucessfully for me, but sometimes it fails, like this 
> (on 
> > > an AMD64):
> > > 
> > >  swsusp: Image: 43552 Pages
> > >  swsusp: Pagedir: 341 Pages
> > > pmdisk: Reading pagedir (341 Pages)
> > > Relocating 
> > > 
> pagedir ...........................................................................................................................0
> > > 
> > > Call Trace:<ffffffff8016de7e>{__alloc_pages+766} 
> > > <ffffffff8016df21>{__get_free_pages+33}
> > >        <ffffffff8056191c>{swsusp_read+1020} 
> > > <ffffffff8015f711>{software_resume+33}
> > >        <ffffffff8010c142>{init+162} <ffffffff8010f57b>{child_rip+8}
> > >        <ffffffff8010c0a0>{init+0} <ffffffff8010f573>{child_rip+0}
> > > 
> > > out of memory
> > 
> > ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::g
> > > PM: Resume from disk failed.
> > 
> > Can you try this one? It would be nice to have reproducible way to
> > trigger this before trying to fix it, through.
> > 
> > [Patch is for 2.6.9something+my bigdiff, may need small tweaks]
> 
> It's for i386, isn't it?  Will it work as expected on AMD64?

Ouch, no, it probably will not work on amd64. Some assembly tweaks
would be needed.

Anyway here's that patch ported to 2.6.10+my_bigdiff (just in case
anyone has the same problem on i386).

hugang, I noticed you changed collision code to use a bitmap. This
should reduce complexity from O(n^2) to O(n) [good!], but I'm
concerned about bitmap size you need -- it seems to be big order
allocation. Perhaps you could reuse PageNosaveFree or something like
that?

Also that code should be pretty much separate from "convert pagedir to
linklist", right? Could you separate them?
								Pavel

--- clean-mm/arch/i386/power/swsusp.S	2004-10-19 14:37:44.000000000 +0200
+++ linux-mm/arch/i386/power/swsusp.S	2004-12-26 21:03:30.000000000 +0100
@@ -31,24 +31,33 @@
 	movl $swsusp_pg_dir-__PAGE_OFFSET,%ecx
 	movl %ecx,%cr3
 
-	movl	pagedir_nosave, %ebx
-	xorl	%eax, %eax
-	xorl	%edx, %edx
-	.p2align 4,,7
-
-copy_loop:
-	movl	4(%ebx,%edx),%edi
-	movl	(%ebx,%edx),%esi
-
-	movl	$1024, %ecx
-	rep
-	movsl
-
-	incl	%eax
-	addl	$16, %edx
-	cmpl	nr_copy_pages,%eax
-	jb copy_loop
-	.p2align 4,,7
+	movl  pagedir_nosave, %eax
+	test %eax, %eax
+	je   copy_loop_end
+	movl  $1024, %edx
+
+copy_loop_start:
+	movl  0xc(%eax), %ebp
+	xorl  %ebx, %ebx
+	leal  0x0(%esi),%esi
+
+copy_one_pgdir:
+	movl  0x4(%eax),%edi
+	test %edi, %edi
+	je   copy_loop_end
+
+	movl  (%eax), %esi
+	movl  %edx, %ecx
+	repz movsl %ds:(%esi),%es:(%edi)
+
+	incl  %ebx
+	addl  $0x10, %eax
+	cmpl  $0xff, %ebx
+	jbe  copy_one_pgdir
+	test %ebp, %ebp
+	movl  %ebp, %eax
+	jne  copy_loop_start
+copy_loop_end:
 
 	movl saved_context_esp, %esp
 	movl saved_context_ebp, %ebp
--- clean-mm/kernel/power/swsusp.c	2004-12-25 15:50:29.000000000 +0100
+++ linux-mm/kernel/power/swsusp.c	2004-12-26 21:08:12.000000000 +0100
@@ -74,9 +74,6 @@
 /* References to section boundaries */
 extern char __nosave_begin, __nosave_end;
 
-/* Variables to be preserved over suspend */
-static int pagedir_order_check;
-
 extern char resume_file[];
 static dev_t resume_device;
 /* Local variables that should not be affected by save */
@@ -97,7 +94,6 @@
  */
 suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
 static suspend_pagedir_t *pagedir_save;
-static int pagedir_order __nosavedata = 0;
 
 #define SWSUSP_SIG	"S1SUSPEND"
 
@@ -223,6 +219,60 @@
 	swap_list_unlock();
 }
 
+#define ONE_PAGE_PBE_NUM   (PAGE_SIZE/sizeof(struct pbe))
+#define PBE_IS_PAGE_END(x)  \
+	( PAGE_SIZE - sizeof(struct pbe) == ((x) - ((~(PAGE_SIZE - 1)) & (x))) )
+
+#define pgdir_for_each(pos, n, head) \
+	for(pos = head, n = pos ? (suspend_pagedir_t*)pos->dummy.val : NULL; \
+		pos != NULL; \
+		pos = n, n = pos ? (suspend_pagedir_t *)pos->dummy.val : NULL)
+
+#define pbe_for_each(pos, n, index, max, head) \
+	for(pos = head, index = 0, \
+			n = pos ? (struct pbe *)pos->dummy.val : NULL; \
+		(pos != NULL) && (index < max); \
+		pos = (PBE_IS_PAGE_END((unsigned long)pos)) ? n : \
+			((struct pbe *)((unsigned long)pos + sizeof(struct pbe))), \
+			index ++, \
+			n = pos ? (struct pbe*)pos->dummy.val : NULL)
+/**
+ *  find_pbe_by_index - 
+ *  @pgdir:
+ *  @index:
+ *
+ *
+ */
+static struct pbe *find_pbe_by_index(struct pbe *pgdir, int index)
+{
+	unsigned long p = 0;
+	struct pbe *pbe, *next;
+
+	pr_debug("find_pbe_by_index: %p, 0x%03x", pgdir, index); 
+	pgdir_for_each(pbe, next, pgdir) {
+		if (p == index / ONE_PAGE_PBE_NUM) {
+			pbe = (struct pbe *)((unsigned long)pbe + 
+					(index % ONE_PAGE_PBE_NUM) * sizeof(struct pbe));
+			pr_debug(" %p, o{%p} c{%p}\n",
+					pbe, (void*)pbe->orig_address, (void*)pbe->address);
+			return pbe;
+		}
+		p ++;
+	}
+	return (NULL);
+}
+
+/**
+ *  pagedir_free - 
+ *  @head: 
+ *
+ */
+static void pagedir_free(suspend_pagedir_t *head)
+{
+	suspend_pagedir_t *next, *cur;
+	pgdir_for_each(cur, next, head) 
+		free_page((unsigned long)cur);
+}
 
 
 /**
@@ -269,17 +319,74 @@
 {
 	swp_entry_t entry;
 	int i;
+	struct pbe *next, *pos;
 
-	for (i = 0; i < nr_copy_pages; i++) {
-		entry = (pagedir_nosave + i)->swap_address;
+	pbe_for_each(pos, next, i, nr_copy_pages, pagedir_nosave) {
+		entry = pos->swap_address;
 		if (entry.val)
 			swap_free(entry);
 		else
 			break;
-		(pagedir_nosave + i)->swap_address = (swp_entry_t){0};
+		pos->swap_address = (swp_entry_t){0};
 	}
 }
 
+static int mod_progress = 1;
+
+static void inline mod_printk_progress(int i)
+{
+	if (mod_progress == 0) mod_progress = 1;
+	if (!(i%100))
+		printk( "\b\b\b\b%3d%%", i / mod_progress );
+}
+
+/**
+ *  write_one_pbe -
+ *  @p:
+ *  @data:
+ *  @cur:
+ *
+ */
+static int write_one_pbe(struct pbe *p, void *data, int cur)
+{
+	int error = 0;
+
+	mod_printk_progress(cur);
+
+	pr_debug("write_one_pbe: %p, o{%p} c{%p} %d ",
+			p, (void *)p->orig_address, (void *)p->address, cur);
+	error = write_page((unsigned long)data, &p->swap_address);
+	if (error) return error;
+	pr_debug("%lu\n", swp_offset(p->swap_address));
+
+	return 0;
+}
+
+static int bio_read_page(pgoff_t page_off, void * page);
+
+/**
+ *  read_one_pbe -
+ *  @p:
+ *  @data:
+ *  @cur
+ *
+ */
+static int read_one_pbe(struct pbe *p, void *data, int cur)
+{
+	int error = 0;
+
+	mod_printk_progress(cur);
+
+	pr_debug("read_one_pbe: %p, o{%p} c{%p} %lu\n",
+			p, (void *)p->orig_address, data, 
+			swp_offset(p->swap_address));
+
+	error = bio_read_page(swp_offset(p->swap_address), data);
+	if (error) return error;
+
+	return 0;
+}
+
 
 /**
  *	data_write - Write saved image to swap.
@@ -291,17 +398,15 @@
 {
 	int error = 0;
 	int i;
-	unsigned int mod = nr_copy_pages / 100;
+	struct pbe *pos, *next;
 
-	if (!mod)
-		mod = 1;
+	mod_progress = nr_copy_pages / 100;
 
 	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages );
-	for (i = 0; i < nr_copy_pages && !error; i++) {
-		if (!(i%mod))
-			printk( "\b\b\b\b%3d%%", i / mod );
-		error = write_page((pagedir_nosave+i)->address,
-					  &((pagedir_nosave+i)->swap_address));
+	pbe_for_each(pos, next, i, nr_copy_pages, pagedir_nosave) {
+		BUG_ON(pos->orig_address == 0);
+		error = write_one_pbe(pos, (void*)pos->address, i);
+		if (error) break;
 	}
 	printk("\b\b\b\bdone\n");
 	return error;
@@ -371,15 +476,17 @@
 
 static int write_pagedir(void)
 {
-	unsigned long addr = (unsigned long)pagedir_nosave;
 	int error = 0;
-	int n = SUSPEND_PD_PAGES(nr_copy_pages);
-	int i;
+	int n = 0;
+	suspend_pagedir_t *pgdir, *next;
 
-	swsusp_info.pagedir_pages = n;
+	pgdir_for_each(pgdir, next, pagedir_nosave) {
+		error = write_page((unsigned long)pgdir, &swsusp_info.pagedir[n]);
+		if (error) break;
+		n ++;
+	}
 	printk( "Writing pagedir (%d pages)\n", n);
-	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE)
-		error = write_page(addr, &swsusp_info.pagedir[i]);
+	swsusp_info.pagedir_pages = n;
 	return error;
 }
 
@@ -564,7 +671,7 @@
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
-	struct pbe * pbe = pagedir_nosave;
+	struct pbe * pbe = NULL;
 	int pages_copied = 0;
 	
 	for_each_zone(zone) {
@@ -574,11 +681,14 @@
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 			if (saveable(zone, &zone_pfn)) {
 				struct page * page;
+				pbe = find_pbe_by_index(pagedir_nosave, pages_copied);
+				BUG_ON(pbe == NULL);
 				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
 				pbe->orig_address = (long) page_address(page);
+				BUG_ON(pbe->orig_address == 0);
+				BUG_ON(pbe->address == 0);
 				/* copy_page is not usable for copying task structs. */
 				memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
-				pbe++;
 				pages_copied++;
 			}
 		}
@@ -587,67 +697,160 @@
 	nr_copy_pages = pages_copied;
 }
 
+#define pointer2num(x)  ((x - PAGE_OFFSET) >> 12)
+#define num2pointer(x)  ((x << 12) + PAGE_OFFSET)
+static inline void collide_set_bit(unsigned char *bitmap, 
+		unsigned long bitnum)
+{
+	bitnum = pointer2num(bitnum); 
+	bitmap[bitnum / 8] |= (1 << (bitnum%8));
+}
+static inline int collide_is_bit_set(unsigned char *bitmap, 
+		unsigned long bitnum)
+{               
+	bitnum = pointer2num(bitnum); 
+	return !!(bitmap[bitnum / 8] & (1 << (bitnum%8)));
+}
+static void collide_bitmap_free(unsigned char *bitmap)
+{
+	free_pages((unsigned long)bitmap, 2);
+}
+
+/* ((1 << COLLIDE_BITMAP_ORDER) * PAGE_SIZE * 8) << 12 + PAGE_OFFSET */
+#define COLLIDE_BITMAP_ORDER 3
+
+static unsigned char *collide_bitmap_init(struct pbe *pgdir)
+{
+	unsigned char *bitmap = 
+		(unsigned char *)__get_free_pages(GFP_ATOMIC | __GFP_COLD, 
+										  COLLIDE_BITMAP_ORDER);
+	struct pbe *next;
+
+	if (bitmap == NULL) {
+		return NULL;
+	}
+	memset(bitmap, 0, (1 << COLLIDE_BITMAP_ORDER) * PAGE_SIZE);
+
+	/* do base check */
+	BUG_ON(collide_is_bit_set(bitmap, (unsigned long)bitmap) == 1);
+	collide_set_bit(bitmap, (unsigned long)bitmap);
+	BUG_ON(collide_is_bit_set(bitmap, (unsigned long)bitmap) == 0);
+	while (pgdir != NULL) {
+		unsigned long nums;
+		next = (struct pbe*)pgdir->dummy.val;
+		for (nums = 0; nums < ONE_PAGE_PBE_NUM; nums++) {
+			collide_set_bit(bitmap, (unsigned long)pgdir);
+			collide_set_bit(bitmap, (unsigned long)pgdir->orig_address);
+			pgdir ++;
+		}
+		pgdir = next;
+	}
+	return bitmap;
+}
+
+static void **eaten_memory = NULL;
+
+static void *swsusp_get_safe_free_page(unsigned char *collide)
+{
+	void *addr = NULL;
+	void **c = eaten_memory;
+
+	do {
+		if (addr) {
+			eaten_memory = (void**)addr;
+			*eaten_memory = c;
+			c = eaten_memory;
+		}
+		addr = (void*)__get_free_pages(GFP_ATOMIC | __GFP_COLD, 0);
+		if (!addr) 
+			return NULL;
+	} while (collide && collide_is_bit_set(collide, (unsigned long)addr));
+
+	return addr;
+}
 
 /**
- *	calc_order - Determine the order of allocation needed for pagedir_save.
- *
- *	This looks tricky, but is just subtle. Please fix it some time.
- *	Since there are %nr_copy_pages worth of pages in the snapshot, we need
- *	to allocate enough contiguous space to hold 
- *		(%nr_copy_pages * sizeof(struct pbe)), 
- *	which has the saved/orig locations of the page.. 
- *
- *	SUSPEND_PD_PAGES() tells us how many pages we need to hold those 
- *	structures, then we call get_bitmask_order(), which will tell us the
- *	last bit set in the number, starting with 1. (If we need 30 pages, that
- *	is 0x0000001e in hex. The last bit is the 5th, which is the order we 
- *	would use to allocate 32 contiguous pages).
- *
- *	Since we also need to save those pages, we add the number of pages that
- *	we need to nr_copy_pages, and in case of an overflow, do the 
- *	calculation again to update the number of pages needed. 
+ *  alloc_one_pagedir - 
+ *  @prev:
+ *  @collide:
  *
- *	With this model, we will tend to waste a lot of memory if we just cross
- *	an order boundary. Plus, the higher the order of allocation that we try
- *	to do, the more likely we are to fail in a low-memory situtation 
- *	(though	we're unlikely to get this far in such a case, since swsusp 
- *	requires half of memory to be free anyway).
  */
+static suspend_pagedir_t * alloc_one_pagedir(suspend_pagedir_t *prev, 
+		unsigned char *collide)
+{
+	suspend_pagedir_t *pgdir = NULL;
+	int i;
 
+	pgdir = (suspend_pagedir_t *)swsusp_get_safe_free_page(collide);
 
-static void calc_order(void)
-{
-	int diff = 0;
-	int order = 0;
+	/*pr_debug("pgdir: %p, %p, %d\n", 
+	  pgdir, prev, sizeof(suspend_pagedir_t)); */
+	for (i = 0; i < ONE_PAGE_PBE_NUM; i++) {
+		pgdir[i].dummy.val = 0;
+		pgdir[i].address = 0;
+		pgdir[i].orig_address = 0;
+		if (prev)
+			prev[i].dummy.val= (unsigned long)pgdir;
+	}
+
+	return (pgdir);
+}
 
+/* calc_nums - Determine the nums of allocation needed for pagedir_save. */
+static int calc_nums(int nr_copy)
+{
+	int diff = 0, ret = 0;
 	do {
-		diff = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages)) - order;
+		diff = (nr_copy / ONE_PAGE_PBE_NUM) - ret + 1;
 		if (diff) {
-			order += diff;
-			nr_copy_pages += 1 << diff;
+			ret += diff;
+			nr_copy += diff;
 		}
-	} while(diff);
-	pagedir_order = order;
+	} while (diff);
+	return nr_copy;
 }
 
-
 /**
  *	alloc_pagedir - Allocate the page directory.
+ *	@pbe:
+ *	@pbe_nums:
+ *	@collide:
+ *	@page_nums:
  *
  *	First, determine exactly how many contiguous pages we need and
  *	allocate them.
  */
 
-static int alloc_pagedir(void)
+static int alloc_pagedir(struct pbe **pbe, int pbe_nums,
+		unsigned char *collide, int page_nums)
 {
-	calc_order();
-	pagedir_save = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD,
-							     pagedir_order);
-	if (!pagedir_save)
-		return -ENOMEM;
-	memset(pagedir_save, 0, (1 << pagedir_order) * PAGE_SIZE);
-	pagedir_nosave = pagedir_save;
-	return 0;
+	unsigned int nums = 0;
+	unsigned int after_alloc = pbe_nums;
+	suspend_pagedir_t *prev = NULL, *cur = NULL;
+
+	if (page_nums)
+		after_alloc = ONE_PAGE_PBE_NUM * page_nums;
+	else
+		after_alloc = calc_nums(after_alloc);
+	pr_debug("alloc_pagedir: %d, %d\n", pbe_nums, after_alloc);
+	for (nums = 0 ; nums < after_alloc ; nums += ONE_PAGE_PBE_NUM) {
+		cur = alloc_one_pagedir(prev, collide);
+		pr_debug("alloc_one_pagedir: %p\n", cur);
+		if (!cur) { /* get page failed */
+			goto no_mem;
+		}
+		if (nums == 0) { /* setup the head */
+			*pbe = cur;
+		}
+		prev = cur;
+	}
+	return after_alloc - pbe_nums;
+
+no_mem:
+	pagedir_free(*pbe);
+	*pbe = NULL;
+
+	return (-ENOMEM);
 }
 
 /**
@@ -656,11 +859,10 @@
 
 static void free_image_pages(void)
 {
-	struct pbe * p;
+	struct pbe * p, * n;
 	int i;
 
-	p = pagedir_save;
-	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
+	pbe_for_each(p, n, i, nr_copy_pages, pagedir_save) {
 		if (p->address) {
 			ClearPageNosave(virt_to_page(p->address));
 			free_page(p->address);
@@ -676,10 +878,10 @@
 
 static int alloc_image_pages(void)
 {
-	struct pbe * p;
+	struct pbe * p, * n;
 	int i;
 
-	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
+	pbe_for_each(p, n, i, nr_copy_pages, pagedir_save) {
 		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
 		if (!p->address)
 			return -ENOMEM;
@@ -693,7 +895,7 @@
 	BUG_ON(PageNosave(virt_to_page(pagedir_save)));
 	BUG_ON(PageNosaveFree(virt_to_page(pagedir_save)));
 	free_image_pages();
-	free_pages((unsigned long) pagedir_save, pagedir_order);
+	pagedir_free(pagedir_save);
 }
 
 
@@ -751,17 +953,19 @@
 	if (!enough_swap())
 		return -ENOSPC;
 
-	if ((error = alloc_pagedir())) {
+	error = alloc_pagedir(&pagedir_save, nr_copy_pages, NULL, 0);
+	if (error < 0) {
 		printk("suspend: Allocating pagedir failed.\n");
 		return error;
 	}
+	pr_debug("alloc_pagedir: addon %d\n", error);
+	nr_copy_pages += error;
 	if ((error = alloc_image_pages())) {
 		printk("suspend: Allocating image pages failed.\n");
 		swsusp_free();
 		return error;
 	}
-
-	pagedir_order_check = pagedir_order;
+	pagedir_nosave = pagedir_save;
 	return 0;
 }
 
@@ -855,8 +1059,6 @@
 
 asmlinkage int swsusp_restore(void)
 {
-	BUG_ON (pagedir_order_check != pagedir_order);
-	
 	/* Even mappings of "global" things (vmalloc) need to be fixed */
 	__flush_tlb_global();
 	wbinvd();	/* Nigel says wbinvd here is good idea... */
@@ -882,104 +1084,6 @@
 	return error;
 }
 
-/* More restore stuff */
-
-/*
- * Returns true if given address/order collides with any orig_address 
- */
-static int __init does_collide_order(suspend_pagedir_t *pagedir, unsigned long addr,
-		int order)
-{
-	int i;
-	unsigned long addre = addr + (PAGE_SIZE<<order);
-	
-	for (i=0; i < nr_copy_pages; i++)
-		if ((pagedir+i)->orig_address >= addr &&
-			(pagedir+i)->orig_address < addre)
-			return 1;
-
-	return 0;
-}
-
-/*
- * We check here that pagedir & pages it points to won't collide with pages
- * where we're going to restore from the loaded pages later
- */
-static int __init check_pagedir(void)
-{
-	int i;
-	unsigned int mod = nr_copy_pages / 100;
-
-	if (!mod)
-		mod = 1;
-
-	printk("Relocating pages...     ");
-	for (i=0; i < nr_copy_pages; i++) {
-		unsigned long addr;
-
-		if (!(i%mod))
-			printk( "\b\b\b\b%3d%%", i / mod );
-
-		do {
-			addr = get_zeroed_page(GFP_ATOMIC);
-			if (!addr)
-				return -ENOMEM;
-		} while (does_collide_order(pagedir_nosave, addr, 0));
-
-		(pagedir_nosave+i)->address = addr;
-	}
-	printk("\b\b\b\bdone\n");
-	return 0;
-}
-
-static int __init swsusp_pagedir_relocate(void)
-{
-	/*
-	 * We have to avoid recursion (not to overflow kernel stack),
-	 * and that's why code looks pretty cryptic 
-	 */
-	suspend_pagedir_t *old_pagedir = pagedir_nosave;
-	void **eaten_memory = NULL;
-	void **c = eaten_memory, *m, *f;
-	int ret = 0;
-
-	printk("Relocating pagedir ");
-
-	if (!does_collide_order(old_pagedir, (unsigned long)old_pagedir, pagedir_order)) {
-		printk("not necessary\n");
-		return check_pagedir();
-	}
-
-	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order)) != NULL) {
-		if (!does_collide_order(old_pagedir, (unsigned long)m, pagedir_order))
-			break;
-		eaten_memory = m;
-		printk( "." ); 
-		*eaten_memory = c;
-		c = eaten_memory;
-	}
-
-	if (!m) {
-		printk("out of memory\n");
-		ret = -ENOMEM;
-	} else {
-		pagedir_nosave =
-			memcpy(m, old_pagedir, PAGE_SIZE << pagedir_order);
-	}
-
-	c = eaten_memory;
-	while (c) {
-		printk(":");
-		f = c;
-		c = *c;
-		free_pages((unsigned long)f, pagedir_order);
-	}
-	if (ret)
-		return ret;
-	printk("|\n");
-	return check_pagedir();
-}
-
 /**
  *	Using bio to read from swap.
  *	This code requires a bit more work than just using buffer heads
@@ -1094,7 +1198,6 @@
 		return -EPERM;
 	}
 	nr_copy_pages = swsusp_info.image_pages;
-	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 	return error;
 }
 
@@ -1121,6 +1224,95 @@
 	return error;
 }
 
+static void __init eat_progress(void)
+{
+	char *eaten_progess = "-\\|/";
+	static int eaten_i = 0;
+
+	printk("\b%c", eaten_progess[eaten_i]);
+	eaten_i ++;
+	if (eaten_i > 3) eaten_i = 0;
+}
+
+static int __init check_one_pbe(struct pbe *p, void *collide, int cur)
+{
+	unsigned long addr = 0;
+
+	pr_debug("check_one_pbe: %p %lu o{%p} ", 
+			p, p->swap_address.val, (void*)p->orig_address);
+	addr = (unsigned long)swsusp_get_safe_free_page(collide);
+	if(!addr)
+		return -ENOMEM;
+	pr_debug("c{%p} done\n", (void*)addr);
+	p->address = addr;
+
+	return 0;
+}
+
+static void __init swsusp_copy_pagedir(suspend_pagedir_t *d_pgdir, 
+		suspend_pagedir_t *s_pgdir)
+{
+	int i = 0;
+
+	while (s_pgdir != NULL) {
+		suspend_pagedir_t *s_next = (suspend_pagedir_t *)s_pgdir->dummy.val;
+		suspend_pagedir_t *d_next = (suspend_pagedir_t *)d_pgdir->dummy.val;
+		for (i = 0; i < ONE_PAGE_PBE_NUM; i++) {
+			d_pgdir->address = s_pgdir->address;
+			d_pgdir->orig_address = s_pgdir->orig_address;
+			d_pgdir->swap_address = s_pgdir->swap_address;
+			s_pgdir ++; d_pgdir ++;
+		}
+		d_pgdir = d_next;
+		s_pgdir = s_next;
+	};
+}
+/**
+ * We check here that pagedir & pages it points to won't collide with pages
+ * where we're going to restore from the loaded pages later
+ */
+static int __init check_pagedir(void)
+{
+	void **c, *f;
+	struct pbe *next, *pos;
+	int error, index;
+	suspend_pagedir_t *addr = NULL;
+	unsigned char *bitmap = collide_bitmap_init(pagedir_nosave);
+
+	BUG_ON(bitmap == NULL);
+
+	printk("Relocating pagedir ... ");
+	error = alloc_pagedir(&addr, nr_copy_pages, bitmap, 
+			swsusp_info.pagedir_pages);
+	if (error < 0) {
+		return error;
+	}
+	swsusp_copy_pagedir(addr, pagedir_nosave);
+	pagedir_free(pagedir_nosave);
+
+	/* check copy address */
+	pbe_for_each(pos, next, index, nr_copy_pages, addr) {
+		error = check_one_pbe(pos, bitmap, index);
+		BUG_ON(error);
+	}
+
+	/* free eaten memory */
+	c = eaten_memory;
+	while (c) {
+		eat_progress();
+		f = c;
+		c = *c;
+		free_pages((unsigned long)f, 0);
+	}
+	/* free unused memory */
+	collide_bitmap_free(bitmap);
+	printk("     done\n");
+
+	pagedir_nosave = addr;
+
+	return 0;
+}
+
 /**
  *	swsusp_read_data - Read image pages from swap.
  *
@@ -1130,53 +1322,67 @@
 
 static int __init data_read(void)
 {
-	struct pbe * p;
+	struct pbe * p, * n;
 	int error;
 	int i;
-	int mod = nr_copy_pages / 100;
 
-	if (!mod)
-		mod = 1;
+	if ((error = check_pagedir())) {
+		return -ENOMEM;
+	}
 
-	if ((error = swsusp_pagedir_relocate()))
-		return error;
+	mod_progress = nr_copy_pages / 100;
 
 	printk( "Reading image data (%d pages):     ", nr_copy_pages );
-	for(i = 0, p = pagedir_nosave; i < nr_copy_pages && !error; i++, p++) {
-		if (!(i%mod))
-			printk( "\b\b\b\b%3d%%", i / mod );
-		error = bio_read_page(swp_offset(p->swap_address),
-				  (void *)p->address);
+	pbe_for_each(p, n, i, nr_copy_pages, pagedir_nosave) {
+		error = read_one_pbe(p, (void*)p->address, i);
+		if (error) break;
 	}
 	printk(" %d done.\n",i);
 	return error;
-
 }
 
 extern dev_t __init name_to_dev_t(const char *line);
 
+static int __init read_one_pagedir(suspend_pagedir_t *pgdir, int i)
+{
+	unsigned long offset = swp_offset(swsusp_info.pagedir[i]);
+	unsigned long next;
+	int error = 0;
+
+	next = pgdir->dummy.val;
+	pr_debug("read_one_pagedir: %p, %d, %lu, %p\n", 
+			pgdir, i, offset, (void*)next);
+	if ((error = bio_read_page(offset, (void *)pgdir))) {
+		return error;
+	}
+	pgdir->dummy.val = next;
+
+	return error;
+}
+
+/*
+ * reading pagedir from swap device
+ */
 static int __init read_pagedir(void)
 {
-	unsigned long addr;
-	int i, n = swsusp_info.pagedir_pages;
+	int i = 0, n = swsusp_info.pagedir_pages;
 	int error = 0;
+	suspend_pagedir_t *pgdir, *next;
 
-	addr = __get_free_pages(GFP_ATOMIC, pagedir_order);
-	if (!addr)
+	error = alloc_pagedir(&pagedir_nosave, nr_copy_pages, NULL, n);
+	if (error < 0)
 		return -ENOMEM;
-	pagedir_nosave = (struct pbe *)addr;
 
-	pr_debug("swsusp: Reading pagedir (%d Pages)\n",n);
+	printk("pmdisk: Reading pagedir (%d Pages)\n",n);
 
-	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE) {
-		unsigned long offset = swp_offset(swsusp_info.pagedir[i]);
-		if (offset)
-			error = bio_read_page(offset, (void *)addr);
-		else
-			error = -EFAULT;
+	pgdir_for_each(pgdir, next, pagedir_nosave) {
+		error = read_one_pagedir(pgdir, i);
+		if (error) break;
+		i++;
 	}
+	BUG_ON(i != n);
 	if (error)
-		free_pages((unsigned long)pagedir_nosave, pagedir_order);
+		pagedir_free(pagedir_nosave);
 	return error;
 }
 
@@ -1191,7 +1397,7 @@
 	if ((error = read_pagedir()))
 		return error;
 	if ((error = data_read()))
-		free_pages((unsigned long)pagedir_nosave, pagedir_order);
+		pagedir_free(pagedir_nosave);
 	return error;
 }
 
@@ -1223,3 +1429,50 @@
 		pr_debug("swsusp: Error %d resuming\n", error);
 	return error;
 }
+
+/**
+ *  for_each_pbe_copy_back - 
+ *
+ *  That usefuly for help us writing the code in assemble code
+ *
+ */
+/* #define CREATE_ASM_CODE */
+#ifdef CREATE_ASM_CODE
+#if 0 /* if your copy back code is running in real mode, enable it */
+#define GET_ADDRESS(x) __pa(x) 
+#else
+#define GET_ADDRESS(x) (x)
+#endif
+asmlinkage void for_each_pbe_copy_back(void)
+{
+	struct pbe *pgdir, *next;
+
+	pgdir = pagedir_nosave;
+	while (pgdir != NULL) {
+		unsigned long nums, i;
+		pgdir = (struct pbe *)GET_ADDRESS(pgdir);
+		next = (struct pbe*)pgdir->dummy.val;
+		for (nums = 0; nums < ONE_PAGE_PBE_NUM; nums++) {
+			register unsigned long *orig, *copy;
+			orig = (unsigned long *)pgdir->orig_address;
+			if (orig == 0) goto end;
+			orig = (unsigned long *)GET_ADDRESS(orig);
+			copy = (unsigned long *)GET_ADDRESS(pgdir->address);
+#if 0
+			memcpy(orig, copy, PAGE_SIZE);
+#else
+			for (i = 0; i < PAGE_SIZE / sizeof(unsigned long); i+=4) {
+				*(orig + i) = *(copy + i);
+				*(orig + i+1) = *(copy + i+1);
+				*(orig + i+2) = *(copy + i+2);
+				*(orig + i+3) = *(copy + i+3);
+			}
+#endif
+			pgdir ++;
+		}
+		pgdir = next;
+	}
+end:
+	panic("just asm code");
+}
+#endif


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
