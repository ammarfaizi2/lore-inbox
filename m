Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSF3PSr>; Sun, 30 Jun 2002 11:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315275AbSF3PSN>; Sun, 30 Jun 2002 11:18:13 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:3265 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S315260AbSF3PRA>;
	Sun, 30 Jun 2002 11:17:00 -0400
Date: Sun, 30 Jun 2002 17:19:12 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.24 - drivers/net/tlan.c dma mapping 3/10
Message-ID: <20020630171912.E19347@fafner.intra.cogenit.fr>
References: <Pine.LNX.4.44.0206232229570.922-100000@localhost.localdomain> <20020624084325.B22534@fafner.intra.cogenit.fr> <20020624211407.A23939@fafner.intra.cogenit.fr> <3D17743E.8060905@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D17743E.8060905@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Jun 24, 2002 at 03:34:22PM -0400
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- (cosmetic) removal of unused variable (pad_allocated);
- (cosmetic) gotoize error paths in TLan_probe1. Extra benefit: code gets 
  correctly indented again.

--- linux-2.5.24/drivers/net/tlan.c	Sat Jun 29 22:15:10 2002
+++ linux-2.5.24/drivers/net/tlan.c	Sat Jun 29 22:25:22 2002
@@ -431,12 +431,9 @@ static struct pci_driver tlan_driver = {
 
 static int __init tlan_probe(void)
 {
-	static int	pad_allocated;
-	
 	printk(KERN_INFO "%s", tlan_banner);
 	
-	TLanPadBuffer = (u8 *) kmalloc(TLAN_MIN_FRAME_SIZE, 
-					GFP_KERNEL);
+	TLanPadBuffer = (u8 *) kmalloc(TLAN_MIN_FRAME_SIZE, GFP_KERNEL);
 
 	if (TLanPadBuffer == NULL) {
 		printk(KERN_ERR "TLAN: Could not allocate memory for pad buffer.\n");
@@ -447,7 +444,6 @@ static int __init tlan_probe(void)
 
 
 	memset(TLanPadBuffer, 0, TLAN_MIN_FRAME_SIZE);
-	pad_allocated = 1;
 
 	TLAN_DBG(TLAN_DEBUG_PROBE, "Starting PCI Probe....\n");
 	
@@ -505,7 +501,7 @@ static int __devinit TLan_probe1(struct 
 	TLanPrivateInfo    *priv;
 	u8		   pci_rev;
 	u16		   device_id;
-	int		   reg;
+	int		   reg, ret;
 
 	if (pdev && pci_enable_device(pdev))
 		return -EIO;
@@ -513,7 +509,8 @@ static int __devinit TLan_probe1(struct 
 	dev = init_etherdev(NULL, sizeof(TLanPrivateInfo));
 	if (dev == NULL) {
 		printk(KERN_ERR "TLAN: Could not allocate memory for device.\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_out;
 	}
 	SET_MODULE_OWNER(dev);
 	
@@ -537,9 +534,8 @@ static int __devinit TLan_probe1(struct 
 		}
 		if (!pci_io_base) {
 			printk(KERN_ERR "TLAN: No IO mappings available\n");
-			unregister_netdev(dev);
-			kfree(dev);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto err_unregister_dev;
 		}
 		
 		dev->base_addr = pci_io_base;
@@ -594,10 +590,9 @@ static int __devinit TLan_probe1(struct 
 	
 	if (TLan_Init(dev)) {
 		printk(KERN_ERR "TLAN: Could not register device.\n");
-		unregister_netdev(dev);
-		kfree(dev);
-		return -EAGAIN;
-	} else {
+		ret = -EAGAIN;
+		goto err_unregister_dev;
+	}
 	
 	TLanDevicesInstalled++;
 	boards_found++;
@@ -618,8 +613,12 @@ static int __devinit TLan_probe1(struct 
 			priv->adapter->deviceLabel,
 			priv->adapterRev);
 	return 0;
-	}
 
+err_unregister_dev:
+	unregister_netdev(dev);
+	kfree(dev);
+err_out:
+	return ret;
 }
 
 static void TLan_Release_Dev(struct net_device *dev)
