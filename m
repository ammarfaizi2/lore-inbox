Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVGSWBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVGSWBF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 18:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVGSV7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 17:59:02 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:8965 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262007AbVGSV5m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 17:57:42 -0400
Date: Tue, 19 Jul 2005 23:57:54 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] I2C: Separate non-i2c hwmon drivers from i2c-core (6/9)
Message-Id: <20050719235754.487f4bf1.khali@linux-fr.org>
In-Reply-To: <20050719233902.40282559.khali@linux-fr.org>
References: <20050719233902.40282559.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kill all isa-related stuff from i2c_detect, it's not used anymore.

This is one major step in the directiom of merging i2c_probe and
i2c_detect. The last obstacle I can think of is the different way forced
addresses work between sensors and non-sensors i2c drivers. I'll deal
with that in a later patchset.

 drivers/i2c/i2c-sensor-detect.c |   45 +++++++++++-----------------------------
 1 files changed, 13 insertions(+), 32 deletions(-)

--- linux-2.6.13-rc3.orig/drivers/i2c/i2c-sensor-detect.c	2005-06-18 09:32:15.000000000 +0200
+++ linux-2.6.13-rc3/drivers/i2c/i2c-sensor-detect.c	2005-07-17 14:27:26.000000000 +0200
@@ -25,42 +25,34 @@
 #include <linux/i2c-sensor.h>
 
 static unsigned short empty[] = {I2C_CLIENT_END};
-static unsigned int empty_isa[] = {I2C_CLIENT_ISA_END};
 
-/* Very inefficient for ISA detects, and won't work for 10-bit addresses! */
+/* Won't work for 10-bit addresses! */
 int i2c_detect(struct i2c_adapter *adapter,
 	       struct i2c_address_data *address_data,
 	       int (*found_proc) (struct i2c_adapter *, int, int))
 {
 	int addr, i, found, j, err;
 	struct i2c_force_data *this_force;
-	int is_isa = i2c_is_isa_adapter(adapter);
-	int adapter_id =
-	    is_isa ? ANY_I2C_ISA_BUS : i2c_adapter_id(adapter);
+	int adapter_id = i2c_adapter_id(adapter);
 	unsigned short *normal_i2c;
-	unsigned int *normal_isa;
 	unsigned short *probe;
 	unsigned short *ignore;
 
 	/* Forget it if we can't probe using SMBUS_QUICK */
-	if ((!is_isa) &&
-	    !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_QUICK))
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_QUICK))
 		return -1;
 	
 	/* Use default "empty" list if the adapter doesn't specify any */
 	normal_i2c = probe = ignore = empty;
-	normal_isa = empty_isa;
 	if (address_data->normal_i2c)
 		normal_i2c = address_data->normal_i2c;
-	if (address_data->normal_isa)
-		normal_isa = address_data->normal_isa;
 	if (address_data->probe)
 		probe = address_data->probe;
 	if (address_data->ignore)
 		ignore = address_data->ignore;
 
-	for (addr = 0x00; addr <= (is_isa ? 0xffff : 0x7f); addr++) {
-		if (!is_isa && i2c_check_addr(adapter, addr))
+	for (addr = 0x00; addr <= 0x7f; addr++) {
+		if (i2c_check_addr(adapter, addr))
 			continue;
 
 		/* If it is in one of the force entries, we don't do any
@@ -69,7 +61,7 @@
 		for (i = 0; !found && (this_force = address_data->forces + i, this_force->force); i++) {
 			for (j = 0; !found && (this_force->force[j] != I2C_CLIENT_END); j += 2) {
 				if ( ((adapter_id == this_force->force[j]) ||
-				      ((this_force->force[j] == ANY_I2C_BUS) && !is_isa)) &&
+				      (this_force->force[j] == ANY_I2C_BUS)) &&
 				      (addr == this_force->force[j + 1]) ) {
 					dev_dbg(&adapter->dev, "found force parameter for adapter %d, addr %04x\n", adapter_id, addr);
 					if ((err = found_proc(adapter, addr, this_force->kind)))
@@ -85,8 +77,7 @@
 		   right now */
 		for (i = 0; !found && (ignore[i] != I2C_CLIENT_END); i += 2) {
 			if ( ((adapter_id == ignore[i]) ||
-			      ((ignore[i] == ANY_I2C_BUS) &&
-			       !is_isa)) &&
+			      (ignore[i] == ANY_I2C_BUS)) &&
 			      (addr == ignore[i + 1])) {
 				dev_dbg(&adapter->dev, "found ignore parameter for adapter %d, addr %04x\n", adapter_id, addr);
 				found = 1;
@@ -97,19 +88,10 @@
 
 		/* Now, we will do a detection, but only if it is in the normal or 
 		   probe entries */
-		if (is_isa) {
-			for (i = 0; !found && (normal_isa[i] != I2C_CLIENT_ISA_END); i += 1) {
-				if (addr == normal_isa[i]) {
-					dev_dbg(&adapter->dev, "found normal isa entry for adapter %d, addr %04x\n", adapter_id, addr);
-					found = 1;
-				}
-			}
-		} else {
-			for (i = 0; !found && (normal_i2c[i] != I2C_CLIENT_END); i += 1) {
-				if (addr == normal_i2c[i]) {
-					found = 1;
-					dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, addr %02x\n", adapter_id, addr);
-				}
+		for (i = 0; !found && (normal_i2c[i] != I2C_CLIENT_END); i += 1) {
+			if (addr == normal_i2c[i]) {
+				found = 1;
+				dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, addr %02x\n", adapter_id, addr);
 			}
 		}
 
@@ -117,7 +99,7 @@
 		     !found && (probe[i] != I2C_CLIENT_END);
 		     i += 2) {
 			if (((adapter_id == probe[i]) ||
-			     ((probe[i] == ANY_I2C_BUS) && !is_isa))
+			     (probe[i] == ANY_I2C_BUS))
 			    && (addr == probe[i + 1])) {
 				dev_dbg(&adapter->dev, "found probe parameter for adapter %d, addr %04x\n", adapter_id, addr);
 				found = 1;
@@ -128,8 +110,7 @@
 
 		/* OK, so we really should examine this address. First check
 		   whether there is some client here at all! */
-		if (is_isa ||
-		    (i2c_smbus_xfer (adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL) >= 0))
+		if (i2c_smbus_xfer(adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL) >= 0)
 			if ((err = found_proc(adapter, addr, -1)))
 				return err;
 	}


-- 
Jean Delvare
