Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTDGBuI (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 21:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbTDGBuI (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 21:50:08 -0400
Received: from ppp146.dyn143.pacific.net.au ([210.23.143.146]:24502 "EHLO
	jekyll.safehouse.com.au") by vger.kernel.org with ESMTP
	id S263187AbTDGBuE (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 21:50:04 -0400
From: David Tymon <David.Tymon@safehouse.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16016.56340.492697.198504@horse.como>
Date: Mon, 7 Apr 2003 12:01:56 +1000
To: linux-kernel@vger.kernel.org
Subject: DMA Timeouts with 3112 SATA Controller (status == 0x21)
Organization: Safehouse International, Melbourne, Australia
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: David.Tymon@safehouse.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am in the process of trying to setup a Dual Xeon machine with a Silicon
Image 3112 SATA controller. The system is booting from a parallel ATA disk and
there are two SATA disks being used to store data.

I was able to access the SATA drives, both in a raid0 and non-raid
configuration, using the driver (sii3112rl.o) with the machine. This module
was compiled for a uni-processor RH8.0 kernel (2.8.18-14). We were getting
transfer rates of around 40MB/s in non-raid and 80MB/s in raid0. There was no
SMP version of the module supplied so it was kind of useless to us.

So, I tried a 2.4.21-pre6 kernel (SMP with hyperthreading). The 3112
controller was identified at boot and I was able to access the disks. However,
hdparm was reporting very poor transfer rates, around 1.8MB/s. It turned out
that DMA was not enabled on the disks. When I enabled DMA I got back to a
transfer rate around 40MB/s. I set the transfer mode to udma6.

Then I tried to make an ext3 filesystem. mkfs would get up to around the 240th
inode table (ie: "Writing inode tables: 240/xyz") and then freeze up for a
while. The following errors were displayed on the console:

    hde: dma_timer_expiry: dma_status == 0x21
    hde: timeout waiting for DMA
    hde: timeout waiting for DMA
    hde: status timeout: status = 0xd8 {Busy}
    hde: drive not ready for command
    ide2: reset phy status=0x00000113 siimage_reset
    ide2: reset timed-out, status=0xd8
    hde: status timeout: status = 0xd8 {Busy}
    hde: drive not ready for command
    ide2: reset phy status=0x00000113 siimage_reset
    ide2: reset timed-out, status=0xd8

followed by loads of IO errors. After this, the disk was uncontactable. I
thought the problem might be with udma6 so I tried all of them but with the
same problems. I also tried 2.5.66 and a RedHat 2.4.20-2.54 kernel but these
had the same problems. If I turned DMA off I was able to make a filesystem
(although very slowly). I was also able to make a filesystem using the
original supplied driver.

The timeouts also occurred if I used the silraid module and accessed the disks
via /dev/ataraid/d0.

I could swap the drives for parallel ATA ones but would rather get the SATA
ones working if possible. I recall reading a message from Andre containing
performance details about a 3112 controller and Linux raid 1, so I presume
that it is possible to get this configuration going and it is just that I am a
doofus.

Here is some info on the machine:

# lspci
00:00.0 Host bridge: Intel Corp.: Unknown device 2550 (rev 03)
00:00.1 Class ff00: Intel Corp.: Unknown device 2551 (rev 03)
00:01.0 PCI bridge: Intel Corp.: Unknown device 2552 (rev 03)
00:02.0 PCI bridge: Intel Corp.: Unknown device 2553 (rev 03)
00:02.1 Class ff00: Intel Corp.: Unknown device 2554 (rev 03)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02)
00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 02)
02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04)
02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04)
02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
04:02.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
05:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
05:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
05:04.0 Unknown mass storage controller: CMD Technology Inc: Unknown device 3112 (rev 02)

# hdparm -i /dev/hde
/dev/hde:
 Model=ST3120023AS, FwRev=3.01, SerialNo=3KA1MN43
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=234441648
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2:  1 2 3 4 5 6

# hdparm -I /dev/hde
/dev/hde:
ATA device, with non-removable media
        Model Number:       ST3120023AS                             
        Serial Number:      3KA1MN43            
        Firmware Revision:  3.01    
Standards:
        Used: ATA/ATAPI-6 T13 1410D revision 2 
        Supported: 6 5 4 3 
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  234441648
        device size with M = 1024*1024:      114473 MBytes
        device size with M = 1000*1000:      120034 MBytes (120 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 4      Queue depth: 1
        Standby timer values: spec'd by Standard
        R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 128, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
           *    SMART feature set
           *    Mandatory FLUSH CACHE command 
           *    Device Configuration Overlay feature set 
                Automatic Acoustic Management feature set 
                SET MAX security extension
           *    DOWNLOAD MICROCODE cmd
           *    SMART self-test 
           *    SMART error logging 
Security: 
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- above Vih
        Device num = 0
Checksum: correct

# smartctl -v /dev/hde
Vendor Specific SMART Attributes with Thresholds:
Revision Number: 10
Attribute                    Flag     Value Worst Threshold Raw Value
(  1)Raw Read Error Rate     0x000f   066   060   034       0000083fe871
(  3)Spin Up Time            0x0003   100   100   000       000000000000
(  4)Start Stop Count        0x0032   100   100   020       000000000000
(  5)Reallocated Sector Ct   0x0033   100   100   036       000000000000
(  7)Seek Error Rate         0x000f   070   060   030       000000a93dad
(  9)Power On Hours          0x0032   100   100   000       0000000000ed
( 10)Spin Retry Count        0x0013   100   100   097       000000000000
( 12)Power Cycle Count       0x0032   100   100   020       000000000047
(194)Unknown Attribute       0x0022   036   051   000       000000000024
(195)Unknown Attribute       0x001a   066   060   000       0000083fe871
(197)Current Pending Sector  0x0012   100   100   000       000000000000
(198)Offline Uncorrectable   0x0010   100   100   000       000000000000
(199)UDMA CRC Error Count    0x003e   200   200   000       000000000000
(200)Unknown Attribute       0x0000   100   253   000       000000000000
(202)Unknown Attribute       0x0032   100   253   000       000000000000


Any help would be most appreciated.

Thanks
David
-- 
David Tymon
Senior Software Engineer               mailto:David.Tymon@safehouse.com.au
Safehouse International                        http://www.safehouse.com.au
Tel: +61 3 9827 5411 Fax: +61 3 9827 7411
