Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbTE2PBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 11:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTE2PBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 11:01:48 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:22191 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262278AbTE2PBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 11:01:33 -0400
Date: Thu, 29 May 2003 08:14:24 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: hugh@veritas.com
Cc: phillips@arcor.de, akpm@digeo.com, hch@infradead.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Avoid vmtruncate/mmap-page-fault race
Message-ID: <20030529151424.GA1397@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20030523114202.C5383@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030523114202.C5383@us.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 11:42:02AM -0700, Paul E. McKenney wrote:
> On Fri, May 23, 2003 at 06:47:31PM +0100, Hugh Dickins wrote:
> > On Fri, 23 May 2003, Daniel Phillips wrote:
> > > On Friday 23 May 2003 18:21, Hugh Dickins wrote:
> > > > Sorry, I miss the point of this patch entirely.  At the moment it just
> > > > looks like an unattractive rearrangement - the code churn akpm advised
> > > > against - with no bearing on that vmtruncate race.  Please correct me.
> > > 
> > > This is all about supporting cross-host mmap (nice trick, huh?).  Yes, 
> > > somebody should post a detailed rfc on that subject.
> > 
> > Ah, thanks - translated into terms that I can understand, so that
> > some ->nopage() not yet in the tree could do something after the
> > install_new_page() returns.  Hmm.  Can we be sure it's appropriate
> > for install_new_page to drop mm->page_table_lock before it returns?
> 
> Exactly -- allows a ->nopage() to drop some lock to avoid races
> between pagefault and either vmtruncate() or invalidate_mmap_range().
> This race (from the cross-host mmap viewpoint) is described in:
> 
>     http://marc.theaimsgroup.com/?l=linux-kernel&m=105286345316249&w=2
> 
> install_new_page() has to drop mm->page_table_lock() for the same
> reason that the previous do_no_page() did.  In addition, dropping
> the lock permits a ->nopage() to invoke things like zap_page_range()
> which acquire mm->page_table_lock().

Rediffed for 2.5.70-mm1.  Some added lines of code due to following
the "#ifndef LINUX_2_2" in the sound system.  The patch in the following
email removes these #ifdefs on the off-chance that they are a
holdover rather than the sound system's way of maintaining
a single code base across all versions of Linux or some such.

					Thanx, Paul


diff -urN -x dontdiff linux-2.5.70-mm1/arch/ia64/ia32/binfmt_elf32.c linux-2.5.70-mm1.install_new_page/arch/ia64/ia32/binfmt_elf32.c
--- linux-2.5.70-mm1/arch/ia64/ia32/binfmt_elf32.c	2003-05-26 18:00:58.000000000 -0700
+++ linux-2.5.70-mm1.install_new_page/arch/ia64/ia32/binfmt_elf32.c	2003-05-28 20:17:42.000000000 -0700
@@ -56,13 +56,13 @@
 extern struct page *ia32_shared_page[];
 extern unsigned long *ia32_gdt;
 
-struct page *
-ia32_install_shared_page (struct vm_area_struct *vma, unsigned long address, int no_share)
+int
+ia32_install_shared_page (struct mm_struct *mm, struct vm_area_struct *vma, unsigned long address, int write_access, pmd_t *pmd)
 {
 	struct page *pg = ia32_shared_page[(address - vma->vm_start)/PAGE_SIZE];
 
 	get_page(pg);
-	return pg;
+	return install_new_page(mm, vma, address, write_access, pmd, pg);
 }
 
 static struct vm_operations_struct ia32_shared_page_vm_ops = {
diff -urN -x dontdiff linux-2.5.70-mm1/arch/sparc64/mm/hugetlbpage.c linux-2.5.70-mm1.install_new_page/arch/sparc64/mm/hugetlbpage.c
--- linux-2.5.70-mm1/arch/sparc64/mm/hugetlbpage.c	2003-05-26 18:00:42.000000000 -0700
+++ linux-2.5.70-mm1.install_new_page/arch/sparc64/mm/hugetlbpage.c	2003-05-28 20:17:42.000000000 -0700
@@ -633,11 +633,11 @@
 	return (int) htlbzone_pages;
 }
 
