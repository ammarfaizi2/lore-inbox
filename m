Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbVKWART@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbVKWART (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 19:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbVKWARS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 19:17:18 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:28049 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1030271AbVKWARR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 19:17:17 -0500
Date: Wed, 23 Nov 2005 00:17:05 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: "Seth, Rohit" <rohit.seth@intel.com>
Cc: linux-mm@kvack.org, nickpiggin@yahoo.com.au, ak@suse.de,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       mingo@elte.hu
Subject: RE: [PATCH 5/5] Light fragmentation avoidance without usemap:
 005_drainpercpu
In-Reply-To: <01EF044AAEE12F4BAAD955CB75064943053DF65D@scsmsx401.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.58.0511230009330.31913@skynet>
References: <01EF044AAEE12F4BAAD955CB75064943053DF65D@scsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Seth, Rohit wrote:

> From:  Mel Gorman Sent: Tuesday, November 22, 2005 11:18 AM
>
> >Per-cpu pages can accidentally cause fragmentation because they are
> free, >but
> >pinned pages in an otherwise contiguous block.  When this patch is
> applied,
> >the per-cpu caches are drained after the direct-reclaim is entered if
> the
>
> I don't think this is the right place to drain the pcp.  Since direct
> reclaim is already done, so it is possible that allocator can service
> the request without draining the pcps.
>

ok, true. A check should be made to see if it's possible yet and if not,
then drain. A more appropriate place might be after this block

                if (page)
                        goto got_pg;

>
> >requested order is greater than 3.
>
> Why this order limit.  Most of the previous failures seen (because of my
> earlier patches of bigger and more physical contiguous chunks for pcps)
> were with order 1 allocation.
>

The order 3 is because of this block;

        if (!(gfp_mask & __GFP_NORETRY)) {
                if ((order <= 3) || (gfp_mask & __GFP_REPEAT))
                        do_retry = 1;
                if (gfp_mask & __GFP_NOFAIL)
                        do_retry = 1;
        }

If it's less than 3, we are retrying anyway and it's something we are
already doing. If it was felt it had a chance of working before, I felt
that draining per-cpu caches was unnecessary.

> >It simply reuses the code used by suspend
> >and hotplug and only is triggered when anti-defragmentation is enabled.
> >
> That code has issues with pre-emptible kernel.
>

ok... why? I thought that we could only be preempted when we were about to
take a spinlock but I have an imperfect understanding of preempt and
things change quickly. The path the drain_all_local_pages() enters
disables the local IRQs before calling __drain_pages() and when
smp_drain_local_pages()  is called, the local IRQs are disabled again
before releasing pages. Where can we get preempted?

> I will be shortly sending the patch to free pages from pcp when higher
> order allocation is not able to get serviced from global list.
>

If that works, this part of the patch can be dropped. The intention is to
"drain the per-cpu lists by some mechanism". I am not too particular about
how it happens. Right now, the per-cpu caches make a massive difference on
my 4-way machine at least on whether a large number of contiguous blocks
can be allocated or not.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
