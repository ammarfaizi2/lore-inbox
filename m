Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUENXvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUENXvi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264657AbUENXvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:51:20 -0400
Received: from mail.kroah.org ([65.200.24.183]:27365 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264538AbUENXaC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:30:02 -0400
Subject: Re: [PATCH] I2C update for 2.6.6
In-Reply-To: <10845773571232@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 14 May 2004 16:29:17 -0700
Message-Id: <10845773573392@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.15.11, 2004/05/05 16:14:40-07:00, hunold@convergence.de

[PATCH] I2C: add .class to i2c drivers

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


 Documentation/i2c/porting-clients         |    4 ++--
 drivers/i2c/busses/i2c-ali1535.c          |    2 +-
 drivers/i2c/busses/i2c-ali1563.c          |    2 +-
 drivers/i2c/busses/i2c-ali15x3.c          |    2 +-
 drivers/i2c/busses/i2c-amd756.c           |    2 +-
 drivers/i2c/busses/i2c-amd8111.c          |    2 +-
 drivers/i2c/busses/i2c-i801.c             |    2 +-
 drivers/i2c/busses/i2c-isa.c              |    2 +-
 drivers/i2c/busses/i2c-nforce2.c          |    2 +-
 drivers/i2c/busses/i2c-parport-light.c    |    2 +-
 drivers/i2c/busses/i2c-parport.c          |    2 +-
 drivers/i2c/busses/i2c-piix4.c            |    2 +-
 drivers/i2c/busses/i2c-sis5595.c          |    2 +-
 drivers/i2c/busses/i2c-sis630.c           |    2 +-
 drivers/i2c/busses/i2c-sis96x.c           |    2 +-
 drivers/i2c/busses/i2c-via.c              |    2 +-
 drivers/i2c/busses/i2c-viapro.c           |    2 +-
 drivers/i2c/busses/i2c-voodoo3.c          |    4 ++--
 drivers/i2c/chips/adm1021.c               |    2 +-
 drivers/i2c/chips/asb100.c                |    2 +-
 drivers/i2c/chips/fscher.c                |    2 +-
 drivers/i2c/chips/gl518sm.c               |    2 +-
 drivers/i2c/chips/it87.c                  |    2 +-
 drivers/i2c/chips/lm75.c                  |    2 +-
 drivers/i2c/chips/lm78.c                  |    2 +-
 drivers/i2c/chips/lm80.c                  |    2 +-
 drivers/i2c/chips/lm83.c                  |    2 +-
 drivers/i2c/chips/lm90.c                  |    2 +-
 drivers/i2c/chips/via686a.c               |    2 +-
 drivers/i2c/chips/w83781d.c               |    2 +-
 drivers/i2c/chips/w83l785ts.c             |    2 +-
 drivers/media/video/bt832.c               |    2 +-
 drivers/media/video/bttv-i2c.c            |    8 ++++----
 drivers/media/video/cx88/cx88-i2c.c       |    4 ++--
 drivers/media/video/dpc7146.c             |    2 +-
 drivers/media/video/hexium_gemini.c       |    2 +-
 drivers/media/video/hexium_orion.c        |    2 +-
 drivers/media/video/msp3400.c             |    4 ++--
 drivers/media/video/mxb.c                 |    2 +-
 drivers/media/video/saa5246a.c            |    2 +-
 drivers/media/video/saa5249.c             |    2 +-
 drivers/media/video/saa7134/saa6752hs.c   |    2 +-
 drivers/media/video/saa7134/saa7134-i2c.c |    4 ++--
 drivers/media/video/tda7432.c             |    4 ++--
 drivers/media/video/tda9875.c             |    4 ++--
 drivers/media/video/tda9887.c             |    4 ++--
 drivers/media/video/tuner.c               |    4 ++--
 drivers/media/video/tvaudio.c             |    4 ++--
 drivers/media/video/tvmixer.c             |    4 ++--
 drivers/usb/media/w9968cf.c               |    2 +-
 include/linux/i2c.h                       |   16 +++++++++-------
 51 files changed, 73 insertions(+), 71 deletions(-)


diff -Nru a/Documentation/i2c/porting-clients b/Documentation/i2c/porting-clients
--- a/Documentation/i2c/porting-clients	Fri May 14 16:19:44 2004
+++ b/Documentation/i2c/porting-clients	Fri May 14 16:19:44 2004
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
 
diff -Nru a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
--- a/drivers/i2c/busses/i2c-ali1535.c	Fri May 14 16:19:45 2004
+++ b/drivers/i2c/busses/i2c-ali1535.c	Fri May 14 16:19:45 2004
@@ -480,7 +480,7 @@
 
 static struct i2c_adapter ali1535_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_ADAP_CLASS_SMBUS,
+	.class          = I2C_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -Nru a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
--- a/drivers/i2c/busses/i2c-ali1563.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/busses/i2c-ali1563.c	Fri May 14 16:19:44 2004
@@ -357,7 +357,7 @@
 
 static struct i2c_adapter ali1563_adapter = {
 	.owner	= THIS_MODULE,
-	.class	= I2C_ADAP_CLASS_SMBUS,
+	.class	= I2C_CLASS_SMBUS,
 	.algo	= &ali1563_algorithm,
 };
 
diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/busses/i2c-ali15x3.c	Fri May 14 16:19:44 2004
@@ -470,7 +470,7 @@
 
 static struct i2c_adapter ali15x3_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_ADAP_CLASS_SMBUS,
+	.class          = I2C_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	Fri May 14 16:19:45 2004
+++ b/drivers/i2c/busses/i2c-amd756.c	Fri May 14 16:19:45 2004
@@ -303,7 +303,7 @@
 
 static struct i2c_adapter amd756_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_ADAP_CLASS_SMBUS,
+	.class          = I2C_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	Fri May 14 16:19:45 2004
+++ b/drivers/i2c/busses/i2c-amd8111.c	Fri May 14 16:19:45 2004
@@ -359,7 +359,7 @@
 	smbus->adapter.owner = THIS_MODULE;
 	snprintf(smbus->adapter.name, I2C_NAME_SIZE,
 		"SMBus2 AMD8111 adapter at %04x", smbus->base);
-	smbus->adapter.class = I2C_ADAP_CLASS_SMBUS;
+	smbus->adapter.class = I2C_CLASS_SMBUS;
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
 
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/busses/i2c-i801.c	Fri May 14 16:19:44 2004
@@ -539,7 +539,7 @@
 
 static struct i2c_adapter i801_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_ADAP_CLASS_SMBUS,
+	.class		= I2C_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -Nru a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
--- a/drivers/i2c/busses/i2c-isa.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/busses/i2c-isa.c	Fri May 14 16:19:44 2004
@@ -43,7 +43,7 @@
 /* There can only be one... */
 static struct i2c_adapter isa_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_ADAP_CLASS_SMBUS,
+	.class          = I2C_CLASS_SMBUS,
 	.algo		= &isa_algorithm,
 	.name		= "ISA main adapter",
 };
