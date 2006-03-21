Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWCUK2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWCUK2Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 05:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWCUK2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 05:28:24 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:41613
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932400AbWCUK2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 05:28:23 -0500
Date: Tue, 21 Mar 2006 02:28:22 -0800 (PST)
Message-Id: <20060321.022822.38340105.davem@davemloft.net>
To: hugh@veritas.com
Cc: torvalds@osdl.org, michael.bishop@APPIQ.com, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: More info for DSM w/r/t sunffb on 2.6.15-rc6
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0512240828230.18398@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0512240104440.17764@goblin.wat.veritas.com>
	<20051223.234622.14020212.davem@davemloft.net>
	<Pine.LNX.4.61.0512240828230.18398@goblin.wat.veritas.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hugh@veritas.com>
Date: Sat, 24 Dec 2005 09:07:29 +0000 (GMT)

> I was wondering your estimation of the likelihood of problems if we
> change sparc and sparc64 io_remap_pfn_range to respect the distinction
> between shared and private, readonly and writable, early in 2.6.16,
> or early in 2.6.17.

I don't anticipate any, what they are doing is clearly broken.

I'll push the following fix soon.

Thanks for pointing all of this stuff out Hugh.

diff --git a/arch/sparc/mm/generic.c b/arch/sparc/mm/generic.c
index 2cb0728..1ef7fa0 100644
--- a/arch/sparc/mm/generic.c
+++ b/arch/sparc/mm/generic.c
@@ -76,7 +76,6 @@ int io_remap_pfn_range(struct vm_area_st
 	vma->vm_pgoff = (offset >> PAGE_SHIFT) |
 		((unsigned long)space << 28UL);
 
-	prot = __pgprot(pg_iobits);
 	offset -= from;
 	dir = pgd_offset(mm, from);
 	flush_cache_range(vma, beg, end);
diff --git a/arch/sparc/mm/loadmmu.c b/arch/sparc/mm/loadmmu.c
index e9f9571..36b4d24 100644
--- a/arch/sparc/mm/loadmmu.c
+++ b/arch/sparc/mm/loadmmu.c
@@ -22,8 +22,6 @@ struct ctx_list *ctx_list_pool;
 struct ctx_list ctx_free;
 struct ctx_list ctx_used;
 
-unsigned int pg_iobits;
-
 extern void ld_mmu_sun4c(void);
 extern void ld_mmu_srmmu(void);
 
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index c664b96..27b0e0b 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -2130,6 +2130,13 @@ static unsigned long srmmu_pte_to_pgoff(
 	return pte_val(pte) >> SRMMU_PTE_FILE_SHIFT;
 }
 
+static pgprot_t srmmu_pgprot_noncached(pgprot_t prot)
+{
+	prot &= ~__pgprot(SRMMU_CACHE);
+
+	return prot;
+}
+
 /* Load up routines and constants for sun4m and sun4d mmu */
 void __init ld_mmu_srmmu(void)
 {
@@ -2150,9 +2157,9 @@ void __init ld_mmu_srmmu(void)
 	BTFIXUPSET_INT(page_readonly, pgprot_val(SRMMU_PAGE_RDONLY));
 	BTFIXUPSET_INT(page_kernel, pgprot_val(SRMMU_PAGE_KERNEL));
 	page_kernel = pgprot_val(SRMMU_PAGE_KERNEL);
-	pg_iobits = SRMMU_VALID | SRMMU_WRITE | SRMMU_REF;
 
 	/* Functions */
+	BTFIXUPSET_CALL(pgprot_noncached, srmmu_pgprot_noncached, BTFIXUPCALL_NORM);
 #ifndef CONFIG_SMP	
 	BTFIXUPSET_CALL(___xchg32, ___xchg32_sun4md, BTFIXUPCALL_SWAPG1G2);
 #endif
diff --git a/arch/sparc/mm/sun4c.c b/arch/sparc/mm/sun4c.c
index 731f196..49f28c1 100644
--- a/arch/sparc/mm/sun4c.c
+++ b/arch/sparc/mm/sun4c.c
@@ -1589,7 +1589,10 @@ static void sun4c_flush_tlb_page(struct 
 
 static inline void sun4c_mapioaddr(unsigned long physaddr, unsigned long virt_addr)
 {
-	unsigned long page_entry;
+	unsigned long page_entry, pg_iobits;
+
+	pg_iobits = _SUN4C_PAGE_PRESENT | _SUN4C_READABLE | _SUN4C_WRITEABLE |
+		    _SUN4C_PAGE_IO | _SUN4C_PAGE_NOCACHE;
 
 	page_entry = ((physaddr >> PAGE_SHIFT) & SUN4C_PFN_MASK);
 	page_entry |= ((pg_iobits | _SUN4C_PAGE_PRIV) & ~(_SUN4C_PAGE_PRESENT));
@@ -2134,6 +2137,13 @@ void __init sun4c_paging_init(void)
 	printk("SUN4C: %d mmu entries for the kernel\n", cnt);
 }
 
+static pgprot_t sun4c_pgprot_noncached(pgprot_t prot)
+{
+	prot |= __pgprot(_SUN4C_PAGE_IO | _SUN4C_PAGE_NOCACHE);
+
+	return prot;
+}
+
 /* Load up routines and constants for sun4c mmu */
 void __init ld_mmu_sun4c(void)
 {
@@ -2156,10 +2166,9 @@ void __init ld_mmu_sun4c(void)
 	BTFIXUPSET_INT(page_readonly, pgprot_val(SUN4C_PAGE_READONLY));
 	BTFIXUPSET_INT(page_kernel, pgprot_val(SUN4C_PAGE_KERNEL));
 	page_kernel = pgprot_val(SUN4C_PAGE_KERNEL);
-	pg_iobits = _SUN4C_PAGE_PRESENT | _SUN4C_READABLE | _SUN4C_WRITEABLE |
-		    _SUN4C_PAGE_IO | _SUN4C_PAGE_NOCACHE;
 
 	/* Functions */
+	BTFIXUPSET_CALL(pgprot_noncached, sun4c_pgprot_noncached, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(___xchg32, ___xchg32_sun4c, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(do_check_pgt_cache, sun4c_check_pgt_cache, BTFIXUPCALL_NORM);
 	
diff --git a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
index 95ffa94..dfccff2 100644
--- a/arch/sparc64/kernel/pci.c
+++ b/arch/sparc64/kernel/pci.c
@@ -656,6 +656,7 @@ int pci_mmap_page_range(struct pci_dev *
 	__pci_mmap_set_flags(dev, vma, mmap_state);
 	__pci_mmap_set_pgprot(dev, vma, mmap_state);
 
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	ret = io_remap_pfn_range(vma, vma->vm_start,
 				 vma->vm_pgoff,
 				 vma->vm_end - vma->vm_start,
@@ -663,7 +664,6 @@ int pci_mmap_page_range(struct pci_dev *
 	if (ret)
 		return ret;
 
-	vma->vm_flags |= VM_IO;
 	return 0;
 }
 
diff --git a/arch/sparc64/mm/generic.c b/arch/sparc64/mm/generic.c
index 5fc5c57..8cb0620 100644
--- a/arch/sparc64/mm/generic.c
+++ b/arch/sparc64/mm/generic.c
@@ -140,7 +140,6 @@ int io_remap_pfn_range(struct vm_area_st
 	vma->vm_flags |= VM_IO | VM_RESERVED | VM_PFNMAP;
 	vma->vm_pgoff = phys_base >> PAGE_SHIFT;
 
-	prot = __pgprot(pg_iobits);
 	offset -= from;
 	dir = pgd_offset(mm, from);
 	flush_cache_range(vma, beg, end);
diff --git a/drivers/char/drm/drm_vm.c b/drivers/char/drm/drm_vm.c
index 0291cd6..ffd0800 100644
--- a/drivers/char/drm/drm_vm.c
+++ b/drivers/char/drm/drm_vm.c
@@ -619,6 +619,7 @@ int drm_mmap(struct file *filp, struct v
 #endif
 		offset = dev->driver->get_reg_ofs(dev);
 #ifdef __sparc__
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 		if (io_remap_pfn_range(DRM_RPR_ARG(vma) vma->vm_start,
 				       (map->offset + offset) >> PAGE_SHIFT,
 				       vma->vm_end - vma->vm_start,
diff --git a/drivers/sbus/char/flash.c b/drivers/sbus/char/flash.c
index 6bdd768..2beb3dd 100644
--- a/drivers/sbus/char/flash.c
+++ b/drivers/sbus/char/flash.c
@@ -71,9 +71,8 @@ flash_mmap(struct file *file, struct vm_
 	if (vma->vm_end - (vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT)) > size)
 		size = vma->vm_end - (vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT));
 
-	pgprot_val(vma->vm_page_prot) &= ~(_PAGE_CACHE);
-	pgprot_val(vma->vm_page_prot) |= _PAGE_E;
 	vma->vm_flags |= (VM_SHM | VM_LOCKED);
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	if (io_remap_pfn_range(vma, vma->vm_start, addr, size, vma->vm_page_prot))
 		return -EAGAIN;
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 996c7b5..07d882b 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1169,11 +1169,6 @@ fb_mmap(struct file *file, struct vm_are
 	vma->vm_pgoff = off >> PAGE_SHIFT;
 	/* This is an IO map - tell maydump to skip this VMA */
 	vma->vm_flags |= VM_IO | VM_RESERVED;
-#if defined(__sparc_v9__)
-	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
-				vma->vm_end - vma->vm_start, vma->vm_page_prot))
-		return -EAGAIN;
-#else
 #if defined(__mc68000__)
 #if defined(CONFIG_SUN3)
 	pgprot_val(vma->vm_page_prot) |= SUN3_PAGE_NOCACHE;
@@ -1195,7 +1190,7 @@ fb_mmap(struct file *file, struct vm_are
 #elif defined(__i386__) || defined(__x86_64__)
 	if (boot_cpu_data.x86 > 3)
 		pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
-#elif defined(__mips__)
+#elif defined(__mips__) || defined(__sparc_v9__)
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 #elif defined(__hppa__)
 	pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
@@ -1212,7 +1207,6 @@ fb_mmap(struct file *file, struct vm_are
 	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
 			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
 		return -EAGAIN;
-#endif /* !__sparc_v9__ */
 	return 0;
 #endif /* !sparc32 */
 }
diff --git a/drivers/video/sbuslib.c b/drivers/video/sbuslib.c
index a4d7cc5..34ef859 100644
--- a/drivers/video/sbuslib.c
+++ b/drivers/video/sbuslib.c
@@ -58,6 +58,8 @@ int sbusfb_mmap_helper(struct sbus_mmap_
 	/* To stop the swapper from even considering these pages */
 	vma->vm_flags |= (VM_IO | VM_RESERVED);
 	
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
 	/* Each page, see which map applies */
 	for (page = 0; page < size; ){
 		map_size = 0;
diff --git a/include/asm-sparc/pgtable.h b/include/asm-sparc/pgtable.h
index b33c354..9eea8f4 100644
--- a/include/asm-sparc/pgtable.h
+++ b/include/asm-sparc/pgtable.h
@@ -269,11 +269,14 @@ BTFIXUPDEF_CALL_CONST(pte_t, mk_pte, str
 
 BTFIXUPDEF_CALL_CONST(pte_t, mk_pte_phys, unsigned long, pgprot_t)
 BTFIXUPDEF_CALL_CONST(pte_t, mk_pte_io, unsigned long, pgprot_t, int)
+BTFIXUPDEF_CALL_CONST(pgprot_t, pgprot_noncached, pgprot_t)
 
 #define mk_pte(page,pgprot) BTFIXUP_CALL(mk_pte)(page,pgprot)
 #define mk_pte_phys(page,pgprot) BTFIXUP_CALL(mk_pte_phys)(page,pgprot)
 #define mk_pte_io(page,pgprot,space) BTFIXUP_CALL(mk_pte_io)(page,pgprot,space)
 
+#define pgprot_noncached(pgprot) BTFIXUP_CALL(pgprot_noncached)(pgprot)
+
 BTFIXUPDEF_INT(pte_modify_mask)
 
 static pte_t pte_modify(pte_t pte, pgprot_t newprot) __attribute_const__;
@@ -309,9 +312,6 @@ BTFIXUPDEF_CALL(pte_t *, pte_offset_kern
 #define pte_unmap(pte)		do{}while(0)
 #define pte_unmap_nested(pte)	do{}while(0)
 
-/* The permissions for pgprot_val to make a page mapped on the obio space */
-extern unsigned int pg_iobits;
-
 /* Certain architectures need to do special things when pte's
  * within a page table are directly modified.  Thus, the following
  * hook is made available.
