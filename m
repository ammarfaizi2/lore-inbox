Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265325AbSLFSAY>; Fri, 6 Dec 2002 13:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbSLFSAY>; Fri, 6 Dec 2002 13:00:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24335 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265325AbSLFSAW>;
	Fri, 6 Dec 2002 13:00:22 -0500
Date: Fri, 6 Dec 2002 18:07:58 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: willy@debian.org, davem@redhat.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021206180758.C16341@parcelfarce.linux.theplanet.co.uk>
References: <200212061739.JAA22230@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200212061739.JAA22230@baldur.yggdrasil.com>; from adam@yggdrasil.com on Fri, Dec 06, 2002 at 09:39:24AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 09:39:24AM -0800, Adam J. Richter wrote:
> On Fri, 6 Dec 2002, Matthew Wilcox wrote:
> >Machines built with PCXS and PCXT processors are guaranteed not to have
> >PCI.  So this only becomes a problem when supporting non-PCI devices.
> >The devices you mentioned -- 53c700 & 82596 -- are core IO and really do
> >need to be supported.  There's also a large userbase for these machines,
> >dropping support for them is not an option.
> 
> Back on 7 Nov 2002, James Bottomley wrote:
> | The ncr8xxx driver is another one used for the Zalon controller in parisc, so
> | it will eventually have the same issues.
> 
> 	How many other drivers beyond these three do we expect to
> need similar sync points if the T class remains unsupported?

Er, well.. machines that can take the Zalon card also have consistent PCI.
However, there are machines which can take the ncr53c720 chip which have
no consistent shared memory available.  Rumours abound of an ncr53c770
driver that already supports non-consistent memory, but nobody's actually
said whch one it is yet.

Leaving aside the T-class, machines that don't support io consistent memory
generally have:

(drivers that need io consistent memory):
 - 82596 ethernet
 - ncr53c700 scsi
 - ncr53c720 scsi
 - zero to four EISA slots

(drivers that don't do DMA):
 - two 16550-compatible serial ports
 - Mux serial port
 - Lasi parallel port
 - Skunk parallel port
 - HIL keyboard/mouse
 - Graphics cards

(custom drivers needed anyway):
 - Harmony audio
 - various other SCSI chips
 - Interphase 100BaseTx
 - HPPB slots

I think that's about it... cc

> >T class machines don't have PCI slots per se, but they do have GSC
> >slots into which a card can be plugged that contains a Dino GSC to PCI
> >bridge and one or more PCI devices.  Examples of cards that are like
> >this include acenic, single and dual tulip.
> 
> 	Regarding the "T class", I would be intersted in knowing how
> old it is, if it is discontinued at this point, how much of a user
> base there is, and how many of these PCI-on-GSC cards there are.

It's certainly discontinued.  I get the impression it was already out in
1997 from a quick Google search.  It's not exactly a slow machine even
by todays standards -- up to 12 180MHz 64-bit processors, but it's just
too weird to be worth supporting.

There's lots of PCI-on-GSC cards; they were used in the B/C/J workstations
and the D/K/R servers.

> 	I was previously under the impression that there were some
> parisc machines that could take some kind of commodity PCI cards and
> lacked consistent memory.

No, that is not the case.

> If the reality is that only about six
> drivers would ever have to be ported to use these sync points, then I
> could see keeping dma_{alloc,free}_consistent, and moving the
> capability of dealing with inconsistent memory to some wrappers in a
> separate .h file (dma_alloc_maybe_consistent, dma_alloc_maybe_free).
> 
> 	I suppose another consideration would be how likely it is that
> a machine that we might care about without consistent memory will ship
> in the future.  In general, the memory hierarchy is getting taller
> (levels of caching, non-uniform memory access), but perhaps the
> industry will continue to treat consistent memory capability as a
> requirement.

I think it will.  The IOMMU in the T600 is the only one I've ever heard
of that wasn't consistent with host memory.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
