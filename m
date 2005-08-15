Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbVHORxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbVHORxp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 13:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbVHORxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 13:53:45 -0400
Received: from kent.litech.org ([72.9.242.215]:13834 "EHLO kent.litech.org")
	by vger.kernel.org with ESMTP id S964864AbVHORxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 13:53:44 -0400
Date: Mon, 15 Aug 2005 13:53:42 -0400
From: Nathan Lutchansky <lutchann@litech.org>
To: LKML <linux-kernel@vger.kernel.org>,
       lm-sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2/5] remove attach_adapter from i2c hwmon drivers
Message-ID: <20050815175342.GC24959@litech.org>
References: <20050815175106.GA24959@litech.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815175106.GA24959@litech.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attach_adapter callback of every i2c hwmon driver can be removed,
now that the i2c core will implicitly call i2c_probe if the address data
is present in the i2c_driver structure.

Signed-off-by: Nathan Lutchansky <lutchann@litech.org>

 drivers/hwmon/adm1021.c   |   12 +++---------
 drivers/hwmon/adm1025.c   |   12 +++---------
 drivers/hwmon/adm1026.c   |   13 +++----------
 drivers/hwmon/adm1031.c   |   13 +++----------
 drivers/hwmon/adm9240.c   |   12 +++---------
 drivers/hwmon/asb100.c    |   17 +++--------------
 drivers/hwmon/atxp1.c     |    9 ++-------
 drivers/hwmon/ds1621.c    |   10 ++--------
 drivers/hwmon/fscher.c    |   12 +++---------
 drivers/hwmon/fscpos.c    |   12 +++---------
 drivers/hwmon/gl518sm.c   |   12 +++---------
 drivers/hwmon/gl520sm.c   |   12 +++---------
 drivers/hwmon/it87.c      |   17 +++--------------
 drivers/hwmon/lm63.c      |   12 +++---------
 drivers/hwmon/lm75.c      |   13 +++----------
 drivers/hwmon/lm77.c      |   13 +++----------
 drivers/hwmon/lm78.c      |   17 +++--------------
 drivers/hwmon/lm80.c      |   12 +++---------
 drivers/hwmon/lm83.c      |   12 +++---------
 drivers/hwmon/lm85.c      |   12 +++---------
 drivers/hwmon/lm87.c      |   12 +++---------
 drivers/hwmon/lm90.c      |   12 +++---------
 drivers/hwmon/lm92.c      |   11 +++--------
 drivers/hwmon/max1619.c   |   12 +++---------
 drivers/hwmon/w83781d.c   |   17 +++--------------
 drivers/hwmon/w83792d.c   |   18 +++---------------
 drivers/hwmon/w83l785ts.c |   12 +++---------
 27 files changed, 79 insertions(+), 269 deletions(-)

Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/adm1021.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/adm1021.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/adm1021.c
@@ -111,7 +111,6 @@ struct adm1021_data {
 	u8	remote_temp_offset_prec;
 };
 
-static int adm1021_attach_adapter(struct i2c_adapter *adapter);
 static int adm1021_detect(struct i2c_adapter *adapter, int address, int kind);
 static void adm1021_init_client(struct i2c_client *client);
 static int adm1021_detach_client(struct i2c_client *client);
@@ -129,8 +128,10 @@ static struct i2c_driver adm1021_driver 
 	.owner		= THIS_MODULE,
 	.name		= "adm1021",
 	.id		= I2C_DRIVERID_ADM1021,
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= adm1021_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= adm1021_detect,
 	.detach_client	= adm1021_detach_client,
 };
 
@@ -182,13 +183,6 @@ static DEVICE_ATTR(temp2_input, S_IRUGO,
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 
-static int adm1021_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, adm1021_detect);
-}
-
 static int adm1021_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/adm1025.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/adm1025.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/adm1025.c
