Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSFAIi7>; Sat, 1 Jun 2002 04:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315417AbSFAIi5>; Sat, 1 Jun 2002 04:38:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44042 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315415AbSFAIiV>;
	Sat, 1 Jun 2002 04:38:21 -0400
Message-ID: <3CF888C2.B4A79AB2@zip.com.au>
Date: Sat, 01 Jun 2002 01:41:38 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 4/16] fix swapcache packing in the radix tree
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



First some terminology: this patch introduces a kernel-wide `pgoff_t'
type.  It is the index of a page into the pagecache.  The thing at
page->index.  For most mappings it is also the offset of the page into
that mapping.  This type has a very distinct function in the kernel and
it needs a name.  I don't have any particular plans to go and migrate
everything so we can support 64-bit pagecache indices on x86, but this
would be the way to do it.

This patch improves the packing density of swapcache pages in the radix
tree.

A swapcache page is identified by the `swap type' (indexes the swap
device) and the `offset' (into that swap device).  These two numbers
are encoded into a `swp_entry_t' machine word in arch-specific code
because the resulting number is placed into pagetables in a form which
will generate a fault.

The kernel also need to generate a pgoff_t for that page to index it
into the swapper_space radix tree.  That pgoff_t is usually
bitwise-identical to the swp_entry_t.  That worked OK when the
pagecache was using a hash.  But with a radix tree, it produces
catastrophically bad results.

