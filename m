Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312562AbSCUXVY>; Thu, 21 Mar 2002 18:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312563AbSCUXVN>; Thu, 21 Mar 2002 18:21:13 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:61853 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312562AbSCUXUz>; Thu, 21 Mar 2002 18:20:55 -0500
Date: Thu, 21 Mar 2002 15:20:23 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: gerrit@us.ibm.com
Subject: Re: Backport of Ingo/Arjan highpte to 2.4.18 (+O1 scheduler)
Message-ID: <245100000.1016752823@flay>
In-Reply-To: <242250000.1016752254@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The smaller two patches they published against 2.5.5 work fine, but
> the main one needed a little work - this seems to work for me, but
> I've only really touch tested it ... just thought this might save someone
> some time .... there didn't seem to be anything too complex in the merge,
> but that doesn't necessarily mean I got it right ;-)

Sigh .... old version ... forgot to rediff. Working version below - sorry.

diff -urN linux-2.4.18-prepte/arch/i386/config.in linux-2.4.18-highpte/arch/i386/config.in
--- linux-2.4.18-prepte/arch/i386/config.in	Mon Feb 25 11:37:52 2002
+++ linux-2.4.18-highpte/arch/i386/config.in	Thu Mar 21 17:37:29 2002
@@ -171,16 +171,27 @@
 tristate '/dev/cpu/*/cpuid - CPU information support' CONFIG_X86_CPUID
 
 choice 'High Memory Support' \
-	"off    CONFIG_NOHIGHMEM \
-	 4GB    CONFIG_HIGHMEM4G \
-	 64GB   CONFIG_HIGHMEM64G" off
+	"off           CONFIG_NOHIGHMEM \
+	 4GB           CONFIG_HIGHMEM4G \
+	 4GB-highpte   CONFIG_HIGHMEM4G_HIGHPTE \
+	 64GB          CONFIG_HIGHMEM64G \
+	 64GB-highpte  CONFIG_HIGHMEM64G_HIGHPTE" off
 if [ "$CONFIG_HIGHMEM4G" = "y" ]; then
    define_bool CONFIG_HIGHMEM y
 fi
+if [ "$CONFIG_HIGHMEM4G_HIGHPTE" = "y" ]; then
+   define_bool CONFIG_HIGHMEM y
+   define_bool CONFIG_HIGHPTE y
+fi
 if [ "$CONFIG_HIGHMEM64G" = "y" ]; then
    define_bool CONFIG_HIGHMEM y
    define_bool CONFIG_X86_PAE y
 fi
+if [ "$CONFIG_HIGHMEM64G_HIGHPTE" = "y" ]; then
+   define_bool CONFIG_HIGHMEM y
+   define_bool CONFIG_HIGHPTE y
+   define_bool CONFIG_X86_PAE y
+fi
 
 bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
@@ -416,11 +427,13 @@
 
 bool 'Kernel debugging' CONFIG_DEBUG_KERNEL
 if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; then
-   bool '  Debug high memory support' CONFIG_DEBUG_HIGHMEM
    bool '  Debug memory allocations' CONFIG_DEBUG_SLAB
    bool '  Memory mapped I/O debugging' CONFIG_DEBUG_IOVIRT
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
+   if [ "$CONFIG_HIGHMEM" = "y" ]; then
+      bool '  Highmem debugging' CONFIG_DEBUG_HIGHMEM
+   fi
    bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
 fi
 
diff -urN linux-2.4.18-prepte/arch/i386/kernel/process.c linux-2.4.18-highpte/arch/i386/kernel/process.c
--- linux-2.4.18-prepte/arch/i386/kernel/process.c	Thu Mar 21 19:20:08 2002
+++ linux-2.4.18-highpte/arch/i386/kernel/process.c	Thu Mar 21 17:37:29 2002
@@ -132,7 +132,6 @@
 		if (!current->need_resched)
 			idle();
 		schedule();
-		check_pgt_cache();
 	}
 }
 
diff -urN linux-2.4.18-prepte/arch/i386/kernel/smpboot.c linux-2.4.18-highpte/arch/i386/kernel/smpboot.c
--- linux-2.4.18-prepte/arch/i386/kernel/smpboot.c	Thu Mar 21 19:20:08 2002
+++ linux-2.4.18-highpte/arch/i386/kernel/smpboot.c	Thu Mar 21 17:37:29 2002
@@ -144,10 +144,6 @@
 	struct cpuinfo_x86 *c = cpu_data + id;
 
 	*c = boot_cpu_data;
-	c->pte_quick = 0;
-	c->pmd_quick = 0;
-	c->pgd_quick = 0;
-	c->pgtable_cache_sz = 0;
 	identify_cpu(c);
 	/*
 	 * Mask B, Pentium, but not Pentium MMX
diff -urN linux-2.4.18-prepte/arch/i386/kernel/traps.c linux-2.4.18-highpte/arch/i386/kernel/traps.c
--- linux-2.4.18-prepte/arch/i386/kernel/traps.c	Sun Sep 30 12:26:08 2001
+++ linux-2.4.18-highpte/arch/i386/kernel/traps.c	Thu Mar 21 17:37:29 2002
@@ -734,7 +734,7 @@
 	page = (unsigned long) vmalloc(PAGE_SIZE);
 	pgd = pgd_offset(&init_mm, page);
 	pmd = pmd_offset(pgd, page);
-	pte = pte_offset(pmd, page);
+	pte = pte_offset_kernel(pmd, page);
 	__free_page(pte_page(*pte));
 	*pte = mk_pte_phys(__pa(&idt_table), PAGE_KERNEL_RO);
 	/*
diff -urN linux-2.4.18-prepte/arch/i386/kernel/vm86.c linux-2.4.18-highpte/arch/i386/kernel/vm86.c
--- linux-2.4.18-prepte/arch/i386/kernel/vm86.c	Mon Feb 25 11:37:53 2002
+++ linux-2.4.18-highpte/arch/i386/kernel/vm86.c	Thu Mar 21 19:43:19 2002
@@ -94,7 +94,7 @@
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
-	pte_t *pte;
+	pte_t *pte, *mapped;
 	int i;
 
 	pgd = pgd_offset(tsk->mm, 0xA0000);
@@ -113,12 +113,13 @@
 		pmd_clear(pmd);
 		return;
 	}
-	pte = pte_offset(pmd, 0xA0000);
+	pte = mapped = pte_offset_map(pmd, 0xA0000);
 	for (i = 0; i < 32; i++) {
 		if (pte_present(*pte))
 			set_pte(pte, pte_wrprotect(*pte));
 		pte++;
 	}
+	pte_unmap(mapped);
 	flush_tlb();
 }
 
diff -urN linux-2.4.18-prepte/arch/i386/mm/fault.c linux-2.4.18-highpte/arch/i386/mm/fault.c
--- linux-2.4.18-prepte/arch/i386/mm/fault.c	Thu Mar 21 19:20:08 2002
+++ linux-2.4.18-highpte/arch/i386/mm/fault.c	Thu Mar 21 17:37:29 2002
@@ -324,12 +324,20 @@
 	asm("movl %%cr3,%0":"=r" (page));
 	page = ((unsigned long *) __va(page))[address >> 22];
 	printk(KERN_ALERT "*pde = %08lx\n", page);
+	/*
+	 * We must not directly access the pte in the highpte
+	 * case, the page table might be allocated in highmem.
+	 * And lets rather not kmap-atomic the pte, just in case
+	 * it's allocated already.
+	 */
+#ifndef CONFIG_HIGHPTE
 	if (page & 1) {
 		page &= PAGE_MASK;
 		address &= 0x003ff000;
 		page = ((unsigned long *) __va(page))[address >> PAGE_SHIFT];
 		printk(KERN_ALERT "*pte = %08lx\n", page);
 	}
+#endif
 	die("Oops", regs, error_code);
 	bust_spinlocks(0);
 	do_exit(SIGKILL);
@@ -399,7 +407,7 @@
 			goto no_context;
 		set_pmd(pmd, *pmd_k);
 
