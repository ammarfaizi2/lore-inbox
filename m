Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317546AbSFLFEt>; Wed, 12 Jun 2002 01:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317547AbSFLFEs>; Wed, 12 Jun 2002 01:04:48 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:41198 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317546AbSFLFEm>; Wed, 12 Jun 2002 01:04:42 -0400
Date: Wed, 12 Jun 2002 01:04:43 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] pageattr update
Message-ID: <20020612010443.B1350@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andi, everyone,

Below are some updates to the pageattr patch you posted earlier.  The 
first set of changes were to add change_page_attrs in several paths 
where the AGP and DRM code would allocate a page and then call 
ioremap_nocache on it to create an uncachable mapping.  Secondly, I 
removed the #ifdef __i386__ around the change_page_attr hook, and 
instead put dummy macros in the headers for the various other archs.  
There was a race in pageattr.c that would make the P4 unhappy, so I 
moved the pte page free to after the tlb flush.  The tlb flush was 
not flushing global pages, so I replaced the code with a call to 
flush_tlb_all() to do the job.  Lastly, since the top page of the 
page tables on x86 is unique to each mm and contains copies of the 
pmd entries in non-PAE mode, I added a function to walk all mms via 
the mmlist to update the pmds before the tlb flush.

With these changes in place, my X server is starting up and using 
DRM happily.  Without the global TLB flush, X would hang on startup.  
Could people please review and test this version?  Thanks,

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

:r ~/patches/v2.4/v2.4.19-pre10-pageattr-B1.diff
diff -urN v2.4.19-pre10/arch/i386/mm/Makefile pageattr-v2.4.19-pre10.diff/arch/i386/mm/Makefile
--- v2.4.19-pre10/arch/i386/mm/Makefile	Fri Dec 29 17:07:20 2000
+++ pageattr-v2.4.19-pre10.diff/arch/i386/mm/Makefile	Tue Jun 11 21:41:54 2002
@@ -9,6 +9,7 @@
 
 O_TARGET := mm.o
 
-obj-y	 := init.o fault.o ioremap.o extable.o
+obj-y	 := init.o fault.o ioremap.o extable.o pageattr.o
+export-objs := pageattr.o
 
 include $(TOPDIR)/Rules.make
