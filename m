Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267881AbUHNCLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267881AbUHNCLp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 22:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267893AbUHNCLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 22:11:45 -0400
Received: from 64.89.71.154.nw.nuvox.net ([64.89.71.154]:1994 "EHLO
	gate.apago.com") by vger.kernel.org with ESMTP id S267881AbUHNCLc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 22:11:32 -0400
SMTP-Relay: dogwood.freil.com
Message-Id: <200408140211.i7E2BNSg027992@dogwood.freil.com>
To: linux-kernel@vger.kernel.org
X-mailer: exmh-2.0.2
Subject: Serious Kernel slowdown with HIMEM (4Gig) in 2.6.7
Date: Fri, 13 Aug 2004 22:11:23 -0400
From: "Lawrence E. Freil" <lef@freil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   
I'm following the kernel bug reporting format so:

1. Linux 2.6.7 kernel slowdown in directory access with HIMEM on

2. I have discovered an issue with the Linux 2.6.7 kernel when HIMEM is
   enabled which exhibits itself as a slowdown in directory access regardless
   of filesystem used.  When HIMEM is disabled the performance returns to
   normal.  The test I ran was a simple "/usr/bin/time ls -l" of a directory
   with 3000 empty files.  With HIMEM enabled in the kernel this takes
   approximately 1.5 seconds.  Without HIMEM it takes 0.03 seconds.  The
   time is 100% CPU and no I/O operations are done to disk.  "time" reports
   there are 460 "minor" page faults with zero "major" page faults.
   I believe the issue here is the mapping of pages between high-mem and
   lowmem in the kernel paging code.  This increase in time for directory
   accesses doubles to triples times for applications using samba.
   I have also tested this on another system which had only 512Meg of RAM
   but with HIMEM set in the kernel and did not experience the problem.
   I believe it only effects the performance when the paging buffers end
   up in highmem.

3. Keywords: HIMEM, Performance

4. No oops, kernel operates normally with the exception of the performance.

5. N/A

6. time "I=0; while test $I -lt 3000; do touch $I; I=`expr $I + 1`; done"
   With HIMEM set (and available!) this takes 20 seconds
   Without HIMEM it takes about 5

7. Slackware 10.0 with 2.6.7 kernel 1GB of RAM.

7.1 ver_linux
Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
jfsutils               1.1.6
xfsprogs               2.6.13
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.6
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         ide_scsi

7.2 /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 9
cpu MHz         : 2793.765
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5521.40

7.3 /proc/modules
ide_scsi 13608 - - Live 0xf8cd9000

7.4 /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : libata
01f0-01f7 : ide0
02f8-02ff : serial
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0400-041f : 0000:00:1f.3
  0400-040f : i801-smbus
0480-04bf : 0000:00:1f.0
0800-087f : 0000:00:1f.0
0cf8-0cff : PCI conf1
d000-d0ff : 0000:01:09.0
  d000-d0ff : 8139too
d400-d4ff : 0000:01:0b.0
d800-d8ff : 0000:01:0b.0
de00-deff : 0000:01:0a.0
  de00-deff : SysKonnect SK-98xx
df00-df3f : 0000:01:08.0
  df00-df3f : eepro100
e800-e8ff : 0000:00:1f.5
ee80-eebf : 0000:00:1f.5
ef00-ef1f : 0000:00:1d.0
  ef00-ef1f : uhci_hcd
ef20-ef3f : 0000:00:1d.1
  ef20-ef3f : uhci_hcd
ef40-ef5f : 0000:00:1d.2
  ef40-ef5f : uhci_hcd
ef80-ef9f : 0000:00:1d.3
  ef80-ef9f : uhci_hcd
efe0-efe7 : 0000:00:02.0
fc00-fc0f : 0000:00:1f.2
  fc00-fc0f : libata

7.5 pciinfo
00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a5
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fe800000 (32-bit, prefetchable) [size=4M]
	Capabilities: [e4] #09 [0106]

00:02.0 VGA compatible controller: Intel Corp. 82865G Integrated Graphics Device (rev 02) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a5
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at fe780000 (32-bit, non-prefetchable) [size=512K]
	Region 2: I/O ports at efe0 [size=8]
	Capabilities: [d0] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at ef00 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at ef20 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 5
	Region 4: I/O ports at ef40 [size=32]

00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at ef80 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 5
	Region 0: Memory at fe77bc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fe400000-fe5fffff
	Prefetchable memory behind bridge: ee200000-ee2fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at fc00 [size=16]

00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 0400 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80b0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at e800 [size=256]
	Region 1: I/O ports at ee80 [size=64]
	Region 2: Memory at fe77b800 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at fe77b400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:08.0 Ethernet controller: Intel Corp. 82562EZ 10/100 Ethernet Controller (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80f8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at fe5ff000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at df00 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:09.0 Ethernet controller: D-Link System Inc RTL8139 Ethernet (rev 10)
	Subsystem: D-Link System Inc DFE-530TX+ 10/100 Ethernet Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at d000 [size=256]
	Region 1: Memory at fe5fec00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0a.0 Ethernet controller: Linksys: Unknown device 1032 (rev 12)
	Subsystem: Linksys: Unknown device 0015
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5750ns min, 7750ns max), cache line size 04
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at fe5f8000 (32-bit, non-prefetchable) [size=16K]
	Region 1: I/O ports at de00 [size=256]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data

01:0b.0 SCSI storage controller: Adaptec ASC-29320A U320 (rev 10)
	Subsystem: Adaptec: Unknown device 0060
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (10000ns min, 6250ns max), cache line size 04
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at d800 [disabled] [size=256]
	Region 1: Memory at fe5fc000 (64-bit, non-prefetchable) [size=8K]
	Region 3: I/O ports at d400 [disabled] [size=256]
	Expansion ROM at fe500000 [disabled] [size=512K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a0] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [94] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=4
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

7.6 scsi info
Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6Y120M0   Rev: YAR5
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: ATA      Model: Maxtor 6Y120M0   Rev: YAR5
  Type:   Direct-Access                    ANSI SCSI revision: 05

------
        Lawrence Freil                      Email:lef@freil.com
        1768 Old Country Place              Phone:(770) 667-9274
        Woodstock, GA 30188
