Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbUBWA0H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 19:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbUBWA0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 19:26:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:32723 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261290AbUBWA0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 19:26:01 -0500
Date: Sun, 22 Feb 2004 16:26:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: cw@f00f.org, mfedyk@matchmail.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
Message-Id: <20040222162634.560c5306.akpm@osdl.org>
In-Reply-To: <40394662.5060104@cyberone.com.au>
References: <20040222033111.GA14197@dingdong.cryptoapps.com>
	<4038299E.9030907@cyberone.com.au>
	<40382BAA.1000802@cyberone.com.au>
	<4038307B.2090405@cyberone.com.au>
	<40383300.5010203@matchmail.com>
	<4038402A.4030708@cyberone.com.au>
	<40384325.1010802@matchmail.com>
	<403845CB.8040805@cyberone.com.au>
	<20040221221721.42e734d6.akpm@osdl.org>
	<40384D9D.6040604@cyberone.com.au>
	<20040222083637.GA15589@dingdong.cryptoapps.com>
	<20040222011350.58f756e8.akpm@osdl.org>
	<40394662.5060104@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> 
> 
> Andrew Morton wrote:
> 
> >Chris Wedgwood <cw@f00f.org> wrote:
> >
> >>On Sun, Feb 22, 2004 at 05:35:09PM +1100, Nick Piggin wrote:
> >>
> >>
> >>>Can you maybe use this patch then, please?
> >>>
> >>I probably need to do more testing, but the quick patch I was using
> >>against mainline (bk head) works better than this against 2.5.3-mm2.
> >>
> >
> >The patch which went in six months or so back which said "only reclaim slab
> >if we're scanning lowmem pagecache" was wrong.  I must have been asleep at
> >the time.
> >
> >We do need to scan slab in response to highmem page reclaim as well. 
> >Because all the math is based around the total amount of memory in the
> >machine, and we know that if we're performing highmem page reclaim then the
> >lower zones have no free memory.
> >
> >
> 
> I don't understand this. Presumably if the lower zones have no free
> memory then we'll be doing lowmem page reclaim too, and that will
> be shrinking the slab.

We should be performing lowmem page reclaim, but we're not.  With some
highmem/lowmem size combinations the `incremental min' logic in the page
allocator will prevent __GFP_HIGHMEM allocations from taking ZONE_NORMAL
below pages_high and kswapd then does not perform page reclaim in the
lowmem zone at all.  I'm seeing some workloads where we reclaim 700 highmem
pages for each lowmem page.  This hugely exacerbated the slab problem on
1.5G machines.  I have that fixed up now.

Regardless of that, we do, logically, want to reclaim slab in response to
highmem reclaim pressure because any highmem allocation can be satisfied by
lowmem too.

