Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317185AbSFKQ7O>; Tue, 11 Jun 2002 12:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317187AbSFKQ7N>; Tue, 11 Jun 2002 12:59:13 -0400
Received: from [12.10.191.119] ([12.10.191.119]:49167 "EHLO
	server.titaniummirror.com") by vger.kernel.org with ESMTP
	id <S317185AbSFKQ7I>; Tue, 11 Jun 2002 12:59:08 -0400
Message-ID: <3D062BD3.7090601@titaniummirror.com>
Date: Tue, 11 Jun 2002 10:56:51 -0600
From: "R. Steve McKown" <smckown@titaniummirror.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Heavy network traffic causes Geode GX1 lockup
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To: linux-kernel@vger.kernel.org
Subject: Heavy network traffic causes Geode GX1 hang

Hi,

Having PCI problems on Geode GX1 based devices w/CS5530A companion chip
using kernel 2.4.16 with 586 CPU config.  Under heavy network load
across multiple attached network interfaces (PCI devices), the system
will lock up hard between 20 minutes and 5 hours after starting.  The
test program generating this traffic runs fine with no errors until the
lock occurs and no syslog errors are generated prior to the lock.

In scanning ChangeLog's for the kernel after 2.4.16, found an Alan Cox
patch for the CS5530 pirq.  While it doesn't make sense that it is an
IRQ routing issue since it runs for some time without error, I tried
it anyway.

This patch causes errors like the following:
IRQ routing conflict for 00:03.0, have irq 10, want irq 11

HOWEVER, with this patch the system will not lock up.  Multiple runs
under multiple configurations for 72 straight hours each.

I am unclear what the problem is and if the patch is masking it or
actually fixing something.  Would appreciate thoughts on next steps
to diagnose this problem.  Some additional detail follows; I apologize
for its length.  I am happy to provide anything else that may be
useful.

Thanks,
Steve McKown
Titanium Mirror, Inc.

****************************************
  Alan's pirq routing fix for CS5530
****************************************
diff -urN linux/arch/i386/kernel/pci-irq.c 
linux.new/arch/i386/kernel/pci-irq.c
--- linux/arch/i386/kernel/pci-irq.c    Tue Apr 23 05:04:14 2002
+++ linux.new/arch/i386/kernel/pci-irq.c    Fri May 10 10:51:07 2002
@@ -225,12 +225,12 @@
  */
 static int pirq_cyrix_get(struct pci_dev *router, struct pci_dev *dev, 
int pirq)
 {
-    return read_config_nybble(router, 0x5C, pirq-1);
+    return read_config_nybble(router, 0x5C, (pirq-1)^1);
 }
 
 static int pirq_cyrix_set(struct pci_dev *router, struct pci_dev *dev, 
int pirq, int irq)
 {
-    write_config_nybble(router, 0x5C, pirq-1, irq);
+    write_config_nybble(router, 0x5C, (pirq-1)^1, irq);
     return 1;
 }


****************************************
  Boot messages after applying patch
****************************************

Linux version 2.4.16-0.5.5tm (root@server.titaniummirror.com) (gcc 
version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Sat May 18 
00:04:16 MDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003d80000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
.
. [snip]
.
PCI: PCI BIOS revision 2.10 entry at 0xfad80, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router NatSemi [1078/0100] at 00:12.0
.
. [snip]
.
8139too Fast Ethernet driver 0.9.22
PCI: Found IRQ 11 for device 00:03.0
IRQ routing conflict for 00:03.0, have irq 10, want irq 11
IRQ routing conflict for 00:0b.0, have irq 10, want irq 11
eth0: RealTek RTL8139 Fast Ethernet at 0xc4811000, 00:d0:c9:42:28:21, IRQ 10
PCI: Found IRQ 10 for device 00:0e.0
IRQ routing conflict for 00:0e.0, have irq 11, want irq 10
IRQ routing conflict for 00:13.0, have irq 11, want irq 10
eth1: RealTek RTL8139 Fast Ethernet at 0xc4813000, 00:e0:7d:a4:ab:4c, IRQ 11
Intel(R) PRO/100 Fast Ethernet Adapter - Loadable driver, ver 1.6.22
Copyright (c) 2001 Intel Corporation
PCI: Found IRQ 11 for device 00:0b.0
IRQ routing conflict for 00:03.0, have irq 10, want irq 11
IRQ routing conflict for 00:0b.0, have irq 10, want irq 11
eth2: Intel(R) 8255x-based Ethernet Adapter
  Mem:0xd3042000  IRQ:10  Speed:0 Mbps  Dx:N/A
  Failed to detect cable link.
  Speed and duplex will be determined at time of connection.
  Hardware receive checksums disabled
PCI: Found IRQ 5 for device 00:0c.0
IRQ routing conflict for 00:0c.0, have irq 12, want irq 5
eth3: Intel(R) 8255x-based Ethernet Adapter
  Mem:0xd3040000  IRQ:12  Speed:0 Mbps  Dx:N/A
  Failed to detect cable link.
  Speed and duplex will be determined at time of connection.
  Hardware receive checksums disabled
Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth4: Digital DS21143 Tulip rev 65 at 0xc4833000, 00:80:C8:B9:3F:C9, IRQ 5.
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip1:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth5: Digital DS21143 Tulip rev 65 at 0xc4835000, 00:80:C8:B9:3F:CA, IRQ 11.
tulip2:  EEPROM default media type Autosense.
tulip2:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip2:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth6: Digital DS21143 Tulip rev 65 at 0xc4837000, 00:80:C8:B9:3F:CB, IRQ 10.
tulip3:  EEPROM default media type Autosense.
tulip3:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip3:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth7: Digital DS21143 Tulip rev 65 at 0xc4839000, 00:80:C8:B9:3F:CC, IRQ 12.
.
. [snip]
.
PCI: Found IRQ 11 for device 00:03.0
IRQ routing conflict for 00:03.0, have irq 10, want irq 11
IRQ routing conflict for 00:0b.0, have irq 10, want irq 11
PCI: Found IRQ 10 for device 00:0e.0
IRQ routing conflict for 00:0e.0, have irq 11, want irq 10
IRQ routing conflict for 00:13.0, have irq 11, want irq 10
PCI: Found IRQ 11 for device 00:0b.0
IRQ routing conflict for 00:03.0, have irq 10, want irq 11
IRQ routing conflict for 00:0b.0, have irq 10, want irq 11
PCI: Found IRQ 5 for device 00:0c.0
IRQ routing conflict for 00:0c.0, have irq 12, want irq 5


****************************************
  lspci output
****************************************

[root@tm0 /root]# lspci
00:00.0 Host bridge: Cyrix Corporation PCI Master
00:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)
00:0b.0 Ethernet controller: Intel Corporation 82559ER (rev 09)
00:0c.0 Ethernet controller: Intel Corporation 82559ER (rev 09)
00:0d.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)
00:12.0 ISA bridge: Cyrix Corporation 5530 Legacy [Kahlua] (rev 30)
00:12.1 Bridge: Cyrix Corporation 5530 SMI [Kahlua]
00:12.2 IDE interface: Cyrix Corporation 5530 IDE [Kahlua]
00:12.3 Multimedia audio controller: Cyrix Corporation 5530 Audio [Kahlua]
00:12.4 VGA compatible controller: Cyrix Corporation 5530 Video [Kahlua]
00:13.0 USB Controller: Compaq Computer Corporation: Unknown device a0f8 
(rev 06)
01:04.0 Ethernet controller: Digital Equipment Corporation DECchip 
21142/43 (rev 41)
01:05.0 Ethernet controller: Digital Equipment Corporation DECchip 
21142/43 (rev 41)
01:06.0 Ethernet controller: Digital Equipment Corporation DECchip 
21142/43 (rev 41)
01:07.0 Ethernet controller: Digital Equipment Corporation DECchip 
21142/43 (rev 41)


