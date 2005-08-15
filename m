Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbVHORyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbVHORyQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 13:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbVHORyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 13:54:16 -0400
Received: from kent.litech.org ([72.9.242.215]:14346 "EHLO kent.litech.org")
	by vger.kernel.org with ESMTP id S964867AbVHORyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 13:54:15 -0400
Date: Mon, 15 Aug 2005 13:54:13 -0400
From: Nathan Lutchansky <lutchann@litech.org>
To: LKML <linux-kernel@vger.kernel.org>,
       lm-sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 3/5] remove attach_adapter from misc i2c chip drivers
Message-ID: <20050815175413.GD24959@litech.org>
References: <20050815175106.GA24959@litech.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815175106.GA24959@litech.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attach_adapter callback of most misc i2c chip drivers can be
removed, now that the i2c core will implicitly call i2c_probe if the
address data is present in the i2c_driver structure.

Signed-off-by: Nathan Lutchansky <lutchann@litech.org>

 drivers/i2c/chips/ds1337.c  |    9 ++-------
 drivers/i2c/chips/ds1374.c  |    8 ++------
 drivers/i2c/chips/eeprom.c  |   10 ++--------
 drivers/i2c/chips/m41t00.c  |    9 ++-------
 drivers/i2c/chips/max6875.c |   10 ++--------
 drivers/i2c/chips/pca9539.c |   10 ++--------
 drivers/i2c/chips/pcf8574.c |   10 ++--------
 drivers/i2c/chips/pcf8591.c |   10 ++--------
 drivers/i2c/chips/rtc8564.c |    8 ++------
 9 files changed, 18 insertions(+), 66 deletions(-)

Index: linux-2.6.13-rc6+gregkh/drivers/i2c/chips/ds1337.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/i2c/chips/ds1337.c
+++ linux-2.6.13-rc6+gregkh/drivers/i2c/chips/ds1337.c
@@ -41,7 +41,6 @@ static unsigned short normal_i2c[] = { 0
 
 I2C_CLIENT_INSMOD_1(ds1337);
 
-static int ds1337_attach_adapter(struct i2c_adapter *adapter);
 static int ds1337_detect(struct i2c_adapter *adapter, int address, int kind);
 static void ds1337_init_client(struct i2c_client *client);
 static int ds1337_detach_client(struct i2c_client *client);
@@ -55,7 +54,8 @@ static struct i2c_driver ds1337_driver =
 	.owner		= THIS_MODULE,
 	.name		= "ds1337",
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= ds1337_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= ds1337_detect,
 	.detach_client	= ds1337_detach_client,
 	.command	= ds1337_command,
 };
@@ -223,11 +223,6 @@ int ds1337_do_command(int bus, int cmd, 
 	return -ENODEV;
 }
 
-static int ds1337_attach_adapter(struct i2c_adapter *adapter)
-{
-	return i2c_probe(adapter, &addr_data, ds1337_detect);
-}
-
 /*
  * The following function does more than just detection. If detection
  * succeeds, it also registers the new chip.
Index: linux-2.6.13-rc6+gregkh/drivers/i2c/chips/ds1374.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/i2c/chips/ds1374.c
+++ linux-2.6.13-rc6+gregkh/drivers/i2c/chips/ds1374.c
@@ -216,11 +216,6 @@ static int ds1374_probe(struct i2c_adapt
 	return 0;
 }
 
-static int ds1374_attach(struct i2c_adapter *adap)
-{
-	return i2c_probe(adap, &addr_data, ds1374_probe);
-}
-
 static int ds1374_detach(struct i2c_client *client)
 {
 	int rc;
@@ -237,7 +232,8 @@ static struct i2c_driver ds1374_driver =
 	.name = DS1374_DRV_NAME,
 	.id = I2C_DRIVERID_DS1374,
 	.flags = I2C_DF_NOTIFY,
-	.attach_adapter = ds1374_attach,
+	.address_data = &addr_data,
+	.detect_client = ds1374_probe,
 	.detach_client = ds1374_detach,
 };
 
Index: linux-2.6.13-rc6+gregkh/drivers/i2c/chips/eeprom.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/i2c/chips/eeprom.c
+++ linux-2.6.13-rc6+gregkh/drivers/i2c/chips/eeprom.c
@@ -62,7 +62,6 @@ struct eeprom_data {
 };
 
 
-static int eeprom_attach_adapter(struct i2c_adapter *adapter);
 static int eeprom_detect(struct i2c_adapter *adapter, int address, int kind);
 static int eeprom_detach_client(struct i2c_client *client);
 
@@ -72,7 +71,8 @@ static struct i2c_driver eeprom_driver =
 	.name		= "eeprom",
 	.id		= I2C_DRIVERID_EEPROM,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= eeprom_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= eeprom_detect,
 	.detach_client	= eeprom_detach_client,
 };
 
@@ -149,12 +149,6 @@ static struct bin_attribute eeprom_attr 
 	.read = eeprom_read,
 };
 
-static int eeprom_attach_adapter(struct i2c_adapter *adapter)
-{
-	return i2c_probe(adapter, &addr_data, eeprom_detect);
-}
-
-/* This function is called by i2c_probe */
 int eeprom_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
