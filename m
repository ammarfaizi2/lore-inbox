Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267298AbSLELDg>; Thu, 5 Dec 2002 06:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267299AbSLELDg>; Thu, 5 Dec 2002 06:03:36 -0500
Received: from [217.167.51.129] ([217.167.51.129]:2252 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S267298AbSLELDf>;
	Thu, 5 Dec 2002 06:03:35 -0500
Subject: Re: [RFC] generic device DMA implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200212042146.gB4Lkw804422@localhost.localdomain>
References: <200212042146.gB4Lkw804422@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Dec 2002 12:15:30 +0100
Message-Id: <1039086930.1609.71.camel@zion>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-04 at 22:46, James Bottomley wrote:
> miles@gnu.org said:
> > How is the driver supposed to tell whether a given dma_addr_t value
> > represents consistent memory or not?  It seems like an (arch-specific)
> > `dma_addr_is_consistent' function is necessary, but I couldn't see one
> > in your patch. 
> 
> well, the patch was only for x86, which is fully consistent.  For parisc, that 
> becomes a field for the dma accessor functions.
> 
> However, even on parisc, the (supported) machines are either entirely 
> consistent or entirely inconsistent.
> 
> If you have a machine that has both consistent and inconsistent blocks, you 
> need to encode that in dma_addr_t (which is a platform definable type).

I don't agree here. Encoding things in dma_addr_t, then special casing
in consistent_{map,unmap,sync,....) looks really ugly to me ! You want
dma_addr_t to contain a bus address for the given bus you are working
with and pass that to your device, period.

Consistency of memory (or simply, in some cases, accessibility of system
memory by a given device) is really a property of the bus. Tweaking
magic bits in dma_addr_t and testing them later is a hack. The proper
implementation is to have the consistent_{alloc,free,map,unmap,sync,...)
functions be function pointers in the generic bus structure.

Actually, the device model defines a bus "type" structure rather than a
"bus instance" structure (well, at least it did last I looked a couple
of weeks ago). That's a problem I beleive here, as those functions are
really a property of a given bus instance. One solution would eventually
be to have the set of functions pointers in the generic struct device
and by default be copied from parent to child.

Actually, to avoid bloat, I think a single pointer to a struct
containing the whole set of consistent functions is enough though, as
those will typically be statically defined.

Ben.

