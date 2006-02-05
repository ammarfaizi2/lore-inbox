Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWBEREG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWBEREG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 12:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWBEREG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 12:04:06 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:9137 "EHLO smtp.cegetel.net")
	by vger.kernel.org with ESMTP id S1750887AbWBEREF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 12:04:05 -0500
Message-ID: <43E62FF4.3030900@cosmosbay.com>
Date: Sun, 05 Feb 2006 18:03:48 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: bcrl@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, V2] i386: instead of poisoning .init zone, change protection
 bits to force a fault
References: <m1r76rft2t.fsf@ebiederm.dsl.xmission.com>	<m17j8jfs03.fsf@ebiederm.dsl.xmission.com>	<20060128235113.697e3a2c.akpm@osdl.org>	<200601291620.28291.ioe-lkml@rameria.de>	<20060129113312.73f31485.akpm@osdl.org>	<43DD1FDC.4080302@cosmosbay.com>	<20060129200504.GD28400@kvack.org>	<43DD2C15.1090800@cosmosbay.com> <20060204144111.7e33569f.akpm@osdl.org>
In-Reply-To: <20060204144111.7e33569f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> Eric Dumazet <dada1@cosmosbay.com> wrote:
>>
>> Chasing some invalid accesses to .init zone, I found that free_init_pages() 
>> was properly freeing the pages but virtual was still usable.
>>
>> A poisoning (memset(page, 0xcc, PAGE_SIZE)) was done but this is not reliable.
>>
>> A new config option DEBUG_INITDATA is introduced to mark this initdata as not 
>> present at all so that buggy code can trigger a fault.
>>
>> This option is not meant for production machines because it may split one or 
>> two huge page (2MB or 4MB) into small pages and thus slow down kernel a bit.
>>
>> (After that we could map non possible cpu percpu data to the initial 
>> percpudata that is included in .init and discarded in free_initmem())
>>
>> ...
>>
>> --- a/arch/i386/mm/init.c	2006-01-25 10:17:24.000000000 +0100
>> +++ b/arch/i386/mm/init.c	2006-01-29 22:38:53.000000000 +0100
>> @@ -750,11 +750,18 @@
>>  	for (addr = begin; addr < end; addr += PAGE_SIZE) {
>>  		ClearPageReserved(virt_to_page(addr));
>>  		set_page_count(virt_to_page(addr), 1);
>> +#ifdef CONFIG_DEBUG_INITDATA
>> +		change_page_attr(virt_to_page(addr), 1, __pgprot(0));
>> +#else
>>  		memset((void *)addr, 0xcc, PAGE_SIZE);
>> +#endif
>>  		free_page(addr);
>>  		totalram_pages++;
>>  	}
>>  	printk(KERN_INFO "Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
>> +#ifdef CONFIG_DEBUG_INITDATA
>> +	global_flush_tlb();
>> +#endif
>>  }
>>  
> 
> This doesn't seem very pointful.
> 
> We unmap the page, then return it to the page allocator.  Then someone
> reallocates the page, tries to use it and goes oops.
> 
> If CONFIG_DEBUG_PAGEALLOC is also set, the kernel will remap the page when
> it's allocated and everything works OK.  So this patch requires
> CONFIG_DEBUG_PAGEALLOC.
> 
> But if CONFIG_DEBUG_PAGEALLOC is set, we'll have unmapped that page in
> free_page() _anyway_, so why bother using this patch?
> 
> The only enhancement I can think of here is to not free the page, so it's
> permanently leaked and permanently unmapped.
> 
> --- devel/arch/i386/mm/init.c~i386-instead-of-poisoning-init-zone-change-protection-fix	2006-02-04 14:33:33.000000000 -0800
> +++ devel-akpm/arch/i386/mm/init.c	2006-02-04 14:34:07.000000000 -0800
> @@ -751,11 +751,15 @@ void free_init_pages(char *what, unsigne
>  		ClearPageReserved(virt_to_page(addr));
>  		set_page_count(virt_to_page(addr), 1);
>  #ifdef CONFIG_DEBUG_INITDATA
> +		/*
> +		 * Unmap the page, and leak it.  So any further accesses will
> +		 * oops.
> +		 */
>  		change_page_attr(virt_to_page(addr), 1, __pgprot(0));
>  #else
>  		memset((void *)addr, 0xcc, PAGE_SIZE);
> -#endif
>  		free_page(addr);
> +#endif
>  		totalram_pages++;
>  	}
>  	printk(KERN_INFO "Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
> _
> 
> But is there much point in doing this?  Does it offer much more than
> CONFIG_DEBUG_PAGEALLOC?
> 
> 

1) CONFIG_DEBUG_PAGEALLOC is very generic (and expensive), while 
CONFIG_DEBUG_INITDATA only makes sure init data becomes unreadable.

2) If CONFIG_DEBUG_INITDATA is on, the redzone is in action in the virtual 
memory that hold the initdata, while the physical pages that contained the 
initdata where freed and might be reused for  other needs.

I think we have two different things here : Virtual mem redzoning (my patch), 
and physical ram poisoning (your patch).

CONFIG_DEBUG_INITDATA uses only a virtual mem redzoning (no underlying memory 
cost, apart of the page tables), while your solution doesnt free the pages, 
and the poisoining wont catch further accesses, just make some results funny 
or false.

The only bad effect of my patch is about the TLB cost, because of the 
hugepage(s) that should revert to 512 normal 4K pages.

Eric