-static struct page *
-hugetlb_nopage(struct vm_area_struct *vma, unsigned long address, int unused)
+static int
+hugetlb_nopage(struct mm_struct * mm, struct vm_area_struct *vma, unsigned long address, int write_access, pmd_t * pmd)
 {
 	BUG();
-	return NULL;
+	return VM_FAULT_SIGBUS;
 }
 
 static struct vm_operations_struct hugetlb_vm_ops = {
diff -urN -x dontdiff linux-2.5.70-mm1/drivers/char/agp/alpha-agp.c linux-2.5.70-mm1.install_new_page/drivers/char/agp/alpha-agp.c
--- linux-2.5.70-mm1/drivers/char/agp/alpha-agp.c	2003-05-26 18:00:42.000000000 -0700
+++ linux-2.5.70-mm1.install_new_page/drivers/char/agp/alpha-agp.c	2003-05-28 20:37:38.000000000 -0700
@@ -11,9 +11,9 @@
 
 #include "agp.h"
 
-static struct page *alpha_core_agp_vm_nopage(struct vm_area_struct *vma,
-					     unsigned long address,
-					     int write_access)
+static int alpha_core_agp_vm_nopage(struct mm_struct *mm, struct vm_area_struct *vma,
+				    unsigned long address,
+				    int write_access, pmd_t pmd)
 {
 	alpha_agp_info *agp = agp_bridge->dev_private_data;
 	dma_addr_t dma_addr;
@@ -23,14 +23,14 @@
 	dma_addr = address - vma->vm_start + agp->aperture.bus_base;
 	pa = agp->ops->translate(agp, dma_addr);
 
-	if (pa == (unsigned long)-EINVAL) return NULL;	/* no translation */
+	if (pa == (unsigned long)-EINVAL) return VM_FAULT_SIGBUS; /* no translation */
 	
 	/*
 	 * Get the page, inc the use count, and return it
 	 */
 	page = virt_to_page(__va(pa));
 	get_page(page);
-	return page;
+	return install_new_page(mm, vma, address, write_access, pmd, page);
 }
 
 static struct aper_size_info_fixed alpha_core_agp_sizes[] =
diff -urN -x dontdiff linux-2.5.70-mm1/drivers/char/drm/drmP.h linux-2.5.70-mm1.install_new_page/drivers/char/drm/drmP.h
--- linux-2.5.70-mm1/drivers/char/drm/drmP.h	2003-05-26 18:00:45.000000000 -0700
+++ linux-2.5.70-mm1.install_new_page/drivers/char/drm/drmP.h	2003-05-28 20:55:40.000000000 -0700
@@ -620,18 +620,17 @@
 extern int	     DRM(fasync)(int fd, struct file *filp, int on);
 
 				/* Mapping support (drm_vm.h) */
-extern struct page *DRM(vm_nopage)(struct vm_area_struct *vma,
-				   unsigned long address,
-				   int write_access);
-extern struct page *DRM(vm_shm_nopage)(struct vm_area_struct *vma,
-				       unsigned long address,
-				       int write_access);
-extern struct page *DRM(vm_dma_nopage)(struct vm_area_struct *vma,
-				       unsigned long address,
-				       int write_access);
-extern struct page *DRM(vm_sg_nopage)(struct vm_area_struct *vma,
-				      unsigned long address,
-				      int write_access);
+extern int DRM(vm_nopage)(struct mm_struct *mm, struct vm_area_struct *vma,
+			  unsigned long address, int write_access, pmd_t *pmd);
+extern int DRM(vm_shm_nopage)(struct mm_struct *mm, struct vm_area_struct *vma,
+			      unsigned long address,
+			      int write_access, pmd_t *pmd);
+extern int DRM(vm_dma_nopage)(struct mm_struct *mm, struct vm_area_struct *vma,
+			      unsigned long address,
+			      int write_access, pmd_t *pmd);
+extern int DRM(vm_sg_nopage)(struct mm_struct *mm, struct vm_area_struct *vma,
+			     unsigned long address,
+			     int write_access, pmd_t *pmd);
 extern void	     DRM(vm_open)(struct vm_area_struct *vma);
 extern void	     DRM(vm_close)(struct vm_area_struct *vma);
 extern void	     DRM(vm_shm_close)(struct vm_area_struct *vma);
diff -urN -x dontdiff linux-2.5.70-mm1/drivers/char/drm/drm_vm.h linux-2.5.70-mm1.install_new_page/drivers/char/drm/drm_vm.h
--- linux-2.5.70-mm1/drivers/char/drm/drm_vm.h	2003-05-26 18:01:02.000000000 -0700
+++ linux-2.5.70-mm1.install_new_page/drivers/char/drm/drm_vm.h	2003-05-28 20:57:19.000000000 -0700
@@ -55,9 +55,9 @@
 	.close  = DRM(vm_close),
 };
 
-struct page *DRM(vm_nopage)(struct vm_area_struct *vma,
-			    unsigned long address,
-			    int write_access)
+int DRM(vm_nopage)(struct mm_struct *mm, struct vm_area_struct *vma,
+		   unsigned long address,
+		   int write_access, pmd_t *pmd)
 {
 #if __REALLY_HAVE_AGP
 	drm_file_t *priv  = vma->vm_file->private_data;
@@ -114,35 +114,35 @@
 			  baddr, __va(agpmem->memory->memory[offset]), offset,
 			  atomic_read(&page->count));
 
-		return page;
+		return install_new_page(mm, vma, address, write_access, pmd, page);
         }
 vm_nopage_error:
 #endif /* __REALLY_HAVE_AGP */
 
