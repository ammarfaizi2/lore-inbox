Return-Path: <linux-kernel-owner+w=401wt.eu-S1030268AbXADXaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbXADXaA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 18:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbXADXaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 18:30:00 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:14578 "EHLO
	pd2mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030268AbXADX37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 18:29:59 -0500
Date: Thu, 04 Jan 2007 17:29:41 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: PROBLEM: sata_sil24 lockups under heavy i/o
In-reply-to: <fa.xijtCUCn78j3D/nyqVcCMUn1RIA@ifi.uio.no>
To: Mark Wagner <mark@lanfear.net>
Cc: linux-kernel@vger.kernel.org
Message-id: <459D8DE5.3050503@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.xijtCUCn78j3D/nyqVcCMUn1RIA@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Wagner wrote:
> [1.] One line summary of the problem:
> 
> sata_sil24 lockups under heavy i/o
> 
> [2.] Full description of the problem/report:
> 
> I have a PCI-based sata_sil24 card. It has 4 ports. It was functioning
> well with two disks attached. Once I attached 2 additional disks (for
> a total of 4) and started heavy i/o (extending a software raid5 device)
> the system began locking up for a few minutes at a time. After the
> system recovers the disk transfer speed is reduced from UDMA/100 to
> UDMA/66 or UDMA/44.

I don't think this is anything to do with the sata_sil24 driver. 
Something really wierd seems to be going on with interrupts on this machine:

> /proc/interrupts
> 
>           CPU0
>   0:   20507744    XT-PIC-XT        timer
>   1:        262    XT-PIC-XT        i8042
>   2:          0    XT-PIC-XT        cascade
>   5:     962175    XT-PIC-XT        sym53c8xx, uhci_hcd:usb1,
> uhci_hcd:usb2
>   7:       3678    XT-PIC-XT        parport0
>   8:          2    XT-PIC-XT        rtc
>  10:    9153035    XT-PIC-XT        ide2, eth0
>  11:         30    XT-PIC-XT        sym53c8xx
>  12:    1026266    XT-PIC-XT        libata
>  14:     840214    XT-PIC-XT        ide0
>  15:     569928    XT-PIC-XT        ide1
> NMI:      11264
> LOC:   20506755
> ERR:        234
> MIS:          0
> 
> Output of dmesg:
> 

...

> Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!

Hmm, you might want to try not forcing the local APIC enabled by 
removing the lapic option from the kernel command line. Don't know if it 
could be related though.

> VP_IDE: IDE controller at PCI slot 0000:00:04.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:04.1
>     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
> Probing IDE interface ide0...
> input: AT Translated Set 2 keyboard as /class/input/input0
> hda: MAXTOR STM3160812A, ATA DISK drive
> hda: IRQ probe failed (0xfffffef8)
> hdb: WDC WD1600JB-00EVA0, ATA DISK drive
> hdb: IRQ probe failed (0xfffffef8)
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: IC35L120AVVA07-0, ATA DISK drive
> hdc: IRQ probe failed (0xffffbef8)
> hdd: WDC WD1200JB-00GVA0, ATA DISK drive
> hdd: IRQ probe failed (0xffffbef8)

These "IRQ proble failed" errors don't seem right at all.

Then:

> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: transmit timed out, tx_status 00 status e000.
>   diagnostics: net 0cd8 media 8880 dma 000000a0 fifo 0000
>   Flags; bus-master 1, dirty 203390(14) current 203406(14)
>   Transmit list 01bea840 vs. c1beaac0.

So eth0's not happy.

> ata2.00: exception Emask 0x0 SAct 0x7 SErr 0x0 action 0x6 frozen
> ata2.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata2.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata2.00: tag 2 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata2: hard resetting port

The SATA card is getting timeouts. And from your other mail:

 > hda: DMA timeout error
 > hda: dma timeout error: status=0x58 { DriveReady SeekComplete 
DataRequest }
 > ide: failed opcode was: unknown
 > hda: status timeout: status=0xd0 { Busy }
 > ide: failed opcode was: unknown
 > hda: no DRQ after issuing MULTWRITE_EXT

Your onboard IDE controller is also timing out.. Sounds to me like some 
kind of general IRQ problem, though you'd have to be losing interrupts 
on IRQ 10, 12 and 14 which seems pretty extreme. Maybe a hardware 
problem, are you sure you have enough power to run this many drives in 
the box?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

