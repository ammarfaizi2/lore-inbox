Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWDTRIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWDTRIa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWDTRHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:07:54 -0400
Received: from ns2.suse.de ([195.135.220.15]:55777 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751172AbWDTRHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:07:08 -0400
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>
Message-Id: <20060228202256.14172.90281.sendpatchset@linux.site>
In-Reply-To: <20060228202202.14172.60409.sendpatchset@linux.site>
References: <20060228202202.14172.60409.sendpatchset@linux.site>
Subject: [patch 5/5] drivers: leave vm_flags alone
Date: Thu, 20 Apr 2006 19:07:02 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of some vm_flags twiddling from driver code. The net result of
this + the last 4 patches is that all converted remap_vmalloc_range
memory can support get_user_pages - do we want that? Can't hurt, can it?

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/drivers/media/video/em28xx/em28xx-video.c
===================================================================
--- linux-2.6.orig/drivers/media/video/em28xx/em28xx-video.c
+++ linux-2.6/drivers/media/video/em28xx/em28xx-video.c
@@ -620,10 +620,6 @@ static int em28xx_v4l2_mmap(struct file 
 		return -EINVAL;
 	}
 
-	/* VM_IO is eventually going to replace PageReserved altogether */
-	vma->vm_flags |= VM_IO;
-	vma->vm_flags |= VM_RESERVED;	/* avoid to swap out this VMA */
-
 	if (remap_vmalloc_range(vma, dev->frame[i].bufmem, 0)) {
 		em28xx_videodbg("mmap: remap_vmalloc_range failed\n");
 		mutex_unlock(&dev->fileop_lock);
Index: linux-2.6/drivers/media/video/et61x251/et61x251_core.c
===================================================================
--- linux-2.6.orig/drivers/media/video/et61x251/et61x251_core.c
+++ linux-2.6/drivers/media/video/et61x251/et61x251_core.c
@@ -1499,9 +1499,6 @@ static int et61x251_mmap(struct file* fi
 		return -EINVAL;
 	}
 
-	vma->vm_flags |= VM_IO;
-	vma->vm_flags |= VM_RESERVED;
-
 	if (remap_vmalloc_range(vma, cam->frame[i].bufmem, 0)) {
 		mutex_unlock(&cam->fileop_mutex);
 		return -EAGAIN;
Index: linux-2.6/drivers/media/video/meye.c
===================================================================
--- linux-2.6.orig/drivers/media/video/meye.c
+++ linux-2.6/drivers/media/video/meye.c
@@ -1689,8 +1689,6 @@ static int meye_mmap(struct file *file, 
 	}
 
 	vma->vm_ops = &meye_vm_ops;
-	vma->vm_flags &= ~VM_IO;	/* not I/O memory */
-	vma->vm_flags |= VM_RESERVED;	/* avoid to swap out this VMA */
 	vma->vm_private_data = (void *) (offset / gbufsize);
 	meye_vm_open(vma);
 
Index: linux-2.6/drivers/media/video/pwc/pwc-if.c
===================================================================
--- linux-2.6.orig/drivers/media/video/pwc/pwc-if.c
+++ linux-2.6/drivers/media/video/pwc/pwc-if.c
@@ -1567,8 +1567,6 @@ static int pwc_video_mmap(struct file *f
 				vma->vm_start, vma->vm_end - vma->vm_start);
 	pdev = vdev->priv;
 
-	vma->vm_flags |= VM_IO;
-
 	if (remap_vmalloc_range(vma, pdev->image_data, 0))
 		return -EAGAIN;
 
Index: linux-2.6/drivers/media/video/sn9c102/sn9c102_core.c
===================================================================
--- linux-2.6.orig/drivers/media/video/sn9c102/sn9c102_core.c
+++ linux-2.6/drivers/media/video/sn9c102/sn9c102_core.c
@@ -1762,9 +1762,6 @@ static int sn9c102_mmap(struct file* fil
 		return -EINVAL;
 	}
 
-	vma->vm_flags |= VM_IO;
-	vma->vm_flags |= VM_RESERVED;
-
 	if (remap_vmalloc_range(vma, cam->frame[i].bufmem, 0)) {
 		mutex_unlock(&cam->fileop_mutex);
 		return -EAGAIN;
Index: linux-2.6/drivers/media/video/zc0301/zc0301_core.c
===================================================================
--- linux-2.6.orig/drivers/media/video/zc0301/zc0301_core.c
+++ linux-2.6/drivers/media/video/zc0301/zc0301_core.c
@@ -963,9 +963,6 @@ static int zc0301_mmap(struct file* filp
 		return -EINVAL;
 	}
 
-	vma->vm_flags |= VM_IO;
-	vma->vm_flags |= VM_RESERVED;
-
 	if (remap_vmalloc_range(vma, cam->frame[i].bufmem, 0)) {
 		mutex_unlock(&cam->fileop_mutex);
 		return -EAGAIN;
