Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312455AbSCUTHW>; Thu, 21 Mar 2002 14:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312457AbSCUTHO>; Thu, 21 Mar 2002 14:07:14 -0500
Received: from dsl3-63-249-88-76.cruzio.com ([63.249.88.76]:28554 "EHLO
	athlon.cichlid.com") by vger.kernel.org with ESMTP
	id <S312455AbSCUTHD>; Thu, 21 Mar 2002 14:07:03 -0500
Date: Thu, 21 Mar 2002 11:06:53 -0800
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200203211906.g2LJ6rp04003@athlon.cichlid.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre4 preempt: BUG: kunmap while in_interrupt()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This occured a few minutes of booting, not sure what triggered it but the
system is somewhat busy. Only happened once and the system seems fine WITHOUT
a reboot.

This is my first try with pre4 AND my first try with the preemptive patches:
  preempt-kernel-rml-2.4.19-pre4-1.patch
  emu10k1-20020320-2.4.19-pre4-1.patch

Mar 21 10:37:22 athlon kernel: kernel BUG at /usr/src/linux-2.4.19-pre4-rml/include/asm/highmem.h:74!
Mar 21 10:37:22 athlon kernel: invalid operand: 0000
Mar 21 10:37:22 athlon kernel: CPU:    1
Mar 21 10:37:22 athlon kernel: EIP:    0010:[file_read_actor+176/256]    Not tainted
Mar 21 10:37:22 athlon kernel: EIP:    0010:[<c0135b40>]    Not tainted
Mar 21 10:37:22 athlon kernel: EFLAGS: 00010282
Mar 21 10:37:22 athlon kernel: eax: 00000047   ebx: 00001000   ecx: ffffffb6   edx: 00000000
Mar 21 10:37:22 athlon kernel: esi: c4baf000   edi: 4001a000   ebp: c10e30c0   esp: ee00fedc
Mar 21 10:37:22 athlon kernel: ds: 0018   es: 0018   ss: 0018
Mar 21 10:37:22 athlon kernel: Process x10 (pid: 9630, stackpage=ee00f000)
Mar 21 10:37:22 athlon kernel: Stack: c02838c0 0000004a 00000000 00001000 efde42c4 c10e30c0 ea71d4d0 00000037 
Mar 21 10:37:22 athlon kernel:        c0135580 ee00ff5c c10e30c0 00000000 00001000 00001000 efde42c4 00000000 
Mar 21 10:37:22 athlon kernel:        00000000 00000000 ea71d414 df00370c ca2d7d30 00030002 089b8000 00000000 
Mar 21 10:37:22 athlon kernel: Call Trace: [do_generic_file_read+688/1504] [generic_file_read+122/288] [file_read_actor+0/256] [sys_read+149/512] [sys_brk+184/240] 
Mar 21 10:37:22 athlon kernel: Call Trace: [<c0135580>] [<c0135c0a>] [<c0135a90>] [<c0149515>] [<c0131608>] 
Mar 21 10:37:22 athlon kernel:    [do_IRQ+412/544] [system_call+51/56] 
Mar 21 10:37:22 athlon kernel:    [<c01095dc>] [<c01078cb>] 
Mar 21 10:37:22 athlon kernel: 
Mar 21 10:37:22 athlon kernel: Code: 0f 0b 5f 58 3b 2d b4 82 36 c0 72 07 89 e8 e8 ad 10 01 00 8b 

The code is:

  static inline void kunmap(struct page *page)
{
        if (in_interrupt())
                BUG();
        if (page < highmem_start_page)
                return;
        kunmap_high(page);
}


Other system info:

root@athlon:linux # sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux athlon 2.4.19-pre4-rml #3 SMP Thu Mar 21 09:34:07 PST 2002 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.13
e2fsprogs              1.26
reiserfsprogs          3.x.0f
pcmcia-cs              3.1.22
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         snd-pcm-oss snd-mixer-oss snd-card-emu10k1 snd-emu10k1 snd-pcm snd-timer snd-util-mem snd-ac97-codec snd-rawmidi snd-hwdep snd-seq-device snd soundcore NVdriver ecc ipt_TOS iptable_mangle ipt_MASQUERADE iptable_nat ip_conntrack ipt_REJECT ipt_LOG iptable_filter ip_tables ncr53c8xx i2c-dev i2c-core parport_pc lp parport 8139too mii sd_mod md dsbr100 videodev usb-ohci usbcore


athlon:aab > cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) Processor
stepping        : 1
cpu MHz         : 1194.678
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2385.51

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) Processor
stepping        : 1
cpu MHz         : 1194.678
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2385.51