-		pte_k = pte_offset(pmd_k, address);
+		pte_k = pte_offset_kernel(pmd_k, address);
 		if (!pte_present(*pte_k))
 			goto no_context;
 		return;
diff -urN linux-2.4.18-prepte/arch/i386/mm/init.c linux-2.4.18-highpte/arch/i386/mm/init.c
--- linux-2.4.18-prepte/arch/i386/mm/init.c	Fri Dec 21 09:41:53 2001
+++ linux-2.4.18-highpte/arch/i386/mm/init.c	Thu Mar 21 17:37:29 2002
@@ -43,28 +43,6 @@
 static unsigned long totalram_pages;
 static unsigned long totalhigh_pages;
 
-int do_check_pgt_cache(int low, int high)
-{
-	int freed = 0;
-	if(pgtable_cache_size > high) {
-		do {
-			if (pgd_quicklist) {
-				free_pgd_slow(get_pgd_fast());
-				freed++;
-			}
-			if (pmd_quicklist) {
-				pmd_free_slow(pmd_alloc_one_fast(NULL, 0));
-				freed++;
-			}
-			if (pte_quicklist) {
-				pte_free_slow(pte_alloc_one_fast(NULL, 0));
-				freed++;
-			}
-		} while(pgtable_cache_size > low);
-	}
-	return freed;
-}
-
 /*
  * NOTE: pagetable_init alloc all the fixmap pagetables contiguous on the
  * physical space so we can cache the place of the first one and move
@@ -76,7 +54,7 @@
 pgprot_t kmap_prot;
 
 #define kmap_get_fixmap_pte(vaddr)					\
-	pte_offset(pmd_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr))
+	pte_offset_kernel(pmd_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr))
 
 void __init kmap_init(void)
 {
@@ -116,7 +94,6 @@
 	printk("%d reserved pages\n",reserved);
 	printk("%d pages shared\n",shared);
 	printk("%d pages swap cached\n",cached);
-	printk("%ld pages in page table cache\n",pgtable_cache_size);
 	show_buffers();
 }
 
@@ -143,7 +120,7 @@
 		printk("PAE BUG #01!\n");
 		return;
 	}
-	pte = pte_offset(pmd, vaddr);
+	pte = pte_offset_kernel(pmd, vaddr);
 	if (pte_val(*pte))
 		pte_ERROR(*pte);
 	pgprot_val(prot) = pgprot_val(PAGE_KERNEL) | pgprot_val(flags);
@@ -196,7 +173,7 @@
 			if (pmd_none(*pmd)) {
 				pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
 				set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte)));
-				if (pte != pte_offset(pmd, 0))
+				if (pte != pte_offset_kernel(pmd, 0))
 					BUG();
 			}
 			vaddr += PMD_SIZE;
@@ -267,7 +244,7 @@
 				*pte = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);
 			}
 			set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte_base)));
-			if (pte_base != pte_offset(pmd, 0))
+			if (pte_base != pte_offset_kernel(pmd, 0))
 				BUG();
 
 		}
@@ -289,7 +266,7 @@
 
 	pgd = swapper_pg_dir + __pgd_offset(vaddr);
 	pmd = pmd_offset(pgd, vaddr);
-	pte = pte_offset(pmd, vaddr);
+	pte = pte_offset_kernel(pmd, vaddr);
 	pkmap_page_table = pte;
 #endif
 
@@ -398,7 +375,7 @@
 
 	pgd = swapper_pg_dir + __pgd_offset(vaddr);
 	pmd = pmd_offset(pgd, vaddr);
-	pte = pte_offset(pmd, vaddr);
+	pte = pte_offset_kernel(pmd, vaddr);
 	old_pte = *pte;
 	*pte = mk_pte_phys(0, PAGE_READONLY);
 	local_flush_tlb();
diff -urN linux-2.4.18-prepte/arch/i386/mm/ioremap.c linux-2.4.18-highpte/arch/i386/mm/ioremap.c
--- linux-2.4.18-prepte/arch/i386/mm/ioremap.c	Tue Mar 20 08:13:33 2001
+++ linux-2.4.18-highpte/arch/i386/mm/ioremap.c	Thu Mar 21 17:37:29 2002
@@ -49,7 +49,7 @@
 	if (address >= end)
 		BUG();
 	do {
-		pte_t * pte = pte_alloc(&init_mm, pmd, address);
+		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, address);
 		if (!pte)
 			return -ENOMEM;
 		remap_area_pte(pte, address, end - address, address + phys_addr, flags);
diff -urN linux-2.4.18-prepte/drivers/char/drm/drm_proc.h linux-2.4.18-highpte/drivers/char/drm/drm_proc.h
--- linux-2.4.18-prepte/drivers/char/drm/drm_proc.h	Thu Nov 22 11:46:37 2001
+++ linux-2.4.18-highpte/drivers/char/drm/drm_proc.h	Thu Mar 21 19:36:14 2002
@@ -449,7 +449,7 @@
 		for (i = vma->vm_start; i < vma->vm_end; i += PAGE_SIZE) {
 			pgd = pgd_offset(vma->vm_mm, i);
 			pmd = pmd_offset(pgd, i);
-			pte = pte_offset(pmd, i);
+			pte = pte_offset_map(pmd, i);
 			if (pte_present(*pte)) {
 				address = __pa(pte_page(*pte))
 					+ (i & (PAGE_SIZE-1));
@@ -465,6 +465,7 @@
 			} else {
 				DRM_PROC_PRINT("      0x%08lx\n", i);
 			}
+			pte_unmap(pte);
 		}
 #endif
 	}
diff -urN linux-2.4.18-prepte/drivers/char/drm/drm_scatter.h linux-2.4.18-highpte/drivers/char/drm/drm_scatter.h
--- linux-2.4.18-prepte/drivers/char/drm/drm_scatter.h	Thu Nov 22 11:46:37 2001
+++ linux-2.4.18-highpte/drivers/char/drm/drm_scatter.h	Thu Mar 21 19:36:28 2002
@@ -143,9 +143,12 @@
 		if ( !pmd_present( *pmd ) )
 			goto failed;
 
-		pte = pte_offset( pmd, i );
-		if ( !pte_present( *pte ) )
+		pte = pte_offset_map( pmd, i );
+		if ( !pte_present( *pte ) ) {
+			pte_unmap(pte);
 			goto failed;
+		}
+		pte_unmap(pte);
 
 		entry->pagelist[j] = pte_page( *pte );
 
diff -urN linux-2.4.18-prepte/drivers/char/drm/drm_vm.h linux-2.4.18-highpte/drivers/char/drm/drm_vm.h
--- linux-2.4.18-prepte/drivers/char/drm/drm_vm.h	Thu Nov 22 11:46:37 2001
+++ linux-2.4.18-highpte/drivers/char/drm/drm_vm.h	Thu Mar 21 19:42:30 2002
@@ -169,8 +169,12 @@
 	if( !pgd_present( *pgd ) ) return NOPAGE_OOM;
 	pmd = pmd_offset( pgd, i );
 	if( !pmd_present( *pmd ) ) return NOPAGE_OOM;
-	pte = pte_offset( pmd, i );
-	if( !pte_present( *pte ) ) return NOPAGE_OOM;
+	pte = pte_offset_map( pmd, i );
+	if( !pte_present( *pte ) ) {
+		pte_unmap(pte);
+		return NOPAGE_OOM;
+	}
+	pte_unmap(pte);
 
 	page = pte_page(*pte);
 	get_page(page);
diff -urN linux-2.4.18-prepte/drivers/sgi/char/graphics.c linux-2.4.18-highpte/drivers/sgi/char/graphics.c
--- linux-2.4.18-prepte/drivers/sgi/char/graphics.c	Thu Oct 11 09:43:30 2001
+++ linux-2.4.18-highpte/drivers/sgi/char/graphics.c	Thu Mar 21 17:37:24 2002
@@ -221,6 +221,7 @@
 	int board = GRAPHICS_CARD (vma->vm_dentry->d_inode->i_rdev);
 
 	unsigned long virt_add, phys_add;
+	struct page * page;
 
 #ifdef DEBUG
 	printk ("Got a page fault for board %d address=%lx guser=%lx\n", board,
@@ -247,8 +248,10 @@
 
 	pgd = pgd_offset(current->mm, address);
 	pmd = pmd_offset(pgd, address);
-	pte = pte_offset(pmd, address);
-	return pte_page(*pte);
+	pte = pte_kmap_offset(pmd, address);
+	page = pte_page(*pte);
+	pte_kunmap(pte);
+	return page;
 }
 
 /*
diff -urN linux-2.4.18-prepte/drivers/usb/stv680.c linux-2.4.18-highpte/drivers/usb/stv680.c
--- linux-2.4.18-prepte/drivers/usb/stv680.c	Mon Feb 25 11:38:07 2002
+++ linux-2.4.18-highpte/drivers/usb/stv680.c	Thu Mar 21 19:42:47 2002
@@ -133,8 +133,9 @@
 	if (!pgd_none (*pgd)) {
 		pmd = pmd_offset (pgd, adr);
 		if (!pmd_none (*pmd)) {
-			ptep = pte_offset (pmd, adr);
+			ptep = pte_offset_map (pmd, adr);
 			pte = *ptep;
+			pte_unmap(pte);
 			if (pte_present (pte)) {
 				ret = (unsigned long) page_address (pte_page (pte));
 				ret |= (adr & (PAGE_SIZE - 1));
diff -urN linux-2.4.18-prepte/drivers/usb/vicam.c linux-2.4.18-highpte/drivers/usb/vicam.c
--- linux-2.4.18-prepte/drivers/usb/vicam.c	Mon Feb 25 11:38:07 2002
+++ linux-2.4.18-highpte/drivers/usb/vicam.c	Thu Mar 21 19:42:59 2002
@@ -115,8 +115,9 @@
 	if (!pgd_none(*pgd)) {
 		pmd = pmd_offset(pgd, adr);
 		if (!pmd_none(*pmd)) {
-			ptep = pte_offset(pmd, adr);
+			ptep = pte_offset_map(pmd, adr);
 			pte = *ptep;
+			pte_unmap(pte);
 			if(pte_present(pte)) {
 				ret  = (unsigned long) page_address(pte_page(pte));
 				ret |= (adr & (PAGE_SIZE - 1));
diff -urN linux-2.4.18-prepte/fs/exec.c linux-2.4.18-highpte/fs/exec.c
--- linux-2.4.18-prepte/fs/exec.c	Fri Dec 21 09:41:55 2001
+++ linux-2.4.18-highpte/fs/exec.c	Thu Mar 21 17:37:24 2002
@@ -270,15 +270,18 @@
 	pmd = pmd_alloc(tsk->mm, pgd, address);
 	if (!pmd)
 		goto out;
-	pte = pte_alloc(tsk->mm, pmd, address);
+	pte = pte_alloc_map(tsk->mm, pmd, address);
 	if (!pte)
 		goto out;
-	if (!pte_none(*pte))
+	if (!pte_none(*pte)) {
+		pte_unmap(pte);
 		goto out;
+	}
 	lru_cache_add(page);
 	flush_dcache_page(page);
 	flush_page_to_ram(page);
 	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(page, PAGE_COPY))));
+	pte_unmap(pte);
 	tsk->mm->rss++;
 	spin_unlock(&tsk->mm->page_table_lock);
 
diff -urN linux-2.4.18-prepte/fs/proc/array.c linux-2.4.18-highpte/fs/proc/array.c
--- linux-2.4.18-prepte/fs/proc/array.c	Thu Mar 21 19:20:08 2002
+++ linux-2.4.18-highpte/fs/proc/array.c	Thu Mar 21 19:34:57 2002
@@ -392,11 +392,10 @@
 	return res;
 }
 		
-static inline void statm_pte_range(pmd_t * pmd, unsigned long address, unsigned long size,
-	int * pages, int * shared, int * dirty, int * total)
+static inline void statm_pte_range(pmd_t * pmd, unsigned long address, unsigned long size, int * pages, int * shared, int * dirty, int * total)
 {
-	pte_t * pte;
-	unsigned long end;
+	unsigned long end, pmd_end;
+	pte_t *pte;
 
 	if (pmd_none(*pmd))
 		return;
@@ -405,11 +404,11 @@
 		pmd_clear(pmd);
 		return;
 	}
-	pte = pte_offset(pmd, address);
-	address &= ~PMD_MASK;
+	pte = pte_offset_map(pmd, address);
 	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
+	pmd_end = (address + PMD_SIZE) & PMD_MASK;
+	if (end > pmd_end)
+		end = pmd_end;
 	do {
 		pte_t page = *pte;
 		struct page *ptpage;
@@ -430,6 +429,7 @@
 		if (page_count(pte_page(page)) > 1)
 			++*shared;
 	} while (address < end);
+	pte_unmap(pte - 1);
 }
 
 static inline void statm_pmd_range(pgd_t * pgd, unsigned long address, unsigned long size,
diff -urN linux-2.4.18-prepte/include/asm-i386/highmem.h linux-2.4.18-highpte/include/asm-i386/highmem.h
--- linux-2.4.18-prepte/include/asm-i386/highmem.h	Thu Nov 22 11:46:19 2001
+++ linux-2.4.18-highpte/include/asm-i386/highmem.h	Thu Mar 21 19:32:58 2002
@@ -26,12 +26,6 @@
 #include <asm/kmap_types.h>
 #include <asm/pgtable.h>
 
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define HIGHMEM_DEBUG 1
-#else
-#define HIGHMEM_DEBUG 0
-#endif
-
 /* declarations for highmem.c */
 extern unsigned long highstart_pfn, highend_pfn;
 
