Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbVHJVu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbVHJVu3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 17:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbVHJVu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 17:50:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56285 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030290AbVHJVu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 17:50:28 -0400
Date: Wed, 10 Aug 2005 23:50:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: Daniel Phillips <phillips@arcor.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Message-ID: <20050810215022.GA2465@elf.ucw.cz>
References: <42F57FCA.9040805@yahoo.com.au> <1123577509.30257.173.camel@gaston> <42F87C24.4080000@yahoo.com.au> <200508100522.51297.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508100522.51297.phillips@arcor.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Swsusp is the main "is valid ram" user I have in mind here. It
> > wants to know whether or not it should save and restore the
> > memory of a given `struct page`.
> 
> Why can't it follow the rmap chain?

It is walking physical memory, not memory managment chains. I need
something like:

static int saveable(struct zone * zone, unsigned long * zone_pfn)
{
        unsigned long pfn = *zone_pfn + zone->zone_start_pfn;
        struct page * page;

        if (!pfn_valid(pfn))
                return 0;

        page = pfn_to_page(pfn);
        BUG_ON(PageReserved(page) && PageNosave(page));
        if (PageNosave(page))
                return 0;
        if (PageReserved(page) && pfn_is_nosave(pfn)) {
                pr_debug("[nosave pfn 0x%lx]", pfn);
                return 0;
        }
        if (PageNosaveFree(page))
                return 0;

        return 1;
}
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