athlon:aab > cat /proc/modules
snd-pcm-oss            39712   1 (autoclean)
snd-mixer-oss          10112   1 (autoclean) [snd-pcm-oss]
snd-card-emu10k1        2368   2
snd-emu10k1            62976   0 [snd-card-emu10k1]
snd-pcm                62912   0 [snd-pcm-oss snd-emu10k1]
snd-timer              13600   0 [snd-pcm]
snd-util-mem            1984   0 [snd-emu10k1]
snd-ac97-codec         24736   0 [snd-emu10k1]
snd-rawmidi            15456   0 [snd-emu10k1]
snd-hwdep               3872   0 [snd-emu10k1]
snd-seq-device          4260   0 [snd-card-emu10k1 snd-rawmidi]
snd                    33416   0 [snd-pcm-oss snd-mixer-oss snd-card-emu10k1 snd-emu10k1 snd-pcm snd-timer snd-util-mem snd-ac97-codec snd-rawmidi snd-hwdep snd-seq-device]
soundcore               5316   6 [snd]
NVdriver              821984   0 (unused)
ecc                    13952   0 (unused)
ipt_TOS                 1440   5 (autoclean)
iptable_mangle          2496   1 (autoclean)
ipt_MASQUERADE          2528   0 (autoclean)
iptable_nat            26132   0 (autoclean) [ipt_MASQUERADE]
ip_conntrack           28652   1 (autoclean) [ipt_MASQUERADE iptable_nat]
ipt_REJECT              3264 130 (autoclean)
ipt_LOG                 4032 279 (autoclean)
iptable_filter          2080   1 (autoclean)
ip_tables              14912   9 [ipt_TOS iptable_mangle ipt_MASQUERADE iptable_nat ipt_REJECT ipt_LOG iptable_filter]
ncr53c8xx              54080   0 (unused)
i2c-dev                 3776   0 (unused)
i2c-core               13856   0 [i2c-dev]
parport_pc             15524   2 (autoclean)
lp                      7392   0 (autoclean)
parport                28928   2 (autoclean) [parport_pc lp]
8139too                19808   1 (autoclean)
mii                     1520   0 (autoclean) [8139too]
sd_mod                 11548   4 (autoclean)
md                     45568   0
dsbr100                 4544   1
videodev                6688   2 [dsbr100]
usb-ohci               25152   0 (unused)
usbcore                68288   1 [dsbr100 usb-ohci]

athlon:aab > cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1000-10ff : LSI Logic / Symbios Logic (formerly NCR) 53c810
  1000-107f : ncr53c8xx
1400-14ff : Realtek Semiconductor Co., Ltd. RTL-8139
  1400-14ff : 8139too
1800-183f : Promise Technology, Inc. 20267
  1800-1807 : ide2
  1808-180f : ide3
  1810-183f : PDC20267
1840-185f : Creative Labs SB Live! EMU10k1
  1840-185f : EMU10K1
1860-187f : PCI device 1415:9501 (Oxford Semiconductor Ltd)
1880-189f : PCI device 1415:9501 (Oxford Semiconductor Ltd)
  1880-1887 : serial(auto)
  1888-188f : serial(auto)
  1890-1897 : serial(auto)
  1898-189f : serial(auto)
18a0-18bf : PCI device 1415:9513 (Oxford Semiconductor Ltd)
18d0-18df : 3ware Inc 3ware 7000-series ATA-RAID
  18d0-18dc : 3ware Storage Controller
18e0-18e3 : PCI device 1022:700c (Advanced Micro Devices [AMD])
18e4-18e7 : Promise Technology, Inc. 20267
  18e6-18e6 : ide3
18e8-18ef : Promise Technology, Inc. 20267
  18e8-18ef : ide3
18f0-18f3 : Promise Technology, Inc. 20267
  18f2-18f2 : ide2
18f8-18ff : Promise Technology, Inc. 20267
  18f8-18ff : ide2
1c00-1c07 : Creative Labs SB Live!
1c08-1c0f : PCI device 1415:9513 (Oxford Semiconductor Ltd)
1c10-1c17 : PCI device 1415:9513 (Oxford Semiconductor Ltd)
  1c10-1c12 : parport1
f000-f00f : Advanced Micro Devices [AMD] AMD-765 [Viper] IDE
  f000-f007 : ide0
  f008-f00f : ide1

