Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWAQTlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWAQTlA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWAQTlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:41:00 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:15048 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932261AbWAQTk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:40:59 -0500
Message-ID: <43CD481A.6040606@comcast.net>
Date: Tue, 17 Jan 2006 14:40:10 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Huge pages and small pages. . .
References: <43CD3CE4.3090300@comcast.net> <Pine.LNX.4.61.0601171358240.1682@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0601171358240.1682@chaos.analogic.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



linux-os (Dick Johnson) wrote:
> On Tue, 17 Jan 2006, John Richard Moser wrote:
> 
> 
> Is there anything in the kernel that shifts the physical pages for 1024
> physically allocated and contiguous virtual pages together physically
> and remaps them as one huge page?  This would probably work well for the
> 
> 
>> A page is something that is defined by the CPU. Perhaps you mean
>> "order"? When acquiring pages for DMA, they need to be contiguous if
>> you are going to access more than one page at a time. Therefore, one
>> can attempt to get two or more pages, i.e., the order or pages.
> 
>> Since the CPU uses virtual memory always, there is no advantage to
>> having contiguous pages. You just map anything that's free into
>> what looks like contiguous memory and away you go.
> 

Well, pages are typically 4KiB seen by the MMU.  If you fault across
them, you need to have them cached in the TLB; if the TLB runs out of
room, you invalidate entries; then when you hit entries not in the TLB,
the TLB has to searhc for the page mapping in the PTE chain.

There are 4MiB pages, called "huge pages," that if you clump 1024
contiguous 4KiB pages together and draw a PTE entry up for can correlate
to a single TLB entry.  In this way, there's no page faulting until you
cross boundaries spaced 4MiB apart from eachother, and you use 1 TLB
entry where you would normally use 1024.

> 
> low end of the heap, until someone figures out a way to tell the system
> to free intermittent pages in a big mapping (if the heap has an
> allocation up high, it can have huge, unused areas that are allocated).
> 
> 
>> The actual allocation only occurs when an access happens. You can
>> allocate all the virtual memory in the machine and never use any
>> of it. When you allocate memory, the kernel just marks a promised
>> page 'not present'. When you attempt to access it, a page-fault
>> occurs and the kernel tries to find a free page to map into your
>> address space.
> 

Yes.  The heap manager brk()s up the heap to allocate more space, all
mapped to the zero page; then the application writes to these pages,
causing them to be COW'd to real memory.  They will stay forever
allocated until the highest pages of the heap are unused by the program,
in which case the heap manager brk()s down the heap and frees them to
the system.

Currently the heap manager can't seem to tell the system that a page
somewhere in the middle of the heap isn't really needed anymore, and can
be freed and mapped back to the zero page to await COW again.  So in
effect, you'll eventually wind out with a heap that's 20, 50, 100, or
200 megs wide and probably all actually mapped to real, usable memory;
at this point, you can probably replace most of those entries with huge
pages to save on TLB entries and page faults.

When the program would try to free up "pages" in a huge page, the kernel
would have to recognize that the application is working in terms of 4KiB
small pages, and take appropriate action shattering the huge page back
into 1024 small pages first.

> 
> It may possibly work for disk cache as well, albeit I can't say for
> sure if it's common to have a 4 meg contiguous section of program data
> loaded.
> 
> 
> 
>> But it __is__ contiguous as far as the program is concerned.

It's a contiguous set of 1024 PTE entries the MMU has to juggle around
in a TLB that can handle 256 entries at once.

>> The only time you need physically contiguous pages is when a
>> DMA operation occurs that crosses page boundaries. Otherwise,
>> it's a waste of time and CPU resources trying to make
>> something contiguous. Also, modern DMA engines use scatter-
>> lists so one can DMA to pages scattered all over the address-
>> space in one operation. In this case, you just build a list of
>> pages. You don't care where they physically reside, although you
>> do need to tell the DMA engine their correct locations.
> 
>> Now there are some M$Garbage "high-memory" so-called enhancements
>> that, using page-registers, "map" more that 4 GB of memory into
>> the 4 GB address space. This is like the garbage that M$ created
>> to use "high memory" for DOS. Use of this kind of hardware-hack
>> is not relevant to the discussion about virtual memory.
> 
> 
> Shifting odd huge allocations around would be neat to, re:
> 
> {2m}[4M  ]{2m}  ->  [4M  ][4M  ]
> 
> --
> All content of all messages exchanged herein are left in the
> Public Domain, unless otherwise explicitly stated.
> 
>    Creative brains are a valuable, limited resource. They shouldn't be
>    wasted on re-inventing the wheel when there are so many fascinating
>    new problems waiting out there.
>                                                 -- Eric Steven Raymond
- -
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.13.4 on an i686 machine (5589.54 BogoMips).
> Warning : 98.36% of all statistics are fiction.
> .

> ****************************************************************
> The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

> Thank you.


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

iD8DBQFDzUgZhDd4aOud5P8RApgqAJ0T0tzanihdjbNou034+NoQ1TNfUgCgiWA/
pxFhbWnoVf3ltyGra0o+B5w=
=UqUX
-----END PGP SIGNATURE-----
