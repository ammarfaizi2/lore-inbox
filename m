Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269690AbTGJXMj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269689AbTGJXLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:11:40 -0400
Received: from foo209.internut.com ([209.181.68.209]:52146 "EHLO bartman")
	by vger.kernel.org with ESMTP id S269687AbTGJXLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:11:21 -0400
From: "Chuck Luciano" <chuck@mrluciano.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: My own 3.5G patch - there was a bug in the patch I started with
Date: Thu, 10 Jul 2003 17:24:39 -0600
Message-ID: <NFBBKNADOLMJPCENHEALOEBIGBAA.chuck@mrluciano.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0547_01C34708.24564590"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <1057878139.1413.11.camel@nighthawk>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0547_01C34708.24564590
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


I almost forgot. The patch I started with had a bug in it. (This is in case
anybody is using that patch)

+#define USER_PTRS_PER_PMD(x)   ((PARTIAL_PGD && ((x)==USER_PTRS_PER_PGD-1)) ? \
+				(PTRS_PER_PMD-PARTIAL_PMD) : \
+				PTRS_PER_PMD)

I had to change this to:

#define USER_PTRS_PER_PMD(x)   ((PARTIAL_PGD && ((x)==USER_PTRS_PER_PGD-1)) ? \
                PARTIAL_PMD : \
                PTRS_PER_PMD)

before my change, it worked at 1Gig boundarys (ok, i really only tested at 0xc0000000) and
at 1gig + .5Gig boundarys (e.g. 0xe0000000), 0xd0000000 would blow up, and I think 0xe8000000
was leaking some memory somewhere.

Anyway, the math was backwards.


> -----Original Message-----
> From: Dave Hansen [mailto:haveblue@us.ibm.com]
> Sent: Thursday, July 10, 2003 5:02 PM
> To: Chuck Luciano
> Cc: Linux-Kernel
> Subject: Re: My own 3.5G patch plus question on Ingo's 4G/$G patch
> 
> 
> On Thu, 2003-07-10 at 12:09, Chuck Luciano wrote:
> > I've been working on a patch for 2.4.18 that allows PAGE_OFFSET
> > to be set on boundarys other then 1GB multiples. I started with
> > a patch that I got from Martin Bligh and back ported it to 2.4.18.
> 
> I stole the configurable PAGE_OFFSET code from Andrea, made it work with
> partial kernel pmds, and stuck it in Martin's tree.  There are several
> parts to it, and I'm not sure which ones you got.
> 
> > http://www.mrluciano.com/chuck/linux-2.4.18-unaligned.patch
> > 
> > I'll apologize in advance for not having figured out how the configure
> > system works, so, when you apply this patch it's on. Also, you have to
> > edit vmlinux.lds AND page.h to move the boundary.
> 
> Here's the 2.5 patch to do the configuration: 
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/patches/2.5.73/2.5.73-mjb1/102-config_page_offset
> You'll have to adapt the arch/i386/Kconfig stuff to 2.4, but there's a
> good example of it here:
> http://ftp.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc8aa1/00_3.5G-address-space-5
> (which is where I stole the code from to begin with)

Thank you. The first time through, I was mainly concerned with getting it all to work. This time I'll
make it configurable.

> 
> Instead of changing _all_ of the loops which touch PMDs, I suggest you
> clean it up inside of the pmd function themselves.  All of these are
> confusing:
> +		if (start + PGDIR_SIZE < start)
> +			break;
> 

Duely noted.


> 
> -- 
> Dave Hansen
> haveblue@us.ibm.com
> 

Thank you,
Chuck L.
------=_NextPart_000_0547_01C34708.24564590
Content-Type: application/octet-stream;
	name="unaligned-page_offset-pae-2.4.19-UL-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="unaligned-page_offset-pae-2.4.19-UL-0.patch"

Binary files linux-2.4.19-suse/Kerntypes and linux-2.4.19-suse-weirdoffset/Kerntypes differ
diff -ur linux-2.4.19-suse/arch/i386/config.in linux-2.4.19-suse-weirdoffset/arch/i386/config.in
--- linux-2.4.19-suse/arch/i386/config.in	Tue Jan 14 14:44:06 2003
+++ linux-2.4.19-suse-weirdoffset/arch/i386/config.in	Mon Jan 20 08:59:28 2003
@@ -193,7 +193,9 @@
    define_bool CONFIG_X86_PAE y
    define_int CONFIG_FORCE_MAX_ZONEORDER 10
    choice 'User address space size' \
