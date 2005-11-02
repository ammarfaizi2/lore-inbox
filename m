Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932621AbVKBHqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbVKBHqp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbVKBHqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:46:45 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:53430 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932621AbVKBHqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:46:44 -0500
To: Ingo Molnar <mingo@elte.hu>
cc: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19 
In-reply-to: Your message of Wed, 02 Nov 2005 08:19:43 +0100.
             <20051102071943.GA1574@elte.hu> 
Date: Tue, 01 Nov 2005 23:46:35 -0800
Message-Id: <E1EXDKN-0004b9-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 02 Nov 2005 08:19:43 +0100, Ingo Molnar wrote:
> 
> * Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> 
> > My own target is NUMA node hotplug, what NUMA node hotplug want is
> > - [remove the range of memory] For this approach, admin should define
> >   *core* node and removable node. Memory on removable node is removable.
> >   Dividing area into removable and not-removable is needed, because
> >   we cannot allocate any kernel's object on removable area.
> >   Removable area should be 100% removable. Customer can know the limitation 
> >   before using.
> 
> that's a perfectly fine method, and is quite similar to the 'separate 
> zone' approach Nick mentioned too. It is also easily understandable for 
> users/customers.
> 
> under such an approach, things become easier as well: if you have zones 
> you can to restrict (no kernel pinned-down allocations, no mlock-ed 
> pages, etc.), there's no need for any 'fragmentation avoidance' patches!  
> Basically all of that RAM becomes instantly removable (with some small 
> complications). That's the beauty of the separate-zones approach. It is 
> also a limitation: no kernel allocations, so all the highmem-alike 
> restrictions apply to it too.
> 
> but what is a dangerous fallacy is that we will be able to support hot 
> memory unplug of generic kernel RAM in any reliable way!
> 
> you really have to look at this from the conceptual angle: 'can an 
> approach ever lead to a satisfactory result'? If the answer is 'no', 
> then we _must not_ add a 90% solution that we _know_ will never be a 
> 100% solution.
> 
> for the separate-removable-zones approach we see the end of the tunnel.  
> Separate zones are well-understood.
> 
> generic unpluggable kernel RAM _will not work_.

Actually, it will.  Well, depending on terminology.

There are two usage models here - those which intend to remove physical
elements and those where the kernel returnss management of its virtualized
"physical" memory to a hypervisor.  In the latter case, a hypervisor
already maintains a virtual map of the memory and the OS needs to release
virtualized "physical" memory.  I think you are referring to RAM here as
the physical component; however these same defrag patches help where a
hypervisor is maintaining the real physical memory below the operating
system and the OS is managing a virtualized "physical" memory.

On pSeries hardware or with Xen, a client OS can return chunks of memory
to the hypervisor.  That memory needs to be returned in chunks of the
size that the hypervisor normally manages/maintains.  But long ranges
of physical contiguity are not required.  Just shorter ranges, depending
on what the hypervisor maintains, need to be returned from the OS to
the hypervisor.

In other words, if we can return 1 MB chunks, the hypervisor can hand
out those 1 MB chunks to other domains/partitions.  So, if we can return
500 1 MB chunks from a 2 GB OS instance, we can add 500 MB dyanamically
to another OS image.

This happens to be a *very* satisfactory answer for virtualized environments.

The other answer, which is harder, is to return (free) entire large physical
chunks, e.g. the size of the full memory of a node, allowing a node to be
dynamically removed (or a DIMM/SIMM/etc.).

So, people are working towards two distinct solutions, both of which
require us to do a better job of defragmenting memory (or avoiding
fragementation in the first place).

gerrit
