Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWBCNwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWBCNwe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 08:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWBCNwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 08:52:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15390 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750787AbWBCNwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 08:52:33 -0500
Date: Fri, 3 Feb 2006 14:54:34 +0100
From: Jens Axboe <axboe@suse.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, AChittenden@bluearc.com, davej@redhat.com,
       linux-kernel@vger.kernel.org, lwoodman@redhat.com
Subject: Re: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060203135434.GC4215@suse.de>
References: <89E85E0168AD994693B574C80EDB9C2703556694@uk-email.terastack.bluearc.com> <20060127142146.GN4311@suse.de> <1138372797.22112.44.camel@imp.csi.cam.ac.uk> <1138958409.3828.9.camel@imp.csi.cam.ac.uk> <20060203012607.0a9d6730.akpm@osdl.org> <1138964504.3828.18.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138964504.3828.18.camel@imp.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03 2006, Anton Altaparmakov wrote:
> Yes, I think it is suse.  I just diffed /mm of both the above kernels
> (.193 and .201) and I think there is a little typo which probably causes
> the problem.  It is mm/vmscan.c::shrink_zone():
> 
> @@ -845,19 +845,38 @@ shrink_zone(struct zone *zone, int max_s
>         }
> 
>         atomic_add(scan_active + 1, &zone->nr_scan_active);
> -       count = atomic_read(&zone->nr_scan_active);
> -       if (count >= SWAP_CLUSTER_MAX) {
> +       nr_active = atomic_read(&zone->nr_scan_active);
> +       if (nr_active >= SWAP_CLUSTER_MAX)
>                 atomic_set(&zone->nr_scan_active, 0);
> -               refill_inactive_zone(zone, count, ps, can_free_mapped);
> -       }
> +       else
> +               nr_active = 0;
> 
>         atomic_add(max_scan, &zone->nr_scan_inactive);
> -       count = atomic_read(&zone->nr_scan_inactive);
> -       if (count >= SWAP_CLUSTER_MAX) {
> +       nr_inactive = atomic_read(&zone->nr_scan_inactive);
> +       if (nr_active >= SWAP_CLUSTER_MAX)
>             ^^^^^^^^^ Should be nr_inactive I think.
> 
> Comparing to code in current linux-2.6.git/mm/vmscan.c confirms that it
> should be nr_inactive.
> 
>                 atomic_set(&zone->nr_scan_inactive, 0);
> -               return shrink_cache(zone, gfp_mask, count, total_scanned, can_free_mapped);
> +       else
> +               nr_inactive = 0;
> 
> Jens, given you have an @suse email address, do you want to kick whoever
> deals with this in novel/suse so it gets fixed in the next sles9 kernel
> update?

Auch, that looks nasty. I'll forward this, thanks!

-- 
Jens Axboe

