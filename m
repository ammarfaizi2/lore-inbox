Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267957AbUIPLia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267957AbUIPLia (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268000AbUIPLi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:38:29 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:39317 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S267957AbUIPLeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:34:16 -0400
Subject: Re: Suspend2 Merge: e820 table support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040916112711.GD5467@elf.ucw.cz>
References: <1095332590.3324.166.camel@laptop.cunninghams>
	 <20040916111438.GB5467@elf.ucw.cz>
	 <1095333881.4932.194.camel@laptop.cunninghams>
	 <20040916112711.GD5467@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1095334545.4932.206.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 16 Sep 2004 21:35:46 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-09-16 at 21:27, Pavel Machek wrote:
> Hmm, it also contains (saveable()):
> 
>         BUG_ON(PageReserved(page) && PageNosave(page));

How do you cover those HighMem pages that get marked Reserved and are
unusable? (That's what the e820 logic was for, iirc. Think it was done
about February!). Not handling them resulted in MCEs when trying to do
the atomic copy or when restoring (seemed random).

> ..but that should be easy to kill. I'd be worried about this function:
> 
> static void free_suspend_pagedir_zone(struct zone *zone, unsigned long
> pagedir)
> {
>         unsigned long zone_pfn, pagedir_end, pagedir_pfn,
> pagedir_end_pfn;
>         pagedir_end = pagedir + (PAGE_SIZE << pagedir_order);
>         pagedir_pfn = __pa(pagedir) >> PAGE_SHIFT;
>         pagedir_end_pfn = __pa(pagedir_end) >> PAGE_SHIFT;
>         for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
> {
>                 struct page *page;
>                 unsigned long pfn = zone_pfn + zone->zone_start_pfn;
>                 if (!pfn_valid(pfn))
>                         continue;
>                 page = pfn_to_page(pfn);

Mmm. I should get around to using pfn_to_page. That's necessary for
discontig support, right? Haven't looked at that yet. (Yes, swsusp has
functionality suspend2 doesn't!) :>.

>                 if (!TestClearPageNosave(page))
>                         continue;
>                 else if (pfn >= pagedir_pfn && pfn < pagedir_end_pfn)
>                         continue;
>                 __free_page(page);
>         }
> }

Wow. This function is really hard to understand. Or maybe I'm really
ignorant :>. 

> I posted diff to get rid of it, but it did not get enough testing so
> it is not in mainline.
> 								Pavel

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

