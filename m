Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSFJO7c>; Mon, 10 Jun 2002 10:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315442AbSFJO7b>; Mon, 10 Jun 2002 10:59:31 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:39950 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315440AbSFJO72>; Mon, 10 Jun 2002 10:59:28 -0400
Date: Mon, 10 Jun 2002 16:59:27 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH/RFC] repost: sparc32: reserve nocache acc. to the amount of system RAM
Message-ID: <20020610145927.GA3785@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 6 days, 6:56
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch settles Anton Blanchard's FIXME from
asm-sparc/vaddrs.h. For sparc32 systems, it makes the kernel
allocate nocache memory based on the amount of system RAM,
abandoning the old behavior of always reserving 256 pages.

Together with Colin Gibb's patches that made it into -pre9,
this should make 2.4 perform just ok on sparcs. Sure, it's
still possible to run out of nocache mem, but the unfortunate
event should more likely only happen when the machine is
running out of system RAM too.

Could someone (DaveM? Uzi?) have a brief look at the patch to
confirm it won't put anyone's machine on fire? I've only had
the opportunity to test it on two different sun4m machines --
so far it seemed to work as expected.

I've set the allocation ratio to "let's have 256 pages
of nocache per 64MB of system RAM," see SRMMU_NOCACHE_ALCRATIO
in vaddrs.h. Should suffice.

The patch applies to both 2.4.19-pre9 & pre10.

T.


diff -urN linux-2.4.19-pre9/arch/sparc/mm/init.c linux-2.4.19-pre9.n/arch/sparc/mm/init.c
--- linux-2.4.19-pre9/arch/sparc/mm/init.c	Fri May  3 02:06:52 2002
+++ linux-2.4.19-pre9.n/arch/sparc/mm/init.c	Sat Jun  1 15:03:25 2002
@@ -61,13 +61,15 @@
 pte_t *kmap_pte;
 pgprot_t kmap_prot;
 
+extern unsigned long fix_kmap_begin;	/* calculated in srmmu.c */
+
 #define kmap_get_fixed_pte(vaddr) \
 	pte_offset(pmd_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr))
 
 void __init kmap_init(void)
 {
 	/* cache the first kmap pte */
-	kmap_pte = kmap_get_fixed_pte(FIX_KMAP_BEGIN);
+	kmap_pte = kmap_get_fixed_pte(fix_kmap_begin);
 	kmap_prot = __pgprot(SRMMU_ET_PTE | SRMMU_PRIV | SRMMU_CACHE);
 }
 
diff -urN linux-2.4.19-pre9/arch/sparc/mm/srmmu.c linux-2.4.19-pre9.n/arch/sparc/mm/srmmu.c
--- linux-2.4.19-pre9/arch/sparc/mm/srmmu.c	Wed May 29 08:37:28 2002
+++ linux-2.4.19-pre9.n/arch/sparc/mm/srmmu.c	Sat Jun  1 15:18:02 2002
@@ -114,8 +114,16 @@
 
 int srmmu_cache_pagetables;
 
-/* XXX Make this dynamic based on ram size - Anton */
-#define SRMMU_NOCACHE_BITMAP_SIZE (SRMMU_NOCACHE_NPAGES * 16)
+/* these will be initialized in srmmu_nocache_calcsize() */
+int srmmu_nocache_npages;
+unsigned long srmmu_nocache_size;
+unsigned long srmmu_nocache_end;
+unsigned long fix_kmap_begin;
+unsigned long fix_kmap_end;
+unsigned long pkmap_base;
+unsigned long pkmap_base_end;
+unsigned long srmmu_nocache_bitmap_size;
+
 #define SRMMU_NOCACHE_BITMAP_SHIFT (PAGE_SHIFT - 4)
 
 void *srmmu_nocache_pool;
@@ -248,7 +256,7 @@
 	spin_lock(&srmmu_nocache_spinlock);
 
 repeat:
-	offset = find_next_zero_bit(srmmu_nocache_bitmap, SRMMU_NOCACHE_BITMAP_SIZE, offset);
+	offset = find_next_zero_bit(srmmu_nocache_bitmap, srmmu_nocache_bitmap_size, offset);
 
 	/* we align on physical address */
 	if (align) {
@@ -258,7 +266,7 @@
 		offset = (va_tmp - SRMMU_NOCACHE_VADDR) >> SRMMU_NOCACHE_BITMAP_SHIFT;
 	}
 
