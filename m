Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315679AbSECTdp>; Fri, 3 May 2002 15:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315680AbSECTdo>; Fri, 3 May 2002 15:33:44 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:14 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315679AbSECTdc>; Fri, 3 May 2002 15:33:32 -0400
Date: Fri, 3 May 2002 21:33:25 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.13: replace mk_pte_phys() with pfn_pte()
Message-ID: <Pine.LNX.4.21.0205032125340.23113-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the patch to replace mk_pte_phys() with pfn_pte() and so creates
the counterpart to pte_pfn().

bye, Roman

diff -ur arch/alpha/kernel/core_irongate.c arch/alpha/kernel/core_irongate.c
--- arch/alpha/kernel/core_irongate.c	Fri May  3 13:26:55 2002
+++ arch/alpha/kernel/core_irongate.c	Fri May  3 12:07:51 2002
@@ -421,6 +421,7 @@
 		     unsigned long phys_addr, unsigned long flags)
 {
 	unsigned long end;
+	unsigned long pfn;
 
 	address &= ~PMD_MASK;
 	end = address + size;
@@ -428,17 +429,17 @@
 		end = PMD_SIZE;
 	if (address >= end)
 		BUG();
+	pfn = phys_addr >> PAGE_SHIFT;
 	do {
 		if (!pte_none(*pte)) {
 			printk("irongate_remap_area_pte: page already exists\n");
 			BUG();
 		}
-		set_pte(pte, 
-			mk_pte_phys(phys_addr, 
-				    __pgprot(_PAGE_VALID | _PAGE_ASM | 
-					     _PAGE_KRE | _PAGE_KWE | flags)));
+		set_pte(pte, pfn_pte(pfn,
+				     __pgprot(_PAGE_VALID | _PAGE_ASM | 
+					      _PAGE_KRE | _PAGE_KWE | flags)));
 		address += PAGE_SIZE;
-		phys_addr += PAGE_SIZE;
+		pfn++;
 		pte++;
 	} while (address && (address < end));
 }
diff -ur arch/alpha/mm/init.c arch/alpha/mm/init.c
--- arch/alpha/mm/init.c	Fri May  3 13:26:55 2002
+++ arch/alpha/mm/init.c	Fri May  3 12:10:15 2002
@@ -250,12 +250,12 @@
 		/* Set up the third level PTEs and update the virtual
 		   addresses of the CRB entries.  */
 		for (i = 0; i < crb->map_entries; ++i) {
-			unsigned long paddr = crb->map[i].pa;
+			unsigned long pfn = crb->map[i].pa >> PAGE_SHIFT;
 			crb->map[i].va = vaddr;
 			for (j = 0; j < crb->map[i].count; ++j) {
 				set_pte(pte_offset_kernel(pmd, vaddr),
-					mk_pte_phys(paddr, PAGE_KERNEL));
-				paddr += PAGE_SIZE;
+					pfn_pte(pfn, PAGE_KERNEL));
+				pfn++;
 				vaddr += PAGE_SIZE;
 			}
 		}
diff -ur arch/arm/mach-arc/mm.c arch/arm/mach-arc/mm.c
--- arch/arm/mach-arc/mm.c	Fri May  3 13:26:55 2002
+++ arch/arm/mach-arc/mm.c	Fri May  3 12:20:27 2002
@@ -138,7 +138,7 @@
 	page_nr = max_low_pfn;
 
 	pte = alloc_bootmem_low_pages(PTRS_PER_PTE * sizeof(pte_t));
-	pte[0] = mk_pte_phys(PAGE_OFFSET + 491520, PAGE_READONLY);
+	pte[0] = pfn_pte((PAGE_OFFSET + 491520) >> PAGE_SHIFT, PAGE_READONLY);
 	pmd_populate(&init_mm, pmd_offset(swapper_pg_dir, 0), pte);
 
 	for (i = 1; i < PTRS_PER_PGD; i++)
