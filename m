Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311121AbSDITiK>; Tue, 9 Apr 2002 15:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311147AbSDITiK>; Tue, 9 Apr 2002 15:38:10 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:32043 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S311121AbSDITiC>; Tue, 9 Apr 2002 15:38:02 -0400
Date: Tue, 9 Apr 2002 20:40:22 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] use vmalloc_to_page
Message-ID: <Pine.LNX.4.21.0204092023010.1389-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janitorial patch against 2.4.19-pre6, backported from 2.5: extending
use of vmalloc_to_page to those drivers (+ ia64 perfmon) where it is
appropriate.  Partly to set consistent example (same safeties in each
case, but respecting different local coding styles); and will pay off
later when highmem pagetable changes won't need to touch these again.

Hugh

--- 2.4.19-pre6/arch/ia64/kernel/perfmon.c	Tue Apr  9 13:36:59 2002
+++ linux/arch/ia64/kernel/perfmon.c	Tue Apr  9 17:50:58 2002
@@ -387,34 +387,8 @@
 	return ia64_get_itc();
 }
 
-/* Given PGD from the address space's page table, return the kernel
- * virtual mapping of the physical memory mapped at ADR.
- */
-static inline unsigned long
-uvirt_to_kva(pgd_t *pgd, unsigned long adr)
-{
-	unsigned long ret = 0UL;
-	pmd_t *pmd;
-	pte_t *ptep, pte;
-
-	if (!pgd_none(*pgd)) {
-		pmd = pmd_offset(pgd, adr);
-		if (!pmd_none(*pmd)) {
-			ptep = pte_offset(pmd, adr);
-			pte = *ptep;
-			if (pte_present(pte)) {
-				ret = (unsigned long) page_address(pte_page(pte));
-				ret |= (adr & (PAGE_SIZE - 1));
-			}
-		}
-	}
-	DBprintk(("[%d] uv2kva(%lx-->%lx)\n", current->pid, adr, ret));
-	return ret;
-}
-
 /* Here we want the physical address of the memory.
- * This is used when initializing the contents of the
- * area and marking the pages as reserved.
+ * This is used when initializing the contents of the area.
  */
 static inline unsigned long
 pfm_kvirt_to_pa(unsigned long adr)
@@ -424,21 +398,19 @@
 	return pa;
 }
 
