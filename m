Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSFNSFr>; Fri, 14 Jun 2002 14:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSFNSFq>; Fri, 14 Jun 2002 14:05:46 -0400
Received: from ns.suse.de ([213.95.15.193]:34321 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S312962AbSFNSFm>;
	Fri, 14 Jun 2002 14:05:42 -0400
Date: Fri, 14 Jun 2002 20:05:37 +0200
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andi Kleen <ak@suse.de>, Benjamin LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org,
        Richard Brunner <richard.brunner@amd.com>, mark.langsdorf@amd.com
Subject: Re: another new version of pageattr caching conflict fix for 2.4
Message-ID: <20020614200537.A5418@wotan.suse.de>
In-Reply-To: <20020613221533.A2544@wotan.suse.de> <20020613210339.B21542@redhat.com> <20020614032429.A19018@wotan.suse.de> <20020613213724.C21542@redhat.com> <20020614040025.GA2093@inspiron.birch.net> <20020614001726.D21542@redhat.com> <20020614062754.A11232@wotan.suse.de> <20020614112849.A22888@redhat.com> <20020614181328.A18643@wotan.suse.de> <20020614173133.GH2314@inspiron.paqnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 12:31:33PM -0500, Andrea Arcangeli wrote:
> On Fri, Jun 14, 2002 at 06:13:28PM +0200, Andi Kleen wrote:
> > +#ifdef CONFIG_HIGHMEM
> > +	/* Hopefully not be mapped anywhere else. */
> > +	if (page >= highmem_start_page) 
> > +		return 0;
> > +#endif
> 
> there's no hope here. If you don't want to code it right because nobody
> is exercising such path and flush both any per-cpu kmap-atomic slot and
> the page->virtual, please place a BUG() there or any more graceful
> failure notification.

Ok done. 

I also removed the DRM change because it was buggy. I'm not 100% yet
it is even a problem. Needs more investigation.

BTW there is another corner case that was overlooked:  
mmap of /dev/kmem, /proc/kcore, /dev/mem. To handle this correctly 
the mmap functions would need to always walk the kernel page table
and force the correct caching attribute in the user mapping.
But what to do when there is already an existing mapping to user space?


> > +int change_page_attr(struct page *page, int numpages, pgprot_t prot)
> > +{
> 
> this API not the best, again I would recommend something on these lines:

Hmm: i would really prefer to do the allocation in the caller.
If you want your API you could do  just do it as a simple wrapper to
the existing function (with the new numpages it would be even 
efficient) 

New version appended.
Also available at ftp://ftp.suse.com/pub/people/ak/v2.4/pageattr-2.4.19pre9-6

-Andi


diff -burpN -X ../KDIFX -x *-o -x *.[ch]-* linux-2.4.19pre9/arch/i386/mm/Makefile linux-2.4.19pre9-work/arch/i386/mm/Makefile
--- linux-2.4.19pre9/arch/i386/mm/Makefile	Fri Dec 29 23:07:20 2000
+++ linux-2.4.19pre9-work/arch/i386/mm/Makefile	Wed Jun  5 02:35:11 2002
@@ -9,6 +9,7 @@
 
 O_TARGET := mm.o
 
-obj-y	 := init.o fault.o ioremap.o extable.o
+obj-y	 := init.o fault.o ioremap.o extable.o pageattr.o
+export-objs := pageattr.o
 
 include $(TOPDIR)/Rules.make
diff -burpN -X ../KDIFX -x *-o -x *.[ch]-* linux-2.4.19pre9/arch/i386/mm/pageattr.c linux-2.4.19pre9-work/arch/i386/mm/pageattr.c
--- linux-2.4.19pre9/arch/i386/mm/pageattr.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.19pre9-work/arch/i386/mm/pageattr.c	Fri Jun 14 20:00:04 2002
@@ -0,0 +1,167 @@
+/* 
+ * Copyright 2002 Andi Kleen, SuSE Labs. 
+ * Thanks to Ben LaHaise for precious feedback.
+ */ 
+
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/highmem.h>
+#include <linux/module.h>
+#include <asm/uaccess.h>
+#include <asm/processor.h>
+
+/* Should move most of this stuff into the appropiate includes */
+#define PAGE_LARGE (_PAGE_PSE|_PAGE_PRESENT) 
+#define LARGE_PAGE_MASK (~(LARGE_PAGE_SIZE-1))
+#define LARGE_PAGE_SIZE (1UL << PMD_SHIFT)
+
+static inline pte_t *lookup_address(unsigned long address) 
+{ 
+	pmd_t *pmd;	
+	pgd_t *pgd = pgd_offset(&init_mm, address); 
+
+	if ((pgd_val(*pgd) & PAGE_LARGE) == PAGE_LARGE)
+		return (pte_t *)pgd; 
+	pmd = pmd_offset(pgd, address); 	       
+	if ((pmd_val(*pmd) & PAGE_LARGE) == PAGE_LARGE)
+		return (pte_t *)pmd; 
+
+        return pte_offset(pmd, address);
+} 
+
+static struct page *split_large_page(unsigned long address, pgprot_t prot)
+{ 
+	int i; 
+	unsigned long addr;
+	struct page *base = alloc_pages(GFP_KERNEL, 0);
+	pte_t *pbase;
+	if (!base) 
+		return NULL;
+	address = __pa(address);
+	addr = address & LARGE_PAGE_MASK; 
+	pbase = (pte_t *)page_address(base);
+	for (i = 0; i < PTRS_PER_PTE; i++, addr += PAGE_SIZE) {
+		pbase[i] = mk_pte_phys(addr, 
+				      addr == address ? prot : PAGE_KERNEL);
+	}
+	return base;
+} 
+
+static void flush_kernel_map(void * address) 
+{ 
+	/* Could use CLFLUSH here if the CPU supports it (Hammer,P4) */
+	if (boot_cpu_data.x86_model >= 4) 
+		asm volatile("wbinvd":::"memory"); 
+	__flush_tlb_all(); 	
+}
+
+static void set_pmd_pte(pte_t *kpte, unsigned long address, pte_t pte) 
+{ 
+	set_pte_atomic(kpte, pte); 	/* change init_mm */
+#ifndef CONFIG_X86_PAE
+	{
+		struct list_head *l;
+		spin_lock(&mmlist_lock);
+		list_for_each(l, &init_mm.mmlist) { 
+			struct mm_struct *mm = list_entry(l, struct mm_struct, mmlist);
+			pmd_t *pmd = pmd_offset(pgd_offset(mm, address), address);
+			set_pte_atomic((pte_t *)pmd, pte);
+		} 
+		spin_unlock(&mmlist_lock);
+	}
+#endif
+}
+
+/* no more special protections in this 2/4MB area - revert to a
+   large page again. */
+static inline void revert_page(struct page *kpte_page, unsigned long address)
+{
+	pte_t *linear = (pte_t *) 
+		pmd_offset(pgd_offset(&init_mm, address), address);
+	set_pmd_pte(linear,  address,
+		mk_pte_phys(__pa(address & LARGE_PAGE_MASK),
+			    __pgprot(_KERNPG_TABLE|_PAGE_PSE)));
+}	
+ 
+/*
+ * Change the page attributes of an page in the linear mapping.
+ *
+ * This should be used when a page is mapped with a different caching policy
+ * than write-back somewhere - some CPUs do not like it when mappings with
+ * different caching policies exist. This changes the page attributes of the
+ * in kernel linear mapping too.
+ * 
+ * The caller needs to ensure that there are no conflicting mappings elsewhere.
+ * This function only deals with the kernel linear map.
+ * When page is in highmem it must never be kmap'ed.
+ */
+static int 
+__change_page_attr(struct page *page, pgprot_t prot, struct page **oldpage) 
+{ 
+	pte_t *kpte; 
+	unsigned long address;
+	struct page *kpte_page;
+
+#ifdef CONFIG_HIGHMEM
+	if (page >= highmem_start_page) 
+		BUG(); 
+#endif
+	address = (unsigned long)page_address(page);
+
+	kpte = lookup_address(address);
+	kpte_page = virt_to_page(((unsigned long)kpte) & PAGE_MASK);
+	if (pgprot_val(prot) != pgprot_val(PAGE_KERNEL)) { 
+		if ((pte_val(*kpte) & _PAGE_PSE) == 0) { 
+			pte_t old = *kpte;
+			pte_t standard = mk_pte(page, PAGE_KERNEL); 
+
+			set_pte_atomic(kpte, mk_pte(page, prot)); 
+			if (pte_same(old,standard))
+				atomic_inc(&kpte_page->count);
+		} else {
+			struct page *split = split_large_page(address, prot); 
+			if (!split)
+				return -ENOMEM;
+			set_pmd_pte(kpte,address,mk_pte(split, PAGE_KERNEL));
+		}	
+	} else if ((pte_val(*kpte) & _PAGE_PSE) == 0) { 
+		set_pte_atomic(kpte, mk_pte(page, PAGE_KERNEL));
+		atomic_dec(&kpte_page->count); 
+	}
+
+	if (test_bit(X86_FEATURE_PSE, &boot_cpu_data.x86_capability) && 
+	    (atomic_read(&kpte_page->count) == 1)) { 
+		*oldpage = kpte_page;
+		revert_page(kpte_page, address);
+	} 
+	return 0;
+} 
+
+int change_page_attr(struct page *page, int numpages, pgprot_t prot)
+{
+	int err = 0; 
+	struct page *fpage; 
+	int i; 
+
+	down_write(&init_mm.mmap_sem);
+	for (i = 0; i < numpages; i++, page++) { 
+		fpage = NULL;
+		err = __change_page_attr(page, prot, &fpage); 
+		if (err) 
+			break; 
+		if (fpage || i == numpages-1) { 
+			void *address = page_address(page);
+#ifdef CONFIG_SMP 
+			smp_call_function(flush_kernel_map, address, 1, 1);
+#endif	
+			flush_kernel_map(address);
+			if (fpage)
+				__free_page(fpage);
+		} 
+	} 	
+	up_write(&init_mm.mmap_sem); 
+	return err;
+}
+
+EXPORT_SYMBOL(change_page_attr);
diff -burpN -X ../KDIFX -x *-o -x *.[ch]-* linux-2.4.19pre9/drivers/char/agp/agpgart_be.c linux-2.4.19pre9-work/drivers/char/agp/agpgart_be.c
--- linux-2.4.19pre9/drivers/char/agp/agpgart_be.c	Sun Jun  2 20:24:00 2002
+++ linux-2.4.19pre9-work/drivers/char/agp/agpgart_be.c	Fri Jun 14 17:37:46 2002
@@ -397,7 +397,7 @@ int agp_unbind_memory(agp_memory * curr)
 static void agp_generic_agp_enable(u32 mode)
 {
 	struct pci_dev *device = NULL;
-	u32 command, scratch, cap_id;
+	u32 command, scratch;
 	u8 cap_ptr;
 
 	pci_read_config_dword(agp_bridge.dev,
@@ -561,6 +561,7 @@ static int agp_generic_create_gatt_table
 					    agp_bridge.current_size;
 					break;
 				}
+				temp = agp_bridge.current_size;
 			} else {
 				agp_bridge.aperture_size_idx = i;
 			}
@@ -578,23 +579,21 @@ static int agp_generic_create_gatt_table
 	}
 	table_end = table + ((PAGE_SIZE * (1 << page_order)) - 1);
 
-	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
+	page = virt_to_page(table);
+
+#ifdef __i386__
+	if (change_page_attr(page, 1<<page_order, PAGE_KERNEL_NOCACHE) < 0) 
+		return -ENOMEM;
+#endif
+	for (; page <= virt_to_page(table_end); page++) { 
 		SetPageReserved(page);
+	}
 
 	agp_bridge.gatt_table_real = (unsigned long *) table;
 	CACHE_FLUSH();
-	agp_bridge.gatt_table = ioremap_nocache(virt_to_phys(table),
-					(PAGE_SIZE * (1 << page_order)));
+	agp_bridge.gatt_table = agp_bridge.gatt_table_real;
 	CACHE_FLUSH();
 
-	if (agp_bridge.gatt_table == NULL) {
-		for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
-			ClearPageReserved(page);
-
-		free_pages((unsigned long) table, page_order);
-
-		return -ENOMEM;
-	}
 	agp_bridge.gatt_bus_addr = virt_to_phys(agp_bridge.gatt_table_real);
 
 	for (i = 0; i < num_entries; i++) {
@@ -651,7 +650,6 @@ static int agp_generic_free_gatt_table(v
 	 * from the table.
 	 */
 
-	iounmap(agp_bridge.gatt_table);
 	table = (char *) agp_bridge.gatt_table_real;
 	table_end = table + ((PAGE_SIZE * (1 << page_order)) - 1);
 
@@ -769,6 +767,13 @@ static unsigned long agp_generic_alloc_p
 	if (page == NULL) {
 		return 0;
 	}
+#ifdef __i386__
+	if (change_page_attr(page, 1, PAGE_KERNEL_NOCACHE) < 0) { 
+	        __free_page(page); 			   
+		return 0; 
+	}
+#endif
+
 	get_page(page);
 	LockPage(page);
 	atomic_inc(&agp_bridge.current_memory_agp);
@@ -785,6 +790,11 @@ static void agp_generic_destroy_page(uns
 	}
 	
 	page = virt_to_page(pt);
+#ifdef __i386__
+	change_page_attr(page, 1, PAGE_KERNEL);
+#endif
+	
+
 	put_page(page);
 	UnlockPage(page);
 	free_page((unsigned long) pt);
@@ -2241,17 +2251,15 @@ static int amd_create_page_map(amd_page_
 	if (page_map->real == NULL) {
 		return -ENOMEM;
 	}
-	SetPageReserved(virt_to_page(page_map->real));
-	CACHE_FLUSH();
-	page_map->remapped = ioremap_nocache(virt_to_phys(page_map->real), 
-					    PAGE_SIZE);
-	if (page_map->remapped == NULL) {
-		ClearPageReserved(virt_to_page(page_map->real));
-		free_page((unsigned long) page_map->real);
-		page_map->real = NULL;
+#ifdef __i386__
+	if (change_page_attr(virt_to_page(page_map->real), 
+			     1, PAGE_KERNEL_NOCACHE)) {
+		free_page(page_map->real); 
 		return -ENOMEM;
 	}
-	CACHE_FLUSH();
+#endif
+	SetPageReserved(virt_to_page(page_map->real));
+	page_map->remapped = page_map->real; 
 
 	for(i = 0; i < PAGE_SIZE / sizeof(unsigned long); i++) {
 		page_map->remapped[i] = agp_bridge.scratch_page;
@@ -2262,7 +2270,6 @@ static int amd_create_page_map(amd_page_
 
 static void amd_free_page_map(amd_page_map *page_map)
 {
-	iounmap(page_map->remapped);
 	ClearPageReserved(virt_to_page(page_map->real));
 	free_page((unsigned long) page_map->real);
 }
@@ -2744,27 +2751,22 @@ static void ali_cache_flush(void)
 
 static unsigned long ali_alloc_page(void)
 {
-	struct page *page;
-	u32 temp;
-
-	page = alloc_page(GFP_KERNEL);
-	if (page == NULL)
+	unsigned long p = agp_generic_alloc_page(); 
+	if (!p) 
 		return 0;
 
-	get_page(page);
-	LockPage(page);
-	atomic_inc(&agp_bridge.current_memory_agp);
-
+	/* probably not needed anymore */
 	global_cache_flush();
 
 	if (agp_bridge.type == ALI_M1541) {
+		u32 temp;
 		pci_read_config_dword(agp_bridge.dev, ALI_CACHE_FLUSH_CTRL, &temp);
 		pci_write_config_dword(agp_bridge.dev, ALI_CACHE_FLUSH_CTRL,
 				(((temp & ALI_CACHE_FLUSH_ADDR_MASK) |
-				  virt_to_phys(page_address(page))) |
+				  virt_to_phys(p)) |
 				    ALI_CACHE_FLUSH_EN ));
 	}
-	return (unsigned long)page_address(page);
+	return p;
 }
 
 static void ali_destroy_page(unsigned long addr)
@@ -2786,11 +2788,7 @@ static void ali_destroy_page(unsigned lo
 				    ALI_CACHE_FLUSH_EN));
 	}
 
-	page = virt_to_page(pt);
-	put_page(page);
-	UnlockPage(page);
-	free_page((unsigned long) pt);
-	atomic_dec(&agp_bridge.current_memory_agp);
+	agp_generic_destroy_page(pt);
 }
 
 /* Setup function */
@@ -2870,17 +2868,15 @@ static int serverworks_create_page_map(s
 	if (page_map->real == NULL) {
 		return -ENOMEM;
 	}
-	SetPageReserved(virt_to_page(page_map->real));
-	CACHE_FLUSH();
-	page_map->remapped = ioremap_nocache(virt_to_phys(page_map->real), 
-					    PAGE_SIZE);
-	if (page_map->remapped == NULL) {
-		ClearPageReserved(virt_to_page(page_map->real));
-		free_page((unsigned long) page_map->real);
-		page_map->real = NULL;
+#ifdef __i386__
+	if (change_page_attr(virt_to_page(page_map->real), 1, 
+			     PAGE_KERNEL_NOCACHE) < 0) {
+		free_page(page_map->real);
 		return -ENOMEM;
 	}
-	CACHE_FLUSH();
+#endif
+	SetPageReserved(virt_to_page(page_map->real));
+	page_map->remapped = page_map->real;
 
 	for(i = 0; i < PAGE_SIZE / sizeof(unsigned long); i++) {
 		page_map->remapped[i] = agp_bridge.scratch_page;
@@ -2891,7 +2887,6 @@ static int serverworks_create_page_map(s
 
 static void serverworks_free_page_map(serverworks_page_map *page_map)
 {
-	iounmap(page_map->remapped);
 	ClearPageReserved(virt_to_page(page_map->real));
 	free_page((unsigned long) page_map->real);
 }
diff -burpN -X ../KDIFX -x *-o -x *.[ch]-* linux-2.4.19pre9/include/asm-i386/pgtable-2level.h linux-2.4.19pre9-work/include/asm-i386/pgtable-2level.h
--- linux-2.4.19pre9/include/asm-i386/pgtable-2level.h	Thu Jul 26 22:40:32 2001
+++ linux-2.4.19pre9-work/include/asm-i386/pgtable-2level.h	Thu Jun 13 16:52:53 2002
@@ -40,6 +40,8 @@ static inline int pgd_present(pgd_t pgd)
  * hook is made available.
  */
 #define set_pte(pteptr, pteval) (*(pteptr) = pteval)
+#define set_pte_atomic(pteptr, pteval) (*(pteptr) = pteval)
+
 /*
  * (pmds are folded into pgds so this doesnt get actually called,
  * but the define is needed for a generic inline function.)
diff -burpN -X ../KDIFX -x *-o -x *.[ch]-* linux-2.4.19pre9/include/asm-i386/pgtable-3level.h linux-2.4.19pre9-work/include/asm-i386/pgtable-3level.h
--- linux-2.4.19pre9/include/asm-i386/pgtable-3level.h	Thu Jul 26 22:40:32 2001
+++ linux-2.4.19pre9-work/include/asm-i386/pgtable-3level.h	Thu Jun 13 17:15:14 2002
@@ -53,6 +53,9 @@ static inline void set_pte(pte_t *ptep, 
 		set_64bit((unsigned long long *)(pmdptr),pmd_val(pmdval))
 #define set_pgd(pgdptr,pgdval) \
 		set_64bit((unsigned long long *)(pgdptr),pgd_val(pgdval))
+#define set_pte_atomic(pteptr,pteval) \
+		set_64bit((unsigned long long *)(pteptr),pte_val(pteval))
+
 
 /*
  * Pentium-II erratum A13: in PAE mode we explicitly have to flush
diff -burpN -X ../KDIFX -x *-o -x *.[ch]-* linux-2.4.19pre9/include/asm-i386/pgtable.h linux-2.4.19pre9-work/include/asm-i386/pgtable.h
--- linux-2.4.19pre9/include/asm-i386/pgtable.h	Mon Jun  3 21:15:18 2002
+++ linux-2.4.19pre9-work/include/asm-i386/pgtable.h	Fri Jun 14 17:45:29 2002
@@ -347,6 +347,9 @@ static inline pte_t pte_modify(pte_t pte
 #define pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
 #define swp_entry_to_pte(x)		((pte_t) { (x).val })
 
+struct page;
+int change_page_attr(struct page *, int, pgprot_t prot);
+
 #endif /* !__ASSEMBLY__ */
 
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