diff -ur arch/arm/mm/ioremap.c arch/arm/mm/ioremap.c
--- arch/arm/mm/ioremap.c	Fri May  3 13:26:55 2002
+++ arch/arm/mm/ioremap.c	Fri May  3 12:21:09 2002
@@ -51,7 +51,7 @@
 			printk("remap_area_pte: page already exists\n");
 			BUG();
 		}
-		set_pte(pte, mk_pte_phys(phys_addr, pgprot));
+		set_pte(pte, pfn_pte(phys_addr >> PAGE_SHIFT, pgprot));
 		address += PAGE_SIZE;
 		phys_addr += PAGE_SIZE;
 		pte++;
diff -ur arch/arm/mm/minicache.c arch/arm/mm/minicache.c
--- arch/arm/mm/minicache.c	Fri May  3 13:26:55 2002
+++ arch/arm/mm/minicache.c	Fri May  3 12:21:38 2002
@@ -43,7 +43,7 @@
  */
 unsigned long map_page_minicache(unsigned long virt)
 {
-	set_pte(minicache_pte, mk_pte_phys(__pa(virt), minicache_pgprot));
+	set_pte(minicache_pte, pfn_pte(__pa(virt) >> PAGE_SHIFT, minicache_pgprot));
 	flush_tlb_kernel_page(minicache_address);
 
 	return minicache_address;
diff -ur arch/arm/mm/mm-armv.c arch/arm/mm/mm-armv.c
--- arch/arm/mm/mm-armv.c	Fri May  3 13:26:55 2002
+++ arch/arm/mm/mm-armv.c	Fri May  3 12:21:51 2002
@@ -198,7 +198,7 @@
 	}
 	ptep = pte_offset_kernel(pmdp, virt);
 
-	set_pte(ptep, mk_pte_phys(phys, __pgprot(prot)));
+	set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, __pgprot(prot)));
 }
 
 /*
diff -ur arch/cris/mm/ioremap.c arch/cris/mm/ioremap.c
--- arch/cris/mm/ioremap.c	Fri May  3 13:26:55 2002
+++ arch/cris/mm/ioremap.c	Fri May  3 12:23:25 2002
@@ -17,6 +17,7 @@
 	unsigned long phys_addr, unsigned long flags)
 {
 	unsigned long end;
+	unsigned long pfn;
 
 	address &= ~PMD_MASK;
 	end = address + size;
@@ -24,16 +25,17 @@
 		end = PMD_SIZE;
 	if (address >= end)
 		BUG();
+	pfn = phys_addr >> PAGE_SHIFT;
 	do {
 		if (!pte_none(*pte)) {
 			printk("remap_area_pte: page already exists\n");
 			BUG();
 		}
-		set_pte(pte, mk_pte_phys(phys_addr, __pgprot(_PAGE_PRESENT | __READABLE | 
-							     __WRITEABLE | _PAGE_GLOBAL |
-							     _PAGE_KERNEL | flags)));
+		set_pte(pte, pfn_pte(pfn, __pgprot(_PAGE_PRESENT | __READABLE | 
+						   __WRITEABLE | _PAGE_GLOBAL |
+						   _PAGE_KERNEL | flags)));
 		address += PAGE_SIZE;
-		phys_addr += PAGE_SIZE;
+		pfn++;
 		pte++;
 	} while (address && (address < end));
 }
diff -ur arch/i386/kernel/acpi.c arch/i386/kernel/acpi.c
--- arch/i386/kernel/acpi.c	Fri May  3 13:26:55 2002
+++ arch/i386/kernel/acpi.c	Fri May  3 12:23:55 2002
@@ -550,7 +550,7 @@
 
 	/* fill page with low mapping */
 	for (i = 0; i < PTRS_PER_PTE; i++)
-		set_pte(ptep + i, mk_pte_phys(i << PAGE_SHIFT, PAGE_SHARED));
+		set_pte(ptep + i, pfn_pte(i, PAGE_SHARED));
 
 	pgd = pgd_offset(current->active_mm, 0);
 	pmd = pmd_alloc(current->mm,pgd, 0);
