Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVALPSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVALPSd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 10:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVALPSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 10:18:33 -0500
Received: from [220.248.27.114] ([220.248.27.114]:61838 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261213AbVALPRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 10:17:00 -0500
Date: Wed, 12 Jan 2005 23:14:48 +0800
From: hugang@soulinfo.com
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH swsusp: page rellocation speed up
Message-ID: <20050112151448.GA5240@hugang.soulinfo.com>
References: <20050111010122.GA3013@mail.muni.cz> <20050112124948.GA15687@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112124948.GA15687@hugang.soulinfo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 08:49:49PM +0800, hugang@soulinfo.com wrote:
> On Tue, Jan 11, 2005 at 02:01:23AM +0100, Lukas Hejtmanek wrote:
> > Hello,
> > 
> > attached patch should speed up page rellocation at time of resume. Please test.
> > The diff is against 2.6.10-bk8
> > 
> ....
> 
> really cool, Passed in my x86 and ppc.
> 
> Here is a patch to make pagedir using non-continuity page, 
>  2.6.10 -> mm1 -> this patch -> my patch
> 
> I temporary split pbe function to pbe.h, useful merge. 

Here is my lastest patch for this.
 changes
  Fix a big bug in core code, Now it works in my PPC and X86, please
  test.

2.6.10 -> mm1 -> axg's patch -> Hejtmanek's -> core.diff

diff -Nurp 2.6.10-mm1-one-pbe/arch/i386/power/swsusp.S 2.6.10-mm1-one-pbe-hg/arch/i386/power/swsusp.S
--- 2.6.10-mm1-one-pbe/arch/i386/power/swsusp.S	2004-12-30 14:56:21.000000000 +0800
+++ 2.6.10-mm1-one-pbe-hg/arch/i386/power/swsusp.S	2005-01-12 20:09:01.000000000 +0800
@@ -31,24 +31,36 @@ ENTRY(swsusp_arch_resume)
 	movl $swsusp_pg_dir-__PAGE_OFFSET,%ecx
 	movl %ecx,%cr3
 
-	movl	pagedir_nosave, %ebx
-	xorl	%eax, %eax
-	xorl	%edx, %edx
-	.p2align 4,,7
+	movl  pagedir_nosave, %eax
+	test %eax, %eax
+	je   copy_loop_end
+	movl  $1024, %edx
 
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
 	.p2align 4,,7
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
+	
+	.p2align 4,,7
+copy_loop_end:
 
 	movl saved_context_esp, %esp
 	movl saved_context_ebp, %ebp
diff -Nurp 2.6.10-mm1-one-pbe/kernel/power/pbe.h 2.6.10-mm1-one-pbe-hg/kernel/power/pbe.h
--- 2.6.10-mm1-one-pbe/kernel/power/pbe.h	1970-01-01 07:00:00.000000000 +0700
+++ 2.6.10-mm1-one-pbe-hg/kernel/power/pbe.h	2005-01-12 21:21:41.000000000 +0800
@@ -0,0 +1,381 @@
+static int mod_progress = 1;
+
+static void inline mod_printk_progress(int i)
+{
+	if (mod_progress == 0) mod_progress = 1;
+	if (!(i%100))
+		printk( "\b\b\b\b%3d%%", i / mod_progress );
+}
+
+#define ONE_PAGE_PBE_NUM   (PAGE_SIZE/sizeof(struct pbe))
+#define PBE_IS_PAGE_END(x) \
+	( PAGE_SIZE - sizeof(struct pbe) == ((x) - ((~(PAGE_SIZE - 1)) & (x))) )
+
+#define pgdir_for_each(pos, n, head) \
+	for(pos = head, n = pos ? (suspend_pagedir_t*)pos->dummy.val : NULL; \
+			pos != NULL; \
+			pos = n, n = pos ? (suspend_pagedir_t *)pos->dummy.val : NULL)
+
+#define pbe_for_each(pos, n, index, max, head) \
+	for(pos = head, index = 0,\
+			n = pos ? (struct pbe *)pos->dummy.val : NULL; \
+		(pos != NULL) && (index < max); \
+		pos = (PBE_IS_PAGE_END((unsigned long)pos)) ? n : \
+			((struct pbe *)((unsigned long)pos + sizeof(struct pbe))), \
+			index ++, \
+			n = pos ? (struct pbe*)pos->dummy.val : NULL)
+
+static inline struct pbe *find_pbe_by_index(struct pbe *pgdir, int index)
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
+static inline void pagedir_free(suspend_pagedir_t *head)
+{
+	suspend_pagedir_t *next, *cur;
+	pgdir_for_each(cur, next, head) 
+		free_page((unsigned long)cur);
+}
+
+/**
+ *  write_one_pbe -
+ *  @p:
+ *  @data:
+ *  @cur:
+ *
+ */
+static int inline write_one_pbe(struct pbe *p, void *data, int cur)
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
+static int inline read_one_pbe(struct pbe *p, void *data, int cur)
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
+/*
+ * Returns true if given address/order collides with any orig_address 
+ */
+static int does_collide_order(unsigned long addr, int order) 
+{
+	int i;
+
+	for (i=0; i < (1<<order); i++)
+		if(!PageNosaveFree(virt_to_page(addr + i * PAGE_SIZE)))
+			return 1;
+	return 0;
+}
+
+static void **eaten_memory = NULL;
+
+static void *swsusp_get_safe_free_page(int collide)
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
+	} while (collide && does_collide_order((unsigned long)addr, 0));
+
+	if (collide)
+		ClearPageNosaveFree(virt_to_page(addr)); 
+
+	return addr;
+}
+
+/**
+ * alloc_one_pagedir - 
+ * @prev:
+ * @collide:
+ * 
+ */
+static suspend_pagedir_t * alloc_one_pagedir(suspend_pagedir_t *prev, 
+		int collide)
+{
+	suspend_pagedir_t *pgdir = NULL;
+	int i;
+
+	pgdir = (suspend_pagedir_t *)swsusp_get_safe_free_page(collide);
+
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
+
+/* calc_nums - Determine the nums of allocation needed for pagedir_save. */
+static int calc_nums(int nr_copy)
+{
+	int diff = 0, ret = 0;
+	do {
+		diff = (nr_copy / ONE_PAGE_PBE_NUM) - ret + 1;
+		if (diff) {
+			ret += diff;
+			nr_copy += diff;
+		}
+	} while (diff);
+	return nr_copy;
+}
+
+/**
+ * alloc_pagedir - Allocate the page directory.
+ * @pbe:
+ * @pbe_nums:
+ * @collide:
+ * @page_nums:
+ */
+static int alloc_pagedir(struct pbe **pbe, int pbe_nums, 
+		int collide, int page_nums)
+{
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
+}
+
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
+static int __init check_one_pbe(struct pbe *p, int cur)
+{
+	unsigned long addr = 0;
+
+	pr_debug("check_one_pbe: %p %lu o{%p} ", 
+			p, p->swap_address.val, (void*)p->orig_address);
+	addr = (unsigned long)swsusp_get_safe_free_page(1);
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
+
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
+	struct zone *zone;
+	unsigned long zone_pfn;
+
+	printk("Relocating pagedir ... ");
+	/* Set page flags */
+	for_each_zone(zone) {
+		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
+			SetPageNosaveFree(pfn_to_page(zone_pfn + zone->zone_start_pfn));
+	}
+
+	/* Clear orig address */
+	pbe_for_each(pos, next, index, nr_copy_pages, pagedir_nosave) {
+		pr_debug("clear <%p>, <%p>, %d\n", 
+				pos, (void*)pos->orig_address, index);
+		ClearPageNosaveFree(virt_to_page(pos->orig_address));
+	}
+	
+	error = alloc_pagedir(&addr, nr_copy_pages, 1, swsusp_info.pagedir_pages);
+	if (error < 0) {
+		return error;
+	}
+	swsusp_copy_pagedir(addr, pagedir_nosave);
+	pagedir_free(pagedir_nosave);
+
+	/* check copy address */
+	pbe_for_each(pos, next, index, nr_copy_pages, addr) {
+		error = check_one_pbe(pos, index);
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
+
+	printk(" done\n");
+
+	pagedir_nosave = addr;
+
+	return 0;
+}
+
+
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
diff -Nurp 2.6.10-mm1-one-pbe/kernel/power/swsusp.c 2.6.10-mm1-one-pbe-hg/kernel/power/swsusp.c
--- 2.6.10-mm1-one-pbe/kernel/power/swsusp.c	2005-01-11 22:42:58.000000000 +0800
+++ 2.6.10-mm1-one-pbe-hg/kernel/power/swsusp.c	2005-01-12 22:56:18.000000000 +0800
@@ -71,12 +71,13 @@
 #include <asm/io.h>
 
 #include "power.h"
+#undef pr_debug
+#define pr_debug printk
 
 /* References to section boundaries */
 extern const void __nosave_begin, __nosave_end;
 
 /* Variables to be preserved over suspend */
-static int pagedir_order_check;
 static int nr_copy_pages_check;
 
 extern char resume_file[];
@@ -99,7 +100,6 @@ unsigned int nr_copy_pages __nosavedata 
  */
 suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
 static suspend_pagedir_t *pagedir_save;
-static int pagedir_order __nosavedata = 0;
 
 #define SWSUSP_SIG	"S1SUSPEND"
 
@@ -260,6 +260,8 @@ static int write_page(unsigned long addr
 }
 
 
+#include "pbe.h"
+
 /**
  *	data_free - Free the swap entries used by the saved image.
  *
@@ -271,14 +273,15 @@ static void data_free(void)
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
 
@@ -293,17 +296,15 @@ static int data_write(void)
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
@@ -373,15 +374,19 @@ static void free_pagedir_entries(void)
 
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
+		pr_debug("write_pagedir: <%p>, %lu\n", 
+				pgdir, swp_offset(swsusp_info.pagedir[n]));
+		if (error) break;
+		n ++;
+	}
 	printk( "Writing pagedir (%d pages)\n", n);
-	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE)
-		error = write_page(addr, &swsusp_info.pagedir[i]);
+	swsusp_info.pagedir_pages = n;
 	return error;
 }
 
@@ -566,9 +571,9 @@ static void copy_data_pages(void)
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
-	struct pbe * pbe = pagedir_nosave;
+	struct pbe * pbe = NULL;
 	int to_copy = nr_copy_pages;
-	
+
 	for_each_zone(zone) {
 		if (is_highmem(zone))
 			continue;
@@ -576,92 +581,31 @@ static void copy_data_pages(void)
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 			if (saveable(zone, &zone_pfn)) {
 				struct page * page;
+				pbe = find_pbe_by_index(pagedir_nosave, nr_copy_pages-to_copy);
+				BUG_ON(pbe == NULL);
 				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
 				pbe->orig_address = (long) page_address(page);
+				BUG_ON(pbe->orig_address == 0);
+				BUG_ON(pbe->address == 0);
 				/* copy_page is not usable for copying task structs. */
 				memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
-				pbe++;
-				to_copy--;
+				to_copy --;
 			}
 		}
 	}
 	BUG_ON(to_copy);
 }
 
