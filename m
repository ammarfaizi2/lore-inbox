Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSFRAkd>; Mon, 17 Jun 2002 20:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317201AbSFRAkc>; Mon, 17 Jun 2002 20:40:32 -0400
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:42932 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S317194AbSFRAkb>; Mon, 17 Jun 2002 20:40:31 -0400
Date: Tue, 18 Jun 2002 02:40:32 +0200
From: Andreas Bombe <bombe@informatik.tu-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: Problems with hardwired yenta resource allocation
Message-ID: <20020618024032.A4230@sunhalle103.informatik.tu-muenchen.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Resend, sorry if it gets through twice.]

The playground: Siemens laptops with two PCMCIA slots and an interesting
configuration of PCI buses (the CardBus bridge is itself behind a PCI
bridge) which amounts to three buses including the graphics controller's
AGP bus, five including the CardBuses.

The situation: No CardBus cards work with the yenta driver.  I don't
have the laptops at hand, and the guy who works with those is likely now
in Japan for the RoboCup (yeah, I had this bug report lying around for a
while, so what).  There should be enough information here to work with.

The problem: In yenta.c:yenta_allocate_res(), since the yenta is itself
behind a PCI bridge, it has to allocate window resources from the range
the PCI bridge has allocated for its own windows:

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 41) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=04, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: d0200000-d02fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

There is also an Realtek Ethernet controller on the same bus as the
yenta.  Now the hardwired values for yenta window resources are:

Mem: min=PCIBIOS_MIN_MEM; max=~0U; align=4MB; size=4MB;
I/O: min=0x4000; max=0xffff; align=1kB; size=256;

The minimum for the I/O region is just over the end of the bridge region.
No I/O window resources can be allocated.

For memory it wants 4MB at 4MB alignment.  There only is 1MB behind the
bridge which is 2MB aligned, from which the Realtek grabbed 256 bytes
already.  Obvious problem here, no mem window resources can be
allocated.


I adjusted the requirements down to make an FireWire OHCI CardBus card
work (which uses 2kB mem, 128B I/O and 256B mem) using these values:

Mem: align = size = 128kB
I/O: min = 0x3000

That configuration works now.  I'm not sure what the right fix to this
is (more liberal constants or dynamic adaption to current situation,
maybe even allocating windows only as needed), I don't know what the
granularity for window resources are anyway.  This particular chip is:

02:0a.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 02)
        Subsystem: Citicorp TTI: Unknown device 10e6
	
-- 
Andreas Bombe <bombe@informatik.tu-muenchen.de>    DSA key 0x04880A44
