Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVGHGlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVGHGlN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 02:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVGHGlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 02:41:12 -0400
Received: from [59.92.138.139] ([59.92.138.139]:61124 "EHLO athena.localdomain")
	by vger.kernel.org with ESMTP id S261432AbVGHGlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 02:41:06 -0400
Date: Fri, 8 Jul 2005 12:10:50 +0530 (IST)
From: Amit Gurdasani <gurdasani@yahoo.com>
X-X-Sender: amitg@athena.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Amit Gurdasani <gurdasani@yahoo.com>
Subject: Unsolved ext3 errors (2.4.30)
Message-ID: <Pine.LNX.4.62.0507081134410.3736@athena.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running Debian sid with a stock 2.4.30 kernel. For the past three months 
or so I have been seeing almost daily (frequently multiple times a day) ext3 
journal aborts on the root filesystem that typically look like this (the 
error number varies):

Jul  8 07:32:29 athena kernel: EXT3-fs error (device ide0(3,2)) in ext3_dirty_inode: error 331547060
Jul  8 07:32:29 athena kernel: Aborting journal on device ide0(3,2).
Jul  8 07:32:29 athena kernel: Remounting filesystem read-only
Jul  8 07:32:29 athena kernel: ext3_reserve_inode_write: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device ide0(3,2)) in ext3_reserve_inode_write: Journal has aborted
Jul  8 07:32:29 athena kernel: EXT3-fs error (device ide0(3,2)) in ext3_commit_write: error 331547060
Jul  8 07:32:29 athena kernel: EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
Jul  8 07:32:29 athena kernel: EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
Jul  8 07:32:29 athena kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000005
Jul  8 07:32:29 athena kernel:  printing eip:
Jul  8 07:32:29 athena kernel: c0178358
Jul  8 07:32:29 athena kernel: *pde = 00000000
Jul  8 07:32:29 athena kernel: Oops: 0002
Jul  8 07:32:29 athena kernel: CPU:    0
Jul  8 07:32:29 athena kernel: EIP:    0010:[journal_commit_transaction+2856/4571]    Not tainted
Jul  8 07:32:29 athena kernel: EFLAGS: 00010293
Jul  8 07:32:29 athena kernel: eax: 00000001   ebx: ca99de14   ecx: ec3cfe4c   edx: 00000000
Jul  8 07:32:29 athena kernel: esi: 00000001   edi: 00000002   ebp: edfe3740   esp: edb6fe78
Jul  8 07:32:29 athena kernel: ds: 0018   es: 0018   ss: 0018
Jul  8 07:32:29 athena kernel: Process kjournald (pid: 14, stackpage=edb6f000)
Jul  8 07:32:29 athena kernel: Stack: cef7e0c0 00000001 edb6feac 00008269 00000008 edfe36f4 00000000 00000000 
Jul  8 07:32:29 athena kernel:        00000000 00000000 ca99ddc0 c5f65fc0 00008269 e1fb3640 db05d0c0 cd55f6c0 
Jul  8 07:32:29 athena kernel:        d57cef40 e7043bc0 c774fbc0 d5d082c0 d5d085c0 d5d083c0 d5d08540 c7f8ca40 
Jul  8 07:32:29 athena kernel: Call Trace:    [tasklet_hi_action+64/112] [__switch_to+216/224] [schedule+503/816] [kjournald+276/512] [commit_timeout+0/16]
Jul  8 07:32:29 athena kernel:   [arch_kernel_thread+43/64] [kjournald+0/512]
Jul  8 07:32:29 athena kernel: 
Jul  8 07:32:29 athena kernel: Code: 89 50 04 89 02 c7 41 04 00 00 00 00 c7 01 00 00 00 00 89 0c 
Jul  8 07:32:30 athena kernel:  <2>EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
Jul  8 07:32:35 athena kernel: EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
Jul  8 07:33:08 athena last message repeated 13 times
Jul  8 07:34:14 athena last message repeated 17 times
Jul  8 07:35:16 athena last message repeated 22 times
Jul  8 07:35:56 athena last message repeated 84 times
Jul  8 07:35:57 athena kernel: usb_control/bulk_msg: timeout
Jul  8 07:35:57 athena kernel: EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
Jul  8 07:36:28 athena last message repeated 123 times
Jul  8 07:37:29 athena last message repeated 262 times
Jul  8 07:38:30 athena last message repeated 253 times
Jul  8 07:39:31 athena last message repeated 256 times
Jul  8 07:40:32 athena last message repeated 260 times

These messages are _not_ preceded by any hardware-level errors (IDE channel 
resets, CRC errors or any other such indication that the cause may be 
hardware failure).

The filesystem is on /dev/hda2 -- a 73G partition that is currently 35% 
(25G) utilized. The disk is a Maxtor DiamondMax D740X (model 6L080L4) made 
in 2002. It does not share the IDE channel with another device.

I have not been able to isolate any particular application or access pattern 
that triggers this issue.

In the call stacks each time, the schedule -> kjournald -> commit_timeout -> 
arch_kernel_thread -> kjournald portion commonly occurs.

I have tried to create a filesystem on another drive, copy all the files 
over, mke2fs this filesystem again and copy all the files back over again, 
but the issue keeps happening. (On next boot, a fsck of the filesystem never 
finds any major issues -- deleted files with the wrong dtime, free block 
count wrong, etc.)