@@ -107,7 +107,6 @@ static int in_scale[6] = { 2500, 2250, 3
  * Functions declaration
  */
 
-static int adm1025_attach_adapter(struct i2c_adapter *adapter);
 static int adm1025_detect(struct i2c_adapter *adapter, int address, int kind);
 static void adm1025_init_client(struct i2c_client *client);
 static int adm1025_detach_client(struct i2c_client *client);
@@ -121,8 +120,10 @@ static struct i2c_driver adm1025_driver 
 	.owner		= THIS_MODULE,
 	.name		= "adm1025",
 	.id		= I2C_DRIVERID_ADM1025,
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= adm1025_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= adm1025_detect,
 	.detach_client	= adm1025_detach_client,
 };
 
@@ -309,13 +310,6 @@ static DEVICE_ATTR(vrm, S_IRUGO | S_IWUS
  * Real code
  */
 
-static int adm1025_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, adm1025_detect);
-}
-
 /*
  * The following function does more than just detection. If detection
  * succeeds, it also registers the new chip.
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/adm1026.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/adm1026.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/adm1026.c
@@ -294,7 +294,6 @@ struct adm1026_data {
 	u8 config3;             /* Register value */
 };
 
-static int adm1026_attach_adapter(struct i2c_adapter *adapter);
 static int adm1026_detect(struct i2c_adapter *adapter, int address,
 	int kind);
 static int adm1026_detach_client(struct i2c_client *client);
@@ -310,19 +309,13 @@ static void adm1026_init_client(struct i
 static struct i2c_driver adm1026_driver = {
 	.owner          = THIS_MODULE,
 	.name           = "adm1026",
+	.class		= I2C_CLASS_HWMON,
 	.flags          = I2C_DF_NOTIFY,
-	.attach_adapter = adm1026_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client  = adm1026_detect,
 	.detach_client  = adm1026_detach_client,
 };
 
-int adm1026_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON)) {
-		return 0;
-	}
-	return i2c_probe(adapter, &addr_data, adm1026_detect);
-}
-
 int adm1026_detach_client(struct i2c_client *client)
 {
 	struct adm1026_data *data = i2c_get_clientdata(client);
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/adm1031.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/adm1031.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/adm1031.c
@@ -97,7 +97,6 @@ struct adm1031_data {
 	s8 temp_crit[3];
 };
 
-static int adm1031_attach_adapter(struct i2c_adapter *adapter);
 static int adm1031_detect(struct i2c_adapter *adapter, int address, int kind);
 static void adm1031_init_client(struct i2c_client *client);
 static int adm1031_detach_client(struct i2c_client *client);
@@ -107,8 +106,10 @@ static struct adm1031_data *adm1031_upda
 static struct i2c_driver adm1031_driver = {
 	.owner = THIS_MODULE,
 	.name = "adm1031",
+	.class = I2C_CLASS_HWMON,
 	.flags = I2C_DF_NOTIFY,
-	.attach_adapter = adm1031_attach_adapter,
+	.address_data = &addr_data,
+	.detect_client = adm1031_detect,
 	.detach_client = adm1031_detach_client,
 };
 
@@ -722,14 +723,6 @@ static ssize_t show_alarms(struct device
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 
-static int adm1031_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, adm1031_detect);
-}
-
-/* This function is called by i2c_probe */
 static int adm1031_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/adm9240.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/adm9240.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/adm9240.c
@@ -129,7 +129,6 @@ static inline unsigned int AOUT_FROM_REG
 	return SCALE(reg, 1250, 255);
 }
 
-static int adm9240_attach_adapter(struct i2c_adapter *adapter);
 static int adm9240_detect(struct i2c_adapter *adapter, int address, int kind);
 static void adm9240_init_client(struct i2c_client *client);
 static int adm9240_detach_client(struct i2c_client *client);
@@ -140,8 +139,10 @@ static struct i2c_driver adm9240_driver 
 	.owner		= THIS_MODULE,
 	.name		= "adm9240",
 	.id		= I2C_DRIVERID_ADM9240,
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= adm9240_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= adm9240_detect,
 	.detach_client	= adm9240_detach_client,
 };
 
@@ -630,13 +631,6 @@ exit:
 	return err;
 }
 
