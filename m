Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbULCRgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbULCRgr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 12:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbULCRgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 12:36:46 -0500
Received: from fire.osdl.org ([65.172.181.4]:25039 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262444AbULCRcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 12:32:36 -0500
Message-ID: <41B09FFD.6070706@osdl.org>
Date: Fri, 03 Dec 2004 09:18:53 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: devik <devik@cdi.cz>
CC: linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: sched isolcpus=1 related OOPS in 2.6.9
References: <Pine.LNX.4.33.0412031725590.493-100000@devix>
In-Reply-To: <Pine.LNX.4.33.0412031725590.493-100000@devix>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

devik wrote:
>>only CPU#0 use (I want to use affinity to select CPU#1).
>>The OOPS triggers every time when I use isolcpus.
>>
>>I traced the problem down into sched.c:1928 (find_busiest_group)
>>where group->cpu_power was zero (thus division by zero occured).
>>In call trace it goes swapper->schedule()->........->find_busiest_group.
>>Important registers there: eax=ecx=edx=0, ebx!=0.
> 
> 
> Well, I have more info. I setup bochs smp emulator and hacked
> printk to output into e9 port which is then directed to a file.
> Also I turned sched_domains debugging. From the result (below)
> is clear that there is bug in isolated domains setup.

You are correct, of course.  If "isolcpus" is used, the isolated
cpu(s) (in <cpu_isolated_map>) are not init like the remaining
cpus are.

I don't know what's intended here... but it's not the divide by 0.

> devik
> 
> <6>BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 0000000000100000 - 0000000002000000 (usable)
> <5>32MB LOWMEM available.
> <6>found SMP MP-table at 000fd0f0
> <7>On node 0 totalpages: 8192
> <7>  DMA zone: 4096 pages, LIFO batch:1
> <7>  Normal zone: 4096 pages, LIFO batch:1
> <7>  HighMem zone: 0 pages, LIFO batch:1
> <6>DMI not present.
> <3>ACPI: Unable to locate RSDP
> <6>Intel MultiProcessor Specification v1.4
> <6>    Virtual Wire compatibility mode.
> <6>OEM ID: BOCHSCPU Product ID: 0.1          APIC at: 0xFEE00000
> Processor #0 6:0 APIC version 17
> Processor #1 6:0 APIC version 17
> <6>I/O APIC #2 Version 17 at 0xFEC00000.
> Enabling APIC mode:  Flat.  Using 1 I/O APICs
> <6>Processors: 2
> Built 1 zonelists
> Kernel command line: BOOT_IMAGE=linux ro root=301 apic=debug noapic isolcpus=1
> mapped APIC to ffffd000 (fee00000)
> mapped IOAPIC to ffffc000 (fec00000)
> <6>Initializing CPU#0
> CPU 0 irqstacks, hard=c035b000 soft=c0359000
> PID hash table entries: 256 (order: 8, 4096 bytes)
> Detected 2.001 MHz processor.
> <6>Using tsc for high-res timesource
> Console: colour VGA+ 80x50
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> <6>Memory: 29372k/32768k available (1511k kernel code, 2960k reserved, 698k data, 168k init, 0k highmem)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> <7>Calibrating delay loop... 8.19 BogoMIPS (lpj=4096)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> <7>CPU: After generic identify, caps: 0180a379 00000000 00000000 00000000
> <7>CPU: After vendor identify, caps:  0180a379 00000000 00000000 00000000
> <7>CPU: After all inits, caps:        0180a379 00000000 00000000 00000040
> <6>Enabling fast FPU save and restore... done.
> <6>Checking 'hlt' instruction... OK.
> CPU0: Intel Pentium III (Coppermine) stepping 03
> per-CPU timeslice cutoff: 81.50 usecs.
> task migration cache decay timeout: 1 msecs.
> Getting VERSION: 170011
> Getting VERSION: 170011
> Getting ID: 0
> Getting LVT0: 0
> Getting LVT1: 0
> enabled ExtINT on CPU#0
> Booting processor 1/1 eip 2000
> CPU 1 irqstacks, hard=c035c000 soft=c035a000
> <6>Initializing CPU#1
> masked ExtINT on CPU#1
> <7>Calibrating delay loop... 8.19 BogoMIPS (lpj=4096)
> <7>CPU: After generic identify, caps: 0180a379 00000000 00000000 00000000
> <7>CPU: After vendor identify, caps:  0180a379 00000000 00000000 00000000
> <7>CPU: After all inits, caps:        0180a379 00000000 00000000 00000040
> CPU1: Intel Pentium III (Coppermine) stepping 03
> <6>Total of 2 processors activated (16.38 BogoMIPS).
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 1.0999 MHz.
> ..... host bus clock speed is 1.0999 MHz.
> <6>checking TSC synchronization across 2 CPUs:
> <6>CPU#0 had 0 usecs TSC skew, fixed it up.
> <6>CPU#1 had 0 usecs TSC skew, fixed it up.
> Brought up 2 CPUs
> <6>Setting up cpu 1 isolated.
> <7>CPU0:  online
> <7> domain 0: span 3
> <7>  groups: 1 2
> <7>CPU1:  online
> <7> domain 0: span 2
> <7>ERROR domain->cpu_power not set
> <7>  groups: 2
> <1>divide error: 0000 [#1]
> SMP
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c0116fd3>]    Not tainted VLI
> EFLAGS: 00010046   (2.6.9imq)
> EIP is at find_busiest_group+0x2b3/0x310
> eax: 00000000   ebx: c10b2e74   ecx: 00000000   edx: 00000000
> esi: c0360ee8   edi: c0351000   ebp: c10b2e84   esp: c10b2e38
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, threadinfo=c10b2000 task=c10b15a0)
> Stack: c10b2e74 00000002 00000002 00004441 08bca3a6 c0351000 00000000 00000001
>        00000080 00000080 00000080 00000000 00000000 c0360edc 00000000 00000002
>        00000040 c1044940 00000001 c10b2eb8 c0117125 c1044940 00000000 c10b2ea8
> Call Trace:
>  [<c01071ff>] show_stack+0x7f/0xa0
>  [<c01073ae>] show_registers+0x15e/0x1c0
>  [<c01075c4>] die+0xf4/0x180
>  [<c010775b>] do_divide_error+0x10b/0x130
>  [<c0106ded>] error_code+0x2d/0x38
>  [<c0117125>] load_balance+0x35/0x1a0
>  [<c01175fa>] rebalance_tick+0xba/0xd0
>  [<c0117732>] scheduler_tick+0x122/0x480
>  [<c0124b85>] update_process_times+0x45/0x50
>  [<c0111928>] smp_apic_timer_interrupt+0xf8/0x100
>  [<c0106d52>] apic_timer_interrupt+0x1a/0x20
>  [<c032d03a>] unpack_to_rootfs+0x17a/0x200
>  [<c032d0eb>] populate_rootfs+0x2b/0x120
>  [<c010058a>] init+0x8a/0x1e0
>  [<c0104565>] kernel_thread_helper+0x5/0x10
> Code: 00 0f 4d c2 83 f8 01 89 c1 7e ad 8b 4d d0 85 c9 0f 84 fe fd ff ff 8b 45 e0 01 45 dc 89 c2 8b 4e 08 01 4d d4 c1 e2 07 89 d0 31 d2 <f7> f1 8b 55 cc 85 d2 89 45 e0 75 1c 8b 45 e4 39 45 e0 76 09 89


-- 
~Randy
