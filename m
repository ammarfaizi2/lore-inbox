Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWAWKDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWAWKDj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 05:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWAWKDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 05:03:39 -0500
Received: from usmimesweeper.bluearc.com ([63.203.197.133]:34572 "EHLO
	us-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S932422AbWAWKDj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 05:03:39 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Out of Memory: Killed process 16498 (java).
Date: Mon, 23 Jan 2006 10:03:30 -0000
Message-ID: <89E85E0168AD994693B574C80EDB9C270355627D@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Out of Memory: Killed process 16498 (java).
Thread-Index: AcYf/vr9AGDZ18sRSYC56TAG/xNAXwABOZeg
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: "Andrew Morton" <akpm@osdl.org>, <davej@redhat.com>,
       <linux-kernel@vger.kernel.org>, <lwoodman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There's your problem, apparently both of these queues is 
> being set to a
> limit lower than blk_max_low_pfn which means the block layer 
> will revert
> to the isa dma bounce zone for that queue... There's room for
> improvement in the logic that chooses what zone to allocate 
> from.

So I presume that requires a source fix. Or can it be configured out?

-- 
Andy, BlueArc Engineering
 

> -----Original Message-----
> From: Jens Axboe [mailto:axboe@suse.de] 
> Sent: 23 January 2006 09:28
> To: Andy Chittenden
> Cc: Andrew Morton; davej@redhat.com; 
> linux-kernel@vger.kernel.org; lwoodman@redhat.com
> Subject: Re: Out of Memory: Killed process 16498 (java).
> 
> On Sat, Jan 21 2006, Andy Chittenden wrote:
> > ok - here is the complete dmesg as of today:
> > 
> > ksize
> > usbmon: debugfs is not available
> > mice: PS/2 mouse device common for all mice
> > NET: Registered protocol family 2
> > IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
> > TCP established hash table entries: 524288 (order: 10, 
> 4194304 bytes)
> > TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
> > TCP: Hash tables configured (established 524288 bind 65536)
> > TCP reno registered
> > TCP bic registered
> > NET: Registered protocol family 1
> > NET: Registered protocol family 17
> > NET: Registered protocol family 8
> > NET: Registered protocol family 20
> > ACPI wakeup devices: 
> > PCI0 PS2K PS2M UAR2 UAR1 AC97 USB1 USB2 USB3 USB4 EHCI PWRB SLPB 
> > ACPI: (supports S0 S1 S3 S4 S5)
> > Freeing unused kernel memory: 148k freed
> > Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> > ide: Assuming 33MHz system bus speed for PIO modes; 
> override with idebus=xx
> > input: AT Translated Set 2 keyboard as /class/input/input0
> > VP_IDE: IDE controller at PCI slot 0000:00:0f.1
> > GSI 17 sharing vector 0xB1 and IRQ 17
> > ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 17
> > PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 1
> > VP_IDE: chipset revision 6
> > VP_IDE: not 100% native mode: will probe irqs later
> > VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on 
> pci0000:00:0f.1
> >     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
> >     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
> > Probing IDE interface ide0...
> > hda: HDS722525VLAT80, ATA DISK drive
> > hdb: Maxtor 6Y200P0, ATA DISK drive
> > bounce: queue ffff81013fa312d8, setting pfn 1310720, max_low 1310720
> > bounce: queue ffff81013fa312d8, setting pfn 1048575, max_low 1310720
> > isa bounce pool size: 16 pages
> > bounce: queue ffff81013fa31048, setting pfn 1310720, max_low 1310720
> > bounce: queue ffff81013fa31048, setting pfn 1048575, max_low 1310720
> 
> There's your problem, apparently both of these queues is 
> being set to a
> limit lower than blk_max_low_pfn which means the block layer 
> will revert
> to the isa dma bounce zone for that queue... There's room for
> improvement in the logic that chooses what zone to allocate 
> from. It's a
> little problematic since there are two reasons why you would have to
> bounce: the hardware cannot support a "high" address, _or_ the driver
> cannot support a highmem page. The latter can be fixed, the former is
> given of course.
> 
> So choosing the gfp mask is a composite of whether the machine has
> highmem and the hardware/driver capabilities.
> 
> -- 
> Jens Axboe
> 
> 
