Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWEAO5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWEAO5M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 10:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWEAO5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 10:57:12 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:19677 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932128AbWEAO5L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 10:57:11 -0400
Subject: Re: [Lhms-devel] [RFC][PATCH] hot add memory which is not aligned
	to section
From: Dave Hansen <haveblue@us.ibm.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LHMS <lhms-devel@lists.sourceforge.net>
In-Reply-To: <20060427223705.e99bb194.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060427223705.e99bb194.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Date: Mon, 01 May 2006 07:56:32 -0700
Message-Id: <1146495392.32079.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 22:37 +0900, KAMEZAWA Hiroyuki wrote:
> @@ -145,10 +148,26 @@
>  	if (!populated_zone(zone))
>  		need_zonelists_rebuild = 1;
>  
> -	for (i = 0; i < nr_pages; i++) {
> -		struct page *page = pfn_to_page(pfn + i);
> -		online_page(page);
> -		onlined_pages++;
> +	res.start = (u64)pfn << PAGE_SHIFT;
> +	res.end = res.start + ((u64)nr_pages << PAGE_SHIFT) - 1;
> +	section_end = res.end;
> +
> +	while (find_next_system_ram(&res)) {
> +		start_pfn = (unsigned long)(res.start >> PAGE_SHIFT);
> +		nr_pages = (unsigned long)
> +                           ((res.end + 1 - res.start) >> PAGE_SHIFT);
> +
> +		if (PageReserved(pfn_to_page(start_pfn))) {
> +			/* this region's page is not populated now */
> +			for (i = 0; i < nr_pages; i++) {
> +				struct page *page = pfn_to_page(start_pfn + i);
> +				online_page(page);
> +				onlined_pages++;
> +			}
> +		}
> +
> +		res.start = res.end + 1;
> +		res.end = section_end;
>  	}
>  	zone->present_pages += onlined_pages;
>  	zone->zone_pgdat->node_present_pages += onlined_pages;

First of all, bravo for doing this in an architecture-independent way.
Very nice.

I'd really prefer to keep the 'struct resource' handling out of the
memory hotplug code.  This took a nice, little, comprehensible for loop,
and made it quite a bit more complex.  There is also a lot of casting
going on, which I don't really grasp in a first glance.

The 'struct resource' which gets passed into find_next_system_ram()
isn't a real resource.  Why not just pass a normal start and end address
in there, and let _it_ do the work?

It looks like that whole loop is optimized for being able to online a
really sparse area without diving into the iomem tables very often.
This seems like a premature complicating optimization to me.  

Why not do something like this:

	for (i = 0; i < nr_pages; i++) {
		struct page *page = pfn_to_page(pfn + i);

		if (page_is_in_io_resource(page))
			continue;

		online_page(page);
		onlined_pages++;
	}

That way, you keep the memory_hotplug.c file nice and neat.

Also, remind me again why you can't just make the SECTION_SIZE match
your 64MB I/O hole sizes.  I forget a lot/ :)

-- Dave

