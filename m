Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVLDALM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVLDALM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 19:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbVLDALM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 19:11:12 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:169 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932174AbVLDALM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 19:11:12 -0500
Date: Sun, 4 Dec 2005 01:10:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andy Isaacson <adi@hexapodia.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][mm][Fix] swsusp: fix counting of highmem pages
Message-ID: <20051204001055.GE5198@elf.ucw.cz>
References: <200512032140.15192.rjw@sisk.pl> <200512040011.30274.rjw@sisk.pl> <20051203235046.GC5198@elf.ucw.cz> <200512040102.24668.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512040102.24668.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Ah, okay, I see. As long as the include hack is gone, its okay with me.
> 
> All right.  Appended is the latest version.

Okay, seems I'll need to get latest mm version, because this changed a
lot. Sorry, that will be tommorow afternoon.

> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
>  kernel/power/snapshot.c |   25 ++++++++++++++++++-------
>  kernel/power/swsusp.c   |    3 ++-
>  2 files changed, 20 insertions(+), 8 deletions(-)
> 
> Index: linux-2.6.15-rc3-mm1/kernel/power/snapshot.c
> ===================================================================
> --- linux-2.6.15-rc3-mm1.orig/kernel/power/snapshot.c	2005-12-03 00:14:49.000000000 +0100
> +++ linux-2.6.15-rc3-mm1/kernel/power/snapshot.c	2005-12-04 00:35:14.000000000 +0100
> @@ -37,6 +37,12 @@
> @@ -52,13 +58,12 @@
>  				if (!pfn_valid(pfn))
>  					continue;
>  				page = pfn_to_page(pfn);
> -				if (PageReserved(page))
> -					continue;
> -				if (PageNosaveFree(page))
> -					continue;
> -				n++;
> +				if (!PageNosaveFree(page) && !PageReserved(page))
> +					n++;
>  			}

As far as I can see, this does not change anything. Can you keep it
out?

>  		}
> +	if (n > 0)
> +		n += (n * KMALLOC_SIZE + PAGE_SIZE - 1) / PAGE_SIZE + 1;
>  	return n;
>  }

Can't you just n += n/50 here? Playing with KMALLOC_SIZE knows way too
much about memory allocation details.

> @@ -437,8 +442,14 @@
>  
>  static int enough_free_mem(unsigned int nr_pages)
>  {
> -	pr_debug("swsusp: available memory: %u pages\n", nr_free_pages());
> -	return nr_free_pages() > (nr_pages + PAGES_FOR_IO +
> +	struct zone *zone;
> +	unsigned int n = 0;
> +
> +	for_each_zone (zone)
> +		if (!is_highmem(zone))
> +			n += zone->free_pages;
> +	pr_debug("swsusp: available memory: %u pages\n", n);
> +	return n > (nr_pages + PAGES_FOR_IO +
>  		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
>  }
>  

Ok, so this is bugfix for different problem.

> Index: linux-2.6.15-rc3-mm1/kernel/power/swsusp.c
> ===================================================================
> --- linux-2.6.15-rc3-mm1.orig/kernel/power/swsusp.c	2005-12-03 00:14:49.000000000 +0100
> +++ linux-2.6.15-rc3-mm1/kernel/power/swsusp.c	2005-12-03 21:25:07.000000000 +0100
> @@ -635,7 +635,8 @@
>  	printk("Shrinking memory...  ");
>  	do {
>  #ifdef FAST_FREE
> -		tmp = count_data_pages() + count_highmem_pages();
> +		tmp = 2 * count_highmem_pages();
> +		tmp += tmp / 50 + count_data_pages();
>  		tmp += (tmp + PBES_PER_PAGE - 1) / PBES_PER_PAGE +
>  			PAGES_FOR_IO;
>  		for_each_zone (zone)

And this is simple enough...
							Pavel
-- 
Thanks, Sharp!
