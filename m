Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUIEGLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUIEGLj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 02:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUIEGLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 02:11:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:23978 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266221AbUIEGLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 02:11:35 -0400
Date: Sat, 4 Sep 2004 23:09:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: torvalds@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] beat kswapd with the proverbial clue-bat
Message-Id: <20040904230939.03da8d2d.akpm@osdl.org>
In-Reply-To: <413AA7B2.4000907@yahoo.com.au>
References: <413AA7B2.4000907@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Kswapd is dumb as bricks when it comes to higher order allocations.
> Actually that's not quite fair: it is bad at lots of things... but
> higher order allocations are one of its more spectacular failures.
> 
> The major problem that I can see is with !wait allocations, where
> you aren't allowed to free anything yourself - you're relying on
> kswapd (aside from that, it's always nice to avoid synchronous reclaim).
> 
> Apparently these (higher-order && !wait) come up mainly in networking
> which is the thing I had in mind. *However* as I only have half of a
> gigabit network (ie. 1 card), I haven't done any testing where it
> really counts. I'm also seeing surprisingly few reports on lkml, so
> perhaps it is me that needs the beating?

There have been few reports, and I believe that networking is getting
changed to reduce the amount of GFP_ATOMIC higher-order allocation
attempts.

There have been multiple instances in the past year or so where we've made
changes in there, the changes were not adequately tested and stuff broke in
subtle ways.  We need to raise the bar a bit - clearly demonstrate that we
have a problem, and then demonstrate that the fix fixes it, then worry
about side-effects.

> Anyway, the big failure case is when memory is fragmented to the
> point that pages_free > pages_low, but you still have no higher order
> pages left. In that case, your !wait allocations can keep calling
> wakeup_kswapd but he'll just keep sleeping. min_free_kbytes is not
> really a solution because it just raises pages_low. In a nutshell,
> that whole area doesn't really have any idea about higher order
> allocations.
> 
> So my solution? Just teach kswapd and the watermark code about higher
> order allocations in a fairly simple way. If pages_low is (say), 1024KB,
> we now also require 512KB of order-1 and above pages, 256K of order-2
> and up, 128K of order 3, etc. (perhaps we should stop at about order-3?)
> 
> *Also*, if we have requested an order 5 allocation, but one isn't
> available, we'll get kswapd to try to free at least 1, even if its
> order-5 "free-until" watermark is 0KB.
> 
> The main cost is keeping track of the number of free pages of each order.
> There is also a penalty in the allocator for order > 0 allocations, but
> I have tried to do it so lower order allocations need to do less work.
> 

I don't see anything in your code which directly prevents the following
serious scenario:

a) Some random 0-order allocation causes a 4-order page to be split up,
   taking the 4-order pool below threshold.

b) kswapd goes berzerk reclaiming 9000 pages to replenish the 4-order
   pool even though we don't need it.  

You have arith in there which kinda-sorta prevents it, but I don't see any
hard-and-fast protection.  Or did I miss it?  
