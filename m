Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271019AbRH1Xjl>; Tue, 28 Aug 2001 19:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271055AbRH1XjW>; Tue, 28 Aug 2001 19:39:22 -0400
Received: from smtp-ham-2.netsurf.de ([194.195.64.98]:25336 "EHLO
	smtp-ham-2.netsurf.de") by vger.kernel.org with ESMTP
	id <S271019AbRH1XjV>; Tue, 28 Aug 2001 19:39:21 -0400
Date: Wed, 29 Aug 2001 01:33:18 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] yenta resource allocation fix
Message-ID: <20010829013318.A16910@storm.local>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that Linus is back, and since he wrote most of yenta.c (according to
copyright notice), I'll just reiterate this (sent to the list and Alan
Cox).  I removed a seemingly bogus bit mask and replaced it with a
consistent IO range mask.

I have no idea why the 0xfff was in place.  Or, on second thought, this
might be to allocate memory space behind official end as slack?  This
would defy the end > start check then, anyway.  Linus?


---- start repeat ----

This fixes the problem of the yenta_socket driver not allocating IO port
windows if they weren't already.  This caused no ports to be available
to a inserted CardBus card which in turn made the tulip driver complain
since it can't run without IO ports.

I'm no expert on the PCI/CardBus bridge stuff, but let's see:  The OR
operation on the range end register with 0xfff seems pretty bogus to me.
Also the "if (start && ..." was always true since start included the 32
bit IO flag.  What my patch does is to mask out the IO flags on both
start and end if the resource is indeed an IO resource, which seems
correct to me.

Now everything works for me.  If I had known the fix was so easy I would
never have bothered with pcmcia-cs.  Well, there is a problem that it
only picks up every second card insertion, so I have to
insert/remove/insert for my card to be recognized, but then it works.


diff -ruN linux-2.4.orig/drivers/pcmcia/yenta.c
linux-2.4/drivers/pcmcia/yenta.c   
--- linux-2.4.orig/drivers/pcmcia/yenta.c       Fri Jul 27 02:21:28 2001
+++ linux-2.4/drivers/pcmcia/yenta.c    Sun Aug 26 23:26:17 2001
@@ -701,8 +701,14 @@
        struct resource *root, *res;
        u32 start, end;
        u32 align, size, min, max;
+       u32 mask;
        unsigned offset;

+       if (type & IORESOURCE_IO)
+               mask = PCI_CB_IO_RANGE_MASK;
+       else
+               mask = ~0U;
+
        offset = 0x1c + 8*nr;
        bus = socket->dev->subordinate;
        res = socket->dev->resource + PCI_BRIDGE_RESOURCES + nr;
@@ -715,8 +721,8 @@
        if (!root)
                return;

-       start = config_readl(socket, offset);
-       end = config_readl(socket, offset+4) | 0xfff;
+       start = config_readl(socket, offset) & mask;
+       end = config_readl(socket, offset+4) & mask;
        if (start && end > start) {
                res->start = start;
                res->end = end;



---- end repeat ----


Some additional data for the missed card insertions:  I put printk()s in
yenta_interrupt() and yenta_bh() printing events (yenta_bh() just out of
curiosity, no events get lost/delayed between interrupt and bh, all fine
there).

This showed that the first insertion after module load doesn't even
arrive as an interrupt.  After that, with only pcmcia_core and
yenta_socket loaded, every card removal and insertion show up as event
0x80 (to be more precise cb_event 0x6, csc 0x0).

With ds loaded first insertion does not arrive also.  The second
insertion gets picked up and card is initialized.  After removal the
next insertion is again missed (no interrupt)!  cb_event is 0x6 for
received insertions, 0x7 for removal after successful insertion and 0x6
for removal after missed insertion.



For reference, hardware is an IBM Thinkpad (i1200 or more specifically
1161-267) with 550MHz Coppermine-Celeron and the following relevant
cardbus bridge:

00:03.0 CardBus bridge: O2 Micro, Inc. OZ6812 Cardbus Controller (rev 05)
        Subsystem: IBM: Unknown device 01a3
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00001000-000010ff
        I/O window 1: 00001400-000014ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
        16-bit legacy interface ports at 0001

Some log messages for this:

PCI: Found IRQ 11 for device 00:03.0
PCI: Sharing IRQ 11 with 00:00.1
PCI: Sharing IRQ 11 with 00:00.2
IRQ routing conflict for 00:03.0, have irq 10, want irq 11
Yenta IRQ list 00b8, PCI irq10
Socket status: 30000827

-- 
Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