-static int adm9240_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, adm9240_detect);
-}
-
 static int adm9240_detach_client(struct i2c_client *client)
 {
 	struct adm9240_data *data = i2c_get_clientdata(client);
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/asb100.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/asb100.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/asb100.c
@@ -210,7 +210,6 @@ struct asb100_data {
 static int asb100_read_value(struct i2c_client *client, u16 reg);
 static void asb100_write_value(struct i2c_client *client, u16 reg, u16 val);
 
-static int asb100_attach_adapter(struct i2c_adapter *adapter);
 static int asb100_detect(struct i2c_adapter *adapter, int address, int kind);
 static int asb100_detach_client(struct i2c_client *client);
 static struct asb100_data *asb100_update_device(struct device *dev);
@@ -220,8 +219,10 @@ static struct i2c_driver asb100_driver =
 	.owner		= THIS_MODULE,
 	.name		= "asb100",
 	.id		= I2C_DRIVERID_ASB100,
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= asb100_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= asb100_detect,
 	.detach_client	= asb100_detach_client,
 };
 
@@ -611,18 +612,6 @@ static DEVICE_ATTR(pwm1_enable, S_IRUGO 
 	device_create_file(&new_client->dev, &dev_attr_pwm1_enable); \
 } while (0)
 
-/* This function is called when:
-	asb100_driver is inserted (when this module is loaded), for each
-		available adapter
-	when a new adapter is inserted (and asb100_driver is still present)
- */
-static int asb100_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, asb100_detect);
-}
-
 static int asb100_detect_subclients(struct i2c_adapter *adapter, int address,
 		int kind, struct i2c_client *new_client)
 {
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/atxp1.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/atxp1.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/atxp1.c
@@ -44,7 +44,6 @@ static unsigned short normal_i2c[] = { 0
 
 I2C_CLIENT_INSMOD_1(atxp1);
 
-static int atxp1_attach_adapter(struct i2c_adapter * adapter);
 static int atxp1_detach_client(struct i2c_client * client);
 static struct atxp1_data * atxp1_update_device(struct device *dev);
 static int atxp1_detect(struct i2c_adapter *adapter, int address, int kind);
@@ -53,7 +52,8 @@ static struct i2c_driver atxp1_driver = 
 	.owner		= THIS_MODULE,
 	.name		= "atxp1",
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter = atxp1_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= atxp1_detect,
 	.detach_client	= atxp1_detach_client,
 };
 
@@ -251,11 +251,6 @@ static ssize_t atxp1_storegpio2(struct d
 static DEVICE_ATTR(gpio2, S_IRUGO | S_IWUSR, atxp1_showgpio2, atxp1_storegpio2);
 
 
-static int atxp1_attach_adapter(struct i2c_adapter *adapter)
-{
-	return i2c_probe(adapter, &addr_data, &atxp1_detect);
-};
-
 static int atxp1_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client * new_client;
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/ds1621.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/ds1621.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/ds1621.c
@@ -80,7 +80,6 @@ struct ds1621_data {
 	u8 conf;			/* Register encoding, combined */
 };
 
-static int ds1621_attach_adapter(struct i2c_adapter *adapter);
 static int ds1621_detect(struct i2c_adapter *adapter, int address,
 			 int kind);
 static void ds1621_init_client(struct i2c_client *client);
@@ -93,7 +92,8 @@ static struct i2c_driver ds1621_driver =
 	.name		= "ds1621",
 	.id		= I2C_DRIVERID_DS1621,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= ds1621_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= ds1621_detect,
 	.detach_client	= ds1621_detach_client,
 };
 
@@ -178,12 +178,6 @@ static DEVICE_ATTR(temp1_min, S_IWUSR | 
 static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
 
 
-static int ds1621_attach_adapter(struct i2c_adapter *adapter)
-{
-	return i2c_probe(adapter, &addr_data, ds1621_detect);
-}
-
-/* This function is called by i2c_probe */
 int ds1621_detect(struct i2c_adapter *adapter, int address,
                   int kind)
 {
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/fscher.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/fscher.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/fscher.c
@@ -104,7 +104,6 @@ I2C_CLIENT_INSMOD_1(fscher);
  * Functions declaration
  */
 
-static int fscher_attach_adapter(struct i2c_adapter *adapter);
 static int fscher_detect(struct i2c_adapter *adapter, int address, int kind);
 static int fscher_detach_client(struct i2c_client *client);
 static struct fscher_data *fscher_update_device(struct device *dev);
@@ -121,8 +120,10 @@ static struct i2c_driver fscher_driver =
 	.owner		= THIS_MODULE,
 	.name		= "fscher",
 	.id		= I2C_DRIVERID_FSCHER,
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= fscher_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= fscher_detect,
 	.detach_client	= fscher_detach_client,
 };
 
@@ -284,13 +285,6 @@ do { \
  * Real code
  */
 
-static int fscher_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, fscher_detect);
-}
-
 static int fscher_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/fscpos.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/fscpos.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/fscpos.c
@@ -85,7 +85,6 @@ static u8 FSCPOS_REG_TEMP_STATE[] = { 0x
 /*
  * Functions declaration
  */
-static int fscpos_attach_adapter(struct i2c_adapter *adapter);
 static int fscpos_detect(struct i2c_adapter *adapter, int address, int kind);
 static int fscpos_detach_client(struct i2c_client *client);
 
@@ -103,8 +102,10 @@ static struct i2c_driver fscpos_driver =
 	.owner		= THIS_MODULE,
 	.name		= "fscpos",
 	.id		= I2C_DRIVERID_FSCPOS,
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= fscpos_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= fscpos_detect,
 	.detach_client	= fscpos_detach_client,
 };
 
@@ -431,13 +432,6 @@ static DEVICE_ATTR(in0_input, S_IRUGO, s
 static DEVICE_ATTR(in1_input, S_IRUGO, show_volt_5, NULL);
 static DEVICE_ATTR(in2_input, S_IRUGO, show_volt_batt, NULL);
 
-static int fscpos_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, fscpos_detect);
-}
-
 int fscpos_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/gl518sm.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/gl518sm.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/gl518sm.c
