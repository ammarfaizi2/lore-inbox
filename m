Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbUKFNXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUKFNXx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 08:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbUKFNXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 08:23:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5017 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261389AbUKFNXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 08:23:50 -0500
Date: Sat, 6 Nov 2004 08:11:07 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrea Arcangeli <andrea@novell.com>, Jesse Barnes <jbarnes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041106101107.GB22514@logos.cnet>
References: <20041105200118.GA20321@logos.cnet> <200411051532.51150.jbarnes@sgi.com> <20041106012018.GT8229@dualathlon.random> <418C2861.6030501@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418C2861.6030501@cyberone.com.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 12:26:57PM +1100, Nick Piggin wrote:
> 
> 
> Andrea Arcangeli wrote:
> 
> >On Fri, Nov 05, 2004 at 03:32:50PM -0800, Jesse Barnes wrote:
> >
> >>On Friday, November 05, 2004 12:01 pm, Marcelo Tosatti wrote:
> >>
> >>>In my opinion the correct approach is to trigger the OOM killer
> >>>when kswapd is unable to free pages. Once that is done, the number
> >>>of tasks inside page reclaim is irrelevant.
> >>>
> >>That makes sense.
> >>
> >
> >I don't like it, kswapd may fail balancing because there's a GFP_DMA
> >allocation that eat the last dma page, but we should not kill tasks if
> >we fail to balance in kswapd, we should kill tasks only when no fail
> >path exists (i.e. only during page faults, everything else in the kernel
> >has a fail path and it should never trigger oom).
> >
> >If you move it in kswapd there's no way to prevent oom-killing from a
> >syscall allocation (I guess even right now it would go wrong in this
> >sense, but at least right now it's more fixable). I want to move the oom
> >kill outside the alloc_page paths. The oom killing is all about the page
> >faults not having a fail path, and in turn the oom killing should be
> >moved in the page fault code, not in the allocator. Everything else
> >should keep returning -ENOMEM to the caller.
> >
> >
> 
> Probably a good idea. OTOH, some kernel allocations might really
> need to be performed and have no failure path. For example __GFP_REPEAT.
> 
> I think maybe __GFP_REPEAT allocations at least should be able to
> cause an OOM. Not sure though.

As I said in my answer to Andrea, OOM killing is about allocations not being 
able to succeed (aka VM not being able to free pages).

kswapd is freeing pages, he is the one who knows about progress.

> >So to me moving the oom killer into kswapd looks a regression.
> 
> Also, I think it would do the wrong thing on NUMA machines because
> that has a per-node kswapd.

Right, we need to handle the NUMA case correctly (we need to which does "dont kill if other nodes
have available memory").

But still, it looks the right thing to do to me.
