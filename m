Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135973AbRDTQq7>; Fri, 20 Apr 2001 12:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135972AbRDTQqw>; Fri, 20 Apr 2001 12:46:52 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:39436 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S135976AbRDTQpI>;
	Fri, 20 Apr 2001 12:45:08 -0400
Date: Fri, 20 Apr 2001 18:45:05 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: stefan@jaschke-net.de
Cc: Francois Romieu <romieu@cogenit.fr>, linux-kernel@vger.kernel.org
Subject: Re: epic100 error
Message-ID: <20010420184505.F32759@se1.cogenit.fr>
In-Reply-To: <20010417184552.A6727@core.devicen.de> <01042016050400.01202@antares> <20010420163343.B4702@se1.cogenit.fr> <01042017575400.01716@antares>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <01042017575400.01716@antares>; from s-jaschke@t-online.de on Fri, Apr 20, 2001 at 05:57:54PM +0200
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Jaschke <s-jaschke@t-online.de> écrit :
> On Friday 20 April 2001 16:33, Francois Romieu wrote:
> > Stefan Jaschke <s-jaschke@t-online.de> ecrit :
> > > I copied epic100.c from 2.4.2 into the 2.4.4-pre4 tree and it compiles
> > > and works without problems.
> > > This gives me a workable solution :-)
> >
> > Thanks for the info.
> > Now, why do you get so much Receive Queue Empty indications...
> 
> Now, this is a question for more knowledgable persons than me :-)

I don't claim to be but it's quite amazing: in your logs,
the driver receives one packet and after that it go into a loop because
the adapter complains of the lack of available rx descriptors.

[Initialization of the card...32 rx descriptors are available for the card]

Apr 20 12:48:45 antares kernel:  In epic_rx(), entry 0 00601021.
Apr 20 12:48:45 antares kernel:   epic_rx() status was 00601021.
Apr 20 12:48:45 antares kernel: eth0: Interrupt, status=0x00240000 new
intstat=0x00240000.
Apr 20 12:48:45 antares kernel: eth0: exiting interrupt, intr_status=0x240000.

Incoming packet. 31 rx descriptors are available for the card.

Apr 20 12:48:46 antares kernel: eth0: Interrupt, status=0x008d0004 new
intstat=0x008c0000.

That shouldn't happen (RxFull in the code: the adapter sees a descriptor
owned by the CPU). The driver says to the card "Look again at the
descriptor" but alas it didn't do anything (coz this shouldn't happen here).

Apr 20 12:48:46 antares last message repeated 32 times

The adapter answer immediatly, kicks the same IRQ. The driver notices it
while it still is in epic_interrupt and after 32 try:

Apr 20 12:48:46 antares kernel: eth0: Too much work at interrupt,
IntrStatus=0x008d0004.

I assume nothing is overclocked or whatever

Could you try this patch (more output during the loop):

--- epic100.c.orig	Fri Apr 20 11:54:57 2001
+++ epic100.c	Fri Apr 20 17:55:25 2001
@@ -1083,8 +1083,19 @@
 			if (status & RxOverflow) {		/* Missed a Rx frame. */
 				ep->stats.rx_errors++;
 			}
-			if (status & (RxOverflow | RxFull))
+			if (status & RxOverflow)
 				outw(RxQueued, ioaddr + COMMAND);
+			if (status & RxFull) {
+				int i = 0;
+
+				for (i = 0; i < RX_RING_SIZE; i++) {
+					if((ep->rx_ring[i].rxstatus & 
+						cpu_to_le32(DescOwn)) != 0) {
+						printk(KERN_INFO "%s: desc %2.2d owned by card\n", dev->name, i);
+					}
+				}
+				outw(RxQueued, ioaddr + COMMAND);
+			}
 			if (status & PCIBusErr170) {
 				printk(KERN_ERR "%s: PCI Bus Error!  EPIC status %4.4x.\n",
 					   dev->name, status);


> Another question I have is about the different driver versions that
> are around. 
> Till Harbaum <harbaum@telematik.informatik.uni-karlsruhe.de> just sent
> me a driver which is directly from SMC:
[...]
> and "copying" is the GPL. It seems to be a not yet released extension of the 
> driver
> available from http://www.smc.de/sites/support/download/PCI/9432/LINUX/src9432lu.zip.
> Some changelog reads " 03/13/2001 Ling Yue     for linux kernel 2.4".
> 
> Is there communication between SMC and your group?

This is a question for more knowledgable persons than me (TM).
So far, the headers don't look terribly GPLish.

-- 
Ueimor
