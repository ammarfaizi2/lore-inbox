Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbVHKVui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVHKVui (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVHKVui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:50:38 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:47886 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932252AbVHKVuh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:50:37 -0400
Date: Thu, 11 Aug 2005 23:51:10 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] (6/7) I2C: Kill i2c_algorithm.id
Message-Id: <20050811235110.53a8d86f.khali@linux-fr.org>
In-Reply-To: <20050811231828.3e7f5837.khali@linux-fr.org>
References: <20050811231828.3e7f5837.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In theory, there should be no more users of I2C_ALGO_* at this point.
However, it happens that several drivers were using I2C_ALGO_* for
adapter ids, so we need to correct these before we can get rid of all
the I2C_ALGO_* definitions.

Note that this also fixes a bug in media/video/tvaudio.c:

	/* don't attach on saa7146 based cards,
	   because dedicated drivers are used */
	if ((adap->id & I2C_ALGO_SAA7146))
		return 0;

This test was plain broken, as it would succeed for many more adapters
than just the saa7146: any those id would share at least one bit with
the saa7146 id. We are really lucky that the few other adapters we want
this driver to work with did not fulfill that condition.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/busses/i2c-keywest.c                  |    1 -
 drivers/i2c/busses/scx200_acb.c                   |    2 +-
 drivers/media/common/saa7146_i2c.c                |    2 +-
 drivers/media/dvb/b2c2/flexcop-i2c.c              |    1 -
 drivers/media/dvb/dvb-usb/dvb-usb-i2c.c           |    1 -
 drivers/media/dvb/pluto2/pluto2.c                 |    1 -
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    1 -
 drivers/media/video/ir-kbd-i2c.c                  |    2 +-
 drivers/media/video/saa7134/saa7134-i2c.c         |    2 +-
 drivers/media/video/tda9840.c                     |    2 +-
 drivers/media/video/tda9887.c                     |    2 +-
 drivers/media/video/tea6415c.c                    |    2 +-
 drivers/media/video/tea6420.c                     |    2 +-
 drivers/media/video/tvaudio.c                     |    4 ++--
 drivers/video/aty/radeon_i2c.c                    |    2 +-
 drivers/video/nvidia/nv_i2c.c                     |    3 +--
 drivers/video/riva/rivafb-i2c.c                   |    3 +--
 drivers/video/savage/savagefb-i2c.c               |    3 +--
 include/linux/i2c-id.h                            |    7 +++++++
 include/media/id.h                                |    5 -----
 20 files changed, 21 insertions(+), 27 deletions(-)

--- linux-2.6.13-rc5.orig/drivers/video/aty/radeon_i2c.c	2005-06-18 09:32:50.000000000 +0200
+++ linux-2.6.13-rc5/drivers/video/aty/radeon_i2c.c	2005-08-02 22:40:54.000000000 +0200
@@ -75,7 +75,7 @@
 
 	strcpy(chan->adapter.name, name);
 	chan->adapter.owner		= THIS_MODULE;
-	chan->adapter.id		= I2C_ALGO_ATI;
+	chan->adapter.id		= I2C_HW_B_RADEON;
 	chan->adapter.algo_data		= &chan->algo;
 	chan->adapter.dev.parent	= &chan->rinfo->pdev->dev;
 	chan->algo.setsda		= radeon_gpio_setsda;
--- linux-2.6.13-rc5.orig/drivers/video/nvidia/nv_i2c.c	2005-06-18 09:32:53.000000000 +0200
+++ linux-2.6.13-rc5/drivers/video/nvidia/nv_i2c.c	2005-08-02 22:36:42.000000000 +0200
@@ -90,14 +90,13 @@
 	return val;
 }
 
-#define I2C_ALGO_NVIDIA   0x0e0000
 static int nvidia_setup_i2c_bus(struct nvidia_i2c_chan *chan, const char *name)
 {
 	int rc;
 
 	strcpy(chan->adapter.name, name);
 	chan->adapter.owner = THIS_MODULE;
-	chan->adapter.id = I2C_ALGO_NVIDIA;
+	chan->adapter.id = I2C_HW_B_NVIDIA;
 	chan->adapter.algo_data = &chan->algo;
 	chan->adapter.dev.parent = &chan->par->pci_dev->dev;
 	chan->algo.setsda = nvidia_gpio_setsda;
--- linux-2.6.13-rc5.orig/drivers/video/riva/rivafb-i2c.c	2005-06-18 09:32:53.000000000 +0200
+++ linux-2.6.13-rc5/drivers/video/riva/rivafb-i2c.c	2005-08-02 22:37:35.000000000 +0200
@@ -92,14 +92,13 @@
 	return val;
 }
 
