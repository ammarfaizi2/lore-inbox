Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319028AbSH1V4B>; Wed, 28 Aug 2002 17:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319029AbSH1V4A>; Wed, 28 Aug 2002 17:56:00 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:33288 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S319028AbSH1V4A>; Wed, 28 Aug 2002 17:56:00 -0400
Message-ID: <3D6D477C.F5116BA7@zip.com.au>
Date: Wed, 28 Aug 2002 14:58:20 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] adjustments to dirty memory thresholds
References: <3D6C53ED.32044CAD@zip.com.au> <20020828200857.GB888@holomorphy.com> <3D6D3216.D472CBC3@zip.com.au> <20020828214243.GC888@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> ...
> I've already written the patch to address it, though of course, I can
> post those traces along with the patch once it's rediffed. (It's trivial
> though -- just a fresh GFP flag and a check for it before calling
> out_of_memory(), setting it in mempool_alloc(), and ignoring it in
> slab.c.) It requires several rounds of "un-throttling" to reproduce
> the OOM's, the nature of which I've outlined elsewhere.

That's a sane approach.  mempool_alloc() is designed for allocations
which "must" succeed if you wait long enough.

In fact it might make sense to only perform a single scan of the
LRU if __GFP_WLI is set, rather than the increasing priority thing.

But sigh.  Pointlessly scanning zillions of dirty pages and doing nothing
with them is dumb.  So much better to go for a FIFO snooze on a per-zone
waitqueue, be woken when some memory has been cleansed.  (That's effectively
what mempool does, but it's all private and different).

> One such trace is below, some of the others might require repeating the
> runs. It's actually a relatively deep call chain, I'd be worried about
> blowing the stack at this point as well.

Well it's presumably the GFP_NOIO which has killed it - we can't wait
on PG_writeback pages and we can't write out dirty pages.  Taking a
nap in mempool_alloc is appropriate.