-
 static void *
 pfm_rvmalloc(unsigned long size)
 {
 	void *mem;
-	unsigned long adr, page;
+	unsigned long adr;
 
+	size=PAGE_ALIGN(size);
 	mem=vmalloc(size);
 	if (mem) {
-		//printk("perfmon: CPU%d pfm_rvmalloc(%ld)=%p\n", smp_processor_id(), size, mem);
 		memset(mem, 0, size); /* Clear the ram out, no junk to the user */
 		adr=(unsigned long) mem;
 		while (size > 0) {
-			page = pfm_kvirt_to_pa(adr);
-			mem_map_reserve(virt_to_page(__va(page)));
+			mem_map_reserve(vmalloc_to_page((void *)adr));
 			adr  += PAGE_SIZE;
 			size -= PAGE_SIZE;
 		}
@@ -449,13 +421,12 @@
 static void
 pfm_rvfree(void *mem, unsigned long size)
 {
-	unsigned long adr, page = 0;
+	unsigned long adr;
 
 	if (mem) {
 		adr=(unsigned long) mem;
-		while (size > 0) {
-			page = pfm_kvirt_to_pa(adr);
-			mem_map_unreserve(virt_to_page(__va(page)));
+		while ((long) size > 0) {
+			mem_map_unreserve(vmalloc_to_page((void *)adr));
 			adr+=PAGE_SIZE;
 			size-=PAGE_SIZE;
 		}
--- 2.4.19-pre6/drivers/char/drm/drm_scatter.h	Thu Nov 22 19:46:37 2001
+++ linux/drivers/char/drm/drm_scatter.h	Tue Apr  9 17:50:58 2002
@@ -66,9 +66,6 @@
 	drm_scatter_gather_t request;
 	drm_sg_mem_t *entry;
 	unsigned long pages, i, j;
-	pgd_t *pgd;
-	pmd_t *pmd;
-	pte_t *pte;
 
 	DRM_DEBUG( "%s\n", __FUNCTION__ );
 
@@ -135,21 +132,10 @@
 	DRM_DEBUG( "sg alloc virtual = %p\n", entry->virtual );
 
 	for ( i = entry->handle, j = 0 ; j < pages ; i += PAGE_SIZE, j++ ) {
-		pgd = pgd_offset_k( i );
-		if ( !pgd_present( *pgd ) )
+		entry->pagelist[j] = vmalloc_to_page((void *)i);
+		if (!entry->pagelist[j])
 			goto failed;
-
-		pmd = pmd_offset( pgd, i );
-		if ( !pmd_present( *pmd ) )
-			goto failed;
-
-		pte = pte_offset( pmd, i );
-		if ( !pte_present( *pte ) )
-			goto failed;
-
-		entry->pagelist[j] = pte_page( *pte );
-
-		SetPageReserved( entry->pagelist[j] );
+		SetPageReserved(entry->pagelist[j]);
 	}
 
 	request.handle = entry->handle;
--- 2.4.19-pre6/drivers/char/drm/drm_vm.h	Thu Nov 22 19:46:37 2001
+++ linux/drivers/char/drm/drm_vm.h	Tue Apr  9 17:50:58 2002
@@ -152,9 +152,6 @@
 #endif
 	unsigned long	 offset;
 	unsigned long	 i;
-	pgd_t		 *pgd;
-	pmd_t		 *pmd;
-	pte_t		 *pte;
 	struct page	 *page;
 
 	if (address > vma->vm_end) return NOPAGE_SIGBUS; /* Disallow mremap */
@@ -162,17 +159,9 @@
 
 	offset	 = address - vma->vm_start;
 	i = (unsigned long)map->handle + offset;
-	/* We have to walk page tables here because we need large SAREA's, and
-	 * they need to be virtually contiguous in kernel space.
-	 */
-	pgd = pgd_offset_k( i );
-	if( !pgd_present( *pgd ) ) return NOPAGE_OOM;
-	pmd = pmd_offset( pgd, i );
-	if( !pmd_present( *pmd ) ) return NOPAGE_OOM;
-	pte = pte_offset( pmd, i );
-	if( !pte_present( *pte ) ) return NOPAGE_OOM;
-
-	page = pte_page(*pte);
+	page = vmalloc_to_page((void *)i);
+	if (!page)
+		return NOPAGE_OOM;
 	get_page(page);
 
 	DRM_DEBUG("shm_nopage 0x%lx\n", address);
--- 2.4.19-pre6/drivers/ieee1394/dv1394.c	Tue Apr  9 13:37:03 2002
+++ linux/drivers/ieee1394/dv1394.c	Tue Apr  9 17:50:58 2002
@@ -193,71 +193,19 @@
 /* Memory management functions */
 /*******************************/
 
-#define MDEBUG(x)	do { } while(0)		/* Debug memory management */
-
-/* [DaveM] I've recoded most of this so that:
- * 1) It's easier to tell what is happening
- * 2) It's more portable, especially for translating things
- *    out of vmalloc mapped areas in the kernel.
- * 3) Less unnecessary translations happen.
- *
- * The code used to assume that the kernel vmalloc mappings
- * existed in the page tables of every process, this is simply
- * not guarenteed.  We now use pgd_offset_k which is the
- * defined way to get at the kernel page tables.
- */
-
-/* Given PGD from the address space's page table, return the kernel
- * virtual mapping of the physical memory mapped at ADR.
- */
-static inline struct page *uvirt_to_page(pgd_t *pgd, unsigned long adr)
-{
-	pmd_t *pmd;
-	pte_t *ptep, pte;
-	struct page *ret = NULL;
-	
-	if (!pgd_none(*pgd)) {
-                pmd = pmd_offset(pgd, adr);
-                if (!pmd_none(*pmd)) {
-                        ptep = pte_offset(pmd, adr);
-                        pte = *ptep;
-                        if(pte_present(pte))
-				ret = pte_page(pte);
-                }
-        }
-	return ret;
-}
-
-/* Here we want the physical address of the memory.
- * This is used when initializing the contents of the
- * area and marking the pages as reserved, and for
- * handling page faults on the rvmalloc()ed buffer
- */
-static inline unsigned long kvirt_to_pa(unsigned long adr) 
-{
-        unsigned long va, kva, ret;
-
-        va = VMALLOC_VMADDR(adr);
-	kva = (unsigned long) page_address(uvirt_to_page(pgd_offset_k(va), va));
-	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
-	ret = __pa(kva);
-        MDEBUG(printk("kv2pa(%lx-->%lx)", adr, ret));
-        return ret;
-}
-
 static void * rvmalloc(unsigned long size)
 {
 	void * mem;
-	unsigned long adr, page;
-        
+	unsigned long adr;
+
+	size=PAGE_ALIGN(size);
 	mem=vmalloc_32(size);
 	if (mem) {
 		memset(mem, 0, size); /* Clear the ram out, 
 					 no junk to the user */
 	        adr=(unsigned long) mem;
 		while (size > 0) {
-	                page = kvirt_to_pa(adr);
-			mem_map_reserve(virt_to_page(__va(page)));
+			mem_map_reserve(vmalloc_to_page((void *)adr));
 			adr+=PAGE_SIZE;
 			size-=PAGE_SIZE;
 		}
@@ -267,13 +215,12 @@
 
 static void rvfree(void * mem, unsigned long size)
 {
-        unsigned long adr, page;
-        
+        unsigned long adr;
+
 	if (mem) {
 	        adr=(unsigned long) mem;
-		while (size > 0) {
-	                page = kvirt_to_pa(adr);
-			mem_map_unreserve(virt_to_page(__va(page)));
+		while ((long) size > 0) {
+			mem_map_unreserve(vmalloc_to_page((void *)adr));
 			adr+=PAGE_SIZE;
 			size-=PAGE_SIZE;
 		}
@@ -1167,9 +1114,9 @@
 		
 		/* fill the sglist with the kernel addresses of pages in the non-contiguous buffer */
 		for(i = 0; i < video->user_dma.n_pages; i++) {
-			unsigned long va = VMALLOC_VMADDR( (unsigned long) video->user_buf + i * PAGE_SIZE );
+			unsigned long va = (unsigned long) video->user_buf + i * PAGE_SIZE;
 			
-			video->user_dma.sglist[i].page = uvirt_to_page(pgd_offset_k(va), va);
+			video->user_dma.sglist[i].page = vmalloc_to_page((void *)va);
 			video->user_dma.sglist[i].length = PAGE_SIZE;
 		}
 		
@@ -1493,7 +1440,7 @@
 static struct page * dv1394_nopage(struct vm_area_struct * area, unsigned long address, int write_access)
 {
 	unsigned long offset;
-	unsigned long page, kernel_virt_addr;
+	unsigned long kernel_virt_addr;
 	struct page *ret = NOPAGE_SIGBUS;
 
 	struct video_card *video = (struct video_card*) area->vm_private_data;
@@ -1511,10 +1458,7 @@
 
 	offset = address - area->vm_start;
 	kernel_virt_addr = (unsigned long) video->user_buf + offset;
-
-	page = kvirt_to_pa(kernel_virt_addr);
-	
-	ret = virt_to_page(__va(page));
+	ret = vmalloc_to_page((void *)kernel_virt_addr);
 	get_page(ret);
 
  out:
--- 2.4.19-pre6/drivers/ieee1394/video1394.c	Tue Apr  9 13:37:03 2002
+++ linux/drivers/ieee1394/video1394.c	Tue Apr  9 17:50:58 2002
@@ -168,86 +168,35 @@
 /* Memory management functions */
 /*******************************/
 
-#define MDEBUG(x)	do { } while(0)		/* Debug memory management */
-
-/* [DaveM] I've recoded most of this so that:
- * 1) It's easier to tell what is happening
- * 2) It's more portable, especially for translating things
- *    out of vmalloc mapped areas in the kernel.
- * 3) Less unnecessary translations happen.
- *
- * The code used to assume that the kernel vmalloc mappings
- * existed in the page tables of every process, this is simply
- * not guaranteed.  We now use pgd_offset_k which is the
- * defined way to get at the kernel page tables.
- */
-
-/* Given PGD from the address space's page table, return the kernel
- * virtual mapping of the physical memory mapped at ADR.
- */
-static inline unsigned long uvirt_to_kva(pgd_t *pgd, unsigned long adr)
-{
-        unsigned long ret = 0UL;
-	pmd_t *pmd;
-	pte_t *ptep, pte;
-  
-	if (!pgd_none(*pgd)) {
-                pmd = pmd_offset(pgd, adr);
-                if (!pmd_none(*pmd)) {
-                        ptep = pte_offset(pmd, adr);
-                        pte = *ptep;
-                        if(pte_present(pte)) {
-				ret = (unsigned long) 
-					page_address(pte_page(pte));
-                                ret |= (adr & (PAGE_SIZE - 1));
-			}
-                }
-        }
-        MDEBUG(printk("uv2kva(%lx-->%lx)", adr, ret));
-	return ret;
-}
-
-static inline unsigned long uvirt_to_bus(unsigned long adr) 
-{
-        unsigned long kva, ret;
-
-        kva = uvirt_to_kva(pgd_offset(current->mm, adr), adr);
-	ret = virt_to_bus((void *)kva);
-        MDEBUG(printk("uv2b(%lx-->%lx)", adr, ret));
-        return ret;
-}
-
 static inline unsigned long kvirt_to_bus(unsigned long adr) 
 {
-        unsigned long va, kva, ret;
+        unsigned long kva, ret;
 
-        va = VMALLOC_VMADDR(adr);
-        kva = uvirt_to_kva(pgd_offset_k(va), va);
+	kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
+	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
 	ret = virt_to_bus((void *)kva);
-        MDEBUG(printk("kv2b(%lx-->%lx)", adr, ret));
         return ret;
 }
 
 /* Here we want the physical address of the memory.
- * This is used when initializing the contents of the
- * area and marking the pages as reserved.
+ * This is used when initializing the contents of the area.
  */
 static inline unsigned long kvirt_to_pa(unsigned long adr) 
 {
-        unsigned long va, kva, ret;
+        unsigned long kva, ret;
 
-        va = VMALLOC_VMADDR(adr);
-        kva = uvirt_to_kva(pgd_offset_k(va), va);
+	kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
+	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
 	ret = __pa(kva);
-        MDEBUG(printk("kv2pa(%lx-->%lx)", adr, ret));
         return ret;
 }
 
 static void * rvmalloc(unsigned long size)
 {
 	void * mem;
-	unsigned long adr, page;
-        
+	unsigned long adr;
+ 
+	size=PAGE_ALIGN(size);
 	mem=vmalloc_32(size);
 	if (mem) 
 	{
@@ -256,8 +205,7 @@
 	        adr=(unsigned long) mem;
 		while (size > 0) 
                 {
-	                page = kvirt_to_pa(adr);
-			mem_map_reserve(virt_to_page(__va(page)));
+			mem_map_reserve(vmalloc_to_page((void *)adr));
 			adr+=PAGE_SIZE;
 			size-=PAGE_SIZE;
 		}
@@ -267,15 +215,14 @@
 
 static void rvfree(void * mem, unsigned long size)
 {
-        unsigned long adr, page;
-        
+        unsigned long adr;
+
 	if (mem) 
 	{
 	        adr=(unsigned long) mem;
-		while (size > 0) 
+		while ((long) size > 0) 
                 {
-	                page = kvirt_to_pa(adr);
-			mem_map_unreserve(virt_to_page(__va(page)));
+			mem_map_unreserve(vmalloc_to_page((void *)adr));
 			adr+=PAGE_SIZE;
 			size-=PAGE_SIZE;
 		}
--- 2.4.19-pre6/drivers/media/video/bttv-driver.c	Tue Apr  9 13:37:03 2002
+++ linux/drivers/media/video/bttv-driver.c	Tue Apr  9 17:50:58 2002
@@ -137,97 +137,52 @@
 /* Memory management functions */
 /*******************************/
 
-#define MDEBUG(x)	do { } while(0)		/* Debug memory management */
-
 /* [DaveM] I've recoded most of this so that:
  * 1) It's easier to tell what is happening
  * 2) It's more portable, especially for translating things
  *    out of vmalloc mapped areas in the kernel.
  * 3) Less unnecessary translations happen.
- *
- * The code used to assume that the kernel vmalloc mappings
- * existed in the page tables of every process, this is simply
- * not guarenteed.  We now use pgd_offset_k which is the
- * defined way to get at the kernel page tables.
- */
-
-/* Given PGD from the address space's page table, return the kernel
- * virtual mapping of the physical memory mapped at ADR.
  */
-static inline unsigned long uvirt_to_kva(pgd_t *pgd, unsigned long adr)
-{
-        unsigned long ret = 0UL;
-	pmd_t *pmd;
-	pte_t *ptep, pte;
-  
-	if (!pgd_none(*pgd)) {
-                pmd = pmd_offset(pgd, adr);
-                if (!pmd_none(*pmd)) {
-                        ptep = pte_offset(pmd, adr);
-                        pte = *ptep;
-                        if(pte_present(pte)) {
-				ret  = (unsigned long) page_address(pte_page(pte));
-				ret |= (adr & (PAGE_SIZE - 1));
-				
-			}
-                }
-        }
-        MDEBUG(printk("uv2kva(%lx-->%lx)", adr, ret));
-	return ret;
-}
-
-static inline unsigned long uvirt_to_bus(unsigned long adr) 
-{
-        unsigned long kva, ret;
-
-        kva = uvirt_to_kva(pgd_offset(current->mm, adr), adr);
-	ret = virt_to_bus((void *)kva);
-        MDEBUG(printk("uv2b(%lx-->%lx)", adr, ret));
-        return ret;
-}
 
 static inline unsigned long kvirt_to_bus(unsigned long adr) 
 {
-        unsigned long va, kva, ret;
+        unsigned long kva, ret;
 
-        va = VMALLOC_VMADDR(adr);
-        kva = uvirt_to_kva(pgd_offset_k(va), va);
+	kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
+	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
 	ret = virt_to_bus((void *)kva);
-        MDEBUG(printk("kv2b(%lx-->%lx)", adr, ret));
         return ret;
 }
 
 /* Here we want the physical address of the memory.
- * This is used when initializing the contents of the
- * area and marking the pages as reserved.
+ * This is used when initializing the contents of the area.
  */
 static inline unsigned long kvirt_to_pa(unsigned long adr) 
 {
-        unsigned long va, kva, ret;
+        unsigned long kva, ret;
 
-        va = VMALLOC_VMADDR(adr);
-        kva = uvirt_to_kva(pgd_offset_k(va), va);
+	kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
+	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
 	ret = __pa(kva);
-        MDEBUG(printk("kv2pa(%lx-->%lx)", adr, ret));
         return ret;
 }
 
-static void * rvmalloc(signed long size)
+static void * rvmalloc(unsigned long size)
 {
 	void * mem;
-	unsigned long adr, page;
+	unsigned long adr;
 
+	size=PAGE_ALIGN(size);
 	mem=vmalloc_32(size);
 	if (NULL == mem)
-		printk(KERN_INFO "bttv: vmalloc_32(%ld) failed\n",size);
+		printk(KERN_INFO "bttv: vmalloc_32(%lu) failed\n",size);
 	else {
 		/* Clear the ram out, no junk to the user */
 		memset(mem, 0, size);
 	        adr=(unsigned long) mem;
 		while (size > 0) 
                 {
-	                page = kvirt_to_pa(adr);
-			mem_map_reserve(virt_to_page(__va(page)));
+			mem_map_reserve(vmalloc_to_page((void *)adr));
 			adr+=PAGE_SIZE;
 			size-=PAGE_SIZE;
 		}
@@ -235,17 +190,16 @@
 	return mem;
 }
 
-static void rvfree(void * mem, signed long size)
+static void rvfree(void * mem, unsigned long size)
 {
-        unsigned long adr, page;
+        unsigned long adr;
         
 	if (mem) 
 	{
 	        adr=(unsigned long) mem;
-		while (size > 0) 
+		while ((long) size > 0)
                 {
-	                page = kvirt_to_pa(adr);
-			mem_map_unreserve(virt_to_page(__va(page)));
+			mem_map_unreserve(vmalloc_to_page((void *)adr));
 			adr+=PAGE_SIZE;
 			size-=PAGE_SIZE;
 		}
--- 2.4.19-pre6/drivers/media/video/cpia.c	Thu Oct 25 21:53:47 2001
+++ linux/drivers/media/video/cpia.c	Tue Apr  9 17:50:58 2002
@@ -178,50 +178,17 @@
  *
  * Memory management
  *
- * This is a shameless copy from the USB-cpia driver (linux kernel
- * version 2.3.29 or so, I have no idea what this code actually does ;).
- * Actually it seems to be a copy of a shameless copy of the bttv-driver.
- * Or that is a copy of a shameless copy of ... (To the powers: is there
- * no generic kernel-function to do this sort of stuff?)
- *
- * Yes, it was a shameless copy from the bttv-driver. IIRC, Alan says
- * there will be one, but apparentely not yet - jerdfelt
- *
  **********************************************************************/
 
-/* Given PGD from the address space's page table, return the kernel
- * virtual mapping of the physical memory mapped at ADR.
- */
-static inline unsigned long uvirt_to_kva(pgd_t *pgd, unsigned long adr)
-{
-	unsigned long ret = 0UL;
-	pmd_t *pmd;
-	pte_t *ptep, pte;
-
-	if (!pgd_none(*pgd)) {
-		pmd = pmd_offset(pgd, adr);
-		if (!pmd_none(*pmd)) {
-			ptep = pte_offset(pmd, adr);
-			pte = *ptep;
-			if (pte_present(pte)) {
-				ret = (unsigned long) page_address(pte_page(pte));
-				ret |= (adr & (PAGE_SIZE-1));
-			}
-		}
-	}
-	return ret;
-}
-
 /* Here we want the physical address of the memory.
- * This is used when initializing the contents of the
- * area and marking the pages as reserved.
+ * This is used when initializing the contents of the area.
  */
 static inline unsigned long kvirt_to_pa(unsigned long adr)
 {
-	unsigned long va, kva, ret;
+	unsigned long kva, ret;
 
-	va = VMALLOC_VMADDR(adr);
-	kva = uvirt_to_kva(pgd_offset_k(va), va);
+	kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
+	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
 	ret = __pa(kva);
 	return ret;
 }
@@ -229,12 +196,9 @@
 static void *rvmalloc(unsigned long size)
 {
 	void *mem;
-	unsigned long adr, page;
-
-	/* Round it off to PAGE_SIZE */
-	size += (PAGE_SIZE - 1);
-	size &= ~(PAGE_SIZE - 1);
+	unsigned long adr;
 
+	size = PAGE_ALIGN(size);
 	mem = vmalloc_32(size);
 	if (!mem)
 		return NULL;
@@ -242,13 +206,9 @@
 	memset(mem, 0, size); /* Clear the ram out, no junk to the user */
 	adr = (unsigned long) mem;
 	while (size > 0) {
-		page = kvirt_to_pa(adr);
-		mem_map_reserve(virt_to_page(__va(page)));
+		mem_map_reserve(vmalloc_to_page((void *)adr));
 		adr += PAGE_SIZE;
-		if (size > PAGE_SIZE)
-			size -= PAGE_SIZE;
-		else
-			size = 0;
+		size -= PAGE_SIZE;
 	}
 
 	return mem;
@@ -256,23 +216,16 @@
 
 static void rvfree(void *mem, unsigned long size)
 {
-	unsigned long adr, page;
+	unsigned long adr;
 
 	if (!mem)
 		return;
 
-	size += (PAGE_SIZE - 1);
-	size &= ~(PAGE_SIZE - 1);
-
 	adr = (unsigned long) mem;
-	while (size > 0) {
-		page = kvirt_to_pa(adr);
-		mem_map_unreserve(virt_to_page(__va(page)));
+	while ((long) size > 0) {
+		mem_map_unreserve(vmalloc_to_page((void *)adr));
 		adr += PAGE_SIZE;
-		if (size > PAGE_SIZE)
-			size -= PAGE_SIZE;
-		else
-			size = 0;
+		size -= PAGE_SIZE;
 	}
 	vfree(mem);
 }
--- 2.4.19-pre6/drivers/usb/ov511.c	Tue Apr  9 13:37:07 2002
+++ linux/drivers/usb/ov511.c	Tue Apr  9 17:50:58 2002
@@ -377,55 +377,18 @@
  *
  * Memory management
  *
- * This is a shameless copy from the USB-cpia driver (linux kernel
- * version 2.3.29 or so, I have no idea what this code actually does ;).
- * Actually it seems to be a copy of a shameless copy of the bttv-driver.
- * Or that is a copy of a shameless copy of ... (To the powers: is there
- * no generic kernel-function to do this sort of stuff?)
- *
- * Yes, it was a shameless copy from the bttv-driver. IIRC, Alan says
- * there will be one, but apparentely not yet -jerdfelt
- *
- * So I copied it again for the OV511 driver -claudio
  **********************************************************************/
 
-/* Given PGD from the address space's page table, return the kernel
- * virtual mapping of the physical memory mapped at ADR.
- */
-static inline unsigned long 
-uvirt_to_kva(pgd_t *pgd, unsigned long adr)
-{
-	unsigned long ret = 0UL;
-	pmd_t *pmd;
-	pte_t *ptep, pte;
-
-	if (!pgd_none(*pgd)) {
-		pmd = pmd_offset(pgd, adr);
-		if (!pmd_none(*pmd)) {
-			ptep = pte_offset(pmd, adr);
-			pte = *ptep;
-			if (pte_present(pte)) {
-				ret = (unsigned long) 
-				      page_address(pte_page(pte));
-				ret |= (adr & (PAGE_SIZE - 1));
-			}
-		}
-	}
-
-	return ret;
-}
-
 /* Here we want the physical address of the memory.
- * This is used when initializing the contents of the
- * area and marking the pages as reserved.
+ * This is used when initializing the contents of the area.
  */
 static inline unsigned long 
 kvirt_to_pa(unsigned long adr)
 {
-	unsigned long va, kva, ret;
+	unsigned long kva, ret;
 
-	va = VMALLOC_VMADDR(adr);
-	kva = uvirt_to_kva(pgd_offset_k(va), va);
+	kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
+	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
 	ret = __pa(kva);
 	return ret;
 }
@@ -434,12 +397,9 @@
 rvmalloc(unsigned long size)
 {
 	void *mem;
-	unsigned long adr, page;
-
-	/* Round it off to PAGE_SIZE */
-	size += (PAGE_SIZE - 1);
-	size &= ~(PAGE_SIZE - 1);
+	unsigned long adr;
 
+	size = PAGE_ALIGN(size);
 	mem = vmalloc_32(size);
 	if (!mem)
 		return NULL;
@@ -447,13 +407,9 @@
 	memset(mem, 0, size); /* Clear the ram out, no junk to the user */
 	adr = (unsigned long) mem;
 	while (size > 0) {
-		page = kvirt_to_pa(adr);
-		mem_map_reserve(virt_to_page(__va(page)));
+		mem_map_reserve(vmalloc_to_page((void *)adr));
 		adr += PAGE_SIZE;
-		if (size > PAGE_SIZE)
-			size -= PAGE_SIZE;
-		else
-			size = 0;
+		size -= PAGE_SIZE;
 	}
 
 	return mem;
@@ -462,23 +418,16 @@
 static void 
 rvfree(void *mem, unsigned long size)
 {
-	unsigned long adr, page;
+	unsigned long adr;
 
 	if (!mem)
 		return;
 
-	size += (PAGE_SIZE - 1);
-	size &= ~(PAGE_SIZE - 1);
-
-	adr=(unsigned long) mem;
-	while (size > 0) {
-		page = kvirt_to_pa(adr);
-		mem_map_unreserve(virt_to_page(__va(page)));
+	adr = (unsigned long) mem;
+	while ((long) size > 0) {
+		mem_map_unreserve(vmalloc_to_page((void *)adr));
 		adr += PAGE_SIZE;
-		if (size > PAGE_SIZE)
-			size -= PAGE_SIZE;
-		else
-			size = 0;
+		size -= PAGE_SIZE;
 	}
 	vfree(mem);
 }
--- 2.4.19-pre6/drivers/usb/pwc-if.c	Tue Apr  9 13:37:07 2002
+++ linux/drivers/usb/pwc-if.c	Tue Apr  9 17:50:58 2002
@@ -179,60 +179,25 @@
 /***************************************************************************/
 /* Private functions */
 
-/* Memory management functions, nicked from cpia.c, which nicked them from
-   bttv.c. So far, I've counted duplication of this code 6 times 
-   (bttv, cpia, ibmcam, ov511, pwc, ieee1394).
- */
-
-/* Given PGD from the address space's page table, return the kernel
- * virtual mapping of the physical memory mapped at ADR.
- */
-static inline unsigned long uvirt_to_kva(pgd_t *pgd, unsigned long adr)
-{
-        unsigned long ret = 0UL;
-	pmd_t *pmd;
-	pte_t *ptep, pte;
-  
-	if (!pgd_none(*pgd)) {
-                pmd = pmd_offset(pgd, adr);
-                if (!pmd_none(*pmd)) {
-                        ptep = pte_offset(pmd, adr);
-                        pte = *ptep;
-                        if(pte_present(pte)) {
-				ret  = (unsigned long) page_address(pte_page(pte));
-				ret |= (adr & (PAGE_SIZE - 1));
-				
-			}
-                }
-        }
-	return ret;
-}
-
-
-
 /* Here we want the physical address of the memory.
- * This is used when initializing the contents of the
- * area and marking the pages as reserved.
+ * This is used when initializing the contents of the area.
  */
 static inline unsigned long kvirt_to_pa(unsigned long adr) 
 {
-        unsigned long va, kva, ret;
+        unsigned long kva, ret;
 
-        va = VMALLOC_VMADDR(adr);
-        kva = uvirt_to_kva(pgd_offset_k(va), va);
+	kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
+	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
 	ret = __pa(kva);
         return ret;
 }
 
-static void * rvmalloc(signed long size)
+static void * rvmalloc(unsigned long size)
 {
 	void * mem;
-	unsigned long adr, page;
+	unsigned long adr;
 
-        /* Round it off to PAGE_SIZE */
-        size += (PAGE_SIZE - 1);
-        size &= ~(PAGE_SIZE - 1);	
-        
+	size=PAGE_ALIGN(size);
         mem=vmalloc_32(size);
 	if (mem) 
 	{
@@ -240,8 +205,7 @@
 	        adr=(unsigned long) mem;
 		while (size > 0) 
                 {
-	                page = kvirt_to_pa(adr);
-			mem_map_reserve(virt_to_page(__va(page)));
+			mem_map_reserve(vmalloc_to_page((void *)adr));
 			adr+=PAGE_SIZE;
 			size-=PAGE_SIZE;
 		}
@@ -249,20 +213,16 @@
 	return mem;
 }
 
-static void rvfree(void * mem, signed long size)
+static void rvfree(void * mem, unsigned long size)
 {
-        unsigned long adr, page;
-        
-        /* Round it off to PAGE_SIZE */
-        size += (PAGE_SIZE - 1);
-        size &= ~(PAGE_SIZE - 1);	
+        unsigned long adr;
+
 	if (mem) 
 	{
 	        adr=(unsigned long) mem;
-		while (size > 0) 
+		while ((long) size > 0) 
                 {
-	                page = kvirt_to_pa(adr);
-			mem_map_unreserve(virt_to_page(__va(page)));
+			mem_map_unreserve(vmalloc_to_page((void *)adr));
 			adr+=PAGE_SIZE;
 			size-=PAGE_SIZE;
 		}
--- 2.4.19-pre6/drivers/usb/se401.c	Fri Sep 14 22:27:10 2001
+++ linux/drivers/usb/se401.c	Tue Apr  9 17:50:58 2002
@@ -80,54 +80,17 @@
  *
  * Memory management
  *
- * This is a shameless copy from the USB-cpia driver (linux kernel
- * version 2.3.29 or so, I have no idea what this code actually does ;).
- * Actually it seems to be a copy of a shameless copy of the bttv-driver.
- * Or that is a copy of a shameless copy of ... (To the powers: is there
- * no generic kernel-function to do this sort of stuff?)
- *
- * Yes, it was a shameless copy from the bttv-driver. IIRC, Alan says
- * there will be one, but apparentely not yet -jerdfelt
- *
- * So I copied it again for the ov511 driver -claudio
- *
- * Same for the se401 driver -Jeroen
  **********************************************************************/
 
-/* Given PGD from the address space's page table, return the kernel
- * virtual mapping of the physical memory mapped at ADR.
- */
-static inline unsigned long uvirt_to_kva(pgd_t *pgd, unsigned long adr)
-{
-	unsigned long ret = 0UL;
-	pmd_t *pmd;
-	pte_t *ptep, pte;
-
-	if (!pgd_none(*pgd)) {
-		pmd = pmd_offset(pgd, adr);
-		if (!pmd_none(*pmd)) {
-			ptep = pte_offset(pmd, adr);
-			pte = *ptep;
-			if (pte_present(pte)) {
-				ret = (unsigned long) page_address(pte_page(pte));
-				ret |= (adr & (PAGE_SIZE - 1));
-			}
-		}
-	}
-
-	return ret;
-}
-
 /* Here we want the physical address of the memory.
- * This is used when initializing the contents of the
- * area and marking the pages as reserved.
+ * This is used when initializing the contents of the area.
  */
 static inline unsigned long kvirt_to_pa(unsigned long adr)
 {
-	unsigned long va, kva, ret;
+	unsigned long kva, ret;
 
-	va = VMALLOC_VMADDR(adr);
-	kva = uvirt_to_kva(pgd_offset_k(va), va);
+	kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
+	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
 	ret = __pa(kva);
 	return ret;
 }
@@ -135,12 +98,9 @@
 static void *rvmalloc(unsigned long size)
 {
 	void *mem;
-	unsigned long adr, page;
-
-	/* Round it off to PAGE_SIZE */
-	size += (PAGE_SIZE - 1);
-	size &= ~(PAGE_SIZE - 1);
+	unsigned long adr;
 
+	size = PAGE_ALIGN(size);
 	mem = vmalloc_32(size);
 	if (!mem)
 		return NULL;
@@ -148,13 +108,9 @@
 	memset(mem, 0, size); /* Clear the ram out, no junk to the user */
 	adr = (unsigned long) mem;
 	while (size > 0) {
-		page = kvirt_to_pa(adr);
-		mem_map_reserve(virt_to_page(__va(page)));
+		mem_map_reserve(vmalloc_to_page((void *)adr));
 		adr += PAGE_SIZE;
-		if (size > PAGE_SIZE)
-			size -= PAGE_SIZE;
-		else
-			size = 0;
+		size -= PAGE_SIZE;
 	}
 
 	return mem;
@@ -162,23 +118,16 @@
 
 static void rvfree(void *mem, unsigned long size)
 {
-	unsigned long adr, page;
+	unsigned long adr;
 
 	if (!mem)
 		return;
 
-	size += (PAGE_SIZE - 1);
-	size &= ~(PAGE_SIZE - 1);
-
-	adr=(unsigned long) mem;
-	while (size > 0) {
-		page = kvirt_to_pa(adr);
-		mem_map_unreserve(virt_to_page(__va(page)));
+	adr = (unsigned long) mem;
+	while ((long) size > 0) {
+		mem_map_unreserve(vmalloc_to_page((void *)adr));
 		adr += PAGE_SIZE;
-		if (size > PAGE_SIZE)
-			size -= PAGE_SIZE;
-		else
-			size = 0;
+		size -= PAGE_SIZE;
 	}
 	vfree(mem);
 }
--- 2.4.19-pre6/drivers/usb/stv680.c	Tue Apr  9 13:37:07 2002
+++ linux/drivers/usb/stv680.c	Tue Apr  9 17:50:58 2002
@@ -111,67 +111,27 @@
  *
  * Memory management
  *
- * This is a shameless copy from the USB-cpia driver (linux kernel
- * version 2.3.29 or so, I have no idea what this code actually does ;).
- * Actually it seems to be a copy of a shameless copy of the bttv-driver.
- * Or that is a copy of a shameless copy of ... (To the powers: is there
- * no generic kernel-function to do this sort of stuff?)
- *
- * Yes, it was a shameless copy from the bttv-driver. IIRC, Alan says
- * there will be one, but apparentely not yet -jerdfelt
- *
- * So I copied it again for the ov511 driver -claudio
- *
- * Same for the se401 driver -Jeroen
- *
- * And the STV0680 driver - Kevin
  ********************************************************************/
 
-/* Given PGD from the address space's page table, return the kernel
- * virtual mapping of the physical memory mapped at ADR.
- */
-static inline unsigned long uvirt_to_kva (pgd_t * pgd, unsigned long adr)
-{
-	unsigned long ret = 0UL;
-	pmd_t *pmd;
-	pte_t *ptep, pte;
-
-	if (!pgd_none (*pgd)) {
-		pmd = pmd_offset (pgd, adr);
-		if (!pmd_none (*pmd)) {
-			ptep = pte_offset (pmd, adr);
-			pte = *ptep;
-			if (pte_present (pte)) {
-				ret = (unsigned long) page_address (pte_page (pte));
-				ret |= (adr & (PAGE_SIZE - 1));
-			}
-		}
-	}
-	return ret;
-}
-
-/* Here we want the physical address of the memory. This is used when 
- * initializing the contents of the area and marking the pages as reserved.
+/* Here we want the physical address of the memory.
+ * This is used when initializing the contents of the area.
  */
 static inline unsigned long kvirt_to_pa (unsigned long adr)
 {
-	unsigned long va, kva, ret;
+	unsigned long kva, ret;
 
-	va = VMALLOC_VMADDR (adr);
-	kva = uvirt_to_kva (pgd_offset_k (va), va);
-	ret = __pa (kva);
+	kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
+	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
+	ret = __pa(kva);
 	return ret;
 }
 
 static void *rvmalloc (unsigned long size)
 {
 	void *mem;
-	unsigned long adr, page;
-
-	/* Round it off to PAGE_SIZE */
-	size += (PAGE_SIZE - 1);
-	size &= ~(PAGE_SIZE - 1);
+	unsigned long adr;
 
+	size = PAGE_ALIGN(size);
 	mem = vmalloc_32 (size);
 	if (!mem)
 		return NULL;
@@ -179,36 +139,25 @@
 	memset (mem, 0, size);	/* Clear the ram out, no junk to the user */
 	adr = (unsigned long) mem;
 	while (size > 0) {
-		page = kvirt_to_pa (adr);
-		mem_map_reserve (virt_to_page (__va (page)));
+		mem_map_reserve(vmalloc_to_page((void *)adr));
 		adr += PAGE_SIZE;
-		if (size > PAGE_SIZE)
-			size -= PAGE_SIZE;
-		else
-			size = 0;
+		size -= PAGE_SIZE;
 	}
 	return mem;
 }
 
 static void rvfree (void *mem, unsigned long size)
 {
-	unsigned long adr, page;
+	unsigned long adr;
 
 	if (!mem)
 		return;
 
-	size += (PAGE_SIZE - 1);
-	size &= ~(PAGE_SIZE - 1);
-
 	adr = (unsigned long) mem;
-	while (size > 0) {
-		page = kvirt_to_pa (adr);
-		mem_map_unreserve (virt_to_page (__va (page)));
+	while ((long) size > 0) {
+		mem_map_unreserve(vmalloc_to_page((void *)adr));
 		adr += PAGE_SIZE;
-		if (size > PAGE_SIZE)
-			size -= PAGE_SIZE;
-		else
-			size = 0;
+		size -= PAGE_SIZE;
 	}
 	vfree (mem);
 }
--- 2.4.19-pre6/drivers/usb/usbvideo.c	Thu Oct 11 07:42:46 2001
+++ linux/drivers/usb/usbvideo.c	Tue Apr  9 17:50:58 2002
@@ -58,57 +58,26 @@
 /* Memory management functions */
 /*******************************/
 
-#define MDEBUG(x)	do { } while(0)		/* Debug memory management */
-
-/* Given PGD from the address space's page table, return the kernel
- * virtual mapping of the physical memory mapped at ADR.
- */
-unsigned long usbvideo_uvirt_to_kva(pgd_t *pgd, unsigned long adr)
-{
-	unsigned long ret = 0UL;
-	pmd_t *pmd;
-	pte_t *ptep, pte;
-
-	if (!pgd_none(*pgd)) {
-		pmd = pmd_offset(pgd, adr);
-		if (!pmd_none(*pmd)) {
-			ptep = pte_offset(pmd, adr);
-			pte = *ptep;
-			if (pte_present(pte)) {
-				ret = (unsigned long) page_address(pte_page(pte));
-				ret |= (adr & (PAGE_SIZE-1));
-			}
-		}
-	}
-	MDEBUG(printk("uv2kva(%lx-->%lx)", adr, ret));
-	return ret;
-}
-
 /*
  * Here we want the physical address of the memory.
- * This is used when initializing the contents of the
- * area and marking the pages as reserved.
+ * This is used when initializing the contents of the area.
  */
 unsigned long usbvideo_kvirt_to_pa(unsigned long adr)
 {
-	unsigned long va, kva, ret;
+	unsigned long kva, ret;
 
-	va = VMALLOC_VMADDR(adr);
-	kva = usbvideo_uvirt_to_kva(pgd_offset_k(va), va);
+	kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
+	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
 	ret = __pa(kva);
-	MDEBUG(printk("kv2pa(%lx-->%lx)", adr, ret));
 	return ret;
 }
 
 void *usbvideo_rvmalloc(unsigned long size)
 {
 	void *mem;
-	unsigned long adr, page;
-
-	/* Round it off to PAGE_SIZE */
-	size += (PAGE_SIZE - 1);
-	size &= ~(PAGE_SIZE - 1);
+	unsigned long adr;
 
+	size = PAGE_ALIGN(size);
 	mem = vmalloc_32(size);
 	if (!mem)
 		return NULL;
@@ -116,13 +85,9 @@
 	memset(mem, 0, size); /* Clear the ram out, no junk to the user */
 	adr = (unsigned long) mem;
 	while (size > 0) {
-		page = usbvideo_kvirt_to_pa(adr);
-		mem_map_reserve(virt_to_page(__va(page)));
+		mem_map_reserve(vmalloc_to_page((void *)adr));
 		adr += PAGE_SIZE;
-		if (size > PAGE_SIZE)
-			size -= PAGE_SIZE;
-		else
-			size = 0;
+		size -= PAGE_SIZE;
 	}
 
 	return mem;
@@ -130,23 +95,16 @@
 
 void usbvideo_rvfree(void *mem, unsigned long size)
 {
-	unsigned long adr, page;
+	unsigned long adr;
 
 	if (!mem)
 		return;
 
-	size += (PAGE_SIZE - 1);
-	size &= ~(PAGE_SIZE - 1);
-
-	adr=(unsigned long) mem;
-	while (size > 0) {
-		page = usbvideo_kvirt_to_pa(adr);
-		mem_map_unreserve(virt_to_page(__va(page)));
+	adr = (unsigned long) mem;
+	while ((long) size > 0) {
+		mem_map_unreserve(vmalloc_to_page((void *)adr));
 		adr += PAGE_SIZE;
-		if (size > PAGE_SIZE)
-			size -= PAGE_SIZE;
-		else
-			size = 0;
+		size -= PAGE_SIZE;
 	}
 	vfree(mem);
 }
--- 2.4.19-pre6/drivers/usb/vicam.c	Tue Apr  9 13:37:07 2002
+++ linux/drivers/usb/vicam.c	Tue Apr  9 17:50:58 2002
@@ -91,80 +91,25 @@
  *
  ******************************************************************************/
 
-/* [DaveM] I've recoded most of this so that:
- * 1) It's easier to tell what is happening
- * 2) It's more portable, especially for translating things
- *    out of vmalloc mapped areas in the kernel.
- * 3) Less unnecessary translations happen.
- *
- * The code used to assume that the kernel vmalloc mappings
- * existed in the page tables of every process, this is simply
- * not guarenteed.  We now use pgd_offset_k which is the
- * defined way to get at the kernel page tables.
- */
-
-/* Given PGD from the address space's page table, return the kernel
- * virtual mapping of the physical memory mapped at ADR.
- */
-static inline unsigned long uvirt_to_kva(pgd_t *pgd, unsigned long adr)
-{
-	unsigned long ret = 0UL;
-	pmd_t *pmd;
-	pte_t *ptep, pte;
-
-	if (!pgd_none(*pgd)) {
-		pmd = pmd_offset(pgd, adr);
-		if (!pmd_none(*pmd)) {
-			ptep = pte_offset(pmd, adr);
-			pte = *ptep;
-			if(pte_present(pte)) {
-				ret  = (unsigned long) page_address(pte_page(pte));
-				ret |= (adr & (PAGE_SIZE - 1));
-
-			}
-		}
-	}
-	return ret;
-}
-
-static inline unsigned long uvirt_to_bus(unsigned long adr)
-{
-	unsigned long kva, ret;
-
-	kva = uvirt_to_kva(pgd_offset(current->mm, adr), adr);
-	ret = virt_to_bus((void *)kva);
-	return ret;
-}
-
-static inline unsigned long kvirt_to_bus(unsigned long adr)
-{
-	unsigned long va, kva, ret;
-
-	va = VMALLOC_VMADDR(adr);
-	kva = uvirt_to_kva(pgd_offset_k(va), va);
-	ret = virt_to_bus((void *)kva);
-	return ret;
-}
-
 /* Here we want the physical address of the memory.
- * This is used when initializing the contents of the
- * area and marking the pages as reserved.
+ * This is used when initializing the contents of the area.
  */
 static inline unsigned long kvirt_to_pa(unsigned long adr)
 {
-	unsigned long va, kva, ret;
+	unsigned long kva, ret;
 
-	va = VMALLOC_VMADDR(adr);
-	kva = uvirt_to_kva(pgd_offset_k(va), va);
+	kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
+	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
 	ret = __pa(kva);
 	return ret;
 }
 
-static void * rvmalloc(signed long size)
+static void * rvmalloc(unsigned long size)
 {
 	void * mem;
-	unsigned long adr, page;
+	unsigned long adr;
 
+	size=PAGE_ALIGN(size);
 	mem=vmalloc_32(size);
 	if (mem)
 	{
@@ -172,8 +117,7 @@
 		adr=(unsigned long) mem;
 		while (size > 0)
 		{
-			page = kvirt_to_pa(adr);
-			mem_map_reserve(virt_to_page(__va(page)));
+			mem_map_reserve(vmalloc_to_page((void *)adr));
 			adr+=PAGE_SIZE;
 			size-=PAGE_SIZE;
 		}
@@ -181,17 +125,16 @@
 	return mem;
 }
 
-static void rvfree(void * mem, signed long size)
+static void rvfree(void * mem, unsigned long size)
 {
-	unsigned long adr, page;
+	unsigned long adr;
 
 	if (mem)
 	{
 		adr=(unsigned long) mem;
-		while (size > 0)
+		while ((long) size > 0)
 		{
-			page = kvirt_to_pa(adr);
-			mem_map_unreserve(virt_to_page(__va(page)));
+			mem_map_unreserve(vmalloc_to_page((void *)adr));
 			adr+=PAGE_SIZE;
 			size-=PAGE_SIZE;
 		}

