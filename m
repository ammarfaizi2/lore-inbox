Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVFWJgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVFWJgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 05:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVFWJfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 05:35:53 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29334 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262261AbVFWJ3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 05:29:13 -0400
Date: Thu, 23 Jun 2005 11:29:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DEBUG_PAGEALLOC & SMP?
Message-ID: <20050623092902.GA29602@elte.hu>
References: <20050623090936.GA28112@elte.hu> <20050623022000.094169d4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623022000.094169d4.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > is this a known problem?
> 
> Nope.
> 
> >  I'm getting an oom-kill and a stuck boot with 
> >  SMP & PAGEALLOC enabled. The UP kernel boots fine.
> 
> Strange, something gobbled all of your ZONE_DMA.  0xd1 is 
> GFP_KERNEL|GFP_DMA, so perhaps something has gone mad in the bouncing 
> code.
> 
> The oom-killer is supposed to do a dump_stack(), but it looks like 
> that patch got lost.

added them, it's:

(gdb) list *0xc02f993f
0xc02f993f is in sd_revalidate_disk (drivers/scsi/sd.c:1472).
1467                           "failure.\n");
1468                    goto out;
1469            }
1470
1471            buffer = kmalloc(512, GFP_KERNEL | __GFP_DMA);
1472            if (!buffer) {
1473                    printk(KERN_WARNING "(sd_revalidate_disk:) Memory allocation "
1474                           "failure.\n");
1475                    goto out_release_request;
1476            }
(gdb)

full log attached below. (ob'fun: the oom-killer picked the migration 
thread to kill ;)

	Ingo

scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
 target0:0:1: Beginning Domain Validation
WIDTH IS 1
(scsi0:A:1): 6.600MB/s transfers (16bit)
(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
 target0:0:1: Ending Domain Validation
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

Calling initcall 0xc049b713: ahd_linux_init+0x0/0x19()
Calling initcall 0xc049b72c: init_sd+0x0/0x53()
oom-killer: gfp_mask=0xd1
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
cpu 2 hot: low 2, high 6, batch 1
cpu 2 cold: low 0, high 2, batch 1
cpu 3 hot: low 2, high 6, batch 1
cpu 3 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31
cpu 0 cold: low 0, high 62, batch 31
cpu 1 hot: low 62, high 186, batch 31
cpu 1 cold: low 0, high 62, batch 31
cpu 2 hot: low 62, high 186, batch 31
cpu 2 cold: low 0, high 62, batch 31
cpu 3 hot: low 62, high 186, batch 31
cpu 3 cold: low 0, high 62, batch 31
HighMem per-cpu: empty

Free pages:      875456kB (0kB HighMem)
Active:0 inactive:0 dirty:0 writeback:0 unstable:0 free:218864 slab:1007 mapped:0 pagetables:0
DMA free:0kB min:68kB low:84kB high:100kB active:0kB inactive:0kB present:16384kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 880 880
Normal free:875456kB min:3756kB low:4692kB high:5632kB active:0kB inactive:0kB present:901120kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Normal: 0*4kB 2*8kB 1*16kB 1*32kB 0*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 213*4096kB = 875456kB
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
curr: swapper/1.
 [<c0103e9a>] dump_stack+0x23/0x25 (20)
 [<c01402a9>] out_of_memory+0x7a/0x111 (32)
 [<c0141485>] __alloc_pages+0x40f/0x419 (72)
 [<c0144071>] kmem_getpages+0x34/0x9a (32)
 [<c0144f06>] cache_grow+0xb6/0x1bd (52)
 [<c0145210>] cache_alloc_refill+0x203/0x263 (60)
 [<c0145495>] kmem_cache_alloc+0x8a/0x8e (32)
 [<c02f993f>] sd_revalidate_disk+0x54/0x13b (44)
 [<c02f9c15>] sd_probe+0x1ef/0x345 (64)
 [<c02250b3>] driver_probe_device+0x2f/0x70 (24)
 [<c02251ed>] driver_attach+0x54/0x94 (36)
 [<c02256fb>] bus_add_driver+0xa6/0xd0 (32)
 [<c049b778>] init_sd+0x4c/0x53 (24)
 [<c047e9f1>] do_initcalls+0x32/0xc5 (36)
 [<c0100405>] init+0xcc/0x24f (28)
 [<c010111d>] kernel_thread_helper+0x5/0xb (138018844)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c03a0a7d>] .... _raw_read_lock+0x1b/0x87
.....[<c014024c>] ..   ( <= out_of_memory+0x1d/0x111)
.. [<c0137f15>] .... print_traces+0x1b/0x52
.....[<c0103e9a>] ..   ( <= dump_stack+0x23/0x25)

p: migration/0/2.
f7c69f64 00000082 f7c6b220 c185dedc 00000000 c04c3248 c186e6a0 f7c69f3c 
       c010fbc8 c185dea0 00000001 f7c6b220 c185dea0 0000038f 0b5710a9 00000000 
       f7c6b220 f7c5c030 f7c5c158 f7c68000 c185dea0 f7c68000 f7c69f88 c039f781 
Call Trace:
 [<c039f781>] schedule+0x3f/0x146 (36)
 [<c01186f6>] migration_thread+0x114/0x1ab (44)
 [<c013159b>] kthread+0xab/0xd3 (48)
 [<c010111d>] kernel_thread_helper+0x5/0xb (137977884)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c039eebe>] .... __schedule+0x4e/0x8d2
.....[<c039f781>] ..   ( <= schedule+0x3f/0x146)
.. [<c03a0990>] .... _raw_spin_lock_irqsave+0x1c/0xa5
.....[<c039ef64>] ..   ( <= __schedule+0xf4/0x8d2)

