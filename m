Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267917AbTBELGA>; Wed, 5 Feb 2003 06:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267915AbTBELGA>; Wed, 5 Feb 2003 06:06:00 -0500
Received: from [217.167.51.129] ([217.167.51.129]:25337 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S267917AbTBELF6>;
	Wed, 5 Feb 2003 06:05:58 -0500
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: alan@redhat.com
Cc: Stephan von Krawczynski <skraw@ithnet.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030205104845.17a0553c.skraw@ithnet.com>
References: <20030202161837.010bed14.skraw@ithnet.com>
	 <3E3D4C08.2030300@pobox.com> <20030202185205.261a45ce.skraw@ithnet.com>
	 <3E3D6367.9090907@pobox.com>  <20030205104845.17a0553c.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044443761.685.44.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 05 Feb 2003 12:16:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Okay, I had to watch for it a bit longer and it turns out that the kernel PDC driver has a problem in this shared interrupt setup. When loads get high it seems to run into some timing problem which causes things like:
> 
> Feb  4 01:02:22 admin kernel: hde: dma_intr: status=0xd0 { Busy }
> Feb  4 01:02:22 admin kernel: 
> Feb  4 01:02:22 admin kernel: PDC202XX: Primary channel reset.
> Feb  4 01:02:22 admin kernel: ide2: reset: success
> Feb  4 01:02:23 admin kernel: hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> Feb  4 01:02:23 admin kernel: 
> Feb  4 01:02:23 admin kernel: hde: drive not ready for command
> Feb  4 01:02:23 admin kernel: hde: status error: status=0x50 { DriveReady SeekComplete }
> Feb  4 01:02:23 admin kernel: 
> Feb  4 01:02:23 admin kernel: hde: no DRQ after issuing WRITE
> Feb  4 01:02:23 admin kernel: hde: status timeout: status=0xd0 { Busy }
> Feb  4 01:02:23 admin kernel: 

Hi Alan !

I'm trying to get some sense out of the above report as it seem to match
a problem a user reported me as well. It's interesting because it's
apparently running UP, so it's not the SMP race found by Ross. It's
definitely a problem with shared interrupt though.

I've followed the code path involved here. Basically, we had
ide_dma_intr() called while the drive was busy. This is strange for a
simple reason: Even if we got the wrong interrupt (shared interrupt),
__ide_dma_test_irq() should have returned 0, and so ide_dma_intr
shouldn't have been called.

Assuming the driver was doing basic read/write operations, I checked
the code, and while it seems that do_rw_disk() is called without
the lock held nor interrupts masked, I see no obvious race.
drive->waiting_for_dma is set before setting up the handler and
issuing the command, and while the DMA engine is indeed started
only after sending the command, it's INTR bit have been cleared
previously (I suppose it can't be stale, or can it while the DMA
haven't been started yet ? In this case we would need to take
the lock here).

> Results are that the drive itself just hangs and has to be powered off (resetting the box does not work). The drives worked (and works) fine in non shared-interrupt context. Controller is:
> 
> <6>PDC20268: IDE controller at PCI slot 01:02.0
> <6>PCI: Found IRQ 11 for device 01:02.0
> <6>PDC20268: chipset revision 1
> <6>PDC20268: not 100%% native mode: will probe irqs later
> <6>    ide2: BM-DMA at 0x7400-0x7407, BIOS settings: hde:pio, hdf:pio
> <6>    ide3: BM-DMA at 0x7408-0x740f, BIOS settings: hdg:pio, hdh:pio
> <4>hdc: AOPEN CD-RW CRW2440, ATAPI CD/DVD-ROM drive
> <4>hde: ST380021A, ATA DISK drive
> <4>blk: queue c034e1f8, I/O limit 4095Mb (mask 0xffffffff)
> <4>hdg: IC35L060AVER07-0, ATA DISK drive
> <4>blk: queue c034e664, I/O limit 4095Mb (mask 0xffffffff)
> <4>ide1 at 0x170-0x177,0x376 on irq 15
> <4>ide2 at 0x8800-0x8807,0x8402 on irq 11
> <4>ide3 at 0x8000-0x8007,0x7802 on irq 11
> <4>hde: host protected area => 1
> <6>hde: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
> <4>hdg: host protected area => 1
> <6>hdg: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(100)
> <6>Partition check:
> <6> hde: hde1
> <6> hdg:<6> [PTBL] [7476/255/63] hdg1
> 
> Regards,
> Stephan
> 
> PS: tg3 does great! Good job, Jeff...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
