Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271707AbTGXQ22 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 12:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271709AbTGXQ21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 12:28:27 -0400
Received: from math.ut.ee ([193.40.5.125]:56961 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S271707AbTGXQ2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 12:28:23 -0400
Date: Thu, 24 Jul 2003 19:43:09 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
cc: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
       Holger Lubitz <holger@lubitz.org>
Subject: Re: PIIX3 timeout waiting for DMA 2.4 and MAXTOR drive.
In-Reply-To: <20030710032456.309999d0.vmlinuz386@yahoo.com.ar>
Message-ID: <Pine.GSO.4.44.0307241911001.20301-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This a PIIX3 chipset problem with some disks?

I believe this a MWDMA2 mode bug in Linux IDE layer (but I may be wrong
of course).

> This message appears three times during the copy and finaly dma
> & multicount is disabled, but reactivated with hdparm without
> problems.
>
> hdc: dma_timer_expiry: dma status == 0x20
> hdc: timeout waiting for DMA
> hdc: timeout waiting for DMA
> hdc: (__ide_dma_test_irq) called while not waiting
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>
> hdc: drive not ready for command
> hdc: status timeout: status=0xd0 { Busy }
>
> hdc: drive not ready for command
> ide1: reset: success

I have similar messages from one drive (old pre-UDMA Seagate with MWDMA)
on several computres. In short: 2.4.18 with PIIX driver is OK, 2.4.19
gives errors. ICH2 and new kernels give errors, old kernel not tested
yet. VIA 686b gives errors with newer kernels but also gives different
error on 2.4.18 (which is completely unexplained by me). Most errors
occur during disk load, cp -a of a kernel tree usually triggers it.
Needless to say that 2.5.latest have been the sam as current 2.4.

Details are below.

Since the disk works fine with kernels up to 2.4.18 24x7 and gets quite
a load (it's a kernel compile disk in an old K6/200 with 430TX, also
gets bk pulls for the kernel), the disk is probably working.

Since new kernels give errors not only on PIIX4 and ICH2 but also on
VIA, it is probaly not just Intel IDE driver problem.

So far I have seen 3 people with MWDMA problems, they are included in
the reply except one that I have lost the address for. MWDMA _seems_ to
be the common denominator.

The details:

2.4.18+piix tuning on PIIX4 works OK.


2.4.18+via driver on via 686b gets this:

hdd: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: drive not ready for command
hdd: status timeout: status=0xd0 { Busy }
hdc: DMA disabled
hdd: drive not ready for command
ide1: reset: success

The same is repeated sometimes without "DMA disabled" message but the
thing seems to work.


2.4.22pre on the same piix4 gets this:

hdd: dma_timer_expiry: dma status == 0x61
hda: dma_timer_expiry: dma status == 0x61
hdd: error waiting for DMA
hdd: dma timeout retry: status=0x58 { DriveReady SeekComplete DataRequest }

hdd: status timeout: status=0xd0 { Busy }

hdc: DMA disabled
hdd: drive not ready for command
ide1: reset timed-out, status=0xff
hdd: dma_timer_expiry: dma status == 0x41
hdd: error waiting for DMA
hdd: dma timeout retry: status=0x58 { DriveReady SeekComplete DataRequest }

hdd: status timeout: status=0xd0 { Busy }

hdd: drive not ready for command
ide1: reset timed-out, status=0xff

And the disk is put offline after lots of IO errors.


2.4.22pre on via686b gets this:

hdd: dma_timer_expiry: dma status == 0x60
hdd: timeout waiting for DMA
hdd: timeout waiting for DMA
hdd: (__ide_dma_test_irq) called while not waiting
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hdd: drive not ready for command
hdd: status timeout: status=0xd0 { Busy }

hdc: DMA disabled
hdd: drive not ready for command
ide1: reset: success

and the disk stays working but sometimes stops for quite several
seconds, spits this error and continues.


2.4.22pre on ICH2 gets this _during partition detection_:

hdd: dma_timer_expiry: dma status == 0x40
hdd: timeout waiting for DMA
hdd: timeout waiting for DMA
hdd: (__ide_dma_test_irq) called while not waiting
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hdd: drive not ready for command

so no partitions and no mounting withs this kernel version.


Ths disk is Seagate ST32531A, 4996476 sectors (2558 MB), CHS=4956/16/63.
It is used as secondary slave with different cdroms as secondary
masters. Smart info tells it passes tests, has no relocated sectors yet
but seek error rate and raw read error rate have high raw values:

  1 Raw_Read_Error_Rate   0x000a 115 099 000 Old_age  Always - 95379906
  3 Spin_Up_Time          0x0006 097 097 000 Old_age  Always - 3
  4 Start_Stop_Count      0x0013 100 100 020 Pre-fail Always - 131
  5 Reallocated_Sector_Ct 0x0013 100 100 036 Pre-fail Always - 0
  7 Seek_Error_Rate       0x000b 068 053 030 Pre-fail Always - 25814353362
 10 Spin_Retry_Count      0x0013 100 100 097 Pre-fail Always - 0
 12 Power_Cycle_Count     0x0013 100 100 020 Pre-fail Always - 126

hdparm -i of it:

/dev/hdd:

 Model=ST32531A, FwRev=0.62, SerialNo=VE047143
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=4956/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=off
 CurCHS=4956/16/63, CurSects=4996476, LBA=yes, LBAsects=4996476
 IORDY=on/off, tPIO={min:383,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio3 pio4
 DMA modes:  mdma0 mdma1 *mdma2
 AdvancedPM=no
 Drive conforms to: unknown:  0 1 2


and hdparm -I:
/dev/hdd:

ATA device, with non-removable media
        Model Number:       ST32531A
        Serial Number:      VE047143
        Firmware Revision:  0.62
Standards:
        Supported: 2 1
        Likely used: 3
Configuration:
        Logical         max     current
        cylinders       4956    4956
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:    4996476
        LBA    user addressable sectors:    4996476
        device size with M = 1024*1024:        2439 MBytes
        device size with M = 1000*1000:        2558 MBytes (2 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 4
        Standby timer values: spec'd by Vendor
        R/W multiple sector transfer: Max = 16  Current = 16
        DMA: mdma0 mdma1 *mdma2
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=383ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
                Power Management feature set
                SMART feature set


I did try increasing the timeout for DMA reads and DMA writes in
ide-dma.c but of course this did not help.

-- 
Meelis Roos (mroos@linux.ee)

