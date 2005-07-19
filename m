Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVGSWFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVGSWFy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 18:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbVGSWFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 18:05:53 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:46866 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S261724AbVGSWFW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 18:05:22 -0400
Date: Wed, 20 Jul 2005 00:05:33 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] I2C: Separate non-i2c hwmon drivers from i2c-core (8/9)
Message-Id: <20050720000533.57ad4953.khali@linux-fr.org>
In-Reply-To: <20050719233902.40282559.khali@linux-fr.org>
References: <20050719233902.40282559.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kill all uses of i2c_is_isa_adapter except for the hybrid drivers (it87,
lm78, w83781d). The i2c-isa adapter not being registered with the i2c
core anymore, drivers don't have to fear being erroneously attached to
it.

 Documentation/i2c/writing-clients |   11 +++++------
 drivers/hwmon/adm1021.c           |    9 ---------
 drivers/hwmon/asb100.c            |    8 --------
 drivers/hwmon/lm75.c              |   10 ----------
 drivers/hwmon/lm85.c              |    5 -----
 5 files changed, 5 insertions(+), 38 deletions(-)

--- linux-2.6.13-rc3.orig/Documentation/i2c/writing-clients	2005-07-17 15:20:30.000000000 +0200
+++ linux-2.6.13-rc3/Documentation/i2c/writing-clients	2005-07-17 15:45:47.000000000 +0200
@@ -315,11 +315,10 @@
     const char *type_name = "";
     int is_isa = i2c_is_isa_adapter(adapter);
 
-    if (is_isa) {
+    /* Do this only if the chip can additionally be found on the ISA bus
+       (hybrid chip). */
 
-      /* If this client can't be on the ISA bus at all, we can stop now
-         (call `goto ERROR0'). But for kicks, we will assume it is all
-         right. */
+    if (is_isa) {
 
       /* Discard immediately if this ISA range is already used */
       if (check_region(address,FOO_EXTENT))
@@ -495,10 +494,10 @@
       return err;
     }
 
-    /* SENSORS ONLY START */
+    /* HYBRID SENSORS CHIP ONLY START */
     if i2c_is_isa_client(client)
       release_region(client->addr,LM78_EXTENT);
-    /* SENSORS ONLY END */
+    /* HYBRID SENSORS CHIP ONLY END */
 
     kfree(client); /* Frees client data too, if allocated at the same time */
     return 0;
--- linux-2.6.13-rc3.orig/drivers/hwmon/adm1021.c	2005-07-17 15:13:16.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/adm1021.c	2005-07-17 16:06:34.000000000 +0200
@@ -198,15 +198,6 @@
 	int err = 0;
 	const char *type_name = "";
 
-	/* Make sure we aren't probing the ISA bus!! This is just a safety check
-	   at this moment; i2c_detect really won't call us. */
-#ifdef DEBUG
-	if (i2c_is_isa_adapter(adapter)) {
-		dev_dbg(&adapter->dev, "adm1021_detect called for an ISA bus adapter?!?\n");
-		return 0;
-	}
-#endif
-
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto error0;
 
--- linux-2.6.13-rc3.orig/drivers/hwmon/asb100.c	2005-07-17 15:12:52.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/asb100.c	2005-07-17 16:06:23.000000000 +0200
@@ -714,14 +714,6 @@
 	struct i2c_client *new_client;
 	struct asb100_data *data;
 
-	/* asb100 is SMBus only */
-	if (i2c_is_isa_adapter(adapter)) {
-		pr_debug("asb100.o: detect failed, "
-				"cannot attach to legacy adapter!\n");
-		err = -ENODEV;
-		goto ERROR0;
-	}
-
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
 		pr_debug("asb100.o: detect failed, "
 				"smbus byte data not supported!\n");
--- linux-2.6.13-rc3.orig/drivers/hwmon/lm75.c	2005-07-17 15:11:52.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/lm75.c	2005-07-17 16:05:51.000000000 +0200
@@ -121,16 +121,6 @@
 	int err = 0;
 	const char *name = "";
 
-	/* Make sure we aren't probing the ISA bus!! This is just a safety check
-	   at this moment; i2c_detect really won't call us. */
-#ifdef DEBUG
-	if (i2c_is_isa_adapter(adapter)) {
-		dev_dbg(&adapter->dev,
-			"lm75_detect called for an ISA bus adapter?!?\n");
-		goto exit;
-	}
-#endif
-
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 				     I2C_FUNC_SMBUS_WORD_DATA))
 		goto exit;
--- linux-2.6.13-rc3.orig/drivers/hwmon/lm85.c	2005-07-17 15:11:12.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/lm85.c	2005-07-17 16:05:43.000000000 +0200
@@ -1033,11 +1033,6 @@
 	int err = 0;
 	const char *type_name = "";
 
-	if (i2c_is_isa_adapter(adapter)) {
-		/* This chip has no ISA interface */
-		goto ERROR0 ;
-	};
-
 	if (!i2c_check_functionality(adapter,
 					I2C_FUNC_SMBUS_BYTE_DATA)) {
 		/* We need to be able to do byte I/O */


-- 
Jean Delvare
