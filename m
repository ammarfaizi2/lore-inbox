Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWFSF4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWFSF4r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 01:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWFSF4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 01:56:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:19095 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750839AbWFSF4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 01:56:45 -0400
Date: Mon, 19 Jun 2006 15:55:23 +1000
From: David Chinner <dgc@sgi.com>
To: Neil Brown <neilb@suse.de>
Cc: Jan Blunck <jblunck@suse.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       balbir@in.ibm.com
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries list (2nd version)
Message-ID: <20060619055523.GS2795448@melbourne.sgi.com>
References: <20060601095125.773684000@hasse.suse.de> <17539.35118.103025.716435@cse.unsw.edu.au> <20060616155120.GA6824@hasse.suse.de> <17555.12234.347353.670918@cse.unsw.edu.au> <20060618235654.GB2114946@melbourne.sgi.com> <17557.61307.364404.640539@cse.unsw.edu.au> <20060619010013.GC2114946@melbourne.sgi.com> <17557.64512.496195.714144@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17557.64512.496195.714144@cse.unsw.edu.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 11:21:04AM +1000, Neil Brown wrote:
> On Monday June 19, dgc@sgi.com wrote:
> > 
> > Ok. Send me the patch and I'll try to get some tests done on it...
> 
> Below, thanks.

Neil,

I doubt I'm going to be able to run any tests for this patch on the
current -mm (2.6.17-rc6-mm2) any time soon. I get an interrupt
related BUG on boot in the sn2 console driver, and then a panic in
the scsi I/o completion code when running mkfs.xfs.  Both are
reproducable.

I don't have any other non-sn2 machine with enough memory in it to
test the patch....

The boot warnings:

....
    eth3      device: S2io Inc. Xframe 10 Gigabit Ethernet PCI-X (rev 03)
    eth3      configuration: eth-id-00:0c:fc:00:02:c8
irq 60, desc: a0000001009a2d00, depth: 1, count: 0, unhandled: 0
->handle_irq():  0000000000000000, 0x0
->chip(): a000000100a0fe40, irq_type_sn+0x0/0x80
->action(): e00000b007471b80
->action->handler(): a0000002059373d0, s2io_msi_handle+0x1510/0x660 [s2io]    eth3
IP address: 192.168.1.248/24
Unexpected irq vector 0x3c on CPU 3!
BUG: warning at drivers/serial/sn_console.c:976/sn_sal_console_write()

Call Trace:
 [<a0000001000125a0>] show_stack+0x40/0xa0
                                sp=e0000039ee2f7970 bsp=e0000039ee2f14b0
 [<a000000100012e30>] dump_stack+0x30/0x60
                                sp=e0000039ee2f7b40 bsp=e0000039ee2f1498
 [<a0000001004e5350>] sn_sal_console_write+0x270/0x3e0
                                sp=e0000039ee2f7b40 bsp=e0000039ee2f1420
 [<a0000001000a1d40>] __call_console_drivers+0x160/0x1c0
                                sp=e0000039ee2f7b40 bsp=e0000039ee2f13e8
 [<a0000001000a1e80>] _call_console_drivers+0xe0/0x100
                                sp=e0000039ee2f7b40 bsp=e0000039ee2f13b8
 [<a0000001000a2460>] release_console_sem+0x2c0/0x460
                                sp=e0000039ee2f7b40 bsp=e0000039ee2f1378
 [<a0000001000a2cf0>] vprintk+0x6f0/0x880
                                sp=e0000039ee2f7b40 bsp=e0000039ee2f12f0
 [<a0000001000a1f10>] printk+0x70/0xa0
                                sp=e0000039ee2f7b80 bsp=e0000039ee2f1290
 [<a00000010000f530>] ack_bad_irq+0x30/0x60
                                sp=e0000039ee2f7bc0 bsp=e0000039ee2f1270
 [<a0000001000f7ab0>] handle_bad_irq+0x410/0x440
                                sp=e0000039ee2f7bc0 bsp=e0000039ee2f1230
 [<a0000001000f7c80>] __do_IRQ+0x80/0x3c0
                                sp=e0000039ee2f7bc0 bsp=e0000039ee2f11d0
 [<a00000010000f790>] ia64_handle_irq+0xb0/0x160
                                sp=e0000039ee2f7bc0 bsp=e0000039ee2f11a0
 [<a00000010000b1a0>] ia64_leave_kernel+0x0/0x290
                                sp=e0000039ee2f7bc0 bsp=e0000039ee2f11a0
 [<a000000100010e80>] default_idle+0x120/0x160
                                sp=e0000039ee2f7d90 bsp=e0000039ee2f1158
 [<a000000100011d90>] cpu_idle+0x1d0/0x2c0
                                sp=e0000039ee2f7e30 bsp=e0000039ee2f1128
 [<a000000100051b70>] start_secondary+0x350/0x380
                                sp=e0000039ee2f7e30 bsp=e0000039ee2f10e0
 [<a000000100008650>] __end_ivt_text+0x330/0x360
                                sp=e0000039ee2f7e30 bsp=e0000039ee2f10e0
