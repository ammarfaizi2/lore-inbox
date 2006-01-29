Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWA2PVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWA2PVd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 10:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWA2PVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 10:21:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:24140 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751024AbWA2PVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 10:21:32 -0500
Date: Sun, 29 Jan 2006 16:22:28 +0100
From: Jens Axboe <axboe@suse.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
Message-ID: <20060129152228.GF13831@suse.de>
References: <20060127194318.GA1433@flint.arm.linux.org.uk> <43DA7CD1.4040301@drzeus.cx> <20060127201458.GA2767@flint.arm.linux.org.uk> <20060127202206.GH9068@suse.de> <20060127202646.GC2767@flint.arm.linux.org.uk> <43DA84B2.8010501@drzeus.cx> <43DA97A3.4080408@drzeus.cx> <20060127225428.GD2767@flint.arm.linux.org.uk> <20060128191759.GC9750@suse.de> <43DBC6E2.4000305@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DBC6E2.4000305@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28 2006, Pierre Ossman wrote:
> Jens Axboe wrote:
> > On Fri, Jan 27 2006, Russell King wrote:
> >   
> >> On Fri, Jan 27, 2006 at 10:58:59PM +0100, Pierre Ossman wrote:
> >>     
> >>> Test done here, few minutes ago. Added this to the wbsd driver in its
> >>> kmap routine:
> >>>
> >>>     if ((host->cur_sg->offset + host->cur_sg->length) > PAGE_SIZE)
> >>>         printk(KERN_DEBUG "wbsd: Big sg: %d, %d\n",
> >>>             host->cur_sg->offset, host->cur_sg->length);
> >>>
> >>> got:
> >>>
> >>> [17385.425389] wbsd: Big sg: 0, 8192
> >>> [17385.436849] wbsd: Big sg: 0, 7168
> >>> [17385.436859] wbsd: Big sg: 0, 7168
> >>> [17385.454029] wbsd: Big sg: 2560, 5632
> >>> [17385.454216] wbsd: Big sg: 2560, 5632
> >>>       
> >> Jens - what's going on?  These look like invalid sg entries to me.
> >>
> >> If they are supposed to be like that, there will be additional problems
> >> for block drivers ensuring cache coherency on PIO.
> >>     
> >
> > No freaking idea, must be coming out of the pci dma mapping. The IOMMU
> > doing funky stuff? How are these sg lists mapped?
> >
> >   
> 
> This is an ISA (i.e. platform) device, so no PCI involved. There is also
> no IOMMU on this system.
> 
> As for the mapping there doesn't seem to be anything fancy about it
> (this is Russell's territory so this is just my naive view of it). The
> queue is set up in mmc_queue.c and the sg is mapped using
> blk_rq_map_sg() in mmc_block.c.
> 
> But if sg entries are not supposed to cross pages, then I guess that
> means that any transfer is limited in size by PAGE_SIZE *
> min(max_phys_seg, max_hw_seg), right?

Ah, you need to disable clustering to prevent that from happening! I was
confused there for a while.

-- 
Jens Axboe

