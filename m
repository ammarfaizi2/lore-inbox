Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWGGH40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWGGH40 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 03:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWGGH40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 03:56:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:29290 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750972AbWGGH4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 03:56:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=NA3OptD7sRKnxVYdF81dA5s+WuuCDFKuebGhrVv3u/90b8j6oYWCxM5sqnHlBSxBwjkGWdLkRmK1CbBYR1sxWgVfiEmFaqstir2eJg59SR73fEaLJ05NVLsKptH40+q6fXRoLEPyru5610eASEvfl0qJOIbkzHIaV5r3E6TYaNE=
Message-ID: <44AE14C7.1070806@innova-card.com>
Date: Fri, 07 Jul 2006 10:01:11 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mel Gorman <mel@skynet.ie>
CC: Franck Bui-Huu <vagabon.xyz@gmail.com>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Only use ARCH_PFN_OFFSET once during boot
References: <20060706095103.31772.49822.sendpatchset@skynet.skynet.ie> <44AD1F90.10103@innova-card.com> <Pine.LNX.4.64.0607061556470.3895@skynet.skynet.ie> <cda58cb80607061101l4698f1afr799e9814688903cf@mail.gmail.com> <20060706195558.GA13225@skynet.ie>
In-Reply-To: <20060706195558.GA13225@skynet.ie>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:
> On Thu, 6 Jul 2006, Franck Bui-Huu wrote:
> 
>> 2006/7/6, Mel Gorman <mel@csn.ul.ie>:
>>> I think my patch does the job of moving ARCH_PFN_OFFSET out of the hot
>>> path in a less risky fashion. However, if you are sure that callers to
>>> free_area_init() and ARCH_PFN_OFFSET are ok after your patch, I'd be happy
>>> to go with it. If you're not sure, I reckon my patch would be the way to
>>> go.
>>>
>> Ok I try to explain better what I have in mind. Your patch changes the
>> behaviour of free_area_init_node() in the sense that it doesn't work
>> as expected if its fourth parameter is different from ARCH_PFN_OFFSET,
>> it even becomes boggus IMHO. And I think it's valid to use it when
>> FLATMEM model is selected.
> 
> I'm missing something silly here.
> 
> Before the patch, we have the following
>   o Call free_area_initSOMETHING()
>   o Set mem_map to NODE_DATA(0)->node_mem_map
>   o At each call to page_to_pfn() or pfn_to_page(), offset mem_map by 
>     ARCH_PFN_OFFSET
> 
> After the patch, we have
> 
>   o Call free_area_initSOMETHING()
>   o Set mem_map to NODE_DATA(0)->node_mem_map - ARCH_PFN_OFFSET
>   o At each call to page_to_pfn() or pfn_to_page(), use mem_map without 
>     any additional offset
> 
> I don't see how free_area_init_node() changed except for callers 
> using mem_map directly.
> 

you're right the behaviour is the same with the old code and with your
patch that is:

If CONFIG_FLATMEM then free_area_init_node must be called:

free_area_init_node(..., ..., ..., ARCH_PFN_OFFSET, ...);

And it's quite dangerous because a user of this function must know the
implementation of pfn_to_page() or alloc_node_mem_map() to know that.

Therefore, what I proposed was to let free_area_init_node() work as
expected, so whatever the value of ARCH_PFN_OFFSET, this use

free_area_init_node(..., ..., ..., whatever, ...);

will define the start of mem as 'whatever' value. And if the user
wants to use the default start mem value then he can do both:

free_area_init_node(..., ..., ..., ARCH_PFN_OFFSET, ...);

or (equivalent):

free_area_init(...);

> ....
> 
> using mem_map directly. uh uh
> 
> Both of our patches are broken.
> 
> page_to_pfn() and pfn_to_page() both need ARCH_PFN_OFFSET to get PFNs,
> that's fine. However, I forgot that another assumption of the FLATMEM memory
> model is that mem_map[0] is the first valid struct page in the system. A

I would say that the first valid struct page in the system is

mem_map[PFN_UP(__pa(PAGE_OFFSET))] == mem_map[ARCH_PFN_OFFSET]

> number of architectures walk mem_map[] directly (cris and frv are examples)
> without offsetting based on this assumption.
> 

but they do have ARCH_PFN_OFFSET = 0, no ?

Walking mem_map[] directly should be avoid. 

If the mem start is different from 0 and ARCH_PFN_OFFSET is not set
then all patches are correct and mem_map[0] is valid.

But if the user set ARCH_PFN_OFFSET != 0, he tells to the system that
the start of memory is not 0, and mem_map[0] is now forbidden since no
page exist in this area. BTW the problem exists with the old code, if
the user do pfn_to_page(0), he will get an invalid page pointer.

		Franck
