Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267889AbTBEJjT>; Wed, 5 Feb 2003 04:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267890AbTBEJjT>; Wed, 5 Feb 2003 04:39:19 -0500
Received: from mail.ithnet.com ([217.64.64.8]:53002 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S267889AbTBEJjS>;
	Wed, 5 Feb 2003 04:39:18 -0500
Date: Wed, 5 Feb 2003 10:48:45 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
Message-Id: <20030205104845.17a0553c.skraw@ithnet.com>
In-Reply-To: <3E3D6367.9090907@pobox.com>
References: <20030202161837.010bed14.skraw@ithnet.com>
	<3E3D4C08.2030300@pobox.com>
	<20030202185205.261a45ce.skraw@ithnet.com>
	<3E3D6367.9090907@pobox.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Feb 2003 13:28:55 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> > To make sure I will let it stress-test overnight and send you the results in
> > about 15 hours from now on. If everything does fine I will redo with ide2,ide3
> > on same interrupt, too. Just to see what happens with these Promise things...
> 
> 
> great.
> 
> though who knows with the Promise stuff... :)  I hope it's not their 
> binary-only junk...
> 
> 	Jeff

Okay, I had to watch for it a bit longer and it turns out that the kernel PDC driver has a problem in this shared interrupt setup. When loads get high it seems to run into some timing problem which causes things like:

Feb  4 01:02:22 admin kernel: hde: dma_intr: status=0xd0 { Busy }
Feb  4 01:02:22 admin kernel: 
Feb  4 01:02:22 admin kernel: PDC202XX: Primary channel reset.
Feb  4 01:02:22 admin kernel: ide2: reset: success
Feb  4 01:02:23 admin kernel: hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Feb  4 01:02:23 admin kernel: 
Feb  4 01:02:23 admin kernel: hde: drive not ready for command
Feb  4 01:02:23 admin kernel: hde: status error: status=0x50 { DriveReady SeekComplete }
Feb  4 01:02:23 admin kernel: 
Feb  4 01:02:23 admin kernel: hde: no DRQ after issuing WRITE
Feb  4 01:02:23 admin kernel: hde: status timeout: status=0xd0 { Busy }
Feb  4 01:02:23 admin kernel: 

Results are that the drive itself just hangs and has to be powered off (resetting the box does not work). The drives worked (and works) fine in non shared-interrupt context. Controller is:

<6>PDC20268: IDE controller at PCI slot 01:02.0
<6>PCI: Found IRQ 11 for device 01:02.0
<6>PDC20268: chipset revision 1
<6>PDC20268: not 100%% native mode: will probe irqs later
<6>    ide2: BM-DMA at 0x7400-0x7407, BIOS settings: hde:pio, hdf:pio
<6>    ide3: BM-DMA at 0x7408-0x740f, BIOS settings: hdg:pio, hdh:pio
<4>hdc: AOPEN CD-RW CRW2440, ATAPI CD/DVD-ROM drive
<4>hde: ST380021A, ATA DISK drive
<4>blk: queue c034e1f8, I/O limit 4095Mb (mask 0xffffffff)
<4>hdg: IC35L060AVER07-0, ATA DISK drive
<4>blk: queue c034e664, I/O limit 4095Mb (mask 0xffffffff)
<4>ide1 at 0x170-0x177,0x376 on irq 15
<4>ide2 at 0x8800-0x8807,0x8402 on irq 11
<4>ide3 at 0x8000-0x8007,0x7802 on irq 11
<4>hde: host protected area => 1
<6>hde: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
<4>hdg: host protected area => 1
<6>hdg: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(100)
<6>Partition check:
<6> hde: hde1
<6> hdg:<6> [PTBL] [7476/255/63] hdg1

Regards,
Stephan

PS: tg3 does great! Good job, Jeff...
