Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268938AbRHBXn3>; Thu, 2 Aug 2001 19:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269211AbRHBXnU>; Thu, 2 Aug 2001 19:43:20 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:54029 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S268938AbRHBXnM>; Thu, 2 Aug 2001 19:43:12 -0400
Message-ID: <011601c11bad$51314480$bef7020a@mammon>
From: "Jeremy Linton" <jlinton@interactivesi.com>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108021508310.21298-100000@heat.gghcwest.com>
Subject: Re: Ongoing 2.4 VM suckage pagemap_lru_lock
Date: Thu, 2 Aug 2001 18:46:02 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm telling you that's not what happens.  When memory pressure gets really
> high, the kernel takes all the CPU time and the box is completely useless.
> Maybe the VM sorts itself out but after five minutes of barely responding,
> I usually just power cycle the damn thing.  As I said, this isn't a
> classic thrash because the swap disks only blip perhaps once every ten
> seconds!
>
> You don't have to go to extremes to observe this behavior.  Yesterday, I
> had one box where kswapd used 100% of one CPU for 70 minutes straight,
> while user process all ran on the other CPU.  All RAM and half swap was
> used, and I/O was heavy.  The machine had been up for 14 days.  I just
> don't understand why kswapd needs to run and run and run and run and run

    Actually, this sounds very similar to a problem I see on a somewhat
regular basis with a very memory hungry module running in the machine.
Basically the module eats up about a quarter of system memory. Then a user
space process comes along and uses a big virtual area (about 1.2x the total
physical memory in the box). If the user space process starts to write to a
lot of the virtual memory it owns, then the box basically slows down to the
point where it appears to have locked up, disk activity goes to 1 blip every
few seconds. On the other hand if the user process is doing mostly read
accesses to the memory space then everything is fine.

    I can't even break into gdb when the box is 'locked up' but before it
locks up I notice that there is massive contention for the pagemap_lru_lock
(been running a hand rolled kernel lock profiler) from two different
places... Take a look at these stack dumps.

Kswapd is in page_launder.......
#0  page_launder (gfp_mask=4, user=0) at vmscan.c:592
#1  0xc013d665 in do_try_to_free_pages (gfp_mask=4, user=0) at vmscan.c:935
#2  0xc013d73b in kswapd (unused=0x0) at vmscan.c:1016
#3  0xc01056b6 in kernel_thread (fn=0xddaa0848, arg=0xdfff5fbc, flags=9) at
process.c:443
#4  0xddaa0844 in ?? ()

And my user space process is desperatly trying to get a page from a page
fault!

#0  reclaim_page (zone=0xc0285ae8) at
/usr/src/linux.2.4.4/include/asm/spinlock.h:102
#1  0xc013e474 in __alloc_pages_limit (zonelist=0xc02864dc, order=0,
limit=1, direct_reclaim=1) at page_alloc.c:294
#2  0xc013e581 in __alloc_pages (zonelist=0xc02864dc, order=0) at
page_alloc.c:383
#3  0xc012de43 in do_anonymous_page (mm=0xdfb88884, vma=0xdb45ce3c,
page_table=0xc091e46c, write_access=1, addr=1506914312)
    at /usr/src/linux.2.4.4/include/linux/mm.h:392
#4  0xc012df40 in do_no_page (mm=0xdfb88884, vma=0xdb45ce3c,
address=1506914312, write_access=1, page_table=0xc091e46c)
    at memory.c:1237
#5  0xc012e15b in handle_mm_fault (mm=0xdfb88884, vma=0xdb45ce3c,
address=1506914312, write_access=1) at memory.c:1317
#6  0xc01163dc in do_page_fault (regs=0xdb2d3fc4, error_code=6) at
fault.c:265
#7  0xc01078b0 in error_code () at af_packet.c:1881
#8  0x40040177 in ?? () at af_packet.c:1881

The spinlock counts are usually on the order of ~1million spins to get the
lock!!!!!!


                                                        jlinton


