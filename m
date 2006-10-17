Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423147AbWJQGhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423147AbWJQGhv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 02:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423149AbWJQGhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 02:37:51 -0400
Received: from smtp-out.google.com ([216.239.45.12]:62644 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1423147AbWJQGhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 02:37:50 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:references:in-reply-to:content-type:content-transfer-encoding;
	b=FBnhE1b2LAQaydlbqrNtOlsAoRyEXEZOcrylxyPplMRY3BuWOT2kGR0lfx5YUaS5H
	SsBINApZlIDz4mmDcF1Sg==
Message-ID: <453479D2.1090302@google.com>
Date: Mon, 16 Oct 2006 23:36:02 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH] Fix bug in try_to_free_pages and balance_pgdat when they
 fail to reclaim pages
References: <453425A5.5040304@google.com> <453475A4.2000504@yahoo.com.au>
In-Reply-To: <453475A4.2000504@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Martin Bligh wrote:
> 
>> The same bug is contained in both try_to_free_pages and balance_pgdat.
>> On reclaiming the requisite number of pages we correctly set
>> prev_priority back to DEF_PRIORITY.
> 
> 
> AFAIKS, we set prev_priority to the priority at which the zone was
> deemed to require no more reclaiming, not DEF_PRIORITY.

Well, it's zone->temp_priority, which was set to DEF_PRIORITY at the
top of the function, though I suppose something else might have
changed it since.

>> However, we ALSO do this even
>> if we loop over all priorities and fail to reclaim.
> 
> 
> If that happens, shouldn't prev_priority be set to 0?

Yes, but it's not. We fall off the bottom of the loop, and set it
back to temp_priority. At best, the code is unclear.

I suppose shrink_zones() might in theory knock temp_priority down
as it goes, so it might come out right. But given that it's a global
(per zone), not per-reclaimer, I fail to see how that's really safe.
Supposing someone else has just started reclaim, and is still at
prio 12?

Moreover, whilst try_to_free_pages calls shrink_zones, balance_pgdat
does not. Nothing else I can see sets temp_priority.

 > I don't agree the patch is correct.

You think it's doing something wrong? Or just unnecessary?

I'm inclined to think the whole concept of temp_priority and
prev_priority are pretty broken. This may not fix the whole thing,
but it seems to me to make it better than it was before.

> We saw problems with this before releasing SLES10 too. See
> zone_is_near_oom and other changesets from around that era. I would
> like to know what workload was prevented from going OOM with these
> changes, but zone_is_near_oom didn't help -- it must have been very
> marginal (or there may indeed be a bug somewhere).

Google production workload. Multiple reclaimers operating - one is
down to priority 0 on the reclaim, but distress is still set to 0,
thanks to prev_priority being borked. Hence we don't reclaim mapped
pages, the reclaim fails, OOM killer kicks in.

Forward ported from an earlier version of 2.6 ... but I don't see
why we need extra heuristics here, it seems like a clear and fairly
simple bug. We're in deep crap with reclaim, and we go set the
global indicator back to "oh no, everything's fine". Not a good plan.

M.
