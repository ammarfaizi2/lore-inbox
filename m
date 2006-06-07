Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWFGJQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWFGJQk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 05:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWFGJQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 05:16:40 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:11419 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S932079AbWFGJQj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 05:16:39 -0400
Date: Wed, 7 Jun 2006 10:16:37 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Bligh <mbligh@google.com>, apw@shadowen.org,
       linux-kernel@vger.kernel.org
Subject: Re: sparsemem panic in 2.6.17-rc5-mm1 and -mm2
Message-ID: <20060607091636.GA19510@skynet.ie>
References: <4484D174.7080902@google.com> <20060606164241.69d55238.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060606164241.69d55238.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: mel@csn.ul.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/06/06 16:42), Andrew Morton didst pronounce:
> On Mon, 05 Jun 2006 17:51:00 -0700
> Martin Bligh <mbligh@google.com> wrote:
> 
> > http://test.kernel.org/abat/34264/debug/console.log
> 
> What sort of machine is this, anyway?
> 
> > WARNING: Not an IBM x440/NUMAQ and CONFIG_NUMA enabled!
> 

It's an IBM x440 that is not recognised by that check. Later in the log,
we see

IBM eserver xSeries 440 detected: force use of acpi=ht

> And is it expected that ZONE_NORMAL only has 384MB?  That seems awfully low
> for a 64GB x86 machine.  Could be that we went oom because we chose to
> allocate really big hash tables, based on the total amount of memory?
> 

The log reports 392MB LOWMEM available. As it is 32 bit machine, it started
with about 896MB but consumes much of it with mem_maps.  The log shows
calculate_numa_remap_pages() reporting

Reserving 35328 pages of KVA for lmem_map of node 0
Shrinking node 0 from 4456448 pages to 4421120 pages
Reserving 31232 pages of KVA for lmem_map of node 1
Shrinking node 1 from 8650752 pages to 8619520 pages
Reserving 31232 pages of KVA for lmem_map of node 2
Shrinking node 2 from 12845056 pages to 12813824 pages
Reserving 29184 pages of KVA for lmem_map of node 3
Shrinking node 3 from 16777216 pages to 16748032 pages
Reserving total of 126976 pages for numa KVA remap
reserve_pages = 126976 find_max_low_pfn() ~ 229375

That is 400MB gone already which is mapped to lowmem. A little later in the
log, it says

min_low_pfn = 1140, max_low_pfn = 100352, highstart_pfn = 100352

so about 4MB is missing from the beginning (probably the kernel image),
so we're down to 396ish. Not sure where the last 4MB is exactly but you
get the idea.

While it is possible we are going OOM due to the size of lowmem, it's
doubtful to be the only cause.
http://test.kernel.org/functional/index.html shows that elm3b67 (the
machine in question) has passed loads of tests in the past.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
