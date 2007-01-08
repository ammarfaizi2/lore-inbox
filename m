Return-Path: <linux-kernel-owner+w=401wt.eu-S1422711AbXAHTbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422711AbXAHTbe (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 14:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422709AbXAHTbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 14:31:33 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:49551 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422706AbXAHTbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 14:31:31 -0500
X-AuditID: d80ac21c-a26c8bb000003b68-8e-45a29c12cba9 
Date: Mon, 8 Jan 2007 19:31:43 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Richard Purdie <richard@openedhand.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/4] Improve swap page error handling
In-Reply-To: <1168264124.5605.66.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0701081835500.1389@blonde.wat.veritas.com>
References: <1168264124.5605.66.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 08 Jan 2007 19:31:25.0921 (UTC) FILETIME=[9640AD10:01C7335B]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2007, Richard Purdie wrote:
> Improve the error handling when writes fail to a swap page. 
> 
> Currently, the kernel will repeatedly retry the write which is unlikely
> to ever succeed. Instead we allow the pages to be unused and then marked
> as bad at which prevents reuse. It should hopefully be suitable for
> testing in -mm.
> 
> These patches are a based on a patch by Nick Piggin and some of my own
> patches/bugfixes as discussed on LKML.

No, not this way, I'm afraid.  Sorry, I don't remember the prior
discussion on LKML, must have flooded past when my attention was
elsewhere.

Is it worth doing this at all?  Probably, but I've no experience
whatsoever of swap write errors, so it's hard for me to judge: my
guess is that many cases would turn out to be software errors (e.g.
lower level needing more memory to perform the write).  But you'd
be right to counter: let's assume they're hardware errors, and
then fix up any software errors when reported.

If it is worth doing this, then you'll need to add code to write
back the swap header, to note the bad pages permanently: you may
well have been waiting to see what reception the patches so far
get, before embarking on that.

1/4 seemed mostly reasonable to me at first, though I had a few
nits about the way you'd divided it between try_to_unuse_entry
and try_to_unuse (e.g. the complication of !start_mm_p belongs
to a later patch, and the mm_users check belongs in try_to_unuse).

I was uneasy with 2/4, wondered if swap_free(entry, page) would
be a better direction to go than your swap_free_markbad(entry).

I disliked 3/4: that initial_locked argument to try_to_unuse_entry,
which (I think) was only necessary because you'd put the lock_page
in try_to_unuse_entry instead of try_to_unuse in the first one.

I rather liked 4/4, the way you let the page rotate around and at
that point discover the failure and fix it up.  But that reveals
both the problem with your approach and its solution.

The killer problem, doing it this way, is that unuse_mm does
down_read(&mm->mmap_sem) for every mm it's tried on, but it's very
possible that the process doing shrink_page_list holds an mmap_sem:
most likely only for reading, but even a recursive down_read can
be deadlocked by a waiting down_write.  There may be more such
problems, I didn't bother to think further once I'd seen that.

But it hints at the solution too.  You're calling your
try_to_unuse_page_entry shortly before the call to try_to_unmap,
and try_to_unmap manages to find all the pages without needing
any mmap_sems at all.

I guess your approach simply highlights my laziness: all the mm
stuff that you factor out in 1/4 dates from before rmap came in.
It still serves a vital purpose, when dealing with pages freshly
read in from swap, when there's no record of what mm or tmpfs file
they belong to; but once that's known, it much quicker to use an
rmap technique, looping through the vmas of the relevant anon_vma
(taking its lock), than scanning all the (swapped) mms in the system.

All I bothered to do, after objrmap came in, was force a shortcut in
unuse_vma once the anon_vma is known (that page_address_in_vma call):
it didn't seem worth rejigging the whole mm loop.  But now you have
another use for unusing a swap entry, that is surely the way to go:
the mm loop is unnecessary, or becomes unnecessary, once we know
the anon_vma to which the swap page belongs.  Which is already so
for your failed-write swap pages.

Hugh
