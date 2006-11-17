Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424581AbWKQPX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424581AbWKQPX5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 10:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755728AbWKQPX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 10:23:57 -0500
Received: from tigris.renesys.com ([69.84.130.136]:13208 "HELO
	tigris.renesys.com") by vger.kernel.org with SMTP id S1755726AbWKQPXz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 10:23:55 -0500
Date: Fri, 17 Nov 2006 10:23:54 -0500
From: John Rouillard <rouilj@renesys.com>
To: linux-kernel@vger.kernel.org
Subject: kernel oops: assertion failure at journal:576 (ext3 issue?)
Message-ID: <20061117152354.GO28000@renesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all:

We have a few (3) systems that are crashing with:

  Assertion failure in journal_next_log_block() at fs/jbd/journal.c:576:
  "journal->j_free > 1" 

  Kernel BUG at journal:576
  invalid operand: 0000 [1] SMP
  CPU 1
  Modules linked in: 
  md5 ipv6 parport_pc lp parport w83627hf eeprom adm1026 hwmon_vid hwmon
  i2c_sensor i2c_isa i2c_amd756 i2c_amd8111 i2c_dev i2c_core nfs lockd
  nfs_acl sunrpc ipt_REJECT ipt_state ip_conntrack iptable_filter
  ip_tables button battery ac ohci_hcd hw_random tg3 floppy dm_snapshot
  dm_zero dm_mirror ext3 jbd dm_mod 3w_9xxx sata_mv libata sd_mod
  scsi_mod
  Pid: 1603, comm: kjournald Not tainted 2.6.9-42.0.3.ELsmp
  RIP: 0010:[<ffffffffa006c18a>]
  <ffffffffa006c18a>{:jbd:journal_next_log_block+76}
  RSP: 0018:0000010476327b88 EFLAGS: 00010212
  RAX: 0000000000000060 RBX: 0000010283163e00 RCX: ffffffff803e1fe8
  RDX: ffffffff803e1fe8 RSI: 0000000000000246 RDI: ffffffff803e1fe0
  RBP: 0000000000000040 R08: ffffffff803e1fe8 R09: 0000010283163e00
  R10: 0000000100000000 R11: ffffffff8011e884 R12: 0000010283163e24
  R13: 0000010476327be0 R14: 0000010283163e00 R15: 000000000000002e
  FS: 0000002a95560b00(0000) GS:ffffffff804e5200(0000)
  knlGS:00000000f7ff36c0
  CS: 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
  CR2: 0000002a9556c000 CR3: 0000000037e42000 CR4: 00000000000006e0
  Process kjournald (pid: 1603, threadinfo 0000010476326000, task
  0000010478d777f0)
  Stack: 0000010453f4afa8 0000010310072240 0000000000000040
  0000010147528be0
  000001044240a880 ffffffffa0067dfe 00000e7c00000000
  00000101c33f2184
  0000000000000000 0000010310b12f50
  Call Trace:<ffffffffa0067dfe>{:jbd:journal_commit_transaction+1834}
  <ffffffff80135756>{autoremove_wake_function+0}
  <ffffffff80135756>{autoremove_wake_function+0}
  <ffffffffa006a914>{:jbd:kjournald+250}
  <ffffffff80135756>{autoremove_wake_function+0}
  <ffffffff80135756>{autoremove_wake_function+0}
  <ffffffffa006a814>{:jbd:commit_timeout+0}
  <ffffffff80110f47>{child_rip+8}
  <ffffffffa006a81a>{:jbd:kjournald+0}
  <ffffffff80110f3f>{child_rip+0}

  Code: 0f 0b bd e2 06 a0 ff ff ff ff 40 02 48 8b ab 18 01 00 00 48
  RIP <ffffffffa006c18a>{:jbd:journal_next_log_block+76} RSP
  <0000010476327b88>
  <0>Kernel panic - not syncing: Oops

(Note I editied together some lines in the "Modules linked in"
section. The rest is cut from the serial console (size 80x24) on the
system.)

We are running centos 4.4 kernel. Uname -a shows:

  Linux cook05 2.6.9-42.0.3.ELsmp #1 SMP Fri Oct 6 06:28:26 CDT 2006
  x86_64 x86_64 x86_64 GNU/Linux 

The disk subsystem for this crash are 4 sata disks on a 3ware 9550
(see the attached dmesg output for more info) with a mix of western
digital and seagate drives. It has also crashed with sysrq enabled and
(not surprisingly) the system is totally dead. We have to power cycle
it to reboot it.

Other systems experiencing the same crash have:

   * non-smp version of the same kernel with the software md raid
     drivers
   * same kernel running a megaraid raid card

The same crash has also been seen with an earlier kernel version
2.6.9-42.ELsmp.

It seems to crash when we expect the system to have high IO, but we
don't have any hard evidence of throughput/transactions to disk to
support that.

We can try setting up a remote kernel dump if that would be
useful/would work.

We get a crash every couple of days on average (sometimes two crashes
with 30 min-2 hours between them) so we can try applying patches/new
kernels if needed and see how the system does.

I have attached selected lines from dmesg to give some additional info
about the hardware and config of the system. I initaly submitted this
with the /proc/kallsyms from the system as requested by the mailing
list FAQ at: http://www.tux.org/lkml/#s4-3, but it's been two days and
the email hasn't shown up on the mailing list archives. So I have
removed it from this post. It is available on request. The dmesg files
is from a post crash boot that should be identical to the pre-crash
boot.

If you require more/different information just let me know and I will
try to obtain it.

Thank you for your help and please cc me on any replies.

--
				-- rouilj

John Rouillard
System Administrator
Renesys Corporation
603-643-9300 x 111

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cook05.dmesg_selected.txt"


Linux version 2.6.9-42.0.3.ELsmp (buildcentos@x8664-build.centos.org)
(gcc version 3.4.6 20060404 (Red Hat 3.4.6-3)) #1 SMP
Fri Oct 6 06:28:26 CDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000480000000 (usable)
ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000f97a0
ACPI: RSDT (v001 A M I  OEMRSDT  0x04000610 MSFT 0x00000097) @ 0x000000007fff000
0
ACPI: FADT (v002 A M I  OEMFACP  0x04000610 MSFT 0x00000097) @ 0x000000007fff020
0
ACPI: MADT (v001 A M I  OEMAPIC  0x04000610 MSFT 0x00000097) @ 0x000000007fff038
0
ACPI: OEMB (v001 A M I  OEMBIOS  0x04000610 MSFT 0x00000097) @ 0x000000007ffff04
0
ACPI: SRAT (v001 A M I  OEMSRAT  0x04000610 MSFT 0x00000097) @ 0x000000007fff355
0
ACPI: DSDT (v001  H8DAR H8DAR010 0x00000000 INTL 0x02002026) @ 0x000000000000000
0

CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0
CPU0: AMD Opteron(tm) Processor 250 stepping 01
per-CPU timeslice cutoff: 1024.16 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp 10478fd9f58
Initializing CPU#1
Calibrating delay using timer specific routine.. 4810.25 BogoMIPS (lpj=2405126)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 1
AMD Opteron(tm) Processor 250 stepping 01
Total of 2 processors activated (9627.98 BogoMIPS).
Using local APIC timer interrupts.
Detected 12.528 MHz APIC timer.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs


Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: CD-224E-N, ATAPI CD/DVD-ROM drive
Using cfq io scheduler
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide0...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hdc: ATAPI 24X CD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27

SCSI subsystem initialized
libata version 1.20 loaded.
sata_mv 0000:03:03.0: version 0.6
ACPI: PCI interrupt 0000:03:03.0[A] -> GSI 42 (level, low) -> IRQ 185
sata_mv 0000:03:03.0: 32 slots 4 ports unknown mode IRQ via INTx
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFFF00000A2120 bmdma 0x0 irq 185
ata2: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFFF00000A4120 bmdma 0x0 irq 185
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFFF00000A6120 bmdma 0x0 irq 185
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFFF00000A8120 bmdma 0x0 irq 185
ata1: no device found (phy stat 00000000)
scsi0 : sata_mv
ata2: no device found (phy stat 00000000)
scsi1 : sata_mv
ata3: no device found (phy stat 00000000)
scsi2 : sata_mv
ata4: no device found (phy stat 00000000)
scsi3 : sata_mv
3ware 9000 Storage Controller device driver for Linux v2.26.04.010.
ACPI: PCI interrupt 0000:03:01.0[A] -> GSI 40 (level, low) -> IRQ 177
scsi4 : 3ware 9000 Storage Controller
3w-9xxx: scsi4: Found a 3ware 9000 Storage Controller at 0xfe9ff000, IRQ: 177.
3w-9xxx: scsi4: Firmware FE9X 3.04.01.011, BIOS BE9X 3.04.00.002, Ports: 4.
  Vendor: AMCC      Model: 9550SX-4LP DISK   Rev: 3.04
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sda: 1953083392 512-byte hdwr sectors (999979 MB)
SCSI device sda: drive cache: write back, no read (daft)
SCSI device sda: 1953083392 512-byte hdwr sectors (999979 MB)
SCSI device sda: drive cache: write back, no read (daft)
 sda: sda1 sda2
Attached scsi disk sda at scsi4, channel 0, id 0, lun 0
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
cdrom: open failed.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.

EXT3 FS on dm-0, internal journal
cdrom: open failed.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-1, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-2, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-3, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-4, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-6, type ext3), uses xattr
Adding 4095992k swap on /dev/VolGroup00/LogVol05.  Priority:-1 extents:1

--45Z9DzgjV8m4Oswq--
