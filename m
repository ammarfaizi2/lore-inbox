Return-Path: <linux-kernel-owner+w=401wt.eu-S932661AbXAHUqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbXAHUqZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 15:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932664AbXAHUqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 15:46:24 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:39301 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932661AbXAHUqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 15:46:23 -0500
X-Originating-Ip: 74.109.98.176
Date: Mon, 8 Jan 2007 15:40:51 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: paulus@samba.org
Subject: [PATCH] Clean up PPC code to use canonical alignment macros from
 kernel.h.
Message-ID: <Pine.LNX.4.64.0701081535140.2965@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.723, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, TW_SV 0.08)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Clean up some PowerPC source files to use the canonical alignment
macros from kernel.h, and add an ALIGN_DOWN() macro to kernel.h for
symmetry.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  there doesn't seem to be any compelling reason for the PPC code to
need to define its own alignment macros, but i've been wrong before.

  and, no, i didn't test-compile this as i don't have a PPC
cross-compiler at the moment.  sorry.

 arch/powerpc/boot/addRamDisk.c               |    3 +--
 arch/powerpc/boot/of.c                       |    2 +-
 arch/powerpc/boot/page.h                     |    9 +--------
 arch/powerpc/boot/simple_alloc.c             |    8 ++++----
 arch/powerpc/kernel/prom_init.c              |   16 ++++++++--------
 arch/powerpc/mm/lmb.c                        |    6 +++---
 arch/powerpc/platforms/powermac/bootx_init.c |   10 +++++-----
 arch/powerpc/platforms/ps3/mm.c              |   16 ++++++++--------
 include/asm-powerpc/iommu.h                  |    2 +-
 include/asm-powerpc/page.h                   |    9 +--------
 include/asm-ppc/page.h                       |    9 +--------
 include/linux/kernel.h                       |    1 +
 12 files changed, 35 insertions(+), 56 deletions(-)

diff --git a/arch/powerpc/boot/addRamDisk.c b/arch/powerpc/boot/addRamDisk.c
index c02a999..609603b 100644
--- a/arch/powerpc/boot/addRamDisk.c
+++ b/arch/powerpc/boot/addRamDisk.c
@@ -10,7 +10,6 @@
 #define ElfHeaderSize  (64 * 1024)
 #define ElfPages  (ElfHeaderSize / 4096)
 #define KERNELBASE (0xc000000000000000)