@@ -93,7 +87,7 @@
 
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#if HIGHMEM_DEBUG
+#if CONFIG_DEBUG_HIGHMEM
 	if (!pte_none(*(kmap_pte-idx)))
 		BUG();
 #endif
@@ -105,8 +99,8 @@
 
 static inline void kunmap_atomic(void *kvaddr, enum km_type type)
 {
-#if HIGHMEM_DEBUG
-	unsigned long vaddr = (unsigned long) kvaddr;
+#if CONFIG_DEBUG_HIGHMEM
+	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
 	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
 
 	if (vaddr < FIXADDR_START) // FIXME
diff -urN linux-2.4.18-prepte/include/asm-i386/kmap_types.h linux-2.4.18-highpte/include/asm-i386/kmap_types.h
--- linux-2.4.18-prepte/include/asm-i386/kmap_types.h	Mon Sep 17 13:16:30 2001
+++ linux-2.4.18-highpte/include/asm-i386/kmap_types.h	Thu Mar 21 19:16:24 2002
@@ -1,13 +1,26 @@
 #ifndef _ASM_KMAP_TYPES_H
 #define _ASM_KMAP_TYPES_H
 
+#include <linux/config.h>
+
+#if CONFIG_DEBUG_HIGHMEM
+# define D(n) __KM_FENCE_##n ,
+#else
+# define D(n)
+#endif
+
 enum km_type {
-	KM_BOUNCE_READ,
-	KM_SKB_DATA,
-	KM_SKB_DATA_SOFTIRQ,
-	KM_USER0,
-	KM_USER1,
-	KM_TYPE_NR
+D(0)  KM_BOUNCE_READ,
+D(1)  KM_SKB_DATA,
+D(2)  KM_SKB_DATA_SOFTIRQ,
+D(3)  KM_USER0,
+D(4)  KM_USER1,
+D(5)  KM_BIO_IRQ,
+D(6)  KM_PTE0,
+D(7)  KM_PTE1,
+D(8)  KM_TYPE_NR
 };
+
+#undef D
 
 #endif
diff -urN linux-2.4.18-prepte/include/asm-i386/pgalloc.h linux-2.4.18-highpte/include/asm-i386/pgalloc.h
--- linux-2.4.18-prepte/include/asm-i386/pgalloc.h	Thu Mar 21 19:20:08 2002
+++ linux-2.4.18-highpte/include/asm-i386/pgalloc.h	Thu Mar 21 19:51:50 2002
@@ -5,15 +5,17 @@
 #include <asm/processor.h>
 #include <asm/fixmap.h>
 #include <linux/threads.h>
+#include <linux/highmem.h>
 
-#define pgd_quicklist (current_cpu_data.pgd_quick)
-#define pmd_quicklist (current_cpu_data.pmd_quick)
-#define pte_quicklist (current_cpu_data.pte_quick)
-#define pgtable_cache_size (current_cpu_data.pgtable_cache_sz)
-
-#define pmd_populate(mm, pmd, pte) \
+#define pmd_populate_kernel(mm, pmd, pte) \
 		set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(pte)))
 
