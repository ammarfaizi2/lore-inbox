Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbVKESSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVKESSr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVKESSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:18:47 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32017 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932176AbVKESSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:18:42 -0500
Date: Sat, 5 Nov 2005 18:18:36 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Convert network drivers
Message-ID: <20051105181835.GP14419@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20051105181122.GD12228@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105181122.GD12228@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform drivers to use struct platform_driver

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff -u b/drivers/net/depca.c b/drivers/net/depca.c
--- b/drivers/net/depca.c
+++ b/drivers/net/depca.c
@@ -398,13 +398,14 @@
 };
 #endif
 
-static int depca_isa_probe (struct device *);
+static int depca_isa_probe (struct platform_device *);
 
-static struct device_driver depca_isa_driver = {
-	.name   = depca_string,
-	.bus    = &platform_bus_type,
+static struct platform_driver depca_isa_driver = {
 	.probe  = depca_isa_probe,
 	.remove = __devexit_p(depca_device_remove),
+	.driver	= {
+		.name   = depca_string,
+	},
 };
 	
 /*
@@ -1525,7 +1526,7 @@
 	return adapter;
 }
 
-static int __init depca_isa_probe (struct device *device)
+static int __init depca_isa_probe (struct platform_device *device)
 {
 	struct net_device *dev;
 	struct depca_private *lp;
@@ -1533,7 +1534,7 @@
 	enum depca_type adapter = unknown;
 	int status = 0;
 
-	ioaddr = (u_long) device->platform_data;
+	ioaddr = (u_long) device->dev.platform_data;
 
 	if ((status = depca_common_init (ioaddr, &dev)))
 		goto out;
@@ -1553,7 +1554,7 @@
 	lp->adapter = adapter;
 	lp->mem_start = mem_start;
 	
-	if ((status = depca_hw_init(dev, device)))
+	if ((status = depca_hw_init(dev, &device->dev)))
 		goto out_free;
 	
 	return 0;
@@ -2082,7 +2083,7 @@ static int __init depca_module_init (voi
 #ifdef CONFIG_EISA
         err |= eisa_driver_register (&depca_eisa_driver);
 #endif
-	err |= driver_register (&depca_isa_driver);
+	err |= platform_driver_register (&depca_isa_driver);
 	depca_platform_probe ();
 	
         return err;
@@ -2097,7 +2098,7 @@ static void __exit depca_module_exit (vo
 #ifdef CONFIG_EISA
         eisa_driver_unregister (&depca_eisa_driver);
 #endif
-	driver_unregister (&depca_isa_driver);
+	platform_driver_unregister (&depca_isa_driver);
 
 	for (i = 0; depca_io_ports[i].iobase; i++) {
 		if (depca_io_ports[i].device) {
diff -u b/drivers/net/dm9000.c b/drivers/net/dm9000.c
--- b/drivers/net/dm9000.c
+++ b/drivers/net/dm9000.c
@@ -149,7 +149,7 @@
 } board_info_t;
 
 /* function declaration ------------------------------------- */
-static int dm9000_probe(struct device *);
+static int dm9000_probe(struct platform_device *);
 static int dm9000_open(struct net_device *);
 static int dm9000_start_xmit(struct sk_buff *, struct net_device *);
 static int dm9000_stop(struct net_device *);
@@ -379,9 +379,8 @@
  * Search DM9000 board, allocate space and register it
  */
 static int
-dm9000_probe(struct device *dev)
+dm9000_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct dm9000_plat_data *pdata = pdev->dev.platform_data;
 	struct board_info *db;	/* Point a board information structure */
 	struct net_device *ndev;
@@ -399,7 +398,7 @@
 	}
 
 	SET_MODULE_OWNER(ndev);
-	SET_NETDEV_DEV(ndev, dev);
+	SET_NETDEV_DEV(ndev, &pdev->dev);
 
 	PRINTK2("dm9000_probe()");
 
@@ -570,7 +569,7 @@
 		printk("%s: Invalid ethernet MAC address.  Please "
 		       "set using ifconfig\n", ndev->name);
 
-	dev_set_drvdata(dev, ndev);
+	platform_set_drvdata(pdev, ndev);
 	ret = register_netdev(ndev);
 
 	if (ret == 0) {
@@ -1141,9 +1140,9 @@
 }
 
 static int
-dm9000_drv_suspend(struct device *dev, pm_message_t state)
+dm9000_drv_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct net_device *ndev = dev_get_drvdata(dev);
+	struct net_device *ndev = platform_get_drvdata(dev);
 
 	if (ndev) {
 		if (netif_running(ndev)) {
@@ -1155,9 +1154,9 @@
 }
 
 static int
-dm9000_drv_resume(struct device *dev)
+dm9000_drv_resume(struct platform_device *dev)
 {
-	struct net_device *ndev = dev_get_drvdata(dev);
+	struct net_device *ndev = platform_get_drvdata(dev);
 	board_info_t *db = (board_info_t *) ndev->priv;
 
 	if (ndev) {
@@ -1173,12 +1172,11 @@
 }
 
 static int
-dm9000_drv_remove(struct device *dev)
+dm9000_drv_remove(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct net_device *ndev = dev_get_drvdata(dev);
+	struct net_device *ndev = platform_get_drvdata(pdev);
 
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 
 	unregister_netdev(ndev);
 	dm9000_release_board(pdev, (board_info_t *) ndev->priv);
@@ -1189,13 +1187,14 @@
 	return 0;
 }
 
-static struct device_driver dm9000_driver = {
-	.name    = "dm9000",
-	.bus     = &platform_bus_type,
+static struct platform_driver dm9000_driver = {
 	.probe   = dm9000_probe,
 	.remove  = dm9000_drv_remove,
 	.suspend = dm9000_drv_suspend,
 	.resume  = dm9000_drv_resume,
+	.driver	= {
+		.name	= "dm9000",
+	},
 };
 
 static int __init
@@ -1203,13 +1202,13 @@
 {
 	printk(KERN_INFO "%s Ethernet Driver\n", CARDNAME);
 
-	return driver_register(&dm9000_driver);	/* search board and register */
+	return platform_driver_register(&dm9000_driver);	/* search board and register */
 }
 
 static void __exit
 dm9000_cleanup(void)
 {
-	driver_unregister(&dm9000_driver);
+	platform_driver_unregister(&dm9000_driver);
 }
 
 module_init(dm9000_init);
diff -u b/drivers/net/gianfar.c b/drivers/net/gianfar.c
--- b/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -127,8 +127,8 @@
 static void adjust_link(struct net_device *dev);
 static void init_registers(struct net_device *dev);
 static int init_phy(struct net_device *dev);
-static int gfar_probe(struct device *device);
-static int gfar_remove(struct device *device);
+static int gfar_probe(struct platform_device *pdev);
+static int gfar_remove(struct platform_device *pdev);
 static void free_skb_resources(struct gfar_private *priv);
 static void gfar_set_multi(struct net_device *dev);
 static void gfar_set_hash_for_addr(struct net_device *dev, u8 *addr);
@@ -157,12 +157,11 @@
 
 /* Set up the ethernet device structure, private data,
  * and anything else we need before we start */
-static int gfar_probe(struct device *device)
+static int gfar_probe(struct platform_device *pdev)
 {
 	u32 tempval;
 	struct net_device *dev = NULL;
 	struct gfar_private *priv = NULL;
-	struct platform_device *pdev = to_platform_device(device);
 	struct gianfar_platform_data *einfo;
 	struct resource *r;
 	int idx;
@@ -209,7 +208,7 @@
 
 	spin_lock_init(&priv->lock);
 
-	dev_set_drvdata(device, dev);
+	platform_set_drvdata(pdev, dev);
 
 	/* Stop the DMA engine now, in case it was running before */
 	/* (The firmware could have used it, and left it running). */
@@ -246,7 +245,7 @@
 	dev->base_addr = (unsigned long) (priv->regs);
 
 	SET_MODULE_OWNER(dev);
-	SET_NETDEV_DEV(dev, device);
+	SET_NETDEV_DEV(dev, &pdev->dev);
 
 	/* Fill in the dev structure */
 	dev->open = gfar_enet_open;
@@ -378,12 +377,12 @@
 	return err;
 }
 
-static int gfar_remove(struct device *device)
+static int gfar_remove(struct platform_device *pdev)
 {
-	struct net_device *dev = dev_get_drvdata(device);
+	struct net_device *dev = platform_get_drvdata(pdev);
 	struct gfar_private *priv = netdev_priv(dev);
 
-	dev_set_drvdata(device, NULL);
+	platform_set_drvdata(pdev, NULL);
 
 	iounmap((void *) priv->regs);
 	free_netdev(dev);
@@ -1862,11 +1861,12 @@ static irqreturn_t gfar_error(int irq, v
 }
 
 /* Structure for a device driver */
-static struct device_driver gfar_driver = {
-	.name = "fsl-gianfar",
-	.bus = &platform_bus_type,
+static struct platform_driver gfar_driver = {
 	.probe = gfar_probe,
 	.remove = gfar_remove,
+	.driver	= {
+		.name = "fsl-gianfar",
+	},
 };
 
 static int __init gfar_init(void)
@@ -1876,7 +1876,7 @@
 	if (err)
 		return err;
 
-	err = driver_register(&gfar_driver);
+	err = platform_driver_register(&gfar_driver);
 
 	if (err)
 		gfar_mdio_exit();
@@ -1886,7 +1886,7 @@
 
 static void __exit gfar_exit(void)
 {
-	driver_unregister(&gfar_driver);
+	platform_driver_unregister(&gfar_driver);
 	gfar_mdio_exit();
 }
 
diff -u b/drivers/net/irda/smsc-ircc2.c b/drivers/net/irda/smsc-ircc2.c
--- b/drivers/net/irda/smsc-ircc2.c
+++ b/drivers/net/irda/smsc-ircc2.c
@@ -214,14 +214,15 @@
 
 /* Power Management */
 
-static int smsc_ircc_suspend(struct device *dev, pm_message_t state);
-static int smsc_ircc_resume(struct device *dev);
+static int smsc_ircc_suspend(struct platform_device *dev, pm_message_t state);
+static int smsc_ircc_resume(struct platform_device *dev);
 
-static struct device_driver smsc_ircc_driver = {
-	.name		= SMSC_IRCC2_DRIVER_NAME,
-	.bus		= &platform_bus_type,
+static struct platform_driver smsc_ircc_driver = {
 	.suspend	= smsc_ircc_suspend,
 	.resume		= smsc_ircc_resume,
+	.driver		= {
+		.name	= SMSC_IRCC2_DRIVER_NAME,
+	},
 };
 
 /* Transceivers for SMSC-ircc */
@@ -346,7 +347,7 @@
 
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
 
-	ret = driver_register(&smsc_ircc_driver);
+	ret = platform_driver_register(&smsc_ircc_driver);
 	if (ret) {
 		IRDA_ERROR("%s, Can't register driver!\n", driver_name);
 		return ret;
@@ -378,7 +379,7 @@
 	}
 
 	if (ret)
-		driver_unregister(&smsc_ircc_driver);
+		platform_driver_unregister(&smsc_ircc_driver);
 
 	return ret;
 }
@@ -491,7 +492,7 @@
 		err = PTR_ERR(self->pldev);
 		goto err_out5;
 	}
-	dev_set_drvdata(&self->pldev->dev, self);
+	platform_set_drvdata(self->pldev, self);
 
 	IRDA_MESSAGE("IrDA: Registered device %s\n", dev->name);
 	dev_count++;
@@ -1685,9 +1686,9 @@
 	return 0;
 }
 
-static int smsc_ircc_suspend(struct device *dev, pm_message_t state)
+static int smsc_ircc_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct smsc_ircc_cb *self = dev_get_drvdata(dev);
+	struct smsc_ircc_cb *self = platform_get_drvdata(dev);
 
 	if (!self->io.suspended) {
 		IRDA_DEBUG(1, "%s, Suspending\n", driver_name);
@@ -1706,9 +1707,9 @@
 	return 0;
 }
 
-static int smsc_ircc_resume(struct device *dev)
+static int smsc_ircc_resume(struct platform_device *dev)
 {
-	struct smsc_ircc_cb *self = dev_get_drvdata(dev);
+	struct smsc_ircc_cb *self = platform_get_drvdata(dev);
 
 	if (self->io.suspended) {
 		IRDA_DEBUG(1, "%s, Waking up\n", driver_name);
@@ -1788,7 +1789,7 @@
 			smsc_ircc_close(dev_self[i]);
 	}
 
-	driver_unregister(&smsc_ircc_driver);
+	platform_driver_unregister(&smsc_ircc_driver);
 }
 
 /*
diff -u b/drivers/net/jazzsonic.c b/drivers/net/jazzsonic.c
--- b/drivers/net/jazzsonic.c
+++ b/drivers/net/jazzsonic.c
@@ -194,7 +194,7 @@
  * Probe for a SONIC ethernet controller on a Mips Jazz board.
  * Actually probing is superfluous but we're paranoid.
  */
-static int __init jazz_sonic_probe(struct device *device)
+static int __init jazz_sonic_probe(struct platform_device *pdev)
 {
 	struct net_device *dev;
 	struct sonic_local *lp;
@@ -212,8 +212,8 @@
 		return -ENOMEM;
 
 	lp = netdev_priv(dev);
-	lp->device = device;
-	SET_NETDEV_DEV(dev, device);
+	lp->device = &pdev->dev;
+	SET_NETDEV_DEV(dev, &pdev->dev);
  	SET_MODULE_OWNER(dev);
 
 	netdev_boot_setup_check(dev);
@@ -264,9 +264,9 @@
 
 #include "sonic.c"
 
-static int __devexit jazz_sonic_device_remove (struct device *device)
+static int __devexit jazz_sonic_device_remove (struct platform_device *pdev)
 {
-	struct net_device *dev = device->driver_data;
+	struct net_device *dev = platform_get_drvdata(pdev);
 	struct sonic_local* lp = netdev_priv(dev);
 
 	unregister_netdev (dev);
@@ -278,18 +278,19 @@ static int __devexit jazz_sonic_device_r
 	return 0;
 }
 
-static struct device_driver jazz_sonic_driver = {
-	.name	= jazz_sonic_string,
-	.bus	= &platform_bus_type,
+static struct platform_driver jazz_sonic_driver = {
 	.probe	= jazz_sonic_probe,
 	.remove	= __devexit_p(jazz_sonic_device_remove),
+	.driver	= {
+		.name	= jazz_sonic_string,
+	},
 };
 
 static int __init jazz_sonic_init_module(void)
 {
 	int err;
 
-	if ((err = driver_register(&jazz_sonic_driver))) {
+	if ((err = platform_driver_register(&jazz_sonic_driver))) {
 		printk(KERN_ERR "Driver registration failed\n");
 		return err;
 	}
@@ -313,7 +314,7 @@ static int __init jazz_sonic_init_module
 
 static void __exit jazz_sonic_cleanup_module(void)
 {
-	driver_unregister(&jazz_sonic_driver);
+	platform_driver_unregister(&jazz_sonic_driver);
 
 	if (jazz_sonic_device) {
 		platform_device_unregister(jazz_sonic_device);
diff -u b/drivers/net/macsonic.c b/drivers/net/macsonic.c
--- b/drivers/net/macsonic.c
+++ b/drivers/net/macsonic.c
@@ -525,7 +525,7 @@
 	return macsonic_init(dev);
 }
 
-static int __init mac_sonic_probe(struct device *device)
+static int __init mac_sonic_probe(struct platform_device *device)
 {
 	struct net_device *dev;
 	struct sonic_local *lp;
@@ -537,8 +537,8 @@
 		return -ENOMEM;
 
 	lp = netdev_priv(dev);
-	lp->device = device;
-	SET_NETDEV_DEV(dev, device);
+	lp->device = &device->dev;
+	SET_NETDEV_DEV(dev, &device->dev);
  	SET_MODULE_OWNER(dev);
 
 	/* This will catch fatal stuff like -ENOMEM as well as success */
@@ -579,9 +579,9 @@
 
 #include "sonic.c"
 
-static int __devexit mac_sonic_device_remove (struct device *device)
+static int __devexit mac_sonic_device_remove (struct platform_device *device)
 {
-	struct net_device *dev = device->driver_data;
+	struct net_device *dev = platform_get_drvdata(device);
 	struct sonic_local* lp = netdev_priv(dev);
 
 	unregister_netdev (dev);
@@ -592,18 +592,19 @@ static int __devexit mac_sonic_device_re
 	return 0;
 }
 
-static struct device_driver mac_sonic_driver = {
-	.name   = mac_sonic_string,
-	.bus    = &platform_bus_type,
+static struct platform_driver mac_sonic_driver = {
 	.probe  = mac_sonic_probe,
 	.remove = __devexit_p(mac_sonic_device_remove),
+	.driver	= {
+		.name = mac_sonic_string,
+	},
 };
 
 static int __init mac_sonic_init_module(void)
 {
 	int err;
 
-	if ((err = driver_register(&mac_sonic_driver))) {
+	if ((err = platform_driver_register(&mac_sonic_driver))) {
 		printk(KERN_ERR "Driver registration failed\n");
 		return err;
 	}
@@ -628,7 +629,7 @@ static int __init mac_sonic_init_module(
 
 static void __exit mac_sonic_cleanup_module(void)
 {
-	driver_unregister(&mac_sonic_driver);
+	platform_driver_unregister(&mac_sonic_driver);
 
 	if (mac_sonic_device) {
 		platform_device_unregister(mac_sonic_device);
diff -u b/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
--- b/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -1387,9 +1387,8 @@
  * Input :	struct device *
  * Output :	-ENOMEM if failed , 0 if success
  */
-static int mv643xx_eth_probe(struct device *ddev)
+static int mv643xx_eth_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(ddev);
 	struct mv643xx_eth_platform_data *pd;
 	int port_num = pdev->id;
 	struct mv643xx_private *mp;
@@ -1402,7 +1401,7 @@
 	if (!dev)
 		return -ENOMEM;
 
-	dev_set_drvdata(ddev, dev);
+	platform_set_drvdata(pdev, dev);
 
 	mp = netdev_priv(dev);
 
@@ -1546,21 +1545,20 @@
 	return err;
 }
 
-static int mv643xx_eth_remove(struct device *ddev)
+static int mv643xx_eth_remove(struct platform_device *pdev)
 {
-	struct net_device *dev = dev_get_drvdata(ddev);
+	struct net_device *dev = platform_get_drvdata(pdev);
 
 	unregister_netdev(dev);
 	flush_scheduled_work();
 
 	free_netdev(dev);
-	dev_set_drvdata(ddev, NULL);
+	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
 
-static int mv643xx_eth_shared_probe(struct device *ddev)
+static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(ddev);
 	struct resource *res;
 
 	printk(KERN_NOTICE "MV-643xx 10/100/1000 Ethernet Driver\n");
@@ -1578,7 +1576,7 @@
 
 }
 
-static int mv643xx_eth_shared_remove(struct device *ddev)
+static int mv643xx_eth_shared_remove(struct platform_device *pdev)
 {
 	iounmap(mv643xx_eth_shared_base);
 	mv643xx_eth_shared_base = NULL;
@@ -1586,18 +1584,20 @@ static int mv643xx_eth_shared_remove(str
 	return 0;
 }
 
-static struct device_driver mv643xx_eth_driver = {
-	.name = MV643XX_ETH_NAME,
-	.bus = &platform_bus_type,
+static struct platform_driver mv643xx_eth_driver = {
 	.probe = mv643xx_eth_probe,
 	.remove = mv643xx_eth_remove,
+	.driver = {
+		.name = MV643XX_ETH_NAME,
+	},
 };
 
-static struct device_driver mv643xx_eth_shared_driver = {
-	.name = MV643XX_ETH_SHARED_NAME,
-	.bus = &platform_bus_type,
+static struct platform_driver mv643xx_eth_shared_driver = {
 	.probe = mv643xx_eth_shared_probe,
 	.remove = mv643xx_eth_shared_remove,
+	.driver = {
+		.name = MV643XX_ETH_SHARED_NAME,
+	},
 };
 
 /*
@@ -1613,11 +1613,11 @@ static int __init mv643xx_init_module(vo
 {
 	int rc;
 
-	rc = driver_register(&mv643xx_eth_shared_driver);
+	rc = platform_driver_register(&mv643xx_eth_shared_driver);
 	if (!rc) {
-		rc = driver_register(&mv643xx_eth_driver);
+		rc = platform_driver_register(&mv643xx_eth_driver);
 		if (rc)
-			driver_unregister(&mv643xx_eth_shared_driver);
+			platform_driver_unregister(&mv643xx_eth_shared_driver);
 	}
 	return rc;
 }
@@ -1633,8 +1633,8 @@ static int __init mv643xx_init_module(vo
  */
 static void __exit mv643xx_cleanup_module(void)
 {
-	driver_unregister(&mv643xx_eth_driver);
-	driver_unregister(&mv643xx_eth_shared_driver);
+	platform_driver_unregister(&mv643xx_eth_driver);
+	platform_driver_unregister(&mv643xx_eth_shared_driver);
 }
 
 module_init(mv643xx_init_module);
diff -u b/drivers/net/smc91x.c b/drivers/net/smc91x.c
--- b/drivers/net/smc91x.c
+++ b/drivers/net/smc91x.c
@@ -2183,9 +2183,8 @@
  *	0 --> there is a device
  *	anything else, error
  */
-static int smc_drv_probe(struct device *dev)
+static int smc_drv_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct net_device *ndev;
 	struct resource *res;
 	unsigned int __iomem *addr;
@@ -2212,7 +2211,7 @@
 		goto out_release_io;
 	}
 	SET_MODULE_OWNER(ndev);
-	SET_NETDEV_DEV(ndev, dev);
+	SET_NETDEV_DEV(ndev, &pdev->dev);
 
 	ndev->dma = (unsigned char)-1;
 	ndev->irq = platform_get_irq(pdev, 0);
@@ -2233,7 +2232,7 @@
 		goto out_release_attrib;
 	}
 
-	dev_set_drvdata(dev, ndev);
+	platform_set_drvdata(pdev, ndev);
 	ret = smc_probe(ndev, addr);
 	if (ret != 0)
 		goto out_iounmap;
@@ -2249,7 +2248,7 @@
 	return 0;
 
  out_iounmap:
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 	iounmap(addr);
  out_release_attrib:
 	smc_release_attrib(pdev);
@@ -2263,14 +2262,13 @@
 	return ret;
 }
 
-static int smc_drv_remove(struct device *dev)
+static int smc_drv_remove(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct net_device *ndev = dev_get_drvdata(dev);
+	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct smc_local *lp = netdev_priv(ndev);
 	struct resource *res;
 
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 
 	unregister_netdev(ndev);
 
@@ -2295,9 +2293,9 @@
 	return 0;
 }
 
-static int smc_drv_suspend(struct device *dev, pm_message_t state)
+static int smc_drv_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct net_device *ndev = dev_get_drvdata(dev);
+	struct net_device *ndev = platform_get_drvdata(dev);
 
 	if (ndev) {
 		if (netif_running(ndev)) {
@@ -2309,14 +2307,13 @@
 	return 0;
 }
 
-static int smc_drv_resume(struct device *dev)
+static int smc_drv_resume(struct platform_device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct net_device *ndev = dev_get_drvdata(dev);
+	struct net_device *ndev = platform_get_drvdata(dev);
 
 	if (ndev) {
 		struct smc_local *lp = netdev_priv(ndev);
-		smc_enable_device(pdev);
+		smc_enable_device(dev);
 		if (netif_running(ndev)) {
 			smc_reset(ndev);
 			smc_enable(ndev);
@@ -2328,13 +2325,14 @@
 	return 0;
 }
 
-static struct device_driver smc_driver = {
-	.name		= CARDNAME,
-	.bus		= &platform_bus_type,
+static struct platform_driver smc_driver = {
 	.probe		= smc_drv_probe,
 	.remove		= smc_drv_remove,
 	.suspend	= smc_drv_suspend,
 	.resume		= smc_drv_resume,
+	.driver		= {
+		.name	= CARDNAME,
+	},
 };
 
 static int __init smc_init(void)
@@ -2348,12 +2346,12 @@
 #endif
 #endif
 
-	return driver_register(&smc_driver);
+	return platform_driver_register(&smc_driver);
 }
 
 static void __exit smc_cleanup(void)
 {
-	driver_unregister(&smc_driver);
+	platform_driver_unregister(&smc_driver);
 }
 
 module_init(smc_init);
diff -u b/drivers/net/tokenring/proteon.c b/drivers/net/tokenring/proteon.c
--- b/drivers/net/tokenring/proteon.c
+++ b/drivers/net/tokenring/proteon.c
@@ -344,9 +344,10 @@ module_param_array(dma, int, NULL, 0);
 
 static struct platform_device *proteon_dev[ISATR_MAX_ADAPTERS];
 
-static struct device_driver proteon_driver = {
-	.name		= "proteon",
-	.bus		= &platform_bus_type,
+static struct platform_driver proteon_driver = {
+	.driver		= {
+		.name	= "proteon",
+	},
 };
 
 static int __init proteon_init(void)
@@ -355,7 +356,7 @@ static int __init proteon_init(void)
 	struct platform_device *pdev;
 	int i, num = 0, err = 0;
 
-	err = driver_register(&proteon_driver);
+	err = platform_driver_register(&proteon_driver);
 	if (err)
 		return err;
 
@@ -372,7 +373,7 @@
 		err = setup_card(dev, &pdev->dev);
 		if (!err) {
 			proteon_dev[i] = pdev;
-			dev_set_drvdata(&pdev->dev, dev);
+			platform_set_drvdata(pdev, dev);
 			++num;
 		} else {
 			platform_device_unregister(pdev);
@@ -399,17 +400,17 @@
 		
 		if (!pdev)
 			continue;
-		dev = dev_get_drvdata(&pdev->dev);
+		dev = platform_get_drvdata(pdev);
 		unregister_netdev(dev);
 		release_region(dev->base_addr, PROTEON_IO_EXTENT);
 		free_irq(dev->irq, dev);
 		free_dma(dev->dma);
 		tmsdev_term(dev);
 		free_netdev(dev);
-		dev_set_drvdata(&pdev->dev, NULL);
+		platform_set_drvdata(pdev, NULL);
 		platform_device_unregister(pdev);
 	}
-	driver_unregister(&proteon_driver);
+	platform_driver_unregister(&proteon_driver);
 }
 
 module_init(proteon_init);
diff -u b/drivers/net/tokenring/skisa.c b/drivers/net/tokenring/skisa.c
--- b/drivers/net/tokenring/skisa.c
+++ b/drivers/net/tokenring/skisa.c
@@ -354,9 +354,10 @@ module_param_array(dma, int, NULL, 0);
 
 static struct platform_device *sk_isa_dev[ISATR_MAX_ADAPTERS];
 
-static struct device_driver sk_isa_driver = {
-	.name		= "skisa",
-	.bus		= &platform_bus_type,
+static struct platform_driver sk_isa_driver = {
+	.driver		= {
+		.name	= "skisa",
+	},
 };
 
 static int __init sk_isa_init(void)
@@ -365,7 +366,7 @@ static int __init sk_isa_init(void)
 	struct platform_device *pdev;
 	int i, num = 0, err = 0;
 
-	err = driver_register(&sk_isa_driver);
+	err = platform_driver_register(&sk_isa_driver);
 	if (err)
 		return err;
 
@@ -382,7 +383,7 @@
 		err = setup_card(dev, &pdev->dev);
 		if (!err) {
 			sk_isa_dev[i] = pdev;
-			dev_set_drvdata(&sk_isa_dev[i]->dev, dev);
+			platform_set_drvdata(sk_isa_dev[i], dev);
 			++num;
 		} else {
 			platform_device_unregister(pdev);
@@ -409,17 +410,17 @@
 
 		if (!pdev)
 			continue;
-		dev = dev_get_drvdata(&pdev->dev);
+		dev = platform_get_drvdata(pdev);
 		unregister_netdev(dev);
 		release_region(dev->base_addr, SK_ISA_IO_EXTENT);
 		free_irq(dev->irq, dev);
 		free_dma(dev->dma);
 		tmsdev_term(dev);
 		free_netdev(dev);
-		dev_set_drvdata(&pdev->dev, NULL);
+		platform_set_drvdata(pdev, NULL);
 		platform_device_unregister(pdev);
 	}
-	driver_unregister(&sk_isa_driver);
+	platform_driver_unregister(&sk_isa_driver);
 }
 
 module_init(sk_isa_init);

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