-	"3GB		CONFIG_1GB \
+	"3.75GB         CONFIG_025GB \
+	 3.5GB          CONFIG_05GB \
+	 3GB		CONFIG_1GB \
 	 2GB		CONFIG_2GB \
 	 1GB		CONFIG_3GB" 3GB
 else
diff -ur linux-2.4.19-suse/arch/i386/mm/init.c linux-2.4.19-suse-weirdoffset/arch/i386/mm/init.c
--- linux-2.4.19-suse/arch/i386/mm/init.c	Tue Jan 14 14:43:57 2003
+++ linux-2.4.19-suse-weirdoffset/arch/i386/mm/init.c	Mon Jan 20 09:09:24 2003
@@ -214,6 +214,107 @@
 	}
 }
 
+#define pte_offset_kernel(dir, address) \
+	((pte_t *) pmd_page_kernel(*(dir)) +  __pte_offset(address))
+#define pmd_page_kernel(pmd) \
+	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
+/*
+ * Create a page table and place a pointer to it in a middle page
+ * directory entry.
+ */
+static pte_t * __init one_page_table_init(pmd_t *pmd)
+{
+	pte_t *page_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+	set_pmd(pmd, __pmd(__pa(page_table) | _KERNPG_TABLE));
+	if (page_table != pte_offset_kernel(pmd, 0))
+		BUG();
+
+	return page_table;
+}
+
+	
+/*
+ * Abstract out using large pages when mapping KVA, or the SMP identity
+ * mapping
+ */
+static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
+{
+	return __pmd(((unsigned long long)page_nr << PAGE_SHIFT) | pgprot_val(pgprot));
+}
+static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
+{
+	pte_t pte;
+
+	pte.pte_high = page_nr >> (32 - PAGE_SHIFT);
+	pte.pte_low = (page_nr << PAGE_SHIFT) | pgprot_val(pgprot);
+	return pte;
+}
+
+#define __PAGE_KERNEL_LARGE (__PAGE_KERNEL | _PAGE_PSE)
+#define PAGE_KERNEL_LARGE __pgprot(__PAGE_KERNEL_LARGE)
+/*
+ * Creates a middle page table and puts a pointer to it in the
+ * given global directory entry. This only returns the gd entry
+ * in non-PAE compilation mode, since the middle layer is folded.
+ */
+static pmd_t * __init one_md_table_init(pgd_t *pgd)
+{
+	pmd_t *pmd_table;
+
+#if CONFIG_X86_PAE
+        pmd_table = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+        set_pgd(pgd, __pgd(__pa(pmd_table) | _PAGE_PRESENT));
+        if (pmd_table != pmd_offset(pgd, 0))
+		BUG();
+#else
+	pmd_table = pmd_offset(pgd, 0);
+#endif
+	return pmd_table;
+}
+
+void pmd_map_pfn_range(pmd_t* pmd_entry, unsigned long pfn, unsigned long max_pfn)
+{
+	int pte_ofs;
+	/* Map with big pages if possible, otherwise create normal page tables. */
+	if (cpu_has_pse) {
+		set_pmd(pmd_entry, pfn_pmd(pfn, PAGE_KERNEL_LARGE));
+		pfn += PTRS_PER_PTE;
+	} else {
+		pte_t* pte = one_page_table_init(pmd_entry);
+		for (pte_ofs = 0; pte_ofs < PTRS_PER_PTE && pfn < max_pfn; pte++, pfn++, pte_ofs++)
+			set_pte(pte, pfn_pte(pfn, PAGE_KERNEL));
+	}
+}
+					
+
+/*
+ * Add low memory identity-mappings - SMP needs it when
+ * starting up on an AP from real-mode. In the non-PAE
+ * case we already have these mappings through head.S.
+ * All user-space mappings are explicitly cleared after
+ * SMP startup in zap_low_mappings().
+ */
+static void __init low_physical_mapping_init(pgd_t *pgd_base)
+{
+#if CONFIG_X86_PAE
+	unsigned long pfn = 0;
+	int pmd_ofs = 0;
+	pmd_t *pmd = one_md_table_init(pgd_base);
+
+	if(!cpu_has_pse) {
+		printk("PAE enabled, but no support for PSE (large pages)!");
+		printk("this is likely to waste some RAM.");
+	}
+
+	for (; pmd_ofs < PTRS_PER_PMD && pfn <= max_low_pfn; pmd++, pmd_ofs++) { 
+		pmd_map_pfn_range(pmd, pfn, max_low_pfn);
+		pfn += PTRS_PER_PTE;
+	}
+#endif
+
+}
+
+
 void __init pagetable_init (void)
 {
 	unsigned long vaddr, end;
@@ -240,14 +341,7 @@
 		set_pgd(pgd_base + i, __pgd(1 + __pa(empty_zero_page)));
 	for (; i < PTRS_PER_PGD; i++, pmd += PTRS_PER_PMD)
 		set_pgd(pgd_base + i, __pgd(1 + __pa(pmd)));
-	/*
-	 * Add low memory identity-mappings - SMP needs it when
-	 * starting up on an AP from real-mode. In the non-PAE
-	 * case we already have these mappings through head.S.
-	 * All user-space mappings are explicitly cleared after
-	 * SMP startup.
-	 */
-	pgd_base[0] = pgd_base[USER_PGD_PTRS];
+	low_physical_mapping_init(pgd_base);
 #endif
 	i = __pgd_offset(PAGE_OFFSET);
 	pgd = pgd_base + i;
@@ -318,13 +412,14 @@
 void __init zap_low_mappings (void)
 {
 	int i;
+	printk("zap_low_mappings()\n");
 	/*
 	 * Zap initial low-memory mappings.
 	 *
 	 * Note that "pgd_clear()" doesn't do it for
 	 * us, because pgd_clear() is a no-op on i386.
 	 */
-	for (i = 0; i < USER_PTRS_PER_PGD; i++)
+	for (i = 0; i < __USER_PTRS_PER_PGD; i++)
 #if CONFIG_X86_PAE
 		set_pgd(swapper_pg_dir+i, __pgd(1 + __pa(empty_zero_page)));
 #else
diff -ur linux-2.4.19-suse/include/asm-i386/page_offset.h linux-2.4.19-suse-weirdoffset/include/asm-i386/page_offset.h
--- linux-2.4.19-suse/include/asm-i386/page_offset.h	Tue Jan 14 14:46:33 2003
+++ linux-2.4.19-suse-weirdoffset/include/asm-i386/page_offset.h	Mon Jan 20 09:00:23 2003
@@ -1,5 +1,7 @@
 #include <linux/config.h>
-#ifdef CONFIG_05GB
+#ifdef CONFIG_025GB
+#define PAGE_OFFSET_RAW 0xF0000000
+#elif defined(CONFIG_05GB)
 #define PAGE_OFFSET_RAW 0xE0000000
 #elif defined(CONFIG_1GB)
 #define PAGE_OFFSET_RAW 0xC0000000
diff -ur linux-2.4.19-suse/include/asm-i386/pgalloc.h linux-2.4.19-suse-weirdoffset/include/asm-i386/pgalloc.h
--- linux-2.4.19-suse/include/asm-i386/pgalloc.h	Tue Jan 14 14:46:34 2003
+++ linux-2.4.19-suse-weirdoffset/include/asm-i386/pgalloc.h	Mon Jan 20 09:00:23 2003
@@ -44,7 +44,6 @@
 {
 	int i;
 	pgd_t *pgd = kmem_cache_alloc(pae_pgd_cachep, GFP_KERNEL);
-
 	if (pgd) {
 		for (i = 0; i < USER_PTRS_PER_PGD; i++) {
 			unsigned long pmd = __get_free_page(GFP_KERNEL);
@@ -53,9 +52,21 @@
 			clear_page(pmd);
 			set_pgd(pgd + i, __pgd(1 + __pa(pmd)));
 		}
-		memcpy(pgd + USER_PTRS_PER_PGD,
-			swapper_pg_dir + USER_PTRS_PER_PGD,
-			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+		if (USER_PTRS_PER_PGD < PTRS_PER_PGD)
+			memcpy(pgd + USER_PTRS_PER_PGD,
+				swapper_pg_dir + USER_PTRS_PER_PGD,
+				(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+		if (PARTIAL_PGD) {
+			pgd_t *kpgd, *upgd;
+			pmd_t *kpmd, *upmd;
+			
+			kpgd = pgd_offset_k(TASK_SIZE);
+			upgd = pgd + __pgd_offset(TASK_SIZE);
+			kpmd = pmd_offset(kpgd, TASK_SIZE);
+			upmd = pmd_offset(upgd, TASK_SIZE);
+			memcpy(upmd, kpmd, (PTRS_PER_PMD-PARTIAL_PMD)*sizeof(pmd_t));
+		}
+			
 	}
 	return pgd;
 out_oom:
diff -ur linux-2.4.19-suse/include/asm-i386/pgtable.h linux-2.4.19-suse-weirdoffset/include/asm-i386/pgtable.h
--- linux-2.4.19-suse/include/asm-i386/pgtable.h	Tue Jan 14 14:46:34 2003
+++ linux-2.4.19-suse-weirdoffset/include/asm-i386/pgtable.h	Mon Jan 20 09:00:23 2003
@@ -138,7 +138,14 @@
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
-#define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define __USER_PTRS_PER_PGD    (TASK_SIZE/PGDIR_SIZE)
+#define PARTIAL_PGD    (TASK_SIZE > __USER_PTRS_PER_PGD*PGDIR_SIZE ? 1 : 0)
+#define PARTIAL_PMD    ((TASK_SIZE % PGDIR_SIZE)/PMD_SIZE)
+#define USER_PTRS_PER_PGD      (PARTIAL_PGD + __USER_PTRS_PER_PGD)
+#define USER_PTRS_PER_PMD(x)   ((PARTIAL_PGD && ((x)==USER_PTRS_PER_PGD-1)) ? \
+				(PTRS_PER_PMD-PARTIAL_PMD) : \
+				PTRS_PER_PMD)
+	
 #define FIRST_USER_PGD_NR	0
 
 #define USER_PGD_PTRS (PAGE_OFFSET >> PGDIR_SHIFT)
diff -ur linux-2.4.19-suse/mm/memory.c linux-2.4.19-suse-weirdoffset/mm/memory.c
--- linux-2.4.19-suse/mm/memory.c	Tue Jan 14 14:44:06 2003
+++ linux-2.4.19-suse-weirdoffset/mm/memory.c	Mon Jan 20 08:12:41 2003
@@ -111,10 +111,11 @@
 	pte_free_via_pmd(pmd);
 }
 
-static inline void free_one_pgd(pgd_t * dir)
+static inline void free_one_pgd(pgd_t * pgd, unsigned long pgdi)
 {
 	pmd_t * pmd, * md, * emd;
-
+	pgd_t *dir = pgd + pgdi;
+	
 	if (pgd_none(*dir))
 		return;
 	if (pgd_bad(*dir)) {
@@ -138,7 +139,7 @@
 	 * found at 0x80000000 onwards.  The loop below compiles instead
 	 * to be terminated by unsigned address comparison using "jb".
 	 */
-	for (md = pmd, emd = pmd + PTRS_PER_PMD; md < emd; md++) {
+	for (md = pmd, emd = pmd + USER_PTRS_PER_PMD(pgdi); md < emd; md++) {
 		prefetchw(md+(PREFETCH_STRIDE/16));
 		free_one_pmd(md);
 	}
@@ -165,12 +166,12 @@
 {
 	pgd_t * page_dir = mm->pgd;
 	unsigned long	last = first + nr;
+	int index = first;
 
 	spin_lock(&mm->page_table_lock);
-	page_dir += first;
 	do {
-		free_one_pgd(page_dir);
-		page_dir++;
+		free_one_pgd(page_dir, index);
+		index++;
 	} while (--nr);
 	spin_unlock(&mm->page_table_lock);
 

------=_NextPart_000_0547_01C34708.24564590--

