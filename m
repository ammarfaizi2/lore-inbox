Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316746AbSE0Tkm>; Mon, 27 May 2002 15:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316751AbSE0Tkm>; Mon, 27 May 2002 15:40:42 -0400
Received: from holomorphy.com ([66.224.33.161]:24746 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316746AbSE0Tkl>;
	Mon, 27 May 2002 15:40:41 -0400
Date: Mon, 27 May 2002 12:40:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
Message-ID: <20020527194018.GQ14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
	ACPI mailing list <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20020521222858.GA14737@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 12:28:59AM +0200, Pavel Machek wrote:
...


I foresee trouble here; you're doing list_entry(list, struct page, list)
on &area->free_list.

On Wed, May 22, 2002 at 12:28:59AM +0200, Pavel Machek wrote:
> +#ifdef CONFIG_SOFTWARE_SUSPEND
> +int is_head_of_free_region(struct page *p)
> +{
> +	pg_data_t *pgdat = pgdat_list;
> +	unsigned type;
> +	unsigned long flags;
> +
> +	for (type=0;type < MAX_NR_ZONES; type++) {
> +		zone_t *zone = pgdat->node_zones + type;
> +		int order = MAX_ORDER - 1;
> +		free_area_t *area;
> +		struct list_head *head, *curr;
> +		spin_lock_irqsave(&zone->lock, flags);	/* Should not matter as we need quiescent system for suspend anyway, but... */
> +
> +		do {
> +			area = zone->free_area + order;
> +			head = &area->free_list;
> +			curr = head;

                        ^^^^^^^^^^^^
                        set right here

On Wed, May 22, 2002 at 12:28:59AM +0200, Pavel Machek wrote:
> +
> +			for(;;) {
> +				if(!curr) {
> +//					printk("FIXME: this should not happen but it does!!!");
> +					break;
> +				}
> +				if(p != memlist_entry(curr, struct page, list)) {
> +					curr = memlist_next(curr);
> +					if (curr == head)
> +						break;
> +					continue;
                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                       deep trouble here and in the if ()

On Wed, May 22, 2002 at 12:28:59AM +0200, Pavel Machek wrote:
> +				}
> +				return 1 << order;
> +			}
> +		} while(order--);
> +		spin_unlock_irqrestore(&zone->lock, flags);
> +
> +	}
> +	return 0;
> +}
> +#endif /* CONFIG_SOFTWARE_SUSPEND */

The rest is okay...

I'd try writing it this way, and though I've not tested it, I've walked
buddy lists a few times in the past week or two:


#ifdef CONFIG_SOFTWARE_SUSPEND
int is_head_of_free_region(struct page *page)
{
	zone_t *zone, *node_zones = pgdat_list->node_zones;
	unsigned long flags;

	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
		int order;
		list_t *curr;

		/*
		 * Should not matter as we need quiescent system for
		 * suspend anyway, but...
		 */
		spin_lock_irqsave(&zone->lock, flags);
		for (order = MAX_ORDER - 1; order >= 0; --order)
			list_for_each(curr, &zone->free_area[order].free_list)
				if (page == list_entry(curr, struct page, list))
					return 1 << order;
		spin_unlock_irqrestore(&zone->lock, flags);

	}
	return 0;
}
#endif /* CONFIG_SOFTWARE_SUSPEND */


Cheers,
Bill
