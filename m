Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbUDFRNf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 13:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbUDFRNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 13:13:34 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:60103 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261427AbUDFRNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 13:13:21 -0400
Subject: Re: [patch 1/3] memory hotplug prototype
From: Dave Hansen <haveblue@us.ibm.com>
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <20040406105649.77F36705DE@sv1.valinux.co.jp>
References: <20040406105353.9BDE8705DE@sv1.valinux.co.jp>
	 <20040406105649.77F36705DE@sv1.valinux.co.jp>
Content-Type: text/plain
Message-Id: <1081271577.32423.193.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 06 Apr 2004 10:12:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-06 at 03:56, IWAMOTO Toshihiro wrote:
>                 for (node = local_node + 1; node < numnodes; node++)
> -                       j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
> +                       j = build_zonelists_node(NODE_DATA(node),
> +                           zonelist, j, k);

This line is probably too long already, but please leave it.  If you
want to clean things up, please send a separate cleanup patch.

> -/* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low two bits) */
> -#define __GFP_DMA	0x01
> -#define __GFP_HIGHMEM	0x02
> +/* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low three bits) */
> +#define __GFP_DMA		0x01
> +#define __GFP_HIGHMEM		0x02
> +#define __GFP_HOTREMOVABLE	0x03

Are you still determined to add a zone like this?  Hotplug will
eventually have to be done on all of the zones (NORMAL, DMA, etc...), so
it seems a bit shortsighted to add a zone like this.  I think it would
be much more valuable to be able to attempt hotremove operations on any
zone, even if they are unlikely to succeed.

>  #define put_page_testzero(p)				\
>  	({						\
> -		BUG_ON(page_count(p) == 0);		\
> +		if (page_count(p) == 0) {		\
> +			int i;						\
> +			printk("Page: %lx ", (long)p);			\
> +			for(i = 0; i < sizeof(struct page); i++)	\
> +				printk(" %02x", ((unsigned char *)p)[i]); \
> +			printk("\n");					\
> +			BUG();				\
> +		}					\
>  		atomic_dec_and_test(&(p)->count);	\
>  	})

Could you pull this debugging code out, or put it in an out-of-line
function?  Stuff like this in inline functions or macros just bloat
code. 

> -#define try_to_unmap(page)	SWAP_FAIL
> +#define try_to_unmap(page, force)	SWAP_FAIL
>  #endif /* CONFIG_MMU *
...
> +#ifdef CONFIG_MEMHOTPLUG
> +               vlist = kmalloc(sizeof(struct page_va_list), GFP_KERNEL);
> +               vlist->mm = mm;
> +               vlist->addr = address;
> +               list_add(&vlist->list, force);
> +#endif


Could you explain what you're trying to do with try_to_unmap() and why
all of the calls need to be changed?

> -	int error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
> +	int error = radix_tree_preload((gfp_mask & ~GFP_ZONEMASK) |
> +	    ((gfp_mask & GFP_ZONEMASK) == __GFP_DMA ? __GFP_DMA : 0));

What is this doing?  Trying to filter off the highmem flag without
affecting the hotremove flag???

>  	lock_page(page);
> +	if (page->mapping == NULL) {
> +		BUG_ON(! PageAgain(page));
> +		unlock_page(page);
> +		page_cache_release(page);
> +		pte_chain_free(pte_chain);
> +		goto again;
> +	}
> +	BUG_ON(PageAgain(page));

You might want to add a little comment here noting that this is for the
hotremove case only.  No normal paths hit it.
 

> -#if defined(CONFIG_PM) || defined(CONFIG_HOTPLUG_CPU)
> +#if defined(CONFIG_PM) || defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMHOTPLUG)

I think it's safe to say that you need an aggregate config option for
this one :)

