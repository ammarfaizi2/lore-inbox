Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbTKEAH4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 19:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTKEAHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 19:07:55 -0500
Received: from cherryhinton.org.uk ([194.106.52.201]:2368 "EHLO ivimey.org")
	by vger.kernel.org with ESMTP id S262349AbTKEAHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 19:07:53 -0500
Message-Id: <5.2.0.9.0.20031104234330.02451b70@mailhost.ivimey.org>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 05 Nov 2003 00:07:42 +0000
To: linux-kernel@vger.kernel.org
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Subject: 2.6.0-test9 SATA and 1394 problems
Cc: Ben Collins <bcollins@debian.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Spam-Score: 0.1 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I have been running 2.6.0-t9 on an Asus A7V600 VIA VT600-based MB for a few 
days now. All seems relatively stable, which is good. A few issues to 
report, though, the most serious of which is that my SATA controller (VIA 
8237 Southbridge) is only detected properly when the machine is fully 
power-cycled (that is, plug out the back, not just soft-off). When that is 
done, all seems well and the drives run fine. If you reboot the machine 
without a full power-cycle, the SATA controller is detected but no drives 
are found. Drives are new Seagate 7200.7 SATA 120Gig. I've tried disabling 
acpi, setting pci=noacpi and setting pci=usepirqmask as suggested in the 
acpi startup messages, but none of this helped.

The BIOS has never reported the existence of the SATA drives on bootup as 
it does for PATA drives. I have updated the BIOS to the latest release 
version (1005).

I should always get this:
VIA8237SATA: IDE controller at PCI slot 0000:00:0f.0
VIA8237SATA: chipset revision 128
VIA8237SATA: 100% native mode on irq 20
     ide4: BM-DMA at 0x9000-0x9007, BIOS settings: hdi:pio, hdj:pio
     ide5: BM-DMA at 0x9008-0x900f, BIOS settings: hdk:pio, hdl:pio
hdi: ST3120026AS, ATA DISK drive
ide4 at 0xa400-0xa407,0xa002 on irq 20
hdk: ST3120026AS, ATA DISK drive
ide5 at 0x9800-0x9807,0x9402 on irq 20

but for a failed boot I just get this:

VIA8237SATA: IDE controller at PCI slot 0000:00:0f.0
VIA8237SATA: chipset revision 128
VIA8237SATA: 100% native mode on irq 20
     ide4: BM-DMA at 0x9000-0x9007, BIOS settings: hdi:pio, hdj:pio
     ide5: BM-DMA at 0x9008-0x900f, BIOS settings: hdk:pio, hdl:pio

Why, btw, are two drives allocated when SATA is limited to one drive per 
interface? Is it just historical?

I don't know if this is a "big thing" or not, but I also get this stack 
dump when the ohci1394 module is loaded. or when the kernel initialises 
that code if built-in:

ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[19]  MMIO=[f1000000-f10007ff]  Max 
Packet=[1024]
Debug: sleeping function called from invalid context at mm/slab.c:1856
in_atomic():1, irqs_disabled():0
Call Trace:
  [<c01200fb>] __might_sleep+0xab/0xf0
  [<c0143529>] __kmalloc+0x89/0x90
  [<f99ff53e>] hpsb_create_hostinfo+0x5e/0xe0 [ieee1394]
  [<f9a04284>] nodemgr_add_host+0x24/0x130 [ieee1394]
  [<f99bf7f0>] ohci_initialize+0x210/0x220 [ohci1394]
  [<f99ffd94>] highlevel_add_host+0x74/0x80 [ieee1394]
  [<f99ff31d>] hpsb_add_host+0x6d/0xa0 [ieee1394]
  [<f99c3b02>] ohci1394_pci_probe+0x482/0x590 [ohci1394]
  [<f99c1870>] ohci_irq_handler+0x0/0x7b0 [ohci1394]
  [<c01f528b>] pci_device_probe_static+0x4b/0x60
  [<c01f52d6>] __pci_device_probe+0x36/0x50
  [<c01f531c>] pci_device_probe+0x2c/0x50
  [<c024bb0d>] bus_match+0x3d/0x70
  [<c024bc3a>] driver_attach+0x5a/0x90
  [<c024bf2b>] bus_add_driver+0x9b/0xb0
  [<c024c391>] driver_register+0x31/0x40
  [<c01f54fb>] pci_register_driver+0x5b/0x80
  [<f9964015>] ohci1394_init+0x15/0x3c [ohci1394]
  [<c01392ba>] sys_init_module+0x14a/0x2a0
  [<c010a409>] sysenter_past_esp+0x52/0x71

ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c0d00001f79969]

Regards,

Ruth


