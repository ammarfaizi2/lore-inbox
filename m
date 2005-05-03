Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVECA2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVECA2t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 20:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVECA2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 20:28:49 -0400
Received: from ozlabs.org ([203.10.76.45]:3817 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261249AbVECA0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 20:26:16 -0400
Date: Tue, 3 May 2005 10:26:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PPC64] pgtable.h and other header cleanups
Message-ID: <20050503002608.GA22453@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.

This patch started as simply removing a few never-used macros from
asm-ppc64/pgtable.h, then kind of grew.  It now makes a bunch of
cleanups to the ppc64 low-level header files (with corresponding
changes to .c files where necessary) such as:
	- Abolishing never-used macros
	- Eliminating multiple #defines with the same purpose
	- Removing pointless macros (cases where just expanding the
macro everywhere turns out clearer and more sensible)
	- Removing some cases where macros which could be defined in
terms of each other weren't
	- Moving imalloc() related definitions from pgtable.h to their
own header file (imalloc.h)
	- Re-arranging headers to group things more logically
	- Moving all VSID allocation related things to mmu.h, instead
of being split between mmu.h and mmu_context.h
	- Removing some reserved space for flags from the PMD - we're
not using it.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/include/asm-ppc64/pgtable.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/pgtable.h	2005-05-02 16:21:09.000000000 +1000
+++ working-2.6/include/asm-ppc64/pgtable.h	2005-05-02 17:58:29.000000000 +1000
@@ -17,16 +17,6 @@
 
 #include <asm-generic/pgtable-nopud.h>
 
-/* PMD_SHIFT determines what a second-level page table entry can map */
-#define PMD_SHIFT	(PAGE_SHIFT + PAGE_SHIFT - 3)
-#define PMD_SIZE	(1UL << PMD_SHIFT)
-#define PMD_MASK	(~(PMD_SIZE-1))
-
-/* PGDIR_SHIFT determines what a third-level page table entry can map */
-#define PGDIR_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT - 3) + (PAGE_SHIFT - 2))
-#define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
-#define PGDIR_MASK	(~(PGDIR_SIZE-1))
-
 /*
  * Entries per page directory level.  The PTE level must use a 64b record
  * for each page table entry.  The PMD and PGD level use a 32b record for 
@@ -40,40 +30,30 @@
 #define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
 #define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
 
-#define USER_PTRS_PER_PGD	(1024)
-#define FIRST_USER_ADDRESS	0
+/* PMD_SHIFT determines what a second-level page table entry can map */
+#define PMD_SHIFT	(PAGE_SHIFT + PTE_INDEX_SIZE)
+#define PMD_SIZE	(1UL << PMD_SHIFT)
+#define PMD_MASK	(~(PMD_SIZE-1))
 
-#define EADDR_SIZE (PTE_INDEX_SIZE + PMD_INDEX_SIZE + \
-                    PGD_INDEX_SIZE + PAGE_SHIFT) 
+/* PGDIR_SHIFT determines what a third-level page table entry can map */
+#define PGDIR_SHIFT	(PMD_SHIFT + PMD_INDEX_SIZE)
+#define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
+#define PGDIR_MASK	(~(PGDIR_SIZE-1))
+
+#define FIRST_USER_ADDRESS	0
 
 /*
  * Size of EA range mapped by our pagetables.
  */
-#define PGTABLE_EA_BITS	41
-#define PGTABLE_EA_MASK	((1UL<<PGTABLE_EA_BITS)-1)
+#define EADDR_SIZE (PTE_INDEX_SIZE + PMD_INDEX_SIZE + \
+                    PGD_INDEX_SIZE + PAGE_SHIFT) 
+#define EADDR_MASK ((1UL << EADDR_SIZE) - 1)
 
 /*
  * Define the address range of the vmalloc VM area.
  */
 #define VMALLOC_START (0xD000000000000000ul)
