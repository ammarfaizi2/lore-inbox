Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTELVJY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbTELVJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:09:24 -0400
Received: from netline-be1.netline.ch ([195.141.226.32]:42255 "EHLO
	netline-be1.netline.ch") by vger.kernel.org with ESMTP
	id S262714AbTELVJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:09:06 -0400
Subject: Re: Improved DRM support for cant_use_aperture platforms
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: davidm@hpl.hp.com
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
In-Reply-To: <16064.453.497373.127754@napali.hpl.hp.com>
References: <200305101009.h4AA9GZi012265@napali.hpl.hp.com>
	 <1052653415.12338.159.camel@thor>
	 <16062.37308.611438.5934@napali.hpl.hp.com>
	 <20030511195543.GA15528@suse.de> <1052690133.10752.176.camel@thor>
	 <16063.60859.712283.537570@napali.hpl.hp.com>
	 <1052768911.10752.268.camel@thor>
	 <16064.453.497373.127754@napali.hpl.hp.com>
Content-Type: multipart/mixed; boundary="=-DUNeIFSd+/Nx3+W7gfby"
Organization: Debian, XFree86
Message-Id: <1052774487.10750.294.camel@thor>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.1.99 (Preview Release)
Date: 12 May 2003 23:21:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DUNeIFSd+/Nx3+W7gfby
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

On Mon, 2003-05-12 at 22:19, David Mosberger wrote:
> >>>>> On 12 May 2003 21:48:31 +0200, Michel Dänzer <michel@daenzer.net> said:
> 
>   >> using an old kernel that doesn't have asm/agp.h yet?).
> 
>   Michel> That's it.
> 
> OK, thanks for clarifying.
> 
>   Michel> So we have to check the version before #including
>   Michel> <asm/agp.h>. Then, we can do something like
> 
>   Michel> #ifndef PAGE_AGP #define PAGE_AGP PAGE_KERNEL_NOCACHE #endif
> 
>   Michel> Or am I missing something?
> 
> Basically correct, except that the patch also needs an improved
> version of vmap(), which was introduced in 2.5.68 only (IIRC).  I'll
> update my patch so it is a no-op unless you have a kernel >= 2.5.68.

Hmm, isn't there a way to make it work with older kernels as well? For
reference, we've been using
http://www.penguinppc.org/~daenzer/DRI/drm-ioremapagp.diff by Benjamin
Herrenschmidt for a while for Apple UniNorth northbridges. I was hoping
to replace it with a cleaner solution like yours.

Anyway, after applying your second patch, things looked much better, and
the attached patch against the DRI CVS trunk builds without warnings
here.


-- 
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer

--=-DUNeIFSd+/Nx3+W7gfby
Content-Disposition: attachment; filename=drm-cant_use_aperture.diff
Content-Type: text/x-patch; name=drm-cant_use_aperture.diff; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Index: programs/Xserver/hw/xfree86/os-support/shared/drm/kernel/mga_dma.c
===================================================================
RCS file: /cvsroot/dri/xc/xc/programs/Xserver/hw/xfree86/os-support/shared/drm/kernel/mga_dma.c,v
retrieving revision 1.9
diff -p -u -r1.9 mga_dma.c
--- programs/Xserver/hw/xfree86/os-support/shared/drm/kernel/mga_dma.c	26 Apr 2003 22:28:55 -0000	1.9
+++ programs/Xserver/hw/xfree86/os-support/shared/drm/kernel/mga_dma.c	12 May 2003 20:59:24 -0000
@@ -554,9 +554,9 @@ static int mga_do_init_dma( drm_device_t
 		(drm_mga_sarea_t *)((u8 *)dev_priv->sarea->handle +
 				    init->sarea_priv_offset);
 
-	DRM_IOREMAP( dev_priv->warp );
-	DRM_IOREMAP( dev_priv->primary );
-	DRM_IOREMAP( dev_priv->buffers );
+	DRM_IOREMAP( dev_priv->warp, dev );
+	DRM_IOREMAP( dev_priv->primary, dev );
+	DRM_IOREMAP( dev_priv->buffers, dev );
 
 	if(!dev_priv->warp->handle ||
 	   !dev_priv->primary->handle ||
@@ -651,11 +651,11 @@ int mga_do_cleanup_dma( drm_device_t *de
 		drm_mga_private_t *dev_priv = dev->dev_private;
 
 		if ( dev_priv->warp != NULL )
-			DRM_IOREMAPFREE( dev_priv->warp );
+			DRM_IOREMAPFREE( dev_priv->warp, dev );
 		if ( dev_priv->primary != NULL )
-			DRM_IOREMAPFREE( dev_priv->primary );
+			DRM_IOREMAPFREE( dev_priv->primary, dev );
 		if ( dev_priv->buffers != NULL )
-			DRM_IOREMAPFREE( dev_priv->buffers );
+			DRM_IOREMAPFREE( dev_priv->buffers, dev );
 
 		if ( dev_priv->head != NULL ) {
 			mga_freelist_cleanup( dev );
Index: programs/Xserver/hw/xfree86/os-support/shared/drm/kernel/mga_drv.h
===================================================================
RCS file: /cvsroot/dri/xc/xc/programs/Xserver/hw/xfree86/os-support/shared/drm/kernel/mga_drv.h,v
retrieving revision 1.8
diff -p -u -r1.8 mga_drv.h
--- programs/Xserver/hw/xfree86/os-support/shared/drm/kernel/mga_drv.h	26 Apr 2003 23:32:00 -0000	1.8
+++ programs/Xserver/hw/xfree86/os-support/shared/drm/kernel/mga_drv.h	12 May 2003 20:59:24 -0000
@@ -226,7 +226,7 @@ do {									\
 	if ( MGA_VERBOSE ) {						\
 		DRM_INFO( "BEGIN_DMA( %d ) in %s\n",			\
 			  (n), __FUNCTION__ );				\
-		DRM_INFO( "   space=0x%x req=0x%x\n",			\
+		DRM_INFO( "   space=0x%x req=0x%Zx\n",			\
 			  dev_priv->prim.space, (n) * DMA_BLOCK_SIZE );	\
 	}								\
 	prim = dev_priv->prim.start;					\
@@ -276,7 +276,7 @@ do {									\
 #define DMA_WRITE( offset, val )					\
 do {									\
 	if ( MGA_VERBOSE ) {						\
-		DRM_INFO( "   DMA_WRITE( 0x%08x ) at 0x%04x\n",		\
+		DRM_INFO( "   DMA_WRITE( 0x%08x ) at 0x%04Zx\n",	\
 			  (u32)(val), write + (offset) * sizeof(u32) );	\
 	}								\
 	*(volatile u32 *)(prim + write + (offset) * sizeof(u32)) = val;	\
Index: programs/Xserver/hw/xfree86/os-support/shared/drm/kernel/r128_cce.c
===================================================================
RCS file: /cvsroot/dri/xc/xc/programs/Xserver/hw/xfree86/os-support/shared/drm/kernel/r128_cce.c,v
retrieving revision 1.7
diff -p -u -r1.7 r128_cce.c
--- programs/Xserver/hw/xfree86/os-support/shared/drm/kernel/r128_cce.c	26 Apr 2003 22:28:56 -0000	1.7
+++ programs/Xserver/hw/xfree86/os-support/shared/drm/kernel/r128_cce.c	12 May 2003 20:59:24 -0000
@@ -350,8 +353,8 @@ static void r128_cce_init_ring_buffer( d
 
 		R128_WRITE( R128_PM4_BUFFER_DL_RPTR_ADDR,
      			    entry->busaddr[page_ofs]);
-		DRM_DEBUG( "ring rptr: offset=0x%08x handle=0x%08lx\n",
-			   entry->busaddr[page_ofs],
+		DRM_DEBUG( "ring rptr: offset=0x%08lx handle=0x%08lx\n",
+			   (unsigned long) entry->busaddr[page_ofs],
      			   entry->handle + tmp_ofs );
 	}
 
@@ -540,9 +543,9 @@ static int r128_do_init_cce( drm_device_
 				     init->sarea_priv_offset);
 
 	if ( !dev_priv->is_pci ) {
-		DRM_IOREMAP( dev_priv->cce_ring );
-		DRM_IOREMAP( dev_priv->ring_rptr );
-		DRM_IOREMAP( dev_priv->buffers );
+		DRM_IOREMAP( dev_priv->cce_ring, dev );
+		DRM_IOREMAP( dev_priv->ring_rptr, dev );
+		DRM_IOREMAP( dev_priv->buffers, dev );
 		if(!dev_priv->cce_ring->handle ||
 		   !dev_priv->ring_rptr->handle ||
 		   !dev_priv->buffers->handle) {
@@ -625,23 +622,22 @@ int r128_do_cleanup_cce( drm_device_t *d
 	if ( dev->dev_private ) {
 		drm_r128_private_t *dev_priv = dev->dev_private;
 
-#if __REALLY_HAVE_SG
+#if __REALLY_HAVE_AGP
 		if ( !dev_priv->is_pci ) {
-#endif
 			if ( dev_priv->cce_ring != NULL )
-				DRM_IOREMAPFREE( dev_priv->cce_ring );
+				DRM_IOREMAPFREE( dev_priv->cce_ring, dev );
 			if ( dev_priv->ring_rptr != NULL )
-				DRM_IOREMAPFREE( dev_priv->ring_rptr );
+				DRM_IOREMAPFREE( dev_priv->ring_rptr, dev );
 			if ( dev_priv->buffers != NULL )
-				DRM_IOREMAPFREE( dev_priv->buffers );
-#if __REALLY_HAVE_SG
-		} else {
+				DRM_IOREMAPFREE( dev_priv->buffers, dev );
+		} else
+#endif	/* __REALLY_HAVE_AGP
+		{
 			if (!DRM(ati_pcigart_cleanup)( dev,
 						dev_priv->phys_pci_gart,
 						dev_priv->bus_pci_gart ))
 				DRM_ERROR( "failed to cleanup PCI GART!\n" );
 		}
-#endif
 
 		DRM(free)( dev->dev_private, sizeof(drm_r128_private_t),
 			   DRM_MEM_DRIVER );
Index: programs/Xserver/hw/xfree86/os-support/shared/drm/kernel/radeon_cp.c
===================================================================
RCS file: /cvsroot/dri/xc/xc/programs/Xserver/hw/xfree86/os-support/shared/drm/kernel/radeon_cp.c,v
retrieving revision 1.25
diff -p -u -r1.25 radeon_cp.c
--- programs/Xserver/hw/xfree86/os-support/shared/drm/kernel/radeon_cp.c	6 May 2003 21:10:33 -0000	1.25
+++ programs/Xserver/hw/xfree86/os-support/shared/drm/kernel/radeon_cp.c	12 May 2003 20:59:27 -0000
@@ -1152,9 +1152,9 @@ static int radeon_do_init_cp( drm_device
 				       init->sarea_priv_offset);
 
 	if ( !dev_priv->is_pci ) {
-		DRM_IOREMAP( dev_priv->cp_ring );
-		DRM_IOREMAP( dev_priv->ring_rptr );
-		DRM_IOREMAP( dev_priv->buffers );
+		DRM_IOREMAP( dev_priv->cp_ring, dev );
+		DRM_IOREMAP( dev_priv->ring_rptr, dev );
+		DRM_IOREMAP( dev_priv->buffers, dev );
 		if(!dev_priv->cp_ring->handle ||
 		   !dev_priv->ring_rptr->handle ||
 		   !dev_priv->buffers->handle) {
@@ -1277,20 +1273,21 @@ int radeon_do_cleanup_cp( drm_device_t *
 	if ( dev->dev_private ) {
 		drm_radeon_private_t *dev_priv = dev->dev_private;
 
+#if __REALLY_HAVE_AGP
 		if ( !dev_priv->is_pci ) {
 			if ( dev_priv->cp_ring != NULL )
-				DRM_IOREMAPFREE( dev_priv->cp_ring );
+				DRM_IOREMAPFREE( dev_priv->cp_ring, dev );
 			if ( dev_priv->ring_rptr != NULL )
-				DRM_IOREMAPFREE( dev_priv->ring_rptr );
+				DRM_IOREMAPFREE( dev_priv->ring_rptr, dev );
 			if ( dev_priv->buffers != NULL )
-				DRM_IOREMAPFREE( dev_priv->buffers );
-		} else {
-#if __REALLY_HAVE_SG
+				DRM_IOREMAPFREE( dev_priv->buffers, dev );
+		} else
+#endif /* __REALLY_HAVE_AGP */
+		{
 			if (!DRM(ati_pcigart_cleanup)( dev,
 						dev_priv->phys_pci_gart,
 						dev_priv->bus_pci_gart ))
 				DRM_ERROR( "failed to cleanup PCI GART!\n" );
-#endif /* __REALLY_HAVE_SG */
 		}
 
 		DRM(free)( dev->dev_private, sizeof(drm_radeon_private_t),
Index: programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drmP.h
===================================================================
RCS file: /cvsroot/dri/xc/xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drmP.h,v
retrieving revision 1.71
diff -p -u -r1.71 drmP.h
--- programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drmP.h	26 Apr 2003 21:22:07 -0000	1.71
+++ programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drmP.h	12 May 2003 20:59:27 -0000
@@ -251,16 +251,16 @@ static inline struct page * vmalloc_to_p
    if (len > DRM_PROC_LIMIT) { ret; *eof = 1; return len - offset; }
 
 				/* Mapping helper macros */
-#define DRM_IOREMAP(map)						\
-	(map)->handle = DRM(ioremap)( (map)->offset, (map)->size )
+#define DRM_IOREMAP(map, dev)							\
+	(map)->handle = DRM(ioremap)( (map)->offset, (map)->size, (dev) )
 
-#define DRM_IOREMAP_NOCACHE(map)					\
-	(map)->handle = DRM(ioremap_nocache)((map)->offset, (map)->size)
+#define DRM_IOREMAP_NOCACHE(map, dev)						\
+	(map)->handle = DRM(ioremap_nocache)((map)->offset, (map)->size, (dev))
 
-#define DRM_IOREMAPFREE(map)						\
-	do {								\
-		if ( (map)->handle && (map)->size )			\
-			DRM(ioremapfree)( (map)->handle, (map)->size );	\
+#define DRM_IOREMAPFREE(map, dev)							\
+	do {									\
+		if ( (map)->handle && (map)->size )				\
+			DRM(ioremapfree)( (map)->handle, (map)->size, (dev) );	\
 	} while (0)
 
 #define DRM_FIND_MAP(_map, _o)								\
@@ -682,9 +682,10 @@ extern void	     DRM(free)(void *pt, siz
 extern unsigned long DRM(alloc_pages)(int order, int area);
 extern void	     DRM(free_pages)(unsigned long address, int order,
 				     int area);
-extern void	     *DRM(ioremap)(unsigned long offset, unsigned long size);
-extern void	     *DRM(ioremap_nocache)(unsigned long offset, unsigned long size);
-extern void	     DRM(ioremapfree)(void *pt, unsigned long size);
+extern void	     *DRM(ioremap)(unsigned long offset, unsigned long size, drm_device_t *dev);
+extern void	     *DRM(ioremap_nocache)(unsigned long offset, unsigned long size,
+					   drm_device_t *dev);
+extern void	     DRM(ioremapfree)(void *pt, unsigned long size, drm_device_t *dev);
 
 #if __REALLY_HAVE_AGP
 extern agp_memory    *DRM(alloc_agp)(int pages, u32 type);
Index: programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_bufs.h
===================================================================
RCS file: /cvsroot/dri/xc/xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_bufs.h,v
retrieving revision 1.20
diff -p -u -r1.20 drm_bufs.h
--- programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_bufs.h	28 Apr 2003 16:20:31 -0000	1.20
+++ programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_bufs.h	12 May 2003 20:59:27 -0000
@@ -124,7 +124,7 @@ int DRM(addmap)( struct inode *inode, st
 					      MTRR_TYPE_WRCOMB, 1 );
 		}
 #endif
-		map->handle = DRM(ioremap)( map->offset, map->size );
+		map->handle = DRM(ioremap)( map->offset, map->size, dev );
 		break;
 
 	case _DRM_SHM:
@@ -246,7 +246,7 @@ int DRM(rmmap)(struct inode *inode, stru
 				DRM_DEBUG("mtrr_del = %d\n", retcode);
 			}
 #endif
-			DRM(ioremapfree)(map->handle, map->size);
+			DRM(ioremapfree)(map->handle, map->size, dev);
 			break;
 		case _DRM_SHM:
 			vfree(map->handle);
Index: programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_drv.h
===================================================================
RCS file: /cvsroot/dri/xc/xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_drv.h,v
retrieving revision 1.35
diff -p -u -r1.35 drm_drv.h
--- programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_drv.h	27 Apr 2003 09:53:58 -0000	1.35
+++ programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_drv.h	12 May 2003 20:59:27 -0000
@@ -454,7 +454,7 @@ static int DRM(takedown)( drm_device_t *
 					DRM_DEBUG( "mtrr_del=%d\n", retcode );
 				}
 #endif
-				DRM(ioremapfree)( map->handle, map->size );
+				DRM(ioremapfree)( map->handle, map->size, dev );
 				break;
 			case _DRM_SHM:
 				vfree(map->handle);
Index: programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_memory.h
===================================================================
RCS file: /cvsroot/dri/xc/xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_memory.h,v
retrieving revision 1.11
diff -p -u -r1.11 drm_memory.h
--- programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_memory.h	26 Apr 2003 21:33:43 -0000	1.11
+++ programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_memory.h	12 May 2003 20:59:27 -0000
@@ -32,6 +32,7 @@
 #define __NO_VERSION__
 #include <linux/config.h>
 #include "drmP.h"
+#include <linux/vmalloc.h>
 
 /* Cut down version of drm_memory_debug.h, which used to be called
  * drm_memory.h.  If you want the debug functionality, change 0 to 1
@@ -39,6 +40,158 @@
  */
 #define DEBUG_MEMORY 0
 
+/* Need at least kernel v2.5.68 to get the 4-argument version of vmap().  */
+#if __REALLY_HAVE_AGP && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,68))
+
+#include <asm/agp.h>
+#include <asm/tlbflush.h>
+
+#ifndef PAGE_AGP
+# define PAGE_AGP	PAGE_KERNEL_NOCACHE
+#endif
+
+/*
+ * Find the drm_map that covers the range [offset, offset+size).
+ */
+static inline drm_map_t *
+drm_lookup_map (unsigned long offset, unsigned long size, drm_device_t *dev)
+{
+	struct list_head *list;
+	drm_map_list_t *r_list;
+	drm_map_t *map;
+
+	list_for_each(list, &dev->maplist->head) {
+		r_list = (drm_map_list_t *) list;
+		map = r_list->map;
+		if (!map)
+			continue;
+		if (map->offset <= offset && (offset + size) <= (map->offset + map->size))
+			return map;
+	}
+	return NULL;
+}
+
+static inline void *
+agp_remap (unsigned long offset, unsigned long size, drm_device_t *dev)
+{
+	unsigned long *phys_addr_map, i, num_pages = PAGE_ALIGN(size) / PAGE_SIZE;
+	struct drm_agp_mem *agpmem;
+	struct page **page_map;
+	void *addr;
+
+	size = PAGE_ALIGN(size);
+
+	for (agpmem = dev->agp->memory; agpmem; agpmem = agpmem->next)
+		if (agpmem->bound <= offset
+		    && (agpmem->bound + (agpmem->pages << PAGE_SHIFT)) >= (offset + size))
+			break;
+	if (!agpmem)
+		return NULL;
+
+	/*
+	 * OK, we're mapping AGP space on a chipset/platform on which memory accesses by
+	 * the CPU do not get remapped by the GART.  We fix this by using the kernel's
+	 * page-table instead (that's probably faster anyhow...).
+	 */
+	/* note: use vmalloc() because num_pages could be large... */
+	page_map = vmalloc(num_pages * sizeof(struct page *));
+	if (!page_map)
+		return NULL;
+
+	phys_addr_map = agpmem->memory->memory + (offset - agpmem->bound) / PAGE_SIZE;
+	for (i = 0; i < num_pages; ++i)
+		page_map[i] = pfn_to_page(phys_addr_map[i] >> PAGE_SHIFT);
+	addr = vmap(page_map, num_pages, VM_IOREMAP, PAGE_AGP);
+	vfree(page_map);
+	if (!addr)
+		return NULL;
+
+	flush_tlb_kernel_range((unsigned long) addr, (unsigned long) addr + size);
+	return addr;
+}
+
+static inline unsigned long
+drm_follow_page (void *vaddr)
+{
+	pgd_t *pgd = pgd_offset_k((unsigned long) vaddr);
+	pmd_t *pmd = pmd_offset(pgd, (unsigned long) vaddr);
+	pte_t *ptep = pte_offset_kernel(pmd, (unsigned long) vaddr);
+	return pte_pfn(*ptep) << PAGE_SHIFT;
+}
+
+#else /* !__REALLY_HAVE_AGP */
+
+static inline void *
+agp_remap (unsigned long offset, unsigned long size, drm_device_t *dev)
+{
+	return NULL;
+}
+
+#endif /* !__REALLY_HAVE_AGP */
+
+static inline void *drm_ioremap(unsigned long offset, unsigned long size, drm_device_t *dev)
+{
+	int remap_aperture = 0;
+
+#if __REALLY_HAVE_AGP && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,68))
+	if (dev->agp->cant_use_aperture) {
+		drm_map_t *map = drm_lookup_map(offset, size, dev);
+
+		if (map && map->type == _DRM_AGP)
+			remap_aperture = 1;
+	}
+#endif
+	if (remap_aperture)
+		return agp_remap(offset, size, dev);
+ 	else
+		return ioremap(offset, size);
+}
+
+static inline void *drm_ioremap_nocache(unsigned long offset, unsigned long size,
+					drm_device_t *dev)
+{
+	int remap_aperture = 0;
+
+#if __REALLY_HAVE_AGP && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,68))
+	if (dev->agp->cant_use_aperture) {
+		drm_map_t *map = drm_lookup_map(offset, size, dev);
+
+		if (map && map->type == _DRM_AGP)
+			remap_aperture = 1;
+	}
+#endif
+	if (remap_aperture)
+		return agp_remap(offset, size, dev);
+	else
+		return ioremap_nocache(offset, size);
+}
+
+static inline void drm_ioremapfree(void *pt, unsigned long size, drm_device_t *dev)
+{
+#if __REALLY_HAVE_AGP && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,68))
+	int unmap_aperture = 0;
+	/*
+	 * This is a bit ugly.  It would be much cleaner if the DRM API would use separate
+	 * routines for handling mappings in the AGP space.  Hopefully this can be done in
+	 * a future revision of the interface...
+	 */
+	if (dev->agp->cant_use_aperture
+	    && ((unsigned long) pt >= VMALLOC_START && (unsigned long) pt < VMALLOC_END))
+	{
+		unsigned long offset;
+		drm_map_t *map;
+
+		offset = drm_follow_page(pt) | ((unsigned long) pt & ~PAGE_MASK);
+		map = drm_lookup_map(offset, size, dev);
+		if (map && map->type == _DRM_AGP)
+			unmap_aperture = 1;
+	}
+	if (unmap_aperture)
+		vunmap(pt);
+	else
+#endif
+		iounmap(pt);
+}
 
 #if DEBUG_MEMORY
 #include "drm_memory_debug.h"
@@ -119,19 +272,19 @@ void DRM(free_pages)(unsigned long addre
 	free_pages(address, order);
 }
 
-void *DRM(ioremap)(unsigned long offset, unsigned long size)
+void *DRM(ioremap)(unsigned long offset, unsigned long size, drm_device_t *dev)
 {
-	return ioremap(offset, size);
+	return drm_ioremap(offset, size, dev);
 }
 
-void *DRM(ioremap_nocache)(unsigned long offset, unsigned long size)
+void *DRM(ioremap_nocache)(unsigned long offset, unsigned long size, drm_device_t *dev)
 {
-	return ioremap_nocache(offset, size);
+	return drm_ioremap_nocache(offset, size, dev);
 }
 
-void DRM(ioremapfree)(void *pt, unsigned long size)
+void DRM(ioremapfree)(void *pt, unsigned long size, drm_device_t *dev)
 {
-	iounmap(pt);
+	drm_ioremapfree(pt, size, dev);
 }
 
 #if __REALLY_HAVE_AGP
Index: programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_memory_debug.h
===================================================================
RCS file: /cvsroot/dri/xc/xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_memory_debug.h,v
retrieving revision 1.2
diff -p -u -r1.2 drm_memory_debug.h
--- programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_memory_debug.h	26 Apr 2003 21:33:43 -0000	1.2
+++ programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_memory_debug.h	12 May 2003 20:59:27 -0000
@@ -270,7 +270,7 @@ void DRM(free_pages)(unsigned long addre
 	}
 }
 
-void *DRM(ioremap)(unsigned long offset, unsigned long size)
+void *DRM(ioremap)(unsigned long offset, unsigned long size, drm_device_t *dev)
 {
 	void *pt;
 
@@ -280,7 +280,7 @@ void *DRM(ioremap)(unsigned long offset,
 		return NULL;
 	}
 
-	if (!(pt = ioremap(offset, size))) {
+	if (!(pt = drm_ioremap(offset, size, dev))) {
 		spin_lock(&DRM(mem_lock));
 		++DRM(mem_stats)[DRM_MEM_MAPPINGS].fail_count;
 		spin_unlock(&DRM(mem_lock));
@@ -293,7 +293,7 @@ void *DRM(ioremap)(unsigned long offset,
 	return pt;
 }
 
-void *DRM(ioremap_nocache)(unsigned long offset, unsigned long size)
+void *DRM(ioremap_nocache)(unsigned long offset, unsigned long size, drm_device_t *dev)
 {
 	void *pt;
 
@@ -303,7 +303,7 @@ void *DRM(ioremap_nocache)(unsigned long
 		return NULL;
 	}
 
-	if (!(pt = ioremap_nocache(offset, size))) {
+	if (!(pt = drm_ioremap_nocache(offset, size, dev))) {
 		spin_lock(&DRM(mem_lock));
 		++DRM(mem_stats)[DRM_MEM_MAPPINGS].fail_count;
 		spin_unlock(&DRM(mem_lock));
@@ -316,7 +316,7 @@ void *DRM(ioremap_nocache)(unsigned long
 	return pt;
 }
 
-void DRM(ioremapfree)(void *pt, unsigned long size)
+void DRM(ioremapfree)(void *pt, unsigned long size, drm_device_t *dev)
 {
 	int alloc_count;
 	int free_count;
@@ -325,7 +325,7 @@ void DRM(ioremapfree)(void *pt, unsigned
 		DRM_MEM_ERROR(DRM_MEM_MAPPINGS,
 			      "Attempt to free NULL pointer\n");
 	else
-		iounmap(pt);
+		drm_ioremapfree(pt, size, dev);
 
 	spin_lock(&DRM(mem_lock));
 	DRM(mem_stats)[DRM_MEM_MAPPINGS].bytes_freed += size;
Index: programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_vm.h
===================================================================
RCS file: /cvsroot/dri/xc/xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_vm.h,v
retrieving revision 1.21
diff -p -u -r1.21 drm_vm.h
--- programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_vm.h	8 Apr 2003 01:30:41 -0000	1.21
+++ programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_vm.h	12 May 2003 20:59:27 -0000
@@ -108,12 +108,12 @@ struct page *DRM(vm_nopage)(struct vm_ar
                  * Get the page, inc the use count, and return it
                  */
 		offset = (baddr - agpmem->bound) >> PAGE_SHIFT;
-		agpmem->memory->memory[offset] &= dev->agp->page_mask;
 		page = virt_to_page(__va(agpmem->memory->memory[offset]));
 		get_page(page);
 
-		DRM_DEBUG("baddr = 0x%lx page = 0x%p, offset = 0x%lx\n",
-			  baddr, __va(agpmem->memory->memory[offset]), offset);
+		DRM_DEBUG("baddr = 0x%lx page = 0x%p, offset = 0x%lx, count=%d\n",
+			  baddr, __va(agpmem->memory->memory[offset]), offset,
+			  atomic_read(&page->count));
 
 		return page;
         }
@@ -207,7 +207,7 @@ void DRM(vm_shm_close)(struct vm_area_st
 					DRM_DEBUG("mtrr_del = %d\n", retcode);
 				}
 #endif
-				DRM(ioremapfree)(map->handle, map->size);
+				DRM(ioremapfree)(map->handle, map->size, dev);
 				break;
 			case _DRM_SHM:
 				vfree(map->handle);
@@ -421,15 +421,16 @@ int DRM(mmap)(struct file *filp, struct 
 
 	switch (map->type) {
         case _DRM_AGP:
-#if defined(__alpha__)
+#if __REALLY_HAVE_AGP
+	  if (dev->agp->cant_use_aperture) {
                 /*
-                 * On Alpha we can't talk to bus dma address from the
-                 * CPU, so for memory of type DRM_AGP, we'll deal with
-                 * sorting out the real physical pages and mappings
-                 * in nopage()
+                 * On some platforms we can't talk to bus dma address from the CPU, so for
+                 * memory of type DRM_AGP, we'll deal with sorting out the real physical
+                 * pages and mappings in nopage()
                  */
                 vma->vm_ops = &DRM(vm_ops);
                 break;
+	  }
 #endif
                 /* fall through to _DRM_FRAME_BUFFER... */        
 	case _DRM_FRAME_BUFFER:
@@ -440,15 +441,15 @@ int DRM(mmap)(struct file *filp, struct 
 				pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
 				pgprot_val(vma->vm_page_prot) &= ~_PAGE_PWT;
 			}
-#elif defined(__ia64__)
-			if (map->type != _DRM_AGP)
-				vma->vm_page_prot =
-					pgprot_writecombine(vma->vm_page_prot);
 #elif defined(__powerpc__)
 			pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE | _PAGE_GUARDED;
 #endif
 			vma->vm_flags |= VM_IO;	/* not in core dump */
 		}
+#if defined(__ia64__)
+		if (map->type != _DRM_AGP)
+			vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+#endif
 		offset = DRIVER_GET_REG_OFS();
 #ifdef __sparc__
 		if (io_remap_page_range(DRM_RPR_ARG(vma) vma->vm_start,
Index: programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/gamma_dma.c
===================================================================
RCS file: /cvsroot/dri/xc/xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/gamma_dma.c,v
retrieving revision 1.26
diff -p -u -r1.26 gamma_dma.c
--- programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/gamma_dma.c	26 Apr 2003 22:28:53 -0000	1.26
+++ programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/gamma_dma.c	12 May 2003 20:59:28 -0000
@@ -618,7 +618,7 @@ static int gamma_do_init_dma( drm_device
 	} else {
 		DRM_FIND_MAP( dev_priv->buffers, init->buffers_offset );
 
-		DRM_IOREMAP( dev_priv->buffers );
+		DRM_IOREMAP( dev_priv->buffers, dev );
 
 		buf = dma->buflist[GLINT_DRI_BUF_COUNT];
 		pgt = buf->address;
@@ -657,7 +657,7 @@ int gamma_do_cleanup_dma( drm_device_t *
 		drm_gamma_private_t *dev_priv = dev->dev_private;
 
 		if ( dev_priv->buffers != NULL )
-			DRM_IOREMAPFREE( dev_priv->buffers );
+			DRM_IOREMAPFREE( dev_priv->buffers, dev );
 
 		DRM(free)( dev->dev_private, sizeof(drm_gamma_private_t),
 			   DRM_MEM_DRIVER );
Index: programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/i810_dma.c
===================================================================
RCS file: /cvsroot/dri/xc/xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/i810_dma.c,v
retrieving revision 1.46
diff -p -u -r1.46 i810_dma.c
--- programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/i810_dma.c	26 Apr 2003 22:28:53 -0000	1.46
+++ programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/i810_dma.c	12 May 2003 20:59:28 -0000
@@ -253,7 +253,7 @@ int i810_dma_cleanup(drm_device_t *dev)
 
 	   	if(dev_priv->ring.virtual_start) {
 		   	DRM(ioremapfree)((void *) dev_priv->ring.virtual_start,
-					 dev_priv->ring.Size);
+					 dev_priv->ring.Size, dev);
 		}
 	   	if (dev_priv->hw_status_page) {
 		   	pci_free_consistent(dev->pdev, PAGE_SIZE,
@@ -270,7 +270,7 @@ int i810_dma_cleanup(drm_device_t *dev)
 			drm_buf_t *buf = dma->buflist[ i ];
 			drm_i810_buf_priv_t *buf_priv = buf->dev_private;
 			if ( buf_priv->kernel_virtual && buf->total )
-				DRM(ioremapfree)(buf_priv->kernel_virtual, buf->total);
+				DRM(ioremapfree)(buf_priv->kernel_virtual, buf->total, dev);
 		}
 	}
    	return 0;
@@ -340,7 +340,7 @@ static int i810_freelist_init(drm_device
 	   	*buf_priv->in_use = I810_BUF_FREE;
 
 		buf_priv->kernel_virtual = DRM(ioremap)(buf->bus_address,
-							buf->total);
+							buf->total, dev);
 	}
 	return 0;
 }
@@ -393,7 +393,7 @@ static int i810_dma_initialize(drm_devic
 
    	dev_priv->ring.virtual_start = DRM(ioremap)(dev->agp->base +
 						    init->ring_start,
-						    init->ring_size);
+						    init->ring_size, dev);
 
    	if (dev_priv->ring.virtual_start == NULL) {
 		dev->dev_private = (void *) dev_priv;
Index: programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/i830_dma.c
===================================================================
RCS file: /cvsroot/dri/xc/xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/i830_dma.c,v
retrieving revision 1.20
diff -p -u -r1.20 i830_dma.c
--- programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/i830_dma.c	26 Apr 2003 22:28:53 -0000	1.20
+++ programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/i830_dma.c	12 May 2003 20:59:28 -0000
@@ -253,7 +253,7 @@ int i830_dma_cleanup(drm_device_t *dev)
 	   
 	   	if (dev_priv->ring.virtual_start) {
 		   	DRM(ioremapfree)((void *) dev_priv->ring.virtual_start,
-					 dev_priv->ring.Size);
+					 dev_priv->ring.Size, dev);
 		}
 	   	if (dev_priv->hw_status_page) {
 			pci_free_consistent(dev->pdev, PAGE_SIZE,
@@ -271,7 +271,7 @@ int i830_dma_cleanup(drm_device_t *dev)
 			drm_buf_t *buf = dma->buflist[ i ];
 			drm_i830_buf_priv_t *buf_priv = buf->dev_private;
 			if ( buf_priv->kernel_virtual && buf->total )
-				DRM(ioremapfree)(buf_priv->kernel_virtual, buf->total);
+				DRM(ioremapfree)(buf_priv->kernel_virtual, buf->total, dev);
 		}
 	}
    	return 0;
@@ -347,7 +347,7 @@ static int i830_freelist_init(drm_device
 	   	*buf_priv->in_use = I830_BUF_FREE;
 
 		buf_priv->kernel_virtual = DRM(ioremap)(buf->bus_address, 
-							buf->total);
+							buf->total, dev);
 	}
 	return 0;
 }
@@ -401,7 +401,7 @@ static int i830_dma_initialize(drm_devic
 
    	dev_priv->ring.virtual_start = DRM(ioremap)(dev->agp->base + 
 						    init->ring_start, 
-						    init->ring_size);
+						    init->ring_size, dev);
 
    	if (dev_priv->ring.virtual_start == NULL) {
 		dev->dev_private = (void *) dev_priv;

--=-DUNeIFSd+/Nx3+W7gfby--

