Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWHaRjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWHaRjb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 13:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWHaRja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 13:39:30 -0400
Received: from mail-gw1.turkuamk.fi ([195.148.208.125]:31434 "EHLO
	mail-gw1.turkuamk.fi") by vger.kernel.org with ESMTP
	id S932401AbWHaRj3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 13:39:29 -0400
Message-ID: <44F71F2B.2010406@kolumbus.fi>
Date: Thu, 31 Aug 2006 20:40:59 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
Cc: Keith Mannthey <kmannth@gmail.com>, akpm@osdl.org, tony.luck@intel.com,
       Linux Memory Management List <linux-mm@kvack.org>, ak@suse.de,
       bob.picco@hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and free_area_init_nodes
References: <20060821134518.22179.46355.sendpatchset@skynet.skynet.ie> <20060821134638.22179.44471.sendpatchset@skynet.skynet.ie> <a762e240608301357n3915250bk8546dd340d5d4d77@mail.gmail.com> <20060831154903.GA7011@skynet.ie> <44F70D74.30807@kolumbus.fi> <Pine.LNX.4.64.0608311749030.13392@skynet.skynet.ie>
In-Reply-To: <Pine.LNX.4.64.0608311749030.13392@skynet.skynet.ie>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release
 6.5.4FP2 HF462|May 23, 2006) at 31.08.2006 20:39:20,
	Serialize by Router on marconi.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 31.08.2006 20:39:21,
	Itemize by SMTP Server on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 31.08.2006 20:39:21,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 31.08.2006 20:39:27,
	Serialize complete at 31.08.2006 20:39:27
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:
> On Thu, 31 Aug 2006, Mika Penttilä wrote:
>
>>
>>>>> static __init inline int srat_disabled(void)
>>>>> @@ -166,7 +167,7 @@ static int hotadd_enough_memory(struct b
>>>>>
>>>>>        if (mem < 0)
>>>>>                return 0;
>>>>> -       allowed = (end_pfn - e820_hole_size(0, end_pfn)) * PAGE_SIZE;
>>>>> +       allowed = (end_pfn - absent_pages_in_range(0, end_pfn)) * 
>>>>> PAGE_SIZE;
>>>>>        allowed = (allowed / 100) * hotadd_percent;
>>>>>        if (allocated + mem > allowed) {
>>>>>                unsigned long range;
>>>>> @@ -238,7 +239,7 @@ static int reserve_hotadd(int node, unsi
>>>>>        }
>>>>>
>>>>>        /* This check might be a bit too strict, but I'm keeping it 
>>>>> for now. */
>>>>> -       if (e820_hole_size(s_pfn, e_pfn) != e_pfn - s_pfn) {
>>>>> +       if (absent_pages_in_range(s_pfn, e_pfn) != e_pfn - s_pfn) {
>>>>>                printk(KERN_ERR "SRAT: Hotplug area has existing 
>>>>> memory\n");
>>>>>                return -1;
>>>>>        }
>>>>>
>>>> We really do want to to compare against the e820 map at it contains
>>>> the memory that is really present (this info was blown away before
>>>> acpi_numa) 
>>>
>>> The information used by absent_pages_in_range() should match what was
>>> available to e820_hole_size().
>>>
>>>
>> But it doesn't : all active ranges are removed before parsing srat. I 
>> think we really need to check against e820 here.
>>
>
> What I see happening is this;
>
> 1. setup_arch calls e820_register_active_regions(0, 0, -1UL) so that all
>    regions are registered as if they were on node 0 so e820_end_of_ram()
>    gets the right value
> 2. remove_all_active_regions() is called to clear what was registered so
>    that rediscovery with NUMA awareness happens
> 3. acpi_numa_init() is called. It parses the table and a little later
>    calls acpi_numa_memory_affinity_init() for each range in the table so
>    now we're into x86_64 code
> 4. acpi_numa_memory_affinity_init() basically deals an address range.
>    Assuming the SRAT table is not broken, it calls
>    e820_register_active_ranges() for that range. At this point, for the
>    range of addresses, the active ranges are now registered
> 5. reserve_hotadd is called if the range is hotpluggable. It will fail if
>    it finds that memory already exists there
>
> So, when absent_pages_in_range() is being called by reserve_hotadd(), 
> it should be using the same information that was available in e820. 
> What am I missing?
>
Ok, right, missed the e820_register_active_ranges() in 
acpi_numa_memory_affinity_init() before reserve_hotadd stuff. So 
logically it should be working mod bugs.

Argh, just looked through the reserve hotadd code and 
hotadd_enough_memory() looks still broken. And why are we doing 
reserve_bootmem_node(), the regions aren't present RAM anyways?

--Mika

