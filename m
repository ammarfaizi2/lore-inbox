Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269272AbUIYH4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269272AbUIYH4n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 03:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269270AbUIYH4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 03:56:43 -0400
Received: from holomorphy.com ([207.189.100.168]:1766 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269272AbUIYHzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 03:55:31 -0400
Date: Sat, 25 Sep 2004 00:55:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [vm 5/6] convert users of remap_page_range() under sound/ to use remap_pfn_range()
Message-ID: <20040925075524.GI9106@holomorphy.com>
References: <20040925074445.GD9106@holomorphy.com> <20040925074712.GE9106@holomorphy.com> <20040925074915.GF9106@holomorphy.com> <20040925075102.GG9106@holomorphy.com> <20040925075328.GH9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925075328.GH9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 12:53:28AM -0700, William Lee Irwin III wrote:
> This patch converts uses of remap_page_range() via io_remap_page_range()
> in include/asm-*/ to use remap_pfn_range(). io_remap_page_range() has a
> similar physical address overflow issue that needs to be addressed later.

This patch converts all users of remap_page_range() under sound/ to use
remap_pfn_range(), with the exception of maestro3 changelogs, which are
likely expected to be preserved intact apart from additions (as most
changelogs are), regardless of API changes.


Index: mm3-2.6.9-rc2/sound/oss/ali5455.c
===================================================================
--- mm3-2.6.9-rc2.orig/sound/oss/ali5455.c	2004-09-25 00:15:53.713606800 -0700
+++ mm3-2.6.9-rc2/sound/oss/ali5455.c	2004-09-25 00:28:42.280766832 -0700
@@ -934,7 +934,7 @@
 	dmabuf->rawbuf = rawbuf;
 	dmabuf->buforder = order;
 
-	/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
+	/* now mark the pages as reserved; otherwise remap_pfn_range doesn't do what we want */
 	pend = virt_to_page(rawbuf + (PAGE_SIZE << order) - 1);
 	for (page = virt_to_page(rawbuf); page <= pend; page++)
 		SetPageReserved(page);
@@ -1955,7 +1955,9 @@
 	if (size > (PAGE_SIZE << dmabuf->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf), size, vma->vm_page_prot))
+	if (remap_pfn_range(vma, vma->vm_start,
+				virt_to_phys(dmabuf->rawbuf) >> PAGE_SHIFT,
+				size, vma->vm_page_prot))
 		goto out;
 	dmabuf->mapped = 1;
 	dmabuf->trigger = 0;
Index: mm3-2.6.9-rc2/sound/oss/au1000.c
===================================================================
--- mm3-2.6.9-rc2.orig/sound/oss/au1000.c	2004-09-25 00:15:53.961569104 -0700
+++ mm3-2.6.9-rc2/sound/oss/au1000.c	2004-09-25 00:28:45.779234984 -0700
@@ -629,7 +629,7 @@
 			return -ENOMEM;
 		db->buforder = order;
 		/* now mark the pages as reserved;
-		   otherwise remap_page_range doesn't do what we want */
+		   otherwise remap_pfn_range doesn't do what we want */
 		pend = virt_to_page(db->rawbuf +
 				    (PAGE_SIZE << db->buforder) - 1);
 		for (page = virt_to_page(db->rawbuf); page <= pend; page++)
@@ -1338,7 +1338,8 @@
 		ret = -EINVAL;
 		goto out;
 	}
