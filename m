Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264781AbUEER1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264781AbUEER1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 13:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbUEER1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 13:27:52 -0400
Received: from mail.convergence.de ([212.84.236.4]:56719 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S264781AbUEER10
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 13:27:26 -0400
Message-ID: <409923F7.7050101@convergence.de>
Date: Wed, 05 May 2004 19:27:19 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jean Delvare <khali@linux-fr.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       sensors@stimpy.netroedge.com
Subject: [PATCH][2.6]
Content-Type: multipart/mixed;
 boundary="------------040202060409050903070905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040202060409050903070905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

in the "[RFC|PATCH][2.6] Additional i2c adapter flags for i2c client 
isolation" thread, the i2c people have  agreed that an ".class" field 
should be added to struct i2c_driver.

Currently only drivers do checks for plausibility ("Is this an adapter I 
can attach to?"), but adapters don't have a chance to keep drivers away 
from their bus.

If both drivers and adapters provide a .class entry, the i2c-core can 
easily compare them and let devices only probe on busses where they can 
really exist.

Real world example: DVB i2c adapters cannot ensure that only known DVB 
i2c chipsets probe their busses. Most client drivers probe every bus 
they get their hands on. This will confuse some DVB i2c busses.

With the new I2C_CLASS_ALL flag it will be possible that an adapter can 
request that really all drivers are probed on the adapter. On the other 
hand, drivers can make sure that they get the chance to probe on every 
i2c adapter out there (this is not encouraged, though)

The attached patch does the first step:
- add .class member to struct i2c_device
- remove unused .flags member from struct i2c_adapter
- rename I2C_ADAP_CLASS_xxx to I2C_CLASS_xxx (to be used both for 
drivers and adapters)
- add new I2C_CLASS_ALL and I2C_CLASS_SOUND classes
- follow these changes in the existing drivers with copy & paste

I think these things are unquestionable and don't make any functional 
changes to the code, so this should be applied to 2.6 now.

 From that point on, we can discuss how to proceed.

Comments?

CU
Michael.

--------------040202060409050903070905
Content-Type: text/plain;
 name="i2c-adapter-client-isolation.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c-adapter-client-isolation.diff"

diff -ura xx-linux-2.6.6-rc3/Documentation/i2c/porting-clients i2c-linux-2.6.6-rc3/Documentation/i2c/porting-clients
--- xx-linux-2.6.6-rc3/Documentation/i2c/porting-clients	2004-04-29 10:38:30.000000000 +0200
+++ i2c-linux-2.6.6-rc3/Documentation/i2c/porting-clients	2004-05-05 11:40:37.000000000 +0200
@@ -62,9 +62,9 @@
   patch to the Documentation/i2c/sysfs-interface file.
 
 * [Attach] For I2C drivers, the attach function should make sure
-  that the adapter's class has I2C_ADAP_CLASS_SMBUS, using the
+  that the adapter's class has I2C_CLASS_SMBUS, using the
   following construct:
-  if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+  if (!(adapter->class & I2C_CLASS_SMBUS))
           return 0;
   ISA-only drivers of course don't need this.
 
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-ali1535.c i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-ali1535.c
--- xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-ali1535.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-ali1535.c	2004-05-05 11:40:37.000000000 +0200
@@ -480,7 +480,7 @@
 
 static struct i2c_adapter ali1535_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_ADAP_CLASS_SMBUS,
+	.class          = I2C_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-ali1563.c i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-ali1563.c
--- xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-ali1563.c	2004-04-29 10:38:35.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-ali1563.c	2004-05-05 11:40:37.000000000 +0200
@@ -357,7 +357,7 @@
 
 static struct i2c_adapter ali1563_adapter = {
 	.owner	= THIS_MODULE,
-	.class	= I2C_ADAP_CLASS_SMBUS,
+	.class	= I2C_CLASS_SMBUS,
 	.algo	= &ali1563_algorithm,
 };
 
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-ali15x3.c i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-ali15x3.c
--- xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-ali15x3.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-ali15x3.c	2004-05-05 11:40:37.000000000 +0200
@@ -470,7 +470,7 @@
 
 static struct i2c_adapter ali15x3_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_ADAP_CLASS_SMBUS,
+	.class          = I2C_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-amd756.c i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-amd756.c
--- xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-amd756.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-amd756.c	2004-05-05 11:40:37.000000000 +0200
@@ -303,7 +303,7 @@
 
 static struct i2c_adapter amd756_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_ADAP_CLASS_SMBUS,
+	.class          = I2C_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-amd8111.c i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-amd8111.c
--- xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-amd8111.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-amd8111.c	2004-05-05 11:40:37.000000000 +0200
@@ -359,7 +359,7 @@
 	smbus->adapter.owner = THIS_MODULE;
 	snprintf(smbus->adapter.name, I2C_NAME_SIZE,
 		"SMBus2 AMD8111 adapter at %04x", smbus->base);
-	smbus->adapter.class = I2C_ADAP_CLASS_SMBUS;
+	smbus->adapter.class = I2C_CLASS_SMBUS;
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
 
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-i801.c i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-i801.c
--- xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-i801.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-i801.c	2004-05-05 11:40:37.000000000 +0200
@@ -539,7 +539,7 @@
 
 static struct i2c_adapter i801_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_ADAP_CLASS_SMBUS,
+	.class		= I2C_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-isa.c i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-isa.c
--- xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-isa.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-isa.c	2004-05-05 11:40:37.000000000 +0200
@@ -43,7 +43,7 @@
 /* There can only be one... */
 static struct i2c_adapter isa_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_ADAP_CLASS_SMBUS,
+	.class          = I2C_CLASS_SMBUS,
 	.algo		= &isa_algorithm,
 	.name		= "ISA main adapter",
 };
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-nforce2.c i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-nforce2.c
--- xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-nforce2.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-nforce2.c	2004-05-05 11:40:37.000000000 +0200
@@ -119,7 +119,7 @@
 
 static struct i2c_adapter nforce2_adapter = {
 	.owner          = THIS_MODULE,
-	.class          = I2C_ADAP_CLASS_SMBUS,
+	.class          = I2C_CLASS_SMBUS,
 	.algo           = &smbus_algorithm,
 	.name   	= "unset",
 };
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-parport-light.c i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-parport-light.c
--- xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-parport-light.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-parport-light.c	2004-05-05 11:40:37.000000000 +0200
@@ -112,7 +112,7 @@
 
 static struct i2c_adapter parport_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_ADAP_CLASS_SMBUS,
+	.class		= I2C_CLASS_SMBUS,
 	.id		= I2C_HW_B_LP,
 	.algo_data	= &parport_algo_data,
 	.name		= "Parallel port adapter (light)",
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-parport.c i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-parport.c
--- xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-parport.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-parport.c	2004-05-05 11:40:37.000000000 +0200
@@ -147,7 +147,7 @@
 
 static struct i2c_adapter parport_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_ADAP_CLASS_SMBUS,
+	.class		= I2C_CLASS_SMBUS,
 	.id		= I2C_HW_B_LP,
 	.name		= "Parallel port adapter",
 };
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-piix4.c i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-piix4.c
--- xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-piix4.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-piix4.c	2004-05-05 11:40:37.000000000 +0200
@@ -410,7 +410,7 @@
 
 static struct i2c_adapter piix4_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_ADAP_CLASS_SMBUS,
