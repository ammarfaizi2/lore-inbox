Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269831AbRHMVqs>; Mon, 13 Aug 2001 17:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269843AbRHMVqi>; Mon, 13 Aug 2001 17:46:38 -0400
Received: from smtp1.ns.sympatico.ca ([142.177.1.91]:56289 "EHLO
	smtp2.ns.sympatico.ca") by vger.kernel.org with ESMTP
	id <S269831AbRHMVqT>; Mon, 13 Aug 2001 17:46:19 -0400
Message-ID: <3B784AAF.9E6E8E00@yahoo.co.uk>
Date: Mon, 13 Aug 2001 17:46:23 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parport_pc.c PnP BIOS sanity check
Content-Type: multipart/mixed;
 boundary="------------0867A241D021AD2567F1AAB4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0867A241D021AD2567F1AAB4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> IRQ 0 is a legal valid IRQ. I suspect the problem is that pnpbios shouldnt
> be reporting an IRQ or we should be using some kind of NO_IRQ cookie

Okay, I accept that.  Then must we also say that DMA 0 is a
valid DMA?  If so, then unless I'm confused about something
the rejection of dma==0 should be eliminated:
--------------------------------------------------------------------------------
--- linux-2.4.7-ac10/drivers/parport/parport_pc.c_ORIG  Fri Aug 10 18:19:07 2001
+++ linux-2.4.7-ac10/drivers/parport/parport_pc.c       Mon Aug 13 17:40:38 2001
@@ -2797,8 +2797,6 @@
        irq=dev->irq_resource[0].start;
        dma=dev->dma_resource[0].start;

-       if (dma==0) dma=-1;
-
        printk(KERN_INFO "PnPBIOS: Parport found %s %s at io=%04x,%04x irq=%d dma=%d\n",
                dev->name,dev->slot_name,io,iohi,irq,dma);
        if (parport_pc_probe_port(io,iohi,irq,dma,NULL))
--------------------------------------------------------------------------------

Otherwise I think the following change should be made for the sake of
code clarity.  (PARPORT_DMA_NONE is defined as -1.)
--------------------------------------------------------------------------------
--- linux-2.4.7-ac10/drivers/parport/parport_pc.c_ORIG  Fri Aug 10 18:19:07 2001
+++ linux-2.4.7-ac10/drivers/parport/parport_pc.c       Fri Aug 10 18:19:55 2001
@@ -2797,7 +2797,7 @@
        irq=dev->irq_resource[0].start;
        dma=dev->dma_resource[0].start;

-       if (dma==0) dma=-1;
+       if (dma==0) dma=PARPORT_DMA_NONE;

        printk(KERN_INFO "PnPBIOS: Parport found %s %s at io=%04x,%04x irq=%d dma=%d\n",
                dev->name,dev->slot_name,io,iohi,irq,dma);
--------------------------------------------------------------------------------

--
Thomas Hood
jdthood_AT_yahoo.co.uk
--------------0867A241D021AD2567F1AAB4
Content-Type: text/plain; charset=us-ascii;
 name="patch-norejdma"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-norejdma"

--- linux-2.4.7-ac10/drivers/parport/parport_pc.c_ORIG	Fri Aug 10 18:19:07 2001
+++ linux-2.4.7-ac10/drivers/parport/parport_pc.c	Mon Aug 13 17:40:38 2001
@@ -2797,8 +2797,6 @@
 	irq=dev->irq_resource[0].start;
 	dma=dev->dma_resource[0].start;
 
-	if (dma==0) dma=-1;
-
 	printk(KERN_INFO "PnPBIOS: Parport found %s %s at io=%04x,%04x irq=%d dma=%d\n",
 		dev->name,dev->slot_name,io,iohi,irq,dma);
 	if (parport_pc_probe_port(io,iohi,irq,dma,NULL))

--------------0867A241D021AD2567F1AAB4
Content-Type: text/plain; charset=us-ascii;
 name="patch-dmanone"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-dmanone"

--- linux-2.4.7-ac10/drivers/parport/parport_pc.c_ORIG	Fri Aug 10 18:19:07 2001
+++ linux-2.4.7-ac10/drivers/parport/parport_pc.c	Fri Aug 10 18:19:55 2001
@@ -2797,7 +2797,7 @@
 	irq=dev->irq_resource[0].start;
 	dma=dev->dma_resource[0].start;
 
-	if (dma==0) dma=-1;
+	if (dma==0) dma=PARPORT_DMA_NONE;
 
 	printk(KERN_INFO "PnPBIOS: Parport found %s %s at io=%04x,%04x irq=%d dma=%d\n",
 		dev->name,dev->slot_name,io,iohi,irq,dma);

--------------0867A241D021AD2567F1AAB4--

