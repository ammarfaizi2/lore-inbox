Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTFPDiv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 23:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTFPDiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 23:38:51 -0400
Received: from guru.webcon.net ([66.11.168.140]:15266 "EHLO guru.webcon.net")
	by vger.kernel.org with ESMTP id S263310AbTFPDim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 23:38:42 -0400
Date: Sun, 15 Jun 2003 23:52:27 -0400 (EDT)
From: Robert Hardy <rhardy@webcon.net>
X-X-Sender: rhardy@vortex.int.webcon.net
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.21-ac1 emu10k1 locks during module "initializing"
Message-ID: <Pine.LNX.4.56.0306152346590.5331@vortex.int.webcon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me personally on any responses as I don't subscribe to the list.
Sorry for the long email but I was trying to follow the BUG-REPORTING
guidelines.

[1.] One line summary of the problem: 
     2.4.21-ac1 emu10k1 locks during module "initializing"

[2.] Full description of the problem/report:
     Something has changed between 2.4.21-rc2-ac2 and 2.4.21-ac1 to break
     the emu10k1 sound module.

     emu10k1 module in 2.4.21-ac1 (w/ patch-o-matic-20030614 iprange.patch
     and connlimit.patch) compiles but generates these 3 new warnings:
efxmgr.c: In function `emu10k1_set_oss_vol':
efxmgr.c:107: warning: passing arg 1 of pointer to function from incompatible pointer type
main.c: In function `fx_init':
main.c:752: warning: passing arg 1 of `emu10k1_ac97_write' from incompatible pointer type
main.c:757: warning: passing arg 1 of `emu10k1_ac97_write' from incompatible pointer type

     When you attempt to use the resulting module it doesn't work (no sound
     output from xmms) and on further inspection it seems to have failed to
     initialize properly and lsmod shows it stuck in a state of
     (initializing) and my logs showed an oops from modprobe (see below.)

     Given the problems seems to be at initialization time those last two
     warnings look like good canidates.

     See my ugly work around in [7.]

[3.] Keywords (i.e., modules, networking, kernel): 
     modules, kernel, emu10k1, sound, ac97_codec

[4.] Kernel version (from /proc/version):

Linux version 2.4.21-ac1 (root@vortex.int.webcon.net) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Sun Jun 15 22:56:16 EDT 2003

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

ksymoops 2.4.5 on i686 2.4.21-ac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-ac1/ (default)
     -m /boot/System.map-2.4.21-ac1 (specified)