+	.class		= I2C_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-sis5595.c i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-sis5595.c
--- xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-sis5595.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-sis5595.c	2004-05-05 11:40:37.000000000 +0200
@@ -360,7 +360,7 @@
 
 static struct i2c_adapter sis5595_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_ADAP_CLASS_SMBUS,
+	.class          = I2C_CLASS_SMBUS,
 	.name		= "unset",
 	.algo		= &smbus_algorithm,
 };
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-sis630.c i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-sis630.c
--- xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-sis630.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-sis630.c	2004-05-05 11:40:37.000000000 +0200
@@ -456,7 +456,7 @@
 
 static struct i2c_adapter sis630_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_ADAP_CLASS_SMBUS,
+	.class		= I2C_CLASS_SMBUS,
 	.name		= "unset",
 	.algo		= &smbus_algorithm,
 };
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-sis96x.c i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-sis96x.c
--- xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-sis96x.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-sis96x.c	2004-05-05 11:40:37.000000000 +0200
@@ -260,7 +260,7 @@
 
 static struct i2c_adapter sis96x_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_ADAP_CLASS_SMBUS,
+	.class		= I2C_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-via.c i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-via.c
--- xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-via.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-via.c	2004-05-05 11:40:37.000000000 +0200
@@ -88,7 +88,7 @@
 
 static struct i2c_adapter vt586b_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_ADAP_CLASS_SMBUS,
