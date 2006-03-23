Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWCWRUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWCWRUU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWCWRUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:20:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:14525 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751074AbWCWRUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:20:17 -0500
From: Andi Kleen <ak@suse.de>
To: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH 2/3] x86-64: Calgary IOMMU - Calgary specific bits
Date: Thu, 23 Mar 2006 17:31:32 +0100
User-Agent: KMail/1.9.1
Cc: Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
References: <20060320084848.GA21729@granada.merseine.nu> <20060320085416.GB21729@granada.merseine.nu>
In-Reply-To: <20060320085416.GB21729@granada.merseine.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603231731.34097.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 March 2006 09:54, Muli Ben-Yehuda wrote:

> +/* register offsets inside the PHB space */


Call it host bridge here.

> +void* tce_table_kva[MAX_NUM_OF_PHBS * MAX_NUM_NODES];
> +unsigned int specified_table_size = TCE_TABLE_SIZE_UNSPECIFIED;

Why are these not static too?

> +static int translate_empty_slots __read_mostly = 0;
> +static int calgary_detected __read_mostly = 0;
> +
> +static void tce_cache_blast(struct iommu_table *tbl);
> +
> +/* enable this to stress test the chip's TCE cache */
> +#undef BLAST_TCE_CACHE_ON_UNMAP

This should be probably hooked into iommu=debug / CONFIG_IOMMU_DEBUG

> +static inline int valid_dma_direction(int dma_direction)
> +{
> +	return ((dma_direction == DMA_BIDIRECTIONAL) ||
> +		(dma_direction == DMA_TO_DEVICE) ||
> +		(dma_direction == DMA_FROM_DEVICE));
> +}

Don't we already check that in the callers?


