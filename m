Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317816AbSFMUPl>; Thu, 13 Jun 2002 16:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317817AbSFMUPk>; Thu, 13 Jun 2002 16:15:40 -0400
Received: from ns.suse.de ([213.95.15.193]:42759 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317816AbSFMUPg>;
	Thu, 13 Jun 2002 16:15:36 -0400
Date: Thu, 13 Jun 2002 22:15:33 +0200
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Richard Brunner <richard.brunner@amd.com>, mark.langsdorf@amd.com,
        bcrl@redhat.com
Subject: New version of pageattr caching conflict fix for 2.4
Message-ID: <20020613221533.A2544@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the latest version of pageattr for i386. The patch changes
the caching attributes in the kernel mapping dynamically to avoid memory
aliases with the AGP GART with different caching policies (which can lead
to data corruption with some CPUs). It also fixes some other kernel 
potential mapping caching conflicts.

The patch does not require turning off of larges pages for the kernel
globally; instead it changes the kernel large page mapping to a 4K
mappin and back as needed.

It adds a new function 

int change_page_attr(struct page *page, pgprot_t mapping) 

Everytime someone maps a page with write back or write combining
or another non standard caching mode into any page table the corresponding
kernel page must be remapped with this version. After that the virtual
kernel address of the page (page_address(page)) has the caching policy
specified in mapping. In theory it could be used to write protect kernel
pages too, but that's probably dangerous and should be avoided.
(best is to use PAGE_KERNEL, PAGE_KERNEL_NOCACHE and perhaps
MAKE_GLOBAL(_PAGE_KERNEL | _PAGE_PWT) for write combining if you really need 
it). The function is currently i386 specific, but at least x86-64 needs 
it too.

Note that some drivers did this previously with ioremap_nocache. This 
is incorrect and should be replaced with change_page_attr(). 

Also available at:
ftp://ftp.suse.com/pub/people/ak/v2.4/pageattr-2.4.19pre9-3

AMD's version to fix the same problem: 
ftp://ftp.suse.com/pub/people/ak/amd-adv-spec-caching-disable-2.4.19pre9-1

Thanks to Ben LaHaise who found some problems in the original version.

I will probably submit this version for 2.4 unless someone finds a grave
problem in this version.

-Andi


diff -burpN -X ../KDIFX -x *.[ch]-* linux-2.4.19pre9/arch/i386/mm/Makefile linux-2.4.19pre9-work/arch/i386/mm/Makefile
--- linux-2.4.19pre9/arch/i386/mm/Makefile	Fri Dec 29 23:07:20 2000
+++ linux-2.4.19pre9-work/arch/i386/mm/Makefile	Wed Jun  5 02:35:11 2002
@@ -9,6 +9,7 @@
 
 O_TARGET := mm.o
 
-obj-y	 := init.o fault.o ioremap.o extable.o
+obj-y	 := init.o fault.o ioremap.o extable.o pageattr.o
+export-objs := pageattr.o
 
 include $(TOPDIR)/Rules.make
diff -burpN -X ../KDIFX -x *.[ch]-* linux-2.4.19pre9/arch/i386/mm/pageattr.c linux-2.4.19pre9-work/arch/i386/mm/pageattr.c
--- linux-2.4.19pre9/arch/i386/mm/pageattr.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.19pre9-work/arch/i386/mm/pageattr.c	Thu Jun 13 19:51:13 2002
@@ -0,0 +1,154 @@
+/* 
+ * Copyright 2002 Andi Kleen, SuSE Labs. 
+ * Thanks to Ben La Haise for precious feedback.
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
+static pte_t *split_large_page(unsigned long address, pgprot_t prot)
+{ 
+	unsigned long addr;
+	int i; 
+	pte_t *base = (pte_t *) __get_free_page(GFP_KERNEL); 
+	if (!base) 
+		return NULL;
+	BUG_ON(atomic_read(&virt_to_page(base)->count) != 1); 	
+	address = __pa(address);
+	addr = address & LARGE_PAGE_MASK; 
+	for (i = 0; i < PTRS_PER_PTE; i++, addr += PAGE_SIZE) {
+		base[i] = mk_pte_phys(addr, addr == address ? prot : PAGE_KERNEL);
+	}
+	return base;
+} 
+
+static void flush_kernel_map(void * address) 
+{ 
+	if (boot_cpu_data.x86_model >= 4) 
+		asm volatile("wbinvd":::"memory"); 
+	__flush_tlb_one(address);
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
+void revert_page(struct page *kpte_page, unsigned long address)
+{
+	pte_t *linear = (pte_t *) 
+		pmd_offset(pgd_offset(&init_mm, address), address);
+	set_pmd_pte(linear,  address,
+		mk_pte_phys(__pa(address & LARGE_PAGE_MASK),
+			    __pgprot(_KERNPG_TABLE|_PAGE_PSE)));
+	__free_page(kpte_page); 			   
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
+int change_page_attr(struct page *page, pgprot_t prot) 
+{ 
+	int err; 
+	pte_t *kpte, *split; 
+	unsigned long address;
+	struct page *kpte_page;
+
+#ifdef CONFIG_HIGHMEM
+	/* Hopefully not be mapped anywhere else. */
+	if (page >= highmem_start_page) 
+		return 0; 
+#endif
+
+	address = (unsigned long)page_address(page);
+
+	down_write(&init_mm.mmap_sem); 
+	kpte = lookup_address(address);
+	kpte_page = virt_to_page(((unsigned long)kpte) & PAGE_MASK);
+	if (pgprot_val(prot) != pgprot_val(PAGE_KERNEL)) { 
+		if ((pte_val(*kpte) & _PAGE_PSE) == 0) { 
+			pte_t old = *kpte;
+			pte_t standard = mk_pte(page, PAGE_KERNEL); 
+		
+			/* Already a 4KB page. Just update it to the
+			 * new protection.  Doesn't need to be
+			 * atomic. It doesn't matter if dirty bits get
+			 * lost.  */
+			set_pte_atomic(kpte, mk_pte(page, prot)); 
+			if (!memcmp(&old,&standard,sizeof(pte_t))) 
+				atomic_inc(&kpte_page->count);
+		} else {
+			err = -ENOMEM; 
+			split = split_large_page(address, prot); 
+			if (!split)
+				goto out;
+			set_pmd_pte(kpte,address,
+				    mk_pte(virt_to_page(split), PAGE_KERNEL));
+		}	
+	} else if ((pte_val(*kpte) & _PAGE_PSE) == 0) { 
+		set_pte_atomic(kpte, mk_pte(page, PAGE_KERNEL));
+		atomic_dec(&kpte_page->count); 
+	}
+
+#ifdef CONFIG_SMP 
+	smp_call_function(flush_kernel_map, (void *)address, 1, 1);
+#endif	
+	flush_kernel_map((void *)address);
+	
+	if (test_bit(X86_FEATURE_PSE, &boot_cpu_data.x86_capability) && 
+	    (atomic_read(&kpte_page->count) == 1))
+		revert_page(kpte_page, address);
+	err = 0;
+ out:
+	up_write(&init_mm.mmap_sem); 
+	return err;
+} 
+
+EXPORT_SYMBOL(change_page_attr);
diff -burpN -X ../KDIFX -x *.[ch]-* linux-2.4.19pre9/drivers/char/agp/agpgart_be.c linux-2.4.19pre9-work/drivers/char/agp/agpgart_be.c
--- linux-2.4.19pre9/drivers/char/agp/agpgart_be.c	Sun Jun  2 20:24:00 2002
+++ linux-2.4.19pre9-work/drivers/char/agp/agpgart_be.c	Thu Jun 13 17:05:49 2002
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
@@ -578,23 +579,16 @@ static int agp_generic_create_gatt_table
 	}
 	table_end = table + ((PAGE_SIZE * (1 << page_order)) - 1);
 