-	if (remap_page_range(vma->vm_start, virt_to_phys(db->rawbuf),
+	if (remap_pfn_range(vma->vm_start,
+			     virt_to_phys(db->rawbuf) >> PAGE_SHIFT,
 			     size, vma->vm_page_prot)) {
 		ret = -EAGAIN;
 		goto out;
Index: mm3-2.6.9-rc2/sound/oss/cmpci.c
===================================================================
--- mm3-2.6.9-rc2.orig/sound/oss/cmpci.c	2004-09-25 00:15:54.083550560 -0700
+++ mm3-2.6.9-rc2/sound/oss/cmpci.c	2004-09-25 00:28:49.412682616 -0700
@@ -1393,7 +1393,7 @@
 		if (!db->rawbuf || !db->dmaaddr)
 			return -ENOMEM;
 		db->buforder = order;
-		/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
+		/* now mark the pages as reserved; otherwise remap_pfn_range doesn't do what we want */
 		pend = virt_to_page(db->rawbuf + (PAGE_SIZE << db->buforder) - 1);
 		for (pstart = virt_to_page(db->rawbuf); pstart <= pend; pstart++)
 			SetPageReserved(pstart);
@@ -2301,7 +2301,9 @@
 	if (size > (PAGE_SIZE << db->buforder))
 		goto out;
 	ret = -EINVAL;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
+	if (remap_pfn_range(vma, vma->vm_start,
+				virt_to_phys(db->rawbuf) >> PAGE_SHIFT,
+				size, vma->vm_page_prot))
 		goto out;
 	db->mapped = 1;
 	ret = 0;
Index: mm3-2.6.9-rc2/sound/oss/cs4281/cs4281m.c
===================================================================
--- mm3-2.6.9-rc2.orig/sound/oss/cs4281/cs4281m.c	2004-09-25 00:15:54.478490520 -0700
+++ mm3-2.6.9-rc2/sound/oss/cs4281/cs4281m.c	2004-09-25 00:28:55.532752224 -0700
@@ -1755,7 +1755,7 @@
 		}
 		db->buforder = order;
 		// Now mark the pages as reserved; otherwise the 
-		// remap_page_range() in cs4281_mmap doesn't work.
+		// remap_pfn_range() in cs4281_mmap doesn't work.
 		// 1. get index to last page in mem_map array for rawbuf.
 		mapend = virt_to_page(db->rawbuf + 
 			(PAGE_SIZE << db->buforder) - 1);
@@ -1778,7 +1778,7 @@
 		}
 		s->buforder_tmpbuff = order;
 		// Now mark the pages as reserved; otherwise the 
-		// remap_page_range() in cs4281_mmap doesn't work.
+		// remap_pfn_range() in cs4281_mmap doesn't work.
 		// 1. get index to last page in mem_map array for rawbuf.
 		mapend = virt_to_page(s->tmpbuff + 
 				(PAGE_SIZE << s->buforder_tmpbuff) - 1);
@@ -3135,9 +3135,10 @@
 	size = vma->vm_end - vma->vm_start;
 	if (size > (PAGE_SIZE << db->buforder))
 		return -EINVAL;
-	if (remap_page_range
-	    (vma, vma->vm_start, virt_to_phys(db->rawbuf), size,
-	     vma->vm_page_prot)) return -EAGAIN;
+	if (remap_pfn_range(vma, vma->vm_start,
+				virt_to_phys(db->rawbuf) >> PAGE_SHIFT,
+				size, vma->vm_page_prot))
+		return -EAGAIN;
 	db->mapped = 1;
 
 	CS_DBGOUT(CS_FUNCTION | CS_PARMS | CS_OPEN, 4,
Index: mm3-2.6.9-rc2/sound/oss/cs46xx.c
===================================================================
--- mm3-2.6.9-rc2.orig/sound/oss/cs46xx.c	2004-09-25 00:15:54.542480792 -0700
+++ mm3-2.6.9-rc2/sound/oss/cs46xx.c	2004-09-25 00:28:58.340325408 -0700
@@ -1190,7 +1190,7 @@
 	dmabuf->buforder = order;
 	dmabuf->rawbuf = rawbuf;
 	// Now mark the pages as reserved; otherwise the 
-	// remap_page_range() in cs46xx_mmap doesn't work.
+	// remap_pfn_range() in cs46xx_mmap doesn't work.
 	// 1. get index to last page in mem_map array for rawbuf.
 	mapend = virt_to_page(dmabuf->rawbuf + 
 		(PAGE_SIZE << dmabuf->buforder) - 1);
@@ -1227,7 +1227,7 @@
 	dmabuf->buforder_tmpbuff = order;
 	
 	// Now mark the pages as reserved; otherwise the 
-	// remap_page_range() in cs46xx_mmap doesn't work.
+	// remap_pfn_range() in cs46xx_mmap doesn't work.
 	// 1. get index to last page in mem_map array for rawbuf.
 	mapend = virt_to_page(dmabuf->tmpbuff + 
 		(PAGE_SIZE << dmabuf->buforder_tmpbuff) - 1);
@@ -2452,7 +2452,8 @@
 		ret = -EINVAL;
 		goto out;
 	}
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf),
+	if (remap_pfn_range(vma, vma->vm_start,
+			     virt_to_phys(dmabuf->rawbuf) >> PAGE_SHIFT,
 			     size, vma->vm_page_prot))
 	{
 		ret = -EAGAIN;
Index: mm3-2.6.9-rc2/sound/oss/es1370.c
===================================================================
--- mm3-2.6.9-rc2.orig/sound/oss/es1370.c	2004-09-25 00:15:53.525635376 -0700
+++ mm3-2.6.9-rc2/sound/oss/es1370.c	2004-09-25 00:29:05.662212312 -0700
@@ -573,7 +573,7 @@
 		if (!db->rawbuf)
 			return -ENOMEM;
 		db->buforder = order;
-		/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
+		/* now mark the pages as reserved; otherwise remap_pfn_range doesn't do what we want */
 		pend = virt_to_page(db->rawbuf + (PAGE_SIZE << db->buforder) - 1);
 		for (page = virt_to_page(db->rawbuf); page <= pend; page++)
 			SetPageReserved(page);
@@ -1364,7 +1364,9 @@
 		ret = -EINVAL;
 		goto out;
 	}
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot)) {
+	if (remap_pfn_range(vma, vma->vm_start,
+				virt_to_phys(db->rawbuf) >> PAGE_SHIFT,
+				size, vma->vm_page_prot)) {
 		ret = -EAGAIN;
 		goto out;
 	}
@@ -1940,7 +1942,9 @@
 	if (size > (PAGE_SIZE << s->dma_dac1.buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(s->dma_dac1.rawbuf), size, vma->vm_page_prot))
+	if (remap_pfn_range(vma, vma->vm_start,
+			virt_to_phys(s->dma_dac1.rawbuf) >> PAGE_SHIFT,
+			size, vma->vm_page_prot))
 		goto out;
 	s->dma_dac1.mapped = 1;
 	ret = 0;
Index: mm3-2.6.9-rc2/sound/oss/es1371.c
===================================================================
--- mm3-2.6.9-rc2.orig/sound/oss/es1371.c	2004-09-25 00:15:53.887580352 -0700
+++ mm3-2.6.9-rc2/sound/oss/es1371.c	2004-09-25 00:29:08.231821672 -0700
@@ -910,7 +910,7 @@
 		if (!db->rawbuf)
 			return -ENOMEM;
 		db->buforder = order;
-		/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
+		/* now mark the pages as reserved; otherwise remap_pfn_range doesn't do what we want */
 		pend = virt_to_page(db->rawbuf + (PAGE_SIZE << db->buforder) - 1);
 		for (page = virt_to_page(db->rawbuf); page <= pend; page++)
 			SetPageReserved(page);
@@ -1555,7 +1555,9 @@
 		ret = -EINVAL;
 		goto out;
 	}
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot)) {
+	if (remap_pfn_range(vma, vma->vm_start,
+				virt_to_phys(db->rawbuf) >> PAGE_SHIFT,
+				size, vma->vm_page_prot)) {
 		ret = -EAGAIN;
 		goto out;
 	}
@@ -2128,7 +2130,9 @@
 	if (size > (PAGE_SIZE << s->dma_dac1.buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(s->dma_dac1.rawbuf), size, vma->vm_page_prot))
+	if (remap_pfn_range(vma, vma->vm_start,
+			virt_to_phys(s->dma_dac1.rawbuf) >> PAGE_SHIFT,
+			size, vma->vm_page_prot))
 		goto out;
 	s->dma_dac1.mapped = 1;
 	ret = 0;
Index: mm3-2.6.9-rc2/sound/oss/esssolo1.c
===================================================================
--- mm3-2.6.9-rc2.orig/sound/oss/esssolo1.c	2004-09-25 00:15:54.389504048 -0700
+++ mm3-2.6.9-rc2/sound/oss/esssolo1.c	2004-09-25 00:29:11.880267024 -0700
@@ -445,7 +445,7 @@
 		if (!db->rawbuf)
 			return -ENOMEM;
 		db->buforder = order;
-		/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
+		/* now mark the pages as reserved; otherwise remap_pfn_range doesn't do what we want */
 		pend = virt_to_page(db->rawbuf + (PAGE_SIZE << db->buforder) - 1);
 		for (page = virt_to_page(db->rawbuf); page <= pend; page++)
 			SetPageReserved(page);
@@ -1242,7 +1242,9 @@
 	if (size > (PAGE_SIZE << db->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
+	if (remap_pfn_range(vma, vma->vm_start,
+				virt_to_phys(db->rawbuf) >> PAGE_SHIFT,
+				size, vma->vm_page_prot))
 		goto out;
 	db->mapped = 1;
 	ret = 0;
Index: mm3-2.6.9-rc2/sound/oss/forte.c
===================================================================
--- mm3-2.6.9-rc2.orig/sound/oss/forte.c	2004-09-25 00:15:54.271521984 -0700
+++ mm3-2.6.9-rc2/sound/oss/forte.c	2004-09-25 00:29:15.041786400 -0700
@@ -1409,7 +1409,8 @@
                 goto out;
 	}
 
-        if (remap_page_range (vma, vma->vm_start, virt_to_phys (channel->buf),
+        if (remap_pfn_range(vma, vma->vm_start,
+			      virt_to_phys(channel->buf) >> PAGE_SHIFT,
 			      size, vma->vm_page_prot)) {
 		DPRINTK ("%s: remap el a no worko\n", __FUNCTION__);
 		ret = -EAGAIN;
Index: mm3-2.6.9-rc2/sound/oss/i810_audio.c
===================================================================
--- mm3-2.6.9-rc2.orig/sound/oss/i810_audio.c	2004-09-25 00:15:53.830589016 -0700
+++ mm3-2.6.9-rc2/sound/oss/i810_audio.c	2004-09-25 00:29:18.347283888 -0700
@@ -917,7 +917,7 @@
 	dmabuf->rawbuf = rawbuf;
 	dmabuf->buforder = order;
 	
-	/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
+	/* now mark the pages as reserved; otherwise remap_pfn_range doesn't do what we want */
 	pend = virt_to_page(rawbuf + (PAGE_SIZE << order) - 1);
 	for (page = virt_to_page(rawbuf); page <= pend; page++)
 		SetPageReserved(page);
@@ -1750,7 +1750,8 @@
 	if (size > (PAGE_SIZE << dmabuf->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf),
+	if (remap_pfn_range(vma, vma->vm_start,
+			     virt_to_phys(dmabuf->rawbuf) >> PAGE_SHIFT,
 			     size, vma->vm_page_prot))
 		goto out;
 	dmabuf->mapped = 1;
Index: mm3-2.6.9-rc2/sound/oss/ite8172.c
===================================================================
--- mm3-2.6.9-rc2.orig/sound/oss/ite8172.c	2004-09-25 00:15:54.330513016 -0700
+++ mm3-2.6.9-rc2/sound/oss/ite8172.c	2004-09-25 00:29:22.860597760 -0700
@@ -693,7 +693,7 @@
 			return -ENOMEM;
 		db->buforder = order;
 		/* now mark the pages as reserved;
-		   otherwise remap_page_range doesn't do what we want */
+		   otherwise remap_pfn_range doesn't do what we want */
 		pend = virt_to_page(db->rawbuf +
 				    (PAGE_SIZE << db->buforder) - 1);
 		for (page = virt_to_page(db->rawbuf); page <= pend; page++)
@@ -1311,7 +1311,8 @@
 		unlock_kernel();
 		return -EINVAL;
 	}
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf),
+	if (remap_pfn_range(vma, vma->vm_start,
+			     virt_to_phys(db->rawbuf) >> PAGE_SHIFT,
 			     size, vma->vm_page_prot)) {
 		unlock_kernel();
 		return -EAGAIN;
Index: mm3-2.6.9-rc2/sound/oss/maestro.c
===================================================================
--- mm3-2.6.9-rc2.orig/sound/oss/maestro.c	2004-09-25 00:15:53.596624584 -0700
+++ mm3-2.6.9-rc2/sound/oss/maestro.c	2004-09-25 00:29:32.279165920 -0700
@@ -2520,7 +2520,9 @@
 	if (size > (PAGE_SIZE << db->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
+	if (remap_pfn_range(vma, vma->vm_start,
+			virt_to_phys(db->rawbuf) >> PAGE_SHIFT,
+			size, vma->vm_page_prot))
 		goto out;
 	db->mapped = 1;
 	ret = 0;
@@ -2953,7 +2955,7 @@
 
 	}
 
-	/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
+	/* now mark the pages as reserved; otherwise remap_pfn_range doesn't do what we want */
 	pend = virt_to_page(rawbuf + (PAGE_SIZE << order) - 1);
 	for (page = virt_to_page(rawbuf); page <= pend; page++)
 		SetPageReserved(page);
Index: mm3-2.6.9-rc2/sound/oss/maestro3.c
===================================================================
--- mm3-2.6.9-rc2.orig/sound/oss/maestro3.c	2004-09-25 00:15:53.651616224 -0700
+++ mm3-2.6.9-rc2/sound/oss/maestro3.c	2004-09-25 00:29:30.275470528 -0700
@@ -1557,7 +1557,9 @@
      * ask Jeff what the hell I'm doing wrong.
      */
     ret = -EAGAIN;
-    if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
+    if (remap_pfn_range(vma, vma->vm_start,
+			virt_to_phys(db->rawbuf) >> PAGE_SHIFT,
+			size, vma->vm_page_prot))
         goto out;
 
     db->mapped = 1;
Index: mm3-2.6.9-rc2/sound/oss/rme96xx.c
===================================================================
--- mm3-2.6.9-rc2.orig/sound/oss/rme96xx.c	2004-09-25 00:15:54.230528216 -0700
+++ mm3-2.6.9-rc2/sound/oss/rme96xx.c	2004-09-25 00:29:36.517521592 -0700
@@ -1685,14 +1685,14 @@
 	if (vma->vm_flags & VM_WRITE) {
 		if (!s->started) rme96xx_startcard(s,1);
 
-		if (remap_page_range(vma, vma->vm_start, virt_to_phys(s->playbuf + dma->outoffset*RME96xx_DMA_MAX_SIZE), size, vma->vm_page_prot)) {
+		if (remap_pfn_range(vma, vma->vm_start, virt_to_phys(s->playbuf + dma->outoffset*RME96xx_DMA_MAX_SIZE) >> PAGE_SHIFT, size, vma->vm_page_prot)) {
 			unlock_kernel();
 			return -EAGAIN;
 		}
 	} 
 	else if (vma->vm_flags & VM_READ) {
 		if (!s->started) rme96xx_startcard(s,1);
-		if (remap_page_range(vma, vma->vm_start, virt_to_phys(s->playbuf + dma->inoffset*RME96xx_DMA_MAX_SIZE), size, vma->vm_page_prot)) {
+		if (remap_pfn_range(vma, vma->vm_start, virt_to_phys(s->playbuf + dma->inoffset*RME96xx_DMA_MAX_SIZE) >> PAGE_SHIFT, size, vma->vm_page_prot)) {
 			unlock_kernel();
 			return -EAGAIN;
 		}
Index: mm3-2.6.9-rc2/sound/oss/sonicvibes.c
===================================================================
--- mm3-2.6.9-rc2.orig/sound/oss/sonicvibes.c	2004-09-25 00:15:54.181535664 -0700
+++ mm3-2.6.9-rc2/sound/oss/sonicvibes.c	2004-09-25 00:29:39.798022880 -0700
@@ -756,7 +756,7 @@
 		if ((virt_to_bus(db->rawbuf) + (PAGE_SIZE << db->buforder) - 1) & ~0xffffff)
 			printk(KERN_DEBUG "sv: DMA buffer beyond 16MB: busaddr 0x%lx  size %ld\n", 
 			       virt_to_bus(db->rawbuf), PAGE_SIZE << db->buforder);
-		/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
+		/* now mark the pages as reserved; otherwise remap_pfn_range doesn't do what we want */
 		pend = virt_to_page(db->rawbuf + (PAGE_SIZE << db->buforder) - 1);
 		for (page = virt_to_page(db->rawbuf); page <= pend; page++)
 			SetPageReserved(page);
@@ -1549,7 +1549,9 @@
 	if (size > (PAGE_SIZE << db->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
+	if (remap_pfn_range(vma, vma->vm_start,
+				virt_to_phys(db->rawbuf) >> PAGE_SHIFT,
+				size, vma->vm_page_prot))
 		goto out;
 	db->mapped = 1;
 	ret = 0;
Index: mm3-2.6.9-rc2/sound/oss/soundcard.c
===================================================================
--- mm3-2.6.9-rc2.orig/sound/oss/soundcard.c	2004-09-25 00:15:54.126544024 -0700
+++ mm3-2.6.9-rc2/sound/oss/soundcard.c	2004-09-25 00:29:44.236348152 -0700
@@ -463,9 +463,9 @@
 	if (size != dmap->bytes_in_use) {
 		printk(KERN_WARNING "Sound: mmap() size = %ld. Should be %d\n", size, dmap->bytes_in_use);
 	}
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmap->raw_buf),
-		vma->vm_end - vma->vm_start,
-		vma->vm_page_prot)) {
+	if (remap_pfn_range(vma, vma->vm_start,
+			virt_to_phys(dmap->raw_buf) >> PAGE_SHIFT,
+			vma->vm_end - vma->vm_start, vma->vm_page_prot)) {
 		unlock_kernel();
 		return -EAGAIN;
 	}
Index: mm3-2.6.9-rc2/sound/oss/trident.c
===================================================================
--- mm3-2.6.9-rc2.orig/sound/oss/trident.c	2004-09-25 00:15:53.769598288 -0700
+++ mm3-2.6.9-rc2/sound/oss/trident.c	2004-09-25 00:29:47.652828768 -0700
@@ -1281,7 +1281,7 @@
 	dmabuf->buforder = order;
 
 	/* now mark the pages as reserved; otherwise */ 
-	/* remap_page_range doesn't do what we want */
+	/* remap_pfn_range doesn't do what we want */
 	pend = virt_to_page(rawbuf + (PAGE_SIZE << order) - 1);
 	for (page = virt_to_page(rawbuf); page <= pend; page++)
 		SetPageReserved(page);
@@ -2223,7 +2223,8 @@
 	if (size > (PAGE_SIZE << dmabuf->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf), 
+	if (remap_pfn_range(vma, vma->vm_start,
+			     virt_to_phys(dmabuf->rawbuf) >> PAGE_SHIFT,
 			     size, vma->vm_page_prot))
 		goto out;
 	dmabuf->mapped = 1;
Index: mm3-2.6.9-rc2/sound/oss/ymfpci.c
===================================================================
--- mm3-2.6.9-rc2.orig/sound/oss/ymfpci.c	2004-09-25 00:15:54.029558768 -0700
+++ mm3-2.6.9-rc2/sound/oss/ymfpci.c	2004-09-25 00:29:52.098152976 -0700
@@ -334,7 +334,7 @@
 	dmabuf->dma_addr = dma_addr;
 	dmabuf->buforder = order;
 
-	/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
+	/* now mark the pages as reserved; otherwise remap_pfn_range doesn't do what we want */
 	mapend = virt_to_page(rawbuf + (PAGE_SIZE << order) - 1);
 	for (map = virt_to_page(rawbuf); map <= mapend; map++)
 		set_bit(PG_reserved, &map->flags);
@@ -1545,7 +1545,8 @@
 	size = vma->vm_end - vma->vm_start;
 	if (size > (PAGE_SIZE << dmabuf->buforder))
 		return -EINVAL;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf),
+	if (remap_pfn_range(vma, vma->vm_start,
+			     virt_to_phys(dmabuf->rawbuf) >> PAGE_SHIFT,
 			     size, vma->vm_page_prot))
 		return -EAGAIN;
 	dmabuf->mapped = 1;