Index: linux-2.6.13-rc6+gregkh/drivers/i2c/chips/m41t00.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/i2c/chips/m41t00.c
+++ linux-2.6.13-rc6+gregkh/drivers/i2c/chips/m41t00.c
@@ -195,12 +195,6 @@ m41t00_probe(struct i2c_adapter *adap, i
 }
 
 static int
-m41t00_attach(struct i2c_adapter *adap)
-{
-	return i2c_probe(adap, &addr_data, m41t00_probe);
-}
-
-static int
 m41t00_detach(struct i2c_client *client)
 {
 	int	rc;
@@ -217,7 +211,8 @@ static struct i2c_driver m41t00_driver =
 	.name		= M41T00_DRV_NAME,
 	.id		= I2C_DRIVERID_STM41T00,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= m41t00_attach,
+	.address_data	= &addr_data,
+	.detect_client	= m41t00_probe,
 	.detach_client	= m41t00_detach,
 };
 
Index: linux-2.6.13-rc6+gregkh/drivers/i2c/chips/max6875.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/i2c/chips/max6875.c
+++ linux-2.6.13-rc6+gregkh/drivers/i2c/chips/max6875.c
@@ -61,7 +61,6 @@ struct max6875_data {
 	unsigned long		last_updated[USER_EEPROM_SLICES];
 };
 
-static int max6875_attach_adapter(struct i2c_adapter *adapter);
 static int max6875_detect(struct i2c_adapter *adapter, int address, int kind);
 static int max6875_detach_client(struct i2c_client *client);
 
@@ -70,7 +69,8 @@ static struct i2c_driver max6875_driver 
 	.owner		= THIS_MODULE,
 	.name		= "max6875",
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= max6875_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= max6875_detect,
 	.detach_client	= max6875_detach_client,
 };
 
@@ -158,12 +158,6 @@ static struct bin_attribute user_eeprom_
 	.read = max6875_read,
 };
 
-static int max6875_attach_adapter(struct i2c_adapter *adapter)
-{
-	return i2c_probe(adapter, &addr_data, max6875_detect);
-}
-
-/* This function is called by i2c_probe */
 static int max6875_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *real_client;
Index: linux-2.6.13-rc6+gregkh/drivers/i2c/chips/pca9539.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/i2c/chips/pca9539.c
+++ linux-2.6.13-rc6+gregkh/drivers/i2c/chips/pca9539.c
@@ -32,7 +32,6 @@ enum pca9539_cmd
 	PCA9539_DIRECTION_1	= 7,
 };
 
-static int pca9539_attach_adapter(struct i2c_adapter *adapter);
 static int pca9539_detect(struct i2c_adapter *adapter, int address, int kind);
 static int pca9539_detach_client(struct i2c_client *client);
 
@@ -41,7 +40,8 @@ static struct i2c_driver pca9539_driver 
 	.owner		= THIS_MODULE,
 	.name		= "pca9539",
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= pca9539_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= pca9539_detect,
 	.detach_client	= pca9539_detach_client,
 };
 
