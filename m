Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVGZWgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVGZWgj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 18:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbVGZWd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 18:33:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:50924 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262303AbVGZWcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 18:32:50 -0400
Subject: patch i2c-hwmon-split-08.patch added to gregkh-2.6 tree
To: khali@linux-fr.org, greg@kroah.com, gregkh@suse.de,
       linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
From: <gregkh@suse.de>
Date: Tue, 26 Jul 2005 15:33:18 -0700
In-Reply-To: <20050720000533.57ad4953.khali@linux-fr.org>
Message-ID: <1DxXzC-0ZH-00@press.kroah.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: I2C: Separate non-i2c hwmon drivers from i2c-core (8/9)

to my gregkh-2.6 tree.  Its filename is

     i2c-hwmon-split-08.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Patches currently in gregkh-2.6 which might be from khali@linux-fr.org are

i2c/i2c-max6875-documentation-update.patch
i2c/i2c-max6875-simplify.patch
i2c/i2c-hwmon-class-01.patch
i2c/i2c-hwmon-class-02.patch
i2c/i2c-hwmon-class-03.patch
i2c/i2c-missing-space.patch
i2c/i2c-nforce2-cleanup.patch
i2c/i2c-hwmon-split-01.patch
i2c/i2c-hwmon-split-02.patch
i2c/i2c-hwmon-split-03.patch
i2c/i2c-hwmon-split-04.patch
i2c/i2c-hwmon-split-05.patch
i2c/i2c-hwmon-split-06.patch
i2c/i2c-hwmon-split-07.patch
i2c/i2c-hwmon-split-08.patch
i2c/i2c-hwmon-split-09.patch


>From khali@linux-fr.org Tue Jul 19 18:06:45 2005
Date: Wed, 20 Jul 2005 00:05:33 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>, LM Sensors
 <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: I2C: Separate non-i2c hwmon drivers from i2c-core (8/9)
Message-Id: <20050720000533.57ad4953.khali@linux-fr.org>

Kill all uses of i2c_is_isa_adapter except for the hybrid drivers (it87,
lm78, w83781d). The i2c-isa adapter not being registered with the i2c
core anymore, drivers don't have to fear being erroneously attached to
it.


Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 Documentation/i2c/writing-clients |   11 +++++------
 drivers/hwmon/adm1021.c           |    9 ---------
 drivers/hwmon/asb100.c            |    8 --------
 drivers/hwmon/lm75.c              |   10 ----------
 drivers/hwmon/lm85.c              |    5 -----
 5 files changed, 5 insertions(+), 38 deletions(-)

--- gregkh-2.6.orig/Documentation/i2c/writing-clients	2005-07-26 15:16:45.000000000 -0700
+++ gregkh-2.6/Documentation/i2c/writing-clients	2005-07-26 15:16:46.000000000 -0700
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
--- gregkh-2.6.orig/drivers/hwmon/adm1021.c	2005-07-26 15:16:45.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/adm1021.c	2005-07-26 15:16:46.000000000 -0700
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
 
--- gregkh-2.6.orig/drivers/hwmon/asb100.c	2005-07-26 15:16:45.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/asb100.c	2005-07-26 15:16:46.000000000 -0700
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
--- gregkh-2.6.orig/drivers/hwmon/lm75.c	2005-07-26 15:16:45.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/lm75.c	2005-07-26 15:16:46.000000000 -0700
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
--- gregkh-2.6.orig/drivers/hwmon/lm85.c	2005-07-26 15:16:45.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/lm85.c	2005-07-26 15:16:46.000000000 -0700
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
