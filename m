Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbTHaOHs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 10:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbTHaOHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 10:07:13 -0400
Received: from imap.gmx.net ([213.165.64.20]:33748 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262027AbTHaOGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 10:06:18 -0400
Date: Sun, 31 Aug 2003 16:05:44 +0200
From: Sebastian Reichelt <SebastianR@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4.21] orinoco_cs card reinsertion
Message-Id: <20030831160544.2d342b72.SebastianR@gmx.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sun__31_Aug_2003_16:05:44_+0200_08258c08"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Sun__31_Aug_2003_16:05:44_+0200_08258c08
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello!

After switching from 2.4.20 to 2.4.21 (Debian unstable package
kernel-source-2.4.21-5), my wireless LAN PCMCIA card stopped working
when I hot-removed and reinserted it. I got these messages in
/var/log/syslog, plus a high beep on removal and a high and then a low
beep on reinsertion:

Upon removal:
Aug 29 16:00:41 SebastianL2 kernel: orinoco_lock() called with
hw_unavailable (dev=cf34b800)

Upon reinsertion:
Aug 29 16:00:44 SebastianL2 cardmgr[192]: socket 0: ZCOMAX
AirRunner/XI-300
Aug 29 16:00:44 SebastianL2 kernel: GetNextTuple(). No matching CIS
configuration, maybe you need the ignore_cis_vcc=1 parameter.
Aug 29 16:00:44 SebastianL2 kernel: orinoco_cs: GetFirstTuple: No more
items
Aug 29 16:00:45 SebastianL2 cardmgr[192]: get dev info on socket 0
failed: Resource temporarily unavailable

I looked at the changes between the two kernels, in orinoco.c,
orinoco_cs.c, and hermes.c, and it seems that quite a bit of code was
restructured. So unfortunately, I cannot narrow it down to a single
change that caused this. The attached patch fixes the problem for me,
but it is NOT a simple copy from the old driver, and it may not be
correct at all. However, it might give someone a hint about what went
wrong. Anyway, even with this patch, I still get the "orinoco_lock()
called with hw_unavailable" message when I remove the card.

Sorry if I'm posting a patch for a problem that has already been fixed
in 2.4.22. The Debian package is still at 2.4.21, and I don't know
anything about the Debian patches and why they are needed, etc. If I can
just install a kernel from kernel.org, I will do this, and try to see if
the problem is still there (I can see an item "orinoco driver update"
in the changelog, but it's not specific). Should I also install a 2.6
kernel and check?

I have attached the output of lspci -vvv and the parts of the syslog
that identify my card and show the problem. The controller is this entry
in lspci.txt:
00:08.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller

Here is the output of ver_linux:

------------------------------------------------------------------------
Linux SebastianL2 2.4.21 #1 Sat Aug 30 00:22:04 CEST 2003 i686 GNU/Linux
 
Gnu C                  3.3.2
Gnu make               3.80
binutils               2.14.90.0.5
util-linux             2.11z
mount                  2.11z
modutils               0.9.13
e2fsprogs              1.35-WIP
pcmcia-cs              3.2.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.11
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.90
------------------------------------------------------------------------

Hopefully someone can find the true cause of the problem. Good luck.

-- 
Sebastian Reichelt

--Multipart_Sun__31_Aug_2003_16:05:44_+0200_08258c08
Content-Type: text/plain;
 name="orinoco_cs.diff"
Content-Disposition: attachment;
 filename="orinoco_cs.diff"
Content-Transfer-Encoding: 7bit

--- drivers/net/wireless/orinoco_cs.c.orig	2003-08-30 00:19:04.000000000 +0200
+++ drivers/net/wireless/orinoco_cs.c	2003-08-30 00:19:39.000000000 +0200
@@ -597,8 +597,8 @@
 
 			orinoco_unlock(priv, &flags);
 
-/*  			if (link->open) */
-/*  				orinoco_cs_stop(dev); */
+			if (dev->stop)
+				dev->stop(dev);
 
 			mod_timer(&link->release, jiffies + HZ / 20);
 		}

--Multipart_Sun__31_Aug_2003_16:05:44_+0200_08258c08
Content-Type: text/plain;
 name="lspci.txt"
Content-Disposition: attachment;
 filename="lspci.txt"
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 80)
	Subsystem: Uniwill Computer Corp: Unknown device 8100
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dfd00000-dfefffff
	Prefetchable memory behind bridge: cfb00000-dfbfffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
	Subsystem: Uniwill Computer Corp: Unknown device 3000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:10.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: Unknown device 8415:8200
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at dffff800 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at ec00 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8231 [PCI-to-ISA Bridge] (rev 10)
	Subsystem: Uniwill Computer Corp: Unknown device 8100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Uniwill Computer Corp: Unknown device 8235
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at fc00 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1e) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1e) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.4 Bridge: VIA Technologies, Inc. VT8235 ACPI (rev 10)
	Subsystem: Uniwill Computer Corp: Unknown device 8235
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 40)
	Subsystem: Uniwill Computer Corp: Unknown device 8100
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at e400 [size=256]
	Region 1: I/O ports at e000 [size=4]
	Region 2: I/O ports at dc00 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97 Modem] (rev 20)
	Subsystem: Uniwill Computer Corp: Unknown device 4005
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at e800 [size=256]
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 51)
	Subsystem: Uniwill Computer Corp: Unknown device 8100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at d000 [size=256]
	Region 1: Memory at dffff700 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: S3 Inc. VT8636A [ProSavage KN133] AGP4X VGA Controller (TwisterK) (rev 01) (prog-if 00 [VGA])
	Subsystem: Uniwill Computer Corp: Unknown device 8003
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at dfe80000 (32-bit, non-prefetchable) [size=512K]
	Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at dfe70000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x4