x86 (and many other architectures) place the `type' field into the
low-order bits of the swp_entry_t.  So *all* swapcache pages are
basically identical in the eight low-order bits.  This produces a very
sparse radix tree for swapcache.  I'm observing packing densities of 1%
to 2%: so the typical 128-slot radix tree node has only one or two
pages in it.

The end result is that the kernel needs to allocate approximately one
new radix-tree node for each page which is added to the swapcache.  So
no wonder we're having radix-tree node exhaustion during swapout! 
(It's actually quite encouraging that the kernel works as well as it
does).

The patch changes the encoding of the swp_entry_t so that its
most-significant bits contain the `type' field and the
least-significant bits contain the `offset' field, right-aligned.

That is: the encoding in swp_entry_t is now arch-independent.  The new
file <linux/swapops.h> has conversion functions which convert the
swp_entry_t to and from its machine pte representation.

Packing density in the swapper_space mapping goes up to around 90%
(observed) and the kernel is tons happier under swap load.


An alternative approach would be to create new conversion functions
which convert an arch-specific swp_entry_t to and from a pgoff_t.  I
tried that.  It worked, but I liked it less.


=====================================

--- 2.5.19/kernel/suspend.c~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/kernel/suspend.c	Sat Jun  1 01:18:07 2002
@@ -64,6 +64,7 @@
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
+#include <linux/swapops.h>
 
 unsigned char software_suspend_enabled = 0;
 
@@ -326,7 +327,7 @@ static void mark_swapfiles(swp_entry_t p
 	if (!cur)
 		panic("Out of memory in mark_swapfiles");
 	/* XXX: this is dirty hack to get first page of swap file */
-	entry = SWP_ENTRY(root_swap, 0);
+	entry = swp_entry(root_swap, 0);
 	lock_page(virt_to_page((unsigned long)cur));
 	rw_swap_page_nolock(READ, entry, (char *) cur);
 
@@ -419,7 +420,7 @@ static int write_suspend_image(void)
 		if (!(entry = get_swap_page()).val)
 			panic("\nNot enough swapspace when writing data" );
 		
-		if(swapfile_used[SWP_TYPE(entry)] != SWAPFILE_SUSPEND)
+		if(swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
 			panic("\nPage %d: not enough swapspace on suspend device", i );
 	    
 		address = (pagedir_nosave+i)->address;
@@ -445,7 +446,7 @@ static int write_suspend_image(void)
 			return -ENOSPC;
 		}
 
-		if(swapfile_used[SWP_TYPE(entry)] != SWAPFILE_SUSPEND)
+		if(swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
 		  panic("\nNot enough swapspace for pagedir on suspend device" );
 
 		if (sizeof(swp_entry_t) != sizeof(long))
@@ -465,7 +466,7 @@ static int write_suspend_image(void)
 		panic("union diskpage has bad size");
 	if (!(entry = get_swap_page()).val)
 		panic( "\nNot enough swapspace when writing header" );
-	if(swapfile_used[SWP_TYPE(entry)] != SWAPFILE_SUSPEND)
+	if(swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
 	  panic("\nNot enough swapspace for header on suspend device" );
 
 	cur = (void *) buffer;
@@ -480,7 +481,7 @@ static int write_suspend_image(void)
 
 	PRINTK( ", signature" );
 #if 0
-	if (SWP_TYPE(entry) != 0)
+	if (swp_type(entry) != 0)
 		panic("Need just one swapfile");
 #endif
 	mark_swapfiles(prev, MARK_SWAP_SUSPEND);
@@ -1068,7 +1069,7 @@ static int resume_try_to_read(const char
 	if (bdev_read_page(resume_device, pos, ptr)) { error = -EIO; goto resume_read_error; }
 #define PREPARENEXT \
 	{	next = cur->link.next; \
-		next.val = SWP_OFFSET(next) * PAGE_SIZE; \
+		next.val = swp_offset(next) * PAGE_SIZE; \
         }
 
 	error = -EIO;
@@ -1141,7 +1142,7 @@ static int resume_try_to_read(const char
 		swp_entry_t swap_address = (pagedir_nosave+i)->swap_address;
 		if (!(i%100))
 			PRINTK( "." );
-		next.val = SWP_OFFSET (swap_address) * PAGE_SIZE;
+		next.val = swp_offset(swap_address) * PAGE_SIZE;
 		/* You do not need to check for overlaps...
 		   ... check_pagedir already did this work */
 		READTO(next.val, (char *)((pagedir_nosave+i)->address));
--- 2.5.19/mm/memory.c~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/mm/memory.c	Sat Jun  1 01:18:07 2002
@@ -50,6 +50,8 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
+#include <linux/swapops.h>
+
 unsigned long max_mapnr;
 unsigned long num_physpages;
 void * high_memory;
@@ -1128,7 +1130,7 @@ void swapin_readahead(swp_entry_t entry)
 	num = valid_swaphandles(entry, &offset);
 	for (i = 0; i < num; offset++, i++) {
 		/* Ok, do the async read-ahead now */
-		new_page = read_swap_cache_async(SWP_ENTRY(SWP_TYPE(entry), offset));
+		new_page = read_swap_cache_async(swp_entry(swp_type(entry), offset));
 		if (!new_page)
 			break;
 		page_cache_release(new_page);
--- 2.5.19/mm/swapfile.c~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/mm/swapfile.c	Sat Jun  1 01:18:07 2002
@@ -19,6 +19,7 @@
 #include <linux/buffer_head.h>		/* for block_flushpage() */
 
 #include <asm/pgtable.h>
+#include <linux/swapops.h>
 
 spinlock_t swaplock = SPIN_LOCK_UNLOCKED;
 unsigned int nr_swapfiles;
@@ -121,7 +122,7 @@ swp_entry_t get_swap_page(void)
 			offset = scan_swap_map(p);
 			swap_device_unlock(p);
 			if (offset) {
-				entry = SWP_ENTRY(type,offset);
+				entry = swp_entry(type,offset);
 				type = swap_info[type].next;
 				if (type < 0 ||
 					p->prio != swap_info[type].prio) {
@@ -154,13 +155,13 @@ static struct swap_info_struct * swap_in
 
 	if (!entry.val)
 		goto out;
-	type = SWP_TYPE(entry);
+	type = swp_type(entry);
 	if (type >= nr_swapfiles)
 		goto bad_nofile;
 	p = & swap_info[type];
 	if (!(p->flags & SWP_USED))
 		goto bad_device;
-	offset = SWP_OFFSET(entry);
+	offset = swp_offset(entry);
 	if (offset >= p->max)
 		goto bad_offset;
 	if (!p->swap_map[offset])
@@ -220,7 +221,7 @@ void swap_free(swp_entry_t entry)
 
 	p = swap_info_get(entry);
 	if (p) {
-		swap_entry_free(p, SWP_OFFSET(entry));
+		swap_entry_free(p, swp_offset(entry));
 		swap_info_put(p);
 	}
 }
@@ -239,7 +240,7 @@ static int exclusive_swap_page(struct pa
 	p = swap_info_get(entry);
 	if (p) {
 		/* Is the only swap cache user the cache itself? */
-		if (p->swap_map[SWP_OFFSET(entry)] == 1) {
+		if (p->swap_map[swp_offset(entry)] == 1) {
 			/* Recheck the page count with the pagecache lock held.. */
 			read_lock(&swapper_space.page_lock);
 			if (page_count(page) - !!PagePrivate(page) == 2)
@@ -307,7 +308,7 @@ int remove_exclusive_swap_page(struct pa
 
 	/* Is the only swap cache user the cache itself? */
 	retval = 0;
-	if (p->swap_map[SWP_OFFSET(entry)] == 1) {
+	if (p->swap_map[swp_offset(entry)] == 1) {
 		/* Recheck the page count with the pagecache lock held.. */
 		write_lock(&swapper_space.page_lock);
 		if (page_count(page) - !!PagePrivate(page) == 2) {
@@ -344,7 +345,7 @@ void free_swap_and_cache(swp_entry_t ent
 
 	p = swap_info_get(entry);
 	if (p) {
-		if (swap_entry_free(p, SWP_OFFSET(entry)) == 1)
+		if (swap_entry_free(p, swp_offset(entry)) == 1)
 			page = find_trylock_page(&swapper_space, entry.val);
 		swap_info_put(p);
 	}
@@ -568,7 +569,7 @@ static int try_to_unuse(unsigned int typ
 		 * page and read the swap into it. 
 		 */
 		swap_map = &si->swap_map[i];
-		entry = SWP_ENTRY(type, i);
+		entry = swp_entry(type, i);
 		page = read_swap_cache_async(entry);
 		if (!page) {
 			/*
@@ -954,7 +955,7 @@ asmlinkage long sys_swapon(const char * 
 	}
 
 	lock_page(virt_to_page(swap_header));
-	rw_swap_page_nolock(READ, SWP_ENTRY(type,0), (char *) swap_header);
+	rw_swap_page_nolock(READ, swp_entry(type,0), (char *) swap_header);
 
 	if (!memcmp("SWAP-SPACE",swap_header->magic.magic,10))
 		swap_header_version = 1;
@@ -1007,7 +1008,7 @@ asmlinkage long sys_swapon(const char * 
 		}
 
 		p->lowest_bit  = 1;
-		maxpages = SWP_OFFSET(SWP_ENTRY(0,~0UL)) - 1;
+		maxpages = swp_offset(swp_entry(0,~0UL)) - 1;
 		if (maxpages > swap_header->info.last_page)
 			maxpages = swap_header->info.last_page;
 		p->highest_bit = maxpages - 1;
@@ -1141,11 +1142,11 @@ int swap_duplicate(swp_entry_t entry)
 	unsigned long offset, type;
 	int result = 0;
 
-	type = SWP_TYPE(entry);
+	type = swp_type(entry);
 	if (type >= nr_swapfiles)
 		goto bad_file;
 	p = type + swap_info;
-	offset = SWP_OFFSET(entry);
+	offset = swp_offset(entry);
 
 	swap_device_lock(p);
 	if (offset < p->max && p->swap_map[offset]) {
@@ -1182,11 +1183,11 @@ int swap_count(struct page *page)
 	entry.val = page->index;
 	if (!entry.val)
 		goto bad_entry;
-	type = SWP_TYPE(entry);
+	type = swp_type(entry);
 	if (type >= nr_swapfiles)
 		goto bad_file;
 	p = type + swap_info;
-	offset = SWP_OFFSET(entry);
+	offset = swp_offset(entry);
 	if (offset >= p->max)
 		goto bad_offset;
 	if (!p->swap_map[offset])
@@ -1218,14 +1219,14 @@ void get_swaphandle_info(swp_entry_t ent
 	unsigned long type;
 	struct swap_info_struct *p;
 
-	type = SWP_TYPE(entry);
+	type = swp_type(entry);
 	if (type >= nr_swapfiles) {
 		printk(KERN_ERR "rw_swap_page: %s%08lx\n", Bad_file, entry.val);
 		return;
 	}
 
 	p = &swap_info[type];
-	*offset = SWP_OFFSET(entry);
+	*offset = swp_offset(entry);
 	if (*offset >= p->max && *offset != 0) {
 		printk(KERN_ERR "rw_swap_page: %s%08lx\n", Bad_offset, entry.val);
 		return;
@@ -1250,11 +1251,11 @@ int valid_swaphandles(swp_entry_t entry,
 {
 	int ret = 0, i = 1 << page_cluster;
 	unsigned long toff;
-	struct swap_info_struct *swapdev = SWP_TYPE(entry) + swap_info;
+	struct swap_info_struct *swapdev = swp_type(entry) + swap_info;
 
 	if (!page_cluster)	/* no readahead */
 		return 0;
-	toff = (SWP_OFFSET(entry) >> page_cluster) << page_cluster;
+	toff = (swp_offset(entry) >> page_cluster) << page_cluster;
 	if (!toff)		/* first page is swap header */
 		toff++, i--;
 	*offset = toff;
--- /dev/null	Thu Aug 30 13:30:55 2001
+++ 2.5.19-akpm/include/linux/swapops.h	Sat Jun  1 01:18:07 2002
@@ -0,0 +1,68 @@
+/*
+ * swapcache pages are stored in the swapper_space radix tree.  We want to
+ * get good packing density in that tree, so the index should be dense in
+ * the low-order bits.
+ *
+ * We arrange the `type' and `offset' fields so that `type' is at the five
+ * high-order bits of the smp_entry_t and `offset' is right-aligned in the
+ * remaining bits.
+ *
+ * swp_entry_t's are *never* stored anywhere in their arch-dependent format.
+ */
+#define SWP_TYPE_SHIFT(e)	(sizeof(e.val) * 8 - MAX_SWAPFILES_SHIFT)
+#define SWP_OFFSET_MASK(e)	((1 << SWP_TYPE_SHIFT(e)) - 1)
+
+/*
+ * Store a type+offset into a swp_entry_t in an arch-independent format
+ */
+static inline swp_entry_t swp_entry(unsigned type, pgoff_t offset)
+{
+	swp_entry_t ret;
+
+	ret.val = (type << SWP_TYPE_SHIFT(ret)) |
+			(offset & SWP_OFFSET_MASK(ret));
+	return ret;
+}
+
+/*
+ * Extract the `type' field from a swp_entry_t.  The swp_entry_t is in
+ * arch-independent format
+ */
+static inline unsigned swp_type(swp_entry_t entry)
+{
+	return (entry.val >> SWP_TYPE_SHIFT(entry)) &
+			((1 << MAX_SWAPFILES_SHIFT) - 1);
+}
+
+/*
+ * Extract the `offset' field from a swp_entry_t.  The swp_entry_t is in
+ * arch-independent format
+ */
+static inline pgoff_t swp_offset(swp_entry_t entry)
+{
+	return entry.val & SWP_OFFSET_MASK(entry);
+}
+
+/*
+ * Convert the arch-dependent pte representation of a swp_entry_t into an
+ * arch-independent swp_entry_t.
+ */
+static inline swp_entry_t pte_to_swp_entry(pte_t pte)
+{
+	swp_entry_t arch_entry;
+
+	arch_entry = __pte_to_swp_entry(pte);
+	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
+}
+
+/*
+ * Convert the arch-independent representation of a swp_entry_t into the
+ * arch-dependent pte representation.
+ */
+static inline pte_t swp_entry_to_pte(swp_entry_t entry)
+{
+	swp_entry_t arch_entry;
+
+	arch_entry = __swp_entry(swp_type(entry), swp_offset(entry));
+	return __swp_entry_to_pte(arch_entry);
+}
--- 2.5.19/include/linux/swap.h~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/linux/swap.h	Sat Jun  1 01:18:07 2002
@@ -11,7 +11,16 @@
 #define SWAP_FLAG_PRIO_MASK	0x7fff
 #define SWAP_FLAG_PRIO_SHIFT	0
 