diff -urN v2.4.19-pre10/arch/i386/mm/pageattr.c pageattr-v2.4.19-pre10.diff/arch/i386/mm/pageattr.c
--- v2.4.19-pre10/arch/i386/mm/pageattr.c	Wed Dec 31 19:00:00 1969
+++ pageattr-v2.4.19-pre10.diff/arch/i386/mm/pageattr.c	Wed Jun 12 00:37:37 2002
@@ -0,0 +1,173 @@
+/* 
+ * Copyright 2002 Andi Kleen, SuSE Labs. 
+ * Copyright 2002 Red Hat, Inc.
+ * Additional fixes by Benjamin LaHaise, Red Hat.
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
+#define LARGE_PAGE_SIZE ((1UL << PMD_SHIFT)) 
+
+#ifdef CONFIG_DISCONTIGMEM
+#error you lose. sorry.
+#endif
+
+#ifdef CONFIG_X86_PAE
+/* note: PAT must be cleared also. assumes a PAE CPU also has PGE. */
+#define PAGE_KERNEL_4K \
+	__pgprot(_KERNPG_TABLE & ~(_PAGE_GLOBAL|_PAGE_DIRTY))
+#else
+#define PAGE_KERNEL_4K \
+	MAKE_GLOBAL(_KERNPG_TABLE & ~(_PAGE_DIRTY))
+#endif
+
+static inline pte_t *lookup_address(unsigned long address) 
+{ 
+	pte_t *pte;
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
+/*
+ * Update all kernel pmd entries in the system for the given address.
+ */
+static void update_all_kernel_pmds(unsigned long address, pte_t new_pmd)
+{
+	/* PAE can avoid this operation as all mms share the same
+	 * kernel pmds, so the update will propagate when the TLBs 
+	 * are flushed.
+	 */
+#if !defined(CONFIG_HIGHMEM64G)
+	struct mm_struct *mm = &init_mm;
+
+	spin_lock(&mmlist_lock);
+	for (;;) {
+		pmd_t *pmdp;
+		mm = list_entry(mm->mmlist.next, struct mm_struct, mmlist);
+		if (mm == &init_mm)
+			break;
+
+		pmdp = pmd_offset(pgd_offset(mm, address), address);
+		set_pte((pte_t *)pmdp, new_pmd);
+	}
+	spin_unlock(&mmlist_lock);
+#endif
+	return;
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
+	struct page *page_to_free = NULL;
+
+#ifdef CONFIG_HIGHMEM
+	if (page >= highmem_start_page) { 
+		/* Hopefully not be mapped anywhere else. */
+		return 0; 
+	} 
+#endif
+
+	address = ((unsigned long)(page - mem_map) << PAGE_SHIFT) + __PAGE_OFFSET;
+
+	down_write(&init_mm.mmap_sem); 
+	kpte = lookup_address(address);
+	kpte_page = virt_to_page(((unsigned long)kpte) & PAGE_MASK);
+	if (pgprot_val(prot) != pgprot_val(PAGE_KERNEL)) { 
+		if ((pte_val(*kpte) & _PAGE_PSE) == 0) { 
+			pte_t old = *kpte, standard = mk_pte(page, PAGE_KERNEL); 
+			/* Already a 4KB page. Just update it to the new protection.
+			 * Doesn't need to be atomic. It doesn't matter if dirty bits 
+			 * get lost.
+			 */
+			set_pte(kpte, mk_pte(page, prot)); 
+			if (!memcmp(&old,&standard,sizeof(pte_t))) 
+				atomic_inc(&kpte_page->count);
+		} else {
+			err = -ENOMEM; 
+			split = split_large_page(address, prot); 
+			if (!split)
+				goto out;
+
+			set_pte(kpte,mk_pte(virt_to_page(split), PAGE_KERNEL_4K));
+			update_all_kernel_pmds(address, *kpte);
+		}	
+	} else if ((pte_val(*kpte) & _PAGE_PSE) == 0) { 
+		/* just an ordinary page again - revert to standard mapping */	
+		set_pte(kpte, mk_pte(page, PAGE_KERNEL));
+		atomic_dec(&kpte_page->count); 
+		if (atomic_read(&kpte_page->count) == 1) {
+			/* no more special protections in this 4MB area - revert to
+			   large page again. */
+			pte_t *linear = (pte_t *) 
+				pmd_offset(pgd_offset(&init_mm, address), address);
+
+			set_pte(linear, 
+				mk_pte_phys(__pa(address & LARGE_PAGE_MASK),
+					    __pgprot(_KERNPG_TABLE|_PAGE_PSE)));
+			update_all_kernel_pmds(address, *linear);
+			page_to_free = kpte_page;
+		}
+	}
+
+	/* Kernel pages typically have the global bit set, so we must 
+	 * flush everything...
+	 */
+	flush_tlb_all();
+
+	if (NULL != page_to_free)
+		__free_page(page_to_free);
+	err = 0;
+ out:
+	up_write(&init_mm.mmap_sem); 
+	return err;
+} 
+
+EXPORT_SYMBOL(change_page_attr);
diff -urN v2.4.19-pre10/drivers/char/agp/agpgart_be.c pageattr-v2.4.19-pre10.diff/drivers/char/agp/agpgart_be.c
--- v2.4.19-pre10/drivers/char/agp/agpgart_be.c	Thu Jun  6 20:09:59 2002
+++ pageattr-v2.4.19-pre10.diff/drivers/char/agp/agpgart_be.c	Tue Jun 11 22:08:48 2002
@@ -397,7 +397,7 @@
 static void agp_generic_agp_enable(u32 mode)
 {
 	struct pci_dev *device = NULL;
-	u32 command, scratch, cap_id;
+	u32 command, scratch;
 	u8 cap_ptr;
 
 	pci_read_config_dword(agp_bridge.dev,
@@ -561,6 +561,7 @@
 					    agp_bridge.current_size;
 					break;
 				}
+				temp = agp_bridge.current_size;
 			} else {
 				agp_bridge.aperture_size_idx = i;
 			}
@@ -578,8 +579,10 @@
 	}
 	table_end = table + ((PAGE_SIZE * (1 << page_order)) - 1);
 
