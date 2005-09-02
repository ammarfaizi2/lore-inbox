Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVIBRRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVIBRRt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 13:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbVIBRRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 13:17:49 -0400
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:39115 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S1750728AbVIBRRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 13:17:48 -0400
Date: Fri, 2 Sep 2005 19:16:42 +0200 (CEST)
From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
To: Brett Russ <russb@emc.com>
cc: Jeff Garzik <jgarzik@pobox.com>, <linux-ide@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2.6.13] libata: Marvell SATA support (PIO mode)
In-Reply-To: <20050901222617.2455520F96@lns1058.lss.emc.com>
Message-ID: <Pine.LNX.4.44.0509021655470.22806-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sep 2005, Brett Russ wrote:

> This is my libata compatible low level driver for the Marvell SATA
> family.

First of all, thanks! I've been waiting for such a driver to appear.

I somehow did not manage to get a working 2.6.13 kernel to boot and,
as I didn't have too much time to see why, I compiled this driver
against the RHEL 4 Update 2 beta kernel (2.6.9-16, but which is itself
compiled by me from source RPM, so Jeff won't be able to match
addresses with the real RHEL binary RPM), which has libata v1.11, as
opposed to v1.12 in kernel 2.6.13 - I had to add the pci_intx function
(from ahci.c in kernel 2.6.13) and to remove the last line
(.ordered_flush = 1) from mv_sht initialization. All tests are with
the UP kernel.

The hardware is an Asus PSCHSR-A board with Adaptec AIC8110, but which 
appears on the PCI bus (supposedly a PCI-X one) as:

02:08.0 SCSI storage controller: Marvell Technology Group Ltd. MV88SX5041 4-port SATA I PCI-X Controller (rev 03)

The driver starts with:

ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 9 (level, low) -> IRQ 9
sata_mvPCI master won't flush

