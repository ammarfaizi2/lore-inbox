Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVCRTkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVCRTkZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 14:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVCRTkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 14:40:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:45202 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262057AbVCRTjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 14:39:43 -0500
Date: Fri, 18 Mar 2005 11:34:14 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-mm@kvack.org, akpm@osdl.org, davem@davemloft.net, wli@holomorphy.com,
       riel@redhat.com, kurt@garloff.de, Keir.Fraser@cl.cam.ac.uk,
       Ian.Pratt@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
Subject: [PATCH 2/4] io_remap_pfn_range: convert sparc callers
Message-Id: <20050318113414.097590d6.rddunlap@osdl.org>
In-Reply-To: <20050318112545.6f5f7635.rddunlap@osdl.org>
References: <20050318112545.6f5f7635.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


io_remap_pfn_range():
  convert sparc32/64 callers of io_remap_page_range(with 6 args)
  to io_remap_pfn_range(with 5 args);

 drivers/char/drm/drm_vm.c   |    6 +++---
 drivers/sbus/char/vfc_dev.c |    6 ++++--
 drivers/video/fbmem.c       |    6 +++---
 drivers/video/sbuslib.c     |    8 +++++---
 4 files changed, 15 insertions(+), 11 deletions(-)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/drivers/char/drm/drm_vm.c linux-2611-bk3-pfn/drivers/char/drm/drm_vm.c
--- linux-2611-bk3-pv/drivers/char/drm/drm_vm.c	2005-03-01 23:38:33.000000000 -0800
+++ linux-2611-bk3-pfn/drivers/char/drm/drm_vm.c	2005-03-07 11:04:59.000000000 -0800
@@ -625,10 +625,10 @@ int drm_mmap(struct file *filp, struct v
 #endif
 		offset = dev->driver->get_reg_ofs(dev);
 #ifdef __sparc__
-		if (io_remap_page_range(DRM_RPR_ARG(vma) vma->vm_start,
-					VM_OFFSET(vma) + offset,
+		if (io_remap_pfn_range(DRM_RPR_ARG(vma) vma->vm_start,
+					(VM_OFFSET(vma) + offset) >> PAGE_SHIFT,
 					vma->vm_end - vma->vm_start,
-					vma->vm_page_prot, 0))
+					vma->vm_page_prot))
 #else
 		if (remap_pfn_range(DRM_RPR_ARG(vma) vma->vm_start,
 				     (VM_OFFSET(vma) + offset) >> PAGE_SHIFT,
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/drivers/sbus/char/vfc_dev.c linux-2611-bk3-pfn/drivers/sbus/char/vfc_dev.c
--- linux-2611-bk3-pv/drivers/sbus/char/vfc_dev.c	2005-03-01 23:38:10.000000000 -0800
+++ linux-2611-bk3-pfn/drivers/sbus/char/vfc_dev.c	2005-03-07 11:04:59.000000000 -0800
@@ -626,8 +626,10 @@ static int vfc_mmap(struct file *file, s
 	vma->vm_flags |=
 		(VM_SHM | VM_LOCKED | VM_IO | VM_MAYREAD | VM_MAYWRITE | VM_MAYSHARE);
 	map_offset = (unsigned int) (long)dev->phys_regs;
-	ret = io_remap_page_range(vma, vma->vm_start, map_offset, map_size, 
-				  vma->vm_page_prot, dev->which_io);
+	ret = io_remap_pfn_range(vma, vma->vm_start,
+				  MK_IOSPACE_PFN(dev->which_io,
+					map_offset >> PAGE_SHIFT),
+				  map_size, vma->vm_page_prot);
 
 	if(ret)
 		return -EAGAIN;
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/drivers/video/fbmem.c linux-2611-bk3-pfn/drivers/video/fbmem.c
--- linux-2611-bk3-pv/drivers/video/fbmem.c	2005-03-01 23:37:30.000000000 -0800
+++ linux-2611-bk3-pfn/drivers/video/fbmem.c	2005-03-07 11:04:59.000000000 -0800
@@ -940,8 +940,8 @@ fb_mmap(struct file *file, struct vm_are
 	/* This is an IO map - tell maydump to skip this VMA */
 	vma->vm_flags |= VM_IO | VM_RESERVED;
 #if defined(__sparc_v9__)
-	if (io_remap_page_range(vma, vma->vm_start, off,
-				vma->vm_end - vma->vm_start, vma->vm_page_prot, 0))
+	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
+				vma->vm_end - vma->vm_start, vma->vm_page_prot))
 		return -EAGAIN;
 #else
 #if defined(__mc68000__)
@@ -977,7 +977,7 @@ fb_mmap(struct file *file, struct vm_are
 #else
 #warning What do we have to do here??
 #endif
-	if (io_remap_page_range(vma, vma->vm_start, off,
+	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
 			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
 		return -EAGAIN;
 #endif /* !__sparc_v9__ */
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/drivers/video/sbuslib.c linux-2611-bk3-pfn/drivers/video/sbuslib.c
--- linux-2611-bk3-pv/drivers/video/sbuslib.c	2005-03-01 23:37:52.000000000 -0800
+++ linux-2611-bk3-pfn/drivers/video/sbuslib.c	2005-03-07 11:04:59.000000000 -0800
@@ -74,10 +74,12 @@ int sbusfb_mmap_helper(struct sbus_mmap_
 		}
 		if (page + map_size > size)
 			map_size = size - page;
-		r = io_remap_page_range(vma,
+		r = io_remap_pfn_range(vma,
 					vma->vm_start + page,
-					map_offset, map_size,
-					vma->vm_page_prot, iospace);
+					MK_IOSPACE_PFN(iospace,
+						map_offset >> PAGE_SHIFT),
+					map_size,
+					vma->vm_page_prot);
 		if (r)
 			return -EAGAIN;
 		page += map_size;
---
