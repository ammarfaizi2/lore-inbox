Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbUKRADH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbUKRADH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 19:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbUKRAAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 19:00:50 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:59044 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262554AbUKQX4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 18:56:40 -0500
To: linux-kernel@vger.kernel.org
cc: Ian.Pratt@cl.cam.ac.uk, akpm@osdl.org, Keir.Fraser@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
Subject: [patch 4/4] Xen core patch : /dev/mem calls io_remap_page_range
Date: Wed, 17 Nov 2004 23:56:38 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CUZfD-00059Q-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch modifies /dev/mem to call io_remap_page_range rather than
remap_page_range under CONFIG_XEN.  (the two definitions are different
under arch xen, unlike most other architectures).  This allows the X
server and other programs that use /dev/mem for MMIO to work under
Xen. 

Signed-off-by: ian.pratt@cl.cam.ac.uk

---


diff -Nurp pristine-linux-2.6.9/drivers/char/mem.c linux-2.6.9-xen0/drivers/char/mem.c
--- pristine-linux-2.6.9/drivers/char/mem.c     2004-10-18 22:54:19.000000000 +0100
+++ linux-2.6.9-xen0/drivers/char/mem.c 2004-11-17 00:12:37.000000000 +0000
@@ -26,6 +26,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
+#include <asm/pgalloc.h>
 
 #ifdef CONFIG_IA64
 # include <linux/efi.h>
@@ -42,7 +43,12 @@ extern void tapechar_init(void);
  */
 static inline int uncached_access(struct file *file, unsigned long addr)
 {
-#if defined(__i386__)
+#ifdef CONFIG_XEN
+        if (file->f_flags & O_SYNC)
+                return 1;
+        /* Xen sets correct MTRR type on non-RAM for us. */
+        return 0;
+#elif defined(__i386__)
        /*
         * On the PPro and successors, the MTRRs are used to set
         * memory types for physical addresses outside main memory,
@@ -210,9 +216,15 @@ static int mmap_mem(struct file * file, 
        if (uncached)
                vma->vm_flags |= VM_IO;
 
+#if defined(CONFIG_XEN)
+       if (io_remap_page_range(vma, vma->vm_start, offset, 
+                               vma->vm_end-vma->vm_start, vma->vm_page_prot))
+               return -EAGAIN;
+#else
        if (remap_page_range(vma, vma->vm_start, offset, vma->vm_end-vma->vm_start,
                             vma->vm_page_prot))
                return -EAGAIN;
+#endif
        return 0;
 }
 
