Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316916AbSE1Unc>; Tue, 28 May 2002 16:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316933AbSE1UnR>; Tue, 28 May 2002 16:43:17 -0400
Received: from [195.39.17.254] ([195.39.17.254]:60060 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316915AbSE1Ulf>;
	Tue, 28 May 2002 16:41:35 -0400
Date: Tue, 28 May 2002 21:32:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
Message-ID: <20020528193220.GB189@elf.ucw.cz>
In-Reply-To: <20020521222858.GA14737@elf.ucw.cz> <20020527194018.GQ14918@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The rest is okay...
> 
> I'd try writing it this way, and though I've not tested it, I've walked
> buddy lists a few times in the past week or two:
> 
> 
> #ifdef CONFIG_SOFTWARE_SUSPEND
> int is_head_of_free_region(struct page *page)
> {
> 	zone_t *zone, *node_zones = pgdat_list->node_zones;
> 	unsigned long flags;
> 
> 	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
> 		int order;
> 		list_t *curr;
> 
> 		/*
> 		 * Should not matter as we need quiescent system for
> 		 * suspend anyway, but...
> 		 */
> 		spin_lock_irqsave(&zone->lock, flags);
> 		for (order = MAX_ORDER - 1; order >= 0; --order)
> 			list_for_each(curr, &zone->free_area[order].free_list)
<== HERE ==>
> 				if (page == list_entry(curr, struct page, list))
> 					return 1 << order;
> 		spin_unlock_irqrestore(&zone->lock, flags);
> 
> 	}
> 	return 0;
> }
> #endif /* CONFIG_SOFTWARE_SUSPEND */

I had to add
	if (!curr) break; 

to fix the oops. It now looks way nicer. Thanx.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