****************************************
  lspci -vvx output
****************************************

[root@tm0 /root]# lspci -vvx
00:00.0 Host bridge: Cyrix Corporation PCI Master
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0 set
00: 78 10 01 00 07 00 80 02 00 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)
    Subsystem: Realtek Semiconductor Co., Ltd. RT8139
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 min, 64 max, 32 set
    Interrupt: pin A routed to IRQ 10
    Region 0: I/O ports at e800 [size=256]
    Region 1: Memory at d3041000 (32-bit, non-prefetchable) [size=256]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 20 00 00
10: 01 e8 00 00 00 10 04 d3 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 20 40

00:0b.0 Ethernet controller: Intel Corporation 82559ER (rev 09)
    Subsystem: Intel Corporation: Unknown device 000c
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 8 min, 56 max, 32 set, cache line size 08
    Interrupt: pin A routed to IRQ 10
    Region 0: Memory at d3042000 (32-bit, non-prefetchable) [size=4K]
    Region 1: I/O ports at e000 [size=64]
    Region 2: Memory at d3020000 (32-bit, non-prefetchable) [size=128K]
    Expansion ROM at <unassigned> [disabled] [size=1M]
    Capabilities: [dc] Power Management version 2
        Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME+
        Status: D0 PME-Enable+ DSel=0 DScale=2 PME-
