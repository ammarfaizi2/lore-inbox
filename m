Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWJLOKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWJLOKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 10:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWJLOKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 10:10:23 -0400
Received: from mail.suse.de ([195.135.220.2]:1217 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751424AbWJLOKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 10:10:16 -0400
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>
Message-Id: <20061012120140.29671.39388.sendpatchset@linux.site>
In-Reply-To: <20061012120102.29671.31163.sendpatchset@linux.site>
References: <20061012120102.29671.31163.sendpatchset@linux.site>
Subject: [patch 4/5] mm: incorrect VM_FAULT_OOM returns from drivers
Date: Thu, 12 Oct 2006 16:10:11 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers are returning OOM when it is not in response to a memory
shortage.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/drivers/char/drm/drm_vm.c
===================================================================
--- linux-2.6.orig/drivers/char/drm/drm_vm.c
+++ linux-2.6/drivers/char/drm/drm_vm.c
@@ -147,14 +147,14 @@ static __inline__ struct page *drm_do_vm
 	if (address > vma->vm_end)
 		return NOPAGE_SIGBUS;	/* Disallow mremap */
 	if (!map)
-		return NOPAGE_OOM;	/* Nothing allocated */
+		return NOPAGE_SIGBUS;	/* Nothing allocated */
 
 	offset = address - vma->vm_start;
 	i = (unsigned long)map->handle + offset;
 	page = (map->type == _DRM_CONSISTENT) ?
 		virt_to_page((void *)i) : vmalloc_to_page((void *)i);
 	if (!page)
-		return NOPAGE_OOM;
+		return NOPAGE_SIGBUS;
 	get_page(page);
 
 	DRM_DEBUG("shm_nopage 0x%lx\n", address);
@@ -272,7 +272,7 @@ static __inline__ struct page *drm_do_vm
 	if (address > vma->vm_end)
 		return NOPAGE_SIGBUS;	/* Disallow mremap */
 	if (!dma->pagelist)
-		return NOPAGE_OOM;	/* Nothing allocated */
+		return NOPAGE_SIGBUS;	/* Nothing allocated */
 
 	offset = address - vma->vm_start;	/* vm_[pg]off[set] should be 0 */
 	page_nr = offset >> PAGE_SHIFT;
@@ -310,7 +310,7 @@ static __inline__ struct page *drm_do_vm
 	if (address > vma->vm_end)
 		return NOPAGE_SIGBUS;	/* Disallow mremap */
 	if (!entry->pagelist)
-		return NOPAGE_OOM;	/* Nothing allocated */
+		return NOPAGE_SIGBUS;	/* Nothing allocated */
 
 	offset = address - vma->vm_start;
 	map_offset = map->offset - (unsigned long)dev->sg->virtual;
Index: linux-2.6/sound/core/pcm_native.c
===================================================================
--- linux-2.6.orig/sound/core/pcm_native.c
+++ linux-2.6/sound/core/pcm_native.c
@@ -3025,7 +3025,7 @@ static struct page * snd_pcm_mmap_status
 	struct page * page;
 	
 	if (substream == NULL)
-		return NOPAGE_OOM;
+		return NOPAGE_SIGBUS;
 	runtime = substream->runtime;
 	page = virt_to_page(runtime->status);
 	get_page(page);
@@ -3068,7 +3068,7 @@ static struct page * snd_pcm_mmap_contro
 	struct page * page;
 	
 	if (substream == NULL)
-		return NOPAGE_OOM;
+		return NOPAGE_SIGBUS;
 	runtime = substream->runtime;
 	page = virt_to_page(runtime->control);
 	get_page(page);
@@ -3129,18 +3129,18 @@ static struct page *snd_pcm_mmap_data_no
 	size_t dma_bytes;
 	
 	if (substream == NULL)
-		return NOPAGE_OOM;
+		return NOPAGE_SIGBUS;
 	runtime = substream->runtime;
 	offset = area->vm_pgoff << PAGE_SHIFT;
 	offset += address - area->vm_start;
-	snd_assert((offset % PAGE_SIZE) == 0, return NOPAGE_OOM);
+	snd_assert((offset % PAGE_SIZE) == 0, return NOPAGE_SIGBUS);
 	dma_bytes = PAGE_ALIGN(runtime->dma_bytes);
 	if (offset > dma_bytes - PAGE_SIZE)
 		return NOPAGE_SIGBUS;
 	if (substream->ops->page) {
 		page = substream->ops->page(substream, offset);
 		if (! page)
-			return NOPAGE_OOM;
+			return NOPAGE_OOM; /* XXX: is this really due to OOM? */
 	} else {
 		vaddr = runtime->dma_area + offset;
 		page = virt_to_page(vaddr);
Index: linux-2.6/sound/oss/via82cxxx_audio.c
===================================================================
--- linux-2.6.orig/sound/oss/via82cxxx_audio.c
+++ linux-2.6/sound/oss/via82cxxx_audio.c
@@ -2120,8 +2120,8 @@ static struct page * via_mm_nopage (stru
 		return NOPAGE_SIGBUS; /* Disallow mremap */
 	}
         if (!card) {
-		DPRINTK ("EXIT, returning NOPAGE_OOM\n");
-		return NOPAGE_OOM;	/* Nothing allocated */
+		DPRINTK ("EXIT, returning NOPAGE_SIGBUS\n");
+		return NOPAGE_SIGBUS;	/* Nothing allocated */
 	}
 
 	pgoff = vma->vm_pgoff + ((address - vma->vm_start) >> PAGE_SHIFT);
Index: linux-2.6/sound/usb/usx2y/usX2Yhwdep.c
===================================================================
--- linux-2.6.orig/sound/usb/usx2y/usX2Yhwdep.c
+++ linux-2.6/sound/usb/usx2y/usX2Yhwdep.c
@@ -48,7 +48,7 @@ static struct page * snd_us428ctls_vm_no
 	
 	offset = area->vm_pgoff << PAGE_SHIFT;
 	offset += address - area->vm_start;
-	snd_assert((offset % PAGE_SIZE) == 0, return NOPAGE_OOM);
+	snd_assert((offset % PAGE_SIZE) == 0, return NOPAGE_SIGBUS);
 	vaddr = (char*)((struct usX2Ydev *)area->vm_private_data)->us428ctls_sharedmem + offset;
 	page = virt_to_page(vaddr);
 	get_page(page);
