Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267976AbUIPMvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267976AbUIPMvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 08:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267993AbUIPMvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 08:51:54 -0400
Received: from witte.sonytel.be ([80.88.33.193]:36289 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267976AbUIPMvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 08:51:49 -0400
Date: Thu, 16 Sep 2004 14:51:38 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Deepak Saxena <dsaxena@plexity.net>
cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
In-Reply-To: <20040915230904.GA19450@plexity.net>
Message-ID: <Pine.GSO.4.58.0409161410080.23693@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org> <20040915222157.GA17284@plexity.net>
 <Pine.LNX.4.58.0409151540260.2333@ppc970.osdl.org> <20040915230904.GA19450@plexity.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004, Deepak Saxena wrote:
> On Sep 15 2004, at 15:46, Linus Torvalds was caught saying:
> > Quite frankly, of your two suggested interfaces, I would select neither.
> > I'd just say that if your bus is special enough, just write your own
> > drivers, and use
> >
> > 	cookie = ixp4xx_iomap(dev, xx);
> > 	...
> > 	ixp4xx_iowrite(val, cookie + offset);
> >
> > which is perfectly valid. You don't have to make these devices even _look_
> > like a PCI device. Why should you?
>
> Problem is that some of those devices are not that special. For example,
> the on-board 16550 is accessed using readb/writeb in the 8250.c driver.

Just what I was thinking...

> I don't think we want to add that level of low-level detail to that
> driver and instead should just hide it in the platform code. I look
> at it from the point of view that the driver should not care about how
> the access actually occurs on the bus. It just says, write data foo at
> location bar regardless of whether bar is ISA, PCI, on-chip, RapidIO,
> etc and that writing of the data is hidden in the implementation of
> the accessor API.

While 16550 serial is a bad example since it does byte accesses only (and thus
doesn't suffer from endianness), I have no problem to imagine there exist
platforms where you have multiple instances of a `standard' (cfr. 16550 serial)
device block, while each of them must be accessed differently:
  - one of them is in PCI I/O space (little endian)
  - one of them is in PCI MMIO space (little endian)
  - one of them is on-chip MMIO (big endian)
  - one of them is somewhere else, but sparsely addressed (some bytes of
    padding between each register)
and we can for sure come up with a few more examples of weird addressing.

How to solve this, without cluttering each ioread*() with many if clauses?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
