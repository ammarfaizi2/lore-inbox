Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbUCYQpi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 11:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263188AbUCYQpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 11:45:38 -0500
Received: from mivlgu.ru ([81.18.140.87]:28844 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S263361AbUCYQoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 11:44:44 -0500
Date: Thu, 25 Mar 2004 19:44:41 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: sata_via: ata1 failed to respond
Message-ID: <20040325164441.GP1756@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mh8CTEa8Ax54aLHp"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Mh8CTEa8Ax54aLHp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

I have another report about nonworking sata_via in 2.4.25-libata9
plus the probing bug fix (so sata_via was identical to the version
in 2.4.25-libata12).  The drive was not recognised with these
messages:

libata version 1.02 loaded.
sata_via version 0.20
sata_via(00:0f.0): routed to hard irq line 10
ata1: SATA max UDMA/133 cmd 0xB800 ctl 0xB402 bmdma 0xA400 irq 20
ata2: SATA max UDMA/133 cmd 0xB000 ctl 0xA802 bmdma 0xA408 irq 20
ata1 is slow to respond, please be patient
ata1 failed to respond (30 secs)

The hardware was: ASUS A7V600 motherboard, Seagate ST3120026AS hard
drive.  2.4.25-libata1 worked fine.

acpi=off and noapic options did not help.  However, replacing
sata_via.c with the version from 2.4.25-libata1 (with removed
".phy_config = pata_phy_config" line to make it compile) allowed the
detection to succeed.

I tried to replace ATA_FLAG_SATA_RESET with ATA_FLAG_SRST in the new
driver - with this change detection also succeeds:

--- kernel-source-2.4.25/drivers/scsi/sata_via.c.via-srst	2004-03-24 16:27:50 +0300
+++ kernel-source-2.4.25/drivers/scsi/sata_via.c	2004-03-25 18:51:19 +0300
@@ -203,7 +203,7 @@ static int svia_init_one (struct pci_dev
 	INIT_LIST_HEAD(&probe_ent->node);
 	probe_ent->pdev = pdev;
 	probe_ent->sht = &svia_sht;
-	probe_ent->host_flags = ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
+	probe_ent->host_flags = ATA_FLAG_SATA | ATA_FLAG_SRST |
 				ATA_FLAG_NO_LEGACY;
 	probe_ent->port_ops = &svia_sata_ops;
 	probe_ent->n_ports = 2;

Here is the full dmesg output from boot with the above change:

=======================================================================
ctor: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1150.0919 MHz.
..... host bus clock speed is 200.0160 MHz.
cpu: 0, clocks: 2000160, slice: 1000080
CPU0<T0:2000160,T1:1000080,D:0,S:1000080,C:2000160>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20040311
PCI: PCI BIOS revision 2.10 entry at 0xf1970, last bus=1
PCI: Using configuration type 1
Looking for DSDT in initrd ... not found!
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:1)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
PCI: Probing PCI hardware
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xa9 -> IRQ 18 Mode:1 Active:1)
00:00:09[A] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb1 -> IRQ 19 Mode:1 Active:1)
00:00:0c[A] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xb9 -> IRQ 16 Mode:1 Active:1)
00:00:0c[B] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xc1 -> IRQ 17 Mode:1 Active:1)
00:00:0c[C] -> 2-17 -> IRQ 17
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xc9 -> IRQ 20 Mode:1 Active:1)
00:00:0f[A] -> 2-20 -> IRQ 20
Pin 2-20 already programmed
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21 Mode:1 Active:1)
00:00:10[A] -> 2-21 -> IRQ 21
Pin 2-21 already programmed
Pin 2-21 already programmed
Pin 2-21 already programmed
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd9 -> IRQ 22 Mode:1 Active:1)
00:00:11[C] -> 2-22 -> IRQ 22
Pin 2-22 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   1   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   1   0    1    1    B9
 11 001 01  1    1    0   1   0    1    1    C1
 12 001 01  1    1    0   1   0    1    1    A9
 13 001 01  1    1    0   1   0    1    1    B1
 14 001 01  1    1    0   1   0    1    1    C9
 15 001 01  1    1    0   1   0    1    1    D1
 16 001 01  1    1    0   1   0    1    1    D9
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9-> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
PCI: Via IRQ fixup for 00:10.0, from 11 to 5
PCI: Via IRQ fixup for 00:10.1, from 11 to 5
PCI: Via IRQ fixup for 00:10.2, from 10 to 5
PCI: Via IRQ fixup for 00:10.3, from 10 to 5
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
kinoded started
VFS: Disk quotas vdquot_6.5.1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:0f.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci00:0f.1
    ide0: BM-DMA at 0x9800-0x9807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x9808-0x980f, BIOS settings: hdc:pio, hdd:DMA
hda: ST380021A, ATA DISK drive
blk: queue c0303aa0, I/O limit 4095Mb (mask 0xffffffff)
hdd: CD-W540E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, UDMA(100)
Partition check:
 hda: hda1 hda2 < hda5 hda6 >
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 145k freed
VFS: Mounted root (romfs filesystem) readonly.
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
libata version 1.02 loaded.
sata_via version 0.20
sata_via(00:0f.0): routed to hard irq line 10
ata1: SATA max UDMA/133 cmd 0xB800 ctl 0xB402 bmdma 0xA400 irq 20
ata2: SATA max UDMA/133 cmd 0xB000 ctl 0xA802 bmdma 0xA408 irq 20
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:407f
ata1: dev 0 ATA, max UDMA/133, 234441648 sectors (lba48)
ata1: dev 0 configured for UDMA/133
ata2: no device found (phy stat 00000000)
ata2: thread exiting
scsi0 : sata_via
scsi1 : sata_via
  Vendor: ATA       Model: ST3120026AS       Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
VFS: Mounted root (ext2 filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Freeing unused kernel memory: 136k freed
Executing init=/sbin/init
=======================================================================

-- 
Sergey Vlasov

--Mh8CTEa8Ax54aLHp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAYwx5W82GfkQfsqIRAuNrAJ9j7+4PWpfHrfUWfHlJnQXSJrogOACff+gy
rS0bWgYpGalBEaiSCw0aq+c=
=ktzN
-----END PGP SIGNATURE-----

--Mh8CTEa8Ax54aLHp--
