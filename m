Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWAWBAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWAWBAk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 20:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWAWBAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 20:00:40 -0500
Received: from hera.kernel.org ([140.211.167.34]:5598 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932343AbWAWBAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 20:00:39 -0500
Date: Sun, 22 Jan 2006 11:31:47 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm@kvack.org, jschopp@austin.ibm.com, linux-kernel@vger.kernel.org,
       kamezawa.hiroyu@jp.fujitsu.com, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/4] Split the free lists into kernel and user parts
Message-ID: <20060122133147.GA4186@dmt.cnet>
References: <20060120115415.16475.8529.sendpatchset@skynet.csn.ul.ie> <20060120115455.16475.93688.sendpatchset@skynet.csn.ul.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120115455.16475.93688.sendpatchset@skynet.csn.ul.ie>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On Fri, Jan 20, 2006 at 11:54:55AM +0000, Mel Gorman wrote:
> 
> This patch adds the core of the anti-fragmentation strategy. It works by
> grouping related allocation types together. The idea is that large groups of
> pages that may be reclaimed are placed near each other. The zone->free_area
> list is broken into RCLM_TYPES number of lists.
> 
> Signed-off-by: Mel Gorman <mel@csn.ul.ie>
> Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
> diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc1-mm1-001_antifrag_flags/include/linux/mmzone.h linux-2.6.16-rc1-mm1-002_fragcore/include/linux/mmzone.h
> --- linux-2.6.16-rc1-mm1-001_antifrag_flags/include/linux/mmzone.h	2006-01-19 11:21:59.000000000 +0000
> +++ linux-2.6.16-rc1-mm1-002_fragcore/include/linux/mmzone.h	2006-01-19 21:51:05.000000000 +0000
> @@ -22,8 +22,16 @@
>  #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
>  #endif
>  
> +#define RCLM_NORCLM 0
> +#define RCLM_EASY   1
> +#define RCLM_TYPES  2
> +
> +#define for_each_rclmtype_order(type, order) \
> +	for (order = 0; order < MAX_ORDER; order++) \
> +		for (type = 0; type < RCLM_TYPES; type++)
> +
>  struct free_area {
> -	struct list_head	free_list;
> +	struct list_head	free_list[RCLM_TYPES];
>  	unsigned long		nr_free;
>  };
>  
> diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc1-mm1-001_antifrag_flags/include/linux/page-flags.h linux-2.6.16-rc1-mm1-002_fragcore/include/linux/page-flags.h
> --- linux-2.6.16-rc1-mm1-001_antifrag_flags/include/linux/page-flags.h	2006-01-19 11:21:59.000000000 +0000
> +++ linux-2.6.16-rc1-mm1-002_fragcore/include/linux/page-flags.h	2006-01-19 21:51:05.000000000 +0000
> @@ -76,6 +76,7 @@
>  #define PG_reclaim		17	/* To be reclaimed asap */
>  #define PG_nosave_free		18	/* Free, should not be written */
>  #define PG_uncached		19	/* Page has been mapped as uncached */
> +#define PG_easyrclm		20	/* Page is in an easy reclaim block */
>  
>  /*
>   * Global page accounting.  One instance per CPU.  Only unsigned longs are
> @@ -345,6 +346,12 @@ extern void __mod_page_state_offset(unsi
>  #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
>  #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
>  
> +#define PageEasyRclm(page)	test_bit(PG_easyrclm, &(page)->flags)
> +#define SetPageEasyRclm(page)	set_bit(PG_easyrclm, &(page)->flags)
> +#define ClearPageEasyRclm(page)	clear_bit(PG_easyrclm, &(page)->flags)
> +#define __SetPageEasyRclm(page)	__set_bit(PG_easyrclm, &(page)->flags)
> +#define __ClearPageEasyRclm(page) __clear_bit(PG_easyrclm, &(page)->flags)
> +

You can't read/write to page->flags non-atomically, except when you
guarantee that the page is not visible to other CPU's (eg at the very
end of the page freeing code).

Please use atomic operations.