-#define MAX_SWAPFILES 32
+/*
+ * MAX_SWAPFILES defines the maximum number of swaptypes: things which can
+ * be swapped to.  The swap type and the offset into that swap type are
+ * encoded into pte's and into pgoff_t's in the swapcache.  Using five bits
+ * for the type means that the maximum number of swapcache pages is 27 bits
+ * on 32-bit-pgoff_t architectures.  And that assumes that the architecture packs
+ * the type/offset into the pte as 5/27 as well.
+ */
+#define MAX_SWAPFILES_SHIFT	5
+#define MAX_SWAPFILES		(1 << MAX_SWAPFILES_SHIFT)
 
 /*
  * Magic header for a swap area. The first part of the union is
--- 2.5.19/include/linux/types.h~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/linux/types.h	Sat Jun  1 01:18:07 2002
@@ -124,6 +124,14 @@ typedef u64 sector_t;
 typedef unsigned long sector_t;
 #endif
 
+/*
+ * The type of an index into the pagecache.  Use a #define so asm/types.h
+ * can override it.
+ */
+#ifndef pgoff_t
+#define pgoff_t unsigned long
+#endif
+
 #endif /* __KERNEL_STRICT_NAMES */
 
 /*
--- 2.5.19/include/asm-i386/pgtable.h~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-i386/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -269,11 +269,11 @@ static inline pte_t pte_modify(pte_t pte
 #define update_mmu_cache(vma,address,pte) do { } while (0)
 
 /* Encode and de-code a swap entry */
