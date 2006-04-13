Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWDMMnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWDMMnb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 08:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWDMMnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 08:43:31 -0400
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:58826 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964880AbWDMMna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 08:43:30 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: shrink_all_memory tweaks (was: Re: Userland swsusp failure (mm-related))
Date: Thu, 13 Apr 2006 22:42:57 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Fabio Comolli <fabio.comolli@gmail.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <b637ec0b0604080537s55e63544r8bb63c887e81ecaf@mail.gmail.com> <200604100923.24768.kernel@kolivas.org> <200604111906.32535.rjw@sisk.pl>
In-Reply-To: <200604111906.32535.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604132242.57664.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 April 2006 03:06, Rafael J. Wysocki wrote:
> The patch is appended.
>
> In shrink_all_memory() I try to free exactly as many pages as the caller
> asks for, preferably in one shot, starting from easier targets.  If slabs
> are huge, they are most likely to have enough pages to reclaim.  The
> inactive lists are next (the zones with more inactive pages go first) etc. 
> However, since each pass potentially requires more work, the number of
> pages to scan is decreased as the pages are reclaimed which seems to make
> the shrinking of memory go more smoothly.
>
> I've been testing it on an x86_64 box for some time and it seems to behave
> quite reasonably, eg. it usually makes the actual image size very close to
> the value of image_size and if you set image_size to 0, it shrinks
> everything almost totally.

Great. Looks pretty good. See comments.

> ---

>  #ifdef CONFIG_PM
>  /*
> - * Try to free `nr_pages' of memory, system-wide.  Returns the number of
> freed - * pages.
> + * Helper function for shrink_all_memory().  Tries to reclaim 'nr_pages'
> pages + * from LRU lists system-wide, for given pass and priority, and
> returns the + * number of reclaimed pages
> + *
> + * For pass > 3 we also try to shrink the LRU lists that contain a few
> pages + */
> +unsigned long shrink_all_zones(unsigned long nr_pages, int pass, int prio,
> +				struct scan_control *sc)

I like how this moves all suspend vm functions out of the generic functions 
even more than I managed to.

> +	int swappiness = vm_swappiness, pass;
> +	struct reclaim_state reclaim_state;
> +	struct zone *zone;
> +	struct scan_control sc = {
> +		.gfp_mask = GFP_KERNEL,
> +		.may_swap = 1,
> +		.swap_cluster_max = nr_pages,
> +		.may_writepage = 1,
>  	};

This is not quite right at maintaining the original semantics I was proposing. 
Since you are iterating over all priorities, setting may_swap means you will 
reclaim mapped ram on the earlier passes once priority gets low enough. 
Setting vm_swappiness temporarily to 100 is unncecessary. You should set 
may_swap to 0 and set it to 1 on passes 3+.

Otherwise, looks good, thanks!

-- 
-ck
