Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268677AbUILL2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268677AbUILL2d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268678AbUILL2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:28:32 -0400
Received: from aun.it.uu.se ([130.238.12.36]:34811 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268677AbUILLYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:24:04 -0400
Date: Sun, 12 Sep 2004 13:23:34 +0200 (MEST)
Message-Id: <200409121123.i8CBNYGZ015172@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: chas@cmf.nrl.navy.mil, marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.28-pre3] ATM drivers gcc-3.4 fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.4.28-pre3
kernel's ATM drivers. The changes are backports from the 2.6 kernel.
Where the 2.4 and 2.6 kernels differ (->dev_data or ->phy_data for
private data), I have chosen to preserve 2.4's behaviour.

/Mikael

--- linux-2.4.28-pre3/drivers/atm/atmtcp.c.~1~	2003-11-29 00:28:11.000000000 +0100
+++ linux-2.4.28-pre3/drivers/atm/atmtcp.c	2004-09-12 01:56:20.000000000 +0200
@@ -246,7 +246,7 @@
 	dev_data = PRIV(atmtcp_dev);
 	dev_data->vcc = NULL;
 	if (dev_data->persist) return;
-	PRIV(atmtcp_dev) = NULL;
+	atmtcp_dev->dev_data = NULL;
 	kfree(dev_data);
 	shutdown_atm_dev(atmtcp_dev);
 	vcc->dev_data = NULL;
@@ -362,7 +362,7 @@
 	}
 	dev->ci_range.vpi_bits = MAX_VPI_BITS;
 	dev->ci_range.vci_bits = MAX_VCI_BITS;
-	PRIV(dev) = dev_data;
+	dev->dev_data = dev_data;
 	PRIV(dev)->vcc = NULL;
 	PRIV(dev)->persist = persist;
 	if (result) *result = dev;
--- linux-2.4.28-pre3/drivers/atm/fore200e.c.~1~	2004-09-12 00:23:20.000000000 +0200
+++ linux-2.4.28-pre3/drivers/atm/fore200e.c	2004-09-12 01:56:20.000000000 +0200
@@ -1621,7 +1621,7 @@
     set_bit(ATM_VF_PARTIAL,&vcc->flags);
     set_bit(ATM_VF_ADDR, &vcc->flags);
 
-    FORE200E_VCC(vcc) = fore200e_vcc;
+    vcc->dev_data = fore200e_vcc;
 
     if (fore200e_activate_vcin(fore200e, 1, vcc, vcc->qos.rxtp.max_sdu) < 0) {
 
@@ -1630,7 +1630,7 @@
 	clear_bit(ATM_VF_ADDR, &vcc->flags);
 	clear_bit(ATM_VF_PARTIAL,&vcc->flags);
 
-	FORE200E_VCC(vcc) = NULL;
+	vcc->dev_data = NULL;
 
 	fore200e->available_cell_rate += vcc->qos.txtp.max_pcr;
 
@@ -1692,7 +1692,7 @@
     vcc->itf = vcc->vci = vcc->vpi = 0;
 
     fore200e_vcc = FORE200E_VCC(vcc);
-    FORE200E_VCC(vcc) = NULL;
+    vcc->dev_data = NULL;
 
     spin_unlock_irqrestore(&fore200e->q_lock, flags);
 
@@ -2739,7 +2739,7 @@
 	return -ENODEV;
     }
 
-    FORE200E_DEV(atm_dev) = fore200e;
+    atm_dev->dev_data = fore200e;
     fore200e->atm_dev = atm_dev;
 
     atm_dev->ci_range.vpi_bits = FORE200E_VPI_BITS;
--- linux-2.4.28-pre3/drivers/atm/he.c.~1~	2004-02-18 15:16:22.000000000 +0100
+++ linux-2.4.28-pre3/drivers/atm/he.c	2004-09-12 01:56:20.000000000 +0200
@@ -378,7 +378,7 @@
 	he_dev->pci_dev = pci_dev;
 	he_dev->atm_dev = atm_dev;
 	he_dev->atm_dev->dev_data = he_dev;
-	HE_DEV(atm_dev) = he_dev;
+	atm_dev->dev_data = he_dev;
 	he_dev->number = atm_dev->number;
 	if (he_start(atm_dev)) {
 		he_stop(he_dev);
@@ -2347,7 +2347,7 @@
 	init_waitqueue_head(&he_vcc->rx_waitq);
 	init_waitqueue_head(&he_vcc->tx_waitq);
 
-	HE_VCC(vcc) = he_vcc;
+	vcc->dev_data = he_vcc;
 
 	if (vcc->qos.txtp.traffic_class != ATM_NONE) {
 		int pcr_goal;
--- linux-2.4.28-pre3/drivers/atm/idt77105.c.~1~	2003-06-14 13:30:20.000000000 +0200
+++ linux-2.4.28-pre3/drivers/atm/idt77105.c	2004-09-12 01:56:20.000000000 +0200
@@ -267,7 +267,7 @@
 {
 	unsigned long flags;
 
-	if (!(PRIV(dev) = kmalloc(sizeof(struct idt77105_priv),GFP_KERNEL)))
+	if (!(dev->phy_data = kmalloc(sizeof(struct idt77105_priv),GFP_KERNEL)))
 		return -ENOMEM;
 	PRIV(dev)->dev = dev;
 	spin_lock_irqsave(&idt77105_priv_lock, flags);
@@ -345,7 +345,7 @@
                 else
                     idt77105_all = walk->next;
 	        dev->phy = NULL;
-                PRIV(dev) = NULL;
+                dev->phy_data = NULL;
                 kfree(walk);
                 break;
             }
--- linux-2.4.28-pre3/drivers/atm/iphase.c.~1~	2003-08-25 20:07:43.000000000 +0200
+++ linux-2.4.28-pre3/drivers/atm/iphase.c	2004-09-12 01:56:20.000000000 +0200
@@ -1782,7 +1782,7 @@
                          (iadev->tx_buf_sz - sizeof(struct cpcs_trailer))){
            printk("IA:  SDU size over (%d) the configured SDU size %d\n",
 		  vcc->qos.txtp.max_sdu,iadev->tx_buf_sz);
-	   INPH_IA_VCC(vcc) = NULL;  
+	   vcc->dev_data = NULL;  
            kfree(ia_vcc);
            return -EINVAL; 
         }
@@ -2707,7 +2707,7 @@
         }
 	kfree(INPH_IA_VCC(vcc));  
         ia_vcc = NULL;