>  /*
>   * Builds allocation fallback zone lists.
>   */
> -static int __init build_zonelists_node(pg_data_t *pgdat, struct zonelist *zonelist, int j, int k)
> +static int build_zonelists_node(pg_data_t *pgdat, struct zonelist *zonelist, int j, int k)
>  {
> +
> +	if (! pgdat->enabled)
> +		return j;

Normal Linux style is:
> +	if (!pgdat->enabled)
> +		return j;


> +	if (k != ZONE_HOTREMOVABLE &&
> +	    pgdat->removable)
> +		return j;

What is this check supposed to do?


> -		memset(zonelist, 0, sizeof(*zonelist));
> +		/* memset(zonelist, 0, sizeof(*zonelist)); */

Why is this memset unnecessary now?


>  		j = 0;
>  		k = ZONE_NORMAL;
> -		if (i & __GFP_HIGHMEM)
> +		hotremovable = 0;
> +		switch (i) {
> +		default:
> +			BUG();
> +			return;
> +		case 0:
> +			k = ZONE_NORMAL;
> +			break;
> +		case __GFP_HIGHMEM:
>  			k = ZONE_HIGHMEM;
> -		if (i & __GFP_DMA)
> +			break;
> +		case __GFP_DMA:
>  			k = ZONE_DMA;
> +			break;
> +		case __GFP_HOTREMOVABLE:
> +#ifdef CONFIG_MEMHOTPLUG
> +			k = ZONE_HIGHMEM;
> +#else
> +			k = ZONE_HOTREMOVABLE;
> +#endif
> +			hotremovable = 1;
> +			break;
> +		}

What if, in the header you did this:
#ifndef CONFIG_MEMHOTPLUG
#define ZONE_HOTREMOVABLE ZONE_HIGHMEM
#endif

Then, you wouldn't need the #ifdef in the .c file.

There is way too much ifdef'ing going on in this code.  The general
Linux rule is: no #ifdef's in .c files.  This is a good example why :)

> +#ifndef CONFIG_MEMHOTPLUG
>   		j = build_zonelists_node(pgdat, zonelist, j, k);
>   		/*
>   		 * Now we build the zonelist so that it contains the zones
> @@ -1267,22 +1304,59 @@ static void __init build_zonelists(pg_da
>   		 * node N+1 (modulo N)
>   		 */
>   		for (node = local_node + 1; node < numnodes; node++)
> - 			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
> +			j = build_zonelists_node(NODE_DATA(node),
> +			    zonelist, j, k);
>   		for (node = 0; node < local_node; node++)
> - 			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
> - 
> -		zonelist->zones[j++] = NULL;
> +			j = build_zonelists_node(NODE_DATA(node),
> +			    zonelist, j, k);
> +#else
> +		while (hotremovable >= 0) {
> +			for(; k >= 0; k--) {
> +				zone = pgdat->node_zones + k;
> +				for (node = local_node; ;) {
> +					if (NODE_DATA(node) == NULL ||
> +					    ! NODE_DATA(node)->enabled ||
> +					    (!! NODE_DATA(node)->removable) !=
> +					    (!! hotremovable))
> +						goto next;
> +					zone = NODE_DATA(node)->node_zones + k;
> +					if (zone->present_pages)
> +						zonelist->zones[j++] = zone;
> +				next:
> +					node = (node + 1) % numnodes;
> +					if (node == local_node)
> +						break;
> +				}
> +			}
> +			if (hotremovable) {
> +				/* place non-hotremovable after hotremovable */
> +				k = ZONE_HIGHMEM;
> +			}
> +			hotremovable--;
> +		}
> +#endif
> +		BUG_ON(j > sizeof(zonelist->zones) /
> +		    sizeof(zonelist->zones[0]) - 1);
> +		for(; j < sizeof(zonelist->zones) /
> +		    sizeof(zonelist->zones[0]); j++)
> +			zonelist->zones[j] = NULL;
>  	} 
>  }

That code need to be separated out somehow.   It's exceedingly hard to
understand what's going on.  

> -void __init build_all_zonelists(void)
> +#ifdef CONFIG_MEMHOTPLUG
> +void
> +#else
> +void __init
> +#endif
> +build_all_zonelists(void)
>  {
>  	int i;
>  
>  	for(i = 0 ; i < numnodes ; i++)
> -		build_zonelists(NODE_DATA(i));
> +		if (NODE_DATA(i) != NULL)
> +			build_zonelists(NODE_DATA(i));
>  	printk("Built %i zonelists\n", numnodes);
>  }

Please make that __init __devinit, instead of using the #ifdef.  That
will turn off the __init when CONFIG_HOTPLUG is turned on.  BTW, you
should make HOTPLUGMEM dependent on CONFIG_HOTPLUG.


-- Dave

