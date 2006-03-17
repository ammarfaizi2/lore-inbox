Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbWCQRzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWCQRzb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWCQRza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:55:30 -0500
Received: from silver.veritas.com ([143.127.12.111]:15038 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1030237AbWCQRza
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:55:30 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.03,105,1141632000"; 
   d="scan'208"; a="36035164:sNHT23165584"
Date: Fri, 17 Mar 2006 17:55:56 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, rlrevell@joe-job.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix free swap cache latency
In-Reply-To: <441A246A.4090208@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0603171734500.643@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0603161853300.24463@goblin.wat.veritas.com>
 <20060316173808.3be343b0.akpm@osdl.org> <441A246A.4090208@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Mar 2006 17:55:29.0619 (UTC) FILETIME=[FA8AF230:01C649EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2006, Nick Piggin wrote:
> Andrew Morton wrote:
> > Hugh Dickins <hugh@veritas.com> wrote:
> > 
> > >			(*zap_work)--;
> > >			continue;
> > > 		}
> > > +
> > > +		(*zap_work) -= PAGE_SIZE;
> > 
> > 
> > Sometimes we subtract 1 from zap_work, sometimes PAGE_SIZE.  It's in
> > units
> > of bytes, so PAGE_SIZE is correct.  Although it would make sense to
> > redefine it to be in units of PAGE_SIZE.  What's up with that?
> 
> Subtracting 1 if there is no work to do for that cacheline entry.
> 
> > Even better, define it in units of "approximate number of touched
> > cachelines".  After all, it is a sort-of-time-based thing.
> 
> Yeah that was the rough intention, but I never actually measured
> to see whether the results were right.
> .... 
> So it gets hard to count, especially if you have other CPUs contending
> the same locks. I suspect the per-page cost is not really 128 cache
> misses most of the time, but it was just a number I pulled out. Anyone
> can feel free to turn the knob if they feel they have a better idea.

Accounting PAGE_SIZE for a present pte or swap entry preserves the
same latency allowance as Ingo made when he introduced ZAP_BLOCK_SIZE,
so it assures us of no regression on those.

I've always felt a pte_none entry probably ought to count for more than
1 on that scale, perhaps 16.  But likewise never did any calculation or
research, nor heard of any complaints - and large stretches of pte_none
should be quite a common case, after your copy_page_range optimization.

Plus we've both regarded that code as just for the interim, while both
of us (I see today) pursue preemptible mmu_gather solutions (I'll look
at your patch and report, but not today).

Hugh
