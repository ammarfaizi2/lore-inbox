Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318086AbSGaMcr>; Wed, 31 Jul 2002 08:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317996AbSGaMcr>; Wed, 31 Jul 2002 08:32:47 -0400
Received: from copper.ftech.net ([212.32.16.118]:49618 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id <S318135AbSGaMcp>;
	Wed, 31 Jul 2002 08:32:45 -0400
Message-ID: <7C078C66B7752B438B88E11E5E20E72E0EF481@GENERAL.farsite.co.uk>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Memory thrashing in the Kernel.
Date: Wed, 31 Jul 2002 13:31:49 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I have developed a Kernel module with a sockets Address Family that
interfaces to our hardware.  We are shifting large amounts of data through
the card at high speed.  To get up-and-running quickly I just kmalloc'd and
kfree'd memory for the buffers and control structures as required.  When I
start a soak test on the 2.4.17 Kernel, the memory stats hover at the
following

             total       used       free     shared    buffers     cached
Mem:        189932     184892       5040          0       2392     161564
-/+ buffers/cache:      20936     168996
Swap:       385552          0     385552

Whereas on the 2.2.19 Kernel I get

             total       used       free     shared    buffers     cached
Mem:        192604      98512      94092      33944      66132       8872
-/+ buffers/cache:      23508     169096
Swap:       393552          0     393552

I don't seem to run out, so I think I must be kfree'ing all the memory.
When I stop the test, the not much of the memory seems to make it back to
the free pool.

Sometimes, under very heavy load conditions, a call to kmalloc fails (no
memory) on the 2.4.17 system.  I guess that the memory recycling cannot keep
up?

Here are my questions:

1) Was there a big change in memory handling between the 2.2.x and 2.4.x
kernels?  The 2.2.x memory handling seems to be more responsive than the
2.4.x

2) Is there a config change I can make speed up the recycling?

3) I'd much prefer to stop thrashing the memory at all.  So, does anyone
know of some buffer pool handling routines that I could use?


Thanks

Kevin

-----Original Message-----
From: Mark Lord [mailto:mlord@pobox.com]
Sent: 31 July 2002 13:19
To: Mukesh Rajan
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE, putting HD to sleep causes "lost interrupt"


Well, the answer is very simple, then:  DON'T DO THAT.

When an ATA (IDE) drive is put to sleep (-Y),
it *requires* a reset to revive it for any future commands.

The IDE driver doesn't know about the -Y, so it just attempts
I/O a few times before digging out the BIG hammer and doing a reset.

All is well.
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com


Mukesh Rajan wrote:
> 
> hi,
> 
> things work perfectly fine on my desktop. but on my laptop (toshiba
> satellite) if i try,
> 
> %hdparm -Y /dev/hda           <--- put to sleep followed by
> %hdparm -C /dev/hda           <--- query status
> 
> gives me
> 
> hda: lost interrupt
> hda: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hda: irq timeout: status=0x50 { DriveReady SeekComplete }
> hda: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hda: irq timeout: status=0x50 { DriveReady SeekComplete }
> hda: lost interrupt
> hda: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hda: irq timeout: status=0x50 { DriveReady SeekComplete }
> hda: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hda: irq timeout: status=0x50 { DriveReady SeekComplete }
> hda: DMA disabled
> ide0: reset: success
> 
> if i try the above from X, the machine freezes and i need to do hard
> reboot.
> 
> the boot message regarding ide are as follows
> 
> boot messages
> -------------
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> ALI15X3: IDE controller on PCI bus 00 dev 20
> PCI: No IRQ known for interrupt pin A of device 00:04.0. Please try using
> pci=biosirq.
> ALI15X3: chipset revision 195
> ALI15X3: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xeff0-0xeff7, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xeff8-0xefff, BIOS settings: hdc:DMA, hdd:pio
> hda: TOSHIBA MK2018GAP, ATA DISK drive
> 
> the closest i think i got to on google is the following but there are no
> answers
> 
> http://mail.nl.linux.org/kernelnewbies/2001-01/msg00064.html
> 
> please help.
> 
> - mukesh
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
