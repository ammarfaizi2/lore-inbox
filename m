Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVEMBWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVEMBWs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 21:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVEMBWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 21:22:13 -0400
Received: from ozlabs.org ([203.10.76.45]:4273 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262219AbVEMBKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 21:10:53 -0400
Date: Fri, 13 May 2005 11:10:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: Abolish ioremap_mm
Message-ID: <20050513011038.GC19269@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

Currently ppc64 has two mm_structs for the kernel, init_mm and also
ioremap_mm.  The latter really isn't necessary: this patch abolishes
it, instead restricting vmallocs to the lower 1TB of the init_mm's
range and placing io mappings in the upper 1TB.  This simplifies the
code in a number of places and eliminates an unecessary set of
pagetables.  It also tweaks the unmap/free path a little, allowing us
to remove the unmap_im_area() set of page table walkers, replacing
them with unmap_vm_area().

 arch/ppc64/kernel/eeh.c       |    2
 arch/ppc64/kernel/head.S      |    4 -
 arch/ppc64/kernel/process.c   |    8 ---
 arch/ppc64/mm/hash_utils.c    |    4 -
 arch/ppc64/mm/imalloc.c       |   20 +++++----
 arch/ppc64/mm/init.c          |   93 ++++--------------------------------------
 include/asm-ppc64/imalloc.h   |   12 +++--
 include/asm-ppc64/page.h      |    2
 include/asm-ppc64/pgtable.h   |    9 ----
 include/asm-ppc64/processor.h |   10 ----
 10 files changed, 31 insertions(+), 133 deletions(-)

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/include/asm-ppc64/pgtable.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/pgtable.h	2005-05-11 10:05:51.000000000 +1000
+++ working-2.6/include/asm-ppc64/pgtable.h	2005-05-12 14:08:37.000000000 +1000
@@ -53,7 +53,8 @@
  * Define the address range of the vmalloc VM area.
  */
 #define VMALLOC_START (0xD000000000000000ul)
-#define VMALLOC_END   (VMALLOC_START + EADDR_MASK)
+#define VMALLOC_SIZE  (0x10000000000UL)
+#define VMALLOC_END   (VMALLOC_START + VMALLOC_SIZE)
 
 /*
  * Bits in a linux-style PTE.  These match the bits in the
@@ -239,9 +240,6 @@
 /* This now only contains the vmalloc pages */
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
 
-/* to find an entry in the ioremap page-table-directory */
-#define pgd_offset_i(address) (ioremap_pgd + pgd_index(address))
-
 /*
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
@@ -459,15 +457,12 @@
 #define __HAVE_ARCH_PTE_SAME
 #define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HPTEFLAGS) == 0)
 
-extern unsigned long ioremap_bot, ioremap_base;
-
 #define pmd_ERROR(e) \
 	printk("%s:%d: bad pmd %08x.\n", __FILE__, __LINE__, pmd_val(e))
 #define pgd_ERROR(e) \
 	printk("%s:%d: bad pgd %08x.\n", __FILE__, __LINE__, pgd_val(e))
 
 extern pgd_t swapper_pg_dir[];
-extern pgd_t ioremap_dir[];
 
 extern void paging_init(void);
 
Index: working-2.6/include/asm-ppc64/imalloc.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/imalloc.h	2005-05-11 10:05:51.000000000 +1000
+++ working-2.6/include/asm-ppc64/imalloc.h	2005-05-12 14:08:37.000000000 +1000
@@ -4,9 +4,9 @@
 /*
  * Define the address range of the imalloc VM area.
  */
-#define PHBS_IO_BASE  	  IOREGIONBASE
-#define IMALLOC_BASE      (IOREGIONBASE + 0x80000000ul)	/* Reserve 2 gigs for PHBs */
-#define IMALLOC_END       (IOREGIONBASE + EADDR_MASK)
+#define PHBS_IO_BASE  	  VMALLOC_END
+#define IMALLOC_BASE      (PHBS_IO_BASE + 0x80000000ul)	/* Reserve 2 gigs for PHBs */
+#define IMALLOC_END       (VMALLOC_START + EADDR_MASK)
 
 
 /* imalloc region types */
@@ -18,7 +18,9 @@
 
 extern struct vm_struct * im_get_free_area(unsigned long size);
 extern struct vm_struct * im_get_area(unsigned long v_addr, unsigned long size,
-			int region_type);
-unsigned long im_free(void *addr);
+				      int region_type);
+extern void im_free(void *addr);
+
+extern unsigned long ioremap_bot;
 
 #endif /* _PPC64_IMALLOC_H */
