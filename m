Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277263AbRJIXlF>; Tue, 9 Oct 2001 19:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278062AbRJIXkw>; Tue, 9 Oct 2001 19:40:52 -0400
Received: from sushi.toad.net ([162.33.130.105]:50337 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S277263AbRJIXks>;
	Tue, 9 Oct 2001 19:40:48 -0400
Subject: Re: Linux 2.4.10-ac10
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: bunk@fs.tum.de
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 09 Oct 2001 19:40:50 -0400
Message-Id: <1002670852.763.24.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I've figured out issue #1.  There's an error in the
parport_pc.c code such that it prints the irq number as the
dma number ( ... thus DMA 7 instead of DMA 3).

I append a patch that fixes this.  I'll submit it again with
a [PATCH] subject heading.

We still need to figure out #2: what is taking up ioport 0x530?

--
Thomas


> Well, the two notable difference in the syslog are:
> 1) Parport now reports that it is going to use DMA 7
>    instead of DMA 3;
> 2) On the second boot ioport 0x530 is reported not to be free
>    and this prevents ad1816 from loading
>
> Two questions:
> 1) Is the parport actually configured to use DMA7, not DMA3? 
>    Please check using "lspnp -v 0d" and also by any other
>    methods you have access to
> 2) What is using 0x530?  What's in /proc/ioports?

The patch:
--- linux-2.4.10-ac10/drivers/parport/parport_pc.c	Mon Oct  8 22:41:14 2001
+++ linux-2.4.10-ac10-fix/drivers/parport/parport_pc.c	Tue Oct  9 19:36:58 2001
@@ -2826,7 +2826,7 @@
 	if ( UNSET(dev->irq_resource[0]) ) {
 		irq = PARPORT_IRQ_NONE;
 	} else {
-		if ( dev->irq_resource[0].start == -1 ) {
+		if ( dev->irq_resource[0].start == (unsigned long)-1 ) {
 			irq = PARPORT_IRQ_NONE;
 			printk(", irq disabled");
 		} else {
@@ -2838,12 +2838,12 @@
 	if ( UNSET(dev->dma_resource[0]) ) {
 		dma = PARPORT_DMA_NONE;
 	} else {
-		if ( dev->dma_resource[0].start == -1 ) {
+		if ( dev->dma_resource[0].start == (unsigned long)-1 ) {
 			dma = PARPORT_DMA_NONE;
 			printk(", dma disabled");
 		} else {
 			dma = dev->dma_resource[0].start;
-			printk(", dma %d",irq);
+			printk(", dma %d",dma);
 		}
 	}
 

