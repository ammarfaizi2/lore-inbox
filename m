Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265718AbUFRWYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265718AbUFRWYW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 18:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbUFRWVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 18:21:50 -0400
Received: from chaos.analogic.com ([204.178.40.224]:59521 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265539AbUFRWQx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 18:16:53 -0400
Date: Fri, 18 Jun 2004 18:12:48 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org, greg@kroah.com,
       tony@atomide.com, david-b@pacbell.net, jamey.hicks@hp.com,
       joshua@joshuawise.com, James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: DMA API issues
In-Reply-To: <40D359B3.6080400@pobox.com>
Message-ID: <Pine.LNX.4.53.0406181751020.7785@chaos>
References: <20040618175902.778e616a.spyro@f2s.com> <40D359B3.6080400@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, Jeff Garzik wrote:

> Ian Molton wrote:
> > Hi.
> >
> > This may have come up previously but I havent seen it, so...
> >
> > My colleagues and I are encountering a number of difficulties with the
> > DMA API, to which a generic solution is required (or risk multiple
> > architectures, busses, and devices going their own way...)
> >
> > Here is an example system that illustrates these problems:
> >
> > I have a System On Chip device which, among other functions, contains an
> > OHCI controller and 32K of SRAM.
> >
> > heres the catch:- The OHCI controller has a different address space than
> > the host bus, and worse, can *only* DMA data from its internal SRAM.
>
> Unfortunately, I tend to think that you should not be using the DMA API
> for this, since it's not host RAM.
>
> There are loads of devices with on-board SRAM/DRAM/... you really have
> to manage your own resources at that point.
>
> I know that sucks, WRT driver re-use.  Maybe you can wrap it inside the
> OHCI driver, ohci_dma_alloc_xxx() etc.  For the normal case, the wrapper
> resolves directly to the DMA API.  For the embedded case, the wrapper
> does SRAM-specific stuff.
>
> You _might_ convince the kernel DMA gurus that this could be done by
> creating a driver-specific bus, and pointing struct device to that
> internal bus, but that seems like an awful lot of work as opposed to the
> wrappers.
>
> 	Jeff
>

I don't think that any DMA lends itself very well to a generic
solution and I see that some have dedicated a lot of effort trying
to make such an API.

Take the simple PLX chip that is pretty common, at least as a clone
or macro-cell in many PCI/Bus devices. For its bus-master DMA, you
need a place to build a scatter-list in physical RAM with
a physical address that's known, plus you need kernel-mode virtual
address pointers to be able to build the list.  Then you need to
get the physical address of some user buffer and lock it down during
the transfer, or you need to have kernel buffers that you know the
physical address of, plus have kernel mode pointers to that area.
That area may not even be RAM! And, certainly the place that you
get the data from inside the device may be a single longword with
auto-incrementing hardware.

The fact that you write a 3 to some register somewhere to start
a DMA for a lot of chips, doesn't mean that there will
ever be a generic solution to DMA. Every driver is different.

Even the busmaster Ethernet boards fail to fully utilize the
capability of DMA. The idea of allocating a DMA-able block,
DMAing to it (waiting for the DMA to complete), then de-allocating
that block is extremely wasteful.

I think the whole thing should be re-thought. Something like:
On startup, some list of every page of RAM should be built
(once). A simple algorithm should be made that uses that
list. With a few machine instructions one should be able to
find:

(1)  The physical page of the starting location.
(2)  The amount of space available in that page.
(3)  The physical page of the next location.
(4)  Etc.

Using that information a scatter-list can be built for
the DMA transfer(s) and those pages need to be brought into
memory and locked down only for the duration of the DMA.

This would allow any resident page anywhere to be the source
or target of any DMA operation.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