-	return NOPAGE_SIGBUS;		/* Disallow mremap */
+	return VM_FAULT_SIGBUS;		/* Disallow mremap */
 }
 
-struct page *DRM(vm_shm_nopage)(struct vm_area_struct *vma,
-				unsigned long address,
-				int write_access)
+int DRM(vm_shm_nopage)(struct mm_struct *mm, struct vm_area_struct *vma,
+		       unsigned long address,
+		       int write_access, pmd_t *pmd)
 {
 	drm_map_t	 *map	 = (drm_map_t *)vma->vm_private_data;
 	unsigned long	 offset;
 	unsigned long	 i;
 	struct page	 *page;
 
-	if (address > vma->vm_end) return NOPAGE_SIGBUS; /* Disallow mremap */
-	if (!map)    		   return NOPAGE_OOM;  /* Nothing allocated */
+	if (address > vma->vm_end) return VM_FAULT_SIGBUS; /* Disallow mremap */
+	if (!map)    		   return VM_FAULT_OOM;  /* Nothing allocated */
 
 	offset	 = address - vma->vm_start;
 	i = (unsigned long)map->handle + offset;
 	page = vmalloc_to_page((void *)i);
 	if (!page)
-		return NOPAGE_OOM;
+		return VM_FAULT_OOM;
 	get_page(page);
 
 	DRM_DEBUG("shm_nopage 0x%lx\n", address);
-	return page;
+	return install_new_page(mm, vma, address, write_access, pmd, page);
 }
 
 /* Special close routine which deletes map information if we are the last
@@ -221,9 +221,9 @@
 	up(&dev->struct_sem);
 }
 
-struct page *DRM(vm_dma_nopage)(struct vm_area_struct *vma,
-				unsigned long address,
-				int write_access)
+int DRM(vm_dma_nopage)(struct mm_struct *mm, struct vm_area_struct *vma,
+		       unsigned long address,
+		       int write_access, pmd_t *pmd)
 {
 	drm_file_t	 *priv	 = vma->vm_file->private_data;
 	drm_device_t	 *dev	 = priv->dev;
@@ -232,9 +232,9 @@
 	unsigned long	 page_nr;
 	struct page	 *page;
 
-	if (!dma)		   return NOPAGE_SIGBUS; /* Error */
-	if (address > vma->vm_end) return NOPAGE_SIGBUS; /* Disallow mremap */
-	if (!dma->pagelist)	   return NOPAGE_OOM ; /* Nothing allocated */
+	if (!dma)		   return VM_FAULT_SIGBUS; /* Error */
+	if (address > vma->vm_end) return VM_FAULT_SIGBUS; /* Disallow mremap */
+	if (!dma->pagelist)	   return VM_FAULT_OOM ; /* Nothing allocated */
 
 	offset	 = address - vma->vm_start; /* vm_[pg]off[set] should be 0 */
 	page_nr  = offset >> PAGE_SHIFT;
@@ -244,12 +244,12 @@
 	get_page(page);
 
 	DRM_DEBUG("dma_nopage 0x%lx (page %lu)\n", address, page_nr);
-	return page;
+	return install_new_page(mm, vma, address, write_access, pmd, page);
 }
 
-struct page *DRM(vm_sg_nopage)(struct vm_area_struct *vma,
-			       unsigned long address,
-			       int write_access)
+int DRM(vm_sg_nopage)(struct mm_struct *mm, struct vm_area_struct *vma,
+		      unsigned long address,
+		      int write_access, pmd_t *pmd)
 {
 	drm_map_t        *map    = (drm_map_t *)vma->vm_private_data;
 	drm_file_t *priv = vma->vm_file->private_data;
@@ -260,9 +260,9 @@
 	unsigned long page_offset;
 	struct page *page;
 
-	if (!entry)                return NOPAGE_SIGBUS; /* Error */
-	if (address > vma->vm_end) return NOPAGE_SIGBUS; /* Disallow mremap */
-	if (!entry->pagelist)      return NOPAGE_OOM ;  /* Nothing allocated */
+	if (!entry)                return VM_FAULT_SIGBUS; /* Error */
+	if (address > vma->vm_end) return VM_FAULT_SIGBUS; /* Disallow mremap */
+	if (!entry->pagelist)      return VM_FAULT_OOM ; /* Nothing allocated */
 
 
 	offset = address - vma->vm_start;
@@ -271,7 +271,7 @@
 	page = entry->pagelist[page_offset];
 	get_page(page);
 
-	return page;
+	return install_new_page(mm, vma, address, write_access, pmd, page);
 }
 
 void DRM(vm_open)(struct vm_area_struct *vma)
diff -urN -x dontdiff linux-2.5.70-mm1/drivers/ieee1394/dma.c linux-2.5.70-mm1.install_new_page/drivers/ieee1394/dma.c
--- linux-2.5.70-mm1/drivers/ieee1394/dma.c	2003-05-26 18:00:40.000000000 -0700
+++ linux-2.5.70-mm1.install_new_page/drivers/ieee1394/dma.c	2003-05-28 20:39:31.000000000 -0700
@@ -184,28 +184,27 @@
 
 /* nopage() handler for mmap access */
 
