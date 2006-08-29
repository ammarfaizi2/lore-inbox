Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965357AbWH2U6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965357AbWH2U6h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 16:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965358AbWH2U6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 16:58:36 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:62623 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965356AbWH2U6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 16:58:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer;
        b=pb+eb96Q+Jr+JB3BHI1m2MGTJCL4UKrHvEQOdmhwGC0dIm/atQn+YnAkrhiBCRGTuB/LaxOfz22py+zaFEzs/mxKarJNOI99psLhTsHr51ioAhO4gLOLd/0opq8mgk+RbdypEuAkT1W1reLDTBjP80VUEcJxCVSxCAL5dx0pe1w=
Subject: PROBLEM: HT1000 drops network packets during disk writes
From: Alex Izvorski <aizvorski@gmail.com>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: nsankar@broadcom.com, jgarzik@pobox.com, support@supermicro.com
Content-Type: multipart/mixed; boundary="=-+yhAMLr1psaIxOAiBtZN"
Date: Tue, 29 Aug 2006 13:59:32 -0700
Message-Id: <1156885172.1399.955.camel@farstar>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+yhAMLr1psaIxOAiBtZN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Any ideas?  I would be happy to help test any fixes and/or provide a
test system, if anyone wants to tackle this.

Regards,
-- Alex Izvorski


[1.] One line summary of the problem:
HT1000 drops network packets during disk writes

[2.] Full description of the problem:
A lot of dropped network packets on onboard gigabit controller (tg3) if
_any_ disk writes are done on onboard SATA controller (sata_svw) at the
same time, on a HT1000-based system.  Packet drop 0.2-1% can be caused
by minimal disk writes (a few kb/s) during moderate (100mbit/s or less)
network I/O.  This appears to be caused by disk writes only, and affects
network reads only. 

[3.] Keywords:
HT1000 HT-1000 sata_svw BC5785 sata tg3 Serverworks Broadcom

[4.] Kernel version:
All tested kernel versions (2.6.9 to 2.6.18-rc4) are affected.
Tested: 
2.6.18-rc4
2.6.17
RHEL4 2.6.9-34.ELsmp rpm

[5.] Most recent kernel version which did not have the bug:
all tested versions have this problem

[7.] A small shell script or example program which triggers the
     problem

on test box, run:
dd if=/dev/zero of=testfile bs=1M count=1000 &
iperf -s -u

on another box connected via gigabit ethernet, run:
iperf -c $ip_address_of_test_box -u -b 300m -l 1316

Typical results:
Interval      Transfer   Bandwidth       Jitter   Lost/Total Datagrams
(with disk access)
0.0-10.0 sec  358 MBytes  300 Mbits/sec  0.002 ms  820/285716 (0.29%)
(without disk access)
0.0-10.0 sec  359 MBytes  301 Mbits/sec  0.003 ms    1/285716
(note the 1 "lost" is really zero lost, iperf always reports that)


[8.] Environment
cpu: AMD Athlon(tm) 64 X2 Dual Core Processor 4600+
motherboard: Supermicro H8SSL-i
ram: 512MB ECC
disk: HDS728080PLA380
operating system: CentOS 4.3

[8.1.] Software (add the output of the ver_linux script here)

Linux localhost.localdomain 2.6.9-34.ELsmp #1 SMP Thu Mar 9 06:23:23 GMT
2006 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  3.4.5
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12a
mount                  2.12a
module-init-tools      3.1-pre5
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         md5 ipv6 sunrpc tg3 ext3 jbd sata_svw libata
sd_mod scsi_mod


[8.2.] Processor information (from /proc/cpuinfo):

AMD Athlon(tm) 64 X2 Dual Core Processor 4600+

[8.3.] Module information (from /proc/modules):

md5 5697 1 - Live 0xffffffffa0181000
ipv6 282785 12 - Live 0xffffffffa0138000
sunrpc 174905 1 - Live 0xffffffffa00e9000
tg3 103621 0 - Live 0xffffffffa0077000
ext3 137809 1 - Live 0xffffffffa0054000
jbd 68977 1 ext3, Live 0xffffffffa0042000
sata_svw 9925 2 - Live 0xffffffffa003e000
libata 66057 1 sata_svw, Live 0xffffffffa002c000
sd_mod 19393 3 - Live 0xffffffffa0026000
scsi_mod 140561 2 libata,sd_mod, Live 0xffffffffa0002000