-#define SWP_TYPE(x)			(((x).val >> 1) & 0x3f)
-#define SWP_OFFSET(x)			((x).val >> 8)
-#define SWP_ENTRY(type, offset)		((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
-#define pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
-#define swp_entry_to_pte(x)		((pte_t) { (x).val })
+#define __swp_type(x)			(((x).val >> 1) & 0x3f)
+#define __swp_offset(x)			((x).val >> 8)
+#define __swp_entry(type, offset)	((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
+#define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
 #endif /* !__ASSEMBLY__ */
 
--- 2.5.19/mm/vmscan.c~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/mm/vmscan.c	Sat Jun  1 01:18:07 2002
@@ -27,6 +27,7 @@
 
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
+#include <linux/swapops.h>
 
 /*
  * The "priority" of VM scanning is how much of the queues we
--- 2.5.19/include/asm-alpha/pgtable.h~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-alpha/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -340,11 +340,11 @@ extern inline void update_mmu_cache(stru
 extern inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
 { pte_t pte; pte_val(pte) = (type << 32) | (offset << 40); return pte; }
 
-#define SWP_TYPE(x)			(((x).val >> 32) & 0xff)
-#define SWP_OFFSET(x)			((x).val >> 40)
-#define SWP_ENTRY(type, offset)		((swp_entry_t) { pte_val(mk_swap_pte((type),(offset))) })
-#define pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
-#define swp_entry_to_pte(x)		((pte_t) { (x).val })
+#define __swp_type(x)			(((x).val >> 32) & 0xff)
+#define __swp_offset(x)			((x).val >> 40)
+#define __swp_entry(type, offset)	((swp_entry_t) { pte_val(mk_swap_pte((type),(offset))) })
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
 #ifndef CONFIG_DISCONTIGMEM
 #define kern_addr_valid(addr)	(1)
--- 2.5.19/include/asm-arm/pgtable.h~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-arm/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -142,11 +142,11 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD
  *
  * We support up to 32GB of swap on 4k machines
  */
