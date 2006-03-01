Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWCAOTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWCAOTU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 09:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWCAOTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 09:19:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9785 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932216AbWCAOTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:19:19 -0500
Date: Wed, 1 Mar 2006 15:18:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Andy Chittenden <AChittenden@bluearc.com>,
       Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, linux-kernel@vger.kernel.org, lwoodman@redhat.com,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060301141848.GW4816@suse.de>
References: <89E85E0168AD994693B574C80EDB9C270393C104@uk-email.terastack.bluearc.com> <20060301134123.GU4816@suse.de> <200603011505.23222.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603011505.23222.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01 2006, Andi Kleen wrote:
> On Wednesday 01 March 2006 14:41, Jens Axboe wrote:
> > On Wed, Mar 01 2006, Andy Chittenden wrote:
> > > with revised patch that does:
> > > 
> > >                 printk("sg%d: dma=%llx, dma_len=%u/%u, pfn=%lu\n", i,
> > > (unsigned long long) sg->dma_address, sg->dma_length, sg->offset,
> > > page_to_pfn(sg->page));
> > 
> > That is correct, thanks!
> > 
> > > hda: DMA table too small
> > > ide dma table, 255 entries, bounce pfn 1310720
> > > sg0: dma=81c8800, dma_len=4096/0, pfn=1296369
> > 
> > Still the same badness here, it's 2kb into a page so straddles two pages
> > for one entry.
> 
> That's normal if it was in the IOMMU and a merged entry. 
> 
> You can try iommu=nomerge.
> 
> Or maybe the higher layers are passing in physically continuous pages
> that get merged? Not too unlikely at boot.

But that would have to be 1kb or 512b io going in, I would expect 4kb to
be the base entries for any normal type of setup (with a 4kb fs). The
8kb could be one such merged entry, I agree.

> > Andi, any idea what is going on here? Why is this throwing up all of a
> > sudden??
> 
> What is throwing up exactly?
>
> There was a change recently in the merging algorithm, but it shouldn't
> cause any bad side effects for correct users of *_map_sg()

That the request we end up passing to blk_rq_map_sg() and then to
pci_map_sg() ends up with more entries than the driver advertised. So
far I think only Andy reported this, and then only with your
blk_queue_bounce_limit() patch applied.

-- 
Jens Axboe

