Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWHaQYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWHaQYK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 12:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWHaQYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 12:24:09 -0400
Received: from mail-gw1.turkuamk.fi ([195.148.208.125]:30402 "EHLO
	mail-gw1.turkuamk.fi") by vger.kernel.org with ESMTP
	id S932361AbWHaQYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 12:24:06 -0400
Message-ID: <44F70D74.30807@kolumbus.fi>
Date: Thu, 31 Aug 2006 19:25:24 +0300
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Mel Gorman <mel@skynet.ie>
Cc: Keith Mannthey <kmannth@gmail.com>, akpm@osdl.org, tony.luck@intel.com,
       linux-mm@kvack.org, ak@suse.de, bob.picco@hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and free_area_init_nodes
References: <20060821134518.22179.46355.sendpatchset@skynet.skynet.ie> <20060821134638.22179.44471.sendpatchset@skynet.skynet.ie> <a762e240608301357n3915250bk8546dd340d5d4d77@mail.gmail.com> <20060831154903.GA7011@skynet.ie>
In-Reply-To: <20060831154903.GA7011@skynet.ie>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release
 6.5.4FP2 HF462|May 23, 2006) at 31.08.2006 19:23:45,
	Serialize by Router on marconi.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 31.08.2006 19:23:46,
	Serialize complete at 31.08.2006 19:23:46,
	Itemize by SMTP Server on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 31.08.2006 19:23:46,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 31.08.2006 19:24:04,
	Serialize complete at 31.08.2006 19:24:04
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>> static __init inline int srat_disabled(void)
>>> @@ -166,7 +167,7 @@ static int hotadd_enough_memory(struct b
>>>
>>>        if (mem < 0)
>>>                return 0;
>>> -       allowed = (end_pfn - e820_hole_size(0, end_pfn)) * PAGE_SIZE;
>>> +       allowed = (end_pfn - absent_pages_in_range(0, end_pfn)) * 
>>> PAGE_SIZE;
>>>        allowed = (allowed / 100) * hotadd_percent;
>>>        if (allocated + mem > allowed) {
>>>                unsigned long range;
>>> @@ -238,7 +239,7 @@ static int reserve_hotadd(int node, unsi
>>>        }
>>>
>>>        /* This check might be a bit too strict, but I'm keeping it for 
>>>        now. */
>>> -       if (e820_hole_size(s_pfn, e_pfn) != e_pfn - s_pfn) {
>>> +       if (absent_pages_in_range(s_pfn, e_pfn) != e_pfn - s_pfn) {
>>>                printk(KERN_ERR "SRAT: Hotplug area has existing 
>>>                memory\n");
>>>                return -1;
>>>        }
>>>       
>> We really do want to to compare against the e820 map at it contains
>> the memory that is really present (this info was blown away before
>> acpi_numa) 
>>     
>
> The information used by absent_pages_in_range() should match what was
> available to e820_hole_size().
>
>   
But it doesn't : all active ranges are removed before parsing srat. I 
think we really need to check against e820 here.

--Mika

