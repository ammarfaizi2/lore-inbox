Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264409AbTK0Arj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 19:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264410AbTK0Arj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 19:47:39 -0500
Received: from mgr1.xmission.com ([198.60.22.201]:35757 "EHLO
	mgr1.xmission.com") by vger.kernel.org with ESMTP id S264409AbTK0Ar2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 19:47:28 -0500
Date: Wed, 26 Nov 2003 17:47:26 -0700
From: Eric Jensen <ej@xmission.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.0-test10 BUG/panic in mpage_end_io_read
Message-ID: <20031126174726.B22441@xmission.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having a problem with 2.6.0-test10 that may be of interest to someone.

I am currently in the process of upgrading to test11, and I will report any
changes in behavior if this draws any attention.

I used the outline described in linux/REPORTING-BUGS.  If you need any more
info please let me know.  I am not on the linux kernel mailing list, but I
do read the archives.  If you want a faster response, please cc me on your
reply.  Thanks,

	--Eric Jensen

[1.] 2.6.0-test10 BUG/panic in mpage_end_io_read

[2.] I have an xfs raid5 array, too which I am trying to copy a bunch of
backup folders from half of a failed raid 1 array.  After booting, the first
two directories copy OK, but on the third one I get either a BUG or a panic
every time.  It does not matter if I do a cp -a * <dest> or 
cp -a <dir1> <dir2> <dir3> <dest> or cp -a <dir1> <dest>, wait a while,
then copy another directory, etc.  No matter what, it seems to always fail
on the third directory.  Also, the size of the directories copied does not
seem to matter.  The sizes range from a few megabytes to a few gigabytes,
but the third one causes a BUG or panic every time.  If I get a BUG, I am
unable to communicate with the array anymore at all.  All processes that I
start which try to communicate with the array (umount, mount -o remount, 
xfs_check, mdadm) will freeze and cannot be killed.  
Every time it fails I have to reboot and my array must be rebuilt, which
takes about 1.5 hrs of pretty solid hdd activity, so it's kind of painful
for me to reproduce this.  I keep accidentally reproducing it while I"m
trying to copy my data over.  While the array is rebuilding I get DMA
errors from the hdds attached to the Promise PDC20269.  They are part of
the raid5 array.  In my experience, hdds that are going bad spew out a lot
of DMA errors, and usually pages at a time.  I'm getting these errors
intermittently, with 3-20 minutes between errors.  These hdds are brand
new, btw.

[3.] Keywords: xfs, raid5, via 8237 SATA, Promise PDC20269 (Ultra133 Tx2),
2.6.0-test10

[4.] Linux version 2.6.0-test10 (root@debian) (gcc version 2.95.4 20011002
(Debian prerelease)) #2 Tue Nov 25 03:14:41 MST 2003

[5.] I have a copy of the BUG, as well as part of the panic call trace that
I typed in by hand on another computer.  I tried to check it as best I
could, but I may have made a mistake typing it in.
---------------------------------- BUG ------------------------------------
kernel BUG at mm/filemap.c:332!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0130f4a>]    Not tainted
EFLAGS: 00010246
EIP is at unlock_page+0x1a/0x40
eax: 00000000   ebx: c1083b08   ecx: 00000017   edx: c1500400
esi: c1500cf4   edi: 00000001   ebp: 00000003   esp: dfcc1f0c
ds: 007b   es: 007b   ss: 0068
Process md0_raid5 (pid: 17, threadinfo=dfcc0000 task=dfcdd2d0)
Stack: dffd2e34 cbe5f540 c016201e cbe5f540 dfbcd298 ffffffff dfbcd298 c02a2f75
       cbe5f540 00000000 00000000 dfbcd298 dfd20b00 dff7ae00 dfd20b08 c17f872c
	   c17f8764 00000000 dff7ae74 00000000 00000002 00000001 00000004 ffffffff
Call Trace:
 [<c016201e>] mpage_end_io_read+0x5e/0x80
 [<c02a2f75>] handle_stripe+0x9e5/0xb30
 [<c02a341c>] raid5d+0xec/0x110
 [<c02a9af9>] md_thread+0xf9/0x140
 [<c02a9a00>] md_thread+0x0/0x140
 [<c0119ea0>] default_wake_function+0x0/0x20
 [<c010725d>] kernel_thread_helper+0x5/0x18

Code: 0f 0b 4c 01 39 85 30 c0 8d 46 04 39 46 04 74 0e 31 c9 ba 03
-------------------------------- END BUG ----------------------------------

--------------------------------- PANIC -----------------------------------
Call Trace:
 [<c016201e>] mpage_end_io_read+0x5e/0x80
 [<c014c6ac>] bio_endio+0x4c/0x60
 [<c0240330>] __end_that_request_first+0xf0/0x1d0
 [<c0240427>] end_that_request_first+0x17/0x20
 [<c0269f91>] ide_end_request+0x81/0x100
 [<c0272fb4>] default_end_request+0x14/0x20
 [<c0277071>] ide_dma_intr+0x61/0xa0
 [<c026b337>] ide_intr+0xc7/0x120
 [<c0277010>] ide_dma_intr+0x0/0xa0
 [<c010abd1>] handle_IRQ_event+0x31/0x60