-	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
+	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++) {
 		SetPageReserved(page);
+		change_page_attr(page, __pgprot(__PAGE_KERNEL | _PAGE_PCD));
+	}
 
 	agp_bridge.gatt_table_real = (unsigned long *) table;
 	CACHE_FLUSH();
@@ -588,8 +591,10 @@
 	CACHE_FLUSH();
 
 	if (agp_bridge.gatt_table == NULL) {
-		for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
+		for (page = virt_to_page(table); page <= virt_to_page(table_end); page++) {
+			change_page_attr(page, PAGE_KERNEL);
 			ClearPageReserved(page);
+		}
 
 		free_pages((unsigned long) table, page_order);
 
@@ -655,8 +660,10 @@
 	table = (char *) agp_bridge.gatt_table_real;
 	table_end = table + ((PAGE_SIZE * (1 << page_order)) - 1);
 
-	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
+	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++) {
+		change_page_attr(page, PAGE_KERNEL);
 		ClearPageReserved(page);
+	}
 
 	free_pages((unsigned long) agp_bridge.gatt_table_real, page_order);
 	return 0;
@@ -769,6 +776,8 @@
 	if (page == NULL) {
 		return 0;
 	}
+	change_page_attr(page, __pgprot(__PAGE_KERNEL | _PAGE_PCD));
+
 	get_page(page);
 	LockPage(page);
 	atomic_inc(&agp_bridge.current_memory_agp);
@@ -785,6 +794,9 @@
 	}
 	
 	page = virt_to_page(pt);
+	change_page_attr(page, PAGE_KERNEL);
+	
+
 	put_page(page);
 	UnlockPage(page);
 	free_page((unsigned long) pt);
@@ -2243,9 +2255,11 @@
 	}
 	SetPageReserved(virt_to_page(page_map->real));
 	CACHE_FLUSH();
+	change_page_attr(virt_to_page(page_map->real), __pgprot(__PAGE_KERNEL | _PAGE_PCD));
 	page_map->remapped = ioremap_nocache(virt_to_phys(page_map->real), 
 					    PAGE_SIZE);
 	if (page_map->remapped == NULL) {
+		change_page_attr(virt_to_page(page_map->real), PAGE_KERNEL);
 		ClearPageReserved(virt_to_page(page_map->real));
 		free_page((unsigned long) page_map->real);
 		page_map->real = NULL;
@@ -2263,6 +2277,7 @@
 static void amd_free_page_map(amd_page_map *page_map)
 {
 	iounmap(page_map->remapped);
+	change_page_attr(virt_to_page(page_map->real), PAGE_KERNEL);
 	ClearPageReserved(virt_to_page(page_map->real));
 	free_page((unsigned long) page_map->real);
 }
@@ -2744,27 +2759,22 @@
 
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
@@ -2786,11 +2796,7 @@
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
@@ -2872,9 +2878,11 @@
 	}
 	SetPageReserved(virt_to_page(page_map->real));
 	CACHE_FLUSH();
