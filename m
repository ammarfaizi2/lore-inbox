Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267752AbUG3RGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267752AbUG3RGk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 13:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267751AbUG3RGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 13:06:40 -0400
Received: from cantor.suse.de ([195.135.220.2]:57998 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267753AbUG3RGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 13:06:19 -0400
Date: Fri, 30 Jul 2004 19:02:27 +0200
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com
Subject: [PATCH] Improve pci_alloc_consistent wrapper on preemptive kernels
Message-Id: <20040730190227.29913e23.ak@suse.de>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a minor optimization for the pci_alloc_consistent wrapper for
the generic dma API. When the kernel is compiled preemptive the caller
can decide if the allocation needs to be GFP_KERNEL or GFP_ATOMIC.

I had this optimization previously in x86-64 private code, but it needs to move
up now that x86-64 uses the generic DMA API.


diff -urpN -X ../KDIFX linux-2.6.8rc2-mm1/include/asm-generic/pci-dma-compat.h linux-2.6.8rc2-mm1-amd64/include/asm-generic/pci-dma-compat.h
--- linux-2.6.8rc2-mm1/include/asm-generic/pci-dma-compat.h	2004-04-06 13:12:19.000000000 +0200
+++ linux-2.6.8rc2-mm1-amd64/include/asm-generic/pci-dma-compat.h	2004-07-30 17:02:49.000000000 +0200
@@ -5,6 +5,13 @@
 #define _ASM_GENERIC_PCI_DMA_COMPAT_H
 
 #include <linux/dma-mapping.h>
+#include <linux/config.h>
+
+#ifdef CONFIG_PREEMPT
+#define preempt_atomic() in_atomic()
+#else
+#define preempt_atomic() 1
+#endif
 
 /* note pci_set_dma_mask isn't here, since it's a public function
  * exported from drivers/pci, use dma_supported instead */
@@ -15,11 +22,12 @@ pci_dma_supported(struct pci_dev *hwdev,
 	return dma_supported(hwdev == NULL ? NULL : &hwdev->dev, mask);
 }
 
+/* Would be better to move this out of line. It's already quite big. */
 static inline void *
 pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
 		     dma_addr_t *dma_handle)
 {
-	return dma_alloc_coherent(hwdev == NULL ? NULL : &hwdev->dev, size, dma_handle, GFP_ATOMIC);
+	return dma_alloc_coherent(hwdev == NULL ? NULL : &hwdev->dev, size, dma_handle, preempt_atomic() ? GFP_ATOMIC : GFP_KERNEL);
 }
 
 static inline void
