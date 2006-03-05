Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWCEILT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWCEILT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 03:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWCEILT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 03:11:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6077 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932290AbWCEILR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 03:11:17 -0500
Date: Sun, 5 Mar 2006 00:09:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: chris.leech@gmail.com
Cc: christopher.leech@intel.com, jeff@garzik.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 0/8] Intel I/O Acceleration Technology (I/OAT)
Message-Id: <20060305000933.2d799138.akpm@osdl.org>
In-Reply-To: <41b516cb0603031439n13e4df4cg8e5b21b606d2b4b8@mail.gmail.com>
References: <20060303214036.11908.10499.stgit@gitlost.site>
	<4408C2CA.5010909@garzik.org>
	<41b516cb0603031439n13e4df4cg8e5b21b606d2b4b8@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chris Leech" <christopher.leech@intel.com> wrote:
>
> > Patch #2 didn't make it.  Too big for the list?
> 
>  Could be, it's the largest of the series.  I've attached the gziped
>  patch.  I can try and split this up for the future.
>
> ..
>
> [I/OAT] Driver for the Intel(R) I/OAT DMA engine
> Adds a new ioatdma driver
> 
> ...
> +struct cb_pci_pmcap_register {
> +	uint32_t	capid:8;	/* RO: 01h */
> +	uint32_t	nxtcapptr:8;
> +	uint32_t	version:3;	/* RO: 010b */
> +	uint32_t	pmeclk:1;	/* RO: 0b */
> +	uint32_t	reserved:1;	/* RV: 0b */
> +	uint32_t	dsi:1;		/* RO: 0b */
> +	uint32_t	aux_current:3;	/* RO: 000b */
> +	uint32_t	d1_support:1;	/* RO: 0b */
> +	uint32_t	d2_support:1;	/* RO: 0b */
> +	uint32_t	pme_support:5;	/* RO: 11001b */
> +};

This maps onto hardware registers?  No big-endian plans in Intel's future? ;)

I have a vague feeling that gcc changed its layout of bitfields many years
ago.  I guess we're fairly safe against that.  Presumably gcc and icc use the
same layout?

Still.  It's a bit of a concern, but I guess we can worry about that if it
happens.

> +
> +static inline u8 read_reg8(struct cb_device *device, unsigned int offset)
> +{
> +	return readb(device->reg_base + offset);
> +}

These are fairly generic-sounding names.  In fact the as-yet-unmerged tiacx
wireless driver is already using these, privately to
drivers/net/wireless/tiacx/pci.c.