+	change_page_attr(virt_to_page(page_map->real), __pgprot(__PAGE_KERNEL | _PAGE_PCD));
 	page_map->remapped = ioremap_nocache(virt_to_phys(page_map->real), 
 					    PAGE_SIZE);
 	if (page_map->remapped == NULL) {
+		change_page_attr(virt_to_page(page_map->real), PAGE_KERNEL);
 		ClearPageReserved(virt_to_page(page_map->real));
 		free_page((unsigned long) page_map->real);
 		page_map->real = NULL;
@@ -2892,6 +2900,7 @@
 static void serverworks_free_page_map(serverworks_page_map *page_map)
 {
 	iounmap(page_map->remapped);
+	change_page_attr(virt_to_page(page_map->real), PAGE_KERNEL);
 	ClearPageReserved(virt_to_page(page_map->real));
 	free_page((unsigned long) page_map->real);
 }
diff -urN v2.4.19-pre10/drivers/char/drm-4.0/mga_dma.c pageattr-v2.4.19-pre10.diff/drivers/char/drm-4.0/mga_dma.c
--- v2.4.19-pre10/drivers/char/drm-4.0/mga_dma.c	Thu Mar  7 16:39:58 2002
+++ pageattr-v2.4.19-pre10.diff/drivers/char/drm-4.0/mga_dma.c	Tue Jun 11 22:01:01 2002
@@ -641,6 +641,7 @@
 		   	iounmap(dev_priv->status_page);
 		}
 	   	if(dev_priv->real_status_page != 0UL) {
+			change_page_attr(virt_to_page(dev_priv->real_status_page), PAGE_KERNEL);
 		   	mga_free_page(dev, dev_priv->real_status_page);
 		}
 	   	if(dev_priv->prim_bufs != NULL) {
@@ -731,6 +732,7 @@
 		return -ENOMEM;
 	}
 
+	change_page_attr(virt_to_page(dev_priv->real_status_page), __pgprot(__PAGE_KERNEL | _PAGE_PCD));
    	dev_priv->status_page =
 		ioremap_nocache(virt_to_bus((void *)dev_priv->real_status_page),
 				PAGE_SIZE);
diff -urN v2.4.19-pre10/include/asm-alpha/pgtable.h pageattr-v2.4.19-pre10.diff/include/asm-alpha/pgtable.h
--- v2.4.19-pre10/include/asm-alpha/pgtable.h	Thu Jun  6 20:10:08 2002
+++ pageattr-v2.4.19-pre10.diff/include/asm-alpha/pgtable.h	Tue Jun 11 22:17:39 2002
@@ -364,4 +364,6 @@
 /* We have our own get_unmapped_area to cope with ADDR_LIMIT_32BIT.  */
 #define HAVE_ARCH_UNMAPPED_AREA
 
+#define change_page_attr(page, prot)	do { } while (0)
+
 #endif /* _ALPHA_PGTABLE_H */
diff -urN v2.4.19-pre10/include/asm-arm/pgtable.h pageattr-v2.4.19-pre10.diff/include/asm-arm/pgtable.h
--- v2.4.19-pre10/include/asm-arm/pgtable.h	Thu Jun  6 20:10:08 2002
+++ pageattr-v2.4.19-pre10.diff/include/asm-arm/pgtable.h	Tue Jun 11 22:17:48 2002
@@ -175,6 +175,7 @@
 #include <asm-generic/pgtable.h>
 
 extern void pgtable_cache_init(void);
+#define change_page_attr(page, prot)	do { } while (0)
 
 #endif /* !__ASSEMBLY__ */
 
diff -urN v2.4.19-pre10/include/asm-cris/pgtable.h pageattr-v2.4.19-pre10.diff/include/asm-cris/pgtable.h
--- v2.4.19-pre10/include/asm-cris/pgtable.h	Thu Jun  6 20:10:08 2002
+++ pageattr-v2.4.19-pre10.diff/include/asm-cris/pgtable.h	Tue Jun 11 22:17:59 2002
@@ -520,4 +520,6 @@
  */
 #define pgtable_cache_init()   do { } while (0)
 
+#define change_page_attr(page, prot)	do { } while (0)
+
 #endif /* _CRIS_PGTABLE_H */
diff -urN v2.4.19-pre10/include/asm-i386/pgtable.h pageattr-v2.4.19-pre10.diff/include/asm-i386/pgtable.h
--- v2.4.19-pre10/include/asm-i386/pgtable.h	Thu Jun  6 20:10:08 2002
+++ pageattr-v2.4.19-pre10.diff/include/asm-i386/pgtable.h	Tue Jun 11 23:59:22 2002
@@ -347,6 +347,9 @@
 #define pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
 #define swp_entry_to_pte(x)		((pte_t) { (x).val })
 
