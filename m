Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTFDG25 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 02:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbTFDG25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 02:28:57 -0400
Received: from bothawui.bothan.net ([66.92.184.160]:9926 "HELO
	bothawui.bothan.net") by vger.kernel.org with SMTP id S262955AbTFDG2x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 02:28:53 -0400
Date: Tue, 3 Jun 2003 23:42:22 -0700
From: Shashi Rao <shashi.rao@terpalum.umd.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc6-ac1 PCMCIA: Cardbus bridge behind transparent P2P bridge
Message-ID: <20030604064222.GA2609@bothan.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Both in-kernel and standalone PCMCIA stopped working on my laptop with 2.4.20
and above. I have a fix for it, but dont quite understand why/how it works.

My report focuses on the in-kernel PCMCIA support, yenta.c etc, compiled as
modules.

Hardware: Sony Vaio PCG-R505DS, an ACPI-only laptop with a builtin Orinoco
PC-card behind a TI PCI1410 cardbus bridge, and another unpopulated external
socket behind a Ricoh RL5c475 bridge. Both these cardbus bridges live behind
a "hub-to-pci" 82801BAM.

lspci -vt yields:

-[00]-+-00.0  Intel Corp. 82830 830 Chipset Host Bridge
      +-02.0  Intel Corp. 82830 CGC [Chipset Graphics Controller]
      +-02.1  Intel Corp. 82830 CGC [Chipset Graphics Controller]
      +-1d.0  Intel Corp. 82801CA/CAM USB (Hub #1)
      +-1d.1  Intel Corp. 82801CA/CAM USB (Hub #2)
      +-1d.2  Intel Corp. 82801CA/CAM USB (Hub #3)
      +-1e.0-[02]--+-02.0  Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
      |            +-05.0  Ricoh Co Ltd RL5c475
      |            +-08.0  Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller
      |            \-0b.0  Texas Instruments PCI1410 PC card Cardbus Controller
      +-1f.0  Intel Corp. 82801CAM ISA Bridge (LPC)
      +-1f.1  Intel Corp. 82801CAM IDE U100
      +-1f.3  Intel Corp. 82801CA/CAM SMBus
      +-1f.5  Intel Corp. 82801CA/CAM AC'97 Audio
      \-1f.6  Intel Corp. 82801CA/CAM AC'97 Modem


Data from a "clean" 2.4.21-rc6-ac1 boot:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/proc/iomem

00000000-0009dfff : System RAM
0009e000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d8000-000dffff : reserved
000e0000-000e0fff : card services
000f0000-000fffff : System ROM
00100000-27ceffff : System RAM
  00100000-0022aebe : Kernel code
  0022aebf-002a985f : Kernel data
27cf0000-27cfbfff : ACPI Tables
27cfc000-27cfffff : ACPI Non-volatile Storage
27d00000-27e7ffff : System RAM
27f00000-27f00fff : Ricoh Co Ltd RL5c475
27f01000-27f01fff : Texas Instruments PCI1410 PC card Cardbus Controller
28000000-283fffff : PCI CardBus #03
28400000-287fffff : PCI CardBus #03
28800000-28bfffff : PCI CardBus #07
28c00000-28ffffff : PCI CardBus #07
e0000000-e007ffff : Intel Corp. 82830 CGC [Chipset Graphics Controller]
  e0000000-e007ffff : intelfb
e0080000-e00fffff : Intel Corp. 82830 CGC [Chipset Graphics Controller] (#2)
e0100000-e01003ff : Intel Corp. 82801CAM IDE U100
e0200000-e0203fff : Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
e0204000-e0204fff : Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller
  e0204000-e0204fff : eepro100
e0205000-e02057ff : Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
  e0205000-e02057ff : ohci1394
e8000000-efffffff : Intel Corp. 82830 CGC [Chipset Graphics Controller]
  e8000000-efffffff : intelfb
f0000000-f7ffffff : Intel Corp. 82830 CGC [Chipset Graphics Controller] (#2)

lspci -vvxxx -s 2:b.0

02:0b.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Subsystem: Lucent Technologies: Unknown device ab01
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 27f01000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 28800000-28bff000 (prefetchable)
	Memory window 1: 28c00000-28fff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 50 ac 07 00 10 02 01 00 07 06 08 a8 02 00
10: 00 10 f0 27 a0 00 00 02 02 07 0a b0 00 00 80 28
20: 00 f0 bf 28 00 00 c0 28 00 f0 ff 28 00 48 00 00
30: fc 48 00 00 00 4c 00 00 fc 4c 00 00 ff 01 c0 05
40: a3 12 01 ab 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 60 90 44 00 00 00 00 00 00 00 00 00 22 00 00 01
90: c0 00 60 61 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 11 fe 00 00 c0 00 0e 08 00 00 1b 00 00 00
b0: 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Here is a patch that refuses to view the 82801BAM as a subtractive decoding
agent (Before 2.4.20, this bridge was treated as a non-transparent positive
decoding bridge). This restores PCMCIA functionality on both the cardbus
bridges.

diff -u --new-file --recursive linux.21rc6-ac1-clean/arch/i386/kernel/pci-pc.c linux.21rc6-ac1-patched/arch/i386/kernel/pci-pc.c
--- linux.21rc6-ac1-clean/arch/i386/kernel/pci-pc.c	Tue Jun  3 22:26:40 2003
+++ linux.21rc6-ac1-patched/arch/i386/kernel/pci-pc.c	Tue Jun  3 22:29:12 2003
@@ -1341,7 +1341,7 @@
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,	        pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8367_0,	pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_NCR,	PCI_DEVICE_ID_NCR_53C810,	pci_fixup_ncr53c810 },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_ANY_ID,			pci_fixup_transparent_bridge },
+/*	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_ANY_ID,			pci_fixup_transparent_bridge }, */
 	{ 0 }
 };

Here are the data from the corresponding [successful] boot:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/proc/iomem

00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000dc000-000dffff : Extension ROM
000f0000-000fffff : System ROM
00100000-27ceffff : System RAM
  00100000-0022aebe : Kernel code
  0022aebf-002a985f : Kernel data
27cf0000-27cfbfff : ACPI Tables
27cfc000-27cfffff : ACPI Non-volatile Storage
27d00000-27e7ffff : System RAM
e0000000-e007ffff : Intel Corp. 82830 CGC [Chipset Graphics Controller]
  e0000000-e007ffff : intelfb
e0080000-e00fffff : Intel Corp. 82830 CGC [Chipset Graphics Controller] (#2)
e0100000-e01003ff : Intel Corp. 82801CAM IDE U100
e0200000-e02fffff : PCI Bus #02
  e0200000-e0203fff : Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
  e0204000-e0204fff : Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller
    e0204000-e0204fff : eepro100
  e0205000-e02057ff : Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
    e0205000-e02057ff : ohci1394
  e0206000-e0206fff : Ricoh Co Ltd RL5c475
  e0207000-e0207fff : Texas Instruments PCI1410 PC card Cardbus Controller
  e0220000-e023ffff : PCI CardBus #03
  e0240000-e025ffff : PCI CardBus #03
  e0260000-e027ffff : PCI CardBus #07
  e0280000-e029ffff : PCI CardBus #07
e8000000-efffffff : Intel Corp. 82830 CGC [Chipset Graphics Controller]
  e8000000-efffffff : intelfb
f0000000-f7ffffff : Intel Corp. 82830 CGC [Chipset Graphics Controller] (#2)
fabfd000-fabfdfff : card services

lspci -vvxxx -s 2:b.0

02:0b.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Subsystem: Lucent Technologies: Unknown device ab01
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e0207000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: e0260000-e027f000 (prefetchable)
	Memory window 1: e0280000-e029f000
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 50 ac 07 00 10 02 01 00 07 06 08 a8 02 00
10: 00 70 20 e0 a0 00 00 02 02 07 0a b0 00 00 26 e0
20: 00 f0 27 e0 00 00 28 e0 00 f0 29 e0 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 40 05
40: a3 12 01 ab 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 60 b0 44 00 00 00 00 00 00 00 00 00 22 00 00 01
90: c0 00 60 61 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 11 fe 00 00 c0 00 0e 08 00 00 1b 00 00 00
b0: 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Some differences/points of note for the TI bridge:
a) Manfred Spraul's adaptive resource allocation is in effect
b) The CB_BRIDGE_CONTROL register's INTR bit changes value [offset 0x3e, bit 7]
c) I/O windows didnt get assigned after the patch

Also, my firewire DVD/CDRW drive, which lives behind the 82801 as well, works
fine both before and after the patch. I'd be happy to provide more
information.

Hmm.

Cheers,
Shashi
--
Shashi Rao, skrao@users.sourceforge.net
