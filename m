Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753546AbWKFU64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbWKFU64 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753568AbWKFU64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:58:56 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:41679 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1753546AbWKFU6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:58:55 -0500
Date: Mon, 6 Nov 2006 12:58:52 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
In-Reply-To: <20061106124257.deffa31c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0611061252140.29760@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
 <20061103134633.a815c7b3.akpm@osdl.org> <Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
 <20061103143145.85a9c63f.akpm@osdl.org> <Pine.LNX.4.64.0611031622540.16997@schroedinger.engr.sgi.com>
 <20061103165854.0f3e77ad.akpm@osdl.org> <Pine.LNX.4.64.0611060846070.25351@schroedinger.engr.sgi.com>
 <20061106115925.1dd41a77.akpm@osdl.org> <Pine.LNX.4.64.0611061207310.26685@schroedinger.engr.sgi.com>
 <20061106122446.8269f7bc.akpm@osdl.org> <Pine.LNX.4.64.0611061229080.29760@schroedinger.engr.sgi.com>
 <20061106124257.deffa31c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2006, Andrew Morton wrote:

> > Interleave is used for data accessed from many nodes otherwise one would 
> > prefer to allocate from the current zone. The shared data may be very 
> > frequently accessed from multiple nodes and one would like different NUMA 
> > nodes to respond to these requests.
> 
> But what is "shared data"??  You're using a new but very general term
> without defining it.

Data that is shared by applications or by the kernel. The user space 
programs may allocate shared data with interleave policy. For certain data 
the kernel may use interleave allocations. F.e. page cache pages in a 
cpuset configured for memory spreading.

It depends what the application or the kernel designates to be shared 
data.

> OK, but if two nodes have a lot of free pages and the rest don't then
> interleave will consume those free pages without performing any reclaim
> from all the other nodes.  Hence hostpots or imbalances.
> 
> Whatever they are.  Why does it matter?

Hotspots create lots of requests going to the same numa node. The nodes 
have a limited capability to service cacheline requests and the bandwidth 
on the interlink is also limited. If too many processors request 
information from the same remote node then performance will drop.

There are different kind of data in a NUMA system:

Data that is node local is only accessed by the local processor. For node 
local data we have no such concerns since the interlink is not used. Quite 
a lot of kernel data per node or per cpu and thus is not a problem.

For shared data that is known to be performance critical--and where we 
know that the data is accessed from multiple nodes--there we need to 
balance the data between multiple nodes to avoid overloads and 
to keep the system running at optimal speed. That is where interleave 
becomes important.


