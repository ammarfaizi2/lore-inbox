Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbRATTnZ>; Sat, 20 Jan 2001 14:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131214AbRATTnP>; Sat, 20 Jan 2001 14:43:15 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:51628 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129664AbRATTnG>; Sat, 20 Jan 2001 14:43:06 -0500
Date: Sat, 20 Jan 2001 11:43:51 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: Inefficient PCI DMA usage (was:
 [experimentalpatch] UHCI updates)
To: linux-usb-devel@lists.sourceforge.net, Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Message-id: <054a01c08319$51626d80$6600000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
In-Reply-To: <20010120003812.G9156@sventech.com>
 <200101200828.f0K8SKF00961@flint.arm.linux.org.uk>
 <20010120123441.H9156@sventech.com>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The usb-ohci driver, widely used on non-x86 platforms, has hit
the same issue.  (Including on some ARM setups.)  An EHCI driver
(usb 2.0, 60 MByte/sec) under way has it too.

The alternative of having every device driver implement their
own simplified (?) kmem_cache code would just seem wrong; it'd
certainly be the cause of lots of bugs.  Simplest to just let
the kmem cache code reach into a different page pool, and make
drivers init their kmem caches appropriately.

I'd hope such a thing wouldn't need to wait for the 2.5 tree to
branch, since using 2.4 effectively on some non-Intel architectures
will require wider use of the pci_{alloc,free}_consistent() stuff.

- Dave



----- Original Message -----
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>; <linux-usb-devel@lists.sourceforge.net>
Sent: Saturday, January 20, 2001 9:34 AM
Subject: [linux-usb-devel] Re: Inefficient PCI DMA usage (was: [experimentalpatch] UHCI
updates)


> On Sat, Jan 20, 2001, Russell King <rmk@arm.linux.org.uk> wrote:
> > Johannes Erdfelt writes:
> > > On Fri, Jan 19, 2001, Miles Lane <miles@megapathdsl.net> wrote:
> > > > Johannes Erdfelt wrote:
> > > >
> > > > > TODO
> > > > > ----
> > > > > - The PCI DMA architecture is horribly inefficient on x86 and ia64. The
> > > > >   result is a page is allocated for each TD. This is evil. Perhaps a slab
> > > > >   cache internally? Or modify the generic slab cache to handle PCI DMA
> > > > >   pages instead?
> > > >
> > > > This might be the kind of thing to run past Linus when the 2.5 tree
> > > > opens up.  Are these inefficiencies necessary evils due to workarounds
> > > > for whacky bugs in BIOSen or PCI chipsets or are they due to poor
> > > > design/implementation?
> > >
> > > Looks like poor design/implementation. Or perhaps it was designed for
> > > another reason than I want to use it for.
> >
> > Why?  What are you trying to do?  Allocate one area per small structure?
> > Why not allocate one big area and allocate from that (like the tulip
> > drivers do for their TX and RX rings)?
> >
> > I don't really know what you're trying to do/what the problem is because
> > there isn't enough context left in the original mail above, and I have
> > no idea whether the original mail appeared here or where I can read it.
>
> I was hoping the context from the original TODO up there was sufficient
> and it looked like it was enough.
>
> TD's are around 32 bytes big (actually, they may be 48 or even 64 now, I
> haven't checked recently). That's a waste of space for an entire page.
>
> However, having every driver implement it's own slab cache seems a
> complete waste of time when we already have the code to do so in
> mm/slab.c. It would be nice if we could extend the generic slab code to
> understand the PCI DMA API for us.
>
> > > I should also check architectures other than x86 and ia64.
> >
> > This is an absolute must.
>
> Not really. The 2 interesting architectures are x86 and ia64 since
> that's where you commonly see UHCI controllers. While you can add UHCI
> controllers to most any other architecture which has PCI, you usually
> see OHCI on those systems.
>
> I was curious to see if any other architectures implemented it
> differently and I was just expecting too much out of the API. You pretty
> much confirmed my suspicions when you suggested doing what the tulip
> driver does.
>
> JE
>
>
> _______________________________________________
> linux-usb-devel@lists.sourceforge.net
> To unsubscribe, use the last form field at:
> http://lists.sourceforge.net/lists/listinfo/linux-usb-devel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