00: 86 80 09 12 07 00 90 02 09 00 00 02 08 20 00 00
10: 00 20 04 d3 01 e0 00 00 00 00 02 d3 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 0c 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 08 38

00:0c.0 Ethernet controller: Intel Corporation 82559ER (rev 09)
    Subsystem: Intel Corporation: Unknown device 000c
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 8 min, 56 max, 32 set, cache line size 08
    Interrupt: pin A routed to IRQ 12
    Region 0: Memory at d3040000 (32-bit, non-prefetchable) [size=4K]
    Region 1: I/O ports at e400 [size=64]
    Region 2: Memory at d3000000 (32-bit, non-prefetchable) [size=128K]
    Expansion ROM at <unassigned> [disabled] [size=1M]
    Capabilities: [dc] Power Management version 2
        Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME+
        Status: D0 PME-Enable+ DSel=0 DScale=2 PME-
00: 86 80 09 12 07 00 90 02 09 00 00 02 08 20 00 00
10: 00 00 04 d3 01 e4 00 00 00 00 00 d3 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 0c 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0c 01 08 38

00:0d.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) 
(prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
    Latency: 32 set, cache line size 08
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
    I/O behind bridge: 0000d000-0000dfff
    Memory behind bridge: d1000000-d2ffffff
    BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
    Capabilities: [dc] Power Management version 1
        Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 11 10 24 00 07 01 90 82 03 00 04 06 08 20 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 d1 d1 80 22
20: 00 d1 f0 d2 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 06 00

00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)
    Subsystem: Realtek Semiconductor Co., Ltd. RT8139
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 min, 64 max, 32 set
    Interrupt: pin A routed to IRQ 11
    Region 0: I/O ports at ec00 [size=256]
    Region 1: Memory at d3043000 (32-bit, non-prefetchable) [size=256]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 20 00 00
10: 01 ec 00 00 00 30 04 d3 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 20 40

00:12.0 ISA bridge: Cyrix Corporation 5530 Legacy [Kahlua] (rev 30)
    Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0 set, cache line size 04
00: 78 10 00 01 1f 00 80 02 30 00 01 06 04 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:12.1 Bridge: Cyrix Corporation 5530 SMI [Kahlua]
    Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Region 0: Memory at 40012000 (32-bit, non-prefetchable) [size=256]
00: 78 10 01 01 02 00 80 02 00 00 80 06 00 00 00 00
10: 00 20 01 40 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:12.2 IDE interface: Cyrix Corporation 5530 IDE [Kahlua] (prog-if 80 
[Master])
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0 set
    Region 4: I/O ports at f000 [size=16]
00: 78 10 02 01 05 00 80 02 00 80 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 f0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:12.3 Multimedia audio controller: Cyrix Corporation 5530 Audio [Kahlua]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0 set
    Region 0: Memory at 40011000 (32-bit, non-prefetchable) [size=128]
00: 78 10 03 01 06 00 80 02 00 00 01 04 00 00 00 00
10: 00 10 01 40 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:12.4 VGA compatible controller: Cyrix Corporation 5530 Video [Kahlua] 
(prog-if 00 [VGA])
    Subsystem: Cyrix Corporation: Unknown device 0001
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Region 0: Memory at 40800000 (32-bit, non-prefetchable) [size=8M]
00: 78 10 04 01 03 00 80 02 00 00 00 03 00 00 80 02
10: 00 00 80 40 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 78 10 01 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:13.0 USB Controller: Compaq Computer Corporation: Unknown device a0f8 
(rev 06) (prog-if 10 [OHCI])
    Subsystem: Compaq Computer Corporation: Unknown device a0f8
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 80 max, 32 set, cache line size 08
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at d3047000 (32-bit, non-prefetchable) [size=4K]
00: 11 0e f8 a0 07 00 80 02 06 10 03 0c 08 20 00 00
10: 00 70 04 d3 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e f8 a0
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 50