-
-/**
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
- *
- *	With this model, we will tend to waste a lot of memory if we just cross
- *	an order boundary. Plus, the higher the order of allocation that we try
- *	to do, the more likely we are to fail in a low-memory situtation 
- *	(though	we're unlikely to get this far in such a case, since swsusp 
- *	requires half of memory to be free anyway).
- */
-
-
-static void calc_order(void)
-{
-	int diff = 0;
-	int order = 0;
-
-	do {
-		diff = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages)) - order;
-		if (diff) {
-			order += diff;
-			nr_copy_pages += 1 << diff;
-		}
-	} while(diff);
-	pagedir_order = order;
-}
-
-
-/**
- *	alloc_pagedir - Allocate the page directory.
- *
- *	First, determine exactly how many contiguous pages we need and
- *	allocate them.
- */
-
-static int alloc_pagedir(void)
-{
-	calc_order();
-	pagedir_save = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD,
-							     pagedir_order);
-	if (!pagedir_save)
-		return -ENOMEM;
-	memset(pagedir_save, 0, (1 << pagedir_order) * PAGE_SIZE);
-	pagedir_nosave = pagedir_save;
-	return 0;
-}
-
 /**
  *	free_image_pages - Free pages allocated for snapshot
  */
 
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
@@ -677,10 +621,10 @@ static void free_image_pages(void)
 
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
@@ -694,7 +638,7 @@ void swsusp_free(void)
 	BUG_ON(PageNosave(virt_to_page(pagedir_save)));
 	BUG_ON(PageNosaveFree(virt_to_page(pagedir_save)));
 	free_image_pages();