+	.class          = I2C_CLASS_SMBUS,
 	.name		= "VIA i2c",
 	.algo_data	= &bit_data,
 };
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-viapro.c i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-viapro.c
--- xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-viapro.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-viapro.c	2004-05-05 11:40:37.000000000 +0200
@@ -289,7 +289,7 @@
 
 static struct i2c_adapter vt596_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_ADAP_CLASS_SMBUS,
+	.class		= I2C_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-voodoo3.c i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-voodoo3.c
--- xx-linux-2.6.6-rc3/drivers/i2c/busses/i2c-voodoo3.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/busses/i2c-voodoo3.c	2004-05-05 11:40:37.000000000 +0200
@@ -167,7 +167,7 @@
 
 static struct i2c_adapter voodoo3_i2c_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_ADAP_CLASS_TV_ANALOG, 
+	.class		= I2C_CLASS_TV_ANALOG, 
 	.name		= "I2C Voodoo3/Banshee adapter",
 	.algo_data	= &voo_i2c_bit_data,
 };
@@ -184,7 +184,7 @@
 
 static struct i2c_adapter voodoo3_ddc_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_ADAP_CLASS_DDC, 
+	.class		= I2C_CLASS_DDC, 
 	.name		= "DDC Voodoo3/Banshee adapter",
 	.algo_data	= &voo_ddc_bit_data,
 };
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/chips/adm1021.c i2c-linux-2.6.6-rc3/drivers/i2c/chips/adm1021.c
--- xx-linux-2.6.6-rc3/drivers/i2c/chips/adm1021.c	2004-04-29 10:38:35.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/chips/adm1021.c	2004-05-05 11:40:37.000000000 +0200
@@ -200,7 +200,7 @@
 
 static int adm1021_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, adm1021_detect);
 }
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/chips/asb100.c i2c-linux-2.6.6-rc3/drivers/i2c/chips/asb100.c
--- xx-linux-2.6.6-rc3/drivers/i2c/chips/asb100.c	2004-04-29 10:38:35.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/chips/asb100.c	2004-05-05 11:40:37.000000000 +0200
@@ -609,7 +609,7 @@
  */
 static int asb100_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, asb100_detect);
 }
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/chips/fscher.c i2c-linux-2.6.6-rc3/drivers/i2c/chips/fscher.c
--- xx-linux-2.6.6-rc3/drivers/i2c/chips/fscher.c	2004-04-29 10:38:35.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/chips/fscher.c	2004-05-05 11:40:37.000000000 +0200
@@ -293,7 +293,7 @@
 
 static int fscher_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, fscher_detect);
 }
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/chips/gl518sm.c i2c-linux-2.6.6-rc3/drivers/i2c/chips/gl518sm.c
--- xx-linux-2.6.6-rc3/drivers/i2c/chips/gl518sm.c	2004-04-29 10:38:35.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/chips/gl518sm.c	2004-05-05 11:40:37.000000000 +0200
@@ -335,7 +335,7 @@
 
 static int gl518_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, gl518_detect);
 }
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/chips/it87.c i2c-linux-2.6.6-rc3/drivers/i2c/chips/it87.c
--- xx-linux-2.6.6-rc3/drivers/i2c/chips/it87.c	2004-04-29 10:38:35.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/chips/it87.c	2004-05-05 11:40:37.000000000 +0200
@@ -500,7 +500,7 @@
      * when a new adapter is inserted (and it87_driver is still present) */
 static int it87_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, it87_detect);
 }
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/chips/lm75.c i2c-linux-2.6.6-rc3/drivers/i2c/chips/lm75.c
--- xx-linux-2.6.6-rc3/drivers/i2c/chips/lm75.c	2004-04-29 10:38:35.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/chips/lm75.c	2004-05-05 11:40:37.000000000 +0200
@@ -105,7 +105,7 @@
 
 static int lm75_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, lm75_detect);
 }
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/chips/lm78.c i2c-linux-2.6.6-rc3/drivers/i2c/chips/lm78.c
--- xx-linux-2.6.6-rc3/drivers/i2c/chips/lm78.c	2004-04-29 10:38:35.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/chips/lm78.c	2004-05-05 11:40:37.000000000 +0200
@@ -488,7 +488,7 @@
      * when a new adapter is inserted (and lm78_driver is still present) */
 static int lm78_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, lm78_detect);
 }
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/chips/lm80.c i2c-linux-2.6.6-rc3/drivers/i2c/chips/lm80.c
--- xx-linux-2.6.6-rc3/drivers/i2c/chips/lm80.c	2004-04-29 10:38:35.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/chips/lm80.c	2004-05-05 11:40:37.000000000 +0200
@@ -376,7 +376,7 @@
 
 static int lm80_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, lm80_detect);
 }
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/chips/lm83.c i2c-linux-2.6.6-rc3/drivers/i2c/chips/lm83.c
--- xx-linux-2.6.6-rc3/drivers/i2c/chips/lm83.c	2004-04-29 10:38:35.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/chips/lm83.c	2004-05-05 11:40:37.000000000 +0200
@@ -216,7 +216,7 @@
 
 static int lm83_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, lm83_detect);
 }
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/chips/lm90.c i2c-linux-2.6.6-rc3/drivers/i2c/chips/lm90.c
--- xx-linux-2.6.6-rc3/drivers/i2c/chips/lm90.c	2004-04-29 10:38:35.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/chips/lm90.c	2004-05-05 11:40:37.000000000 +0200
@@ -261,7 +261,7 @@
 
 static int lm90_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, lm90_detect);
 }
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/chips/via686a.c i2c-linux-2.6.6-rc3/drivers/i2c/chips/via686a.c
--- xx-linux-2.6.6-rc3/drivers/i2c/chips/via686a.c	2004-04-29 10:38:35.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/chips/via686a.c	2004-05-05 11:40:37.000000000 +0200
@@ -602,7 +602,7 @@
 /* This is called when the module is loaded */
 static int via686a_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, via686a_detect);
 }
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/chips/w83781d.c i2c-linux-2.6.6-rc3/drivers/i2c/chips/w83781d.c
--- xx-linux-2.6.6-rc3/drivers/i2c/chips/w83781d.c	2004-04-29 10:38:35.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/chips/w83781d.c	2004-05-05 11:40:37.000000000 +0200
@@ -905,7 +905,7 @@
 static int
 w83781d_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, w83781d_detect);
 }