+static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct page *pte)
+{
+	set_pmd(pmd, __pmd(_PAGE_TABLE +
+		((unsigned long long)(pte - mem_map) <<
+			(unsigned long long) PAGE_SHIFT)));
+}
 /*
  * Allocate and free page tables.
  */
@@ -29,7 +31,7 @@
 extern void kmem_cache_free(struct kmem_cache_s *, void *);
 
 
-static inline pgd_t *get_pgd_slow(void)
+static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	int i;
 	pgd_t *pgd = kmem_cache_alloc(pae_pgd_cachep, GFP_KERNEL);
@@ -56,7 +58,7 @@
 
 #else
 
-static inline pgd_t *get_pgd_slow(void)
+static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
 
@@ -71,27 +73,7 @@
 
 #endif /* CONFIG_X86_PAE */
 
-static inline pgd_t *get_pgd_fast(void)
-{
-	unsigned long *ret;
-
-	if ((ret = pgd_quicklist) != NULL) {
-		pgd_quicklist = (unsigned long *)(*ret);
-		ret[0] = 0;
-		pgtable_cache_size--;
-	} else
-		ret = (unsigned long *)get_pgd_slow();
-	return (pgd_t *)ret;
-}
-
-static inline void free_pgd_fast(pgd_t *pgd)
-{
-	*(unsigned long *)pgd = (unsigned long) pgd_quicklist;
-	pgd_quicklist = (unsigned long *) pgd;
-	pgtable_cache_size++;
-}
-
-static inline void free_pgd_slow(pgd_t *pgd)
+static inline void pgd_free(pgd_t *pgd)
 {
 #if defined(CONFIG_X86_PAE)
 	int i;
@@ -104,59 +86,64 @@
 #endif
 }
 
-static inline pte_t *pte_alloc_one(struct mm_struct *mm, unsigned long address)
+
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
+	int count = 0;
 	pte_t *pte;
-
-	pte = (pte_t *) __get_free_page(GFP_KERNEL);
-	if (pte)
-		clear_page(pte);
+   
+   	do {
+		pte = (pte_t *) __get_free_page(GFP_KERNEL);
+		if (pte)
+			clear_page(pte);
+		else {
+			current->state = TASK_UNINTERRUPTIBLE;
+			schedule_timeout(HZ);
+		}
+	} while (!pte && (count++ < 10));
 	return pte;
 }
-
-static inline pte_t *pte_alloc_one_fast(struct mm_struct *mm,
-					unsigned long address)
+  
+static inline struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	unsigned long *ret;
-
-	if ((ret = (unsigned long *)pte_quicklist) != NULL) {
-		pte_quicklist = (unsigned long *)(*ret);
-		ret[0] = ret[1];
-		pgtable_cache_size--;
-	}
-	return (pte_t *)ret;
+	int count = 0;
+	struct page *pte;
+   
+   	do {
+#if CONFIG_HIGHPTE
+		pte = alloc_pages(GFP_KERNEL | __GFP_HIGHMEM, 0);
+#else
+		pte = alloc_pages(GFP_KERNEL, 0);
+#endif
+		if (pte)
+			clear_highpage(pte);
+		else {
+			current->state = TASK_UNINTERRUPTIBLE;
+			schedule_timeout(HZ);
+		}
+	} while (!pte && (count++ < 10));
+	return pte;
 }
-
-static inline void pte_free_fast(pte_t *pte)
+  
+static inline void pte_free_kernel(pte_t *pte)
 {
-	*(unsigned long *)pte = (unsigned long) pte_quicklist;
-	pte_quicklist = (unsigned long *) pte;
-	pgtable_cache_size++;
+	free_page((unsigned long)pte);
 }
-
-static __inline__ void pte_free_slow(pte_t *pte)
+  
+static inline void pte_free(struct page *pte)
 {
-	free_page((unsigned long)pte);
+	__free_page(pte);
 }
-
-#define pte_free(pte)		pte_free_slow(pte)
-#define pgd_free(pgd)		free_pgd_slow(pgd)
-#define pgd_alloc(mm)		get_pgd_fast()
-
+  
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
  * inside the pgd, so has no extra memory associated with it.
  * (In the PAE case we free the pmds as part of the pgd.)
  */
 
-#define pmd_alloc_one_fast(mm, addr)	({ BUG(); ((pmd_t *)1); })
 #define pmd_alloc_one(mm, addr)		({ BUG(); ((pmd_t *)2); })
-#define pmd_free_slow(x)		do { } while (0)
-#define pmd_free_fast(x)		do { } while (0)
 #define pmd_free(x)			do { } while (0)
 #define pgd_populate(mm, pmd, pte)	BUG()
-
-extern int do_check_pgt_cache(int, int);
 
 /*
  * TLB flushing:
diff -urN linux-2.4.18-prepte/include/asm-i386/pgtable.h linux-2.4.18-highpte/include/asm-i386/pgtable.h
--- linux-2.4.18-prepte/include/asm-i386/pgtable.h	Thu Nov 22 11:46:19 2001
+++ linux-2.4.18-highpte/include/asm-i386/pgtable.h	Thu Mar 21 19:32:57 2002
@@ -315,9 +315,12 @@
 
 #define page_pte(page) page_pte_prot(page, __pgprot(0))
 
-#define pmd_page(pmd) \
+#define pmd_page_kernel(pmd) \
 ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 
+#define pmd_page(pmd) \
+	(mem_map + (pmd_val(pmd) >> PAGE_SHIFT))
+
 /* to find an entry in a page-table-directory. */
 #define pgd_index(address) ((address >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 
@@ -334,8 +337,14 @@
 /* Find an entry in the third-level page table.. */
 #define __pte_offset(address) \
 		((address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
-#define pte_offset(dir, address) ((pte_t *) pmd_page(*(dir)) + \
-			__pte_offset(address))
+#define pte_offset_kernel(dir, address) \
+	((pte_t *) pmd_page_kernel(*(dir)) +  __pte_offset(address))
+#define pte_offset_map(dir, address) \
+	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE0) + __pte_offset(address))
+#define pte_offset_map2(dir, address) \
+	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE1) + __pte_offset(address))
+#define pte_unmap(pte) kunmap_atomic(pte, KM_PTE0)
+#define pte_unmap2(pte) kunmap_atomic(pte, KM_PTE1)
 
 /*
  * The i386 doesn't have any external MMU info: the kernel page
diff -urN linux-2.4.18-prepte/include/asm-i386/processor.h linux-2.4.18-highpte/include/asm-i386/processor.h
--- linux-2.4.18-prepte/include/asm-i386/processor.h	Thu Nov 22 11:46:19 2001
+++ linux-2.4.18-highpte/include/asm-i386/processor.h	Thu Mar 21 19:32:57 2002
@@ -49,10 +49,6 @@
 	int	f00f_bug;
 	int	coma_bug;
 	unsigned long loops_per_jiffy;
-	unsigned long *pgd_quick;
-	unsigned long *pmd_quick;
-	unsigned long *pte_quick;
-	unsigned long pgtable_cache_sz;
 } __attribute__((__aligned__(SMP_CACHE_BYTES)));
 
 #define X86_VENDOR_INTEL 0
diff -urN linux-2.4.18-prepte/include/linux/highmem.h linux-2.4.18-highpte/include/linux/highmem.h
--- linux-2.4.18-prepte/include/linux/highmem.h	Mon Feb 25 11:38:13 2002
+++ linux-2.4.18-highpte/include/linux/highmem.h	Thu Mar 21 19:32:59 2002
@@ -2,7 +2,6 @@
 #define _LINUX_HIGHMEM_H
 
 #include <linux/config.h>
-#include <asm/pgalloc.h>
 
 #ifdef CONFIG_HIGHMEM
 
@@ -14,7 +13,7 @@
 unsigned int nr_free_highpages(void);
 
 extern struct buffer_head * create_bounce(int rw, struct buffer_head * bh_orig);
-
+extern void check_highmem_ptes(void);
 
 static inline char *bh_kmap(struct buffer_head *bh)
 {
@@ -52,8 +51,9 @@
 
 static inline void clear_highpage(struct page *page)
 {
-	clear_page(kmap(page));
-	kunmap(page);
+	void *kaddr = kmap_atomic(page, KM_USER0);
+	clear_page(kaddr);
+	kunmap_atomic(kaddr, KM_USER0);
 }
 
 /*
@@ -61,15 +61,16 @@
  */
 static inline void memclear_highpage_flush(struct page *page, unsigned int offset, unsigned int size)
 {
-	char *kaddr;
+	void *kaddr;
 
 	if (offset + size > PAGE_SIZE)
 		BUG();
-	kaddr = kmap(page);
-	memset(kaddr + offset, 0, size);
+
+	kaddr = kmap_atomic(page, KM_USER0);
+	memset((char *)kaddr + offset, 0, size);
 	flush_dcache_page(page);
 	flush_page_to_ram(page);
-	kunmap(page);
+	kunmap_atomic(kaddr, KM_USER0);
 }
 
 static inline void copy_user_highpage(struct page *to, struct page *from, unsigned long vaddr)
