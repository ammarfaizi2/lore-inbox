Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVCRTpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVCRTpU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 14:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVCRTou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 14:44:50 -0500
Received: from fire.osdl.org ([65.172.181.4]:50322 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262062AbVCRTjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 14:39:52 -0500
Date: Fri, 18 Mar 2005 11:33:52 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-mm@kvack.org, akpm@osdl.org, davem@davemloft.net, wli@holomorphy.com,
       riel@redhat.com, kurt@garloff.de, Keir.Fraser@cl.cam.ac.uk,
       Ian.Pratt@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
Subject: [PATCH 1/4] io_remap_pfn_range: add for all arch-es
Message-Id: <20050318113352.0baaaf5e.rddunlap@osdl.org>
In-Reply-To: <20050318112545.6f5f7635.rddunlap@osdl.org>
References: <20050318112545.6f5f7635.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


io_remap_pfn_range():
  add io_remap_pfn_range() for all arches;
  add MK_IOSPACE_PFN(), GET_IOSPACE(), and GET_PFN()
	for all arches but primarily for sparc32/64's extended IO space,
  sparc: kill the hack of using low bit of <offset> to mean
	write_combine or set side-effect (_PAGE_E) bit;
	(DaveM suggested that I kill it;)
  future: convert remaining callers of io_remap_page_range() to
	io_remap_pfn_range() and deprecate io_remap_page_range();

 arch/sparc/kernel/sparc_ksyms.c     |    1
 arch/sparc/mm/generic.c             |   34 ++++++++++++++++++++++++
 arch/sparc64/kernel/pci.c           |   15 +++++-----
 arch/sparc64/kernel/sparc64_ksyms.c |    6 +++-
 arch/sparc64/mm/generic.c           |   50 ++++++++++++++++++++++++++++--------
 include/asm-alpha/pgtable.h         |    7 +++++
 include/asm-arm/pgtable.h           |    7 +++++
 include/asm-arm26/pgtable.h         |    7 +++++
 include/asm-frv/pgtable.h           |    7 +++++
 include/asm-h8300/pgtable.h         |    7 +++++
 include/asm-i386/pgtable.h          |    7 +++++
 include/asm-ia64/pgtable.h          |    7 +++++
 include/asm-m32r/pgtable.h          |    7 +++++
 include/asm-m68k/pgtable.h          |    7 +++++
 include/asm-m68knommu/pgtable.h     |    7 +++++
 include/asm-mips/pgtable.h          |   18 ++++++++++++
 include/asm-parisc/pgtable.h        |    7 +++++
 include/asm-ppc/pgtable.h           |   16 +++++++++++
 include/asm-ppc64/pgtable.h         |    7 +++++
 include/asm-sh/pgtable.h            |    7 +++++
 include/asm-sh64/pgtable.h          |    8 +++++
 include/asm-sparc/pgtable.h         |   14 +++++++++-
 include/asm-sparc64/pgtable.h       |   12 ++++++++
 include/asm-x86_64/pgtable.h        |    7 +++++
 24 files changed, 251 insertions(+), 21 deletions(-)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/arch/sparc/kernel/sparc_ksyms.c linux-2611-bk3-pfn/arch/sparc/kernel/sparc_ksyms.c
--- linux-2611-bk3-pv/arch/sparc/kernel/sparc_ksyms.c	2005-03-01 23:37:48.000000000 -0800
+++ linux-2611-bk3-pfn/arch/sparc/kernel/sparc_ksyms.c	2005-03-07 11:04:59.000000000 -0800
@@ -164,6 +164,7 @@ EXPORT_SYMBOL(get_auxio);
 #endif
 EXPORT_SYMBOL(request_fast_irq);
 EXPORT_SYMBOL(io_remap_page_range);
+EXPORT_SYMBOL(io_remap_pfn_range);
   /* P3: iounit_xxx may be needed, sun4d users */
 /* EXPORT_SYMBOL(iounit_map_dma_init); */
 /* EXPORT_SYMBOL(iounit_map_dma_page); */
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/arch/sparc/mm/generic.c linux-2611-bk3-pfn/arch/sparc/mm/generic.c
--- linux-2611-bk3-pv/arch/sparc/mm/generic.c	2005-03-07 11:02:16.000000000 -0800
+++ linux-2611-bk3-pfn/arch/sparc/mm/generic.c	2005-03-07 13:23:18.000000000 -0800
@@ -118,3 +118,37 @@ int io_remap_page_range(struct vm_area_s
 	flush_tlb_range(vma, beg, end);
 	return error;
 }
+
+int io_remap_pfn_range(struct vm_area_struct *vma, unsigned long from,
+			unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	int error = 0;
+	pgd_t * dir;
+	unsigned long beg = from;
+	unsigned long end = from + size;
+	struct mm_struct *mm = vma->vm_mm;
+	int space = GET_IOSPACE(pfn);
+	unsigned long offset = GET_PFN(pfn) << PAGE_SHIFT;
+
+	prot = __pgprot(pg_iobits);
+	offset -= from;
+	dir = pgd_offset(mm, from);
+	flush_cache_range(vma, beg, end);
+
+	spin_lock(&mm->page_table_lock);
+	while (from < end) {
+		pmd_t *pmd = pmd_alloc(current->mm, dir, from);
+		error = -ENOMEM;
+		if (!pmd)
+			break;
+		error = io_remap_pmd_range(mm, pmd, from, end - from, offset + from, prot, space);
+		if (error)
+			break;
+		from = (from + PGDIR_SIZE) & PGDIR_MASK;
+		dir++;
+	}
+	spin_unlock(&mm->page_table_lock);
+
+	flush_tlb_range(vma, beg, end);
+	return error;
+}
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/arch/sparc64/kernel/pci.c linux-2611-bk3-pfn/arch/sparc64/kernel/pci.c
--- linux-2611-bk3-pv/arch/sparc64/kernel/pci.c	2005-03-07 11:02:16.000000000 -0800
+++ linux-2611-bk3-pfn/arch/sparc64/kernel/pci.c	2005-03-07 11:04:59.000000000 -0800
@@ -18,6 +18,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/pbm.h>
+#include <asm/pgtable.h>
 #include <asm/irq.h>
 #include <asm/ebus.h>
 #include <asm/isa.h>
@@ -734,12 +735,10 @@ static void __pci_mmap_set_flags(struct 
 static void __pci_mmap_set_pgprot(struct pci_dev *dev, struct vm_area_struct *vma,
 					     enum pci_mmap_state mmap_state)
 {
-	/* Our io_remap_page_range takes care of this, do nothing. */
+	/* Our io_remap_page_range/io_remap_pfn_range takes care of this,
+	   do nothing. */
 }
 
-extern int io_remap_page_range(struct vm_area_struct *vma, unsigned long from, unsigned long offset,
-			       unsigned long size, pgprot_t prot, int space);
-
 /* Perform the actual remap of the pages for a PCI device mapping, as appropriate
  * for this architecture.  The region in the process to map is described by vm_start
  * and vm_end members of VMA, the base physical address is found in vm_pgoff.
@@ -761,10 +760,10 @@ int pci_mmap_page_range(struct pci_dev *
 	__pci_mmap_set_flags(dev, vma, mmap_state);
 	__pci_mmap_set_pgprot(dev, vma, mmap_state);
 
-	ret = io_remap_page_range(vma, vma->vm_start,
-				  (vma->vm_pgoff << PAGE_SHIFT |
-				   (write_combine ? 0x1UL : 0x0UL)),
-				  vma->vm_end - vma->vm_start, vma->vm_page_prot, 0);
+	ret = io_remap_pfn_range(vma, vma->vm_start,
+				 vma->vm_pgoff,
+				 vma->vm_end - vma->vm_start,
+				 vma->vm_page_prot);
 	if (ret)
 		return ret;
 
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/arch/sparc64/kernel/sparc64_ksyms.c linux-2611-bk3-pfn/arch/sparc64/kernel/sparc64_ksyms.c
--- linux-2611-bk3-pv/arch/sparc64/kernel/sparc64_ksyms.c	2005-03-01 23:38:20.000000000 -0800
+++ linux-2611-bk3-pfn/arch/sparc64/kernel/sparc64_ksyms.c	2005-03-07 11:04:59.000000000 -0800
@@ -87,7 +87,10 @@ extern int svr4_setcontext(svr4_ucontext
 extern int compat_sys_ioctl(unsigned int fd, unsigned int cmd, u32 arg);
 extern int (*handle_mathemu)(struct pt_regs *, struct fpustate *);
 extern long sparc32_open(const char __user * filename, int flags, int mode);
-extern int io_remap_page_range(struct vm_area_struct *vma, unsigned long from, unsigned long offset, unsigned long size, pgprot_t prot, int space);
+extern int io_remap_page_range(struct vm_area_struct *vma, unsigned long from,
+	unsigned long offset, unsigned long size, pgprot_t prot, int space);
+extern int io_remap_pfn_range(struct vm_area_struct *vma, unsigned long from,
+	unsigned long pfn, unsigned long size, pgprot_t prot);
 extern void (*prom_palette)(int);
 
 extern int __ashrdi3(int, int);
@@ -254,6 +257,7 @@ EXPORT_SYMBOL(pci_dma_supported);
 
 /* I/O device mmaping on Sparc64. */
 EXPORT_SYMBOL(io_remap_page_range);
+EXPORT_SYMBOL(io_remap_pfn_range);
 
 /* Solaris/SunOS binary compatibility */
 EXPORT_SYMBOL(_sigpause_common);
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/arch/sparc64/mm/generic.c linux-2611-bk3-pfn/arch/sparc64/mm/generic.c
--- linux-2611-bk3-pv/arch/sparc64/mm/generic.c	2005-03-07 11:02:16.000000000 -0800
+++ linux-2611-bk3-pfn/arch/sparc64/mm/generic.c	2005-03-07 13:27:06.000000000 -0800
@@ -20,10 +20,6 @@
  *
  * They use a pgprot that sets PAGE_IO and does not check the
  * mem_map table as this is independent of normal memory.
- *
- * As a special hack if the lowest bit of offset is set the
- * side-effect bit will be turned off.  This is used as a
- * performance improvement on FFB/AFB. -DaveM
  */
 static inline void io_remap_pte_range(struct mm_struct *mm, pte_t * pte,
 				      unsigned long address,
@@ -33,6 +29,8 @@ static inline void io_remap_pte_range(st
 {
 	unsigned long end;
 
+	/* clear hack bit that was used as a write_combine side-effect flag */
+	offset &= ~0x1UL;
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
@@ -41,22 +39,22 @@ static inline void io_remap_pte_range(st
 		pte_t entry;
 		unsigned long curend = address + PAGE_SIZE;
 		
-		entry = mk_pte_io((offset & ~(0x1UL)), prot, space);
+		entry = mk_pte_io(offset, prot, space);
 		if (!(address & 0xffff)) {
 			if (!(address & 0x3fffff) && !(offset & 0x3ffffe) && end >= address + 0x400000) {
-				entry = mk_pte_io((offset & ~(0x1UL)),
+				entry = mk_pte_io(offset,
 						  __pgprot(pgprot_val (prot) | _PAGE_SZ4MB),
 						  space);
 				curend = address + 0x400000;
 				offset += 0x400000;
 			} else if (!(address & 0x7ffff) && !(offset & 0x7fffe) && end >= address + 0x80000) {
-				entry = mk_pte_io((offset & ~(0x1UL)),
+				entry = mk_pte_io(offset,
 						  __pgprot(pgprot_val (prot) | _PAGE_SZ512K),
 						  space);
 				curend = address + 0x80000;
 				offset += 0x80000;
 			} else if (!(offset & 0xfffe) && end >= address + 0x10000) {
-				entry = mk_pte_io((offset & ~(0x1UL)),
+				entry = mk_pte_io(offset,
 						  __pgprot(pgprot_val (prot) | _PAGE_SZ64K),
 						  space);
 				curend = address + 0x10000;
@@ -66,8 +64,6 @@ static inline void io_remap_pte_range(st
 		} else
 			offset += PAGE_SIZE;
 
-		if (offset & 0x1UL)
-			pte_val(entry) &= ~(_PAGE_E);
 		do {
 			BUG_ON(!pte_none(*pte));
 			set_pte_at(mm, address, pte, entry);
@@ -150,3 +146,37 @@ int io_remap_page_range(struct vm_area_s
 
 	return error;
 }
+
+int io_remap_pfn_range(struct vm_area_struct *vma, unsigned long from,
+		unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	int error = 0;
+	pgd_t * dir;
+	unsigned long beg = from;
+	unsigned long end = from + size;
+	struct mm_struct *mm = vma->vm_mm;
+	int space = GET_IOSPACE(pfn);
+	unsigned long offset = GET_PFN(pfn) << PAGE_SHIFT;
+
+	prot = __pgprot(pg_iobits);
+	offset -= from;
+	dir = pgd_offset(mm, from);
+	flush_cache_range(vma, beg, end);
+
+	spin_lock(&mm->page_table_lock);
+	while (from < end) {
+		pud_t *pud = pud_alloc(current->mm, dir, from);
+		error = -ENOMEM;
+		if (!pud)
+			break;
+		error = io_remap_pud_range(mm, pud, from, end - from, offset + from, prot, space);
+		if (error)
+			break;
+		from = (from + PGDIR_SIZE) & PGDIR_MASK;
+		dir++;
+	}
+	flush_tlb_range(vma, beg, end);
+	spin_unlock(&mm->page_table_lock);
+
+	return error;
+}
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/include/asm-alpha/pgtable.h linux-2611-bk3-pfn/include/asm-alpha/pgtable.h
--- linux-2611-bk3-pv/include/asm-alpha/pgtable.h	2005-03-07 11:02:18.000000000 -0800
+++ linux-2611-bk3-pfn/include/asm-alpha/pgtable.h	2005-03-07 11:04:59.000000000 -0800
@@ -340,6 +340,13 @@ extern inline pte_t mk_swap_pte(unsigned
 	remap_pfn_range(vma, start, pfn, size, prot);		\
 })
 
+#define io_remap_pfn_range(vma, start, pfn, size, prot)	\
+		remap_pfn_range(vma, start, pfn, size, prot)
+
+#define MK_IOSPACE_PFN(space, pfn)	(pfn)
+#define GET_IOSPACE(pfn)		0
+#define GET_PFN(pfn)			(pfn)
+
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
 #define pmd_ERROR(e) \
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/include/asm-arm/pgtable.h linux-2611-bk3-pfn/include/asm-arm/pgtable.h
--- linux-2611-bk3-pv/include/asm-arm/pgtable.h	2005-03-07 11:02:18.000000000 -0800
+++ linux-2611-bk3-pfn/include/asm-arm/pgtable.h	2005-03-07 11:04:59.000000000 -0800
@@ -419,6 +419,13 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD
 #define io_remap_page_range(vma,from,phys,size,prot) \
 		remap_pfn_range(vma, from, (phys) >> PAGE_SHIFT, size, prot)
 
+#define io_remap_pfn_range(vma,from,pfn,size,prot) \
+		remap_pfn_range(vma, from, pfn, size, prot)
+
+#define MK_IOSPACE_PFN(space, pfn)	(pfn)
+#define GET_IOSPACE(pfn)		0
+#define GET_PFN(pfn)			(pfn)
+
 #define pgtable_cache_init() do { } while (0)
 
 #endif /* !__ASSEMBLY__ */
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/include/asm-arm26/pgtable.h linux-2611-bk3-pfn/include/asm-arm26/pgtable.h
--- linux-2611-bk3-pv/include/asm-arm26/pgtable.h	2005-03-07 11:02:18.000000000 -0800
+++ linux-2611-bk3-pfn/include/asm-arm26/pgtable.h	2005-03-07 11:04:59.000000000 -0800
@@ -293,6 +293,13 @@ static inline pte_t mk_pte_phys(unsigned
 #define io_remap_page_range(vma,from,phys,size,prot) \
 		remap_pfn_range(vma, from, (phys) >> PAGE_SHIFT, size, prot)
 
+#define io_remap_pfn_range(vma,from,pfn,size,prot) \
+		remap_pfn_range(vma, from, pfn, size, prot)
+
+#define MK_IOSPACE_PFN(space, pfn)	(pfn)
+#define GET_IOSPACE(pfn)		0
+#define GET_PFN(pfn)			(pfn)
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASMARM_PGTABLE_H */
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/include/asm-frv/pgtable.h linux-2611-bk3-pfn/include/asm-frv/pgtable.h
--- linux-2611-bk3-pv/include/asm-frv/pgtable.h	2005-03-07 11:02:18.000000000 -0800
+++ linux-2611-bk3-pfn/include/asm-frv/pgtable.h	2005-03-07 11:04:59.000000000 -0800
@@ -503,6 +503,13 @@ static inline int pte_file(pte_t pte)
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
 		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
+#define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
+		remap_pfn_range(vma, vaddr, pfn, size, prot)
+
+#define MK_IOSPACE_PFN(space, pfn)	(pfn)
+#define GET_IOSPACE(pfn)		0
+#define GET_PFN(pfn)			(pfn)
+
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/include/asm-h8300/pgtable.h linux-2611-bk3-pfn/include/asm-h8300/pgtable.h
--- linux-2611-bk3-pv/include/asm-h8300/pgtable.h	2005-03-01 23:38:07.000000000 -0800
+++ linux-2611-bk3-pfn/include/asm-h8300/pgtable.h	2005-03-07 11:04:59.000000000 -0800
@@ -55,6 +55,13 @@ extern int is_in_rom(unsigned long);
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
 		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
+#define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
+		remap_pfn_range(vma, vaddr, pfn, size, prot)
+
+#define MK_IOSPACE_PFN(space, pfn)	(pfn)
+#define GET_IOSPACE(pfn)		0
+#define GET_PFN(pfn)			(pfn)
+
 /*
  * All 32bit addresses are effectively valid for vmalloc...
  * Sort of meaningless for non-VM targets.
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/include/asm-i386/pgtable.h linux-2611-bk3-pfn/include/asm-i386/pgtable.h
--- linux-2611-bk3-pv/include/asm-i386/pgtable.h	2005-03-07 11:02:18.000000000 -0800
+++ linux-2611-bk3-pfn/include/asm-i386/pgtable.h	2005-03-07 11:04:59.000000000 -0800
@@ -405,6 +405,13 @@ extern void noexec_setup(const char *str
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
 		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
+#define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
+		remap_pfn_range(vma, vaddr, pfn, size, prot)
+
+#define MK_IOSPACE_PFN(space, pfn)	(pfn)
+#define GET_IOSPACE(pfn)		0
+#define GET_PFN(pfn)			(pfn)
+
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/include/asm-ia64/pgtable.h linux-2611-bk3-pfn/include/asm-ia64/pgtable.h
--- linux-2611-bk3-pv/include/asm-ia64/pgtable.h	2005-03-07 11:02:18.000000000 -0800
+++ linux-2611-bk3-pfn/include/asm-ia64/pgtable.h	2005-03-07 11:04:59.000000000 -0800
@@ -447,6 +447,13 @@ extern void paging_init (void);
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
 		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
+#define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
+		remap_pfn_range(vma, vaddr, pfn, size, prot)
+
+#define MK_IOSPACE_PFN(space, pfn)	(pfn)
+#define GET_IOSPACE(pfn)		0
+#define GET_PFN(pfn)			(pfn)
+
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/include/asm-m32r/pgtable.h linux-2611-bk3-pfn/include/asm-m32r/pgtable.h
--- linux-2611-bk3-pv/include/asm-m32r/pgtable.h	2005-03-07 11:02:18.000000000 -0800
+++ linux-2611-bk3-pfn/include/asm-m32r/pgtable.h	2005-03-07 11:04:59.000000000 -0800
@@ -381,6 +381,13 @@ static inline void pmd_set(pmd_t * pmdp,
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)	\
 	remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
+#define io_remap_pfn_range(vma, vaddr, pfn, size, prot)	\
+		remap_pfn_range(vma, vaddr, pfn, size, prot)
+
+#define MK_IOSPACE_PFN(space, pfn)	(pfn)
+#define GET_IOSPACE(pfn)		0
+#define GET_PFN(pfn)			(pfn)
+
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/include/asm-m68k/pgtable.h linux-2611-bk3-pfn/include/asm-m68k/pgtable.h
--- linux-2611-bk3-pv/include/asm-m68k/pgtable.h	2005-03-07 11:02:18.000000000 -0800
+++ linux-2611-bk3-pfn/include/asm-m68k/pgtable.h	2005-03-07 11:04:59.000000000 -0800
@@ -144,6 +144,13 @@ static inline void update_mmu_cache(stru
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
 		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
+#define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
+		remap_pfn_range(vma, vaddr, pfn, size, prot)
+
+#define MK_IOSPACE_PFN(space, pfn)	(pfn)
+#define GET_IOSPACE(pfn)		0
+#define GET_PFN(pfn)			(pfn)
+
 /* MMU-specific headers */
 
 #ifdef CONFIG_SUN3
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/include/asm-m68knommu/pgtable.h linux-2611-bk3-pfn/include/asm-m68knommu/pgtable.h
--- linux-2611-bk3-pv/include/asm-m68knommu/pgtable.h	2005-03-01 23:38:10.000000000 -0800
+++ linux-2611-bk3-pfn/include/asm-m68knommu/pgtable.h	2005-03-07 11:04:59.000000000 -0800
@@ -59,6 +59,13 @@ extern int is_in_rom(unsigned long);
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
 		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
+#define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
+		remap_pfn_range(vma, vaddr, pfn, size, prot)
+
+#define MK_IOSPACE_PFN(space, pfn)	(pfn)
+#define GET_IOSPACE(pfn)		0
+#define GET_PFN(pfn)			(pfn)
+
 /*
  * All 32bit addresses are effectively valid for vmalloc...
  * Sort of meaningless for non-VM targets.
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/include/asm-mips/pgtable.h linux-2611-bk3-pfn/include/asm-mips/pgtable.h
--- linux-2611-bk3-pv/include/asm-mips/pgtable.h	2005-03-07 11:02:18.000000000 -0800
+++ linux-2611-bk3-pfn/include/asm-mips/pgtable.h	2005-03-07 11:04:59.000000000 -0800
@@ -367,11 +367,27 @@ static inline int io_remap_page_range(st
 	phys_t phys_addr_high = fixup_bigphys_addr(paddr, size);
 	return remap_pfn_range(vma, vaddr, phys_addr_high >> PAGE_SHIFT, size, prot);
 }
+
+static inline int io_remap_pfn_range(struct vm_area_struct *vma,
+		unsigned long vaddr,
+		unsigned long pfn,
+		unsigned long size,
+		pgprot_t prot)
+{
+	phys_t phys_addr_high = fixup_bigphys_addr(pfn << PAGE_SHIFT, size);
+	return remap_pfn_range(vma, vaddr, pfn, size, prot);
+}
 #else
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
-	remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
+#define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
+		remap_pfn_range(vma, vaddr, pfn, size, prot)
 #endif
 
+#define MK_IOSPACE_PFN(space, pfn)	(pfn)
+#define GET_IOSPACE(pfn)		0
+#define GET_PFN(pfn)			(pfn)
+
 #include <asm-generic/pgtable.h>
 
 /*
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/include/asm-parisc/pgtable.h linux-2611-bk3-pfn/include/asm-parisc/pgtable.h
--- linux-2611-bk3-pv/include/asm-parisc/pgtable.h	2005-03-07 11:02:18.000000000 -0800
+++ linux-2611-bk3-pfn/include/asm-parisc/pgtable.h	2005-03-07 11:04:59.000000000 -0800
@@ -501,6 +501,13 @@ static inline void ptep_set_wrprotect(st
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
 		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
+#define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
+		remap_pfn_range(vma, vaddr, pfn, size, prot)
+
+#define MK_IOSPACE_PFN(space, pfn)	(pfn)
+#define GET_IOSPACE(pfn)		0
+#define GET_PFN(pfn)			(pfn)
+
 /* We provide our own get_unmapped_area to provide cache coherency */
 
 #define HAVE_ARCH_UNMAPPED_AREA
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/include/asm-ppc/pgtable.h linux-2611-bk3-pfn/include/asm-ppc/pgtable.h
--- linux-2611-bk3-pv/include/asm-ppc/pgtable.h	2005-03-07 11:02:18.000000000 -0800
+++ linux-2611-bk3-pfn/include/asm-ppc/pgtable.h	2005-03-07 11:04:59.000000000 -0800
@@ -735,11 +735,27 @@ static inline int io_remap_page_range(st
 	phys_addr_t paddr64 = fixup_bigphys_addr(paddr, size);
 	return remap_pfn_range(vma, vaddr, paddr64 >> PAGE_SHIFT, size, prot);
 }
+
+static inline int io_remap_pfn_range(struct vm_area_struct *vma,
+					unsigned long vaddr,
+					unsigned long pfn,
+					unsigned long size,
+					pgprot_t prot)
+{
+	phys_addr_t paddr64 = fixup_bigphys_addr(pfn << PAGE_SHIFT, size);
+	return remap_pfn_range(vma, vaddr, pfn, size, prot);
+}
 #else
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
 		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
+#define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
+		remap_pfn_range(vma, vaddr, pfn, size, prot)
 #endif
 
+#define MK_IOSPACE_PFN(space, pfn)	(pfn)
+#define GET_IOSPACE(pfn)		0
+#define GET_PFN(pfn)			(pfn)
+
 /*
  * No page table caches to initialise
  */
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/include/asm-ppc64/pgtable.h linux-2611-bk3-pfn/include/asm-ppc64/pgtable.h
--- linux-2611-bk3-pv/include/asm-ppc64/pgtable.h	2005-03-07 11:02:18.000000000 -0800
+++ linux-2611-bk3-pfn/include/asm-ppc64/pgtable.h	2005-03-07 11:04:59.000000000 -0800
@@ -527,6 +527,13 @@ extern void update_mmu_cache(struct vm_a
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
 		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
+#define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
+		remap_pfn_range(vma, vaddr, pfn, size, prot)
+
+#define MK_IOSPACE_PFN(space, pfn)	(pfn)
+#define GET_IOSPACE(pfn)		0
+#define GET_PFN(pfn)			(pfn)
+
 void pgtable_cache_init(void);
 
 extern void hpte_init_native(void);
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/include/asm-sh/pgtable.h linux-2611-bk3-pfn/include/asm-sh/pgtable.h
--- linux-2611-bk3-pv/include/asm-sh/pgtable.h	2005-03-07 11:02:18.000000000 -0800
+++ linux-2611-bk3-pfn/include/asm-sh/pgtable.h	2005-03-07 11:04:59.000000000 -0800
@@ -279,6 +279,13 @@ typedef pte_t *pte_addr_t;
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
 		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
+#define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
+		remap_pfn_range(vma, vaddr, pfn, size, prot)
+
+#define MK_IOSPACE_PFN(space, pfn)	(pfn)
+#define GET_IOSPACE(pfn)		0
+#define GET_PFN(pfn)			(pfn)
+
 /*
  * No page table caches to initialise
  */
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/include/asm-sh64/pgtable.h linux-2611-bk3-pfn/include/asm-sh64/pgtable.h
--- linux-2611-bk3-pv/include/asm-sh64/pgtable.h	2005-03-07 11:02:18.000000000 -0800
+++ linux-2611-bk3-pfn/include/asm-sh64/pgtable.h	2005-03-07 11:04:59.000000000 -0800
@@ -482,6 +482,14 @@ extern void update_mmu_cache(struct vm_a
 
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
 		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
+
+#define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
+		remap_pfn_range(vma, vaddr, pfn, size, prot)
+
+#define MK_IOSPACE_PFN(space, pfn)	(pfn)
+#define GET_IOSPACE(pfn)		0
+#define GET_PFN(pfn)			(pfn)
+
 #endif /* !__ASSEMBLY__ */
 
 /*
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/include/asm-sparc/pgtable.h linux-2611-bk3-pfn/include/asm-sparc/pgtable.h
--- linux-2611-bk3-pv/include/asm-sparc/pgtable.h	2005-03-07 11:02:18.000000000 -0800
+++ linux-2611-bk3-pfn/include/asm-sparc/pgtable.h	2005-03-07 11:04:59.000000000 -0800
@@ -454,8 +454,20 @@ extern unsigned long *sparc_valid_addr_b
 #define kern_addr_valid(addr) \
 	(test_bit(__pa((unsigned long)(addr))>>20, sparc_valid_addr_bitmap))
 
-extern int io_remap_page_range(struct vm_area_struct *vma, unsigned long from, unsigned long to,
+extern int io_remap_page_range(struct vm_area_struct *vma,
+			       unsigned long from, unsigned long to,
 			       unsigned long size, pgprot_t prot, int space);
+extern int io_remap_pfn_range(struct vm_area_struct *vma,
+			      unsigned long from, unsigned long pfn,
+			      unsigned long size, pgprot_t prot);
+
+/*
+ * For sparc32&64, the pfn in io_remap_pfn_range() carries <iospace> in
+ * its high 4 bits.  These macros/functions put it there or get it from there.
+ */
+#define MK_IOSPACE_PFN(space, pfn)	(pfn | (space << (BITS_PER_LONG - 4)))
+#define GET_IOSPACE(pfn)		(pfn >> (BITS_PER_LONG - 4))
+#define GET_PFN(pfn)			(pfn & 0x0fffffffUL)
 
 #include <asm-generic/pgtable.h>
 
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/include/asm-sparc64/pgtable.h linux-2611-bk3-pfn/include/asm-sparc64/pgtable.h
--- linux-2611-bk3-pv/include/asm-sparc64/pgtable.h	2005-03-07 11:02:18.000000000 -0800
+++ linux-2611-bk3-pfn/include/asm-sparc64/pgtable.h	2005-03-07 11:08:06.000000000 -0800
@@ -16,6 +16,7 @@
 
 #include <linux/config.h>
 #include <linux/compiler.h>
+#include <asm/types.h>
 #include <asm/spitfire.h>
 #include <asm/asi.h>
 #include <asm/system.h>
@@ -431,6 +432,17 @@ extern unsigned long *sparc64_valid_addr
 extern int io_remap_page_range(struct vm_area_struct *vma, unsigned long from,
 			       unsigned long offset,
 			       unsigned long size, pgprot_t prot, int space);
+extern int io_remap_pfn_range(struct vm_area_struct *vma, unsigned long from,
+			       unsigned long pfn,
+			       unsigned long size, pgprot_t prot);
+
+/*
+ * For sparc32&64, the pfn in io_remap_pfn_range() carries <iospace> in
+ * its high 4 bits.  These macros/functions put it there or get it from there.
+ */
+#define MK_IOSPACE_PFN(space, pfn)	(pfn | (space << (BITS_PER_LONG - 4)))
+#define GET_IOSPACE(pfn)		(pfn >> (BITS_PER_LONG - 4))
+#define GET_PFN(pfn)			(pfn & 0x0fffffffffffffffUL)
 
 /* Override for {pgd,pmd}_addr_end() to deal with the virtual address
  * space hole.  We simply sign extend bit 43.
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/include/asm-x86_64/pgtable.h linux-2611-bk3-pfn/include/asm-x86_64/pgtable.h
--- linux-2611-bk3-pv/include/asm-x86_64/pgtable.h	2005-03-07 11:02:18.000000000 -0800
+++ linux-2611-bk3-pfn/include/asm-x86_64/pgtable.h	2005-03-07 11:04:59.000000000 -0800
@@ -407,6 +407,13 @@ extern int kern_addr_valid(unsigned long
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
 		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
+#define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
+		remap_pfn_range(vma, vaddr, pfn, size, prot)
+
+#define MK_IOSPACE_PFN(space, pfn)	(pfn)
+#define GET_IOSPACE(pfn)		0
+#define GET_PFN(pfn)			(pfn)
+
 #define HAVE_ARCH_UNMAPPED_AREA
 
 #define pgtable_cache_init()   do { } while (0)
---
