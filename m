Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265027AbSKAOQe>; Fri, 1 Nov 2002 09:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265028AbSKAOQe>; Fri, 1 Nov 2002 09:16:34 -0500
Received: from mail.scram.de ([195.226.127.117]:16583 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S265027AbSKAOQ3>;
	Fri, 1 Nov 2002 09:16:29 -0500
Date: Fri, 1 Nov 2002 15:16:53 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Garzik <jgarzik@pobox.com>, <phillim2@comcast.net>
Subject: [PATCH] Update of tms380tr / tmsisa for 2.5.45
Message-ID: <Pine.LNX.4.44.0211011511200.14458-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This one fixes the following problems:

o add spinlock to fix race condition in tms380tr.
o fix startup of tmsisa to not register and unregister devices multiple
  times, so hotplug doesn't run wild.
o add support for statically compiling tmsisa into kernel.

Have fun!
--jochen

diff -u -r linux-2.5.45.orig/drivers/net/Space.c linux-2.5.45/drivers/net/Space.c
--- linux-2.5.45.orig/drivers/net/Space.c	2002-10-31 01:41:55.000000000 +0100
+++ linux-2.5.45/drivers/net/Space.c	2002-11-01 13:30:51.000000000 +0100
@@ -563,6 +563,7 @@
 #ifdef CONFIG_TR
 /* Token-ring device probe */
 extern int ibmtr_probe(struct net_device *);
+extern int tms_isa_probe(struct net_device *dev);
 extern int smctr_probe(struct net_device *);

 static int
@@ -572,6 +573,9 @@
 #ifdef CONFIG_IBMTR
 	&& ibmtr_probe(dev)
 #endif
+#ifdef CONFIG_TMSISA
+	&& tms_isa_probe(dev)
+#endif
 #ifdef CONFIG_SMCTR
 	&& smctr_probe(dev)
 #endif
diff -u -r linux-2.5.45.orig/drivers/net/tokenring/tms380tr.c linux-2.5.45/drivers/net/tokenring/tms380tr.c
--- linux-2.5.45.orig/drivers/net/tokenring/tms380tr.c	2002-10-31 01:42:59.000000000 +0100
+++ linux-2.5.45/drivers/net/tokenring/tms380tr.c	2002-11-01 13:11:06.000000000 +0100
@@ -57,6 +57,7 @@
  *				as well.
  *      14-Jan-01	JF	Fix DMA on ifdown/ifup sequences. Some
  *      			cleanup.
+ *	13-Jan-02	JF	Add spinlock to fix race condition.
  *
  *  To do:
  *    1. Multi/Broadcast packet handling (this may have fixed itself)
@@ -253,6 +254,9 @@
 	struct net_local *tp = (struct net_local *)dev->priv;
 	int err;

+	/* init the spinlock */
+	spin_lock_init(tp->lock);
+
 	/* Reset the hardware here. Don't forget to set the station address. */

 	if(dev->dma > 0)
@@ -630,6 +634,7 @@
 	TPL *tpl;
 	short length;
 	unsigned char *buf;
+	unsigned long flags;
 	struct sk_buff *skb;
 	int i;
 	dma_addr_t dmabuf, newbuf;
@@ -641,18 +646,22 @@
 		 * NOTE: We *must* always leave one unused TPL in the chain,
 		 * because otherwise the adapter might send frames twice.
 		 */
+		spin_lock_irqsave(&tp->lock, flags);
 		if(tp->TplFree->NextTPLPtr->BusyFlag)	/* No free TPL */
 		{
 			if (tms380tr_debug > 0)
 				printk(KERN_INFO "%s: No free TPL\n", dev->name);
+				spin_unlock_irqrestore(&tp->lock, flags);
 			return;
 		}

 		/* Send first buffer from queue */
 		skb = skb_dequeue(&tp->SendSkbQueue);
 		if(skb == NULL)
+		{
+			spin_unlock_irqrestore(&tp->lock, flags);
 			return;
-
+		}
 		tp->QueueSkb++;
 		dmabuf = 0;

@@ -700,6 +709,7 @@

 		/* Let adapter send the frame. */
 		tms380tr_exec_sifcmd(dev, CMD_TX_VALID);
+		spin_unlock_irqrestore(&tp->lock, flags);
 	}

 	return;
@@ -2349,7 +2359,6 @@
 	if (dev->priv == NULL)
 	{
 		struct net_local *tms_local;
-		dma_addr_t buffer;

 		dev->priv = kmalloc(sizeof(struct net_local), GFP_KERNEL | GFP_DMA);
 		if (dev->priv == NULL)
@@ -2363,16 +2372,15 @@
 		init_waitqueue_head(&tms_local->wait_for_tok_int);
 		tms_local->dmalimit = dmalimit;
 		tms_local->pdev = pdev;
-                buffer = pci_map_single(pdev, (void *)tms_local,
+                tms_local->dmabuffer = pci_map_single(pdev, (void *)tms_local,
                         sizeof(struct net_local), PCI_DMA_BIDIRECTIONAL);
-                if (buffer + sizeof(struct net_local) > dmalimit)
+                if (tms_local->dmabuffer + sizeof(struct net_local) > dmalimit)
                 {
 			printk("%s: Memory not accessible for DMA\n",
 				dev->name);
 			tmsdev_term(dev);
 			return -ENOMEM;
 		}
-		tms_local->dmabuffer = buffer;
 	}

 	/* These can be overridden by the card driver if needed */
diff -u -r linux-2.5.45.orig/drivers/net/tokenring/tms380tr.h linux-2.5.45/drivers/net/tokenring/tms380tr.h
--- linux-2.5.45.orig/drivers/net/tokenring/tms380tr.h	2002-10-31 01:42:22.000000000 +0100
+++ linux-2.5.45/drivers/net/tokenring/tms380tr.h	2002-10-31 11:38:48.000000000 +0100
@@ -1135,6 +1135,7 @@
 	unsigned short (*sifreadw)(struct net_device *, unsigned short);
 	void (*sifwritew)(struct net_device *, unsigned short, unsigned short);

+	spinlock_t lock;                /* SMP protection */
 	void *tmspriv;
 } NET_LOCAL;

