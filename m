Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263372AbTEIR5t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 13:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbTEIR5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 13:57:49 -0400
Received: from franka.aracnet.com ([216.99.193.44]:13199 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263372AbTEIR5Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 13:57:16 -0400
Date: Fri, 09 May 2003 08:55:00 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>
cc: Jamie Lokier <jamie@shareable.org>, Roland McGrath <roland@redhat.com>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 uaccess to fixmap pages
Message-ID: <44170000.1052495699@[10.10.2.4]>
In-Reply-To: <3EBBD982.9070006@us.ibm.com>
References: <Pine.LNX.4.44.0305090856500.9705-100000@home.transmeta.com> <3EBBD982.9070006@us.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1848459384=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1848459384==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>> It actually does have some cost in that form, namely the fact that the
>> kernel 1:1 mapping needs to be 4MB-aligned in order to take advantage of
>> large-pte support. So we'd have to move the kernel to something like
>> 0xc0400000 (and preferably higher, to make sure there is a nice hole in
>> between - say 0xc1000000), which in turn has a cost of verifying that 
>> nothing assumes the current lay-out (we've had the 1/2/3GB TASK_SIZE 
>> patches floating around, but they've never had "odd sizes").

I should explicitly state that with PAE on, you need to be PMD aligned (1GB)
as well, which everyone seems aware of, but nobody has explicitly mentioned
as far as I can see ;-) 

> Don't anyone go applying these yet, though.  I think there has been a
> bugfix or two since Martin released 2.5.68-mjb1, where these came from.
>  So, consider them just an example for now.

Here's the latest (fixed) sequence of patches, which seems to work pretty 
happily. Might need some merging to get them to go against mainline, but 
nothing major.

M.



--==========1848459384==========
Content-Type: text/plain; charset=us-ascii; name=102-config_page_offset
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=102-config_page_offset; size=5678

diff -urpN -X /home/fletch/.diff.exclude 101-config_hz/arch/i386/Kconfig 102-config_page_offset/arch/i386/Kconfig
--- 101-config_hz/arch/i386/Kconfig	Thu Apr 24 21:37:26 2003
+++ 102-config_page_offset/arch/i386/Kconfig	Thu Apr 24 21:37:27 2003
@@ -656,6 +656,44 @@ config HIGHMEM64G
 
 endchoice
 
+choice
+	help
+	  On i386, a process can only virtually address 4GB of memory.  This
+	  lets you select how much of that virtual space you would like to 
+	  devoted to userspace, and how much to the kernel.
+
+	  Some userspace programs would like to address as much as possible and 
+	  have few demands of the kernel other than it get out of the way.  These
+	  users may opt to use the 3.5GB option to give their userspace program 
+	  as much room as possible.  Due to alignment issues imposed by PAE, 
+	  the "3.5GB" option is unavailable if "64GB" high memory support is 
+	  enabled.
+
+	  Other users (especially those who use PAE) may be running out of
+	  ZONE_NORMAL memory.  Those users may benefit from increasing the
+	  kernel's virtual address space size by taking it away from userspace, 
+	  which may not need all of its space.  An indicator that this is 
+	  happening is when /proc/Meminfo's "LowFree:" is a small percentage of
+	  "LowTotal:" while "HighFree:" is very large.
+
+	  If unsure, say "3GB"
+	prompt "User address space size"
+        default 1GB
+	
+config	05GB
+	bool "3.5 GB"
+	depends on !HIGHMEM64G
+	
+config	1GB
+	bool "3 GB"
+	
+config	2GB
+	bool "2 GB"
+	
+config	3GB
+	bool "1 GB"
+endchoice
+
 config HIGHMEM
 	bool
 	depends on HIGHMEM64G || HIGHMEM4G
diff -urpN -X /home/fletch/.diff.exclude 101-config_hz/arch/i386/Makefile 102-config_page_offset/arch/i386/Makefile
--- 101-config_hz/arch/i386/Makefile	Tue Apr  8 14:38:14 2003
+++ 102-config_page_offset/arch/i386/Makefile	Thu Apr 24 21:37:27 2003
@@ -89,6 +89,7 @@ drivers-$(CONFIG_OPROFILE)		+= arch/i386
 
 CFLAGS += $(mflags-y)
 AFLAGS += $(mflags-y)
+AFLAGS_vmlinux.lds.o += -imacros $(TOPDIR)/include/asm-i386/page.h
 
 boot := arch/i386/boot
 
diff -urpN -X /home/fletch/.diff.exclude 101-config_hz/arch/i386/vmlinux.lds.S 102-config_page_offset/arch/i386/vmlinux.lds.S
--- 101-config_hz/arch/i386/vmlinux.lds.S	Sun Apr 20 19:34:57 2003
+++ 102-config_page_offset/arch/i386/vmlinux.lds.S	Thu Apr 24 21:37:27 2003
@@ -10,7 +10,7 @@ ENTRY(startup_32)
 jiffies = jiffies_64;
 SECTIONS
 {
-  . = 0xC0000000 + 0x100000;
+  . = __PAGE_OFFSET + 0x100000;
   /* read-only */
   _text = .;			/* Text and read-only data */
   .text : {
diff -urpN -X /home/fletch/.diff.exclude 101-config_hz/include/asm-i386/page.h 102-config_page_offset/include/asm-i386/page.h
--- 101-config_hz/include/asm-i386/page.h	Tue Apr  8 14:38:20 2003
+++ 102-config_page_offset/include/asm-i386/page.h	Thu Apr 24 21:37:27 2003
@@ -115,9 +115,26 @@ static __inline__ int get_order(unsigned
 #endif /* __ASSEMBLY__ */
 
 #ifdef __ASSEMBLY__
-#define __PAGE_OFFSET		(0xC0000000)
+#include <linux/config.h>
+#ifdef CONFIG_05GB
+#define __PAGE_OFFSET          (0xE0000000)
+#elif defined(CONFIG_1GB)
+#define __PAGE_OFFSET          (0xC0000000)
+#elif defined(CONFIG_2GB)
+#define __PAGE_OFFSET          (0x80000000)
+#elif defined(CONFIG_3GB)
+#define __PAGE_OFFSET          (0x40000000)
+#endif
 #else
-#define __PAGE_OFFSET		(0xC0000000UL)
+#ifdef CONFIG_05GB
+#define __PAGE_OFFSET          (0xE0000000UL)
+#elif defined(CONFIG_1GB)
+#define __PAGE_OFFSET          (0xC0000000UL)
+#elif defined(CONFIG_2GB)
+#define __PAGE_OFFSET          (0x80000000UL)
+#elif defined(CONFIG_3GB)
+#define __PAGE_OFFSET          (0x40000000UL)
+#endif
 #endif
 
 
diff -urpN -X /home/fletch/.diff.exclude 101-config_hz/include/asm-i386/processor.h 102-config_page_offset/include/asm-i386/processor.h
--- 101-config_hz/include/asm-i386/processor.h	Sun Apr 20 19:35:05 2003
+++ 102-config_page_offset/include/asm-i386/processor.h	Thu Apr 24 21:37:27 2003
@@ -287,7 +287,11 @@ extern unsigned int mca_pentium_flag;
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
+#ifdef CONFIG_05GB
+#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 16))
+#else
 #define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 3))
+#endif
 
 /*
  * Size of io_bitmap in longwords: 32 is ports 0-0x3ff.
diff -urpN -X /home/fletch/.diff.exclude 101-config_hz/mm/memory.c 102-config_page_offset/mm/memory.c
--- 101-config_hz/mm/memory.c	Sun Apr 20 19:35:08 2003
+++ 102-config_page_offset/mm/memory.c	Thu Apr 24 21:37:27 2003
@@ -101,8 +101,7 @@ static inline void free_one_pmd(struct m
 
 static inline void free_one_pgd(struct mmu_gather *tlb, pgd_t * dir)
 {
-	int j;
-	pmd_t * pmd;
+	pmd_t * pmd, * md, * emd;
 
 	if (pgd_none(*dir))
 		return;
@@ -113,8 +112,21 @@ static inline void free_one_pgd(struct m
 	}
 	pmd = pmd_offset(dir, 0);
 	pgd_clear(dir);
-	for (j = 0; j < PTRS_PER_PMD ; j++)
-		free_one_pmd(tlb, pmd+j);
+	/*
+	 * Beware if changing the loop below.  It once used int j,
+	 * 	for (j = 0; j < PTRS_PER_PMD; j++)
+	 * 		free_one_pmd(pmd+j);
+	 * but some older i386 compilers (e.g. egcs-2.91.66, gcc-2.95.3)
+	 * terminated the loop with a _signed_ address comparison
+	 * using "jle", when configured for HIGHMEM64GB (X86_PAE).
+	 * If also configured for 3GB of kernel virtual address space,
+	 * if page at physical 0x3ffff000 virtual 0x7ffff000 is used as
+	 * a pmd, when that mm exits the loop goes on to free "entries"
+	 * found at 0x80000000 onwards.  The loop below compiles instead
+	 * to be terminated by unsigned address comparison using "jb".
+	 */
+	for (md = pmd, emd = pmd + PTRS_PER_PMD; md < emd; md++)
+		free_one_pmd(tlb,md);
 	pmd_free_tlb(tlb, pmd);
 }
 

--==========1848459384==========
Content-Type: text/plain; charset=us-ascii; name=540-separate_pmd
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=540-separate_pmd; size=3823

diff -urpN -X /home/fletch/.diff.exclude 520-queuestat/arch/i386/mm/init.c 540-separate_pmd/arch/i386/mm/init.c
--- 520-queuestat/arch/i386/mm/init.c	Thu Apr 24 21:38:20 2003
+++ 540-separate_pmd/arch/i386/mm/init.c	Thu Apr 24 21:39:37 2003
@@ -514,9 +514,11 @@ void __init mem_init(void)
 #include <linux/slab.h>
 
 kmem_cache_t *pmd_cache;
+kmem_cache_t *kernel_pmd_cache;
 kmem_cache_t *pgd_cache;
 
 void pmd_ctor(void *, kmem_cache_t *, unsigned long);
+void kernel_pmd_ctor(void *, kmem_cache_t *, unsigned long);
 void pgd_ctor(void *, kmem_cache_t *, unsigned long);
 
 void __init pgtable_cache_init(void)
@@ -528,9 +530,18 @@ void __init pgtable_cache_init(void)
 						SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN,
 						pmd_ctor,
 						NULL);
-
 		if (!pmd_cache)
 			panic("pgtable_cache_init(): cannot create pmd cache");
+
+		kernel_pmd_cache = kmem_cache_create("pae_kernel_pmd",
+						(PTRS_PER_PMD*sizeof(pmd_t))*KERNEL_PGD_PTRS,
+						0,
+						SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN,
+						kernel_pmd_ctor,
+						NULL);
+
+		if (!kernel_pmd_cache)
+			panic("pgtable_cache_init(): cannot create kernel pmd cache");
 	}
 
         /*
diff -urpN -X /home/fletch/.diff.exclude 520-queuestat/arch/i386/mm/pgtable.c 540-separate_pmd/arch/i386/mm/pgtable.c
--- 520-queuestat/arch/i386/mm/pgtable.c	Mon Mar 17 21:43:39 2003
+++ 540-separate_pmd/arch/i386/mm/pgtable.c	Thu Apr 24 21:39:37 2003
@@ -136,7 +136,7 @@ pte_t *pte_alloc_one_kernel(struct mm_st
    
    	do {
 		pte = (pte_t *) __get_free_page(GFP_KERNEL);
-		if (pte)
+		if (pte) 
 			clear_page(pte);
 		else {
 			current->state = TASK_UNINTERRUPTIBLE;
@@ -168,6 +168,7 @@ struct page *pte_alloc_one(struct mm_str
 }
 
 extern kmem_cache_t *pmd_cache;
+extern kmem_cache_t *kernel_pmd_cache;
 extern kmem_cache_t *pgd_cache;
 
 void pmd_ctor(void *__pmd, kmem_cache_t *pmd_cache, unsigned long flags)
@@ -175,6 +176,15 @@ void pmd_ctor(void *__pmd, kmem_cache_t 
 	clear_page(__pmd);
 }
 
+void kernel_pmd_ctor(void *__pmd, kmem_cache_t *kernel_pmd_cache, unsigned long flags)
+{
+	int i;
+	for (i=USER_PTRS_PER_PGD; i<PTRS_PER_PGD; i++) {
+		pmd_t *kern_pmd = (pmd_t *)pgd_page(swapper_pg_dir[i]);
+		memcpy(__pmd+PAGE_SIZE*(i-USER_PTRS_PER_PGD), kern_pmd, PAGE_SIZE);
+	}
+}
+
 void pgd_ctor(void *__pgd, kmem_cache_t *pgd_cache, unsigned long flags)
 {
 	pgd_t *pgd = __pgd;
@@ -190,14 +200,20 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	int i;
 	pgd_t *pgd = kmem_cache_alloc(pgd_cache, SLAB_KERNEL);
+	kmem_cache_t *pmd_cachep = pmd_cache;
 
 	if (PTRS_PER_PMD == 1)
 		return pgd;
 	else if (!pgd)
 		return NULL;
 
-	for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
-		pmd_t *pmd = kmem_cache_alloc(pmd_cache, SLAB_KERNEL);
+	for (i = 0; i < PTRS_PER_PGD; ++i) {
+		pmd_t *pmd;
+		
+		if (i >= USER_PTRS_PER_PGD) 
+			pmd_cachep = kernel_pmd_cache;
+			
+		pmd = kmem_cache_alloc(pmd_cachep, SLAB_KERNEL);
 		if (!pmd)
 			goto out_oom;
 		set_pgd(pgd + i, __pgd(1 + __pa((unsigned long long)((unsigned long)pmd))));
@@ -205,8 +221,10 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	return pgd;
 
 out_oom:
-	for (i--; i >= 0; --i)
-		kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+	for (i--; i >= 0; --i) {
+		pmd_t *pmd = pmd_offset(&pgd[i],0);
+		kmem_cache_free(pmd_cachep, pmd);
+	}
 	kmem_cache_free(pgd_cache, (void *)pgd);
 	return NULL;
 }
@@ -216,8 +234,14 @@ void pgd_free(pgd_t *pgd)
 	int i;
 
 	if (PTRS_PER_PMD > 1) {
-		for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
-			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+		for (i = 0; i < PTRS_PER_PGD; i++) {
+			pmd_t *pmd_to_free = pmd_offset(&pgd[i],0);
+			
+			if( i >= USER_PTRS_PER_PGD )
+				kmem_cache_free(kernel_pmd_cache, pmd_to_free);
+			else 
+				kmem_cache_free(pmd_cache, pmd_to_free);
+
 			set_pgd(pgd + i, __pgd(0));
 		}
 	}

--==========1848459384==========
Content-Type: text/plain; charset=us-ascii; name=650-banana_split
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=650-banana_split; size=18867

diff -urpN -X /home/fletch/.diff.exclude 640-per_node_idt/arch/i386/Kconfig 650-banana_split/arch/i386/Kconfig
--- 640-per_node_idt/arch/i386/Kconfig	Thu Apr 24 21:39:38 2003
+++ 650-banana_split/arch/i386/Kconfig	Thu Apr 24 21:41:25 2003
@@ -687,7 +687,6 @@ choice
 	
 config	05GB
 	bool "3.5 GB"
-	depends on !HIGHMEM64G
 	
 config	1GB
 	bool "3 GB"
diff -urpN -X /home/fletch/.diff.exclude 640-per_node_idt/arch/i386/mm/init.c 650-banana_split/arch/i386/mm/init.c
--- 640-per_node_idt/arch/i386/mm/init.c	Thu Apr 24 21:39:37 2003
+++ 650-banana_split/arch/i386/mm/init.c	Thu Apr 24 21:41:25 2003
@@ -123,6 +123,24 @@ static void __init page_table_range_init
 	}
 }
 
+
+/*
+ * Abstract out using large pages when mapping KVA, or the SMP identity
+ * mapping
+ */
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
 /*
  * This maps the physical memory to kernel virtual address space, a total 
  * of max_low_pfn pages, by creating page tables starting from address 
@@ -133,8 +151,7 @@ static void __init kernel_physical_mappi
 	unsigned long pfn;
 	pgd_t *pgd;
 	pmd_t *pmd;
-	pte_t *pte;
-	int pgd_idx, pmd_idx, pte_ofs;
+	int pgd_idx, pmd_idx;
 
 	pgd_idx = pgd_index(PAGE_OFFSET);
 	pgd = pgd_base + pgd_idx;
@@ -144,21 +161,48 @@ static void __init kernel_physical_mappi
 		pmd = one_md_table_init(pgd);
 		if (pfn >= max_low_pfn)
 			continue;
-		for (pmd_idx = 0; pmd_idx < PTRS_PER_PMD && pfn < max_low_pfn; pmd++, pmd_idx++) {
-			/* Map with big pages if possible, otherwise create normal page tables. */
-			if (cpu_has_pse) {
-				set_pmd(pmd, pfn_pmd(pfn, PAGE_KERNEL_LARGE));
-				pfn += PTRS_PER_PTE;
-			} else {
-				pte = one_page_table_init(pmd);
-
-				for (pte_ofs = 0; pte_ofs < PTRS_PER_PTE && pfn < max_low_pfn; pte++, pfn++, pte_ofs++)
-					set_pte(pte, pfn_pte(pfn, PAGE_KERNEL));
-			}
+	
+		/* beware of starting KVA in the middle of a pmd. */
+		if( pgd_idx == pgd_index(PAGE_OFFSET) ) {
+			pmd_idx = pmd_index(PAGE_OFFSET);
+			pmd = &pmd[pmd_idx];
+		} else
+			pmd_idx = 0;
+
+		for (; pmd_idx < PTRS_PER_PMD && pfn < max_low_pfn; pmd++, pmd_idx++) {
+			pmd_map_pfn_range(pmd, pfn, max_low_pfn);
+			pfn += PTRS_PER_PTE; 
 		}
 	}	
 }
 
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
+		printk("PAE enabled, but no support for PSE (large pages)!\n");
+		printk("this is likely to waste some RAM.");
+	}
+	
+	for (; pmd_ofs < PTRS_PER_PMD && pfn <= max_low_pfn; pmd++, pmd_ofs++) { 
+		pmd_map_pfn_range(pmd, pfn, max_low_pfn);
+		pfn += PTRS_PER_PTE;
+	}		
+#endif
+}
+
+
 static inline int page_kills_ppro(unsigned long pagenr)
 {
 	if (pagenr >= 0x70000 && pagenr <= 0x7003F)
@@ -225,7 +269,7 @@ void __init permanent_kmaps_init(pgd_t *
 	pgd = swapper_pg_dir + pgd_index(vaddr);
 	pmd = pmd_offset(pgd, vaddr);
 	pte = pte_offset_kernel(pmd, vaddr);
-	pkmap_page_table = pte;	
+	pkmap_page_table = pte;
 }
 
 void __init one_highpage_init(struct page *page, int pfn, int bad_ppro)
@@ -290,6 +334,7 @@ static void __init pagetable_init (void)
 	}
 
 	kernel_physical_mapping_init(pgd_base);
