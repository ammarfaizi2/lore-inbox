Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbVCVB1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVCVB1n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 20:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbVCVBYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 20:24:50 -0500
Received: from fire.osdl.org ([65.172.181.4]:49557 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262226AbVCVBWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:22:05 -0500
Date: Mon, 21 Mar 2005 17:22:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm3: SIS5513 DMA problem (set_drive_speed_status)
Message-Id: <20050321172207.6b4a77e8.akpm@osdl.org>
In-Reply-To: <20050314161528.575f3a77@phoebee>
References: <20050314161528.575f3a77@phoebee>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Zwickel <martin.zwickel@technotrend.de> wrote:
>
> Hi,
> 
> just tried the 2.6.11-mm3 and at boot-time my start scripts try to
> enable DMA on my disk (hdparm -m16 -c1 -u1 -X69 /dev/hda).

Martin, could you please test 2.6.12-rc1? 

(2.6.12-rc1-mm1 did not include Bart's tree because that's causing an oops
in idecd_open() on ppc64 which I need to look into).

(But 2.6.11-mm3 didn't include Bart's tree either)

What happens if you don't run hdparm at boot-time and just let the kernel
handle the mode setting?


> But while running hdparm, the kernel waits many seconds and gives me
> some DMA warnings/errors:
> 
> [dmesg output]
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> SIS5513: IDE controller at PCI slot 0000:00:02.5
> SIS5513: chipset revision 0
> SIS5513: not 100% native mode: will probe irqs later
> SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
>     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
> Probing IDE interface ide0...
> hda: WDC WD1600JB-00GVA0, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: IDE DVD-ROM 16X, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> Probing IDE interface ide2...
> Probing IDE interface ide3...
> Probing IDE interface ide4...
> Probing IDE interface ide5...
> hda: max request size: 1024KiB
> hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
> hda: cache flushes supported
>  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
> hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> 
> ....
> 
> BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
> 
> ....
> 
> hda: set_drive_speed_status: status=0xd0 { Busy }
> 
> ide: failed opcode was: unknown
> hda: dma_timer_expiry: dma status == 0x41
> hda: DMA timeout error
> hda: dma timeout error: status=0xd0 { Busy }
> 
> ide: failed opcode was: unknown
> hda: DMA disabled
> ide0: reset: success
> hda: CHECK for good STATUS
> hdc: Speed warnings UDMA 3/4/5 is not functional.
> [/dmesg output]
> 
> That happened also with 2.6.11-rc3 since I thought I should switch away
> from my 2.6.8-rc2-mm1 (the best kernel ever ;)).
> 
> In kernel config I enabled:
> CONFIG_EDD=y
> 
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> CONFIG_BLK_DEV_IDECD=y
> 
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_GENERIC=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_SIS5513=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_IDEDMA_AUTO=y
> 
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_ACPI=y
> 
> 
> My machine:
> Pentium 4 - 2,4Ghz
> 
> 
> cat /proc/interrupts:
>  14:      26411          XT-PIC  ide0
>  15:         24          XT-PIC  ide1
> 
> 
> lspci -vvxxx:
> 0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
>         Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 128
>         Region 4: I/O ports at ff00 [size=16]
> 00: 39 10 13 55 05 00 00 02 00 80 01 01 00 80 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 01 ff 00 00 00 00 00 00 00 00 00 00 39 10 13 55
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 06 00 00 00 00 00
> 50: f2 00 f2 00 2a 96 d5 c0 00 00 00 00 00 00 00 00
> 60: fb aa fb aa 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 17 21 06 04 00 00 00 00 56 23 06 04 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 
> 
> Any hint/clue about that?
> 
> Regards,
> Martin
> 
> -- 
> MyExcuse:
> Write-only-memory subsystem too slow for this machine. Contact your
> local dealer.
> 
> Martin Zwickel <martin.zwickel@technotrend.de>
> Research & Development
> 
> TechnoTrend AG <http://www.technotrend.de>
> 