diff -urN linux-2.4.18-prepte/include/linux/mm.h linux-2.4.18-highpte/include/linux/mm.h
--- linux-2.4.18-prepte/include/linux/mm.h	Thu Mar 21 19:20:20 2002
+++ linux-2.4.18-highpte/include/linux/mm.h	Thu Mar 21 19:32:59 2002
@@ -411,7 +411,8 @@
 
 extern int vmtruncate(struct inode * inode, loff_t offset);
 extern pmd_t *FASTCALL(__pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address));
-extern pte_t *FASTCALL(pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
+extern pte_t *FASTCALL(pte_alloc_kernel(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
+extern pte_t *FASTCALL(pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
 extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
 extern int make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
@@ -427,7 +428,7 @@
 
 /*
  * On a two-level page table, this ends up being trivial. Thus the
- * inlining and the symmetry break with pte_alloc() that does all
+ * inlining and the symmetry break with pte_alloc_map() that does all
  * of this out-of-line.
  */
 static inline pmd_t *pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
@@ -436,9 +437,6 @@
 		return __pmd_alloc(mm, pgd, address);
 	return pmd_offset(pgd, address);
 }
-
-extern int pgt_cache_water[2];
-extern int check_pgt_cache(void);
 
 extern void free_area_init(unsigned long * zones_size);
 extern void free_area_init_node(int nid, pg_data_t *pgdat, struct page *pmap,
diff -urN linux-2.4.18-prepte/kernel/sched.c linux-2.4.18-highpte/kernel/sched.c
--- linux-2.4.18-prepte/kernel/sched.c	Thu Mar 21 19:20:08 2002
+++ linux-2.4.18-highpte/kernel/sched.c	Thu Mar 21 17:49:37 2002
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <asm/mmu_context.h>
 #include <linux/kernel_stat.h>
+#include <linux/highmem.h>
 
 /*
  * Priority of a process goes from 0 to 139. The 0-99
@@ -751,6 +752,10 @@
 
 	if (unlikely(in_interrupt()))
 		BUG();
+#if CONFIG_DEBUG_HIGHMEM
+	check_highmem_ptes();
+#endif
+
 	release_kernel_lock(prev, smp_processor_id());
 	prev->sleep_timestamp = jiffies;
 	spin_lock_irq(&rq->lock);
diff -urN linux-2.4.18-prepte/kernel/sysctl.c linux-2.4.18-highpte/kernel/sysctl.c
--- linux-2.4.18-prepte/kernel/sysctl.c	Fri Dec 21 09:42:04 2001
+++ linux-2.4.18-highpte/kernel/sysctl.c	Thu Mar 21 17:37:24 2002
@@ -96,8 +96,6 @@
 extern int acct_parm[];
 #endif
 
-extern int pgt_cache_water[];
-
 static int parse_table(int *, int, void *, size_t *, void *, size_t,
 		       ctl_table *, void **);
 static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
@@ -267,8 +265,6 @@
 	 sizeof(sysctl_overcommit_memory), 0644, NULL, &proc_dointvec},
 	{VM_PAGERDAEMON, "kswapd",
 	 &pager_daemon, sizeof(pager_daemon_t), 0644, NULL, &proc_dointvec},
-	{VM_PGT_CACHE, "pagetable_cache", 
-	 &pgt_cache_water, 2*sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_PAGE_CLUSTER, "page-cluster", 
 	 &page_cluster, sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_MIN_READAHEAD, "min-readahead",
diff -urN linux-2.4.18-prepte/mm/filemap.c linux-2.4.18-highpte/mm/filemap.c
--- linux-2.4.18-prepte/mm/filemap.c	Mon Feb 25 11:38:13 2002
+++ linux-2.4.18-highpte/mm/filemap.c	Thu Mar 21 18:21:11 2002
@@ -1989,7 +1989,7 @@
 /* Called with mm->page_table_lock held to protect against other
  * threads/the swapper from ripping pte's out from under us.
  */
-static inline int filemap_sync_pte(pte_t * ptep, struct vm_area_struct *vma,
+static inline int filemap_sync_pte(pte_t *ptep, pmd_t *pmdp, struct vm_area_struct *vma,
 	unsigned long address, unsigned int flags)
 {
 	pte_t pte = *ptep;
@@ -2005,11 +2005,10 @@
 }
 
 static inline int filemap_sync_pte_range(pmd_t * pmd,
-	unsigned long address, unsigned long size, 
-	struct vm_area_struct *vma, unsigned long offset, unsigned int flags)
+	unsigned long address, unsigned long end, 
+	struct vm_area_struct *vma, unsigned int flags)
 {
-	pte_t * pte;
-	unsigned long end;
+	pte_t *pte;
 	int error;
 
 	if (pmd_none(*pmd))
@@ -2019,27 +2018,26 @@
 		pmd_clear(pmd);
 		return 0;
 	}
-	pte = pte_offset(pmd, address);
-	offset += address & PMD_MASK;
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
+	pte = pte_offset_map(pmd, address);
+	if ((address & PMD_MASK) != (end & PMD_MASK))
+		end = (address & PMD_MASK) + PMD_SIZE;
 	error = 0;
 	do {
-		error |= filemap_sync_pte(pte, vma, address + offset, flags);
+		error |= filemap_sync_pte(pte, pmd, vma, address, flags);
 		address += PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));
+
+	pte_unmap(pte - 1);
+
 	return error;
 }
 
 static inline int filemap_sync_pmd_range(pgd_t * pgd,
-	unsigned long address, unsigned long size, 
+	unsigned long address, unsigned long end, 
 	struct vm_area_struct *vma, unsigned int flags)
 {
 	pmd_t * pmd;
-	unsigned long offset, end;
 	int error;
 
 	if (pgd_none(*pgd))
@@ -2050,14 +2048,11 @@
 		return 0;
 	}
 	pmd = pmd_offset(pgd, address);
-	offset = address & PGDIR_MASK;
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
+	if ((address & PGDIR_MASK) != (end & PGDIR_MASK))
+		end = (address & PGDIR_MASK) + PGDIR_SIZE;
 	error = 0;
 	do {
-		error |= filemap_sync_pte_range(pmd, address, end - address, vma, offset, flags);
+		error |= filemap_sync_pte_range(pmd, address, end, vma, flags);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
@@ -2077,11 +2072,11 @@
 	spin_lock(&vma->vm_mm->page_table_lock);
 
 	dir = pgd_offset(vma->vm_mm, address);
-	flush_cache_range(vma->vm_mm, end - size, end);
+	flush_cache_range(vma, address, end);
 	if (address >= end)
 		BUG();
 	do {
-		error |= filemap_sync_pmd_range(dir, address, end - address, vma, flags);
+		error |= filemap_sync_pmd_range(dir, address, end, vma, flags);
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
diff -urN linux-2.4.18-prepte/mm/highmem.c linux-2.4.18-highpte/mm/highmem.c
--- linux-2.4.18-prepte/mm/highmem.c	Thu Mar 21 19:20:08 2002
+++ linux-2.4.18-highpte/mm/highmem.c	Thu Mar 21 17:51:29 2002
@@ -21,6 +21,7 @@
 #include <linux/highmem.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
+#include <asm/pgalloc.h>
 
 /*
  * Virtual_count is not a pure "count".
@@ -446,3 +447,17 @@
 	return bh;
 }
 
+#if CONFIG_DEBUG_HIGHMEM
+void check_highmem_ptes(void)
+{
+	int idx, type;
+ 
+	for (type = 0; type < KM_TYPE_NR; type++) {
+		idx = type + KM_TYPE_NR*smp_processor_id();
+ 		if (!pte_none(*(kmap_pte-idx))) {
+ 			printk("scheduling with KM_TYPE %d held!\n", type);
+ 			BUG();
+ 		}
+ 	}
+}
+#endif
diff -urN linux-2.4.18-prepte/mm/memory.c linux-2.4.18-highpte/mm/memory.c
--- linux-2.4.18-prepte/mm/memory.c	Thu Mar 21 19:20:20 2002
+++ linux-2.4.18-highpte/mm/memory.c	Thu Mar 21 19:35:50 2002
@@ -90,7 +90,7 @@
  */
 static inline void free_one_pmd(pmd_t * dir)
 {
-	pte_t * pte;
+	struct page *pte;
 
 	if (pmd_none(*dir))
 		return;
@@ -99,7 +99,7 @@
 		pmd_clear(dir);
 		return;
 	}
-	pte = pte_offset(dir, 0);
+	pte = pmd_page(*dir);
 	pmd_clear(dir);
 	pte_free(pte);
 }
@@ -125,18 +125,6 @@
 	pmd_free(pmd);
 }
 
-/* Low and high watermarks for page table cache.
-   The system should try to have pgt_water[0] <= cache elements <= pgt_water[1]
- */
-int pgt_cache_water[2] = { 25, 50 };
-
-/* Returns the number of pages freed */
-int check_pgt_cache(void)
-{
-	return do_check_pgt_cache(pgt_cache_water[0], pgt_cache_water[1]);
-}
-
-
 /*
  * This function clears all user-level page tables of a process - this
  * is needed by execve(), so that old pages aren't in the way.
@@ -152,11 +140,59 @@
 		page_dir++;
 	} while (--nr);
 	spin_unlock(&mm->page_table_lock);
+}
+
+pte_t * pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
+{
+	if (!pmd_present(*pmd)) {
+		struct page *new;
 
-	/* keep the page table cache within bounds */
-	check_pgt_cache();
+		spin_unlock(&mm->page_table_lock);
+		new = pte_alloc_one(mm, address);
+		spin_lock(&mm->page_table_lock);
+		if (!new)
+			return NULL;
+
+		/*
+		 * Because we dropped the lock, we should re-check the
+		 * entry, as somebody else could have populated it..
+		 */
+		if (pmd_present(*pmd)) {
+			pte_free(new);
+			goto out;
+		}
+		pmd_populate(mm, pmd, new);
+	}
+out:
+	if (pmd_present(*pmd))
+		return pte_offset_map(pmd, address);
+	return NULL;
 }
 
