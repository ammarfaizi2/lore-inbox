Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282511AbSABJaq>; Wed, 2 Jan 2002 04:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286815AbSABJag>; Wed, 2 Jan 2002 04:30:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27919 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S282511AbSABJaX>;
	Wed, 2 Jan 2002 04:30:23 -0500
Date: Wed, 2 Jan 2002 10:30:15 +0100
From: Jens Axboe <axboe@suse.de>
To: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: "sr: unaligned transfer" in 2.5.2-pre1
Message-ID: <20020102103015.O16092@suse.de>
In-Reply-To: <m2vgexzv90.fsf@ppro.localdomain> <20011223112249.B4493@kroah.com> <m23d1trr4w.fsf@pengo.localdomain> <20011230122756.L1821@suse.de> <20011230212700.B652@one-eyed-alien.net> <20011231125157.D1246@suse.de> <20011231145455.C6465@one-eyed-alien.net> <065e01c192fd$fe066e20$6800000a@brownell.org> <20020101233423.I16092@suse.de> <20020101152859.D14915@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020101152859.D14915@one-eyed-alien.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01 2002, Matthew Dharm wrote:
> On Tue, Jan 01, 2002 at 11:34:23PM +0100, Jens Axboe wrote:
> > On Tue, Jan 01 2002, David Brownell wrote:
> > > Not that I've seen a writeup about highmem (linux/Documentation
> > > doesn't seem to have one anyway) but if I infer correctly from that
> > > DMA-mapping.txt writeup, URBs don't support it because there's no way
> > > to specify buffers as a "struct page *" or an array of "struct
> > > scatterlist".  That's the only way that document identifies to access
> > > "highmem memory".
> 
> This sounds like another good reason to have URBs take scatterlists
> directly, oddly enough. :)

Or at least a derived structure, however it might as well just use
scatterlist (address member is soon gone). So yes.

> > > > (1) Do the USB HCDs support highmem?  I seem to recall they do, but
> > > > I'm not certain.
> > > 
> > > If URBs can't describe highmem, the HCD's won't support them per se;
> > > you'd have to turn highmem to "lowmem" or whatever it's called, and
> > > then let the HCDs manage the lowmem-to-dma_addr_t mappings.
> > > 
> > > Alternatively, in 2.5 we might add "highmem" support to USB.  Now that
> > > I've looked at it a few minutes, I suspect we must -- just to support
> > > block devices (usb-storage) fully.  Is there more to it than adding
> > 
> > No, you can always ask to get pages low mem bounced. Highmem is no
> > requirement, and if your device really can't support it there's no point
> > in attempting to support it.
> 
> I presume there is some overhead in bouncing to lowmem?  I imagine that
> highmem support for the HCDs wouldn't be that difficult -- they are just
> PCI devices, after all.

Lots of overhead required for copying data back and forth between low
and high page (both the memcpy, but also the highmem kmap). In addition
it puts added pressure on the memory allocator.

> I'd rather eliminate as much overhead as possible -- I already get
> complaints from performance fanatics about the inability of usb-storage to
> get past 92% bus saturation (sustained), and the problem will only get
> worse on USB 2.0

Then you should move the the page/len/offset construct.
> 
> > > page+offset as an alternative way to describe the transfer_buffer?
> > 
> > no
> 
> Hrm... isn't that what one of the patches sent did?  Or does that only work
> for lowmem allocations described by the structure?

Hmmm no, I don't think so. It only worked for low mem pages, since it
used page_address to 'map' the page.

-- 
Jens Axboe