-static struct page*
-dma_region_pagefault(struct vm_area_struct *area, unsigned long address, int write_access)
+static int
+dma_region_pagefault(struct mm_struct *mm, struct vm_area_struct *area, unsigned long address, int write_access, pmd_t *pmd)
 {
 	unsigned long offset;
 	unsigned long kernel_virt_addr;
-	struct page *ret = NOPAGE_SIGBUS;
+	struct page *page;
 
 	struct dma_region *dma = (struct dma_region*) area->vm_private_data;
 
 	if(!dma->kvirt)
-		goto out;
+		return VM_FAULT_SIGBUS;
 
 	if( (address < (unsigned long) area->vm_start) ||
 	    (address > (unsigned long) area->vm_start + (PAGE_SIZE * dma->n_pages)) )
-		goto out;
+		return VM_FAULT_SIGBUS;
 
 	offset = address - area->vm_start;
 	kernel_virt_addr = (unsigned long) dma->kvirt + offset;
-	ret = vmalloc_to_page((void*) kernel_virt_addr);
-	get_page(ret);
-out:
-	return ret;
+	page = vmalloc_to_page((void*) kernel_virt_addr);
+	get_page(page);
+	return install_new_page(mm, vma, address, write_access, pmd, page);
 }
 
 static struct vm_operations_struct dma_region_vm_ops = {
diff -urN -x dontdiff linux-2.5.70-mm1/drivers/media/video/video-buf.c linux-2.5.70-mm1.install_new_page/drivers/media/video/video-buf.c
--- linux-2.5.70-mm1/drivers/media/video/video-buf.c	2003-05-26 18:00:40.000000000 -0700
+++ linux-2.5.70-mm1.install_new_page/drivers/media/video/video-buf.c	2003-05-28 20:17:42.000000000 -0700
@@ -979,21 +979,21 @@
  * now ...).  Bounce buffers don't work very well for the data rates
  * video capture has.
  */
-static struct page*
-videobuf_vm_nopage(struct vm_area_struct *vma, unsigned long vaddr,
-		  int write_access)
+static int
+videobuf_vm_nopage(struct mm_struct *mm, struct vm_area_struct *vma,
+		   unsigned long vaddr, int write_access, pmd_t pmd)
 {
 	struct page *page;
 
 	dprintk(3,"nopage: fault @ %08lx [vma %08lx-%08lx]\n",
 		vaddr,vma->vm_start,vma->vm_end);
         if (vaddr > vma->vm_end)
-		return NOPAGE_SIGBUS;
+		return VM_FAULT_SIGBUS;
 	page = alloc_page(GFP_USER);
 	if (!page)
-		return NOPAGE_OOM;
+		return VM_FAULT_OOM;
 	clear_user_page(page_address(page), vaddr, page);
-	return page;
+	return install_new_page(mm, vma, vaddr, write_access, pmd, page);
 }
 
 static struct vm_operations_struct videobuf_vm_ops =
diff -urN -x dontdiff linux-2.5.70-mm1/drivers/scsi/sg.c linux-2.5.70-mm1.install_new_page/drivers/scsi/sg.c
--- linux-2.5.70-mm1/drivers/scsi/sg.c	2003-05-28 20:16:04.000000000 -0700
+++ linux-2.5.70-mm1.install_new_page/drivers/scsi/sg.c	2003-05-28 20:39:59.000000000 -0700
@@ -1121,21 +1121,21 @@
 	}
 }
 
