Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267896AbTAMQoZ>; Mon, 13 Jan 2003 11:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267911AbTAMQoZ>; Mon, 13 Jan 2003 11:44:25 -0500
Received: from [217.167.51.129] ([217.167.51.129]:30945 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S267896AbTAMQoX>;
	Mon, 13 Jan 2003 11:44:23 -0500
Subject: Re: Linux 2.4.21-pre3-ac4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1042404682.16288.34.camel@irongate.swansea.linux.org.uk>
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>
	 <1042399796.525.215.camel@zion.wanadoo.fr>
	 <1042403235.16288.14.camel@irongate.swansea.linux.org.uk>
	 <1042401074.525.219.camel@zion.wanadoo.fr>
	 <1042401443.525.223.camel@zion.wanadoo.fr>
	 <1042404682.16288.34.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042476966.30833.11.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 13 Jan 2003 17:56:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 21:51, Alan Cox wrote:
> On Sun, 2003-01-12 at 19:57, Benjamin Herrenschmidt wrote:
> > Actually, do we really need that delay as we are waiting for an
> > interrupt anyway ? my understanding is that this delay is the required
> > before we start polling for BSY bit (that is the max time the drive may
> > take to assert BSY after getting the command), but in our case, unless
> > we have other bugs, we shall have the channel marked busy, so nobody
> > will tap it, except the actual interrupt coming in. Or will the case of
> > shared interrupt potentially cause a read of status at the wrong time ?
> 
> Precisely. Or a random IRQ from a drive power change or hotplug that
> passed our command in the other direction.
> 
> We could actually address this another way which might even be easier, 
> that is in the IRQ path to wait the 400nS if BSY isnt asserted. I need
> to go reread the spec to check if we can poll it before the timeout
> but not trust the data, or cannot poll it.

Now I think that would be bad as that would mean waiting in the normal
case. But if you look at the various access patterns, I think there is
no real problem in fact, though I beleive only Andre can confirm.

We have 3 cases to deal with:

 1 - Command with no data transfer. Here, there should be no problem
just doing a read from status or alt_status, right ? now, reading status
might clear the IRQ if we are slow enough, so we may want alt_status
instead. (We can probably safely ignore controllers that have no alt
status here, or route them via some hwif->IOSYNC() macro). Or maybe just
re-read the select register for making everybody happy.

 2 - Command with a data transfer not using DMA (that is either PIO or
the command part of an ATAPI command in ide-cd). I don't think there's
any problem reading alt status or select here, is there andre ? So we
can also safely do that before waiting and thus make sure the bus path
to the controller is ok

 3 - Command with a data transfer using DMA (new ide-scsi, ide-hd with
dma, etc...). Here, I beleive there is just no problem, we don't need to
wait at all, since the interrupt handler will check for the DMA
controller to have completed via hwif->ide_dma_test_irq before reading
the status reg at all, right ?

Ben.

