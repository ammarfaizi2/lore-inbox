Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276988AbRJKWGJ>; Thu, 11 Oct 2001 18:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276990AbRJKWGG>; Thu, 11 Oct 2001 18:06:06 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:12304 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S276987AbRJKWFq>; Thu, 11 Oct 2001 18:05:46 -0400
Message-ID: <000b01c152a1$0d94c370$6401000a@it0>
From: "Tommy Faasen" <faasen@xs4all.nl>
To: "Manfred Spraul" <manfred@colorfullife.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <3BC5F092.6492A8B3@colorfullife.com>
Subject: Re: SMP debugging
Date: Fri, 12 Oct 2001 00:07:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The way I look at the output is that the kernel only looks
> > what the specs ofthe first cpu are and asumes that the second
> > is the same.
>
> Correct, that part of the Intel MP specification: if 2 different cpus
> are
> used, then the capabilities of the second cpu must be a subset of the
> capabilities of the first cpu. (IIRC)
>
Sounds reasonable so why did it work on 2.4.0 and 2.2.x?
I'll try all the 2.4.1 pre patches as well, someone was kind enough to point
me to them.

> Probably you must edit smpboot.c or init.c and clear the capabilities of
> cpu0 that cpu1 doesn't have.
>
> > Invalid operand: 0000
> > CPU:    0
> > EIP:    0010:[<c010c784>]    Not tainted
> > EFLAGS: 00010206
>
> Could you run the oops through ksymoops?
>
I can't get ksymoops to compile (version 2.4.0) but I only tried twice..
merge.o undefined reference to 'htab_create'
etc