-static struct page *
-sg_vma_nopage(struct vm_area_struct *vma, unsigned long addr, int unused)
+static int
+sg_vma_nopage(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, int write_access, pmd_t *pmd)
 {
 	Sg_fd *sfp;
-	struct page *page = NOPAGE_SIGBUS;
+	struct page *page = VM_FAULT_SIGBUS;
 	void *page_ptr = NULL;
 	unsigned long offset;
 	Sg_scatter_hold *rsv_schp;
 
 	if ((NULL == vma) || (!(sfp = (Sg_fd *) vma->vm_private_data)))
-		return page;
+		return install_new_page(mm, vma, addr, write_access, pmd, page);
 	rsv_schp = &sfp->reserve;
 	offset = addr - vma->vm_start;
 	if (offset >= rsv_schp->bufflen)
-		return page;
+		return install_new_page(mm, vma, addr, write_access, pmd, page);
 	SCSI_LOG_TIMEOUT(3, printk("sg_vma_nopage: offset=%lu, scatg=%d\n",
 				   offset, rsv_schp->k_use_sg));
 	if (rsv_schp->k_use_sg) {	/* reserve buffer is a scatter gather list */
@@ -1162,7 +1162,7 @@
 		page = virt_to_page(page_ptr);
 		get_page(page);	/* increment page count */
 	}
-	return page;
+	return install_new_page(mm, vma, addr, write_access, pmd, page);
 }
 
 static struct vm_operations_struct sg_mmap_vm_ops = {
diff -urN -x dontdiff linux-2.5.70-mm1/drivers/sgi/char/graphics.c linux-2.5.70-mm1.install_new_page/drivers/sgi/char/graphics.c
--- linux-2.5.70-mm1/drivers/sgi/char/graphics.c	2003-05-26 18:00:40.000000000 -0700
+++ linux-2.5.70-mm1.install_new_page/drivers/sgi/char/graphics.c	2003-05-28 20:17:42.000000000 -0700
@@ -211,9 +211,9 @@
 /* 
  * This is the core of the direct rendering engine.
  */
-struct page *
-sgi_graphics_nopage (struct vm_area_struct *vma, unsigned long address, int
-		     no_share)
+struct int
+sgi_graphics_nopage (struct mm_struct *mm, struct vm_area_struct *vma,
+		     unsigned long address, int write_access, pmd_t *pmdpf)
 {
 	pgd_t *pgd; pmd_t *pmd; pte_t *pte; 
 	int board = GRAPHICS_CARD (vma->vm_dentry->d_inode->i_rdev);
@@ -249,7 +249,7 @@
 	pte = pte_kmap_offset(pmd, address);
 	page = pte_page(*pte);
 	pte_kunmap(pte);
-	return page;
+	return install_new_page(mm, vma, address, write_access, pmdpf, page);
 }
 
 /*
diff -urN -x dontdiff linux-2.5.70-mm1/fs/ncpfs/mmap.c linux-2.5.70-mm1.install_new_page/fs/ncpfs/mmap.c
--- linux-2.5.70-mm1/fs/ncpfs/mmap.c	2003-05-26 18:00:43.000000000 -0700
+++ linux-2.5.70-mm1.install_new_page/fs/ncpfs/mmap.c	2003-05-28 20:17:42.000000000 -0700
@@ -25,8 +25,8 @@
 /*
  * Fill in the supplied page for mmap
  */
-static struct page* ncp_file_mmap_nopage(struct vm_area_struct *area,
-				     unsigned long address, int write_access)
+static int ncp_file_mmap_nopage(struct mm_struct *mm, struct vm_area_struct *area,
+				unsigned long address, int write_access, pmd_t *pmd)
 {
 	struct file *file = area->vm_file;
 	struct dentry *dentry = file->f_dentry;
@@ -85,7 +85,7 @@
 		memset(pg_addr + already_read, 0, PAGE_SIZE - already_read);
 	flush_dcache_page(page);
 	kunmap(page);
-	return page;
+	return install_new_page(mm, area, address, write_access, pmd, page);
 }
 
 static struct vm_operations_struct ncp_file_mmap =
diff -urN -x dontdiff linux-2.5.70-mm1/include/linux/mm.h linux-2.5.70-mm1.install_new_page/include/linux/mm.h
--- linux-2.5.70-mm1/include/linux/mm.h	2003-05-28 20:16:04.000000000 -0700
+++ linux-2.5.70-mm1.install_new_page/include/linux/mm.h	2003-05-28 20:17:42.000000000 -0700
@@ -142,7 +142,7 @@
 struct vm_operations_struct {
 	void (*open)(struct vm_area_struct * area);
 	void (*close)(struct vm_area_struct * area);
-	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int unused);
+	int (*nopage)(struct mm_struct * mm, struct vm_area_struct * area, unsigned long address, int write_access, pmd_t *pmd);
 	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
 };
 
@@ -380,12 +380,6 @@
 }
 
 /*
- * Error return values for the *_nopage functions
- */
-#define NOPAGE_SIGBUS	(NULL)
-#define NOPAGE_OOM	((struct page *) (-1))
-
-/*
  * Different kinds of faults, as returned by handle_mm_fault().
  * Used to decide whether a process gets delivered SIGBUS or
  * just gets major/minor fault counters bumped up.
@@ -402,8 +396,8 @@
 
 extern void show_free_areas(void);
 
-struct page *shmem_nopage(struct vm_area_struct * vma,
-			unsigned long address, int unused);
+int shmem_nopage(struct mm_struct * mm, struct vm_area_struct * vma,
+		 unsigned long address, int write_access, pmd_t * pmd);
 struct file *shmem_file_setup(char * name, loff_t size, unsigned long flags);
 void shmem_lock(struct file * file, int lock);
 int shmem_zero_setup(struct vm_area_struct *);
@@ -421,6 +415,7 @@
 int zeromap_page_range(struct vm_area_struct *vma, unsigned long from,
 			unsigned long size, pgprot_t prot);
 
+extern int install_new_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long address, int write_access, pmd_t *pmd, struct page * new_page);
 extern void invalidate_mmap_range(struct address_space *mapping,
 				  loff_t const holebegin,
 				  loff_t const holelen);
@@ -559,7 +554,7 @@
 extern void truncate_inode_pages(struct address_space *, loff_t);
 
 /* generic vm_area_ops exported for stackable file systems */