eth3: Link down                                                       done
.....


And the panic from mkfs.xfs:

budgie:~/dgc/jbod # sh jbd-mkfs
meta-data=/dev/mapper/dm1        isize=256    agcount=5, agsize=1114112 blks
         =                       sectsz=512   attr=0
data     =                       bsize=16384  blocks=5570560, imaxpct=25
         =                       sunit=0      swidth=0 blks, unwritten=1
naming   =version 2              bsize=16384
log      =/dev/mapper/dm0        bsize=16384  blocks=8192, version=1
         =                       sectsz=512   sunit=0 blks
realtime =none                   extsz=65536  blocks=0, rtextents=0
idle[0]: Oops 8813272891392 [1]
Modules linked in: ipv6 s2io sg

Pid: 0, CPU 1, comm:                 idle
psr : 0000101008022018 ifs : 800000000000038a ip  : [<a00000010014c7c0>]    Not tainted
ip is at kmem_freepages+0x100/0x200
unat: 0000000000000000 pfs : 000000000000050d rsc : 0000000000000003
rnat: 800000000000048d bsps: 0000000000000000 pr  : 80000000e7a95669
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a00000010014cf30 b6  : a000000100003320 b7  : a000000100105fc0
f6  : 1003e0000000000000045 f7  : 0ffdd8000000000000000
f8  : 1000589ffec9800000000 f9  : 10004a000000000000000
f10 : 1003e0000000000c1e09c f11 : 1003e00000000054d2444
r1  : a000000100d953c0 r2  : 0000000000000001 r3  : 0000000000000001
r8  : 0000000000000000 r9  : a0007fff5d4e0000 r10 : 0000000005bd8ff9
r11 : 00000000068f7ff8 r12 : e0000039ee2bfb50 r13 : e0000039ee2b8000
r14 : 0000000000d1efff r15 : 0000000000000080 r16 : ffffffffffffffff
r17 : a0007fff8b3a8000 r18 : a000000100baece8 r19 : 0000000000000208
r20 : e0000039ee3b98b8 r21 : 0000000000000000 r22 : 0000000000000080
r23 : ffffffffffffff7f r24 : 0000000000000000 r25 : e000003078274000
r26 : e00000347bffc000 r27 : 0000000000000000 r28 : e0000039ee2bfb60
r29 : e00000347bffc020 r30 : 00000000000021b9 r31 : 0000000000000000