-#define SWP_TYPE(x)		(((x).val >> 2) & 0x7f)
-#define SWP_OFFSET(x)		((x).val >> 9)
-#define SWP_ENTRY(type,offset)	((swp_entry_t) { ((type) << 2) | ((offset) << 9) })
-#define pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
-#define swp_entry_to_pte(swp)	((pte_t) { (swp).val })
+#define __swp_type(x)		(((x).val >> 2) & 0x7f)
+#define __swp_offset(x)		((x).val >> 9)
+#define __swp_entry(type,offset) ((swp_entry_t) { ((type) << 2) | ((offset) << 9) })
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(swp)	((pte_t) { (swp).val })
 
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
 /* FIXME: this is not correct */
--- 2.5.19/include/asm-cris/pgtable.h~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-cris/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -500,11 +500,11 @@ static inline void update_mmu_cache(stru
 /* Encode and de-code a swap entry (must be !pte_none(e) && !pte_present(e)) */
 /* Since the PAGE_PRESENT bit is bit 4, we can use the bits above */
 
-#define SWP_TYPE(x)                     (((x).val >> 5) & 0x7f)
-#define SWP_OFFSET(x)                   ((x).val >> 12)
-#define SWP_ENTRY(type, offset)         ((swp_entry_t) { ((type) << 5) | ((offset) << 12) })
-#define pte_to_swp_entry(pte)           ((swp_entry_t) { pte_val(pte) })
-#define swp_entry_to_pte(x)             ((pte_t) { (x).val })
+#define __swp_type(x)			(((x).val >> 5) & 0x7f)
+#define __swp_offset(x)			((x).val >> 12)
+#define __swp_entry(type, offset)	((swp_entry_t) { ((type) << 5) | ((offset) << 12) })
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
 #define kern_addr_valid(addr)   (1)
 
--- 2.5.19/include/asm-ia64/pgtable.h~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-ia64/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -402,11 +402,11 @@ pte_same (pte_t a, pte_t b)
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern void paging_init (void);
 
-#define SWP_TYPE(entry)			(((entry).val >> 1) & 0xff)
-#define SWP_OFFSET(entry)		(((entry).val << 1) >> 10)
-#define SWP_ENTRY(type,offset)		((swp_entry_t) { ((type) << 1) | ((long) (offset) << 9) })
-#define pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
-#define swp_entry_to_pte(x)		((pte_t) { (x).val })
+#define __swp_type(entry)		(((entry).val >> 1) & 0xff)
+#define __swp_offset(entry)		(((entry).val << 1) >> 10)
+#define __swp_entry(type,offset)	((swp_entry_t) { ((type) << 1) | ((long) (offset) << 9) })
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
 #define io_remap_page_range remap_page_range	/* XXX is this right? */
 
--- 2.5.19/include/asm-m68k/pgtable.h~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-m68k/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -145,20 +145,20 @@ extern inline void update_mmu_cache(stru
 
 #ifdef CONFIG_SUN3
 /* Macros to (de)construct the fake PTEs representing swap pages. */
-#define SWP_TYPE(x)                ((x).val & 0x7F)
-#define SWP_OFFSET(x)      (((x).val) >> 7)
-#define SWP_ENTRY(type,offset) ((swp_entry_t) { ((type) | ((offset) << 7)) })
-#define pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
-#define swp_entry_to_pte(x)		((pte_t) { (x).val })
+#define __swp_type(x)		((x).val & 0x7F)
+#define __swp_offset(x)		(((x).val) >> 7)
+#define __swp_entry(type,offset) ((swp_entry_t) { ((type) | ((offset) << 7)) })
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
 #else
 
 /* Encode and de-code a swap entry (must be !pte_none(e) && !pte_present(e)) */
-#define SWP_TYPE(x)			(((x).val >> 1) & 0xff)
-#define SWP_OFFSET(x)			((x).val >> 10)
-#define SWP_ENTRY(type, offset)		((swp_entry_t) { ((type) << 1) | ((offset) << 10) })
-#define pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
-#define swp_entry_to_pte(x)		((pte_t) { (x).val })
+#define __swp_type(x)		(((x).val >> 1) & 0xff)
+#define __swp_offset(x)		((x).val >> 10)
+#define __swp_entry(type, offset) ((swp_entry_t) { ((type) << 1) | ((offset) << 10) })
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
 #endif /* CONFIG_SUN3 */
 
--- 2.5.19/include/asm-mips/pgtable.h~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-mips/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -493,12 +493,11 @@ extern void paging_init(void);
 extern void update_mmu_cache(struct vm_area_struct *vma,
 				unsigned long address, pte_t pte);
 
-#define SWP_TYPE(x)		(((x).val >> 1) & 0x3f)
-#define SWP_OFFSET(x)		((x).val >> 8)
-#define SWP_ENTRY(type,offset)	((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
-#define pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
-#define swp_entry_to_pte(x)	((pte_t) { (x).val })
-
+#define __swp_type(x)		(((x).val >> 1) & 0x3f)
+#define __swp_offset(x)		((x).val >> 8)
+#define __swp_entry(type,offset) ((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
 #define kern_addr_valid(addr)	(1)
 
--- 2.5.19/include/asm-mips64/pgtable.h~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-mips64/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -553,11 +553,11 @@ extern void (*update_mmu_cache)(struct v
 extern inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
 { pte_t pte; pte_val(pte) = (type << 32) | (offset << 40); return pte; }
 
-#define SWP_TYPE(x)		(((x).val >> 32) & 0xff)
-#define SWP_OFFSET(x)		((x).val >> 40)
-#define SWP_ENTRY(type,offset)	((swp_entry_t) { pte_val(mk_swap_pte((type),(offset))) })
-#define pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
-#define swp_entry_to_pte(x)	((pte_t) { (x).val })
+#define __swp_type(x)		(((x).val >> 32) & 0xff)
+#define __swp_offset(x)		((x).val >> 40)
+#define __swp_entry(type,offset) ((swp_entry_t) { pte_val(mk_swap_pte((type),(offset))) })
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
 #ifndef CONFIG_DISCONTIGMEM
 #define kern_addr_valid(addr)	(1)
--- 2.5.19/include/asm-parisc/pgtable.h~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-parisc/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -312,14 +312,14 @@ extern inline void update_mmu_cache(stru
 
 /* Encode and de-code a swap entry */
 
-#define SWP_TYPE(x)                     ((x).val & 0x3f)
-#define SWP_OFFSET(x)                   ( (((x).val >> 6) &  0x7) | \
+#define __swp_type(x)                     ((x).val & 0x3f)
+#define __swp_offset(x)                   ( (((x).val >> 6) &  0x7) | \
 					  (((x).val >> 7) & ~0x7) )
-#define SWP_ENTRY(type, offset)         ((swp_entry_t) { (type) | \
+#define __swp_entry(type, offset)         ((swp_entry_t) { (type) | \
 					    ((offset &  0x7) << 6) | \
 					    ((offset & ~0x7) << 7) })
-#define pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
-#define swp_entry_to_pte(x)		((pte_t) { (x).val })
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
 #define module_map	vmalloc
 #define module_unmap	vfree
--- 2.5.19/include/asm-ppc/pgtable.h~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-ppc/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -482,11 +482,11 @@ extern void add_hash_page(unsigned conte
  * must not include the _PAGE_PRESENT bit, or the _PAGE_HASHPTE bit
  * (if used).  -- paulus
  */
-#define SWP_TYPE(entry)			((entry).val & 0x3f)
-#define SWP_OFFSET(entry)		((entry).val >> 6)
-#define SWP_ENTRY(type, offset)		((swp_entry_t) { (type) | ((offset) << 6) })
-#define pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) >> 2 })
-#define swp_entry_to_pte(x)		((pte_t) { (x).val << 2 })
+#define __swp_type(entry)		((entry).val & 0x3f)
+#define __swp_offset(entry)		((entry).val >> 6)
+#define __swp_entry(type, offset)	((swp_entry_t) { (type) | ((offset) << 6) })
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) >> 2 })
+#define __swp_entry_to_pte(x)		((pte_t) { (x).val << 2 })
 
 /* CONFIG_APUS */
 /* For virtual address to physical address conversion */
