Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWEUWX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWEUWX5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 18:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWEUWX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 18:23:57 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:56720 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932414AbWEUWX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 18:23:56 -0400
Date: Sun, 21 May 2006 23:23:51 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andrew Morton <akpm@osdl.org>
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, ak@suse.de, bob.picco@hp.com,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and free_area_init_nodes
In-Reply-To: <20060521120843.43babdc7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0605212219540.27379@skynet.skynet.ie>
References: <20060508141030.26912.93090.sendpatchset@skynet>
 <20060508141151.26912.15976.sendpatchset@skynet> <20060520135922.129a481d.akpm@osdl.org>
 <Pine.LNX.4.64.0605211528390.16327@skynet.skynet.ie> <20060521120843.43babdc7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 May 2006, Andrew Morton wrote:

> Mel Gorman <mel@csn.ul.ie> wrote:
>>
>
>>> Anyway, I just don't get how this code can work.  We have an e820 map with
>>> up to 128 entries (this machine has ten) and we're trying to scrunch that
>>> all into the four-entry early_node_map[].
>>>
>>
>> Missing E820MAX was a mistake. On x86_64, CONFIG_MAX_ACTIVE_REGIONS should
>> have been used. I didn't expect x86_64 to have so many memory holes.
>
> x86 uses 128 e820 slots too.
>

That is true, but with x86, I am not expecting many regions. For flatmem, 
only one region will be registered. For NUMA, I would expect one 
registration per node *unless* SRAT is being used. With SRAT, MAXCHUNKS 
regions at most with is 4 * MAX_NUMNODES.

>>
>>> On my little x86 PC:
>>>
>>> BIOS-provided physical RAM map:
>>> BIOS-e820: 0000000000000000 - 000000000009bc00 (usable)
>>> BIOS-e820: 000000000009bc00 - 000000000009c000 (reserved)
>>> BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>>> BIOS-e820: 0000000000100000 - 000000000ffc0000 (usable)
>>> BIOS-e820: 000000000ffc0000 - 000000000fff8000 (ACPI data)
>>> BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
>>> BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>>> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>>> BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
>>> BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
>>> 0MB HIGHMEM available.
>>> 255MB LOWMEM available.
>>> found SMP MP-table at 000ff780
>>> Range (nid 0) 0 -> 65472, max 4
>>> On node 0 totalpages: 65472
>>>  DMA zone: 4096 pages, LIFO batch:0
>>>  Normal zone: 61376 pages, LIFO batch:15
>>>
>>> So here, the architecture code only called add_active_range() the once, for
>>> the entire memory map.
>>
>> Because in this case, the architecture reported that there was just one
>> range of available pages with no holes.
>
> So..  we're registering a simgle blob of pfns which includes the "reserved"
> memory as well as the "ACPI data" and the "ACPI NVS" (with an apparent
> off-by-one here).
>

The off-by-one is a surprise. On this machine, it must be because the 
arch-specific code calculated highend_pfn wrong. I don't use the e820 on 
i386 because it didn't seem necessary.

> How come the machine still works?  I guess the architecture went and marked
> those pfns reserved.
>

Yes, that is what I'd expect to happen. The ranges are registered and a 
memmap allocated but the freeing of memory from bootmem is still the same 
on i386. For i386, my patchset reports the same size of zones and 
start_pfn on each node so there should be no difference in the end result 
between my code and the arch-specific initialisation.

>>> If so, perhaps the bug is that the x86_64 code isn't doing that.  And that
>> > x86 isn't doing it for some people either.
>> >
>>
>>  I'm hoping in this case that having MAX_ACTIVE_REGIONS match E820MAX will
>>  fix the issue on your machine.
>
> I expect it will.
>
> One does wonder whether it's worth all this fuss though.  It's only a
> 24-byte structure and it's all thrown away in free_initmem().  One _could_
> just go and do
>
> 	#define MAX_ACTIVE_REGIONS 10000
>
> and be happy.
>

I could, but I thought I'd be shot for trying something like that. A fixed 
value of 128 would cover the largest tables I'm aware of on all 
architectures. Should I just set that fixed value?

