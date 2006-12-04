Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937328AbWLDTl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937328AbWLDTl5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 14:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937329AbWLDTl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 14:41:57 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:44377 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937328AbWLDTl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 14:41:56 -0500
Date: Mon, 4 Dec 2006 11:41:42 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Mel Gorman <mel@skynet.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
In-Reply-To: <20061204113051.4e90b249.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612041133020.32337@schroedinger.engr.sgi.com>
References: <20061130170746.GA11363@skynet.ie> <20061130173129.4ebccaa2.akpm@osdl.org>
 <Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie> <20061201110103.08d0cf3d.akpm@osdl.org>
 <20061204140747.GA21662@skynet.ie> <20061204113051.4e90b249.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006, Andrew Morton wrote:

> My concern is that __GFP_MOVABLE is useful for fragmentation-avoidance, but
> useless for memory hot-unplug.  So that if/when hot-unplug comes along
> we'll add more gunk which is a somewhat-superset of the GFP_MOVABLE
> infrastructure, hence we didn't need the GFP_MOVABLE code.  Or something.

It is useless for memory unplug until we implement limits for unmovable 
pages in a zone (per MA_ORDER area? That would fit nicely into the anti 
frag scheme) or until we have logic that makes !GFP_MOVABLE allocations 
fall back to a node that is not removable.

> That depends on how we do hot-unplug, if we do it.  I continue to suspect
> that it'll be done via memory zones: effectively by resurrecting
> GFP_HIGHMEM.  In which case there's little overlap with anti-frag.  (btw, I
> have a suspicion that the most important application of memory hot-unplug
> will be power management: destructively turning off DIMMs).

There are numerous other uses as well (besides DIMM and node unplug):

1. Faulty DIMM isolation
2. Virtual memory managers can reduce memory without resorting to 
   balloons.
3. Physical removal and exchange of memory while a system is running
   (Likely necessary to complement hotplug cpu, cpus usually come
   with memory).

The multi zone approach does not work with NUMA. NUMA only supports a 
single zone for memory policy control etc. Also multiple zones carry with 
it a management overhead that is unnecessary for the MOVABLE/UNMOVABLE
distinction.
 
> perhaps not for the hugetlbpage problem.  Whereas anti-fragmentation adds
> vastly more code, but can address both problems?  Or something.

I'd favor adding full defragmentation.
