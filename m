Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262751AbUBZJwk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 04:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbUBZJwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 04:52:40 -0500
Received: from verein.lst.de ([212.34.189.10]:42667 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262751AbUBZJwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 04:52:35 -0500
Date: Thu, 26 Feb 2004 10:51:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <linus@osdl.org>,
       anton@samba.org, paulus@samba.org, axboe@suse.de,
       piggin@cyberone.com.au, viro@parcelfarce.linux.theplanet.co.uk,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iSeries virtual disk
Message-ID: <20040226095156.GA25423@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <linus@osdl.org>,
	anton@samba.org, paulus@samba.org, axboe@suse.de,
	piggin@cyberone.com.au, viro@parcelfarce.linux.theplanet.co.uk,
	LKML <linux-kernel@vger.kernel.org>
References: <20040123163504.36582570.sfr@canb.auug.org.au> <20040122221136.174550c3.akpm@osdl.org> <20040226172325.3a139f73.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040226172325.3a139f73.sfr@canb.auug.org.au>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 05:23:25PM +1100, Stephen Rothwell wrote:
> Unfortunately, things have moved on in the last couple of weeks and to
> fix everyone;s abjections, I need to include in this patch a ppc64 specific
> version of the dma_mapping routines.  They are pretty straight forward.

While thes dma mapping changes look good they really don't belong into a
patch for a new driver. Can you split them out into a separate patch? 

> Disks are now called /dev/iseries/vd<x><n> (without devfs) or
> /dev/viod/disc<n>/part<n> (with devfs).  Up to 7 partitions are supported
> on each of up to 32 disks.

Hmm, different names for devfs vs non-devfs seems silly.  But I think we
can't easily get rid of the disc<foo>/part sillyness.  Can you at least
make both use the same prefix?


>  config VIOCD
>  	tristate "iSeries Virtual I/O CD support"
>  	help

What happened to this driver, btw?

> +void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
> +		enum dma_data_direction direction)
> +{
> +	if (dev->bus == &pci_bus_type)
> +		pci_unmap_single(to_pci_dev(dev), dma_addr, size, (int)direction);
>
> 
> +#ifdef CONFIG_PPC_PSERIES
> +	else if (dev->bus == &vio_bus_type)
> +		vio_unmap_single(to_vio_dev(dev), dma_addr, size, (int)direction);
> +#endif

So vio on iseries claims to be pci?  That's a little silly if you ask
me..

> +#include <linux/major.h>
> +#include <linux/fs.h>
> +#include <asm/uaccess.h>

please put all asm/* headers after linux/*

> +#include <linux/hdreg.h>

probably not needed anymore without ide emulation.

> +#include <linux/seq_file.h>

you don't use this anymore, do you?

> +static int		viodasd_max_disk;

the code surrounding this doesn't look right yet.  You first initialize
it to the maximum value and then reset it in a magic even handler?
I think that logic needs some clarification.

> +#define DEVICE_NO(cell)	((struct viodasd_device *)(cell) - &viodasd_devices[0])

Aniother idea:  It might be better to just put a disk_no member into
struct viodasd_device - then you can allocate the struct viodasd_device
dynamically one by one and easily support lots of disks without overhead
for lowend configurations (remember we have a 32bit dev_t now)

> +extern struct device *iSeries_vio_dev;

shouldn't this be in some header?

> +static void viodasd_init_disk(struct viodasd_device *d);

What's preventing this one to be implemented above it's usage? or even
better merging it into it's only caller.

> +static void viodasd_end_request(struct request *req, int uptodate,
> +		int num_sectors)
> +{
> +	if (end_that_request_first(req, uptodate, num_sectors))
> +		return;
> +        add_disk_randomness(req->rq_disk);
> +	end_that_request_last(req);
> +}

indentation looks messed up here.

> +static void viodasd_init_disk(struct viodasd_device *d)
> +{
> +	struct gendisk *g;
> +	struct request_queue *q;
> +	int disk_no = DEVICE_NO(d);
> +
> +	if (d->disk)
> +		return;

as there's only one caller it shouldn't happen, should it?

> +	g->private_data = (void *)d;

no need to cast to void * here - this is implicit in C

> +        for (i = 0; i < MAX_DISKNO; i++) {
> +		d = &viodasd_devices[i];
> +		if (d->disk) {

How can d->disk ever be NULLL here?

> 
> +			if (d->disk->queue)
> +				blk_cleanup_queue(d->disk->queue);
> +			del_gendisk(d->disk);

the queue cleanups needs to be after put_gendisk.  Also where did you
see d->disk->queue as NULL?