diff -ura xx-linux-2.6.6-rc3/drivers/i2c/chips/w83l785ts.c i2c-linux-2.6.6-rc3/drivers/i2c/chips/w83l785ts.c
--- xx-linux-2.6.6-rc3/drivers/i2c/chips/w83l785ts.c	2004-04-29 10:38:35.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/i2c/chips/w83l785ts.c	2004-05-05 11:40:37.000000000 +0200
@@ -145,7 +145,7 @@
 
 static int w83l785ts_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, w83l785ts_detect);
 }
diff -ura xx-linux-2.6.6-rc3/drivers/media/video/bt832.c i2c-linux-2.6.6-rc3/drivers/media/video/bt832.c
--- xx-linux-2.6.6-rc3/drivers/media/video/bt832.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/media/video/bt832.c	2004-05-05 11:40:37.000000000 +0200
@@ -197,7 +197,7 @@
 
 static int bt832_probe(struct i2c_adapter *adap)
 {
-	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, bt832_attach);
 	return 0;
 }
diff -ura xx-linux-2.6.6-rc3/drivers/media/video/bttv-i2c.c i2c-linux-2.6.6-rc3/drivers/media/video/bttv-i2c.c
--- xx-linux-2.6.6-rc3/drivers/media/video/bttv-i2c.c	2004-04-29 10:38:36.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/media/video/bttv-i2c.c	2004-05-05 11:40:37.000000000 +0200
@@ -108,8 +108,8 @@
 	.inc_use           = bttv_inc_use,
 	.dec_use           = bttv_dec_use,
 #endif
