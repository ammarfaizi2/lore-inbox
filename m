Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269489AbRHCRYm>; Fri, 3 Aug 2001 13:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269482AbRHCRWy>; Fri, 3 Aug 2001 13:22:54 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:62468 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S269506AbRHCRWi>; Fri, 3 Aug 2001 13:22:38 -0400
Message-ID: <01fa01c11c41$51462cd0$bef7020a@mammon>
From: "Jeremy Linton" <jlinton@interactivesi.com>
To: <linux-kernel@vger.kernel.org>
Subject: Free memory starvation in a zone?
Date: Fri, 3 Aug 2001 12:25:35 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kreclaimd() there is a nice loop that looks like

 for(i = 0; i < MAX_NR_ZONES; i++) {
    zone_t *zone = pgdat->node_zones + i;
    if (!zone->size)
        continue;

    while (zone->free_pages < zone->pages_low) {
        struct page * page;
        page = reclaim_page(zone);
        if (!page)
            break;
        __free_page(page);
    }
}

I was playing around with the page age algorithm when i noticed that it
appears that the machine will get into a state where the inner loop _NEVER_
exits the current zone because applications running in that zone are eating
the memory as fast as it is being freed up. I imaging that this could be
causing some pretty serious problems since the other zone's pages will only
get recleaimed during a page alloc. Maybe there should be a max number of
pages that can be reclaimed out of any given zone to force this loop to
break? Something like 5 or 10% of the zone?

Any comments?


BTW: I started playing with the page age system when I noticed that it
wasn't very evenly distributed. All the pages in a  tend to fall into one or
two age groups pretty close to PAGE_AGE_START with a significant number of
them often below PAGE_AGE_START.