+struct page;
+int change_page_attr(struct page *, pgprot_t prot);
+
 #endif /* !__ASSEMBLY__ */
 
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
diff -urN v2.4.19-pre10/include/asm-ia64/pgtable.h pageattr-v2.4.19-pre10.diff/include/asm-ia64/pgtable.h
--- v2.4.19-pre10/include/asm-ia64/pgtable.h	Thu Jun  6 20:10:08 2002
+++ pageattr-v2.4.19-pre10.diff/include/asm-ia64/pgtable.h	Tue Jun 11 22:18:10 2002
@@ -473,4 +473,6 @@
  */
 #define pgtable_cache_init()	do { } while (0)
 
+#define change_page_attr(page, prot)	do { } while (0)
+
 #endif /* _ASM_IA64_PGTABLE_H */
diff -urN v2.4.19-pre10/include/asm-m68k/pgtable.h pageattr-v2.4.19-pre10.diff/include/asm-m68k/pgtable.h
--- v2.4.19-pre10/include/asm-m68k/pgtable.h	Mon Nov 12 17:49:51 2001
+++ pageattr-v2.4.19-pre10.diff/include/asm-m68k/pgtable.h	Tue Jun 11 22:18:14 2002
@@ -187,4 +187,6 @@
  */
 #define pgtable_cache_init()	do { } while (0)
 
+#define change_page_attr(page, prot)	do { } while (0)
+
 #endif /* _M68K_PGTABLE_H */
diff -urN v2.4.19-pre10/include/asm-mips/pgtable.h pageattr-v2.4.19-pre10.diff/include/asm-mips/pgtable.h
--- v2.4.19-pre10/include/asm-mips/pgtable.h	Thu Jun  6 20:10:09 2002
+++ pageattr-v2.4.19-pre10.diff/include/asm-mips/pgtable.h	Tue Jun 11 22:18:24 2002
@@ -538,4 +538,6 @@
  */
 #define pgtable_cache_init()	do { } while (0)
 
+#define change_page_attr(page, prot)	do { } while (0)
+
 #endif /* _ASM_PGTABLE_H */
diff -urN v2.4.19-pre10/include/asm-mips64/pgtable.h pageattr-v2.4.19-pre10.diff/include/asm-mips64/pgtable.h
--- v2.4.19-pre10/include/asm-mips64/pgtable.h	Thu Jun  6 20:10:10 2002
+++ pageattr-v2.4.19-pre10.diff/include/asm-mips64/pgtable.h	Tue Jun 11 22:18:20 2002
@@ -566,6 +566,8 @@
 
 #include <asm-generic/pgtable.h>
 
+#define change_page_attr(page, prot)	do { } while (0)
+
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
 
 #endif /* _ASM_PGTABLE_H */
diff -urN v2.4.19-pre10/include/asm-parisc/pgtable.h pageattr-v2.4.19-pre10.diff/include/asm-parisc/pgtable.h
--- v2.4.19-pre10/include/asm-parisc/pgtable.h	Thu Jun  6 20:10:10 2002
+++ pageattr-v2.4.19-pre10.diff/include/asm-parisc/pgtable.h	Tue Jun 11 22:18:32 2002
@@ -338,4 +338,6 @@
  */
 #define pgtable_cache_init()	do { } while (0)
 
+#define change_page_attr(page, prot)	do { } while (0)
+
 #endif /* _PARISC_PAGE_H */
diff -urN v2.4.19-pre10/include/asm-ppc/pgtable.h pageattr-v2.4.19-pre10.diff/include/asm-ppc/pgtable.h
--- v2.4.19-pre10/include/asm-ppc/pgtable.h	Thu Jun  6 20:10:10 2002
+++ pageattr-v2.4.19-pre10.diff/include/asm-ppc/pgtable.h	Tue Jun 11 22:18:43 2002
@@ -556,6 +556,8 @@
  */
 #define pgtable_cache_init()	do { } while (0)
 
+#define change_page_attr(page, prot)	do { } while (0)
+
 #endif /* __ASSEMBLY__ */
 #endif /* _PPC_PGTABLE_H */
 #endif /* __KERNEL__ */
