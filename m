Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262914AbSKCWrd>; Sun, 3 Nov 2002 17:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263281AbSKCWrc>; Sun, 3 Nov 2002 17:47:32 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10245 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262914AbSKCWrW>; Sun, 3 Nov 2002 17:47:22 -0500
Date: Sun, 3 Nov 2002 23:53:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Hot/cold allocation -- swsusp can not handle hot pages
Message-ID: <20021103225353.GQ28704@atrey.karlin.mff.cuni.cz>
References: <20021102181900.GA140@elf.ucw.cz> <20021102184612.GI23425@holomorphy.com> <20021102202208.GC18576@atrey.karlin.mff.cuni.cz> <3DC44839.A3AEAE41@digeo.com> <20021103200809.GC27271@elf.ucw.cz> <20021103205206.GN23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103205206.GN23425@holomorphy.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > "big-picture" should be in Documentation/swsusp.txt...
> > *Should* be :-(. I need to copy all used memory, to make sure my
> > snapshot is atomic.
> > Copying works by looking at what is allocated, counting needed pages,
> > allocating 'directory' for them, allocating memory for copies, and
> > actually copying.
> > When I suddenly find I have less data to copy than I thought, it
> > screws up the code.
> 
> Why don't we just mark PG_nosave in page->flags and stuff order in
> page->index (or elsewhere) for you and then you can safely walk
> the zone->zone_mem_map? A single pass of marking up-front should
> be a bit quicker than searching the lists for a list head at every
> page, and also something more maintainable/comprehensible: we can
> basically know what we're dealing with and do a kind of "shutdown"
> of the stuff for you:

Storing order in page->index is kind of hack, right?

> static void empty_pageset(struct zone *zone, struct per_cpu_pages *pcp)
> {
> 	pcp->batch = pcp->low = pcp->high = 1;
> 	pcp->count -= free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
> }
> 
> static void empty_cpu_pages(void *unused)
> {
> 	struct zone *zone;
> 	unsigned long flags;
> 	int cpu;
> 
> 	cpu = get_cpu();
> 	local_irq_save(flags);
> 
> 	for_each_zone(zone) {
> 		empty_pcp(zone, &zone->pageset[cpu].pcp[0]);
> 		empty_pcp(zone, &zone->pageset[cpu].pcp[1]);
> 	}
> 
> 	local_irq_restore(flags);
> 	put_cpu();
> }

You don't need to make it SMP-safe.. Plan is to hotremove cpus before
we enter this stage.

> static void shootdown_per_cpu_pages(void)
> {
> 	smp_call_function(empty_cpu_pages, NULL, 0, 1);
> 	empty_cpu_pages(NULL);
> }
> 
> void suspend_mark_free_pages(void)
> {
> 	struct zone *zone;
> 	struct free_area *area;
> 	struct page *page;
> 	unsigned long flags;
> 	int order;
> 
> 	shootdown_per_cpu_pages();
> 
> 	for_each_zone(zone) {
> 		spin_lock_irqsave(&zone->lock, flags);
> 		for (order = 0; order < MAX_ORDER; ++order) {
> 			area = &zone->free_area[order];
> 			list_for_each_entry(page, &area->free_list, list) {
> 				SetPageNosave(page);
> 				/* if ->index clashes, use flag bits */
> 				page->index = order;
> 			}
> 		}
> 		spin_unlock_irqrestore(&zone->lock, flags);
> 	}
> }
> 
> Then you can just do
> 
> 	if (PageNosave(page))
> 		pfn += 1 << page->index;
> 
> in kernel/suspend.c and everybody's happy, no?

Well, empty_cpu_pages() seems like function I need to call before I do
my current stuff, and it will start working. Thanx. I do not really
want to store ->index anywhere... Its not performance critical.

I'll try that, probably tuesday.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
