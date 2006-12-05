Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967955AbWLEBNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967955AbWLEBNH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 20:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967957AbWLEBNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 20:13:07 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:60213 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967955AbWLEBNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 20:13:04 -0500
Date: Tue, 5 Dec 2006 10:16:29 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: akpm@osdl.org, clameter@sgi.com, apw@shadowen.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
Message-Id: <20061205101629.5cb78828.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0612042338390.2108@skynet.skynet.ie>
References: <20061130170746.GA11363@skynet.ie>
	<20061130173129.4ebccaa2.akpm@osdl.org>
	<Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie>
	<20061201110103.08d0cf3d.akpm@osdl.org>
	<20061204140747.GA21662@skynet.ie>
	<20061204113051.4e90b249.akpm@osdl.org>
	<Pine.LNX.4.64.0612041946460.26428@skynet.skynet.ie>
	<20061204143435.6ab587db.akpm@osdl.org>
	<Pine.LNX.4.64.0612042338390.2108@skynet.skynet.ie>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, your plan looks good to me.
some comments.

On Mon, 4 Dec 2006 23:45:32 +0000 (GMT)
Mel Gorman <mel@csn.ul.ie> wrote:
> 1. Use lumpy-reclaim to intelligently reclaim contigous pages. The same
>     logic can be used to reclaim within a PFN range
> 2. Merge anti-frag to help high-order allocations, hugetlbpage
>     allocations and freeing up SPARSEMEM sections of memory
For freeing up SPARSEMEM sections of memory ? 
It looks that you assumes MAX_ORDER_NR_PAGES equals to PAGES_PER_SECTION.
plz don't assume that when you talk about generic arch code.

> 3. Anti-frag includes support for page flags that affected a MAX_ORDER block
>     of pages. These flags can be used to mark a section of memory that should
>     not be allocated from. This is of interest to both hugetlb page allocatoin
>     and memory hot-remove. Use the flags to mark a MAX_ORDER_NR_PAGES that
>     is currently being freed up and shouldn't be allocated. 

> 4. Use anti-frag fallback logic to bias unmovable allocations to the lower
>     PFNs.
I think this can be one of the most diffcult things ;)

> 5. Add arch support where possible for offlining sections of memory that
>     can be powered down.
I had a patch for ACPI-memory-hot-unplug, which ties memory sections to memory
chunk on ACPI.

> 6. Add arch support where possible to power down a DIMM when the memory
>     sections that make it up have been offlined. This is an extenstion of
>     step 5 only.
> 7. Add a zone that only allows __GFP_MOVABLE allocations so that
>     sections can 100% be reclaimed and powered-down
> 8. Allow nodes to only have a zone for __GFP_MOVABLE allocations so that
>     whole nodes can be offlined.
> 
I (numa-node-hotplug) needs 7 and 8 basically. And Other people may not.
IMHO:
For DIMM unplug, I suspect that we'll finally divide memory to core-memory and
hot-pluggable by pgdat even on SMP. If we use pgdat for that purpose, almost all
necessary infrastructure(statistics ,etc..) is ready. 
But if we find better way, it's good.

-Kame

