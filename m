Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266389AbUG0PaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266389AbUG0PaA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 11:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266409AbUG0PaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 11:30:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13759 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266389AbUG0P1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 11:27:54 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [Lse-tech] [RFC][PATCH] Change pcibus_to_cpumask() to pcibus_to_node()
Date: Tue, 27 Jul 2004 08:22:43 -0700
User-Agent: KMail/1.6.2
Cc: Matthew Dobson <colpatch@us.ibm.com>, Jesse Barnes <jbarnes@sgi.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       LSE Tech <lse-tech@lists.sourceforge.net>
References: <1090887007.16676.18.camel@arrakis> <20040727105145.A18533@infradead.org>
In-Reply-To: <20040727105145.A18533@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407270822.43870.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 27, 2004 2:51 am, Christoph Hellwig wrote:
> On Mon, Jul 26, 2004 at 05:10:08PM -0700, Matthew Dobson wrote:
> > So in discussions with Jesse at OLS, we decided that pcibus_to_node() is
>
> Please do pcibus_to_nodemask() instead - there could be dual-ported pci
> bridges.

Do you know of any?  On sn2 there are dual ported xio->pci bridges, but in 
that case, half the busses are associated with one node and the other half 
with another node, so pcibus_to_node would work in that case.  And for 
numalink->pci bridges, we'll return the node id of the bridge in that case 
(which may not have any memory, but in that case alloc_pages_node will fall 
back to the next node).

I wonder though if we shouldn't add

  ...
#ifdef CONFIG_NUMA
  int node; /* or nodemask_t if necessary */
#endif
  ...

to struct pci_bus instead?  That would make the existing code paths a little 
faster and avoid the need for a global array, which tends to lead to TLB 
misses.

Anyway, my needs are very simple.  I'd like to do 
alloc_pages_node(pci_to_node(pci_dev)); in the sn2 version of 
pci_alloc_consistent and use the new routine to simplify the initial irq 
setup code, making it look more like build_zonelists and the sched domains 
patch I posted yesterday.  So as long as those needs are provided for, I'm ok 
with the interface.

Thanks,
Jesse
