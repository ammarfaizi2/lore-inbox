Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWCQRyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWCQRyh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWCQRyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:54:37 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:11931 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030236AbWCQRyg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:54:36 -0500
Subject: Re: [PATCH: 010/017]Memory hotplug for new nodes v.4.(allocate
	wait table)
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       "Luck, Tony" <tony.luck@intel.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20060317163451.C64B.Y-GOTO@jp.fujitsu.com>
References: <20060317163451.C64B.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 09:53:39 -0800
Message-Id: <1142618019.10906.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 17:22 +0900, Yasunori Goto wrote:
> +#ifdef CONFIG_MEMORY_HOTPLUG
>  static inline unsigned long wait_table_size(unsigned long pages)
>  {
>  	unsigned long size = 1;
> @@ -1806,6 +1807,17 @@ static inline unsigned long wait_table_s
>  
>  	return max(size, 4UL);
>  }
> +#else
> +/*
> + * Because zone size might be changed by hot-add,
> + * We can't determin suitable size for wait_table as traditional.
> + * So, we use maximum size.
> + */
> +static inline unsigned long wait_table_size(unsigned long pages)
> +{
> +	return 4096UL;
> +}
> +#endif

Ick.  Is there really _no_ way to resize this at runtime?  I know it
isn't an immediately easy thing to do, but we've really tried not to do
these kinds of things with memory hotplug in the past.  The whole thing
would have been really easy if we could just preallocate everything
really big in the first place.

I don't think this has to be a super-fast, efficient, implementation.
Once the code has gone into the actual waitqueue code, it is already in
a slow path.  

We could do something like this:

void fastcall wait_on_page_bit(struct page *page, int bit_nr)
{
        DEFINE_WAIT_BIT(wait, &page->flags, bit_nr);

        if (!test_bit(bit_nr, &page->flags))
		return;
			
        while (__wait_on_bit(page_waitqueue(page), &wait, sync_page,
			TASK_UNINTERRUPTIBLE));
}

And have a special case inside of sync_page() to return -EAGAIN when a
waitqueue resize is going on.  There is a race there if zone->wait_table
and zone->wait_table_bits are not matching values.

So, to do the update, you'd need to do something like this:

	set_waitqueue_resize_start(zone);
	// now all of the waiters will spin
	zone->wait_table = kmalloc();
	smp_wmb(); // make sure all the cpus see the kmalloc
	zone->wait_table_bits = new_bits;
	set_waitqueue_resize_done(zone);

Putting a seqlock next to wait_table_bits might also do the trick.  I
need to think about it some more.  BTW, I think this only works for the
waiter side, not the wakers.  But, I think it can work in both cases.

>  /*
>   * This is an integer logarithm so that shifts can be used later
> @@ -2074,7 +2086,7 @@ void __init setup_per_cpu_pageset(void)
>  #endif
>  
>  static __meminit
> -void zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
> +int zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
>  {
>  	int i;
>  	struct pglist_data *pgdat = zone->zone_pgdat;
> @@ -2085,12 +2097,37 @@ void zone_wait_table_init(struct zone *z
>  	 */
>  	zone->wait_table_size = wait_table_size(zone_size_pages);
>  	zone->wait_table_bits =	wait_table_bits(zone->wait_table_size);
> -	zone->wait_table = (wait_queue_head_t *)
> -		alloc_bootmem_node(pgdat, zone->wait_table_size
> -					* sizeof(wait_queue_head_t));
> +	if (system_state == SYSTEM_BOOTING) {
> +		zone->wait_table = (wait_queue_head_t *)
> +			alloc_bootmem_node(pgdat, zone->wait_table_size
> +						* sizeof(wait_queue_head_t));
> +	} else {
> +		int table_size;
> +		/*
> +		 * XXX: This is the case that new node is hotadded.
> +		 * 	At this time, kmalloc() will not get this new node's
> +		 *	memory. Because this wait_table must be initialized,
> +		 *	to use this new node itself. To use this new node's
> +		 *	memory, further consideration will be necessary.
> +		 */
> +		do {
> +			table_size = zone->wait_table_size
> +					* sizeof(wait_queue_head_t);
> +			zone->wait_table = kmalloc(table_size, GFP_KERNEL);
> +			if (!zone->wait_table) {
> +				/* try half size */
> +				zone->wait_table_size >>= 1;
> +				zone->wait_table_bits =
> +					wait_table_bits(zone->wait_table_size);
> +			}
> +		} while (zone->wait_table_size && !zone->wait_table);
> +	}
> +	if (!zone->wait_table)
> +		return -ENOMEM;
>  
>  	for(i = 0; i < zone->wait_table_size; ++i)
>  		init_waitqueue_head(zone->wait_table + i);
> +	return 0;
>  }

Why do you need those retries to shrink the size?  Are you actually
getting common failures?  Is it best to shrink the size, or try
something like vmalloc?  This seems a bit hackish to me.  

-- Dave

