Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267454AbSLFACD>; Thu, 5 Dec 2002 19:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267465AbSLFACD>; Thu, 5 Dec 2002 19:02:03 -0500
Received: from dp.samba.org ([66.70.73.150]:43981 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267454AbSLFACB>;
	Thu, 5 Dec 2002 19:02:01 -0500
Date: Fri, 6 Dec 2002 10:59:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021205235911.GQ1500@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Jeff Garzik <jgarzik@pobox.com>,
	James Bottomley <James.Bottomley@steeleye.com>,
	"Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
References: <20021205004744.GB2741@zax.zax> <200212050144.gB51iH105366@localhost.localdomain> <20021205023847.GA1500@zax.zax> <20021205034131.GA26616@gtf.org> <20021205060458.GF1500@zax.zax> <3DEF7EF9.8090306@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DEF7EF9.8090306@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 11:29:45AM -0500, Jeff Garzik wrote:
> David Gibson wrote:
> >On Wed, Dec 04, 2002 at 10:41:31PM -0500, Jeff Garzik wrote:
> >
> >>On Thu, Dec 05, 2002 at 01:38:47PM +1100, David Gibson wrote:
> >>
> >>>It seems the "try to get consistent memory, but otherwise give me
> >>>inconsistent" is only useful on machines which:
> >>>	(1) Are not fully consisent, BUT
> >>>	(2) Can get consistent memory without disabling the cache, BUT
> >>>	(3) Not very much of it, so you might run out.
> >>>
> >>>The point is, there has to be an advantage to using consistent memory
> >>>if it is available AND the possibility of it not being available.
> >>
> >>Agreed here.  Add to this
> >>
> >>(4) quite silly from an API taste perspective.
> >>
> >>
> >>
> >>>Otherwise, drivers which absolutely need consistent memory, no matter
> >>>the cost, should use consistent_alloc(), all other drivers just use
> >>>kmalloc() (or whatever) then use the DMA flushing functions which
> >>>compile to NOPs on platforms with consistent memory.
> >>
> >>Ug.  This is travelling backwards in time.
> >>
> >>kmalloc is not intended to allocate memory for DMA'ing.  I (and others)
> >>didn't spend all that time converting drivers to the PCI DMA API just to
> >>see all that work undone.
> >
> >
> >But if there aren't any consistency constraints on the memory, why not
> >get it with kmalloc().  There are two approaches to handling DMA on a
> >not-fully-consistent machine:
> >	1) Allocate the memory specially so that it is consistent
> >	2) Use any old memory, and make sure we have explicit cache
> >frobbing.
> 
> For me it's an API issue.  kmalloc does not return DMA'able memory.

Ok - see my reply to James's post.  I see the point of this given that
there are constraints on DMAable memory which are not related to
consistency (e.g. particular address ranges and cacheline alignment).
A mallocater which can satisfy these constraints makes sense to me.

I just think it's a mistake to associate these constraints with cache
consistency - they are not related.  James's original patch does make
this separation in practice, but it misleading suggests a link - which
is what confused me.

> 
> If "your way" is acceptable to most, then at the very least I would want
> 
> 	#define get_any_old_dmaable_memory kmalloc

I imagine platforms where any address is DMAable and which are fully
consistent would do this.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
