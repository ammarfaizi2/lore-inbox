Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVGaTni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVGaTni (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 15:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVGaTnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 15:43:37 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:62994 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S261955AbVGaTmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 15:42:03 -0400
Date: Sun, 31 Jul 2005 21:42:02 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] (4/11) hwmon vs i2c, second round
Message-Id: <20050731214202.478c265f.khali@linux-fr.org>
In-Reply-To: <20050731205933.2e2a957f.khali@linux-fr.org>
References: <20050731205933.2e2a957f.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i2c_probe and i2c_detect now do the exact same thing and operate on
the same data structure, so we can have everyone call i2c_probe.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 Documentation/i2c/porting-clients |    1 +
 Documentation/i2c/writing-clients |   19 +++++--------------
 drivers/hwmon/adm1021.c           |    2 +-
 drivers/hwmon/adm1025.c           |    2 +-
 drivers/hwmon/adm1026.c           |    2 +-
 drivers/hwmon/adm1031.c           |    4 ++--
 drivers/hwmon/adm9240.c           |    2 +-
 drivers/hwmon/asb100.c            |    2 +-
 drivers/hwmon/atxp1.c             |    2 +-
 drivers/hwmon/ds1621.c            |    4 ++--
 drivers/hwmon/fscher.c            |    2 +-
 drivers/hwmon/fscpos.c            |    2 +-
 drivers/hwmon/gl518sm.c           |    2 +-
 drivers/hwmon/gl520sm.c           |    2 +-
 drivers/hwmon/it87.c              |    4 ++--
 drivers/hwmon/lm63.c              |    2 +-
 drivers/hwmon/lm75.c              |    4 ++--
 drivers/hwmon/lm77.c              |    4 ++--
 drivers/hwmon/lm78.c              |    4 ++--
 drivers/hwmon/lm80.c              |    2 +-
 drivers/hwmon/lm83.c              |    2 +-
 drivers/hwmon/lm85.c              |    2 +-
 drivers/hwmon/lm87.c              |    2 +-
 drivers/hwmon/lm90.c              |    2 +-
 drivers/hwmon/lm92.c              |    2 +-
 drivers/hwmon/max1619.c           |    2 +-
 drivers/hwmon/w83781d.c           |    2 +-
 drivers/hwmon/w83792d.c           |    2 +-
 drivers/hwmon/w83l785ts.c         |    2 +-
 drivers/i2c/chips/ds1337.c        |    2 +-
 drivers/i2c/chips/eeprom.c        |    4 ++--
 drivers/i2c/chips/max6875.c       |    4 ++--
 drivers/i2c/chips/pca9539.c       |    4 ++--
 drivers/i2c/chips/pcf8574.c       |    4 ++--
 drivers/i2c/chips/pcf8591.c       |    4 ++--
 35 files changed, 50 insertions(+), 58 deletions(-)

--- linux-2.6.13-rc4.orig/Documentation/i2c/porting-clients	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/Documentation/i2c/porting-clients	2005-07-31 20:55:59.000000000 +0200
@@ -66,6 +66,7 @@
   if (!(adapter->class & I2C_CLASS_HWMON))
           return 0;
   ISA-only drivers of course don't need this.
+  Call i2c_probe() instead of i2c_detect().
 
 * [Detect] As mentioned earlier, the flags parameter is gone.
   The type_name and client_name strings are replaced by a single
--- linux-2.6.13-rc4.orig/Documentation/i2c/writing-clients	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/Documentation/i2c/writing-clients	2005-07-31 20:55:59.000000000 +0200
@@ -148,7 +148,7 @@
 detection algorithm.
 
 You do not have to use this parameter interface; but don't try to use
-function i2c_probe() (or i2c_detect()) if you don't.
+function i2c_probe() if you don't.
 
 NOTE: If you want to write a `sensors' driver, the interface is slightly
       different! See below.
@@ -259,17 +259,10 @@
     return i2c_probe(adapter,&addr_data,&foo_detect_client);
   }
 
-For `sensors' drivers, use the i2c_detect function instead:
-  
-  int foo_attach_adapter(struct i2c_adapter *adapter)
-  { 
-    return i2c_detect(adapter,&addr_data,&foo_detect_client);
-  }
-
 Remember, structure `addr_data' is defined by the macros explained above,
 so you do not have to define it yourself.
 
-The i2c_probe or i2c_detect function will call the foo_detect_client
+The i2c_probe function will call the foo_detect_client
 function only for those i2c addresses that actually have a device on
 them (unless a `force' parameter was used). In addition, addresses that
 are already in use (by some other registered client) are skipped.
