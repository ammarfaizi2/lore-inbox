Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266354AbSKKLnp>; Mon, 11 Nov 2002 06:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266387AbSKKLnp>; Mon, 11 Nov 2002 06:43:45 -0500
Received: from mail.scram.de ([195.226.127.117]:20955 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S266354AbSKKLn3>;
	Mon, 11 Nov 2002 06:43:29 -0500
Date: Mon, 11 Nov 2002 12:49:52 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@ayse
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] tms380tr / tmsisa 2.5.47
Message-ID: <Pine.LNX.4.44.0211111244070.980-100000@ayse>
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
o remove unnecessary console SPAM during boot.
o fixed probing of ISA devices in tmsisa.

--jochen

diff -r -u linux-2.5.47.orig/drivers/net/tokenring/tms380tr.c linux-2.5.47/drivers/net/tokenring/tms380tr.c
--- linux-2.5.47.orig/drivers/net/tokenring/tms380tr.c	2002-11-11 04:28:17.000000000 +0100
+++ linux-2.5.47/drivers/net/tokenring/tms380tr.c	2002-11-11 11:09:40.000000000 +0100
@@ -57,6 +57,9 @@
  *				as well.
  *      14-Jan-01	JF	Fix DMA on ifdown/ifup sequences. Some
  *      			cleanup.
+ *	13-Jan-02	JF	Add spinlock to fix race condition.
+ *	09-Nov-02	JF	Fixed printks to not SPAM the console during
+ *				normal operation.
  *
  *  To do:
  *    1. Multi/Broadcast packet handling (this may have fixed itself)
@@ -68,7 +71,7 @@
  */

 #ifdef MODULE
-static const char version[] = "tms380tr.c: v1.08 14/01/2001 by Christoph Goos, Adam Fritzler\n";
+static const char version[] = "tms380tr.c: v1.09 09/11/2002 by Christoph Goos, Adam Fritzler\n";
 #endif

 #include <linux/module.h>
@@ -235,7 +238,7 @@
 static int __init tms380tr_init_card(struct net_device *dev)
 {
 	if(tms380tr_debug > 3)
-		printk("%s: tms380tr_init_card\n", dev->name);
+		printk(KERN_DEBUG "%s: tms380tr_init_card\n", dev->name);

 	return (0);
 }
@@ -253,6 +256,9 @@
 	struct net_local *tp = (struct net_local *)dev->priv;
 	int err;

+	/* init the spinlock */
+	spin_lock_init(tp->lock);
+
 	/* Reset the hardware here. Don't forget to set the station address. */

 	if(dev->dma > 0)
@@ -278,7 +284,7 @@
 	tp->timer.data		= (unsigned long)dev;
 	add_timer(&tp->timer);

-	printk(KERN_INFO "%s: Adapter RAM size: %dK\n",
+	printk(KERN_DEBUG "%s: Adapter RAM size: %dK\n",
 	       dev->name, tms380tr_read_ptr(dev));

 	tms380tr_enable_interrupts(dev);
@@ -341,25 +347,25 @@
 	tms380tr_init_net_local(dev);

 	if(tms380tr_debug > 3)
-		printk(KERN_INFO "%s: Resetting adapter...\n", dev->name);
+		printk(KERN_DEBUG "%s: Resetting adapter...\n", dev->name);
 	err = tms380tr_reset_adapter(dev);
 	if(err < 0)
 		return (-1);

 	if(tms380tr_debug > 3)
-		printk(KERN_INFO "%s: Bringup diags...\n", dev->name);
+		printk(KERN_DEBUG "%s: Bringup diags...\n", dev->name);
 	err = tms380tr_bringup_diags(dev);
 	if(err < 0)
 		return (-1);

 	if(tms380tr_debug > 3)
-		printk(KERN_INFO "%s: Init adapter...\n", dev->name);
+		printk(KERN_DEBUG "%s: Init adapter...\n", dev->name);
 	err = tms380tr_init_adapter(dev);
 	if(err < 0)
 		return (-1);

 	if(tms380tr_debug > 3)
-		printk(KERN_INFO "%s: Done!\n", dev->name);
+		printk(KERN_DEBUG "%s: Done!\n", dev->name);
 	return (0);
 }