-#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))

 struct addr_range {
 	unsigned long long addr;
@@ -177,7 +176,7 @@ int main(int argc, char **argv)
 	roundedKernelPages = roundedKernelLen / 4096;
 	printf("Vmlinux pages to copy = %ld/0x%lx \n", roundedKernelPages, roundedKernelPages);

-	offset_end = _ALIGN_UP(vmlinux.memsize, 4096);
+	offset_end = ALIGN(vmlinux.memsize, 4096);
 	/* calc how many pages we need to insert between the vmlinux and the start of the ram disk */
 	padPages = offset_end/4096 - roundedKernelPages;

diff --git a/arch/powerpc/boot/of.c b/arch/powerpc/boot/of.c
index 0182f38..dcdc067 100644
--- a/arch/powerpc/boot/of.c
+++ b/arch/powerpc/boot/of.c
@@ -178,7 +178,7 @@ static void *of_try_claim(u32 size)
 	unsigned long addr = 0;

 	if (claim_base == 0)
-		claim_base = _ALIGN_UP((unsigned long)_end, ONE_MB);
+		claim_base = ALIGN((unsigned long)_end, ONE_MB);

 	for(; claim_base < RAM_END; claim_base += ONE_MB) {
 #ifdef DEBUG
diff --git a/arch/powerpc/boot/page.h b/arch/powerpc/boot/page.h
index 14eca30..5c33be7 100644
--- a/arch/powerpc/boot/page.h
+++ b/arch/powerpc/boot/page.h
@@ -21,14 +21,7 @@
 #define PAGE_SIZE	(ASM_CONST(1) << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))

-/* align addr on a size boundary - adjust address up/down if needed */
-#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
-#define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
-
-/* align addr on a size boundary - adjust address up if needed */
-#define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
-
 /* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	_ALIGN(addr, PAGE_SIZE)
+#define PAGE_ALIGN(addr)	ALIGN(addr, PAGE_SIZE)

 #endif				/* _PPC_BOOT_PAGE_H */
diff --git a/arch/powerpc/boot/simple_alloc.c b/arch/powerpc/boot/simple_alloc.c
index cfe3a75..39bb37f 100644
--- a/arch/powerpc/boot/simple_alloc.c
+++ b/arch/powerpc/boot/simple_alloc.c
@@ -42,7 +42,7 @@ static void *simple_malloc(u32 size)
 	if (size == 0)
 		goto err_out;

-	size = _ALIGN_UP(size, alloc_min);
+	size = ALIGN(size, alloc_min);

 	for (i=0; i<tbl_entries; i++, p++)
 		if (!(p->flags & ENTRY_BEEN_USED)) { /* never been used */
@@ -127,16 +127,16 @@ void *simple_alloc_init(char *base, u32 heap_size, u32 granularity,
 {
 	u32 heap_base, tbl_size;

-	heap_size = _ALIGN_UP(heap_size, granularity);
+	heap_size = ALIGN(heap_size, granularity);
 	alloc_min = granularity;
 	tbl_entries = max_allocs;

 	tbl_size = tbl_entries * sizeof(struct alloc_info);

-	alloc_tbl = (struct alloc_info *)_ALIGN_UP((unsigned long)base, 8);
+	alloc_tbl = (struct alloc_info *)ALIGN((unsigned long)base, 8);
 	memset(alloc_tbl, 0, tbl_size);

-	heap_base = _ALIGN_UP((u32)alloc_tbl + tbl_size, alloc_min);
+	heap_base = ALIGN((u32)alloc_tbl + tbl_size, alloc_min);

 	next_base = heap_base;
 	space_left = heap_size;
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 520ef42..b571fef 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -842,18 +842,18 @@ static unsigned long __init alloc_up(unsigned long size, unsigned long align)
 	unsigned long addr = 0;

 	if (align)
-		base = _ALIGN_UP(base, align);
+		base = ALIGN(base, align);
 	prom_debug("alloc_up(%x, %x)\n", size, align);
 	if (RELOC(ram_top) == 0)
 		prom_panic("alloc_up() called with mem not initialized\n");

 	if (align)
-		base = _ALIGN_UP(RELOC(alloc_bottom), align);
+		base = ALIGN(RELOC(alloc_bottom), align);
 	else
 		base = RELOC(alloc_bottom);

 	for(; (base + size) <= RELOC(alloc_top);
-	    base = _ALIGN_UP(base + 0x100000, align)) {
+	    base = ALIGN(base + 0x100000, align)) {
 		prom_debug("    trying: 0x%x\n\r", base);
 		addr = (unsigned long)prom_claim(base, size, 0);
 		if (addr != PROM_ERROR && addr != 0)
@@ -893,7 +893,7 @@ static unsigned long __init alloc_down(unsigned long size, unsigned long align,

 	if (highmem) {
 		/* Carve out storage for the TCE table. */
-		addr = _ALIGN_DOWN(RELOC(alloc_top_high) - size, align);
+		addr = ALIGN_DOWN(RELOC(alloc_top_high) - size, align);
 		if (addr <= RELOC(alloc_bottom))
 			return 0;
 		/* Will we bump into the RMO ? If yes, check out that we
@@ -911,9 +911,9 @@ static unsigned long __init alloc_down(unsigned long size, unsigned long align,
 		goto bail;
 	}

-	base = _ALIGN_DOWN(RELOC(alloc_top) - size, align);
+	base = ALIGN_DOWN(RELOC(alloc_top) - size, align);
 	for (; base > RELOC(alloc_bottom);
-	     base = _ALIGN_DOWN(base - 0x100000, align))  {
+	     base = ALIGN_DOWN(base - 0x100000, align))  {
 		prom_debug("    trying: 0x%x\n\r", base);
 		addr = (unsigned long)prom_claim(base, size, 0);
 		if (addr != PROM_ERROR && addr != 0)
@@ -979,8 +979,8 @@ static void reserve_mem(u64 base, u64 size)
 	 * have our terminator with "size" set to 0 since we are
 	 * dumb and just copy this entire array to the boot params
 	 */
-	base = _ALIGN_DOWN(base, PAGE_SIZE);
-	top = _ALIGN_UP(top, PAGE_SIZE);
+	base = ALIGN_DOWN(base, PAGE_SIZE);
+	top = ALIGN(top, PAGE_SIZE);
 	size = top - base;

 	if (cnt >= (MEM_RESERVE_MAP_SIZE - 1))
diff --git a/arch/powerpc/mm/lmb.c b/arch/powerpc/mm/lmb.c
index 716a290..4ff7a04 100644
--- a/arch/powerpc/mm/lmb.c
+++ b/arch/powerpc/mm/lmb.c
@@ -261,16 +261,16 @@ unsigned long __init __lmb_alloc_base(unsigned long size, unsigned long align,
 		unsigned long lmbsize = lmb.memory.region[i].size;

 		if (max_addr == LMB_ALLOC_ANYWHERE)
-			base = _ALIGN_DOWN(lmbbase + lmbsize - size, align);
+			base = ALIGN_DOWN(lmbbase + lmbsize - size, align);
 		else if (lmbbase < max_addr) {
 			base = min(lmbbase + lmbsize, max_addr);
-			base = _ALIGN_DOWN(base - size, align);
+			base = ALIGN_DOWN(base - size, align);
 		} else
 			continue;

 		while ((lmbbase <= base) &&
 		       ((j = lmb_overlaps_region(&lmb.reserved, base, size)) >= 0) )
-			base = _ALIGN_DOWN(lmb.reserved.region[j].base - size,
+			base = ALIGN_DOWN(lmb.reserved.region[j].base - size,
 					   align);

 		if ((base != 0) && (lmbbase <= base))
diff --git a/arch/powerpc/platforms/powermac/bootx_init.c b/arch/powerpc/platforms/powermac/bootx_init.c
index 9d73d02..b841224 100644
--- a/arch/powerpc/platforms/powermac/bootx_init.c
+++ b/arch/powerpc/platforms/powermac/bootx_init.c
@@ -111,7 +111,7 @@ static void * __init bootx_early_getprop(unsigned long base,

 #define dt_push_token(token, mem) \
 	do { \
-		*(mem) = _ALIGN_UP(*(mem),4); \
+		*(mem) = ALIGN(*(mem),4); \
 		*((u32 *)*(mem)) = token; \
 		*(mem) += 4; \
 	} while(0)
@@ -153,7 +153,7 @@ static void __init bootx_dt_add_prop(char *name, void *data, int size,
 	/* push property content */
 	if (size && data) {
 		memcpy((void *)*mem_end, data, size);
-		*mem_end = _ALIGN_UP(*mem_end + size, 4);
+		*mem_end = ALIGN(*mem_end + size, 4);
 	}
 }

@@ -306,7 +306,7 @@ static void __init bootx_scan_dt_build_struct(unsigned long base,
 			*lp++ = *p;
 	}
 	*lp = 0;
-	*mem_end = _ALIGN_UP((unsigned long)lp + 1, 4);
+	*mem_end = ALIGN((unsigned long)lp + 1, 4);

 	/* get and store all properties */
 	while (*ppp) {
@@ -359,11 +359,11 @@ static unsigned long __init bootx_flatten_dt(unsigned long start)
 	/* Start using memory after the big blob passed by BootX, get
 	 * some space for the header
 	 */
-	mem_start = mem_end = _ALIGN_UP(((unsigned long)bi) + start, 4);
+	mem_start = mem_end = ALIGN(((unsigned long)bi) + start, 4);
 	DBG("Boot params header at: %x\n", mem_start);
 	hdr = (struct boot_param_header *)mem_start;
 	mem_end += sizeof(struct boot_param_header);
-	rsvmap = (u64 *)(_ALIGN_UP(mem_end, 8));
+	rsvmap = (u64 *)(ALIGN(mem_end, 8));
 	hdr->off_mem_rsvmap = ((unsigned long)rsvmap) - mem_start;
 	mem_end = ((unsigned long)rsvmap) + 8 * sizeof(u64);

diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index 49c0d01..389c9d0 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -238,7 +238,7 @@ int ps3_mm_region_create(struct mem_region *r, unsigned long size)
 	int result;
 	unsigned long muid;

-	r->size = _ALIGN_DOWN(size, 1 << PAGE_SHIFT_16M);
+	r->size = ALIGN_DOWN(size, 1 << PAGE_SHIFT_16M);

 	DBG("%s:%d requested  %lxh\n", __func__, __LINE__, size);
 	DBG("%s:%d actual     %lxh\n", __func__, __LINE__, r->size);
@@ -395,8 +395,8 @@ static struct dma_chunk * dma_find_chunk(struct ps3_dma_region *r,
 	unsigned long bus_addr, unsigned long len)
 {
 	struct dma_chunk *c;
-	unsigned long aligned_bus = _ALIGN_DOWN(bus_addr, 1 << r->page_size);
-	unsigned long aligned_len = _ALIGN_UP(len, 1 << r->page_size);
+	unsigned long aligned_bus = ALIGN_DOWN(bus_addr, 1 << r->page_size);
+	unsigned long aligned_len = ALIGN(len, 1 << r->page_size);

 	list_for_each_entry(c, &r->chunk_list.head, link) {
 		/* intersection */
@@ -500,7 +500,7 @@ static int dma_region_create(struct ps3_dma_region* r)
 {
 	int result;

-	r->len = _ALIGN_UP(map.total, 1 << r->page_size);
+	r->len = ALIGN(map.total, 1 << r->page_size);
 	INIT_LIST_HEAD(&r->chunk_list.head);
 	spin_lock_init(&r->chunk_list.lock);

@@ -594,8 +594,8 @@ static int dma_map_area(struct ps3_dma_region *r, unsigned long virt_addr,
 		return 0;
 	}

-	result = dma_map_pages(r, _ALIGN_DOWN(phys_addr, 1 << r->page_size),
-		_ALIGN_UP(len, 1 << r->page_size), &c);
+	result = dma_map_pages(r, ALIGN_DOWN(phys_addr, 1 << r->page_size),
+		ALIGN(len, 1 << r->page_size), &c);

 	if (result) {
 		*bus_addr = 0;
@@ -630,9 +630,9 @@ int dma_unmap_area(struct ps3_dma_region *r, unsigned long bus_addr,
 	c = dma_find_chunk(r, bus_addr, len);

 	if (!c) {
-		unsigned long aligned_bus = _ALIGN_DOWN(bus_addr,
+		unsigned long aligned_bus = ALIGN_DOWN(bus_addr,
 			1 << r->page_size);
-		unsigned long aligned_len = _ALIGN_UP(len, 1 << r->page_size);
+		unsigned long aligned_len = ALIGN(len, 1 << r->page_size);
 		DBG("%s:%d: not found: bus_addr %lxh\n",
 			__func__, __LINE__, bus_addr);
 		DBG("%s:%d: not found: len %lxh\n",
diff --git a/include/asm-powerpc/iommu.h b/include/asm-powerpc/iommu.h
index f85dbd3..d4f6fb6 100644
--- a/include/asm-powerpc/iommu.h
+++ b/include/asm-powerpc/iommu.h
@@ -32,7 +32,7 @@
 #define IOMMU_PAGE_SHIFT      12
 #define IOMMU_PAGE_SIZE       (ASM_CONST(1) << IOMMU_PAGE_SHIFT)
 #define IOMMU_PAGE_MASK       (~((1 << IOMMU_PAGE_SHIFT) - 1))
-#define IOMMU_PAGE_ALIGN(addr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE)
+#define IOMMU_PAGE_ALIGN(addr) ALIGN(addr, IOMMU_PAGE_SIZE)

 /* Boot time flags */
 extern int iommu_is_off;
diff --git a/include/asm-powerpc/page.h b/include/asm-powerpc/page.h
index b4d38b0..d93453c 100644
--- a/include/asm-powerpc/page.h
+++ b/include/asm-powerpc/page.h
@@ -83,15 +83,8 @@
 #include <asm/page_32.h>
 #endif

-/* align addr on a size boundary - adjust address up/down if needed */
-#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
-#define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
-
-/* align addr on a size boundary - adjust address up if needed */
-#define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
-
 /* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	_ALIGN(addr, PAGE_SIZE)
+#define PAGE_ALIGN(addr)	ALIGN(addr, PAGE_SIZE)

 /*
  * Don't compare things with KERNELBASE or PAGE_OFFSET to test for
diff --git a/include/asm-ppc/page.h b/include/asm-ppc/page.h
index fe95c82..9ed27db 100644
--- a/include/asm-ppc/page.h
+++ b/include/asm-ppc/page.h
@@ -36,15 +36,8 @@ typedef unsigned long pte_basic_t;
 #define PTE_FMT		"%.8lx"
 #endif

-/* align addr on a size boundary - adjust address up/down if needed */
-#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
-#define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
-
-/* align addr on a size boundary - adjust address up if needed */
-#define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
-
 /* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	_ALIGN(addr, PAGE_SIZE)
+#define PAGE_ALIGN(addr)	ALIGN(addr, PAGE_SIZE)


 #undef STRICT_MM_TYPECHECKS
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index b0c4a05..cc1e9ad 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -31,6 +31,7 @@

 #define ALIGN(x,a)		__ALIGN_MASK(x,(typeof(x))(a)-1)
 #define __ALIGN_MASK(x,mask)	(((x)+(mask))&~(mask))
+#define ALIGN_DOWN(x,a)		((x)&(~((a)-1)))

 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
