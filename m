Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316969AbSE1WM5>; Tue, 28 May 2002 18:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316977AbSE1WM4>; Tue, 28 May 2002 18:12:56 -0400
Received: from [195.39.17.254] ([195.39.17.254]:12957 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316969AbSE1WMy>;
	Tue, 28 May 2002 18:12:54 -0400
Date: Wed, 29 May 2002 00:08:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>,
        wli@holomorphy.com
Subject: DO NOT APPLY Re: swsusp: cleanup -- use list_for_each in head_of_free_region 
Message-ID: <20020528220834.GA5637@elf.ucw.cz>
In-Reply-To: <20020528193357.GA801@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This cleans up is_head_of_free_region, thanks to William Lee Irwin III
> <wli@holomorphy.com>. Please apply,

It forgets to spin_unlock when it sees free page. Sorry about
that. Just forget this patch, I'll get you better variant in
2.5.19. Its only cosmetics, anyway.
								Pavel


> --- linux-swsusp.test//mm/page_alloc.c	Sun May 26 19:32:05 2002
> +++ linux-swsusp/mm/page_alloc.c	Tue May 28 21:19:26 2002
> @@ -249,42 +249,31 @@
>  }
>  
>  #ifdef CONFIG_SOFTWARE_SUSPEND
> -int is_head_of_free_region(struct page *p)
> +int is_head_of_free_region(struct page *page)
>  {
> -	pg_data_t *pgdat = pgdat_list;
> -	unsigned type;
> -	unsigned long flags;
> +        zone_t *zone, *node_zones = pgdat_list->node_zones;
> +        unsigned long flags;
>  
> -	for (type=0;type < MAX_NR_ZONES; type++) {
> -		zone_t *zone = pgdat->node_zones + type;
> -		int order = MAX_ORDER - 1;
> -		free_area_t *area;
> -		struct list_head *head, *curr;
> -		spin_lock_irqsave(&zone->lock, flags);	/* Should not matter as we need quiescent system for suspend anyway, but... */
> +        for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
> +                int order;
> +                list_t *curr;
>  
> -		do {
> -			area = zone->free_area + order;
> -			head = &area->free_list;
> -			curr = head;
> -
> -			for(;;) {
> -				if(!curr) {
> -//					printk("FIXME: this should not happen but it does!!!");
> +                /*
> +                 * Should not matter as we need quiescent system for
> +                 * suspend anyway, but...
> +                 */
> +                spin_lock_irqsave(&zone->lock, flags);
> +                for (order = MAX_ORDER - 1; order >= 0; --order)
> +                        list_for_each(curr, &zone->free_area[order].free_list) {
> +				if (!curr)
>  					break;
> -				}
> -				if(p != memlist_entry(curr, struct page, list)) {
> -					curr = memlist_next(curr);
> -					if (curr == head)
> -						break;
> -					continue;
> -				}
> -				return 1 << order;
> +                                if (page == list_entry(curr, struct page, list))
> +                                        return 1 << order;
>  			}
> -		} while(order--);
> -		spin_unlock_irqrestore(&zone->lock, flags);
> +                spin_unlock_irqrestore(&zone->lock, flags);
>  
> -	}
> -	return 0;
> +        }
> +        return 0;
>  }
>  #endif /* CONFIG_SOFTWARE_SUSPEND */
>  
> 
> 
> 

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
