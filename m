Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270266AbRHRRtb>; Sat, 18 Aug 2001 13:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270264AbRHRRtW>; Sat, 18 Aug 2001 13:49:22 -0400
Received: from odyssey.netrox.net ([204.253.4.3]:12739 "EHLO t-rex.netrox.net")
	by vger.kernel.org with ESMTP id <S270279AbRHRRtK>;
	Sat, 18 Aug 2001 13:49:10 -0400
Subject: [PATCH] let Net Devices feed Entropy, updated (2/2)
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <998117417.2184.44.camel@phantasy>
In-Reply-To: <998117417.2184.44.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 18 Aug 2001 13:49:04 -0400
Message-Id: <998156967.2062.61.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

part 2 of 2, against 2.4.8-ac7. see previous email for more information.

this patch enables the 3c501, 3c505, 3c509, 3c523, 3c59x, 8139too,
cs89x0, eepro, eepro100, eexpress, ibmlana, ne2k-pci, pcnet_cs,
xircom_tulic_cb, sk_mca, smc9194, tulic_core, and wavelan drivers to use
the new flag. all of the drivers which previously contributed entropy
are listed above. *None of these drivers will contribute unless you
enable the configuration setting*




diff -urN linux-2.4.8-ac7/drivers/net/3c501.c linux/drivers/net/3c501.c
--- linux-2.4.8-ac7/drivers/net/3c501.c	Tue Jul 17 21:53:55 2001
+++ linux/drivers/net/3c501.c	Sat Aug 18 01:52:29 2001
@@ -410,7 +410,8 @@
 	if (el_debug > 2)
 		printk("%s: Doing el_open()...", dev->name);
 
-	if ((retval = request_irq(dev->irq, &el_interrupt, 0, dev->name, dev)))
+	if ((retval = request_irq(dev->irq, &el_interrupt,
+				SA_SAMPLE_NET_RANDOM, dev->name, dev)))
 		return retval;
 
 	spin_lock_irqsave(&lp->lock, flags);
diff -urN linux-2.4.8-ac7/drivers/net/3c505.c linux/drivers/net/3c505.c
--- linux-2.4.8-ac7/drivers/net/3c505.c	Sat Aug 18 01:55:57 2001
+++ linux/drivers/net/3c505.c	Sat Aug 18 01:52:29 2001
@@ -897,7 +897,8 @@
 	/*
 	 * install our interrupt service routine
 	 */