+	low_physical_mapping_init(pgd_base);
 	remap_numa_kva();
 
 	/*
@@ -298,19 +343,7 @@ static void __init pagetable_init (void)
 	 */
 	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
 	page_table_range_init(vaddr, 0, pgd_base);
-
 	permanent_kmaps_init(pgd_base);
-
-#if CONFIG_X86_PAE
-	/*
-	 * Add low memory identity-mappings - SMP needs it when
-	 * starting up on an AP from real-mode. In the non-PAE
-	 * case we already have these mappings through head.S.
-	 * All user-space mappings are explicitly cleared after
-	 * SMP startup.
-	 */
-	pgd_base[0] = pgd_base[USER_PTRS_PER_PGD];
-#endif
 }
 
 void zap_low_mappings (void)
@@ -322,7 +355,7 @@ void zap_low_mappings (void)
 	 * Note that "pgd_clear()" doesn't do it for
 	 * us, because pgd_clear() is a no-op on i386.
 	 */
-	for (i = 0; i < USER_PTRS_PER_PGD; i++)
+	for (i = 0; i < __USER_PTRS_PER_PGD; i++)
 #if CONFIG_X86_PAE
 		set_pgd(swapper_pg_dir+i, __pgd(1 + __pa(empty_zero_page)));
 #else