@@ -141,7 +141,6 @@ struct gl518_data {
 	u8 beep_enable;		/* Boolean */
 };
 
-static int gl518_attach_adapter(struct i2c_adapter *adapter);
 static int gl518_detect(struct i2c_adapter *adapter, int address, int kind);
 static void gl518_init_client(struct i2c_client *client);
 static int gl518_detach_client(struct i2c_client *client);
@@ -154,8 +153,10 @@ static struct i2c_driver gl518_driver = 
 	.owner		= THIS_MODULE,
 	.name		= "gl518sm",
 	.id		= I2C_DRIVERID_GL518,
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= gl518_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= gl518_detect,
 	.detach_client	= gl518_detach_client,
 };
 
@@ -343,13 +344,6 @@ static DEVICE_ATTR(beep_mask, S_IWUSR|S_
  * Real code
  */
 
-static int gl518_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, gl518_detect);
-}
-
 static int gl518_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/gl520sm.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/gl520sm.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/gl520sm.c
@@ -99,7 +99,6 @@ That's why _TEMP2 and _IN4 access the sa
  * Function declarations
  */
 
-static int gl520_attach_adapter(struct i2c_adapter *adapter);
 static int gl520_detect(struct i2c_adapter *adapter, int address, int kind);
 static void gl520_init_client(struct i2c_client *client);
 static int gl520_detach_client(struct i2c_client *client);
@@ -112,8 +111,10 @@ static struct i2c_driver gl520_driver = 
 	.owner		= THIS_MODULE,
 	.name		= "gl520sm",
 	.id		= I2C_DRIVERID_GL520,
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= gl520_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= gl520_detect,
 	.detach_client	= gl520_detach_client,
 };
 
