Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTLGSqo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 13:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbTLGSqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 13:46:44 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:54403
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263357AbTLGSqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 13:46:40 -0500
Date: Sun, 7 Dec 2003 13:45:36 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pgcl-2.6.0-test5-bk3-17
In-Reply-To: <20031207072803.GU8039@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0312071342590.1758@montezuma.fsmlabs.com>
References: <20031128041558.GW19856@holomorphy.com> <20031128072148.GY8039@holomorphy.com>
 <20031130164301.GK8039@holomorphy.com> <20031201073632.GQ8039@holomorphy.com>
 <20031207072803.GU8039@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Dec 2003, William Lee Irwin III wrote:

> On Sun, Nov 30, 2003 at 08:43:01AM -0800, William Lee Irwin III wrote:
> >> I wonder if this would be enough to get sysenter support going again.
> >> I've not got a sysenter-capable userspace around, so I can't really
> >> test this myself.
> >> vs. pgcl-2.6.0-test11-5
>
> On Sun, Nov 30, 2003 at 11:36:32PM -0800, William Lee Irwin III wrote:
> > Stack decoding fixes, shutting up some compiler warnings, and dumping
> > PAGE_SIZE and MMUPAGE_SIZE into /proc/meminfo (for lack of a better place).
> > The printk()'s down there should eventually get ripped out anyway for
> > minimal impact and a quieter boot, but until then...
>
> Woops, those page sizes were a bit off. Come to think of it, so is
> aio_setup_ring()...

And here is a sync point, it gets DRI memory allocation/mapping code
working. There are a few things which need to be ironed out wrt the radeon
driver, but this is some good progress.

Tested with the radeon DRI driver.

Index: linux-2.6.0-test11/drivers/char/drm/drmP.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test11/drivers/char/drm/drmP.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 drmP.h
--- linux-2.6.0-test11/drivers/char/drm/drmP.h	28 Nov 2003 18:03:00 -0000	1.1.1.1
+++ linux-2.6.0-test11/drivers/char/drm/drmP.h	7 Dec 2003 17:47:22 -0000
@@ -203,7 +203,7 @@ static inline struct page * vmalloc_to_p
 #define DRM_RPR_ARG(vma) vma,
 #endif

-#define VM_OFFSET(vma) ((vma)->vm_pgoff << PAGE_SHIFT)
+#define VM_OFFSET(vma) ((vma)->vm_pgoff << MMUPAGE_SHIFT)

 /*@}*/

Index: linux-2.6.0-test11/drivers/char/drm/drm_bufs.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test11/drivers/char/drm/drm_bufs.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 drm_bufs.h
--- linux-2.6.0-test11/drivers/char/drm/drm_bufs.h	28 Nov 2003 18:03:00 -0000	1.1.1.1
+++ linux-2.6.0-test11/drivers/char/drm/drm_bufs.h	7 Dec 2003 18:37:49 -0000
@@ -120,7 +120,7 @@ int DRM(addmap)( struct inode *inode, st
 	}
 	DRM_DEBUG( "offset = 0x%08lx, size = 0x%08lx, type = %d\n",
 		   map->offset, map->size, map->type );