> +static int enumerate_dma_channels(struct cb_device *device)
> +{
> +	u8 xfercap_scale;
> +	u32 xfercap;
> +	int i;
> +	struct cb_dma_chan *cb_chan;
> +
> +	device->common.chancnt = read_reg8(device, CB_CHANCNT_OFFSET);
> +	xfercap_scale = read_reg8(device, CB_XFERCAP_OFFSET);
> +	xfercap = (xfercap_scale == 0 ? ~0UL : (1 << xfercap_scale));

I recommend using just "-1" to represent the all-ones pattern.  It simply
works, in all situations.

Where you _did_ want the UL was after that "1".

> +	for (i = 0; i < device->common.chancnt; i++) {
> +		cb_chan = kzalloc(sizeof(*cb_chan), GFP_KERNEL);
> +		if (!cb_chan)
> +			return -ENOMEM;

memory leak?

> +		cb_chan->device = device;
> +		cb_chan->reg_base = device->reg_base + (0x80 * (i + 1));
> +		cb_chan->xfercap = xfercap;
> +		spin_lock_init(&cb_chan->cleanup_lock);
> +		spin_lock_init(&cb_chan->desc_lock);
> +		INIT_LIST_HEAD(&cb_chan->free_desc);
> +		INIT_LIST_HEAD(&cb_chan->used_desc);
> +		/* This should be made common somewhere in dmaengine.c */
> +		cb_chan->common.device = &device->common;
> +		cb_chan->common.client = NULL;
> +		list_add_tail(&cb_chan->common.device_node, &device->common.channels);

No locking needed for that list?

> +static struct cb_desc_sw * cb_dma_alloc_descriptor(struct cb_dma_chan *cb_chan)

There's a mix of styles here.  I don't think the space after the asterisk does
anything useful, and it could be argued that it's incorrect (or misleading)
wrt C declaration semantics.

> +{
> +	struct cb_dma_descriptor *desc;

What do all these "cb"'s stand for, anyway?

> +	struct cb_desc_sw *desc_sw;
> +	struct cb_device *cb_device = to_cb_device(cb_chan->common.device);
> +	dma_addr_t phys;
> +
> +	desc = pci_pool_alloc(cb_device->dma_pool, GFP_ATOMIC, &phys);
> +	if (!desc)
> +		return NULL;
> +
> +	desc_sw = kzalloc(sizeof(*desc_sw), GFP_ATOMIC);

GFP_ATOMIC is to be avoided if at all possible.  It stresses the memory system
and can easily fail under load.

>From my reading, two of the callers could trivially call this function outside
spin_lock_bh() and the third could perhaps do so with a little work.  You
could at least fix up two of those callers, and pass in the gfp_flags.


<wonders why the heck dma_pool_alloc() uses SLAB_ATOMIC when the caller's
passing in the gfp_flags>

> +/* returns the actual number of allocated descriptors */
> +static int cb_dma_alloc_chan_resources(struct dma_chan *chan)
> +{
> ...
> +	/* Allocate descriptors */
> +	spin_lock_bh(&cb_chan->desc_lock);
> +	for (i = 0; i < INITIAL_CB_DESC_COUNT; i++) {
> +		desc = cb_dma_alloc_descriptor(cb_chan);
> +		if (!desc) {
> +			printk(KERN_ERR "CB: Only %d initial descriptors\n", i);
> +			break;
> +		}
> +		list_add_tail(&desc->node, &cb_chan->free_desc);
> +	}
> +	spin_unlock_bh(&cb_chan->desc_lock);

Here's one such caller.

> +
> +static void cb_dma_free_chan_resources(struct dma_chan *chan)
> +{
> +	struct cb_dma_chan *cb_chan = to_cb_chan(chan);
> +	struct cb_device *cb_device = to_cb_device(chan->device);
> +	struct cb_desc_sw *desc, *_desc;
> +	u16 chanctrl;
> +	int in_use_descs = 0;
> +
> +	cb_dma_memcpy_cleanup(cb_chan);
> +
> +	chan_write_reg8(cb_chan, CB_CHANCMD_OFFSET, CB_CHANCMD_RESET);
> +
> +	spin_lock_bh(&cb_chan->desc_lock);
> +	list_for_each_entry_safe(desc, _desc, &cb_chan->used_desc, node) {
> +		in_use_descs++;
> +		list_del(&desc->node);
> +		pci_pool_free(cb_device->dma_pool, desc->hw, desc->phys);
> +		kfree(desc);
> +	}
> +	list_for_each_entry_safe(desc, _desc, &cb_chan->free_desc, node) {
> +		list_del(&desc->node);
> +		pci_pool_free(cb_device->dma_pool, desc->hw, desc->phys);
> +		kfree(desc);
> +	}
> +	spin_unlock_bh(&cb_chan->desc_lock);

Do we actually need the lock there?  If we're freeing everything which it
protects anwyay?

> +
> +static void cb_dma_memcpy_cleanup(struct cb_dma_chan *chan)
> +{
> +	unsigned long phys_complete;
> +	struct cb_desc_sw *desc, *_desc;
> +	dma_cookie_t cookie = 0;
> +
> +	prefetch(chan->completion_virt);
> +
> +	if (!spin_trylock(&chan->cleanup_lock))
> +		return;

What's going on here?  Lock ranking problems?  spin_trylock() in
non-infrastructural code is a bit of a red flag.

Whatever the reason, it needs a comment in there please.  That comment should
also explain why simply baling out is acceptable.

> +
> +static irqreturn_t cb_do_interrupt(int irq, void *data, struct pt_regs *regs)
> +{
> +	struct cb_device *instance = data;
> +	unsigned long attnstatus;
> +	u8 intrctrl;
> +
> +	intrctrl = read_reg8(instance, CB_INTRCTRL_OFFSET);
> +
> +	if (!(intrctrl & CB_INTRCTRL_MASTER_INT_EN)) {
> +		return IRQ_NONE;
> +	}

braces.

> +	attnstatus = (unsigned long) read_reg32(instance, CB_ATTNSTATUS_OFFSET);

Unneeded cast.

> +static void cb_start_null_desc(struct cb_dma_chan *cb_chan)
> +{
> +	struct cb_desc_sw *desc;
> +
> +	spin_lock_bh(&cb_chan->desc_lock);
> +
> +	if (!list_empty(&cb_chan->free_desc)) {
> +		desc = to_cb_desc(cb_chan->free_desc.next);
> +		list_del(&desc->node);
> +	} else {
> +		/* try to get another desc */
> +		desc = cb_dma_alloc_descriptor(cb_chan);
> +		/* will this ever happen? */
> +		BUG_ON(!desc);
> +	}
> +
> +	desc->hw->ctl = CB_DMA_DESCRIPTOR_NUL;
> +	desc->hw->next = 0;
> +
> +	list_add_tail(&desc->node, &cb_chan->used_desc);
> +
> +#if (BITS_PER_LONG == 64)
> +	chan_write_reg64(cb_chan, CB_CHAINADDR_OFFSET, desc->phys);
> +#else
> +	chan_write_reg32(cb_chan, CB_CHAINADDR_OFFSET_LOW, (u32) desc->phys);
> +	chan_write_reg32(cb_chan, CB_CHAINADDR_OFFSET_HIGH, 0);
> +#endif
> +	chan_write_reg8(cb_chan, CB_CHANCMD_OFFSET, CB_CHANCMD_START);
> +
> +	spin_unlock_bh(&cb_chan->desc_lock);
> +}

Can the chan_write*() calls be moved outside the locked region?

> +/*
> + * Perform a CB transaction to verify the HW works.
> + */

Damn, I wish I knew what CB meant.

> +#define CB_TEST_SIZE 2000
> +
> +static int cb_self_test(struct cb_device *device)
> +{
> +	int i;
> +	u8 *src;
> +	u8 *dest;
> +	struct dma_chan *dma_chan;
> +	dma_cookie_t cookie;
> +	int err = 0;
> +
> +	src = kzalloc(sizeof(u8) * CB_TEST_SIZE, SLAB_KERNEL);
> +	if (!src)
> +		return -ENOMEM;
> +	dest = kzalloc(sizeof(u8) * CB_TEST_SIZE, SLAB_KERNEL);
> +	if (!dest) {
> +		kfree(src);
> +		return -ENOMEM;
> +	}
> +
> +	/* Fill in src buffer */
> +	for (i = 0; i < CB_TEST_SIZE; i++)
> +		src[i] = (u8)i;

memset?

> +	/* Start copy, using first DMA channel */
> +	dma_chan = container_of(device->common.channels.next, struct dma_chan, device_node);
> +
> +	cb_dma_alloc_chan_resources(dma_chan);

cb_dma_alloc_chan_resources() can fail.

> +	cookie = cb_dma_memcpy_buf_to_buf(dma_chan, dest, src, CB_TEST_SIZE);
> +	cb_dma_memcpy_issue_pending(dma_chan);
> +
> +	udelay(1000);

msleep(1) would be preferred.

> +static int __devinit cb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	int err;
> +	unsigned long mmio_start, mmio_len;
> +	void *reg_base;
> +	struct cb_device *device;
> +
> +	err = pci_enable_device(pdev);
> +	if (err)
> +		goto err_enable_device;
> +
> +	err = pci_set_dma_mask(pdev, DMA_64BIT_MASK);
> +	if (err)
> +		err = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
> +	if (err)
> +		goto err_set_dma_mask;
> +
> +	err = pci_request_regions(pdev, cb_pci_drv.name);
> +	if (err)
> +		goto err_request_regions;
> +
> +	mmio_start = pci_resource_start(pdev, 0);
> +	mmio_len = pci_resource_len(pdev, 0);
> +
> +	reg_base = ioremap(mmio_start, mmio_len);
> +	if (!reg_base) {
> +		err = -ENOMEM;
> +		goto err_ioremap;
> +	}
> +
> +	device = kzalloc(sizeof(*device), GFP_KERNEL);
> +	if (!device) {
> +		err = -ENOMEM;
> +		goto err_kzalloc;
> +	}
> +
> +	/* DMA coherent memory pool for DMA descriptor allocations */
> +	device->dma_pool = pci_pool_create("dma_desc_pool", pdev,
> +		sizeof(struct cb_dma_descriptor), 64, 0);
> +	if (!device->dma_pool) {
> +		err = -ENOMEM;
> +		goto err_dma_pool;
> +	}
> +
> +	device->completion_pool = pci_pool_create("completion_pool", pdev, sizeof(u64), SMP_CACHE_BYTES, SMP_CACHE_BYTES);
> +	if (!device->completion_pool) {
> +		err = -ENOMEM;
> +		goto err_completion_pool;
> +	}
> +
> +	device->pdev = pdev;
> +	pci_set_drvdata(pdev, device);
> +#ifdef CONFIG_PCI_MSI
> +	if (pci_enable_msi(pdev) == 0) {
> +		device->msi = 1;
> +	} else {
> +		device->msi = 0;
> +	}
> +#endif
> +	err = request_irq(pdev->irq, &cb_do_interrupt, SA_SHIRQ, "ioat",
> +		device);
> +	if (err)
> +		goto err_irq;
> +
> +	device->reg_base = reg_base;
> +
> +	write_reg8(device, CB_INTRCTRL_OFFSET, CB_INTRCTRL_MASTER_INT_EN);
> +	pci_set_master(pdev);
> +
> +	INIT_LIST_HEAD(&device->common.channels);
> +	enumerate_dma_channels(device);

enumerate_dma_channels() can fail.

> +	device->common.device_alloc_chan_resources = cb_dma_alloc_chan_resources;
> +	device->common.device_free_chan_resources = cb_dma_free_chan_resources;
> +	device->common.device_memcpy_buf_to_buf = cb_dma_memcpy_buf_to_buf;
> +	device->common.device_memcpy_buf_to_pg = cb_dma_memcpy_buf_to_pg;
> +	device->common.device_memcpy_pg_to_pg = cb_dma_memcpy_pg_to_pg;
> +	device->common.device_memcpy_complete = cb_dma_is_complete;
> +	device->common.device_memcpy_issue_pending = cb_dma_memcpy_issue_pending;
> +	printk(KERN_INFO "Intel(R) I/OAT DMA Engine found, %d channels\n",
> +		device->common.chancnt);
> +
> +	if ((err = cb_self_test(device)))
> +		goto err_self_test;
> +
> +	dma_async_device_register(&device->common);
> +
> +	return 0;
> +
> +err_self_test:
> +err_irq:
> +	pci_pool_destroy(device->completion_pool);
> +err_completion_pool:
> +	pci_pool_destroy(device->dma_pool);
> +err_dma_pool:
> +	kfree(device);
> +err_kzalloc:
> +	iounmap(reg_base);
> +err_ioremap:
> +	pci_release_regions(pdev);
> +err_request_regions:
> +err_set_dma_mask:

You might want a pci_disable_device() in here.

> +err_enable_device:
> +	return err;
> +}
> +
> +static void __devexit cb_remove(struct pci_dev *pdev)
> +{
> +	struct cb_device *device;
> +
> +	device = pci_get_drvdata(pdev);
> +	dma_async_device_unregister(&device->common);

pci_disable_device()?

> +	free_irq(device->pdev->irq, device);
> +#ifdef CONFIG_PCI_MSI
> +	if (device->msi)
> +		pci_disable_msi(device->pdev);
> +#endif
> +	pci_pool_destroy(device->dma_pool);
> +	pci_pool_destroy(device->completion_pool);
> +	iounmap(device->reg_base);
> +	pci_release_regions(pdev);
> +	kfree(device);
> +}
> +
> +/* MODULE API */
> +MODULE_VERSION("1.0");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Intel Corporation");
> +
> +static int __init cb_init_module(void)
> +{
> +	/* it's currently unsafe to unload this module */
> +	/* if forced, worst case is that rmmod hangs */

How come?

> +	if (THIS_MODULE != NULL)
> +		THIS_MODULE->unsafe = 1;
> +
> +	return pci_module_init(&cb_pci_drv);
> +}
> +



> +#define CB_LOW_COMPLETION_MASK		0xffffffc0
> +
> +extern struct list_head dma_device_list;
> +extern struct list_head dma_client_list;

It's strange to see extern decls for lists, but no decl for their lock.  A
comment might help.

> +struct cb_dma_chan {
> +
> +	void *reg_base;
> +
> +	dma_cookie_t completed_cookie;
> +	unsigned long last_completion;
> +
> +	u32 xfercap;	/* XFERCAP register value expanded out */
> +
> +	spinlock_t cleanup_lock;
> +	spinlock_t desc_lock;
> +	struct list_head free_desc;
> +	struct list_head used_desc;
> +
> +	int pending;
> +
> +	struct cb_device *device;
> +	struct dma_chan common;
> +
> +	dma_addr_t completion_addr;
> +	union {
> +		u64 full; /* HW completion writeback */
> +		struct {
> +			u32 low;
> +			u32 high;
> +		};
> +	} *completion_virt;
> +};

Again, is it safe to assume that these parts will never be present in
big-endian machines?