@@ -515,13 +516,6 @@ static ssize_t set_beep_mask(struct i2c_
  * Real code
  */
 
-static int gl520_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, gl520_detect);
-}
-
 static int gl520_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/lm92.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/lm92.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/lm92.c
@@ -384,13 +384,6 @@ exit:
 	return err;
 }
 
-static int lm92_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, lm92_detect);
-}
-
 static int lm92_detach_client(struct i2c_client *client)
 {
 	struct lm92_data *data = i2c_get_clientdata(client);
@@ -414,8 +407,10 @@ static struct i2c_driver lm92_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm92",
 	.id		= I2C_DRIVERID_LM92,
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= lm92_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= lm92_detect,
 	.detach_client	= lm92_detach_client,
 };
 
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/it87.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/it87.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/it87.c
@@ -220,7 +220,6 @@ struct it87_data {
 };
 
 
-static int it87_attach_adapter(struct i2c_adapter *adapter);
 static int it87_isa_attach_adapter(struct i2c_adapter *adapter);
 static int it87_detect(struct i2c_adapter *adapter, int address, int kind);
 static int it87_detach_client(struct i2c_client *client);
@@ -237,8 +236,10 @@ static struct i2c_driver it87_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "it87",
 	.id		= I2C_DRIVERID_IT87,
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= it87_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= it87_detect,
 	.detach_client	= it87_detach_client,
 };
 
@@ -689,17 +690,6 @@ static DEVICE_ATTR(cpu0_vid, S_IRUGO, sh
 #define device_create_file_vid(client) \
 device_create_file(&client->dev, &dev_attr_cpu0_vid)
 
-/* This function is called when:
-     * it87_driver is inserted (when this module is loaded), for each
-       available adapter
-     * when a new adapter is inserted (and it87_driver is still present) */
-static int it87_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, it87_detect);
-}
-
 static int it87_isa_attach_adapter(struct i2c_adapter *adapter)
 {
 	return it87_detect(adapter, isa_address, -1);
@@ -737,7 +727,6 @@ exit:
 	return err;
 }
 
-/* This function is called by i2c_probe */
 int it87_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/lm63.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/lm63.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/lm63.c
@@ -126,7 +126,6 @@ I2C_CLIENT_INSMOD_1(lm63);
  * Functions declaration
  */
 
-static int lm63_attach_adapter(struct i2c_adapter *adapter);
 static int lm63_detach_client(struct i2c_client *client);
 
 static struct lm63_data *lm63_update_device(struct device *dev);
@@ -141,8 +140,10 @@ static void lm63_init_client(struct i2c_
 static struct i2c_driver lm63_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm63",
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= lm63_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= lm63_detect,
 	.detach_client	= lm63_detach_client,
 };
 
@@ -355,13 +356,6 @@ static DEVICE_ATTR(alarms, S_IRUGO, show
  * Real code
  */
 
-static int lm63_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, lm63_detect);
-}
-
 /*
  * The following function does more than just detection. If detection
  * succeeds, it also registers the new chip.
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/lm75.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/lm75.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/lm75.c
@@ -55,7 +55,6 @@ struct lm75_data {
 	u16			temp_hyst;
 };
 
-static int lm75_attach_adapter(struct i2c_adapter *adapter);
 static int lm75_detect(struct i2c_adapter *adapter, int address, int kind);
 static void lm75_init_client(struct i2c_client *client);
 static int lm75_detach_client(struct i2c_client *client);
@@ -69,8 +68,10 @@ static struct i2c_driver lm75_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm75",
 	.id		= I2C_DRIVERID_LM75,
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= lm75_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= lm75_detect,
 	.detach_client	= lm75_detach_client,
 };
 
@@ -104,14 +105,6 @@ static DEVICE_ATTR(temp1_max, S_IWUSR | 
 static DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
 static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL);
 
-static int lm75_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, lm75_detect);
-}
-
-/* This function is called by i2c_probe */
 static int lm75_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/lm77.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/lm77.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/lm77.c
@@ -62,7 +62,6 @@ struct lm77_data {
 	u8			alarms;
 };
 
