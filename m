Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262244AbTCWDjF>; Sat, 22 Mar 2003 22:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262260AbTCWDjE>; Sat, 22 Mar 2003 22:39:04 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:21634 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S262244AbTCWDjB>;
	Sat, 22 Mar 2003 22:39:01 -0500
Date: Sun, 23 Mar 2003 04:49:58 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE todo list
Message-ID: <20030323034957.GA28820@vana.vc.cvut.cz>
References: <1048352492.9219.4.camel@irongate.swansea.linux.org.uk> <20030322172453.GB9889@vana.vc.cvut.cz> <1048360040.9221.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048360040.9221.23.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 07:07:21PM +0000, Alan Cox wrote:
> On Sat, 2003-03-22 at 17:24, Petr Vandrovec wrote:
> >   any hope that promise 20265 driver could detect non-udma66 cable
> > and run at udma2 only? BIOS properly detect this, but Linux driver
> > wants to use udma100, and usually dies hard with CRC errors during
> > reading of PTBL extended chain (it also should not lockup when
> > CRC error happens 5 times in a row, but ...).
> 
> The five CRC in a row is what causes the DMA->PIO changedown. That
> implies there is a real bug in the error handling locking, or in
> the driver handling of that.
> 
> Can you throw some printks into the ide code and see what kind of 
> a death you get when it tries to change back to PIO.
> 
> As to the cable stuff, I'll take a look at it in time, but both
> need fixing

This one fixes lockup, but I'm not actually sure that it is better
than before, as both channels are downgraded to the PIO:

... CRC error stuff ...
PDC202XX: Secondary channel reset
PDC202XX: Primary channel reset
ide3: reset: master: error (0x00?)
... USB stuff & so on, before mounting root ...
... repeat 4 times:
hde: dma_timer_expiry: dma status = 0x21
hde: timeout waiting for DMA
PDC202XX: Primary channel reset
PDC202XX: Secondary channel reset
hde: timeout waiting for DMA
... end of repeat
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 292k freed
init-2.04#

It looks like that hde resurrecting did not cause any damage to the
filesystems (and obviously hde is completely innocent udma100 citizen;
hdg is the only one which should be turned to udma2 or pio).

And strange thing, once I was lucky enough to read partition table from 
hdg, so I could run atapci, and it reports that hde host interface is setup 
for UDMA4, while hdg for UDMA2. So host hardware is actually probably set 
ok, it is just "hdg: 234441648 sectors (120034 MB) w/2048KiB Cache, 
CHS=232581/16/63, UDMA(100)" which contains wrong value, and hdg itself, 
which says that udma5 is selected (and does not work).
						Petr Vandrovec
						vandrove@vc.cvut.cz


--- linux-2.5.65-c1197.dist/drivers/ide/ide-iops.c	2003-03-22 15:29:16.000000000 +0100
+++ linux-2.5.65-c1197/drivers/ide/ide-iops.c	2003-03-23 04:26:14.000000000 +0100
@@ -902,7 +902,7 @@
         /*
          * Select the drive, and issue the SETFEATURES command
          */
-	disable_irq(hwif->irq);	/* disable_irq_nosync ?? */
+	disable_irq_nosync(hwif->irq);
 	udelay(1);
 	SELECT_DRIVE(drive);
 	SELECT_MASK(drive, 0);