> +
> +	offset = find_next_zero_string(tbl->it_map, tbl->it_hint,
> +				       tbl->it_size, npages);
> +	if (offset == ~0UL) {
> +		tce_cache_blast(tbl);
> +		offset = find_next_zero_string(tbl->it_map, 0,
> +					       tbl->it_size, npages);
> +		if (offset == ~0UL)
> +			panic("Calgary: IOMMU full, fix the allocator.\n");

This should properly error out, not panic.


> +static dma_addr_t iommu_alloc(struct iommu_table *tbl, void *vaddr,
> +	unsigned int npages, int direction)
> +{
> +	unsigned long entry, flags;
> +	dma_addr_t ret = bad_dma_address;
> +
> +	spin_lock_irqsave(&tbl->it_lock, flags);
> +
> +	entry = iommu_range_alloc(tbl, npages);
> +
> +	ret = entry << PAGE_SHIFT; /* set the return dma address */
> +
> +	if (unlikely(ret == bad_dma_address))
> +		goto error;
> +
> +	/* put the TCEs in the HW table */
> +	tce_build(tbl, entry, npages, (unsigned long)vaddr & PAGE_MASK,
> +		  direction);
> +	/* make sure HW sees the new TCEs */
> +	mb();
> +
> +	spin_unlock_irqrestore(&tbl->it_lock, flags);
> +
> +	return ret;

Does this imply vaddr is always page aligned? Otherwise you would need
to add the offset into the page.


> +	BUG_ON(!tbl);
> +
> +	spin_lock_irqsave(&tbl->it_lock, flags);

That is a useless BUG_ON. More occurrences.

> +	/* make sure updates are seen by hardware */
> +	mb();

Doesn't make sense on x86-64.


> +	dma_handle = iommu_alloc(tbl, vaddr, npages, direction);
> +	if (dma_handle != bad_dma_address)
> +		dma_handle |= (uaddr & ~PAGE_MASK);

Would be cleaner to do it in iommu_alloc



+
> +static inline unsigned long split_queue_offset(unsigned char num)
etc.

Looks like these all should be array lookups.
+
> +	/* avoid the BIOS/VGA first 640KB-1MB region */
> +	start = (640 * 1024);
> +	npages = ((1024 - 640) * 1024) >> PAGE_SHIFT;
> +	iommu_range_reserve(tbl, start, npages);

Why only those and not the other PCI holes? And why at all?


> +static int __init calgary_setup_tar(struct pci_dev *dev, void __iomem *bbar)
> +{
> +	u64 val64;
> +	u64 table_phys;
> +	void __iomem *target;
> +	int ret;
> +	struct iommu_table *tbl;
> +
> +	/* build TCE tables for each PHB */
> +	ret = build_tce_table(dev, bbar);
> +	if (ret)
> +		goto done;

That's a useless goto

>
> +done:
> +	return ret;
> +}
> +
> +static void __init calgary_free_tar(struct pci_dev *dev)
> +{
> +	u64 val64;
> +	struct iommu_table *tbl = dev->sysdata;
> +	void __iomem *target;
> +
> +	target = calgary_reg(tbl->bbar, tar_offset(dev->bus->number));
> +	val64 = be64_to_cpu(readq(target));
> +	val64 &= ~TAR_SW_BITS;
> +	writeq(cpu_to_be64(val64), target);
> +	readq(target); /* flush */
> +
> +	kfree(tbl);
> +	dev->sysdata = NULL;

We already use dev->sysdata for the NUMA topology information from ACPI.
I think that will conflict. You need to define a new structure for 
all users.

> +	/*
> +	 * FE0MB-8MB*OneBasedChassisNumber+1MB*(RioNodeId-ChassisBase)
> +	 * ChassisBase is always zero for x366/x260/x460
> +	 * RioNodeId is 2 for first Calgary, 3 for second Calgary
> +	 */
> +	address = 0xfe000000 - (0x800000 * (1 + dev->bus->number / 15)) +
> +		(0x100000) * (nodeid - 0);


Nasty magic numbers all over.

> +	return address;
> +}
> +
> +static int __init calgary_init_one(struct pci_dev *dev)
> +{
> +	u32 address;
> +	void __iomem *bbar;
> +	int ret;
> +
> +	address = locate_register_space(dev);
> +	/* map entire 1MB of Calgary config space */
> +	bbar = ioremap(address, 1024 * 1024);

ioremap_nocache

Where exactly is the isolation enabled?

> +	printk(KERN_INFO "PCI-DMA: detecting Calgary chipset...\n");

I want it to be quiet if Calgary is not there please.

> +	for (bus = 0, calgary = 0;
> +	     bus < MAX_NUM_OF_PHBS * num_online_nodes() * 2;
> +	     bus++) {

Yuck another full scan. We're nearly over the threshold where whoever
adds more of these has to write a proper function to encapsulate and possibly
cache all that.

> +		BUG_ON(bus >= MAX_PHB_BUS_NUM * MAX_NUM_NODES);
> +		if (read_pci_config(bus, 0, 0, 0) != PCI_VENDOR_DEVICE_ID_CALGARY)
> +			continue;

> +		printk(KERN_ERR "PCI-DMA: Calgary init failed %x, "
> +		       "falling back to no_iommu\n", ret);

Shouldn't it rather fall back to swiotlb?

> +		if (end_pfn > MAX_DMA32_PFN)
> +			printk(KERN_ERR "WARNING more than 4GB of memory, "
> +					"32bit PCI may malfunction.\n");
> +		return ret;
> +	}
> +
> +	force_iommu = 1;

Why that?

> +	dma_ops = &calgary_dma_ops;
> +
> +	return ret;
> +}
> +
> +void __init calgary_parse_options(char *p)
> +{
> +	while (*p) {
> +		if (!strncmp(p, "64k", 3))
> +			specified_table_size = TCE_TABLE_SIZE_64K;
> +		else if (!strncmp(p, "128k", 4))
> +			specified_table_size = TCE_TABLE_SIZE_128K;
> +		else if (!strncmp(p, "256k", 4))
> +			specified_table_size = TCE_TABLE_SIZE_256K;
> +		else if (!strncmp(p, "512k", 4))
> +			specified_table_size = TCE_TABLE_SIZE_512K;
> +		else if (!strncmp(p, "1M", 2))
> +			specified_table_size = TCE_TABLE_SIZE_1M;
> +		else if (!strncmp(p, "2M", 2))
> +			specified_table_size = TCE_TABLE_SIZE_2M;
> +		else if (!strncmp(p, "4M", 2))
> +			specified_table_size = TCE_TABLE_SIZE_4M;
> +		else if (!strncmp(p, "8M", 2))
> +			specified_table_size = TCE_TABLE_SIZE_8M;

You forgot to document all these in Documentation/x86_64


> +	tce_free(tbl, 0, tbl->it_size);
> +	mb(); /* flush TCE table update */

I don't think it will do anything on x86-64


> +	p = __alloc_bootmem_low(size, size, 0);
> +	if (!p)
> +		printk(KERN_ERR "Calgary: cannot allocate TCE table of "
> +		       "size 0x%x\n", size);

It won't - it will panic. I have a patch to add alloc_bootmem_nopanic queued
though. You should use that later.

I would like to see a printk and some comments about the full isolation
because it's a big change. How does it interact with the X server for once?

The patch is not self contained because it doesn't have Kconfig?

-Andi