diff -urN v2.4.19-pre10/include/asm-ppc64/pgtable.h pageattr-v2.4.19-pre10.diff/include/asm-ppc64/pgtable.h
--- v2.4.19-pre10/include/asm-ppc64/pgtable.h	Thu Jun  6 20:10:10 2002
+++ pageattr-v2.4.19-pre10.diff/include/asm-ppc64/pgtable.h	Tue Jun 11 22:18:39 2002
@@ -440,5 +440,7 @@
 extern void make_pte(HPTE * htab, unsigned long va, unsigned long pa,
 		int mode, unsigned long hash_mask, int large);
 
+#define change_page_attr(page, prot)	do { } while (0)
+
 #endif /* __ASSEMBLY__ */
 #endif /* _PPC64_PGTABLE_H */
diff -urN v2.4.19-pre10/include/asm-s390/pgtable.h pageattr-v2.4.19-pre10.diff/include/asm-s390/pgtable.h
--- v2.4.19-pre10/include/asm-s390/pgtable.h	Thu Jun  6 20:10:10 2002
+++ pageattr-v2.4.19-pre10.diff/include/asm-s390/pgtable.h	Tue Jun 11 22:18:47 2002
@@ -503,5 +503,7 @@
  */
 #define pgtable_cache_init()	do { } while (0)
 
+#define change_page_attr(page, prot)	do { } while (0)
+
 #endif /* _S390_PAGE_H */
 
diff -urN v2.4.19-pre10/include/asm-s390x/pgtable.h pageattr-v2.4.19-pre10.diff/include/asm-s390x/pgtable.h
--- v2.4.19-pre10/include/asm-s390x/pgtable.h	Thu Jun  6 20:10:10 2002
+++ pageattr-v2.4.19-pre10.diff/include/asm-s390x/pgtable.h	Tue Jun 11 22:18:50 2002
@@ -523,5 +523,7 @@
  */
 #define pgtable_cache_init()	do { } while (0)
 
+#define change_page_attr(page, prot)	do { } while (0)
+
 #endif /* _S390_PAGE_H */
 
diff -urN v2.4.19-pre10/include/asm-sh/pgtable.h pageattr-v2.4.19-pre10.diff/include/asm-sh/pgtable.h
--- v2.4.19-pre10/include/asm-sh/pgtable.h	Thu Jun  6 20:10:10 2002
+++ pageattr-v2.4.19-pre10.diff/include/asm-sh/pgtable.h	Tue Jun 11 22:18:57 2002
@@ -310,4 +310,6 @@
  */
 #define pgtable_cache_init()	do { } while (0)
 
+#define change_page_attr(page, prot)	do { } while (0)
+
 #endif /* __ASM_SH_PAGE_H */
diff -urN v2.4.19-pre10/include/asm-sparc/pgtable.h pageattr-v2.4.19-pre10.diff/include/asm-sparc/pgtable.h
--- v2.4.19-pre10/include/asm-sparc/pgtable.h	Thu Jun  6 20:10:10 2002
+++ pageattr-v2.4.19-pre10.diff/include/asm-sparc/pgtable.h	Tue Jun 11 22:19:05 2002
@@ -458,4 +458,6 @@
  */
 #define pgtable_cache_init()	do { } while (0)
 
+#define change_page_attr(page, prot)	do { } while (0)
+
 #endif /* !(_SPARC_PGTABLE_H) */
diff -urN v2.4.19-pre10/include/asm-sparc64/pgtable.h pageattr-v2.4.19-pre10.diff/include/asm-sparc64/pgtable.h
--- v2.4.19-pre10/include/asm-sparc64/pgtable.h	Thu Jun  6 20:10:10 2002
+++ pageattr-v2.4.19-pre10.diff/include/asm-sparc64/pgtable.h	Tue Jun 11 22:19:00 2002
@@ -357,4 +357,6 @@
  */
 #define pgtable_cache_init()	do { } while (0)
 
+#define change_page_attr(page, prot)	do { } while (0)
+
 #endif /* !(_SPARC64_PGTABLE_H) */