athlon:aab > cat /proc/iomem
00000000-0009bfff : System RAM
0009c000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000ca800-000cc7ff : Extension ROM
000cc800-000cd7ff : Extension ROM
000dc000-000dcfff : Advanced Micro Devices [AMD] AMD-765 [Viper] USB
  000dc000-000dcfff : usb-ohci
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-2ffeffff : System RAM
  00100000-00275b8c : Kernel code
  00275b8d-002f80df : Kernel data
2fff0000-2ffffbff : ACPI Tables
2ffffc00-2fffffff : ACPI Non-volatile Storage
f4000000-f47fffff : 3ware Inc 3ware 7000-series ATA-RAID
f4800000-f481ffff : Promise Technology, Inc. 20267
f4821000-f4821fff : PCI device 1415:9501 (Oxford Semiconductor Ltd)
f4822000-f4822fff : PCI device 1415:9501 (Oxford Semiconductor Ltd)
f4823000-f4823fff : PCI device 1415:9513 (Oxford Semiconductor Ltd)
f4824000-f48240ff : LSI Logic / Symbios Logic (formerly NCR) 53c810
f4824400-f482440f : 3ware Inc 3ware 7000-series ATA-RAID
f4824800-f48248ff : Realtek Semiconductor Co., Ltd. RTL-8139
  f4824800-f48248ff : 8139too
f4825000-f4825fff : PCI device 1022:700c (Advanced Micro Devices [AMD])
f5000000-f5ffffff : PCI Bus #01
  f5000000-f5ffffff : nVidia Corporation Vanta [NV6]
f8000000-fbffffff : PCI device 1022:700c (Advanced Micro Devices [AMD])
fc000000-fdffffff : PCI Bus #01
  fc000000-fdffffff : nVidia Corporation Vanta [NV6]
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

root@athlon:/root # lspci -vvv
00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at f4825000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at 18e0 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 99
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f5000000-f5ffffff
        Prefetchable memory behind bridge: fc000000-fdffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-765 [Viper] ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-765 [Viper] IDE (rev 01) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-765 [Viper] ACPI (rev 01)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-765 [Viper] USB (rev 07) (prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (20000ns max)
        Interrupt: pin D routed to IRQ 11
        Region 0: Memory at 000dc000 (32-bit, non-prefetchable) [size=4K]

00:08.0 Non-VGA unclassified device: Symbios Logic Inc. (formerly NCR) 53c810 (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 1000 [size=256]
        Region 1: Memory at f4824000 (32-bit, non-prefetchable) [size=256]

00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 4d33
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 18f8 [size=8]
        Region 1: I/O ports at 18f0 [size=4]
        Region 2: I/O ports at 18e8 [size=8]
        Region 3: I/O ports at 18e4 [size=4]
        Region 4: I/O ports at 1800 [size=64]
        Region 5: Memory at f4800000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 08)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 1840 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.1 Input device controller: Creative Labs SB Live! (rev 08)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 0: I/O ports at 1c00 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 RAID bus controller: 3ware Inc: Unknown device 1001 (rev 01)
        Subsystem: 3ware Inc: Unknown device 1001
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (2250ns min), cache line size 10
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 18d0 [size=16]
        Region 1: Memory at f4824400 (32-bit, non-prefetchable) [size=16]
        Region 2: Memory at f4000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Serial controller: Oxford Semiconductor Ltd: Unknown device 9501 (prog-if 06 [16950])
        Subsystem: Oxford Semiconductor Ltd: Unknown device 0000
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 1880 [size=32]
        Region 1: Memory at f4822000 (32-bit, non-prefetchable) [size=4K]
        Region 2: I/O ports at 1860 [size=32]
        Region 3: Memory at f4821000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 Parallel controller: Oxford Semiconductor Ltd: Unknown device 9513 (prog-if 01 [BiDir])
        Subsystem: Oxford Semiconductor Ltd: Unknown device 0000
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 5
        Region 0: I/O ports at 1c10 [size=8]
        Region 1: I/O ports at 1c08 [size=8]
        Region 2: I/O ports at 18a0 [size=32]
        Region 3: Memory at f4823000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 1400 [size=256]
        Region 1: Memory at f4824800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at fc000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

root@athlon:linux # cat /proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: 3ware    Model: 3w-xxxx          Rev: 1.0 
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi0 Channel: 00 Id: 07 Lun: 00
  Vendor: 3ware    Model: 3w-xxxx          Rev: 1.0 
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: HP       Model: C1537A           Rev: L708
  Type:   Sequential-Access                ANSI SCSI revision: 02

