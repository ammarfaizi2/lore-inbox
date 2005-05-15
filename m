Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVEOWP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVEOWP2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 18:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVEOWP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 18:15:28 -0400
Received: from pop.gmx.de ([213.165.64.20]:6623 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261280AbVEOWPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 18:15:13 -0400
X-Authenticated: #23875046
From: Alexey Fisher <fishor@gmx.net>
Reply-To: fishor@gmx.net
To: linux-kernel@vger.kernel.org
Subject: clean up and warnings patch for 2.6.12-rc4-mm1 i2c-chip
Date: Mon, 16 May 2005 00:14:35 +0200
User-Agent: KMail/1.8
Cc: trivial@rustcorp.com.au
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505160014.36016.fishor@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi here is some clean ups for Kconfig in i2c/chips subdirectory and error handling fix up for chip max1619.
Best  regards.
Alexey Fisher


diff -uprN linux/drivers/i2c/chips/Kconfig linux-2.6-dev/drivers/i2c/chips/Kconfig
--- linux/drivers/i2c/chips/Kconfig	2005-05-15 22:49:31.000000000 +0200
+++ linux-2.6-dev/drivers/i2c/chips/Kconfig	2005-05-15 22:58:28.000000000 +0200
@@ -29,6 +29,7 @@ config SENSORS_ADM1025
 	help
 	  If you say yes here you get support for Analog Devices ADM1025
 	  and Philips NE1619 sensor chips.
+	  
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm1025.
 
@@ -38,6 +39,7 @@ config SENSORS_ADM1026
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for Analog Devices ADM1026
+	  
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm1026.
 
@@ -48,6 +50,7 @@ config SENSORS_ADM1031
 	help
 	  If you say yes here you get support for Analog Devices ADM1031 
 	  and ADM1030 sensor chips.
+	  
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm1031.
 
@@ -198,8 +201,7 @@ config SENSORS_LM78
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor LM78,
-	  LM78-J and LM79.  This can also be built as a module which can be
-	  inserted and removed while the kernel is running.
+	  LM78-J and LM79.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm78.
@@ -232,7 +234,7 @@ config SENSORS_LM85
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor LM85
-	  sensor chips and clones: ADT7463 and ADM1027.
+	  sensor chips and clones: ADT7463, EMC6D100, EMC6D102 and ADM1027.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm85.
diff -uprN linux/drivers/i2c/chips/max1619.c linux-2.6-dev/drivers/i2c/chips/max1619.c
--- linux/drivers/i2c/chips/max1619.c	2005-05-15 22:49:31.000000000 +0200
+++ linux-2.6-dev/drivers/i2c/chips/max1619.c	2005-05-15 21:05:56.000000000 +0200
@@ -195,6 +195,7 @@ static int max1619_detect(struct i2c_ada
 	u8 reg_config=0, reg_convrate=0, reg_status=0;
 	u8 man_id, chip_id;
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		err = -ENODEV;
 		goto exit;
 
 	if (!(data = kmalloc(sizeof(struct max1619_data), GFP_KERNEL))) {
@@ -234,6 +235,7 @@ static int max1619_detect(struct i2c_ada
 			dev_dbg(&adapter->dev,
 				"MAX1619 detection failed at 0x%02x.\n",
 				address);
+			return -ENODEV;
 			goto exit_free;
 		}
 	}
@@ -254,6 +256,7 @@ static int max1619_detect(struct i2c_ada
 			dev_info(&adapter->dev,
 			    "Unsupported chip (man_id=0x%02X, "
 			    "chip_id=0x%02X).\n", man_id, chip_id);
+			return -ENODEV;
 			goto exit_free;
 		}
 	
diff -uprN linux/drivers/pci/pci.ids linux-2.6-dev/drivers/pci/pci.ids
--- linux/drivers/pci/pci.ids	2005-05-07 07:20:31.000000000 +0200
+++ linux-2.6-dev/drivers/pci/pci.ids	2005-05-15 23:16:21.000000000 +0200
@@ -5322,6 +5322,7 @@
 	0459  LT WinModem
 	045a  LT WinModem
 	045c  LT WinModem
+	045d  LT WinModem
 	0461  V90 WildWire Modem
 	0462  V90 WildWire Modem
 	0480  Venus Modem (V90, 56KFlex)
