Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129677AbQJ0AtW>; Thu, 26 Oct 2000 20:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130101AbQJ0AtM>; Thu, 26 Oct 2000 20:49:12 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:3593 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129677AbQJ0AtB>;
	Thu, 26 Oct 2000 20:49:01 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200010270048.e9R0mie220290@saturn.cs.uml.edu>
Subject: Re: Topic for discussion: OS Design
To: root@chaos.analogic.com
Date: Thu, 26 Oct 2000 20:48:44 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        dlitz@dlitz.net (Dwayne C . Litzenberger),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1001026083116.10279A-100000@chaos.analogic.com> from "Richard B. Johnson" at Oct 26, 2000 09:17:49 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson writes:
> On Thu, 26 Oct 2000, Albert D. Cahalan wrote:
>> Richard B. Johnson writes:

>>> o	Once installed, a kernel module is every bit as "efficient"
>>> as some driver linked into the kernel at build-time. Of course
>>
>> I doubt this is true on most modern processors. On the Pentium
>> and above, large pages are used for the kernel. The PowerPC port
>             ^^^^^^^^^^^
>
> The page-size is determined by the architecture.

The page sizes are determined by the architecture.

For common Intel chips: 4 kB, 2 MB, 4 MB.
(some restrictions may apply -- Ingo Molnar would know)

For ia64, you get about a dozen different sizes ranging from
the old 4 kB pages up to something like 256 MB.

For the PowerPC you have BAT registers that override page tables.
You get 4 for code and 4 for data, so you can map all physical
memory for the kernel w/o using page table entries or TLB slots.

The SPARC code, if I recall correctly, does not maintain page
tables for normal kernel code. If the virtual address is within
the direct mapped region, a software TLB loader just adds an
offset to get the physical address.

So your modules suffer by being unable to take advantage of
more efficent virtual-to-physical mapping mechanisms.

>> uses BAT registers. Other ports have other hacks to reduce TLB
>> misses and/or wasted memory. Also, you waste half a page or more
>> for the average module.
> 
> Since kernel memory is allocated in pages, you use whatever you
> need. If a module is 4097 bytes in length, you could, in principle,
> 'waste' 4095 bytes. So what? it's never paged or otherwise producing
> any overhead whatsoever.

What, wasted memory is not overhead?

Also, consider the cache effects. To keep things simple, assume
you have a highly modular kernel and that modules are 2 kB.
Also, you have separate 4-way 16 kB L1 caches for code and data.
Well, you now have an 8 kB cache for code, along with 8 kB of
useless transistors.

Of course this is bad, even if you don't have modules that are
exactly 2 kB.

> These are modules I have written for a project. Since these are object
> files, they contain not only code, but also a relocation table. So they
> don't require as much memory as the file size shows. However, since
> these are all modules, the relocation table is similar in size and
> can be considered a constant.
> 
>          6204 Oct 24 10:48 firewire.o    8192 -  6204 = 1988
>         11120 Oct 24 10:48 gpib_drvr.o  12288 - 11120 = 1168
>          6692 Oct 24 10:48 ramdisk.o     8192 -  6692 = 1500
>          3886 Oct 24 10:48 rtc_drvr.o    4096 -  3886 =  210
>          6776 Oct 25 12:38 vxibus.o      8192 -  6776 = 1416
> Totals                                          ----    ----
>                                                34678    6282
> 
> This shows that out of 34,678 bytes we needed, we wasted 6282, ~1.5
> pages. Since there are 5 modules, we waste about 1/3 page per module.
> 
> So I don't, as you say; "... waste 1/2 page or more per module".

Somebody else posted their numbers: you waste about 15% of memory.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