-	if ((SRMMU_NOCACHE_BITMAP_SIZE - offset) < size) {
+	if ((srmmu_nocache_bitmap_size - offset) < size) {
 		printk("Run out of nocached RAM!\n");
 		spin_unlock(&srmmu_nocache_spinlock);
 		return 0;
@@ -322,6 +330,35 @@
 
 void srmmu_early_allocate_ptable_skeleton(unsigned long start, unsigned long end);
 
+extern unsigned long probe_memory(void);	/* in fault.c */
+
+/* Reserve nocache dynamically proportionally to the amount of
+ * system RAM. -- Tomas Szepe <szepe@pinerecords.com>, June 2002
+ */
+void srmmu_nocache_calcsize(void)
+{
+	unsigned long sysmemavail = probe_memory() / 1024;
+
+	srmmu_nocache_npages =
+		sysmemavail / SRMMU_NOCACHE_ALCRATIO / 1024 * 256;
+	if (sysmemavail % (SRMMU_NOCACHE_ALCRATIO * 1024))
+		srmmu_nocache_npages += 256;
+
+	/* anything above 1280 blows up */
+	if (srmmu_nocache_npages > 1280) srmmu_nocache_npages = 1280;
+
+	srmmu_nocache_size = srmmu_nocache_npages * PAGE_SIZE;
+	srmmu_nocache_bitmap_size = srmmu_nocache_npages * 16;
+	srmmu_nocache_end = SRMMU_NOCACHE_VADDR + srmmu_nocache_size;
+	fix_kmap_begin = srmmu_nocache_end;
+	fix_kmap_end = fix_kmap_begin + (KM_TYPE_NR * NR_CPUS - 1) * PAGE_SIZE;
+	pkmap_base = SRMMU_NOCACHE_VADDR + srmmu_nocache_size + 0x40000;
+	pkmap_base_end = pkmap_base + LAST_PKMAP * PAGE_SIZE;
+
+	/* printk("system memory available = %luk\nnocache ram size = %luk\n",
+		sysmemavail, srmmu_nocache_size / 1024); */
+}
+
 void srmmu_nocache_init(void)
 {
 	pgd_t *pgd;
@@ -330,24 +367,24 @@
 	unsigned long paddr, vaddr;
 	unsigned long pteval;
 
-	srmmu_nocache_pool = __alloc_bootmem(SRMMU_NOCACHE_SIZE, PAGE_SIZE, 0UL);
-	memset(srmmu_nocache_pool, 0, SRMMU_NOCACHE_SIZE);
+	srmmu_nocache_pool = __alloc_bootmem(srmmu_nocache_size, PAGE_SIZE, 0UL);
+	memset(srmmu_nocache_pool, 0, srmmu_nocache_size);
 
-	srmmu_nocache_bitmap = __alloc_bootmem(SRMMU_NOCACHE_BITMAP_SIZE, SMP_CACHE_BYTES, 0UL);
-	memset(srmmu_nocache_bitmap, 0, SRMMU_NOCACHE_BITMAP_SIZE);
+	srmmu_nocache_bitmap = __alloc_bootmem(srmmu_nocache_bitmap_size, SMP_CACHE_BYTES, 0UL);
+	memset(srmmu_nocache_bitmap, 0, srmmu_nocache_bitmap_size);
 
 	srmmu_swapper_pg_dir = (pgd_t *)__srmmu_get_nocache(SRMMU_PGD_TABLE_SIZE, SRMMU_PGD_TABLE_SIZE);
 	memset(__nocache_fix(srmmu_swapper_pg_dir), 0, SRMMU_PGD_TABLE_SIZE);
 	init_mm.pgd = srmmu_swapper_pg_dir;
 
-	srmmu_early_allocate_ptable_skeleton(SRMMU_NOCACHE_VADDR, SRMMU_NOCACHE_END);
+	srmmu_early_allocate_ptable_skeleton(SRMMU_NOCACHE_VADDR, srmmu_nocache_end);
 
 	spin_lock_init(&srmmu_nocache_spinlock);
 
 	paddr = __pa((unsigned long)srmmu_nocache_pool);
 	vaddr = SRMMU_NOCACHE_VADDR;
 
-	while (vaddr < SRMMU_NOCACHE_END) {
+	while (vaddr < srmmu_nocache_end) {
 		pgd = pgd_offset_k(vaddr);
 		pmd = srmmu_pmd_offset(__nocache_fix(pgd), vaddr);
 		pte = srmmu_pte_offset(__nocache_fix(pmd), vaddr);
@@ -1144,6 +1181,7 @@
 	pages_avail = 0;
 	last_valid_pfn = bootmem_init(&pages_avail);
 
+	srmmu_nocache_calcsize();
 	srmmu_nocache_init();
         srmmu_inherit_prom_mappings(0xfe400000,(LINUX_OPPROM_ENDVM-PAGE_SIZE));
 	map_kernel();
@@ -1165,12 +1203,12 @@
 	srmmu_allocate_ptable_skeleton(DVMA_VADDR, DVMA_END);
 #endif
 
-	srmmu_allocate_ptable_skeleton(FIX_KMAP_BEGIN, FIX_KMAP_END);
-	srmmu_allocate_ptable_skeleton(PKMAP_BASE, PKMAP_BASE_END);
+	srmmu_allocate_ptable_skeleton(fix_kmap_begin, fix_kmap_end);
+	srmmu_allocate_ptable_skeleton(pkmap_base, pkmap_base_end);
 
-	pgd = pgd_offset_k(PKMAP_BASE);
-	pmd = pmd_offset(pgd, PKMAP_BASE);
-	pte = pte_offset(pmd, PKMAP_BASE);
+	pgd = pgd_offset_k(pkmap_base);
+	pmd = pmd_offset(pgd, pkmap_base);
+	pte = pte_offset(pmd, pkmap_base);
 	pkmap_page_table = pte;
 
 	flush_cache_all();
@@ -1219,7 +1257,7 @@
 		   "nocache used\t: %d\n",
 		   srmmu_name,
 		   num_contexts,
-		   SRMMU_NOCACHE_SIZE,
+		   srmmu_nocache_size,
 		   (srmmu_nocache_used << SRMMU_NOCACHE_BITMAP_SHIFT));
 }
 
diff -urN linux-2.4.19-pre9/include/asm-sparc/highmem.h linux-2.4.19-pre9.n/include/asm-sparc/highmem.h
--- linux-2.4.19-pre9/include/asm-sparc/highmem.h	Thu Oct 25 03:17:21 2001
+++ linux-2.4.19-pre9.n/include/asm-sparc/highmem.h	Sat Jun  1 15:03:25 2002
@@ -36,6 +36,10 @@
 extern pgprot_t kmap_prot;
 extern pte_t *pkmap_page_table;
 
+/* these two get calculated in arch/sparc/mm/srmmu.c */
+extern unsigned long fix_kmap_begin;
+extern unsigned long pkmap_base;
+
 extern void kmap_init(void) __init;
 
 /*
@@ -45,9 +49,9 @@
  */
 #define LAST_PKMAP 1024
 
-#define LAST_PKMAP_MASK (LAST_PKMAP-1)
-#define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
-#define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
+#define LAST_PKMAP_MASK (LAST_PKMAP - 1)
+#define PKMAP_NR(virt)  ((virt - pkmap_base) >> PAGE_SHIFT)
+#define PKMAP_ADDR(nr)  (pkmap_base + ((nr) << PAGE_SHIFT))
 
 extern void *kmap_high(struct page *page);
 extern void kunmap_high(struct page *page);
@@ -85,7 +89,7 @@
 		return page_address(page);
 
 	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = FIX_KMAP_BEGIN + idx * PAGE_SIZE;
+	vaddr = fix_kmap_begin + idx * PAGE_SIZE;
 
 /* XXX Fix - Anton */
 #if 0
@@ -114,10 +118,10 @@
 	unsigned long vaddr = (unsigned long) kvaddr;
 	unsigned long idx = type + KM_TYPE_NR*smp_processor_id();
 
-	if (vaddr < FIX_KMAP_BEGIN) // FIXME
+	if (vaddr < fix_kmap_begin) // FIXME
 		return;
 
-	if (vaddr != FIX_KMAP_BEGIN + idx * PAGE_SIZE)
+	if (vaddr != fix_kmap_begin + idx * PAGE_SIZE)
 		BUG();
 
 /* XXX Fix - Anton */
diff -urN linux-2.4.19-pre9/include/asm-sparc/vaddrs.h linux-2.4.19-pre9.n/include/asm-sparc/vaddrs.h
--- linux-2.4.19-pre9/include/asm-sparc/vaddrs.h	Mon Jul 30 01:13:30 2001
+++ linux-2.4.19-pre9.n/include/asm-sparc/vaddrs.h	Sat Jun  1 15:07:17 2002
@@ -14,23 +14,26 @@
 
 #define SRMMU_MAXMEM		0x0c000000
 
-#define SRMMU_NOCACHE_VADDR	0xfc000000	/* KERNBASE + SRMMU_MAXMEM */
-/* XXX Make this dynamic based on ram size - Anton */
-#define SRMMU_NOCACHE_NPAGES	256
-#define SRMMU_NOCACHE_SIZE	(SRMMU_NOCACHE_NPAGES * PAGE_SIZE)
-#define SRMMU_NOCACHE_END	(SRMMU_NOCACHE_VADDR + SRMMU_NOCACHE_SIZE)
+#define SRMMU_NOCACHE_VADDR	(KERNBASE + SRMMU_MAXMEM)
+				/* = 0x0fc000000 */
 
-#define FIX_KMAP_BEGIN		0xfc100000
-#define FIX_KMAP_END (FIX_KMAP_BEGIN + ((KM_TYPE_NR*NR_CPUS)-1)*PAGE_SIZE)
-
-#define PKMAP_BASE		0xfc140000
-#define PKMAP_BASE_END		(PKMAP_BASE+LAST_PKMAP*PAGE_SIZE)
+/* The following constant is used in mm/srmmu.c::srmmu_nocache_calcsize()
+ * to determine the amount of memory that will be reserved as nocache:
+ *
+ * 256 pages will be taken as nocache per each
+ * SRMMU_NOCACHE_ALCRATIO MB of system memory.
+ *
+ * limits enforced:	nocache minimum = 256 pages
+ *			nocache maximum = 1280 pages
+ */
+#define SRMMU_NOCACHE_ALCRATIO	64	/* 256 pages per 64MB of system RAM */
 
 #define SUN4M_IOBASE_VADDR	0xfd000000 /* Base for mapping pages */
 #define IOBASE_VADDR		0xfe000000
 #define IOBASE_END		0xfe300000
 
 #define VMALLOC_START		0xfe300000
+
 /* XXX Alter this when I get around to fixing sun4c - Anton */
 #define VMALLOC_END		0xffc00000
 
