Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWHCNP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWHCNP1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 09:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWHCNP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 09:15:27 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:12550 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932277AbWHCNP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 09:15:26 -0400
Message-ID: <44D1F688.2030806@shadowen.org>
Date: Thu, 03 Aug 2006 14:13:44 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: moreau francis <francis_moreau2000@yahoo.fr>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Re : Re : Re : sparsemem usage
References: <20060803124628.21540.qmail@web25805.mail.ukl.yahoo.com>
In-Reply-To: <20060803124628.21540.qmail@web25805.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moreau francis wrote:
> Andy Whitcroft wrote:
>> That would be incorrect usage.  pfn_valid() simply doesn't tell you if 
>> you have memory backing a pfn, it mearly means you can interrogate the 
>> page* for it.  A good example of code which counts pages in a region is 
>> in count_highmem_pages() which has a form as below:
>>
>>             for (pfn = start; pfn < end; pfn++) {
>>                   if (!pfn_valid(pfn))
>>                                          continue;
>>                                  page = pfn_to_page(pfn);
>>                                  if (PageReserved(page))
>>                                          continue;
>>                 num_physpages++;
>>             }
>>
> num_physpages would still not give the right total number of pages in the
> system. It will report a value smaller than the size of all memories which can
> be suprising, depending on how it is used. In my mind I thought that it should
> store the number of all pages in the system (reserved + free + ...).
> 
> Futhermore for flatmem model, my example that count the number of physical
> pages is valid: reserved pages are really pages that are in used by the kernel.
> But it's not valid anymore for sparsemem model. For consistency and code
> sharing, I would make the same meaning of pfn_valid() and PageReserved() for
> both models.

The semantics and meaning of both pfn_valid() and PageReserved() are the 
same in all three memory models, just not what you need them to be for 
your pfn_valid() loop to tell you how many real frames there are.
I do not believe it is correct to say that your loop would give you the 
number of physical pages under FLATMEM.  If there are any gaps at all 
(such as there is for IO space just below 1MB) that will pass 
pfn_valid(), and yet does _not_ have any real memory associated with it.
With FLATMEM you will get pfn_valid() passing on non-memory pages.

I have to re-iterate pfn_valid() does not mean pfn_valid_memory(), it 
means pfn_valid_memmap().  If you want to know if a page is valid and 
memory (at least on x86) you could use:

	if (pfn_valid(pfn) && page_is_ram(pfn)) {
	}

It is rare you care how many real page frames there are in the system. 
You are more interested in how many usable frames there are.  Such as 
for use in sizing hashes or caches.  The reserved pages should be 
excluded in this calculation.  ACPI pages, BIOS pages and the like 
simply are no interest.

I don't see anywhere in the kernel using that construct to work out how 
many pages there are in the system.  Mostly we have architectual 
information to tell us what real physical pages exist in the system such 
as the srat or e820 etc.  If we really care about real page counts at 
that accuracy we have those to refer to.

Do you have a usage model in which we really care about the number of 
pages in the system to that level of accuracy?

-apw
