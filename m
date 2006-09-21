Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWIUSEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWIUSEB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 14:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWIUSEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 14:04:00 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:27140 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751415AbWIUSEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 14:04:00 -0400
Message-ID: <4512D3F8.5030307@shadowen.org>
Date: Thu, 21 Sep 2006 19:03:36 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: 2.6.18-rc7-mm1 -- ppc64 crash in slab_node ??
References: <20060919012848.4482666d.akpm@osdl.org>	<45128F94.1080502@shadowen.org> <20060921102823.628a2a74.akpm@osdl.org>
In-Reply-To: <20060921102823.628a2a74.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 21 Sep 2006 14:11:48 +0100
> Andy Whitcroft <apw@shadowen.org> wrote:
> 
>> Hmmm seeing this on a ppc64 lpar.
>>
>> PID hash table entries: 4096 (order: 12, 32768 bytes)
>> Console: colour dummy device 80x25
>> Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
>> Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
>> freeing bootmem node 0
>> freeing bootmem node 1
>> Memory: 2042288k/2097152k available (5752k kernel code, 55392k reserved,
>> 1456k data, 875k bss, 252k init)
>> Unable to handle kernel paging request for data at address 0x00000004
>> Faulting instruction address: 0xc0000000000bc830
>> Oops: Kernel access of bad area, sig: 11 [#1]
>> SMP NR_CPUS=128 NUMA
>> Modules linked in:
>> NIP: C0000000000BC830 LR: C0000000000C7DF4 CTR: 0000000000000000
>> REGS: c00000000070f990 TRAP: 0300   Not tainted  (2.6.18-rc7-mm1-autokern1)
>> MSR: 8000000000001032 <ME,IR,DR>  CR: 24004022  XER: 0000000B
>> DAR: 0000000000000004, DSISR: 0000000040000000
>> TASK = c0000000005c0900[0] 'swapper' THREAD: c00000000070c000 CPU: 0
>> GPR00: C0000000000C80DC C00000000070FC10 C00000000070B1A0 0000000000000000
>> GPR04: 00000000000000D0 0000000000000000 0000000000000000 0000000000000042
>> GPR08: 0000000000000000 C0000000005C0900 0000000000000000 C00000007FFF3800
>> GPR12: 0000000024004022 C0000000005C1480 0000000000000000 0000000000000000
>> GPR16: 0000000000000000 0000000000000000 0000000000000000 4000000001C00000
>> GPR20: 0000000000000000 0000000000000000 0000000000141000 C0000000004DA2D0
>> GPR24: 000000000199FB40 0000000000000000 0000000000042000 C0000000005F31A8
>> GPR28: C0000000005F31A8 C0000000007416E8 C0000000005FCC60 00000000000000D0
>> NIP [C0000000000BC830] .slab_node+0x10/0x78
>> LR [C0000000000C7DF4] .fallback_alloc+0x3c/0x100
>> Call Trace:
>> [C00000000070FC10] [8000000000001032] 0x8000000000001032 (unreliable)
>> [C00000000070FCB0] [C0000000000C80DC] .kmem_cache_zalloc+0x128/0x150
>> [C00000000070FD50] [C0000000000C90BC] .kmem_cache_create+0x2a0/0x6ac
>> [C00000000070FE30] [C00000000057BF90] .kmem_cache_init+0x1b4/0x4f8
>> [C00000000070FEF0] [C00000000055F7BC] .start_kernel+0x214/0x33c
>> [C00000000070FF90] [C0000000000084F4] .start_here_common+0x50/0x5c
>> Instruction dump:
>> 7fc3f378 60000000 e8010010 eba1ffe8 ebc1fff0 ebe1fff8 7c0803a6 4e800020
>> fbc1fff0 ebc2ce20 60000000 60000000 <a8030004> 2f800002 419e0038 2c800001
>>  <0>Kernel panic - not syncing: Attempted to kill the idle task!
>>
>> Given all the problems with -mm1 I'm not sure how hard to search for this.
>>
> 
> I guess the below will fix it.  But Christoph's machine would have oopsed
> too, if it had called fallback_alloc() this early.  So presumably it did
> not.  But yours does.  I wonder why?

Thanks I'll push it into the testing system and see what happens.

The following at least feels suspicious to my mind.  This appears to say
that this machine has most of its memory in node 1.  I am pretty sure
that this machine is infact a single node lpar and shouldn't be numa at all.

early_node_map[3] active PFN ranges
    1:        0 ->    32768
    0:    32768 ->    40960
    1:    40960 ->   524288

If I am doing the math right this machine only has 32Mb in node 0.
Yeah, according to the system we have one node of 32Mb with both CPU's
in it, and another node with no CPUS's with the rest of its 2Gb of ram.

# cat /sys/devices/system/node/node*/*
00000000,00000000,00000000,00000003
10 20

Node 0 MemTotal:        32768 kB
[...]
00000000,00000000,00000000,00000000
20 10

Node 1 MemTotal:      2064384 kB
[...]

I'll have a look at it tommorrow and see if I can figure out whats wrong
with the layout.

:/

-apw
