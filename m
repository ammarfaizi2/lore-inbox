Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbVIGQds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVIGQds (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 12:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbVIGQdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 12:33:46 -0400
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:36538 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S1751234AbVIGQdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 12:33:45 -0400
Date: Wed, 7 Sep 2005 18:31:21 +0200 (CEST)
From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
To: Brett Russ <russb@emc.com>
cc: Jeff Garzik <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>,
       <linux-ide@vger.kernel.org>, <hch@infradead.org>
Subject: Re: [PATCH 2.6.13] libata: Marvell SATA support (PIO mode)
In-Reply-To: <431EFBD0.1040509@emc.com>
Message-ID: <Pine.LNX.4.44.0509071723440.2481-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Sep 2005, Brett Russ wrote:

> The one I fixed concerned the 5xxx chips not supporting the master
> reset functionality.

Please note that in my case the failure to do master reset is followed
by the module still being loaded and oops-ing at rmmod, which means
that the error path in the probe routine is wrong and some resources
remain allocated.

>   IRQ routing conflict for 0000:02:08.0, have irq 9, want irq 5

In the mean time, I have discovered that booting the SMP kernel (the
mainboard is UP, but both it and the CPU support HyperThreading) takes
care of this: the controller gets some high numbered IRQ, like 209 or
so, not shared. This is not exactly related to this driver, but might
help others that want to use the on-board controller on this MB.

> The chip does take an "error" interrupt upon drive connection but
> that's not fatal.

In my situation this happened with the drive already connected, so is
it possible that such interrupt is (also) generated when probing for
drives ?

Here is some more output, this time with debugging on (cut-and-pasted 
from serial console, maybe with some extra newlines):

- without any drive connected, I also get problems now:

mv_init_one: ENTER for PCI Bus:Slot.Func=2:8.0
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err 
cause/mask=0x00000018/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err 
cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err 
cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err 
cause/mask=0x00000000/0x00001f7f
mv_host_init: HC0: HC config=0x11dcf013 HC IRQ cause=0x00000000
mv_host_init: HC MAIN IRQ cause/mask=0x00000001/0x0007ffff PCI int 
cause/mask=0x00000000/6mv_init_one: PCI config space:
mv_init_one: 504111ab 02b00007 01000003 00002008
mv_init_one: f5000004 00000000 00000000 00000000
mv_init_one: 00000000 00000000 00000000 81241043
mv_init_one: 00000000 00000040 00000000 00000109
mv_host_intr: ENTER, hc0 relevant=0x00000001 HC IRQ cause=0x00000000
mv_phy_reset: ENTER, port 0, mmio 0xf8a22000
mv_phy_reset: Done.  Now calling __sata_phy_reset()
mv_err_intr: port 0 error; EDMA err cause: 0x00000018 SERR: 0x00000000
mv_phy_reset: ENTER, port 0, mmio 0xf8a22000
mv_phy_reset: Done.  Now calling __sata_phy_reset()
Badness in __sata_phy_reset at drivers/scsi/libata-core.c:1413
 [<f8961dc8>] __sata_phy_reset+0x75/0x12e [libata]
 [<f887566e>] mv_phy_reset+0xe8/0x175 [sata_mv]
 [<f8875449>] mv_host_intr+0xf1/0x187 [sata_mv]
 [<f887555e>] mv_interrupt+0x7f/0xa7 [sata_mv]
 [<c010745e>] handle_IRQ_event+0x25/0x4f
 [<c01079be>] do_IRQ+0x11c/0x1ae
 =======================
 [<c02d1c88>] common_interrupt+0x18/0x20
bad: scheduling while atomic!
 [<c02ced41>] schedule+0x2d/0x87a
 [<c011e53e>] scheduler_tick+0x3ce/0x3e5
 [<c0122bba>] profile_hook+0x1b/0x26
 [<c0129741>] __mod_timer+0x101/0x10b
 [<c02cfa90>] schedule_timeout+0xd3/0xee
 [<c0129feb>] process_timeout+0x0/0x5
 [<f8875082>] mv_scr_read+0xf/0x54 [sata_mv]
 [<c012a562>] msleep+0x4f/0x55
 [<f8961dfb>] __sata_phy_reset+0xa8/0x12e [libata]
 [<f887566e>] mv_phy_reset+0xe8/0x175 [sata_mv]
 [<f8875449>] mv_host_intr+0xf1/0x187 [sata_mv]
 [<f887555e>] mv_interrupt+0x7f/0xa7 [sata_mv]
 [<c010745e>] handle_IRQ_event+0x25/0x4f
 [<c01079be>] do_IRQ+0x11c/0x1ae
 =======================
 [<c02d1c88>] common_interrupt+0x18/0x20

which kills the network, the system is still responsive to keyboard -
but doesn't want to reboot, needs the button push. This however seems 
to be random, as I can also get a successful start:

mv_init_one: ENTER for PCI Bus:Slot.Func=2:8.0
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err 
cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err 
cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err 
cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err 
cause/mask=0x00000000/0x00001f7f
mv_host_init: HC0: HC config=0x11dcf013 HC IRQ cause=0x00000000
mv_host_init: HC MAIN IRQ cause/mask=0x00000000/0x0007ffff PCI int 
cause/mask=0x00000000/6mv_init_one: PCI config space:
mv_init_one: 504111ab 02b00007 01000003 00002008
mv_init_one: f5000004 00000000 00000000 00000000
mv_init_one: 00000000 00000000 00000000 81241043
mv_init_one: 00000000 00000040 00000000 00000109
mv_phy_reset: ENTER, port 0, mmio 0xf8a22000
mv_phy_reset: Done.  Now calling __sata_phy_reset()
mv_phy_reset: Port disabled pre-sig.  Exiting.
mv_phy_reset: ENTER, port 1, mmio 0xf8a24000
mv_phy_reset: Done.  Now calling __sata_phy_reset()
mv_phy_reset: Port disabled pre-sig.  Exiting.
mv_phy_reset: ENTER, port 2, mmio 0xf8a26000
mv_phy_reset: Done.  Now calling __sata_phy_reset()
mv_phy_reset: Port disabled pre-sig.  Exiting.
mv_phy_reset: ENTER, port 3, mmio 0xf8a28000
mv_phy_reset: Done.  Now calling __sata_phy_reset()
mv_phy_reset: Port disabled pre-sig.  Exiting.



- with a drive connected to what on the MB is labeled as the first
channel for this controller (which IIRC is also recognized as the
first channel by the mv_sata driver):

mv_init_one: ENTER for PCI Bus:Slot.Func=2:8.0
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err 
cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err 
cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err 
cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err 
cause/mask=0x00000000/0x00001f7f
mv_host_init: HC0: HC config=0x11dcf013 HC IRQ cause=0x00000111
mv_host_init: HC MAIN IRQ cause/mask=0x00000102/0x0007ffff PCI int 
cause/mask=0x00000000/6mv_init_one: PCI config space:
mv_init_one: 504111ab 02b00007 01000003 00002008
mv_init_one: f5000004 00000000 00000000 00000000
mv_init_one: 00000000 00000000 00000000 81241043
mv_init_one: 00000000 00000040 00000000 00000109
mv_host_intr: ENTER, hc0 relevant=0x00000102 HC IRQ cause=0x00000111
mv_host_intr: EXIT
mv_phy_reset: ENTER, port 0, mmio 0xf8a22000
mv_host_intr: ENTER, hc0 relevant=0x00000001 HC IRQ cause=0x00000000
mv_err_intr: port 0 error; EDMA err cause: 0x00000008 SERR: 0x00000000
mv_phy_reset: ENTER, port 0, mmio 0xf8a22000
mv_phy_reset: Done.  Now calling __sata_phy_reset()
Badness in __sata_phy_reset at drivers/scsi/libata-core.c:1413
 [<f8961dc8>] __sata_phy_reset+0x75/0x12e [libata]
 [<f887566e>] mv_phy_reset+0xe8/0x175 [sata_mv]
 [<f8875449>] mv_host_intr+0xf1/0x187 [sata_mv]
 [<f887555e>] mv_interrupt+0x7f/0xa7 [sata_mv]
 [<c010745e>] handle_IRQ_event+0x25/0x4f
 [<c01079be>] do_IRQ+0x11c/0x1ae
 =======================
 [<c02d1c88>] common_interrupt+0x18/0x20
 [<c012007b>] dup_task_struct+0x71/0xc0
 [<c0111714>] delay_tsc+0x9/0x13
 [<c01c18d9>] __delay+0x9/0xa
 [<f8875652>] mv_phy_reset+0xcc/0x175 [sata_mv]
 [<c0107e9e>] setup_irq+0xae/0xb7
 [<f88754df>] mv_interrupt+0x0/0xa7 [sata_mv]
 [<f8961ce1>] ata_bus_probe+0xe/0x7b [libata]
 [<f8963fd4>] ata_device_add+0x16c/0x1e8 [libata]
 [<f8875abf>] mv_init_one+0x1f8/0x235 [sata_mv]
 [<c01c744d>] pci_device_probe_static+0x2a/0x3d
 [<c01c747b>] __pci_device_probe+0x1b/0x2c
 [<c01c74a7>] pci_device_probe+0x1b/0x2d
 [<c021d734>] bus_match+0x27/0x45
 [<c021d7fd>] driver_attach+0x37/0x66
 [<c021dbbb>] bus_add_driver+0x78/0x99
 [<c01c764e>] pci_register_driver+0x6e/0x8a
 [<f881b00a>] mv_init+0xa/0x15 [sata_mv]
 [<c0137c05>] sys_init_module+0x116/0x238
 [<c02d12cb>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02ced41>] schedule+0x2d/0x87a
 [<c011e1ae>] scheduler_tick+0x3e/0x3e5
 [<c0122bba>] profile_hook+0x1b/0x26
 [<c0129741>] __mod_timer+0x101/0x10b
 [<c02cfa90>] schedule_timeout+0xd3/0xee
 [<c0129feb>] process_timeout+0x0/0x5
 [<f8875082>] mv_scr_read+0xf/0x54 [sata_mv]
 [<c012a562>] msleep+0x4f/0x55
 [<f8961dfb>] __sata_phy_reset+0xa8/0x12e [libata]
 [<f887566e>] mv_phy_reset+0xe8/0x175 [sata_mv]
 [<f8875449>] mv_host_intr+0xf1/0x187 [sata_mv]
 [<f887555e>] mv_interrupt+0x7f/0xa7 [sata_mv]
 [<c010745e>] handle_IRQ_event+0x25/0x4f
 [<c01079be>] do_IRQ+0x11c/0x1ae
 =======================
 [<c02d1c88>] common_interrupt+0x18/0x20
 [<c012007b>] dup_task_struct+0x71/0xc0
 [<c0111714>] delay_tsc+0x9/0x13
 [<c01c18d9>] __delay+0x9/0xa
 [<f8875652>] mv_phy_reset+0xcc/0x175 [sata_mv]
 [<c0107e9e>] setup_irq+0xae/0xb7
 [<f88754df>] mv_interrupt+0x0/0xa7 [sata_mv]
 [<f8961ce1>] ata_bus_probe+0xe/0x7b [libata]
 [<f8963fd4>] ata_device_add+0x16c/0x1e8 [libata]
 [<f8875abf>] mv_init_one+0x1f8/0x235 [sata_mv]
 [<c01c744d>] pci_device_probe_static+0x2a/0x3d
 [<c01c747b>] __pci_device_probe+0x1b/0x2c
 [<c01c74a7>] pci_device_probe+0x1b/0x2d
 [<c021d734>] bus_match+0x27/0x45
 [<c021d7fd>] driver_attach+0x37/0x66
 [<c021dbbb>] bus_add_driver+0x78/0x99
 [<c01c764e>] pci_register_driver+0x6e/0x8a
 [<f881b00a>] mv_init+0xa/0x15 [sata_mv]
 [<c0137c05>] sys_init_module+0x116/0x238
 [<c02d12cb>] syscall_call+0x7/0xb

after which the system is dead.

> Either way, mv_phy_reset() is called from mv_err_intr()  which
> doesn't appear in either of the stack dumps above.

It appears now, both in the debug messages and on the stack (but not 
in the success case).

> -do the phy_reset part of error recovery after returning from
> interrupt handler?

I might be completely off here, but what the 3c59x network driver does
for the case where a MII link is used is to start a timer which checks
the state of the link, async from the init routine, which is very
similar in my understanding to your intention expressed above. This
scheme works fine for network...

Please note that I also exposed another problem in my previous
message: after 'rmmod sata_mv', the controller can still generate
interrupts, f.e. when a drive is attached.

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

