Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWHBPh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWHBPh4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 11:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWHBPh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 11:37:56 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:53521 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751220AbWHBPhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 11:37:55 -0400
Message-ID: <44D0C671.7040709@shadowen.org>
Date: Wed, 02 Aug 2006 16:36:17 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: moreau francis <francis_moreau2000@yahoo.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Re : sparsemem usage
References: <20060802151233.46707.qmail@web25801.mail.ukl.yahoo.com>
In-Reply-To: <20060802151233.46707.qmail@web25801.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moreau francis wrote:
> Andy Whitcroft wrote:
>> The memory allocator buddy location algorithm has an implicit assumption 
>> that the memory map will be contigious and valid out to MAX_ORDER.  ie 
>> that we can do relative arithmetic on a page* for a page to find its 
>> buddy at all times.  The allocator never looks outside a MAX_ORDER 
>> block, aligned to MAX_ORDER in physical pages.  SPARSEMEM's 
>> implementation by it nature breaks up the mem_map at the section size. 
>> Thus for the buddy to work a section must be >= MAX_ORDER in size to 
>> maintain the contiguity constraint.
> 
> thanks for the explanation. But still something I'm missing, how can a
> MAX_ORDER block be allocated in a memory whose size is only 128Ko ?
> Can't it be detected by the buddy allocatorvery early without doing any 
> relative arithmetic on a page* ?

When allocating we do not have a problem as we simply pull a free page 
off the appropriately sizes free list.  Its when freeing we have an 
issue, all the allocator has to work with is the page you are freeing. 
As MAX_ORDER is >128K we can get to the situation where all but one page 
is free.  When we free that page we then need to merge this 128Kb page 
with its buddy if its free.   To tell if that one is free it has to look 
at the page* for it, so that page* must also exist for this check to work.

>> However, just because you have a small memory block in your memory map 
>> doesn't mean that the sparsemem section size needs to be that small to 
>> match.  If there is any valid memory in any section that section will be 
>> instantiated and the valid memory marked within it, any invalid memory 
>> is marked reserved.  
> 
> ah ok but that means that pfn_valid() will still returns ok for invalid page which
> are in a invalid memory marked as reserved. Is it not risky ?

pfn_valid() will indeed say 'ok'.  But that is defined only to mean that 
it is safe to look at the page* for that page.  It says nothing else 
about the page itself.  Pages which are reserved never get freed into 
the allocator so they are not there to be allocated so we should not be 
refering to them.

>> The section size bounds the amount of internal 
>> fragmentation we can have in the mem_map.  SPARSEMEM as its name 
>> suggests wins biggest when memory is very sparsly populate. 
> 
> sorry but I don't understand. I would say that sparsemem section size should
> be chosen to make mem_map[] and mem_section[] sizes as small as possible.

There are tradeoffs here.  The smaller the section size the better the 
internal fragmentation will be.  However also the more of them there 
will be, the more space that will be used tracking them, the more 
cachelines touched with them.  Also as we have seen we can't have things 
in the allocator bigger than the section size.  This can constrain the 
lower bound on the section size.  Finally, on 32 bit systems the overall 
number of sections is bounded by the available space in the fields 
section of the page* flags field.

If your system has 256 1Gb sections and 1 128Kb section then it could 
well make sense to have a 1GB section size or perhaps a 256Mb section 
size as you are only wasting space in the last section.

> 
>> If I am 
>> reading correctly your memory is actually contigious.
> 
> well there're big holes in address space.
> 

I read that as saying there was a major gap to 3Gb and then it was 
contigious from there; but then I was guessing at the units :).

-apw
