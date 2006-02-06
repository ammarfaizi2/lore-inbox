Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWBFIxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWBFIxO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 03:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWBFIxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 03:53:14 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:54701 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1750735AbWBFIxN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 03:53:13 -0500
Message-ID: <43E70E72.4060502@cosmosbay.com>
Date: Mon, 06 Feb 2006 09:53:06 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: bcrl@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, V2] i386: instead of poisoning .init zone, change protection
 bits to force a fault
References: <m1r76rft2t.fsf@ebiederm.dsl.xmission.com>	<m17j8jfs03.fsf@ebiederm.dsl.xmission.com>	<20060128235113.697e3a2c.akpm@osdl.org>	<200601291620.28291.ioe-lkml@rameria.de>	<20060129113312.73f31485.akpm@osdl.org>	<43DD1FDC.4080302@cosmosbay.com>	<20060129200504.GD28400@kvack.org>	<43DD2C15.1090800@cosmosbay.com>	<20060204144111.7e33569f.akpm@osdl.org>	<43E62FF4.3030900@cosmosbay.com> <20060205114235.318146a5.akpm@osdl.org>
In-Reply-To: <20060205114235.318146a5.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 06 Feb 2006 09:53:06 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> Eric Dumazet <dada1@cosmosbay.com> wrote:
>>> --- devel/arch/i386/mm/init.c~i386-instead-of-poisoning-init-zone-change-protection-fix	2006-02-04 14:33:33.000000000 -0800
>>  > +++ devel-akpm/arch/i386/mm/init.c	2006-02-04 14:34:07.000000000 -0800
>>  > @@ -751,11 +751,15 @@ void free_init_pages(char *what, unsigne
>>  >  		ClearPageReserved(virt_to_page(addr));
>>  >  		set_page_count(virt_to_page(addr), 1);
>>  >  #ifdef CONFIG_DEBUG_INITDATA
>>  > +		/*
>>  > +		 * Unmap the page, and leak it.  So any further accesses will
>>  > +		 * oops.
>>  > +		 */
>>  >  		change_page_attr(virt_to_page(addr), 1, __pgprot(0));
>>  >  #else
>>  >  		memset((void *)addr, 0xcc, PAGE_SIZE);
>>  > -#endif
>>  >  		free_page(addr);
>>  > +#endif
>>  >  		totalram_pages++;
>>  >  	}
>>  >  	printk(KERN_INFO "Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
>>  > _
>>  > 
>>  > But is there much point in doing this?  Does it offer much more than
>>  > CONFIG_DEBUG_PAGEALLOC?
>>  > 
>>  > 
>>
>>  1) CONFIG_DEBUG_PAGEALLOC is very generic (and expensive), while 
>>  CONFIG_DEBUG_INITDATA only makes sure init data becomes unreadable.
>>
>>  2) If CONFIG_DEBUG_INITDATA is on, the redzone is in action in the virtual 
>>  memory that hold the initdata, while the physical pages that contained the 
>>  initdata where freed and might be reused for  other needs.
>>
>>  I think we have two different things here : Virtual mem redzoning (my patch), 
>>  and physical ram poisoning (your patch).
>>
>>  CONFIG_DEBUG_INITDATA uses only a virtual mem redzoning (no underlying memory 
>>  cost, apart of the page tables), while your solution doesnt free the pages, 
>>  and the poisoining wont catch further accesses, just make some results funny 
>>  or false.
>>
>>  The only bad effect of my patch is about the TLB cost, because of the 
>>  hugepage(s) that should revert to 512 normal 4K pages.
> 
> Your patch made my kernel oops!  The oops was prevented by either enabling
> CONFIG_DEBUG_PAGEALLOC or by the above patch.

Oh I got it now ! Sorry for being stupid :(

If pages are freed, they indeed can be reused by kmalloc() and we get page 
faults...
I wrongly assumed these pages would be mapped to different virtual addresses.

So your patch is necessary, unless we can free the pages and let them be used 
only for User context for example.

Thank you
Eric