@@ -630,6 +636,7 @@
 	TPL *tpl;
 	short length;
 	unsigned char *buf;
+	unsigned long flags;
 	struct sk_buff *skb;
 	int i;
 	dma_addr_t dmabuf, newbuf;
@@ -641,18 +648,22 @@
 		 * NOTE: We *must* always leave one unused TPL in the chain,
 		 * because otherwise the adapter might send frames twice.
 		 */
+		spin_lock_irqsave(&tp->lock, flags);
 		if(tp->TplFree->NextTPLPtr->BusyFlag)	/* No free TPL */
 		{
 			if (tms380tr_debug > 0)
-				printk(KERN_INFO "%s: No free TPL\n", dev->name);
+				printk(KERN_DEBUG "%s: No free TPL\n", dev->name);
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

@@ -700,6 +711,7 @@

 		/* Let adapter send the frame. */
 		tms380tr_exec_sifcmd(dev, CMD_TX_VALID);
+		spin_unlock_irqrestore(&tp->lock, flags);
 	}

 	return;
@@ -775,7 +787,7 @@
 	unsigned short irq_type;

 	if(dev == NULL) {
-		printk("%s: irq %d for unknown device.\n", dev->name, irq);
+		printk(KERN_INFO "%s: irq %d for unknown device.\n", dev->name, irq);
 		return;
 	}

@@ -787,7 +799,7 @@
 		irq_type &= STS_IRQ_MASK;

 		if(!tms380tr_chk_ssb(tp, irq_type)) {
-			printk(KERN_INFO "%s: DATA LATE occurred\n", dev->name);
+			printk(KERN_DEBUG "%s: DATA LATE occurred\n", dev->name);
 			break;
 		}

@@ -845,7 +857,7 @@
 			break;

 		default:
-			printk(KERN_INFO "Unknown Token Ring IRQ (0x%04x)\n", irq_type);
+			printk(KERN_DEBUG "Unknown Token Ring IRQ (0x%04x)\n", irq_type);
 			break;
 		}

