Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316958AbSE1Vxh>; Tue, 28 May 2002 17:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316959AbSE1Vxg>; Tue, 28 May 2002 17:53:36 -0400
Received: from holomorphy.com ([66.224.33.161]:54414 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316958AbSE1Vxf>;
	Tue, 28 May 2002 17:53:35 -0400
Date: Tue, 28 May 2002 14:53:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
Message-ID: <20020528215318.GW14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@suse.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	ACPI mailing list <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20020521222858.GA14737@elf.ucw.cz> <20020527194018.GQ14918@holomorphy.com> <20020528193220.GB189@elf.ucw.cz> <20020528210917.GU14918@holomorphy.com> <20020528211120.GA28189@atrey.karlin.mff.cuni.cz> <20020528212427.GV14918@holomorphy.com> <20020528213408.GE28189@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Actually, I just thought of something that might be useful in addition,
>> which is that it would probably only be necessary to search inside of
>> page_zone(page), do you agree?

On Tue, May 28, 2002 at 11:34:08PM +0200, Pavel Machek wrote:
> Hey, speeding this up is not a top priority. But.. if we can make it
> simpler as well ... ;-).

Yeah, system startup/shutdown isn't really something to optimize for
aside from dodging some worst cases (which is not relevant here).


On Tue, May 28, 2002 at 11:34:08PM +0200, Pavel Machek wrote:
> #ifdef CONFIG_SOFTWARE_SUSPEND
> int is_head_of_free_region(struct page *page)
> {
>         zone_t *zone = page_zone(page);
>         unsigned long flags;
>         int order;
>         list_t *curr;
> 
>         /*
>          * Should not matter as we need quiescent system for
>          * suspend anyway, but...
>          */
>         spin_lock_irqsave(&zone->lock, flags);
>         for (order = MAX_ORDER - 1; order >= 0; --order)
>                 list_for_each(curr, &zone->free_area[order].free_list){
>                         if (!curr)
>                                 break;
>                         if (page == list_entry(curr, struct page,list)) {
>                                 spin_unlock_irqrestore(&zone->lock,flags);
>                                 return 1 << order;
>                         }
>                 }
>         spin_unlock_irqrestore(&zone->lock, flags);
>         return 0;
> }
> #endif /* CONFIG_SOFTWARE_SUSPEND */
> Does that look okay to you?
> 							Pavel

This looks good, though OTOH if we have a page from a zone we should know
the zone exists, and then maybe the if (!curr) check isn't needed. If that's
the case the scary check that almost looks like defensive programming won't
be needed at all. Also, is it always expected that this will be a free page?


Cheers,
Bill
