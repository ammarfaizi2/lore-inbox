Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267212AbUHRDfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267212AbUHRDfJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 23:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267230AbUHRDfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 23:35:09 -0400
Received: from ms0.nttdata.co.jp ([163.135.193.231]:23479 "EHLO
	ms0.nttdata.co.jp") by vger.kernel.org with ESMTP id S267212AbUHRDex
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 23:34:53 -0400
To: davem@redhat.com, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Cc: dev_null@anet.ne.jp
Reply-To: dev_null@anet.ne.jp
Subject: Re: TG3 doesn't work in kernel 2.4.27 (Resolved!)
From: Tetsuo Handa <bs-handa@bs.rd.nttdata.co.jp>
References: <20040817110002.32088.38168.Mailman@linux.us.dell.com>
	<200408172129.AJH50391.692B5188@anet.ne.jp>
	<20040817110248.4c2f7cd8.davem@redhat.com>
In-Reply-To: <20040817110248.4c2f7cd8.davem@redhat.com>
Message-Id: <200408181233.FDJ97547.BOBCTItE@bs.rd.nttdata.co.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Wed, 18 Aug 2004 12:34:36 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, David.

In message <20040817110248.4c2f7cd8.davem@redhat.com>
   "Re: TG3 doesn't work in kernel 2.4.27"
   ""David S. Miller" <davem@redhat.com>" wrote:

> On Tue, 17 Aug 2004 21:30:06 +0900
> Tetsuo Handa <a5497108@anet.ne.jp> wrote:
> 
> > I compiled as a UP kernel but it wasn't the cause.
> > Also, I patched the above fix on 2.4.27-rc4 and
> > compiled as a UP kernel, but didn't work.
> 
> Just add this patch, it will fix the problem but it
> is not the nicest fix.  I'll work on a better one.
> 
> It just disables the new Sun code, and uses the old
> fiber handling for 5704.
> 
It resolved the problem. It works on SMP kernel, too.
The line position was different for tg3.c in 2.4.27 .

-----START-----
--- tg3.c.org	2004-08-08 08:26:05.000000000 +0900
+++ tg3.c	2004-08-18 09:27:58.000000000 +0900
@@ -5264,7 +5264,7 @@
 	 * is enabled.
 	 */
 	tw32_f(MAC_LOW_WMARK_MAX_RX_FRAME, 2);
-
+#if 0
 	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5704 &&
 	    tp->phy_id == PHY_ID_SERDES) {
 		/* Enable hardware link auto-negotiation */
@@ -5284,7 +5284,7 @@
 
 		tp->tg3_flags2 |= TG3_FLG2_HW_AUTONEG;
 	}
-
+#endif
 	err = tg3_setup_phy(tp, 1);
 	if (err)
 		return err;
-----END-----

Also, as you have mentioned that this bug can only affect 5704 chips with fiber interfaces,
I found that the box has BCM5704S. The following is the result of 'lspci -vv'.

-----START-----
00:00.0 Host bridge: ServerWorks CNB20-HE Host Bridge (rev 33)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.1 Host bridge: ServerWorks CNB20-HE Host Bridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 Host bridge: ServerWorks CNB20-HE Host Bridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 0240
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 2200 [size=256]
	Region 2: Memory at febff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Host bridge: ServerWorks CSB6 South Bridge (rev b0)
	Subsystem: ServerWorks: Unknown device 0201
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64

00:0f.1 IDE interface: ServerWorks CSB6 RAID/IDE Controller (rev b0) (prog-if 8a [Master SecP PriP])
	Subsystem: ServerWorks: Unknown device 0212
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at 0700 [size=16]

00:0f.2 USB Controller: ServerWorks CSB6 OHCI USB Controller (rev 05) (prog-if 10 [OHCI])
	Subsystem: ServerWorks: Unknown device 0220
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at febfe000 (32-bit, non-prefetchable) [size=4K]

00:0f.3 ISA bridge: ServerWorks GCLE-2 Host Bridge
	Subsystem: ServerWorks: Unknown device 0230
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:10.0 Host bridge: ServerWorks: Unknown device 0110 (rev 12)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Capabilities: [60] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=4
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
00:10.2 Host bridge: ServerWorks: Unknown device 0110 (rev 12)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Capabilities: [60] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=4
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
01:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704S Gigabit Ethernet (rev 02)
	Subsystem: IBM: Unknown device 029c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fbff0000 (64-bit, non-prefetchable) [size=64K]
	Region 2: Memory at fbfe0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=2 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: 0000000100000000  Data: c065

01:00.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704S Gigabit Ethernet (rev 02)
	Subsystem: IBM: Unknown device 029c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), cache line size 08
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at fbfd0000 (64-bit, non-prefetchable) [size=64K]
	Region 2: Memory at fbfc0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=2 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: 0000000100000000  Data: bef5

02:02.0 Fibre Channel: QLogic Corp. QLA2312 Fibre Channel Adapter (rev 02)
	Subsystem: IBM: Unknown device 027d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 2400 [size=256]
	Region 1: Memory at f9ffe000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [4c] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=2
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-	Capabilities: [54] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [64] #06 [0080]

02:02.1 Fibre Channel: QLogic Corp. QLA2312 Fibre Channel Adapter (rev 02)
	Subsystem: IBM: Unknown device 027d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), cache line size 08
	Interrupt: pin B routed to IRQ 19
	Region 0: I/O ports at 2600 [size=256]
	Region 1: Memory at f9ffc000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [4c] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=2
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-	Capabilities: [54] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [64] #06 [0080]

-----END-----

Thank you very much.
-----
Tetsuo Handa
