Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268008AbTBRUja>; Tue, 18 Feb 2003 15:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268010AbTBRUja>; Tue, 18 Feb 2003 15:39:30 -0500
Received: from AMarseille-201-1-6-77.abo.wanadoo.fr ([80.11.137.77]:18983 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S268008AbTBRUj2>;
	Tue, 18 Feb 2003 15:39:28 -0500
Subject: Re: PATCH: make the sl82c105 work again
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030218185309.C9785@flint.arm.linux.org.uk>
References: <E18lCZa-0006Ec-00@the-village.bc.nu>
	 <20030218185309.C9785@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045601367.570.56.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 18 Feb 2003 21:49:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-18 at 19:53, Russell King wrote:
> On Tue, Feb 18, 2003 at 06:34:29PM +0000, Alan Cox wrote:
> > +	hwif->drives[0].pio_speed = XFER_PIO_0;
> > +	hwif->drives[0].autotune = 1;
> > +	hwif->drives[1].pio_speed = XFER_PIO_1;
> > +	hwif->drives[1].autotune = 1;
> 
> Is there some reason why drive 1 is PIO 1 and drive 0 is PIO 0 ?

No, just a typo from me that I forgot to send a patch for.

There is also still a problem. If DMA fails, the main IDE layer
goes back to PIO, that works, and then goes back to DMA, it
calls hwif->ide_dma_on() from IRQ with lock held etc...

The problem is that if I fix that, that means the proper setting
up of the disk for DMA etc... will not be done in ide_dma_on
anymore but only on ide_dma_check() (so once upon discovery)
and when setting xfer mode. Not on hdparm -d1. I'm still wondering
what is the best fix for that. For ide-pmac, I did the later
(only do the job in check()), but I also think we should change
ide.c to actually call hwif->ide_dma_check() when DMA is turned
ON with hdparm instead of ide_dma_on().

Ben.
 

