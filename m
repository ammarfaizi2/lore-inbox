Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267237AbSLEGIk>; Thu, 5 Dec 2002 01:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267238AbSLEGIk>; Thu, 5 Dec 2002 01:08:40 -0500
Received: from dp.samba.org ([66.70.73.150]:13221 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267237AbSLEGIi>;
	Thu, 5 Dec 2002 01:08:38 -0500
Date: Thu, 5 Dec 2002 17:15:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: davem@redhat.com, James.Bottomley@steeleye.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, miles@gnu.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021205061558.GI1500@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	"Adam J. Richter" <adam@yggdrasil.com>, davem@redhat.com,
	James.Bottomley@steeleye.com, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org, miles@gnu.org
References: <200212050302.TAA03366@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212050302.TAA03366@adam.yggdrasil.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 07:02:18PM -0800, Adam J. Richter wrote:
> >On Wed, Dec 04, 2002 at 07:44:17PM -0600, James Bottomley wrote:
> >> david@gibson.dropbear.id.au said:
> >> > Do you have an example of where the second option is useful?  Off hand
> >> > the only places I can think of where you'd use a consistent_alloc()
> >> > rather than map_single() and friends is in cases where the hardware's
> >> > behaviour means you absolutely positively have to have consistent
> >> > memory. 
> >> 
> >> Well, it comes from parisc drivers.  Here you'd really rather have
> >> consistent memory because it's more efficient, but on certain
> >> platforms it's just not possible.
> 
> >Hmm... that doesn't seem sufficient to explain it.
> 
> 	The question is not what is possible, but what is optimal.
> 
> 	Yes, it is possible to write drivers for machines without
> consistent memory that work with any DMA device, by using
> dma_{map,sync}_single as you suggest, even if caching could be
> disabled.  That is how drivers/scsi/53c700.c and
> drivers/net/lasi_82596.c work today.
> 
> 	The advantages of James's approach is that it will result in
> these drivers having simpler source code and even smaller object code
> on machines that do not have this problem.

Since, with James's approach you'd need a dma sync function (which
might compile to NOP) in pretty much the same places you'd need
map/sync calls, I don't see that it does make the source noticeably
simpler.

The only difference is that the map functions might also involve iommu
or similar setup - which also could compile to a nop in some cases.

> 	If were to try the approach of using pci_{map,sync}_single
> always (i.e., just writing the code not to use alloc_consistent),
> that would have a performance cost on machines where using
> consistent memory for writing small amounts of data is cheaper than
> the cost of the cache flushes that would otherwise be required.

Well, I'm only talking about the cases where we actually care about
reducing the use of consistent memory.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
