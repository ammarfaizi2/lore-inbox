Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274774AbRIZB6C>; Tue, 25 Sep 2001 21:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274777AbRIZB5w>; Tue, 25 Sep 2001 21:57:52 -0400
Received: from [195.223.140.107] ([195.223.140.107]:61937 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274774AbRIZB5g>;
	Tue, 25 Sep 2001 21:57:36 -0400
Date: Wed, 26 Sep 2001 03:58:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
Subject: Re: 2.4.10 still slow compared to 2.4.5pre1
Message-ID: <20010926035810.V1782@athlon.random>
In-Reply-To: <C5C45572D968D411A1B500D0B74FF4A80418D54B@xfc01.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C5C45572D968D411A1B500D0B74FF4A80418D54B@xfc01.fc.hp.com>; from cary_dickens2@hp.com on Tue, Sep 25, 2001 at 08:44:35PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 08:44:35PM -0400, DICKENS,CARY (HP-Loveland,ex2) wrote:
> Andrea,
> 
> I hate to inform you that we tracked this down and nr_inactive_pages can be
> zero.  This causes divide by zero in shrink_caches.
> 
> This is from the 00_vm-tweaks-1 patch:
>  static int shrink_caches(int priority, zone_t * classzone, unsigned int
> gfp_mask, int nr_pages)
>  {
> -	int max_scan = nr_inactive_pages / priority;
> +	int max_scan;
> +	int chunk_size = nr_pages;
> +	unsigned long ratio;
>  
>  	nr_pages -= kmem_cache_reap(gfp_mask);
>  	if (nr_pages <= 0)
>  		return 0;
>  
> -	/* Do we want to age the active list? */
> -	if (nr_inactive_pages < nr_active_pages*2)
> -		refill_inactive(nr_pages);
> +	spin_lock(&pagemap_lru_lock);
> +	nr_pages = chunk_size;
> +	/* try to keep the active list 2/3 of the size of the cache */
> +	ratio = (unsigned long) nr_pages * nr_active_pages /
> (nr_inactive_pages * 2);

how can you ever trigger it during boot?

anyways that is a real bug, thanks for spotting it, you can just add 1
to nr_inactive_pages to fix it.

	ratio = (unsigned long) nr_pages * nr_active_pages / ((nr_inactive_pages+1) * 2);

it will be fixed in the next update of course.

Andrea
