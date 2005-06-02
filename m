Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVFBOCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVFBOCG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 10:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVFBOCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 10:02:06 -0400
Received: from dvhart.com ([64.146.134.43]:64166 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261427AbVFBOBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 10:01:38 -0400
Date: Thu, 02 Jun 2005 07:01:37 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, jschopp@austin.ibm.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version 12
Message-ID: <333490000.1117720896@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.58.0506021120120.4112@skynet>
References: <20050531112048.D2511E57A@skynet.csn.ul.ie> <429E20B6.2000907@austin.ibm.com><429E4023.2010308@yahoo.com.au> <423970000.1117668514@flay> <Pine.LNX.4.58.0506021120120.4112@skynet>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> Other than the very minor whitespace changes above I have nothing bad to
>> >> say about this patch.  I think it is about time to pick in up in -mm for
>> >> wider testing.
>> >> 
>> > 
>> > It adds a lot of complexity to the page allocator and while
>> > it might be very good, the only improvement we've been shown
>> > yet is allocating lots of MAX_ORDER allocations I think? (ie.
>> > not very useful)
>> 
>> I agree that MAX_ORDER allocs aren't interesting, but we can hit
>> frag problems easily at way less than max order. CIFS does it, NFS
>> does it, jumbo frame gigabit ethernet does it, to name a few. The
>> most common failure I see is order 3.
>> 
> 
> I focused on the MAX_ORDER allocations for two reasons. The first is
> because they are very difficult to satisfy. If we can service MAX_ORDER
> allocations, we can certainly service order 3. The second is that my very
> long-term (and currently vapour-ware) aim is to transparently support
> large pages which will require 4MiB blocks on the x86 at least.

Oh, I wasn't arguing with your approach ... is always better to go a bit
further. Was just illustrating that there are real world problems right
now that hit this stuff, ergo we need it. Yes, I'd like to be able to do 
large page, memory hotplug, etc too ... but if people aren't excited about
those, there are plenty of other reasons to fix the frag problem.

It seems apparent statistically that the larger the machine, the worse the
frag problem is, as we'll blow away more memory before getting contig 
blocks. If it wasn't pre-7am, I'd try to calculate the statistics, but 
frankly, I can't be bothered ;-) I'm sure there are others whose math
degree is less rusty than mine.

> With this allocator, we are still using a blunderbus approach but the
> chances of big enough chunks been available are a lot better. I released a
> proof-of-concept patch that freed pages by linearly scanning that worked
> very well, but it needs a lot of work. Linearly scanning would help
> guarantee high-order allocations but the penalty is that LRU-ordering
> would be violated.

Yes, would be nice ... but we need to gather things into freeable and 
non-freeable either way, it seems, so doesn't invalidate what you're 
doing at all.

It seems apparent statistically that the larger the machine, the worse the
frag problem is, as we'll blow away more memory before getting contig 
blocks. If it wasn't pre-7am, I'd try to calculate the statistics, but 
frankly, I can't be bothered ;-) I'm sure there are others whose math
degree is less rusty than mine, and I'd hate to deprive them of the 
opportunity to play ;-)

> To test lower-order allocations, I ran a slightly different test where I
> tried to allocate 6000 order-5 pages under heavy pressure. The standard
> allocator repeatadly went OOM and allocated 5190 pages. The modified one
> did not OOM and allocated 5961. The test is not very fair though because
> it pins memory and the allocations are type GFP_KERNEL. For the gigabit
> ethernet and network filesystem tests, I imagine we are dealing with
> GFP_ATOMIC or GFP_NFS?

cifsd: page allocation failure. order:3, mode:0xd0

M.
