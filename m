Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbVJaGzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbVJaGzV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 01:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbVJaGzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 01:55:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35528 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751065AbVJaGzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 01:55:20 -0500
Date: Sun, 30 Oct 2005 23:54:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kravetz@us.ibm.com, mel@csn.ul.ie, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-Id: <20051030235440.6938a0e9.akpm@osdl.org>
In-Reply-To: <4365BBC4.2090906@yahoo.com.au>
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie>
	<20051031055725.GA3820@w-mikek2.ibm.com>
	<4365BBC4.2090906@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Mike Kravetz wrote:
> > On Sun, Oct 30, 2005 at 06:33:55PM +0000, Mel Gorman wrote:
> > 
> >>Here are a few brief reasons why this set of patches is useful;
> >>
> >>o Reduced fragmentation improves the chance a large order allocation succeeds
> >>o General-purpose memory hotplug needs the page/memory groupings provided
> >>o Reduces the number of badly-placed pages that page migration mechanism must
> >>  deal with. This also applies to any active page defragmentation mechanism.
> > 
> > 
> > I can say that this patch set makes hotplug memory remove be of
> > value on ppc64.  My system has 6GB of memory and I would 'load
> > it up' to the point where it would just start to swap and let it
> > run for an hour.  Without these patches, it was almost impossible
> > to find a section that could be offlined.  With the patches, I
> > can consistently reduce memory to somewhere between 512MB and 1GB.
> > Of course, results will vary based on workload.  Also, this is
> > most advantageous for memory hotlug on ppc64 due to relatively
> > small section size (16MB) as compared to the page grouping size
> > (8MB).  A more general purpose solution is needed for memory hotplug
> > support on architectures with larger section sizes.
> > 
> > Just another data point,
> 
> Despite what people were trying to tell me at Ottawa, this patch
> set really does add quite a lot of complexity to the page
> allocator, and it seems to be increasingly only of benefit to
> dynamically allocating hugepages and memory hot unplug.

Remember that Rohit is seeing ~10% variation between runs of scientific
software, and that his patch to use higher-order pages to preload the
percpu-pages magazines fixed that up.  I assume this means that it provided
up to 10% speedup, which is a lot.

But the patch caused page allocator fragmentation and several reports of
gigE Tx buffer allocation failures, so I dropped it.

We think that Mel's patches will allow us to reintroduce Rohit's
optimisation.

> If that is the case, do we really want to make such sacrifices
> for the huge machines that want these things? What about just
> making an extra zone for easy-to-reclaim things to live in?
> 
> This could possibly even be resized at runtime according to
> demand with the memory hotplug stuff (though I haven't been
> following that).
> 
> Don't take this as criticism of the actual implementation or its
> effectiveness.
> 

But yes, adding additional complexity is a black mark, and these patches
add quite a bit.  (Ditto the fine-looking adaptive readahead patches, btw).
