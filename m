Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315471AbSFJPwa>; Mon, 10 Jun 2002 11:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315476AbSFJPw3>; Mon, 10 Jun 2002 11:52:29 -0400
Received: from naxos.pdb.sbs.de ([192.109.3.5]:47795 "EHLO naxos.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S315471AbSFJPwX>;
	Mon, 10 Jun 2002 11:52:23 -0400
Subject: Serverworks OSB4 in impossible state
From: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
To: osb4-bug@ide.cabal.tm
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
Content-Type: multipart/mixed; boundary="=-0SHAgZ/hGTn9GLwEsvyv"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 10 Jun 2002 17:52:58 +0200
Message-Id: <1023724379.23630.309.camel@biker.pdb.fsc.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0SHAgZ/hGTn9GLwEsvyv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Hello,

I know a similar problem was discussed here a short while ago.
However we have here a situation where we can reproduce the problem 
reliably. This is a RedHat 2.4.18-4 kernel.

We have a CD with a corrupt last block. If we try to read this block in
PIO mode (hdparm -d 0 /dev/hdc) , we get errors like in the first
attachment.

The machine has only a CDROM (Mitsumi FX 4830T) attached to the IDE bus
as /dev/hdc. We used no IDE-related boot parameters.

If we read the block in DMA mode (with dd), the machine stalls with the
"impossible state" message.

A PCI bus scan reveals that the IO register (dma_base+2) contains indeed
0xa5 (bit 0 set), which leads to the panic. Normally the read on that
register returns 0xa0.

We see in our PCI bus scan that a successful DMA of 4096 bytes was
carried out ~23ms before the stall condition. Another 4096 byte request
was scheduled but never seen. Between the successful DMA and the stall
condition we see nothing but a few timer interrupts.
Then an IDE interrupt occurs, which leads immediately to the panic.

The CD-ROM drive certainly reports some sort of error like in the PIO
case when tyring to access the last block. This seems to be the
(indirect) reason why the Bus master bit in (dma_base+2) remains set
long after the DMA is finished. 

Any ideas/comments?

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





--=-0SHAgZ/hGTn9GLwEsvyv
Content-Description: Kernel error messages in PIO-mode
Content-Disposition: attachment; filename=hdc-msgs
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-15

Jun 10 13:12:40 pdb0384c kernel: hdc: command error: status=3D0x51 { DriveR=
eady SeekComplete Error }
Jun 10 13:12:40 pdb0384c kernel: hdc: command error: error=3D0x50
Jun 10 13:12:40 pdb0384c kernel: hdc: command error: status=3D0x51 { DriveR=
eady SeekComplete Error }
Jun 10 13:12:40 pdb0384c kernel: hdc: command error: error=3D0x50
Jun 10 13:12:40 pdb0384c kernel: end_request: I/O error, dev 16:00 (hdc), s=
ector 1307712
Jun 10 13:12:49 pdb0384c kernel: hdc: cdrom_decode_status: status=3D0x51 { =
DriveReady SeekComplete Error }
Jun 10 13:12:49 pdb0384c kernel: hdc: cdrom_decode_status: error=3D0x30
Jun 10 13:12:56 pdb0384c kernel: hdc: cdrom_decode_status: status=3D0x51 { =
DriveReady SeekComplete Error }
Jun 10 13:12:56 pdb0384c kernel: hdc: cdrom_decode_status: error=3D0x30
Jun 10 13:13:06 pdb0384c kernel: hdc: cdrom_decode_status: status=3D0x51 { =
DriveReady SeekComplete Error }
Jun 10 13:13:06 pdb0384c kernel: hdc: cdrom_decode_status: error=3D0x30
Jun 10 13:13:09 pdb0384c kernel: hdc: cdrom_decode_status: status=3D0x51 { =
DriveReady SeekComplete Error }
Jun 10 13:13:09 pdb0384c kernel: hdc: cdrom_decode_status: error=3D0x30
Jun 10 13:13:09 pdb0384c kernel: hdc: ATAPI reset complete
Jun 10 13:13:13 pdb0384c kernel: hdc: cdrom_decode_status: status=3D0x51 { =
DriveReady SeekComplete Error }
Jun 10 13:13:13 pdb0384c kernel: hdc: cdrom_decode_status: error=3D0x30
Jun 10 13:13:17 pdb0384c kernel: hdc: cdrom_decode_status: status=3D0x51 { =
DriveReady SeekComplete Error }
Jun 10 13:13:17 pdb0384c kernel: hdc: cdrom_decode_status: error=3D0x30
Jun 10 13:13:21 pdb0384c kernel: hdc: cdrom_decode_status: status=3D0x51 { =
DriveReady SeekComplete Error }
Jun 10 13:13:21 pdb0384c kernel: hdc: cdrom_decode_status: error=3D0x30
Jun 10 13:13:21 pdb0384c kernel: hdc: ATAPI reset complete
Jun 10 13:13:21 pdb0384c kernel: end_request: I/O error, dev 16:00 (hdc), s=
ector 1307716
Jun 10 13:13:21 pdb0384c kernel: hdc: command error: status=3D0x51 { DriveR=
eady SeekComplete Error }
Jun 10 13:13:21 pdb0384c kernel: hdc: command error: error=3D0x50
Jun 10 13:13:21 pdb0384c kernel: end_request: I/O error, dev 16:00 (hdc), s=
ector 1307712
Jun 10 13:13:25 pdb0384c kernel: hdc: cdrom_decode_status: status=3D0x51 { =
DriveReady SeekComplete Error }
Jun 10 13:13:25 pdb0384c kernel: hdc: cdrom_decode_status: error=3D0x30
Jun 10 13:13:29 pdb0384c kernel: hdc: cdrom_decode_status: status=3D0x51 { =
DriveReady SeekComplete Error }
Jun 10 13:13:29 pdb0384c kernel: hdc: cdrom_decode_status: error=3D0x30
Jun 10 13:13:33 pdb0384c kernel: hdc: cdrom_decode_status: status=3D0x51 { =
DriveReady SeekComplete Error }
Jun 10 13:13:33 pdb0384c kernel: hdc: cdrom_decode_status: error=3D0x30
Jun 10 13:13:36 pdb0384c kernel: hdc: cdrom_decode_status: status=3D0x51 { =
DriveReady SeekComplete Error }
Jun 10 13:13:36 pdb0384c kernel: hdc: cdrom_decode_status: error=3D0x30
Jun 10 13:13:36 pdb0384c kernel: hdc: ATAPI reset complete
Jun 10 13:13:41 pdb0384c kernel: hdc: cdrom_decode_status: status=3D0x51 { =
DriveReady SeekComplete Error }
Jun 10 13:13:41 pdb0384c kernel: hdc: cdrom_decode_status: error=3D0x30
Jun 10 13:13:44 pdb0384c kernel: hdc: cdrom_decode_status: status=3D0x51 { =
DriveReady SeekComplete Error }
Jun 10 13:13:44 pdb0384c kernel: hdc: cdrom_decode_status: error=3D0x30
Jun 10 13:13:48 pdb0384c kernel: hdc: cdrom_decode_status: status=3D0x51 { =
DriveReady SeekComplete Error }
Jun 10 13:13:48 pdb0384c kernel: hdc: cdrom_decode_status: error=3D0x30
Jun 10 13:13:48 pdb0384c kernel: hdc: ATAPI reset complete
Jun 10 13:13:48 pdb0384c kernel: end_request: I/O error, dev 16:00 (hdc), s=
ector 1307716

--=-0SHAgZ/hGTn9GLwEsvyv
Content-Disposition: attachment; filename=dmesg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=dmesg; charset=ISO-8859-15

ACPI table found: RSDT v1 [PTLTD    RSDT   1540.1]
__va_range(0xbfefc0f9, 0x24): idx=3D8 mapped at ffff6000
__va_range(0xbfefc0f9, 0x74): idx=3D8 mapped at ffff6000
ACPI table found: FACP v1 [FSC    D1309    1540.1]
__va_range(0xbfefeef8, 0x24): idx=3D8 mapped at ffff6000
__va_range(0xbfefeef8, 0x50): idx=3D8 mapped at ffff6000
ACPI table found: SPCR v1 [PTLTD  $UCRTBL$ 1540.1]
__va_range(0xbfefef48, 0x24): idx=3D8 mapped at ffff6000
__va_range(0xbfefef48, 0x90): idx=3D8 mapped at ffff6000
ACPI table found: APIC v1 [PTLTD  	 APIC   1540.1]
__va_range(0xbfefef48, 0x90): idx=3D8 mapped at ffff6000
LAPIC (acpi_id[0x0000] id[0x6] enabled[1])
CPU 0 (0x0600) enabledProcessor #6 Unknown CPU [15:2] APIC version 16

LAPIC (acpi_id[0x0001] id[0x0] enabled[1])
CPU 1 (0x0000) enabledProcessor #0 Unknown CPU [15:2] APIC version 16

LAPIC (acpi_id[0x0002] id[0x1] enabled[1])
CPU 2 (0x0100) enabledProcessor #1 Unknown CPU [15:2] APIC version 16

LAPIC (acpi_id[0x0003] id[0x7] enabled[1])
CPU 3 (0x0700) enabledProcessor #7 Unknown CPU [15:2] APIC version 16

IOAPIC (id[0x2] address[0xfec00000] global_irq_base[0x0])
IOAPIC (id[0x3] address[0xfec10000] global_irq_base[0x10])
INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x1] trigger[0x1])
INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
LAPIC_NMI (acpi_id[0x0000] polarity[0x1] trigger[0x1] lint[0x1])
LAPIC_NMI (acpi_id[0x0001] polarity[0x1] trigger[0x1] lint[0x1])
LAPIC_NMI (acpi_id[0x0002] polarity[0x1] trigger[0x1] lint[0x1])
LAPIC_NMI (acpi_id[0x0003] polarity[0x1] trigger[0x1] lint[0x1])
4 CPUs total
Local APIC address fee00000
__va_range(0xbfefefd8, 0x24): idx=3D8 mapped at ffff6000
__va_range(0xbfefefd8, 0x28): idx=3D8 mapped at ffff6000
ACPI table found: BOOT v1 [PTLTD  $SBFTBL$ 1540.1]
Enabling the CPU's according to the ACPI table
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: FSCD1309 Product ID: PRIMERGY     APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
I/O APIC #3 Version 17 at 0xFEC10000.
Processors: 4
Kernel command line: ro root=3D/dev/sda2
Initializing CPU#0
Detected 2395.457 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4771.02 BogoMIPS
Memory: 3098776k/3145728k available (1232k kernel code, 46496k reserved, 84=
2k data, 304k init, 2228160k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer cache hash table entries: 262144 (order: 8, 1048576 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU0: Intel(R) XEON(TM) CPU 2.40GHz stepping 04
per-CPU timeslice cutoff: 1462.93 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4784.12 BogoMIPS
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU1: Intel(R) XEON(TM) CPU 2.40GHz stepping 04
Booting processor 2/1 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4784.12 BogoMIPS
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#2.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU2: Intel(R) XEON(TM) CPU 2.40GHz stepping 04
Booting processor 3/7 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4784.12 BogoMIPS
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#3.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU3: Intel(R) XEON(TM) CPU 2.40GHz stepping 04
Total of 4 processors activated (19123.40 BogoMIPS).
cpu_sibling_map[0] =3D 3
cpu_sibling_map[1] =3D 2
cpu_sibling_map[2] =3D 1
cpu_sibling_map[3] =3D 0
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
Setting 3 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 3 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-10, 2-11, 3-0, 3-1, 3-2, 3-3, 3-4, 3-5, 3-6, 3=
-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-15 not connected.
..TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 16.
number of IO-APIC #3 registers: 16.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    1    1    39
 02 00F 0F  0    0    0   0   0    1    1    31
 03 00F 0F  0    0    0   0   0    1    1    41
 04 00F 0F  0    0    0   0   0    1    1    49
 05 00F 0F  0    0    0   0   0    1    1    51
 06 00F 0F  0    0    0   0   0    1    1    59
 07 00F 0F  0    0    0   0   0    1    1    61
 08 00F 0F  0    0    0   0   0    1    1    69
 09 00F 0F  1    1    0   1   0    1    1    71
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 00F 0F  0    0    0   0   0    1    1    79
 0d 00F 0F  0    0    0   0   0    1    1    81
 0e 00F 0F  0    0    0   0   0    1    1    89
 0f 00F 0F  0    0    0   0   0    1    1    91

IO APIC #3......
.... register #00: 03000000
.......    : physical APIC id: 03
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 03000000
.......     : arbitration: 03
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 00F 0F  1    1    0   1   0    1    1    99
 0e 00F 0F  1    1    0   1   0    1    1    A1
 0f 000 00  1    0    0   0   0    0    0    00
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
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ29 -> 1:13
IRQ30 -> 1:14
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2395.2498 MHz.
..... host bus clock speed is 99.8019 MHz.
cpu: 0, clocks: 998019, slice: 199603
CPU0<T0:998016,T1:798400,D:13,S:199603,C:998019>
cpu: 2, clocks: 998019, slice: 199603
cpu: 3, clocks: 998019, slice: 199603
cpu: 1, clocks: 998019, slice: 199603
CPU1<T0:998016,T1:598800,D:10,S:199603,C:998019>
CPU2<T0:998016,T1:399200,D:7,S:199603,C:998019>
CPU3<T0:998016,T1:199600,D:4,S:199603,C:998019>
checking TSC synchronization across CPUs: passed.
PCI: PCI BIOS revision 2.10 entry at 0xfd9aa, last bus=3D2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Discovered primary peer bus 02 [IRQ]
PCI->APIC IRQ transform: (B0,I5,P0) -> 30
PCI->APIC IRQ transform: (B0,I15,P0) -> 9
PCI->APIC IRQ transform: (B2,I10,P0) -> 29
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
allocated 64 pages and 64 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.5.0 initialized
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IR=
Q SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Real Time Clock Driver v1.10e
block: 1024 slots per queue, batch=3D256
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
SvrWks CSB5: IDE controller on PCI bus 00 dev 79
SvrWks CSB5: chipset revision 147
SvrWks CSB5: not 100% native mode: will probe irqs later
SvrWks CSB5: simplex device: DMA forced
    ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:pio, hdb:pio
SvrWks CSB5: simplex device: DMA forced
    ide1: BM-DMA at 0x1808-0x180f, BIOS settings: hdc:pio, hdd:pio
hdc: FX4830T, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ide-floppy driver 0.99.newide
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
pci_hotplug: PCI Hot Plug PCI Core version: 0.4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 32768 buckets, 256Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 220k freed
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno =3D 2
sym53c8xx: at PCI bus 2, device 10, function 0
sym53c8xx: 53c1010-66 detected with Symbios NVRAM
sym53c1010-66-0: rev 0x1 on pci bus 2 device 10 function 0 irq 29
sym53c1010-66-0: Symbios format NVRAM, ID 7, Fast-80, Parity Checking
sym53c1010-66-0: on-chip RAM at 0xfe000000
sym53c1010-66-0: restart (scsi reset).
sym53c1010-66-0: handling phase mismatch from SCRIPTS.
sym53c1010-66-0: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx-1.7.3c-20010512
blk: queue f7fd6e18, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: SEAGATE   Model: ST318451LC        Rev: 7500
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7fd6c18, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: SEAGATE   Model: ST318451LC        Rev: 7500
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7fd6a18, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: SDR       Model: GEM318            Rev: 0  =20
  Type:   Processor                          ANSI SCSI revision: 02
blk: queue f7308e18, I/O limit 4095Mb (mask 0xffffffff)
sym53c1010-66-0-<0,0>: tagged command queue depth set to 8
sym53c1010-66-0-<1,0>: tagged command queue depth set to 8
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
sym53c1010-66-0-<0,*>: FAST-80 WIDE SCSI 160.0 MB/s (12.5 ns, offset 62)
SCSI device sda: 35843671 512-byte hdwr sectors (18352 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
sym53c1010-66-0-<1,*>: FAST-80 WIDE SCSI 160.0 MB/s (12.5 ns, offset 62)
SCSI device sdb: 35843671 512-byte hdwr sectors (18352 MB)
 sdb:
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 304k freed
Adding Swap: 1702848k swap-space (priority -1)
Adding Swap: 1694816k swap-space (priority -2)
Adding Swap: 1702848k swap-space (priority -3)
Adding Swap: 1702848k swap-space (priority -4)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xf8bc5000, IRQ 9
usb-ohci.c: usb-00:0f.2, ServerWorks OSB4/CSB5 OHCI USB Controller
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 4 ports detected
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,2), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepr=
o100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <s=
aw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:30:05:29:74:92, IRQ 30.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
hdc: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdc: DMA disabled

--=-0SHAgZ/hGTn9GLwEsvyv
Content-Description: /proc/ide/ide1/hdc/settings
Content-Disposition: attachment; filename=settings
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-15

name			value		min		max		mode
----			-----		---		---		----
breada_readahead        4               0               127             rw
current_speed           66              0               69              rw
dsc_overlap             0               0               1               rw
file_readahead          0               0               2097151         rw
ide_scsi                0               0               1               rw
init_speed              66              0               69              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
max_kb_per_request      64              1               127             rw
nice1                   1               0               1               rw
number                  2               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw

--=-0SHAgZ/hGTn9GLwEsvyv
Content-Description: /proc/ide/svwks
Content-Disposition: attachment; filename=svwks
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-15


                             ServerWorks OSB4/CSB5/CSB6

                            ServerWorks CSB5 Chipset (rev 93)
------------------------------- General Status ----------------------------=
-----
--------------- Primary Channel ---------------- Secondary Channel --------=
-----
                disabled                         disabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 -=
-----
DMA enabled:    no               no              yes               no=20
UDMA enabled:   no               no              yes               no=20
UDMA enabled:   0                0               2                 0
DMA enabled:    2                2               2                 2
PIO  enabled:   ?                ?               4                 ?


--=-0SHAgZ/hGTn9GLwEsvyv--