--- 2.5.19/include/asm-ppc64/pgtable.h~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-ppc64/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -367,11 +367,11 @@ extern void paging_init(void);
 extern void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t);
 
 /* Encode and de-code a swap entry */
-#define SWP_TYPE(entry)			(((entry).val >> 1) & 0x3f)
-#define SWP_OFFSET(entry)		((entry).val >> 8)
-#define SWP_ENTRY(type, offset)		((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
-#define pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) >> PTE_SHIFT })
-#define swp_entry_to_pte(x)		((pte_t) { (x).val << PTE_SHIFT })
+#define __swp_type(entry)		(((entry).val >> 1) & 0x3f)
+#define __swp_offset(entry)		((entry).val >> 8)
+#define __swp_entry(type, offset)	((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) >> PTE_SHIFT })
+#define __swp_entry_to_pte(x)		((pte_t) { (x).val << PTE_SHIFT })
 
 /*
  * kern_addr_valid is intended to indicate whether an address is a valid
--- 2.5.19/include/asm-s390/pgtable.h~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-s390/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -485,12 +485,12 @@ extern inline pte_t mk_swap_pte(unsigned
 	return pte;
 }
 
-#define SWP_TYPE(entry)		(((entry).val >> 1) & 0x3f)
-#define SWP_OFFSET(entry)	(((entry).val >> 12) & 0x7FFFF )
-#define SWP_ENTRY(type,offset)	((swp_entry_t) { pte_val(mk_swap_pte((type),(offset))) })
+#define __swp_type(entry)	(((entry).val >> 1) & 0x3f)
+#define __swp_offset(entry)	(((entry).val >> 12) & 0x7FFFF )
+#define __swp_entry(type,offset) ((swp_entry_t) { pte_val(mk_swap_pte((type),(offset))) })
 
-#define pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
-#define swp_entry_to_pte(x)	((pte_t) { (x).val })
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
 #endif /* !__ASSEMBLY__ */
 
