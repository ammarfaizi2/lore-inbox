Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUFEW3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUFEW3o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 18:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUFEW3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 18:29:43 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:25756 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262114AbUFEW3g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 18:29:36 -0400
Date: Sun, 6 Jun 2004 00:26:04 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: [patch 2.6.7-rc2] more drivers/atm/horizon.c polishing
Message-ID: <20040606002604.A5414@electric-eye.fr.zoreil.com>
References: <200406040818.i548IQLa027356@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200406040818.i548IQLa027356@hera.kernel.org>; from linux-kernel@vger.kernel.org on Fri, Jun 04, 2004 at 03:38:25AM +0000
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- just say no to numbered labels;
- pci_enable_device can fail so setup_pci_dev() must return a value;
- propagate existing error codes when possible in do_pci_device()
- missing pci_disable_device here and there. 

diff -puN drivers/atm/ambassador.c~ambassador-10 drivers/atm/ambassador.c
--- linux-2.6.7-rc2/drivers/atm/ambassador.c~ambassador-10	2004-06-05 23:19:13.000000000 +0200
+++ linux-2.6.7-rc2-romieu/drivers/atm/ambassador.c	2004-06-06 00:15:28.000000000 +0200
@@ -2215,7 +2215,7 @@ static int __init amb_init (amb_dev * de
     
   } /* amb_reset */
   
-  return -1;
+  return -EINVAL;
 }
 
 static void setup_dev(amb_dev *dev, struct pci_dev *pci_dev) 
@@ -2257,27 +2257,31 @@ static void setup_dev(amb_dev *dev, stru
 	spin_lock_init (&dev->rxq[pool].lock);
 }
 
-static void setup_pci_dev(struct pci_dev *pci_dev)
+static int setup_pci_dev(struct pci_dev *pci_dev)
 {
-      unsigned char lat;
+	unsigned char lat;
+	int ret;
       
-      /* XXX check return value */
-      pci_enable_device(pci_dev);
-
-      // enable bus master accesses
-      pci_set_master(pci_dev);
+	// enable bus master accesses
+	pci_set_master(pci_dev);
       
-      // frobnicate latency (upwards, usually)
-      pci_read_config_byte (pci_dev, PCI_LATENCY_TIMER, &lat);
-      if (pci_lat) {
-	PRINTD (DBG_INIT, "%s PCI latency timer from %hu to %hu",
-		"changing", lat, pci_lat);
-	pci_write_config_byte (pci_dev, PCI_LATENCY_TIMER, pci_lat);
-      } else if (lat < MIN_PCI_LATENCY) {
-	PRINTK (KERN_INFO, "%s PCI latency timer from %hu to %hu",
-		"increasing", lat, MIN_PCI_LATENCY);
-	pci_write_config_byte (pci_dev, PCI_LATENCY_TIMER, MIN_PCI_LATENCY);
-      }
+	ret = pci_enable_device(pci_dev);
+	if (ret < 0)
+		goto out;
+
+	// frobnicate latency (upwards, usually)
+	pci_read_config_byte (pci_dev, PCI_LATENCY_TIMER, &lat);
+
+	if (!pci_lat) 
+		pci_lat = (lat < MIN_PCI_LATENCY) ? MIN_PCI_LATENCY : lat;
+
+	if (lat != pci_lat) {
+		PRINTK (KERN_INFO, "Changing PCI latency timer from %hu to %hu",
+			lat, pci_lat);
+		pci_write_config_byte(pci_dev, PCI_LATENCY_TIMER, pci_lat);
+	}
+out:
+	return ret;
 }
 
 static int __init do_pci_device(struct pci_dev *pci_dev)
@@ -2294,40 +2298,43 @@ static int __init do_pci_device(struct p
 		" IO %x, IRQ %u, MEM %p", iobase, irq, membase);
 
 	// check IO region
-	if (!request_region (iobase, AMB_EXTENT, DEV_LABEL)) {
+	err = pci_request_region(pci_dev, 1, DEV_LABEL);
+	if (err < 0) {
 		PRINTK (KERN_ERR, "IO range already in use!");
-		return -EBUSY;
+		goto out;
 	}
 
 	dev = kmalloc (sizeof(amb_dev), GFP_KERNEL);
 	if (!dev) {
 		PRINTK (KERN_ERR, "out of memory!");
 		err = -ENOMEM;
-		goto out;
+		goto out_release;
 	}
 
 	setup_dev(dev, pci_dev);
 
-	if (amb_init (dev)) {
+	err = amb_init(dev);
+	if (err < 0) {
 		PRINTK (KERN_ERR, "adapter initialisation failure");
-		err = -EINVAL;
-		goto out1;
+		goto out_free;
 	}
 
-	setup_pci_dev(pci_dev);
+	err = setup_pci_dev(pci_dev);
+	if (err < 0)
+		goto out_reset;
 
 	// grab (but share) IRQ and install handler
-	if (request_irq (irq, interrupt_handler, SA_SHIRQ, DEV_LABEL, dev)) {
+	err = request_irq(irq, interrupt_handler, SA_SHIRQ, DEV_LABEL, dev);
+	if (err < 0) {
 		PRINTK (KERN_ERR, "request IRQ failed!");
-		err = -EBUSY;
-		goto out2;
+		goto out_disable;
 	}
 
 	dev->atm_dev = atm_dev_register (DEV_LABEL, &amb_ops, -1, NULL);
 	if (!dev->atm_dev) {
 		PRINTD (DBG_ERR, "failed to register Madge ATM adapter");
 		err = -EINVAL;
-		goto out3;
+		goto out_free_irq;
 	}
 
 	PRINTD (DBG_INFO, "registered Madge ATM adapter (no. %d) (%p) at %p",
@@ -2348,17 +2355,20 @@ static int __init do_pci_device(struct p
 	// enable host interrupts
 	interrupts_on (dev);
 
-	return 0;
-
-out3:
-	free_irq (irq, dev);
-out2:
-	amb_reset (dev, 0);
-out1:
-	kfree (dev);
 out:
-	release_region (iobase, AMB_EXTENT);
 	return err;
+
+out_free_irq:
+	free_irq(irq, dev);
+out_disable:
+	pci_disable_device(pci_dev);
+out_reset:
+	amb_reset(dev, 0);
+out_free:
+	kfree(dev);
+out_release:
+	pci_release_region(pci_dev, 1);
+	goto out;
 }
 
 static int __init amb_probe (void) {
@@ -2488,7 +2498,10 @@ static void __exit amb_module_exit (void
   del_timer_sync(&housekeeping);
   
   while (amb_devs) {
+    struct pci_dev *pdev;
+
     dev = amb_devs;
+    pdev = dev->pci_dev;
     amb_devs = dev->prev;
     
     PRINTD (DBG_INFO|DBG_INIT, "closing %p (atm_dev = %p)", dev, dev->atm_dev);
@@ -2496,11 +2509,12 @@ static void __exit amb_module_exit (void
     drain_rx_pools (dev);
     interrupts_off (dev);
     amb_reset (dev, 0);
+    free_irq (dev->irq, dev);
+    pci_disable_device (pdev);
     destroy_queues (dev);
     atm_dev_deregister (dev->atm_dev);
-    free_irq (dev->irq, dev);
-    release_region (dev->iobase, AMB_EXTENT);
     kfree (dev);
+    pci_release_region (pdev, 1);
   }
   
   return;

_
