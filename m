Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVBTA7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVBTA7i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 19:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVBTA7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 19:59:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:31398 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262333AbVBTA7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 19:59:33 -0500
Date: Sat, 19 Feb 2005 16:59:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>
Subject: Re: IBM Thinkpad G41 PCMCIA problems [Was: Yenta TI: ... no PCI
 interrupts. Fish. Please report.]
In-Reply-To: <1108858971.8413.147.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0502191648110.14176@ppc970.osdl.org>
References: <1108858971.8413.147.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 Feb 2005, Steven Rostedt wrote:
> 
> 0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 81) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
>         Latency: 0
>         Bus: primary=00, secondary=02, subordinate=08, sec-latency=168
>         I/O behind bridge: 00003000-00006fff
>         Memory behind bridge: c2000000-cfffffff
>         Prefetchable memory behind bridge: f0000000-f7ffffff
>         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

This is the bridge that your cardbus controller is behind:

> 0000:02:01.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus Controller (rev 01)
>         Subsystem: IBM ThinkPad T30/T40
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 168, Cache Line Size: 0x20 (128 bytes)
>         Interrupt: pin A routed to IRQ 177
>         Region 0: Memory at 3fefb000 (32-bit, non-prefetchable) [size=4K]
>         Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
>         Memory window 0: 40000000-403ff000 (prefetchable)
>         Memory window 1: 40400000-407ff000
>         I/O window 0: 00004000-000040ff
>         I/O window 1: 00004400-000044ff
>         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
>         16-bit legacy interface ports at 0001
> 
> 0000:02:01.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus Controller (rev 01)
>         Subsystem: IBM ThinkPad T30/T40
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 168, Cache Line Size: 0x20 (128 bytes)
>         Interrupt: pin B routed to IRQ 185
>         Region 0: Memory at 3fefc000 (32-bit, non-prefetchable) [size=4K]
>         Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
>         Memory window 0: 40800000-40bff000 (prefetchable)
>         Memory window 1: 40c00000-40fff000
>         I/O window 0: 00004800-000048ff
>         I/O window 1: 00004c00-00004cff
>         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite+
>         16-bit legacy interface ports at 0001

And quite frankly, their "Region 0:" things look broken: the bridge is a 
"Normal decode" bridge, which means that anything behind that bridge 
should only map things _within_ the IO windows of the bridge, ie all IO 
mappings on the cardbus bridge should be inside the IO mappings of the 
parent bridge.  But they aren't. 

Now, your interrupts are a bit insane too, but they may actually be 
correct for all I know. The Yenta code will just decide that interrupts 
can't be working, since when it tries to trigger an interrupt it won't 
come in: but that is quite possibly not due to broken interrupts, but 
because the whole controller IO-MEM region has been mapped at the wrong 
place, so the controller simply never _sees_ our writes.

The parent bridge has IO port mappings at 00003000-00006fff, and IO memory 
mappings at c2000000-cfffffff and f0000000-f7ffffff. The cardbus stuff 
_should_ all be behind those regions, but instead they are at 3fefb000 and 
40000000-40fff000 (memory-mapped) and 00004000-00004cff (IO mapped).

So something is seriously broken.

That's a PCI layer brokenness, btw, not a PCMCIA brokenness. 

Can you enable debugging in arch/i386/pci/pci.h and post the whole bootup 
dmesg. Also, can you show what /proc/iomem looks like, and what 

	ls -R /sys/devices/pci*

says (that cardbus controller should be properly nested _inside_ that PCI 
bridge, dammit!).

Greg, any ideas?

		Linus