@@ -1379,7 +1391,7 @@
 	do {
 		retry_cnt--;
 		if(tms380tr_debug > 3)
-			printk(KERN_INFO "BUD-Status: ");
+			printk(KERN_DEBUG "BUD-Status: ");
 		loop_cnt = BUD_MAX_LOOPCNT;	/* maximum: three seconds*/
 		do {			/* Inspect BUD results */
 			loop_cnt--;
@@ -1388,7 +1400,7 @@
 			Status &= STS_MASK;

 			if(tms380tr_debug > 3)
-				printk(KERN_INFO " %04X \n", Status);
+				printk(KERN_DEBUG " %04X \n", Status);
 			/* BUD successfully completed */
 			if(Status == STS_INITIALIZE)
 				return (1);
@@ -1445,10 +1457,10 @@

 	if(tms380tr_debug > 3)
 	{
-		printk(KERN_INFO "%s: buffer (real): %lx\n", dev->name, (long) &tp->scb);
-		printk(KERN_INFO "%s: buffer (virt): %lx\n", dev->name, (long) ((char *)&tp->scb - (char *)tp) + tp->dmabuffer);
-		printk(KERN_INFO "%s: buffer (DMA) : %lx\n", dev->name, (long) tp->dmabuffer);
-		printk(KERN_INFO "%s: buffer (tp)  : %lx\n", dev->name, (long) tp);
+		printk(KERN_DEBUG "%s: buffer (real): %lx\n", dev->name, (long) &tp->scb);
+		printk(KERN_DEBUG "%s: buffer (virt): %lx\n", dev->name, (long) ((char *)&tp->scb - (char *)tp) + tp->dmabuffer);
+		printk(KERN_DEBUG "%s: buffer (DMA) : %lx\n", dev->name, (long) tp->dmabuffer);
+		printk(KERN_DEBUG "%s: buffer (tp)  : %lx\n", dev->name, (long) tp);
 	}
 	/* Maximum: three initialization retries */
 	retry_cnt = INIT_MAX_RETRIES;
@@ -1799,7 +1811,7 @@

 	if(tms380tr_debug > 3)
 	{
-		printk("%s: AdapterCheckBlock: ", dev->name);
+		printk(KERN_DEBUG "%s: AdapterCheckBlock: ", dev->name);
 		for (i = 0; i < 4; i++)
 			printk("%04X", AdapterCheckBlock[i]);
 		printk("\n");
@@ -1876,52 +1888,52 @@
 			break;

 		case ILLEGAL_OP_CODE:
-			printk("%s: Illegal operation code in firmware\n",
+			printk(KERN_INFO "%s: Illegal operation code in firmware\n",
 				dev->name);
 			/* Parm[0-3]: adapter internal register R13-R15 */
 			break;

 		case PARITY_ERRORS:
-			printk("%s: Adapter internal bus parity error\n",
+			printk(KERN_INFO "%s: Adapter internal bus parity error\n",
 				dev->name);
 			/* Parm[0-3]: adapter internal register R13-R15 */
 			break;

 		case RAM_DATA_ERROR:
-			printk("%s: RAM data error\n", dev->name);
+			printk(KERN_INFO "%s: RAM data error\n", dev->name);
 			/* Parm[0-1]: MSW/LSW address of RAM location. */
 			break;

 		case RAM_PARITY_ERROR:
-			printk("%s: RAM parity error\n", dev->name);
+			printk(KERN_INFO "%s: RAM parity error\n", dev->name);
 			/* Parm[0-1]: MSW/LSW address of RAM location. */
 			break;

 		case RING_UNDERRUN:
-			printk("%s: Internal DMA underrun detected\n",
+			printk(KERN_INFO "%s: Internal DMA underrun detected\n",
 				dev->name);
 			break;

 		case INVALID_IRQ:
-			printk("%s: Unrecognized interrupt detected\n",
+			printk(KERN_INFO "%s: Unrecognized interrupt detected\n",
 				dev->name);
 			/* Parm[0-3]: adapter internal register R13-R15 */
 			break;

 		case INVALID_ERROR_IRQ:
-			printk("%s: Unrecognized error interrupt detected\n",
+			printk(KERN_INFO "%s: Unrecognized error interrupt detected\n",
 				dev->name);
 			/* Parm[0-3]: adapter internal register R13-R15 */
 			break;

 		case INVALID_XOP:
-			printk("%s: Unrecognized XOP request detected\n",
+			printk(KERN_INFO "%s: Unrecognized XOP request detected\n",
 				dev->name);
 			/* Parm[0-3]: adapter internal register R13-R15 */
 			break;

 		default:
-			printk("%s: Unknown status", dev->name);
+			printk(KERN_INFO "%s: Unknown status", dev->name);
 			break;
 	}

@@ -2072,14 +2084,14 @@

 			if((HighAc != LowAc) || (HighAc == AC_NOT_RECOGNIZED))
 			{
-				printk(KERN_INFO "%s: (DA=%08lX not recognized)",
+				printk(KERN_DEBUG "%s: (DA=%08lX not recognized)\n",
 					dev->name,
 					*(unsigned long *)&tpl->MData[2+2]);
 			}
 			else
 			{
 				if(tms380tr_debug > 3)
-					printk("%s: Directed frame tx'd\n",
+					printk(KERN_DEBUG "%s: Directed frame tx'd\n",
 						dev->name);
 			}
 		}
@@ -2088,7 +2100,7 @@
 			if(!DIRECTED_FRAME(tpl))
 			{
 				if(tms380tr_debug > 3)
-					printk("%s: Broadcast frame tx'd\n",
+					printk(KERN_DEBUG "%s: Broadcast frame tx'd\n",
 						dev->name);
 			}
 		}
@@ -2165,7 +2177,7 @@
 			tms380tr_update_rcv_stats(tp,ReceiveDataPtr,Length);

 			if(tms380tr_debug > 3)
-				printk("%s: Packet Length %04X (%d)\n",
+				printk(KERN_DEBUG "%s: Packet Length %04X (%d)\n",
 					dev->name, Length, Length);

 			/* Indicate the received frame to system the
@@ -2349,12 +2361,11 @@
 	if (dev->priv == NULL)
 	{
 		struct net_local *tms_local;
-		dma_addr_t buffer;

 		dev->priv = kmalloc(sizeof(struct net_local), GFP_KERNEL | GFP_DMA);
 		if (dev->priv == NULL)
 		{
-                        printk("%s: Out of memory for DMA\n",
+                        printk(KERN_INFO "%s: Out of memory for DMA\n",
                                 dev->name);
 			return -ENOMEM;
 		}
@@ -2363,16 +2374,15 @@
 		init_waitqueue_head(&tms_local->wait_for_tok_int);
 		tms_local->dmalimit = dmalimit;
 		tms_local->pdev = pdev;
-                buffer = pci_map_single(pdev, (void *)tms_local,
+                tms_local->dmabuffer = pci_map_single(pdev, (void *)tms_local,
                         sizeof(struct net_local), PCI_DMA_BIDIRECTIONAL);
-                if (buffer + sizeof(struct net_local) > dmalimit)
+                if (tms_local->dmabuffer + sizeof(struct net_local) > dmalimit)
                 {
-			printk("%s: Memory not accessible for DMA\n",
+			printk(KERN_INFO "%s: Memory not accessible for DMA\n",
 				dev->name);
 			tmsdev_term(dev);
 			return -ENOMEM;
 		}
-		tms_local->dmabuffer = buffer;
 	}

 	/* These can be overridden by the card driver if needed */
@@ -2403,7 +2413,7 @@

 int init_module(void)
 {
-	printk("%s", version);
+	printk(KERN_DEBUG "%s", version);

 	TMS380_module = &__this_module;
 	return 0;
diff -r -u linux-2.5.47.orig/drivers/net/tokenring/tms380tr.h linux-2.5.47/drivers/net/tokenring/tms380tr.h
--- linux-2.5.47.orig/drivers/net/tokenring/tms380tr.h	2002-11-11 04:28:07.000000000 +0100
+++ linux-2.5.47/drivers/net/tokenring/tms380tr.h	2002-11-11 11:09:43.000000000 +0100
@@ -1135,6 +1135,7 @@
 	unsigned short (*sifreadw)(struct net_device *, unsigned short);
 	void (*sifwritew)(struct net_device *, unsigned short, unsigned short);

+	spinlock_t lock;                /* SMP protection */
 	void *tmspriv;
 } NET_LOCAL;

diff -r -u linux-2.5.47.orig/drivers/net/tokenring/tmsisa.c linux-2.5.47/drivers/net/tokenring/tmsisa.c
--- linux-2.5.47.orig/drivers/net/tokenring/tmsisa.c	2002-11-11 04:28:03.000000000 +0100
+++ linux-2.5.47/drivers/net/tokenring/tmsisa.c	2002-11-11 11:09:34.000000000 +0100
@@ -16,10 +16,18 @@
  *    AF        Adam Fritzler           mid@auk.cx
  *    JF	Jochen Friedrich	jochen@scram.de
  *
+ *  Modification History:
+ *	14-Jan-01	JF	Created
+ *	28-Oct-02	JF	Fixed probe of card for static compilation.
+ *				Fixed module init to not make hotplug go wild.
+ *	09-Nov-02	JF	Fixed early bail out on out of memory
+ *				situations if multiple cards are found.
+ *				Cleaned up some unnecessary console SPAM.
+ *
  *  TODO:
  *	1. Add support for Proteon TR ISA adapters (1392, 1392+)
  */
-static const char version[] = "tmsisa.c: v1.00 14/01/2001 by Jochen Friedrich\n";
+static const char version[] = "tmsisa.c: v1.02 09/11/2002 by Jochen Friedrich\n";

 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -131,22 +139,53 @@
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

-	if(tms_isa_probe1(dev->base_addr))
-		return -1;
-
-	if (versionprinted++ == 0)
-		printk("%s", version);
-
 	/* At this point we have found a valid card. */
-
-	if (!request_region(dev->base_addr, TMS_ISA_IO_EXTENT, isa_cardname))
+
+	if (versionprinted++ == 0)
+		printk(KERN_DEBUG "%s", version);
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
@@ -158,7 +197,7 @@

 	tms_isa_read_eeprom(dev);

-	printk("%s:    Ring Station Address: ", dev->name);
+	printk(KERN_DEBUG "%s:    Ring Station Address: ", dev->name);
 	printk("%2.2x", dev->dev_addr[0]);
 	for (j = 1; j < 6; j++)
 		printk(":%2.2x", dev->dev_addr[j]);
@@ -191,7 +230,7 @@

                 if(irqlist[j] == 0)
                 {
-                        printk("%s: AutoSelect no IRQ available\n", dev->name);
+                        printk(KERN_INFO "%s: AutoSelect no IRQ available\n", dev->name);
 			release_region(dev->base_addr, TMS_ISA_IO_EXTENT);
 			tmsdev_term(dev);
 			return -1;
@@ -204,7 +243,7 @@
 				break;
 		if (irqlist[j] == 0)
 		{
-			printk("%s: Illegal IRQ %d specified\n",
+			printk(KERN_INFO "%s: Illegal IRQ %d specified\n",
 				dev->name, dev->irq);
 			release_region(dev->base_addr, TMS_ISA_IO_EXTENT);
 			tmsdev_term(dev);
@@ -213,7 +252,7 @@
 		if (request_irq(dev->irq, tms380tr_interrupt, 0,
 			isa_cardname, dev))
 		{
-                        printk("%s: Selected IRQ %d not available\n",
+                        printk(KERN_INFO "%s: Selected IRQ %d not available\n",
 				dev->name, dev->irq);
 			release_region(dev->base_addr, TMS_ISA_IO_EXTENT);
 			tmsdev_term(dev);
@@ -232,7 +271,7 @@

 		if(dmalist[j] == 0)
 		{
-			printk("%s: AutoSelect no DMA available\n", dev->name);
+			printk(KERN_INFO "%s: AutoSelect no DMA available\n", dev->name);
 			release_region(dev->base_addr, TMS_ISA_IO_EXTENT);
 			free_irq(dev->irq, dev);
 			tmsdev_term(dev);
@@ -246,7 +285,7 @@
 				break;
 		if (dmalist[j] == 0)
 		{
-                        printk("%s: Illegal DMA %d specified\n",
+                        printk(KERN_INFO "%s: Illegal DMA %d specified\n",
 				dev->name, dev->dma);
 			release_region(dev->base_addr, TMS_ISA_IO_EXTENT);
 			free_irq(dev->irq, dev);
@@ -255,7 +294,7 @@
 		}
 		if (request_dma(dev->dma, isa_cardname))
 		{
-                        printk("%s: Selected DMA %d not available\n",
+                        printk(KERN_INFO "%s: Selected DMA %d not available\n",
 				dev->name, dev->dma);
 			release_region(dev->base_addr, TMS_ISA_IO_EXTENT);
 			free_irq(dev->irq, dev);
@@ -264,7 +303,7 @@
 		}
 	}

-	printk("%s:    IO: %#4lx  IRQ: %d  DMA: %d\n",
+	printk(KERN_DEBUG "%s:    IO: %#4lx  IRQ: %d  DMA: %d\n",
 	       dev->name, dev->base_addr, dev->irq, dev->dma);

 	if (register_trdev(dev) == 0)
@@ -285,7 +324,7 @@
 	}
 	else
 	{
-		printk("%s: register_trdev() returned non-zero.\n", dev->name);
+		printk("KERN_INFO %s: register_trdev() returned non-zero.\n", dev->name);
 		release_region(dev->base_addr, TMS_ISA_IO_EXTENT);
 		free_irq(dev->irq, dev);
 		free_dma(dev->dma);
@@ -386,56 +425,61 @@
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
+					goto partial;
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
+					goto partial;
+			}
 		}
+		unregister_netdev(dev);
+		kfree(dev);
 	}
-	printk(KERN_NOTICE "tmsisa.c: %d cards found.\n", num);
+partial:
+	printk(KERN_DEBUG "tmsisa.c: %d cards found.\n", num);
 	/* Probe for cards. */
 	if (num == 0) {
 		printk(KERN_NOTICE "tmsisa.c: No cards found.\n");
+		return (-ENODEV);
 	}
 	return (0);
 }

