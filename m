Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267835AbTBEHHe>; Wed, 5 Feb 2003 02:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267836AbTBEHHe>; Wed, 5 Feb 2003 02:07:34 -0500
Received: from mail.scram.de ([195.226.127.117]:35271 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S267835AbTBEHHd>;
	Wed, 5 Feb 2003 02:07:33 -0500
Date: Wed, 5 Feb 2003 07:06:00 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: mike_phillips@urscorp.com, <phillim2@comcast.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [CHECKER] 112 potential memory leaks in 2.5.48
In-Reply-To: <20030205011353.GA17941@Xenon.Stanford.EDU>
Message-ID: <Pine.LNX.4.44.0302050653210.3534-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> /u1/acc/linux/2.5.48/drivers/net/tokenring/madgemc.c:356:madgemc_probe:
> ERROR:LEAK:194:356:Memory leak [Allocated from:
> /u1/acc/linux/2.5.48/drivers/net/tokenring/madgemc.c:194:kmalloc]

This should fix the leaks (and updates the driver to use propper
reference counting).

--jochen
===== madgemc.c 1.9 vs edited =====
--- 1.9/drivers/net/tokenring/madgemc.c	Thu Nov 21 18:59:53 2002
+++ edited/madgemc.c	Wed Feb  5 08:16:32 2003
@@ -180,8 +180,11 @@

 		if ((dev = init_trdev(NULL, 0))==NULL) {
 			printk("madgemc: unable to allocate dev space\n");
+			if (madgemc_card_list)
+				return 0;
 			return -1;
 		}
+		SET_MODULE_OWNER(dev);
 		dev->dma = 0;

 		/*
@@ -193,6 +196,9 @@
 		card = kmalloc(sizeof(struct madgemc_card), GFP_KERNEL);
 		if (card==NULL) {
 			printk("madgemc: unable to allocate card struct\n");
+			kfree(dev); /* release_trdev? */
+			if (madgemc_card_list)
+				return 0;
 			return -1;
 		}
 		card->dev = dev;
@@ -223,14 +229,14 @@

 		if (dev->irq == 0) {
 			printk("%s: invalid IRQ\n", dev->name);
-			goto getout;
+			goto getout1;
 		}

 		if (!request_region(dev->base_addr, MADGEMC_IO_EXTENT,
 				   "madgemc")) {
 			printk(KERN_INFO "madgemc: unable to setup Smart MC in slot %d because of I/O base conflict at 0x%04lx\n", slot, dev->base_addr);
 			dev->base_addr += MADGEMC_SIF_OFFSET;
-			goto getout;
+			goto getout1;
 		}
 		dev->base_addr += MADGEMC_SIF_OFFSET;

@@ -348,6 +354,14 @@
 		if (tmsdev_init(dev, ISA_MAX_ADDRESS, NULL)) {
 			printk("%s: unable to get memory for dev->priv.\n",
 			       dev->name);
+			release_region(dev->base_addr-MADGEMC_SIF_OFFSET,
+			       MADGEMC_IO_EXTENT);
+
+			kfree(card);
+			tmsdev_term(dev);
+			kfree(dev);
+			if (madgemc_card_list)
+				return 0;
 			return -1;
 		}
 		tp = (struct net_local *)dev->priv;
@@ -376,10 +390,14 @@
 			madgemc_card_list = card;
 		} else {
 			printk("madgemc: register_trdev() returned non-zero.\n");
+			release_region(dev->base_addr-MADGEMC_SIF_OFFSET,
+			       MADGEMC_IO_EXTENT);

 			kfree(card);
 			tmsdev_term(dev);
 			kfree(dev);
+			if (madgemc_card_list)
+				return 0;
 			return -1;
 		}

@@ -389,6 +407,7 @@
 	getout:
 		release_region(dev->base_addr-MADGEMC_SIF_OFFSET,
 			       MADGEMC_IO_EXTENT);
+	getout1:
 		kfree(card);
 		kfree(dev); /* release_trdev? */
 		slot++;
@@ -696,7 +715,6 @@
 	 */
 	madgemc_chipset_init(dev);
 	tms380tr_open(dev);
-	MOD_INC_USE_COUNT;
 	return 0;
 }

@@ -704,7 +722,6 @@
 {
 	tms380tr_close(dev);
 	madgemc_chipset_close(dev);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }


