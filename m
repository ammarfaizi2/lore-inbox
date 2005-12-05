Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbVLEX6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbVLEX6E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbVLEX6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:58:04 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:33198 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1751501AbVLEX6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:58:01 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] /dev/mem __HAVE_PHYS_MEM_ACCESS_PROT  tidy-up
Date: Mon, 5 Dec 2005 16:57:56 -0700
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512051657.56607.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tidy up __HAVE_PHYS_MEM_ACCESS_PROT usage to make mmap_mem() easier to read.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work4/drivers/char/mem.c
===================================================================
--- work4.orig/drivers/char/mem.c	2005-12-02 15:16:56.000000000 -0700
+++ work4/drivers/char/mem.c	2005-12-02 15:40:35.000000000 -0700
@@ -228,22 +228,25 @@
 	return written;
 }
 
+#ifndef __HAVE_PHYS_MEM_ACCESS_PROT
+static pgprot_t phys_mem_access_prot(struct file *file, unsigned long addr,
+				     unsigned long size, pgprot_t vma_prot)
+{
+#ifdef pgprot_noncached
+	if (uncached_access(file, addr))
+		return pgprot_noncached(vma_prot);
+#endif
+	return vma_prot;
+}
+#endif
+
 static int mmap_mem(struct file * file, struct vm_area_struct * vma)
 {
-#if defined(__HAVE_PHYS_MEM_ACCESS_PROT)
 	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
 
 	vma->vm_page_prot = phys_mem_access_prot(file, offset,
 						 vma->vm_end - vma->vm_start,
 						 vma->vm_page_prot);
-#elif defined(pgprot_noncached)
-	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
-	int uncached;
-
-	uncached = uncached_access(file, offset);
-	if (uncached)
-		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-#endif
 
 	/* Remap-pfn-range will mark the range VM_IO and VM_RESERVED */
 	if (remap_pfn_range(vma,