Index: working-2.6/include/asm-ppc64/page.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/page.h	2005-05-11 10:05:51.000000000 +1000
+++ working-2.6/include/asm-ppc64/page.h	2005-05-12 14:08:37.000000000 +1000
@@ -202,9 +202,7 @@
 #define PAGE_OFFSET     ASM_CONST(0xC000000000000000)
 #define KERNELBASE      PAGE_OFFSET
 #define VMALLOCBASE     ASM_CONST(0xD000000000000000)
-#define IOREGIONBASE    ASM_CONST(0xE000000000000000)
 
-#define IO_REGION_ID       (IOREGIONBASE >> REGION_SHIFT)
 #define VMALLOC_REGION_ID  (VMALLOCBASE >> REGION_SHIFT)
 #define KERNEL_REGION_ID   (KERNELBASE >> REGION_SHIFT)
 #define USER_REGION_ID     (0UL)
Index: working-2.6/arch/ppc64/kernel/eeh.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/eeh.c	2005-04-26 15:37:55.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/eeh.c	2005-05-12 14:05:12.000000000 +1000
@@ -505,7 +505,7 @@
 	pte_t *ptep;
 	unsigned long pa;
 
-	ptep = find_linux_pte(ioremap_mm.pgd, token);
+	ptep = find_linux_pte(init_mm.pgd, token);
 	if (!ptep)
 		return token;
 	pa = pte_pfn(*ptep) << PAGE_SHIFT;
Index: working-2.6/arch/ppc64/kernel/process.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/process.c	2005-04-26 15:37:55.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/process.c	2005-05-12 14:05:12.000000000 +1000
@@ -58,14 +58,6 @@
 struct task_struct *last_task_used_altivec = NULL;
 #endif
 
-struct mm_struct ioremap_mm = {
-	.pgd		= ioremap_dir,
-	.mm_users	= ATOMIC_INIT(2),
-	.mm_count	= ATOMIC_INIT(1),
-	.cpu_vm_mask	= CPU_MASK_ALL,
-	.page_table_lock = SPIN_LOCK_UNLOCKED,
-};
-
 /*
  * Make sure the floating-point register state in the
  * the thread_struct is up to date for task tsk.
Index: working-2.6/include/asm-ppc64/processor.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/processor.h	2005-04-26 15:38:02.000000000 +1000
+++ working-2.6/include/asm-ppc64/processor.h	2005-05-12 14:08:37.000000000 +1000
@@ -590,16 +590,6 @@
 }
 
 /*
- * Note: the vm_start and vm_end fields here should *not*
- * be in kernel space.  (Could vm_end == vm_start perhaps?)
- */
-#define IOREMAP_MMAP { &ioremap_mm, 0, 0x1000, NULL, \
-		    PAGE_SHARED, VM_READ | VM_WRITE | VM_EXEC, \
-		    1, NULL, NULL }
-
-extern struct mm_struct ioremap_mm;
-
-/*
  * Return saved PC of a blocked thread. For now, this is the "user" PC
  */
 #define thread_saved_pc(tsk)    \
Index: working-2.6/arch/ppc64/mm/hash_utils.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hash_utils.c	2005-05-11 10:05:49.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hash_utils.c	2005-05-12 14:08:37.000000000 +1000
@@ -310,10 +310,6 @@
 
 		vsid = get_vsid(mm->context.id, ea);
 		break;
