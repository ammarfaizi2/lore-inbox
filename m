Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbULMWmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbULMWmU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 17:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbULMWe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 17:34:26 -0500
Received: from h142-az.mvista.com ([65.200.49.142]:55192 "HELO
	xyzzy.farnsworth.org") by vger.kernel.org with SMTP id S261215AbULMWTY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 17:19:24 -0500
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 13 Dec 2004 15:19:21 -0700
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Russell King <rmk@arm.linux.org.uk>,
       Manish Lachwani <mlachwani@mvista.com>,
       Brian Waite <brian@waitefamily.us>,
       "Steven J. Hill" <sjhill@realitydiluted.com>
Subject: [PATCH 5/6] mv643xx_eth: Add support for platform device interface
Message-ID: <20041213221921.GE19951@xyzzy>
References: <20041213220949.GA19609@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213220949.GA19609@xyzzy>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds platform device support to the mv643xx_eth driver.

This is a change to the driver's programming interface.  Platform
code must now pass in the address of the MV643xx ethernet registers
and IRQ.  If firmware doesn't set the MAC address, platform code
must also pass in the MAC address.

Also, note that local MV_READ/MV_WRITE macros are used rather than
using global macros.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

Index: linux-2.5-marvell-submit/drivers/net/mv643xx_eth.c
===================================================================
--- linux-2.5-marvell-submit.orig/drivers/net/mv643xx_eth.c	2004-12-13 14:30:37.436993510 -0700
+++ linux-2.5-marvell-submit/drivers/net/mv643xx_eth.c	2004-12-13 14:30:39.866524559 -0700
@@ -65,6 +65,8 @@
 #endif
 
 /* Static function declarations */
+static void eth_port_uc_addr_get(struct net_device *dev,
+		                                 unsigned char *MacAddr);
 static int mv64340_eth_real_open(struct net_device *);
 static int mv64340_eth_real_stop(struct net_device *);
 static int mv64340_eth_change_mtu(struct net_device *, int);
@@ -74,11 +76,19 @@
 static int mv64340_poll(struct net_device *dev, int *budget);
 #endif
 
-unsigned char prom_mac_addr_base[6];
-unsigned long mv64340_sram_base;
+static void __iomem *mv64x60_eth_shared_base;
 
 static spinlock_t mv64340_eth_phy_lock = SPIN_LOCK_UNLOCKED;
 
+#undef MV_READ
+#define MV_READ(offset)	\
+	readl(mv64x60_eth_shared_base - MV64340_ETH_SHARED_REGS + offset)
+
+#undef MV_WRITE
+#define MV_WRITE(offset, data)	\
+	writel((u32)data,	\
+		mv64x60_eth_shared_base - MV64340_ETH_SHARED_REGS + offset)
+
 /*
  * Changes MTU (maximum transfer unit) of the gigabit ethenret port
  *
@@ -1300,29 +1310,43 @@
 }
 
 /*/
- * mv64340_eth_init
+ * mv64340_eth_probe
  *								       
  * First function called after registering the network device. 
  * It's purpose is to initialize the device as an ethernet device, 
- * fill the structure that was given in registration with pointers
- * to functions, and setting the MAC address of the interface
+ * fill the ethernet device structure with pointers * to functions,
+ * and set the MAC address of the interface
  *
- * Input : number of port to initialize
- * Output : -ENONMEM if failed , 0 if success
+ * Input : struct device *
+ * Output : -ENOMEM or -ENODEV if failed , 0 if success
  */
-static struct net_device *mv64340_eth_init(int port_num)
+static int mv64340_eth_probe(struct device *ddev)
 {
+	struct platform_device *pdev = to_platform_device(ddev);
+	struct mv64xxx_eth_platform_data *pd;
+	int port_num = pdev->id;
 	struct mv64340_private *mp;
 	struct net_device *dev;
+	u8 *p;
+	struct resource *res;
 	int err;
 
 	dev = alloc_etherdev(sizeof(struct mv64340_private));
 	if (!dev)
-		return NULL;
+		return -ENOMEM;
+
+ 	dev_set_drvdata(ddev, dev);
 
 	mp = netdev_priv(dev);
 
-	dev->irq = ETH_PORT0_IRQ_NUM + port_num;
+	if ((res = platform_get_resource(pdev, IORESOURCE_IRQ, 0)))
+		dev->irq = res->start;
+	else {
+		err = -ENODEV;
+		goto out;
+	}
+
+	mp->port_num = port_num;
 
 	dev->open = mv64340_eth_open;
 	dev->stop = mv64340_eth_stop;
@@ -1355,58 +1379,111 @@
 #endif
 #endif
 
-	mp->port_num = port_num;
 
 	/* Configure the timeout task */
         INIT_WORK(&mp->tx_timeout_task,
                   (void (*)(void *))mv64340_eth_tx_timeout_task, dev);
 
 	spin_lock_init(&mp->lock);
-
-	/* set MAC addresses */
-	memcpy(dev->dev_addr, prom_mac_addr_base, 6);
-	dev->dev_addr[5] += port_num;
+	
+	/* set default config values */
+	eth_port_uc_addr_get(dev, dev->dev_addr);
+	pd = pdev->dev.platform_data;
+	if (pd) {
+		if (pd->mac_addr != NULL)
+			memcpy(dev->dev_addr, pd->mac_addr, 6);
+	}
 
 	err = register_netdev(dev);
 	if (err)
-		goto out_free_dev;
+		goto out;
 
-	printk(KERN_NOTICE "%s: port %d with MAC address %02x:%02x:%02x:%02x:%02x:%02x\n",
-		dev->name, port_num,
-		dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
-		dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
+	p = dev->dev_addr;
+	printk(KERN_NOTICE
+		"%s: port %d with MAC address %02x:%02x:%02x:%02x:%02x:%02x\n",
+		dev->name, port_num, p[0], p[1], p[2], p[3], p[4], p[5]);
 
 	if (dev->features & NETIF_F_SG)
-		printk("Scatter Gather Enabled  ");
+		printk(KERN_NOTICE "%s: Scatter Gather Enabled", dev->name);
 
 	if (dev->features & NETIF_F_IP_CSUM)
-		printk("TX TCP/IP Checksumming Supported  \n");
+		printk(KERN_NOTICE "%s: TX TCP/IP Checksumming Supported\n",
+								dev->name);
+
+#ifdef MV64340_CHECKSUM_OFFLOAD_TX
+	printk(KERN_NOTICE "%s: RX TCP/UDP Checksum Offload ON \n", dev->name);
+#endif
 
-	printk("RX TCP/UDP Checksum Offload ON, \n");
-	printk("TX and RX Interrupt Coalescing ON \n");
+#ifdef MV64340_COAL
+	printk(KERN_NOTICE "%s: TX and RX Interrupt Coalescing ON \n",
+								dev->name);
+#endif
 
 #ifdef MV64340_NAPI
-	printk("RX NAPI Enabled \n");
+	printk(KERN_NOTICE "%s: RX NAPI Enabled \n", dev->name);
 #endif
 
-	return dev;
+	return 0;
 
-out_free_dev:
+out:
 	free_netdev(dev);
 
-	return NULL;
+	return err;
 }
 
-static void mv64340_eth_remove(struct net_device *dev)
+static int mv64340_eth_remove(struct device *ddev)
 {
+	struct net_device *dev = dev_get_drvdata(ddev);
+
 	unregister_netdev(dev);
 	flush_scheduled_work();
+
 	free_netdev(dev);
+	dev_set_drvdata(ddev, NULL);
+	return 0;
 }
 
-static struct net_device *mv64340_dev0;
-static struct net_device *mv64340_dev1;
-static struct net_device *mv64340_dev2;
+static int mv64340_eth_shared_probe(struct device *ddev)
+{
+	struct platform_device *pdev = to_platform_device(ddev);
+	struct resource *res;
+
+	printk(KERN_NOTICE "MV-643xx 10/100/1000 Ethernet Driver\n");
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL)
+		return -ENODEV;
+
+	mv64x60_eth_shared_base = ioremap(res->start,
+						MV64340_ETH_SHARED_REGS_SIZE);
+	if (mv64x60_eth_shared_base == NULL)
+		return -ENOMEM;
+
+	return 0;
+
+}
+
+static int mv64340_eth_shared_remove(struct device *ddev)
+{
+	iounmap(mv64x60_eth_shared_base);
+	mv64x60_eth_shared_base = NULL;
+
+	return 0;
+}
+
+static struct device_driver mv643xx_eth_driver = {
+	.name	= MV64XXX_ETH_NAME,
+	.bus	= &platform_bus_type,
+	.probe	= mv64340_eth_probe,
+	.remove	= mv64340_eth_remove,
+};
+
+static struct device_driver mv643xx_eth_shared_driver = {
+	.name	= MV64XXX_ETH_SHARED_NAME,
+	.bus	= &platform_bus_type,
+	.probe	= mv64340_eth_shared_probe,
+	.remove	= mv64340_eth_shared_remove,
+};
 
 /*
  * mv64340_init_module
@@ -1419,30 +1496,15 @@
  */
 static int __init mv64340_init_module(void)
 {
-	printk(KERN_NOTICE "MV-643xx 10/100/1000 Ethernet Driver\n");
+	int rc;
 
-#ifdef CONFIG_MV643XX_ETH_0
-	mv64340_dev0 = mv64340_eth_init(0);
-	if (!mv64340_dev0) {
-		printk(KERN_ERR
-		       "Error registering MV-64360 ethernet port 0\n");
-	}
-#endif
-#ifdef CONFIG_MV643XX_ETH_1
-	mv64340_dev1 = mv64340_eth_init(1);
-	if (!mv64340_dev1) {
-		printk(KERN_ERR
-		       "Error registering MV-64360 ethernet port 1\n");
+	rc = driver_register(&mv643xx_eth_shared_driver);
+	if (!rc) {
+		rc = driver_register(&mv643xx_eth_driver);
+		if (rc)
+			driver_unregister(&mv643xx_eth_shared_driver);
 	}
-#endif
-#ifdef CONFIG_MV643XX_ETH_2
-	mv64340_dev2 = mv64340_eth_init(2);
-	if (!mv64340_dev2) {
-		printk(KERN_ERR
-		       "Error registering MV-64360 ethernet port 2\n");
-	}
-#endif
-	return 0;
+	return rc;
 }
 
 /*
@@ -1456,19 +1518,16 @@
  */
 static void __exit mv64340_cleanup_module(void)
 {
-	if (mv64340_dev2)
-		mv64340_eth_remove(mv64340_dev2);
-	if (mv64340_dev1)
-		mv64340_eth_remove(mv64340_dev1);
-	if (mv64340_dev0)
-		mv64340_eth_remove(mv64340_dev0);
+	driver_unregister(&mv643xx_eth_driver);
+	driver_unregister(&mv643xx_eth_shared_driver);
 }
 
 module_init(mv64340_init_module);
 module_exit(mv64340_cleanup_module);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Rabeeh Khoury, Assaf Hoffman, Matthew Dharm and Manish Lachwani");
+MODULE_AUTHOR("Rabeeh Khoury, Assaf Hoffman, Matthew Dharm, Manish Lachwani"
+		" and Dale Farnsworth");
 MODULE_DESCRIPTION("Ethernet driver for Marvell MV64340");
 
 /*
@@ -1796,6 +1855,42 @@
 }
 
 /*
+ * eth_port_uc_addr_get - This function retrieves the port Unicast address
+ * (MAC address) from the ethernet hw registers.
+ *
+ * DESCRIPTION:
+ *		This function retrieves the port Ethernet MAC address.
+ *
+ * INPUT:
+ *	unsigned int	eth_port_num	Port number.
+ *	char		*MacAddr	pointer where the MAC address is stored
+ *
+ * OUTPUT:
+ *	Copy the MAC address to the location pointed to by MacAddr
+ *
+ * RETURN:
+ *	N/A.
+ *
+ */
+static void eth_port_uc_addr_get(struct net_device *dev, unsigned char *MacAddr)
+{
+	struct mv64340_private *mp = netdev_priv(dev);
+	unsigned int port_num = mp->port_num;
+        u32 MacLow;
+        u32 MacHigh;
+
+        MacLow = MV_READ(MV64340_ETH_MAC_ADDR_LOW(port_num));
+        MacHigh = MV_READ(MV64340_ETH_MAC_ADDR_HIGH(port_num));
+
+        MacAddr[5] = (MacLow) & 0xff;
+        MacAddr[4] = (MacLow >> 8) & 0xff;
+        MacAddr[3] = (MacHigh) & 0xff;
+        MacAddr[2] = (MacHigh >> 8) & 0xff;
+        MacAddr[1] = (MacHigh >> 16) & 0xff;
+        MacAddr[0] = (MacHigh >> 24) & 0xff;
+}
+
+/*
  * eth_port_uc_addr - This function Set the port unicast address table
  *
  * DESCRIPTION:
Index: linux-2.5-marvell-submit/drivers/net/mv643xx_eth.h
===================================================================
--- linux-2.5-marvell-submit.orig/drivers/net/mv643xx_eth.h	2004-12-13 14:30:38.294827930 -0700
+++ linux-2.5-marvell-submit/drivers/net/mv643xx_eth.h	2004-12-13 14:30:39.867524366 -0700
@@ -46,10 +46,6 @@
  *  The first part is the high level driver of the gigE ethernet ports.
  */
 
-#define ETH_PORT0_IRQ_NUM 48			/* main high register, bit0 */
-#define ETH_PORT1_IRQ_NUM ETH_PORT0_IRQ_NUM+1	/* main high register, bit1 */
-#define ETH_PORT2_IRQ_NUM ETH_PORT0_IRQ_NUM+2	/* main high register, bit1 */
-
 /* Checksum offload for Tx works */
 #define  MV64340_CHECKSUM_OFFLOAD_TX
 #define	 MV64340_NAPI
Index: linux-2.5-marvell-submit/include/linux/mv643xx.h
===================================================================
--- linux-2.5-marvell-submit.orig/include/linux/mv643xx.h	2004-12-10 15:47:16.000000000 -0700
+++ linux-2.5-marvell-submit/include/linux/mv643xx.h	2004-12-13 14:30:39.868524173 -0700
@@ -663,6 +663,9 @@
 /*        Ethernet Unit Registers  		*/
 /****************************************/
 
+#define MV64340_ETH_SHARED_REGS                                     0x2000
+#define MV64340_ETH_SHARED_REGS_SIZE                                0x2000
+
 #define MV64340_ETH_PHY_ADDR_REG                                    0x2000
 #define MV64340_ETH_SMI_REG                                         0x2004
 #define MV64340_ETH_UNIT_DEFAULT_ADDR_REG                           0x2008
@@ -1040,4 +1043,13 @@
 
 extern void mv64340_irq_init(unsigned int base);
 
+#define MV64340_ETH_DESC_SIZE				64
+
+#define MV64XXX_ETH_SHARED_NAME	"mv64xxx_eth_shared"
+#define MV64XXX_ETH_NAME	"mv64xxx_eth"
+
+struct mv64xxx_eth_platform_data {
+	char	*mac_addr;	/* pointer to mac address */
+};
+
 #endif /* __ASM_MV64340_H */
