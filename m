Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbVLCVke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbVLCVke (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 16:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVLCVke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 16:40:34 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50304 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751297AbVLCVkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 16:40:33 -0500
Date: Sat, 3 Dec 2005 22:40:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Andy Isaacson <adi@hexapodia.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][mm][Fix] swsusp: fix counting of highmem pages
Message-ID: <20051203214020.GA5198@elf.ucw.cz>
References: <200512032140.15192.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512032140.15192.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following patch fixes a problem with swsusp that causes suspend to
> fail on systems with the highmem zone, if many highmem pages are in use.
> 
> It makes swsusp count the non-free highmem pages in a correct way
> and, consequently, release a sufficient amount of memory before suspend.
> 
> Please apply (Pavel, please ack if you think the patch is ok).

Please don't, it's way too complex in my eyes. Sorry, result of
misscomunication between me and Rafael.

> +static inline unsigned int get_kmalloc_size(void)
> +{
> +#define CACHE(x) \
> +	if (sizeof(struct highmem_page) <= x) \
> +		return x;
> +#include <linux/kmalloc_sizes.h>
> +#undef CACHE
> +	return sizeof(struct highmem_page);
> +}
> +

Can we get rid of this uglyness...

> @@ -437,8 +446,14 @@
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

And just use 2% approximation here, too?

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

This part is okay. Just make enough_free_mem use similar code. (If
possible, share the code, it is really computing the same thing).

								Pavel
-- 
Thanks, Sharp!