-extern struct page *filemap_nopage(struct vm_area_struct *, unsigned long, int);
+int filemap_nopage(struct mm_struct *, struct vm_area_struct *, unsigned long, int, pmd_t *);
 
 /* mm/page-writeback.c */
 int write_one_page(struct page *page, int wait);
diff -urN -x dontdiff linux-2.5.70-mm1/kernel/ksyms.c linux-2.5.70-mm1.install_new_page/kernel/ksyms.c
--- linux-2.5.70-mm1/kernel/ksyms.c	2003-05-28 20:16:04.000000000 -0700
+++ linux-2.5.70-mm1.install_new_page/kernel/ksyms.c	2003-05-28 20:17:42.000000000 -0700
@@ -116,6 +116,7 @@
 EXPORT_SYMBOL(max_mapnr);
 #endif
 EXPORT_SYMBOL(high_memory);
+EXPORT_SYMBOL(install_new_page);
 EXPORT_SYMBOL(invalidate_mmap_range);
 EXPORT_SYMBOL(vmtruncate);
 EXPORT_SYMBOL(find_vma);
diff -urN -x dontdiff linux-2.5.70-mm1/mm/filemap.c linux-2.5.70-mm1.install_new_page/mm/filemap.c
--- linux-2.5.70-mm1/mm/filemap.c	2003-05-28 20:16:04.000000000 -0700
+++ linux-2.5.70-mm1.install_new_page/mm/filemap.c	2003-05-28 20:17:42.000000000 -0700
@@ -1013,7 +1013,7 @@
  * it in the page cache, and handles the special cases reasonably without
  * having a lot of duplicated code.
  */
-struct page * filemap_nopage(struct vm_area_struct * area, unsigned long address, int unused)
+int filemap_nopage(struct mm_struct * mm, struct vm_area_struct * area, unsigned long address, int write_access, pmd_t * pmd)
 {
 	int error;
 	struct file *file = area->vm_file;
@@ -1034,7 +1034,7 @@
 	 */
 	size = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	if ((pgoff >= size) && (area->vm_mm == current->mm))
-		return NULL;
+		return VM_FAULT_SIGBUS;
 
 	/*
 	 * The "size" of the file, as far as mmap is concerned, isn't bigger
@@ -1088,7 +1088,7 @@
 	 * Found the page and have a reference on it.
 	 */
 	mark_page_accessed(page);
-	return page;
+	return install_new_page(mm, area, address, write_access, pmd, page);
 
 no_cached_page:
 	/*
@@ -1111,8 +1111,8 @@
 	 * to schedule I/O.
 	 */
 	if (error == -ENOMEM)
-		return NOPAGE_OOM;
-	return NULL;
+		return VM_FAULT_OOM;
+	return VM_FAULT_SIGBUS;
 
 page_not_uptodate:
 	inc_page_state(pgmajfault);
@@ -1169,7 +1169,7 @@
 	 * mm layer so, possibly freeing the page cache page first.
 	 */
 	page_cache_release(page);
-	return NULL;
+	return VM_FAULT_SIGBUS;
 }
 
 static struct page * filemap_getpage(struct file *file, unsigned long pgoff,
diff -urN -x dontdiff linux-2.5.70-mm1/mm/memory.c linux-2.5.70-mm1.install_new_page/mm/memory.c
--- linux-2.5.70-mm1/mm/memory.c	2003-05-28 20:16:04.000000000 -0700
+++ linux-2.5.70-mm1.install_new_page/mm/memory.c	2003-05-28 20:43:16.000000000 -0700
@@ -1374,39 +1374,33 @@
 }
 
 /*
- * do_no_page() tries to create a new page mapping. It aggressively
- * tries to share with existing pages, but makes a separate copy if
- * the "write_access" parameter is true in order to avoid the next
- * page fault.
- *
- * As this is called only for pages that do not currently exist, we
- * do not need to flush old virtual caches or the TLB.
- *
- * This is called with the MM semaphore held and the page table
- * spinlock held. Exit with the spinlock released.
+ * do_no_page() invokes do_anonymous_page() or ->nopage, as appropriate.
+ * Called w/ MM sema and page_table_lock held, the latter released before exit.
  */
-static int
+static inline int
 do_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	unsigned long address, int write_access, pte_t *page_table, pmd_t *pmd)
 {
-	struct page * new_page;
-	pte_t entry;
-	struct pte_chain *pte_chain;
-	int ret;
-
 	if (!vma->vm_ops || !vma->vm_ops->nopage)
-		return do_anonymous_page(mm, vma, page_table,
-					pmd, write_access, address);
+		return do_anonymous_page(mm, vma, page_table, pmd, write_access, address);
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
+	return vma->vm_ops->nopage(mm, vma, address & PAGE_MASK, write_access, pmd);
+}
 
