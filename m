Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbVLBXym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVLBXym (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 18:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVLBXym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 18:54:42 -0500
Received: from web50103.mail.yahoo.com ([206.190.38.31]:40787 "HELO
	web50103.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751072AbVLBXyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 18:54:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=OgikF1EHTNg6Px3n0T/it23ZRP7n5OcGHxVTKsZGUq+Mgev7+KPuNo3eZr+kQ2wL4WiLvCRuO/evwT2eDWuNVS9RWu9zW6TKOTu/M5ELGzgS2oq+NBmOsxkpY4eyzo0DlGivHnQwuC/Lr9rxWUejfMCfgr2YKS9gebkR9Xiadao=  ;
Message-ID: <20051202235440.28853.qmail@web50103.mail.yahoo.com>
Date: Fri, 2 Dec 2005 15:54:40 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: PCI-Bridge Parity Error on nVidia, 2.6.15-rc3-mm1
To: ebuddington@wesleyan.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20051202160928.GA10662@pool-71-161-133-232.spfdma.east.verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message originates in the new 'edac' module in the -mm tree.

EDAC is poll scanning the PCI devices peeking in their STATUS registers and bridges' SEC_STATUS
registers looking for PCI bus parity and SERR errors.

The aim of this polling is to provide a detector of PCI bus transactions that generate a parity
error or other serious error.

When SERR and Parity status bits are set, the parity occurred in the Address phase of the bus
transaction. If only the Parity bit is set, then the error was in the data phase. In either case,
some data was lost in the transaction. If just the SERR is set, then some board has determined a
very serious error has occurred. 

The Caveat is that NOT ALL BOARDS follow the PCI spec. Some board vendors have ignored the Parity
status generatioin, because there have been no "enforcers" of PCI Parity events, either in the
linux world and in the windoze world. This lack of conformance on the part of board vendors brings
some grief to the use of EDAC.

Was the error a valid error?

Or was the error a result of bad board?

this can be hard to tell.

The PCI Parity bits are sticky. They stay set until explicitly reset. At least that is the
standard. EDAC reset the bits after harvesting them.

I am working on a patch to the EDAC module to add a "whitelist" and a "blacklist" interfaces. The
'whitelist' specifies an explicit list of devices to scan for the parity error. The 'blacklist' is
the list of devices to skip in the scan of all PCI devices.

This will provide mechanism to EDAC on how to do the scanning. The next issue is to decide for a
given system, whether to enable PCI Parity scanning at all, use a whitelist or use a blacklist. 

You will have to decide.  EDAC is simply a detector or reporter of what is happening, at this
time. The error may or may not be valid. If you are having some other errors that are
unexplainable, then EDAC is a second witness as to the cause of those troubles.

You can turn off the PCI scanning by the following:

echo 0 > /sys/module/edac_mc/parameters/check_pci_parity

But from your report, EDAC is correctly reporting something bad is happening on your system. 

Try different cables to your 1394 disks (I assume your disks on on the 1394).

After re-reading your report, I see you indicate that output occurs on boot up. Do you see the
PCI-Bridge Parity AFTER bootup?

If not, then the FIRST output is an initialization remenant artifact. One of the  fixes will be to
consume that artifact. Therefore, ignore the singleton Parity report.

If there are more after boot up, then there is a bad board or false positives.

doug thompson




--- Eric Buddington <ebuddington@verizon.net> wrote:

> I am consistently seeing "PCI-Bridge- Detected Parity Error on
> 0000:00:09.0 0000:00:09.0" in dmesg on bootup. If I cat /dev/dv1394-0
> > /dev/null (with DV coming in), it generates a whole lot more.
> 
> Other, possibly related problems:
> 
> 1) After cat runs for a while, I get "dv1394: discontinuity detected,
> dropping all frames"
> 2) heavy hard drive usage tends to freeze processes permanently in D
> state. Sometimes a strace of 'sync' shows that sync() never returns,
> even if no other process is stuck in D state yet. I'm using
> netconsole, and no messages show up in conjunction with
> this. Alt-SysRq-b seems to be the only way out.
> 
> System specs:
> - Athlon-64X2, Foxconn mainboard.
> - Linux turkey 2.6.15-rc3-mm1 #3 SMP PREEMPT Thu Dec 1 19:59:31 EST 2005 i686 unknown unknown
> GNU/Linux, no other patches. Problem also observed on 2.4.14-mm1.
> - root fs is reiser4 on md0 (2x250Gb, striped).
> 
> lspci -vv:
> 00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
> 	Subsystem: Foxconn International, Inc. Unknown device 0ca4
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Capabilities: [44] HyperTransport: Slave or Primary Interface
> 		Command: BaseUnitID=0 UnitCnt=15 MastHost- DefDir- DUL-
> 		Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
> 		Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
> 		Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
> 		Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
> 		Revision ID: 1.03
> 		Link Frequency 0: 800MHz
> 		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
> 		Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 500MHz+ 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz-
> 1.4GHz- 1.6GHz- Vend-
> 		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
> 		Link Frequency 1: 200MHz
> 		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
> 		Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz-
> 1.4GHz- 1.6GHz- Vend-
> 		Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE-
> RNFE- CRCNFE- SERRNFE-
> 		Prefetchable memory behind bridge Upper: 00-00
> 		Bus Number: 00
> 	Capabilities: [e0] HyperTransport: MSI Mapping
> 
> 00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
> 	Subsystem: Foxconn International, Inc. Unknown device 0ca4
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 
> 00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
> 	Subsystem: Foxconn International, Inc. Unknown device 0ca4
> 	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: I/O ports at fc00 [size=32]
> 	Region 4: I/O ports at 4c00 [size=64]
> 	Region 5: I/O ports at 4c40 [size=64]
> 	Capabilities: [44] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2) (prog-if 10 [OHCI])
> 	Subsystem: Foxconn International, Inc. Unknown device 0ca4
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0 (750ns min, 250ns max)
> 	Interrupt: pin A routed to IRQ 225
> 	Region 0: Memory at dffff000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [44] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3) (prog-if 20 [EHCI])
> 	Subsystem: Foxconn International, Inc. Unknown device 0ca4
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0 (750ns min, 250ns max)
> 	Interrupt: pin B routed to IRQ 217
> 	Region 0: Memory at feb00000 (32-bit, non-prefetchable) [size=256]
> 	Capabilities: [44] Debug port
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio Controller (rev a2)
> 	Subsystem: Foxconn International, Inc. Unknown device 0ca4
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0 (500ns min, 1250ns max)
> 	Interrupt: pin A routed to IRQ 3
> 	Region 0: I/O ports at f000 [size=256]
> 	Region 1: I/O ports at ec00 [size=256]
> 	Region 2: Memory at dfffd000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [44] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2) (prog-if 8a [Master SecP PriP])
> 	Subsystem: Foxconn International, Inc. Unknown device 0ca4
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0 (750ns min, 250ns max)
> 	Region 4: I/O ports at e000 [size=16]
> 	Capabilities: [44] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3) (prog-if 85
> [Master SecO PriO])
> 	Subsystem: Foxconn International, Inc. Unknown device 0ca4
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0 (750ns min, 250ns max)
> 	Interrupt: pin A routed to IRQ 201
> 	Region 0: I/O ports at 09f0 [size=8]
> 	Region 1: I/O ports at 0bf0 [size=4]
> 	Region 2: I/O ports at 0970 [size=8]
> 	Region 3: I/O ports at 0b70 [size=4]
> 	Region 4: I/O ports at cc00 [size=16]
> 	Region 5: Memory at dfffb000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [44] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3) (prog-if 85
> [Master SecO PriO])
> 	Subsystem: Foxconn International, Inc. Unknown device 0ca4
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0 (750ns min, 250ns max)
> 	Interrupt: pin A routed to IRQ 209
> 	Region 0: I/O ports at 09e0 [size=8]
> 	Region 1: I/O ports at 0be0 [size=4]
> 	Region 2: I/O ports at 0960 [size=8]
> 	Region 3: I/O ports at 0b60 [size=4]
> 	Region 4: I/O ports at b800 [size=16]
> 	Region 5: Memory at dfffa000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [44] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2) (prog-if 01 [Subtractive
> decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
> 	I/O behind bridge: 0000a000-0000afff
> 	Memory behind bridge: dd000000-deffffff
> 	Prefetchable memory behind bridge: dfe00000-dfefffff
> 	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR-
> <PERR-
> 	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
> 
> 00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
> 	Subsystem: Foxconn International, Inc. Unknown device 0ca4
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0 (250ns min, 5000ns max)
> 	Interrupt: pin A routed to IRQ 201
> 	Region 0: Memory at dfff9000 (32-bit, non-prefetchable) [size=4K]
> 	Region 1: I/O ports at b400 [size=8]
> 	Capabilities: [44] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
> 
> 00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0, Cache Line Size 08
> 	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
> 	I/O behind bridge: 00009000-00009fff
> 	Memory behind bridge: dfd00000-dfdfffff
> 	Prefetchable memory behind bridge: 00000000dfc00000-00000000dfc00000
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> 	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
> 	Capabilities: [40] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
> 		Address: 00000000fee00000  Data: 40b9
> 	Capabilities: [58] HyperTransport: MSI Mapping
> 	Capabilities: [80] Express Root Port (Slot+) IRQ 0
> 		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
> 		Device: Latency L0s <512ns, L1 <4us
> 		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
> 		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
> 		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 1
> 		Link: Latency L0s <512ns, L1 <4us
> 		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
> 		Link: Speed 2.5Gb/s, Width x1
> 		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
> 		Slot: Number 2, PowerLimit 10.000000
> 		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> 		Slot: AttnInd Off, PwrInd On, Power-
> 
=== message truncated ===



"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

