Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbTILMdc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 08:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbTILMdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 08:33:32 -0400
Received: from vlugnet.org ([217.160.107.28]:46246 "EHLO vlugnet.org")
	by vger.kernel.org with ESMTP id S261419AbTILMd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 08:33:29 -0400
From: Ronny Buchmann <ronny-lkml@vlugnet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [OOPS] 2.4.22 / HPT372N
Date: Fri, 12 Sep 2003 14:32:51 +0200
User-Agent: KMail/1.5.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marko Kreen <marko@l-t.ee>
References: <200309091406.56334.ronny-lkml@vlugnet.org> <200309121141.45776.ronny-lkml@vlugnet.org> <1063363684.5409.8.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1063363684.5409.8.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309121432.51880.ronny-lkml@vlugnet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag 12 September 2003 12:48 schrieb Alan Cox:
> On Gwe, 2003-09-12 at 10:41, Ronny Buchmann wrote:
> > I will test with cdrom attached later today.
> > Currently I have one disk on each channel.
> >
> > I had another look at hpt.c(from highpoint) and hpt366.c and found this:
> > --- linux-2.4.22-ac1/drivers/ide/pci/hpt366.c.orig	2003-09-11
> > 21:29:06.000000000 +0200
> > +++ linux-2.4.22-ac1/drivers/ide/pci/hpt366.c	2003-09-12
> > 01:05:44.000000000 +0200
> > @@ -713,7 +713,7 @@
> >
> >  	/* Reconnect channels to bus */
> >  	outb(0x00, hwif->dma_base+0x73);
> > -	outb(0x00, hwif->dma_base+0x79);
> > +	outb(0x00, hwif->dma_base+0x77);
> >  }
>
> Which piece of documentation makes you think that ? So I can double
> check it.

from hpt.c

void INLINE Switching370Clock(PChannel pChan, UCHAR ucClockValue)
{
        if((InPort(pChan->NextChannelBMI + BMI_STS) & BMI_STS_ACTIVE) == 0){
                PUCHAR PrimaryMiscCtrlRegister = pChan->BaseBMI + 0x70;
                PUCHAR SecondaryMiscCtrlRegister = pChan->BaseBMI + 0x74;
                                                                                                             
                OutPort(PrimaryMiscCtrlRegister+3, 0x80); // tri-state the primary channel
                OutPort(SecondaryMiscCtrlRegister+3, 0x80); // tri-state the secondary channel
                                                                                                             
                OutPort((PUCHAR)((ULONG)pChan->BaseBMI+0x7B), ucClockValue); // switching the clock
                                                                                                             
                OutPort((PUCHAR)((ULONG)pChan->BaseBMI+0x79), 0xC0); // reset two channels begin
                                                                                                             
                OutPort(PrimaryMiscCtrlRegister, 0x37); // reset primary channel state machine
                OutPort(SecondaryMiscCtrlRegister, 0x37); // reset secordary channel state machine
                                                                                                             
                OutPort((PUCHAR)((ULONG)pChan->BaseBMI+0x79), 0x00); // reset two channels finished
                                                                                                             
                OutPort(PrimaryMiscCtrlRegister+3, 0x00); // normal-state the primary channel
                OutPort(SecondaryMiscCtrlRegister+3, 0x00); // normal-state the secondary channel
        }
}

It's the equivalent to hpt372n_set_clock().

static void hpt372n_set_clock(ide_drive_t *drive, int mode)
{
        ide_hwif_t *hwif        = HWIF(drive);
                                                                                                             
        /* FIXME: should we check for DMA active and BUG() */
        /* Tristate the bus */
        outb(0x80, hwif->dma_base+0x73);
        outb(0x80, hwif->dma_base+0x77);
         
        /* Switch clock and reset channels */
        outb(mode, hwif->dma_base+0x7B);
        outb(0xC0, hwif->dma_base+0x79);
         
        /* Reset state machines */
        outb(0x37, hwif->dma_base+0x70);
        outb(0x37, hwif->dma_base+0x74);
         
        /* Complete reset */
        outb(0x00, hwif->dma_base+0x79);
         
        /* Reconnect channels to bus */
        outb(0x00, hwif->dma_base+0x73);
        outb(0x00, hwif->dma_base+0x77);
}

> > -	d->channels = 1;
> > +	d->channels = 2;
>
> Need to work out which 372N and others are dual channel but yes
Are there actually single channel versions?

-- 
ronny


