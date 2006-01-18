Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbWARTM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbWARTM3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 14:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbWARTM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 14:12:29 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:16114 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030371AbWARTM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 14:12:28 -0500
Message-ID: <43CE92E5.6030206@comcast.net>
Date: Wed, 18 Jan 2006 14:11:33 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>
CC: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Huge pages and small pages. . .
References: <43CD3CE4.3090300@comcast.net> <Pine.LNX.4.61.0601171358240.1682@chaos.analogic.com> <43CD481A.6040606@comcast.net> <43CE1A46.1020601@aitel.hist.no>
In-Reply-To: <43CE1A46.1020601@aitel.hist.no>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Helge Hafting wrote:
> John Richard Moser wrote:
> 
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>>
>>
>> linux-os (Dick Johnson) wrote:
>>  
>>
>>> On Tue, 17 Jan 2006, John Richard Moser wrote:
>>>
>>>
>>> Is there anything in the kernel that shifts the physical pages for 1024
>>> physically allocated and contiguous virtual pages together physically
>>> and remaps them as one huge page?  This would probably work well for the
>>>
>>>
>>>   
>>>
>>>> A page is something that is defined by the CPU. Perhaps you mean
>>>> "order"? When acquiring pages for DMA, they need to be contiguous if
>>>> you are going to access more than one page at a time. Therefore, one
>>>> can attempt to get two or more pages, i.e., the order or pages.
>>>>     
>>>> Since the CPU uses virtual memory always, there is no advantage to
>>>> having contiguous pages. You just map anything that's free into
>>>> what looks like contiguous memory and away you go.
>>>>     
>>
>>
>> Well, pages are typically 4KiB seen by the MMU.  If you fault across
>> them, you need to have them cached in the TLB; if the TLB runs out of
>> room, you invalidate entries; then when you hit entries not in the TLB,
>> the TLB has to searhc for the page mapping in the PTE chain.
>>
>> There are 4MiB pages, called "huge pages," that if you clump 1024
>> contiguous 4KiB pages together and draw a PTE entry up for can correlate
>> to a single TLB entry.  In this way, there's no page faulting until you
>> cross boundaries spaced 4MiB apart from eachother, and you use 1 TLB
>> entry where you would normally use 1024.
>>
>>  
>>
>>> low end of the heap, until someone figures out a way to tell the system
>>> to free intermittent pages in a big mapping (if the heap has an
>>> allocation up high, it can have huge, unused areas that are allocated).
>>>
>>>
>>>   
>>>
>>>> The actual allocation only occurs when an access happens. You can
>>>> allocate all the virtual memory in the machine and never use any
>>>> of it. When you allocate memory, the kernel just marks a promised
>>>> page 'not present'. When you attempt to access it, a page-fault
>>>> occurs and the kernel tries to find a free page to map into your
>>>> address space.
>>>>     
>>
>>
>> Yes.  The heap manager brk()s up the heap to allocate more space, all
>> mapped to the zero page; then the application writes to these pages,
>> causing them to be COW'd to real memory.  They will stay forever
>> allocated until the highest pages of the heap are unused by the program,
>> in which case the heap manager brk()s down the heap and frees them to
>> the system.
>>
>> Currently the heap manager can't seem to tell the system that a page
>> somewhere in the middle of the heap isn't really needed anymore, and can
>> be freed and mapped back to the zero page to await COW again.  So in
>> effect, you'll eventually wind out with a heap that's 20, 50, 100, or
>> 200 megs wide and probably all actually mapped to real, usable memory;
>> at this point, you can probably replace most of those entries with huge
>> pages to save on TLB entries and page faults.
>>  
>>
> This would be a nice performance win _if_ the program is
> actually using all those pages regularly. And I mean _all_.
> 
> The idea fails if we get any memory pressure, and some
> of the little-used pages gets swapped out.  You can't swap
> out part of a huge page, so you either have to break it up,
> or suffer the possibly large performance loss of having
> one megabyte less of virtual memory.   (That'll be even worse
> if several processes do this, of course.)
> 
>> When the program would try to free up "pages" in a huge page, the kernel
>> would have to recognize that the application is working in terms of 4KiB
>> small pages, and take appropriate action shattering the huge page back
>> into 1024 small pages first.
>>  
>>
> To see whether this is worthwile, I suggest instrumenting a kernel
> to detect:
> (1) When a process gets opportunity to have a huge page
>      (I.e. it has a sufficiently large and aligned memory block,
>       none of it is swapped, and rearranging into contigous
>       physical memory is possible.)
> (2) When a huge page would need to be broken up.
>      (I.e. parts of a previously identified huge page gets swapped
>       out, deallocated, shared, memprotected and so on.)
> 
> 
> Both of these detectors will be necessary anyway if automatic huge
> pages gets deployed.  In the meantime, you can check to see
> if such occations arise and for how long the huge pages remain
> viable. I believe the swapper will kill them fast once you have
> any memory pressure, and that fragmentation normally will prevent
> such pages from forming.  But I could be wrong of course.
> 

You're probably right.  On a system with optimum memory, this would be
optimal; aside from that it could get painful.

> For this to be fesible, the reduction in TLB misses would have to
> outweigh the initial cost of copying all that memory into a contigous
> region, the cost of shattering the mapping once the swapper gets
> aggressive, and of course the ongoing cost of identifying mergeable blocks.
> 
> Helge Hafting
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDzpLjhDd4aOud5P8RAmrAAJ0bTjc/SIrTSUECLIIEG8xCNjVnBACdF/N3
Cl/3+2m2nNm7IsGhJcFsWUs=
=Vrrl
-----END PGP SIGNATURE-----
