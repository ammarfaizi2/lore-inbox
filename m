Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVDMLTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVDMLTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 07:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVDMLTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 07:19:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29962 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261313AbVDMLTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 07:19:43 -0400
Date: Wed, 13 Apr 2005 12:19:37 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Rolf Offermanns <roffermanns@sysgo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmap + dma_alloc_coherent
Message-ID: <20050413121937.A14087@flint.arm.linux.org.uk>
Mail-Followup-To: Rolf Offermanns <roffermanns@sysgo.com>,
	linux-kernel@vger.kernel.org
References: <200504131243.48694.roffermanns@sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200504131243.48694.roffermanns@sysgo.com>; from roffermanns@sysgo.com on Wed, Apr 13, 2005 at 12:43:47PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 12:43:47PM +0200, Rolf Offermanns wrote:
> I would like to mmap a kernel buffer, allocated with pci_alloc_consistent()
> for DMA, to userspace and came up with the following. Since there seem to be
> some (unresolved) issues (see below) with this and I would like to do the
> RightThing(TM), I would appreciate your comments about my stuff.

This has come up before.  ARM implements dma_mmap_*() to allow this
to happen, but it never got propagated to the other architectures.

Here's the (untested) x86 version.  There may be a problem with
x86 not marking the pages reserved, which is required for
remap_pfn_range() to work.

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -r orig/arch/i386/kernel/pci-dma.c linux/arch/i386/kernel/pci-dma.c
--- orig/arch/i386/kernel/pci-dma.c	Mon Apr  4 22:52:57 2005
+++ linux/arch/i386/kernel/pci-dma.c	Mon Apr  4 22:44:45 2005
@@ -49,7 +49,7 @@ void *dma_alloc_coherent(struct device *
 	ret = (void *)__get_free_pages(gfp, order);
 
 	if (ret != NULL) {
-		memset(ret, 0, size);
+		memset(ret, 0, PAGE_ALIGN(size));
 		*dma_handle = virt_to_phys(ret);
 	}
 	return ret;
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -r orig/include/asm-i386/dma-mapping.h linux/include/asm-i386/dma-mapping.h
--- orig/include/asm-i386/dma-mapping.h	Mon Apr  4 22:54:41 2005
+++ linux/include/asm-i386/dma-mapping.h	Mon Apr  4 22:48:11 2005
@@ -16,6 +16,23 @@ void *dma_alloc_coherent(struct device *
 void dma_free_coherent(struct device *dev, size_t size,
 			 void *vaddr, dma_addr_t dma_handle);
 
+static inline int
+dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
+		  void *vaddr, dma_addr_t handle, size_t size)
+{
+	unsigned long offset = vma->vm_pgoff, usize;
+
+	size = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	usize = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+
+	if (offset >= size || usize > (size - offset))
+		return -ENXIO;
+
+	return remap_pfn_range(vma, vma->vm_start,
+			       (__pa(vaddr) >> PAGE_SHIFT) + offset,
+			       usize << PAGE_SHIFT, vma->vm_page_prot);
+}
+
 static inline dma_addr_t
 dma_map_single(struct device *dev, void *ptr, size_t size,
 	       enum dma_data_direction direction)



-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
