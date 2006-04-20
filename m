Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWDTRG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWDTRG7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWDTRG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:06:59 -0400
Received: from ns2.suse.de ([195.135.220.15]:50657 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751180AbWDTRG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:06:57 -0400
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>
Message-Id: <20060228202246.14172.12624.sendpatchset@linux.site>
In-Reply-To: <20060228202202.14172.60409.sendpatchset@linux.site>
References: <20060228202202.14172.60409.sendpatchset@linux.site>
Subject: [patch 4/5] mm: extra remap_vmalloc_range check
Date: Thu, 20 Apr 2006 19:06:52 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flag to ensure all remap_vmalloc_range memory has been allocated
with the vmalloc _user variants, so data does not get leaked.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/linux/vmalloc.h
===================================================================
--- linux-2.6.orig/include/linux/vmalloc.h
+++ linux-2.6/include/linux/vmalloc.h
@@ -8,6 +8,7 @@
 #define VM_IOREMAP	0x00000001	/* ioremap() and friends */
 #define VM_ALLOC	0x00000002	/* vmalloc() */
 #define VM_MAP		0x00000004	/* vmap()ed pages */
+#define VM_USERMAP	0x00000008	/* suitable for remap_vmalloc_range */
 /* bits [20..32] reserved for arch specific ioremap internals */
 
 /*
Index: linux-2.6/drivers/media/video/et61x251/et61x251_core.c
===================================================================
--- linux-2.6.orig/drivers/media/video/et61x251/et61x251_core.c
+++ linux-2.6/drivers/media/video/et61x251/et61x251_core.c
@@ -133,7 +133,8 @@ et61x251_request_buffers(struct et61x251
 
 	cam->nbuffers = count;
 	while (cam->nbuffers > 0) {
-		if ((buff = vmalloc_32(cam->nbuffers * PAGE_ALIGN(imagesize))))
+		if ((buff = vmalloc_32_user(cam->nbuffers *
+						PAGE_ALIGN(imagesize))))
 			break;
 		cam->nbuffers--;
 	}
Index: linux-2.6/drivers/media/video/sn9c102/sn9c102_core.c
===================================================================
--- linux-2.6.orig/drivers/media/video/sn9c102/sn9c102_core.c
+++ linux-2.6/drivers/media/video/sn9c102/sn9c102_core.c
@@ -149,7 +149,7 @@ sn9c102_request_buffers(struct sn9c102_d
 
 	cam->nbuffers = count;
 	while (cam->nbuffers > 0) {
-		if ((buff = vmalloc_32(cam->nbuffers * PAGE_ALIGN(imagesize))))
+		if ((buff = vmalloc_32_user(cam->nbuffers * PAGE_ALIGN(imagesize))))
 			break;
 		cam->nbuffers--;
 	}
Index: linux-2.6/drivers/media/video/zc0301/zc0301_core.c
===================================================================
--- linux-2.6.orig/drivers/media/video/zc0301/zc0301_core.c
+++ linux-2.6/drivers/media/video/zc0301/zc0301_core.c
@@ -136,7 +136,7 @@ zc0301_request_buffers(struct zc0301_dev
 
 	cam->nbuffers = count;
 	while (cam->nbuffers > 0) {
-		if ((buff = vmalloc_32(cam->nbuffers * PAGE_ALIGN(imagesize))))
+		if ((buff = vmalloc_32_user(cam->nbuffers * PAGE_ALIGN(imagesize))))
 			break;
 		cam->nbuffers--;
 	}
Index: linux-2.6/mm/vmalloc.c
===================================================================
--- linux-2.6.orig/mm/vmalloc.c
+++ linux-2.6/mm/vmalloc.c
@@ -525,7 +525,15 @@ EXPORT_SYMBOL(vmalloc);
  */
 void *vmalloc_user(unsigned long size)
 {
-	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO, PAGE_KERNEL);
+	struct vm_struct *area;
+	void *ret;
+
+	ret = __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO, PAGE_KERNEL);
+	area = find_vm_area(ret);
+	BUG_ON(!area);
+	area->flags |= VM_USERMAP;
+
+	return ret;
 }
 EXPORT_SYMBOL(vmalloc_user);
 
@@ -592,7 +600,15 @@ EXPORT_SYMBOL(vmalloc_32);
  */
 void *vmalloc_32_user(unsigned long size)
 {
-	return __vmalloc(size, GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL);
+	struct vm_struct *area;
+	void *ret;
+
+	ret = __vmalloc(size, GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL);
+	area = find_vm_area(ret);
+	BUG_ON(!area);
+	area->flags |= VM_USERMAP;
+
+	return ret;
 }
 EXPORT_SYMBOL(vmalloc_32_user);
 
@@ -700,6 +716,9 @@ int remap_vmalloc_range(struct vm_area_s
 	if (!area)
 		return -EINVAL;
 
+	if (!(area->flags & VM_USERMAP))
+		return -EINVAL;
+
 	if (usize + (pgoff << PAGE_SHIFT) > area->size - PAGE_SIZE)
 		return -EINVAL;
 
Index: linux-2.6/drivers/media/video/em28xx/em28xx-core.c
===================================================================
--- linux-2.6.orig/drivers/media/video/em28xx/em28xx-core.c
+++ linux-2.6/drivers/media/video/em28xx/em28xx-core.c
@@ -79,10 +79,8 @@ u32 em28xx_request_buffers(struct em28xx
 
 	dev->num_frames = count;
 	while (dev->num_frames > 0) {
-		if ((buff = vmalloc_32(dev->num_frames * imagesize))) {
-			memset(buff, 0, dev->num_frames * imagesize);
+		if ((buff = vmalloc_32_user(dev->num_frames * imagesize)))
 			break;
-		}
 		dev->num_frames--;
 	}
 
