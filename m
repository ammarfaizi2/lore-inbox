Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267994AbUIPLmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267994AbUIPLmI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267986AbUIPLlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:41:45 -0400
Received: from gprs214-194.eurotel.cz ([160.218.214.194]:25474 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267994AbUIPLh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:37:56 -0400
Date: Thu, 16 Sep 2004 13:37:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend2 Merge: e820 table support.
Message-ID: <20040916113735.GG5467@elf.ucw.cz>
References: <1095332590.3324.166.camel@laptop.cunninghams> <20040916111438.GB5467@elf.ucw.cz> <1095333881.4932.194.camel@laptop.cunninghams> <20040916112711.GD5467@elf.ucw.cz> <1095334545.4932.206.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095334545.4932.206.camel@laptop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hmm, it also contains (saveable()):
> > 
> >         BUG_ON(PageReserved(page) && PageNosave(page));
> 
> How do you cover those HighMem pages that get marked Reserved and are
> unusable? (That's what the e820 logic was for, iirc. Think it was done
> about February!). Not handling them resulted in MCEs when trying to do
> the atomic copy or when restoring (seemed random).

This function is not use for highmem, AFAICS. If page is marked
reserved we do not touch it. Do you suggest that we need to save it
for highmem case?

MCEs... I see you have patch to disable them during suspend... That's
clearly wrong thing to do, right?

> > ..but that should be easy to kill. I'd be worried about this function:
> > 
> > static void free_suspend_pagedir_zone(struct zone *zone, unsigned long
> > pagedir)
> > {
> >         unsigned long zone_pfn, pagedir_end, pagedir_pfn,
> > pagedir_end_pfn;
> >         pagedir_end = pagedir + (PAGE_SIZE << pagedir_order);
> >         pagedir_pfn = __pa(pagedir) >> PAGE_SHIFT;
> >         pagedir_end_pfn = __pa(pagedir_end) >> PAGE_SHIFT;
> >         for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
> > {
> >                 struct page *page;
> >                 unsigned long pfn = zone_pfn + zone->zone_start_pfn;
> >                 if (!pfn_valid(pfn))
> >                         continue;
> >                 page = pfn_to_page(pfn);
> 
> Mmm. I should get around to using pfn_to_page. That's necessary for
> discontig support, right? Haven't looked at that yet. (Yes, swsusp has
> functionality suspend2 doesn't!) :>.
> 
> >                 if (!TestClearPageNosave(page))
> >                         continue;
> >                 else if (pfn >= pagedir_pfn && pfn < pagedir_end_pfn)
> >                         continue;
> >                 __free_page(page);
> >         }
> > }
> 
> Wow. This function is really hard to understand. Or maybe I'm really
> ignorant :>.

No, this function really is ugly and needs to die.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