-	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, 0);
-
-	/* no page was available -- either SIGBUS or OOM */
-	if (new_page == NOPAGE_SIGBUS)
-		return VM_FAULT_SIGBUS;
-	if (new_page == NOPAGE_OOM)
-		return VM_FAULT_OOM;
+/*
+ * install_new_page - tries to create a new page mapping.
+ * install_new_page() tries to share w/existing pages, but makes separate
+ * copy if "write_access" is true in order to avoid the next page fault.
+ * As this is called only for pages that do not currently exist, we
+ * do not need to flush old virtual caches or the TLB.
+ */
+int
+install_new_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long address, int write_access, pmd_t *pmd, struct page * new_page)
+{
+	pte_t entry, *page_table;
+	struct pte_chain *pte_chain;
+	int ret;
 
 	pte_chain = pte_chain_alloc(GFP_KERNEL);
 	if (!pte_chain)
diff -urN -x dontdiff linux-2.5.70-mm1/mm/shmem.c linux-2.5.70-mm1.install_new_page/mm/shmem.c
--- linux-2.5.70-mm1/mm/shmem.c	2003-05-26 18:00:39.000000000 -0700
+++ linux-2.5.70-mm1.install_new_page/mm/shmem.c	2003-05-28 20:17:42.000000000 -0700
@@ -936,7 +936,7 @@
 	return error;
 }
 
-struct page *shmem_nopage(struct vm_area_struct *vma, unsigned long address, int unused)
+int shmem_nopage(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long address, int write_access, pmd_t *pmd)
 {
 	struct inode *inode = vma->vm_file->f_dentry->d_inode;
 	struct page *page = NULL;
@@ -949,10 +949,10 @@
 
 	error = shmem_getpage(inode, idx, &page, SGP_CACHE);
 	if (error)
-		return (error == -ENOMEM)? NOPAGE_OOM: NOPAGE_SIGBUS;
+		return (error == -ENOMEM)? VM_FAULT_OOM: VM_FAULT_SIGBUS;
 
 	mark_page_accessed(page);
-	return page;
+	return install_new_page(mm, vma, address, write_access, pmd, page);
 }
 
 static int shmem_populate(struct vm_area_struct *vma,
diff -urN -x dontdiff linux-2.5.70-mm1/sound/core/pcm_native.c linux-2.5.70-mm1.install_new_page/sound/core/pcm_native.c
--- linux-2.5.70-mm1/sound/core/pcm_native.c	2003-05-26 18:00:37.000000000 -0700
+++ linux-2.5.70-mm1.install_new_page/sound/core/pcm_native.c	2003-05-28 21:39:45.000000000 -0700
@@ -60,6 +60,11 @@
 static int snd_pcm_hw_refine_old_user(snd_pcm_substream_t * substream, struct sndrv_pcm_hw_params_old * _oparams);
 static int snd_pcm_hw_params_old_user(snd_pcm_substream_t * substream, struct sndrv_pcm_hw_params_old * _oparams);
 
+#ifndef LINUX_2_2
+#define NOPAGE_OOM VM_FAULT_OOM
+#define NOPAGE_SIGBUS VM_FAULT_SIGBUS
+#endif
+
 /*
  *
  */
@@ -2693,7 +2698,7 @@
 #endif
 
 #ifndef LINUX_2_2
-static struct page * snd_pcm_mmap_status_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
+static int snd_pcm_mmap_status_nopage(struct mm_struct *mm, struct vm_area_struct *area, unsigned long address, int write_access, pmd_t *pmd)
 #else
 static unsigned long snd_pcm_mmap_status_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
 #endif
@@ -2708,7 +2713,7 @@
 	page = virt_to_page(runtime->status);
 	get_page(page);
 #ifndef LINUX_2_2
-	return page;
+	return install_new_page(mm, area, address, write_access, pmd, page);
 #else
 	return page_address(page);
 #endif
@@ -2747,7 +2752,7 @@
 }
 
 #ifndef LINUX_2_2
-static struct page * snd_pcm_mmap_control_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
+static int snd_pcm_mmap_control_nopage(struct mm_struct *mm, struct vm_area_struct *area, unsigned long address, int write_access, pmd_t *pmd)
 #else
 static unsigned long snd_pcm_mmap_control_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
 #endif
@@ -2762,7 +2767,7 @@
 	page = virt_to_page(runtime->control);
 	get_page(page);
 #ifndef LINUX_2_2
-	return page;
+	return install_new_page(mm, area, address, write_access, pmd, page);
 #else
 	return page_address(page);
 #endif
@@ -2813,7 +2818,7 @@
 }
 
 #ifndef LINUX_2_2