-static int lm77_attach_adapter(struct i2c_adapter *adapter);
 static int lm77_detect(struct i2c_adapter *adapter, int address, int kind);
 static void lm77_init_client(struct i2c_client *client);
 static int lm77_detach_client(struct i2c_client *client);
@@ -76,8 +75,10 @@ static struct lm77_data *lm77_update_dev
 static struct i2c_driver lm77_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm77",
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter = lm77_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= lm77_detect,
 	.detach_client	= lm77_detach_client,
 };
 
@@ -204,14 +205,6 @@ static DEVICE_ATTR(temp1_max_hyst, S_IRU
 static DEVICE_ATTR(alarms, S_IRUGO,
 		   show_alarms, NULL);
 
-static int lm77_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, lm77_detect);
-}
-
-/* This function is called by i2c_probe */
 static int lm77_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/lm78.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/lm78.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/lm78.c
@@ -152,7 +152,6 @@ struct lm78_data {
 };
 
 
-static int lm78_attach_adapter(struct i2c_adapter *adapter);
 static int lm78_isa_attach_adapter(struct i2c_adapter *adapter);
 static int lm78_detect(struct i2c_adapter *adapter, int address, int kind);
 static int lm78_detach_client(struct i2c_client *client);
@@ -167,8 +166,10 @@ static struct i2c_driver lm78_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm78",
 	.id		= I2C_DRIVERID_LM78,
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= lm78_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= lm78_detect,
 	.detach_client	= lm78_detach_client,
 };
 
@@ -463,23 +464,11 @@ static ssize_t show_alarms(struct device
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
-/* This function is called when:
-     * lm78_driver is inserted (when this module is loaded), for each
-       available adapter
-     * when a new adapter is inserted (and lm78_driver is still present) */
-static int lm78_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, lm78_detect);
-}
-
 static int lm78_isa_attach_adapter(struct i2c_adapter *adapter)
 {
 	return lm78_detect(adapter, isa_address, -1);
 }
 
-/* This function is called by i2c_probe */
 int lm78_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i, err;
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/lm80.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/lm80.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/lm80.c
@@ -130,7 +130,6 @@ struct lm80_data {
  * Functions declaration
  */
 
-static int lm80_attach_adapter(struct i2c_adapter *adapter);
 static int lm80_detect(struct i2c_adapter *adapter, int address, int kind);
 static void lm80_init_client(struct i2c_client *client);
 static int lm80_detach_client(struct i2c_client *client);
@@ -146,8 +145,10 @@ static struct i2c_driver lm80_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm80",
 	.id		= I2C_DRIVERID_LM80,
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= lm80_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= lm80_detect,
 	.detach_client	= lm80_detach_client,
 };
 
@@ -386,13 +387,6 @@ static DEVICE_ATTR(alarms, S_IRUGO, show
  * Real code
  */
 
-static int lm80_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, lm80_detect);
-}
-
 int lm80_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i, cur;
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/lm83.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/lm83.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/lm83.c
@@ -114,7 +114,6 @@ static const u8 LM83_REG_W_HIGH[] = {
  * Functions declaration
  */
 
-static int lm83_attach_adapter(struct i2c_adapter *adapter);
 static int lm83_detect(struct i2c_adapter *adapter, int address, int kind);
 static int lm83_detach_client(struct i2c_client *client);
 static struct lm83_data *lm83_update_device(struct device *dev);
@@ -127,8 +126,10 @@ static struct i2c_driver lm83_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm83",
 	.id		= I2C_DRIVERID_LM83,
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= lm83_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= lm83_detect,
 	.detach_client	= lm83_detach_client,
 };
 
