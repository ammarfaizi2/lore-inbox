Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVLJGBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVLJGBd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 01:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVLJGBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 01:01:33 -0500
Received: from smtpout.mac.com ([17.250.248.88]:55258 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932099AbVLJGBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 01:01:33 -0500
In-Reply-To: <Pine.LNX.4.61.0512092205540.29012@goblin.wat.veritas.com>
References: <r02010500-1043-55BAAD4668D211DA98840011248907EC@[10.64.61.57]> <1134148609.30856.22.camel@localhost> <E4ECF4F0-9442-4FFE-BE55-3EF7A1CC40F4@mac.com> <1134151696.3278.2.camel@localhost> <DB1A6A43-DA12-4C5B-B195-5C01DED4CF3E@mac.com> <Pine.LNX.4.61.0512092034510.28318@goblin.wat.veritas.com> <A699737E-EE3B-4521-B68C-F7D90C018CFB@mac.com> <Pine.LNX.4.61.0512092205540.29012@goblin.wat.veritas.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9F5D68CE-C9B6-43FD-B884-B273C96F43DD@mac.com>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Mark Rustad <mrustad@mac.com>
Subject: Re: [PATCH 2.6.15-rc5] hugetlb: make make_huge_pte global and fix coding style
Date: Sat, 10 Dec 2005 00:01:28 -0600
To: Hugh Dickins <hugh@veritas.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 9, 2005, at 4:12 PM, Hugh Dickins wrote:

> On Fri, 9 Dec 2005, Mark Rustad wrote:
>> On Dec 9, 2005, at 2:37 PM, Hugh Dickins wrote:
>>>
>>> You're not the only one to have trouble with recent remap_pfn_range
>>> changes.
>>> Would you let us know what you were doing, that you can no longer  
>>> do?
>>> Some of the change may need to be reverted.
>>
>> Well, our driver had been allocating two 320MB and one 128MB range  
>> of memory,
>> each of the three being contiguous. These were allocated by  
>> allocating lots of
>> 1MB groups of pages until we got a contiguous range, then the  
>> unneeded pages
>> were freed.
>
> I can understand that you might be dissatisfied with that.

Not dissatisfied really. It worked fine, not optimal of course, but  
it worked. Since change was forced by kernel changes, it made sense  
to try to do better while making it work again.

>> These areas were then mapped into the application with  
>> remap_pfn_range. We
>> have been running on a SuSE kernel derived from 2.6.5 for a long  
>> time where
>> this worked fine, even for gdb to access during debugging. Now  
>> that we are
>> moving to a more current kernel, changes were needed mainly to  
>> allow gdb to
>> access these shared memory areas.
>
> Okay, I think I get the picture.  2.6.15-rc5 would work if you used
> three adjacent mmaps, but that would involve changes to your driver  
> and
> to your userspace, so you thought better to do it another way anyway.

We had to change the remap_pfn_range though, because that was no  
longer usable if one wanted to be able to access the memory from gdb,  
which is a requirement for debugging. Also, all of our shared memory  
had been coming out of low memory - the change to hugepages now has  
lifted that restriction, which is also a much better place to be.

>> I had messed with simply taking the large memory by restricting  
>> the kernel's
>> memory range with mem=, but gdb still can't get to the pages  
>> because it
>> believes that they are for I/O (there would be no struct page in  
>> that case).
>>
>> Given the situation, using hugepages seemed more attractive  
>> anyway, so I just
>> decided to go that way and specify hugepages=192 on the kernel  
>> command line.
>>
>> We also have a single page shared between our processes and the  
>> driver, but we
>> now use the new insert_single_page call for that, which works  
>> nicely. It
>> seemed to me that calling that for the each of the single pages in  
>> our 768M of
>> shared memory was silly, so I went the hugepage route, and that  
>> proved to be
>> less trouble than I had expected. I feel like things now are  
>> really where they
>> should have been all along.
>
> Hmm.  Well, I share the doubts Dave and Adam have expressed.  Out- 
> of-tree
> drivers making up their own page tables are likely to break and be  
> broken,
> and the more so once you get into hugepages.  You'll be much more  
> portable
> from release to release if you stick with lots of vm_insert_pages,  
> silly
> as all that does seem, yes.  Sorry, I don't have a better answer to  
> hand.

Well, portability is less important than maintainability. I think  
being able to call make_huge_pte likely makes what I'm doing somewhat  
more maintainable than duplicating the code locally. I would prefer  
an explicit call to do the mapping, but I don't really expect that  
there are very many things doing memory mapping on this scale, so I  
have not submitted a patch to implement that. I am also not very  
confident in my understanding of this area of the kernel to think  
that I could provide an adequate patch, even though the code that I  
have is working for our application.

Do you foresee problems in using the make_huge_pte function? I am  
also calling alloc_huge_page, free_huge_page, huge_pte_alloc,  
set_huge_pte_at and pte_none in my code. I only had to change  
make_huge_pte in order to be able to call it - the other functions  
were already callable. Note that in my case, the driver is built into  
the kernel - it is not a module. My patch for changing make_huge_pte  
does not export that symbol from the kernel for use by modules.

-- 
Mark Rustad, MRustad@mac.com