@@ -278,11 +271,9 @@
 The detect client function
 --------------------------
 
-The detect client function is called by i2c_probe or i2c_detect.
-The `kind' parameter contains 0 if this call is due to a `force'
-parameter, and -1 otherwise (for i2c_detect, it contains 0 if
-this call is due to the generic `force' parameter, and the chip type
-number if it is due to a specific `force' parameter).
+The detect client function is called by i2c_probe. The `kind' parameter
+contains -1 for a probed detection, 0 for a forced detection, or a positive
+number for a forced detection with a chip type forced.
 
 Below, some things are only needed if this is a `sensors' driver. Those
 parts are between /* SENSORS ONLY START */ and /* SENSORS ONLY END */
--- linux-2.6.13-rc4.orig/drivers/hwmon/adm1021.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/adm1021.c	2005-07-31 20:55:59.000000000 +0200
@@ -187,7 +187,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, adm1021_detect);
+	return i2c_probe(adapter, &addr_data, adm1021_detect);
 }
 
 static int adm1021_detect(struct i2c_adapter *adapter, int address, int kind)
--- linux-2.6.13-rc4.orig/drivers/hwmon/adm1025.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/adm1025.c	2005-07-31 20:55:59.000000000 +0200
@@ -314,7 +314,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, adm1025_detect);
+	return i2c_probe(adapter, &addr_data, adm1025_detect);
 }
 
 /*
--- linux-2.6.13-rc4.orig/drivers/hwmon/adm1026.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/adm1026.c	2005-07-31 20:55:59.000000000 +0200
@@ -321,7 +321,7 @@
 	if (!(adapter->class & I2C_CLASS_HWMON)) {
 		return 0;
 	}
-	return i2c_detect(adapter, &addr_data, adm1026_detect);
+	return i2c_probe(adapter, &addr_data, adm1026_detect);
 }
 
 int adm1026_detach_client(struct i2c_client *client)
--- linux-2.6.13-rc4.orig/drivers/hwmon/adm1031.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/adm1031.c	2005-07-31 20:55:59.000000000 +0200
@@ -727,10 +727,10 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, adm1031_detect);
+	return i2c_probe(adapter, &addr_data, adm1031_detect);
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 static int adm1031_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
--- linux-2.6.13-rc4.orig/drivers/hwmon/adm9240.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/adm9240.c	2005-07-31 20:55:59.000000000 +0200
@@ -635,7 +635,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, adm9240_detect);
+	return i2c_probe(adapter, &addr_data, adm9240_detect);
 }
 
 static int adm9240_detach_client(struct i2c_client *client)
--- linux-2.6.13-rc4.orig/drivers/hwmon/asb100.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/asb100.c	2005-07-31 20:55:59.000000000 +0200
@@ -621,7 +621,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, asb100_detect);
+	return i2c_probe(adapter, &addr_data, asb100_detect);
 }
 
 static int asb100_detect_subclients(struct i2c_adapter *adapter, int address,
--- linux-2.6.13-rc4.orig/drivers/hwmon/atxp1.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/atxp1.c	2005-07-31 20:55:59.000000000 +0200
@@ -254,7 +254,7 @@
 
 static int atxp1_attach_adapter(struct i2c_adapter *adapter)
 {
-	return i2c_detect(adapter, &addr_data, &atxp1_detect);
+	return i2c_probe(adapter, &addr_data, &atxp1_detect);
 };
 
 static int atxp1_detect(struct i2c_adapter *adapter, int address, int kind)
--- linux-2.6.13-rc4.orig/drivers/hwmon/ds1621.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/ds1621.c	2005-07-31 20:55:59.000000000 +0200
@@ -181,10 +181,10 @@
 
 static int ds1621_attach_adapter(struct i2c_adapter *adapter)
 {
-	return i2c_detect(adapter, &addr_data, ds1621_detect);
+	return i2c_probe(adapter, &addr_data, ds1621_detect);
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 int ds1621_detect(struct i2c_adapter *adapter, int address,
                   int kind)
 {
--- linux-2.6.13-rc4.orig/drivers/hwmon/fscher.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/fscher.c	2005-07-31 20:55:59.000000000 +0200
@@ -289,7 +289,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, fscher_detect);
+	return i2c_probe(adapter, &addr_data, fscher_detect);
 }
 
 static int fscher_detect(struct i2c_adapter *adapter, int address, int kind)
--- linux-2.6.13-rc4.orig/drivers/hwmon/fscpos.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/fscpos.c	2005-07-31 20:55:59.000000000 +0200
@@ -436,7 +436,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, fscpos_detect);
+	return i2c_probe(adapter, &addr_data, fscpos_detect);
 }
 
 int fscpos_detect(struct i2c_adapter *adapter, int address, int kind)
--- linux-2.6.13-rc4.orig/drivers/hwmon/gl518sm.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/gl518sm.c	2005-07-31 20:55:59.000000000 +0200
@@ -348,7 +348,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, gl518_detect);
+	return i2c_probe(adapter, &addr_data, gl518_detect);
 }
 
 static int gl518_detect(struct i2c_adapter *adapter, int address, int kind)
--- linux-2.6.13-rc4.orig/drivers/hwmon/gl520sm.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/gl520sm.c	2005-07-31 20:55:59.000000000 +0200
@@ -520,7 +520,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, gl520_detect);
+	return i2c_probe(adapter, &addr_data, gl520_detect);
 }
 
 static int gl520_detect(struct i2c_adapter *adapter, int address, int kind)
--- linux-2.6.13-rc4.orig/drivers/hwmon/it87.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/it87.c	2005-07-31 20:55:59.000000000 +0200
@@ -698,7 +698,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, it87_detect);
+	return i2c_probe(adapter, &addr_data, it87_detect);
 }
 
 static int it87_isa_attach_adapter(struct i2c_adapter *adapter)
@@ -738,7 +738,7 @@
 	return err;
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 int it87_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm63.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm63.c	2005-07-31 20:55:59.000000000 +0200
@@ -360,7 +360,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, lm63_detect);
+	return i2c_probe(adapter, &addr_data, lm63_detect);
 }
 
 /*
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm75.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm75.c	2005-07-31 20:55:59.000000000 +0200
@@ -109,10 +109,10 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, lm75_detect);
+	return i2c_probe(adapter, &addr_data, lm75_detect);
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 static int lm75_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm77.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm77.c	2005-07-31 20:55:59.000000000 +0200
@@ -209,10 +209,10 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, lm77_detect);
+	return i2c_probe(adapter, &addr_data, lm77_detect);
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 static int lm77_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm78.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm78.c	2005-07-31 20:55:59.000000000 +0200
@@ -478,7 +478,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, lm78_detect);
+	return i2c_probe(adapter, &addr_data, lm78_detect);
 }
 
 static int lm78_isa_attach_adapter(struct i2c_adapter *adapter)
@@ -486,7 +486,7 @@
 	return lm78_detect(adapter, isa_address, -1);
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 int lm78_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i, err;
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm80.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm80.c	2005-07-31 20:55:59.000000000 +0200
@@ -391,7 +391,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, lm80_detect);
+	return i2c_probe(adapter, &addr_data, lm80_detect);
 }
 
 int lm80_detect(struct i2c_adapter *adapter, int address, int kind)
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm83.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm83.c	2005-07-31 20:55:59.000000000 +0200
@@ -214,7 +214,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, lm83_detect);
+	return i2c_probe(adapter, &addr_data, lm83_detect);
 }
 
 /*
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm85.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm85.c	2005-07-31 20:55:59.000000000 +0200
@@ -1012,7 +1012,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, lm85_detect);
+	return i2c_probe(adapter, &addr_data, lm85_detect);
 }
 
 int lm85_detect(struct i2c_adapter *adapter, int address,
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm87.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm87.c	2005-07-31 20:55:59.000000000 +0200
@@ -539,7 +539,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, lm87_detect);
+	return i2c_probe(adapter, &addr_data, lm87_detect);
 }
 
 /*
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm90.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm90.c	2005-07-31 20:55:59.000000000 +0200
@@ -354,7 +354,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, lm90_detect);
+	return i2c_probe(adapter, &addr_data, lm90_detect);
 }
 
 /*
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm92.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm92.c	2005-07-31 20:55:59.000000000 +0200
@@ -389,7 +389,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, lm92_detect);
+	return i2c_probe(adapter, &addr_data, lm92_detect);
 }
 
 static int lm92_detach_client(struct i2c_client *client)
--- linux-2.6.13-rc4.orig/drivers/hwmon/max1619.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/max1619.c	2005-07-31 20:55:59.000000000 +0200
@@ -180,7 +180,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, max1619_detect);
+	return i2c_probe(adapter, &addr_data, max1619_detect);
 }
 
 /*
--- linux-2.6.13-rc4.orig/drivers/hwmon/w83781d.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/w83781d.c	2005-07-31 20:55:59.000000000 +0200
@@ -869,7 +869,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, w83781d_detect);
+	return i2c_probe(adapter, &addr_data, w83781d_detect);
 }
 
 static int
--- linux-2.6.13-rc4.orig/drivers/hwmon/w83792d.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/w83792d.c	2005-07-31 20:55:59.000000000 +0200
@@ -1076,7 +1076,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, w83792d_detect);
+	return i2c_probe(adapter, &addr_data, w83792d_detect);
 }
 
 
--- linux-2.6.13-rc4.orig/drivers/hwmon/w83l785ts.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/w83l785ts.c	2005-07-31 20:55:59.000000000 +0200
@@ -142,7 +142,7 @@
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, w83l785ts_detect);
+	return i2c_probe(adapter, &addr_data, w83l785ts_detect);
 }
 
 /*
--- linux-2.6.13-rc4.orig/drivers/i2c/chips/ds1337.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/chips/ds1337.c	2005-07-31 20:55:59.000000000 +0200
@@ -226,7 +226,7 @@
 
 static int ds1337_attach_adapter(struct i2c_adapter *adapter)
 {
-	return i2c_detect(adapter, &addr_data, ds1337_detect);
+	return i2c_probe(adapter, &addr_data, ds1337_detect);
 }
 
 /*
--- linux-2.6.13-rc4.orig/drivers/i2c/chips/eeprom.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/chips/eeprom.c	2005-07-31 20:55:59.000000000 +0200
@@ -152,10 +152,10 @@
 
 static int eeprom_attach_adapter(struct i2c_adapter *adapter)
 {
-	return i2c_detect(adapter, &addr_data, eeprom_detect);
+	return i2c_probe(adapter, &addr_data, eeprom_detect);
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 int eeprom_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
--- linux-2.6.13-rc4.orig/drivers/i2c/chips/max6875.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/chips/max6875.c	2005-07-31 20:55:59.000000000 +0200
@@ -161,10 +161,10 @@
 
 static int max6875_attach_adapter(struct i2c_adapter *adapter)
 {
-	return i2c_detect(adapter, &addr_data, max6875_detect);
+	return i2c_probe(adapter, &addr_data, max6875_detect);
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 static int max6875_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *real_client;
--- linux-2.6.13-rc4.orig/drivers/i2c/chips/pca9539.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/chips/pca9539.c	2005-07-31 20:55:59.000000000 +0200
@@ -108,10 +108,10 @@
 
 static int pca9539_attach_adapter(struct i2c_adapter *adapter)
 {
-	return i2c_detect(adapter, &addr_data, pca9539_detect);
+	return i2c_probe(adapter, &addr_data, pca9539_detect);
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 static int pca9539_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
--- linux-2.6.13-rc4.orig/drivers/i2c/chips/pcf8574.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/chips/pcf8574.c	2005-07-31 20:55:59.000000000 +0200
@@ -112,10 +112,10 @@
 
 static int pcf8574_attach_adapter(struct i2c_adapter *adapter)
 {
-	return i2c_detect(adapter, &addr_data, pcf8574_detect);
+	return i2c_probe(adapter, &addr_data, pcf8574_detect);
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 int pcf8574_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
--- linux-2.6.13-rc4.orig/drivers/i2c/chips/pcf8591.c	2005-07-31 14:25:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/chips/pcf8591.c	2005-07-31 20:55:59.000000000 +0200
@@ -163,10 +163,10 @@
  */
 static int pcf8591_attach_adapter(struct i2c_adapter *adapter)
 {
-	return i2c_detect(adapter, &addr_data, pcf8591_detect);
+	return i2c_probe(adapter, &addr_data, pcf8591_detect);
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 int pcf8591_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;


-- 
Jean Delvare
