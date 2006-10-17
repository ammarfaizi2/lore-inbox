Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423135AbWJQGSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423135AbWJQGSS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 02:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423137AbWJQGSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 02:18:18 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:25171 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1423135AbWJQGSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 02:18:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=HiNI3M2dr54Zyi+5YAmKHrGQvTyDVnrwM9IuGNOCpqkKFqglvp6c2JPWe5j7XiLx3aYHj9RbeF+FmDh03KWa56KkQ84ZUOmot77VnZ0HqPeSt6HBA3UGaz6tKJOFbyNz2n0+kSS50e0Dr7FvVOAMVRkj/+g5jwluhytQVk4qpXY=  ;
Message-ID: <453475A4.2000504@yahoo.com.au>
Date: Tue, 17 Oct 2006 16:18:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH] Fix bug in try_to_free_pages and balance_pgdat when they
 fail to reclaim pages
References: <453425A5.5040304@google.com>
In-Reply-To: <453425A5.5040304@google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:

> The same bug is contained in both try_to_free_pages and balance_pgdat.
> On reclaiming the requisite number of pages we correctly set
> prev_priority back to DEF_PRIORITY.


AFAIKS, we set prev_priority to the priority at which the zone was
deemed to require no more reclaiming, not DEF_PRIORITY.

> However, we ALSO do this even
> if we loop over all priorities and fail to reclaim.


If that happens, shouldn't prev_priority be set to 0?

I don't agree the patch is correct.

>
> Setting prev_priority artificially high causes reclaimers to set
> distress artificially low, and fail to reclaim mapped pages, when
> they are, in fact, under severe memory pressure (their priority
> may be as low as 0). This causes the OOM killer to fire incorrectly.
>
> This patch changes that to set prev_priority to 0 instead, if we
> fail to reclaim.


We saw problems with this before releasing SLES10 too. See
zone_is_near_oom and other changesets from around that era. I would
like to know what workload was prevented from going OOM with these
changes, but zone_is_near_oom didn't help -- it must have been very
marginal (or there may indeed be a bug somewhere).

Nick
--

>
> Signed-off-by: Martin J. Bligh <mbligh@google.com>

>
>
>------------------------------------------------------------------------
>
>diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.18/mm/vmscan.c 2.6.18-prev_reset/mm/vmscan.c
>--- linux-2.6.18/mm/vmscan.c	2006-09-20 12:24:42.000000000 -0700
>+++ 2.6.18-prev_reset/mm/vmscan.c	2006-10-16 17:23:48.000000000 -0700
>@@ -962,7 +962,6 @@ static unsigned long shrink_zones(int pr
> unsigned long try_to_free_pages(struct zone **zones, gfp_t gfp_mask)
> {
> 	int priority;
>-	int ret = 0;
> 	unsigned long total_scanned = 0;
> 	unsigned long nr_reclaimed = 0;
> 	struct reclaim_state *reclaim_state = current->reclaim_state;
>@@ -1000,8 +999,15 @@ unsigned long try_to_free_pages(struct z
> 		}
> 		total_scanned += sc.nr_scanned;
> 		if (nr_reclaimed >= sc.swap_cluster_max) {
>-			ret = 1;
>-			goto out;
>+			for (i = 0; zones[i] != 0; i++) {
>+				struct zone *zone = zones[i];
>+
>+				if (!cpuset_zone_allowed(zone, __GFP_HARDWALL))
>+					continue;
>+
>+				zone->prev_priority = zone->temp_priority;
>+			}
>+			return 1;
> 		}
> 
> 		/*
>@@ -1021,16 +1027,15 @@ unsigned long try_to_free_pages(struct z
> 		if (sc.nr_scanned && priority < DEF_PRIORITY - 2)
> 			blk_congestion_wait(WRITE, HZ/10);
> 	}
>-out:
> 	for (i = 0; zones[i] != 0; i++) {
> 		struct zone *zone = zones[i];
> 
> 		if (!cpuset_zone_allowed(zone, __GFP_HARDWALL))
> 			continue;
> 
>-		zone->prev_priority = zone->temp_priority;
>+		zone->prev_priority = 0;
> 	}
>-	return ret;
>+	return 0;
> }
> 
> /*
>@@ -1186,7 +1191,10 @@ out:
> 	for (i = 0; i < pgdat->nr_zones; i++) {
> 		struct zone *zone = pgdat->node_zones + i;
> 
>-		zone->prev_priority = zone->temp_priority;
>+		if (priority < 0)		/* we failed to reclaim */
>+			zone->prev_priority = 0;
>+		else
>+			zone->prev_priority = zone->temp_priority;
> 	}
> 	if (!all_zones_ok) {
> 		cond_resched();
>

Send instant messages to your online friends http://au.messenger.yahoo.com 
