Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272921AbTHFW1l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 18:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272923AbTHFW1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 18:27:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51468 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272921AbTHFW1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 18:27:38 -0400
Date: Wed, 6 Aug 2003 23:27:35 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Cardbus suspend/resume of 3ccfe575bt card fails
Message-ID: <20030806232735.I16116@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi akpm,

Yes, I should've reported this sooner.

2.4 and 2.6 kernels exhibit the same problem - upon resume, the card
indicates that it has a 10base link to the hub, but the hub indicates
it has a 100base link.  No traffic is possible.

Unplugging and replugging the card restores the link correctly (100base).

The following is from 2.6.0-test2:

0000:05:00.0: 3Com PCI 3CCFE575BT Cyclone CardBus at 0x1800. Vers LK1.1.19

Before suspend, mii-diag reports:

Basic registers of MII PHY #0:  3000 282d 0300 e54b 00a1 45e1 0001 0000.
 The autonegotiated capability is 00a0.
The autonegotiated media type is 100baseTx.
 Basic mode control register 0x3000: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
 Your link partner advertised 45e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT, w/ 802.3X flow control.
   End of basic transceiver information.

After resume, it reports:

Basic registers of MII PHY #0:  ffff ffff ffff ffff ffff ffff ffff ffff.
  No MII transceiver present!.

I suspect this may be caused by the device not being restored correctly:

05:00.0 Class 0200: 10b7:5157 (rev 01)
        Subsystem: 10b7:5b57
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 1800 [disabled] [size=128]
        Region 1: [virtual] Memory at 10c00000 (32-bit, non-prefetchable) [disabled] [size=128]
        Region 2: [virtual] Memory at 10c00080 (32-bit, non-prefetchable) [disabled] [size=128]
        Expansion ROM at 10800000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

It looks like 3c59x only saves the PCI config space and restores it if
you have WOL enabled - this is obviously wrong if you're suspending/
resuming a CardBus device.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

