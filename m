Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbSJ2BtX>; Mon, 28 Oct 2002 20:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261478AbSJ2BtX>; Mon, 28 Oct 2002 20:49:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24070 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261463AbSJ2BtQ>;
	Mon, 28 Oct 2002 20:49:16 -0500
Message-ID: <3DBDEA80.6040108@pobox.com>
Date: Mon, 28 Oct 2002 20:55:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tms380tr update
References: <Pine.LNX.4.44.0210282252310.774-100000@gfrw1044.bocc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Friedrich wrote:

>Hi,
>
>it looks like linuxtr.net seems to be down, so i'm sending this here
>instead...
>
>This one fixes the following problems:
>
>o add spinlock to fix race condition in tms380tr.
>o fix startup of tmsisa to not register and unregister devices multiple
>  times, so hotplug doesn't run wild.
>o add support for statically compiling tmsisa into kernel (untested).
>
>--jochen
>
>
>diff -u -r linux-2.5.44.orig/drivers/net/Space.c linux-2.5.44/drivers/net/Space.c
>--- linux-2.5.44.orig/drivers/net/Space.c	2002-10-19 06:01:12.000000000 +0200
>+++ linux-2.5.44/drivers/net/Space.c	2002-10-28 22:54:13.000000000 +0100
>@@ -567,6 +567,7 @@
> #ifdef CONFIG_TR
> /* Token-ring device probe */
> extern int ibmtr_probe(struct net_device *);
>+extern int tms_isa_probe(struct net_device *dev);
> extern int smctr_probe(struct net_device *);
>
> static int
>@@ -576,6 +577,9 @@
> #ifdef CONFIG_IBMTR
> 	&& ibmtr_probe(dev)
> #endif
>+#ifdef CONFIG_TMSISA
>+	&& tms_isa_probe(dev)
>+#endif
> #ifdef CONFIG_SMCTR
> 	&& smctr_probe(dev)
> #endif
>diff -u -r linux-2.5.44.orig/drivers/net/tokenring/tms380tr.c linux-2.5.44/drivers/net/tokenring/tms380tr.c
>--- linux-2.5.44.orig/drivers/net/tokenring/tms380tr.c	2002-10-19 06:01:57.000000000 +0200
>+++ linux-2.5.44/drivers/net/tokenring/tms380tr.c	2002-10-28 22:32:05.000000000 +0100
>@@ -57,6 +57,7 @@
>  *				as well.
>  *      14-Jan-01	JF	Fix DMA on ifdown/ifup sequences. Some
>  *      			cleanup.
>+ *	13-Jan-02	JF	Add spinlock to fix race condition.
>  *
>  *  To do:
>  *    1. Multi/Broadcast packet handling (this may have fixed itself)
>@@ -253,6 +254,9 @@
> 	struct net_local *tp = (struct net_local *)dev->priv;
> 	int err;
>
>+	/* init the spinlock */
>+	tp->lock = (spinlock_t) SPIN_LOCK_UNLOCKED;
>+
>  
>
use spin_lock_init()...

>@@ -641,18 +646,22 @@
> 		 * NOTE: We *must* always leave one unused TPL in the chain,
> 		 * because otherwise the adapter might send frames twice.
> 		 */
>+		spin_lock_irqsave(&(tp->lock), flags);
> 		if(tp->TplFree->NextTPLPtr->BusyFlag)	/* No free TPL */
> 		{
> 			if (tms380tr_debug > 0)
> 				printk(KERN_INFO "%s: No free TPL\n", dev->name);
>+				spin_unlock_irqrestore(&(tp->lock), flags);
> 			return;
> 		}
>
> 		/* Send first buffer from queue */
> 		skb = skb_dequeue(&tp->SendSkbQueue);
> 		if(skb == NULL)
>+		{
>+			spin_unlock_irqrestore(&(tp->lock), flags);
> 			return;
>-
>+		}
> 		tp->QueueSkb++;
> 		dmabuf = 0;
>
>@@ -700,6 +709,7 @@
>
> 		/* Let adapter send the frame. */
> 		tms380tr_exec_sifcmd(dev, CMD_TX_VALID);
>+		spin_unlock_irqrestore(&(tp->lock), flags);
>  
>
please remove the non-standard parens from the &tp->lock reference...


>@@ -131,9 +136,25 @@
> {
>         static int versionprinted;
> 	struct net_local *tp;
>-	int j;
>+	int i,j;
> 	struct tms_isa_card *card;
>
>+	if (!dev->base_addr)
>+		for(i = 0; portlist[i]; i++)
>+			{
>+				if(check_region(portlist[i], TMS_ISA_IO_EXTENT))
>+					continue;
>+
>+				if(tms_isa_probe1(portlist[i]))
>+					continue;
>+
>+				dev->base_addr = portlist[i];
>+				break;
>+			}
>+
>+	if(!dev->base_addr)
>+		return -1;
>+
> 	if(check_region(dev->base_addr, TMS_ISA_IO_EXTENT))
> 		return -1;
>
>  
>
_all_ uses of check_region are racy and wrong.  use request_region only, 
and check its return value.


>@@ -386,51 +407,54 @@
> 	num = 0;
> 	if (io[0])
> 	{ /* Only probe addresses from command line */
>+		dev = init_trdev(NULL, 0);
>+		if (!dev)
>+			return (-ENOMEM);
> 		for (i = 0; i < ISATR_MAX_ADAPTERS; i++)
> 	       	{
> 			if (io[i] == 0)
> 				continue;
>-
>-			dev = init_trdev(NULL, 0);
>-			if (!dev)
>-				return (-ENOMEM);
>
> 			dev->base_addr = io[i];
> 			dev->irq       = irq[i];
> 			dev->dma       = dma[i];
>
>-			if (tms_isa_probe(dev))
>+			if (!tms_isa_probe(dev))
> 			{
>-				unregister_netdev(dev);
>-				kfree(dev);
>-			}
>-			else
> 				num++;
>+				dev = init_trdev(NULL, 0);
>+				if (!dev)
>+					return (-ENOMEM);
>  
>
by this point you have successfully registered at least one card. 
 either unregister them all before returning ENOMEM, or return success 
and simply warn that not all adapters initialized successfully.


>+			}
> 		}
>+		unregister_netdev(dev);
>+		kfree(dev);
> 	}
>        	else
>        	{
>+		dev = init_trdev(NULL, 0);
>+		if (!dev)
>+			return (-ENOMEM);
>+
> 		for(i = 0; portlist[i]; i++)
> 		{
> 			if (num >= ISATR_MAX_ADAPTERS)
> 				continue;
>-
>-			dev = init_trdev(NULL, 0);
>-			if (!dev)
>-				return (-ENOMEM);
>
> 			dev->base_addr = portlist[i];
> 			dev->irq       = irq[num];
> 			dev->dma       = dma[num];
>
>-			if (tms_isa_probe(dev))
>+			if (!tms_isa_probe(dev))
> 			{
>-				unregister_netdev(dev);
>-				kfree(dev);
>-			}
>-			else
> 				num++;
>+				dev = init_trdev(NULL, 0);
>+				if (!dev)
>+					return (-ENOMEM);
>  
>
likewise



