Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbUKSXaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbUKSXaQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 18:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbUKSX1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 18:27:08 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:2247 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261637AbUKSXW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 18:22:56 -0500
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk,
       Ian.Pratt@cl.cam.ac.uk
Subject: [4/7] Xen VMM patch set : /dev/mem io_remap_page_range for CONFIG_XEN
In-reply-to: Your message of "Fri, 19 Nov 2004 23:16:33 GMT."
             <E1CVHzW-0004XC-00@mta1.cl.cam.ac.uk> 
Date: Fri, 19 Nov 2004 23:22:51 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CVI5c-0004bf-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch modifies /dev/mem to call io_remap_page_range rather than
remap_pfn_range under CONFIG_XEN.  This is required because in arch
xen we need to use a different function for mapping MMIO space vs
mapping psueudo-physical memory.  This allows the X server and other
programs that use /dev/mem for MMIO to work under Xen.

Signed-off-by: ian.pratt@cl.cam.ac.uk

---


diff -Nurp pristine-linux-2.6.10-rc2/drivers/char/mem.c tmp-linux-2.6.10-rc2-xen.patch/drivers/char/mem.c
--- pristine-linux-2.6.10-rc2/drivers/char/mem.c	2004-11-15 01:27:41.000000000 +0000
+++ tmp-linux-2.6.10-rc2-xen.patch/drivers/char/mem.c	2004-11-19 16:33:04.000000000 +0000
@@ -42,7 +42,12 @@ extern void tapechar_init(void);
  */
 static inline int uncached_access(struct file *file, unsigned long addr)
 {
-#if defined(__i386__)
+#ifdef CONFIG_XEN
+	if (file->f_flags & O_SYNC)
+		return 1;
+	/* Xen sets correct MTRR type on non-RAM for us. */
+	return 0;
+#elif defined(__i386__)
 	/*
 	 * On the PPro and successors, the MTRRs are used to set
 	 * memory types for physical addresses outside main memory,
@@ -201,6 +206,14 @@ static int mmap_mem(struct file * file, 
 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 #endif
 
+#if defined(CONFIG_XEN)
+	if (io_remap_page_range(vma,
+				vma->vm_start,
+				vma->vm_pgoff << PAGE_SHIFT,
+				vma->vm_end-vma->vm_start,
+				vma->vm_page_prot))
+		return -EAGAIN;
+#else
 	/* Remap-pfn-range will mark the range VM_IO and VM_RESERVED */
 	if (remap_pfn_range(vma,
 			    vma->vm_start,
@@ -208,6 +221,7 @@ static int mmap_mem(struct file * file, 
 			    vma->vm_end-vma->vm_start,
 			    vma->vm_page_prot))
 		return -EAGAIN;
+#endif
 	return 0;
 }
 
