Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751780AbWBWW36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbWBWW36 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 17:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWBWW36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 17:29:58 -0500
Received: from fmr20.intel.com ([134.134.136.19]:55953 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751780AbWBWW35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 17:29:57 -0500
Subject: Re: [patch 0/3] New dock patches
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, greg@kroah.com,
       len.brown@intel.com, muneda.takahiro@jp.fujitsu.com
In-Reply-To: <20060223210525.GA1735@elf.ucw.cz>
References: <1140636081.32574.18.camel@whizzy>
	 <20060223210525.GA1735@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 14:35:05 -0800
Message-Id: <1140734105.11750.41.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 23 Feb 2006 22:29:46.0099 (UTC) FILETIME=[A6480430:01C638C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 22:05 +0100, Pavel Machek wrote:
> Hi!
> 
> > Hello, this is a new set of docking station patches which replaces
> > the old docking station patches.  It applies to 2.6.16-rc4-mm1.  It
> > is new and improved over the old version, in that it can now handle
> > laptops which define docking stations outside of the scope of PCI.
> > 
> > Thanks to everyone who provided feedback on the original patches, and
> > especially to Pavel who is the only brave soul to test these patches
> > out so far :).  As always, I would appreciate feedback on these 
> > patches.
> 
> I tested the new version from today... it works okay. It produces some
> weird messages:
> 
> acpiphp: Slot [4294967295] registered
> ACPI Exception (acpi_bus-0072): AE_NOT_FOUND, No context for object
> [c1d081e8] [20060210]
> PCI: Found IBM Dock II Cardbus Bridge applying quirk
> PCI: Found IBM Dock II Cardbus Bridge applying quirk
> PCI: Transparent bridge - 0000:02:03.0
> PCI: Bus #0c (-#0f) is hidden behind transparent bridge #02 (-#0b)
> Please report the result to linux-kernel to fix this permanently
> PCI: Bus #10 (-#13) is hidden behind transparent bridge #02 (-#0b)
> Please report the result to linux-kernel to fix this permanently
> ACPI Exception (acpi_bus-0072): AE_NOT_FOUND, No context for object
> [c1d02368] [20060210]
> 

The ACPI exceptions are ok, it just means that we are looking for an
object that doesn't exist yet - which is expected since we are
hotplugging it.  The PCI warnings I also get on my system - but I think
they are not relevant, because if I look at lspci after docking, the bus
numbers for the dock bridge do not hide the new cardbus bus numbers - I
think the subordinate bus numbers for the parent bus are fixed up after
this message.  Can you send your lspci -vv output so we can make sure
that your bridge bus number is being done correctly?  I also assume you
are still using pci=assign-busses as well.

Here's my error message:

[  262.092000] PCI: Bus #0c (-#0f) is hidden behind transparent bridge #02 (-#0b) 
[  262.092000] PCI: Bus #10 (-#13) is hidden behind transparent bridge #02 (-#0b) 

But then, the output of lspci after docking shows the bus numbers are ok:

***** Dock Bridge's Parent - Note subordinate bus number *****

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 81) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=13, sec-latency=64
	I/O behind bridge: 00004000-00008fff
	Memory behind bridge: c0200000-cfffffff
	Prefetchable memory behind bridge: e8000000-efffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-


**** Dock Bridge + new cardbus controllers on dock station ******

0000:02:03.0 PCI bridge: Texas Instruments PCI2032 PCI Docking Bridge (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=02, secondary=0b, subordinate=13, sec-latency=64
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: ca000000-ceffffff
	Prefetchable memory behind bridge: c6000000-c9ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

0000:0b:02.0 CardBus bridge: Texas Instruments PCI1420
	Subsystem: IBM: Unknown device 0148
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x20 (128 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ce000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=0b, secondary=0c, subordinate=0f, sec-latency=176
	Memory window 0: c6000000-c7fff000 (prefetchable)
	Memory window 1: ca000000-cbfff000
	I/O window 0: 00005000-000050ff
	I/O window 1: 00005400-000054ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

0000:0b:02.1 CardBus bridge: Texas Instruments PCI1420
	Subsystem: IBM: Unknown device 0148
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x20 (128 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ce001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=0b, secondary=10, subordinate=13, sec-latency=176
	Memory window 0: c8000000-c9fff000 (prefetchable)
	Memory window 1: cc000000-cdfff000
	I/O window 0: 00005800-000058ff
	I/O window 1: 00005c00-00005cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:0c:00.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 09)
	Subsystem: Intel Corp. EtherExpress PRO/100 Cardbus
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ca020000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Region 1: I/O ports at 5000 [disabled] [size=64]
	Region 2: Memory at ca000000 (32-bit, non-prefetchable) [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-


