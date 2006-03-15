Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWCOHv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWCOHv1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 02:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWCOHv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 02:51:27 -0500
Received: from silver.veritas.com ([143.127.12.111]:25899 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932181AbWCOHv1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 02:51:27 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,193,1139212800"; 
   d="scan'208"; a="35900668:sNHT26602028"
Date: Wed, 15 Mar 2006 07:52:20 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc1: 28ms latency when process with lots of swapped memory
 exits
In-Reply-To: <1142375939.24603.33.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0603150721040.9086@goblin.wat.veritas.com>
References: <1142352926.13256.117.camel@mindpipe> 
 <Pine.LNX.4.61.0603141812400.5882@goblin.wat.veritas.com> 
 <20060314210142.GA23458@elte.hu> <1142375939.24603.33.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Mar 2006 07:51:26.0759 (UTC) FILETIME=[4349E370:01C64805]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2006, Lee Revell wrote:
> On Tue, 2006-03-14 at 22:01 +0100, Ingo Molnar wrote:
> > hm, where does the latency come from? We do have a lockbreaker in 
> > unmap_vmas():
> > 
> >                         if (need_resched() ||
> >                                 (i_mmap_lock &&
> > need_lockbreak(i_mmap_lock))) {
> >                                 if (i_mmap_lock) {
> >                                         *tlbp = NULL;
> >                                         goto out;
> >                                 }
> >                                 cond_resched();
> >                         }
> > 
> > 
> > why doesnt this break up the 28ms latency?

That block is actually for PREEMPT n, and for truncating a mapped
file (i_mmap_lock additionally held): all Lee's PREEMPT y exit case
should need is the tlb_finish_mmu and tlb_gather_mmu around it,
letting preemption in - and the ZAP_BLOCK_SIZE 8*PAGE_SIZE.

> But the preempt count is >= 2, doesn't that mean some other lock must be
> held also, or someone called preempt_disable?

Yes, as I read the trace (and let me admit, I'm not at all skilled at
reading those traces), and as your swap observation implies, this is
not a problem with ptes present, but with swap entries: and with the
radix tree lookup involved in finding whether they have an associated
struct page in core - all handled while holding page table lock, and
while holding the per-cpu mmu_gather structure.

Oh, thank you for forcing me to take another look, 2.6.15 did make a
regression there, and this one is very simply remedied: Lee, please
try the patch below (I've done it against 2.6.16-rc6 because that's
what I have to hand; and would be a better tree for you to test),
and let us know if it fixes your case as I expect - thanks.

(Robin Holt observed how inefficient the small ZAP_BLOCK_SIZE was on
very sparse mmaps, as originally implemented; so he and Nick reworked
it to count only real work done; but the swap entries got put on the
side of "no real work", whereas you've found they may involve very
significant work.  My patch below reverses that: yes, I've got some
other cases now going the slow way when they needn't, but they're
too rare to clutter the code for.)

Hugh

--- 2.6.16-rc6/mm/memory.c	2006-03-12 15:25:45.000000000 +0000
+++ linux/mm/memory.c	2006-03-15 07:32:36.000000000 +0000
@@ -623,11 +623,12 @@ static unsigned long zap_pte_range(struc
 			(*zap_work)--;
 			continue;
 		}
+
+		(*zap_work) -= PAGE_SIZE;
+
 		if (pte_present(ptent)) {
 			struct page *page;
 
-			(*zap_work) -= PAGE_SIZE;
-
 			page = vm_normal_page(vma, addr, ptent);
 			if (unlikely(details) && page) {
 				/*
