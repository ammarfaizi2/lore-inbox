Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWARKcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWARKcN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 05:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWARKcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 05:32:13 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:49579 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932414AbWARKcM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 05:32:12 -0500
Message-ID: <43CE1A46.1020601@aitel.hist.no>
Date: Wed, 18 Jan 2006 11:36:54 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Huge pages and small pages. . .
References: <43CD3CE4.3090300@comcast.net> <Pine.LNX.4.61.0601171358240.1682@chaos.analogic.com> <43CD481A.6040606@comcast.net>
In-Reply-To: <43CD481A.6040606@comcast.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>
>
>linux-os (Dick Johnson) wrote:
>  
>
>>On Tue, 17 Jan 2006, John Richard Moser wrote:
>>
>>
>>Is there anything in the kernel that shifts the physical pages for 1024
>>physically allocated and contiguous virtual pages together physically
>>and remaps them as one huge page?  This would probably work well for the
>>
>>
>>    
>>
>>>A page is something that is defined by the CPU. Perhaps you mean
>>>"order"? When acquiring pages for DMA, they need to be contiguous if
>>>you are going to access more than one page at a time. Therefore, one
>>>can attempt to get two or more pages, i.e., the order or pages.
>>>      
>>>
>>>Since the CPU uses virtual memory always, there is no advantage to
>>>having contiguous pages. You just map anything that's free into
>>>what looks like contiguous memory and away you go.
>>>      
>>>
>
>Well, pages are typically 4KiB seen by the MMU.  If you fault across
>them, you need to have them cached in the TLB; if the TLB runs out of
>room, you invalidate entries; then when you hit entries not in the TLB,
>the TLB has to searhc for the page mapping in the PTE chain.
>
>There are 4MiB pages, called "huge pages," that if you clump 1024
>contiguous 4KiB pages together and draw a PTE entry up for can correlate
>to a single TLB entry.  In this way, there's no page faulting until you
>cross boundaries spaced 4MiB apart from eachother, and you use 1 TLB
>entry where you would normally use 1024.
>
>  
>
>>low end of the heap, until someone figures out a way to tell the system
>>to free intermittent pages in a big mapping (if the heap has an
>>allocation up high, it can have huge, unused areas that are allocated).
>>
>>
>>    
>>
>>>The actual allocation only occurs when an access happens. You can
>>>allocate all the virtual memory in the machine and never use any
>>>of it. When you allocate memory, the kernel just marks a promised
>>>page 'not present'. When you attempt to access it, a page-fault
>>>occurs and the kernel tries to find a free page to map into your
>>>address space.
>>>      
>>>
>
>Yes.  The heap manager brk()s up the heap to allocate more space, all
>mapped to the zero page; then the application writes to these pages,
>causing them to be COW'd to real memory.  They will stay forever
>allocated until the highest pages of the heap are unused by the program,
>in which case the heap manager brk()s down the heap and frees them to
>the system.
>
>Currently the heap manager can't seem to tell the system that a page
>somewhere in the middle of the heap isn't really needed anymore, and can
>be freed and mapped back to the zero page to await COW again.  So in
>effect, you'll eventually wind out with a heap that's 20, 50, 100, or
>200 megs wide and probably all actually mapped to real, usable memory;
>at this point, you can probably replace most of those entries with huge
>pages to save on TLB entries and page faults.
>  
>
This would be a nice performance win _if_ the program is
actually using all those pages regularly. And I mean _all_.

The idea fails if we get any memory pressure, and some
of the little-used pages gets swapped out.  You can't swap
out part of a huge page, so you either have to break it up,
or suffer the possibly large performance loss of having
one megabyte less of virtual memory.   (That'll be even worse
if several processes do this, of course.)

>When the program would try to free up "pages" in a huge page, the kernel
>would have to recognize that the application is working in terms of 4KiB
>small pages, and take appropriate action shattering the huge page back
>into 1024 small pages first.
>  
>
To see whether this is worthwile, I suggest instrumenting a kernel
to detect:
(1) When a process gets opportunity to have a huge page
      (I.e. it has a sufficiently large and aligned memory block,
       none of it is swapped, and rearranging into contigous
       physical memory is possible.)
(2) When a huge page would need to be broken up.
      (I.e. parts of a previously identified huge page gets swapped
       out, deallocated, shared, memprotected and so on.)


Both of these detectors will be necessary anyway if automatic huge
pages gets deployed.  In the meantime, you can check to see
if such occations arise and for how long the huge pages remain
viable. I believe the swapper will kill them fast once you have
any memory pressure, and that fragmentation normally will prevent
such pages from forming.  But I could be wrong of course.

For this to be fesible, the reduction in TLB misses would have to
outweigh the initial cost of copying all that memory into a contigous
region, the cost of shattering the mapping once the swapper gets
aggressive, and of course the ongoing cost of identifying mergeable blocks.

Helge Hafting
