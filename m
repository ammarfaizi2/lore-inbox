Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267967AbUIPL2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267967AbUIPL2G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267968AbUIPL2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:28:05 -0400
Received: from gprs214-194.eurotel.cz ([160.218.214.194]:23170 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267967AbUIPL1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:27:30 -0400
Date: Thu, 16 Sep 2004 13:27:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend2 Merge: e820 table support.
Message-ID: <20040916112711.GD5467@elf.ucw.cz>
References: <1095332590.3324.166.camel@laptop.cunninghams> <20040916111438.GB5467@elf.ucw.cz> <1095333881.4932.194.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095333881.4932.194.camel@laptop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +#ifdef CONFIG_SOFTWARE_SUSPEND2
> > > +			/*
> > > +			 * Mark nosave pages
> > > +			 */
> > > +			if (addr >= (void *)&__nosave_begin && addr < (void *)&__nosave_end)
> > > +				SetPageNosave(mem_map+tmp);
> > > +		} else
> > > +			/*
> > > +			 * Non-RAM pages are always nosave
> > > +			 */
> > > +			SetPageNosave(mem_map+tmp);
> > > +#else
> > > +		}
> > > +#endif
> > > +	}
> > 
> > Current -mm code does something funny with Nosave; I'm not sure it
> > will not try to free them after resume. I have fix in my tree but it
> > is little tested.
> 
> Double negative: you think current mm may try to free Nosave pages after
> resume? I haven't updated to the latest -mm yet, but will see if I can
> try tomorrow.


Hmm, it also contains (saveable()):

        BUG_ON(PageReserved(page) && PageNosave(page));

..but that should be easy to kill. I'd be worried about this function:

static void free_suspend_pagedir_zone(struct zone *zone, unsigned long
pagedir)
{
        unsigned long zone_pfn, pagedir_end, pagedir_pfn,
pagedir_end_pfn;
        pagedir_end = pagedir + (PAGE_SIZE << pagedir_order);
        pagedir_pfn = __pa(pagedir) >> PAGE_SHIFT;
        pagedir_end_pfn = __pa(pagedir_end) >> PAGE_SHIFT;
        for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
{
                struct page *page;
                unsigned long pfn = zone_pfn + zone->zone_start_pfn;
                if (!pfn_valid(pfn))
                        continue;
                page = pfn_to_page(pfn);
                if (!TestClearPageNosave(page))
                        continue;
                else if (pfn >= pagedir_pfn && pfn < pagedir_end_pfn)
                        continue;
                __free_page(page);
        }
}

I posted diff to get rid of it, but it did not get enough testing so
it is not in mainline.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
