Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030538AbVIOQvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030538AbVIOQvt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 12:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030539AbVIOQvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 12:51:49 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:23941 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1030538AbVIOQvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 12:51:48 -0400
Message-ID: <4329A6A3.7080506@vc.cvut.cz>
Date: Thu, 15 Sep 2005 18:51:47 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   so now once crashes on UP system were sorted out, I tried to
put new kernel on my SMP host - and sorry to say, but it does not
seem to work as advertised :-(  It seems that we somehow got
blocks from CPU#1 into memory blocks on CPU#0, and free_block
complains that caller holds cachep->nodelists[0]->list_lock
while nodeid for block passed to free_block() comes from processor
(and node) #1...

   I cannot find how this happened.  Hopefully somebody else
will know...  Meanwhile I'll try to get rid of PREEMPT, apparently
although it is now masqueraded under 'Low-latency desktop' it
is still somewhat dangerous.  If it is triggered by preempt, that is.
						Thanks,
							Petr Vandrovec


ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 0) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mm/slab.c:1849
invalid operand: 0000 [1] PREEMPT SMP
CPU 0
Modules linked in:
Pid: 8, comm: events/0 Not tainted 2.6.14-rc1-1619 #1
RIP: 0010:[<ffffffff8016e826>] <ffffffff8016e826>{free_block+294}
RSP: 0000:ffff81007ff21d88  EFLAGS: 00010002
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000310
RDX: 0000000000000000 RSI: ffff81007ffddd10 RDI: ffff81007ffda080
RBP: ffff81007ffde000 R08: ffff81003ffaed90 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff81007ffc9b50
R13: ffff81007ffde048 R14: ffff81007ffda080 R15: ffff81007ffda080
FS:  0000000000000000(0000) GS:ffffffff805fb800(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006e0
Process events/0 (pid: 8, threadinfo ffff81007ff20000, task ffff81003ff8c790)
Stack: 0000000000000000 0000000000000000 0000000000000213 0000000200000000
        ffff81007ffddd10 ffff81007ffddd10 ffff81007ffddce8 0000000000000002
        0000000000000000 ffff81007ffda080
Call Trace:<ffffffff8016fdc7>{drain_array_locked+167} <ffffffff8016feee>{cache_reap+206}
        <ffffffff803a2374>{_spin_lock_irqsave+36} <ffffffff8016fe20>{cache_reap+0}
        <ffffffff8014a1bc>{worker_thread+476} <ffffffff80132610>{default_wake_function+0}
        <ffffffff80132610>{default_wake_function+0} <ffffffff80149fe0>{worker_thread+0}
        <ffffffff8014ebc2>{kthread+146} <ffffffff8010ed12>{child_rip+8}
        <ffffffff80149fe0>{worker_thread+0} <ffffffff8014eb30>{kthread+0}
        <ffffffff8010ed0a>{child_rip+0}

Code: 0f 0b 68 bd aa 3d 80 c2 39 07 48 89 ee 4c 89 ff 4c 8d 75 30
RIP <ffffffff8016e826>{free_block+294} RSP <ffff81007ff21d88>
  <6>note: events/0[8] exited with preempt_count 1
hda: _NEC DVD_RW ND-3500AG, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: WDC WD1200JB-00CRA0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 128KiB
hdc: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hdc: cache flushes not supported
  hdc: hdc1
libata version 1.12 loaded.
sata_sil version 0.9
ACPI: PCI Interrupt 0000:01:0b.0[A] -> GSI 17 (level, low) -> IRQ 177
<and box is dead>

