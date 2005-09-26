Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbVIZWpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVIZWpy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 18:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbVIZWpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 18:45:54 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:57365 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932354AbVIZWpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 18:45:54 -0400
To: akpm@osdl.org, benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] Make phys_mem_access_prot() work with pfns instead of
 addresses
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 26 Sep 2005 15:45:40 -0700
Message-ID: <527jd3sb1n.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 26 Sep 2005 22:45:42.0384 (UTC) FILETIME=[064F0700:01C5C2EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch that makes mmap64() work better on /dev/mem.  On ppc,
we currently call phys_mem_access_prot() on the address being mmap'ed;
unfortunately calculating the address to pass in can overflow on
32-bit architectures.  Fortunately, mmap_mem() already has the pfn, so
it's simple to get rid of the conversion and work directly with the pfn.

My interest comes from being able to access memory-mapped peripherals
on PowerPC 44x chips (which are 32-bit).  The registers are typically
located at addresses above 4G, and it's nice to be able to just use
mmap64() from userspace to peek and poke at things.

I tested the patch on a PowerPC 440SPe system by successfully using
mmap64() on an address above 4G.

I only compile tested for ppc64.  Also, I don't have access to a
system where Ben's original change helped performance.  The changes
seem pretty safe to me but someone should check my work.

Thanks,
  Roland

--

Change the phys_mem_access_prot() function to take a pfn instead of an
address.  This allows mmap64() to work on /dev/mem for addresses above
4G on 32-bit architectures.  We start with a pfn in mmap_mem(), so
there's no need to convert to an address; in fact, it's actively bad,
since the conversion can overflow when the address is above 4G.

Similarly fix the ppc32 page_is_ram() function to avoid a conversion
to an address by directly comparing to max_pfn.  Working with max_pfn
instead of high_memory fixes page_is_ram() to give the right answer
for highmem pages.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

diff --git a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
--- a/arch/ppc/kernel/pci.c
+++ b/arch/ppc/kernel/pci.c
@@ -1586,16 +1586,17 @@ static pgprot_t __pci_mmap_set_pgprot(st
  * above routine
  */
 pgprot_t pci_phys_mem_access_prot(struct file *file,
-				  unsigned long offset,
+				  unsigned long pfn,
 				  unsigned long size,
 				  pgprot_t protection)
 {
 	struct pci_dev *pdev = NULL;
 	struct resource *found = NULL;
 	unsigned long prot = pgprot_val(protection);
+	unsigned long offset = pfn << PAGE_SHIFT;
 	int i;
 
-	if (page_is_ram(offset >> PAGE_SHIFT))
+	if (page_is_ram(pfn))
 		return prot;
 
 	prot |= _PAGE_NO_CACHE | _PAGE_GUARDED;
diff --git a/arch/ppc/mm/init.c b/arch/ppc/mm/init.c
--- a/arch/ppc/mm/init.c
+++ b/arch/ppc/mm/init.c
@@ -648,18 +648,16 @@ void update_mmu_cache(struct vm_area_str
  */
 int page_is_ram(unsigned long pfn)
 {
-	unsigned long paddr = (pfn << PAGE_SHIFT);
-
-	return paddr < __pa(high_memory);
+	return pfn < max_pfn;
 }
 
-pgprot_t phys_mem_access_prot(struct file *file, unsigned long addr,
+pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
 	if (ppc_md.phys_mem_access_prot)
-		return ppc_md.phys_mem_access_prot(file, addr, size, vma_prot);
+		return ppc_md.phys_mem_access_prot(file, pfn, size, vma_prot);
 
-	if (!page_is_ram(addr >> PAGE_SHIFT))
+	if (!page_is_ram(pfn))
 		vma_prot = __pgprot(pgprot_val(vma_prot)
 				    | _PAGE_GUARDED | _PAGE_NO_CACHE);
 	return vma_prot;
diff --git a/arch/ppc64/kernel/pci.c b/arch/ppc64/kernel/pci.c
--- a/arch/ppc64/kernel/pci.c
+++ b/arch/ppc64/kernel/pci.c
@@ -727,16 +727,17 @@ static pgprot_t __pci_mmap_set_pgprot(st
  * above routine
  */
 pgprot_t pci_phys_mem_access_prot(struct file *file,
-				  unsigned long offset,
+				  unsigned long pfn,
 				  unsigned long size,
 				  pgprot_t protection)
 {
 	struct pci_dev *pdev = NULL;
 	struct resource *found = NULL;
 	unsigned long prot = pgprot_val(protection);
+	unsigned long offset = pfn << PAGE_SHIFT;
 	int i;
 
-	if (page_is_ram(offset >> PAGE_SHIFT))
+	if (page_is_ram(pfn))
 		return __pgprot(prot);
 
 	prot |= _PAGE_NO_CACHE | _PAGE_GUARDED;
diff --git a/arch/ppc64/mm/init.c b/arch/ppc64/mm/init.c
--- a/arch/ppc64/mm/init.c
+++ b/arch/ppc64/mm/init.c
@@ -856,13 +856,13 @@ void pgtable_cache_init(void)
 	}
 }
 
-pgprot_t phys_mem_access_prot(struct file *file, unsigned long addr,
+pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
 	if (ppc_md.phys_mem_access_prot)
-		return ppc_md.phys_mem_access_prot(file, addr, size, vma_prot);
+		return ppc_md.phys_mem_access_prot(file, pfn, size, vma_prot);
 
-	if (!page_is_ram(addr >> PAGE_SHIFT))
+	if (!page_is_ram(pfn))
 		vma_prot = __pgprot(pgprot_val(vma_prot)
 				    | _PAGE_GUARDED | _PAGE_NO_CACHE);
 	return vma_prot;
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -231,9 +231,7 @@ static ssize_t write_mem(struct file * f
 static int mmap_mem(struct file * file, struct vm_area_struct * vma)
 {
 #if defined(__HAVE_PHYS_MEM_ACCESS_PROT)
-	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
-
-	vma->vm_page_prot = phys_mem_access_prot(file, offset,
+	vma->vm_page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
 						 vma->vm_end - vma->vm_start,
 						 vma->vm_page_prot);
 #elif defined(pgprot_noncached)
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -918,7 +918,7 @@ fb_mmap(struct file *file, struct vm_are
 	}
 #endif
 #elif defined(__powerpc__)
-	vma->vm_page_prot = phys_mem_access_prot(file, off,
+	vma->vm_page_prot = phys_mem_access_prot(file, off >> PAGE_SHIFT,
 						 vma->vm_end - vma->vm_start,
 						 vma->vm_page_prot);
 #elif defined(__alpha__)
diff --git a/include/asm-ppc/machdep.h b/include/asm-ppc/machdep.h
--- a/include/asm-ppc/machdep.h
+++ b/include/asm-ppc/machdep.h
@@ -98,7 +98,7 @@ struct machdep_calls {
 
 	/* Get access protection for /dev/mem */
 	pgprot_t	(*phys_mem_access_prot)(struct file *file,
-						unsigned long offset,
+						unsigned long pfn,
 						unsigned long size,
 						pgprot_t vma_prot);
 
diff --git a/include/asm-ppc/pci.h b/include/asm-ppc/pci.h
--- a/include/asm-ppc/pci.h
+++ b/include/asm-ppc/pci.h
@@ -126,7 +126,7 @@ extern void pcibios_add_platform_entries
 
 struct file;
 extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
-					 unsigned long offset,
+					 unsigned long pfn,
 					 unsigned long size,
 					 pgprot_t prot);
 
diff --git a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
--- a/include/asm-ppc/pgtable.h
+++ b/include/asm-ppc/pgtable.h
@@ -705,7 +705,7 @@ static inline void __ptep_set_access_fla
 #define pgprot_noncached(prot)	(__pgprot(pgprot_val(prot) | _PAGE_NO_CACHE | _PAGE_GUARDED))
 
 struct file;
-extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long addr,
+extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				     unsigned long size, pgprot_t vma_prot);
 #define __HAVE_PHYS_MEM_ACCESS_PROT
 
diff --git a/include/asm-ppc64/machdep.h b/include/asm-ppc64/machdep.h
--- a/include/asm-ppc64/machdep.h
+++ b/include/asm-ppc64/machdep.h
@@ -130,7 +130,7 @@ struct machdep_calls {
 	
 	/* Get access protection for /dev/mem */
 	pgprot_t	(*phys_mem_access_prot)(struct file *file,
-						unsigned long offset,
+						unsigned long pfn,
 						unsigned long size,
 						pgprot_t vma_prot);
 
diff --git a/include/asm-ppc64/pci.h b/include/asm-ppc64/pci.h
--- a/include/asm-ppc64/pci.h
+++ b/include/asm-ppc64/pci.h
@@ -168,7 +168,7 @@ extern void pcibios_add_platform_entries
 
 struct file;
 extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
-					 unsigned long offset,
+					 unsigned long pfn,
 					 unsigned long size,
 					 pgprot_t prot);
 
diff --git a/include/asm-ppc64/pgtable.h b/include/asm-ppc64/pgtable.h
--- a/include/asm-ppc64/pgtable.h
+++ b/include/asm-ppc64/pgtable.h
@@ -471,7 +471,7 @@ static inline void __ptep_set_access_fla
 #define pgprot_noncached(prot)	(__pgprot(pgprot_val(prot) | _PAGE_NO_CACHE | _PAGE_GUARDED))
 
 struct file;
-extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long addr,
+extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				     unsigned long size, pgprot_t vma_prot);
 #define __HAVE_PHYS_MEM_ACCESS_PROT
 