[8.4.] Loaded driver and hardware information
(/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
03c0-03df : vga+
0500-0503 : PM1a_EVT_BLK
0504-0505 : PM1a_CNT_BLK
0508-050b : PM_TMR
0514-051b : GPE0_BLK
0540-0543 : PM1b_EVT_BLK
0544-0545 : PM1b_CNT_BLK
0550-0557 : GPE1_BLK
0cf8-0cff : PCI conf1
5010-5015 : ACPI CPU throttle
a000-bfff : PCI Bus #01
  a800-a81f : 0000:01:0e.0
    a800-a81f : sata_svw
  a880-a883 : 0000:01:0e.0
    a880-a883 : sata_svw
  ac00-ac07 : 0000:01:0e.0
    ac00-ac07 : sata_svw
  b000-b003 : 0000:01:0e.0
    b000-b003 : sata_svw
  b080-b087 : 0000:01:0e.0
    b080-b087 : sata_svw
d400-d4ff : 0000:00:03.0
d800-d8ff : 0000:00:03.1
e000-e0ff : 0000:00:05.0
e800-e8ff : 0000:00:03.2
ffa0-ffaf : 0000:00:02.1
  ffa0-ffa7 : ide0

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000ca000-000cb7ff : Adapter ROM
000cb800-000ccfff : Adapter ROM
000cd000-000cdfff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-003090cf : Kernel code
  003090d0-00449123 : Kernel data
1fff0000-1fffdfff : ACPI Tables
1fffe000-1fffffff : ACPI Non-volatile Storage
fc900000-fcafffff : PCI Bus #01
  fc900000-fc9fffff : PCI Bus #02
    fc9c0000-fc9cffff : 0000:02:03.0
      fc9c0000-fc9cffff : tg3
    fc9d0000-fc9dffff : 0000:02:03.1
      fc9d0000-fc9dffff : tg3
  fcafe000-fcafffff : 0000:01:0e.0
    fcafe000-fcafffff : sata_svw
fd000000-fdffffff : 0000:00:05.0
febfb000-febfbfff : 0000:00:03.0
febfc000-febfcfff : 0000:00:03.1
febfd000-febfdfff : 0000:00:03.2
febff000-febfffff : 0000:00:05.0
fec00000-fec02fff : reserved
fee00000-fee00fff : reserved
ff500000-ff5fffff : PCI Bus #01
  ff500000-ff5fffff : PCI Bus #02
ff780000-ffffffff : reserved

[8.5.] PCI information ('lspci -vvv' as root)
(lspci -vvv output attached)

00:01.0 PCI bridge: Broadcom HT1000 PCI/PCI-X bridge
00:02.0 Host bridge: Broadcom HT1000 Legacy South Bridge
00:02.1 IDE interface: Broadcom HT1000 Legacy IDE controller
00:02.2 ISA bridge: Broadcom HT1000 LPC Bridge
00:03.0 USB Controller: Broadcom HT1000 USB Controller (rev 01)
00:03.1 USB Controller: Broadcom HT1000 USB Controller (rev 01)
00:03.2 USB Controller: Broadcom HT1000 USB Controller (rev 01)
00:05.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
01:0d.0 PCI bridge: Broadcom HT1000 PCI/PCI-X bridge (rev b2)
01:0e.0 RAID bus controller: Broadcom BCM5785 (HT1000) SATA Native SATA
Mode
02:03.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 10)
02:03.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 10)

[8.7.] Other information that might be relevant to the problem

What the problem is probably not: 

- it does not require high I/O load: transfering 80-100Mbit/s over the
network while writing only 30-40kb/s to disk causes some dropped
packets.

- it is not caused by disk reading, only by writing (including swap).

- it is not caused by net writing, only by reading (*maybe* - need to
test this more).

- it is not a bug in iperf: exact same results in tcpdump and other
programs which do network I/O.

- it is not due to CPU load: cpu is mostly idle while doing the test;
also loading the cpu 100% with several copies of burnK7 does not cause
any dropped packets by itself, and adjusting the priority of iperf +/-15
has no effect.

- it is not due to anything filesystem-related: writing to a disk device
directly has the same effect.

- it is not affected by the mode in which the SATA controller is in:
BIOS choices are "MMIO" (native SATA) and "IDE" (legacy), results are
identical in either.

- it is not affected by any kernel settings tested: MSI on/off,
preemptible/non-preemptible/preempt big kernel lock, SMP/non-SMP,
flat/sparse/discontig memory, ...

- it is not affected by any ethernet settings tested with ethtool:
checksum offloading on/off, rx/tx queue size, coalescing... these cause
some changes to the number of dropped packets, but there's always a
considerable amount of drop.

====


--=-+yhAMLr1psaIxOAiBtZN
Content-Disposition: attachment; filename=ht1000-dmesg.txt
Content-Type: text/plain; name=ht1000-dmesg.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit

Bootdata ok (command line is ro root=LABEL=/)
Linux version 2.6.9-34.ELsmp (buildcentos@nasha.karan.org) (gcc version 3.4.5 20051201 (Red Hat 3.4.5-2)) #1 SMP Thu Mar 9 06:23:23 GMT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fffe000 (ACPI data)
 BIOS-e820: 000000001fffe000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec03000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000f7140
