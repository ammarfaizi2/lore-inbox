Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030510AbWHRSou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030510AbWHRSou (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWHRSou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:44:50 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:40109 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751465AbWHRSot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:44:49 -0400
Date: Fri, 18 Aug 2006 11:44:22 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: manfred@colorfullife.com, ak@muc.de, mpm@selenic.com, marcelo@kvack.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, ak@suse.de,
       dgc@sgi.com
Subject: Re: [MODSLAB 3/7] A Kmalloc subsystem
In-Reply-To: <20060819031916.85d5979e.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0608181138190.32621@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
 <20060816022253.13379.76984.sendpatchset@schroedinger.engr.sgi.com>
 <20060816094358.e7006276.ak@muc.de> <Pine.LNX.4.64.0608161718160.19789@schroedinger.engr.sgi.com>
 <44E3FC4F.2090506@colorfullife.com> <Pine.LNX.4.64.0608172222210.29168@schroedinger.engr.sgi.com>
 <20060818161739.f7581645.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0608180956080.31844@schroedinger.engr.sgi.com>
 <20060819031916.85d5979e.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2006, KAMEZAWA Hiroyuki wrote:

> At first, ia64's DISCONTIG is special because of VIRTUAL_MEMMAP.
> and ia64's SPARSEMEM is special,too. it's SPARSEMEM_EXTREME.

Right. Would it be possible to get VIRTUAL_MEMMAP support into SPARSEMEM?

> with FLATMEM, pfn_to_page() is  pfn + mem_map. just an address calclation.

So the virt_to_page is as fast as IA64 DISCONTIG on UP and SMP.

> with *usual* DISCONTIG
> --  
>   pgdat = NODE_DATA(pfn_to_nid(pfn));
>   page = pgdat->node_mem_map + pfn - pgdat->node_start_pfn
> --
> if accessing to pgdat is fast, cost will not be big problem.
> pfn_to_nid() is usually implemeted by calclation or table look up.

Hmmm.... pfn_to_nid usually involves a table lookup. So two table lookups 
to get there.

> and usual SPARSEMEM, (not EXTREME)
> --
> page = mem_section[(pfn >> SECTION_SHIFT)].mem_map + pfn
> --
> need one table look up. maybe not very big.

Bigger than a cacheline that can be kept in the cache? On a large Altix we 
may have 1k nodes meaning up to 4k zones!

> with SPARSEMEM_EXTREME
> --
> page = mem_section[(pfn >> SECTION_SHIFT)][(pfn & MASK)].mem_map + pfn
> --
> need one (big)table look up.

Owww... Cache issues.

Could we do the lookup using a sparse virtually mapped table like on 
IA64. Then align section shift to whatever page table is in place (on 
platforms that require page tables and IA64 could continue to use its 
special handler)?

Then page could be reached via

page = vmem_map + pfn

again ?

