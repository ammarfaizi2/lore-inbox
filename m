Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSHXUxo>; Sat, 24 Aug 2002 16:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315439AbSHXUxn>; Sat, 24 Aug 2002 16:53:43 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:30986
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313563AbSHXUxl>; Sat, 24 Aug 2002 16:53:41 -0400
Date: Sat, 24 Aug 2002 13:56:42 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: IDE janitoring comments
In-Reply-To: <20020824222830.14052@192.168.4.1>
Message-ID: <Pine.LNX.4.10.10208241356310.20141-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have part of cris fixed

On Sun, 25 Aug 2002, Benjamin Herrenschmidt wrote:

> >>  - Do we really want to keep all those _P versions around ?
> >> A quick grep showed _only_ by the non-portable x86 specific
> >> recovery timer stuff that taps ISA timers (well, I think ports
> >> 0x40 and 0x43 and an ISA timer). I would strongly suggest to
> >
> >I'd like to keep them around for the moment. They should be using
> >udelay() but thats a general issue with _p inb/outb etc.
> 
> I don't think we need them at all in hwif (see below)
> 
> >> After much thinking about the above, I came to the conslusion
> >> we probably want to just kill all the IN_BYTE, OUT_BYTE, etc.
> >
> >Agreed entirely
> >
> >
> >> Also, getting rid of the _P version would make things a lot
> >> easier as well here too.
> >
> >What currently uses the _P versions ?
> 
> Ok, I looked and found out that those are used by 
> 
>  - some weird stuff in ide.c tapping IO ports at 0x40 and 0x43 that
> I assume is a timer. (Can someone make sure that code don't get used
> on anything but legacy x86 ?).
> 
>  - a couple of interface drivers like cmd640 tapping the PCI config
> IO stuffs for probing.
> 
> In all cases, I firmly beleive those are way outside of the domain
> of application of the hwif-> abstraction. Those are code that knows
> it's tapping legacy stuff on a IO port, and can/should directly use
> the in/out_p function. I don't think those have anything to do in
> hwif. All that should be in hwif is what is needed by the generic
> code to tap the IDE registers themselves.
> 
> Do you agree ? (I'd love to get rid of them :)
> 
> If you agree, I'll send you a patch tomorrow along with the fixing
> of ide-pmac that will do
> 
>  - Remove the _P versions from hwif->iops
>  - slightly change ide-iops to define both sets of iops, one set
>    providing PIO ops using directly in/outx & int/outsx, and one
>    set providing MMIO ops using directly read/writex
> 
> Anybody that need different routines for the generic IDE code to
> tap the taskfile (or eventually DMA) registers (typically cris
> arch) will provide it's own set of routines to hwif. I can probably
> fix cris (though I don't know anything about that arch, but the
> code seem obvious enough), and i'll rely on you to fix m86k :)
> 
> 
> Ben.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

