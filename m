Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269389AbUIYTOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269389AbUIYTOh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 15:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269390AbUIYTOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 15:14:37 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:36341 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269389AbUIYTOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 15:14:10 -0400
Message-ID: <70fda320409251214129bba57@mail.gmail.com>
Date: Sat, 25 Sep 2004 14:14:09 -0500
From: micah milano <micaho@gmail.com>
Reply-To: micah milano <micaho@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: SiI3112 Serial ATA Maxtor 6Y120M0 incorrect geometry detected
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got two Maxtor 6Y120M0 drives, same firmware, but they show up
with differing CHS when I attempt to partition them, however it seems
like other places on the system they are detected as having the same
properties. This is making setting up software raid-1 difficult.
Should I boot with a particular geometry specified on the kernel line
to make it correct?

Using fdisk -l on each disk you see that one reports 255 heads, 63
sectors/track, 14946 cylinders and the other reports 16 heads, 63
sectors/track, 238216 cylinders.

This is 2.6.7 (i'm here because the ipmi software from supermicro is
not working for 2.6.8 yet), and I am not able to follow this list, so
please CC me on any reply. I've tried to include all the useful
information, but if I neglected something, please let me know and I
will provide it right away.

Thanks for any insight, this is driving me a little batty,
micah

fdisk -l /dev/hde

Disk /dev/hde: 122.9 GB, 122942324736 bytes
255 heads, 63 sectors/track, 14946 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

fdisk -l /dev/hdg

Disk /dev/hdg: 122.9 GB, 122942324736 bytes
16 heads, 63 sectors/track, 238216 cylinders
Units = cylinders of 1008 * 512 = 516096 bytes

parted says:

parted /dev/hde
Error: The partition table on /dev/hde is inconsistent.  There are many reasons
why this might be the case.  However, the most likely reason is that Linux
detected the BIOS geometry for /dev/hde incorrectly.  GNU Parted suspects the
real geometry should be 14946/255/63 (not 238216/16/63).  You should check with
your BIOS first, as this may not be correct.  You can inform Linux by adding the
parameter hde=14946,255,63 to the command line.  See the LILO or GRUB
Information: The operating system thinks the geometry on /dev/hde is      
238216/16/63.  Therefore, cylinder 1024 ends at 503.999M.

parted /dev/hdg (no error):
Using /dev/hdg
Information: The operating system thinks the geometry on /dev/hdg is      
238216/16/63.  Therefore, cylinder 1024 ends at 503.999M.

cat /proc/ide/piix 

Controller: 0

                                Intel PIIX4 Ultra 100 Chipset.
--------------- Primary Channel ---------------- Secondary Channel -------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    no               no              yes               no 
UDMA enabled:   no               no              yes               no 
UDMA enabled:   X                X               2                 X
UDMA
DMA
PIO

cat /proc/ide/drivers 
ide-scsi version 0.92
ide-cdrom version 4.61
ide-disk version 1.18

cat /proc/ide/hde/geometry 
physical     16383/16/63
logical      65535/16/63

cat /proc/ide/hdg/geometry 
physical     16383/16/63
logical      65535/16/63

hdparm -I /dev/hde

/dev/hde:

ATA device, with non-removable media
        Model Number:       Maxtor 6Y120M0                          
        Serial Number:      Y3MGJ4XE            
        Firmware Revision:  YAR51EW0