diff -Nru a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/busses/i2c-nforce2.c	Fri May 14 16:19:44 2004
@@ -119,7 +119,7 @@
 
 static struct i2c_adapter nforce2_adapter = {
 	.owner          = THIS_MODULE,
-	.class          = I2C_ADAP_CLASS_SMBUS,
+	.class          = I2C_CLASS_SMBUS,
 	.algo           = &smbus_algorithm,
 	.name   	= "unset",
 };
diff -Nru a/drivers/i2c/busses/i2c-parport-light.c b/drivers/i2c/busses/i2c-parport-light.c
--- a/drivers/i2c/busses/i2c-parport-light.c	Fri May 14 16:19:45 2004
+++ b/drivers/i2c/busses/i2c-parport-light.c	Fri May 14 16:19:45 2004
@@ -112,7 +112,7 @@
 
 static struct i2c_adapter parport_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_ADAP_CLASS_SMBUS,
+	.class		= I2C_CLASS_SMBUS,
 	.id		= I2C_HW_B_LP,
 	.algo_data	= &parport_algo_data,
 	.name		= "Parallel port adapter (light)",
diff -Nru a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
--- a/drivers/i2c/busses/i2c-parport.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/busses/i2c-parport.c	Fri May 14 16:19:44 2004
@@ -147,7 +147,7 @@
 
 static struct i2c_adapter parport_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_ADAP_CLASS_SMBUS,