+pte_t * pte_alloc_kernel(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
+{
+	if (!pmd_present(*pmd)) {
+		pte_t *new;
+
+		spin_unlock(&mm->page_table_lock);
+		new = pte_alloc_one_kernel(mm, address);
+		spin_lock(&mm->page_table_lock);
+		if (!new)
+			return NULL;
+
+		/*
+		 * Because we dropped the lock, we should re-check the
+		 * entry, as somebody else could have populated it..
+		 */
+		if (pmd_present(*pmd)) {
+			pte_free_kernel(new);
+			goto out;
+		}
+		pmd_populate_kernel(mm, pmd, new);
+	}
+out:
+	return pte_offset_kernel(pmd, address);
+}
 #define PTE_TABLE_MASK	((PTRS_PER_PTE-1) * sizeof(pte_t))
 #define PMD_TABLE_MASK	((PTRS_PER_PMD-1) * sizeof(pmd_t))
 
@@ -169,7 +205,7 @@
  *         variable count and make things faster. -jj
  *
  * dst->page_table_lock is held on entry and exit,
- * but may be dropped within pmd_alloc() and pte_alloc().
+ * but may be dropped within pmd_alloc() and pte_alloc_map().
  */
 int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
 			struct vm_area_struct *vma)
@@ -221,12 +257,11 @@
 				goto cont_copy_pmd_range;
 			}
 
-			src_pte = pte_offset(src_pmd, address);
-			dst_pte = pte_alloc(dst, dst_pmd, address);
+			dst_pte = pte_alloc_map(dst, dst_pmd, address);
 			if (!dst_pte)
 				goto nomem;
-
 			spin_lock(&src->page_table_lock);			
+			src_pte = pte_offset_map2(src_pmd, address);
 			do {
 				pte_t pte = *src_pte;
 				struct page *ptepage;
@@ -259,11 +294,16 @@
 
 cont_copy_pte_range:		set_pte(dst_pte, pte);
 cont_copy_pte_range_noset:	address += PAGE_SIZE;
-				if (address >= end)
+				if (address >= end) {
+					pte_unmap2(src_pte);
+					pte_unmap(dst_pte);
 					goto out_unlock;
+				}
 				src_pte++;
 				dst_pte++;
 			} while ((unsigned long)src_pte & PTE_TABLE_MASK);
+			pte_unmap2(src_pte-1);
+			pte_unmap(dst_pte-1);
 			spin_unlock(&src->page_table_lock);
 		
 cont_copy_pmd_range:	src_pmd++;
@@ -292,7 +332,7 @@
 static inline int zap_pte_range(mmu_gather_t *tlb, pmd_t * pmd, unsigned long address, unsigned long size)
 {
 	unsigned long offset;
-	pte_t * ptep;
+	pte_t *ptep;
 	int freed = 0;
 
 	if (pmd_none(*pmd))
@@ -302,7 +342,7 @@
 		pmd_clear(pmd);
 		return 0;
 	}
-	ptep = pte_offset(pmd, address);
+	ptep = pte_offset_map(pmd, address);
 	offset = address & ~PMD_MASK;
 	if (offset + size > PMD_SIZE)
 		size = PMD_SIZE - offset;
@@ -322,6 +362,7 @@
 			pte_clear(ptep);
 		}
 	}
+	pte_unmap(ptep-1);
 
 	return freed;
 }
@@ -414,11 +455,13 @@
 	if (pmd_none(*pmd) || pmd_bad(*pmd))
 		goto out;
 
-	ptep = pte_offset(pmd, address);
-	if (!ptep)
+	ptep = pte_offset_map(pmd, address);
+	if (!ptep) {
 		goto out;
+	}
 
 	pte = *ptep;
