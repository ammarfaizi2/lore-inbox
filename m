Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbSLaOwk>; Tue, 31 Dec 2002 09:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbSLaOwk>; Tue, 31 Dec 2002 09:52:40 -0500
Received: from host194.steeleye.com ([66.206.164.34]:3343 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S262871AbSLaOwj>; Tue, 31 Dec 2002 09:52:39 -0500
Message-Id: <200212311500.gBVF0qZ01875@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: David Brownell <david-b@pacbell.net>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic device DMA (dma_pool update) 
In-Reply-To: Message from David Brownell <david-b@pacbell.net> 
   of "Mon, 30 Dec 2002 15:11:19 PST." <3E10D297.1090206@pacbell.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Dec 2002 09:00:50 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think a much easier way of doing this would be a slight modification to the 
current pci_pool code: we know it works already.  All that really has to 
change is that it should take a struct device instead of a pci_dev and it 
should call dma_alloc_coherent to get the source memory.  The rest of the pci 
pool code is mainly about memory management and is well tested and so should 
remain (much as I'd like to see a mempool implementation).

You have this in your code:

+void *
+dma_alloc (struct device *dev, size_t size, dma_addr_t *handle, int mem_flags)
+{
+	struct pci_dev	*pdev = to_pci_dev(dev);
+
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	if (size >= PAGE_SIZE)
+		return pci_alloc_consistent (pdev, size, handle);

This would work if just passed to dma_alloc_coherent and drop the check for 
the pci_bus_type (If the dma_ APIs are implemented in terms of the pci_ ones, 
then they will bug out in the generic implementation of dma_alloc_coherent so 
there's no need to do this type of transform twice).

This:

+dma_alloc (struct device *dev, size_t size, dma_addr_t *handle, int mem_flags)
+{
+	void	*ret;
+
+	/* We rely on kmalloc memory being aligned to L1_CACHE_BYTES, to
+	 * prevent cacheline sharing during DMA.  With dma-incoherent caches,
+	 * such sharing causes bugs, not just cache-related slowdown.
+	 */
+	ret = kmalloc (size, mem_flags | __dma_slab_flags (dev));
+	if (likely (ret != 0))
+		*handle = virt_to_phys (ret);
+	return ret;

Just can't be done: you can't get consistent memory from kmalloc and you 
certainly can't use virt_to_phys and expect it to work on IOMMU hardware.

James






