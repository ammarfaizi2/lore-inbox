Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272305AbTHNKwZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 06:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272307AbTHNKwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 06:52:25 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:4873 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S272305AbTHNKwW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 06:52:22 -0400
Date: Thu, 14 Aug 2003 03:52:16 -0700
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: C99 Initialisers
Message-ID: <20030814105216.GA26892@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <3F3A9FA1.8000708@pobox.com> <Pine.GSO.4.21.0308141202410.12289-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0308141202410.12289-100000@vervain.sonytel.be>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message may contain content offensive to Atheists and servants of false gods.  Read at your own risk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 12:05:28PM +0200, Geert Uytterhoeven wrote:
> On Wed, 13 Aug 2003, Jeff Garzik wrote:
> > > On Wed, Aug 13, 2003 at 03:44:44PM -0400, Jeff Garzik wrote:
> > >>enums are easy  putting direct references would be annoying, but I also 
> > >>argue it's potentially broken and wrong to store and export that 
> > >>information publicly anyway.  The use of enums instead of pointers is 
> > >>practically required because there is a many-to-one relationship of ids 
> > >>to board information structs.
> > > 
> > > The hard part is that it's actually many-to-many.  The same card can have
> > > multiple drivers.  one driver can support many cards.
> > 
> > pci_device_tables are (and must be) at per-driver granularity.  Sure the 
> > same card can have multiple drivers, but that doesn't really matter in 
> > this context, simply because I/we cannot break that per-driver 
> > granularity.  Any solution must maintain per-driver granularity.
> 
> Aren't there any `hidden multi-function in single-function' PCI devices out
> there? E.g. cards with a serial and a parallel port?
> 
> At least for the Zorro bus, these exist. E.g. the Ariadne card contains both
> Ethernet and 2 parallel ports, so the Ariadne Ethernet driver and the (still to
> be written) Ariadne parallel port driver are both drivers for the same Zorro
> device.

I'm not sure but i think most of those look like multiple
pci devices rather than one device with multiple functions.
I've got an Initio 9520UW: One PCI card with two ini9x00 UW
SCSI HBAs sharing one interrupt and one EEPro100 on another
interrupt.  During scan it seems to me to be three devices
sitting behind a bridge.

This is on 2.4.18 so 2.6 may look a little different.

$ lspci -tvv
-[00]-+-00.0  Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
[snip +- a bunch of devices]
      \-0c.0-[02]--+-04.0  Initio Corporation 360P
                   +-08.0  Initio Corporation 360P
                   \-09.0  Intel Corp. 82557/8/9 [Ethernet Pro 100]

$ lspci -vv
[snip]
00:0c.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: de800000-dfffffff
        Prefetchable memory behind bridge: 00000000e2f00000-00000000e3e00000
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

02:04.0 SCSI storage controller: Initio Corporation 360P (rev 01)
        Subsystem: Unknown device 9292:0202
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at c800 [size=256]
        Region 1: Memory at df800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=32K]

02:08.0 SCSI storage controller: Initio Corporation 360P (rev 01)
        Subsystem: Unknown device 9292:0202
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at c400 [size=256]
        Region 1: Memory at df000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=32K]

02:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e3000000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at c000 [size=32]
        Region 2: Memory at de800000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
