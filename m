Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267469AbSLFAD0>; Thu, 5 Dec 2002 19:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267463AbSLFACR>; Thu, 5 Dec 2002 19:02:17 -0500
Received: from dp.samba.org ([66.70.73.150]:42189 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267464AbSLFACC>;
	Thu, 5 Dec 2002 19:02:02 -0500
Date: Fri, 6 Dec 2002 10:44:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Miles Bader <miles@gnu.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021205234401.GO1500@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Miles Bader <miles@gnu.org>,
	James Bottomley <James.Bottomley@steeleye.com>,
	"Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
References: <20021205004744.GB2741@zax.zax> <200212050144.gB51iH105366@localhost.localdomain> <20021205023847.GA1500@zax.zax> <buohedtrw64.fsf@mcspd15.ucom.lsi.nec.co.jp> <20021205060606.GG1500@zax.zax> <buovg29klsh.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buovg29klsh.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 03:43:58PM +0900, Miles Bader wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
> > > As I mentioned in my previous message, one of my platforms is like that
> > > memory, which is only 2 megabytes in size.
> > 
> > Ok, that starts to make sense then (what platform is it,
> > incidentally).  Is using consistent memory actually faster than doing
> > the cache flushes expliticly?  Much?
> 
> It's an embedded evaluation board (Midas `RTE-MOTHER-A' and
> `RTE-V850E-MA1-CB').
> 
> The thing is there _is_ no cache on this machine (it's very slow), so
> cache-consistency is actually not an issue (and the cache-flushing
> macros won't help me at all).
> 
> PCI devices are several busses removed from the CPU, and they only have
> this one 2MB area in common.  So on this machine, PCI devices can _only_
> use consistent memory.
> 
> When a driver uses the non-consistent interfaces, then:
> 
>   * pci_map_single allocates a `shadow area' of consistent memory and
>     pci_unmap_single deallocates it

That's a little misleading: all your memory is consistent, the point
is that it is a shadow area of PCI-mappable memory.

>   * pci_dma_sync_... just does a memcpy to/from the `shadow' consistent
>     memory from/to the drivers kalloc'd block (in principle I think this
>     is incorrect, because it uses the `dir' parameter to determine the
>     direction to copy, but it works in practice)
> 
> So you can see that for this platform, it would be better if drivers
> could _always_ use alloc_consistent, but many don't.

Ah, ok, now I understand.  The issue here is actually nothing to do
with consistency, since your platform is fully consistent.  The issue
is that there are other constraints for DMAable memory and you want
drivers to be able to easily mallocate with those constraints.

Actually, it occurs to me that PC ISA DMA is in a similar situation -
there is a constraint on DMAable memory (sufficiently low physical
address) which has nothing to do with consistency.

> Yes this is a wierd and frustrating design, but I think it does credit
> to the linux PCI layer that I could get it work at all, without
> modifying any drivers!  I guess my main goal in this discussion is to
> ensure that remains the case...

Ok... see also my reply to one of James's posts.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
