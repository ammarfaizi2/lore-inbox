Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271149AbRHVLBn>; Wed, 22 Aug 2001 07:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271909AbRHVLBe>; Wed, 22 Aug 2001 07:01:34 -0400
Received: from ns.ithnet.com ([217.64.64.10]:39691 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S271149AbRHVLBO>;
	Wed, 22 Aug 2001 07:01:14 -0400
Date: Wed, 22 Aug 2001 13:01:06 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.9 ?
Message-Id: <20010822130106.0c4d4bf1.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33.0108220729380.280-100000@mikeg.weiden.de>
In-Reply-To: <20010822010649Z16145-32383+774@humbolt.nl.linux.org>
	<Pine.LNX.4.33.0108220729380.280-100000@mikeg.weiden.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001 07:33:38 +0200 (CEST)
Mike Galbraith <mikeg@wen-online.de> wrote:

>> HAHAHA.. I was right, hurried whack with my little hammer _did_ bust
> it all to pieces :)
> 
> This is also (very!) hurried and _lightly_ tested, but still cures my
> problem..  what do you think?
> 
> 	-Mike
> 
> 
> --- linux-2.4.9/mm/vmscan.c.org	Sun Aug 19 08:55:24 2001
> +++ linux-2.4.9/mm/vmscan.c	Wed Aug 22 05:03:50 2001
> @@ -506,11 +506,17 @@
>  		}
[...]
> +			if (++page->age > PAGE_AGE_START) {

I am not very experienced with the aging algorithm, but can this statement be false at all? I mean if I get that right page->age starts with PAGE_AGE_START, doesn't it?

> +				del_page_from_inactive_dirty_list(page);
> +				add_page_to_active_list(page);
> +				page->age = PAGE_AGE_START;
> +				continue;
> +			}
> +			list_del(page_lru);
> +			list_add(page_lru, &inactive_dirty_list);
>  			continue;
>  		}
> 
> @@ -927,7 +933,7 @@
>  			recalculate_vm_stats();
>  		}
> 
> -		if (!do_try_to_free_pages(GFP_KSWAPD, 1)) {
> +		if (!do_try_to_free_pages(GFP_KSWAPD, 0)) {
>  			if (out_of_memory())
>  				oom_kill();
>  			continue;
> --- linux-2.4.9/mm/filemap.c.org	Mon Aug 20 17:25:20 2001
> +++ linux-2.4.9/mm/filemap.c	Wed Aug 22 05:07:35 2001
> @@ -980,12 +980,9 @@
>  static inline void check_used_once (struct page *page)
>  {
>  	if (!PageActive(page)) {
> -		if (page->age)
> +		if (++page->age > PAGE_AGE_START)

same here. Am I missing something?

>  			activate_page(page);
> -		else {
> -			page->age = PAGE_AGE_START;
> -			ClearPageReferenced(page);
> -		}
> +		ClearPageReferenced(page);
>  	}
>  }
> 
> 
> 
