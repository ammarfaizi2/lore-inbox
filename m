Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVL2N5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVL2N5k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 08:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVL2N5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 08:57:39 -0500
Received: from general.keba.co.at ([193.154.24.243]:42469 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1750713AbVL2N5i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 08:57:38 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: SLAB-related panic in 2.6.15-rc7-rt1 on ARM
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Thu, 29 Dec 2005 14:57:34 +0100
Message-ID: <AAD6DA242BC63C488511C611BD51F367323303@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SLAB-related panic in 2.6.15-rc7-rt1 on ARM
Thread-Index: AcYMbBbv7mUCsIjqQjellMqTAU5UTQAEmePA
From: "kus Kusche Klaus" <kus@keba.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Cc: "Ingo Molnar" <mingo@elte.hu>,
       "linux-kernel" <linux-kernel@vger.kernel.org>, <clameter@sgi.com>,
       <mpm@selenic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: penberg@gmail.com
> On 12/29/05, kus Kusche Klaus <kus@keba.com> wrote:
> > My sa1100-based system panics while booting with 
> 2.6.15-rc7-rt1 when the
> > SLAB allocator is configured. Everything is fine with the SLOB
> > allocator.
> >
> > Please cc me, I'm currently not subscribed.
> >
> > Memory: 62856KB available (1552K code, 381K data, 80K init)
> > Unhandled fault: alignment exception (0xc0207003) at 0x0000015b
> > Internal error: : c0207003 [#1]
> > Modules linked in:
> > CPU: 0
> > PC is at get_page_from_freelist+0x1c/0x3d8
> > LR is at __alloc_pages+0x5c/0x2ac
> 
> Unfortunately, I am clueless of arm (and have no idea what alignment
> exception is) but the problem is probably related to mm/slab.c using
> alloc_pages_node() whereas mm/slob.c uses get_free_page(). Do you have
> CONFIG_BUG enabled? If not, please turn it on to see if gfp_zone()
> catches an invalid GFP flag coming from the slab.

CONFIG_BUG was on. I turned on some more debugging CONFIGs
(SLAB, PREEMPT, IRQ_FLAGS, VM, BUGVERBOSE, ERRORS), retried, and got
this
(note the very early BUG and two "MM: invalid domain"):

Uncompressing
Linux............................................................. done,
booting the kernel.
BUG: bad raw irq-flag value 600000d3, swapper/0!
[<c021fd68>] (dump_stack+0x0/0x24) from [<c0249560>]
(check_raw_flags+0x50/0x5c)
[<c0249510>] (check_raw_flags+0x0/0x5c) from [<c0249ff0>]
(__down_trylock+0x140/0x15c)
[<c0249eb0>] (__down_trylock+0x0/0x15c) from [<c024aa4c>]
(rt_down_trylock+0x20/0x164)
[<c024aa2c>] (rt_down_trylock+0x0/0x164) from [<c023152c>]
(vprintk+0x2a0/0x374)
 r6 = C0374720  r5 = C0399FD0  r4 = C03D92A4 
[<c023128c>] (vprintk+0x0/0x374) from [<c023161c>] (printk+0x1c/0x20)
[<c0231600>] (printk+0x0/0x20) from [<c0208694>]
(start_kernel+0x1c/0x19c)
 r3 = 00000000  r2 = 800000D3  r1 = C039C068  r0 = C0374720
[<c0208678>] (start_kernel+0x0/0x19c) from [<c0208094>]
(__enable_mmu+0x0/0x2c)
 r4 = C020717D 
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<00000000>] .... __init_begin+0x3fdf8000/0x2c
.....[<00000000>] ..   ( <= __init_begin+0x3fdf8000/0x2c)
.. [<c024b78c>] .... add_preempt_count+0x1c/0x20
.....[<c02312ac>] ..   ( <= vprintk+0x20/0x374)

Linux version 2.6.15-rc7-rt1 (kk@silver) (gcc version 3.4.4) #9 PREEMPT
Thu Dec 29 14:00:29 CET 2005
CPU: StrongARM-1110 [6901b118] revision 8 (ARMv4)
Machine: Keba KETOP
Ignoring unrecognised tag 0x00000000
Memory policy: ECC disabled, Data cache writeback
MM: invalid domain in supersection mapping for 0x8000000000 at
0xea000000
MM: invalid domain in supersection mapping for 0x18000000000 at
0xf0000000
ketop map io done
Real-Time Preemption Support (C) 2004-2005 Ingo Molnar
Built 1 zonelists
Kernel command line: console=ttySA0,38400n8 root=31:02 rootfstype=ext2
WARNING: experimental RCU implementation.
PID hash table entries: 512 (order: 9, 8192 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 64MB = 64MB total
Memory: 62904KB available (1520K code, 372K data, 76K init)
Unhandled fault: alignment exception (0xc0207003) at 0x00000163
Internal error: : c0207003 [#1]
Modules linked in:
CPU: 0
PC is at get_page_from_freelist+0x1c/0x400
LR is at __alloc_pages+0x68/0x2c0
pc : [<c0257cac>]    lr : [<c02580f8>]    Not tainted
sp : c0399e78  ip : c0399ec0  fp : c0399ebc
r10: c039d724  r9 : c03a29d8  r8 : 00000000
r7 : c039c068  r6 : 000000d0  r5 : c03a2994  r4 : c039d724
r3 : 00000044  r2 : 0000000b  r1 : 00000000  r0 : 000200d0
Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  Segment kernel
Control: C020717F  Table: C020717F  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc0398194)
Stack: (0xc0399e78 to 0xc039a000)
9e60:                                                       000008b5
000008f1 
9e80: 40000053 fffff70f c039d724 c021a4bc 000200d0 c039d724 c03a2994
000000d0 
9ea0: c039c068 00000000 c03a29d8 c039d724 c0399ef8 c0399ec0 c02580f8
c0257c9c 
9ec0: 000200d0 c0399ed0 00000010 c024951c 00000010 c03a2994 00000000
c021a860 
9ee0: 00000000 c03a29d8 000000d0 c0399f30 c0399efc c026bc4c c025809c
00000001 
9f00: 000000d0 00000000 c03a2994 00000000 c0398000 000000d0 c03a29d8
c03ee20c 
9f20: c026cff0 c0399f5c c0399f34 c026b8bc c026b970 20000000 c03ee20c
00000000 
9f40: 00052c00 00000020 c0398000 00000020 c0399f9c c0399f60 c026cff0
c026b7dc 
9f60: c0399f88 c0399f70 c0379bb8 c02499c0 00000326 c03a28d4 00000000
c021a7e0 
9f80: c03a2994 c03a28d4 c021a860 c03ee20c c0399fd8 c0399fa0 c0213ab0
c026cd04 
9fa0: 00000000 00000000 000000c0 00000000 c020717d c03d7de0 c039d244
c03f5220 
9fc0: c0219520 6901b118 c02194f0 c0399ff4 c0399fdc c0208760 c02139a4
c02082e4 
9fe0: c03d7e48 c020717d 00000000 c0399ff8 c0208094 c0208684 00000000
00000000 
Backtrace: 
[<c0257c90>] (get_page_from_freelist+0x0/0x400) from [<c02580f8>]
(__alloc_pages+0x68/0x2c0)
[<c0258090>] (__alloc_pages+0x0/0x2c0) from [<c026bc4c>]
(cache_alloc_refill+0x2e8/0x6cc)
[<c026b964>] (cache_alloc_refill+0x0/0x6cc) from [<c026b8bc>]
(kmem_cache_alloc+0xec/0x144)
[<c026b7d0>] (kmem_cache_alloc+0x0/0x144) from [<c026cff0>]
(kmem_cache_create+0x2f8/0x6b0)
[<c026ccf8>] (kmem_cache_create+0x0/0x6b0) from [<c0213ab0>]
(kmem_cache_init+0x118/0x320)
[<c0213998>] (kmem_cache_init+0x0/0x320) from [<c0208760>]
(start_kernel+0xe8/0x19c)
[<c0208678>] (start_kernel+0x0/0x19c) from [<c0208094>]
(__enable_mmu+0x0/0x2c)
 r4 = C020717D 
Code: e24dd01c e50b2034 e5922000 e50b002c (e5920158) 
 <0>Kernel panic - not syncing: Attempted to kill the idle task!
[<c021fd68>] (dump_stack+0x0/0x24) from [<c02306e8>] (panic+0x48/0x11c)
[<c02306a0>] (panic+0x0/0x11c) from [<c0232d64>] (do_exit+0x74/0xb78)
 r3 = 00000000  r2 = 00000002  r1 = 00000001  r0 = C0377760
[<c0232cf0>] (do_exit+0x0/0xb78) from [<c02200c0>] (die+0x2ec/0x338)
[<c021fdd4>] (die+0x0/0x338) from [<c0220160>]
(register_undef_hook+0x0/0x6c)
[<c022010c>] (notify_die+0x0/0x54) from [<c0221d2c>]
(do_DataAbort+0x8c/0xa0)
 r4 = 00030001 
[<c0221ca0>] (do_DataAbort+0x0/0xa0) from [<c021b860>]
(__dabt_svc+0x40/0x60)
 r8 = 00000000  r7 = C039C068  r6 = 000000D0  r5 = C0399E64
 r4 = FFFFFFFF 
[<c0257c90>] (get_page_from_freelist+0x0/0x400) from [<c02580f8>]
(__alloc_pages+0x68/0x2c0)
[<c0258090>] (__alloc_pages+0x0/0x2c0) from [<c026bc4c>]
(cache_alloc_refill+0x2e8/0x6cc)
[<c026b964>] (cache_alloc_refill+0x0/0x6cc) from [<c026b8bc>]
(kmem_cache_alloc+0xec/0x144)
[<c026b7d0>] (kmem_cache_alloc+0x0/0x144) from [<c026cff0>]
(kmem_cache_create+0x2f8/0x6b0)
[<c026ccf8>] (kmem_cache_create+0x0/0x6b0) from [<c0213ab0>]
(kmem_cache_init+0x118/0x320)
[<c0213998>] (kmem_cache_init+0x0/0x320) from [<c0208760>]
(start_kernel+0xe8/0x19c)
[<c0208678>] (start_kernel+0x0/0x19c) from [<c0208094>]
(__enable_mmu+0x0/0x2c)
 r4 = C020717D 
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c024b78c>] .... add_preempt_count+0x1c/0x20
.....[<c02086b0>] ..   ( <= start_kernel+0x38/0x19c)
.. [<c024b78c>] .... add_preempt_count+0x1c/0x20
.....[<c02306b8>] ..   ( <= panic+0x18/0x11c)

 


-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
 
