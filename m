Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266289AbTGEGjs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 02:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266290AbTGEGjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 02:39:48 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:11276
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S266289AbTGEGjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 02:39:45 -0400
Date: Fri, 4 Jul 2003 23:49:55 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Ryan Mack <rmack@mackman.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21 ServerWorks DMA Bugs
In-Reply-To: <Pine.LNX.4.53.0307042325430.3837@mackman.net>
Message-ID: <Pine.LNX.4.10.10307042348420.21771-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


cat /proc/ide/hd{a,c}/settings

You should see unmask listed.

echo unmask:1 > /proc/ide/hd{a,c}/settings

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Fri, 4 Jul 2003, Ryan Mack wrote:

> I've real the other threads but nothing touches on my specific issue.  I
> have a dual P4 Xeon Dell PowerEdge 1600SC with a Fusion MPT SCSI
> controller and a ServerWorks CSB5 IDE chipset.  All the HDs are on the
> SCSI bus, and only my CD reader and my DVD writer are on the IDE bus (one
> on each channel).  Hyperthreading is enabled (4 logical processors).  I am 
> using GCC 3.2.2.
> 
> The CD readers is the blacklisted 'SAMSUNG CD-ROM SC-148C' and I never use
> it so I can remove it if needed.  The DVD writer is a 'SONY DVD RW
> DRU-500A'.  Both are going through the ide-scsi driver.  Whenever I
> read/write CDs in the DVD writer, I get very high system load (50% on one
> CPU), even though DMA seems to be enabled.
> 
> In addition, I get horrible clock skew.  After burning a 50 meg audio
> track, my clock is 10 seconds off.  Enabled unmasked interrupts and 32 bit
> bus IO reduces the clock skew to about .1 seconds, but this adds up.
> 
> I've tried everything, even downgrading to 2.4.20, although under 2.4.20 I
> can't seem to find an appropriate devfs entry to run hdparm on, so I'm
> unable to unmask interrupts and switch bus IO width.  Not compiling the
> CSB5 driver doesn't make a difference either.
> 
> Anyhow, anybody know what might be going on?  Excerpts from the relevant
> files included below.
> 
> Thanks, Ryan
> 
> 
> dmesg:
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> SvrWks CSB5: IDE controller at PCI slot 00:0f.1
> SvrWks CSB5: chipset revision 147
> SvrWks CSB5: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0x08b0-0x08b7, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0x08b8-0x08bf, BIOS settings: hdc:DMA, hdd:pio
> hda: SONY DVD RW DRU-500A, ATAPI CD/DVD-ROM drive
> hdc: SAMSUNG CD-ROM SC-148C, ATAPI CD/DVD-ROM drive
> hdc: Disabling (U)DMA for SAMSUNG CD-ROM SC-148C
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: attached ide-scsi driver.
> hdc: attached ide-scsi driver.
> scsi1 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: SONY      Model: DVD RW DRU-500A   Rev: 2.0c
>   Type:   CD-ROM                             ANSI SCSI revision: 02
>   Vendor: SAMSUNG   Model: CD-ROM SC-148C    Rev: B105
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
> Attached scsi CD-ROM sr1 at scsi1, channel 0, id 1, lun 0
> sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
> Uniform CD-ROM driver Revision: 3.12
> sr1: scsi3-mmc drive: 1x/48x cd/rw xa/form2 cdda tray
> 
> 
> .config:
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDESCSI=m
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_BLK_DEV_GENERIC=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_BLK_DEV_SVWKS=y
> CONFIG_IDEDMA_AUTO=y
> CONFIG_BLK_DEV_IDE_MODES=y
> 
> CONFIG_SCSI=y
> CONFIG_BLK_DEV_SD=y
> CONFIG_SD_EXTRA_DEVS=40
> CONFIG_BLK_DEV_SR=m
> CONFIG_SR_EXTRA_DEVS=2
> CONFIG_CHR_DEV_SG=m
> CONFIG_SCSI_CONSTANTS=y
> 
> CONFIG_FUSION=y
> CONFIG_FUSION_BOOT=y
> CONFIG_FUSION_MAX_SGE=40
> CONFIG_FUSION_ISENSE=m
> 
> 
> /proc/svwks (note that like others, this is being misidentified as only
> UDMA2 capable, when it should be UDMA5):
> 
>                              ServerWorks OSB4/CSB5/CSB6
> 
>                             ServerWorks CSB5 Chipset (rev 93)
> ------------------------------- General Status ---------------------------------
> --------------- Primary Channel ---------------- Secondary Channel -------------
>                  enabled                          enabled
> --------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
> DMA enabled:    yes              no              no                no 
> UDMA enabled:   yes              no              no                no 
> UDMA enabled:   2                0               0                 0
> DMA enabled:    2                2               ?                 2
> PIO  enabled:   4                0               4                 0
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

