Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVCKUfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVCKUfm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 15:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVCKUbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 15:31:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26018 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261310AbVCKU15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 15:27:57 -0500
Date: Fri, 11 Mar 2005 13:04:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: 2.4 fix for write throttling on x86 >1G
Message-ID: <20050311160413.GK4816@logos.cnet>
References: <20050311061035.GZ26348@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311061035.GZ26348@opteron.random>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea!

On Fri, Mar 11, 2005 at 07:10:35AM +0100, Andrea Arcangeli wrote:
> Hello Marcelo,
> 
> I've got a fix for you on 2.4. I got reports of stalls with heavy writes
> on 2.4. 

Out of curiosity, that was SuSE not mainline ? 

> There was a mistake in nr_free_buffer_pages. That function is
> definitely meant _not_ to take highmem into account (dirty cache cannot
> spread over highmem in 2.4 [even when on top of fs]). For unknown
> reasons it was actually taking highmem into account. The code was
> obviously meant to not take inot account see the GFP_USER and zonelist,
> except it wasn't using the zonelist.

True, initialization of "zone" variable in nr_free_buffer_pages() is 
un-nice. 

> That is a severe problem because
> there will be no write throttling at all, and no bdflush wakeup either.
> 
> This should fix it, though my compiler fails to compile 2.4, so it's not
> immediate to verify it. If any problem showup I'll post a followup.
> 
> This is a noop for all systems <800M (1G shouldn't be noticeable
> either). This is why most people can't notice.

Do we really want to limit dirty cache to low mem on HIGHIO capable 
machines? I'm afraid doing so might hurt performance on such systems.

I think it might be wise to have nr_free_buffer_pages() take highmem
into account if CONFIG_HIGHIO is set ?

> --- 2.4.23aa3/mm/page_alloc.c.~1~	2004-07-04 02:09:42.000000000 +0200
> +++ 2.4.23aa3/mm/page_alloc.c	2005-03-11 07:00:23.000000000 +0100
> @@ -656,7 +656,7 @@ unsigned int nr_free_buffer_pages (void)
>  		class_idx = zone_idx(zone);
>  
>  		sum += zone->nr_cache_pages;
> -		for (zone = pgdat->node_zones; zone < pgdat->node_zones + MAX_NR_ZONES; zone++) {
> +		for (; zone; zone = *zonep++) {
>  			int free = zone->free_pages - zone->watermarks[class_idx].high;
>  			if (free <= 0)
>  				continue;