+	.class		= I2C_CLASS_SMBUS,
 	.id		= I2C_HW_B_LP,
 	.name		= "Parallel port adapter",
 };
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/busses/i2c-piix4.c	Fri May 14 16:19:44 2004
@@ -410,7 +410,7 @@
 
 static struct i2c_adapter piix4_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_ADAP_CLASS_SMBUS,
+	.class		= I2C_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -Nru a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
--- a/drivers/i2c/busses/i2c-sis5595.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/busses/i2c-sis5595.c	Fri May 14 16:19:44 2004
@@ -360,7 +360,7 @@
 
 static struct i2c_adapter sis5595_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_ADAP_CLASS_SMBUS,
+	.class          = I2C_CLASS_SMBUS,
 	.name		= "unset",
 	.algo		= &smbus_algorithm,
 };
diff -Nru a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
--- a/drivers/i2c/busses/i2c-sis630.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/busses/i2c-sis630.c	Fri May 14 16:19:44 2004
@@ -456,7 +456,7 @@
 
 static struct i2c_adapter sis630_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_ADAP_CLASS_SMBUS,
+	.class		= I2C_CLASS_SMBUS,
 	.name		= "unset",
 	.algo		= &smbus_algorithm,
 };
diff -Nru a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
--- a/drivers/i2c/busses/i2c-sis96x.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/busses/i2c-sis96x.c	Fri May 14 16:19:44 2004
@@ -260,7 +260,7 @@
 
 static struct i2c_adapter sis96x_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_ADAP_CLASS_SMBUS,
+	.class		= I2C_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -Nru a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
--- a/drivers/i2c/busses/i2c-via.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/busses/i2c-via.c	Fri May 14 16:19:44 2004
@@ -88,7 +88,7 @@
 
 static struct i2c_adapter vt586b_adapter = {
 	.owner		= THIS_MODULE,
-	.class          = I2C_ADAP_CLASS_SMBUS,
+	.class          = I2C_CLASS_SMBUS,
 	.name		= "VIA i2c",
 	.algo_data	= &bit_data,
 };
diff -Nru a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/busses/i2c-viapro.c	Fri May 14 16:19:44 2004
@@ -289,7 +289,7 @@
 
 static struct i2c_adapter vt596_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_ADAP_CLASS_SMBUS,
+	.class		= I2C_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -Nru a/drivers/i2c/busses/i2c-voodoo3.c b/drivers/i2c/busses/i2c-voodoo3.c
--- a/drivers/i2c/busses/i2c-voodoo3.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/busses/i2c-voodoo3.c	Fri May 14 16:19:44 2004
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
diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/chips/adm1021.c	Fri May 14 16:19:44 2004
@@ -200,7 +200,7 @@
 
 static int adm1021_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, adm1021_detect);
 }
diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/chips/asb100.c	Fri May 14 16:19:44 2004
@@ -609,7 +609,7 @@
  */
 static int asb100_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, asb100_detect);
 }
diff -Nru a/drivers/i2c/chips/fscher.c b/drivers/i2c/chips/fscher.c
--- a/drivers/i2c/chips/fscher.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/chips/fscher.c	Fri May 14 16:19:44 2004
@@ -293,7 +293,7 @@
 
 static int fscher_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, fscher_detect);
 }