diff -urpN -X /home/fletch/.diff.exclude 640-per_node_idt/arch/i386/mm/pgtable.c 650-banana_split/arch/i386/mm/pgtable.c
--- 640-per_node_idt/arch/i386/mm/pgtable.c	Thu Apr 24 21:39:37 2003
+++ 650-banana_split/arch/i386/mm/pgtable.c	Thu Apr 24 21:41:25 2003
@@ -178,10 +178,22 @@ void pmd_ctor(void *__pmd, kmem_cache_t 
 
 void kernel_pmd_ctor(void *__pmd, kmem_cache_t *kernel_pmd_cache, unsigned long flags)
 {
+	pmd_t *pmd = __pmd;
 	int i;
-	for (i=USER_PTRS_PER_PGD; i<PTRS_PER_PGD; i++) {
+	
+	/* you only need to memset the portion which isn't used by
+	 * the kernel
+	 */
+	clear_page(__pmd);
+	
+	for (i=FIRST_KERNEL_PGD_PTR; i<PTRS_PER_PGD; i++, pmd+=PTRS_PER_PMD) {
 		pmd_t *kern_pmd = (pmd_t *)pgd_page(swapper_pg_dir[i]);
-		memcpy(__pmd+PAGE_SIZE*(i-USER_PTRS_PER_PGD), kern_pmd, PAGE_SIZE);
+		int start_index = USER_PTRS_PER_PMD(i);
+		pmd_t *dst_pmd = &pmd[start_index];
+		pmd_t *src_pmd = &kern_pmd[start_index];
+		int num_pmds = PTRS_PER_PMD-USER_PTRS_PER_PMD(i);
+		
+		memcpy(dst_pmd, src_pmd, num_pmds*sizeof(pmd_t));
 	}
 }
 
@@ -200,30 +212,42 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	int i;
 	pgd_t *pgd = kmem_cache_alloc(pgd_cache, SLAB_KERNEL);
-	kmem_cache_t *pmd_cachep = pmd_cache;
+	pmd_t *kern_pmd_pages;
 
 	if (PTRS_PER_PMD == 1)
 		return pgd;
 	else if (!pgd)
 		return NULL;
 
-	for (i = 0; i < PTRS_PER_PGD; ++i) {
+	for (i = 0; i < FIRST_KERNEL_PGD_PTR; ++i) {
 		pmd_t *pmd;
-		
-		if (i >= USER_PTRS_PER_PGD) 
-			pmd_cachep = kernel_pmd_cache;
-			
-		pmd = kmem_cache_alloc(pmd_cachep, SLAB_KERNEL);
+	
+		pmd = kmem_cache_alloc(pmd_cache, SLAB_KERNEL);
 		if (!pmd)
 			goto out_oom;
 		set_pgd(pgd + i, __pgd(1 + __pa((unsigned long long)((unsigned long)pmd))));
 	}
+	
+	/*
+	 * The kernel pages are allocated in one big chunk, instead of having
+	 * a different slab for each one. 
+	 */
+	kern_pmd_pages = kmem_cache_alloc(kernel_pmd_cache, SLAB_KERNEL);
+	if (!kern_pmd_pages)
+		goto out_oom;
+	
+	for (i = FIRST_KERNEL_PGD_PTR; i < PTRS_PER_PGD; ++i) {
+		set_pgd(pgd + i, __pgd(1 + __pa((unsigned long long)((unsigned long)kern_pmd_pages))));
+		/* kern_pmd_pages += PAGE_SIZE, effectively */
+		kern_pmd_pages = &kern_pmd_pages[PTRS_PER_PMD];
+	}
+	
 	return pgd;
 
 out_oom:
 	for (i--; i >= 0; --i) {
 		pmd_t *pmd = pmd_offset(&pgd[i],0);
-		kmem_cache_free(pmd_cachep, pmd);
+		kmem_cache_free(pmd_cache, pmd);
 	}
 	kmem_cache_free(pgd_cache, (void *)pgd);
 	return NULL;
@@ -232,19 +256,24 @@ out_oom:
 void pgd_free(pgd_t *pgd)
 {
 	int i;
-
+	pmd_t *pmd_to_free;
+		
 	if (PTRS_PER_PMD > 1) {
-		for (i = 0; i < PTRS_PER_PGD; i++) {
-			pmd_t *pmd_to_free = pmd_offset(&pgd[i],0);
-			
-			if( i >= USER_PTRS_PER_PGD )
-				kmem_cache_free(kernel_pmd_cache, pmd_to_free);
-			else 
-				kmem_cache_free(pmd_cache, pmd_to_free);
-
+		for (i = 0; i < FIRST_KERNEL_PGD_PTR; i++) {
+			pmd_to_free = pmd_offset(&pgd[i],0);
+			kmem_cache_free(pmd_cache, pmd_to_free);
 			set_pgd(pgd + i, __pgd(0));
 		}
+		
+		/*
+		 * All of the kernel pmd pages are allocated from a single
+		 * slab, as a unit.  They must only be freed once
+		 */
+		pmd_to_free = pmd_offset(&pgd[FIRST_KERNEL_PGD_PTR],0);
+		kmem_cache_free(kernel_pmd_cache, pmd_to_free);
+		for (i = FIRST_KERNEL_PGD_PTR; i < PTRS_PER_PGD; i++)
+			set_pgd(&pgd[i], __pgd(0));
 	}
-
+	
 	kmem_cache_free(pgd_cache, (void *)pgd);
 }
diff -urpN -X /home/fletch/.diff.exclude 640-per_node_idt/include/asm-alpha/pgtable.h 650-banana_split/include/asm-alpha/pgtable.h
--- 640-per_node_idt/include/asm-alpha/pgtable.h	Tue Apr  8 14:38:20 2003
+++ 650-banana_split/include/asm-alpha/pgtable.h	Thu Apr 24 21:41:25 2003
@@ -39,6 +39,7 @@
 #define PTRS_PER_PMD	(1UL << (PAGE_SHIFT-3))
 #define PTRS_PER_PGD	(1UL << (PAGE_SHIFT-3))
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 /* Number of pointers that fit on a page:  this will go away. */
diff -urpN -X /home/fletch/.diff.exclude 640-per_node_idt/include/asm-arm/pgtable.h 650-banana_split/include/asm-arm/pgtable.h
--- 640-per_node_idt/include/asm-arm/pgtable.h	Mon Mar 17 21:43:48 2003
+++ 650-banana_split/include/asm-arm/pgtable.h	Thu Apr 24 21:41:25 2003
@@ -45,6 +45,7 @@ extern void __pgd_error(const char *file
 
 #define FIRST_USER_PGD_NR	1
 #define USER_PTRS_PER_PGD	((TASK_SIZE/PGDIR_SIZE) - FIRST_USER_PGD_NR)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 
 /*
  * The table below defines the page protection levels that we insert into our
diff -urpN -X /home/fletch/.diff.exclude 640-per_node_idt/include/asm-cris/pgtable.h 650-banana_split/include/asm-cris/pgtable.h
--- 640-per_node_idt/include/asm-cris/pgtable.h	Sun Apr 20 19:35:05 2003
+++ 650-banana_split/include/asm-cris/pgtable.h	Thu Apr 24 21:41:25 2003
@@ -202,6 +202,7 @@ static inline void flush_tlb(void) 
  */
 
 #define USER_PTRS_PER_PGD       (TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR       0
 
 /*
diff -urpN -X /home/fletch/.diff.exclude 640-per_node_idt/include/asm-i386/pgtable.h 650-banana_split/include/asm-i386/pgtable.h
--- 640-per_node_idt/include/asm-i386/pgtable.h	Thu Apr 24 21:38:42 2003
+++ 650-banana_split/include/asm-i386/pgtable.h	Thu Apr 24 21:41:25 2003
@@ -55,7 +55,22 @@ void pgtable_cache_init(void);
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
-#define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define __USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define FIRST_KERNEL_PGD_PTR	(__USER_PTRS_PER_PGD)
+#define PARTIAL_PGD	(TASK_SIZE > __USER_PTRS_PER_PGD*PGDIR_SIZE ? 1 : 0)
+#define PARTIAL_PMD	((TASK_SIZE % PGDIR_SIZE)/PMD_SIZE)
+#define USER_PTRS_PER_PGD	(PARTIAL_PGD + __USER_PTRS_PER_PGD)
+#ifndef __ASSEMBLY__
+static inline int USER_PTRS_PER_PMD(int pgd_index) {
+	if (pgd_index < __USER_PTRS_PER_PGD)
+		return PTRS_PER_PMD;
+	else if (PARTIAL_PMD && (pgd_index == __USER_PTRS_PER_PGD))
+		return (PTRS_PER_PMD-PARTIAL_PMD);
+	else
+		return 0;
+}
+#endif
+
 #define FIRST_USER_PGD_NR	0
 
 #define USER_PGD_PTRS (PAGE_OFFSET >> PGDIR_SHIFT)
diff -urpN -X /home/fletch/.diff.exclude 640-per_node_idt/include/asm-ia64/pgtable.h 650-banana_split/include/asm-ia64/pgtable.h
--- 640-per_node_idt/include/asm-ia64/pgtable.h	Sun Apr 20 19:35:05 2003
+++ 650-banana_split/include/asm-ia64/pgtable.h	Thu Apr 24 21:41:25 2003
@@ -90,6 +90,7 @@
 #define PGDIR_MASK		(~(PGDIR_SIZE-1))
 #define PTRS_PER_PGD		(__IA64_UL(1) << (PAGE_SHIFT-3))
 #define USER_PTRS_PER_PGD	(5*PTRS_PER_PGD/8)	/* regions 0-4 are user regions */
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 /*
diff -urpN -X /home/fletch/.diff.exclude 640-per_node_idt/include/asm-m68k/pgtable.h 650-banana_split/include/asm-m68k/pgtable.h
--- 640-per_node_idt/include/asm-m68k/pgtable.h	Sun Nov 17 20:29:53 2002
+++ 650-banana_split/include/asm-m68k/pgtable.h	Thu Apr 24 21:41:25 2003
@@ -58,6 +58,7 @@
 #define PTRS_PER_PGD	128
 #endif
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 /* Virtual address region for use by kernel_map() */
diff -urpN -X /home/fletch/.diff.exclude 640-per_node_idt/include/asm-mips/pgtable.h 650-banana_split/include/asm-mips/pgtable.h
--- 640-per_node_idt/include/asm-mips/pgtable.h	Sun Apr 20 19:35:05 2003
+++ 650-banana_split/include/asm-mips/pgtable.h	Thu Apr 24 21:41:25 2003
@@ -95,6 +95,7 @@ extern int add_temporary_entry(unsigned 
 #define PTRS_PER_PMD	1
 #define PTRS_PER_PGD	1024
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define VMALLOC_START     KSEG2
diff -urpN -X /home/fletch/.diff.exclude 640-per_node_idt/include/asm-mips64/pgtable.h 650-banana_split/include/asm-mips64/pgtable.h
--- 640-per_node_idt/include/asm-mips64/pgtable.h	Thu Apr 24 21:39:07 2003
+++ 650-banana_split/include/asm-mips64/pgtable.h	Thu Apr 24 21:41:25 2003
@@ -124,6 +124,7 @@ extern void (*_flush_cache_l1)(void);
 #define PTRS_PER_PMD	1024
 #define PTRS_PER_PTE	512
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define KPTBL_PAGE_ORDER  2
diff -urpN -X /home/fletch/.diff.exclude 640-per_node_idt/include/asm-parisc/pgtable.h 650-banana_split/include/asm-parisc/pgtable.h
--- 640-per_node_idt/include/asm-parisc/pgtable.h	Mon Mar 17 21:43:49 2003
+++ 650-banana_split/include/asm-parisc/pgtable.h	Thu Apr 24 21:41:25 2003
@@ -81,6 +81,7 @@
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 #define PTRS_PER_PGD    (1UL << (PAGE_SHIFT - PT_NLEVELS))
 #define USER_PTRS_PER_PGD       PTRS_PER_PGD
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 
 /* Definitions for 2nd level */
 #define pgtable_cache_init()	do { } while (0)
diff -urpN -X /home/fletch/.diff.exclude 640-per_node_idt/include/asm-ppc/pgtable.h 650-banana_split/include/asm-ppc/pgtable.h
--- 640-per_node_idt/include/asm-ppc/pgtable.h	Tue Apr  8 14:38:20 2003
+++ 650-banana_split/include/asm-ppc/pgtable.h	Thu Apr 24 21:41:25 2003
@@ -83,6 +83,7 @@ extern unsigned long ioremap_bot, iorema
 #define PTRS_PER_PMD	1
 #define PTRS_PER_PGD	1024
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define USER_PGD_PTRS (PAGE_OFFSET >> PGDIR_SHIFT)
diff -urpN -X /home/fletch/.diff.exclude 640-per_node_idt/include/asm-ppc64/pgtable.h 650-banana_split/include/asm-ppc64/pgtable.h
--- 640-per_node_idt/include/asm-ppc64/pgtable.h	Wed Mar 26 22:54:37 2003
+++ 650-banana_split/include/asm-ppc64/pgtable.h	Thu Apr 24 21:41:25 2003
@@ -36,6 +36,7 @@
 #define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
 
 #define USER_PTRS_PER_PGD	(1024)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define EADDR_SIZE (PTE_INDEX_SIZE + PMD_INDEX_SIZE + \
diff -urpN -X /home/fletch/.diff.exclude 640-per_node_idt/include/asm-sh/pgtable.h 650-banana_split/include/asm-sh/pgtable.h
--- 640-per_node_idt/include/asm-sh/pgtable.h	Sun Apr 20 19:35:06 2003
+++ 650-banana_split/include/asm-sh/pgtable.h	Thu Apr 24 21:41:25 2003
@@ -101,6 +101,7 @@ extern unsigned long empty_zero_page[102
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define PTE_PHYS_MASK	0x1ffff000
diff -urpN -X /home/fletch/.diff.exclude 640-per_node_idt/include/asm-sparc/pgtable.h 650-banana_split/include/asm-sparc/pgtable.h
--- 640-per_node_idt/include/asm-sparc/pgtable.h	Sun Apr 20 19:35:07 2003
+++ 650-banana_split/include/asm-sparc/pgtable.h	Thu Apr 24 21:41:25 2003
@@ -109,6 +109,7 @@ BTFIXUPDEF_INT(page_kernel)
 #define PTRS_PER_PMD    	BTFIXUP_SIMM13(ptrs_per_pmd)
 #define PTRS_PER_PGD    	BTFIXUP_SIMM13(ptrs_per_pgd)
 #define USER_PTRS_PER_PGD	BTFIXUP_SIMM13(user_ptrs_per_pgd)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define PAGE_NONE      __pgprot(BTFIXUP_INT(page_none))
diff -urpN -X /home/fletch/.diff.exclude 640-per_node_idt/include/asm-sparc64/pgtable.h 650-banana_split/include/asm-sparc64/pgtable.h
--- 640-per_node_idt/include/asm-sparc64/pgtable.h	Wed Mar 26 22:54:37 2003
+++ 650-banana_split/include/asm-sparc64/pgtable.h	Thu Apr 24 21:41:25 2003
@@ -93,6 +93,7 @@
 /* Kernel has a separate 44bit address space. */
 #define USER_PTRS_PER_PGD	((const int)(test_thread_flag(TIF_32BIT)) ? \
 				 (1) : (PTRS_PER_PGD))
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define pte_ERROR(e)	__builtin_trap()
diff -urpN -X /home/fletch/.diff.exclude 640-per_node_idt/include/asm-um/pgtable.h 650-banana_split/include/asm-um/pgtable.h
--- 640-per_node_idt/include/asm-um/pgtable.h	Mon Mar 17 21:43:49 2003
+++ 650-banana_split/include/asm-um/pgtable.h	Thu Apr 24 21:41:25 2003
@@ -40,6 +40,7 @@ extern unsigned long *empty_zero_page;
 #define PTRS_PER_PMD	1
 #define PTRS_PER_PGD	1024
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR       0
 
 #define pte_ERROR(e) \
diff -urpN -X /home/fletch/.diff.exclude 640-per_node_idt/include/asm-x86_64/pgtable.h 650-banana_split/include/asm-x86_64/pgtable.h
--- 640-per_node_idt/include/asm-x86_64/pgtable.h	Tue Apr  8 14:38:21 2003
+++ 650-banana_split/include/asm-x86_64/pgtable.h	Thu Apr 24 21:41:26 2003
@@ -111,6 +111,7 @@ static inline void set_pml4(pml4_t *dst,
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define USER_PGD_PTRS (PAGE_OFFSET >> PGDIR_SHIFT)
diff -urpN -X /home/fletch/.diff.exclude 640-per_node_idt/mm/memory.c 650-banana_split/mm/memory.c
--- 640-per_node_idt/mm/memory.c	Thu Apr 24 21:37:39 2003
+++ 650-banana_split/mm/memory.c	Thu Apr 24 21:41:26 2003
@@ -99,9 +99,10 @@ static inline void free_one_pmd(struct m
 	pte_free_tlb(tlb, page);
 }
 
-static inline void free_one_pgd(struct mmu_gather *tlb, pgd_t * dir)
+static inline void free_one_pgd(struct mmu_gather *tlb, pgd_t * pgd, unsigned long pgdi)
 {
 	pmd_t * pmd, * md, * emd;
+	pgd_t *dir = pgd + pgdi;
 
 	if (pgd_none(*dir))
 		return;
@@ -125,7 +126,7 @@ static inline void free_one_pgd(struct m
 	 * found at 0x80000000 onwards.  The loop below compiles instead
 	 * to be terminated by unsigned address comparison using "jb".
 	 */
-	for (md = pmd, emd = pmd + PTRS_PER_PMD; md < emd; md++)
+	for (md = pmd, emd = pmd + USER_PTRS_PER_PMD(pgdi); md < emd; md++)
 		free_one_pmd(tlb,md);
 	pmd_free_tlb(tlb, pmd);
 }
@@ -139,11 +140,11 @@ static inline void free_one_pgd(struct m
 void clear_page_tables(struct mmu_gather *tlb, unsigned long first, int nr)
 {
 	pgd_t * page_dir = tlb->mm->pgd;
-
-	page_dir += first;
+	int index = first;
+	
 	do {
-		free_one_pgd(tlb, page_dir);
-		page_dir++;
+		free_one_pgd(tlb, page_dir, index);
+		index++;
 	} while (--nr);
 }
 

--==========1848459384==========--

