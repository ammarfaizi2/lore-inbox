Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTFHSQH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 14:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263750AbTFHSQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 14:16:07 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:9139 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S263738AbTFHSQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 14:16:01 -0400
Date: Sun, 8 Jun 2003 20:29:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: hugang <hugang@soulinfo.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: software suspend in 2.5.70-mm3.
Message-ID: <20030608182920.GD9182@elf.ucw.cz>
References: <20030603211156.726366e7.hugang@soulinfo.com> <1054646566.9234.20.camel@dhcp22.swansea.linux.org.uk> <20030603223511.155ea2cc.hugang@soulinfo.com> <20030603185551.GA3274@zaurus.ucw.cz> <20030608102626.638dd3ed.hugang@soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030608102626.638dd3ed.hugang@soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  Locating Ben's patch and forward-porting 
> >  it would be way better...
> 
> I was tried  Ben's patch, It's cool, Very stable in my laptop.
> 
> Here is two patch.
>   * suspend.c can swap more pages into swap space.
>   * vmscan.c  can make swap faster.
> 
> --- linux-2.5.70/kernel/suspend.c.old	Sun Jun  8 11:09:41 2003
> +++ linux-2.5.70/kernel/suspend.c	Sun Jun  8 10:54:55 2003
> @@ -621,9 +621,17 @@
>   */
>  static void free_some_memory(void)
>  {
> +	unsigned int count = 10;
> +
>  	printk("Freeing memory: ");
> -	while (shrink_all_memory(10000))
> +	while (count) {
> +		unsigned int ret = shrink_all_memory(4 * 1024 * 1024 / PAGE_SIZE);
> +		if (ret == 0) {
> +			count--;
> +			continue;
> +		}
>  		printk(".");
> +	}
>  	printk("|\n");
>  }

If this does something then... well... shrink_all_memory needs to be
fixed.

> --- linux-2.5.70/mm/vmscan.c.old	Sun Jun  8 11:08:27 2003
> +++ linux-2.5.70/mm/vmscan.c	Sun Jun  8 11:02:27 2003
> @@ -882,7 +882,8 @@
>   * dead and from now on, only perform a short scan.  Basically we're polling
>   * the zone for when the problem goes away.
>   */
> -static int balance_pgdat(pg_data_t *pgdat, int nr_pages, struct page_state *ps)
> +static int balance_pgdat(pg_data_t *pgdat, int nr_pages,
> +		struct page_state *ps, unsigned int time)
>  {
>  	int to_free = nr_pages;
>  	int priority;
> @@ -930,7 +931,7 @@
>  		}
>  		if (all_zones_ok)
>  			break;
> -		blk_congestion_wait(WRITE, HZ/10);
> +		blk_congestion_wait(WRITE, HZ/time);
>  	}
>  	return nr_pages - to_free;
>  }
> @@ -984,7 +985,7 @@
>  		schedule();
>  		finish_wait(&pgdat->kswapd_wait, &wait);
>  		get_page_state(&ps);
> -		balance_pgdat(pgdat, 0, &ps);
> +		balance_pgdat(pgdat, 0, &ps, 10);
>  	}
>  }
>  
> @@ -1020,7 +1021,7 @@
>  		struct page_state ps;
>  
>  		get_page_state(&ps);
> -		freed = balance_pgdat(pgdat, nr_to_free, &ps);
> +		freed = balance_pgdat(pgdat, nr_to_free, &ps, 200);
>  		ret += freed;
>  		nr_to_free -= freed;
>  		if (nr_to_free <= 0)

Comment in balance_pgdat saying what the time means would be
nice... And calling it time is pretty misleading: its frequency.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