+	pte_unmap(ptep);
 	if (pte_present(pte)) {
 		if (!write ||
 		    (pte_write(pte) && pte_dirty(pte)))
@@ -771,10 +814,11 @@
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 	do {
-		pte_t * pte = pte_alloc(mm, pmd, address);
+		pte_t * pte = pte_alloc_map(mm, pmd, address);
 		if (!pte)
 			return -ENOMEM;
 		zeromap_pte_range(pte, address, end - address, prot);
+		pte_unmap(pte);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
@@ -851,10 +895,11 @@
 		end = PGDIR_SIZE;
 	phys_addr -= address;
 	do {
-		pte_t * pte = pte_alloc(mm, pmd, address);
+		pte_t * pte = pte_alloc_map(mm, pmd, address);
 		if (!pte)
 			return -ENOMEM;
 		remap_pte_range(pte, address, end - address, address + phys_addr, prot);
+		pte_unmap(pte);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
@@ -940,7 +985,7 @@
  * with the page_table_lock released.
  */
 static int do_wp_page(struct mm_struct *mm, struct vm_area_struct * vma,
-	unsigned long address, pte_t *page_table, pte_t pte)
+	unsigned long address, pte_t *page_table, pmd_t *pmd, pte_t pte)
 {
 	struct page *old_page, *new_page;
 
@@ -954,10 +999,12 @@
 		if (reuse) {
 			flush_cache_page(vma, address);
 			establish_pte(vma, address, page_table, pte_mkyoung(pte_mkdirty(pte_mkwrite(pte))));
+			pte_unmap(page_table);
 			spin_unlock(&mm->page_table_lock);
 			return 1;	/* Minor fault */
 		}
 	}
+	pte_unmap(page_table);
 
 	/*
 	 * Ok, we need to copy. Oh, well..
@@ -974,6 +1021,7 @@
 	 * Re-check the pte - we dropped the lock
 	 */
 	spin_lock(&mm->page_table_lock);
+	page_table = pte_offset_map(pmd, address);
 	if (pte_same(*page_table, pte)) {
 		if (PageReserved(old_page))
 			++mm->rss;
@@ -983,12 +1031,14 @@
 		/* Free the old page.. */
 		new_page = old_page;
 	}
+	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
 	page_cache_release(new_page);
 	page_cache_release(old_page);
 	return 1;	/* Minor fault */
 
 bad_wp_page:
+	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
 	printk("do_wp_page: bogus page at address %08lx (page 0x%lx)\n",address,(unsigned long)old_page);
 	return -1;
@@ -1110,13 +1160,14 @@
  */
 static int do_swap_page(struct mm_struct * mm,
 	struct vm_area_struct * vma, unsigned long address,
-	pte_t * page_table, pte_t orig_pte, int write_access)
+	pte_t *page_table, pmd_t *pmd, pte_t orig_pte, int write_access)
 {
 	struct page *page;
 	swp_entry_t entry = pte_to_swp_entry(orig_pte);
 	pte_t pte;
 	int ret = 1;
 
+	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
 	page = lookup_swap_cache(entry);
 	if (!page) {
@@ -1129,7 +1180,9 @@
 			 */
 			int retval;
 			spin_lock(&mm->page_table_lock);
+			page_table = pte_offset_map(pmd, address);
 			retval = pte_same(*page_table, orig_pte) ? -1 : 1;
+			pte_unmap(page_table);
 			spin_unlock(&mm->page_table_lock);
 			return retval;
 		}
@@ -1147,7 +1200,9 @@
 	 * released the page table lock.
 	 */
 	spin_lock(&mm->page_table_lock);
+	page_table = pte_offset_map(pmd, address);
 	if (!pte_same(*page_table, orig_pte)) {
+		pte_unmap(page_table);
 		spin_unlock(&mm->page_table_lock);
 		unlock_page(page);
 		page_cache_release(page);
@@ -1172,6 +1227,7 @@
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, address, pte);
+	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
 	return ret;
 }
@@ -1181,7 +1237,7 @@
  * spinlock held to protect against concurrent faults in
  * multithreaded programs. 
  */
-static int do_anonymous_page(struct mm_struct * mm, struct vm_area_struct * vma, pte_t *page_table, int write_access, unsigned long addr)
+static int do_anonymous_page(struct mm_struct * mm, struct vm_area_struct * vma, pte_t *page_table, pmd_t *pmd, int write_access, unsigned long addr)
 {
 	pte_t entry;
 
@@ -1193,6 +1249,7 @@
 		struct page *page;
 
 		/* Allocate our own private page. */
+		pte_unmap(page_table);
 		spin_unlock(&mm->page_table_lock);
 
 		page = alloc_page(GFP_HIGHUSER);
@@ -1201,7 +1258,10 @@
 		clear_user_highpage(page, addr);
 
 		spin_lock(&mm->page_table_lock);
+		page_table = pte_offset_map(pmd, addr);
+
 		if (!pte_none(*page_table)) {
+			pte_unmap(page_table);
 			page_cache_release(page);
 			spin_unlock(&mm->page_table_lock);
 			return 1;
@@ -1214,6 +1274,7 @@
 	}
 
 	set_pte(page_table, entry);
+	pte_unmap(page_table);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, addr, entry);
@@ -1237,13 +1298,14 @@
  * spinlock held. Exit with the spinlock released.
  */
 static int do_no_page(struct mm_struct * mm, struct vm_area_struct * vma,
-	unsigned long address, int write_access, pte_t *page_table)
+	unsigned long address, int write_access, pte_t *page_table, pmd_t *pmd)
 {
 	struct page * new_page;
 	pte_t entry;
 
 	if (!vma->vm_ops || !vma->vm_ops->nopage)
-		return do_anonymous_page(mm, vma, page_table, write_access, address);
+		return do_anonymous_page(mm, vma, page_table, pmd, write_access, address);
+	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
 
 	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, 0);
@@ -1269,6 +1331,8 @@
 	}
 
 	spin_lock(&mm->page_table_lock);
+	page_table = pte_offset_map(pmd, address);
+
 	/*
 	 * This silly early PAGE_DIRTY setting removes a race
 	 * due to the bad i386 page protection. But it's valid
@@ -1288,8 +1352,10 @@
 		if (write_access)
 			entry = pte_mkwrite(pte_mkdirty(entry));
 		set_pte(page_table, entry);
+		pte_unmap(page_table);
 	} else {
 		/* One of our sibling threads was faster, back out. */
+		pte_unmap(page_table);
 		page_cache_release(new_page);
 		spin_unlock(&mm->page_table_lock);
 		return 1;
@@ -1324,7 +1390,7 @@
  */
 static inline int handle_pte_fault(struct mm_struct *mm,
 	struct vm_area_struct * vma, unsigned long address,
-	int write_access, pte_t * pte)
+	int write_access, pte_t *pte, pmd_t *pmd)
 {
 	pte_t entry;
 
@@ -1336,18 +1402,19 @@
 		 * drop the lock.
 		 */
 		if (pte_none(entry))
-			return do_no_page(mm, vma, address, write_access, pte);
-		return do_swap_page(mm, vma, address, pte, entry, write_access);
+			return do_no_page(mm, vma, address, write_access, pte, pmd);
+		return do_swap_page(mm, vma, address, pte, pmd, entry, write_access);
 	}
 
 	if (write_access) {
 		if (!pte_write(entry))
-			return do_wp_page(mm, vma, address, pte, entry);
+			return do_wp_page(mm, vma, address, pte, pmd, entry);
 
 		entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
 	establish_pte(vma, address, pte, entry);
+	pte_unmap(pte);
 	spin_unlock(&mm->page_table_lock);
 	return 1;
 }
@@ -1372,9 +1439,9 @@
 	pmd = pmd_alloc(mm, pgd, address);
 
 	if (pmd) {
-		pte_t * pte = pte_alloc(mm, pmd, address);
+		pte_t * pte = pte_alloc_map(mm, pmd, address);
 		if (pte)
-			return handle_pte_fault(mm, vma, address, write_access, pte);
+			return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
 	}
 	spin_unlock(&mm->page_table_lock);
 	return -1;
