Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWEOKqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWEOKqd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 06:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWEOKqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 06:46:33 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:54227 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964876AbWEOKqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 06:46:32 -0400
Date: Mon, 15 May 2006 19:47:35 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: apw@shadowen.org, nickpiggin@yahoo.com.au, akpm@osdl.org, mel@csn.ul.ie,
       davej@codemonkey.org.uk, tony.luck@intel.com,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/6] Have ia64 use add_active_range() and
 free_area_init_nodes
Message-Id: <20060515194735.0858b7c9.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060515192918.c3e2e895.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060508141030.26912.93090.sendpatchset@skynet>
	<20060508141211.26912.48278.sendpatchset@skynet>
	<20060514203158.216a966e.akpm@osdl.org>
	<44683A09.2060404@shadowen.org>
	<44685123.7040501@yahoo.com.au>
	<446855AF.1090100@shadowen.org>
	<20060515192918.c3e2e895.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2006 19:29:18 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> On Mon, 15 May 2006 11:19:27 +0100
> Andy Whitcroft <apw@shadowen.org> wrote:
> 
> > Nick Piggin wrote:
> > > Andy Whitcroft wrote:
> > > 
> > >> Interesting.  You are correct there was no config component, at the time
> > >> I didn't have direct evidence that any architecture needed it, only that
> > >> we had an unchecked requirement on zones, a requirement that had only
> > >> recently arrived with the changes to free buddy detection.  I note that
> > > 
> > > 
> > > Recently arrived? Over a year ago with the no-buddy-bitmap patches,
> > > right? Just checking because I that's what I'm assuming broke it...
> > 
> > Yep, sorry I forget I was out of the game for 6 months!  And yes that
> > was when the requirements were altered.
> > 
> When no-bitmap-buddy patches was included,
> 
> 1. bad_range() is not covered by CONFIG_VM_DEBUG. It always worked.
> ==
> static int bad_range(struct zone *zone, struct page *page)
> {
>         if (page_to_pfn(page) >= zone->zone_start_pfn + zone->spanned_pages)
>                 return 1;
>         if (page_to_pfn(page) < zone->zone_start_pfn)
>                 return 1;
> ==
> And , this code
> ==
>                 buddy = __page_find_buddy(page, page_idx, order);
> 
>                 if (bad_range(zone, buddy))
>                         break;
> ==
> 
> checked whether buddy is in zone and guarantees it to have page struct.
> 
> 
> But clean-up/speed-up codes vanished these checks. (I don't know when this occurs)
> Sorry for misses these things.
> 

One more point
When above no-bitmap patches was included, the user of not-aligned zones
are only ia64, I think. Because ia64 used virtual mem_map, page_to_pfn(page)
on  CONFIG_DISCONTIG_MEM doesn't access page struct itself. 

#define page_to_pfn(page)	(page - vmemmap)

So, it didn't  panic. ia64/vmemmap was safe.

If other archs used not-aligned zone + CONFIG_DISCONTIGMEM,
not-aligned-zones problem would come out earlier.

-Kame

