Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWCHNhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWCHNhO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 08:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWCHNhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 08:37:13 -0500
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:42958 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751399AbWCHNhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 08:37:12 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: [ck] Re: [PATCH] mm: yield during swap prefetching
Date: Thu, 9 Mar 2006 00:36:48 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <200603081013.44678.kernel@kolivas.org> <20060307152636.1324a5b5.akpm@osdl.org> <cone.1141774323.5234.18683.501@kolivas.org>
In-Reply-To: <cone.1141774323.5234.18683.501@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603090036.49915.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cc'ing Ingo...

On Wednesday 08 March 2006 10:32, Con Kolivas wrote:
> Andrew Morton writes:
> > Con Kolivas <kernel@kolivas.org> wrote:
> >> Swap prefetching doesn't use very much cpu but spends a lot of time
> >> waiting on disk in uninterruptible sleep. This means it won't get
> >> preempted often even at a low nice level since it is seen as sleeping
> >> most of the time. We want to minimise its cpu impact so yield where
> >> possible.
> >>
> >> Signed-off-by: Con Kolivas <kernel@kolivas.org>
> >> ---
> >>  mm/swap_prefetch.c |    1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> Index: linux-2.6.15-ck5/mm/swap_prefetch.c
> >> ===================================================================
> >> --- linux-2.6.15-ck5.orig/mm/swap_prefetch.c	2006-03-02
> >> 14:00:46.000000000 +1100 +++
> >> linux-2.6.15-ck5/mm/swap_prefetch.c	2006-03-08 08:49:32.000000000 +1100
> >> @@ -421,6 +421,7 @@ static enum trickle_return trickle_swap(
> >>
> >>  		if (trickle_swap_cache_async(swp_entry, node) == TRICKLE_DELAY)
> >>  			break;
> >> +		yield();
> >>  	}
> >>
> >>  	if (sp_stat.prefetched_pages) {
> >
> > yield() really sucks if there are a lot of runnable tasks.  And the
> > amount of CPU which that thread uses isn't likely to matter anyway.
> >
> > I think it'd be better to just not do this.  Perhaps alter the thread's
> > static priority instead?  Does the scheduler have a knob which can be
> > used to disable a tasks's dynamic priority boost heuristic?
>
> We do have SCHED_BATCH but even that doesn't really have the desired
> effect. I know how much yield sucks and I actually want it to suck as much
> as yield does.

Thinking some more on this I wonder if SCHED_BATCH isn't a strong enough 
scheduling hint if it's not suitable for such an application. Ingo do you 
think we could make SCHED_BATCH tasks always wake up on the expired array?

Cheers,
Con
