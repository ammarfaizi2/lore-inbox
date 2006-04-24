Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWDXRCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWDXRCy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWDXRCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:02:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15823 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750972AbWDXRCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:02:53 -0400
Date: Mon, 24 Apr 2006 10:01:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Matthew Reppert <arashi@sacredchao.net>, linux-kernel@vger.kernel.org,
       Dave Airlie <airlied@linux.ie>, "Antonino A. Daplas" <adaplas@pol.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PCI ROM resource allocation issue with 2.6.17-rc2
In-Reply-To: <20060423222122.498a3dd2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604240949330.3701@g5.osdl.org>
References: <1145851361.3375.20.camel@minerva> <20060423222122.498a3dd2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 Apr 2006, Andrew Morton wrote:
>
> Matthew Reppert <arashi@sacredchao.net> wrote:
> >
> > I've been running 2.6.12-rc2-mm3 for a long time.  Recently I upgraded
> > a bunch of OS packages (Debian unstable), so I thought I may as well
> > upgrade the kernel, too.  I've got a dual-head setup driven by a Radeon
> > 9200 and a Radeon 7000.  When I booted 2.6.17-rc2, X never came up; I
> > got "RADEON: Cannot read V_BIOS" and "RADEON: VIdeo BIOS not detected
> > in PCI space!" for the RADEON 7000, and it eventually gets in a loop of
> > spitting out "RADEON: Idle timed out, resetting engine ... " messages
> > in Xorg.log.  Doing a diff of working and broken logs uncovered that the
> > Radeon 7000's PCI ROM resource area had moved from ff8c000 to c6900000.
> > Once I removed the Radeon 7000 screen from the Xorg config, X came up fine
> > on the one head.  Adding stupid amounts of printks to the PCI subsystem in
> > .17-rc2 uncovered that at some point, the ROM area is discovered to be
> > at ff8c0000, but is later reallocated to c6900000.

The relocation sounds strange (and isn't visible in your dmesg that I can 
see). But it _should_ be perfectly fine: it's moving the ROM from the 
non-prefetchable region of the 00:1e.0 bridge into the prefetchable one. 

I don't see quite why it would do it (yes, ROM's are prefetchable, but the 
old location was _valid_, and I don't see why we didn't re-use it), but it 
_really_ shouldn't matter. 

I would expect some silly interaction with X, as usual. It would be nice 
to see the whole dmesg, especially with the debugging messages - I suspect 
the remapping of the ROM happens only when X starts up, and that your 
dmesg is from just the kernel boot from before that?

But it might be that I just missed it (or that we don't have good debug 
output for that case).

> > I've also got a Promise PDC20268 whose expansion ROM seems to have made a
> > similar move (from ff8f8000 to c6920000), but the ATA devices attached to
> > that controller seem to work fine under 2.6.17-rc2.

Exactly the same deal. It's moved from non-prefetchable to prefetchable.

That said, the PDC202xx driver doesn't even _use_ the ROM resource, so I 
don't see why it bothers to enable it.

You can try this stupid patch to see if it moves the ROM resource back 
into the non-prefetchable region. Maybe it matters even if it shouldn't.

		Linus
---
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a10ed9d..7af4610 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -217,7 +217,7 @@ #endif
 			sz = pci_size(l, sz, (u32)PCI_ROM_ADDRESS_MASK);
 			if (sz) {
 				res->flags = (l & IORESOURCE_ROM_ENABLE) |
-				  IORESOURCE_MEM | IORESOURCE_PREFETCH |
+				  IORESOURCE_MEM | /* IORESOURCE_PREFETCH | */
 				  IORESOURCE_READONLY | IORESOURCE_CACHEABLE;
 				res->start = l & PCI_ROM_ADDRESS_MASK;
 				res->end = res->start + (unsigned long) sz;