diff -ur arch/i386/mm/init.c arch/i386/mm/init.c
--- arch/i386/mm/init.c	Fri May  3 13:26:55 2002
+++ arch/i386/mm/init.c	Fri May  3 12:25:13 2002
@@ -122,7 +122,7 @@
 	}
 	pte = pte_offset_kernel(pmd, vaddr);
 	/* <phys,flags> stored as-is, to permit clearing entries */
-	set_pte(pte, mk_pte_phys(phys, flags));
+	set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
 
 	/*
 	 * It's enough to flush this one mapping.
@@ -239,7 +239,7 @@
 				vaddr = i*PGDIR_SIZE + j*PMD_SIZE + k*PAGE_SIZE;
 				if (end && (vaddr >= end))
 					break;
-				*pte = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);
+				*pte = pfn_pte(__pa(vaddr) >> PAGE_SHIFT, PAGE_KERNEL);
 			}
 			set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte_base)));
 			if (pte_base != pte_offset_kernel(pmd, 0))
@@ -375,7 +375,7 @@
 	pmd = pmd_offset(pgd, vaddr);
 	pte = pte_offset_kernel(pmd, vaddr);
 	old_pte = *pte;
-	*pte = mk_pte_phys(0, PAGE_READONLY);
+	*pte = pfn_pte(0, PAGE_READONLY);
 	local_flush_tlb();
 
 	boot_cpu_data.wp_works_ok = do_test_wp_bit(vaddr);
diff -ur arch/i386/mm/ioremap.c arch/i386/mm/ioremap.c
--- arch/i386/mm/ioremap.c	Fri May  3 13:26:55 2002
+++ arch/i386/mm/ioremap.c	Fri May  3 12:26:39 2002
@@ -20,6 +20,7 @@
 	unsigned long phys_addr, unsigned long flags)
 {
 	unsigned long end;
+	unsigned long pfn;
 
 	address &= ~PMD_MASK;
 	end = address + size;
@@ -27,15 +28,16 @@
 		end = PMD_SIZE;
 	if (address >= end)
 		BUG();
+	pfn = phys_addr >> PAGE_SHIFT;
 	do {
 		if (!pte_none(*pte)) {
 			printk("remap_area_pte: page already exists\n");
 			BUG();
 		}
-		set_pte(pte, mk_pte_phys(phys_addr, __pgprot(_PAGE_PRESENT | _PAGE_RW | 
+		set_pte(pte, pfn_pte(pfn, __pgprot(_PAGE_PRESENT | _PAGE_RW | 
 					_PAGE_DIRTY | _PAGE_ACCESSED | flags)));
 		address += PAGE_SIZE;
-		phys_addr += PAGE_SIZE;
+		pfn++;
 		pte++;
 	} while (address && (address < end));
 }
diff -ur arch/ia64/kernel/efi.c arch/ia64/kernel/efi.c
--- arch/ia64/kernel/efi.c	Fri May  3 13:26:55 2002
+++ arch/ia64/kernel/efi.c	Fri May  3 12:27:07 2002
@@ -268,7 +268,7 @@
 		 */
 		ia64_clear_ic(flags);
 		ia64_itr(0x1, IA64_TR_PALCODE, vaddr & mask,
-			 pte_val(mk_pte_phys(md->phys_addr, PAGE_KERNEL)), IA64_GRANULE_SHIFT);
+			 pte_val(pfn_pte(md->phys_addr >> PAGE_SHIFT, PAGE_KERNEL)), IA64_GRANULE_SHIFT);
 		local_irq_restore(flags);
 		ia64_srlz_i();
 	}
diff -ur arch/ia64/mm/init.c arch/ia64/mm/init.c
--- arch/ia64/mm/init.c	Fri May  3 13:27:09 2002
+++ arch/ia64/mm/init.c	Fri May  3 12:27:24 2002
@@ -291,7 +291,7 @@
 	ia64_srlz_d();
 
 	ia64_itr(0x2, IA64_TR_PERCPU_DATA, PERCPU_ADDR,
-		 pte_val(mk_pte_phys(__pa(my_cpu_data), PAGE_KERNEL)), PAGE_SHIFT);
+		 pte_val(pfn_pte(__pa(my_cpu_data) >> PAGE_SHIFT, PAGE_KERNEL)), PAGE_SHIFT);
 
 	__restore_flags(flags);
 	ia64_srlz_i();
