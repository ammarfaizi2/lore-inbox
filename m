Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755276AbWK0ACj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276AbWK0ACj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 19:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755277AbWK0ACj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 19:02:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:39049 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1755276AbWK0ACi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 19:02:38 -0500
X-Authenticated: #5358227
Date: Mon, 27 Nov 2006 01:02:34 +0100
From: Matthias Lederhofer <matled@gmx.net>
To: Milan Broz <mbroz@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: freeze with swap on dm-crypt on smp system (v2.6.18-g23541d2)
Message-ID: <20061127000234.GA2084@moooo.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I found a bug introduced in v2.6.18-g23541d2 (git-bisect).
The computer has a dual core amd64 with 1GB ram and 3GB swap space,
64 bit kernel and 32 bit userland.

What I did:
 - run the mprime 'torture test' with the memory option set to 1500MB
    (ftp://mersenne.org/gimps/mprime235.tar.gz, I ran
     echo -e '15\n\n1500\n1500\n\n\n\n17\n\n6\n' | ./mprime)
 - mount a tmpfs with 2GB and write to it (stops at 1.0-1.1GB)
What happened:
With mprime normal keyboard input was ignored totally.  The machine
still responds to ping/sysrq but killing all processes with sysrq does
not help.  Sometimes with tmpfs I was able to type, but ^C did not
work and I was not able to do anything (e.g. get a new shell, start a
program etc.).

The swap space has to be on a dm-crypt and smp has to be enabled,
without this the bug did not occur.  Just ask if you need any other
information about the system, output from sysrq debug commands or
anything else.

I found that enabling this options from 'Kernel hacking' helps, even
though it once froze when I tried to quit mprime.
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_PREEMPT=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_RWSEMS=y
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_PROVE_LOCKING=y
> CONFIG_LOCKDEP=y
> CONFIG_DEBUG_LOCKDEP=y
> CONFIG_TRACE_IRQFLAGS=y
> CONFIG_STACKTRACE=y
> CONFIG_DEBUG_VM=y
While running mprime with this options I got this warning:
> warning: many lost ticks.
> Your time source seems to be instable or some driver is hogging interupts
> rip xor_128+0x2/0x20

kernel boot output:
Linux version 2.6.18-g23541d2d (matled@foo) (gcc version 4.1.2 20061028 (prerelease) (Debian 4.1.1-19)) #1 SMP PREEMPT Sun Nov 26 21:20:27 CET 2006
Command line: root=/dev/md10 ro panic=20 console=tty0 console=ttyS0,115200
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003eff0000 (usable)
 BIOS-e820: 000000003eff0000 - 000000003eff3000 (ACPI NVS)
 BIOS-e820: 000000003eff3000 - 000000003f000000 (ACPI data)
 BIOS-e820: 000000003f000000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f2000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
