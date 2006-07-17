Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWGQS0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWGQS0g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 14:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWGQS0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 14:26:35 -0400
Received: from the.earth.li ([193.201.200.66]:62855 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S1751131AbWGQS0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 14:26:35 -0400
Date: Mon, 17 Jul 2006 19:26:33 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Status of HPT372A driver?
Message-ID: <20060717182633.GX1485@earth.li>
References: <20060717142705.GS1485@earth.li> <44BBC75A.2000800@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BBC75A.2000800@ru.mvista.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2006 at 09:22:34PM +0400, Sergei Shtylyov wrote:
> Jonathan McDowell wrote:
> 
> >I recently acquired a HighPoint RocketRaid 1520 SATA controller (I know,
> >I know, bad choice but I just need something to tide me over until I can
> >upgrade to a motherboard with AHCI love). This presents as a HPT372A:
> 
> >00:09.0 RAID bus controller: Triones Technologies, Inc. HPT372A/372N (rev 
> >01)
> >00:09.0 0104: 1103:0005 (rev 01)
> 
>    Sigh, I had no chance to test the driver on this chip myself... And I 
>    also haven't tried the driver on SATA drives at all... :-/

:(

I've had a try with libata and Alan Cox's 2.6.17-ide1 patch (I'd
previously tried this and had issues, which turned out to be a faulty
drive I think). This seems to get better results (sda is the same drive
as was hde earlier):

/dev/sda:
 Timing cached reads:   1084 MB in  2.01 seconds = 540.41 MB/sec
 Timing buffered disk reads:  166 MB in  3.00 seconds =  55.25 MB/sec

I imagine this is due to:

libata version 1.20 loaded.
pata_hpt37x: BIOS has not set timing clocks.
hpt37x: HPT372A: Bus clock 33MHz.
ata1: PATA max UDMA/133 cmd 0xA000 ctl 0xA402 bmdma 0xB000 irq 11
ata2: PATA max UDMA/133 cmd 0xA800 ctl 0xAC02 bmdma 0xB008 irq 11
ata1: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:407f
ata1: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
Find mode for 12 reports C829C62
Find mode for DMA 70 reports 1C81DC62
ata1: dev 0 configured for UDMA/133

ie it's configuring for UDMA/133 as expected.

The hpt366 driver was stable (I copied 100+G of data with cp/rsync and
it was fine); I've only been running this one (marked "Raving Lunatic"
in the Kconfig) for 5 minutes, so I'll see how it goes. I'm happy to try
out anything you might want for the hpt366 driver though.
 
> >The 2.6.17 hpt366.c driver is at version 0.36. I also found your patches
> >to l-k earlier this year, but I'm not sure whether I got them all as I
> >had some rejects; I ended up with a version 1.00 driver as at:
> 
>    Some patch was recast, maybe this was the reason...
> 
> >http://the.earth.li/~noodles/hpt366.c
> 
>    I'm surprised that this has even compiled! It has check_in_drive_lists() 
> defined twice...

No, it has it once (unused) - the used instance is check_in_drive_list()

> >Is there somewhere I can get your latest work without having to try to
> >pick the right patches from the l-k archives?
> 
>    You may find the summary patch in the -mm tree

Right, I found this shortly after I sent my first mail, but it's not a
lot different from what I'm running AFAICT (changes from min to min_t
and the removal of the unused check_in_drive_lists).

> >Also I'm getting fairly appalling speeds; I don't know if this is thie
> >card or not, but I have a SATA II capable drive (I know the controller
> > is only SATA I) attached that's getting detected as:
> 
> >hde: 488397168 sectors (250059 MB) w/16384KiB Cache, CHS=30401/255/63, 
> >UDMA(33)
> 
>    Hm, looks like the drive is wrongly reported as blacklisted or the cable 
> being somehow misdetected... Ah, this was SATA drive, you say?

Yup. It's a Western Digital Caviar SE16. The RocketRaid 1520 card has a
Marvell 88i8030 PATA/SATA bridge on it for each SATA channel.

> >I'd expect UDMA(133) or similar instead? hdparm -Tt gives:
> 
>    I also would, at least UDMA(100)... :-)
> 
> >/dev/sda:
> > Timing cached reads:   984 MB in  2.00 seconds = 491.58 MB/sec
> > Timing buffered disk reads:   90 MB in  3.00 seconds =  30.00 MB/sec
> >
> >/dev/hda:
> > Timing cached reads:   940 MB in  2.00 seconds = 469.89 MB/sec
> > Timing buffered disk reads:  172 MB in  3.04 seconds =  56.66 MB/sec
> >
> >/dev/hde:
> > Timing cached reads:   1012 MB in  2.01 seconds = 504.48 MB/sec
> > Timing buffered disk reads:   44 MB in  3.05 seconds =  14.43 MB/sec
> 
> >(sda is an old 36GB SCSI disk on an Adaptec 2940, hda is a Maxtor on the
> >internal VIA PATA controller. I'd expected hde to at least outperform
> >sda.)
> 
>    Output of hdparm -iI /dev/hde would also be helpful.

/dev/hde:

 Model=WDC WD2500KS-00MJB0, FwRev=02.01C03, SerialNo=WD-WCANK3255074
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=50
 BuffType=unknown, BuffSize=16384kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: Unspecified:  ATA/ATAPI-1 ATA/ATAPI-2 ATA/ATAPI-3 ATA/ATAPI-4 ATA/ATAPI-5 ATA/ATAPI-6 ATA/ATAPI-7

 * signifies the current active mode

ATA device, with non-removable media
        Model Number:       WDC WD2500KS-00MJB0
        Serial Number:      WD-WCANK3255074
        Firmware Revision:  02.01C03
Standards:
        Supported: 7 6 5 4
        Likely used: 7
Configuration:
        Logical         max     current
        cylinders       16383   65535
        heads           16      1
        sectors/track   63      63
        --
        CHS current addressable sectors:    4128705
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors:  488397168
        device size with M = 1024*1024:      238475 MBytes
        device size with M = 1000*1000:      250059 MBytes (250 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Standby timer values: spec'd by Standard, with device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    NOP cmd
           *    DOWNLOAD_MICROCODE
                SET_MAX security extension
                Automatic Acoustic Management feature set
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    General Purpose Logging feature set
           *    SATA-I signaling speed (1.5Gb/s)
           *    SATA-II signaling speed (3.0Gb/s)
           *    Host-initiated interface power management
           *    Phy event counters
           *    Software settings preservation
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
Checksum: correct

J.

-- 
Settle down, Beavis.