Jun 15 23:19:26 vortex kernel: ac97_codec: AC97  codec, id: TRA35 (TriTech TR A5)
Jun 15 23:19:26 vortex kernel: Unable to handle kernel paging request at virtual address 004095cd
Jun 15 23:19:26 vortex kernel: e2f07863
Jun 15 23:19:26 vortex kernel: *pde = 00000000
Jun 15 23:19:26 vortex kernel: Oops: 0000
Jun 15 23:19:26 vortex kernel: CPU:    0
Jun 15 23:19:26 vortex kernel: EIP:    0010:[<e2f07863>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 15 23:19:26 vortex kernel: EFLAGS: 00010082
Jun 15 23:19:26 vortex kernel: eax: 00405551   ebx: 00000018   ecx: 00000282   edx: 0000a404
Jun 15 23:19:26 vortex kernel: esi: 00000000   edi: 00000043   ebp: 00000012   esp: d8067ca4
Jun 15 23:19:26 vortex kernel: ds: 0018   es: 0018   ss: 0018
Jun 15 23:19:26 vortex kernel: Process modprobe (pid: 1236, stackpage=d8067000)
Jun 15 23:19:26 vortex kernel: Stack: d7ed4098 d7ed0000 00000043 00000012 e2f09aa8 d7ed4098 00000018 00000000 
Jun 15 23:19:26 vortex kernel:        00000020 000003ff 00000000 00000000 00000000 00000003 d8067d9d ffffffff 
Jun 15 23:19:26 vortex kernel:        d8067d1c 20000001 33323130 37363534 42413938 46454443 4a494847 4e4d4c4b 
Jun 15 23:19:26 vortex kernel: Call Trace:    [<e2f09aa8>] [<e2f09e6c>] [<e2f080de>] [<e2f0a0ab>] [<e2f0a604>]
Jun 15 23:19:26 vortex kernel:   [<e2f11280>] [<e2f112e0>] [<c01e286a>] [<e2f11280>] [<e2f112e0>] [<c01e2900>]
Jun 15 23:19:27 vortex kernel:   [<e2f112e0>] [<e2f0a773>] [<e2f112e0>] [<c011a781>] [<e2f02060>] [<e2f0f2f4>]
Jun 15 23:19:27 vortex kernel:   [<e2f02060>] [<e2f02060>] [<c0107083>]
Jun 15 23:19:27 vortex kernel: Code: 0f b7 a8 7c 40 00 00 89 d8 8d 7d 1e 89 fa ee 8d 55 1c 89 f0 


>>EIP; e2f07863 <[emu10k1]emu10k1_ac97_write+24/4f>   <=====

>>eax; 00405551 Before first symbol
>>edx; 0000a404 Before first symbol
>>esp; d8067ca4 <_end+17d63dcc/205b5188>

Trace; e2f09aa8 <[emu10k1]fx_init+189c/18f4>
Trace; e2f09e6c <[emu10k1]hw_init+36c/598>
Trace; e2f080de <[emu10k1]emu10k1_midi_init+15b/190>
Trace; e2f0a0ab <[emu10k1]emu10k1_init+13/40>
Trace; e2f0a604 <[emu10k1]emu10k1_probe+2c9/383>
Trace; e2f11280 <[emu10k1]emu10k1_pci_tbl+0/38>
Trace; e2f112e0 <[emu10k1]emu10k1_pci_driver+0/40>
Trace; c01e286a <pci_announce_device+35/70>
Trace; e2f11280 <[emu10k1]emu10k1_pci_tbl+0/38>
Trace; e2f112e0 <[emu10k1]emu10k1_pci_driver+0/40>
Trace; c01e2900 <pci_register_driver+5b/5f>
Trace; e2f112e0 <[emu10k1]emu10k1_pci_driver+0/40>
Trace; e2f0a773 <[emu10k1]emu10k1_init_module+1f/49>
Trace; e2f112e0 <[emu10k1]emu10k1_pci_driver+0/40>
Trace; c011a781 <sys_init_module+530/67a>
Trace; e2f02060 <[emu10k1]emu10k1_audio_read+0/1ef>
Trace; e2f0f2f4 <[emu10k1].rodata.end+127d/2ea9>
Trace; e2f02060 <[emu10k1]emu10k1_audio_read+0/1ef>
Trace; e2f02060 <[emu10k1]emu10k1_audio_read+0/1ef>
Trace; c0107083 <system_call+33/38>

Code;  e2f07863 <[emu10k1]emu10k1_ac97_write+24/4f>
00000000 <_EIP>:
Code;  e2f07863 <[emu10k1]emu10k1_ac97_write+24/4f>   <=====
   0:   0f b7 a8 7c 40 00 00      movzwl 0x407c(%eax),%ebp   <=====
Code;  e2f0786a <[emu10k1]emu10k1_ac97_write+2b/4f>
   7:   89 d8                     mov    %ebx,%eax
Code;  e2f0786c <[emu10k1]emu10k1_ac97_write+2d/4f>
   9:   8d 7d 1e                  lea    0x1e(%ebp),%edi
Code;  e2f0786f <[emu10k1]emu10k1_ac97_write+30/4f>
   c:   89 fa                     mov    %edi,%edx
Code;  e2f07871 <[emu10k1]emu10k1_ac97_write+32/4f>
   e:   ee                        out    %al,(%dx)
Code;  e2f07872 <[emu10k1]emu10k1_ac97_write+33/4f>
   f:   8d 55 1c                  lea    0x1c(%ebp),%edx
Code;  e2f07875 <[emu10k1]emu10k1_ac97_write+36/4f>
  12:   89 f0                     mov    %esi,%eax

[6.] A small shell script or example program which triggers the
     problem (if possible)

     If the problem hasn't already occurred once you login to X, attempting
     to play an mp3 w/ xmms will trigger the problem.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux vortex.int.webcon.net 2.4.21-ac1 #1 Sun Jun 15 22:56:16 EDT 2003 i686 i686 i386 GNU/Linux
 
Gnu C                  3.2.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.22
e2fsprogs              1.32
reiserfsprogs          3.6.4
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded         emu10k1 ac97_codec soundcore nfs lockd sunrpc radeon agpgart binfmt_misc autofs4 tulip crc32 sg sr_mod serial ide-scsi scsi_mod ide-cd cdrom usbmouse keybdev mousedev hid input ehci-hcd usb-ohci usbcore rtc

[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 1.60GHz
stepping	: 4
cpu MHz		: 1615.121
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3224.37

[7.3.] Module information (from /proc/modules):

emu10k1                62408 (initializing)
ac97_codec             16680   0 (autoclean) [emu10k1]
soundcore               6212   4 (autoclean) [emu10k1]
nfs                    78584   1 (autoclean)
lockd                  56688   1 (autoclean) [nfs]
sunrpc                 79836   1 (autoclean) [nfs lockd]
radeon                112772  12
agpgart                25768   3
binfmt_misc             7208   1
autofs4                11732   1 (autoclean)
tulip                  43840   1
crc32                   3680   0 [tulip]
sg                     30636   0 (autoclean)
sr_mod                 15352   0 (autoclean)
serial                 51716   0 (autoclean)
ide-scsi               11760   0
scsi_mod               68660   3 [sg sr_mod ide-scsi]
ide-cd                 34720   0
cdrom                  32672   0 [sr_mod ide-cd]
usbmouse                3128   0 (unused)
keybdev                 2848   0 (unused)
mousedev                5300   1
hid                    21540   0 (unused)
input                   5536   0 [usbmouse keybdev mousedev hid]
ehci-hcd               19496   0 (unused)
usb-ohci               20776   0 (unused)
usbcore                76608   1 [usbmouse hid ehci-hcd usb-ohci]
rtc                     8252   0 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0c00-0c0f : Intel Corp. 82801BA/BAM SMBus
0cf8-0cff : PCI conf1
7000-7fff : PCI Bus #01
  7800-78ff : ATI Technologies Inc Radeon R100 QD [Radeon 7200]
a000-a07f : Digital Equipment Corporation DECchip 21142/43
  a000-a07f : tulip
a400-a41f : Creative Labs SB Live! EMU10k1
  a400-a41f : EMU10K1
a800-a80f : Promise Technology, Inc. PDC20276 IDE
  a800-a807 : ide2
  a808-a80f : ide3
ac00-ac03 : Promise Technology, Inc. PDC20276 IDE
  ac02-ac02 : ide3
b000-b007 : Promise Technology, Inc. PDC20276 IDE
  b000-b007 : ide3
b400-b403 : Promise Technology, Inc. PDC20276 IDE
  b402-b402 : ide2
b800-b807 : Promise Technology, Inc. PDC20276 IDE
  b800-b807 : ide2
bc00-bc07 : Creative Labs SB Live! MIDI/Game Port
fc00-fc0f : Intel Corp. 82801BA IDE U100
  fc00-fc07 : ide0
  fc08-fc0f : ide1

# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000d07ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-00235f6a : Kernel code
  00235f6b-002b181f : Kernel data
1fff0000-1fff7fff : ACPI Tables
1fff8000-1fffffff : ACPI Non-volatile Storage
cf700000-df8fffff : PCI Bus #01
  d0000000-d7ffffff : ATI Technologies Inc Radeon R100 QD [Radeon 7200]
dfb00000-dfdfffff : PCI Bus #01
  dfd80000-dfdfffff : ATI Technologies Inc Radeon R100 QD [Radeon 7200]
dfef9000-dfef9fff : NEC Corporation USB
  dfef9000-dfef9fff : usb-ohci
dfefa000-dfefafff : NEC Corporation USB (#2)
  dfefa000-dfefafff : usb-ohci
dfefbb00-dfefbbff : NEC Corporation USB 2.0
  dfefbb00-dfefbbff : ehci_hcd
dfefbc00-dfefbfff : Digital Equipment Corporation DECchip 21142/43
  dfefbc00-dfefbfff : tulip
dfefc000-dfefffff : Promise Technology, Inc. PDC20276 IDE
e0000000-efffffff : Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffb00000-ffbfffff : reserved
fff00000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
	Subsystem: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [e4] #09 [9104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x4

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=02, sec-latency=64
	I/O behind bridge: 00007000-00007fff
	Memory behind bridge: dfb00000-dfdfffff
	Prefetchable memory behind bridge: cf700000-df8fffff
	BridgeCtl: Parity+ SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 00008000-0000bfff
	Memory behind bridge: dfe00000-dfefffff
	Prefetchable memory behind bridge: df900000-df9fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05) (prog-if 80 [Master])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 3981
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at fc00 [size=16]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 3981
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at 0c00 [size=16]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R100 QD [Radeon 64 DDR] (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Radeon 7000/Radeon
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 7800 [size=256]
	Region 2: Memory at dfd80000 (32-bit, non-prefetchable) [size=512K]
	Expansion ROM at dfd60000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x4
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:01.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 05)
	Subsystem: Creative Labs CT4850 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at a400 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:01.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 05)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at bc00 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:02.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: AOPEN Inc.: Unknown device 0028
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at a000 [size=128]
	Region 1: Memory at dfefbc00 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at dfe80000 [disabled] [size=256K]

03:0a.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 01) (prog-if 85)
	Subsystem: Promise Technology, Inc.: Unknown device 1275
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 22
	Region 0: I/O ports at b800 [size=8]
	Region 1: I/O ports at b400 [size=4]
	Region 2: I/O ports at b000 [size=8]
	Region 3: I/O ports at ac00 [size=4]
	Region 4: I/O ports at a800 [size=16]
	Region 5: Memory at dfefc000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:0c.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at dfef9000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:0c.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin B routed to IRQ 21
	Region 0: Memory at dfefa000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:0c.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 3504
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8500ns max), cache line size 20
	Interrupt: pin C routed to IRQ 22
	Region 0: Memory at dfefbb00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W1610A Rev: 1.05
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: AOPEN    Model: 16XDVD-ROM/AMH   Rev: R12 
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds: If I do this:
     WORKAROUND (yes it is ugly but works fine...):
     cd /usr/src/linux-2.4.21-ac1/drivers
     rm -r sound
     cp -a /usr/src/linux-2.4.21-rc2-ac2-1/drivers/sound .
     The kernel now builds fine with less warnings in the sound tree and emu10k1 works properly.

Regards,
Rob

-- 
---------------------"Happiness is understanding."----------------------
Robert Hardy, B.Eng Computer Systems                  C.E.O. Webcon Inc.
rhardy <at> webcon <dot> ca    GPG Key available          (613) 276-7327