-	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
+	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++) { 
 		SetPageReserved(page);
+		change_page_attr(page, PAGE_KERNEL_NOCACHE);
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
@@ -651,7 +645,6 @@ static int agp_generic_free_gatt_table(v
 	 * from the table.
 	 */
 
-	iounmap(agp_bridge.gatt_table);
 	table = (char *) agp_bridge.gatt_table_real;
 	table_end = table + ((PAGE_SIZE * (1 << page_order)) - 1);
 
@@ -769,6 +762,10 @@ static unsigned long agp_generic_alloc_p
 	if (page == NULL) {
 		return 0;
 	}
+#ifdef __i386__
+	change_page_attr(page, __pgprot(__PAGE_KERNEL | _PAGE_PCD));
+#endif
+
 	get_page(page);
 	LockPage(page);
 	atomic_inc(&agp_bridge.current_memory_agp);
@@ -785,6 +782,11 @@ static void agp_generic_destroy_page(uns
 	}
 	
 	page = virt_to_page(pt);
+#ifdef __i386__
+	change_page_attr(page, PAGE_KERNEL);
+#endif
+	
+
 	put_page(page);
 	UnlockPage(page);
 	free_page((unsigned long) pt);
@@ -2242,16 +2244,8 @@ static int amd_create_page_map(amd_page_
 		return -ENOMEM;
 	}
 	SetPageReserved(virt_to_page(page_map->real));
-	CACHE_FLUSH();
-	page_map->remapped = ioremap_nocache(virt_to_phys(page_map->real), 
-					    PAGE_SIZE);
-	if (page_map->remapped == NULL) {
-		ClearPageReserved(virt_to_page(page_map->real));
-		free_page((unsigned long) page_map->real);
-		page_map->real = NULL;
-		return -ENOMEM;
-	}
-	CACHE_FLUSH();
+	change_page_attr(virt_to_page(page_map->real), PAGE_KERNEL_NOCACHE); 
+	page_map->remapped = page_map->real; 
 
 	for(i = 0; i < PAGE_SIZE / sizeof(unsigned long); i++) {
 		page_map->remapped[i] = agp_bridge.scratch_page;
@@ -2262,7 +2256,6 @@ static int amd_create_page_map(amd_page_
 
 static void amd_free_page_map(amd_page_map *page_map)
 {
-	iounmap(page_map->remapped);
 	ClearPageReserved(virt_to_page(page_map->real));
 	free_page((unsigned long) page_map->real);
 }
@@ -2744,27 +2737,22 @@ static void ali_cache_flush(void)
 
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
@@ -2786,11 +2774,7 @@ static void ali_destroy_page(unsigned lo
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
@@ -2871,16 +2855,8 @@ static int serverworks_create_page_map(s
 		return -ENOMEM;
 	}
 	SetPageReserved(virt_to_page(page_map->real));
-	CACHE_FLUSH();
-	page_map->remapped = ioremap_nocache(virt_to_phys(page_map->real), 
-					    PAGE_SIZE);
-	if (page_map->remapped == NULL) {
-		ClearPageReserved(virt_to_page(page_map->real));
-		free_page((unsigned long) page_map->real);
-		page_map->real = NULL;
-		return -ENOMEM;
-	}
-	CACHE_FLUSH();
+	change_page_attr(virt_to_page(page_map->real), PAGE_KERNEL_NOCACHE)
+	page_map->remapped = page_map->real;
 
 	for(i = 0; i < PAGE_SIZE / sizeof(unsigned long); i++) {
 		page_map->remapped[i] = agp_bridge.scratch_page;
@@ -2891,7 +2867,6 @@ static int serverworks_create_page_map(s
 
 static void serverworks_free_page_map(serverworks_page_map *page_map)
 {
-	iounmap(page_map->remapped);
 	ClearPageReserved(virt_to_page(page_map->real));
 	free_page((unsigned long) page_map->real);
 }
diff -burpN -X ../KDIFX -x *.[ch]-* linux-2.4.19pre9/include/asm-i386/pgtable-2level.h linux-2.4.19pre9-work/include/asm-i386/pgtable-2level.h
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
diff -burpN -X ../KDIFX -x *.[ch]-* linux-2.4.19pre9/include/asm-i386/pgtable-3level.h linux-2.4.19pre9-work/include/asm-i386/pgtable-3level.h
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
diff -burpN -X ../KDIFX -x *.[ch]-* linux-2.4.19pre9/include/asm-i386/pgtable.h linux-2.4.19pre9-work/include/asm-i386/pgtable.h
--- linux-2.4.19pre9/include/asm-i386/pgtable.h	Mon Jun  3 21:15:18 2002
+++ linux-2.4.19pre9-work/include/asm-i386/pgtable.h	Thu Jun 13 20:27:09 2002
@@ -347,6 +347,9 @@ static inline pte_t pte_modify(pte_t pte
 #define pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
 #define swp_entry_to_pte(x)		((pte_t) { (x).val })
 
+struct page;
+int change_page_attr(struct page *, pgprot_t prot);
+
 #endif /* !__ASSEMBLY__ */
 
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