I've provided more information about the system below. (The kernel 
configuration is right at the end.)

What could be the cause of the issue, and is there any workaround I can 
perform?

Thanks.

Amit

P.S.: I'm only subscribed to linux-kernel-digest, so please cc me in 
responses.

uname -a:

Linux athena.localdomain 2.4.30 #2 Wed Jul 6 11:38:05 IST 2005 i686 GNU/Linux

/proc/mounts:

rootfs / rootfs rw 0 0
/dev/root / ext3 ro,noatime 0 0
none /dev devfs rw 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw 0 0
tmpfs /dev/shm tmpfs rw 0 0
usbfs /proc/bus/usb usbfs rw 0 0
/dev/hda1 /mnt/win vfat rw,noatime,nosuid,nodev,noexec 0 0
/dev/sda1 /mnt/loop ntfs ro,noatime 0 0
/dev/hdc1 /mnt/space ntfs ro,noatime 0 0
/dev/hdc2 /mnt/scratch ext3 rw,noatime 0 0
none /proc/bus/usb usbdevfs rw 0 0
automount(pid1846) /misc autofs rw 0 0
automount(pid1925) /smb autofs rw 0 0
automount(pid1949) /net autofs rw 0 0
none /proc/sys/fs/binfmt_misc binfmt_misc rw 0 0

/etc/mtab:

/dev/ide/host0/bus0/target0/lun0/part2 / ext3 rw,noatime,errors=remount-ro 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw,gid=5,mode=620 0 0
tmpfs /dev/shm tmpfs rw 0 0
usbfs /proc/bus/usb usbfs rw 0 0
/dev/ide/host0/bus0/target0/lun0/part1 /mnt/win vfat rw,noexec,nosuid,nodev,noatime,gid=2000,umask=007,iocharset=utf8 0 0
/dev/scsi/host0/bus0/target1/lun0/part1 /mnt/loop ntfs ro,noatime,gid=2000,umask=0227,uid=1000,iocharset=utf8 0 0
/dev/ide/host0/bus1/target0/lun0/part1 /mnt/space ntfs ro,noatime,gid=2000,umask=0227,uid=1000,iocharset=utf8 0 0
/dev/ide/host0/bus1/target0/lun0/part2 /mnt/scratch ext3 rw,noatime,errors=remount-ro 0 0
none /proc/bus/usb usbdevfs rw 0 0
tmpfs /dev tmpfs rw,size=10M,mode=0755 0 0
automount(pid1846) /misc autofs rw,fd=4,pgrp=1846,minproto=2,maxproto=4 0 0
automount(pid1925) /smb autofs rw,fd=4,pgrp=1925,minproto=2,maxproto=4 0 0
automount(pid1949) /net autofs rw,fd=4,pgrp=1949,minproto=2,maxproto=4 0 0
none /proc/sys/fs/binfmt_misc binfmt_misc rw 0 0

df output:

Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/ide/host0/bus0/target0/lun0/part2
                       75623644  25902208  48953128  35% /
tmpfs                   371292         4    371288   1% /dev/shm
/dev/ide/host0/bus0/target0/lun0/part1
                        1028110    716583    311527  70% /mnt/win
/dev/scsi/host0/bus0/target1/lun0/part1
                       35832948  30419584   5413364  85% /mnt/loop
/dev/ide/host0/bus1/target0/lun0/part1
                       97691878  50596290  47095588  52% /mnt/space
/dev/ide/host0/bus1/target0/lun0/part2
                       95863976  49278636  46061052  52% /mnt/scratch

Bootup kernel messages:

dfec000
ACPI: FADT (v001 ASUS   A7N266VM 0x42302e31 MSFT 0x31313031) @ 0x2dfec100
ACPI: BOOT (v001 ASUS   A7N266VM 0x42302e31 MSFT 0x31313031) @ 0x2dfec040
ACPI: MADT (v001 ASUS   A7N266VM 0x42302e31 MSFT 0x31313031) @ 0x2dfec080
ACPI: DSDT (v001   ASUS A7N266VM 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium(tm) Pro APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Using ACPI (MADT) for SMP configuration information
Kernel command line: root=/dev/hda2 vga=0x0f07 ro
Initializing CPU#0
Detected 1403.198 MHz processor.
Console: colour VGA+ 80x60
Calibrating delay loop... 2798.38 BogoMIPS
Memory: 742432k/753584k available (1551k kernel code, 10640k reserved, 470k data, 152k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(TM) XP 1600+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... failed.
...trying to set up timer as ExtINT IRQ... works.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1403.2044 MHz.
..... host bus clock speed is 267.2769 MHz.
cpu: 0, clocks: 2672769, slice: 1336384
CPU0<T0:2672768,T1:1336384,D:0,S:1336384,C:2672769>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20040326
PCI: PCI BIOS revision 2.10 entry at 0xf1b40, last bus=2
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 16 18) *5
ACPI: PCI Interrupt Link [LNKB] (IRQs 16 18) *5
ACPI: PCI Interrupt Link [LNKC] (IRQs 16 18) *5
ACPI: PCI Interrupt Link [LNKD] (IRQs 16 18) *5
ACPI: PCI Interrupt Link [LNKE] (IRQs 19) *11
ACPI: PCI Interrupt Link [LNKF] (IRQs 20 21 22) *5
ACPI: PCI Interrupt Link [LNKU] (IRQs 20 21 22) *10
ACPI: PCI Interrupt Link [LNKI] (IRQs 20 21 22) *10
ACPI: PCI Interrupt Link [LNKJ] (IRQs 20 21 22) *5
ACPI: PCI Interrupt Link [LNKK] (IRQs 20 21 22) *11
ACPI: PCI Interrupt Link [LNKM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 22
00:00:01[A] -> 2-22 -> IRQ 22 level high
ACPI: PCI Interrupt Link [LNKU] enabled at IRQ 21
00:00:02[A] -> 2-21 -> IRQ 21 level high
ACPI: PCI Interrupt Link [LNKI] enabled at IRQ 20
00:00:04[A] -> 2-20 -> IRQ 20 level high
ACPI: PCI Interrupt Link [LNKJ] enabled at IRQ 22
ACPI: PCI Interrupt Link [LNKK] enabled at IRQ 21
ACPI: PCI Interrupt Link [LNKM] enabled at IRQ 20
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 18
00:01:06[A] -> 2-18 -> IRQ 18 level high
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 16
00:01:06[B] -> 2-16 -> IRQ 16 level high
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 18
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 16
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 19
00:02:00[A] -> 2-19 -> IRQ 19 level high
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
  00 000 00  1    0    0   0   0    0    0    00
  01 001 01  0    0    0   0   0    1    1    39
  02 000 00  1    0    0   0   0    0    0    00
  03 001 01  0    0    0   0   0    1    1    41
  04 001 01  0    0    0   0   0    1    1    49
  05 001 01  0    0    0   0   0    1    1    51
  06 001 01  0    0    0   0   0    1    1    59
  07 001 01  1    0    0   0   0    1    1    61
  08 001 01  0    0    0   0   0    1    1    69
  09 001 01  0    1    0   0   0    1    1    71
  0a 001 01  0    0    0   0   0    1    1    79
  0b 001 01  0    0    0   0   0    1    1    81
  0c 001 01  0    0    0   0   0    1    1    89
  0d 001 01  0    0    0   0   0    1    1    91
  0e 001 01  0    0    0   0   0    1    1    99
  0f 001 01  0    0    0   0   0    1    1    A1
  10 001 01  1    1    0   0   0    1    1    C9
  11 000 00  1    0    0   0   0    0    0    00
  12 001 01  1    1    0   0   0    1    1    C1
  13 001 01  1    1    0   0   0    1    1    D1
  14 001 01  1    1    0   0   0    1    1    B9
  15 001 01  1    1    0   0   0    1    1    B1
  16 001 01  1    1    0   0   0    1    1    A9
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
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
.................................... done.
PCI: Using ACPI for IRQ routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
BIOS EDD facility v0.11 2004-Jun-21, 4 devices found
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU] (supports C1)
Detected PS/2 Mouse Port.
pty: 2048 Unix98 ptys configured
Real Time Clock Driver v1.10f
Software Watchdog Timer: 0.05, timer margin: 60 sec
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE: IDE controller at PCI slot 00:09.0
NFORCE: chipset revision 195
NFORCE: not 100% native mode: will probe irqs later
NFORCE: BIOS didn't set cable bits correctly. Enabling workaround.
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE: 00:09.0 (rev c3) UDMA100 controller
     ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:DMA, hdd:DMA
hda: MAXTOR 6L080L4, ATA DISK drive
blk: queue c035c860, I/O limit 4095Mb (mask 0xffffffff)
hdc: WDC WD2000JB-00GVA0, ATA DISK drive
hdd: DVD-ROM 16X, ATAPI CD/DVD-ROM drive
blk: queue c035ccb4, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=9732/255/63, UDMA(100)
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 390721968 sectors (200050 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(33)
Partition check:
  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
  /dev/ide/host0/bus1/target0/lun0: p1 p2 p3
Guestimating sector 156353887 for superblock
Guestimating sector 390700544 for superblock
driver for Silicon Image(tm) Medley(tm) hardware version 0.0.1: No raid array found
SCSI subsystem driver Revision: 1.00
i91u: PCI Base=0xB800, IRQ=18, BIOS=0xD4000, SCSI ID=7
i91u: Reset SCSI Bus ... 
scsi0 : Initio INI-9X00U/UW SCSI device driver; Revision: 1.03g
   Vendor: IBM       Model: DDYS-T36950M      Rev: SC4D
   Type:   Direct-Access                      ANSI SCSI revision: 03
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
SCSI device sda: 71687212 512-byte hdwr sectors (36704 MB)
  /dev/scsi/host0/bus0/target1/lun0: p1
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Setting latency timer of device 00:02.0 to 64
host/usb-ohci.c: USB OHCI at membase 0xee80b000, IRQ 21
host/usb-ohci.c: usb-00:02.0, nVidia Corporation nForce USB Controller
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 3 ports detected
PCI: Setting latency timer of device 00:03.0 to 64
host/usb-ohci.c: USB OHCI at membase 0xee80d000, IRQ 21
host/usb-ohci.c: usb-00:03.0, nVidia Corporation nForce USB Controller (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
host/usb-ohci.c: USB OHCI at membase 0xee80f000, IRQ 18
host/usb-ohci.c: usb-01:07.0, ALi Corporation USB 1.1 Controller
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-ohci.c: USB OHCI at membase 0xee811000, IRQ 16
host/usb-ohci.c: usb-01:07.1, ALi Corporation USB 1.1 Controller (#2)
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 152k freed
hub.c: new USB device 00:02.0-1, assigned address 2
hiddev0: USB HID v1.10 Device [American Power Conversion Back-UPS ES 500 FW:850.m3.I USB FW:m3] on usb1:2.0
hub.c: new USB device 00:02.0-2, assigned address 3
input: USB HID v1.00 Mouse [04fc:0005] on usb1:3.0
hub.c: new USB device 01:07.1-1, assigned address 2
usb.c: USB device 2 (vend/prod 0x4cf/0x8813) is not claimed by any active driver.
Adding Swap: 297192k swap-space (priority -1)
Adding Swap: 265064k swap-space (priority -2)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
mice: PS/2 mouse device common for all mice
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
scsi1 : SCSI emulation for USB Mass Storage devices
   Vendor: LITE-ON   Model: LTR-48327S        Rev: PQS3
   Type:   CD-ROM                             ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
USB Mass Storage support registered.
i2c-core.o: i2c core module version 2.9.1 (20050412)
i2c-proc.o version 2.9.1 (20050412)
i2c-dev.o: i2c /dev entries driver module version 2.9.1 (20050412)
i2c-isa.o version 2.9.1 (20050412)
i2c-dev.o: Registered 'ISA main adapter' as minor 0
i2c-amd756.o version 2.9.1 (20050412)
i2c-dev.o: Registered 'SMBus nVidia nForce adapter at 5500' as minor 1
eeprom.o version 2.9.1 (20050412)
ddcmon.o version 2.9.1 (20050412)
w83781d.o version 2.9.1 (20050412)
PCI: Enabling device 00:06.0 (0005 -> 0007)
PCI: Setting latency timer of device 00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49576 usecs
intel8x0: clocking to 47435
devfs_register(unknown): could not append to parent, err: -17
devfs_register(unknown): could not append to parent, err: -17
devfs_register(unknown): could not append to parent, err: -17
devfs_register(unknown): could not append to parent, err: -17
loop: loaded (max 8 devices)
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 175x/48x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
hdd: attached ide-cdrom driver.
hdd: ATAPI 50X DVD-ROM drive, 256kB Cache, UDMA(33)
inserting floppy driver for 2.4.30
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
pcnet32.c:v1.30h 06.24.2004 tsbogend@alpha.franken.de
ip_tables: (C) 2000-2002 Netfilter core team
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
ppdev: user-space parallel port driver
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ DETECT_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Non-volatile memory driver v1.2
ehci_hcd 01:07.3: ALi Corporation USB 2.0 Controller
ehci_hcd 01:07.3: irq 16, pci mem ee96b000
usb.c: new USB bus registered, assigned bus number 5
ehci_hcd 01:07.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29/2.4
hub.c: USB hub found
hub.c: 6 ports detected
usb.c: USB disconnect on device 01:07.1-1 address 2
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
MSDOS FS: IO charset utf8
NTFS driver v1.1.22 [Flags: R/W MODULE]
hub.c: new USB device 01:07.3-3, assigned address 2
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide1(22,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.30.
PCI: Setting latency timer of device 00:04.0 to 64
eth0: forcedeth.c: subsystem: 01043:0c11 bound to 00:04.0
Linux video capture interface: v1.00
bttv: driver version 0.7.108 loaded
bttv: using 4 buffers with 2080k (8320k total) for capture
bttv: Bt8xx card found (0).
bttv0: Bt848 (rev 18) at 01:06.0, irq: 18, latency: 64, mmio: 0xef800000
bttv0: using: AVerMedia TVCapture 98 [card=13,insmod option]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [11]
i2c-algo-bit.o: (0) scl=0, sda=0
i2c-algo-bit.o: bt848 #0 seems to be busy.
bttv: readee error
bttv0: Avermedia eeprom[0x0000]: tuner=2 radio:no remote control:no
bttv0: using tuner=2
bttv0: PLL: 28636363 => 35468950 .. ok
bttv0: registered device video0
bttv0: registered device vbi0

lspci -vv output:

0000:00:00.0 Host bridge: nVidia Corporation nForce CPU bridge (rev b2)
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0
 	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
 	Capabilities: <available only to root>

0000:00:00.1 RAM memory: nVidia Corporation nForce 220/420 Memory Controller (rev b2)
 	Subsystem: nVidia Corporation: Unknown device 0c11
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:00.2 RAM memory: nVidia Corporation nForce 220/420 Memory Controller (rev b2)
 	Subsystem: nVidia Corporation: Unknown device 0c11
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:00.3 RAM memory: nVidia Corporation: Unknown device 01aa (rev b2)
 	Subsystem: nVidia Corporation: Unknown device 0c11
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:01.0 ISA bridge: nVidia Corporation nForce ISA Bridge (rev c3)
 	Subsystem: nVidia Corporation: Unknown device 0c11
 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0
 	Capabilities: <available only to root>

0000:00:01.1 SMBus: nVidia Corporation nForce PCI System Management (rev c1)
 	Subsystem: nVidia Corporation: Unknown device 0c11
 	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Interrupt: pin A routed to IRQ 22
 	Region 0: I/O ports at 5000 [size=16]
 	Region 1: I/O ports at 5500 [size=16]
 	Region 2: I/O ports at 5100 [size=32]
 	Capabilities: <available only to root>

0000:00:02.0 USB Controller: nVidia Corporation nForce USB Controller (rev c3) (prog-if 10 [OHCI])
 	Subsystem: nVidia Corporation: Unknown device 0c11
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0 (750ns min, 250ns max)
 	Interrupt: pin A routed to IRQ 21
 	Region 0: Memory at df000000 (32-bit, non-prefetchable) [size=4K]
 	Capabilities: <available only to root>

0000:00:03.0 USB Controller: nVidia Corporation nForce USB Controller (rev c3) (prog-if 10 [OHCI])
 	Subsystem: nVidia Corporation: Unknown device 0c11
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0 (750ns min, 250ns max)
 	Interrupt: pin A routed to IRQ 21
 	Region 0: Memory at de800000 (32-bit, non-prefetchable) [size=4K]
 	Capabilities: <available only to root>

0000:00:04.0 Ethernet controller: nVidia Corporation nForce Ethernet Controller (rev c2)
 	Subsystem: Asustek Computer, Inc.: Unknown device 0c11
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0 (250ns min, 5000ns max)
 	Interrupt: pin A routed to IRQ 20
 	Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=1K]
 	Region 1: I/O ports at d800 [size=8]
 	Capabilities: <available only to root>

0000:00:05.0 Multimedia audio controller: nVidia Corporation: Unknown device 01b0 (rev c2)
 	Subsystem: Asustek Computer, Inc.: Unknown device 0c11
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0 (250ns min, 3000ns max)
 	Interrupt: pin A routed to IRQ 22
 	Region 0: Memory at dd800000 (32-bit, non-prefetchable) [size=512K]
 	Capabilities: <available only to root>

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce Audio (rev c2)
 	Subsystem: Asustek Computer, Inc.: Unknown device 8384
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0 (500ns min, 1250ns max)
 	Interrupt: pin A routed to IRQ 21
 	Region 0: I/O ports at e100 [size=256]
 	Region 1: I/O ports at e000 [size=128]
 	Region 2: Memory at dd000000 (32-bit, non-prefetchable) [size=4K]
 	Capabilities: <available only to root>

0000:00:08.0 PCI bridge: nVidia Corporation nForce PCI-to-PCI bridge (rev c2) (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0
 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
 	I/O behind bridge: 0000b000-0000bfff
 	Memory behind bridge: db000000-dcffffff
 	Prefetchable memory behind bridge: ef700000-efffffff
 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:09.0 IDE interface: nVidia Corporation nForce IDE (rev c3) (prog-if 8a [Master SecP PriP])
 	Subsystem: nVidia Corporation: Unknown device 0c11
 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0 (750ns min, 250ns max)
 	Region 4: I/O ports at a800 [size=16]
 	Capabilities: <available only to root>

0000:00:1e.0 PCI bridge: nVidia Corporation nForce AGP to PCI Bridge (rev b2) (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0
 	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
 	Memory behind bridge: da000000-daffffff
 	Prefetchable memory behind bridge: dff00000-ef6fffff
 	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:01:06.0 Multimedia video controller: Brooktree Corporation Bt848 Video Capture (rev 12)
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 64 (4000ns min, 10000ns max)
 	Interrupt: pin A routed to IRQ 18
 	Region 0: Memory at ef800000 (32-bit, prefetchable) [size=4K]

0000:01:07.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
 	Subsystem: ALi Corporation USB 1.1 Controller
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 64 (20000ns max), Cache Line Size: 0x08 (32 bytes)
 	Interrupt: pin B routed to IRQ 18
 	Region 0: Memory at dc800000 (32-bit, non-prefetchable) [size=4K]
 	Capabilities: <available only to root>

0000:01:07.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
 	Subsystem: ALi Corporation USB 1.1 Controller
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 64 (20000ns max), Cache Line Size: 0x08 (32 bytes)
 	Interrupt: pin C routed to IRQ 16
 	Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=4K]
 	Capabilities: <available only to root>

0000:01:07.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01) (prog-if 20 [EHCI])
 	Subsystem: ALi Corporation USB 2.0 Controller
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 64 (20000ns max), Cache Line Size: 0x10 (64 bytes)
 	Interrupt: pin A routed to IRQ 16
 	Region 0: Memory at db800000 (32-bit, non-prefetchable) [size=256]
 	Capabilities: <available only to root>

0000:01:08.0 SCSI storage controller: Initio Corporation 360P (rev 02)
 	Subsystem: Unknown device 9292:0202
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 64, Cache Line Size: 0x08 (32 bytes)
 	Interrupt: pin A routed to IRQ 18
 	Region 0: I/O ports at b800 [size=256]
 	Region 1: Memory at db000000 (32-bit, non-prefetchable) [size=4K]
 	Expansion ROM at <unassigned> [disabled] [size=32K]

0000:02:00.0 VGA compatible controller: nVidia Corporation NVCrush11 [GeForce2 MX Integrated Graphics] (rev b1) (prog-if 00 [VGA])
 	Subsystem: nVidia Corporation: Unknown device 0c11
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 32 (1250ns min, 250ns max)
 	Interrupt: pin A routed to IRQ 19
 	Region 0: Memory at da000000 (32-bit, non-prefetchable) [size=16M]
 	Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
 	Expansion ROM at dfff0000 [disabled] [size=64K]
 	Capabilities: <available only to root>

lsmod output:

Module                  Size  Used by    Not tainted
snd-seq-oss            26656   0 (unused)
nls_iso8859-1           2844   0 (autoclean)
isofs                  26580   0 (autoclean)
parport_pc             27848   1 (autoclean)
lp                      7048   0 (autoclean)
binfmt_misc             5960   1
bttv                   95072   0 (unused)
i2c-algo-bit            7172   0 [bttv]
videodev                6272   2 [bttv]
forcedeth              10316   1
ntfs                   56032   2 (autoclean)
nls_cp437               4348   1 (autoclean)
vfat                   10572   1 (autoclean)
fat                    31768   0 (autoclean) [vfat]
cpuid                    840   0 (unused)
msr                     1032   0 (unused)
microcode               4196   0
nls_utf8                 768   3
autofs4                 9012   3
ehci-hcd               18828   0 (unused)
nvram                   4564   0 (unused)
uinput                  3104   0 (unused)
serial                 50020   0
ppdev                   6732   0 (unused)
parport                24712   1 [parport_pc lp ppdev]
ppp_deflate             3256   0 (unused)
zlib_inflate           18596   0 [isofs ppp_deflate]
zlib_deflate           19480   0 [ppp_deflate]
ppp_async               6848   0 (unused)
ppp_generic            20580   0 [ppp_deflate ppp_async]
slhc                    4992   0 [ppp_generic]
joydev                  5664   0 (unused)
evdev                   4096   0 (unused)
ip_tables              11968   0 (unused)
floppy                 49592   0
ide-cd                 30112   0
sr_mod                 14712   0
cdrom                  29220   0 [ide-cd sr_mod]
sg                     27932   0
loop                    9112   0 (unused)
snd-virmidi             1280   0
snd-seq-virmidi         2936   0 [snd-virmidi]
snd-seq-midi-event      3272   0 [snd-seq-oss snd-seq-virmidi]
snd-seq                43280   2 [snd-seq-oss snd-seq-virmidi snd-seq-midi-event]
snd-rawmidi            14752   0 [snd-seq-virmidi]
snd-seq-device          4228   0 [snd-seq-oss snd-seq snd-rawmidi]
snd-pcm-oss            46528   0
snd-intel8x0           19008   2 (autoclean)
snd-ac97-codec         65468   0 (autoclean) [snd-intel8x0]
snd-mixer-oss          14584   1 [snd-pcm-oss]
snd-pcm                67944   0 [snd-pcm-oss snd-intel8x0 snd-ac97-codec]
snd-timer              16304   0 [snd-seq snd-pcm]
snd                    42084   1 [snd-seq-oss snd-virmidi snd-seq-virmidi snd-seq-midi-event snd-seq snd-rawmidi snd-seq-device snd-pcm-oss snd-intel8x0 snd-ac97-codec snd-mixer-oss snd-pcm snd-timer]
soundcore               3716  11 [bttv snd]
snd-page-alloc          5256   0 [snd-seq-oss snd-seq snd-rawmidi snd-seq-device snd-intel8x0 snd-mixer-oss snd-pcm snd-timer snd]
w83781d                22020   0
ddcmon                  5576   0 (unused)
eeprom                  4140   0 (unused)
i2c-amd756              3262   0 (unused)
i2c-isa                  764   0 (unused)
i2c-dev                 3872   0 (unused)
i2c-proc                5988   0 [w83781d ddcmon eeprom]
i2c-core               14500   0 [bttv i2c-algo-bit w83781d ddcmon eeprom i2c-amd756 i2c-isa i2c-dev i2c-proc]
usb-storage            25200   0
mousedev                4308   1

/proc/cmdline:

root=/dev/hda2 vga=0x0f07 ro

/proc/cpuinfo:

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(TM) XP 1600+
stepping	: 2
cpu MHz		: 1403.198
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 2798.38

/proc/meminfo:

         total:    used:    free:  shared: buffers:  cached:
Mem:  760406016 752640000  7766016        0 210206720 78102528
Swap: 575750144 73334784 502415360
MemTotal:       742584 kB
MemFree:          7584 kB
MemShared:           0 kB
Buffers:        205280 kB
Cached:          58636 kB
SwapCached:      17636 kB
Active:         190376 kB
Inactive:        91332 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       742584 kB
LowFree:          7584 kB
SwapTotal:      562256 kB
SwapFree:       490640 kB

/proc/slabinfo:

slabinfo - version: 1.1
kmem_cache            61     72    108    2    2    1
ip_fib_hash            9    112     32    1    1    1
tcp_tw_bucket          0      0    128    0    0    1
tcp_bind_bucket       28    112     32    1    1    1
tcp_open_request       1     30    128    1    1    1
inet_peer_cache        1     59     64    1    1    1
ip_dst_cache          11     40    192    1    2    1
arp_cache              2     30    128    1    1    1
uhci_urb_priv          0      0     60    0    0    1
blkdev_requests     6144   6150    128  205  205    1
devfsd_event           0      0     20    0    0    1
journal_head           7    154     48    2    2    1
revoke_table           2    250     12    1    1    1
revoke_record          0      0     32    0    0    1
dnotify_cache         86    169     20    1    1    1
file_lock_cache       26     42     92    1    1    1
fasync_cache           0      0     16    0    0    1
uid_cache             14    112     32    1    1    1
skbuff_head_cache    276    380    192   19   19    1
sock                 232    240   1024   60   60    1
sigqueue               1     29    132    1    1    1
kiobuf                 0      0     64    0    0    1
cdev_cache            32    354     64    6    6    1
bdev_cache             9     59     64    1    1    1
mnt_cache             24     59     64    1    1    1
inode_cache        14737  20321    512 2903 2903    1
dentry_cache        7325  17430    128  581  581    1
dquot                  0      0    128    0    0    1
filp                2853   2880    128   96   96    1
names_cache            1      3   4096    1    3    1
buffer_head       103094 108690    128 3623 3623    1
mm_struct            118    140    192    7    7    1
vm_area_struct      6610   7050    128  235  235    1
fs_cache             117    177     64    3    3    1
files_cache          118    126    448   14   14    1
signal_act           122    129   1344   43   43    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             1      1  65536    1    1   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             6      6  32768    6    6    8
size-16384(DMA)        1      1  16384    1    1    4
size-16384            29     31  16384   29   31    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              3     10   8192    3   10    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096          11293  11308   4096 11293 11308    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048            147    150   2048   75   75    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024          13262  16828   1024 4207 4207    1
size-512(DMA)          0      0    512    0    0    1
size-512           13787  19592    512 2449 2449    1
size-256(DMA)          0      0    256    0    0    1
size-256             914   1605    256  107  107    1
size-128(DMA)          0      0    128    0    0    1
size-128           31255  49710    128 1657 1657    1
size-64(DMA)           0      0     64    0    0    1
size-64            20295  35636     64  604  604    1
size-32(DMA)           0      0     64    0    0    1
size-32            19751  36108     64  612  612    1

/proc/filesystems:

nodev	rootfs
nodev	bdev
nodev	proc
nodev	sockfs
nodev	tmpfs
nodev	shm
nodev	pipefs
 	ext3
 	ext2
nodev	ramfs
nodev	devfs
nodev	devpts
nodev	usbdevfs
nodev	usbfs
nodev	autofs
 	vfat
 	ntfs
nodev	binfmt_misc
 	iso9660

/proc/interrupts:

            CPU0
   0:   12515922          XT-PIC  timer
   1:      47107    IO-APIC-edge  keyboard
   7:      19658    IO-APIC-edge  parport0
   8:    4765121    IO-APIC-edge  rtc
   9:          1   IO-APIC-level  acpi
  14:    1934142    IO-APIC-edge  ide0
  15:    4585736    IO-APIC-edge  ide1
  16:   13825196   IO-APIC-level  usb-ohci, ehci_hcd
  18:    7763012   IO-APIC-level  i91u, usb-ohci, bttv
  20:   12962544   IO-APIC-level  eth0
  21:   17657770   IO-APIC-level  usb-ohci, usb-ohci, NVidia nForce
NMI:          0 
LOC:   12514604 
ERR:          0
MIS:          0

/proc/devices:

Character devices:
   1 mem
   2 pty/m%d
   3 pty/s%d
   4 tts/%d
   5 cua/%d
   6 lp
   7 vcs
  10 misc
  13 input
  14 sound
  21 sg
  29 fb
  36 netlink
  81 video_capture
  89 i2c
  99 ppdev
108 ppp
116 alsa
128 ptm
129 ptm
130 ptm
131 ptm
132 ptm
133 ptm
134 ptm
135 ptm
136 pts/%d
137 pts/%d
138 pts/%d
139 pts/%d
140 pts/%d
141 pts/%d
142 pts/%d
143 pts/%d
162 raw
180 usb
202 cpu/msr
203 cpu/cpuid

Block devices:
   1 ramdisk
   2 fd
   3 ide0
   7 loop
   8 sd
  11 sr
  22 ide1
  65 sd
  66 sd
114 ataraid

Kernel configuration:

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_EDD=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOBIOS=y
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_BIOS=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set
# CONFIG_HOTPLUG_PCI_SHPC_POLL_EVENT_MODE is not set
# CONFIG_HOTPLUG_PCI_PCIE is not set
# CONFIG_HOTPLUG_PCI_PCIE_POLL_EVENT_MODE is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
# CONFIG_OOM_KILLER is not set
CONFIG_PM=y
# CONFIG_APM is not set

#
# ACPI Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_MMCONFIG=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_ASUS=y
CONFIG_ACPI_TOSHIBA=y
# CONFIG_ACPI_DEBUG is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_IP22 is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_CISS_MONITOR_THREAD is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_STATS=y

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_COMPAT_IPFWADM=m
CONFIG_IP_NF_NAT_NEEDED=y

#
#   IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=m

#
#   IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
# CONFIG_KHTTPD is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
# 
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
# CONFIG_BLK_DEV_IDECS is not set
# CONFIG_BLK_DEV_DELKIN is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASK_IOCTL=y

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
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
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
CONFIG_BLK_DEV_SIIMAGE=y
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_ATARAID=y
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
CONFIG_BLK_DEV_ATARAID_MEDLEY=m
CONFIG_BLK_DEV_ATARAID_SII=y

#
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=4
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_MEGARAID2 is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_SATA_SVW is not set
# CONFIG_SCSI_ATA_PIIX is not set
# CONFIG_SCSI_SATA_NV is not set
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_SX4 is not set
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
CONFIG_SCSI_BUSLOGIC=y
CONFIG_SCSI_OMIT_FLASHPOINT=y
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=y
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
CONFIG_ETHERTAP=m
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
CONFIG_FORCEDETH=m
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
CONFIG_8139TOO_TUNE_TWISTER=y
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_SUNDANCE_MMIO is not set
# CONFIG_TLAN is not set
CONFIG_VIA_RHINE=m
CONFIG_VIA_RHINE_MMIO=y
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPPOE is not set
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
CONFIG_SHAPER=m

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_UINPUT=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_MANY_PORTS=y
CONFIG_SERIAL_SHARE_IRQ=y
CONFIG_SERIAL_DETECT_IRQ=y
# CONFIG_SERIAL_MULTIPORT is not set
# CONFIG_HUB6 is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=2048
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
# CONFIG_I2C_ELV is not set
# CONFIG_I2C_VELLEMAN is not set
# CONFIG_SCx200_I2C is not set
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_ALGOPCF=m
# CONFIG_I2C_ELEKTOR is not set
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set

#
# Joysticks
#
# CONFIG_INPUT_ANALOG is not set
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_KCS is not set
# CONFIG_IPMI_WATCHDOG is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I810_TCO is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_60XX_WDT is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
CONFIG_SOFT_WATCHDOG=y
# CONFIG_W83877F_WDT is not set
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SCx200 is not set
# CONFIG_SCx200_GPIO is not set
CONFIG_AMD_RNG=m
CONFIG_INTEL_RNG=m
CONFIG_HW_RANDOM=m
CONFIG_AMD_PM768=m
CONFIG_NVRAM=m
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_K8 is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_NVIDIA=y
# CONFIG_AGP_ATI is not set

#
# Direct Rendering Manager (XFree86 DRI support)
#
CONFIG_DRM=y
# CONFIG_DRM_OLD is not set

#
# DRM 4.1 drivers
#
CONFIG_DRM_NEW=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I810_XFREE_41 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set
# CONFIG_OBMOUSE is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
CONFIG_I2C_PARPORT=m

#
# Video Adapters
#
CONFIG_VIDEO_BT848=m
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_ZORAN_BUZ is not set
# CONFIG_VIDEO_ZORAN_DC10 is not set
# CONFIG_VIDEO_ZORAN_LML33 is not set
# CONFIG_VIDEO_ZR36120 is not set
# CONFIG_VIDEO_MEYE is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_MIROPCM20 is not set
# CONFIG_RADIO_MIROPCM20_RDS is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_SF16FMR2 is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# File systems
#
CONFIG_QUOTA=y
CONFIG_QFMT_V2=m
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
CONFIG_BEFS_FS=m
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
CONFIG_CRAMFS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_JFS_FS=m
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_MINIX_FS=m
CONFIG_VXFS_FS=m
CONFIG_NTFS_FS=m
CONFIG_NTFS_RW=y
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=m
CONFIG_UDF_RW=y
CONFIG_UFS_FS=m
CONFIG_UFS_FS_WRITE=y
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_RT=y
# CONFIG_XFS_TRACE is not set
# CONFIG_XFS_DEBUG is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_DIRECTIO=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="utf-8"
CONFIG_SMB_UNIX=y
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=m

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
# CONFIG_EFI_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="utf-8"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=m
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_RIVA=m
CONFIG_FB_CLGEN=m
# CONFIG_FB_PM2 is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_VESA=y
CONFIG_FB_VGA16=m
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_IT8181 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_MFB=m
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_VGA_PLANES=m
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_FORTE is not set
CONFIG_SOUND_ICH=m
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_AD1889 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
CONFIG_SOUND_VMIDI=m
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
# CONFIG_SOUND_MPU401 is not set
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_PAS_JOYSTICK is not set
# CONFIG_SOUND_PSS is not set
CONFIG_SOUND_SB=m
# CONFIG_SOUND_AWE32_SYNTH is not set
# CONFIG_SOUND_KAHLUA is not set
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
# CONFIG_SOUND_YM3812 is not set
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_YMFPCI_LEGACY is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set
# CONFIG_SOUND_AD1980 is not set
# CONFIG_SOUND_WM97XX is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_UHCI_ALT=y
CONFIG_USB_OHCI=y
# CONFIG_USB_SL811HS_ALT is not set
# CONFIG_USB_SL811HS is not set

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_MIDI is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set

#
# USB Imaging devices
#
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_W9968CF is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_DABUSB is not set

#
# USB Network adaptors
#
# CONFIG_USB_PEGASUS is not set
CONFIG_USB_RTL8150=m
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
CONFIG_USB_CDCETHER=m
CONFIG_USB_USBNET=m

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
# CONFIG_USB_SERIAL_DEBUG is not set
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set

#
# Support for USB gadgets
#
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_LOG_BUF_SHIFT=0

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_TEST=m

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_FW_LOADER=m
