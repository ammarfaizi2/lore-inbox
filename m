Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbTBEQiB>; Wed, 5 Feb 2003 11:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbTBEQiB>; Wed, 5 Feb 2003 11:38:01 -0500
Received: from radium.jvb.tudelft.nl ([130.161.82.13]:2236 "EHLO
	radium.jvb.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261645AbTBEQhx> convert rfc822-to-8bit; Wed, 5 Feb 2003 11:37:53 -0500
From: "Robbert Kouprie" <robbert@radium.jvb.tudelft.nl>
To: "'Stephan von Krawczynski'" <skraw@ithnet.com>,
       "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>,
       <alan@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
Date: Wed, 5 Feb 2003 17:44:27 +0100
Message-ID: <009f01c2cd35$d9015860$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Razor-id: c83d2994223c09760d503d93d035edc3acb934dd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

> > Feb 4 01:02:22 admin kernel: hde: dma_intr: status=0xd0 { Busy } 
> > Feb 4 01:02:22 admin kernel: 
> > Feb 4 01:02:22 admin kernel: PDC202XX: Primary channel reset. 
> > Feb 4 01:02:22 admin kernel: ide2: reset: success 
> > Feb 4 01:02:23 admin kernel: hde: status error: status=0x58 { DriveReady
SeekComplete DataRequest } 
> > Feb 4 01:02:23 admin kernel: 
> > Feb 4 01:02:23 admin kernel: hde: drive not ready for command 
> > Feb 4 01:02:23 admin kernel: hde: status error: status=0x50 { DriveReady
SeekComplete } 
> > Feb 4 01:02:23 admin kernel: 
> > Feb 4 01:02:23 admin kernel: hde: no DRQ after issuing WRITE 
> > Feb 4 01:02:23 admin kernel: hde: status timeout: status=0xd0 { Busy } 
> > Feb 4 01:02:23 admin kernel: 
>
> Hi Alan ! 
>
> I'm trying to get some sense out of the above report as it seem to match 
> a problem a user reported me as well. It's interesting because it's 
> apparently running UP, so it's not the SMP race found by Ross. It's 
> definitely a problem with shared interrupt though. 

Hi all,

I experience a similar problem too on UP (and UP kernel, no preempt, no
taskfile, no acpi). Having replaced almost all hardware involved, I'm 99%
sure it isn't a hardware problem. I reported to Alan & Andre privately at
the time, but unfortunately there was no way to reproduce it, so nothing
came out of it. Also there have been a few threads where it looks like
people report the same problem.

Like:
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0210.3/0416.html (2nd
paragraph)
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0301.1/0547.html
(replacing the cable actually _didn't_ fix it in the end)

System is a PIII-866 on an Asus board, WD1800JB 180Gb on pri master
(UDMA100), WD1200BB 120Gb sec master (UDMA100) on an Promise PDC20269 PCI
card, kernel 2.4.20-rc1-ac4 (yes it's an older one, but testing is hard, as
it sometimes takes a month for the problem to show up again).

In a shared interrupt setup (i.e. 2 disks on each channel of the PDC), the
machine will just crash in unpredictable ways, without leaving traces. With
only the 180Gb drive on the PDC, there's no interrupt sharing, and the
system is able to stay alive when the error happens, it's just the disk that
drops dead in that case. Box has to be powered off (resetting doesn't help)
for the drive to get alive again. The logs say:

Nov  1 08:24:14 Bambi kernel: hde: dma_timer_expiry: dma status == 0x21
Nov  1 08:24:24 Bambi kernel: PDC202XX: Primary channel reset.
Nov  1 08:24:24 Bambi kernel: hde: timeout waiting for DMA
Nov  1 08:24:24 Bambi kernel: hde: (__ide_dma_test_irq) called while not
waiting
Nov  1 08:24:24 Bambi kernel: blk: queue c02d5e58, I/O limit 4095Mb (mask
0xffffffff)
Nov  1 08:24:34 Bambi kernel: hde: irq timeout: status=0xd0 { Busy }
Nov  1 08:24:34 Bambi kernel: 
Nov  1 08:24:34 Bambi kernel: hde: DMA disabled
Nov  1 08:24:34 Bambi kernel: PDC202XX: Primary channel reset.
Nov  1 08:25:04 Bambi kernel: ide2: reset timed-out, status=0xd0
Nov  1 08:25:04 Bambi kernel: hde: status timeout: status=0xd0 { Busy }
Nov  1 08:25:04 Bambi kernel: 
Nov  1 08:25:04 Bambi kernel: PDC202XX: Primary channel reset.
Nov  1 08:25:34 Bambi kernel: ide2: reset timed-out, status=0xd0

A few times I tried to reset the drive with hdparm using "hdparm -w
/dev/hde". This didn't have success and produced the following log messages:

Nov  1 12:02:57 Bambi kernel: hde: DMA disabled
Nov  1 12:02:57 Bambi kernel: PDC202XX: Primary channel reset.
Nov  1 12:02:57 Bambi kernel: hde: ide_timer_expiry: hwgroup->busy was 0 ??
Nov  1 12:03:27 Bambi kernel: ide2: reset timed-out, status=0xd0

Does anyone have any theory of how to reproduce this (maybe with the new
theory of Benjamin)? I would be glad to test new kernels, but some testcase
is required to be able to supply more results (within a reasonable amount of
time that is ;)).

Below all specs in the shared irq setup, 2 drives on the 20269, one on each
channel. (In the non-shared setup, I moved the WD 120Gb to an extra
PDC20262, no interrupts were shared.)

Regards,
- Robbert Kouprie


System specs:
-------------
CUSL2-C BIOS 1009 (also tried 1008)
PIII 866 (also tried a PIII-800)
Promise Ultra133TX2 (PDC20269) BIOS 2.20.0.14 (also tried 2.20.0.12)
1x Maxtor 30GB 7200RPM on ICH2, Primary Master, UDM100
1x Maxtor 80GB 7200RPM on ICH2, Secondary Master, UDMA100 (also tried this
one as Quarternary Slave)
1x WD 180GB 7200RPM on Promise Ultra133, Primary [Tertiary] Master UDMA 100
(RMA'd the first one, second one makes no difference)
1x WD 120GB 7200RPM on Promise Ultra133, secondary [Quarternary] Master
UDMA100
Ultra133 on PCI slot #1
Intel eepro100 on PCI slot #3 (also tried a 3com 3C905B-TX)
S3 Virge on PCI slot #5
1x256MB PC133, 2x128MB PC133 (memtested for a full night, tried in different
combinations, locations)
A-Open 300W PSU (also tried with an Enermax 430W)

NOTE: All the things mentioned as "also tried" didn't make it stop crashing.

cat /proc/interrupts:
---------------------
           CPU0       
  0:      77362          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:      74310          XT-PIC  eth0
 12:     146397          XT-PIC  ide2, ide3
 14:      15335          XT-PIC  ide0
 15:         35          XT-PIC  ide1
NMI:          0 
LOC:      77319 
ERR:          0
MIS:          0

lspci -vvvx:
------------
00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and
Memory Controller Hub (rev 02)
        Subsystem: Asustek Computer, Inc. TUSL2-C Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [88] #09 [f104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
00: 86 80 30 11 06 00 90 20 02 00 00 06 00 00 00 00
10: 08 00 00 f8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 27 80
30: 00 00 00 00 88 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corp. 82815 815 Chipset AGP Bridge (rev 02)

(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: f7b00000-f7bfffff
        Prefetchable memory behind bridge: f7f00000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
00: 86 80 31 11 07 00 20 00 02 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 e0 d0 a0 22
20: b0 f7 b0 f7 f0 f7 f0 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 01)

(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000b000-0000dfff
        Memory behind bridge: f0000000-f7afffff
        Prefetchable memory behind bridge: f7c00000-f7efffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 86 80 4e 24 07 01 80 00 01 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 20 b0 d0 80 22
20: 00 f0 a0 f7 c0 f7 e0 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0e 00

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 01)

        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
00: 86 80 40 24 0f 01 80 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 01) (prog-if 80

[Master])
        Subsystem: Asustek Computer, Inc. TUSL2-C Mainboard
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at a800 [size=16]
00: 86 80 4b 24 05 00 80 02 01 80 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 a8 00 00 00 00 00 00 00 00 00 00 43 10 27 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 01)

        Subsystem: Asustek Computer, Inc. TUSL2-C Mainboard
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at e800 [size=16]
00: 86 80 43 24 01 00 80 02 01 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e8 00 00 00 00 00 00 00 00 00 00 43 10 27 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00

02:09.0 Unknown mass storage controller: Promise Technology, Inc. 20269

(rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc.: Unknown device 4d68
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 4
        Region 0: I/O ports at d800 [size=8]
        Region 1: I/O ports at d400 [size=4]
        Region 2: I/O ports at d000 [size=8]
        Region 3: I/O ports at b800 [size=4]
        Region 4: I/O ports at b400 [size=16]
        Region 5: Memory at f7000000 (32-bit, non-prefetchable)
[size=16K]
        Expansion ROM at <unassigned> [disabled] [size=16K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5a 10 69 4d 07 00 30 04 02 85 80 01 08 20 00 00
10: 01 d8 00 00 01 d4 00 00 01 d0 00 00 01 b8 00 00
20: 01 b4 00 00 00 00 00 f7 00 00 00 00 5a 10 68 4d
30: 00 00 00 00 60 00 00 00 00 00 00 00 04 01 04 12

02:0b.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]

(rev 09)
        Subsystem: Intel Corp. EtherExpress PRO/100 S Management Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at f6800000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: I/O ports at b000 [size=64]
        Region 2: Memory at f6000000 (32-bit, non-prefetchable)
[size=128K]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 86 80 29 12 17 00 90 02 09 00 00 02 08 20 00 00
10: 00 00 80 f6 01 b0 00 00 00 00 00 f6 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 11 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 03 01 08 38

02:0e.0 VGA compatible controller: S3 Inc. 86c325 [ViRGE] (rev 06)

(prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f0000000 (32-bit, non-prefetchable)
[size=64M]
        Expansion ROM at f7cf0000 [disabled] [size=64K]
00: 33 53 31 56 07 00 00 02 06 00 00 03 00 20 00 00
10: 00 00 00 f0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 cf f7 00 00 00 00 00 00 00 00 0a 01 04 ff

------
Linux version 2.4.20-pre10-ac2 (root@Bambi) (gcc version 2.95.4 20011002
(Debian prerelease)) #1 Tue Oct 29 16:04:06 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017feb000 (usable)
 BIOS-e820: 0000000017feb000 - 0000000017fef000 (ACPI data)
 BIOS-e820: 0000000017fef000 - 0000000017fff000 (reserved)
 BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
383MB LOWMEM available.
On node 0 totalpages: 98283
zone(0): 4096 pages.
zone(1): 94187 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=301 ide2=ata66 ide3=ata66
ide_setup: ide2=ata66
ide_setup: ide3=ata66
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 871.032 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1736.70 BogoMIPS
Memory: 383624k/393132k available (1109k kernel code, 6940k reserved, 336k
data, 248k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=48225 max_file_pages=0 max_inodes=0 max_dentries=48225
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 871.0616 MHz.
..... host bus clock speed is 134.0092 MHz.
cpu: 0, clocks: 1340092, slice: 670046
CPU0<T0:1340080,T1:670032,D:2,S:670046,C:1340092>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0df0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [8086/1130] 000600 00
Found 00:08 [8086/1131] 000604 01
Found 00:f0 [8086/244e] 000604 01
Found 00:f8 [8086/2440] 000601 00
Found 00:f9 [8086/244b] 000101 00
Found 00:fb [8086/2443] 000c05 00
Fixups for bus 00
Scanning behind PCI bridge 00:01.0, config 010100, pass 0
Scanning bus 01
Fixups for bus 01
Bus scan for 01 returning with max=01
Scanning behind PCI bridge 00:1e.0, config 020200, pass 0
Scanning bus 02
Found 02:48 [105a/4d69] 000180 00
Found 02:58 [8086/1229] 000200 00
Found 02:68 [5333/5631] 000300 00
Fixups for bus 02
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
Bus scan for 02 returning with max=02
Scanning behind PCI bridge 00:01.0, config 010100, pass 1
Scanning behind PCI bridge 00:1e.0, config 020200, pass 1
Bus scan for 00 returning with max=02
PCI: Bus 01 already known
PCI: Bus 02 already known
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
Journalled Block Device driver loaded
NTFS driver v1.1.22 [Flags: R/O]
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
i810 TCO timer, v0.05: timer margin: 30 sec (0xe460) (nowayout=0)
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Intel(R) PRO/100 Network Driver - version 2.1.15-k1
Copyright (c) 2002 Intel Corporation

PCI: Found IRQ 4 for device 02:0b.0
e100: eth0: Intel(R) PRO/100 S Management Adapter
  Mem:0xf6800000  IRQ:4  Speed:0 Mbps  Dx:N/A
  Failed to detect cable link
  Speed and duplex will be determined at time of connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 1
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:DMA, hdd:pio
PDC20269: IDE controller at PCI slot 02:09.0
PCI: Found IRQ 12 for device 02:09.0
PCI: Sharing IRQ 12 with 02:0d.0
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xb400-0xb407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xb408-0xb40f, BIOS settings: hdg:pio, hdh:pio
hda: Maxtor 6E030L0, ATA DISK drive
blk: queue c02d5580, I/O limit 4095Mb (mask 0xffffffff)
hdc: Maxtor 4D080H4, ATA DISK drive
blk: queue c02d59ec, I/O limit 4095Mb (mask 0xffffffff)
hde: WDC WD1800JB-00DUA0, ATA DISK drive
blk: queue c02d5e58, I/O limit 4095Mb (mask 0xffffffff)
hdg: WDC WD1200BB-00CAA0, ATA DISK drive
blk: queue c02d62c4, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xd800-0xd807,0xd402 on irq 12
ide3 at 0xd000-0xd007,0xb802 on irq 12
hda: host protected area => 1
hda: 60058656 sectors (30750 MB) w/2048KiB Cache, CHS=3738/255/63, UDMA(100)
hdc: host protected area => 1
hdc: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63,
UDMA(100)
hde: host protected area => 1
hde: 351651888 sectors (180046 MB) w/8192KiB Cache, CHS=21889/255/63,
UDMA(100)
hdg: host protected area => 1
hdg: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
 hdc: hdc1
 hde: hde1
 hdg: hdg1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 248k freed
Adding Swap: 1461872k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide1(22,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide3(34,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
e100: eth0 NIC Link is Up 100 Mbps Full duplex