ACPI: RSDT (v001 A M I  OEMRSDT  0x11000517 MSFT 0x00000097) @ 0x000000001fff0000
ACPI: FADT (v002 A M I  OEMFACP  0x11000517 MSFT 0x00000097) @ 0x000000001fff0200
ACPI: MADT (v001 A M I  OEMAPIC  0x11000517 MSFT 0x00000097) @ 0x000000001fff0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x11000517 MSFT 0x00000097) @ 0x000000001fffe040
ACPI: DSDT (v001  0ABSW 0ABSW005 0x00000005 INTL 0x02002026) @ 0x0000000000000000
Enabling SRAT NUMA discovery
Warning: acpi_table_parse(ACPI_SRAT) returned 0!
Warning: acpi_table_parse(ACPI_SLIT) returned 0!
acpi_numa_init() failed, disabling ACPI NUMA config
Scanning NUMA topology in Northbridge 24
Number of nodes 1 (10000)
Node 0 MemBase 0000000000000000 Limit 000000001fff0000
Using 22 for the hash shift. Max addr is 1fff0000 
Using node hash shift of 22
Bootmem setup node 0 0000000000000000-000000001fff0000
No mptable found.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x508
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:11 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:11 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
Setting APIC routing to flat
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-15
ACPI: IOAPIC (id[0x03] address[0xfec01000] gsi_base[16])
IOAPIC[1]: apic_id 3, version 17, address 0xfec01000, GSI 16-31
ACPI: IOAPIC (id[0x04] address[0xfec02000] gsi_base[32])
IOAPIC[2]: apic_id 4, version 17, address 0xfec02000, GSI 32-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ 8c02000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Built 1 zonelists
Kernel command line: ro root=LABEL=/ console=tty0
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 65536 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2394.124 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 509240k/524224k available (2084k kernel code, 0k reserved, 1280k data, 192k init)
Calibrating delay using timer specific routine.. 4793.01 BogoMIPS (lpj=2396507)
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
AMD CPU0: Physical Processor ID: 0
AMD CPU0: Processor Core ID: 0
AMD CPU0: Initial APIC ID: 0
CPU 0(2) -> Node 0
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
AMD CPU0: Physical Processor ID: 0
AMD CPU0: Processor Core ID: 0
AMD CPU0: Initial APIC ID: 0
CPU 0(2) -> Node 0
CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ stepping 01
per-CPU timeslice cutoff: 512.02 usecs.
task migration cache decay timeout: 1 msecs.
Booting processor 1/1 rip 6000 rsp 1001fe25f58
Initializing CPU#1
Calibrating delay using timer specific routine.. 4787.35 BogoMIPS (lpj=2393678)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
AMD CPU1: Physical Processor ID: 0
AMD CPU1: Processor Core ID: 1
AMD CPU1: Initial APIC ID: 1
CPU 1(2) -> Node 0
AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ stepping 01
Total of 2 processors activated (9580.37 BogoMIPS).
Using local APIC timer interrupts.
Detected 12.469 MHz APIC timer.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
Disabling vsyscall due to use of PM timer
time.c: Using PM based timekeeping.
checking if image is initramfs... it is
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:02.1
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1.P1P2._PRT]
ACPI: PCI Interrupt Link [LN00] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN01] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN02] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN03] (IRQs 1 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LN04] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN05] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN06] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN07] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN08] (IRQs 1 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LN09] (IRQs 1 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LN10] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN11] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN12] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN13] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN14] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN15] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN16] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN17] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN18] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN19] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN20] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN21] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN22] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN23] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN24] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN25] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN26] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN27] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN28] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN29] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LN30] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNUS] (IRQs *10)
ACPI: PCI Interrupt Link [LNSA] (IRQs *11)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:03.1[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:03.2[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:05.0[A] -> GSI 19 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:01:0e.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 24 (level, low) -> IRQ 177
ACPI: PCI interrupt 0000:02:03.1[B] -> GSI 25 (level, low) -> IRQ 185
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1156856734.307:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 7BBEE86DB23DA574
- User ID: CentOS (Kernel Module GPG key)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Processor [CPU1] (supports C1)
ACPI: Processor [CPU2] (supports C1)
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks HT1000: IDE controller at PCI slot 0000:00:02.1
SvrWks HT1000: chipset revision 0
SvrWks HT1000: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
Probing IDE interface ide0...
Probing IDE interface ide0...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.50.04-rh)
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: init not cpu 0
ACPI: (supports S0 S1 S5)
ACPI wakeup devices: 
P1P2 USB0 USB1 USB2 PS2K PS2M SLPB 
Freeing unused kernel memory: 192k freed
SCSI subsystem initialized
libata version 1.20 loaded.
sata_svw 0000:01:0e.0: version 1.07
ACPI: PCI interrupt 0000:01:0e.0[A] -> GSI 11 (level, low) -> IRQ 11
ata1: SATA max UDMA/133 cmd 0xFFFFFF0000004000 ctl 0xFFFFFF0000004020 bmdma 0xFFFFFF0000004030 irq 11
ata2: SATA max UDMA/133 cmd 0xFFFFFF0000004100 ctl 0xFFFFFF0000004120 bmdma 0xFFFFFF0000004130 irq 11
ata3: SATA max UDMA/133 cmd 0xFFFFFF0000004200 ctl 0xFFFFFF0000004220 bmdma 0xFFFFFF0000004230 irq 11
ata4: SATA max UDMA/133 cmd 0xFFFFFF0000004300 ctl 0xFFFFFF0000004320 bmdma 0xFFFFFF0000004330 irq 11
ata1: dev 0 cfg 49:2f00 82:346b 83:7fe9 84:4773 85:3468 86:3c01 87:4763 88:207f
ata1: dev 0 ATA-7, max UDMA/133, 160836480 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_svw
ata2: no device found (phy stat 00000004)
scsi1 : sata_svw
ata3: no device found (phy stat 00000004)
scsi2 : sata_svw
ata4: no device found (phy stat 00000004)
scsi3 : sata_svw
Using cfq io scheduler
  Vendor: ATA       Model: HDS728080PLA380   Rev: PF2O
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 160836480 512-byte hdwr sectors (82348 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 160836480 512-byte hdwr sectors (82348 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: sda1: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 5980215
EXT3-fs: sda1: 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
inserting floppy driver for 2.6.9-34.ELsmp
floppy0: no floppy controllers found
tg3.c:v3.43-rh (Oct 24, 2005)
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 24 (level, low) -> IRQ 177
divert: allocating divert_blk for eth0
eth0: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:30:48:56:64:32
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[0] 
eth0: dma_rwctrl[769f4000]
ACPI: PCI interrupt 0000:02:03.1[B] -> GSI 25 (level, low) -> IRQ 185
divert: allocating divert_blk for eth1
eth1: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:30:48:56:64:33
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth1: dma_rwctrl[769f4000]
Evaluate _OSC Set fails. Status = 0x0005
pciehp: Both _OSC and OSHP methods do not exist
Evaluate _OSC Set fails. Status = 0x0005
pciehp: Both _OSC and OSHP methods do not exist
ACPI: PCI interrupt 0000:00:03.2[A] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:03.2: EHCI Host Controller
ehci_hcd 0000:00:03.2: irq 10, pci mem ffffff000001a000
ehci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:03.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: irq 10, pci mem ffffff000001c000
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:03.1[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:03.1: OHCI Host Controller
ohci_hcd 0000:00:03.1: irq 10, pci mem ffffff000001e000
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (FF) [SLPF]
EXT3 FS on sda1, internal journal
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
Adding 2409708k swap on /dev/sda2.  Priority:-1 extents:1
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ip_tables: (C) 2000-2002 Netfilter core team
ip_tables: (C) 2000-2002 Netfilter core team
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
lp: driver loaded but no devices found
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff803fc400(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
eth0: no IPv6 routers present
ip_tables: (C) 2000-2002 Netfilter core team
tg3: eth1: Link is up at 1000 Mbps, full duplex.
tg3: eth1: Flow control is on for TX and on for RX.
eth1: no IPv6 routers present
unloading Kernel Card Services
ohci_hcd 0000:00:03.0: remove, state 1
usb usb2: USB disconnect, address 1
ohci_hcd 0000:00:03.0: USB bus 2 deregistered
ohci_hcd 0000:00:03.1: remove, state 1
usb usb3: USB disconnect, address 1
ohci_hcd 0000:00:03.1: USB bus 3 deregistered
ehci_hcd 0000:00:03.2: remove, state 1
usb usb1: USB disconnect, address 1
ehci_hcd 0000:00:03.2: USB bus 1 deregistered
device-mapper: cleaned up

--=-+yhAMLr1psaIxOAiBtZN
Content-Disposition: attachment; filename=ht1000-config-2.6.9-34.ELsmp
Content-Type: text/plain; name=ht1000-config-2.6.9-34.ELsmp; charset=us-ascii
Content-Transfer-Encoding: 7bit

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.9-34.ELsmp
# Thu Mar  9 06:18:54 2006
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_HPET_TIMER=y
CONFIG_X86_PM_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_AUDITFILESYSTEM=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_HOTPLUG=y
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_EXTRA_PASS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SHMEM=y
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Processor type and features
#
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_L1_CACHE_BYTES=128
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_HT=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_PREEMPT is not set
CONFIG_SCHED_SMT=y
CONFIG_K8_NUMA=y
CONFIG_DISCONTIGMEM=y
CONFIG_NUMA=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NR_CPUS=8
CONFIG_GART_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y

#
# Power management options
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_ACPI_BLACKLIST_YEAR=2001
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_PROC_INTF is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
# CONFIG_CPU_FREQ_24_API is not set
CONFIG_CPU_FREQ_TABLE=y

#
# CPUFreq processor drivers
#
CONFIG_X86_POWERNOW_K8=y
CONFIG_X86_POWERNOW_K8_ACPI=y
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
CONFIG_X86_ACPI_CPUFREQ=y
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_UNORDERED_IO is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_LEGACY_PROC=y
# CONFIG_PCI_NAMES is not set

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_YENTA=m
CONFIG_CARDBUS=y
CONFIG_PD6729=m
# CONFIG_I82092 is not set
CONFIG_TCIC=m

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_FAKE is not set
CONFIG_HOTPLUG_PCI_ACPI=m
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_PCIE=m
# CONFIG_HOTPLUG_PCI_PCIE_POLL_EVENT_MODE is not set
CONFIG_HOTPLUG_PCI_SHPC=m
# CONFIG_HOTPLUG_PCI_SHPC_POLL_EVENT_MODE is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_UID16=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=m
# CONFIG_MTD_DEBUG is not set
CONFIG_MTD_PARTITIONS=y
CONFIG_MTD_CONCAT=m
CONFIG_MTD_REDBOOT_PARTS=m
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
CONFIG_MTD_CMDLINE_PARTS=y

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=m
CONFIG_MTD_BLOCK=m
CONFIG_MTD_BLOCK_RO=m
CONFIG_FTL=m
CONFIG_NFTL=m
CONFIG_NFTL_RW=y
# CONFIG_INFTL is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_AMDSTD_RETRY=3
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_PNC2000 is not set
CONFIG_MTD_SC520CDP=m
CONFIG_MTD_NETSC520=m
# CONFIG_MTD_SBC_GXX is not set
# CONFIG_MTD_ELAN_104NC is not set
CONFIG_MTD_SCx200_DOCFLASH=m
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=m
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
# CONFIG_MTD_DILNETPC is not set
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_PCI is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
# CONFIG_MTD_BLKMTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOC2001PLUS is not set

#
# NAND Flash Device Drivers
#
CONFIG_MTD_NAND=m
# CONFIG_MTD_NAND_VERIFY_WRITE is not set
CONFIG_MTD_NAND_IDS=m
# CONFIG_MTD_NAND_DISKONCHIP is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_PC_PCMCIA=m
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_PARIDE is not set
CONFIG_BLK_CPQ_DA=m
CONFIG_BLK_CPQ_CISS_DA=m
CONFIG_CISS_SCSI_TAPE=y
CONFIG_BLK_DEV_DAC960=m
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_SX8=m
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_BLK_DEV_INITRD=y
CONFIG_LBD=y
CONFIG_DISKDUMP=m

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_DELKIN=m
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_ATIIXP=y
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_TRIFLEX=y
CONFIG_BLK_DEV_CY82C693=y
CONFIG_BLK_DEV_CS5520=y
CONFIG_BLK_DEV_CS5530=y
CONFIG_BLK_DEV_HPT34X=y
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=y
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IT8212=y
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=y
# CONFIG_PDC202XX_BURST is not set
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_PDC202XX_FORCE=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_SCSI_DUMP=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SAS_CLASS=m
# CONFIG_SAS_DEBUG is not set

#
# SCSI low-level drivers
#
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=4
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_AIC7XXX_OLD=m
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_ENABLE_RD_STRM is not set
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_AHCI=m
CONFIG_SCSI_SATA_SVW=m
CONFIG_SCSI_ATA_PIIX=m
CONFIG_SCSI_SATA_NV=m
CONFIG_SCSI_SATA_PROMISE=m
CONFIG_SCSI_SATA_SX4=m
CONFIG_SCSI_SATA_SIL=m
CONFIG_SCSI_SATA_SIS=m
CONFIG_SCSI_SATA_VIA=m
CONFIG_SCSI_SATA_VITESSE=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
CONFIG_SCSI_LPFC=m
# CONFIG_SCSI_FUTURE_DOMAIN is not set
CONFIG_SCSI_GDTH=m
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_ISCSI_SFNET=m
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
CONFIG_SCSI_QLOGIC_1280=m
CONFIG_SCSI_QLA2XXX=m
CONFIG_SCSI_QLA21XX=m
CONFIG_SCSI_QLA22XX=m
CONFIG_SCSI_QLA2300=m
CONFIG_SCSI_QLA2322=m
CONFIG_SCSI_QLA6312=m
CONFIG_SCSI_QLA24XX=m
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_QLOGIC is not set
# CONFIG_PCMCIA_SYM53C500 is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID5=m
CONFIG_MD_RAID6=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_DM=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_MIRROR=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_EMC=m

#
# Fusion MPT device support
#
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
CONFIG_FUSION_FC=m
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=40
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LAN=m
CONFIG_FUSION_OLD_MODULE_COMPAT=m

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_CONFIG=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_TUNNEL=m

#
# IP: Virtual Server Configuration
#
CONFIG_IP_VS=m
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_TUNNEL=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_BRIDGE_NETFILTER=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_CT_ACCT=y
CONFIG_IP_NF_CT_PROTO_SCTP=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
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
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
CONFIG_IP_NF_MATCH_SCTP=m
CONFIG_IP_NF_MATCH_COMMENT=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_TARGET_NOTRACK=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

#
# IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
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
CONFIG_IP6_NF_MATCH_PHYSDEV=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_IP6_NF_RAW=m

#
# Bridge: Netfilter Configuration
#
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=y

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_BRIDGE=m
CONFIG_VLAN_8021Q=m
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
CONFIG_NET_DIVERT=y
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CLK_JIFFIES=y
# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
# CONFIG_NET_SCH_CLK_CPU is not set
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_NET_CLS_IND=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_RX is not set
CONFIG_NETPOLL_TRAP=y
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_BCSP_TXCRC=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIBTUART=m
CONFIG_BT_HCIVHCI=m
CONFIG_TUX=m

#
# TUX options
#
CONFIG_TUX_EXTCGI=y
# CONFIG_TUX_EXTENDED_LOG is not set
# CONFIG_TUX_DEBUG is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
CONFIG_ETHERTAP=m

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_HAPPYMEAL=m
CONFIG_SUNGEM=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_TYPHOON=m

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_AMD8111_ETH=m
CONFIG_AMD8111E_NAPI=y
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_ADAPTEC_STARFIRE_NAPI=y
CONFIG_B44=m
CONFIG_FORCEDETH=m
# CONFIG_DGRS is not set
CONFIG_EEPRO100=m
# CONFIG_EEPRO100_PIO is not set
CONFIG_E100=m
CONFIG_E100_NAPI=y
CONFIG_FEALNX=m
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
CONFIG_8139CP=m
CONFIG_8139TOO=m
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_SIS900=m
CONFIG_EPIC100=m
# CONFIG_SUNDANCE is not set
CONFIG_VIA_RHINE=m
CONFIG_VIA_RHINE_MMIO=y

#
# Ethernet (1000 Mbit)
#
CONFIG_ACENIC=m
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_DL2K=m
CONFIG_E1000=m
CONFIG_E1000_NAPI=y
CONFIG_NS83820=m
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_R8169=m
CONFIG_R8169_NAPI=y
CONFIG_SKY2=m
CONFIG_SK98LIN=m
CONFIG_VIA_VELOCITY=m
CONFIG_TIGON3=m
CONFIG_BNX2=m

#
# Ethernet (10000 Mbit)
#
CONFIG_IXGB=m
CONFIG_IXGB_NAPI=y
CONFIG_S2IO=m
CONFIG_S2IO_NAPI=y

#
# Token Ring devices
#
CONFIG_TR=y
CONFIG_IBMOL=m
CONFIG_3C359=m
CONFIG_TMS380TR=m
CONFIG_TMSPCI=m
CONFIG_ABYSS=m

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
CONFIG_PCMCIA_WAVELAN=m
CONFIG_PCMCIA_NETWAVE=m

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_IEEE80211=m
# CONFIG_IEEE80211_DEBUG is not set
CONFIG_IEEE80211_CRYPT=m
CONFIG_IEEE80211_WPA=m
CONFIG_IEEE80211_CRYPT_TKIP=m
CONFIG_IPW2100=m
CONFIG_IPW2100_PROMISC=y
# CONFIG_IPW_DEBUG is not set
CONFIG_IPW2200=m
CONFIG_HERMES=m
CONFIG_PLX_HERMES=m
CONFIG_TMD_HERMES=m
CONFIG_PCI_HERMES=m
CONFIG_ATMEL=m
CONFIG_PCI_ATMEL=m

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
CONFIG_PCMCIA_HERMES=m
CONFIG_AIRO_CS=m
CONFIG_PCMCIA_ATMEL=m
CONFIG_PCMCIA_WL3501=m

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
CONFIG_PRISM54=m
CONFIG_NET_WIRELESS=y

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_PCMCIA_AXNET=m

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# ATM drivers
#
CONFIG_ATM_TCP=m
CONFIG_ATM_LANAI=m
CONFIG_ATM_ENI=m
# CONFIG_ATM_ENI_DEBUG is not set
# CONFIG_ATM_ENI_TUNE_BURST is not set
CONFIG_ATM_FIRESTREAM=m
# CONFIG_ATM_ZATM is not set
CONFIG_ATM_IDT77252=m
# CONFIG_ATM_IDT77252_DEBUG is not set
# CONFIG_ATM_IDT77252_RCV_ALL is not set
CONFIG_ATM_IDT77252_USE_SUNI=y
CONFIG_ATM_AMBASSADOR=m
# CONFIG_ATM_AMBASSADOR_DEBUG is not set
CONFIG_ATM_HORIZON=m
# CONFIG_ATM_HORIZON_DEBUG is not set
CONFIG_ATM_FORE200E_MAYBE=m
# CONFIG_ATM_FORE200E_PCA is not set
CONFIG_ATM_HE=m
# CONFIG_ATM_HE_USE_SUNI is not set
CONFIG_FDDI=y
# CONFIG_DEFXX is not set
# CONFIG_SKFP is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
# CONFIG_PPP_BSDCOMP is not set
CONFIG_PPPOE=m
CONFIG_PPPOATM=m
# CONFIG_SLIP is not set
CONFIG_NET_FC=y
# CONFIG_SHAPER is not set
CONFIG_NETCONSOLE=m
CONFIG_NETDUMP=m

#
# ISDN subsystem
#
CONFIG_ISDN=m

#
# Old ISDN4Linux
#
CONFIG_ISDN_I4L=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_IPPP_FILTER=y
# CONFIG_ISDN_PPP_BSDCOMP is not set
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y

#
# ISDN feature submodules
#

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
CONFIG_ISDN_DRV_HISAX=m

#
# D-channel protocol features
#
CONFIG_HISAX_EURO=y
CONFIG_DE_AOC=y
CONFIG_HISAX_NO_SENDCOMPLETE=y
CONFIG_HISAX_NO_LLC=y
CONFIG_HISAX_NO_KEYPAD=y
CONFIG_HISAX_1TR6=y
CONFIG_HISAX_NI1=y
CONFIG_HISAX_MAX_CARDS=8

#
# HiSax supported cards
#
CONFIG_HISAX_16_3=y
CONFIG_HISAX_TELESPCI=y
CONFIG_HISAX_S0BOX=y
CONFIG_HISAX_FRITZPCI=y
CONFIG_HISAX_AVM_A1_PCMCIA=y
CONFIG_HISAX_ELSA=y
CONFIG_HISAX_DIEHLDIVA=y
CONFIG_HISAX_SEDLBAUER=y
CONFIG_HISAX_NETJET=y
CONFIG_HISAX_NETJET_U=y
CONFIG_HISAX_NICCY=y
CONFIG_HISAX_BKM_A4T=y
CONFIG_HISAX_SCT_QUADRO=y
CONFIG_HISAX_GAZEL=y
CONFIG_HISAX_HFC_PCI=y
CONFIG_HISAX_W6692=y
CONFIG_HISAX_HFC_SX=y
CONFIG_HISAX_ENTERNOW_PCI=y
# CONFIG_HISAX_DEBUG is not set

#
# HiSax PCMCIA card service modules
#
CONFIG_HISAX_SEDLBAUER_CS=m
CONFIG_HISAX_ELSA_CS=m
CONFIG_HISAX_AVM_A1_CS=m
CONFIG_HISAX_TELES_CS=m

#
# HiSax sub driver modules
#
CONFIG_HISAX_ST5481=m
CONFIG_HISAX_HFCUSB=m
CONFIG_HISAX_FRITZ_PCIPNP=m
CONFIG_HISAX_HDLC=y

#
# Active cards
#
CONFIG_ISDN_DRV_TPAM=m

#
# CAPI subsystem
#
CONFIG_ISDN_CAPI=m
CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_CAPIFS_BOOL=y
CONFIG_ISDN_CAPI_CAPIFS=m
CONFIG_ISDN_CAPI_CAPIDRV=m

#
# CAPI hardware drivers
#

#
# Active AVM cards
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_B1PCMCIA=m
CONFIG_ISDN_DRV_AVMB1_AVM_CS=m
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m

#
# Active Eicon DIVA Server cards
#
# CONFIG_CAPI_EICON is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_VSXXXAA=m
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDDLER is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
CONFIG_N_HDLC=m
CONFIG_STALDRV=y

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_CS=m
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_MULTIPORT=y
CONFIG_SERIAL_8250_RSA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_CRASH=m
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
CONFIG_SC520_WDT=m
CONFIG_EUROTECH_WDT=m
CONFIG_IB700_WDT=m
CONFIG_WAFER_WDT=m
CONFIG_I8XX_TCO=m
CONFIG_SC1200_WDT=m
# CONFIG_SCx200_WDT is not set
# CONFIG_60XX_WDT is not set
CONFIG_CPU5_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_MACHZ_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m
CONFIG_WDT_501_PCI=y

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_HW_RANDOM=m
# CONFIG_NVRAM is not set
CONFIG_RTC=y
CONFIG_DTLK=m
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL_MCH=y
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_MGA=m
# CONFIG_DRM_SIS is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
# CONFIG_HPET is not set
CONFIG_MAX_RAW_DEVS=8192
CONFIG_HANGCHECK_TIMER=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
CONFIG_I2C_ISA=m
CONFIG_I2C_NFORCE2=m
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
CONFIG_I2C_PROSAVAGE=m
CONFIG_I2C_SAVAGE4=m
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m
# CONFIG_I2C_PCA_ISA is not set

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_FSCHER=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83627HF=m

#
# Other I2C Chip support
#
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_PCF8574=m
CONFIG_SENSORS_PCF8591=m
CONFIG_SENSORS_RTC8564=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#

#
# Video Adapters
#
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5246A is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_CX88 is not set
CONFIG_VIDEO_OVCAMCHIP=m

#
# Radio Adapters
#
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_CIRRUS=m
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=m
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
CONFIG_FB_RIVA=m
# CONFIG_FB_RIVA_I2C is not set
# CONFIG_FB_RIVA_DEBUG is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
CONFIG_FB_KYRO=m
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_BIT32_EMUL=m
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_ALI5451=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
CONFIG_SND_AZT3328=m
CONFIG_SND_AZX=m
CONFIG_SND_BT87X=m
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CS4281=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_KORG1212=m
CONFIG_SND_MIXART=m
CONFIG_SND_NM256=m
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
CONFIG_SND_HDSP=m
CONFIG_SND_TRIDENT=m
CONFIG_SND_YMFPCI=m
CONFIG_SND_ALS4000=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
CONFIG_SND_ES1938=m
CONFIG_SND_ES1968=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_FM801=m
CONFIG_SND_FM801_TEA575X=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_SONICVIBES=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VX222=m

#
# ALSA USB devices
#
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_USX2Y=m

#
# PCMCIA devices
#

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

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
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set

#
# USB Bluetooth TTY can only be used with disabled Bluetooth subsystem
#
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_RW_DETECT=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_HID_FF=y
CONFIG_HID_PID=y
CONFIG_LOGITECH_FF=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
CONFIG_USB_KBTAB=m
CONFIG_USB_POWERMATE=m
CONFIG_USB_MTOUCH=m
CONFIG_USB_EGALAX=m
CONFIG_USB_XPAD=m
CONFIG_USB_ATI_REMOTE=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m

#
# USB Multimedia devices
#
CONFIG_USB_DABUSB=m
CONFIG_USB_VICAM=m
CONFIG_USB_DSBR=m
CONFIG_USB_IBMCAM=m
CONFIG_USB_KONICAWC=m
CONFIG_USB_OV511=m
CONFIG_USB_SE401=m
CONFIG_USB_SN9C102=m
CONFIG_USB_STV680=m
CONFIG_USB_W9968CF=m
CONFIG_USB_PWC=m

#
# USB Network adaptors
#
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m

#
# USB Host-to-Host Cables
#
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_GENESYS=y
CONFIG_USB_NET1080=y
CONFIG_USB_PL2301=y

#
# Intelligent USB Devices/Gadgets
#
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_ZAURUS=y
CONFIG_USB_CDCETHER=y

#
# USB Network Adapters
#
CONFIG_USB_AX8817X=y

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KEYSPAN_MPR=y
CONFIG_USB_SERIAL_KEYSPAN_USA28=y
CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
CONFIG_USB_SERIAL_KEYSPAN_USA19=y
CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
CONFIG_USB_AUERSWALD=m
CONFIG_USB_RIO500=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_LED=m
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_PHIDGETSERVO=m
CONFIG_USB_TEST=m

#
# USB ATM/DSL drivers
#
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# InfiniBand support
#
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_MTHCA=m
# CONFIG_INFINIBAND_MTHCA_DEBUG is not set
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_DEBUG is not set
CONFIG_INFINIBAND_SDP=m
# CONFIG_INFINIBAND_SDP_DEBUG is not set
CONFIG_INFINIBAND_SRP=m

#
# EDAC - error detection and reporting (RAS)
#
CONFIG_EDAC=m

#
# Reporting subsystems
#
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_MM_EDAC=m
CONFIG_EDAC_AMD76X=m
CONFIG_EDAC_E7XXX=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82875P=m
CONFIG_EDAC_I82860=m
CONFIG_EDAC_R82600=m
CONFIG_EDAC_POLL=y

#
# Firmware Drivers
#
CONFIG_EDD=m
CONFIG_DELL_RBU=m

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS_XATTR=y
CONFIG_DEVPTS_FS_SECURITY=y
CONFIG_TMPFS=y
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_SECURITY=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y
CONFIG_RELAYFS_FS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_NAND=y
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
CONFIG_CRAMFS=m
CONFIG_VXFS_FS=m
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_ACL_SUPPORT=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_SPKM3=m
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_EFI_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
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
# Profiling support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_DEBUG_INFO=y
CONFIG_INIT_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_KPROBES=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_DEBUG_PROC_KEYS=y
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_SECURITY_ROOTPLUG is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
# CONFIG_SECURITY_SELINUX_MLS is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIGNATURE=y
CONFIG_CRYPTO_SIGNATURE_DSA=y
CONFIG_CRYPTO_MPILIB=y

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m

--=-+yhAMLr1psaIxOAiBtZN
Content-Disposition: attachment; filename=ht1000-lspci-vvv.txt
Content-Type: text/plain; name=ht1000-lspci-vvv.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit

00:01.0 PCI bridge: Broadcom HT1000 PCI/PCI-X bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+ <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=02, sec-latency=64
        I/O behind bridge: 0000a000-0000bfff
        Memory behind bridge: fc900000-fcafffff
        Prefetchable memory behind bridge: 00000000ff500000-00000000ff500000
        Secondary status: 66Mhz- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [90] PCI-X bridge device.
                Secondary Status: 64bit+, 133MHz+, SCD-, USC-, SCO-, SRD- Freq=3
                Status: Bus=0 Dev=1 Func=0 64bit- 133MHz- SCD- USC-, SCO-, SRD-
                : Upstream: Capacity=0, Commitment Limit=0
                : Downstream: Capacity=0, Commitment Limit=0
        Capabilities: [a0] HyperTransport: MSI Mapping
        Capabilities: [b0] HyperTransport: Slave or Primary Interface
                Command: BaseUnitID=1 UnitCnt=3 MastHost- DefDir-
                Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
                Link Config 0: MLWI=8bit MLWO=8bit LWI=8bit LWO=8bit
                Link Control 1: CFlE- CST- CFE- <LkFail- Init- EOC+ TXO+ <CRCErr=0
                Link Config 1: MLWI=8bit MLWO=8bit LWI=N/C LWO=N/C
                Revision ID: 0.00

00:02.0 Host bridge: Broadcom HT1000 Legacy South Bridge
        Subsystem: Broadcom: Unknown device 0201
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64

00:02.1 IDE interface: Broadcom HT1000 Legacy IDE controller (prog-if 8a [Master SecP PriP])
        Subsystem: Broadcom HT1000 Legacy IDE controller
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 10
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at ffa0 [size=16]

00:02.2 ISA bridge: Broadcom HT1000 LPC Bridge
        Subsystem: Broadcom: Unknown device 0230
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:03.0 USB Controller: Broadcom HT1000 USB Controller (rev 01) (prog-if 10 [OHCI])
        Subsystem: Broadcom HT1000 USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at febfb000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at d400 [size=256]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+

00:03.1 USB Controller: Broadcom HT1000 USB Controller (rev 01) (prog-if 10 [OHCI])
        Subsystem: Broadcom HT1000 USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at febfc000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at d800 [size=256]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+

00:03.2 USB Controller: Broadcom HT1000 USB Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: Broadcom HT1000 USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at febfd000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at e800 [size=256]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+

00:05.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage XL
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), Cache Line Size 10
        Interrupt: pin A routed to IRQ 169
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at e000 [size=256]
        Region 2: Memory at febff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at febc0000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] HyperTransport: Host or Secondary Interface
        !!! Possibly incomplete decoding
                Command: WarmRst+ DblEnd-
                Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
                Link Config: MLWI=16bit MLWO=16bit LWI=8bit LWO=8bit
                Revision ID: 1.02

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

01:0d.0 PCI bridge: Broadcom HT1000 PCI/PCI-X bridge (rev b2) (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 10
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fc900000-fc9fffff
        Prefetchable memory behind bridge: 00000000ff500000-00000000ff500000
        Secondary status: 66Mhz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [90] PCI-X bridge device.
                Secondary Status: 64bit+, 133MHz+, SCD-, USC-, SCO-, SRD- Freq=0
                Status: Bus=1 Dev=13 Func=0 64bit+ 133MHz+ SCD- USC-, SCO-, SRD-
                : Upstream: Capacity=8, Commitment Limit=8
                : Downstream: Capacity=8, Commitment Limit=8

01:0e.0 RAID bus controller: Broadcom BCM5785 (HT1000) SATA Native SATA Mode
        Subsystem: Broadcom BCM5785 (HT1000) SATA Native SATA Mode
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at b080 [size=8]
        Region 1: I/O ports at b000 [size=4]
        Region 2: I/O ports at ac00 [size=8]
        Region 3: I/O ports at a880 [size=4]
        Region 4: I/O ports at a800 [size=32]
        Region 5: Memory at fcafe000 (32-bit, non-prefetchable) [size=8K]
        Expansion ROM at fcac0000 [disabled] [size=128K]
        Capabilities: [60] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=4
                Status: Bus=1 Dev=14 Func=0 64bit+ 133MHz+ SCD- USC-, DC=simple, DMMRBC=0, DMOST=4, DMCRS=2, RSCEM-
        Capabilities: [90] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [a0] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
                Address: 00000000  Data: 0000

02:03.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 10)
        Subsystem: Super Micro Computer Inc: Unknown device 1648
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), Cache Line Size 10
        Interrupt: pin A routed to IRQ 177
        Region 0: Memory at fc9c0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=2 OST=0
                Status: Bus=2 Dev=3 Func=0 64bit+ 133MHz+ SCD- USC-, DC=simple, DMMRBC=2, DMOST=0, DMCRS=1, RSCEM-
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: fff4a70fcf7c001c  Data: 7148

02:03.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 10)
        Subsystem: Super Micro Computer Inc: Unknown device 1648
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), Cache Line Size 10
        Interrupt: pin B routed to IRQ 185
        Region 0: Memory at fc9d0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=2 OST=0
                Status: Bus=2 Dev=3 Func=1 64bit+ 133MHz+ SCD- USC-, DC=simple, DMMRBC=2, DMOST=0, DMCRS=1, RSCEM-
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: 0000000100000000  Data: 1b29


--=-+yhAMLr1psaIxOAiBtZN--

