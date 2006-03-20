Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWCTIm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWCTIm5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 03:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWCTIm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 03:42:56 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:42187 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932225AbWCTImz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 03:42:55 -0500
Date: Mon, 20 Mar 2006 17:41:29 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH: 010/017]Memory hotplug for new nodes v.4.(allocate wait table)
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       "Luck, Tony" <tony.luck@intel.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-mm <linux-mm@kvack.org>
In-Reply-To: <1142618019.10906.91.camel@localhost.localdomain>
References: <20060317163451.C64B.Y-GOTO@jp.fujitsu.com> <1142618019.10906.91.camel@localhost.localdomain>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060320153711.7E98.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ick.  Is there really _no_ way to resize this at runtime?  I know it
> isn't an immediately easy thing to do, but we've really tried not to do
> these kinds of things with memory hotplug in the past.  The whole thing
> would have been really easy if we could just preallocate everything
> really big in the first place.
> 
> I don't think this has to be a super-fast, efficient, implementation.
> Once the code has gone into the actual waitqueue code, it is already in
> a slow path.  
> 
> We could do something like this:
> 
> void fastcall wait_on_page_bit(struct page *page, int bit_nr)
> {
>         DEFINE_WAIT_BIT(wait, &page->flags, bit_nr);
> 
>         if (!test_bit(bit_nr, &page->flags))
> 		return;
> 			
>         while (__wait_on_bit(page_waitqueue(page), &wait, sync_page,
> 			TASK_UNINTERRUPTIBLE));
> }
> 
> And have a special case inside of sync_page() to return -EAGAIN when a
> waitqueue resize is going on.  There is a race there if zone->wait_table
> and zone->wait_table_bits are not matching values.
> 
> So, to do the update, you'd need to do something like this:
> 
> 	set_waitqueue_resize_start(zone);
> 	// now all of the waiters will spin
> 	zone->wait_table = kmalloc();
> 	smp_wmb(); // make sure all the cpus see the kmalloc
> 	zone->wait_table_bits = new_bits;
> 	set_waitqueue_resize_done(zone);
> 
> Putting a seqlock next to wait_table_bits might also do the trick.  I
> need to think about it some more.  BTW, I think this only works for the
> waiter side, not the wakers.  But, I think it can work in both cases.

Hmmmmm.
I'm not sure this works well. 
Probably, resizing of hash table needs much work.

But, I don't think that my patch set is the completion of node
style hotplug.
(At least, pgdat is allocated another node, not new node.)
So, I would like to leave this issue as further works too.
Linux style is not to solve everything at once, 
it is step by step approach.

BTW, this issue is not only for node, but also smp style hotplug case.
When memory is hotplugged, one of zone size changes.
But, current memor hotplug do nothing when size becomes not enough.
It depends on boottime size....

When node is hot-added, there is no wait_table because size is 0.
So, new wait_table is necessary at this time.


> >  /*
> >   * This is an integer logarithm so that shifts can be used later
> > @@ -2074,7 +2086,7 @@ void __init setup_per_cpu_pageset(void)
> >  #endif
> >  
> >  static __meminit
> > -void zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
> > +int zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
> >  {
> >  	int i;
> >  	struct pglist_data *pgdat = zone->zone_pgdat;
> > @@ -2085,12 +2097,37 @@ void zone_wait_table_init(struct zone *z
> >  	 */
> >  	zone->wait_table_size = wait_table_size(zone_size_pages);
> >  	zone->wait_table_bits =	wait_table_bits(zone->wait_table_size);
> > -	zone->wait_table = (wait_queue_head_t *)
> > -		alloc_bootmem_node(pgdat, zone->wait_table_size
> > -					* sizeof(wait_queue_head_t));
> > +	if (system_state == SYSTEM_BOOTING) {
> > +		zone->wait_table = (wait_queue_head_t *)
> > +			alloc_bootmem_node(pgdat, zone->wait_table_size
> > +						* sizeof(wait_queue_head_t));
> > +	} else {
> > +		int table_size;
> > +		/*
> > +		 * XXX: This is the case that new node is hotadded.
> > +		 * 	At this time, kmalloc() will not get this new node's
> > +		 *	memory. Because this wait_table must be initialized,
> > +		 *	to use this new node itself. To use this new node's
> > +		 *	memory, further consideration will be necessary.
> > +		 */
> > +		do {
> > +			table_size = zone->wait_table_size
> > +					* sizeof(wait_queue_head_t);
> > +			zone->wait_table = kmalloc(table_size, GFP_KERNEL);
> > +			if (!zone->wait_table) {
> > +				/* try half size */
> > +				zone->wait_table_size >>= 1;
> > +				zone->wait_table_bits =
> > +					wait_table_bits(zone->wait_table_size);
> > +			}
> > +		} while (zone->wait_table_size && !zone->wait_table);
> > +	}
> > +	if (!zone->wait_table)
> > +		return -ENOMEM;
> >  
> >  	for(i = 0; i < zone->wait_table_size; ++i)
> >  		init_waitqueue_head(zone->wait_table + i);
> > +	return 0;
> >  }
> 
> Why do you need those retries to shrink the size?  Are you actually
> getting common failures?  Is it best to shrink the size, or try
> something like vmalloc?  This seems a bit hackish to me.  

Just I thought wait table might be over than "order 3" pages.
But, I don't remember why I used kmalloc(). :-(
Ok. I'll change this to vmalloc(). It will be simpler.

Thanks.

-- 
Yasunori Goto 


