Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288643AbSANCOY>; Sun, 13 Jan 2002 21:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288657AbSANCOG>; Sun, 13 Jan 2002 21:14:06 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:32641
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288639AbSANCNq>; Sun, 13 Jan 2002 21:13:46 -0500
Date: Sun, 13 Jan 2002 20:58:39 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: ISA hardware discovery -- the elegant solution
Message-ID: <20020113205839.A4434@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been thinking about the hardware-discovery problem for ISA devices,
and there may be an elegant solution.  It will take a number of small changes
to the kernel sources, however.

The kernel's device drivers have, of course, to include probe
routines, and those hard-compiled in typically log the presence of
their hardware to /var/log/mesg when it loads.  By scanning that
file, we in effect get to use those probes.

My autoconfigurator's probe table now has a small number of tests than 
do regexp matches against the dmesg log.  As is, this solution does not
scale well, because each regexp has to be discovered by eyeball and then
maintained in the table by hand.

But suppose the format of boot-time driver messages were standardized in a
format that included their config symbol in a discoverable form?

I have hand-edited a copy of my current /var/log/dmesg to illustrate
how I think this could work.  

:MTRR: your CPUs had inconsistent fixed MTRR settings
:MTRR: probably your BIOS does not setup all CPUs
:PCI: PCI BIOS revision 2.10 entry at 0xfd7c0, last bus=1
:PCI: Using configuration type 1
:PCI: Probing PCI hardware
BIOS disabled PCI ordering compliance, so we enabled it again.
:IO_APIC: AMD Errata #22 may be present. In the event of instability try
        : booting with the "noapic" option.
:NET: Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
:RTNETLINK: Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
:JBD: Journalled Block Device driver loaded
:UNIX_PTY: 2048 Unix98 ptys configured
block: 128 slots per queue, batch=32
:IDE: Uniform Multi-Platform E-IDE driver Revision: 6.31
:IDE: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
:SCSI: SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

  Vendor: IBM-PSG   Model: ST318451LW    !#  Rev: B833
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM-PSG   Model: ST318451LW    !#  Rev: B833
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: HP        Model: C5683A            Rev: C005
  Type:   Sequential-Access                  ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
  Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sda: 35548320 512-byte hdwr sectors (18201 MB)
Partition check:
 sda: sda1 sda2 < sda5 >
(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sdb: 35548320 512-byte hdwr sectors (18201 MB)
 sdb: sdb1 sdb2
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 1, lun 0
(scsi1:A:0): 20.000MB/s transfers (20.000MHz, offset 16)
:BLK_DEV_SR: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
(scsi1:A:1): 20.000MB/s transfers (20.000MHz, offset 16)
:BLK_DEV_SR: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
:USB_DEVFS: registered new driver usbdevfs
:USB: registered new driver hub
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 96k freed
Adding Swap: 1807272k swap-space (priority -1)
:EXT3_FS: FS 2.4-0.9.16, 02 Dec 2001 on sd(8,5), internal journal
:BLK_DEV_MD: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
kjournald starting.  Commit interval 5 seconds
:EXT3_FS: FS 2.4-0.9.16, 02 Dec 2001 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
:EXT3_FS: FS 2.4-0.9.16, 02 Dec 2001 on sd(8,18), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
:BLK_DEV_ST: Version 20011103, bufsize 32768, wrt 30720, max init. bufs 4, s/g segs 16
Attached scsi tape st0 at scsi0, channel 0, id 2, lun 0

The convention I propose is that at least one line of a driver probe message
should begin with :, followed by the driver config symbol, followed by :.
I am not attached to that particular punctuation, it is simply an unambiguous
way of indicating "this is a config symbol".

With this change, generating a report on ISA hardware and other
facilities configured in at boot time would be trivial.  This would
make the autoconfigurator much more capable.  Best of all, the only
change required to accomplish this would be safe edits of print format
strings.

I would be willing to generate a patch to implement this change.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

To stay young requires the unceasing cultivation of the ability to
unlearn old falsehoods.
	-- Lazarus Long 
