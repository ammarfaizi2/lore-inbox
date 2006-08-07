Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWHGXz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWHGXz3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWHGXz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:55:26 -0400
Received: from cdma-45-249.msk.skylink.ru ([83.217.45.249]:36549 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932422AbWHGXzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:55:05 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 1/3] PAL: Support of the fixed PHY
Date: Tue, 08 Aug 2006 03:54:49 +0400
Message-Id: <20060807235448.14154.38768.stgit@localhost.localdomain>
In-Reply-To: <20060807235112.14154.43199.stgit@localhost.localdomain>
References: <20060807235112.14154.43199.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This makes it possible for HW PHY-less boards to utilize PAL goodies.
Generic routines to connect to fixed PHY are provided, as well as ability
to specify software callback that fills up link, speed, etc. information
into PHY descriptor (the latter feature not tested so far).

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 drivers/net/phy/Kconfig      |   17 ++
 drivers/net/phy/Makefile     |    1 
 drivers/net/phy/fixed.c      |  358 ++++++++++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c |   51 ++++--
 include/linux/phy.h          |    1 
 5 files changed, 407 insertions(+), 21 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 2ba6d3a..b79ec0d 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -56,5 +56,22 @@ config SMSC_PHY
 	---help---
 	  Currently supports the LAN83C185 PHY
 
+config FIXED_PHY
+	tristate "Drivers for PHY emulation on fixed speed/link"
+	depends on PHYLIB
+	---help---
+	  Adds the driver to PHY layer to cover the boards that do not have any PHY bound,
+	  but with the ability to manipulate with speed/link in software. The relavant MII
+	  speed/duplex parameters could be effectively handled in user-specified  fuction.
+	  Currently tested with mpc866ads.
+
+config FIXED_MII_10_FDX
+	bool "Emulation for 10M Fdx fixed PHY behavior"
+	depends on FIXED_PHY
+
+config FIXED_MII_100_FDX
+	bool "Emulation for 100M Fdx fixed PHY behavior"
+	depends on FIXED_PHY
+
 endmenu
 
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index a00e619..320f832 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_LXT_PHY)		+= lxt.o
 obj-$(CONFIG_QSEMI_PHY)		+= qsemi.o
 obj-$(CONFIG_SMSC_PHY)		+= smsc.o
 obj-$(CONFIG_VITESSE_PHY)	+= vitesse.o