@@ -105,12 +105,6 @@ static struct attribute_group pca9539_de
 	.attrs = pca9539_attributes,
 };
 
-static int pca9539_attach_adapter(struct i2c_adapter *adapter)
-{
-	return i2c_probe(adapter, &addr_data, pca9539_detect);
-}
-
-/* This function is called by i2c_probe */
 static int pca9539_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
Index: linux-2.6.13-rc6+gregkh/drivers/i2c/chips/pcf8574.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/i2c/chips/pcf8574.c
+++ linux-2.6.13-rc6+gregkh/drivers/i2c/chips/pcf8574.c
@@ -58,7 +58,6 @@ struct pcf8574_data {
 	u8 write;			/* Remember last written value */
 };
 
-static int pcf8574_attach_adapter(struct i2c_adapter *adapter);
 static int pcf8574_detect(struct i2c_adapter *adapter, int address, int kind);
 static int pcf8574_detach_client(struct i2c_client *client);
 static void pcf8574_init_client(struct i2c_client *client);
@@ -69,7 +68,8 @@ static struct i2c_driver pcf8574_driver 
 	.name		= "pcf8574",
 	.id		= I2C_DRIVERID_PCF8574,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= pcf8574_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= pcf8574_detect,
 	.detach_client	= pcf8574_detach_client,
 };
 
@@ -109,12 +109,6 @@ static DEVICE_ATTR(write, S_IWUSR | S_IR
  * Real code
  */
 
-static int pcf8574_attach_adapter(struct i2c_adapter *adapter)
-{
-	return i2c_probe(adapter, &addr_data, pcf8574_detect);
-}
-
-/* This function is called by i2c_probe */
 int pcf8574_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
Index: linux-2.6.13-rc6+gregkh/drivers/i2c/chips/pcf8591.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/i2c/chips/pcf8591.c
+++ linux-2.6.13-rc6+gregkh/drivers/i2c/chips/pcf8591.c
@@ -80,7 +80,6 @@ struct pcf8591_data {
 	u8 aout;
 };
 
-static int pcf8591_attach_adapter(struct i2c_adapter *adapter);
 static int pcf8591_detect(struct i2c_adapter *adapter, int address, int kind);
 static int pcf8591_detach_client(struct i2c_client *client);
 static void pcf8591_init_client(struct i2c_client *client);
@@ -92,7 +91,8 @@ static struct i2c_driver pcf8591_driver 
 	.name		= "pcf8591",
 	.id		= I2C_DRIVERID_PCF8591,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= pcf8591_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= pcf8591_detect,
 	.detach_client	= pcf8591_detach_client,
 };
 
@@ -160,12 +160,6 @@ static DEVICE_ATTR(out0_enable, S_IWUSR 
 /*
  * Real code
  */
-static int pcf8591_attach_adapter(struct i2c_adapter *adapter)
-{
-	return i2c_probe(adapter, &addr_data, pcf8591_detect);
-}
-
-/* This function is called by i2c_probe */
 int pcf8591_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
Index: linux-2.6.13-rc6+gregkh/drivers/i2c/chips/rtc8564.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/i2c/chips/rtc8564.c
+++ linux-2.6.13-rc6+gregkh/drivers/i2c/chips/rtc8564.c
@@ -196,11 +196,6 @@ done:
 	return ret;
 }
 
-static int rtc8564_probe(struct i2c_adapter *adap)
-{
-	return i2c_probe(adap, &addr_data, rtc8564_attach);
-}
-
 static int rtc8564_detach(struct i2c_client *client)
 {
 	i2c_detach_client(client);
@@ -366,7 +361,8 @@ static struct i2c_driver rtc8564_driver 
 	.name		= "RTC8564",
 	.id		= I2C_DRIVERID_RTC8564,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter = rtc8564_probe,
+	.address_data	= &addr_data,
+	.detect_client	= rtc8564_attach,
 	.detach_client	= rtc8564_detach,
 	.command	= rtc8564_command
 };