@@ -1393,64 +1460,25 @@
 {
 	pmd_t *new;
 
-	/* "fast" allocation can happen without dropping the lock.. */
-	new = pmd_alloc_one_fast(mm, address);
-	if (!new) {
-		spin_unlock(&mm->page_table_lock);
-		new = pmd_alloc_one(mm, address);
-		spin_lock(&mm->page_table_lock);
-		if (!new)
-			return NULL;
+	spin_unlock(&mm->page_table_lock);
+	new = pmd_alloc_one(mm, address);
+	spin_lock(&mm->page_table_lock);
+	if (!new)
+		return NULL;
 
-		/*
-		 * Because we dropped the lock, we should re-check the
-		 * entry, as somebody else could have populated it..
-		 */
-		if (!pgd_none(*pgd)) {
-			pmd_free(new);
-			goto out;
-		}
+	/*
+	 * Because we dropped the lock, we should re-check the
+	 * entry, as somebody else could have populated it..
+	 */
+	if (pgd_present(*pgd)) {
+		pmd_free(new);
+		goto out;
 	}
 	pgd_populate(mm, pgd, new);
 out:
 	return pmd_offset(pgd, address);
 }
 
-/*
- * Allocate the page table directory.
- *
- * We've already handled the fast-path in-line, and we own the
- * page table lock.
- */
-pte_t *pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
-{
-	if (pmd_none(*pmd)) {
-		pte_t *new;
-
-		/* "fast" allocation can happen without dropping the lock.. */
-		new = pte_alloc_one_fast(mm, address);
-		if (!new) {
-			spin_unlock(&mm->page_table_lock);
-			new = pte_alloc_one(mm, address);
-			spin_lock(&mm->page_table_lock);
-			if (!new)
-				return NULL;
-
-			/*
-			 * Because we dropped the lock, we should re-check the
-			 * entry, as somebody else could have populated it..
-			 */
-			if (!pmd_none(*pmd)) {
-				pte_free(new);
-				goto out;
-			}
-		}
-		pmd_populate(mm, pmd, new);
-	}
-out:
-	return pte_offset(pmd, address);
-}
-
 int make_pages_present(unsigned long addr, unsigned long end)
 {
 	int ret, len, write;
@@ -1481,13 +1509,11 @@
 	if (!pgd_none(*pgd)) {
 		pmd = pmd_offset(pgd, addr);
 		if (!pmd_none(*pmd)) {
-			preempt_disable();
 			ptep = pte_offset_map(pmd, addr);
 			pte = *ptep;
 			if (pte_present(pte))
 				page = pte_page(pte);
 			pte_unmap(ptep);
-			preempt_enable();
 		}
 	}
 	/*
diff -urN linux-2.4.18-prepte/mm/mprotect.c linux-2.4.18-highpte/mm/mprotect.c
--- linux-2.4.18-prepte/mm/mprotect.c	Mon Sep 17 15:30:23 2001
+++ linux-2.4.18-highpte/mm/mprotect.c	Thu Mar 21 17:37:24 2002
@@ -11,6 +11,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
+#include <linux/highmem.h>
 
 static inline void change_pte_range(pmd_t * pmd, unsigned long address,
 	unsigned long size, pgprot_t newprot)
@@ -25,7 +26,7 @@
 		pmd_clear(pmd);
 		return;
 	}
-	pte = pte_offset(pmd, address);
+	pte = pte_offset_map(pmd, address);
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
@@ -44,6 +45,7 @@
 		address += PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));
+	pte_unmap(pte - 1);
 }
 
 static inline void change_pmd_range(pgd_t * pgd, unsigned long address,
diff -urN linux-2.4.18-prepte/mm/mremap.c linux-2.4.18-highpte/mm/mremap.c
--- linux-2.4.18-prepte/mm/mremap.c	Thu Sep 20 20:31:26 2001
+++ linux-2.4.18-highpte/mm/mremap.c	Thu Mar 21 17:37:24 2002
@@ -15,7 +15,7 @@
 
 extern int vm_enough_memory(long pages);
 
-static inline pte_t *get_one_pte(struct mm_struct *mm, unsigned long addr)
+static inline pte_t *get_one_pte_map2(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t * pgd;
 	pmd_t * pmd;
@@ -39,21 +39,23 @@
 		goto end;
 	}
 
-	pte = pte_offset(pmd, addr);
-	if (pte_none(*pte))
+	pte = pte_offset_map2(pmd, addr);
+	if (pte_none(*pte)) {
+		pte_unmap2(pte);
 		pte = NULL;
+	}
 end:
 	return pte;
 }
 
-static inline pte_t *alloc_one_pte(struct mm_struct *mm, unsigned long addr)
+static inline pte_t *alloc_one_pte_map(struct mm_struct *mm, unsigned long addr)
 {
 	pmd_t * pmd;
 	pte_t * pte = NULL;
 
 	pmd = pmd_alloc(mm, pgd_offset(mm, addr), addr);
 	if (pmd)
-		pte = pte_alloc(mm, pmd, addr);
+		pte = pte_alloc_map(mm, pmd, addr);
 	return pte;
 }
 
@@ -77,12 +79,16 @@
 static int move_one_page(struct mm_struct *mm, unsigned long old_addr, unsigned long new_addr)
 {
 	int error = 0;
-	pte_t * src;
+	pte_t *src, *dst;
 
 	spin_lock(&mm->page_table_lock);
-	src = get_one_pte(mm, old_addr);
-	if (src)
-		error = copy_one_pte(mm, src, alloc_one_pte(mm, new_addr));
+	src = get_one_pte_map2(mm, old_addr);
+	if (src) {
+		dst = alloc_one_pte_map(mm, new_addr);
+		error = copy_one_pte(mm, src, dst);
+		pte_unmap2(src);
+		pte_unmap(dst);
+	}
 	spin_unlock(&mm->page_table_lock);
 	return error;
 }
diff -urN linux-2.4.18-prepte/mm/swapfile.c linux-2.4.18-highpte/mm/swapfile.c
--- linux-2.4.18-prepte/mm/swapfile.c	Mon Feb 25 11:38:14 2002
+++ linux-2.4.18-highpte/mm/swapfile.c	Thu Mar 21 17:37:24 2002
@@ -393,7 +393,7 @@
 		pmd_clear(dir);
 		return;
 	}
-	pte = pte_offset(dir, address);
+	pte = pte_offset_map(dir, address);
 	offset += address & PMD_MASK;
 	address &= ~PMD_MASK;
 	end = address + size;
@@ -404,6 +404,7 @@
 		address += PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));
+	pte_unmap(pte - 1);
 }
 
 /* mmlist_lock and vma->vm_mm->page_table_lock are held */
diff -urN linux-2.4.18-prepte/mm/vmalloc.c linux-2.4.18-highpte/mm/vmalloc.c
--- linux-2.4.18-prepte/mm/vmalloc.c	Mon Feb 25 11:38:14 2002
+++ linux-2.4.18-highpte/mm/vmalloc.c	Thu Mar 21 17:37:24 2002
@@ -31,7 +31,7 @@
 		pmd_clear(pmd);
 		return;
 	}
-	pte = pte_offset(pmd, address);
+	pte = pte_offset_kernel(pmd, address);
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
@@ -126,7 +126,7 @@
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 	do {
-		pte_t * pte = pte_alloc(&init_mm, pmd, address);
+		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, address);
 		if (!pte)
 			return -ENOMEM;
 		if (alloc_area_pte(pte, address, end - address, gfp_mask, prot))
diff -urN linux-2.4.18-prepte/mm/vmscan.c linux-2.4.18-highpte/mm/vmscan.c
--- linux-2.4.18-prepte/mm/vmscan.c	Mon Feb 25 11:38:14 2002
+++ linux-2.4.18-highpte/mm/vmscan.c	Thu Mar 21 17:37:24 2002
@@ -166,7 +166,7 @@
 		return count;
 	}
 	
-	pte = pte_offset(dir, address);
+	pte = pte_offset_map(dir, address);
 	
 	pmd_end = (address + PMD_SIZE) & PMD_MASK;
 	if (end > pmd_end)
@@ -180,6 +180,7 @@
 				count -= try_to_swap_out(mm, vma, address, pte, page, classzone);
 				if (!count) {
 					address += PAGE_SIZE;
+					pte++;
 					break;
 				}
 			}
@@ -187,6 +188,7 @@
 		address += PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));
+	pte_unmap(pte - 1);
 	mm->swap_address = address;
 	return count;
 }