end_pfn_map = 1048576
DMI 2.3 present.
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   258032
Intel MultiProcessor Specification v1.4
MPTABLE: OEM ID: OEM00000 MPTABLE: Product ID: PROD00000000 MPTABLE: APIC at: 0xFEE00000
Processor #0 (Bootup-CPU)
Processor #1
I/O APIC #2 at 0xFEC00000.
Setting APIC routing to flat
Processors: 2
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000f0000
Nosave address range: 00000000000f0000 - 0000000000100000
Allocating PCI resources starting at 50000000 (gap: 40000000:b0000000)
PERCPU: Allocating 21952 bytes of per cpu data
Built 1 zonelists.  Total pages: 253687
Kernel command line: root=/dev/md10 ro panic=20 console=tty0 console=ttyS0,115200
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Checking aperture...
CPU 0: aperture @ 6e20000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Memory: 1012796k/1032128k available (1826k kernel code, 18644k reserved, 549k data, 200k init)
Calibrating delay using timer specific routine.. 4024.83 BogoMIPS (lpj=8049661)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
Freeing SMP alternatives: 20k freed
ExtINT not setup in hardware but reported by MP table
Using local APIC timer interrupts.
result 12557378
Detected 12.557 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4018.56 BogoMIPS (lpj=8037126)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 482 cycles)
Brought up 2 CPUs
testing NMI watchdog ... OK.
time.c: Using 1.193182 MHz WALL PIT GTOD PIT/TSC timer.
time.c: Detected 2009.181 MHz processor.
migration_cost=276
NET: Registered protocol family 16
PCI: Using configuration type 1
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Transparent bridge - 0000:00:10.0
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router default [10de/02f0] at 0000:00:00.0
PCI->APIC IRQ transform: 0000:00:05.0[A] -> IRQ 11
PCI->APIC IRQ transform: 0000:00:0a.1[A] -> IRQ 5
PCI->APIC IRQ transform: 0000:00:0b.0[A] -> IRQ 11
PCI->APIC IRQ transform: 0000:00:0b.1[B] -> IRQ 10
PCI->APIC IRQ transform: 0000:00:0e.0[A] -> IRQ 11
PCI->APIC IRQ transform: 0000:00:0f.0[A] -> IRQ 10
PCI->APIC IRQ transform: 0000:00:10.1[B] -> IRQ 10
PCI->APIC IRQ transform: 0000:00:14.0[A] -> IRQ 5
PCI->APIC IRQ transform: 0000:01:0e.0[A] -> IRQ 5
PCI-DMA: Disabling IOMMU.
PCI: Bridge: 0000:00:10.0
  IO window: disabled.
  MEM window: f5000000-f50fffff
  PREFETCH window: disabled.
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.57.
forcedeth: using HIGHDMA
eth0: forcedeth.c: subsystem: 01458:e000 bound to 0000:00:14.0
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 11
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 11
scsi0 : sata_nv
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 625140335 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : sata_nv
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7, max UDMA/133, 625140335 sectors: LBA48 NCQ (depth 0/32)
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
SCSI device sda: 625140335 512-byte hdwr sectors (320072 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 625140335 512-byte hdwr sectors (320072 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 >
sd 0:0:0:0: Attached scsi disk sda
scsi 1:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
SCSI device sdb: 625140335 512-byte hdwr sectors (320072 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
SCSI device sdb: 625140335 512-byte hdwr sectors (320072 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 >
sd 1:0:0:0: Attached scsi disk sdb
ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC400 irq 10
ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 10
scsi2 : sata_nv
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/32)
ata3.00: ata3: dev 0 multi count 16
ata3.00: configured for UDMA/133
scsi3 : sata_nv
ata4: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0x967
scsi 2:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
sdc: Write Protect is off
SCSI device sdc: drive cache: write back
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
sdc: Write Protect is off
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3 sdc4 < sdc5 >
sd 2:0:0:0: Attached scsi disk sdc
serio: i8042 KBD port at 0x60,0x64 irq 1
md: raid1 personality registered for level 1
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
device-mapper: ioctl: 4.9.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
TCP cubic registered
NET: Registered protocol family 1
input: AT Translated Set 2 keyboard as /class/input/input0
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdc3 ...
md:  adding sdc3 ...
md: sdc2 has different UUID to sdc3
md:  adding sdb3 ...
md: sdb2 has different UUID to sdc3
md:  adding sda3 ...
md: sda2 has different UUID to sdc3
md: created md11
md: bind<sda3>
md: bind<sdb3>
md: bind<sdc3>
md: running: <sdc3><sdb3><sda3>
raid1: raid set md11 active with 3 out of 3 mirrors
md: considering sdc2 ...
md:  adding sdc2 ...
md:  adding sdb2 ...
md:  adding sda2 ...
md: created md10
md: bind<sda2>
md: bind<sdb2>
md: bind<sdc2>
md: running: <sdc2><sdb2><sda2>
raid1: raid set md10 active with 3 out of 3 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 200k freed
INIT: version 2.86 booting
