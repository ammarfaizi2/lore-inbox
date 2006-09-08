Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWIHVlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWIHVlw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 17:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWIHVlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 17:41:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:5001 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751194AbWIHVlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 17:41:50 -0400
Subject: Re: TG3 data corruption (TSO ?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Chan <mchan@broadcom.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1551EAE59135BE47B544934E30FC4FC093FB19@NT-IRVA-0751.brcm.ad.broadcom.com>
References: <1551EAE59135BE47B544934E30FC4FC093FB19@NT-IRVA-0751.brcm.ad.broadcom.com>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 07:41:29 +1000
Message-Id: <1157751689.31071.97.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Please send me lspci and tg3 probing output so that I know what
> tg3 hardware you're using.  I also want to look at the tcpdump or
> ethereal on the mirrored port that shows the packet being corrupted.

Hi Michael !

It's the dual controller of an Apple Quad G5, thus afaik in an HT2000
chip:

0001:05:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5780 Gigabit Ethernet (rev 03)
        Subsystem: Apple Computer Inc. Unknown device 0085
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min)
        Interrupt: pin A routed to IRQ 66
        Region 0: Memory at fa530000 (64-bit, non-prefetchable) [size=64K]
        Region 2: Memory at fa520000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device
                Command: DPERE- ERO- RBC=512 OST=1
                Status: Dev=05:04.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=1 DMCRS=16 RSCEM- 266MHz- 533MHz-
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: Mask- 64bit+ Queue=0/3 Enable-
                Address: 00011aa5c8ce4904  Data: 18d8

0001:05:04.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5780 Gigabit Ethernet (rev 03)
        Subsystem: Apple Computer Inc. Unknown device 0085
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (16000ns min), Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 67
        Region 0: Memory at fa510000 (64-bit, non-prefetchable) [size=64K]
        Region 2: Memory at fa500000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device
                Command: DPERE- ERO+ RBC=512 OST=1
                Status: Dev=05:04.1 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=1 DMCRS=16 RSCEM- 266MHz- 533MHz-
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: Mask- 64bit+ Queue=0/3 Enable-
                Address: 4e001a0002804460  Data: 00a2

And the dmesg bits:

tg3.c:v3.65 (August 07, 2006)
eth0: Tigon3 [partno(BCM95780) rev 8003 PHY(5780)] (PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:14:51:65:e6:90
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
eth0: dma_rwctrl[76144000] dma_mask[40-bit]
eth1: Tigon3 [partno(BCM95780) rev 8003 PHY(5780)] (PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:14:51:65:e6:91
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
eth1: dma_rwctrl[76144000] dma_mask[40-bit]

As for the tcpdump output, well, I have a 3Gb file for now :) I need to do a bit of surgery on it to
get only the interesting part. I'll try to do that later today (but it may have to wait for monday).

Cheers,
Ben.