-	case IO_REGION_ID:
-		mm = &ioremap_mm;
-		vsid = get_kernel_vsid(ea);
-		break;
 	case VMALLOC_REGION_ID:
 		mm = &init_mm;
 		vsid = get_kernel_vsid(ea);
Index: working-2.6/arch/ppc64/mm/init.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/init.c	2005-05-11 10:05:49.000000000 +1000
+++ working-2.6/arch/ppc64/mm/init.c	2005-05-12 14:11:16.000000000 +1000
@@ -73,9 +73,6 @@
 extern pgd_t swapper_pg_dir[];
 extern struct task_struct *current_set[NR_CPUS];
 
-extern pgd_t ioremap_dir[];
-pgd_t * ioremap_pgd = (pgd_t *)&ioremap_dir;
-
 unsigned long klimit = (unsigned long)_end;
 
 unsigned long _SDR1=0;
@@ -137,69 +134,6 @@
 
 #else
 
-static void unmap_im_area_pte(pmd_t *pmd, unsigned long addr,
-				  unsigned long end)
-{
-	pte_t *pte;
-
-	pte = pte_offset_kernel(pmd, addr);
-	do {
-		pte_t ptent = ptep_get_and_clear(&ioremap_mm, addr, pte);
-		WARN_ON(!pte_none(ptent) && !pte_present(ptent));
-	} while (pte++, addr += PAGE_SIZE, addr != end);
-}
-
-static inline void unmap_im_area_pmd(pud_t *pud, unsigned long addr,
-				     unsigned long end)
-{
-	pmd_t *pmd;
-	unsigned long next;
-
-	pmd = pmd_offset(pud, addr);
-	do {
-		next = pmd_addr_end(addr, end);
-		if (pmd_none_or_clear_bad(pmd))
-			continue;
-		unmap_im_area_pte(pmd, addr, next);
-	} while (pmd++, addr = next, addr != end);
-}
-
-static inline void unmap_im_area_pud(pgd_t *pgd, unsigned long addr,
-				     unsigned long end)
-{
-	pud_t *pud;
-	unsigned long next;
-
-	pud = pud_offset(pgd, addr);
-	do {
-		next = pud_addr_end(addr, end);
-		if (pud_none_or_clear_bad(pud))
-			continue;
-		unmap_im_area_pmd(pud, addr, next);
-	} while (pud++, addr = next, addr != end);
-}
-
-static void unmap_im_area(unsigned long addr, unsigned long end)
-{
-	struct mm_struct *mm = &ioremap_mm;
-	unsigned long next;
-	pgd_t *pgd;
-
-	spin_lock(&mm->page_table_lock);
-
-	pgd = pgd_offset_i(addr);
-	flush_cache_vunmap(addr, end);
-	do {
-		next = pgd_addr_end(addr, end);
-		if (pgd_none_or_clear_bad(pgd))
-			continue;
-		unmap_im_area_pud(pgd, addr, next);
-	} while (pgd++, addr = next, addr != end);
-	flush_tlb_kernel_range(start, end);
-
-	spin_unlock(&mm->page_table_lock);
-}
-
 /*
  * map_io_page currently only called by __ioremap
  * map_io_page adds an entry to the ioremap page table
@@ -214,21 +148,21 @@
 	unsigned long vsid;
 
 	if (mem_init_done) {
-		spin_lock(&ioremap_mm.page_table_lock);
-		pgdp = pgd_offset_i(ea);
-		pudp = pud_alloc(&ioremap_mm, pgdp, ea);
+		spin_lock(&init_mm.page_table_lock);
+		pgdp = pgd_offset_k(ea);
+		pudp = pud_alloc(&init_mm, pgdp, ea);
 		if (!pudp)
 			return -ENOMEM;
-		pmdp = pmd_alloc(&ioremap_mm, pudp, ea);
+		pmdp = pmd_alloc(&init_mm, pudp, ea);
 		if (!pmdp)
 			return -ENOMEM;
-		ptep = pte_alloc_kernel(&ioremap_mm, pmdp, ea);
+		ptep = pte_alloc_kernel(&init_mm, pmdp, ea);
 		if (!ptep)
 			return -ENOMEM;
 		pa = abs_to_phys(pa);
-		set_pte_at(&ioremap_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
+		set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
 							  __pgprot(flags)));
-		spin_unlock(&ioremap_mm.page_table_lock);
+		spin_unlock(&init_mm.page_table_lock);
 	} else {
 		unsigned long va, vpn, hash, hpteg;
 
@@ -267,13 +201,9 @@
 
 	for (i = 0; i < size; i += PAGE_SIZE)
 		if (map_io_page(ea+i, pa+i, flags))
-			goto failure;
+			return NULL;
 
 	return (void __iomem *) (ea + (addr & ~PAGE_MASK));
- failure:
-	if (mem_init_done)
-		unmap_im_area(ea, ea + size);
-	return NULL;
 }
 
 
@@ -381,19 +311,14 @@
  */
 void iounmap(volatile void __iomem *token)
 {
-	unsigned long address, size;
 	void *addr;
 
 	if (!mem_init_done)
 		return;
 	
 	addr = (void *) ((unsigned long __force) token & PAGE_MASK);
-	
-	if ((size = im_free(addr)) == 0)
-		return;
 
-	address = (unsigned long)addr; 
-	unmap_im_area(address, address + size);
+	im_free(addr);
 }
 
 static int iounmap_subset_regions(unsigned long addr, unsigned long size)
