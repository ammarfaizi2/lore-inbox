Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267578AbUH2J5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267578AbUH2J5V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 05:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267587AbUH2J5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 05:57:21 -0400
Received: from ee.oulu.fi ([130.231.61.23]:10900 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S267578AbUH2J5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 05:57:18 -0400
Date: Sun, 29 Aug 2004 12:56:58 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: "David S. Miller" <davem@redhat.com>
Cc: Brian Somers <brian.somers@sun.com>, Michael.Waychison@sun.com,
       linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
Message-ID: <20040829095657.GA22755@ee.oulu.fi>
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com> <200408162049.FFF09413.8592816B@anet.ne.jp> <20040816143824.15238e42.davem@redhat.com> <412CD101.4050406@sun.com> <20040825120831.55a20c57.davem@redhat.com> <412CF0E9.2010903@sun.com> <20040825175805.6807014c.davem@redhat.com> <412DC055.4070401@sun.com> <20040826123730.375ce5d2.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20040826123730.375ce5d2.davem@redhat.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 12:37:30PM -0700, David S. Miller wrote:
> On Thu, 26 Aug 2004 11:49:57 +0100
> Brian Somers <brian.somers@sun.com> wrote:
> 
> > Can we get this guy to try running an older version of tg3 to see
> > what change introduce the issue?
> 
> Brian, we already narrowed it down to exactly the hw autoneg
> changes Sun wrote.  It breaks the IBM blades onboard 5704
> fibre chips.  Reverting your change or disabling hw autoneg
> in the new code both fix the problem.
Just another datapoint, an IBM blade with

01:00.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704S Gigabit
Ethernet (rev 02)

01:00.1 Class 0200: 14e4:16a8 (rev 02)
        Subsystem: 1014:029c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), Cache Line Size 08
        Interrupt: pin B routed to IRQ 185
        Region 0: Memory at fbfd0000 (64-bit, non-prefetchable)
        Region 2: Memory at fbfc0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=2 OST=0
                Status: Bus=1 Dev=0 Func=1 64bit+ 133MHz+ SCD- USC-,
DC=simple, DMMRBC=2, DMOST=0, DMCRS=1, RSCEM-
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3
Enable-
                Address: 0000000100000000  Data: 5900

doesn't work with the hw autoneg stuff in fc2's 2.6.8-1.521, #if 0
around the

        if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5704 &&
            tp->phy_id == PHY_ID_SERDES) {
                /* Enable hardware link auto-negotiation */
		...
	} 

makes it work. So it looks like a A2 vs. A3 (or
PCI_SUBSYSTEM_VENDOR_IBM ;) ) thing.

Btw., a ethtool workaround would be appreciated or is that even possible? I
tried ethtool -s eth1 speed 1000 duplex full port fibre autoneg off without
luck. But that was over a java-based VNC thing run remotely over SSH port
forwarding that gets keyboard mappings wrong, so I didn't spend too much
time playing around :-)

-- 
Pekka Pietikainen
