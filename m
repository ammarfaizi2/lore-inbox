Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWGJQVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWGJQVO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 12:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbWGJQVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 12:21:14 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:16039 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964849AbWGJQVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 12:21:13 -0400
Date: Mon, 10 Jul 2006 09:20:56 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1 oops on x86_64
In-Reply-To: <20060709132135.6c786cfb.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0607100856540.4491@schroedinger.engr.sgi.com>
References: <20060709021106.9310d4d1.akpm@osdl.org> <44B12C74.9090104@fr.ibm.com>
 <20060709132135.6c786cfb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006, Andrew Morton wrote:

> I dunno, Christoph.  I think those patches are going to significantly
> increase the number of works-with-my-config, doesnt-with-yours scenarios.
> 
> We're going to hurt ourselves if we do this.

On the other hand we also clean up a lot of strange uses of HIGHMEM. The 
more we increase common memory the more we will go to 64 bit 
configurationa and at that point we want HIGHMEM to have the least impact 
possible.

Hmm... Actually we could leave __GFP_HIGHMEM at it prior value since
GFP_ZONEMASK masks it out anyways. Need to test this though. This may
also make some of the __GFP_DMA32 ifdefs unnecessary.

The advantages of zone reduction are:

1. It shortens traversal times of zones lists and significantly reduces 
   the amounts of cachelines touched (all the for_each_zone constructs). 
   See __drain_pages, nr_free_pages, show_free_areas,  multiple uses in 
   swap prefetch, shrink_all_zones, shrink_all_memory,
   refresh_cpu_vm_stats.

2. It reduces the number of allocations for pagesets significantly. In an
   extreme case (1024p 1024 nodes) we currently have 4*1024*4*1024 = 16 
   mio allocations of pagesets. The reduction brings that down to 
   2*1024*2*1024 = 4 mio. The number of pagesets grows by the square.

3. The macro changes allow lots of tests to be performed at compile time
   rather than at run time.

4. The changes in mmzone.h allow easy additions/removal of zones should
   this become necessary in the future.

5. Clean up the output from /proc/meminfo /proc/vmstat 
   /sys/devices/system/node/nodeX/meminfo for the !CONFIG_HIGHMEM case.

6. Shrink zones struct through removal of useless counters and shrink
   pgdat structure by reducing the size of node_zonelists.

7. The reduces zonelists significantly reduce the work to build
   the zonelists at startup time.