> > processor 0:
> > flags  : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat
> > pse36 mmx fxsr
> > processor 1:
> > flags  : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
mmx
>
> Ok, cpu0 support fxsr, cpu1 doesn't.
> fxsr is used for the thread switching.
> It seems that this causes an oops during the first thread switch.
>
> Could you try what happens if you replace
> linux/include/asm-i386/processor.h:
> - #define cpu_has_fxsr        (test_bit(X86_FEATURE_FXSR,
> boot_cpu_data.x86_capability))
> + #define cpu_has_fxsr (0)
>
After compiling a got a bunch of undefined/unreferenced cpu_has_fxsr(0)
calls some *.o file.
I tried to replace
#define X86_CR4_OSFXSR 0x0200
with
#define X86_CR4_OSFXSR 0x0000
but that produced

 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fffd000 (usable)
 BIOS-e820: 000000000fffd000 - 000000000ffff000 (ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
found SMP MP-table at 000f6e30
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 65533
zone(0): 4096 pages.
zone(1): 61437 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: BOOT_IMAGE=dual-2.4.1 ro root=803 ether=11,0x300,eth1
conso
le=ttyS0,9600 console=tty0
Initializing CPU#0
Detected 233.867 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 465.30 BogoMIPS
Memory: 254816k/262132k available (1477k kernel code, 6928k reserved, 430k
data,
 216k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU0: Intel Pentium II (Klamath) stepping 04
per-CPU timeslice cutoff: 1465.81 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 466.94 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium II (Deschutes) stepping 01
Total of 2 processors activated (932.24 BogoMIPS).
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 233.8522 MHz.
..... host bus clock speed is 66.8145 MHz.
cpu: 0, clocks: 668145, slice: 222715
CPU0<T0:668144,T1:445424,D:5,S:222715,C:668145>
cpu: 1, clocks: 668145, slice: 222715
CPU1<T0:668144,T1:222704,D:10,S:222715,C:668145>
checking TSC synchronization across CPUs: passed.
PCI: PCI BIOS revision 2.10 entry at 0xf0730, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Simple Boot Flag extension found and enabled.
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI en
abled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: queued sectors max/low 169216kB/56405kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:DMA
hda: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
hdb: CRD-8322B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdb: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.97.sv
hda: No disk in drive
hda: 98304kB, 32/64/96 CHS, 4096 kBps, 512 sector size, 2941 rpm
floppy0: no floppy controllers found
eth0: 3c5x9 at 0x300, 10baseT port, address  00 20 af f2 51 7a, IRQ 11.
3c509.c:1.18 12Mar2001 becker@scyld.com
http://www.scyld.com/network/3c509.html
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0b.0: 3Com PCI 3c905C Tornado at 0xb000. Vers LK1.1.16
PCI: Setting latency timer of device 00:0b.0 to 64
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel 440LX chipset
agpgart: AGP aperture is 64M @ 0xe4000000
ide-floppy driver 0.97.sv
SCSI subsystem driver Revision: 1.00
PCI: Setting latency timer of device 00:06.0 to 64
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: IBM       Model: DNES-309170Y      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: DNES-309170W      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: MATSHITA  Model: CD-R   CW-7501    Rev: 2.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: IBM       Model: DNES-309170W      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:0:0:0: Tagged Queuing enabled.  Depth 253
scsi0:0:1:0: Tagged Queuing enabled.  Depth 253
scsi0:0:6:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 6, lun 0
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
Partition check:
 sda: sda1 sda2 sda3
(scsi0:A:1): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
SCSI device sdb: 17916240 512-byte hdwr sectors (9173 MB)
 sdb: sdb1
(scsi0:A:6): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
SCSI device sdc: 17916240 512-byte hdwr sectors (9173 MB)
 sdc: sdc1
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
sr0: scsi-1 drive
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 216k freed
reiserfs: checking transaction log (device 08:21) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
invalid operand: 0000
CPU:    0
EIP:    0010:[<c010c784>]    Not tainted
EFLAGS: 00010206
eax: 0183fbff   ebx: c02de350   ecx: cfe52da0   edx: cfc32000
esi: cfc32000   edi: 00000000   ebp: c02de000   esp: c02dff5c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02df000)
Stack: c0105862 cfc32000 cfc32000 00000000 cfc32000 cfc33e00 c0316800
cfc32350
       c0113253 c02dffc4 c02de000 cfe52da0 c01051b0 c02de000 c01051b0
c02de000
       c02c2940 cfc32000 00000000 0008e000 c15c4dc0 c15c4dc0 00000001
0000001b
Call Trace: [<c0105862>] [<c0113253>] [<c01051b0>] [<c01051b0>] [<c010524e>]
   [<c0105000>] [<c0105047>]

Code: 0f ae 82 90 03 00 00 db e2 eb 08 90 dd b2 90 03 00 00 9b 0f
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing

btw this is the output of 2.4.0 in case it helps
 Linux version 2.4.0 (root@minion) (gcc version 2.95.3 20010315 (release))
#5 SM
P Sun Oct 7 18:12:27 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 000000000fefd000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000002000 @ 000000000fffd000 (ACPI data)
 BIOS-e820: 0000000000001000 @ 000000000ffff000 (ACPI NVS)
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f6e30
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 65533
zone(0): 4096 pages.
zone(1): 61437 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    MMX  present.
    Bootup CPU
Processor #0 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
Bus #0 is PCI
Bus #1 is PCI
Bus #2 is ISA
I/O APIC #2 Version 17 at 0xFEC00000.
Int: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 00
Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 2, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 2, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 2, IRQ 0b, APIC ID 2, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 3, trig 3, bus 2, IRQ 0a, APIC ID 2, APIC INT 10
Int: type 0, pol 3, trig 3, bus 2, IRQ 0f, APIC ID 2, APIC INT 11
Int: type 0, pol 3, trig 3, bus 2, IRQ 07, APIC ID 2, APIC INT 12
Int: type 0, pol 3, trig 3, bus 2, IRQ 05, APIC ID 2, APIC INT 13
Lint: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: BOOT_IMAGE=dual ro root=803 ether=11,0x300,eth1
console=tty
S0,9600 console=tty0
Initializing CPU#0
Detected 233.866 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 466.94 BogoMIPS
Memory: 255044k/262132k available (1295k kernel code, 6700k reserved, 502k
data,
 212k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0080fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0080fbff 00000000 00000000 00000000
CPU: After generic, caps: 0080fbff 00000000 00000000 00000000
CPU: Common caps: 0080fbff 00000000 00000000 00000000
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0080fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0080fbff 00000000 00000000 00000000
CPU: After generic, caps: 0080fbff 00000000 00000000 00000000
CPU: Common caps: 0080fbff 00000000 00000000 00000000
CPU0: Intel Pentium II (Klamath) stepping 04
per-CPU timeslice cutoff: 1465.81 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 1000000
Getting ID: e000000
Getting LVT0: 8700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
CPU present map: 3
Booting processor 1/0 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#1
Startup point 1.
CPU#1 (phys ID: 0) waiting for CALLOUT
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 466.94 BogoMIPS
Stack at about cfff5fbc
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
OK.
CPU1: Intel Pentium II (Deschutes) stepping 01
CPU has booted.
Before bogomips.
Total of 2 processors activated (933.88 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
testing the IO APIC.......................

.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 233.8784 MHz.
..... host bus clock speed is 66.8220 MHz.
cpu: 0, clocks: 668220, slice: 222740
CPU0<T0:668208,T1:445456,D:12,S:222740,C:668220>
cpu: 1, clocks: 668220, slice: 222740
CPU1<T0:668208,T1:222720,D:8,S:222740,C:668220>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xf0730, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.0 present.
33 structures occupying 1082 bytes.
DMI table at 0x000F5A3A.
BIOS Vendor: Award Software, Inc.
BIOS Version: ASUS P2L97-DS ACPI BIOS Revision 1008
BIOS Release: 02/02/99
System Vendor: System Manufacturer.
Product Name: System Name.
Version System Version.
Serial Number SYS-1234567890.
Board Vendor: ASUSTeK Computer INC..
Board Name: P2L97-DS.
Board Version: REV 1.xx.
Asset Tag: Asset-1234567890.
IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
request_module[parport_lowlevel]: Root fs not mounted
lp: driver loaded but no devices found
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:DMA
hda: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
hdb: CRD-8322B, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdb: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hda: 98304kB, 32/64/96 CHS, 4096 kBps, 512 sector size, 2941 rpm
floppy0: no floppy controllers found
eth0: 3c509 at 0x300, 10baseT port, address  00 20 af f2 51 7a, IRQ 11.
3c509.c:1.16 (2.2) 2/3/98 becker@cesdis.gsfc.nasa.gov.
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI
ISA
PNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
3c59x.c:LK1.1.11 13 Nov 2000  Donald Becker and others.
http://www.scyld.com/net
work/vortex.html $Revision: 1.102.2.46 $
See Documentation/networking/vortex.txt
eth1: 3Com PCI 3c905C Tornado at 0xb000, PCI: Setting latency timer of
device 00
:0b.0 to 64
 00:50:da:c6:f2:4c, IRQ 15
  8K byte-wide RAM 5:3 Rx:Tx split, 100baseTX interface.
  Enabling bus-master transmits and whole-frame receives.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel 440LX chipset
agpgart: AGP aperture is 64M @ 0xe4000000
SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AIC-7880 Ultra SCSI host adapter> found at PCI 0/6/0
(scsi0) Wide Channel, SCSI ID=7, 16/255 SCBs
(scsi0) Downloading sequencer code... 422 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7880 Ultra SCSI host adapter>
(scsi0:0:0:0) Synchronous at 40.0 Mbyte/sec, offset 8.
  Vendor: IBM       Model: DNES-309170Y      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:0:1:0) Synchronous at 40.0 Mbyte/sec, offset 8.
  Vendor: IBM       Model: DNES-309170W      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: MATSHITA  Model: CD-R   CW-7501    Rev: 2.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:0:6:0) Synchronous at 40.0 Mbyte/sec, offset 8.
  Vendor: IBM       Model: DNES-309170W      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
Detected scsi disk sdc at scsi0, channel 0, id 6, lun 0
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
Partition check:
 sda: sda1 sda2 sda3
SCSI device sdb: 17916240 512-byte hdwr sectors (9173 MB)
 sdb: sdb1
SCSI device sdc: 17916240 512-byte hdwr sectors (9173 MB)
 sdc: sdc1
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 212k freed
eth0: Setting Rx mode to 1 addresses.
eth1: using default media 100baseTX

> If that doesn't work, then check where X86_FEATURE_FXSR is used.
>
will do, please note that never programmed kernel/system stuff.
Btw i don't have a lot of time tomorrow but I hope to get on this in the
weekend.
> --
> Manfred
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

