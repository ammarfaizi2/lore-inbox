Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVCPMFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVCPMFO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 07:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbVCPMFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 07:05:14 -0500
Received: from fire.osdl.org ([65.172.181.4]:54455 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261183AbVCPMFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 07:05:02 -0500
Date: Wed, 16 Mar 2005 04:04:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: noahm@csail.mit.edu, linux-kernel@vger.kernel.org
Subject: Re: OOM problems with 2.6.11-rc4
Message-Id: <20050316040435.39533675.akpm@osdl.org>
In-Reply-To: <20050316003134.GY7699@opteron.random>
References: <20050315204413.GF20253@csail.mit.edu>
	<20050316003134.GY7699@opteron.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> the VM is setting all_unreclaimable on the
> normal zone without any care about the progress we're making at freeing
> the slab.

Urgh, I didn't notice that all_unreclaimable is set.

> Beware this absolutely untested and it may not be enough.  Perhaps there
> are more bugs in the same area (the shrink_slab itself seems overkill
> complicated for no good reason and different methods returns random
> stuff, dcache returns a percentage of the free entries, dquot instead
> returns the allocated inuse entries too which makes the whole API
> looking unreliable).

No, the two functions are equivalent for the default value of
vfs_cache_pressure (100) - it's not a percentage.  It's just that we forgot
about the quota cache when adding the tunable.  And mbcache, come to that.

> Signed-off-by: Andrea Arcangeli <andrea@suse.de>
> 
> --- x/mm/vmscan.c.~1~	2005-03-14 05:02:17.000000000 +0100
> +++ x/mm/vmscan.c	2005-03-16 01:28:16.000000000 +0100
> @@ -1074,8 +1074,9 @@ scan:
>  			total_scanned += sc.nr_scanned;
>  			if (zone->all_unreclaimable)
>  				continue;
> -			if (zone->pages_scanned >= (zone->nr_active +
> -							zone->nr_inactive) * 4)

A change we made a while back effectively doubles the rate at which
pages_scanned gets incremented here (we now account for the active list as
well as the inactive list).  So this should be *8 to make it more
equivalent to the old code.  Not that this is likely to make much
difference.


> +			if (!reclaim_state->reclaimed_slab &&
> +			    zone->pages_scanned >= (zone->nr_active +
> +						    zone->nr_inactive) * 4)
>  				zone->all_unreclaimable = 1;

That might not change anything because we clear ->all_unreclaimable in
free_page_bulk().  Although that is behind the per-cpu-pages, so there will
be some lag.  And this change will cause us to not bale out of reclaim..

Still, I think it would make more sense to return a success indication from
shrink_slab() if we actually freed any slab objects.  That will prevent us
from incorrectly going all_unreclaimable if all we happen to be doing is
increasing slab internal fragmentation.

We could do that kludgily by re-polling the shrinker but it would be better
to return a second value from all the shrinkers.

> --- x/fs/dquot.c.~1~	2005-03-08 01:02:13.000000000 +0100
> +++ x/fs/dquot.c	2005-03-16 01:18:19.000000000 +0100
> @@ -510,7 +510,7 @@ static int shrink_dqcache_memory(int nr,
>  	spin_lock(&dq_list_lock);
>  	if (nr)
>  		prune_dqcache(nr);
> -	ret = dqstats.allocated_dquots;
> +	ret = (dqstats.free_dquots / 100) * sysctl_vfs_cache_pressure;
>  	spin_unlock(&dq_list_lock);
>  	return ret;
>  }

yup.
