Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266919AbUGVTKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266919AbUGVTKI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 15:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266917AbUGVTKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 15:10:08 -0400
Received: from smtp2-ha.chilitech.net ([63.174.244.23]:8168 "EHLO
	smtp2-ha.chilitech.net") by vger.kernel.org with ESMTP
	id S266913AbUGVTJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 15:09:19 -0400
Message-ID: <410011F7.7030202@chilitech.com>
Date: Thu, 22 Jul 2004 15:13:59 -0400
From: Jack Sprat <trashcan@chilitech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: linux-2.4.x sound module opl3sa2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I submitted this possible bug months ago to maintainer. No response for 
whatever reason and the potential bug persists [or I am in error ;-) ]. 
-- Ron H.

1. Sound driver opl3sa2.c: Possible incorrect display of port number
2. Output from /var/log/messages; Jun 14(unpatched), Jun 18 (patched)
     The suspect output is in line 2 "Search for a card at"

Jun 14 11:15:45 micron kernel: opl3sa2: Found OPL3-SA3 (YMF715 or YMF719)
Jun 14 11:15:45 micron kernel: opl3sa2: Search for a card at 0x880.
Jun 14 11:15:45 micron kernel: opl3sa2: Control I/O port 0x370 is not a 
YMF7xx chipset!

Jun 18 21:43:53 micron kernel: opl3sa2: Found OPL3-SA3 (YMF715 or YMF719)
Jun 18 21:43:53 micron kernel: opl3sa2: Search for a card at 0x370.
Jun 18 21:43:53 micron kernel: opl3sa2: Control I/O port 0x370 is not a 
YMF7xx chipset!

Note that 0x370 = 3*256 + 7 * 16 = 880 ; port 0x370 incorrectly 
displayed as 0x880

An attempt at a patch (patch program run from /usr/src/linux):
---------------------------------
diff -durN linux-2.4.x/drivers/sound/opl3sa2.c 
linux-2.4.x.new/drivers/sound/opl3sa2.c
--- linux-2.4.x/drivers/sound/opl3sa2.c 2002-08-02 20:39:44.000000000 -0400
+++ linux-2.4.x.new/drivers/sound/opl3sa2.c     2004-06-18 
20:57:54.000000000 -0400
@@ -1023,7 +1023,7 @@
                        if(io == -1)
                                break;
                        isapnp=0;
-                       printk(KERN_INFO PFX "Search for a card at 
0x%d.\n", io);
+                       printk(KERN_INFO PFX "Search for a card at 
%#x.\n", io);
                        /* Fall through */
                }
 #endif
--------------------- End patch ----------------
I suspect the remainder of this report is unnecessary but is included...
3. modules sound opl3sa2.c linux-2.4.x
4. Linux version 2.4.22-1.2197.nptl (bhcompile@daffy.perf.redhat.com) 
(gcc version 3.2.3 20030422 (Red Hat Linux 3.2.3-6
)) #1 Thu Jul 1 15:29:17 EDT 2004
5. N/A
6. From modules.conf:
options opl3sa2 io=0x370 mss_io=0x530 mpu_io=0x330 irq=7 dma=0 dma2=3
7. Nothing unusual in environment
7.1 If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux micron.readyto.rumble 2.4.22-1.2197.nptl #1 Thu Jul 1 15:29:17 EDT 
2004 i686 i686 i386 GNU/Linux

Gnu C                  3.3.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.25
e2fsprogs              1.34
jfsutils               1.1.3
reiserfsprogs          3.6.8
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.3
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.17
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         lp parport autofs 8139too mii floppy sg scsi_mod 
opl3sa2 mpu401 ad1848 sound soundcore keybdev mo
usedev hid input usb-uhci usbcore ext3 jbd
7.2
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 3
cpu MHz         : 266.618
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov mmx
bogomips        : 532.48
7.3
lp                      8196   0 (autoclean)
parport                33952   0 (autoclean) [lp]
autofs                 11156   0 (autoclean) (unused)
8139too                15560   1
mii                     3736   0 [8139too]
floppy                 55036   0 (autoclean)
sg                     33804   0 (autoclean) (unused)
scsi_mod              107496   1 (autoclean) [sg]
opl3sa2                10000   1
mpu401                 22372   0 [opl3sa2]
ad1848                 25580   0 [opl3sa2]
sound                  68468   1 [opl3sa2 mpu401 ad1848]
soundcore               6148   6 [sound]
keybdev                 2432   0 (unused)
mousedev                5012   1
hid                    22724   0 (unused)
input                   5664   0 [keybdev mousedev hid]
usb-uhci               24460   0 (unused)
usbcore                73120   1 [hid usb-uhci]
ext3                   65252   7
jbd                    47468   7 [ext3]

7.4
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0100-0101 : opl3sa2
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
02f8-02ff : serial(auto)
0300-0301 : mpu401
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
0e80-0e83 : WSS config
0e84-0e87 : MS Sound System
1000-100f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  1000-1007 : ide0
  1008-100f : ide1
1020-103f : Intel Corp. 82371AB/EB/MB PIIX4 USB
  1020-103f : usb-uhci
1400-14ff : D-Link System Inc RTL8139 Ethernet
  1400-14ff : 8139too
7000-701f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
8000-803f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-040fdbff : System RAM
  00100000-00253f65 : Kernel code
  00253f66-003665a7 : Kernel data
040fdc00-040ff7ff : ACPI Tables
040ff800-040ffbff : ACPI Non-volatile Storage
040ffc00-0fffffff : System RAM
f4000000-f40000ff : D-Link System Inc RTL8139 Ethernet
  f4000000-f40000ff : 8139too
f5000000-f5ffffff : PCI Bus #01
  f5000000-f5ffffff : NVidia / SGS Thomson (Joint Venture) Riva128
f8000000-fbffffff : Intel Corp. 440LX/EX - 82443LX/EX Host bridge
fc000000-fcffffff : PCI Bus #01
  fc000000-fcffffff : NVidia / SGS Thomson (Joint Venture) Riva128
fffe7000-ffffffff : reserved
00:00.0 Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (rev 
03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f5000000-f5ffffff
        Prefetchable memory behind bridge: fc000000-fcffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 1000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at 1020 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0f.0 Ethernet controller: D-Link System Inc RTL8139 Ethernet (rev 10)
        Subsystem: D-Link System Inc DFE-530TX+ 10/100 Ethernet Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 1400 [size=256]
        Region 1: Memory at f4000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: NVidia / SGS Thomson (Joint Venture) 
Riva128 (rev 10) (prog-if 00 [VGA])
        Subsystem: Diamond Multimedia Systems Viper V330
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at fc000000 (32-bit, prefetchable) [size=16M]
        Expansion ROM at <unassigned> [disabled] [size=4M]
        Capabilities: [44] AGP version 1.0
                Status: RQ=4 SBA- 64bit- FW- Rate=x1
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

Attached devices: none