+obj-$(CONFIG_FIXED_PHY)		+= fixed.o
diff --git a/drivers/net/phy/fixed.c b/drivers/net/phy/fixed.c
new file mode 100644
index 0000000..5d6442c
--- /dev/null
+++ b/drivers/net/phy/fixed.c
@@ -0,0 +1,358 @@
+/*
+ * drivers/net/phy/fixed.c
+ *
+ * Driver for fixed PHYs, when transceiver is able to operate in one fixed mode.
+ *
+ * Author: Vitaly Bordug
+ *
+ * Copyright (c) 2006 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/unistd.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/mii.h>
+#include <linux/ethtool.h>
+#include <linux/phy.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+
+#define MII_REGS_NUM	7
+
+/*
+    The idea is to emulate normal phy behavior by responding with
+    pre-defined values to mii BMCR read, so that read_status hook could
+    take all the needed info.
+*/
+
+struct fixed_phy_status {
+	u8 	link;
+	u16	speed;
+	u8 	duplex;
+};
+
+/*-----------------------------------------------------------------------------
+ *  Private information hoder for mii_bus
+ *-----------------------------------------------------------------------------*/
+struct fixed_info {
+	u16 *regs;
+	u8 regs_num;
+	struct fixed_phy_status phy_status;
+	struct phy_device *phydev; /* pointer to the container */
+	/* link & speed cb */
+	int(*link_update)(struct net_device*, struct fixed_phy_status*);
+
+};
+
+/*-----------------------------------------------------------------------------
+ *  If something weird is required to be done with link/speed,
+ * network driver is able to assign a function to implement this.
+ * May be useful for PHY's that need to be software-driven.
+ *-----------------------------------------------------------------------------*/
+int fixed_mdio_set_link_update(struct phy_device* phydev,
+		int(*link_update)(struct net_device*, struct fixed_phy_status*))
+{
+	struct fixed_info *fixed;
+
+	if(link_update == NULL)
+		return -EINVAL;
+
+	if(phydev) {
+		if(phydev->bus)	{
+			fixed = phydev->bus->priv;
+			fixed->link_update = link_update;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+EXPORT_SYMBOL(fixed_mdio_set_link_update);
+
+/*-----------------------------------------------------------------------------
+ *  This is used for updating internal mii regs from the status
+ *-----------------------------------------------------------------------------*/
+static int fixed_mdio_update_regs(struct fixed_info *fixed)
+{
+	u16 *regs = fixed->regs;
+	u16 bmsr = 0;
+	u16 bmcr = 0;
+
+	if(!regs) {
+		printk(KERN_ERR "%s: regs not set up", __FUNCTION__);
+		return -EINVAL;
+	}
+
+	if(fixed->phy_status.link)
+		bmsr |= BMSR_LSTATUS;
+
+	if(fixed->phy_status.duplex) {
+		bmcr |= BMCR_FULLDPLX;
+
+		switch ( fixed->phy_status.speed ) {
+		case 100:
+			bmsr |= BMSR_100FULL;
+			bmcr |= BMCR_SPEED100;
+		break;
+
+		case 10:
+			bmsr |= BMSR_10FULL;
+		break;
+		}
+	} else {
+		switch ( fixed->phy_status.speed ) {
+		case 100:
+			bmsr |= BMSR_100HALF;
+			bmcr |= BMCR_SPEED100;
+		break;
+
+		case 10:
+			bmsr |= BMSR_100HALF;
+		break;
+		}
+	}
+
+	regs[MII_BMCR] =  bmcr;
+	regs[MII_BMSR] =  bmsr | 0x800; /*we are always capable of 10 hdx*/
+
+	return 0;
+}
+
+static int fixed_mii_read(struct mii_bus *bus, int phy_id, int location)
+{
+	struct fixed_info *fixed = bus->priv;
+
+	/* if user has registered link update callback, use it */
+	if(fixed->phydev)
+		if(fixed->phydev->attached_dev) {
+			if(fixed->link_update) {
+				fixed->link_update(fixed->phydev->attached_dev,
+						&fixed->phy_status);
+				fixed_mdio_update_regs(fixed);
+			}
+	}
+
+	if ((unsigned int)location >= fixed->regs_num)
+		return -1;
+	return fixed->regs[location];
+}
+
+static int fixed_mii_write(struct mii_bus *bus, int phy_id, int location, u16 val)
+{
+	/* do nothing for now*/
+	return 0;
+}
+
+static int fixed_mii_reset(struct mii_bus *bus)
+{
+	/*nothing here - no way/need to reset it*/
+	return 0;
+}
+
+static int fixed_config_aneg(struct phy_device *phydev)
+{
+	/* :TODO:03/13/2006 09:45:37 PM::
+	 The full autoneg funcionality can be emulated,
+	 but no need to have anything here for now
+	 */
+	return 0;
+}
+
+/*-----------------------------------------------------------------------------
+ * the manual bind will do the magic - with phy_id_mask == 0
+ * match will never return true...
+ *-----------------------------------------------------------------------------*/
+static struct phy_driver fixed_mdio_driver = {
+	.name		= "Fixed PHY",
+	.features	= PHY_BASIC_FEATURES,
+	.config_aneg	= fixed_config_aneg,
+	.read_status	= genphy_read_status,
+	.driver 	= { .owner = THIS_MODULE,},
+};
+
+/*-----------------------------------------------------------------------------
+ *  This func is used to create all the necessary stuff, bind
+ * the fixed phy driver and register all it on the mdio_bus_type.
+ * speed is either 10 or 100, duplex is boolean.
+ * number is used to create multiple fixed PHYs, so that several devices can
+ * utilize them simultaneously.
+ *-----------------------------------------------------------------------------*/
+static int fixed_mdio_register_device(int number, int speed, int duplex)
+{
+	struct mii_bus *new_bus;
+	struct fixed_info *fixed;
+	struct phy_device *phydev;
+	int err = 0;
+
+	struct device* dev = kzalloc(sizeof(struct device), GFP_KERNEL);
+
+	if (NULL == dev)
+		return -ENOMEM;
+
+	new_bus = kzalloc(sizeof(struct mii_bus), GFP_KERNEL);
+
+	if (NULL == new_bus) {
+		kfree(dev);
+		return -ENOMEM;
+	}
+	fixed = kzalloc(sizeof(struct fixed_info), GFP_KERNEL);
+
+	if (NULL == fixed) {
+		kfree(dev);
+		kfree(new_bus);
+		return -ENOMEM;
+	}
+
+	fixed->regs = kzalloc(MII_REGS_NUM*sizeof(int), GFP_KERNEL);
+	fixed->regs_num = MII_REGS_NUM;
+	fixed->phy_status.speed = speed;
+	fixed->phy_status.duplex = duplex;
+	fixed->phy_status.link = 1;
+
+	new_bus->name = "Fixed MII Bus",
+	new_bus->read = &fixed_mii_read,
+	new_bus->write = &fixed_mii_write,
+	new_bus->reset = &fixed_mii_reset,
+
+	/*set up workspace*/
+	fixed_mdio_update_regs(fixed);
+	new_bus->priv = fixed;
+
+	new_bus->dev = dev;
+	dev_set_drvdata(dev, new_bus);
+
+	/* create phy_device and register it on the mdio bus */
+	phydev = phy_device_create(new_bus, 0, 0);
+
+	/*
+	 Put the phydev pointer into the fixed pack so that bus read/write code could
+	 be able to access for instance attached netdev. Well it doesn't have to do 
+	 so, only in case of utilizing user-specified link-update...
+	 */
+	fixed->phydev = phydev;
+
+	if(NULL == phydev) {
+		err = -ENOMEM;
+		goto device_create_fail;
+	}
+
+	phydev->irq = -1;
+	phydev->dev.bus = &mdio_bus_type;
+
+	if(number)
+		snprintf(phydev->dev.bus_id, BUS_ID_SIZE,
+				"fixed_%d@%d:%d", number, speed, duplex);
+	else
+		snprintf(phydev->dev.bus_id, BUS_ID_SIZE,
+				"fixed@%d:%d", speed, duplex);
+	phydev->bus = new_bus;
+
+	err = device_register(&phydev->dev);
+	if(err) {
+		printk(KERN_ERR "Phy %s failed to register\n",
+				phydev->dev.bus_id);
+		goto bus_register_fail;
+	}
+
+	/*
+	   the mdio bus has phy_id match... In order not to do it
+	   artificially, we are binding the driver here by hand; 
+	   it will be the same for all the fixed phys anyway.
+	 */
+	down_write(&phydev->dev.bus->subsys.rwsem);
+
+	phydev->dev.driver = &fixed_mdio_driver.driver;
+
+	err = phydev->dev.driver->probe(&phydev->dev);
+	if(err < 0) {
+		printk(KERN_ERR "Phy %s: problems with fixed driver\n",phydev->dev.bus_id);
+		up_write(&phydev->dev.bus->subsys.rwsem);
+		goto probe_fail;
+	}
+
+	device_bind_driver(&phydev->dev);
+	up_write(&phydev->dev.bus->subsys.rwsem);
+
+	return 0;
+
+probe_fail:
+	device_unregister(phydev->dev);
+bus_register_fail:
+	kfree(phydev);
+device_create_fail:
+	kfree(dev);
+	kfree(new_bus);
+	kfree(fixed);
+
+	return err;
+}
+
+
+MODULE_DESCRIPTION("Fixed PHY device & driver for PAL");
+MODULE_AUTHOR("Vitaly Bordug");
+MODULE_LICENSE("GPL");
+
+static int __init fixed_init(void)
+{
+	int ret;
+	int duplex = 0;
+
+	/* register on the bus... Not expected to be matched with anything there... */
+	phy_driver_register(&fixed_mdio_driver);
+
+	/* So let the fun begin...
+	   We will create several mdio devices here, and will bound the upper
+	   driver to them.
+
+	   Then the external software can lookup the phy bus by searching
+	   fixed@speed:duplex, e.g. fixed@100:1, to be connected to the
+	   virtual 100M Fdx phy.
+
+	   In case several virtual PHYs required, the bus_id will be in form
+	   fixed_<num>@<speed>:<duplex>, which make it able even to define
+	   driver-specific link control callback, if for instance PHY is completely
+	   SW-driven.
+
+	*/
+
+#ifdef CONFIG_FIXED_MII_DUPLEX
+	duplex = 1;
+#endif
+
+#ifdef CONFIG_FIXED_MII_100_FDX
+	fixed_mdio_register_device(0, 100, 1);
+#endif
+
+#ifdef CONFIX_FIXED_MII_10_FDX
+	fixed_mdio_register_device(0, 10, 1);
+#endif
+	return 0;
+}
+
+static void __exit fixed_exit(void)
+{
+	phy_driver_unregister(&fixed_mdio_driver);
+	/* :WARNING:02/18/2006 04:32:40 AM:: Cleanup all the created stuff */
+}
+
+module_init(fixed_init);
+module_exit(fixed_exit);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 1bc1e03..2d1ecfd 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -45,6 +45,35 @@ static struct phy_driver genphy_driver;
 extern int mdio_bus_init(void);
 extern void mdio_bus_exit(void);
 
+struct phy_device* phy_device_create(struct mii_bus *bus, int addr, int phy_id)
+{
+	struct phy_device *dev;
+	/* We allocate the device, and initialize the
+	 * default values */
+	dev = kcalloc(1, sizeof(*dev), GFP_KERNEL);
+
+	if (NULL == dev)
+		return (struct phy_device*) PTR_ERR((void*)-ENOMEM);
+
+	dev->speed = 0;
+	dev->duplex = -1;
+	dev->pause = dev->asym_pause = 0;
+	dev->link = 1;
+
+	dev->autoneg = AUTONEG_ENABLE;
+
+	dev->addr = addr;
+	dev->phy_id = phy_id;
+	dev->bus = bus;
+
+	dev->state = PHY_DOWN;
+
+	spin_lock_init(&dev->lock);
+
+	return dev;
+}
+EXPORT_SYMBOL(phy_device_create);
+
 /* get_phy_device
  *
  * description: Reads the ID registers of the PHY at addr on the
@@ -78,27 +107,7 @@ struct phy_device * get_phy_device(struc
 	if (0xffffffff == phy_id)
 		return NULL;
 
-	/* Otherwise, we allocate the device, and initialize the
-	 * default values */
-	dev = kcalloc(1, sizeof(*dev), GFP_KERNEL);
-
-	if (NULL == dev)
-		return ERR_PTR(-ENOMEM);
-
-	dev->speed = 0;
-	dev->duplex = -1;
-	dev->pause = dev->asym_pause = 0;
-	dev->link = 1;
-
-	dev->autoneg = AUTONEG_ENABLE;
-
-	dev->addr = addr;
-	dev->phy_id = phy_id;
-	dev->bus = bus;
-
-	dev->state = PHY_DOWN;
-
-	spin_lock_init(&dev->lock);
+	dev = phy_device_create(bus, addr, phy_id);
 
 	return dev;
 }
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 331521a..9447a57 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -378,6 +378,7 @@ int phy_mii_ioctl(struct phy_device *phy
 		struct mii_ioctl_data *mii_data, int cmd);
 int phy_start_interrupts(struct phy_device *phydev);
 void phy_print_status(struct phy_device *phydev);
+struct phy_device* phy_device_create(struct mii_bus *bus, int addr, int phy_id);
 
 extern struct bus_type mdio_bus_type;
 #endif /* __PHY_H */
