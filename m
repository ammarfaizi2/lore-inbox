Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318923AbSH1P4L>; Wed, 28 Aug 2002 11:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318924AbSH1P4L>; Wed, 28 Aug 2002 11:56:11 -0400
Received: from hal.astr.lu.lv ([195.13.134.67]:30857 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S318923AbSH1P4J> convert rfc822-to-8bit;
	Wed, 28 Aug 2002 11:56:09 -0400
From: Andris Pavenis <pavenis@latnet.lv>
To: Doug Ledford <dledford@redhat.com>
Subject: Re: Linux-2.4.20-pre4-ac1: i810_audio broken
Date: Wed, 28 Aug 2002 18:59:38 +0300
User-Agent: KMail/1.4.6
Cc: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>,
       "linux-kernel@vger" <linux-kernel@vger.kernel.org>
References: <200208271253.12192.pavenis@latnet.lv> <200208281622.30303.pavenis@latnet.lv> <20020828112133.C30777@redhat.com>
In-Reply-To: <20020828112133.C30777@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200208281859.38609.pavenis@latnet.lv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 August 2002 18:21, Doug Ledford wrote:
> On Wed, Aug 28, 2002 at 04:22:30PM +0300, Andris Pavenis wrote:
> > On Wednesday 28 August 2002 15:51, Juergen Sawinski wrote:
> > > Can you drop in the old (working) source into the new tree and see if
> > > that works? If that works I'll try making a step by step patch series,
> > > to see what breaks it.
> >
> > Today's tests were done in that way (I only replaced i810_audio.c,
> > removed i810_audio.o, run 'make modules' and 'make modules_install' and
> > tested the results). As I wrote earlier it seems that Dough's patch (to
> > 2.4.20-pre1-ac2) broke driver
>
> (In an email Juergen sent to me privately he mentioned that on the ICH4
> the CIV register is now read-only where as on previous ICH chips it was
> read-write, which is something I missed as far as changes to the chip are
> concerned)
>
> Now, given the tidbit of information above, I would expect ICH4 chipsets
> to break with the driver.  We currently rely upon the ability to set the
> CIV register to what we want in order to start the DMA where we want.  If
> that's now readonly, I'll have to rethink how I reset the DMA hardware and
> how I will have to start recording the new DMA position instead of setting
> the new DMA position.  The one thing about this though, I would expect
> this issue to cause previously non-working ICH4 chips to work poorly with
> my patch instead of previously working ICH4 chips to now start working
> poorly since my patch didn't change the (/me stops mid-sentence and
> realizes that "yes, in fact there is a change in my patch to base DMA
> operations that could cause this").  Hmmm...backup....try backing out my
> changes to stop_dac and stop_adc (the part where I change how we do a DMA
> engine reset every time we stop the dac and adc) and see if that solves
> your problem.  The changes to __stop_dac() and __stop_adc() are localized
> actually and you should be able to safely leave all of those hunks out
> without effecting the rest of the patch.

Tried, it helps for i810_audio.c both from 2.4.20-pre1-ac2 and 
2.4.20-pre4-ac1. (Patch simply to be sure we're talking about the
same thing). In both cases I put i810_audio.c in 2.4.20-pre4-ac1 source
tree.

Andris

--- i810_audio.c-2.4.20-pre1-ac2	2002-08-28 09:50:44.000000000 +0300
+++ i810_audio.c	2002-08-28 18:51:34.000000000 +0300
@@ -732,8 +732,6 @@
 	outb(0, card->iobase + PI_CR);
 	// wait for the card to acknowledge shutdown
 	while( inb(card->iobase + PI_CR) != 0 ) ;
-	// reset the dma engine now
-	outb(0x02, card->iobase + PI_CR);
 	// now clear any latent interrupt bits (like the halt bit)
 	if(card->pci_id == PCI_DEVICE_ID_SI_7012)
 		outb( inb(card->iobase + PI_PICB), card->iobase + PI_PICB );
@@ -784,8 +782,6 @@
 	outb(0, card->iobase + PO_CR);
 	// wait for the card to acknowledge shutdown
 	while( inb(card->iobase + PO_CR) != 0 ) ;
-	// reset the dma engine now
-	outb(0x02, card->iobase + PO_CR);
 	// now clear any latent interrupt bits (like the halt bit)
 	if(card->pci_id == PCI_DEVICE_ID_SI_7012)
 		outb( inb(card->iobase + PO_PICB), card->iobase + PO_PICB );
