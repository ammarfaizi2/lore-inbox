Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262751AbVCWCeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262751AbVCWCeT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 21:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbVCWCdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 21:33:44 -0500
Received: from loopy.telegraphics.com.au ([202.45.126.152]:2699 "EHLO
	loopy.telegraphics.com.au") by vger.kernel.org with ESMTP
	id S262770AbVCWCaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 21:30:04 -0500
Date: Wed, 23 Mar 2005 13:30:00 +1100 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux/m68k <linux-m68k@vger.kernel.org>,
       Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: [PATCH] Jazzsonic driver updates
In-Reply-To: <Pine.LNX.4.62.0503221807160.20753@numbat.sonytel.be>
Message-ID: <Pine.LNX.4.61.0503231242110.13146@loopy.telegraphics.com.au>
References: <200503070210.j272ARii023023@hera.kernel.org>
 <Pine.LNX.4.62.0503221807160.20753@numbat.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Mar 2005, Geert Uytterhoeven wrote:

> On Fri, 28 Jan 2005, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1986, 2005/01/28 00:12:28-05:00, ralf@linux-mips.org
> > 
> > 	[PATCH] Jazzsonic driver updates
> > 	
> > 	 o Resurrect the Jazz SONIC driver after years of it not having been tested
> > 	 o Convert from Space.c initialization to module_init / platform device.
> > 	
> > 	Signed-off-by: Jeff Garzik <jgarzik@pobox.com>
> 
> > --- a/drivers/net/sonic.c	2005-03-06 18:10:39 -08:00
> > +++ b/drivers/net/sonic.c	2005-03-06 18:10:39 -08:00
> > @@ -116,7 +116,7 @@
> >  	/*
> >  	 * Map the packet data into the logical DMA address space
> >  	 */
> > -	if ((laddr = vdma_alloc(PHYSADDR(skb->data), skb->len)) == ~0UL) {
> > +	if ((laddr = vdma_alloc(CPHYSADDR(skb->data), skb->len)) == ~0UL) {
>                                 ^^^^^^^^^
> This part broke compilation for Mac/m68k.
> 

Compilation is easily fixed, a patch is below.

BTW, this will still leave the macsonic driver in a non-working state. I 
have a patch to make it work again, which also re-introduces the support 
for 16-bit cards that went missing way back in 2.4.something (jazzsonic 
cards are all 32-bit, as are some mac cards). My patch basically ports the 
current macsonic driver from mac68k 2.2 branch, and has been widely tested 
on macs. Problem is, it hasn't yet been tested on MIPS, and it makes a lot 
of changes to sonic.c, which is shared by jazzsonic and macsonic.

Can anyone with a Jazz machine help out with this?

One of the difficulties is that MIPS and m68k architectures each have 
their own repo, and last time I looked, the SONIC code in the MIPS repo 
didn't agree with the SONIC code in the m68k repo. But, it shouldn't be 
difficult to make macsonic and jazzsonic work with the same core driver 
code again. Besides, we already have two SONIC drivers in the tree, 
seperating jazzsonic and macsonic would add a third.

-f

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>


--- a/drivers/net/macsonic.c	2005-03-25 04:01:51.000000000 +1100
+++ b/drivers/net/macsonic.c	2005-03-25 04:48:39.000000000 +1100
@@ -638,6 +638,7 @@
 #define vdma_free(baz)
 #define sonic_chiptomem(bat) (bat)
 #define PHYSADDR(quux) (quux)
+#define CPHYSADDR(quux) (quux)
 
 #define sonic_request_irq       request_irq
 #define sonic_free_irq          free_irq
