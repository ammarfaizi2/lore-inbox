Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWICN5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWICN5F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 09:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWICN5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 09:57:05 -0400
Received: from mxsf20.cluster1.charter.net ([209.225.28.220]:38569 "EHLO
	mxsf20.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751113AbWICN5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 09:57:01 -0400
X-IronPort-AV: i="4.08,204,1154923200"; 
   d="scan'208"; a="816929636:sNHT45860814"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17658.57131.33728.434385@smtp.charter.net>
Date: Sun, 3 Sep 2006 09:56:59 -0400
From: "John Stoffel" <john@stoffel.org>
To: "John Stoffel" <john@stoffel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       jeff@garzik.org, alan@redhat.com
Subject: Re: 2.6.18-rc4-mm1 ATA oops on HPT302 controller
In-Reply-To: <17657.56290.549931.187652@smtp.charter.net>
References: <17648.47873.675155.821074@stoffel.org>
	<1157151612.6271.338.camel@localhost.localdomain>
	<17657.56290.549931.187652@smtp.charter.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
Alan> Ar Sad, 2006-08-26 am 17:20 -0400, ysgrifennodd John Stoffel:
>>> irq 16: nobody cared (try booting with the "irqpoll" option)
>>> [<c013e3e4>] __report_bad_irq+0x24/0x90
>>> [<c013e668>] note_interrupt+0x218/0x250
>>> [<c013d8f3>] handle_IRQ_event+0x33/0x70

Alan> Looks like ACPI routing problems

John> Hmmm, so maybe there's something in the -mm patches which is
John> screwing up things?  I'll try 2.6.18-rc5-mm1 then with my
John> regular .config and see what happens.

Ok, so once I found and fixed the 'if BLOCK' issue in
drivers/md/Kconfig, I've been able to compile and boot 2.6.18-rc5-mm1
without any problems using the old drivers/ide/pci/hpt366.c driver,
and I'm not seeing any IRQ problems.  I get the following in dmesg:

  HPT302: IDE controller at PCI slot 0000:03:06.0
  ACPI: PCI Interrupt 0000:03:06.0[A] -> GSI 18 (level, low) -> IRQ 18
  HPT302: chipset revision 1
  HPT302: DPLL base: 66 MHz, f_CNT: 101, assuming 33 MHz PCI
  HPT302: using 66 MHz DPLL clock
  HPT302: 100% native mode on irq 18
      ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:DMA, hdf:pio
      ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:DMA, hdh:pio
  Probing IDE interface ide2...
  hde: WDC WD1200JB-00CRA1, ATA DISK drive
  ide2 at 0xecf8-0xecff,0xecf2 on irq 18
  Probing IDE interface ide3...
  hdg: WDC WD1200JB-00EVA0, ATA DISK drive
  ide3 at 0xece0-0xece7,0xecda on irq 18
  Probing IDE interface ide1...
  hde: max request size: 128KiB
  hde: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
  hde: cache flushes not supported
   hde: hde1
  hdg: max request size: 512KiB
  hdg: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
  hdg: cache flushes supported
   hdg: hdg1


But for 2.6.18-rc4-mm3 with ATA version I get:

    pata_hpt37x: BIOS has not set timing clocks.
    hpt37x: HPT302: Bus clock 33MHz.
    ACPI: PCI Interrupt 0000:03:06.0[A] -> GSI 18 (level, low) -> IRQ 18
    ata1: PATA max UDMA/133 cmd 0xECF8 ctl 0xECF2 bmdma 0xE800 irq 18
    ata2: PATA max UDMA/133 cmd 0xECE0 ctl 0xECDA bmdma 0xE808 irq 18
    scsi2 : pata_hpt37x
    ata1.00: ATA-5, max UDMA/100, 234441648 sectors: LBA 
    ata1.00: ata1: dev 0 multi count 16
    Find mode for 12 reports C829C62
    Find mode for DMA 69 reports 1C6DDC62
    ata1.00: configured for UDMA/100
    scsi3 : pata_hpt37x
    ata2.00: ATA-6, max UDMA/100, 234441648 sectors: LBA48 
    ata2.00: ata2: dev 0 multi count 16
    Find mode for 12 reports C829C62
    Find mode for DMA 69 reports 1C6DDC62
    ata2.00: configured for UDMA/100
    scsi 2:0:0:0: Direct-Access     ATA      WDC WD1200JB-00C 17.0 PQ: 0 ANSI: 5
    SCSI device sdc: 234441648 512-byte hdwr sectors (120034 MB)
    sdc: Write Protect is off
    SCSI device sdc: drive cache: write back
    SCSI device sdc: 234441648 512-byte hdwr sectors (120034 MB)
    sdc: Write Protect is off
    SCSI device sdc: drive cache: write back
     sdc: sdc1
    sd 2:0:0:0: Attached scsi disk sdc
    sd 2:0:0:0: Attached scsi generic sg3 type 0
    scsi 3:0:0:0: Direct-Access     ATA      WDC WD1200JB-00E 15.0 PQ: 0 ANSI: 5
    SCSI device sdd: 234441648 512-byte hdwr sectors (120034 MB)
    sdd: Write Protect is off
    SCSI device sdd: drive cache: write back
    SCSI device sdd: 234441648 512-byte hdwr sectors (120034 MB)
    sdd: Write Protect is off
    SCSI device sdd: drive cache: write back
     sdd: sdd1
    sd 3:0:0:0: Attached scsi disk sdd
    sd 3:0:0:0: Attached scsi generic sg4 type 0


So I wonder if I'm just getting the wrong DPLL clock setup in the
drivers/ata/pata_hpt37x.c HPT302 sections?  I'm slowing working
through the code trying to figure it out, but a one month old and a
four year don't give me alot of un-interrupted time to poke at this. 

John> I thought the 440GX was a well understood chip, though old now
John> obviously.  :]   I'll run some more tests and see what happens under
John> -mm kernels with the old IDE drivers.

Interestingly enough, I'm not seeing any IRQ problems when I boot
2.6.18-rc5-mm1 and use the old IDE driver, not to say that there's not
something on IRQ18 which is screwing things up.  Here's my info.  As
you can see, I've got a lot of devices sharing IRQs on this box.  

  > cat /proc/interrupts 
	     CPU0       CPU1       
    0:   18691454   22263933   IO-APIC-edge     timer
    1:      12123      14082   IO-APIC-edge     i8042
    4:        496          7   IO-APIC-edge     serial
    6:          0          3   IO-APIC-edge     floppy
    8:          4          0   IO-APIC-edge     rtc
    9:          0          0   IO-APIC-fasteoi  acpi
   11:      46304      37965   IO-APIC-edge     Cyclom-Y
   12:      20161      23761   IO-APIC-edge     i8042
   14:     194172     168410   IO-APIC-edge     ide0
   16:    1808966    2057575   IO-APIC-fasteoi  ohci_hcd:usb4, mga@pci:0000:01:00.0
   17:   12035631         20   IO-APIC-fasteoi  ehci_hcd:usb1, Ensoniq AudioPCI, eth0
   18:     880579    1057408   IO-APIC-fasteoi  ide2, ide3, aic7xxx, aic7xxx, ohci1394
   19:          0          0   IO-APIC-fasteoi  ohci_hcd:usb2, uhci_hcd:usb3
  NMI:          0          0 
  LOC:   40959188   40959346 
  ERR:          0
  MIS:          6


If there's any tests or patches I can run to help out here, please let
me know.

Thanks,
John

-- 
VGER BF report: U 0.5