--Multipart_Sun__31_Aug_2003_16:05:44_+0200_08258c08
Content-Type: text/plain;
 name="syslog.txt"
Content-Disposition: attachment;
 filename="syslog.txt"
Content-Transfer-Encoding: 7bit

Aug 29 15:58:07 SebastianL2 kernel: Linux Kernel Card Services 3.1.22
Aug 29 15:58:07 SebastianL2 kernel:   options:  [pci] [cardbus] [pm]
Aug 29 15:58:07 SebastianL2 kernel: PCI: Assigned IRQ 9 for device 00:08.0
Aug 29 15:58:07 SebastianL2 kernel: orinoco.c 0.13b (David Gibson <hermes@gibson.dropbear.id.au> and others)
Aug 29 15:58:07 SebastianL2 kernel: hermes.c: 4 Dec 2002 David Gibson <hermes@gibson.dropbear.id.au>
Aug 29 15:58:07 SebastianL2 kernel: orinoco_cs.c 0.13b (David Gibson <hermes@gibson.dropbear.id.au> and others)
Aug 29 15:58:07 SebastianL2 kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Aug 29 15:58:07 SebastianL2 kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Aug 29 15:58:07 SebastianL2 kernel: TCP: Hash tables configured (established 16384 bind 32768)
Aug 29 15:58:07 SebastianL2 kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Aug 29 15:58:07 SebastianL2 kernel: Yenta IRQ list 0820, PCI irq9
Aug 29 15:58:07 SebastianL2 kernel: Socket status: 30000411
Aug 29 15:58:07 SebastianL2 kernel: VFS: Mounted root (ext2 filesystem) readonly.
Aug 29 15:58:07 SebastianL2 kernel: Freeing unused kernel memory: 76k freed
Aug 29 15:58:07 SebastianL2 kernel: Adding Swap: 248968k swap-space (priority -1)
Aug 29 15:58:07 SebastianL2 cardmgr[191]: cannot access /lib/modules/2.4.21: No such file or directory
Aug 29 15:58:07 SebastianL2 cardmgr[191]: watching 1 sockets
Aug 29 15:58:07 SebastianL2 kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Aug 29 15:58:07 SebastianL2 kernel: cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x87f
Aug 29 15:58:07 SebastianL2 kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x400-0x40f 0x4d0-0x4d7
Aug 29 15:58:07 SebastianL2 cardmgr[192]: starting, version is 3.2.2
Aug 29 15:58:07 SebastianL2 kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Aug 29 15:58:07 SebastianL2 cardmgr[192]: socket 0: ZCOMAX AirRunner/XI-300
Aug 29 15:58:08 SebastianL2 kernel: eth1: Station identity 001f:0003:0000:0008
Aug 29 15:58:08 SebastianL2 kernel: eth1: Looks like an Intersil firmware version 0.8.3
Aug 29 15:58:08 SebastianL2 kernel: eth1: Ad-hoc demo mode supported
Aug 29 15:58:08 SebastianL2 kernel: eth1: IEEE standard IBSS ad-hoc mode supported
Aug 29 15:58:08 SebastianL2 kernel: eth1: WEP supported, 104-bit key
Aug 29 15:58:08 SebastianL2 kernel: eth1: MAC address 00:00:CB:06:01:B4
Aug 29 15:58:08 SebastianL2 kernel: eth1: Station name "Prism  I"
Aug 29 15:58:08 SebastianL2 kernel: eth1: ready
Aug 29 15:58:08 SebastianL2 kernel: eth1: index 0x01: Vcc 5.0, irq 5, io 0x0100-0x013f
Aug 29 15:58:08 SebastianL2 cardmgr[192]: executing: './network start eth1'
Aug 29 15:58:08 SebastianL2 kernel: eth1: Error -110 setting multicast list.
Aug 29 15:58:08 SebastianL2 last message repeated 2 times
Aug 29 15:58:08 SebastianL2 kernel: eth1: New link status: Connected (0001)
[...]
Aug 29 16:00:41 SebastianL2 kernel: orinoco_lock() called with hw_unavailable (dev=cf34b800)
Aug 29 16:00:41 SebastianL2 cardmgr[192]: executing: './network stop eth1'
[...]
Aug 29 16:00:44 SebastianL2 cardmgr[192]: socket 0: ZCOMAX AirRunner/XI-300
Aug 29 16:00:44 SebastianL2 kernel: GetNextTuple().  No matching CIS configuration, maybe you need the ignore_cis_vcc=1 parameter.
Aug 29 16:00:44 SebastianL2 kernel: orinoco_cs: GetFirstTuple: No more items
Aug 29 16:00:45 SebastianL2 cardmgr[192]: get dev info on socket 0 failed: Resource temporarily unavailable

--Multipart_Sun__31_Aug_2003_16:05:44_+0200_08258c08--