-	if ((retval = request_irq(dev->irq, &elp_interrupt, 0, dev->name, dev))) {
+	if ((retval = request_irq(dev->irq, &elp_interrupt,
+					SA_SAMPLE_NET_RANDOM, dev->name, dev))) {
 		printk(KERN_ERR "%s: could not allocate IRQ%d\n", dev->name, dev->irq);
 		return retval;
 	}
diff -urN linux-2.4.8-ac7/drivers/net/3c509.c linux/drivers/net/3c509.c
--- linux-2.4.8-ac7/drivers/net/3c509.c	Tue Jul 17 21:53:55 2001
+++ linux/drivers/net/3c509.c	Sat Aug 18 01:52:29 2001
@@ -560,7 +560,8 @@
 	outw(RxReset, ioaddr + EL3_CMD);
 	outw(SetStatusEnb | 0x00, ioaddr + EL3_CMD);
 
-	i = request_irq(dev->irq, &el3_interrupt, 0, dev->name, dev);
+	i = request_irq(dev->irq, &el3_interrupt,
+			SA_SAMPLE_NET_RANDOM, dev->name, dev);
 	if (i) return i;
 
 	EL3WINDOW(0);
diff -urN linux-2.4.8-ac7/drivers/net/3c523.c linux/drivers/net/3c523.c
--- linux-2.4.8-ac7/drivers/net/3c523.c	Wed Jun 20 14:10:53 2001
+++ linux/drivers/net/3c523.c	Sat Aug 18 01:52:29 2001
@@ -280,7 +280,7 @@
 
 	elmc_id_attn586();	/* disable interrupts */
 
-	ret = request_irq(dev->irq, &elmc_interrupt, SA_SHIRQ | SA_SAMPLE_RANDOM,
+	ret = request_irq(dev->irq, &elmc_interrupt, SA_SHIRQ | SA_SAMPLE_NET_RANDOM,
 			  dev->name, dev);
 	if (ret) {
 		printk(KERN_ERR "%s: couldn't get irq %d\n", dev->name, dev->irq);
diff -urN linux-2.4.8-ac7/drivers/net/3c59x.c linux/drivers/net/3c59x.c
--- linux-2.4.8-ac7/drivers/net/3c59x.c	Sat Aug 18 01:55:57 2001
+++ linux/drivers/net/3c59x.c	Sat Aug 18 01:52:29 2001
@@ -1581,7 +1581,7 @@
 
 	/* Use the now-standard shared IRQ implementation. */
 	if ((retval = request_irq(dev->irq, vp->full_bus_master_rx ?
-				&boomerang_interrupt : &vortex_interrupt, SA_SHIRQ, dev->name, dev))) {
+				&boomerang_interrupt : &vortex_interrupt, SA_SHIRQ | SA_SAMPLE_NET_RANDOM, dev->name, dev))) {
 		printk(KERN_ERR "%s: Could not reserve IRQ %d\n", dev->name, dev->irq);
 		goto out;
 	}
diff -urN linux-2.4.8-ac7/drivers/net/8139too.c linux/drivers/net/8139too.c
--- linux-2.4.8-ac7/drivers/net/8139too.c	Sat Aug 18 01:55:57 2001
+++ linux/drivers/net/8139too.c	Sat Aug 18 01:52:29 2001
@@ -1289,7 +1289,8 @@
 
 	DPRINTK ("ENTER\n");
 
-	retval = request_irq (dev->irq, rtl8139_interrupt, SA_SHIRQ, dev->name, dev);
+	retval = request_irq (dev->irq, rtl8139_interrupt,
+			SA_SHIRQ | SA_SAMPLE_NET_RANDOM, dev->name, dev);
 	if (retval) {
 		DPRINTK ("EXIT, returning %d\n", retval);
 		return retval;
diff -urN linux-2.4.8-ac7/drivers/net/cs89x0.c linux/drivers/net/cs89x0.c
--- linux-2.4.8-ac7/drivers/net/cs89x0.c	Sat Aug 18 01:55:58 2001
+++ linux/drivers/net/cs89x0.c	Sat Aug 18 01:52:29 2001
@@ -1057,7 +1057,7 @@
 
 		for (i = 2; i < CS8920_NO_INTS; i++) {
 			if ((1 << dev->irq) & lp->irq_map) {
-				if (request_irq(i, net_interrupt, 0, dev->name, dev) == 0) {
+				if (request_irq(i, net_interrupt, SA_SAMPLE_NET_RANDOM, dev->name, dev) == 0) {
 					dev->irq = i;
 					write_irq(dev, lp->chip_type, i);
 					/* writereg(dev, PP_BufCFG, GENERATE_SW_INTERRUPT); */
diff -urN linux-2.4.8-ac7/drivers/net/eepro.c linux/drivers/net/eepro.c
--- linux-2.4.8-ac7/drivers/net/eepro.c	Sat Aug 18 01:55:58 2001
+++ linux/drivers/net/eepro.c	Sat Aug 18 01:52:29 2001
@@ -944,7 +944,8 @@
 		return -EAGAIN;
 	}
 		
-	if (request_irq(dev->irq , &eepro_interrupt, 0, dev->name, dev)) {
+	if (request_irq(dev->irq , &eepro_interrupt, SA_SAMPLE_NET_RANDOM,
+				dev->name, dev)) {
 		printk("%s: unable to get IRQ %d.\n", dev->name, dev->irq);
 		return -EAGAIN;
 	}
diff -urN linux-2.4.8-ac7/drivers/net/eepro100.c linux/drivers/net/eepro100.c
--- linux-2.4.8-ac7/drivers/net/eepro100.c	Sat Aug 18 01:55:58 2001
+++ linux/drivers/net/eepro100.c	Sat Aug 18 01:52:29 2001
@@ -915,7 +915,8 @@
 	sp->in_interrupt = 0;
 
 	/* .. we can safely take handler calls during init. */
-	retval = request_irq(dev->irq, &speedo_interrupt, SA_SHIRQ, dev->name, dev);
+	retval = request_irq(dev->irq, &speedo_interrupt,
+			SA_SHIRQ | SA_SAMPLE_NET_RANDOM, dev->name, dev);
 	if (retval) {
 		MOD_DEC_USE_COUNT;
 		return retval;
diff -urN linux-2.4.8-ac7/drivers/net/eexpress.c linux/drivers/net/eexpress.c
--- linux-2.4.8-ac7/drivers/net/eexpress.c	Wed Jun 20 14:10:53 2001
+++ linux/drivers/net/eexpress.c	Sat Aug 18 01:52:29 2001
@@ -433,7 +433,8 @@
 	if (!dev->irq || !irqrmap[dev->irq])
 		return -ENXIO;
 
-	ret = request_irq(dev->irq,&eexp_irq,0,dev->name,dev);
+	ret = request_irq(dev->irq,&eexp_irq,SA_SAMPLE_NET_RANDOM,
+			dev->name,dev);
 	if (ret) return ret;
 
 	request_region(ioaddr, EEXP_IO_EXTENT, "EtherExpress");
diff -urN linux-2.4.8-ac7/drivers/net/ibmlana.c linux/drivers/net/ibmlana.c
--- linux-2.4.8-ac7/drivers/net/ibmlana.c	Wed Jun 20 14:10:53 2001
+++ linux/drivers/net/ibmlana.c	Sat Aug 18 01:52:29 2001
@@ -856,7 +856,7 @@
 
 	result =
 	    request_irq(priv->realirq, irq_handler,
-			SA_SHIRQ | SA_SAMPLE_RANDOM, dev->name, dev);
+			SA_SHIRQ | SA_SAMPLE_NET_RANDOM, dev->name, dev);
 	if (result != 0) {
 		printk("%s: failed to register irq %d\n", dev->name,
 		       dev->irq);
diff -urN linux-2.4.8-ac7/drivers/net/ne2k-pci.c linux/drivers/net/ne2k-pci.c
--- linux-2.4.8-ac7/drivers/net/ne2k-pci.c	Wed Jun 20 14:13:18 2001
+++ linux/drivers/net/ne2k-pci.c	Sat Aug 18 01:52:29 2001
@@ -387,7 +387,8 @@
 
 static int ne2k_pci_open(struct net_device *dev)
 {
-	int ret = request_irq(dev->irq, ei_interrupt, SA_SHIRQ, dev->name, dev);
+	int ret = request_irq(dev->irq, ei_interrupt,
+			SA_SHIRQ | SA_SAMPLE_NET_RANDOM, dev->name, dev);
 	if (ret)
 		return ret;
 
diff -urN linux-2.4.8-ac7/drivers/net/pcmcia/pcnet_cs.c linux/drivers/net/pcmcia/pcnet_cs.c
--- linux-2.4.8-ac7/drivers/net/pcmcia/pcnet_cs.c	Tue Jul 17 21:53:55 2001
+++ linux/drivers/net/pcmcia/pcnet_cs.c	Sat Aug 18 01:52:29 2001
@@ -977,7 +977,7 @@
     MOD_INC_USE_COUNT;
 
     set_misc_reg(dev);
-    request_irq(dev->irq, ei_irq_wrapper, SA_SHIRQ, dev_info, dev);
+    request_irq(dev->irq, ei_irq_wrapper, SA_SHIRQ | SA_SAMPLE_NET_RANDOM, dev_info, dev);
 
     info->link_status = 0x00;
     info->watchdog.function = &ei_watchdog;
diff -urN linux-2.4.8-ac7/drivers/net/pcmcia/xircom_cb.c linux/drivers/net/pcmcia/xircom_cb.c
--- linux-2.4.8-ac7/drivers/net/pcmcia/xircom_cb.c	Sat Aug 18 01:55:58 2001
+++ linux/drivers/net/pcmcia/xircom_cb.c	Sat Aug 18 01:52:29 2001
@@ -463,7 +463,8 @@
 	int retval;
 	enter();
 	printk(KERN_INFO "Xircom cardbus adaptor found, registering as %s, using irq %i \n",dev->name,dev->irq);
-	retval = request_irq(dev->irq, &xircom_interrupt, SA_SHIRQ, dev->name, dev);
+	retval = request_irq(dev->irq, &xircom_interrupt,
+			SA_SHIRQ | SA_SAMPLE_NET_RANDOM, dev->name, dev);
 	if (retval) {
 		printk(KERN_ERR "xircom_cb: Unable to aquire IRQ %i, aborting.\n",dev->irq);
 		leave();
diff -urN linux-2.4.8-ac7/drivers/net/pcmcia/xircom_tulip_cb.c linux/drivers/net/pcmcia/xircom_tulip_cb.c
--- linux-2.4.8-ac7/drivers/net/pcmcia/xircom_tulip_cb.c	Tue Jul 17 21:53:55 2001
+++ linux/drivers/net/pcmcia/xircom_tulip_cb.c	Sat Aug 18 01:52:29 2001
@@ -768,7 +768,8 @@
 {
 	struct tulip_private *tp = (struct tulip_private *)dev->priv;
 
-	if (request_irq(dev->irq, &tulip_interrupt, SA_SHIRQ, dev->name, dev))
+	if (request_irq(dev->irq, &tulip_interrupt,
+			SA_SHIRQ | SA_SAMPLE_NET_RANDOM, dev->name, dev))
 		return -EAGAIN;
 
 	tulip_init_ring(dev);
diff -urN linux-2.4.8-ac7/drivers/net/sk_mca.c linux/drivers/net/sk_mca.c
--- linux-2.4.8-ac7/drivers/net/sk_mca.c	Wed Jul  4 14:50:39 2001
+++ linux/drivers/net/sk_mca.c	Sat Aug 18 01:52:29 2001
@@ -861,7 +861,7 @@
 	/* register resources - only necessary for IRQ */
 	result =
 	    request_irq(priv->realirq, irq_handler,
-			SA_SHIRQ | SA_SAMPLE_RANDOM, "sk_mca", dev);
+			SA_SHIRQ | SA_SAMPLE_NET_RANDOM, "sk_mca", dev);
 	if (result != 0) {
 		printk("%s: failed to register irq %d\n", dev->name,
 		       dev->irq);
diff -urN linux-2.4.8-ac7/drivers/net/smc9194.c linux/drivers/net/smc9194.c
--- linux-2.4.8-ac7/drivers/net/smc9194.c	Tue Jul 17 21:53:55 2001
+++ linux/drivers/net/smc9194.c	Sat Aug 18 01:52:29 2001
@@ -1019,7 +1019,7 @@
 	ether_setup(dev);
 
 	/* Grab the IRQ */
-      	retval = request_irq(dev->irq, &smc_interrupt, 0, dev->name, dev);
+      	retval = request_irq(dev->irq, &smc_interrupt, SA_SAMPLE_NET_RANDOM, dev->name, dev);
       	if (retval) {
 		printk("%s: unable to get IRQ %d (irqval=%d).\n", dev->name,
 			dev->irq, retval);
diff -urN linux-2.4.8-ac7/drivers/net/tulip/tulip_core.c linux/drivers/net/tulip/tulip_core.c
--- linux-2.4.8-ac7/drivers/net/tulip/tulip_core.c	Sat Aug 18 01:55:58 2001
+++ linux/drivers/net/tulip/tulip_core.c	Sat Aug 18 01:52:29 2001
@@ -504,7 +504,9 @@
 	int retval;
 	MOD_INC_USE_COUNT;
 
-	if ((retval = request_irq(dev->irq, &tulip_interrupt, SA_SHIRQ, dev->name, dev))) {
+	if ((retval = request_irq(dev->irq, &tulip_interrupt,
+					SA_SHIRQ | SA_SAMPLE_NET_RANDOM,
+					dev->name, dev))) {
 		MOD_DEC_USE_COUNT;
 		return retval;
 	}
diff -urN linux-2.4.8-ac7/drivers/net/wavelan.c linux/drivers/net/wavelan.c
--- linux-2.4.8-ac7/drivers/net/wavelan.c	Sat Aug 18 01:56:00 2001
+++ linux/drivers/net/wavelan.c	Sat Aug 18 01:52:29 2001
@@ -3896,7 +3896,8 @@
 		return -ENXIO;
 	}
 
-	if (request_irq(dev->irq, &wavelan_interrupt, 0, "WaveLAN", dev) != 0) 
+	if (request_irq(dev->irq, &wavelan_interrupt, SA_SAMPLE_NET_RANDOM,
+				"WaveLAN", dev) != 0) 
 	{
 #ifdef DEBUG_CONFIG_ERROR
 		printk(KERN_WARNING "%s: wavelan_open(): invalid IRQ\n",





-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