Call Trace:
 [<a0000001000125a0>] show_stack+0x40/0xa0
                                sp=e0000039ee2bf700 bsp=e0000039ee2b98c8
 [<a000000100012dd0>] show_regs+0x7d0/0x800
                                sp=e0000039ee2bf8d0 bsp=e0000039ee2b9880
 [<a000000100033510>] die+0x230/0x340
                                sp=e0000039ee2bf8d0 bsp=e0000039ee2b9838
 [<a0000001000564e0>] ia64_do_page_fault+0x860/0x9c0
                                sp=e0000039ee2bf8f0 bsp=e0000039ee2b97d8
 [<a00000010000b1a0>] ia64_leave_kernel+0x0/0x290
                                sp=e0000039ee2bf980 bsp=e0000039ee2b97d8
 [<a00000010014c7c0>] kmem_freepages+0x100/0x200
                                sp=e0000039ee2bfb50 bsp=e0000039ee2b9788
 [<a00000010014cf30>] slab_destroy+0x1b0/0x260
                                sp=e0000039ee2bfb50 bsp=e0000039ee2b9738
 [<a00000010014d300>] free_block+0x320/0x3c0
                                sp=e0000039ee2bfb60 bsp=e0000039ee2b96e0
 [<a00000010014ccf0>] __cache_free+0x430/0x4c0
                                sp=e0000039ee2bfb60 bsp=e0000039ee2b9688
 [<a00000010014db80>] kmem_cache_free+0x120/0x180
                                sp=e0000039ee2bfb70 bsp=e0000039ee2b9658
 [<a000000100105ff0>] mempool_free_slab+0x30/0x60
                                sp=e0000039ee2bfb70 bsp=e0000039ee2b9630
 [<a000000100106210>] mempool_free+0x130/0x160
                                sp=e0000039ee2bfb70 bsp=e0000039ee2b95e8
 [<a000000100638760>] dec_pending+0x2c0/0x2e0
                                sp=e0000039ee2bfb70 bsp=e0000039ee2b95a0
 [<a000000100638a80>] clone_endio+0x140/0x180
                                sp=e0000039ee2bfb70 bsp=e0000039ee2b9558
 [<a000000100168970>] bio_endio+0x110/0x140
                                sp=e0000039ee2bfb70 bsp=e0000039ee2b9520
 [<a0000001003dc2b0>] __end_that_request_first+0x390/0xac0
                                sp=e0000039ee2bfb70 bsp=e0000039ee2b9498
 [<a0000001003dca10>] end_that_request_chunk+0x30/0x60
                                sp=e0000039ee2bfb70 bsp=e0000039ee2b9468
 [<a000000100565d30>] scsi_end_request+0x50/0x1e0
                                sp=e0000039ee2bfb70 bsp=e0000039ee2b9420
 [<a0000001005663f0>] scsi_io_completion+0x3b0/0x8a0
                                sp=e0000039ee2bfb70 bsp=e0000039ee2b9388
 [<a0000001005dd220>] sd_rw_intr+0x480/0x4a0
                                sp=e0000039ee2bfb80 bsp=e0000039ee2b9338
 [<a00000010055a5f0>] scsi_finish_command+0x150/0x180
                                sp=e0000039ee2bfba0 bsp=e0000039ee2b9308
 [<a000000100567910>] scsi_softirq_done+0x270/0x2a0
                                sp=e0000039ee2bfba0 bsp=e0000039ee2b92e0
 [<a0000001003d8e60>] blk_done_softirq+0x160/0x1c0
                                sp=e0000039ee2bfbb0 bsp=e0000039ee2b92c8
 [<a0000001000afff0>] __do_softirq+0xd0/0x240
                                sp=e0000039ee2bfbc0 bsp=e0000039ee2b9250
 [<a0000001000b01e0>] do_softirq+0x80/0xe0
                                sp=e0000039ee2bfbc0 bsp=e0000039ee2b91e8
 [<a0000001000b0520>] irq_exit+0x80/0xc0
                                sp=e0000039ee2bfbc0 bsp=e0000039ee2b91d0
 [<a00000010000f810>] ia64_handle_irq+0x130/0x160
                                sp=e0000039ee2bfbc0 bsp=e0000039ee2b91a0
 [<a00000010000b1a0>] ia64_leave_kernel+0x0/0x290
                                sp=e0000039ee2bfbc0 bsp=e0000039ee2b91a0
 [<a000000100407600>] __copy_user+0x20/0x960
                                sp=e0000039ee2bfd90 bsp=e0000039ee2b9178
 [<a000000100010e20>] default_idle+0xc0/0x160
                                sp=e0000039ee2bfd90 bsp=e0000039ee2b9158
 [<a000000100011d90>] cpu_idle+0x1d0/0x2c0
                                sp=e0000039ee2bfe30 bsp=e0000039ee2b9128
 [<a000000100051b70>] start_secondary+0x350/0x380
                                sp=e0000039ee2bfe30 bsp=e0000039ee2b90e0
 [<a000000100008650>] __end_ivt_text+0x330/0x360
                                sp=e0000039ee2bfe30 bsp=e0000039ee2b90e0
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

Cheers,

Dave.
--
Dave Chinner
Principal Engineer
SGI Australian Software Group
