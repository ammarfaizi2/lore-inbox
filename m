Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWBETnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWBETnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 14:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWBETnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 14:43:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38108 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750701AbWBETnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 14:43:08 -0500
Date: Sun, 5 Feb 2006 11:42:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: bcrl@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, V2] i386: instead of poisoning .init zone, change
 protection bits to force a fault
Message-Id: <20060205114235.318146a5.akpm@osdl.org>
In-Reply-To: <43E62FF4.3030900@cosmosbay.com>
References: <m1r76rft2t.fsf@ebiederm.dsl.xmission.com>
	<m17j8jfs03.fsf@ebiederm.dsl.xmission.com>
	<20060128235113.697e3a2c.akpm@osdl.org>
	<200601291620.28291.ioe-lkml@rameria.de>
	<20060129113312.73f31485.akpm@osdl.org>
	<43DD1FDC.4080302@cosmosbay.com>
	<20060129200504.GD28400@kvack.org>
	<43DD2C15.1090800@cosmosbay.com>
	<20060204144111.7e33569f.akpm@osdl.org>
	<43E62FF4.3030900@cosmosbay.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
>
> > --- devel/arch/i386/mm/init.c~i386-instead-of-poisoning-init-zone-change-protection-fix	2006-02-04 14:33:33.000000000 -0800
>  > +++ devel-akpm/arch/i386/mm/init.c	2006-02-04 14:34:07.000000000 -0800
>  > @@ -751,11 +751,15 @@ void free_init_pages(char *what, unsigne
>  >  		ClearPageReserved(virt_to_page(addr));
>  >  		set_page_count(virt_to_page(addr), 1);
>  >  #ifdef CONFIG_DEBUG_INITDATA
>  > +		/*
>  > +		 * Unmap the page, and leak it.  So any further accesses will
>  > +		 * oops.
>  > +		 */
>  >  		change_page_attr(virt_to_page(addr), 1, __pgprot(0));
>  >  #else
>  >  		memset((void *)addr, 0xcc, PAGE_SIZE);
>  > -#endif
>  >  		free_page(addr);
>  > +#endif
>  >  		totalram_pages++;
>  >  	}
>  >  	printk(KERN_INFO "Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
>  > _
>  > 
>  > But is there much point in doing this?  Does it offer much more than
>  > CONFIG_DEBUG_PAGEALLOC?
>  > 
>  > 
> 
>  1) CONFIG_DEBUG_PAGEALLOC is very generic (and expensive), while 
>  CONFIG_DEBUG_INITDATA only makes sure init data becomes unreadable.
> 
>  2) If CONFIG_DEBUG_INITDATA is on, the redzone is in action in the virtual 
>  memory that hold the initdata, while the physical pages that contained the 
>  initdata where freed and might be reused for  other needs.
> 
>  I think we have two different things here : Virtual mem redzoning (my patch), 
>  and physical ram poisoning (your patch).
> 
>  CONFIG_DEBUG_INITDATA uses only a virtual mem redzoning (no underlying memory 
>  cost, apart of the page tables), while your solution doesnt free the pages, 
>  and the poisoining wont catch further accesses, just make some results funny 
>  or false.
> 
>  The only bad effect of my patch is about the TLB cost, because of the 
>  hugepage(s) that should revert to 512 normal 4K pages.

Your patch made my kernel oops!  The oops was prevented by either enabling
CONFIG_DEBUG_PAGEALLOC or by the above patch.