-static struct page * snd_pcm_mmap_data_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
+static int snd_pcm_mmap_data_nopage(struct mm_struct *mm, struct vm_area_struct *area, unsigned long address, int write_access, pmd_t *pmd)
 #else
 static unsigned long snd_pcm_mmap_data_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
 #endif
@@ -2848,7 +2853,7 @@
 	}
 	get_page(page);
 #ifndef LINUX_2_2
-	return page;
+	return install_new_page(mm, area, address, write_access, pmd, page);
 #else
 	return page_address(page);
 #endif
diff -urN -x dontdiff linux-2.5.70-mm1/sound/oss/emu10k1/audio.c linux-2.5.70-mm1.install_new_page/sound/oss/emu10k1/audio.c
--- linux-2.5.70-mm1/sound/oss/emu10k1/audio.c	2003-05-26 18:00:23.000000000 -0700
+++ linux-2.5.70-mm1.install_new_page/sound/oss/emu10k1/audio.c	2003-05-28 20:17:42.000000000 -0700
@@ -970,7 +970,7 @@
 	return 0;
 }
 
-static struct page *emu10k1_mm_nopage (struct vm_area_struct * vma, unsigned long address, int write_access)
+static int emu10k1_mm_nopage (struct mm_struct * mm, struct vm_area_struct * vma, unsigned long address, int write_access, pmd_t * pmd)
 {
 	struct emu10k1_wavedevice *wave_dev = vma->vm_private_data;
 	struct woinst *woinst = wave_dev->woinst;
@@ -983,8 +983,8 @@
 	DPD(3, "addr: %#lx\n", address);
 
 	if (address > vma->vm_end) {
-		DPF(1, "EXIT, returning NOPAGE_SIGBUS\n");
-		return NOPAGE_SIGBUS; /* Disallow mremap */
+		DPF(1, "EXIT, returning VM_FAULT_SIGBUS\n");
+		return VM_FAULT_SIGBUS; /* Disallow mremap */
 	}
 
 	pgoff = vma->vm_pgoff + ((address - vma->vm_start) >> PAGE_SHIFT);
@@ -1013,7 +1013,7 @@
 	get_page (dmapage);
 
 	DPD(3, "page: %#lx\n", (unsigned long) dmapage);
-	return dmapage;
+	return install_new_page(mm, vma, address, write_access, pmd, dmapage);
 }
 
 struct vm_operations_struct emu10k1_mm_ops = {
diff -urN -x dontdiff linux-2.5.70-mm1/sound/oss/via82cxxx_audio.c linux-2.5.70-mm1.install_new_page/sound/oss/via82cxxx_audio.c
--- linux-2.5.70-mm1/sound/oss/via82cxxx_audio.c	2003-05-26 18:00:27.000000000 -0700
+++ linux-2.5.70-mm1.install_new_page/sound/oss/via82cxxx_audio.c	2003-05-28 20:17:44.000000000 -0700
@@ -1846,8 +1846,8 @@
 }
 
 
-static struct page * via_mm_nopage (struct vm_area_struct * vma,
-				    unsigned long address, int write_access)
+static int via_mm_nopage (struct mm_struct *mm, struct vm_area_struct * vma,
+			  unsigned long address, int write_access, pmd_t *pmd)
 {
 	struct via_info *card = vma->vm_private_data;
 	struct via_channel *chan = &card->ch_out;
@@ -1863,12 +1863,12 @@
 		 write_access);
 
         if (address > vma->vm_end) {
-		DPRINTK ("EXIT, returning NOPAGE_SIGBUS\n");
-		return NOPAGE_SIGBUS; /* Disallow mremap */
+		DPRINTK ("EXIT, returning VM_FAULT_SIGBUS\n");
+		return VM_FAULT_SIGBUS; /* Disallow mremap */
 	}
         if (!card) {
-		DPRINTK ("EXIT, returning NOPAGE_OOM\n");
-		return NOPAGE_OOM;	/* Nothing allocated */
+		DPRINTK ("EXIT, returning VM_FAULT_OOM\n");
+		return VM_FAULT_OOM;	/* Nothing allocated */
 	}
 
 	pgoff = vma->vm_pgoff + ((address - vma->vm_start) >> PAGE_SHIFT);
@@ -1895,10 +1895,10 @@
 	assert ((((unsigned long)chan->pgtbl[pgoff].cpuaddr) % PAGE_SIZE) == 0);
 
 	dmapage = virt_to_page (chan->pgtbl[pgoff].cpuaddr);
-	DPRINTK ("EXIT, returning page %p for cpuaddr %lXh\n",
+	DPRINTK ("EXIT, installing page %p for cpuaddr %lXh\n",
 		 dmapage, (unsigned long) chan->pgtbl[pgoff].cpuaddr);
 	get_page (dmapage);
-	return dmapage;
+	return install_new_page(mm, vma, address, write_access, pmd, dmapage);
 }
 
 