diff -u -r linux-2.5.45.orig/drivers/net/tokenring/tmsisa.c linux-2.5.45/drivers/net/tokenring/tmsisa.c
--- linux-2.5.45.orig/drivers/net/tokenring/tmsisa.c	2002-10-31 01:41:55.000000000 +0100
+++ linux-2.5.45/drivers/net/tokenring/tmsisa.c	2002-11-01 15:09:46.000000000 +0100
@@ -16,10 +16,15 @@
  *    AF        Adam Fritzler           mid@auk.cx
  *    JF	Jochen Friedrich	jochen@scram.de
  *
+ *  Modification History:
+ *	14-Jan-01	JF	Created
+ *	01-Nov-02	JF	Fixed probe of card for static compilation.
+ *				Fixed module init to not make hotplug go wild.
+ *
  *  TODO:
  *	1. Add support for Proteon TR ISA adapters (1392, 1392+)
  */
-static const char version[] = "tmsisa.c: v1.00 14/01/2001 by Jochen Friedrich\n";
+static const char version[] = "tmsisa.c: v1.01 01/11/2002 by Jochen Friedrich\n";

 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -131,22 +136,53 @@
 {
         static int versionprinted;
 	struct net_local *tp;
-	int j;
+	int i,j;
 	struct tms_isa_card *card;

-	if(check_region(dev->base_addr, TMS_ISA_IO_EXTENT))
-		return -1;
+	if (!dev->base_addr)
+	{
+		for(i = 0; portlist[i]; i++)
+		{
+			if (!request_region(portlist[i], TMS_ISA_IO_EXTENT, isa_cardname))
+				continue;
+
+			if(tms_isa_probe1(portlist[i]))
+			{
+				release_region(dev->base_addr, TMS_ISA_IO_EXTENT);
+				continue;
+			}
+
+			dev->base_addr = portlist[i];
+			break;
+		}
+		if(!dev->base_addr)
+			return -1;
+	}
+	else
+	{
+		if (!request_region(dev->base_addr, TMS_ISA_IO_EXTENT, isa_cardname))
+			return -1;
+
+		if(tms_isa_probe1(dev->base_addr))
+		{
+			release_region(dev->base_addr, TMS_ISA_IO_EXTENT);
+			return -1;
+  		}
+	}
+
+	/* At this point we have found a valid card. */

-	if(tms_isa_probe1(dev->base_addr))
-		return -1;
-
 	if (versionprinted++ == 0)
 		printk("%s", version);
-
-	/* At this point we have found a valid card. */
-
-	if (!request_region(dev->base_addr, TMS_ISA_IO_EXTENT, isa_cardname))
+
+#ifndef MODULE
+	dev = init_trdev(dev, 0);
+	if (!dev)
+	{
+		release_region(dev->base_addr, TMS_ISA_IO_EXTENT);
 		return -1;
+	}
+#endif

 	if (tmsdev_init(dev, ISA_MAX_ADDRESS, NULL))
        	{
@@ -386,51 +422,54 @@
 	num = 0;
 	if (io[0])
 	{ /* Only probe addresses from command line */
+		dev = init_trdev(NULL, 0);
+		if (!dev)
+			return (-ENOMEM);
 		for (i = 0; i < ISATR_MAX_ADAPTERS; i++)
 	       	{
 			if (io[i] == 0)
 				continue;
-
-			dev = init_trdev(NULL, 0);
-			if (!dev)
-				return (-ENOMEM);

 			dev->base_addr = io[i];
 			dev->irq       = irq[i];
 			dev->dma       = dma[i];

-			if (tms_isa_probe(dev))
+			if (!tms_isa_probe(dev))
 			{
-				unregister_netdev(dev);
-				kfree(dev);
-			}
-			else
 				num++;
+				dev = init_trdev(NULL, 0);
+				if (!dev)
+					return (0);
+			}
 		}
+		unregister_netdev(dev);
+		kfree(dev);
 	}
        	else
        	{
+		dev = init_trdev(NULL, 0);
+		if (!dev)
+			return (-ENOMEM);
+
 		for(i = 0; portlist[i]; i++)
 		{
 			if (num >= ISATR_MAX_ADAPTERS)
 				continue;
-
-			dev = init_trdev(NULL, 0);
-			if (!dev)
-				return (-ENOMEM);

 			dev->base_addr = portlist[i];
 			dev->irq       = irq[num];
 			dev->dma       = dma[num];

-			if (tms_isa_probe(dev))
+			if (!tms_isa_probe(dev))
 			{
-				unregister_netdev(dev);
-				kfree(dev);
-			}
-			else
 				num++;
+				dev = init_trdev(NULL, 0);
+				if (!dev)
+					return (0);
+			}
 		}
+		unregister_netdev(dev);
+		kfree(dev);
 	}
 	printk(KERN_NOTICE "tmsisa.c: %d cards found.\n", num);
 	/* Probe for cards. */


