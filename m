Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130391AbRATRe5>; Sat, 20 Jan 2001 12:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130636AbRATRer>; Sat, 20 Jan 2001 12:34:47 -0500
Received: from quattro.sventech.com ([205.252.248.110]:61451 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S130391AbRATRem>; Sat, 20 Jan 2001 12:34:42 -0500
Date: Sat, 20 Jan 2001 12:34:42 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Inefficient PCI DMA usage (was: [experimental patch] UHCI updates)
Message-ID: <20010120123441.H9156@sventech.com>
In-Reply-To: <20010120003812.G9156@sventech.com> <200101200828.f0K8SKF00961@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <200101200828.f0K8SKF00961@flint.arm.linux.org.uk>; from Russell King on Sat, Jan 20, 2001 at 08:28:20AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2001, Russell King <rmk@arm.linux.org.uk> wrote:
> Johannes Erdfelt writes:
> > On Fri, Jan 19, 2001, Miles Lane <miles@megapathdsl.net> wrote:
> > > Johannes Erdfelt wrote:
> > > 
> > > > TODO
> > > > ----
> > > > - The PCI DMA architecture is horribly inefficient on x86 and ia64. The
> > > >   result is a page is allocated for each TD. This is evil. Perhaps a slab
> > > >   cache internally? Or modify the generic slab cache to handle PCI DMA
> > > >   pages instead?
> > > 
> > > This might be the kind of thing to run past Linus when the 2.5 tree 
> > > opens up.  Are these inefficiencies necessary evils due to workarounds 
> > > for whacky bugs in BIOSen or PCI chipsets or are they due to poor 
> > > design/implementation?
> > 
> > Looks like poor design/implementation. Or perhaps it was designed for
> > another reason than I want to use it for.
> 
> Why?  What are you trying to do?  Allocate one area per small structure?
> Why not allocate one big area and allocate from that (like the tulip
> drivers do for their TX and RX rings)?
> 
> I don't really know what you're trying to do/what the problem is because
> there isn't enough context left in the original mail above, and I have
> no idea whether the original mail appeared here or where I can read it.

I was hoping the context from the original TODO up there was sufficient
and it looked like it was enough.

TD's are around 32 bytes big (actually, they may be 48 or even 64 now, I
haven't checked recently). That's a waste of space for an entire page.

However, having every driver implement it's own slab cache seems a
complete waste of time when we already have the code to do so in
mm/slab.c. It would be nice if we could extend the generic slab code to
understand the PCI DMA API for us.

> > I should also check architectures other than x86 and ia64.
> 
> This is an absolute must.

Not really. The 2 interesting architectures are x86 and ia64 since
that's where you commonly see UHCI controllers. While you can add UHCI
controllers to most any other architecture which has PCI, you usually
see OHCI on those systems.

I was curious to see if any other architectures implemented it
differently and I was just expecting too much out of the API. You pretty
much confirmed my suspicions when you suggested doing what the tulip
driver does.

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