Code: 0f 0b 4c 01 39 85 30 c0 8d 46 04 39 46 04 74 0e 31 c9 ba 03
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing
------------------------------- END PANIC ---------------------------------

[6.] n/a

[7.]
[7.1] ver_linux
Linux debian 2.6.0-test10 #2 Tue Nov 25 03:14:41 MST 2003 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               0.9.14
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         rtc

[7.2] /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(TM) XP 2500+
stepping        : 0
cpu MHz         : 1833.218
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3612.67

[7.3] /proc/modules
rtc 9184 - - Live 0xe583f000

[7.4] /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
7000-701f : 0000:00:10.3
7400-741f : 0000:00:10.2
7800-781f : 0000:00:10.1
8000-801f : 0000:00:10.0
8400-840f : 0000:00:0f.1
  8400-8407 : ide0
  8408-840f : ide1
8800-88ff : 0000:00:0f.0
  8800-88ff : libata
9000-900f : 0000:00:0f.0
  9000-900f : libata
9400-9403 : 0000:00:0f.0
  9400-9403 : libata
9800-9807 : 0000:00:0f.0
  9800-9807 : libata
a000-a003 : 0000:00:0f.0
  a000-a003 : libata
a400-a407 : 0000:00:0f.0
  a400-a407 : libata
a800-a80f : 0000:00:0e.0
  a800-a807 : ide2
  a808-a80f : ide3
b000-b003 : 0000:00:0e.0
  b002-b002 : ide3
b400-b407 : 0000:00:0e.0
  b400-b407 : ide3
b800-b803 : 0000:00:0e.0
  b802-b802 : ide2
d000-d007 : 0000:00:0e.0
  d000-d007 : ide2
d400-d43f : 0000:00:0a.0
  d400-d43f : e100
d800-d8ff : 0000:00:09.0
  d800-d8ff : SysKonnect SK-98xx
e000-e0ff : 0000:00:11.5

/proc/iomem
00000000-0009c3ff : System RAM
0009c400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000cc000-000ce7ff : Extension ROM
000d0000-000d0fff : Extension ROM
000f0000-000fffff : System ROM
00100000-1fffbfff : System RAM
  00100000-002f5211 : Kernel code
  002f5212-003ca57f : Kernel data
1fffc000-1fffefff : ACPI Tables
1ffff000-1fffffff : ACPI Non-volatile Storage
e4000000-e40000ff : 0000:00:10.4
e4800000-e4803fff : 0000:00:0e.0
e5000000-e5ffffff : 0000:00:0c.0
  e5000000-e5ffffff : rivafb
e6000000-e60fffff : 0000:00:0a.0
  e6000000-e60fffff : e100
e6800000-e6800fff : 0000:00:0a.0
  e6800000-e6800fff : e100
e7000000-e7003fff : 0000:00:09.0
  e7000000-e7003fff : SysKonnect SK-98xx
e8000000-efffffff : 0000:00:0c.0
  e8000000-ebffffff : rivafb
f8000000-fbffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5] lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3189 (rev 80)
        Subsystem: Asustek Computer, Inc.: Unknown device 807f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [80] AGP version 3.5
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b198 (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: e7f00000-e7efffff
        Prefetchable memory behind bridge: f8000000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: 3Com Corporation: Unknown device 1700 (rev 12)
        Subsystem: Asustek Computer, Inc.: Unknown device 80eb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (5750ns min, 7750ns max), cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at e7000000 (32-bit, non-prefetchable) [size=16K]
        Region 1: I/O ports at d800 [size=256]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data

00:0a.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e6800000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at d400 [size=64]
        Region 2: Memory at e6000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0c.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX) (rev b2) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at e5000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at e7ff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 4d69 (rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc.: Unknown device 4d68
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at d000 [size=8]
        Region 1: I/O ports at b800 [size=4]
        Region 2: I/O ports at b400 [size=8]
        Region 3: I/O ports at b000 [size=4]
        Region 4: I/O ports at a800 [size=16]
        Region 5: Memory at e4800000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=16K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown device 3149 (rev 80)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at a400 [size=8]
        Region 1: I/O ports at a000 [size=4]
        Region 2: I/O ports at 9800 [size=8]
        Region 3: I/O ports at 9400 [size=4]
        Region 4: I/O ports at 9000 [size=16]
        Region 5: I/O ports at 8800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 20
        Region 4: I/O ports at 8400 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. UHCI USB (rev 81) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at 8000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. UHCI USB (rev 81) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at 7800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 81) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at 7400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 81) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at 7000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.4 USB Controller: VIA Technologies, Inc.: Unknown device 3104 (rev 86) (prog-if 20)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin C routed to IRQ 21
        Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3227
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 60)
        Subsystem: Asustek Computer, Inc.: Unknown device 80b0
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 22
        Region 0: I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6] /proc/scsi/scsi
n/a

[7.7] none that I can think of

[X.] I have not figured out any patches, fixes or workarounds for this problem.

