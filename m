Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWCJV2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWCJV2l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 16:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWCJV2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 16:28:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20890 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751018AbWCJV2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 16:28:40 -0500
Date: Fri, 10 Mar 2006 13:28:38 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: skge/sk98lin slowdown with 4 Gb memory compared to 2 Gb memory
Message-ID: <20060310132838.7cd176f4@localhost.localdomain>
In-Reply-To: <20060310202929.GA7308@amd64.of.nowhere>
References: <20060310202929.GA7308@amd64.of.nowhere>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suspect the optimization (in other drivers as well) that doesn't set 64 bit mask
unless dma addresses are 64 bit. The problem would go away if you config for 64G of
memory.

This unconditionally sets 64 bit mask, does it change the situation?

--- linux-2.6.orig/drivers/net/skge.c	2006-03-10 13:26:29.000000000 -0800
+++ linux-2.6/drivers/net/skge.c	2006-03-10 13:12:38.000000000 -0800
@@ -3265,16 +3265,10 @@
 
 	pci_set_master(pdev);
 
-	if (sizeof(dma_addr_t) > sizeof(u32) &&
-	    !(err = pci_set_dma_mask(pdev, DMA_64BIT_MASK))) {
+	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK) &&
+	    !pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK))
 		using_dac = 1;
-		err = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
-		if (err < 0) {
-			printk(KERN_ERR PFX "%s unable to obtain 64 bit DMA "
-			       "for consistent allocations\n", pci_name(pdev));
-			goto err_out_free_regions;
-		}
-	} else {
+	else {
 		err = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (err) {
 			printk(KERN_ERR PFX "%s no usable DMA configuration\n",
