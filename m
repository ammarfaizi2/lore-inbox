Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266543AbUG0SeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUG0SeT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266549AbUG0SeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:34:19 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:46235 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S266543AbUG0SeQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:34:16 -0400
Subject: Re: [Lse-tech] [RFC][PATCH] Change pcibus_to_cpumask() to
	pcibus_to_node()
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       LSE Tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <200407270822.43870.jbarnes@engr.sgi.com>
References: <1090887007.16676.18.camel@arrakis>
	 <20040727105145.A18533@infradead.org>
	 <200407270822.43870.jbarnes@engr.sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1090953179.18747.19.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 27 Jul 2004 11:32:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-27 at 08:22, Jesse Barnes wrote:
> On Tuesday, July 27, 2004 2:51 am, Christoph Hellwig wrote:
> > On Mon, Jul 26, 2004 at 05:10:08PM -0700, Matthew Dobson wrote:
> > > So in discussions with Jesse at OLS, we decided that pcibus_to_node() is
> >
> > Please do pcibus_to_nodemask() instead - there could be dual-ported pci
> > bridges.
> 
> Do you know of any?  On sn2 there are dual ported xio->pci bridges, but in 
> that case, half the busses are associated with one node and the other half 
> with another node, so pcibus_to_node would work in that case.  And for 
> numalink->pci bridges, we'll return the node id of the bridge in that case 
> (which may not have any memory, but in that case alloc_pages_node will fall 
> back to the next node).
> 
> I wonder though if we shouldn't add
> 
>   ...
> #ifdef CONFIG_NUMA
>   int node; /* or nodemask_t if necessary */
> #endif
>   ...
> 
> to struct pci_bus instead?  That would make the existing code paths a little 
> faster and avoid the need for a global array, which tends to lead to TLB 
> misses.

I like that idea!  Stick a nodemask_t in struct pci_bus, initialize it
to NODE_MASK_ALL.  If a particular arch wants to put something more
accurate in there, then great, if not, we're just in the same boat we're
in now.

Anyone else have opinions one way or the other on Jesse's idea?

> Anyway, my needs are very simple.  I'd like to do 
> alloc_pages_node(pci_to_node(pci_dev)); in the sn2 version of 
> pci_alloc_consistent and use the new routine to simplify the initial irq 
> setup code, making it look more like build_zonelists and the sched domains 
> patch I posted yesterday.  So as long as those needs are provided for, I'm ok 
> with the interface.
> 
> Thanks,
> Jesse

I'm trying to keep the dependency of topology on what the pci_dev and
pci_bus structs look like to a minimum.  That's why I'd like to keep the
topology function based on PCI bus numbers (or possibly struct pci_bus),
not struct pci_dev.  The pci_bus is what really has the node affinity
anyway, and the device only has that affinity through the fact that it
is physically plugged into a particular bus.

-Matt