-	free_pages((unsigned long) pagedir_save, pagedir_order);
+	pagedir_free(pagedir_save);
 }
 
 
@@ -752,18 +696,20 @@ static int swsusp_alloc(void)
 	if (!enough_swap())
 		return -ENOSPC;
 
-	if ((error = alloc_pagedir())) {
+	if ((error = alloc_pagedir(&pagedir_save, nr_copy_pages, 0, 0)) < 0) {
 		pr_debug("suspend: Allocating pagedir failed.\n");
 		return error;
 	}
+	pr_debug("alloc_pagedir: addon %d\n", error);
+	nr_copy_pages += error;
 	if ((error = alloc_image_pages())) {
 		pr_debug("suspend: Allocating image pages failed.\n");
 		swsusp_free();
 		return error;
 	}
 
+	pagedir_nosave = pagedir_save;
 	nr_copy_pages_check = nr_copy_pages;
-	pagedir_order_check = pagedir_order;
 	return 0;
 }
 
@@ -856,7 +802,6 @@ int swsusp_suspend(void)
 asmlinkage int swsusp_restore(void)
 {
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);
-	BUG_ON (pagedir_order_check != pagedir_order);
 	
 	/* Even mappings of "global" things (vmalloc) need to be fixed */
 	__flush_tlb_global();