01:04.0 Ethernet controller: Digital Equipment Corporation DECchip 
21142/43 (rev 41)
    Subsystem: D-Link System Inc: Unknown device 1112
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 20 min, 40 max, 32 set, cache line size 08
    Interrupt: pin A routed to IRQ 5
    Region 0: I/O ports at d000 [size=128]
    Region 1: Memory at d2000000 (32-bit, non-prefetchable) [size=1K]
    Expansion ROM at <unassigned> [disabled] [size=256K]
00: 11 10 19 00 07 00 80 02 41 00 00 02 08 20 00 00
10: 01 d0 00 00 00 00 00 d2 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 12 11
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 14 28

01:05.0 Ethernet controller: Digital Equipment Corporation DECchip 
21142/43 (rev 41)
    Subsystem: D-Link System Inc: Unknown device 1112
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 20 min, 40 max, 32 set, cache line size 08
    Interrupt: pin A routed to IRQ 11
    Region 0: I/O ports at d400 [size=128]
    Region 1: Memory at d2001000 (32-bit, non-prefetchable) [size=1K]
    Expansion ROM at <unassigned> [disabled] [size=256K]
00: 11 10 19 00 07 00 80 02 41 00 00 02 08 20 00 00
10: 01 d4 00 00 00 10 00 d2 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 12 11
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 14 28

01:06.0 Ethernet controller: Digital Equipment Corporation DECchip 
21142/43 (rev 41)
    Subsystem: D-Link System Inc: Unknown device 1112
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 20 min, 40 max, 32 set, cache line size 08
    Interrupt: pin A routed to IRQ 10
    Region 0: I/O ports at d800 [size=128]
    Region 1: Memory at d2002000 (32-bit, non-prefetchable) [size=1K]
    Expansion ROM at <unassigned> [disabled] [size=256K]
00: 11 10 19 00 07 00 80 02 41 00 00 02 08 20 00 00
10: 01 d8 00 00 00 20 00 d2 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 12 11
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 14 28

01:07.0 Ethernet controller: Digital Equipment Corporation DECchip 
21142/43 (rev 41)
    Subsystem: D-Link System Inc: Unknown device 1112
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 20 min, 40 max, 32 set, cache line size 08
    Interrupt: pin A routed to IRQ 12
    Region 0: I/O ports at dc00 [size=128]
    Region 1: Memory at d2003000 (32-bit, non-prefetchable) [size=1K]
    Expansion ROM at <unassigned> [disabled] [size=256K]
00: 11 10 19 00 07 00 80 02 41 00 00 02 08 20 00 00
10: 01 dc 00 00 00 30 00 d2 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 12 11
30: 00 00 00 00 00 00 00 00 00 00 00 00 0c 01 14 28


****************************************
  /proc/interrupts
****************************************

[root@tm0 /root]# cat /proc/interrupts
           CPU0       
  0:      12921          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:        890          XT-PIC  serial
  4:       1591          XT-PIC  serial
  5:          5          XT-PIC  eth4
  8:          0          XT-PIC  rtc
 10:         10          XT-PIC  eth0, e100, eth6
 11:          5          XT-PIC  eth1, eth5
 12:         10          XT-PIC  e100, eth7
 14:        111          XT-PIC  ide0
NMI:          0
ERR:          0


****************************************
  Algorithm of test program
****************************************
The tester program works properly in all cases on Transmeta based
devices as well as similary configured Pentium class systems.

Contact peer test system via eth0
Share network device lists; verify they are the same
  (test assumes crossover cables between all interfaces)
Configure all network interfaces
Preconfigure an array of mtu-sized blocks of random data
Launch a thread for each interface
- Each thread transfers a block of mtu-sized data
  with the peer test system using a 2-byte CRC.
  One system sends, the other receives, then roles reverse
- Threads update interface statistics (yes, mutex locked)
Main thread generates syslog output with various statistics
  once every 30 seconds.


