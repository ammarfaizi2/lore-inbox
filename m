Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267466AbUIUGmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267466AbUIUGmg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 02:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267464AbUIUGmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 02:42:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24035 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267480AbUIUGm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 02:42:29 -0400
Date: Tue, 21 Sep 2004 08:40:29 +0200
From: Jens Axboe <axboe@suse.de>
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: jmerkey@galt.devicelogics.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2 bio sickness with large writes
Message-ID: <20040921064029.GB2287@suse.de>
References: <4148D2C7.3050007@drdos.com> <20040916063416.GI2300@suse.de> <4149C176.2020506@drdos.com> <20040917073653.GA2573@suse.de> <20040917201604.GA12974@galt.devicelogics.com> <414F0F87.9040903@drdos.com> <20040920180957.GB7616@suse.de> <414F2D80.9090909@drdos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414F2D80.9090909@drdos.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20 2004, Jeff V. Merkey wrote:
> Jens Axboe wrote:
> 
> >>page and offset sematics in the interface are also somewhat burdensome. 
> >>Wouldn't a more reasonable
> >>interface for async IO be:
> >>
> >>address
> >>length
> >>address
> >>length
> >>
> >>rather than
> >>
> >>page structure
> >>offset in page structure
> >>page structure
> >>offset in page structure
> >>   
> >>
> >
> >No, because { address, length } cannot fully describe all memory in any
> >given machine.
> >
> > 
> >
> This response I don't understand. How memory is described in a machine 
> for DMA addressibility
> is pretty standard (with the exception of memory on intel machine in 32 
> bit systems above 4GBthat need page tables) --
> a physical numerical address. But who is going to DMA into memory not in 
> the address space.

The mapped address, yes, not the data you are actually mapping for dma.
On 32-bit intel boxes, even with just 1GB of memory, you don't have a
kernel mapping of the memory above 960MB.

> >Any chunk of memory has a page associated with it, but it may not have a
> >kernel address mapping associated with it. So some identifier was needed
> >other than a virtual address, a page is as good as any so making one up
> >would be silly.
> >
> >Once you understand this, it doesn't seem so odd. You need to pass in a
> >single page or sg table to map for dma anyways, the sg table holds page
> >pointers as well.
> >
> > 
> >
> >>I can assume from the interface as designed that if you pass an offset 
> >>for a page that is not page aligned,
> >>and ask for a 4K write, then you will end up dropping the data on the 
> >>floor than spans beyond the end of the page.
> >>   
> >>
> >
> >What kind of bogus example is that? Asking for a 4K write from a 4K page
> >but asking to start 1K in that page is just stupid and not even remotely
> >valid.
> >
> > 
> >
> Hardware doesn't care about page boundries. It sees hardware addresses
> and lengths, at least most SG hardware I've worked with does. For ease
> of submission, an interface that takes <address,length> would suffice.

But what if there's no 'address' that identifies the piece of memory you
want to do io for? It might not be directly addressable by the kernel.

The pci dma mapping will coalesce the segments for you in the sg table
according to the hardware restrictions. Most hardware understands sg
addressing, if it doesn't it's a bad design imho.

> Why on earth would someone need a context pointer into the kernel's
> page tables to submit an SG into a device, apart from performing
> virtual-to-physical translation?

Ehm well exactly to do that virtual-to-physical translation, perhaps?
That's the whole point.

> >It's not difficult at all. Apparently you don't understand it so you
> >think it's difficult, that's only natural. But you have access to the
> >page mapping of any given piece of data always, or if you have the
> >virtual address only it's trivial to go to the { page, offset } mapping.
> > 
> >
> No, I do understand, and using page/offset at a low level SG interface

You pretty much continue to describe throughout this mail that you do
not understand why that is so.

> IS burdensome.  I mean, if this is what I have to support I guess I
> have to use it, but it will be just another section of code where I
> have another **FAT** layer to waste more CPU cycles calculating
> offset/page (oh yeah I have to lookup the struct page * structure
> also) when it would be much simpler to just submit address/len in i386

What a load of crap. Where does this waste of cycles come from?

> systems. With this type of interface, If I have for instance an
> on-disk structure that starts in the middle of a 4K page due to other
> headers, etc. than spans a page, I cannot just submit the address and
> length, I have to break it into two bio requests instead of one with a
> for () loop from hell and calculate the offsets and rumage around in
> memory looking up struct page * addresses.

Calculating an offset is extremely complicated and wasteful, indeed.
It's at least a few cycles.

If you just used the bio_add_page() stuff like you are supposed to, you
would not have to do that either.

> >I can only imagine that you are used to a very different interface on
> >some other OS so you think it's difficult to use. Most of your
> >complaints seem to be based on false assumptions or because you don't
> >understand why certain design decisions were made.
> >
> > 
> >
> 
> No. I am used to programming to hardware with SG devices that all OS 
> use. Is there somewhere a page based
> SG device (other than SCI) for disk drive?. I don't think so, I think 
> they operate address/len, address/len, etc.

Where 'address' is the dma address, not the virtual address. You need
the page to do that translation.

-- 
Jens Axboe

