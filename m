Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316158AbSEJWmF>; Fri, 10 May 2002 18:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316156AbSEJWmA>; Fri, 10 May 2002 18:42:00 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:2043 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316153AbSEJWlJ>;
	Fri, 10 May 2002 18:41:09 -0400
Date: Fri, 10 May 2002 15:41:08 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>, irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] : ir253_smc_msg.diff
Message-ID: <20020510154108.B14407@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir253_smc_msg.diff :
------------------
	        <Following patch from Jeff Snyder>
	o [CRITICA] Release the proper region and not NULL pointer
	o [FEATURE] Fix messages


diff -u -p linux/drivers/net/irda/smc-ircc.d8.c linux/drivers/net/irda/smc-ircc.c
--- linux/drivers/net/irda/smc-ircc.d8.c	Fri May  3 18:52:33 2002
+++ linux/drivers/net/irda/smc-ircc.c	Fri May  3 18:54:44 2002
@@ -10,6 +10,8 @@
  * Modified by:   Dag Brattli <dag@brattli.net>
  * Modified at:   Tue Jun 26 2001
  * Modified by:   Stefani Seibold <stefani@seibold.net>
+ * Modified at:   Thur Apr 18 2002
+ * Modified by:   Jeff Snyder <je4d@pobox.com>
  * 
  *     Copyright (c) 2001      Stefani Seibold
  *     Copyright (c) 1999-2001 Dag Brattli
@@ -539,7 +541,7 @@ static int __init ircc_open(unsigned int
 	if (ircc_irq < 255) {
 		if (ircc_irq!=irq)
 			MESSAGE("%s, Overriding IRQ - chip says %d, using %d\n",
-				driver_name, self->io->irq, ircc_irq);
+				driver_name, irq, ircc_irq);
 		self->io->irq = ircc_irq;
 	}
 	else
@@ -547,13 +549,13 @@ static int __init ircc_open(unsigned int
 	if (ircc_dma < 255) {
 		if (ircc_dma!=dma)
 			MESSAGE("%s, Overriding DMA - chip says %d, using %d\n",
-				driver_name, self->io->dma, ircc_dma);
+				driver_name, dma, ircc_dma);
 		self->io->dma = ircc_dma;
 	}
 	else
 		self->io->dma = dma;
 
-	request_region(fir_base, CHIP_IO_EXTENT, driver_name);
+	request_region(self->io->fir_base, CHIP_IO_EXTENT, driver_name);
 
 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&irport->qos);
@@ -1191,10 +1193,9 @@ static int __exit ircc_close(struct ircc
         outb(IRCC_CFGB_IR, iobase+IRCC_SCE_CFGB);
 #endif
 	/* Release the PORT that this driver is using */
-	IRDA_DEBUG(0, __FUNCTION__ "(), releasing 0x%03x\n", 
-		   self->io->fir_base);
+	IRDA_DEBUG(0, __FUNCTION__ "(), releasing 0x%03x\n", iobase);
 
-	release_region(self->io->fir_base, self->io->fir_ext);
+	release_region(iobase, CHIP_IO_EXTENT);
 
 	if (self->tx_buff.head)
 		kfree(self->tx_buff.head);
