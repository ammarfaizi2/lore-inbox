Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTLWSCi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 13:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbTLWSCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 13:02:38 -0500
Received: from www.jubileegroup.co.uk ([212.22.195.7]:31911 "EHLO
	www2.jubileegroup.co.uk") by vger.kernel.org with ESMTP
	id S261868AbTLWSBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 13:01:50 -0500
Date: Tue, 23 Dec 2003 18:01:40 +0000 (GMT)
From: Ged Haywood <ged@www2.jubileegroup.co.uk>
To: rddunlap@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: Re: All filesystems hang under long periods of heavy load (read and
 write) on a filesystem
Message-ID: <Pine.LNX.4.21.0312231544250.20325-100000@www2.jubileegroup.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, 04 Nov 2003 Randy Dunlap wrote:

> On Mon, 03 Nov 2003 15:46:22 -0800 Shirley Shi wrote:
> 
> | Can anyone know why all filesystems hang under periods of heavy load on
> | one of the filesystem? Once the filesystems hang, any command related to
> | the filesystem, like 'ls', 'cat',etc., will stick forever until re-power
> | cycling the machine.
> 
> Can you try a recent kernel, like 2.4.23-pre8 or -pre9?

Didn't see any followup to this.  Please CC me, I'm not subscribed.

Background:

Similar problems here, both kernels 2.2.16 and 2.4.23, the latter
compiled with the config abbreviated below, on a modest Webserver.

This is a Compaq DL380 with SCSI RAID and two IDE drives.  No problems
at all on the SCSI drives.  The IDE drives are 40GB Maxtor, 250GB WD,
one is on the DL380's own IDE controller, the other is on a PCI card.
One partition on the 40G drive, three (each about 80GB) on the 250.
The interrupts are not shared.  Both drives are jumpered as slaves,
there is a CD as master on ide0 but no master on ide2 (yeah, OK,
but that one's all right...:).  All filesystems ext2.  The IDE drives
are used primarily for some data logging (not system logs) and backup.

The 40GB Maxtor has given no trouble until today, the machine hadn't
even been rebooted for two years until the end of November when I put
in the 250G IDE drive.  It was still running kernel 2.2.16 at the time.
Neither kernel loads any modules, eveything needed is compiled in.

Fault:

Copying large files from the smaller IDE drive to the larger trashed
the filesystem on the partition being written to.  Before installation
in the Webserver the same operations had been carried out error-free
on a PC on the bench to stress test the drives.

When the fault appeared the machine was running 2.2.16, but the bench
test had been with 2.4.23 so I compiled 2.4.23 on the Webserver to see
if it would help.  Not a lot, read on...

When I compiled with CONFIG_IDEDISK_MULTI_MODE not set and tried to
copy a large (2GB) file from the smaller IDE drive to the larger, it
trashed the filesystem on the drive I was writing to.  This fault is
apparently fixed by compiling with CONFIG_IDEDISK_MULTI_MODE=y although
there was one other change which I think will have made no difference -
I specified IRQ11 explicitly in the LILO boot parameters.

Unfortuantely now when copying the same large file from the larger IDE
drive to the smaller the filesystem on the drive being READ is trashed
when another process tries to write to that same drive concurrently.
This also prevents any access to the drive until a reboot.

Googled lots of similar postings, if anyone wants me to try anything
out please let me know.  Otherwise this is just a heads up to say that
there is certainly something nasty in the released 2.4.23 IDE code...

73,
Ged.

=============================================================================
Extract from LILO config:

image=/boot/bzImage.2.4.23.004
	label=linux-2.4.23-d
	read-only
	root=/dev/ida/c0d0p1
	append=" ide2=0x2c00,0x2c0a,11 ide3=0x2c10,0x2c1a,11"

=============================================================================
Extracts from /var/log/messages
=============================================================================
Note that the LILO boot parameters are somehow truncated.  It shouldn't matter
on this machine since ide3 is not being used...
...
Dec 22 14:48:08 www2 kernel: Linux version 2.4.23 (ged@www2) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #4 Fri Dec 19 20:48:47 GMT 2003 
...
Dec 22 14:48:08 www2 kernel: Kernel command line: auto BOOT_IMAGE=linux-2.4.23-d ro root=4801 ide2=0x2c00,0x2c0a,11 ide3=0x2c10, 
Dec 22 14:48:08 www2 kernel: ide_setup: ide2=0x2c00,0x2c0a,11 
Dec 22 14:48:08 www2 kernel:  
Dec 22 14:48:08 www2 kernel: ide_setup: ide3=0x2c10, 
Dec 22 14:48:08 www2 kernel:  
Dec 22 14:48:08 www2 kernel: Initializing CPU#0 
Dec 22 14:48:08 www2 kernel: Detected 731.081 MHz processor. 
...
Dec 22 14:48:09 www2 kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0084, last bus=3 
Dec 22 14:48:09 www2 kernel: PCI: Using configuration type 1 
Dec 22 14:48:09 www2 kernel: PCI: Probing PCI hardware 
Dec 22 14:48:09 www2 kernel: PCI: Probing PCI hardware (bus 00) 
Dec 22 14:48:09 www2 kernel: PCI: Device 00:00 not found by BIOS 
Dec 22 14:48:09 www2 kernel: PCI: Device 00:01 not found by BIOS 
Dec 22 14:48:09 www2 kernel: PCI: Device 00:78 not found by BIOS 
...
Dec 22 14:48:11 www2 kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4 
Dec 22 14:48:11 www2 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx 
Dec 22 14:48:11 www2 kernel: hda: CD-224E, ATAPI CD/DVD-ROM drive 
Dec 22 14:48:11 www2 kernel: hdb: Maxtor 94098U8, ATA DISK drive 
Dec 22 14:48:11 www2 kernel: hdf: WDC WD2500JB-00EVA0, ATA DISK drive 
Dec 22 14:48:11 www2 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14 
Dec 22 14:48:11 www2 kernel: ide2 at 0x2c00-0x2c07,0x2c0a on irq 11 
Dec 22 14:48:11 www2 kernel: hdb: attached ide-disk driver. 
Dec 22 14:48:11 www2 kernel: hdb: host protected area => 1 
Dec 22 14:48:11 www2 kernel: hdb: 80041248 sectors (40981 MB) w/2048KiB Cache, CHS=79406/16/63 
Dec 22 14:48:11 www2 kernel: hdf: attached ide-disk driver. 
Dec 22 14:48:11 www2 kernel: hdf: host protected area => 1 
Dec 22 14:48:11 www2 kernel: hdf: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63 
Dec 22 14:48:11 www2 kernel: hda: attached ide-cdrom driver. 
Dec 22 14:48:11 www2 kernel: hda: ATAPI 24X CD-ROM drive, 512kB Cache 
Dec 22 14:48:11 www2 kernel: Uniform CD-ROM driver Revision: 3.12 
Dec 22 14:48:11 www2 kernel:  hdb: [PTBL] [4982/255/63] hdb1 
Dec 22 14:48:11 www2 kernel:  hdf: hdf1 hdf2 hdf3 hdf4 
...
Dec 23 12:19:01 www2 kernel: hdb: status timeout: status=0xd0 { Busy } 
Dec 23 12:19:01 www2 kernel:  
Dec 23 12:19:01 www2 kernel: hdb: no DRQ after issuing WRITE 
Dec 23 12:19:33 www2 kernel: ide0: reset timed-out, status=0x80 
Dec 23 12:19:33 www2 kernel: hdb: status timeout: status=0xd0 { Busy } 
Dec 23 12:19:33 www2 kernel:  
Dec 23 12:19:33 www2 kernel: hdb: no DRQ after issuing WRITE 
Dec 23 12:20:03 www2 kernel: ide0: reset timed-out, status=0x80 
Dec 23 12:20:03 www2 kernel: end_request: I/O error, dev 03:41 (hdb), sector 35289088 
...

At this stage everything is hunky-dory. :)
=============================================================================
cat /proc/interrupts:

(This is after /dev/hdb failed.)

           CPU0       
  0:    9643877          XT-PIC  timer
  1:          4          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:     525270          XT-PIC  ida0
 10:    1224738          XT-PIC  eth0
 11:    1506346          XT-PIC  ide2
 12:          0          XT-PIC  PS/2 Mouse
 14:     955863          XT-PIC  ide0
NMI:          0 
ERR:       1412
=============================================================================
Extracts from kernel 2.4.23 .config:
=============================================================================
CONFIG_X86=y
# CONFIG_EXPERIMENTAL is not set
CONFIG_MPENTIUMIII=y
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_ACPI is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_LVM=m
#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y

CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=0
=============================================================================
hdparm -vi /dev/hdb
(This drive is not working; MultSect is normally 16).

/dev/hdb:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 4982/255/63, sectors = 80041248, start = 0

 Model=Maxtor 94098U8, FwRev=FA500S60, SerialNo=G80CWGYC
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=0
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=80041248
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 *mword2 
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4 
 UDMA modes: mode0 mode1 mode2 mode3 mode4 
=============================================================================
hdparm /dev/hdf
(This drive is working.)

/dev/hdf:
 multcount    = 16 (on)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 30401/255/63, sectors = 488397168, start = 0

 Model=WDC WD2500JB-00EVA0, FwRev=15.05R15, SerialNo=WD-WMAEH1325940
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=74
 BuffType=3(DualPortCache), BuffSize=8192kB, MaxMultSect=16, MultSect=16
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=0
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=268435455
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 *mword2 
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4 
 UDMA modes: mode0 mode1 mode2 mode3 mode4 mode5 
=============================================================================

This is odd - maybe it's why I can't talk to the drive on ide0 any more.
The RAID bus controller on 00:05 is use as ide2/3 and working fine as I write.

lspci -vvv
...

00:05.0 RAID bus controller: CMD Technology Inc: Unknown device 0680 (rev 02)
	Subsystem: CMD Technology Inc: Unknown device 3680
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set, cache line size 01
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 2c00 [size=8]
	Region 1: I/O ports at 2c08 [size=4]
	Region 2: I/O ports at 2c10 [size=8]
	Region 3: I/O ports at 2c18 [size=4]
	Region 4: I/O ports at 2c20 [size=16]
	Region 5: Memory at c4dfee00 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-


00:0f.1 IDE interface: Relience Computer: Unknown device 0211 (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Region 4: I/O ports at 2c30 [size=16]

=============================================================================