Index: working-2.6/arch/ppc64/kernel/head.S
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/head.S	2005-04-26 15:37:55.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/head.S	2005-05-12 14:08:37.000000000 +1000
@@ -2121,10 +2121,6 @@
 swapper_pg_dir:
 	.space	4096
 
-	.globl	ioremap_dir
-ioremap_dir:
-	.space	4096
-
 #ifdef CONFIG_SMP
 /* 1 page segment table per cpu (max 48, cpu0 allocated at STAB0_PHYS_ADDR) */
 	.globl	stab_array
Index: working-2.6/arch/ppc64/mm/imalloc.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/imalloc.c	2005-05-11 10:05:49.000000000 +1000
+++ working-2.6/arch/ppc64/mm/imalloc.c	2005-05-12 14:20:33.000000000 +1000
@@ -15,6 +15,7 @@
 #include <asm/pgtable.h>
 #include <asm/semaphore.h>
 #include <asm/imalloc.h>
+#include <asm/cacheflush.h>
 
 static DECLARE_MUTEX(imlist_sem);
 struct vm_struct * imlist = NULL;
@@ -285,29 +286,32 @@
 	return area;
 }
 
-unsigned long im_free(void * addr)
+void im_free(void * addr)
 {
 	struct vm_struct **p, *tmp;
-	unsigned long ret_size = 0;
   
 	if (!addr)
-		return ret_size;
-	if ((PAGE_SIZE-1) & (unsigned long) addr) {
+		return;
+	if ((unsigned long) addr & ~PAGE_MASK) {
 		printk(KERN_ERR "Trying to %s bad address (%p)\n", __FUNCTION__,			addr);
-		return ret_size;
+		return;
 	}
 	down(&imlist_sem);
 	for (p = &imlist ; (tmp = *p) ; p = &tmp->next) {
 		if (tmp->addr == addr) {
-			ret_size = tmp->size;
 			*p = tmp->next;
+
+			/* XXX: do we need the lock? */
+			spin_lock(&init_mm.page_table_lock);
+			unmap_vm_area(tmp);
+			spin_unlock(&init_mm.page_table_lock);
+
 			kfree(tmp);
 			up(&imlist_sem);
-			return ret_size;
+			return;
 		}
 	}
 	up(&imlist_sem);
 	printk(KERN_ERR "Trying to %s nonexistent area (%p)\n", __FUNCTION__,
 			addr);
-	return ret_size;
 }


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