Standards:
        Supported: 7 6 5 4 
        Likely used: 7
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  240121728
        device size with M = 1024*1024:      117246 MBytes
        device size with M = 1000*1000:      122942 MBytes (122 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 0
        Advanced power management level: unknown setting (0x0000)
Recommended acoustic management value: 192, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
           *    SMART feature set
           *    FLUSH CACHE EXT command
           *    Mandatory FLUSH CACHE command 
           *    Device Configuration Overlay feature set 
           *    Automatic Acoustic Management feature set 
                SET MAX security extension
                Advanced Power Management feature set
           *    DOWNLOAD MICROCODE cmd
           *    SMART self-test 
           *    SMART error logging 
Security: 
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
Checksum: correct


hdparm -I /dev/hdg

/dev/hdg:

ATA device, with non-removable media
        Model Number:       Maxtor 6Y120M0                          
        Serial Number:      Y3MGJ86E            
        Firmware Revision:  YAR51EW0
Standards:
        Supported: 7 6 5 4 
        Likely used: 7
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  240121728
        device size with M = 1024*1024:      117246 MBytes
        device size with M = 1000*1000:      122942 MBytes (122 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 0
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 192, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
           *    SMART feature set
           *    FLUSH CACHE EXT command
           *    Mandatory FLUSH CACHE command 
           *    Device Configuration Overlay feature set 
           *    Automatic Acoustic Management feature set 
                SET MAX security extension
                Advanced Power Management feature set
           *    DOWNLOAD MICROCODE cmd
           *    SMART self-test 
           *    SMART error logging 
Security: 
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
Checksum: correct

hdparm -i /dev/hde

/dev/hde:

 Model=Maxtor 6Y120M0, FwRev=YAR51EW0, SerialNo=Y3MGJ4XE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=240121728
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null): 

 * signifies the current active mode


hdparm -i /dev/hdg

/dev/hdg:

 Model=Maxtor 6Y120M0, FwRev=YAR51EW0, SerialNo=Y3MGJ86E
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=240121728
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null): 

 * signifies the current active mode



ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3: IDE controller at PCI slot 0000:00:1f.1
ICH3: chipset revision 2
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2060-0x2067, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x2068-0x206f, BIOS settings: hdc:pio, hdd:pio
hdc: CD-224E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
SiI3112 Serial ATA: IDE controller at PCI slot 0000:03:02.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: 100% native mode on irq 26
    ide2: MMIO-DMA , BIOS settings: hde:DMA, hdf:DMA
    ide3: MMIO-DMA , BIOS settings: hdg:DMA, hdh:DMA
hde: Maxtor 6Y120M0, ATA DISK drive
ide2 at 0xf8858080-0xf8858087,0xf885808a on irq 26
hdg: Maxtor 6Y120M0, ATA DISK drive
ide3 at 0xf88580c0-0xf88580c7,0xf88580ca on irq 26
SiI3112 Serial ATA: IDE controller at PCI slot 0000:03:03.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: 100% native mode on irq 27
    ide4: MMIO-DMA , BIOS settings: hdi:pio, hdj:pio
    ide5: MMIO-DMA , BIOS settings: hdk:pio, hdl:pio
hdi: no response (status = 0xfe)
hdk: no response (status = 0xfe)
hdi: no response (status = 0xfe), resetting drive
hdi: no response (status = 0xfe)
hdk: no response (status = 0xfe), resetting drive
hdk: no response (status = 0xfe)
hde: max request size: 64KiB
hde: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63
 /dev/ide/host2/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 >
hdg: max request size: 64KiB
hdg: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63
 /dev/ide/host2/bus1/target0/lun0:
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)


Additionally, if I try to partition /dev/hdg (which has no partition
table yet), using fdisk, it strangley doesn't ask me for much
information, such as how large it should be:

fdisk /dev/hdg

The number of cylinders for this disk is set to 238216.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., old versions of LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)

Command (m for help): p

Disk /dev/hdg: 122.9 GB, 122942324736 bytes
16 heads, 63 sectors/track, 238216 cylinders
Units = cylinders of 1008 * 512 = 516096 bytes

   Device Boot      Start         End      Blocks   Id  System

Command (m for help): a
Partition number (1-4): 1
Warning: partition 1 has empty type

Command (m for help): p

Disk /dev/hdg: 122.9 GB, 122942324736 bytes
16 heads, 63 sectors/track, 238216 cylinders
Units = cylinders of 1008 * 512 = 516096 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hdg1   *           1           1           0    0  Empty
Partition 1 does not end on cylinder boundary.

Command (m for help):