diff -Nru a/drivers/i2c/chips/gl518sm.c b/drivers/i2c/chips/gl518sm.c
--- a/drivers/i2c/chips/gl518sm.c	Fri May 14 16:19:45 2004
+++ b/drivers/i2c/chips/gl518sm.c	Fri May 14 16:19:45 2004
@@ -335,7 +335,7 @@
 
 static int gl518_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, gl518_detect);
 }
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Fri May 14 16:19:45 2004
+++ b/drivers/i2c/chips/it87.c	Fri May 14 16:19:45 2004
@@ -500,7 +500,7 @@
      * when a new adapter is inserted (and it87_driver is still present) */
 static int it87_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, it87_detect);
 }
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/chips/lm75.c	Fri May 14 16:19:44 2004
@@ -105,7 +105,7 @@
 
 static int lm75_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, lm75_detect);
 }
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	Fri May 14 16:19:45 2004
+++ b/drivers/i2c/chips/lm78.c	Fri May 14 16:19:45 2004
@@ -488,7 +488,7 @@
      * when a new adapter is inserted (and lm78_driver is still present) */
 static int lm78_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, lm78_detect);
 }
diff -Nru a/drivers/i2c/chips/lm80.c b/drivers/i2c/chips/lm80.c
--- a/drivers/i2c/chips/lm80.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/chips/lm80.c	Fri May 14 16:19:44 2004
@@ -376,7 +376,7 @@
 
 static int lm80_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, lm80_detect);
 }
diff -Nru a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/chips/lm83.c	Fri May 14 16:19:44 2004
@@ -216,7 +216,7 @@
 
 static int lm83_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, lm83_detect);
 }
diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/chips/lm90.c	Fri May 14 16:19:44 2004
@@ -274,7 +274,7 @@
 
 static int lm90_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, lm90_detect);
 }
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/chips/via686a.c	Fri May 14 16:19:44 2004
@@ -573,7 +573,7 @@
 /* This is called when the module is loaded */
 static int via686a_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, via686a_detect);
 }
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/chips/w83781d.c	Fri May 14 16:19:44 2004
@@ -911,7 +911,7 @@
 static int
 w83781d_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, w83781d_detect);
 }
diff -Nru a/drivers/i2c/chips/w83l785ts.c b/drivers/i2c/chips/w83l785ts.c
--- a/drivers/i2c/chips/w83l785ts.c	Fri May 14 16:19:44 2004
+++ b/drivers/i2c/chips/w83l785ts.c	Fri May 14 16:19:44 2004
@@ -145,7 +145,7 @@
 
 static int w83l785ts_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+	if (!(adapter->class & I2C_CLASS_SMBUS))
 		return 0;
 	return i2c_detect(adapter, &addr_data, w83l785ts_detect);
 }
diff -Nru a/drivers/media/video/bt832.c b/drivers/media/video/bt832.c
--- a/drivers/media/video/bt832.c	Fri May 14 16:19:44 2004
+++ b/drivers/media/video/bt832.c	Fri May 14 16:19:44 2004
@@ -197,7 +197,7 @@
 
 static int bt832_probe(struct i2c_adapter *adap)
 {
-	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, bt832_attach);
 	return 0;
 }
diff -Nru a/drivers/media/video/bttv-i2c.c b/drivers/media/video/bttv-i2c.c
--- a/drivers/media/video/bttv-i2c.c	Fri May 14 16:19:44 2004
+++ b/drivers/media/video/bttv-i2c.c	Fri May 14 16:19:44 2004
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
diff -Nru a/drivers/media/video/cx88/cx88-i2c.c b/drivers/media/video/cx88/cx88-i2c.c
--- a/drivers/media/video/cx88/cx88-i2c.c	Fri May 14 16:19:44 2004
+++ b/drivers/media/video/cx88/cx88-i2c.c	Fri May 14 16:19:44 2004
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
diff -Nru a/drivers/media/video/dpc7146.c b/drivers/media/video/dpc7146.c
--- a/drivers/media/video/dpc7146.c	Fri May 14 16:19:44 2004
+++ b/drivers/media/video/dpc7146.c	Fri May 14 16:19:44 2004
@@ -106,7 +106,7 @@
 	   video port pins should be enabled here ?! */
 	saa7146_write(dev, MC1, (MASK_08 | MASK_24 | MASK_10 | MASK_26));
 
