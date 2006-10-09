Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751756AbWJIJyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbWJIJyE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 05:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWJIJyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 05:54:04 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:7592 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S1750794AbWJIJyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 05:54:00 -0400
Date: Mon, 9 Oct 2006 10:53:58 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Steve Fox <drfickle@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Badari Pulavarty <pbadari@us.ibm.com>, Martin Bligh <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, kmannth@us.ibm.com,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.18-mm2 boot failure on x86-64
In-Reply-To: <20061006200436.GG19756@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0610091049390.30765@skynet.skynet.ie>
References: <20060928014623.ccc9b885.akpm@osdl.org> <200610052105.00359.ak@suse.de>
 <1160080954.29690.44.camel@flooterbu> <200610052250.55146.ak@suse.de>
 <1160101394.29690.48.camel@flooterbu> <20061006143312.GB9881@skynet.ie>
 <20061006153629.GA19756@in.ibm.com> <20061006171105.GC9881@skynet.ie>
 <1160157830.29690.66.camel@flooterbu> <20061006200436.GG19756@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006, Vivek Goyal wrote:

> On Fri, Oct 06, 2006 at 01:03:50PM -0500, Steve Fox wrote:
>> On Fri, 2006-10-06 at 18:11 +0100, Mel Gorman wrote:
>>> On (06/10/06 11:36), Vivek Goyal didst pronounce:
>>>> Where is bss placed in physical memory? I guess bss_start and bss_stop
>>>> from System.map will tell us. That will confirm that above memset step is
>>>> stomping over bss. Then we have to just find that somewhere probably
>>>> we allocated wrong physical memory area for bootmem allocator map.
>>>>
>>>
>>> BSS is at 0x643000 -> 0x777BC4
>>> init_bootmem wipes from 0x777000 -> 0x8F7000
>>>
>>> So the BSS bytes from 0x777000 ->0x777BC4 (which looks very suspiciously
>>> pile a page alignment of addr & PAGE_MASK) gets set to 0xFF. One possible
>>> fix is below. It adds a check in bad_addr() to see if the BSS section is
>>> about to be used for bootmap. It Seems To Work For Me (tm) and illustrates
>>> the source of the problem even if it's not the 100% correct fix.
>>
>> I was able to boot the machine with Mel's patch applied on top of
>> -git22.
>
>
> Please have a look at the attached patch. Does it make some sense.
>

It makes some sense. As you state, it wastes memory but that is better 
than breaking.

> Steve, can you please give this patch a try if it fixes the problem?
>

I boottested the patch on the same machine as Steve was using and it 
completed successfully.

> Thanks
> Vivek
>
>
>
>
> o Currently some code pieces assume that address returned by find_e820_area()
>  are page aligned. But looks like find_e820_area() had no such intention
>  and hence one might end up stomping over some of the data. One such
>  case is bootmem allocator initialization code stomped over bss.
>
> o This patch modified find_e820_area() to return page aligned address. This
>  might be little wasteful of memory but at the same time probably it is
>  easier to handle page aligned memory.
>
> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
> ---
>
> arch/x86_64/kernel/e820.c |   14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff -puN arch/x86_64/kernel/e820.c~x86_64-return-page-aligned-phy-addr-from-find-e820-area arch/x86_64/kernel/e820.c
> --- linux-2.6.19-rc1-1M/arch/x86_64/kernel/e820.c~x86_64-return-page-aligned-phy-addr-from-find-e820-area	2006-10-06 15:28:13.000000000 -0400
> +++ linux-2.6.19-rc1-1M-root/arch/x86_64/kernel/e820.c	2006-10-06 15:44:45.000000000 -0400
> @@ -54,13 +54,13 @@ static inline int bad_addr(unsigned long
>
> 	/* various gunk below that needed for SMP startup */
> 	if (addr < 0x8000) {
> -		*addrp = 0x8000;
> +		*addrp = PAGE_ALIGN(0x8000);
> 		return 1;
> 	}
>
> 	/* direct mapping tables of the kernel */
> 	if (last >= table_start<<PAGE_SHIFT && addr < table_end<<PAGE_SHIFT) {
> -		*addrp = table_end << PAGE_SHIFT;
> +		*addrp = PAGE_ALIGN(table_end << PAGE_SHIFT);
> 		return 1;
> 	}
>
> @@ -68,18 +68,18 @@ static inline int bad_addr(unsigned long
> #ifdef CONFIG_BLK_DEV_INITRD
> 	if (LOADER_TYPE && INITRD_START && last >= INITRD_START &&
> 	    addr < INITRD_START+INITRD_SIZE) {
> -		*addrp = INITRD_START + INITRD_SIZE;
> +		*addrp = PAGE_ALIGN(INITRD_START + INITRD_SIZE);
> 		return 1;
> 	}
> #endif
> 	/* kernel code */
> -	if (last >= __pa_symbol(&_text) && last < __pa_symbol(&_end)) {
> -		*addrp = __pa_symbol(&_end);
> +	if (last >= __pa_symbol(&_text) && addr < __pa_symbol(&_end)) {
> +		*addrp = PAGE_ALIGN(__pa_symbol(&_end));
> 		return 1;
> 	}
>
> 	if (last >= ebda_addr && addr < ebda_addr + ebda_size) {
> -		*addrp = ebda_addr + ebda_size;
> +		*addrp = PAGE_ALIGN(ebda_addr + ebda_size);
> 		return 1;
> 	}
>
> @@ -152,7 +152,7 @@ unsigned long __init find_e820_area(unsi
> 			continue;
> 		while (bad_addr(&addr, size) && addr+size <= ei->addr+ei->size)
> 			;
> -		last = addr + size;
> +		last = PAGE_ALIGN(addr) + size;
> 		if (last > ei->addr + ei->size)
> 			continue;
> 		if (last > end)
> _
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