>> I'm still confused why Christian's failed
>>  to boot with the patch backed out though.
>
> He didn't get any "Too many memory regions" messages, so it's something
> different.
>
> Maybe he hit my off-by-one on his "ACPI data"?
>

Possibly but the off-by-one error for you was on x86 not x86_64 and I 
suspect that highend_pfn was wrong in this case. I'll be checking tomorrow 
where I can see an off-by-one error.

> hm, I didn't mention this in the earlier email.   On my x86 I have
>
>  BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009bc00 (usable)
>  BIOS-e820: 000000000009bc00 - 000000000009c000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000000ffc0000 (usable)
>  BIOS-e820: 000000000ffc0000 - 000000000fff8000 (ACPI data)
>  BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
>  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
>
> I added some debug and saw that add_active_range() was getting a
> start_pfn=0 and an end_pfn which corresponds with 0x0fffc000.  So my "ACPI
> NVS" is getting chopped off.
>

Yes. However, this just means that the memory for that the PFN range will 
not be backed by memmap. This would only be a problem if free_bootmem() is 
called on those range of pages. If that was happening, I would be 
expecting oops early or bad_page reports during the boot process.

> If Christian is seeing a similar thing then his "ACPI data" will be getting
> only part-registered.
>
> I'd suggest that the next rev be liberal in its printking.  This is the
> debug patch I used:
>

I also have an old debug patch that was very printk happy. I will dust it 
off and add it with the additional information from your patch.

> mm/page_alloc.c |   25 +++++++++++++++++++++----
> 1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff -puN mm/page_alloc.c~a mm/page_alloc.c
> --- devel/mm/page_alloc.c~a	2006-05-20 13:19:58.000000000 -0700
> +++ devel-akpm/mm/page_alloc.c	2006-05-20 13:20:42.000000000 -0700
> @@ -2463,22 +2463,36 @@ void __init add_active_range(unsigned in
> 						unsigned long end_pfn)
> {
> 	unsigned int i;
> -	printk(KERN_DEBUG "Range (%d) %lu -> %lu\n", nid, start_pfn, end_pfn);
> +
> +	printk("Range (nid %d) %lu -> %lu, max %d\n",
> +			nid, start_pfn, end_pfn, MAX_ACTIVE_REGIONS - 1);
>
> 	/* Merge with existing active regions if possible */
> 	for (i = 0; early_node_map[i].end_pfn; i++) {
> -		if (early_node_map[i].nid != nid)
> +		printk("i=%d early_node_map[i].nid=%d "
> +				"early_node_map[i].start_pfn=%lu "
> +				"early_node_map[i].end_pfn=%lu",
> +			i, early_node_map[i].nid,
> +			early_node_map[i].start_pfn,
> +			early_node_map[i].end_pfn);
> +
> +		if (early_node_map[i].nid != nid) {
> +			printk(" continue 1\n");
> 			continue;
> +		}
>
> 		/* Skip if an existing region covers this new one */
> 		if (start_pfn >= early_node_map[i].start_pfn &&
> -				end_pfn <= early_node_map[i].end_pfn)
> +				end_pfn <= early_node_map[i].end_pfn) {
> +			printk(" return 1\n");
> 			return;
> +		}
>
> 		/* Merge forward if suitable */
> 		if (start_pfn <= early_node_map[i].end_pfn &&
> 				end_pfn > early_node_map[i].end_pfn) {
> 			early_node_map[i].end_pfn = end_pfn;
> +			printk(" return 2\n");
> 			return;
> 		}
>
> @@ -2486,13 +2500,16 @@ void __init add_active_range(unsigned in
> 		if (start_pfn < early_node_map[i].end_pfn &&
> 				end_pfn >= early_node_map[i].start_pfn) {
> 			early_node_map[i].start_pfn = start_pfn;
> +			printk(" return 3\n");
> 			return;
> 		}
> +		printk("\n");
> 	}
>
> 	/* Leave last entry NULL, we use range.end_pfn to terminate the walk */
> 	if (i >= MAX_ACTIVE_REGIONS - 1) {
> -		printk(KERN_ERR "Too many memory regions, truncating\n");
> +		printk(KERN_ERR "More than %d memory regions, truncating\n",
> +				MAX_ACTIVE_REGIONS - 1);
> 		return;
> 	}
>
> _
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