-#define VMALLOC_END   (VMALLOC_START + PGTABLE_EA_MASK)
-
-/*
- * Define the address range of the imalloc VM area.
- * (used for ioremap)
- */
-#define IMALLOC_START     (ioremap_bot)
-#define IMALLOC_VMADDR(x) ((unsigned long)(x))
-#define PHBS_IO_BASE  	  (0xE000000000000000ul)	/* Reserve 2 gigs for PHBs */
-#define IMALLOC_BASE      (0xE000000080000000ul)  
-#define IMALLOC_END       (IMALLOC_BASE + PGTABLE_EA_MASK)
-
-/*
- * Define the user address range
- */
-#define USER_START (0UL)
-#define USER_END   (USER_START + PGTABLE_EA_MASK)
-
+#define VMALLOC_END   (VMALLOC_START + EADDR_MASK)
 
 /*
  * Bits in a linux-style PTE.  These match the bits in the
@@ -168,10 +148,6 @@
 /* shift to put page number into pte */
 #define PTE_SHIFT (17)
 
-/* We allow 2^41 bytes of real memory, so we need 29 bits in the PMD
- * to give the PTE page number.  The bottom two bits are for flags. */
-#define PMD_TO_PTEPAGE_SHIFT (2)
-
 #ifdef CONFIG_HUGETLB_PAGE
 
 #ifndef __ASSEMBLY__
@@ -220,13 +196,12 @@
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 
 #define pmd_set(pmdp, ptep) 	\
-	(pmd_val(*(pmdp)) = (__ba_to_bpn(ptep) << PMD_TO_PTEPAGE_SHIFT))
+	(pmd_val(*(pmdp)) = __ba_to_bpn(ptep))
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(pmd_val(pmd) == 0)
 #define	pmd_present(pmd)	(pmd_val(pmd) != 0)
 #define	pmd_clear(pmdp)		(pmd_val(*(pmdp)) = 0)
-#define pmd_page_kernel(pmd)	\
-	(__bpn_to_ba(pmd_val(pmd) >> PMD_TO_PTEPAGE_SHIFT))
+#define pmd_page_kernel(pmd)	(__bpn_to_ba(pmd_val(pmd)))
 #define pmd_page(pmd)		virt_to_page(pmd_page_kernel(pmd))
 
 #define pud_set(pudp, pmdp)	(pud_val(*(pudp)) = (__ba_to_bpn(pmdp)))
@@ -266,8 +241,6 @@
 /* to find an entry in the ioremap page-table-directory */
 #define pgd_offset_i(address) (ioremap_pgd + pgd_index(address))
 
-#define pages_to_mb(x)		((x) >> (20-PAGE_SHIFT))
-
 /*
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
@@ -487,18 +460,13 @@
 
 extern unsigned long ioremap_bot, ioremap_base;
 
-#define USER_PGD_PTRS (PAGE_OFFSET >> PGDIR_SHIFT)
-#define KERNEL_PGD_PTRS (PTRS_PER_PGD-USER_PGD_PTRS)
-
-#define pte_ERROR(e) \
-	printk("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
 #define pmd_ERROR(e) \
 	printk("%s:%d: bad pmd %08x.\n", __FILE__, __LINE__, pmd_val(e))
 #define pgd_ERROR(e) \
 	printk("%s:%d: bad pgd %08x.\n", __FILE__, __LINE__, pgd_val(e))
 
-extern pgd_t swapper_pg_dir[1024];
-extern pgd_t ioremap_dir[1024];
+extern pgd_t swapper_pg_dir[];
+extern pgd_t ioremap_dir[];
 
 extern void paging_init(void);
 
@@ -540,43 +508,11 @@
  */
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
-		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
-
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
 		remap_pfn_range(vma, vaddr, pfn, size, prot)
 
-#define MK_IOSPACE_PFN(space, pfn)	(pfn)
-#define GET_IOSPACE(pfn)		0
-#define GET_PFN(pfn)			(pfn)
-
 void pgtable_cache_init(void);
 
