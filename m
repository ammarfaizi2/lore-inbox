Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286756AbSABF3R>; Wed, 2 Jan 2002 00:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286758AbSABF3I>; Wed, 2 Jan 2002 00:29:08 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:21962 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S286756AbSABF2x>; Wed, 2 Jan 2002 00:28:53 -0500
Date: Tue, 01 Jan 2002 21:27:07 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: highmem and usb [was
 "sr: unaligned transfer" in 2.5.2-pre1]
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        Matthew Dharm <mdharm@one-eyed-alien.net>, Greg KH <greg@kroah.com>
Message-id: <06c801c1934e$1fc01a20$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <m2vgexzv90.fsf@ppro.localdomain> <20011223112249.B4493@kroah.com>
 <m23d1trr4w.fsf@pengo.localdomain> <20011230122756.L1821@suse.de>
 <20011230212700.B652@one-eyed-alien.net> <20011231125157.D1246@suse.de>
 <20011231145455.C6465@one-eyed-alien.net>
 <065e01c192fd$fe066e20$6800000a@brownell.org> <20020101233423.I16092@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Not that I've seen a writeup about highmem (linux/Documentation
> > doesn't seem to have one anyway) but if I infer correctly from that
> > DMA-mapping.txt writeup, URBs don't support it because there's no way
> > to specify buffers as a "struct page *" or an array of "struct
> > scatterlist".  That's the only way that document identifies to access
> > "highmem memory".
> 
> What kind of mapping does URBs require? A virtual mapping?

Each URB points to one transfer buffer, address plus length, where
the USB device drivers directly read/write those addresses.   The
requirement for drivers is that the transfer buffers can be passed to
pci_map_single() calls by the Host Controller Drivers (HCDs).  The
device drivers, and URBs, don't expose such mappings, they only
require that they can be created/destroyed.

I'd be inclined to say transfer buffers must not be "virtual" mappings,
but since terminology can differ I'll let you draw your conclusion.


> > > (1) Do the USB HCDs support highmem?  I seem to recall they do, but
> > > I'm not certain.
> > 
> > If URBs can't describe highmem, the HCD's won't support them per se;
> > you'd have to turn highmem to "lowmem" or whatever it's called, and
> > then let the HCDs manage the lowmem-to-dma_addr_t mappings.
> > 
> > Alternatively, in 2.5 we might add "highmem" support to USB.  Now that
> > I've looked at it a few minutes, I suspect we must -- just to support
> > block devices (usb-storage) fully.  Is there more to it than adding
> 
> No, you can always ask to get pages low mem bounced. Highmem is no
> requirement, and if your device really can't support it there's no point
> in attempting to support it.

Standard HC hardware (EHCI, OHCI, UHCI) can use 32bit addresses
for their PCI DMA.  EHCI can also, in some implementations, handle 64bit
addresses.


> > page+offset as an alternative way to describe the transfer_buffer?
> 
> no
> 
> > (And making all the "single" mapping calls in the HCDs use page
> > mappings.)
> 
> exactly

So you're saying that pci_map_page() is not necessary?  And that
highmem buffers (page+offset, or scatterlist thereof) can be turned
into the form needed by URBs using some other mechanism?

I'd certainly rather that be the case for the moment, for simplicity.
Keep in mind that usb-storage seems to be the only driver that'd
run into that issue.

- Dave