@@ -880,110 +825,6 @@ int swsusp_resume(void)
 	return error;
 }
 
-
-/* More restore stuff */
-
-/*
- * Returns true if given address/order collides with any orig_address 
- */
-static int __init does_collide_order(unsigned long addr, int order)
-{
-	int i;
-	
-	for (i=0; i < (1<<order); i++)
-		if(!PageNosaveFree(virt_to_page(addr + i * PAGE_SIZE)))
-			return 1;
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
-
-	for(i=0; i < nr_copy_pages; i++) {
-		unsigned long addr;
-
-		do {
-			addr = get_zeroed_page(GFP_ATOMIC);
-			if(!addr)
-				return -ENOMEM;
-		} while (does_collide_order(addr,0));
-
-		(pagedir_nosave+i)->address = addr;
-	}
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
-	struct zone *zone;
-	int i;
-	struct pbe *p;
-	unsigned long zone_pfn;
-
-	printk("Relocating pagedir ");
-
-	/* Set page flags */
-	
-	for_each_zone(zone) {
-        	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
-                	SetPageNosaveFree(pfn_to_page(zone_pfn + 
-					zone->zone_start_pfn));
-	}
-
-	/* Clear orig address */
-
-	for(i = 0, p = pagedir_nosave; i < nr_copy_pages; i++, p++) {
-		ClearPageNosaveFree(virt_to_page(p->orig_address));
-	}
-
-	if (!does_collide_order((unsigned long)old_pagedir, pagedir_order)) {
-		printk("not necessary\n");
-		return check_pagedir();
-	}
-
-	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order)) != NULL) {
-		if (!does_collide_order((unsigned long)m, pagedir_order))
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
@@ -1098,7 +939,6 @@ static int __init check_header(void)
 		return -EPERM;
 	}
 	nr_copy_pages = swsusp_info.image_pages;
-	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 	return error;
 }
 