-extern void hpte_init_native(void);
-extern void hpte_init_lpar(void);
-extern void hpte_init_iSeries(void);
-
-/* imalloc region types */
-#define IM_REGION_UNUSED	0x1
-#define IM_REGION_SUBSET	0x2
-#define IM_REGION_EXISTS	0x4
-#define IM_REGION_OVERLAP	0x8
-#define IM_REGION_SUPERSET	0x10
-
-extern struct vm_struct * im_get_free_area(unsigned long size);
-extern struct vm_struct * im_get_area(unsigned long v_addr, unsigned long size,
-			int region_type);
-unsigned long im_free(void *addr);
-
-extern long pSeries_lpar_hpte_insert(unsigned long hpte_group,
-				     unsigned long va, unsigned long prpn,
-				     int secondary, unsigned long hpteflags,
-				     int bolted, int large);
-
-extern long native_hpte_insert(unsigned long hpte_group, unsigned long va,
-			       unsigned long prpn, int secondary,
-			       unsigned long hpteflags, int bolted, int large);
-
 /*
  * find_linux_pte returns the address of a linux pte for a given 
  * effective address and directory.  If not found, it returns zero.
Index: working-2.6/include/asm-ppc64/page.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/page.h	2005-05-02 16:21:09.000000000 +1000
+++ working-2.6/include/asm-ppc64/page.h	2005-05-02 16:21:43.000000000 +1000
@@ -23,7 +23,6 @@
 #define PAGE_SHIFT	12
 #define PAGE_SIZE	(ASM_CONST(1) << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))
-#define PAGE_OFFSET_MASK (PAGE_SIZE-1)
 
 #define SID_SHIFT       28
 #define SID_MASK        0xfffffffffUL
@@ -85,9 +84,6 @@
 /* align addr on a size boundary - adjust address up if needed */
 #define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
 
-/* to align the pointer to the (next) double word boundary */
-#define DOUBLEWORD_ALIGN(addr)	_ALIGN(addr,sizeof(unsigned long))
-
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	_ALIGN(addr, PAGE_SIZE)
 
@@ -100,7 +96,6 @@
 #define REGION_SIZE   4UL
 #define REGION_SHIFT  60UL
 #define REGION_MASK   (((1UL<<REGION_SIZE)-1UL)<<REGION_SHIFT)
