Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVBLBYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVBLBYv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 20:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVBLBYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 20:24:51 -0500
Received: from fmr22.intel.com ([143.183.121.14]:17042 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261807AbVBLBYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 20:24:49 -0500
Date: Fri, 11 Feb 2005 17:24:39 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: [PATCH] kmalloc() bug in pci-dma.c
Message-ID: <20050211172439.A21261@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After burning my fingers with a similar mistake in one of the patches 
that I am working on, I did a quick grep to find out all faulty kmalloc() 
calls and found this.

dma_declare_coherent_memory() is calling kmalloc with wrong arguments. 
Attached patch fixes this.

Please apply.

Thanks,
Venki

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

--- linux-2.6.10/arch/i386/kernel/pci-dma.c.org	2005-02-11 15:18:42.596362296 -0800
+++ linux-2.6.10/arch/i386/kernel/pci-dma.c	2005-02-11 15:19:18.446912184 -0800
@@ -89,11 +89,11 @@ int dma_declare_coherent_memory(struct d
 	if (!mem_base)
 		goto out;
 
-	dev->dma_mem = kmalloc(GFP_KERNEL, sizeof(struct dma_coherent_mem));
+	dev->dma_mem = kmalloc(sizeof(struct dma_coherent_mem), GFP_KERNEL);
 	if (!dev->dma_mem)
 		goto out;
 	memset(dev->dma_mem, 0, sizeof(struct dma_coherent_mem));
-	dev->dma_mem->bitmap = kmalloc(GFP_KERNEL, bitmap_size);
+	dev->dma_mem->bitmap = kmalloc(bitmap_size, GFP_KERNEL);
 	if (!dev->dma_mem->bitmap)
 		goto free1_out;
 	memset(dev->dma_mem->bitmap, 0, bitmap_size);
