Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWBFJCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWBFJCL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWBFJCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:02:10 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:40579 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1750805AbWBFJCI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:02:08 -0500
Message-ID: <43E7108A.8030001@cosmosbay.com>
Date: Mon, 06 Feb 2006 10:02:02 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: bcrl@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, V2] i386: instead of poisoning .init zone, change protection
 bits to force a fault
References: <m1r76rft2t.fsf@ebiederm.dsl.xmission.com>	<m17j8jfs03.fsf@ebiederm.dsl.xmission.com>	<20060128235113.697e3a2c.akpm@osdl.org>	<200601291620.28291.ioe-lkml@rameria.de>	<20060129113312.73f31485.akpm@osdl.org>	<43DD1FDC.4080302@cosmosbay.com>	<20060129200504.GD28400@kvack.org>	<43DD2C15.1090800@cosmosbay.com> <20060204144111.7e33569f.akpm@osdl.org>
In-Reply-To: <20060204144111.7e33569f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 06 Feb 2006 10:02:02 +0100 (CET)
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

I wonder if you dont have to move the 'totalram_pages++;' next to the 
free_page(addr) call (ie inside the #else/#endif block)

Eric