-#ifdef I2C_ADAP_CLASS_TV_ANALOG
-	.class             = I2C_ADAP_CLASS_TV_ANALOG,
+#ifdef I2C_CLASS_TV_ANALOG
+	.class             = I2C_CLASS_TV_ANALOG,
 #endif
 	I2C_DEVNAME("bt848"),
 	.id                = I2C_HW_B_BT848,
@@ -291,8 +291,8 @@
 	.inc_use       = bttv_inc_use,
 	.dec_use       = bttv_dec_use,
 #endif
-#ifdef I2C_ADAP_CLASS_TV_ANALOG
-	.class         = I2C_ADAP_CLASS_TV_ANALOG,
+#ifdef I2C_CLASS_TV_ANALOG
+	.class         = I2C_CLASS_TV_ANALOG,
 #endif
 	I2C_DEVNAME("bt878"),
 	.id            = I2C_ALGO_BIT | I2C_HW_B_BT848 /* FIXME */,
diff -ura xx-linux-2.6.6-rc3/drivers/media/video/cx88/cx88-i2c.c i2c-linux-2.6.6-rc3/drivers/media/video/cx88/cx88-i2c.c
--- xx-linux-2.6.6-rc3/drivers/media/video/cx88/cx88-i2c.c	2004-04-29 10:38:36.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/media/video/cx88/cx88-i2c.c	2004-05-05 11:40:37.000000000 +0200
@@ -128,8 +128,8 @@
 	.inc_use           = cx8800_inc_use,
 	.dec_use           = cx8800_dec_use,
 #endif
-#ifdef I2C_ADAP_CLASS_TV_ANALOG
-	.class             = I2C_ADAP_CLASS_TV_ANALOG,
+#ifdef I2C_CLASS_TV_ANALOG
+	.class             = I2C_CLASS_TV_ANALOG,
 #endif
 	I2C_DEVNAME("cx2388x"),
 	.id                = I2C_HW_B_BT848,
diff -ura xx-linux-2.6.6-rc3/drivers/media/video/dpc7146.c i2c-linux-2.6.6-rc3/drivers/media/video/dpc7146.c
--- xx-linux-2.6.6-rc3/drivers/media/video/dpc7146.c	2004-04-29 10:38:36.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/media/video/dpc7146.c	2004-05-05 11:40:37.000000000 +0200
@@ -106,7 +106,7 @@
 	   video port pins should be enabled here ?! */
 	saa7146_write(dev, MC1, (MASK_08 | MASK_24 | MASK_10 | MASK_26));
 