-#define I2C_ALGO_RIVA   0x0e0000
 static int riva_setup_i2c_bus(struct riva_i2c_chan *chan, const char *name)
 {
 	int rc;
 
 	strcpy(chan->adapter.name, name);
 	chan->adapter.owner		= THIS_MODULE;
-	chan->adapter.id		= I2C_ALGO_RIVA;
+	chan->adapter.id		= I2C_HW_B_RIVA;
 	chan->adapter.algo_data		= &chan->algo;
 	chan->adapter.dev.parent	= &chan->par->pdev->dev;
 	chan->algo.setsda		= riva_gpio_setsda;
--- linux-2.6.13-rc5.orig/drivers/video/savage/savagefb-i2c.c	2005-06-18 09:32:53.000000000 +0200
+++ linux-2.6.13-rc5/drivers/video/savage/savagefb-i2c.c	2005-08-02 22:39:13.000000000 +0200
@@ -137,7 +137,6 @@
 	return (0 != (GET_CR_DATA(chan->ioaddr) & PROSAVAGE_I2C_SDA_IN));
 }
 
-#define I2C_ALGO_SAVAGE   0x0f0000
 static int savage_setup_i2c_bus(struct savagefb_i2c_chan *chan,
 				const char *name)
 {
@@ -147,7 +146,7 @@
 	if (add_bus && chan->par) {
 		strcpy(chan->adapter.name, name);
 		chan->adapter.owner		= THIS_MODULE;
-		chan->adapter.id		= I2C_ALGO_SAVAGE;
+		chan->adapter.id		= I2C_HW_B_SAVAGE;
 		chan->adapter.algo_data		= &chan->algo;
 		chan->adapter.dev.parent	= &chan->par->pcidev->dev;
 		chan->algo.udelay		= 40;
--- linux-2.6.13-rc5.orig/include/linux/i2c-id.h	2005-08-02 21:40:11.000000000 +0200
+++ linux-2.6.13-rc5/include/linux/i2c-id.h	2005-08-03 20:04:58.000000000 +0200
@@ -245,6 +245,9 @@
 #define I2C_HW_B_ZR36067	0x010019 /* Zoran-36057/36067 based boards */
 #define I2C_HW_B_PCILYNX	0x01001a /* TI PCILynx I2C adapter */
 #define I2C_HW_B_CX2388x	0x01001b /* connexant 2388x based tv cards */
+#define I2C_HW_B_NVIDIA		0x01001c /* nvidia framebuffer driver */
+#define I2C_HW_B_SAVAGE		0x01001d /* savage framebuffer driver */
+#define I2C_HW_B_RADEON		0x01001e /* radeon framebuffer driver */
 
 /* --- PCF 8584 based algorithms					*/
 #define I2C_HW_P_LP		0x020000 /* Parallel port interface */
@@ -317,4 +320,8 @@
 /* --- Marvell mv64xxx i2c adapter */
 #define I2C_HW_MV64XXX		0x190000
 
+/* --- Miscellaneous adapters */
+#define I2C_HW_SAA7146		0x060000 /* SAA7146 video decoder bus */
+#define I2C_HW_SAA7134		0x090000 /* SAA7134 video decoder bus */
+
 #endif /* LINUX_I2C_ID_H */
--- linux-2.6.13-rc5.orig/include/media/id.h	2005-08-02 18:31:23.000000000 +0200
+++ linux-2.6.13-rc5/include/media/id.h	2005-08-02 22:41:16.000000000 +0200
@@ -34,8 +34,3 @@
 #ifndef  I2C_DRIVERID_SAA6752HS
 # define I2C_DRIVERID_SAA6752HS I2C_DRIVERID_EXP0+8
 #endif
-
-/* algorithms */
-#ifndef I2C_ALGO_SAA7134
-# define I2C_ALGO_SAA7134 0x090000
-#endif
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-keywest.c	2005-08-02 20:44:33.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-keywest.c	2005-08-03 20:05:26.000000000 +0200
@@ -619,7 +619,6 @@
 		sprintf(chan->adapter.name, "%s %d", np->parent->name, i);
 		chan->iface = iface;
 		chan->chan_no = i;
-		chan->adapter.id = I2C_ALGO_SMBUS;
 		chan->adapter.algo = &keywest_algorithm;
 		chan->adapter.algo_data = NULL;
 		chan->adapter.client_register = NULL;
--- linux-2.6.13-rc5.orig/drivers/i2c/busses/scx200_acb.c	2005-08-02 20:44:33.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/scx200_acb.c	2005-08-02 22:50:38.000000000 +0200
@@ -454,7 +454,7 @@
 	i2c_set_adapdata(adapter, iface);
 	snprintf(adapter->name, I2C_NAME_SIZE, "SCx200 ACB%d", index);
 	adapter->owner = THIS_MODULE;
-	adapter->id = I2C_ALGO_SMBUS;
+	adapter->id = I2C_HW_SMBUS_SCX200;
 	adapter->algo = &scx200_acb_algorithm;
 	adapter->class = I2C_CLASS_HWMON;
 
--- linux-2.6.13-rc5.orig/drivers/media/common/saa7146_i2c.c	2005-08-02 20:44:33.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/common/saa7146_i2c.c	2005-08-02 22:54:24.000000000 +0200
@@ -410,7 +410,7 @@
 #endif
 		i2c_adapter->algo	   = &saa7146_algo;
 		i2c_adapter->algo_data     = NULL;
-		i2c_adapter->id		   = I2C_ALGO_SAA7146;
+		i2c_adapter->id		   = I2C_HW_SAA7146;
 		i2c_adapter->timeout = SAA7146_I2C_TIMEOUT;
 		i2c_adapter->retries = SAA7146_I2C_RETRIES;
 	}
--- linux-2.6.13-rc5.orig/drivers/media/video/tda9840.c	2005-08-02 18:31:08.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/video/tda9840.c	2005-08-02 22:54:54.000000000 +0200
@@ -205,7 +205,7 @@
 static int attach(struct i2c_adapter *adapter)
 {
 	/* let's see whether this is a know adapter we can attach to */
-	if (adapter->id != I2C_ALGO_SAA7146) {
+	if (adapter->id != I2C_HW_SAA7146) {
 		dprintk("refusing to probe on unknown adapter [name='%s',id=0x%x]\n", adapter->name, adapter->id);
 		return -ENODEV;
 	}
--- linux-2.6.13-rc5.orig/drivers/media/video/tda9887.c	2005-08-02 22:11:48.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/video/tda9887.c	2005-08-02 22:54:36.000000000 +0200
@@ -620,7 +620,7 @@
 	switch (adap->id) {
 	case I2C_HW_B_BT848:
 	case I2C_HW_B_RIVA:
-	case I2C_ALGO_SAA7134:
+	case I2C_HW_SAA7134:
 		return i2c_probe(adap, &addr_data, tda9887_attach);
 		break;
 	}
--- linux-2.6.13-rc5.orig/drivers/media/video/tea6415c.c	2005-08-02 18:31:08.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/video/tea6415c.c	2005-08-02 22:54:47.000000000 +0200
@@ -86,7 +86,7 @@
 static int attach(struct i2c_adapter *adapter)
 {
 	/* let's see whether this is a know adapter we can attach to */
-	if (adapter->id != I2C_ALGO_SAA7146) {
+	if (adapter->id != I2C_HW_SAA7146) {
 		dprintk("refusing to probe on unknown adapter [name='%s',id=0x%x]\n", adapter->name, adapter->id);
 		return -ENODEV;
 	}
--- linux-2.6.13-rc5.orig/drivers/media/video/tea6420.c	2005-08-02 18:31:08.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/video/tea6420.c	2005-08-02 22:54:59.000000000 +0200
@@ -135,7 +135,7 @@
 static int attach(struct i2c_adapter *adapter)
 {
 	/* let's see whether this is a know adapter we can attach to */
-	if (adapter->id != I2C_ALGO_SAA7146) {
+	if (adapter->id != I2C_HW_SAA7146) {
 		dprintk("refusing to probe on unknown adapter [name='%s',id=0x%x]\n", adapter->name, adapter->id);
 		return -ENODEV;
 	}
--- linux-2.6.13-rc5.orig/drivers/media/video/tvaudio.c	2005-08-02 22:11:14.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/video/tvaudio.c	2005-08-02 22:57:04.000000000 +0200
@@ -1548,7 +1548,7 @@
 {
 	/* don't attach on saa7146 based cards,
 	   because dedicated drivers are used */
-	if ((adap->id & I2C_ALGO_SAA7146))
+	if (adap->id == I2C_HW_SAA7146)
 		return 0;
 #ifdef I2C_CLASS_TV_ANALOG
 	if (adap->class & I2C_CLASS_TV_ANALOG)
@@ -1557,7 +1557,7 @@
 	switch (adap->id) {
 	case I2C_HW_B_BT848:
 	case I2C_HW_B_RIVA:
-	case I2C_ALGO_SAA7134:
+	case I2C_HW_SAA7134:
 		return i2c_probe(adap, &addr_data, chip_attach);
 	}
 #endif
--- linux-2.6.13-rc5.orig/drivers/media/dvb/b2c2/flexcop-i2c.c	2005-08-02 20:44:33.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/dvb/b2c2/flexcop-i2c.c	2005-08-03 20:04:44.000000000 +0200
@@ -190,7 +190,6 @@
 	fc->i2c_adap.class	    = I2C_CLASS_TV_DIGITAL;
 	fc->i2c_adap.algo       = &flexcop_algo;
 	fc->i2c_adap.algo_data  = NULL;
-	fc->i2c_adap.id         = I2C_ALGO_BIT;
 
 	if ((ret = i2c_add_adapter(&fc->i2c_adap)) < 0)
 		return ret;
--- linux-2.6.13-rc5.orig/drivers/media/dvb/dvb-usb/dvb-usb-i2c.c	2005-08-02 18:31:07.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/dvb/dvb-usb/dvb-usb-i2c.c	2005-08-03 20:04:41.000000000 +0200
@@ -27,7 +27,6 @@
 #endif
 	d->i2c_adap.algo      = d->props.i2c_algo;
 	d->i2c_adap.algo_data = NULL;
-	d->i2c_adap.id        = I2C_ALGO_BIT;
 
 	i2c_set_adapdata(&d->i2c_adap, d);
 
--- linux-2.6.13-rc5.orig/drivers/media/dvb/pluto2/pluto2.c	2005-08-02 18:31:07.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/dvb/pluto2/pluto2.c	2005-08-03 20:04:38.000000000 +0200
@@ -633,7 +633,6 @@
 	i2c_set_adapdata(&pluto->i2c_adap, pluto);
 	strcpy(pluto->i2c_adap.name, DRIVER_NAME);
 	pluto->i2c_adap.owner = THIS_MODULE;
-	pluto->i2c_adap.id = I2C_ALGO_BIT;
 	pluto->i2c_adap.class = I2C_CLASS_TV_DIGITAL;
 	pluto->i2c_adap.dev.parent = &pdev->dev;
 	pluto->i2c_adap.algo_data = &pluto->i2c_bit;
--- linux-2.6.13-rc5.orig/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-08-02 20:44:33.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-08-03 20:04:34.000000000 +0200
@@ -1523,7 +1523,6 @@
 #endif
 	ttusb->i2c_adap.algo              = &ttusb_dec_algo;
 	ttusb->i2c_adap.algo_data         = NULL;
-	ttusb->i2c_adap.id                = I2C_ALGO_BIT;
 
 	result = i2c_add_adapter(&ttusb->i2c_adap);
 	if (result) {
--- linux-2.6.13-rc5.orig/drivers/media/video/ir-kbd-i2c.c	2005-08-02 22:13:11.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/video/ir-kbd-i2c.c	2005-08-02 22:57:18.000000000 +0200
@@ -432,7 +432,7 @@
 	case I2C_HW_B_BT848:
 		probe = probe_bttv;
 		break;
-	case I2C_ALGO_SAA7134:
+	case I2C_HW_SAA7134:
 		probe = probe_saa7134;
 		break;
 	}
--- linux-2.6.13-rc5.orig/drivers/media/video/saa7134/saa7134-i2c.c	2005-08-02 20:44:33.000000000 +0200
+++ linux-2.6.13-rc5/drivers/media/video/saa7134/saa7134-i2c.c	2005-08-02 22:56:20.000000000 +0200
@@ -381,7 +381,7 @@
 	.class         = I2C_CLASS_TV_ANALOG,
 #endif
 	I2C_DEVNAME("saa7134"),
-	.id            = I2C_ALGO_SAA7134,
+	.id            = I2C_HW_SAA7134,
 	.algo          = &saa7134_algo,
 	.client_register = attach_inform,
 };

-- 
Jean Delvare
