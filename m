Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbVAUSAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbVAUSAE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 13:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVAUSAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 13:00:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2461 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262438AbVAUR6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 12:58:38 -0500
Date: Fri, 21 Jan 2005 12:28:54 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Avoiding fragmentation through different allocator
Message-ID: <20050121142854.GH19973@logos.cnet>
References: <20050120101300.26FA5E598@skynet.csn.ul.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120101300.26FA5E598@skynet.csn.ul.ie>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 10:13:00AM +0000, Mel Gorman wrote:
> Changelog since V5
> o Fixed up gcc-2.95 errors
> o Fixed up whitespace damage
> 
> Changelog since V4
> o No changes. Applies cleanly against 2.6.11-rc1 and 2.6.11-rc1-bk6. Applies
>   with offsets to 2.6.11-rc1-mm1
> 
> Changelog since V3
> o inlined get_pageblock_type() and set_pageblock_type()
> o set_pageblock_type() now takes a zone parameter to avoid a call to page_zone()
> o When taking from the global pool, do not scan all the low-order lists
> 
> Changelog since V2
> o Do not to interfere with the "min" decay
> o Update the __GFP_BITS_SHIFT properly. Old value broke fsync and probably
>   anything to do with asynchronous IO
>   
> Changelog since V1
> o Update patch to 2.6.11-rc1
> o Cleaned up bug where memory was wasted on a large bitmap
> o Remove code that needed the binary buddy bitmaps
> o Update flags to avoid colliding with __GFP_ZERO changes
> o Extended fallback_count bean counters to show the fallback count for each
>   allocation type
> o In-code documentation

Hi Mel,

I was thinking that it would be nice to have a set of high-order intensive workloads, 
and I wonder what are the most common high-order allocation paths which fail.

It mostly depends on hardware because most high-order allocations happen inside
device drivers? What are the kernel codepaths which try to do high-order allocations
and fallback if failed? 

To measure whether the cost of page migration offsets the ability to be able to deliver
high-order allocations we want a set of meaningful performance tests?

Its quite possible that not all unsatisfiable high-order allocations want to 
force page migration (which is quite expensive in terms of CPU/cache). Only migrate on 
__GFP_NOFAIL ?

William, that same tradeoff exists for the zone balancing through migration idea
you propose...