-	if ( (map->offset & (~PAGE_MASK)) || (map->size & (~PAGE_MASK)) ) {
+	if ((map->offset & ~MMUPAGE_MASK) || (map->size & ~MMUPAGE_MASK)) {
 		DRM(free)( map, sizeof(*map), DRM_MEM_MAPS );
 		return -EINVAL;
 	}
@@ -392,7 +392,7 @@ int DRM(addbufs_agp)( struct inode *inod
 	size = 1 << order;

 	alignment  = (request.flags & _DRM_PAGE_ALIGN)
-		? PAGE_ALIGN(size) : size;
+		? MMUPAGE_ALIGN(size) : size;
 	page_order = order - PAGE_SHIFT > 0 ? order - PAGE_SHIFT : 0;
 	total = PAGE_SIZE << page_order;

@@ -572,7 +572,7 @@ int DRM(addbufs_pci)( struct inode *inod
 	if ( dev->queue_count ) return -EBUSY; /* Not while in use */

 	alignment = (request.flags & _DRM_PAGE_ALIGN)
-		? PAGE_ALIGN(size) : size;
+		? MMUPAGE_ALIGN(size) : size;
 	page_order = order - PAGE_SHIFT > 0 ? order - PAGE_SHIFT : 0;
 	total = PAGE_SIZE << page_order;

@@ -800,7 +800,7 @@ int DRM(addbufs_sg)( struct inode *inode
 	size = 1 << order;

 	alignment  = (request.flags & _DRM_PAGE_ALIGN)
-			? PAGE_ALIGN(size) : size;
+			? MMUPAGE_ALIGN(size) : size;
 	page_order = order - PAGE_SHIFT > 0 ? order - PAGE_SHIFT : 0;
 	total = PAGE_SIZE << page_order;

Index: linux-2.6.0-test11/drivers/char/drm/drm_ioctl.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test11/drivers/char/drm/drm_ioctl.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 drm_ioctl.h
Index: linux-2.6.0-test11/drivers/char/drm/drm_memory.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test11/drivers/char/drm/drm_memory.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 drm_memory.h
--- linux-2.6.0-test11/drivers/char/drm/drm_memory.h	28 Nov 2003 18:03:00 -0000	1.1.1.1
+++ linux-2.6.0-test11/drivers/char/drm/drm_memory.h	7 Dec 2003 18:37:00 -0000
@@ -279,7 +281,7 @@ unsigned long DRM(alloc_pages)(int order
 	for (addr = address, sz = bytes;
 	     sz > 0;
 	     addr += PAGE_SIZE, sz -= PAGE_SIZE) {
-		SetPageReserved(virt_to_page(addr));
+		SetPageReserved(pfn_to_page(vmalloc_to_pfn((void *)addr)));
 	}

 	return address;
@@ -307,7 +309,8 @@ void DRM(free_pages)(unsigned long addre
 	for (addr = address, sz = bytes;
 	     sz > 0;
 	     addr += PAGE_SIZE, sz -= PAGE_SIZE) {
-		ClearPageReserved(virt_to_page(addr));
+
+		ClearPageReserved(pfn_to_page(vmalloc_to_pfn((void *)addr)));
 	}

 	free_pages(address, order);
Index: linux-2.6.0-test11/drivers/char/drm/drm_scatter.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test11/drivers/char/drm/drm_scatter.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 drm_scatter.h
--- linux-2.6.0-test11/drivers/char/drm/drm_scatter.h	28 Nov 2003 18:03:00 -0000	1.1.1.1
+++ linux-2.6.0-test11/drivers/char/drm/drm_scatter.h	29 Nov 2003 17:15:58 -0000
@@ -137,7 +137,7 @@ int DRM(sg_alloc)( struct inode *inode,
 	DRM_DEBUG( "sg alloc virtual = %p\n", entry->virtual );

 	for ( i = entry->handle, j = 0 ; j < pages ; i += PAGE_SIZE, j++ ) {
-		entry->pagelist[j] = vmalloc_to_page((void *)i);
+		entry->pagelist[j] = pfn_to_page(vmalloc_to_pfn((void *)i));
 		if (!entry->pagelist[j])
 			goto failed;
 		SetPageReserved(entry->pagelist[j]);
Index: linux-2.6.0-test11/drivers/char/drm/drm_vm.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test11/drivers/char/drm/drm_vm.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 drm_vm.h
--- linux-2.6.0-test11/drivers/char/drm/drm_vm.h	28 Nov 2003 18:03:00 -0000	1.1.1.1
+++ linux-2.6.0-test11/drivers/char/drm/drm_vm.h	7 Dec 2003 18:42:11 -0000
@@ -166,7 +166,7 @@ struct page *DRM(vm_shm_nopage)(struct v

 	offset	 = address - vma->vm_start;
 	i = (unsigned long)map->handle + offset;
-	page = vmalloc_to_page((void *)i);
+	page = pfn_to_page(vmalloc_to_pfn((void *)i));
 	if (!page)
 		return NOPAGE_OOM;
 	get_page(page);
