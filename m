Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbWFZI06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWFZI06 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 04:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbWFZI06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 04:26:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:1892 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964923AbWFZI05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 04:26:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=UZeSmOXSmXCPuW0rBihZQl+2456W2mm4MiceYBn4HF+1h+FRX0cKU4/P9F4CRFrY4u5MZ5Kx4LW8qbmqmjErLcldzS/9l3T1jfyIIN+czNDrdpSziOoxLa5YVu6fSMlHhGa7IEUICOTcnoSjv8FrDjMjC/WX//uRI5pwwK5lo78=
Message-ID: <449F9B4C.6000404@innova-card.com>
Date: Mon, 26 Jun 2006 10:31:08 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: Franck <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm1
References: <20060621034857.35cfe36f.akpm@osdl.org> <449AB01A.5000608@innova-card.com> <Pine.LNX.4.64.0606221617420.5869@skynet.skynet.ie> <449ABC3E.5070609@innova-card.com> <Pine.LNX.4.64.0606221649070.5869@skynet.skynet.ie> <cda58cb80606221025y63906e81wbec9597b94069b6a@mail.gmail.com> <20060623102037.GA1973@skynet.ie> <449BDCF5.6040808@innova-card.com> <20060623134634.GA6071@skynet.ie> <449C036D.6060004@innova-card.com> <20060623151322.GA13130@skynet.ie> <449C0DF3.601@innova-card.com> <Pine.LNX.4.64.0606231728040.13746@skynet.skynet.ie>
In-Reply-To: <Pine.LNX.4.64.0606231728040.13746@skynet.skynet.ie>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <fbh.work@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel

Mel Gorman wrote:
> On Fri, 23 Jun 2006, Franck Bui-Huu wrote:
> 

[snip]

>>
>> -unsigned long __init init_bootmem (unsigned long start, unsigned long
>> pages)
>> +unsigned long __init init_bootmem(unsigned long start, unsigned long
>> pages)
>> {
>>     max_low_pfn = pages;
>>     min_low_pfn = start;
>> -    return(init_bootmem_core(NODE_DATA(0), start, 0, pages));
>> +    return init_bootmem_core(NODE_DATA(0), start, ARCH_PFN_OFFSET,
>> pages);
>> }
>>
> 
> Not all arches will use init_bootmem(). Arm for example uses
> init_bootmem_node(). ARCH_PFN_OFFSET is only meant to affect mem_map,

well, I don't agree here. ARCH_PFN_OFFSET is used to save the first
page number that has physical memory. I don't see why we couldn't use
it to correctly initialise the memory system...

If we don't change init_bootmem() to use ARCH_PFN_OFFSET, then the
kernel will initialise the start of memory to 0 which is boggus. IOW,
we can't use this function without this change (except if your memory
start at 0 of course). And I think that init_bootmem() has been
implemented for systems which have only one node _whatever_ memory
start value...

>> #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c

[snip]

>> @@ -2174,8 +2181,7 @@ #endif
>>
>> void __init free_area_init(unsigned long *zones_size)
>> {
>> -    free_area_init_node(0, NODE_DATA(0), zones_size,
>> -            __pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
>> +    free_area_init_node(0, NODE_DATA(0), zones_size, ARCH_PFN_OFFSET,
>> NULL);
>> }
>>
> 
> Same comment applies as for init_bootmem(). I can't be sure it's a good
> idea.
> 

same comment as for init_bootmem()


		Franck