-	saa7146_i2c_adapter_prepare(dev, &dpc->i2c_adapter, I2C_ADAP_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
+	saa7146_i2c_adapter_prepare(dev, &dpc->i2c_adapter, I2C_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
 	if(i2c_add_adapter(&dpc->i2c_adapter) < 0) {
 		DEB_S(("cannot register i2c-device. skipping.\n"));
 		kfree(dpc);
diff -Nru a/drivers/media/video/hexium_gemini.c b/drivers/media/video/hexium_gemini.c
--- a/drivers/media/video/hexium_gemini.c	Fri May 14 16:19:44 2004
+++ b/drivers/media/video/hexium_gemini.c	Fri May 14 16:19:44 2004
@@ -250,7 +250,7 @@
 	/* enable i2c-port pins */
 	saa7146_write(dev, MC1, (MASK_08 | MASK_24 | MASK_10 | MASK_26));
 
-	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, I2C_ADAP_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
+	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, I2C_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
 	if (i2c_add_adapter(&hexium->i2c_adapter) < 0) {
 		DEB_S(("cannot register i2c-device. skipping.\n"));
 		kfree(hexium);
diff -Nru a/drivers/media/video/hexium_orion.c b/drivers/media/video/hexium_orion.c
--- a/drivers/media/video/hexium_orion.c	Fri May 14 16:19:45 2004
+++ b/drivers/media/video/hexium_orion.c	Fri May 14 16:19:45 2004
@@ -237,7 +237,7 @@
 	saa7146_write(dev, DD1_STREAM_B, 0x00000000);
 	saa7146_write(dev, MC2, (MASK_09 | MASK_25 | MASK_10 | MASK_26));
 
-	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, I2C_ADAP_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
+	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, I2C_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
 	if (i2c_add_adapter(&hexium->i2c_adapter) < 0) {
 		DEB_S(("cannot register i2c-device. skipping.\n"));
 		kfree(hexium);
diff -Nru a/drivers/media/video/msp3400.c b/drivers/media/video/msp3400.c
--- a/drivers/media/video/msp3400.c	Fri May 14 16:19:44 2004
+++ b/drivers/media/video/msp3400.c	Fri May 14 16:19:44 2004
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
diff -Nru a/drivers/media/video/mxb.c b/drivers/media/video/mxb.c
--- a/drivers/media/video/mxb.c	Fri May 14 16:19:44 2004
+++ b/drivers/media/video/mxb.c	Fri May 14 16:19:44 2004
@@ -223,7 +223,7 @@
 	   video port pins should be enabled here ?! */
 	saa7146_write(dev, MC1, (MASK_08 | MASK_24 | MASK_10 | MASK_26));
 
-	saa7146_i2c_adapter_prepare(dev, &mxb->i2c_adapter, I2C_ADAP_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
+	saa7146_i2c_adapter_prepare(dev, &mxb->i2c_adapter, I2C_CLASS_TV_ANALOG, SAA7146_I2C_BUS_BIT_RATE_480);
 	if(i2c_add_adapter(&mxb->i2c_adapter) < 0) {
 		DEB_S(("cannot register i2c-device. skipping.\n"));
 		kfree(mxb);
diff -Nru a/drivers/media/video/saa5246a.c b/drivers/media/video/saa5246a.c
--- a/drivers/media/video/saa5246a.c	Fri May 14 16:19:44 2004
+++ b/drivers/media/video/saa5246a.c	Fri May 14 16:19:44 2004
@@ -143,7 +143,7 @@
  */
 static int saa5246a_probe(struct i2c_adapter *adap)
 {
-	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, saa5246a_attach);
 	return 0;
 }
diff -Nru a/drivers/media/video/saa5249.c b/drivers/media/video/saa5249.c
--- a/drivers/media/video/saa5249.c	Fri May 14 16:19:44 2004
+++ b/drivers/media/video/saa5249.c	Fri May 14 16:19:44 2004
@@ -219,7 +219,7 @@
  
 static int saa5249_probe(struct i2c_adapter *adap)
 {
-	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, saa5249_attach);
 	return 0;
 }
diff -Nru a/drivers/media/video/saa7134/saa6752hs.c b/drivers/media/video/saa7134/saa6752hs.c
--- a/drivers/media/video/saa7134/saa6752hs.c	Fri May 14 16:19:45 2004
+++ b/drivers/media/video/saa7134/saa6752hs.c	Fri May 14 16:19:45 2004
@@ -335,7 +335,7 @@
 
 static int saa6752hs_probe(struct i2c_adapter *adap)
 {
-	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, saa6752hs_attach);
 
 	return 0;
diff -Nru a/drivers/media/video/saa7134/saa7134-i2c.c b/drivers/media/video/saa7134/saa7134-i2c.c
--- a/drivers/media/video/saa7134/saa7134-i2c.c	Fri May 14 16:19:44 2004
+++ b/drivers/media/video/saa7134/saa7134-i2c.c	Fri May 14 16:19:44 2004
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
diff -Nru a/drivers/media/video/tda7432.c b/drivers/media/video/tda7432.c
--- a/drivers/media/video/tda7432.c	Fri May 14 16:19:44 2004
+++ b/drivers/media/video/tda7432.c	Fri May 14 16:19:44 2004
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
diff -Nru a/drivers/media/video/tda9875.c b/drivers/media/video/tda9875.c
--- a/drivers/media/video/tda9875.c	Fri May 14 16:19:44 2004
+++ b/drivers/media/video/tda9875.c	Fri May 14 16:19:44 2004
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
diff -Nru a/drivers/media/video/tda9887.c b/drivers/media/video/tda9887.c
--- a/drivers/media/video/tda9887.c	Fri May 14 16:19:44 2004
+++ b/drivers/media/video/tda9887.c	Fri May 14 16:19:44 2004
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
diff -Nru a/drivers/media/video/tuner.c b/drivers/media/video/tuner.c
--- a/drivers/media/video/tuner.c	Fri May 14 16:19:45 2004
+++ b/drivers/media/video/tuner.c	Fri May 14 16:19:45 2004
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
diff -Nru a/drivers/media/video/tvaudio.c b/drivers/media/video/tvaudio.c
--- a/drivers/media/video/tvaudio.c	Fri May 14 16:19:44 2004
+++ b/drivers/media/video/tvaudio.c	Fri May 14 16:19:44 2004
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
diff -Nru a/drivers/media/video/tvmixer.c b/drivers/media/video/tvmixer.c
--- a/drivers/media/video/tvmixer.c	Fri May 14 16:19:45 2004
+++ b/drivers/media/video/tvmixer.c	Fri May 14 16:19:45 2004
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
diff -Nru a/drivers/usb/media/w9968cf.c b/drivers/usb/media/w9968cf.c
--- a/drivers/usb/media/w9968cf.c	Fri May 14 16:19:44 2004
+++ b/drivers/usb/media/w9968cf.c	Fri May 14 16:19:45 2004
@@ -1578,7 +1578,7 @@
 
 	static struct i2c_adapter adap = {
 		.id =                I2C_ALGO_SMBUS | I2C_HW_SMBUS_W9968CF,
-		.class =             I2C_ADAP_CLASS_CAM_DIGITAL,
+		.class =             I2C_CLASS_CAM_DIGITAL,
 		.owner =             THIS_MODULE,
 		.client_register =   w9968cf_i2c_attach_inform,
 		.client_unregister = w9968cf_i2c_detach_inform,
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Fri May 14 16:19:44 2004
+++ b/include/linux/i2c.h	Fri May 14 16:19:44 2004
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

