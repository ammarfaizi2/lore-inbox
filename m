Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbUCIEln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 23:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbUCIEln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 23:41:43 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:62350 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S261535AbUCIElk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 23:41:40 -0500
Date: Mon, 8 Mar 2004 21:41:38 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: linux-kernel@vger.kernel.org
Subject: pci_set_dma_mask()/pci_dma_supported() & broken PCI bridge issue
Message-ID: <20040309044138.GA9491@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Plexity Networks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am a bit confused about the proper way that dma_set_mask() should
behave. My situation is that I have an ARM core that has broken
PCI window, allowing DMA only to/from the lower 64MB of RAM. My
current approach to get around this is custom dma-API functions
that trap based on (dev->bus == &pci_bus_type && *dev->dma_mask !=
0xfffffff). If dma_mask is 0xfffffff, I use the generic ARM dma API
implementation, otherwise I call my platform-specific functions
that bounce buffers that are > 64MB.  I set the dma_mask to (64MB - 1) 
by hooking in a platform_notify() function and calling dma_set_mask()
if the device is a PCI device.

Everything was working fine with PCI IDE, EEPro100, and USB, but 
when I tried switching to Intel's e100 driver, the self test failed.  
Looking at the code, the cuplrit is the following line:

	if((err = pci_set_dma_mask(pdev, 0xFFFFFFFFULL))) {
		DPRINTK(PROBE, ERR, "No usable DMA configuration, aborting.\n");
		goto err_out_free_res;
	}

pci_set_dma_mask does:

int
pci_set_dma_mask(struct pci_dev *dev, u64 mask)
{
	if (!pci_dma_supported(dev, mask))
		return -EIO; 

	dev->dma_mask = mask;

	return 0;
}

Currently pci_dma_supported() on ARM returns 1 on 0xffffffff, so
the device's dma_mask gets updated and my code is no longer 
trapping the calls to the DMA API, so the self-test buffer
is getting allocated outside of the DMA-safe window and it
never gets updated by the device's write (A PCI analyzer confirms
this is the case). I can fix pci_dma_supported() to return 0 
on my platform if (dma_mask > 64MB), but this still leaves me
with an unusable driver b/c it will just bail out. 

My comment from this experience is that it seems that there needs to 
be a way for the platform code to tell the PCI layer "this dma mask you 
gave me is not supported, but here is what I can support" and the driver 
can decide if this is appropriate. The other option is to have the driver 
keep on trying smaller and smaller masks as Documentation/dma-mapping.txt 
describes. 

Perhaps a pci_get_dma_mask() so that drivers can see what
the current mask is set to? In that case, drivers could do:

	unsigned long long my_mask = 0x00ffffffULL;

	if(pci_get_dma_mask(pdev) > my_mask) {
		if(!pci_set_dma_mask(my_mask)) {
			bail_out;
		}
		... 	
	} else {
		/* We're OK on this platform */
		...
	}

Comments?

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/