@@ -1134,23 +974,20 @@ static int __init check_sig(void)
 
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
@@ -1161,26 +998,24 @@ extern dev_t __init name_to_dev_t(const 
 
 static int __init read_pagedir(void)
 {
-	unsigned long addr;
-	int i, n = swsusp_info.pagedir_pages;
+	int i = 0, n = swsusp_info.pagedir_pages;
 	int error = 0;
+	suspend_pagedir_t *pgdir, *next;
 
-	addr = __get_free_pages(GFP_ATOMIC, pagedir_order);
-	if (!addr)
+	error = alloc_pagedir(&pagedir_nosave, nr_copy_pages, 0, n);
+	if (error < 0)
 		return -ENOMEM;
-	pagedir_nosave = (struct pbe *)addr;
 
 	pr_debug("pmdisk: Reading pagedir (%d Pages)\n",n);
-
-	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE) {
-		unsigned long offset = swp_offset(swsusp_info.pagedir[i]);
-		if (offset)
-			error = bio_read_page(offset, (void *)addr);
-		else
-			error = -EFAULT;
+	pgdir_for_each(pgdir, next, pagedir_nosave) {
+		error = read_one_pagedir(pgdir, i);
+		if (error) break;
+		pgdir[ONE_PAGE_PBE_NUM-1].dummy.val = pgdir ? pgdir ->dummy.val : 0;
+		i++;
 	}
+	BUG_ON(i != n);
 	if (error)
-		free_pages((unsigned long)pagedir_nosave, pagedir_order);
+		pagedir_free(pagedir_nosave);
 	return error;
 }
 
@@ -1195,7 +1030,7 @@ static int __init read_suspend_image(voi
 	if ((error = read_pagedir()))
 		return error;
 	if ((error = data_read()))
-		free_pages((unsigned long)pagedir_nosave, pagedir_order);
+		pagedir_free(pagedir_nosave);
 	return error;
 }
 

2.6.10 -> mm1 -> axg's patch -> Hejtmanek's -> core.diff  -> ppc.diff

diff -Nurp 2.6.10-mm1-axg/arch/ppc/kernel/swsusp.S 2.6.10-mm1-axg-swap_mem/arch/ppc/kernel/swsusp.S
--- 2.6.10-mm1-axg/arch/ppc/kernel/swsusp.S	2005-01-06 11:36:19.000000000 +0800
+++ 2.6.10-mm1-axg-swap_mem/arch/ppc/kernel/swsusp.S	2005-01-12 22:34:15.000000000 +0800
@@ -159,43 +159,56 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	sync
 	isync
 
-	/* Load ptr the list of pages to copy in r3 */
-	lis	r11,(pagedir_nosave - KERNELBASE)@h
-	ori	r11,r11,pagedir_nosave@l
-	lwz	r10,0(r11)
-	tophys(r3,r10)
-
-	/* Load the count of pages to copy in r4 */
-	lis	r11,(nr_copy_pages - KERNELBASE)@h
-	ori	r11,r11,nr_copy_pages@l
-	lwz	r4,0(r11)
+	/* Load ptr the list of pages to copy in r9 */
+	lis r11,(pagedir_nosave - KERNELBASE)@h
+	ori r11,r11,pagedir_nosave@l
+	lwz r9,0(r11)
 
+#if 0
+	twi     31,r0,0 /* triger trap */
+#endif
+	cmpwi   r9, 0
+	beq copy_loop_end
 
-	/* Copy the pages. This is a very basic implementation, to
-	 * be replaced by something more cache efficient */
-1:
-	li	r0,256
-	mtctr	r0
-	lwz	r11,0(r3)	/* source */
-	tophys(r5,r11)
-	lwz	r10,4(r3)	/* destination */
-	tophys(r6,r10)
-2:
-	lwz	r8,0(r5)
-	lwz	r9,4(r5)
-	lwz	r10,8(r5)
-	lwz	r11,12(r5)
-	addi	r5,r5,16
-	stw	r8,0(r6)
-	stw	r9,4(r6)
-	stw	r10,8(r6)
-	stw	r11,12(r6)
-	addi	r6,r6,16
-	bdnz	2b
-	addi	r3,r3,16
-	subi	r4,r4,1
-	cmpwi	0,r4,0
-	bne	1b
+copy_loop:
+	tophys(r9,r9)
+	lwz    r6, 12(r9)
+	li     r10, 0
+
+copy_one_pgdir:
+	lwz    r11, 4(r9)
+	addi   r8,r10,1
+	cmpwi  r11, 0
+	addi   r7,r9,16
+	beq copy_loop_end
+	li     r0, 256
+	mtctr  r0
+	lwz    r9,0(r9)
+#if 0
+	twi    31,r0,0 /* triger trap */
+#endif
+	tophys(r10,r11)
+	tophys(r11,r9)
+
+copy_one_page:
+	lwz    r0, 0(r11)
+	stw    r0, 0(r10)
+	lwz    r9, 4(r11)
+	stw    r9, 4(r10)
+	lwz    r0, 8(r11)
+	stw    r0, 8(r10)
+	lwz    r9, 12(r11)
+	addi   r11,r11,16
+	stw    r9, 12(r10)
+	addi   r10,r10,16
+	bdnz copy_one_page
+	mr     r10, r8
+	cmplwi r10, 255
+	mr     r9, r7
+	ble copy_one_pgdir
+	mr     r9, r6
+	bne copy_loop
+copy_loop_end:
 
 	/* Do a very simple cache flush/inval of the L1 to ensure
 	 * coherency of the icache
-- 
Hu Gang       .-.
              /v\
             // \\ 
Linux User  /(   )\  [204016]
GPG Key ID   ^^-^^   http://soulinfo.com/~hugang/hugang.asc