-#define REGION_STRIDE (1UL << REGION_SHIFT)
 
 static __inline__ void clear_page(void *addr)
 {
@@ -209,13 +204,13 @@
 #define VMALLOCBASE     ASM_CONST(0xD000000000000000)
 #define IOREGIONBASE    ASM_CONST(0xE000000000000000)
 
-#define IO_REGION_ID       (IOREGIONBASE>>REGION_SHIFT)
-#define VMALLOC_REGION_ID  (VMALLOCBASE>>REGION_SHIFT)
-#define KERNEL_REGION_ID   (KERNELBASE>>REGION_SHIFT)
+#define IO_REGION_ID       (IOREGIONBASE >> REGION_SHIFT)
+#define VMALLOC_REGION_ID  (VMALLOCBASE >> REGION_SHIFT)
+#define KERNEL_REGION_ID   (KERNELBASE >> REGION_SHIFT)
 #define USER_REGION_ID     (0UL)
-#define REGION_ID(X)	   (((unsigned long)(X))>>REGION_SHIFT)
+#define REGION_ID(ea)	   (((unsigned long)(ea)) >> REGION_SHIFT)
 
-#define __bpn_to_ba(x) ((((unsigned long)(x))<<PAGE_SHIFT) + KERNELBASE)
+#define __bpn_to_ba(x) ((((unsigned long)(x)) << PAGE_SHIFT) + KERNELBASE)
 #define __ba_to_bpn(x) ((((unsigned long)(x)) & ~REGION_MASK) >> PAGE_SHIFT)
 
 #define __va(x) ((void *)((unsigned long)(x) + KERNELBASE))
Index: working-2.6/arch/ppc64/mm/imalloc.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/imalloc.c	2005-04-26 15:37:55.000000000 +1000
+++ working-2.6/arch/ppc64/mm/imalloc.c	2005-05-02 16:59:40.000000000 +1000
@@ -14,6 +14,7 @@
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/semaphore.h>
+#include <asm/imalloc.h>
 
 static DECLARE_MUTEX(imlist_sem);
 struct vm_struct * imlist = NULL;
@@ -23,11 +24,11 @@
 	unsigned long addr;
 	struct vm_struct **p, *tmp;
 
-	addr = IMALLOC_START;
+	addr = ioremap_bot;
 	for (p = &imlist; (tmp = *p) ; p = &tmp->next) {
 		if (size + addr < (unsigned long) tmp->addr)
 			break;
-		if ((unsigned long)tmp->addr >= IMALLOC_START) 
+		if ((unsigned long)tmp->addr >= ioremap_bot) 
 			addr = tmp->size + (unsigned long) tmp->addr;
 		if (addr > IMALLOC_END-size) 
 			return 1;
Index: working-2.6/arch/ppc64/mm/hash_utils.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hash_utils.c	2005-04-26 15:37:55.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hash_utils.c	2005-05-02 16:56:17.000000000 +1000
@@ -298,24 +298,23 @@
 	int local = 0;
 	cpumask_t tmp;
 
+	if ((ea & ~REGION_MASK) > EADDR_MASK)
+		return 1;
+
  	switch (REGION_ID(ea)) {
 	case USER_REGION_ID:
 		user_region = 1;
 		mm = current->mm;
-		if ((ea > USER_END) || (! mm))
+		if (! mm)
 			return 1;
 
 		vsid = get_vsid(mm->context.id, ea);
 		break;
 	case IO_REGION_ID:
-		if (ea > IMALLOC_END)
-			return 1;
 		mm = &ioremap_mm;
 		vsid = get_kernel_vsid(ea);
 		break;
 	case VMALLOC_REGION_ID:
-		if (ea > VMALLOC_END)
-			return 1;
 		mm = &init_mm;
 		vsid = get_kernel_vsid(ea);
 		break;
@@ -362,7 +361,7 @@
 	unsigned long vsid, vpn, va, hash, secondary, slot;
 	unsigned long huge = pte_huge(pte);
 
-	if ((ea >= USER_START) && (ea <= USER_END))
+	if (ea < KERNELBASE)
 		vsid = get_vsid(context, ea);
 	else
 		vsid = get_kernel_vsid(ea);
Index: working-2.6/arch/ppc64/mm/hash_native.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hash_native.c	2005-04-26 15:37:55.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hash_native.c	2005-05-02 16:51:44.000000000 +1000
@@ -320,8 +320,7 @@
 
 	j = 0;
 	for (i = 0; i < number; i++) {
-		if ((batch->addr[i] >= USER_START) &&
-		    (batch->addr[i] <= USER_END))
+		if (batch->addr[i] < KERNELBASE)
 			vsid = get_vsid(context, batch->addr[i]);
 		else
 			vsid = get_kernel_vsid(batch->addr[i]);
Index: working-2.6/arch/ppc64/mm/init.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/init.c	2005-05-02 08:57:20.000000000 +1000
+++ working-2.6/arch/ppc64/mm/init.c	2005-05-02 16:38:18.000000000 +1000
@@ -64,6 +64,7 @@
 #include <asm/iommu.h>
 #include <asm/abs_addr.h>
 #include <asm/vdso.h>
+#include <asm/imalloc.h>
 
 int mem_init_done;
 unsigned long ioremap_bot = IMALLOC_BASE;
Index: working-2.6/include/asm-ppc64/mmu.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/mmu.h	2005-04-26 15:38:02.000000000 +1000
+++ working-2.6/include/asm-ppc64/mmu.h	2005-05-02 17:45:59.000000000 +1000
@@ -15,19 +15,10 @@
 
 #include <linux/config.h>
 #include <asm/page.h>
-#include <linux/stringify.h>
 
-#ifndef __ASSEMBLY__
-
-/* Time to allow for more things here */
-typedef unsigned long mm_context_id_t;
-typedef struct {
-	mm_context_id_t id;
-#ifdef CONFIG_HUGETLB_PAGE
-	pgd_t *huge_pgdir;
-	u16 htlb_segs; /* bitmask */
-#endif
-} mm_context_t;
+/*
+ * Segment table
+ */
 
 #define STE_ESID_V	0x80
 #define STE_ESID_KS	0x20
@@ -36,15 +27,48 @@
 
 #define STE_VSID_SHIFT	12
 
-struct stab_entry {
-	unsigned long esid_data;
-	unsigned long vsid_data;
-};
+/* Location of cpu0's segment table */
+#define STAB0_PAGE	0x9
+#define STAB0_PHYS_ADDR	(STAB0_PAGE<<PAGE_SHIFT)
+#define STAB0_VIRT_ADDR	(KERNELBASE+STAB0_PHYS_ADDR)
+
+/*
+ * SLB
+ */
 
-/* Hardware Page Table Entry */
+#define SLB_NUM_BOLTED		3
+#define SLB_CACHE_ENTRIES	8
+
+/* Bits in the SLB ESID word */
+#define SLB_ESID_V		ASM_CONST(0x0000000008000000) /* valid */
+
+/* Bits in the SLB VSID word */
+#define SLB_VSID_SHIFT		12
+#define SLB_VSID_KS		ASM_CONST(0x0000000000000800)
+#define SLB_VSID_KP		ASM_CONST(0x0000000000000400)
+#define SLB_VSID_N		ASM_CONST(0x0000000000000200) /* no-execute */
+#define SLB_VSID_L		ASM_CONST(0x0000000000000100) /* largepage 16M */
+#define SLB_VSID_C		ASM_CONST(0x0000000000000080) /* class */
+
+#define SLB_VSID_KERNEL		(SLB_VSID_KP|SLB_VSID_C)
+#define SLB_VSID_USER		(SLB_VSID_KP|SLB_VSID_KS)
+
+/*
+ * Hash table
+ */
 
 #define HPTES_PER_GROUP 8
 
+/* Values for PP (assumes Ks=0, Kp=1) */
+/* pp0 will always be 0 for linux     */
+#define PP_RWXX	0	/* Supervisor read/write, User none */
+#define PP_RWRX 1	/* Supervisor read/write, User read */
+#define PP_RWRW 2	/* Supervisor read/write, User read/write */
+#define PP_RXRX 3	/* Supervisor read,       User read */
+
+#ifndef __ASSEMBLY__
+
+/* Hardware Page Table Entry */
 typedef struct {
 	unsigned long avpn:57; /* vsid | api == avpn  */
 	unsigned long :     2; /* Software use */
@@ -90,14 +114,6 @@
 	} dw1;
 } HPTE; 
 
-/* Values for PP (assumes Ks=0, Kp=1) */
-/* pp0 will always be 0 for linux     */
-#define PP_RWXX	0	/* Supervisor read/write, User none */
-#define PP_RWRX 1	/* Supervisor read/write, User read */
-#define PP_RWRW 2	/* Supervisor read/write, User read/write */
-#define PP_RXRX 3	/* Supervisor read,       User read */
-
-
 extern HPTE *		htab_address;
 extern unsigned long	htab_hash_mask;
 
@@ -174,31 +190,70 @@
 
 extern void htab_finish_init(void);
 
+extern void hpte_init_native(void);
+extern void hpte_init_lpar(void);
+extern void hpte_init_iSeries(void);
+
+extern long pSeries_lpar_hpte_insert(unsigned long hpte_group,
+				     unsigned long va, unsigned long prpn,
+				     int secondary, unsigned long hpteflags,
+				     int bolted, int large);
+extern long native_hpte_insert(unsigned long hpte_group, unsigned long va,
+			       unsigned long prpn, int secondary,
+			       unsigned long hpteflags, int bolted, int large);
+
 #endif /* __ASSEMBLY__ */
 
 /*
- * Location of cpu0's segment table
+ * VSID allocation
+ *
+ * We first generate a 36-bit "proto-VSID".  For kernel addresses this
+ * is equal to the ESID, for user addresses it is:
+ *	(context << 15) | (esid & 0x7fff)
+ *
+ * The two forms are distinguishable because the top bit is 0 for user
+ * addresses, whereas the top two bits are 1 for kernel addresses.
+ * Proto-VSIDs with the top two bits equal to 0b10 are reserved for
+ * now.
+ *
+ * The proto-VSIDs are then scrambled into real VSIDs with the
+ * multiplicative hash:
+ *
+ *	VSID = (proto-VSID * VSID_MULTIPLIER) % VSID_MODULUS
+ *	where	VSID_MULTIPLIER = 268435399 = 0xFFFFFC7
+ *		VSID_MODULUS = 2^36-1 = 0xFFFFFFFFF
+ *
+ * This scramble is only well defined for proto-VSIDs below
+ * 0xFFFFFFFFF, so both proto-VSID and actual VSID 0xFFFFFFFFF are
+ * reserved.  VSID_MULTIPLIER is prime, so in particular it is
+ * co-prime to VSID_MODULUS, making this a 1:1 scrambling function.
+ * Because the modulus is 2^n-1 we can compute it efficiently without
+ * a divide or extra multiply (see below).
+ *
+ * This scheme has several advantages over older methods:
+ *
+ * 	- We have VSIDs allocated for every kernel address
+ * (i.e. everything above 0xC000000000000000), except the very top
+ * segment, which simplifies several things.
+ *
+ * 	- We allow for 15 significant bits of ESID and 20 bits of
+ * context for user addresses.  i.e. 8T (43 bits) of address space for
+ * up to 1M contexts (although the page table structure and context
+ * allocation will need changes to take advantage of this).
+ *
+ * 	- The scramble function gives robust scattering in the hash
+ * table (at least based on some initial results).  The previous
+ * method was more susceptible to pathological cases giving excessive
+ * hash collisions.
+ */
+/*
+ * WARNING - If you change these you must make sure the asm
+ * implementations in slb_allocate (slb_low.S), do_stab_bolted
+ * (head.S) and ASM_VSID_SCRAMBLE (below) are changed accordingly.
+ *
+ * You'll also need to change the precomputed VSID values in head.S
+ * which are used by the iSeries firmware.
  */
-#define STAB0_PAGE	0x9
-#define STAB0_PHYS_ADDR	(STAB0_PAGE<<PAGE_SHIFT)
-#define STAB0_VIRT_ADDR	(KERNELBASE+STAB0_PHYS_ADDR)
-
-#define SLB_NUM_BOLTED		3
-#define SLB_CACHE_ENTRIES	8
-
-/* Bits in the SLB ESID word */
-#define SLB_ESID_V		0x0000000008000000	/* entry is valid */
-
-/* Bits in the SLB VSID word */
-#define SLB_VSID_SHIFT		12
-#define SLB_VSID_KS		0x0000000000000800
-#define SLB_VSID_KP		0x0000000000000400
-#define SLB_VSID_N		0x0000000000000200	/* no-execute */
-#define SLB_VSID_L		0x0000000000000100	/* largepage (4M) */
-#define SLB_VSID_C		0x0000000000000080	/* class */
-
-#define SLB_VSID_KERNEL		(SLB_VSID_KP|SLB_VSID_C)
-#define SLB_VSID_USER		(SLB_VSID_KP|SLB_VSID_KS)
 
 #define VSID_MULTIPLIER	ASM_CONST(200730139)	/* 28-bit prime */
 #define VSID_BITS	36
@@ -239,4 +294,50 @@
 	srdi	rx,rx,VSID_BITS;	/* extract 2^36 bit */		\
 	add	rt,rt,rx
 
+
+#ifndef __ASSEMBLY__
+
+typedef unsigned long mm_context_id_t;
+
+typedef struct {
+	mm_context_id_t id;
+#ifdef CONFIG_HUGETLB_PAGE
+	pgd_t *huge_pgdir;
+	u16 htlb_segs; /* bitmask */
+#endif
+} mm_context_t;
+
+
+static inline unsigned long vsid_scramble(unsigned long protovsid)
+{
+#if 0
+	/* The code below is equivalent to this function for arguments
+	 * < 2^VSID_BITS, which is all this should ever be called
+	 * with.  However gcc is not clever enough to compute the
+	 * modulus (2^n-1) without a second multiply. */
+	return ((protovsid * VSID_MULTIPLIER) % VSID_MODULUS);
+#else /* 1 */
+	unsigned long x;
+
+	x = protovsid * VSID_MULTIPLIER;
+	x = (x >> VSID_BITS) + (x & VSID_MODULUS);
+	return (x + ((x+1) >> VSID_BITS)) & VSID_MODULUS;
+#endif /* 1 */
+}
+
+/* This is only valid for addresses >= KERNELBASE */
+static inline unsigned long get_kernel_vsid(unsigned long ea)
+{
+	return vsid_scramble(ea >> SID_SHIFT);
+}
+
+/* This is only valid for user addresses (which are below 2^41) */
+static inline unsigned long get_vsid(unsigned long context, unsigned long ea)
+{
+	return vsid_scramble((context << USER_ESID_BITS)
+			     | (ea >> SID_SHIFT));
+}
+
+#endif /* __ASSEMBLY */
+
 #endif /* _PPC64_MMU_H_ */
Index: working-2.6/arch/ppc64/mm/stab.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/stab.c	2005-04-26 15:37:55.000000000 +1000
+++ working-2.6/arch/ppc64/mm/stab.c	2005-05-02 17:29:03.000000000 +1000
@@ -19,6 +19,11 @@
 #include <asm/paca.h>
 #include <asm/cputable.h>
 
+struct stab_entry {
+	unsigned long esid_data;
+	unsigned long vsid_data;
+};
+
 /* Both the segment table and SLB code uses the following cache */
 #define NR_STAB_CACHE_ENTRIES 8
 DEFINE_PER_CPU(long, stab_cache_ptr);
Index: working-2.6/include/asm-ppc64/mmu_context.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/mmu_context.h	2005-04-26 15:38:02.000000000 +1000
+++ working-2.6/include/asm-ppc64/mmu_context.h	2005-05-02 17:41:49.000000000 +1000
@@ -84,86 +84,4 @@
 	local_irq_restore(flags);
 }
 
-/* VSID allocation
- * ===============
- *
- * We first generate a 36-bit "proto-VSID".  For kernel addresses this
- * is equal to the ESID, for user addresses it is:
- *	(context << 15) | (esid & 0x7fff)
- *
- * The two forms are distinguishable because the top bit is 0 for user
- * addresses, whereas the top two bits are 1 for kernel addresses.
- * Proto-VSIDs with the top two bits equal to 0b10 are reserved for
- * now.
- *
- * The proto-VSIDs are then scrambled into real VSIDs with the
- * multiplicative hash:
- *
- *	VSID = (proto-VSID * VSID_MULTIPLIER) % VSID_MODULUS
- *	where	VSID_MULTIPLIER = 268435399 = 0xFFFFFC7
- *		VSID_MODULUS = 2^36-1 = 0xFFFFFFFFF
- *
- * This scramble is only well defined for proto-VSIDs below
- * 0xFFFFFFFFF, so both proto-VSID and actual VSID 0xFFFFFFFFF are
- * reserved.  VSID_MULTIPLIER is prime, so in particular it is
- * co-prime to VSID_MODULUS, making this a 1:1 scrambling function.
- * Because the modulus is 2^n-1 we can compute it efficiently without
- * a divide or extra multiply (see below).
- *
- * This scheme has several advantages over older methods:
- *
- * 	- We have VSIDs allocated for every kernel address
- * (i.e. everything above 0xC000000000000000), except the very top
- * segment, which simplifies several things.
- *
- * 	- We allow for 15 significant bits of ESID and 20 bits of
- * context for user addresses.  i.e. 8T (43 bits) of address space for
- * up to 1M contexts (although the page table structure and context
- * allocation will need changes to take advantage of this).
- *
- * 	- The scramble function gives robust scattering in the hash
- * table (at least based on some initial results).  The previous
- * method was more susceptible to pathological cases giving excessive
- * hash collisions.
- */
-
-/*
- * WARNING - If you change these you must make sure the asm
- * implementations in slb_allocate(), do_stab_bolted and mmu.h
- * (ASM_VSID_SCRAMBLE macro) are changed accordingly.
- *
- * You'll also need to change the precomputed VSID values in head.S
- * which are used by the iSeries firmware.
- */
-
-static inline unsigned long vsid_scramble(unsigned long protovsid)
-{
-#if 0
-	/* The code below is equivalent to this function for arguments
-	 * < 2^VSID_BITS, which is all this should ever be called
-	 * with.  However gcc is not clever enough to compute the
-	 * modulus (2^n-1) without a second multiply. */
-	return ((protovsid * VSID_MULTIPLIER) % VSID_MODULUS);
-#else /* 1 */
-	unsigned long x;
-
-	x = protovsid * VSID_MULTIPLIER;
-	x = (x >> VSID_BITS) + (x & VSID_MODULUS);
-	return (x + ((x+1) >> VSID_BITS)) & VSID_MODULUS;
-#endif /* 1 */
-}
-
-/* This is only valid for addresses >= KERNELBASE */
-static inline unsigned long get_kernel_vsid(unsigned long ea)
-{
-	return vsid_scramble(ea >> SID_SHIFT);
-}
-
-/* This is only valid for user addresses (which are below 2^41) */
-static inline unsigned long get_vsid(unsigned long context, unsigned long ea)
-{
-	return vsid_scramble((context << USER_ESID_BITS)
-			     | (ea >> SID_SHIFT));
-}
-
 #endif /* __PPC64_MMU_CONTEXT_H */


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