-	saa7146_i2c_adapter_prepare(dev, &dpc->i2c_adapter, I2C_ADAP_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
+	saa7146_i2c_adapter_prepare(dev, &dpc->i2c_adapter, I2C_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
 	if(i2c_add_adapter(&dpc->i2c_adapter) < 0) {
 		DEB_S(("cannot register i2c-device. skipping.\n"));
 		kfree(dpc);
diff -ura xx-linux-2.6.6-rc3/drivers/media/video/hexium_gemini.c i2c-linux-2.6.6-rc3/drivers/media/video/hexium_gemini.c
--- xx-linux-2.6.6-rc3/drivers/media/video/hexium_gemini.c	2004-04-29 10:38:36.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/media/video/hexium_gemini.c	2004-05-05 11:40:37.000000000 +0200
@@ -250,7 +250,7 @@
 	/* enable i2c-port pins */
 	saa7146_write(dev, MC1, (MASK_08 | MASK_24 | MASK_10 | MASK_26));
 
-	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, I2C_ADAP_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
+	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, I2C_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
 	if (i2c_add_adapter(&hexium->i2c_adapter) < 0) {
 		DEB_S(("cannot register i2c-device. skipping.\n"));
 		kfree(hexium);
diff -ura xx-linux-2.6.6-rc3/drivers/media/video/hexium_orion.c i2c-linux-2.6.6-rc3/drivers/media/video/hexium_orion.c
--- xx-linux-2.6.6-rc3/drivers/media/video/hexium_orion.c	2004-04-29 10:38:36.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/media/video/hexium_orion.c	2004-05-05 11:40:37.000000000 +0200
@@ -237,7 +237,7 @@
 	saa7146_write(dev, DD1_STREAM_B, 0x00000000);
 	saa7146_write(dev, MC2, (MASK_09 | MASK_25 | MASK_10 | MASK_26));
 
-	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, I2C_ADAP_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
+	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, I2C_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
 	if (i2c_add_adapter(&hexium->i2c_adapter) < 0) {
 		DEB_S(("cannot register i2c-device. skipping.\n"));
 		kfree(hexium);
diff -ura xx-linux-2.6.6-rc3/drivers/media/video/msp3400.c i2c-linux-2.6.6-rc3/drivers/media/video/msp3400.c
--- xx-linux-2.6.6-rc3/drivers/media/video/msp3400.c	2004-04-29 10:38:36.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/media/video/msp3400.c	2004-05-05 11:40:37.000000000 +0200
@@ -1353,8 +1353,8 @@
 
 static int msp_probe(struct i2c_adapter *adap)
 {
-#ifdef I2C_ADAP_CLASS_TV_ANALOG
-	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+#ifdef I2C_CLASS_TV_ANALOG
+	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, msp_attach);
 #else
 	switch (adap->id) {
diff -ura xx-linux-2.6.6-rc3/drivers/media/video/mxb.c i2c-linux-2.6.6-rc3/drivers/media/video/mxb.c
--- xx-linux-2.6.6-rc3/drivers/media/video/mxb.c	2004-04-29 10:38:36.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/media/video/mxb.c	2004-05-05 11:40:37.000000000 +0200
@@ -223,7 +223,7 @@
 	   video port pins should be enabled here ?! */
 	saa7146_write(dev, MC1, (MASK_08 | MASK_24 | MASK_10 | MASK_26));
 
-	saa7146_i2c_adapter_prepare(dev, &mxb->i2c_adapter, I2C_ADAP_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
+	saa7146_i2c_adapter_prepare(dev, &mxb->i2c_adapter, I2C_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
 	if(i2c_add_adapter(&mxb->i2c_adapter) < 0) {
 		DEB_S(("cannot register i2c-device. skipping.\n"));
 		kfree(mxb);
diff -ura xx-linux-2.6.6-rc3/drivers/media/video/saa5246a.c i2c-linux-2.6.6-rc3/drivers/media/video/saa5246a.c
--- xx-linux-2.6.6-rc3/drivers/media/video/saa5246a.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/media/video/saa5246a.c	2004-05-05 11:40:37.000000000 +0200
@@ -143,7 +143,7 @@
  */
 static int saa5246a_probe(struct i2c_adapter *adap)
 {
-	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, saa5246a_attach);
 	return 0;
 }
diff -ura xx-linux-2.6.6-rc3/drivers/media/video/saa5249.c i2c-linux-2.6.6-rc3/drivers/media/video/saa5249.c
--- xx-linux-2.6.6-rc3/drivers/media/video/saa5249.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/media/video/saa5249.c	2004-05-05 11:40:37.000000000 +0200
@@ -219,7 +219,7 @@
  
 static int saa5249_probe(struct i2c_adapter *adap)
 {
-	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, saa5249_attach);
 	return 0;
 }
diff -ura xx-linux-2.6.6-rc3/drivers/media/video/saa7134/saa6752hs.c i2c-linux-2.6.6-rc3/drivers/media/video/saa7134/saa6752hs.c
--- xx-linux-2.6.6-rc3/drivers/media/video/saa7134/saa6752hs.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/media/video/saa7134/saa6752hs.c	2004-05-05 11:40:37.000000000 +0200
@@ -335,7 +335,7 @@
 
 static int saa6752hs_probe(struct i2c_adapter *adap)
 {
-	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, saa6752hs_attach);
 
 	return 0;
diff -ura xx-linux-2.6.6-rc3/drivers/media/video/saa7134/saa7134-i2c.c i2c-linux-2.6.6-rc3/drivers/media/video/saa7134/saa7134-i2c.c
--- xx-linux-2.6.6-rc3/drivers/media/video/saa7134/saa7134-i2c.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/media/video/saa7134/saa7134-i2c.c	2004-05-05 11:40:37.000000000 +0200
@@ -347,8 +347,8 @@
 	.inc_use       = inc_use,
 	.dec_use       = dec_use,
 #endif
-#ifdef I2C_ADAP_CLASS_TV_ANALOG
-	.class         = I2C_ADAP_CLASS_TV_ANALOG,
+#ifdef I2C_CLASS_TV_ANALOG
+	.class         = I2C_CLASS_TV_ANALOG,
 #endif
 	I2C_DEVNAME("saa7134"),
 	.id            = I2C_ALGO_SAA7134,
diff -ura xx-linux-2.6.6-rc3/drivers/media/video/tda7432.c i2c-linux-2.6.6-rc3/drivers/media/video/tda7432.c
--- xx-linux-2.6.6-rc3/drivers/media/video/tda7432.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/media/video/tda7432.c	2004-05-05 11:40:37.000000000 +0200
@@ -338,8 +338,8 @@
 
 static int tda7432_probe(struct i2c_adapter *adap)
 {
-#ifdef I2C_ADAP_CLASS_TV_ANALOG
-	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+#ifdef I2C_CLASS_TV_ANALOG
+	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, tda7432_attach);
 #else
 	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848))
diff -ura xx-linux-2.6.6-rc3/drivers/media/video/tda9875.c i2c-linux-2.6.6-rc3/drivers/media/video/tda9875.c
--- xx-linux-2.6.6-rc3/drivers/media/video/tda9875.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/media/video/tda9875.c	2004-05-05 11:40:37.000000000 +0200
@@ -272,8 +272,8 @@
 
 static int tda9875_probe(struct i2c_adapter *adap)
 {
-#ifdef I2C_ADAP_CLASS_TV_ANALOG
-	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+#ifdef I2C_CLASS_TV_ANALOG
+	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, tda9875_attach);
 #else
 	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848))
diff -ura xx-linux-2.6.6-rc3/drivers/media/video/tda9887.c i2c-linux-2.6.6-rc3/drivers/media/video/tda9887.c
--- xx-linux-2.6.6-rc3/drivers/media/video/tda9887.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/media/video/tda9887.c	2004-05-05 11:40:37.000000000 +0200
@@ -370,8 +370,8 @@
 
 static int tda9887_probe(struct i2c_adapter *adap)
 {
-#ifdef I2C_ADAP_CLASS_TV_ANALOG
-	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+#ifdef I2C_CLASS_TV_ANALOG
+	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, tda9887_attach);
 #else
 	switch (adap->id) {
diff -ura xx-linux-2.6.6-rc3/drivers/media/video/tuner.c i2c-linux-2.6.6-rc3/drivers/media/video/tuner.c
--- xx-linux-2.6.6-rc3/drivers/media/video/tuner.c	2004-04-29 10:38:36.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/media/video/tuner.c	2004-05-05 11:40:37.000000000 +0200
@@ -1067,8 +1067,8 @@
 	}
 	this_adap = 0;
 
-#ifdef I2C_ADAP_CLASS_TV_ANALOG
-	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+#ifdef I2C_CLASS_TV_ANALOG
+	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, tuner_attach);
 #else
 	switch (adap->id) {
diff -ura xx-linux-2.6.6-rc3/drivers/media/video/tvaudio.c i2c-linux-2.6.6-rc3/drivers/media/video/tvaudio.c
--- xx-linux-2.6.6-rc3/drivers/media/video/tvaudio.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/media/video/tvaudio.c	2004-05-05 11:40:37.000000000 +0200
@@ -1497,8 +1497,8 @@
 
 static int chip_probe(struct i2c_adapter *adap)
 {
-#ifdef I2C_ADAP_CLASS_TV_ANALOG
-	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+#ifdef I2C_CLASS_TV_ANALOG
+	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, chip_attach);
 #else
 	switch (adap->id) {
diff -ura xx-linux-2.6.6-rc3/drivers/media/video/tvmixer.c i2c-linux-2.6.6-rc3/drivers/media/video/tvmixer.c
--- xx-linux-2.6.6-rc3/drivers/media/video/tvmixer.c	2004-04-29 10:33:12.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/media/video/tvmixer.c	2004-05-05 11:40:37.000000000 +0200
@@ -263,8 +263,8 @@
 	struct video_audio va;
 	int i,minor;
 
-#ifdef I2C_ADAP_CLASS_TV_ANALOG
-	if (!(client->adapter->class & I2C_ADAP_CLASS_TV_ANALOG))
+#ifdef I2C_CLASS_TV_ANALOG
+	if (!(client->adapter->class & I2C_CLASS_TV_ANALOG))
 		return -1;
 #else
 	/* TV card ??? */
diff -ura xx-linux-2.6.6-rc3/drivers/usb/media/w9968cf.c i2c-linux-2.6.6-rc3/drivers/usb/media/w9968cf.c
--- xx-linux-2.6.6-rc3/drivers/usb/media/w9968cf.c	2004-04-29 10:38:42.000000000 +0200
+++ i2c-linux-2.6.6-rc3/drivers/usb/media/w9968cf.c	2004-05-05 11:40:37.000000000 +0200
@@ -1578,7 +1578,7 @@
 
 	static struct i2c_adapter adap = {
 		.id =                I2C_ALGO_SMBUS | I2C_HW_SMBUS_W9968CF,
-		.class =             I2C_ADAP_CLASS_CAM_DIGITAL,
+		.class =             I2C_CLASS_CAM_DIGITAL,
 		.owner =             THIS_MODULE,
 		.client_register =   w9968cf_i2c_attach_inform,
 		.client_unregister = w9968cf_i2c_detach_inform,
diff -ura xx-linux-2.6.6-rc3/include/linux/i2c.h i2c-linux-2.6.6-rc3/include/linux/i2c.h
--- xx-linux-2.6.6-rc3/include/linux/i2c.h	2004-04-29 10:33:57.000000000 +0200
+++ i2c-linux-2.6.6-rc3/include/linux/i2c.h	2004-05-05 18:29:31.000000000 +0200
@@ -113,6 +113,7 @@
 	struct module *owner;
 	char name[32];
 	int id;
+	unsigned int class;
 	unsigned int flags;		/* div., see below		*/
 
 	/* Notifies the driver that a new bus has appeared. This routine
@@ -237,7 +238,6 @@
 	/* data fields that are valid for all devices	*/
 	struct semaphore bus_lock;
 	struct semaphore clist_lock;
-	unsigned int flags;/* flags specifying div. data		*/
 
 	int timeout;
 	int retries;
@@ -286,12 +286,14 @@
 						/* Must equal I2C_M_TEN below */
 
 /* i2c adapter classes (bitmask) */
-#define I2C_ADAP_CLASS_SMBUS		(1<<0)	/* lm_sensors, ... */
-#define I2C_ADAP_CLASS_TV_ANALOG	(1<<1)	/* bttv + friends */
-#define I2C_ADAP_CLASS_TV_DIGITAL	(1<<2)	/* dbv cards */
-#define I2C_ADAP_CLASS_DDC		(1<<3)	/* i2c-matroxfb ? */
-#define I2C_ADAP_CLASS_CAM_ANALOG	(1<<4)	/* camera with analog CCD */
-#define I2C_ADAP_CLASS_CAM_DIGITAL	(1<<5)	/* most webcams */
+#define I2C_CLASS_SMBUS		(1<<0)	/* lm_sensors, ... */
+#define I2C_CLASS_TV_ANALOG	(1<<1)	/* bttv + friends */
+#define I2C_CLASS_TV_DIGITAL	(1<<2)	/* dvb cards */
+#define I2C_CLASS_DDC		(1<<3)	/* i2c-matroxfb ? */
+#define I2C_CLASS_CAM_ANALOG	(1<<4)	/* camera with analog CCD */
+#define I2C_CLASS_CAM_DIGITAL	(1<<5)	/* most webcams */
+#define I2C_CLASS_SOUND		(1<<6)	/* sound devices */
+#define I2C_CLASS_ALL		(UINT_MAX) /* all of the above */
 
 /* i2c_client_address_data is the struct for holding default client
  * addresses for a driver and for the parameters supplied on the

--------------040202060409050903070905--