-        INPH_IA_VCC(vcc) = NULL;  
+        vcc->dev_data = NULL;  
         clear_bit(ATM_VF_ADDR,&vcc->flags);
         return;        
 }  
@@ -2720,7 +2720,7 @@
 	if (!test_bit(ATM_VF_PARTIAL,&vcc->flags))  
 	{  
 		IF_EVENT(printk("ia: not partially allocated resources\n");)  
-		INPH_IA_VCC(vcc) = NULL;  
+		vcc->dev_data = NULL;  
 	}  
 	iadev = INPH_IA_DEV(vcc->dev);  
 	error = atm_find_ci(vcc, &vpi, &vci);  
@@ -2744,7 +2744,7 @@
 	/* Device dependent initialization */  
 	ia_vcc = kmalloc(sizeof(*ia_vcc), GFP_KERNEL);  
 	if (!ia_vcc) return -ENOMEM;  
-	INPH_IA_VCC(vcc) = ia_vcc;  
+	vcc->dev_data = ia_vcc;  
   
 	if ((error = open_rx(vcc)))  
 	{  
@@ -3256,7 +3256,7 @@
 		ret = -ENOMEM;
 		goto err_out_disable_dev;
 	}
-	INPH_IA_DEV(dev) = iadev; 
+	dev->dev_data = iadev; 
 	IF_INIT(printk(DEV_LABEL "registered at (itf :%d)\n", dev->number);)
 	IF_INIT(printk("dev_id = 0x%x iadev->LineRate = %d \n", (u32)dev,
 		iadev->LineRate);)
--- linux-2.4.28-pre3/drivers/atm/uPD98402.c.~1~	2001-09-23 21:06:32.000000000 +0200
+++ linux-2.4.28-pre3/drivers/atm/uPD98402.c	2004-09-12 01:56:20.000000000 +0200
@@ -212,7 +212,7 @@
 static int uPD98402_start(struct atm_dev *dev)
 {
 	DPRINTK("phy_start\n");
-	if (!(PRIV(dev) = kmalloc(sizeof(struct uPD98402_priv),GFP_KERNEL)))
+	if (!(dev->phy_data = kmalloc(sizeof(struct uPD98402_priv),GFP_KERNEL)))
 		return -ENOMEM;
 	memset(&PRIV(dev)->sonet_stats,0,sizeof(struct k_sonet_stats));
 	(void) GET(PCR); /* clear performance events */
--- linux-2.4.28-pre3/drivers/atm/zatm.c.~1~	2003-08-25 20:07:43.000000000 +0200
+++ linux-2.4.28-pre3/drivers/atm/zatm.c	2004-09-12 01:56:20.000000000 +0200
@@ -1565,7 +1565,7 @@
         DPRINTK("zatm_close: done waiting\n");
         /* deallocate memory */
         kfree(ZATM_VCC(vcc));
-        ZATM_VCC(vcc) = NULL;
+	vcc->dev_data = NULL;
 	clear_bit(ATM_VF_ADDR,&vcc->flags);
 }
 
@@ -1578,7 +1578,7 @@
 
 	DPRINTK(">zatm_open\n");
 	zatm_dev = ZATM_DEV(vcc->dev);
-	if (!test_bit(ATM_VF_PARTIAL,&vcc->flags)) ZATM_VCC(vcc) = NULL;
+	if (!test_bit(ATM_VF_PARTIAL,&vcc->flags)) vcc->dev_data = NULL;
 	error = atm_find_ci(vcc,&vpi,&vci);
 	if (error) return error;
 	vcc->vpi = vpi;
@@ -1594,7 +1594,7 @@
 			clear_bit(ATM_VF_ADDR,&vcc->flags);
 			return -ENOMEM;
 		}
-		ZATM_VCC(vcc) = zatm_vcc;
+		vcc->dev_data = zatm_vcc;
 		ZATM_VCC(vcc)->tx_chan = 0; /* for zatm_close after open_rx */
 		if ((error = open_rx_first(vcc))) {
 	                zatm_close(vcc);
@@ -1828,7 +1828,7 @@
 			dev = atm_dev_register(DEV_LABEL,&ops,-1,NULL);
 			if (!dev) break;
 			zatm_dev->pci_dev = pci_dev;
-			ZATM_DEV(dev) = zatm_dev;
+			dev->dev_data = zatm_dev;
 			zatm_dev->copper = type;
 			if (zatm_init(dev) || zatm_start(dev)) {
 				atm_dev_deregister(dev);
