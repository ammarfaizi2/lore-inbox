Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbSLEF6q>; Thu, 5 Dec 2002 00:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267236AbSLEF5m>; Thu, 5 Dec 2002 00:57:42 -0500
Received: from dp.samba.org ([66.70.73.150]:54692 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267235AbSLEF5h>;
	Thu, 5 Dec 2002 00:57:37 -0500
Date: Thu, 5 Dec 2002 17:04:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021205060458.GF1500@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Jeff Garzik <jgarzik@pobox.com>,
	James Bottomley <James.Bottomley@steeleye.com>,
	"Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
References: <20021205004744.GB2741@zax.zax> <200212050144.gB51iH105366@localhost.localdomain> <20021205023847.GA1500@zax.zax> <20021205034131.GA26616@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021205034131.GA26616@gtf.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 10:41:31PM -0500, Jeff Garzik wrote:
> On Thu, Dec 05, 2002 at 01:38:47PM +1100, David Gibson wrote:
> > It seems the "try to get consistent memory, but otherwise give me
> > inconsistent" is only useful on machines which:
> > 	(1) Are not fully consisent, BUT
> > 	(2) Can get consistent memory without disabling the cache, BUT
> > 	(3) Not very much of it, so you might run out.
> > 
> > The point is, there has to be an advantage to using consistent memory
> > if it is available AND the possibility of it not being available.
> 
> Agreed here.  Add to this
> 
> (4) quite silly from an API taste perspective.
> 
> 
> > Otherwise, drivers which absolutely need consistent memory, no matter
> > the cost, should use consistent_alloc(), all other drivers just use
> > kmalloc() (or whatever) then use the DMA flushing functions which
> > compile to NOPs on platforms with consistent memory.
> 
> Ug.  This is travelling backwards in time.
> 
> kmalloc is not intended to allocate memory for DMA'ing.  I (and others)
> didn't spend all that time converting drivers to the PCI DMA API just to
> see all that work undone.

But if there aren't any consistency constraints on the memory, why not
get it with kmalloc().  There are two approaches to handling DMA on a
not-fully-consistent machine:
	1) Allocate the memory specially so that it is consistent
	2) Use any old memory, and make sure we have explicit cache
frobbing.

We have to have both: some hardware requires approach (1), and the
structure of the kernel often requires (2) to avoid lots of copying
(e.g. a network device doesn't allocate its own skbs to transmit, so
it can't assume the memory has any special consistency properties).

Since in case (2), we can't make assumptions about where the memory
came from, it might as well come from kmalloc() (or a slab, or
get_free_pages() or whatever).

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
