Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWAWJkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWAWJkx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 04:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWAWJkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 04:40:53 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:58512 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932385AbWAWJkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 04:40:53 -0500
Date: Mon, 23 Jan 2006 09:39:16 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-mm@kvack.org, jschopp@austin.ibm.com, linux-kernel@vger.kernel.org,
       kamezawa.hiroyu@jp.fujitsu.com, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/4] Split the free lists into kernel and user parts
In-Reply-To: <20060122133147.GA4186@dmt.cnet>
Message-ID: <Pine.LNX.4.58.0601230937200.11319@skynet>
References: <20060120115415.16475.8529.sendpatchset@skynet.csn.ul.ie>
 <20060120115455.16475.93688.sendpatchset@skynet.csn.ul.ie>
 <20060122133147.GA4186@dmt.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jan 2006, Marcelo Tosatti wrote:

> Hi Mel,
>
> On Fri, Jan 20, 2006 at 11:54:55AM +0000, Mel Gorman wrote:
> >
> > This patch adds the core of the anti-fragmentation strategy. It works by
> > grouping related allocation types together. The idea is that large groups of
> > pages that may be reclaimed are placed near each other. The zone->free_area
> > list is broken into RCLM_TYPES number of lists.
> >
> > Signed-off-by: Mel Gorman <mel@csn.ul.ie>
> > Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
> > diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc1-mm1-001_antifrag_flags/include/linux/mmzone.h linux-2.6.16-rc1-mm1-002_fragcore/include/linux/mmzone.h
> > --- linux-2.6.16-rc1-mm1-001_antifrag_flags/include/linux/mmzone.h	2006-01-19 11:21:59.000000000 +0000
> > +++ linux-2.6.16-rc1-mm1-002_fragcore/include/linux/mmzone.h	2006-01-19 21:51:05.000000000 +0000
> > @@ -22,8 +22,16 @@
> >  #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
> >  #endif
> >
> > +#define RCLM_NORCLM 0
> > +#define RCLM_EASY   1
> > +#define RCLM_TYPES  2
> > +
> > +#define for_each_rclmtype_order(type, order) \
> > +	for (order = 0; order < MAX_ORDER; order++) \
> > +		for (type = 0; type < RCLM_TYPES; type++)
> > +
> >  struct free_area {
> > -	struct list_head	free_list;
> > +	struct list_head	free_list[RCLM_TYPES];
> >  	unsigned long		nr_free;
> >  };
> >
> > diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc1-mm1-001_antifrag_flags/include/linux/page-flags.h linux-2.6.16-rc1-mm1-002_fragcore/include/linux/page-flags.h
> > --- linux-2.6.16-rc1-mm1-001_antifrag_flags/include/linux/page-flags.h	2006-01-19 11:21:59.000000000 +0000
> > +++ linux-2.6.16-rc1-mm1-002_fragcore/include/linux/page-flags.h	2006-01-19 21:51:05.000000000 +0000
> > @@ -76,6 +76,7 @@
> >  #define PG_reclaim		17	/* To be reclaimed asap */
> >  #define PG_nosave_free		18	/* Free, should not be written */
> >  #define PG_uncached		19	/* Page has been mapped as uncached */
> > +#define PG_easyrclm		20	/* Page is in an easy reclaim block */
> >
> >  /*
> >   * Global page accounting.  One instance per CPU.  Only unsigned longs are
> > @@ -345,6 +346,12 @@ extern void __mod_page_state_offset(unsi
> >  #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
> >  #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
> >
> > +#define PageEasyRclm(page)	test_bit(PG_easyrclm, &(page)->flags)
> > +#define SetPageEasyRclm(page)	set_bit(PG_easyrclm, &(page)->flags)
> > +#define ClearPageEasyRclm(page)	clear_bit(PG_easyrclm, &(page)->flags)
> > +#define __SetPageEasyRclm(page)	__set_bit(PG_easyrclm, &(page)->flags)
> > +#define __ClearPageEasyRclm(page) __clear_bit(PG_easyrclm, &(page)->flags)
> > +
>
> You can't read/write to page->flags non-atomically, except when you
> guarantee that the page is not visible to other CPU's (eg at the very
> end of the page freeing code).
>

The helper PageEasyRclm is only used when either the spinlock is held or a
per-cpu page is being released so it should be safe. The Set and Clear
helpers are only used with a spinlock held.

> Please use atomic operations.
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