which means init failed, but the driver is still loaded at this point.  
Afterwards, when I try to run rmmod, I get:

 Unable to handle kernel NULL pointer dereference at virtual address 00000024
  printing eip:
 f89738b9
 *pde = 00000000
 Oops: 0000 [#1]
 Modules linked in: sata_mv(U) sd_mod libata scsi_mod nfsd exportfs lockd sunrpc dm_mod button battery ac uhci_hcd ehci_hcd e1000 ext3 jbd
 CPU:	 0
 EIP:	 0060:[<f89738b9>]    Not tainted VLI
 EFLAGS: 00010246   (2.6.9-16.EL) 
 EIP is at ata_pci_remove_one+0x12/0xb3 [libata]
 eax: f7f6ac44   ebx: 00000000   ecx: f8855488   edx: f89738a7
 esi: f8855424   edi: 00000000   ebp: f7f6ac00   esp: f6f96f14
 ds: 007b   es: 007b   ss: 0068
 Process rmmod (pid: 2628, threadinfo=f6f96000 task=f733f770)
 Stack: f7f6ac44 f7f6ac00 f8855424 f8855424 f6f96000 c01ec1df f7f6ac44 c024a46f 
	f8855424 f8855488 c024a491 c0368c40 c0368c8c c024a821 f885542c f8855424 
	00000000 c024abe7 f8855400 c035e5c0 c01ec39c f8855500 c013b6f5 00000000 
 Call Trace:
  [<c01ec1df>] pci_device_remove+0x16/0x28
  [<c024a46f>] device_release_driver+0x3c/0x46
  [<c024a491>] driver_detach+0x18/0x1f
  [<c024a821>] bus_remove_driver+0x48/0x75
  [<c024abe7>] driver_unregister+0xc/0x31
  [<c01ec39c>] pci_unregister_driver+0xb/0x13
  [<c013b6f5>] sys_delete_module+0x132/0x179
  [<c015a699>] unmap_vma_list+0xe/0x17
  [<c015aa48>] do_munmap+0x1c8/0x1d2
  [<c011a779>] do_page_fault+0x0/0x4dc
  [<c030fa37>] syscall_call+0x7/0xb
 Code: 87 c7 83 3c 24 00 74 07 89 e8 e8 59 72 87 c7 89 f0 83 c4 54 5b 5e 5f 5d c3 55 89 c5 8d 40 44 57 31 ff 56 53 52 89 04 24 8b 58 74 <3b> 7b 24 73 0e 8b 74 bb 30 47 8b 06 e8 55 ef fa ff eb ed 8b 43 
  <0>Fatal exception: panic in 5 seconds

This init error seems to be connected to the PCI BusMaster state:  
after booting, but before loading the driver, 'lspci -vv' shows
BusMaster+, but after loading the driver which complains, the state is
BusMaster-. This is with the latest BIOS (1007A) available for this
board, so "update BIOS" is not an option...

If I comment out the call to mv_master_reset(), the driver seems to 
initialize fine (no disks attached at this point):

sata_mv version 0.10
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 9 (level, low) -> IRQ 9
ata1: SATA max PIO4 cmd 0x0 ctl 0xF8A22120 bmdma 0x0 irq 9
ata2: SATA max PIO4 cmd 0x0 ctl 0xF8A24120 bmdma 0x0 irq 9
ata3: SATA max PIO4 cmd 0x0 ctl 0xF8A26120 bmdma 0x0 irq 9
ata4: SATA max PIO4 cmd 0x0 ctl 0xF8A28120 bmdma 0x0 irq 9
ata1: no device found (phy stat 00000000)
scsi0 : sata_mv
ata2: no device found (phy stat 00000000)
scsi1 : sata_mv
ata3: no device found (phy stat 00000000)
scsi2 : sata_mv
ata4: no device found (phy stat 00000000)
scsi3 : sata_mv
blk_queue_max_hw_segments: set to minimum 1

(the last line is actually repeated several times). Afterwards, rmmod 
doesn't produce any oops.

If I connect a disk in this state (driver unloaded) = device hotplug,
I get immediately:

irq 9: nobody cared! (screaming interrupt?)
irq 9: Please try booting with acpi=off and report a bug
 [<c0107e8f>] __report_bad_irq+0x3a/0x77
 [<c010834d>] note_interrupt+0x191/0x1b7
 [<c0108852>] do_IRQ+0x209/0x2bf
 [<c030fb7c>] common_interrupt+0x18/0x20
 [<c02b007b>] skb_copy_and_csum_bits+0x25d/0x281
 [<c0126774>] __do_softirq+0x2c/0x79
 [<c0109338>] do_softirq+0x46/0x4d
 =======================
 [<c01088fc>] do_IRQ+0x2b3/0x2bf
 [<c030fb7c>] common_interrupt+0x18/0x20
 [<c010403b>] default_idle+0x23/0x26
 [<c010408c>] cpu_idle+0x1f/0x34
 [<c03b86b9>] start_kernel+0x214/0x216
handlers:
[<c01fc0c3>] (acpi_irq+0x0/0x14)
Disabling IRQ #9

so I guess that the controller generates some interrupt whenever a
device is connected and the kernel doesn't know what to do with this
interrupt - so the interrupt generation by the controller probably has
to be disabled on rmmod.

Booting with apci=off and loading the same driver (without the
mv_master_reset() call) with one disk connected, I get:

 PCI: Found IRQ 5 for device 0000:02:08.0
 PCI: Sharing IRQ 5 with 0000:00:1d.0
 IRQ routing conflict for 0000:02:08.0, have irq 9, want irq 5
 ata1: SATA max PIO4 cmd 0x0 ctl 0xF8A22120 bmdma 0x0 irq 9
 ata2: SATA max PIO4 cmd 0x0 ctl 0xF8A24120 bmdma 0x0 irq 9
 ata3: SATA max PIO4 cmd 0x0 ctl 0xF8A26120 bmdma 0x0 irq 9
 ata4: SATA max PIO4 cmd 0x0 ctl 0xF8A28120 bmdma 0x0 irq 9
 Badness in __sata_phy_reset at drivers/scsi/libata-core.c:1413
  [<f88e8f0c>] __sata_phy_reset+0x75/0x12e [libata]
  [<f883f62f>] mv_phy_reset+0xbf/0x11e [sata_mv]
  [<c0250f16>] end_that_request_last+0x6c/0x7e
  [<f883f3bf>] mv_host_intr+0xd6/0x142 [sata_mv]
  [<f883f500>] mv_interrupt+0xd5/0x145 [sata_mv]
  [<c0107e2b>] handle_IRQ_event+0x25/0x4f
  [<c01087d3>] do_IRQ+0x18a/0x2bf
  =======================
  [<c030fb7c>] common_interrupt+0x18/0x20
  [<f883f618>] mv_phy_reset+0xa8/0x11e [sata_mv]
  [<c01091d8>] setup_irq+0x179/0x181
  [<f883f42b>] mv_interrupt+0x0/0x145 [sata_mv]
  [<f88e8e25>] ata_bus_probe+0xe/0x7b [libata]
  [<f88eb34d>] ata_device_add+0x186/0x202 [libata]
  [<f883f97a>] mv_init_one+0x197/0x1d5 [sata_mv]
  [<c01ec15d>] pci_device_probe_static+0x2a/0x3d
  [<c01ec18b>] __pci_device_probe+0x1b/0x2c
  [<c01ec1b7>] pci_device_probe+0x1b/0x2d
  [<c024a33b>] bus_match+0x27/0x45
  [<c024a404>] driver_attach+0x37/0x66
  [<c024a7b9>] bus_add_driver+0x77/0x97
  [<c024abd4>] driver_register+0x51/0x58
  [<c01ec375>] pci_register_driver+0x85/0xa1
  [<f881a00a>] mv_init+0xa/0x15 [sata_mv]
  [<c013d5a3>] sys_init_module+0x1f1/0x2d9
  [<c030fa37>] syscall_call+0x7/0xb
 bad: scheduling while atomic!
  [<c030d515>] schedule+0x2d/0x552
  [<c0107e2b>] handle_IRQ_event+0x25/0x4f
  [<c030e40e>] schedule_timeout+0xf1/0x10c
  [<c012ad7e>] process_timeout+0x0/0x5
  [<f883f082>] mv_scr_read+0xf/0x54 [sata_mv]
  [<c012b498>] msleep+0x4e/0x54
  [<f88e8f3f>] __sata_phy_reset+0xa8/0x12e [libata]
  [<f883f62f>] mv_phy_reset+0xbf/0x11e [sata_mv]
  [<c0250f16>] end_that_request_last+0x6c/0x7e
  [<f883f3bf>] mv_host_intr+0xd6/0x142 [sata_mv]
  [<f883f500>] mv_interrupt+0xd5/0x145 [sata_mv]
  [<c0107e2b>] handle_IRQ_event+0x25/0x4f
  [<c01087d3>] do_IRQ+0x18a/0x2bf
  =======================
  [<c030fb7c>] common_interrupt+0x18/0x20
  [<f883f618>] mv_phy_reset+0xa8/0x11e [sata_mv]
  [<c01091d8>] setup_irq+0x179/0x181
  [<f883f42b>] mv_interrupt+0x0/0x145 [sata_mv]
  [<f88e8e25>] ata_bus_probe+0xe/0x7b [libata]
  [<f88eb34d>] ata_device_add+0x186/0x202 [libata]
  [<f883f97a>] mv_init_one+0x197/0x1d5 [sata_mv]
  [<c01ec15d>] pci_device_probe_static+0x2a/0x3d
  [<c01ec18b>] __pci_device_probe+0x1b/0x2c
  [<c01ec1b7>] pci_device_probe+0x1b/0x2d
  [<c024a33b>] bus_match+0x27/0x45
  [<c024a404>] driver_attach+0x37/0x66
  [<c024a7b9>] bus_add_driver+0x77/0x97
  [<c024abd4>] driver_register+0x51/0x58
  [<c01ec375>] pci_register_driver+0x85/0xa1
  [<f881a00a>] mv_init+0xa/0x15 [sata_mv]
  [<c013d5a3>] sys_init_module+0x1f1/0x2d9
  [<c030fa37>] syscall_call+0x7/0xb


I don't know how much of the problem comes from BIOS/ACPI and how much
from the combination of this driver with the RHEL kernel and my
hacking. But I don't know how to proceed further, so I'm waiting for 
some hints or patches :-)

Side note: I was able some time ago to use this controller with the
mv_sata driver 3.40, also with a RHEL kernel, without any fiddling
with ACPI.

--
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