@@ -209,13 +210,6 @@ static DEVICE_ATTR(alarms, S_IRUGO, show
  * Real code
  */
 
-static int lm83_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, lm83_detect);
-}
-
 /*
  * The following function does more than just detection. If detection
  * succeeds, it also registers the new chip.
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/lm85.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/lm85.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/lm85.c
@@ -368,7 +368,6 @@ struct lm85_data {
 	struct lm85_zone zone[3];
 };
 
-static int lm85_attach_adapter(struct i2c_adapter *adapter);
 static int lm85_detect(struct i2c_adapter *adapter, int address,
 			int kind);
 static int lm85_detach_client(struct i2c_client *client);
@@ -383,8 +382,10 @@ static struct i2c_driver lm85_driver = {
 	.owner          = THIS_MODULE,
 	.name           = "lm85",
 	.id             = I2C_DRIVERID_LM85,
+	.class		= I2C_CLASS_HWMON,
 	.flags          = I2C_DF_NOTIFY,
-	.attach_adapter = lm85_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= lm85_detect,
 	.detach_client  = lm85_detach_client,
 };
 
@@ -1007,13 +1008,6 @@ temp_auto(1);
 temp_auto(2);
 temp_auto(3);
 
-int lm85_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, lm85_detect);
-}
-
 int lm85_detect(struct i2c_adapter *adapter, int address,
 		int kind)
 {
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/lm87.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/lm87.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/lm87.c
@@ -150,7 +150,6 @@ static u8 LM87_REG_TEMP_LOW[3] = { 0x3A,
  * Functions declaration
  */
 
-static int lm87_attach_adapter(struct i2c_adapter *adapter);
 static int lm87_detect(struct i2c_adapter *adapter, int address, int kind);
 static void lm87_init_client(struct i2c_client *client);
 static int lm87_detach_client(struct i2c_client *client);
@@ -164,8 +163,10 @@ static struct i2c_driver lm87_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm87",
 	.id		= I2C_DRIVERID_LM87,
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= lm87_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= lm87_detect,
 	.detach_client	= lm87_detach_client,
 };
 
@@ -534,13 +535,6 @@ static DEVICE_ATTR(aout_output, S_IRUGO 
  * Real code
  */
 
-static int lm87_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, lm87_detect);
-}
-
 /*
  * The following function does more than just detection. If detection
  * succeeds, it also registers the new chip.
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/lm90.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/lm90.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/lm90.c
@@ -174,7 +174,6 @@ I2C_CLIENT_INSMOD_6(lm90, adm1032, lm99,
  * Functions declaration
  */
 
-static int lm90_attach_adapter(struct i2c_adapter *adapter);
 static int lm90_detect(struct i2c_adapter *adapter, int address,
 	int kind);
 static void lm90_init_client(struct i2c_client *client);
@@ -189,8 +188,10 @@ static struct i2c_driver lm90_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "lm90",
 	.id		= I2C_DRIVERID_LM90,
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= lm90_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= lm90_detect,
 	.detach_client	= lm90_detach_client,
 };
 
@@ -349,13 +350,6 @@ static DEVICE_ATTR(alarms, S_IRUGO, show
  * Real code
  */
 
-static int lm90_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, lm90_detect);
-}
-
 /*
  * The following function does more than just detection. If detection
  * succeeds, it also registers the new chip.
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/max1619.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/max1619.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/max1619.c
@@ -78,7 +78,6 @@ I2C_CLIENT_INSMOD_1(max1619);
  * Functions declaration
  */
 
-static int max1619_attach_adapter(struct i2c_adapter *adapter);
 static int max1619_detect(struct i2c_adapter *adapter, int address,
 	int kind);
 static void max1619_init_client(struct i2c_client *client);
@@ -92,8 +91,10 @@ static struct max1619_data *max1619_upda
 static struct i2c_driver max1619_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "max1619",
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= max1619_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= max1619_detect,
 	.detach_client	= max1619_detach_client,
 };
 