diff -ur arch/ia64/sn/kernel/misctest.c arch/ia64/sn/kernel/misctest.c
--- arch/ia64/sn/kernel/misctest.c	Fri May  3 13:26:55 2002
+++ arch/ia64/sn/kernel/misctest.c	Fri May  3 12:27:49 2002
@@ -89,7 +89,7 @@
 			printk("zzzspec: probe %ld, 0x%lx\n", res, val);
 			ia64_clear_ic(flags);
 			ia64_itc(0x2, 0xe00000ff00000000UL,
-			          pte_val(mk_pte_phys(0xff00000000UL,
+			          pte_val(pfn_pte(0xff00000000UL >> PAGE_SHIFT,
 				  __pgprot(__DIRTY_BITS|_PAGE_PL_0|_PAGE_AR_RW))), _PAGE_SIZE_256M);
 			local_irq_restore(flags);
 			ia64_srlz_i ();
diff -ur arch/mips/gt64120/momenco_ocelot/setup.c arch/mips/gt64120/momenco_ocelot/setup.c
--- arch/mips/gt64120/momenco_ocelot/setup.c	Fri May  3 13:26:55 2002
+++ arch/mips/gt64120/momenco_ocelot/setup.c	Fri May  3 12:28:15 2002
@@ -78,7 +78,7 @@
 
 static char reset_reason;
 
-#define ENTRYLO(x) ((pte_val(mk_pte_phys((x), PAGE_KERNEL_UNCACHED)) >> 6)|1)
+#define ENTRYLO(x) ((pte_val(pfn_pte((x) >> PAGE_SHIFT, PAGE_KERNEL_UNCACHED)) >> 6)|1)
 
 static void __init setup_l3cache(unsigned long size);
 
diff -ur arch/mips/mm/ioremap.c arch/mips/mm/ioremap.c
--- arch/mips/mm/ioremap.c	Fri May  3 13:26:55 2002
+++ arch/mips/mm/ioremap.c	Fri May  3 12:29:04 2002
@@ -18,6 +18,7 @@
 	unsigned long phys_addr, unsigned long flags)
 {
 	unsigned long end;
+	unsigned long pfn;
 	pgprot_t pgprot = __pgprot(_PAGE_GLOBAL | _PAGE_PRESENT | __READABLE
 	                           | __WRITEABLE | flags);
 
@@ -27,14 +28,15 @@
 		end = PMD_SIZE;
 	if (address >= end)
 		BUG();
+	pfn = phys_addr >> PAGE_SHIFT;
 	do {
 		if (!pte_none(*pte)) {
 			printk("remap_area_pte: page already exists\n");
 			BUG();
 		}
-		set_pte(pte, mk_pte_phys(phys_addr, pgprot));
+		set_pte(pte, pfn_pte(pfn, pgprot));
 		address += PAGE_SIZE;
-		phys_addr += PAGE_SIZE;
+		pfn++;
 		pte++;
 	} while (address && (address < end));
 }
diff -ur arch/ppc/mm/pgtable.c arch/ppc/mm/pgtable.c
--- arch/ppc/mm/pgtable.c	Fri May  3 13:26:55 2002
+++ arch/ppc/mm/pgtable.c	Fri May  3 12:29:36 2002
@@ -237,7 +237,7 @@
 	pg = pte_alloc_kernel(&init_mm, pd, va);
 	if (pg != 0) {
 		err = 0;
-		set_pte(pg, mk_pte_phys(pa & PAGE_MASK, __pgprot(flags)));
+		set_pte(pg, pfn_pte(pa >> PAGE_SHIFT, __pgprot(flags)));
 		if (mem_init_done)
 			flush_HPTE(0, va, pmd_val(*pd));
 	}
diff -ur arch/ppc64/mm/init.c arch/ppc64/mm/init.c
--- arch/ppc64/mm/init.c	Fri May  3 13:26:55 2002
+++ arch/ppc64/mm/init.c	Fri May  3 12:30:02 2002
@@ -240,7 +240,7 @@
 		ptep = pte_alloc_kernel(&ioremap_mm, pmdp, ea);
 
 		pa = absolute_to_phys(pa);
-		set_pte(ptep, mk_pte_phys(pa & PAGE_MASK, __pgprot(flags)));
+		set_pte(ptep, pfn_pte(pa >> PAGE_SHIFT, __pgprot(flags)));
 		spin_unlock(&ioremap_mm.page_table_lock);
 	} else {
 		/* If the mm subsystem is not fully up, we cannot create a
diff -ur arch/s390/mm/init.c arch/s390/mm/init.c
--- arch/s390/mm/init.c	Fri May  3 13:26:55 2002
+++ arch/s390/mm/init.c	Fri May  3 13:31:18 2002
@@ -118,9 +118,8 @@
         pte_t   pte;
 	int     i;
         unsigned long tmp;
-        unsigned long address=0;
+        unsigned long pfn = 0;
         unsigned long pgdir_k = (__pa(swapper_pg_dir) & PAGE_MASK) | _KERNSEG_TABLE;
-	unsigned long end_mem = (unsigned long) __va(max_low_pfn*PAGE_SIZE);
         static const int ssm_mask = 0x04000000L;
 
 	/* unmap whole virtual address space */
@@ -136,7 +135,7 @@
 
         pg_dir = swapper_pg_dir;
 
-        while (address < end_mem) {
+        while (pfn < max_low_pfn) {
                 /*
                  * pg_table is physical at this point
                  */
@@ -149,11 +148,11 @@
                 pg_dir++;
 
                 for (tmp = 0 ; tmp < PTRS_PER_PTE ; tmp++,pg_table++) {
-                        pte = mk_pte_phys(address, PAGE_KERNEL);
-                        if (address >= end_mem)
+                        pte = pfn_pte(pfn, PAGE_KERNEL);
+                        if (pfn >= max_low_pfn)
                                 pte_clear(&pte);
                         set_pte(pg_table, pte);
-                        address += PAGE_SIZE;
+                        pfn++;
                 }
         }
 
diff -ur arch/s390/mm/ioremap.c arch/s390/mm/ioremap.c
--- arch/s390/mm/ioremap.c	Fri May  3 13:26:55 2002
+++ arch/s390/mm/ioremap.c	Fri May  3 13:33:18 2002
@@ -21,6 +21,7 @@
         unsigned long phys_addr, unsigned long flags)
 {
         unsigned long end;
+        unsigned long pfn;
 
         address &= ~PMD_MASK;
         end = address + size;
@@ -28,15 +29,15 @@
                 end = PMD_SIZE;
 	if (address >= end)
 		BUG();
+        pfn = phys_addr >> PAGE_SHIFT;
         do {
                 if (!pte_none(*pte)) {
                         printk("remap_area_pte: page already exists\n");
 			BUG();
 		}
-                set_pte(pte, mk_pte_phys(phys_addr,
-                                         __pgprot(_PAGE_PRESENT | flags)));
+                set_pte(pte, pfn_pte(pfn, __pgprot(_PAGE_PRESENT | flags)));
                 address += PAGE_SIZE;
-                phys_addr += PAGE_SIZE;
+                pfn++;
                 pte++;
         } while (address && (address < end));
 }
diff -ur arch/s390x/mm/init.c arch/s390x/mm/init.c
--- arch/s390x/mm/init.c	Fri May  3 13:26:55 2002
+++ arch/s390x/mm/init.c	Fri May  3 13:33:47 2002
@@ -116,10 +116,9 @@
         pte_t * pt_dir;
         pte_t   pte;
 	int     i,j,k;
-        unsigned long address=0;
+        unsigned long pfn = 0;
         unsigned long pgdir_k = (__pa(swapper_pg_dir) & PAGE_MASK) |
           _KERN_REGION_TABLE;
-	unsigned long end_mem = (unsigned long) __va(max_low_pfn*PAGE_SIZE);
 	static const int ssm_mask = 0x04000000L;
 
 	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
@@ -147,7 +146,7 @@
 	
         for (i = 0 ; i < PTRS_PER_PGD ; i++,pg_dir++) {
 
-                if (address >= end_mem) {
+                if (pfn >= max_low_pfn) {
                         pgd_clear(pg_dir);
                         continue;
                 }          
@@ -156,7 +155,7 @@
                 pgd_populate(&init_mm, pg_dir, pm_dir);
 
                 for (j = 0 ; j < PTRS_PER_PMD ; j++,pm_dir++) {
-                        if (address >= end_mem) {
+                        if (pfn >= max_low_pfn) {
                                 pmd_clear(pm_dir);
                                 continue; 
                         }          
@@ -165,13 +164,13 @@
                         pmd_populate(&init_mm, pm_dir, pt_dir);
 	
                         for (k = 0 ; k < PTRS_PER_PTE ; k++,pt_dir++) {
-                                pte = mk_pte_phys(address, PAGE_KERNEL);
-                                if (address >= end_mem) {
+                                pte = mk_pte_phys(pfn, PAGE_KERNEL);
+                                if (pfn >= max_low_pfn) {
                                         pte_clear(&pte); 
                                         continue;
                                 }
                                 set_pte(pt_dir, pte);
-                                address += PAGE_SIZE;
+                                pfn++;
                         }
                 }
         }
diff -ur arch/s390x/mm/ioremap.c arch/s390x/mm/ioremap.c
--- arch/s390x/mm/ioremap.c	Fri May  3 13:26:55 2002
+++ arch/s390x/mm/ioremap.c	Fri May  3 13:34:25 2002
@@ -21,6 +21,7 @@
         unsigned long phys_addr, unsigned long flags)
 {
         unsigned long end;
+        unsigned long pfn;
 
         address &= ~PMD_MASK;
         end = address + size;
@@ -28,15 +29,15 @@
                 end = PMD_SIZE;
 	if (address >= end)
 		BUG();
+        pfn = phys_addr >> PAGE_SHIFT;
         do {
                 if (!pte_none(*pte)) {
                         printk("remap_area_pte: page already exists\n");
 			BUG();
 		}
-                set_pte(pte, mk_pte_phys(phys_addr,
-                                         __pgprot(_PAGE_PRESENT | flags)));
+                set_pte(pte, pfn_pte(pfn, __pgprot(_PAGE_PRESENT | flags)));
                 address += PAGE_SIZE;
-                phys_addr += PAGE_SIZE;
+                pfn++;
                 pte++;
         } while (address && (address < end));
 }
diff -ur arch/sh/mm/cache-sh4.c arch/sh/mm/cache-sh4.c
--- arch/sh/mm/cache-sh4.c	Fri May  3 13:26:55 2002
+++ arch/sh/mm/cache-sh4.c	Fri May  3 12:49:40 2002
@@ -398,7 +398,7 @@
 		pte_t entry;
 		unsigned long flags;
 
-		entry = mk_pte_phys(phys_addr, pgprot);
+		entry = pfn_pte(phys_addr >> PAGE_SHIFT, pgprot);
 		down(&p3map_sem[(address & CACHE_ALIAS)>>12]);
 		set_pte(pte, entry);
 		save_and_cli(flags);
@@ -437,7 +437,7 @@
 		pte_t entry;
 		unsigned long flags;
 
-		entry = mk_pte_phys(phys_addr, pgprot);
+		entry = pfn_pte(phys_addr >> PAGE_SHIFT, pgprot);
 		down(&p3map_sem[(address & CACHE_ALIAS)>>12]);
 		set_pte(pte, entry);
 		save_and_cli(flags);
diff -ur arch/sh/mm/ioremap.c arch/sh/mm/ioremap.c
--- arch/sh/mm/ioremap.c	Fri May  3 13:26:55 2002
+++ arch/sh/mm/ioremap.c	Fri May  3 12:50:36 2002
@@ -17,6 +17,7 @@
 	unsigned long size, unsigned long phys_addr, unsigned long flags)
 {
 	unsigned long end;
+	unsigned long pfn;
 	pgprot_t pgprot = __pgprot(_PAGE_PRESENT | _PAGE_RW |
 				   _PAGE_DIRTY | _PAGE_ACCESSED |
 				   _PAGE_HW_SHARED | _PAGE_FLAGS_HARD | flags);
@@ -27,14 +28,15 @@
 		end = PMD_SIZE;
 	if (address >= end)
 		BUG();
+	pfn = phys_addr >> PAGE_SHIFT;
 	do {
 		if (!pte_none(*pte)) {
 			printk("remap_area_pte: page already exists\n");
 			BUG();
 		}
-		set_pte(pte, mk_pte_phys(phys_addr, pgprot));
+		set_pte(pte, pfn_pte(pfn, pgprot));
 		address += PAGE_SIZE;
-		phys_addr += PAGE_SIZE;
+		pfn++;
 		pte++;
 	} while (address && (address < end));
 }
diff -ur arch/sparc/mm/srmmu.c arch/sparc/mm/srmmu.c
--- arch/sparc/mm/srmmu.c	Fri May  3 13:26:55 2002
+++ arch/sparc/mm/srmmu.c	Fri May  3 12:51:41 2002
@@ -2043,7 +2043,7 @@
 	BTFIXUPSET_CALL(pgd_clear, srmmu_pgd_clear, BTFIXUPCALL_SWAPO0G0);
 
 	BTFIXUPSET_CALL(mk_pte, srmmu_mk_pte, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(mk_pte_phys, srmmu_mk_pte_phys, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(pfn_pte, srmmu_pfn_pte, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(mk_pte_io, srmmu_mk_pte_io, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pgd_set, srmmu_pgd_set, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pmd_set, srmmu_pmd_set, BTFIXUPCALL_NORM);
diff -ur arch/sparc/mm/sun4c.c arch/sparc/mm/sun4c.c
--- arch/sparc/mm/sun4c.c	Fri May  3 13:27:09 2002
+++ arch/sparc/mm/sun4c.c	Fri May  3 12:52:01 2002
@@ -2526,7 +2526,7 @@
 	BTFIXUPSET_CALL(pgd_clear, sun4c_pgd_clear, BTFIXUPCALL_NOP);
 
 	BTFIXUPSET_CALL(mk_pte, sun4c_mk_pte, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(mk_pte_phys, sun4c_mk_pte_phys, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(pfn_pte, sun4c_pfn_pte, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(mk_pte_io, sun4c_mk_pte_io, BTFIXUPCALL_NORM);
 	
 	BTFIXUPSET_INT(pte_modify_mask, _SUN4C_PAGE_CHG_MASK);
diff -ur arch/x86_64/mm/init.c arch/x86_64/mm/init.c
--- arch/x86_64/mm/init.c	Fri May  3 13:26:57 2002
+++ arch/x86_64/mm/init.c	Fri May  3 12:52:23 2002
@@ -125,7 +125,7 @@
 	pte = pte_offset_kernel(pmd, vaddr);
 	if (pte_val(*pte))
 		pte_ERROR(*pte);
-	set_pte(pte, mk_pte_phys(phys, prot));
+	set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, prot));
 
 	/*
 	 * It's enough to flush this one mapping.
diff -ur arch/x86_64/mm/ioremap.c arch/x86_64/mm/ioremap.c
--- arch/x86_64/mm/ioremap.c	Fri May  3 13:26:57 2002
+++ arch/x86_64/mm/ioremap.c	Fri May  3 12:53:25 2002
@@ -20,6 +20,7 @@
 	unsigned long phys_addr, unsigned long flags)
 {
 	unsigned long end;
+	unsigned long pfn;
 
 	address &= ~PMD_MASK;
 	end = address + size;
@@ -27,15 +28,16 @@
 		end = PMD_SIZE;
 	if (address >= end)
 		BUG();
+	pfn = phys_addr >> PAGE_SHIFT;
 	do {
 		if (!pte_none(*pte)) {
 			printk("remap_area_pte: page already exists\n");
 			BUG();
 		}
-		set_pte(pte, mk_pte_phys(phys_addr, __pgprot(_PAGE_PRESENT | _PAGE_RW | 
+		set_pte(pte, pfn_pte(pfn, __pgprot(_PAGE_PRESENT | _PAGE_RW | 
 					_PAGE_GLOBAL | _PAGE_DIRTY | _PAGE_ACCESSED | flags)));
 		address += PAGE_SIZE;
-		phys_addr += PAGE_SIZE;
+		pfn++;
 		pte++;
 	} while (address && (address < end));
 }
Only in drivers/pci: classlist.h
diff -ur include/asm-i386/pgtable-2level.h include/asm-i386/pgtable-2level.h
--- include/asm-i386/pgtable-2level.h	Fri May  3 13:36:44 2002
+++ include/asm-i386/pgtable-2level.h	Fri May  3 14:31:39 2002
@@ -59,6 +59,6 @@
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 #define pte_none(x)		(!(x).pte_low)
 #define pte_pfn(x)		((unsigned long)(((x).pte_low >> PAGE_SHIFT)))
-#define __mk_pte(page_nr,pgprot) __pte(((page_nr) << PAGE_SHIFT) | pgprot_val(pgprot))
+#define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
 #endif /* _I386_PGTABLE_2LEVEL_H */
diff -ur include/asm-i386/pgtable-3level.h include/asm-i386/pgtable-3level.h
--- include/asm-i386/pgtable-3level.h	Fri May  3 13:37:08 2002
+++ include/asm-i386/pgtable-3level.h	Fri May  3 13:04:35 2002
@@ -90,7 +90,7 @@
 #define pte_none(x)	(!(x).pte_low && !(x).pte_high)
 #define pte_pfn(x)	(((x).pte_low >> PAGE_SHIFT) | ((x).pte_high << (32 - PAGE_SHIFT)))
 
-static inline pte_t __mk_pte(unsigned long page_nr, pgprot_t pgprot)
+static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
 {
 	pte_t pte;
 
diff -ur include/asm-i386/pgtable.h include/asm-i386/pgtable.h
--- include/asm-i386/pgtable.h	Fri May  3 13:26:57 2002
+++ include/asm-i386/pgtable.h	Fri May  3 14:40:39 2002
@@ -229,10 +229,7 @@
  * and a page entry and page directory to the page they refer to.
  */
 
-#define mk_pte(page, pgprot)	__mk_pte((page) - mem_map, (pgprot))
-
-/* This takes a physical page address that is used by the remapping functions */
-#define mk_pte_phys(physpage, pgprot)	__mk_pte((physpage) >> PAGE_SHIFT, pgprot)
+#define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
diff -ur mm/memory.c mm/memory.c
--- mm/memory.c	Fri May  3 13:27:09 2002
+++ mm/memory.c	Fri May  3 12:55:10 2002
@@ -866,21 +866,22 @@
 	unsigned long phys_addr, pgprot_t prot)
 {
 	unsigned long end;
+	unsigned long pfn;
 
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
 		end = PMD_SIZE;
+	pfn = phys_addr >> PAGE_SHIFT;
 	do {
 		struct page *page;
 		pte_t oldpage = ptep_get_and_clear(pte);
-		unsigned long pfn = phys_addr >> PAGE_SHIFT;
 
 		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
- 			set_pte(pte, mk_pte_phys(phys_addr, prot));
+ 			set_pte(pte, pfn_pte(pfn, prot));
 		forget_pte(oldpage);
 		address += PAGE_SIZE;
-		phys_addr += PAGE_SIZE;
+		pfn++;
 		pte++;
 	} while (address && (address < end));
 }