--- 2.5.19/include/asm-s390x/pgtable.h~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-s390x/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -505,12 +505,12 @@ extern inline pte_t mk_swap_pte(unsigned
 	return pte;
 }
 
-#define SWP_TYPE(entry)		(((entry).val >> 1) & 0x3f)
-#define SWP_OFFSET(entry)	((entry).val >> 12)
-#define SWP_ENTRY(type,offset)	((swp_entry_t) { pte_val(mk_swap_pte((type),(offset))) })
+#define __swp_type(entry)	(((entry).val >> 1) & 0x3f)
+#define __swp_offset(entry)	((entry).val >> 12)
+#define __swp_entry(type,offset) ((swp_entry_t) { pte_val(mk_swap_pte((type),(offset))) })
 
-#define pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
-#define swp_entry_to_pte(x)	((pte_t) { (x).val })
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
 #endif /* !__ASSEMBLY__ */
 
--- 2.5.19/include/asm-sh/pgtable.h~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-sh/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -294,11 +294,11 @@ extern void update_mmu_cache(struct vm_a
  * NOTE: We should set ZEROs at the position of _PAGE_PRESENT
  *       and _PAGE_PROTONOE bits
  */
-#define SWP_TYPE(x)		((x).val & 0xff)
-#define SWP_OFFSET(x)		((x).val >> 10)
-#define SWP_ENTRY(type, offset)	((swp_entry_t) { (type) | ((offset) << 10) })
-#define pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
-#define swp_entry_to_pte(x)	((pte_t) { (x).val })
+#define __swp_type(x)		((x).val & 0xff)
+#define __swp_offset(x)		((x).val >> 10)
+#define __swp_entry(type, offset) ((swp_entry_t) { (type) | ((offset) << 10) })
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
 /*
  * Routines for update of PTE 
--- 2.5.19/include/asm-sparc/pgtable.h~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-sparc/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -376,11 +376,11 @@ BTFIXUPDEF_CALL(void, update_mmu_cache, 
 extern int invalid_segment;
 
 /* Encode and de-code a swap entry */
-#define SWP_TYPE(x)			(((x).val >> 2) & 0x7f)
-#define SWP_OFFSET(x)			(((x).val >> 9) & 0x3ffff)
-#define SWP_ENTRY(type,offset)		((swp_entry_t) { (((type) & 0x7f) << 2) | (((offset) & 0x3ffff) << 9) })
-#define pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
-#define swp_entry_to_pte(x)		((pte_t) { (x).val })
+#define __swp_type(x)			(((x).val >> 2) & 0x7f)
+#define __swp_offset(x)			(((x).val >> 9) & 0x3ffff)
+#define __swp_entry(type,offset)	((swp_entry_t) { (((type) & 0x7f) << 2) | (((offset) & 0x3ffff) << 9) })
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
 struct ctx_list {
 	struct ctx_list *next;
--- 2.5.19/include/asm-sparc64/pgtable.h~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-sparc64/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -298,16 +298,16 @@ extern inline pte_t mk_pte_io(unsigned l
 }
 
 /* Encode and de-code a swap entry */
-#define SWP_TYPE(entry)		(((entry).val >> PAGE_SHIFT) & 0xffUL)
-#define SWP_OFFSET(entry)	((entry).val >> (PAGE_SHIFT + 8UL))
-#define SWP_ENTRY(type, offset)	\
+#define __swp_type(entry)	(((entry).val >> PAGE_SHIFT) & 0xffUL)
+#define __swp_offset(entry)	((entry).val >> (PAGE_SHIFT + 8UL))
+#define __swp_entry(type, offset)	\
 	( (swp_entry_t) \
 	  { \
 		(((long)(type) << PAGE_SHIFT) | \
                  ((long)(offset) << (PAGE_SHIFT + 8UL))) \
 	  } )
-#define pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
-#define swp_entry_to_pte(x)		((pte_t) { (x).val })
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
 extern unsigned long prom_virt_to_phys(unsigned long, int *);
 
--- 2.5.19/include/asm-x86_64/pgtable.h~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-x86_64/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -329,11 +329,11 @@ extern inline pte_t pte_modify(pte_t pte
 #define update_mmu_cache(vma,address,pte) do { } while (0)
 
 /* Encode and de-code a swap entry */
-#define SWP_TYPE(x)			(((x).val >> 1) & 0x3f)
-#define SWP_OFFSET(x)			((x).val >> 8)
-#define SWP_ENTRY(type, offset)		((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
-#define pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
-#define swp_entry_to_pte(x)		((pte_t) { (x).val })
+#define __swp_type(x)			(((x).val >> 1) & 0x3f)
+#define __swp_offset(x)			((x).val >> 8)
+#define __swp_entry(type, offset)	((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
 #endif /* !__ASSEMBLY__ */
 
--- 2.5.19/arch/m68k/atari/stram.c~ratpack	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/arch/m68k/atari/stram.c	Sat Jun  1 01:18:07 2002
@@ -315,7 +315,7 @@ void __init atari_stram_reserve_pages(vo
 		   otherwise just use the end of kernel data (= start_mem) */
 		swap_start = !kernel_in_stram ? stram_start + PAGE_SIZE : start_mem;
 		/* decrement by one page, rest of kernel assumes that first swap page
-		 * is always reserved and maybe doesn't handle SWP_ENTRY == 0
+		 * is always reserved and maybe doesn't handle swp_entry == 0
 		 * correctly */
 		swap_start -= PAGE_SIZE;
 		swap_end = stram_end;
@@ -749,7 +749,7 @@ static int unswap_by_read(unsigned short
 		}
 
 		if (map[i]) {
-			entry = SWP_ENTRY(stram_swap_type, i);
+			entry = swp_entry(stram_swap_type, i);
 			DPRINTK("unswap: map[i=%lu]=%u nr_swap=%u\n",
 				i, map[i], nr_swap_pages);
 


-
