Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263848AbTHXAR0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 20:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263968AbTHXAR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 20:17:26 -0400
Received: from k-kdom.nishanet.com ([65.125.12.2]:34316 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S263848AbTHXAQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 20:16:51 -0400
Message-ID: <3F48010B.6060500@boxho.com>
Date: Sat, 23 Aug 2003 20:04:27 -0400
From: Resident Boxholder <resid@boxho.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: k2.6 amd74xx AMD_IDE fails raid
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MSI K7N2 Delta mboard, Nforce2, AMD xp3000+, PC3200cls2, 550watt ps

kern 2.6.0 beta3, logs refer to ide problems, /proc/ide/amd74xx doesn't 
look right--

#/proc/ide/amd74xx four identical drives, but different speeds here, 
hdparm can fix
# but changes are ignored by amd74xx, and this file is unwriteable--
-------------------drive0----drive1----drive2----drive3-----
Transfer Rate:   99.9MB/s   3.3MB/s  99.9MB/s   3.3MB/s

hdparm -d0 ...bus[0-1].../cd # no dma cd's, per another amd74xx message

raid zero with four Maxtor 60G's, 8mb buff cache each, not booting on raid,
no raid mounted yet, testing a raid-zero device of four 
drives/partitions by a
copy operation

Compile kernels and cp -aR /usr/src /tmp OK, all on first drive, which 
amd74xx
sets up OK. I guess it fails to set up second and fourth drives(see 
/proc/ide/amd74xx),
which makes raid fail when copy exceeds buffer cache size(see another 
amd74xx message),
due to 3000% diff in drive speeds(30x diff according to amd74xx's 
error), too different
for raid to use.

cp -aR /usr/src /tmp
# OK
make bzImage
# OK

mke2fs /dev/md/0
mount -t ext2fs /dev/md/0 /mnt
cp -aR /usr/src /mnt
# crash

mkreiserfs --format 3.6 /dev/md/0
mount -t reiserfs /dev/md/0 /mnt
cp smallfile.txt /mnt
# 0.0 bozomips OK
cp -aR /usr/src /mnt
# crash

reiserfsck /dev/md/0
mount -t reiserfs /dev/md/0 /mnt
cp smallfile.txt /mnt
# OK
swapoff -a # HEY! NOTE!!!!!!
cp -aR /usr/src /mnt
# 0.0 bozomips OK?! CLUE: "speed kills", swapoff made it work

reiserfsck /dev/md/0
mount -t reiserfs /dev/md/0 /mnt
cp smallfile.txt /mnt
# OK
cat /proc/
200000
echo 300000 >
cp -aR /usr/src /mnt
# perhaps a little bit better but crash anyway

#/proc/ide/amd74xx four identical drives, different speeds, hdparm can't 
help!
-------------------drive0----drive1----drive2----drive3-----
Transfer Rate:   99.9MB/s   3.3MB/s  99.9MB/s   3.3MB/s

Aren't drive0 and drive1(and drive2 and drive3) supposed to have the 
same settings
and speed if hda hdc hde hdg are four identical Maxtor 60G ATA/133 
8MBcache? Using
hdparm does not change these settings in /proc/ide/amd74xx and the file 
is not
writeable. If these speeds are so different, couldn't that explain why
when a file copy to a raid partition exceeds the 4 x 8MB = 32MB cache
the kernel locks up? The raid can't handle that 3000% speed diff?

hda and hdc are on the mboard ide controller and hde and hdg are on a 
Promise
chip ata133 pci controller card.

I tried setting turning off dma for two cd drives because a message to 
this list
"fixed" a problem that way, but it doesn't help me.

-Bob D

#/proc/ide/amd74xx
----------AMD BusMastering IDE Configuration----------------
Driver Version:                     2.9
South Bridge:
Revision:                           IDE 0xa2
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xf000
PCI clock:                          33.3MHz
-----------------------Primary IDE-------Secondary IDE------
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                 yes
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 80w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       DMA      UDMA       DMA
Address Setup:       30ns      90ns      30ns      90ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      30ns     270ns
Cycle Time:          20ns     600ns      20ns     600ns
Transfer Rate:   99.9MB/s   3.3MB/s  99.9MB/s   3.3MB/s

#/proc/sys/dev/raid/speed_limit_*
# two files say 1000 min and 200000 max

#/var/log/kern.log /var/log/messages
Aug 23 18:26:01 where exiting on signal 15
Aug 23 18:27:03 where syslogd 1.4.1#10: restart.
Aug 23 18:27:03 where kernel: klogd 1.4.1#10, log source = /proc/kmsg 
started.
Aug 23 18:27:03 where kernel: Cannot find map file.
Aug 23 18:27:03 where kernel: No module symbols loaded - kernel modules 
not enabled.
Aug 23 18:27:03 where kernel:
Aug 23 18:27:03 where kernel: ACPI: PCI Interrupt Link [APCJ] enabled at 
IRQ 22
Aug 23 18:27:03 where kernel: ACPI: PCI Interrupt Link [APCK] enabled at 
IRQ 21
Aug 23 18:27:03 where kernel: ACPI: PCI Interrupt Link [APCL] enabled at 
IRQ 20
Aug 23 18:27:03 where kernel: ACPI: PCI Interrupt Link [APCM] enabled at 
IRQ 22
Aug 23 18:27:03 where kernel: ACPI: PCI Interrupt Link [AP3C] enabled at 
IRQ 21
Aug 23 18:27:03 where kernel: ACPI: PCI Interrupt Link [APCZ] enabled at 
IRQ 20
Aug 23 18:27:03 where kernel: PCI: Using ACPI for IRQ routing
Aug 23 18:27:03 where kernel: PCI: if you experience problems, try using 
option 'pci=noacpi' or even 'acpi=off'
Aug 23 18:27:03 where kernel: pty: 256 Unix98 ptys configured
Aug 23 18:27:03 where kernel: Machine check exception polling timer started.
Aug 23 18:27:03 where kernel: highmem bounce pool size: 64 pages
Aug 23 18:27:03 where kernel: devfs: v1.22 (20021013) Richard Gooch 
(rgooch@atnf.csiro.au)
Aug 23 18:27:03 where kernel: devfs: boot_options: 0x1
Aug 23 18:27:03 where kernel: Installing knfsd (copyright (C) 1996 
okir@monad.swb.de).
Aug 23 18:27:03 where kernel: udf: registering filesystem
Aug 23 18:27:03 where kernel: Initializing Cryptographic API
Aug 23 18:27:03 where kernel: ACPI: Processor [CPU0] (supports C1)
Aug 23 18:27:03 where kernel: ACPI: Thermal Zone [THRM] (37 C)
Aug 23 18:27:03 where kernel: Real Time Clock Driver v1.11
Aug 23 18:27:03 where kernel: Non-volatile memory driver v1.2
Aug 23 18:27:03 where kernel: Linux agpgart interface v0.100 (c) Dave Jones
Aug 23 18:27:03 where kernel: agpgart: Detected NVIDIA nForce2 chipset
Aug 23 18:27:03 where kernel: agpgart: Maximum main memory to use for 
agp memory: 941M
Aug 23 18:27:03 where kernel: agpgart: AGP aperture is 64M @ 0xd8000000
Aug 23 18:27:03 where kernel: Hangcheck: starting hangcheck timer 0.5.0 
(tick is 180 seconds, margin is 60 seconds).
Aug 23 18:27:03 where kernel: Serial: 8250/16550 driver $Revision: 1.90 
$ IRQ sharing disabled
Aug 23 18:27:03 where kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Aug 23 18:27:03 where kernel: Using anticipatory scheduling elevator
Aug 23 18:27:03 where kernel: Floppy drive(s): fd0 is 1.44M
Aug 23 18:27:03 where kernel: FDC 0 is a post-1991 82077
Aug 23 18:27:03 where kernel: RAMDISK driver initialized: 16 RAM disks 
of 0K size 1024 blocksize
Aug 23 18:27:03 where kernel: loop: loaded (max 8 devices)
Aug 23 18:27:03 where kernel: nbd: registered device at major 43
Aug 23 18:27:03 where kernel: 8139too Fast Ethernet driver 0.9.26
Aug 23 18:27:03 where kernel: eth0: RealTek RTL8139 Fast Ethernet at 
0xf8808000, 00:40:f4:71:45:9f, IRQ 19
Aug 23 18:27:03 where kernel: Universal TUN/TAP device driver 1.5 
(C)1999-2002 Maxim Krasnyansky
Aug 23 18:27:03 where kernel: Uniform Multi-Platform E-IDE driver 
Revision: 7.00alpha2
Aug 23 18:27:03 where kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
Aug 23 18:27:03 where kernel: NFORCE2: IDE controller at PCI slot 
0000:00:09.0
Aug 23 18:27:03 where kernel: NFORCE2: chipset revision 162
Aug 23 18:27:03 where kernel: NFORCE2: not 100%% native mode: will probe 
irqs later
Aug 23 18:27:03 where kernel: AMD_IDE: Bios didn't set cable bits 
correctly. Enabling workaround.
Aug 23 18:27:03 where kernel: AMD_IDE: Bios didn't set cable bits 
correctly. Enabling workaround.
Aug 23 18:27:03 where kernel: AMD_IDE:  (rev a2) UDMA100 controller on 
pci0000:00:09.0
Aug 23 18:27:03 where kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS 
settings: hda:DMA, hdb:DMA
Aug 23 18:27:03 where kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS 
settings: hdc:DMA, hdd:DMA
Aug 23 18:27:03 where kernel: hda: Maxtor 6Y060P0, ATA DISK drive
Aug 23 18:27:03 where kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 23 18:27:03 where kernel: hdc: Maxtor 6Y060P0, ATA DISK drive
Aug 23 18:27:03 where kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug 23 18:27:03 where kernel: PDC20269: IDE controller at PCI slot 
0000:01:07.0
Aug 23 18:27:03 where kernel: PDC20269: chipset revision 2
Aug 23 18:27:03 where kernel: PDC20269: 100%% native mode on irq 16
Aug 23 18:27:03 where kernel:     ide2: BM-DMA at 0xa000-0xa007, BIOS 
settings: hde:pio, hdf:pio
Aug 23 18:27:03 where kernel:     ide3: BM-DMA at 0xa008-0xa00f, BIOS 
settings: hdg:pio, hdh:pio
Aug 23 18:27:03 where kernel: hde: Maxtor 6Y060P0, ATA DISK drive
Aug 23 18:27:03 where kernel: ide2 at 0x9000-0x9007,0x9402 on irq 16
Aug 23 18:27:03 where kernel: hdg: Maxtor 6Y060P0, ATA DISK drive
Aug 23 18:27:03 where kernel: ide3 at 0x9800-0x9807,0x9c02 on irq 16
Aug 23 18:27:03 where kernel: PDC20269: IDE controller at PCI slot 
0000:01:08.0
Aug 23 18:27:03 where kernel: PDC20269: chipset revision 2
Aug 23 18:27:03 where kernel: PDC20269: 100%% native mode on irq 17
Aug 23 18:27:03 where kernel:     ide4: BM-DMA at 0xb400-0xb407, BIOS 
settings: hdi:pio, hdj:pio
Aug 23 18:27:03 where kernel:     ide5: BM-DMA at 0xb408-0xb40f, BIOS 
settings: hdk:pio, hdl:pio
Aug 23 18:27:03 where kernel: hdi: YAMAHA CRW8824E, ATAPI CD/DVD-ROM drive
Aug 23 18:27:03 where kernel: Call Trace:
Aug 23 18:27:03 where kernel:  [<c010d04b>] __report_bad_irq+0x2b/0x90
Aug 23 18:27:03 where kernel:  [<c010d144>] note_interrupt+0x64/0xa0
Aug 23 18:27:03 where kernel:  [<c010d3fe>] do_IRQ+0x12e/0x140
Aug 23 18:27:03 where kernel:  [<c010b85c>] common_interrupt+0x18/0x20
Aug 23 18:27:03 where kernel:  [<c0116304>] delay_tsc+0x14/0x50
Aug 23 18:27:03 where kernel:  [<c0213054>] __delay+0x14/0x20
Aug 23 18:27:03 where kernel:  [<c028cd1d>] ide_delay_50ms+0x1d/0x30
Aug 23 18:27:03 where kernel:  [<c0284f53>] do_probe+0x43/0x250
Aug 23 18:27:03 where kernel:  [<c026315d>] device_add+0xed/0x110
Aug 23 18:27:03 where kernel:  [<c0285655>] probe_hwif+0x365/0x4a0
Aug 23 18:27:03 where kernel:  [<c02857b4>] probe_hwif_init+0x24/0x80
Aug 23 18:27:03 where kernel:  [<c0296fe5>] ide_setup_pci_device+0x55/0x80
Aug 23 18:27:03 where kernel:  [<c0281c0b>] pdc202new_init_one+0x3b/0x40
Aug 23 18:27:03 where kernel:  [<c047e09d>] ide_scan_pcidev+0x5d/0x70
Aug 23 18:27:03 where kernel:  [<c047e0f6>] ide_scan_pcibus+0x46/0xd0
Aug 23 18:27:03 where kernel:  [<c047dfa3>] probe_for_hwifs+0x13/0x30
Aug 23 18:27:03 where kernel:  [<c047dfc8>] 
ide_init_builtin_drivers+0x8/0x20
Aug 23 18:27:03 where kernel:  [<c047e028>] ide_init+0x48/0x60
Aug 23 18:27:03 where kernel:  [<c04667fc>] do_initcalls+0x2c/0xa0
Aug 23 18:27:03 where kernel:  [<c012ef72>] init_workqueues+0x12/0x60
Aug 23 18:27:03 where kernel:  [<c01050a6>] init+0x36/0x1d0
Aug 23 18:27:03 where kernel:  [<c0105070>] init+0x0/0x1d0
Aug 23 18:27:03 where kernel:  [<c0108e99>] kernel_thread_helper+0x5/0xc
Aug 23 18:27:03 where kernel:
Aug 23 18:27:03 where kernel: ide4 at 0xa400-0xa407,0xa802 on irq 17
Aug 23 18:27:03 where kernel: hdk: BCD-F520D CD-ROM, ATAPI CD/DVD-ROM drive
Aug 23 18:27:03 where kernel: ide5 at 0xac00-0xac07,0xb002 on irq 17
Aug 23 18:27:03 where kernel: hda: max request size: 128KiB
Aug 23 18:27:03 where kernel: hda: 120103200 sectors (61492 MB) 
w/7936KiB Cache, CHS=65535/16/63, UDMA(100)
Aug 23 18:27:03 where kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
Aug 23 18:27:03 where kernel: hdc: max request size: 128KiB
Aug 23 18:27:03 where kernel: hdc: 120103200 sectors (61492 MB) 
w/7936KiB Cache, CHS=65535/16/63, UDMA(100)
Aug 23 18:27:03 where kernel:  /dev/ide/host0/bus1/target0/lun0: p1 p2 p3 p4
Aug 23 18:27:03 where kernel: hde: max request size: 128KiB
Aug 23 18:27:03 where kernel: hde: 120103200 sectors (61492 MB) 
w/7936KiB Cache, CHS=65535/16/63, UDMA(133)
Aug 23 18:27:03 where kernel:  /dev/ide/host2/bus0/target0/lun0: p1 p2 p3 p4
Aug 23 18:27:03 where kernel: hdg: max request size: 128KiB
Aug 23 18:27:03 where kernel: hdg: 120103200 sectors (61492 MB) 
w/7936KiB Cache, CHS=65535/16/63, UDMA(133)
Aug 23 18:27:03 where kernel:  /dev/ide/host2/bus1/target0/lun0: p1 p2 p3 p4
Aug 23 18:27:03 where kernel: hdi: ATAPI 16X CD-ROM CD-R/RW drive, 
4096kB Cache
Aug 23 18:27:03 where kernel: Uniform CD-ROM driver Revision: 3.12
Aug 23 18:27:03 where kernel: hdk: ATAPI 52X CD-ROM drive, 128kB Cache
Aug 23 18:27:03 where kernel: ehci_hcd 0000:00:02.2: EHCI Host Controller
Aug 23 18:27:03 where kernel: ehci_hcd 0000:00:02.2: irq 20, pci mem 
f8855000
Aug 23 18:27:03 where kernel: ehci_hcd 0000:00:02.2: new USB bus 
registered, assigned bus number 1
Aug 23 18:27:03 where kernel: PCI: cache line size of 64 is not 
supported by device 0000:00:02.2
Aug 23 18:27:03 where kernel: ehci_hcd 0000:00:02.2: USB 2.0 enabled, 
EHCI 1.00, driver 2003-Jun-13
Aug 23 18:27:03 where kernel: hub 1-0:0: USB hub found
Aug 23 18:27:03 where kernel: hub 1-0:0: 6 ports detected
Aug 23 18:27:03 where kernel: drivers/usb/host/uhci-hcd.c: USB Universal 
Host Controller Interface driver v2.1
Aug 23 18:27:03 where kernel: Initializing USB Mass Storage driver...
Aug 23 18:27:03 where kernel: drivers/usb/core/usb.c: registered new 
driver usb-storage
Aug 23 18:27:03 where kernel: USB Mass Storage support registered.
Aug 23 18:27:03 where kernel: drivers/usb/core/usb.c: registered new 
driver hid
Aug 23 18:27:03 where kernel: drivers/usb/input/hid-core.c: v2.0:USB HID 
core driver
Aug 23 18:27:03 where kernel: mice: PS/2 mouse device common for all mice
Aug 23 18:27:03 where kernel: input: ImExPS/2 Logitech Explorer Mouse on 
isa0060/serio1
Aug 23 18:27:03 where kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Aug 23 18:27:03 where kernel: input: AT Set 2 keyboard on isa0060/serio0
Aug 23 18:27:03 where kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug 23 18:27:03 where kernel: i2c /dev entries driver module version 
2.7.0 (20021208)
Aug 23 18:27:03 where kernel: i2c_adapter i2c-0: nForce2 SMBus adapter 
at 0x5000
Aug 23 18:27:03 where kernel: i2c_adapter i2c-1: nForce2 SMBus adapter 
at 0x5040
Aug 23 18:27:03 where kernel: md: raid0 personality registered as nr 2
Aug 23 18:27:03 where kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, 
MD_SB_DISKS=27
Aug 23 18:27:03 where kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Aug 23 18:27:03 where kernel: IP: routing cache hash table of 8192 
buckets, 64Kbytes
Aug 23 18:27:03 where kernel: TCP: Hash tables configured (established 
262144 bind 65536)
Aug 23 18:27:03 where kernel: Linux IP multicast router 0.06 plus PIM-SM
Aug 23 18:27:03 where kernel: ip_conntrack version 2.1 (8191 buckets, 
65528 max) - 296 bytes per conntrack
Aug 23 18:27:03 where kernel: ip_tables: (C) 2000-2002 Netfilter core team
Aug 23 18:27:03 where kernel: ipt_recent v0.3.1: Stephen Frost 
<sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Aug 23 18:27:03 where kernel: NET4: Unix domain sockets 1.0/SMP for 
Linux NET4.0.
Aug 23 18:27:03 where kernel: BIOS EDD facility v0.09 2003-Jan-22, 4 
devices found
Aug 23 18:27:03 where kernel: md: Autodetecting RAID arrays.
Aug 23 18:27:03 where kernel: md: autorun ...
Aug 23 18:27:03 where kernel: md: ... autorun DONE.
Aug 23 18:27:03 where kernel: hub 1-0:0: debounce: port 1: delay 100ms 
stable 4 status 0x509
Aug 23 18:27:03 where kernel: UDF-fs: No partition found (1)
Aug 23 18:27:03 where kernel: found reiserfs format "3.6" with standard 
journal
Aug 23 18:27:03 where kernel: Call Trace:
Aug 23 18:27:03 where kernel:  [<c010d04b>] __report_bad_irq+0x2b/0x90
Aug 23 18:27:03 where kernel:  [<c010d144>] note_interrupt+0x64/0xa0
Aug 23 18:27:03 where kernel:  [<c010d3fe>] do_IRQ+0x12e/0x140
Aug 23 18:27:03 where kernel:  [<c0105000>] _stext+0x0/0x60
Aug 23 18:27:03 where kernel:  [<c010b85c>] common_interrupt+0x18/0x20
Aug 23 18:27:03 where kernel:  [<c0105000>] _stext+0x0/0x60
Aug 23 18:27:03 where kernel:  [<c0108ca6>] default_idle+0x26/0x30
Aug 23 18:27:03 where kernel:  [<c0108d2b>] cpu_idle+0x3b/0x40
Aug 23 18:27:03 where kernel:  [<c0466784>] start_kernel+0x184/0x1b0
Aug 23 18:27:03 where kernel:  [<c04664c0>] unknown_bootoption+0x0/0x100
Aug 23 18:27:03 where kernel:
Aug 23 18:27:03 where kernel: Call Trace:
Aug 23 18:27:03 where kernel:  [<c010d04b>] __report_bad_irq+0x2b/0x90
Aug 23 18:27:03 where kernel:  [<c010d144>] note_interrupt+0x64/0xa0
Aug 23 18:27:03 where kernel:  [<c010d3fe>] do_IRQ+0x12e/0x140
Aug 23 18:27:03 where kernel:  [<c0105000>] _stext+0x0/0x60
Aug 23 18:27:03 where kernel:  [<c010b85c>] common_interrupt+0x18/0x20
Aug 23 18:27:03 where kernel:  [<c0105000>] _stext+0x0/0x60
Aug 23 18:27:03 where kernel:  [<c0108ca6>] default_idle+0x26/0x30
Aug 23 18:27:03 where kernel:  [<c0108d2b>] cpu_idle+0x3b/0x40
Aug 23 18:27:03 where kernel:  [<c0466784>] start_kernel+0x184/0x1b0
Aug 23 18:27:03 where kernel:  [<c04664c0>] unknown_bootoption+0x0/0x100
Aug 23 18:27:03 where kernel:
Aug 23 18:27:03 where kernel: Reiserfs journal params: device hda1, size 
8192, journal first block 18, max trans len 1024, max batch 900, max 
commit age 30, max trans age 30
Aug 23 18:27:03 where kernel: reiserfs: checking transaction log (hda1) 
for (hda1)
Aug 23 18:27:03 where kernel: Using r5 hash to sort names
Aug 23 18:27:03 where kernel: VFS: Mounted root (reiserfs filesystem).
Aug 23 18:27:03 where kernel: Mounted devfs on /dev
Aug 23 18:27:03 where kernel: Freeing unused kernel memory: 188k freed
Aug 23 18:27:03 where kernel: hub 1-0:0: debounce: port 2: delay 100ms 
stable 4 status 0x509
Aug 23 18:27:03 where kernel: hdi: DMA disabled
Aug 23 18:27:03 where kernel: end_request: I/O error, dev hdi, sector 0
Aug 23 18:27:03 where kernel: APIC error on CPU0: 00(02)
Aug 23 18:27:03 where kernel: hdk: DMA disabled
Aug 23 18:27:03 where kernel: Adding 2097136k swap on 
/dev/ide/host2/bus0/target0/lun0/part1.  Priority:-1 extents:1
Aug 23 18:27:03 where kernel: Adding 2097136k swap on 
/dev/ide/host2/bus1/target0/lun0/part1.  Priority:-2 extents:1
Aug 23 18:27:03 where kernel: Call Trace:
Aug 23 18:27:03 where kernel:  [<c010d04b>] __report_bad_irq+0x2b/0x90
Aug 23 18:27:03 where kernel:  [<c010d144>] note_interrupt+0x64/0xa0
Aug 23 18:27:03 where kernel:  [<c010d3fe>] do_IRQ+0x12e/0x140
Aug 23 18:27:03 where kernel:  [<c0105000>] _stext+0x0/0x60
Aug 23 18:27:03 where kernel:  [<c010b85c>] common_interrupt+0x18/0x20
Aug 23 18:27:03 where kernel:  [<c0105000>] _stext+0x0/0x60
Aug 23 18:27:03 where kernel:  [<c0108ca6>] default_idle+0x26/0x30
Aug 23 18:27:03 where kernel:  [<c0108d2b>] cpu_idle+0x3b/0x40
Aug 23 18:27:03 where kernel:  [<c0466784>] start_kernel+0x184/0x1b0
Aug 23 18:27:03 where kernel:  [<c04664c0>] unknown_bootoption+0x0/0x100
Aug 23 18:27:03 where kernel:
Aug 23 18:27:03 where kernel: Call Trace:
Aug 23 18:27:03 where kernel:  [<c010d04b>] __report_bad_irq+0x2b/0x90
Aug 23 18:27:03 where kernel:  [<c010d144>] note_interrupt+0x64/0xa0
Aug 23 18:27:03 where kernel:  [<c010d3fe>] do_IRQ+0x12e/0x140
Aug 23 18:27:03 where kernel:  [<c0105000>] _stext+0x0/0x60
Aug 23 18:27:03 where kernel:  [<c010b85c>] common_interrupt+0x18/0x20
Aug 23 18:27:03 where kernel:  [<c0105000>] _stext+0x0/0x60
Aug 23 18:27:03 where kernel:  [<c0108ca6>] default_idle+0x26/0x30
Aug 23 18:27:03 where kernel:  [<c0108d2b>] cpu_idle+0x3b/0x40
Aug 23 18:27:03 where kernel:  [<c0466784>] start_kernel+0x184/0x1b0
Aug 23 18:27:03 where kernel:  [<c04664c0>] unknown_bootoption+0x0/0x100
Aug 23 18:27:03 where kernel:
Aug 23 18:27:03 where kernel: hub 1-0:0: debounce: port 3: delay 100ms 
stable 4 status 0x509
Aug 23 18:27:03 where kernel: md: md0 stopped.
Aug 23 18:27:03 where kernel: md: bind<hdc2>
Aug 23 18:27:03 where kernel: md: bind<hde2>
Aug 23 18:27:03 where kernel: md: bind<hdg2>
Aug 23 18:27:03 where kernel: md: bind<hda2>
Aug 23 18:27:03 where kernel: md0: setting max_sectors to 128, segment 
boundary to 32767
Aug 23 18:27:03 where kernel: raid0: looking at hda2
Aug 23 18:27:03 where kernel: raid0:   comparing hda2(7999872) with 
hda2(7999872)
Aug 23 18:27:03 where kernel: raid0:   END
Aug 23 18:27:03 where kernel: raid0:   ==> UNIQUE
Aug 23 18:27:03 where kernel: raid0: 1 zones
Aug 23 18:27:03 where kernel: raid0: looking at hdg2
Aug 23 18:27:03 where kernel: raid0:   comparing hdg2(7999872) with 
hda2(7999872)
Aug 23 18:27:03 where kernel: raid0:   EQUAL
Aug 23 18:27:03 where kernel: raid0: looking at hde2
Aug 23 18:27:03 where kernel: raid0:   comparing hde2(7999872) with 
hda2(7999872)
Aug 23 18:27:03 where kernel: raid0:   EQUAL
Aug 23 18:27:03 where kernel: raid0: looking at hdc2
Aug 23 18:27:03 where kernel: raid0:   comparing hdc2(7999872) with 
hda2(7999872)
Aug 23 18:27:03 where kernel: raid0:   EQUAL
Aug 23 18:27:03 where kernel: raid0: FINAL 1 zones
Aug 23 18:27:03 where kernel: raid0: done.
Aug 23 18:27:03 where kernel: raid0 : md_size is 31999488 blocks.
Aug 23 18:27:03 where kernel: raid0 : conf->hash_spacing is 31999488 blocks.
Aug 23 18:27:03 where kernel: raid0 : nb_zone is 1.
Aug 23 18:27:03 where kernel: raid0 : Allocating 4 bytes for hash.
Aug 23 18:27:03 where kernel: md: md1 stopped.
Aug 23 18:27:03 where kernel: md: bind<hdc3>
Aug 23 18:27:03 where kernel: md: bind<hde3>
Aug 23 18:27:03 where kernel: md: bind<hdg3>
Aug 23 18:27:03 where kernel: md: bind<hda3>
Aug 23 18:27:03 where kernel: md1: setting max_sectors to 128, segment 
boundary to 32767
Aug 23 18:27:03 where kernel: raid0: looking at hda3
Aug 23 18:27:03 where kernel: raid0:   comparing hda3(7999872) with 
hda3(7999872)
Aug 23 18:27:03 where kernel: raid0:   END
Aug 23 18:27:03 where kernel: raid0:   ==> UNIQUE
Aug 23 18:27:03 where kernel: raid0: 1 zones
Aug 23 18:27:03 where kernel: raid0: looking at hdg3
Aug 23 18:27:03 where kernel: raid0:   comparing hdg3(7999872) with 
hda3(7999872)
Aug 23 18:27:03 where kernel: raid0:   EQUAL
Aug 23 18:27:03 where kernel: raid0: looking at hde3
Aug 23 18:27:03 where kernel: raid0:   comparing hde3(7999872) with 
hda3(7999872)
Aug 23 18:27:03 where kernel: raid0:   EQUAL
Aug 23 18:27:03 where kernel: raid0: looking at hdc3
Aug 23 18:27:03 where kernel: raid0:   comparing hdc3(7999872) with 
hda3(7999872)
Aug 23 18:27:03 where kernel: raid0:   EQUAL
Aug 23 18:27:03 where kernel: raid0: FINAL 1 zones
Aug 23 18:27:03 where kernel: raid0: done.
Aug 23 18:27:03 where kernel: raid0 : md_size is 31999488 blocks.
Aug 23 18:27:03 where kernel: raid0 : conf->hash_spacing is 31999488 blocks.
Aug 23 18:27:03 where kernel: raid0 : nb_zone is 1.
Aug 23 18:27:03 where kernel: raid0 : Allocating 4 bytes for hash.
Aug 23 18:27:03 where kernel: md: md2 stopped.
Aug 23 18:27:03 where kernel: md: bind<hdc4>
Aug 23 18:27:03 where kernel: md: bind<hde4>
Aug 23 18:27:03 where kernel: md: bind<hdg4>
Aug 23 18:27:03 where kernel: md: bind<hda4>
Aug 23 18:27:03 where kernel: md2: setting max_sectors to 128, segment 
boundary to 32767
Aug 23 18:27:03 where kernel: raid0: looking at hda4
Aug 23 18:27:03 where kernel: raid0:   comparing hda4(36051520) with 
hda4(36051520)
Aug 23 18:27:03 where kernel: raid0:   END
Aug 23 18:27:03 where kernel: raid0:   ==> UNIQUE
Aug 23 18:27:03 where kernel: raid0: 1 zones
Aug 23 18:27:03 where kernel: raid0: looking at hdg4
Aug 23 18:27:03 where kernel: raid0:   comparing hdg4(36051520) with 
hda4(36051520)
Aug 23 18:27:03 where kernel: raid0:   EQUAL
Aug 23 18:27:03 where kernel: raid0: looking at hde4
Aug 23 18:27:03 where kernel: raid0:   comparing hde4(36051520) with 
hda4(36051520)
Aug 23 18:27:03 where kernel: raid0:   EQUAL
Aug 23 18:27:03 where kernel: raid0: looking at hdc4
Aug 23 18:27:03 where kernel: raid0:   comparing hdc4(36051520) with 
hda4(36051520)
Aug 23 18:27:03 where kernel: raid0:   EQUAL
Aug 23 18:27:03 where kernel: raid0: FINAL 1 zones
Aug 23 18:27:03 where kernel: raid0: done.
Aug 23 18:27:03 where kernel: raid0 : md_size is 144206080 blocks.
Aug 23 18:27:03 where kernel: raid0 : conf->hash_spacing is 144206080 
blocks.
Aug 23 18:27:03 where kernel: raid0 : nb_zone is 1.
Aug 23 18:27:03 where kernel: raid0 : Allocating 4 bytes for hash.
Aug 23 18:27:03 where kernel: eth0: Setting 100mbps full-duplex based on 
auto-negotiated partner ability 41e1.
Aug 23 18:27:03 where kernel: Call Trace:
Aug 23 18:27:03 where kernel:  [<c010d04b>] __report_bad_irq+0x2b/0x90
Aug 23 18:27:03 where kernel:  [<c010d144>] note_interrupt+0x64/0xa0
Aug 23 18:27:03 where kernel:  [<c010d3fe>] do_IRQ+0x12e/0x140
Aug 23 18:27:03 where kernel:  [<c010b85c>] common_interrupt+0x18/0x20
Aug 23 18:27:03 where kernel:  [<c01fc443>] search_by_key+0x753/0xdb0
Aug 23 18:27:03 where kernel:  [<c02c748e>] usb_hcd_irq+0x2e/0x60
Aug 23 18:27:03 where kernel:  [<c01e7c44>] make_cpu_key+0x54/0x60
Aug 23 18:27:03 where kernel:  [<c01e9fdf>] reiserfs_update_sd+0x7f/0x1c0
Aug 23 18:27:03 where kernel:  [<c0204377>] journal_begin+0x27/0x30
Aug 23 18:27:03 where kernel:  [<c01f3e9c>] reiserfs_dirty_inode+0x5c/0xc0
Aug 23 18:27:03 where kernel:  [<c0172eeb>] __mark_inode_dirty+0xeb/0xf0
Aug 23 18:27:03 where kernel:  [<c016cf41>] update_atime+0xc1/0xd0
Aug 23 18:27:03 where kernel:  [<c0138482>] 
__generic_file_aio_read+0x1d2/0x200
Aug 23 18:27:03 where kernel:  [<c01381b0>] file_read_actor+0x0/0x100
Aug 23 18:27:03 where kernel:  [<c01385b0>] generic_file_read+0x90/0xb0
Aug 23 18:27:03 where kernel:  [<c011a4bb>] pgd_alloc+0x1b/0x20
Aug 23 18:27:03 where kernel:  [<c011dab1>] mm_init+0xa1/0xe0
Aug 23 18:27:03 where kernel:  [<c010cfeb>] handle_IRQ_event+0x3b/0x70
Aug 23 18:27:03 where kernel:  [<c015311a>] vfs_read+0xca/0x140
Aug 23 18:27:03 where kernel:  [<c015dc1a>] kernel_read+0x4a/0x60
Aug 23 18:27:03 where kernel:  [<c015e671>] prepare_binprm+0xc1/0xd0
Aug 23 18:27:03 where kernel:  [<c015ebf3>] do_execve+0x113/0x1f0
Aug 23 18:27:03 where kernel:  [<c010978f>] sys_execve+0x3f/0x80
Aug 23 18:27:03 where kernel:  [<c010aeef>] syscall_call+0x7/0xb
Aug 23 18:27:03 where kernel:
Aug 23 18:27:03 where kernel: Call Trace:
Aug 23 18:27:03 where kernel:  [<c010d04b>] __report_bad_irq+0x2b/0x90
Aug 23 18:27:03 where kernel:  [<c010d144>] note_interrupt+0x64/0xa0
Aug 23 18:27:03 where kernel:  [<c010d3fe>] do_IRQ+0x12e/0x140
Aug 23 18:27:03 where kernel:  [<c010b85c>] common_interrupt+0x18/0x20