@@ -175,13 +176,6 @@ static DEVICE_ATTR(alarms, S_IRUGO, show
  * Real code
  */
 
-static int max1619_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, max1619_detect);
-}
-
 /*
  * The following function does more than just detection. If detection
  * succeeds, it also registers the new chip.
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/w83781d.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/w83781d.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/w83781d.c
@@ -257,7 +257,6 @@ struct w83781d_data {
 	u8 vrm;
 };
 
-static int w83781d_attach_adapter(struct i2c_adapter *adapter);
 static int w83781d_isa_attach_adapter(struct i2c_adapter *adapter);
 static int w83781d_detect(struct i2c_adapter *adapter, int address, int kind);
 static int w83781d_detach_client(struct i2c_client *client);
@@ -272,8 +271,10 @@ static struct i2c_driver w83781d_driver 
 	.owner = THIS_MODULE,
 	.name = "w83781d",
 	.id = I2C_DRIVERID_W83781D,
+	.class = I2C_CLASS_HWMON,
 	.flags = I2C_DF_NOTIFY,
-	.attach_adapter = w83781d_attach_adapter,
+	.address_data = &addr_data,
+	.detect_client = w83781d_detect,
 	.detach_client = w83781d_detach_client,
 };
 
@@ -859,18 +860,6 @@ do { \
 device_create_file(&client->dev, &dev_attr_temp##offset##_type); \
 } while (0)
 
-/* This function is called when:
-     * w83781d_driver is inserted (when this module is loaded), for each
-       available adapter
-     * when a new adapter is inserted (and w83781d_driver is still present) */
-static int
-w83781d_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, w83781d_detect);
-}
-
 static int
 w83781d_isa_attach_adapter(struct i2c_adapter *adapter)
 {
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/w83792d.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/w83792d.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/w83792d.c
@@ -300,7 +300,6 @@ struct w83792d_data {
 	u8 sf2_levels[3][4];	/* Smart FanII: Fan1,2,3 duty cycle levels */
 };
 
-static int w83792d_attach_adapter(struct i2c_adapter *adapter);
 static int w83792d_detect(struct i2c_adapter *adapter, int address, int kind);
 static int w83792d_detach_client(struct i2c_client *client);
 
@@ -318,8 +317,10 @@ static void w83792d_init_client(struct i
 static struct i2c_driver w83792d_driver = {
 	.owner = THIS_MODULE,
 	.name = "w83792d",
+	.class = I2C_CLASS_HWMON,
 	.flags = I2C_DF_NOTIFY,
-	.attach_adapter = w83792d_attach_adapter,
+	.address_data = &addr_data,
+	.detect_client = w83792d_detect,
 	.detach_client = w83792d_detach_client,
 };
 
@@ -1065,19 +1066,6 @@ device_create_file(&client->dev, \
 } while (0)
 
 
-/* This function is called when:
-     * w83792d_driver is inserted (when this module is loaded), for each
-       available adapter
-     * when a new adapter is inserted (and w83792d_driver is still present) */
-static int
-w83792d_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, w83792d_detect);
-}
-
-
 static int
 w83792d_create_subclient(struct i2c_adapter *adapter,
 				struct i2c_client *new_client, int addr,
Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/w83l785ts.c
===================================================================
--- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/w83l785ts.c
+++ linux-2.6.13-rc6+gregkh/drivers/hwmon/w83l785ts.c
@@ -79,7 +79,6 @@ I2C_CLIENT_INSMOD_1(w83l785ts);
  * Functions declaration
  */
 
-static int w83l785ts_attach_adapter(struct i2c_adapter *adapter);
 static int w83l785ts_detect(struct i2c_adapter *adapter, int address,
 	int kind);
 static int w83l785ts_detach_client(struct i2c_client *client);
@@ -94,8 +93,10 @@ static struct i2c_driver w83l785ts_drive
 	.owner		= THIS_MODULE,
 	.name		= "w83l785ts",
 	.id		= I2C_DRIVERID_W83L785TS,
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= w83l785ts_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= w83l785ts_detect,
 	.detach_client	= w83l785ts_detach_client,
 };
 
@@ -137,13 +138,6 @@ static DEVICE_ATTR(temp1_max, S_IRUGO, s
  * Real code
  */
 
-static int w83l785ts_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, w83l785ts_detect);
-}
-
 /*
  * The following function does more than just detection. If detection
  * succeeds, it also registers the new chip.
