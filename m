Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbTERF4P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 01:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbTERF4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 01:56:15 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:31756
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261989AbTERF4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 01:56:10 -0400
Date: Sat, 17 May 2003 23:00:26 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jes Sorensen <jes@wildopensource.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>, James.Bottomley@steeleye.com,
       Grant Grundler <grundler@dsl2.external.hp.com>,
       Colin Ngam <cngam@sgi.com>, Jeremy Higdon <jeremy@sgi.com>,
       linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org, wildos@sgi.com
Subject: Re: [patch] support 64 bit pci_alloc_consistent
In-Reply-To: <16071.1892.811622.257847@trained-monkey.org>
Message-ID: <Pine.LNX.4.10.10305172259220.23972-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jes,

Thumbs up here, as I will need this for 47bit DMA mapping for SATA/SAS.

Please adopt!

Andre Hedrick
LAD Storage Consulting Group

On Sun, 18 May 2003, Jes Sorensen wrote:

> Hi Linus,
> 
> This is patch which provides support for 64 bit address allocations from
> pci_alloc_consistent(), based on the address mask set through
> pci_set_consistent_dma_mask(). This is necessary on some platforms which
> are unable to provide physical memory in the lower 4GB block and do not
> provide IOMMU support for cards operating in certain bus modes, such as
> PCI-X on the SGI SN2.
> 
> The default mask for pci_alloc_consistent() is still 32 bit as there are
> 64 bit capable hardware out there that doesn't support 64 bit addresses
> for descripters etc. Likewise, platforms which provide IOMMU support in
> all bus modes can ignore struct pci_dev->consistent_dma_mask and just
> return a 32 bit address as before.
> 
> The patch also includes changes to tg3.c to make it use the new api as
> well as a documentation update. I have done my best on the documentation
> part, if anyone feel the can make my scribbles clearer, please do.
> 
> Thanks to Dave Miller, Grant Grundler, James Bottomley, Colin Ngam, and
> Jeremy Higdon for input and code/documentation portions.
> 
> This patch should apply cleanly to 2.5.69-bk12.
> 
> Thanks,
> Jes
> 
> diff -urN -X /home/jes/exclude-linux linux-2.5.69-030509-vanilla/Documentation/DMA-mapping.txt linux-2.5.69-pci/Documentation/DMA-mapping.txt
> --- linux-2.5.69-030509-vanilla/Documentation/DMA-mapping.txt	Sun May  4 19:53:31 2003
> +++ linux-2.5.69-pci/Documentation/DMA-mapping.txt	Sat May 17 23:32:16 2003
> @@ -83,6 +83,15 @@
>  to be increased.  And for a device with limitations, as discussed in
>  the previous paragraph, it needs to be decreased.
>  
> +pci_alloc_consistent() by default will return 32-bit DMA addresses.
> +PCI-X specification requires PCI-X devices to support 64-bit
> +addressing (DAC) for all transactions. And at least one platform (SGI
> +SN2) requires 64-bit consistent allocations to operate correctly when
> +the IO bus is in PCI-X mode. Therefore, like with pci_set_dma_mask(),
> +it's good practice to call pci_set_consistent_dma_mask() to set the
> +appropriate mask even if your device only supports 32-bit DMA
> +(default) and especially if it's a PCI-X device.
> +
>  For correct operation, you must interrogate the PCI layer in your
>  device probe routine to see if the PCI controller on the machine can
>  properly support the DMA addressing limitation your device has.  It is
> @@ -94,6 +103,11 @@
>  
>  	int pci_set_dma_mask(struct pci_dev *pdev, u64 device_mask);
>  
> +The query for consistent allocations is performed via a a call to
> +pci_set_consistent_dma_mask():
> +
> +	int pci_set_consistent_dma_mask(struct pci_dev *pdev, u64 device_mask);
> +
>  Here, pdev is a pointer to the PCI device struct of your device, and
>  device_mask is a bit mask describing which bits of a PCI address your
>  device supports.  It returns zero if your card can perform DMA
> @@ -133,7 +147,7 @@
>  Sparc64 is one platform which behaves in this way.
>  
>  Here is how you would handle a 64-bit capable device which can drive
> -all 64-bits during a DAC cycle:
> +all 64-bits when accessing streaming DMA:
>  
>  	int using_dac;
>  
> @@ -147,6 +161,30 @@
>  		goto ignore_this_device;
>  	}
>  
> +If a card is capable of using 64-bit consistent allocations as well,
> +the case would look like this:
> +
> +	int using_dac, consistent_using_dac;
> +
> +	if (!pci_set_dma_mask(pdev, 0xffffffffffffffff)) {
> +		using_dac = 1;
> +	   	consistent_using_dac = 1;
> +		pci_set_consistent_dma_mask(pdev, 0xffffffffffffffff)
> +	} else if (!pci_set_dma_mask(pdev, 0xffffffff)) {
> +		using_dac = 0;
> +		consistent_using_dac = 0;
> +		pci_set_consistent_dma_mask(pdev, 0xffffffff)
> +	} else {
> +		printk(KERN_WARNING
> +		       "mydev: No suitable DMA available.\n");
> +		goto ignore_this_device;
> +	}
> +
> +pci_set_consistent_dma_mask() will always be able to set the same or a
> +smaller mask as pci_set_dma_mask(). However for the rare case that a
> +device driver only uses consistent allocations, one would have to
> +check the return value from pci_set_consistent().
> +
>  If your 64-bit device is going to be an enormous consumer of DMA
>  mappings, this can be problematic since the DMA mappings are a
>  finite resource on many platforms.  Please see the "DAC Addressing
> @@ -215,9 +253,10 @@
>  
>    Think of "consistent" as "synchronous" or "coherent".
>  
> -  Consistent DMA mappings are always SAC addressable.  That is
> -  to say, consistent DMA addresses given to the driver will always
> -  be in the low 32-bits of the PCI bus space.
> +  The current default is to return consistent memory in the low 32
> +  bits of the PCI bus space.  However, for future compatibility you
> +  should set the consistent mask even if this default is fine for your
> +  driver.
>  
>    Good examples of what to use consistent mappings for are:
>  
> @@ -287,15 +326,14 @@
>  driver needs regions sized smaller than a page, you may prefer using
>  the pci_pool interface, described below.
>  
> -The consistent DMA mapping interfaces, for non-NULL dev, will always
> -return a DMA address which is SAC (Single Address Cycle) addressable.
> -Even if the device indicates (via PCI dma mask) that it may address
> -the upper 32-bits and thus perform DAC cycles, consistent allocation
> -will still only return 32-bit PCI addresses for DMA.  This is true
> -of the pci_pool interface as well.
> -
> -In fact, as mentioned above, all consistent memory provided by the
> -kernel DMA APIs are always SAC addressable.
> +The consistent DMA mapping interfaces, for non-NULL dev, will by
> +default return a DMA address which is SAC (Single Address Cycle)
> +addressable.  Even if the device indicates (via PCI dma mask) that it
> +may address the upper 32-bits and thus perform DAC cycles, consistent
> +allocation will only return > 32-bit PCI addresses for DMA if the
> +consistent dma mask has been explicitly changed via
> +pci_set_consistent_dma_mask().  This is true of the pci_pool interface
> +as well.
>  
>  pci_alloc_consistent returns two values: the virtual address which you
>  can use to access it from the CPU and dma_handle which you pass to the
> diff -urN -X /home/jes/exclude-linux linux-2.5.69-030509-vanilla/drivers/net/tg3.c linux-2.5.69-pci/drivers/net/tg3.c
> --- linux-2.5.69-030509-vanilla/drivers/net/tg3.c	Sun May  4 19:53:31 2003
> +++ linux-2.5.69-pci/drivers/net/tg3.c	Sat May 17 11:49:43 2003
> @@ -6400,8 +6400,7 @@
>  	tw32(BUFMGR_MODE, 0);
>  	tw32(FTQ_RESET, 0);
>  
> -	/* pci_alloc_consistent gives only non-DAC addresses */
> -	test_desc.addr_hi = 0;
> +	test_desc.addr_hi = ((u64) buf_dma) >> 32;
>  	test_desc.addr_lo = buf_dma & 0xffffffff;
>  	test_desc.nic_mbuf = 0x00002100;
>  	test_desc.len = size;
> @@ -6743,6 +6742,12 @@
>  	/* Configure DMA attributes. */
>  	if (!pci_set_dma_mask(pdev, (u64) 0xffffffffffffffff)) {
>  		pci_using_dac = 1;
> +		if (pci_set_consistent_dma_mask(pdev,
> +						(u64) 0xffffffffffffffff)) {
> +			printk(KERN_ERR PFX "Unable to obtain 64 bit DMA "
> +			       "for consistent allocations\n");
> +			goto err_out_free_res;
> +		}
>  	} else {
>  		err = pci_set_dma_mask(pdev, (u64) 0xffffffff);
>  		if (err) {
> diff -urN -X /home/jes/exclude-linux linux-2.5.69-030509-vanilla/drivers/pci/pci.c linux-2.5.69-pci/drivers/pci/pci.c
> --- linux-2.5.69-030509-vanilla/drivers/pci/pci.c	Sun May  4 19:53:08 2003
> +++ linux-2.5.69-pci/drivers/pci/pci.c	Fri May 16 15:43:44 2003
> @@ -701,6 +701,17 @@
>  	return 0;
>  }
>  
> +int
> +pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
> +{
> +	if (!pci_dma_supported(dev, mask))
> +		return -EIO;
> +
> +	dev->consistent_dma_mask = mask;
> +
> +	return 0;
> +}
> +     
>  static int __devinit pci_init(void)
>  {
>  	struct pci_dev *dev;
> @@ -751,6 +762,7 @@
>  EXPORT_SYMBOL(pci_clear_mwi);
>  EXPORT_SYMBOL(pci_set_dma_mask);
>  EXPORT_SYMBOL(pci_dac_set_dma_mask);
> +EXPORT_SYMBOL(pci_set_consistent_dma_mask);
>  EXPORT_SYMBOL(pci_assign_resource);
>  EXPORT_SYMBOL(pci_find_parent_resource);
>  
> diff -urN -X /home/jes/exclude-linux linux-2.5.69-030509-vanilla/drivers/pci/probe.c linux-2.5.69-pci/drivers/pci/probe.c
> --- linux-2.5.69-030509-vanilla/drivers/pci/probe.c	Sun May  4 19:53:35 2003
> +++ linux-2.5.69-pci/drivers/pci/probe.c	Fri May 16 15:44:40 2003
> @@ -502,6 +502,7 @@
>  	/* Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
>  	   set this higher, assuming the system even supports it.  */
>  	dev->dma_mask = 0xffffffff;
> +	dev->consistent_dma_mask = 0xffffffff;
>  	if (pci_setup_device(dev) < 0) {
>  		kfree(dev);
>  		return NULL;
> diff -urN -X /home/jes/exclude-linux linux-2.5.69-030509-vanilla/include/linux/pci.h linux-2.5.69-pci/include/linux/pci.h
> --- linux-2.5.69-030509-vanilla/include/linux/pci.h	Sun May  4 19:53:14 2003
> +++ linux-2.5.69-pci/include/linux/pci.h	Fri May 16 15:42:55 2003
> @@ -390,6 +390,11 @@
>  					   or supports 64-bit transfers.  */
>  	struct list_head pools;		/* pci_pools tied to this device */
>  
> +	u64		consistent_dma_mask;/* Like dma_mask, but for
> +					       pci_alloc_consistent mappings as
> +					       not all hardware supports
> +					       64 bit addresses for consistent
> +					       allocations such descriptors. */
>  	u32             current_state;  /* Current operating state. In ACPI-speak,
>  					   this is D0-D3, D0 being fully functional,
>  					   and D3 being off. */
> @@ -614,6 +619,7 @@
>  void pci_clear_mwi(struct pci_dev *dev);
>  int pci_set_dma_mask(struct pci_dev *dev, u64 mask);
>  int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask);
> +int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
>  int pci_assign_resource(struct pci_dev *dev, int i);
>  
>  /* Power management related routines */
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

