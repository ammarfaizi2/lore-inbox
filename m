Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUHaQdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUHaQdI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUHaQci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:32:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:43486 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263003AbUHaQbQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:31:16 -0400
Subject: Re: [RFC] buddy allocator without bitmap(2) [1/3]
From: Dave Hansen <haveblue@us.ibm.com>
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <413455BE.6010302@jp.fujitsu.com>
References: <413455BE.6010302@jp.fujitsu.com>
Content-Type: text/plain
Message-Id: <1093969857.26660.4816.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 31 Aug 2004 09:30:57 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 03:41, Hiroyuki KAMEZAWA wrote:
> +static void __init calculate_aligned_end(struct zone *zone,
> +					 unsigned long start_pfn,
> +					 int nr_pages)
...
> +		end_address = (zone->zone_start_pfn + end_idx) << PAGE_SHIFT;
> +#ifndef CONFIG_DISCONTIGMEM
> +		reserve_bootmem(end_address,PAGE_SIZE);
> +#else
> +		reserve_bootmem_node(zone->zone_pgdat,end_address,PAGE_SIZE);
> +#endif
> +	}
> +	return;
> +}

What if someone has already reserved that address?  You might not be
able to grow the zone, right?

>   /*
>    * Initially all pages are reserved - free ones are freed
> @@ -1510,7 +1574,9 @@ void __init memmap_init_zone(unsigned lo
>   {
>   	struct page *start = pfn_to_page(start_pfn);
>   	struct page *page;
> -
> +	unsigned long saved_start_pfn = start_pfn;
> +	struct zone *zonep = zone_table[NODEZONE(nid, zone)];

If you're going to calculate NODEZONE() twice, you might as well just
move it into its own variable.  

> +	/* Because memmap_init_zone() is called in suitable way
> +	 * even if zone has memory holes,
> +	 * calling calculate_aligned_end(zone) here is reasonable
> +	 */
> +	calculate_aligned_end(zonep, saved_start_pfn, size);

Could you please elaborate on "suitable way".  That comment really
doesn't say anything.

-- Dave

