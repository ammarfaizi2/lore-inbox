Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316955AbSE1VeI>; Tue, 28 May 2002 17:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316957AbSE1VeH>; Tue, 28 May 2002 17:34:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48649 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316955AbSE1VeF>; Tue, 28 May 2002 17:34:05 -0400
Date: Tue, 28 May 2002 23:34:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: William Lee Irwin III <wli@holomorphy.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
Message-ID: <20020528213408.GE28189@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020521222858.GA14737@elf.ucw.cz> <20020527194018.GQ14918@holomorphy.com> <20020528193220.GB189@elf.ucw.cz> <20020528210917.GU14918@holomorphy.com> <20020528211120.GA28189@atrey.karlin.mff.cuni.cz> <20020528212427.GV14918@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>> I had to add
> >>> 	if (!curr) break; 
> >>> to fix the oops. It now looks way nicer. Thanx.
> 
> At some point in the past, I wrote:
> >> It's pretty odd that this happens to the buddy lists. I guess if it's
> >> needed as a stopgap measure, I can't complain too much, but I'd suspect
> >> something's corrupting it or you're catching a buddy list operation in
> >> progress. I might be interested in taking a stab at finding out where
> >> the corruption happens if you also think that's what's going on.
> 
> On Tue, May 28, 2002 at 11:11:20PM +0200, Pavel Machek wrote:
> > I think it is not a coruption, but something like
> > "not all list are valid on non-himem machine", or something like that.
> > 								Pavel
> 
> d'oh! Sorry about that, I forgot about free_area_init_core() not fixing
> up zeroed-out list_heads for ZONE_HIGHMEM. I don't see any harm in
> doing INIT_LIST_HEAD() on them in free_area_init_core(), and it

Doing INIT_LIST_HEAD() on them would be certainly cleaner...

> seem to fix this boundary case, no? Alternatively, highmem zones on non-
> highmem machines can be skipped by the caller as well. Do you think
> either of these might be good ideas, or is it going too far out of one's
> way for marginal code prettiness benefits?
> 
> Actually, I just thought of something that might be useful in addition,
> which is that it would probably only be necessary to search inside of
> page_zone(page), do you agree?

Hey, speeding this up is not a top priority. But.. if we can make it
simpler as well ... ;-).

#ifdef CONFIG_SOFTWARE_SUSPEND
int is_head_of_free_region(struct page *page)
{
        zone_t *zone = page_zone(page);
        unsigned long flags;
        int order;
        list_t *curr;

        /*
         * Should not matter as we need quiescent system for
         * suspend anyway, but...
         */
        spin_lock_irqsave(&zone->lock, flags);
        for (order = MAX_ORDER - 1; order >= 0; --order)
                list_for_each(curr, &zone->free_area[order].free_list){
                        if (!curr)
                                break;
                        if (page == list_entry(curr, struct page,list)) {
                                spin_unlock_irqrestore(&zone->lock,flags);
                                return 1 << order;
                        }
                }
        spin_unlock_irqrestore(&zone->lock, flags);
        return 0;
}
#endif /* CONFIG_SOFTWARE_SUSPEND */

Does that look okay to you?

							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
