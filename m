Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261335AbTCYBaI>; Mon, 24 Mar 2003 20:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261328AbTCYBaD>; Mon, 24 Mar 2003 20:30:03 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:24080 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261338AbTCYB2H>;
	Mon, 24 Mar 2003 20:28:07 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.66
In-reply-to: <10485563232187@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Mar 2003 17:38 -0800
Message-id: <10485563231250@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.889.357.9, 2003/03/21 16:45:59-08:00, greg@kroah.com

i2c: ugh, clean up lindent mess in i2c-proc.c::i2c_detect()

Yes, this function now goes beyond 80 columns, but it's almost 
readable, while the previous version was not.

Also removed some #ifdefs


 drivers/i2c/i2c-proc.c |  180 ++++++++++++-------------------------------------
 1 files changed, 47 insertions(+), 133 deletions(-)


diff -Nru a/drivers/i2c/i2c-proc.c b/drivers/i2c/i2c-proc.c
--- a/drivers/i2c/i2c-proc.c	Mon Mar 24 17:27:42 2003
+++ b/drivers/i2c/i2c-proc.c	Mon Mar 24 17:27:42 2003
@@ -23,6 +23,8 @@
     This driver puts entries in /proc/sys/dev/sensors for each I2C device
 */
 
+/* #define DEBUG 1 */
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -581,9 +583,9 @@
 	    is_isa ? SENSORS_ISA_BUS : i2c_adapter_id(adapter);
 
 	/* Forget it if we can't probe using SMBUS_QUICK */
-	if ((!is_isa)
-	    && !i2c_check_functionality(adapter,
-					I2C_FUNC_SMBUS_QUICK)) return -1;
+	if ((!is_isa) &&
+	    !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_QUICK))
+		return -1;
 
 	for (addr = 0x00; addr <= (is_isa ? 0xffff : 0x7f); addr++) {
 		/* XXX: WTF is going on here??? */
@@ -594,31 +596,14 @@
 		/* If it is in one of the force entries, we don't do any
 		   detection at all */
 		found = 0;
-		for (i = 0;
-		     !found
-		     && (this_force =
-			 address_data->forces + i, this_force->force); i++) {
-			for (j = 0;
-			     !found
-			     && (this_force->force[j] != SENSORS_I2C_END);
-			     j += 2) {
-				if (
-				    ((adapter_id == this_force->force[j])
-				     ||
-				     ((this_force->
-				       force[j] == SENSORS_ANY_I2C_BUS)
-				      && !is_isa))
-				    && (addr == this_force->force[j + 1])) {
-#ifdef DEBUG
-					printk
-					    (KERN_DEBUG "i2c-proc.o: found force parameter for adapter %d, addr %04x\n",
-					     adapter_id, addr);
-#endif
-					if (
-					    (err =
-					     found_proc(adapter, addr, 0,
-							this_force->
-							kind))) return err;
+		for (i = 0; !found && (this_force = address_data->forces + i, this_force->force); i++) {
+			for (j = 0; !found && (this_force->force[j] != SENSORS_I2C_END); j += 2) {
+				if ( ((adapter_id == this_force->force[j]) ||
+				      ((this_force->force[j] == SENSORS_ANY_I2C_BUS) && !is_isa)) &&
+				      (addr == this_force->force[j + 1]) ) {
+					dev_dbg(&adapter->dev, "found force parameter for adapter %d, addr %04x\n", adapter_id, addr);
+					if ((err = found_proc(adapter, addr, 0, this_force->kind)))
+						return err;
 					found = 1;
 				}
 			}
@@ -628,42 +613,22 @@
 
 		/* If this address is in one of the ignores, we can forget about it
 		   right now */
-		for (i = 0;
-		     !found
-		     && (address_data->ignore[i] != SENSORS_I2C_END);
-		     i += 2) {
-			if (
-			    ((adapter_id == address_data->ignore[i])
-			     ||
-			     ((address_data->
-			       ignore[i] == SENSORS_ANY_I2C_BUS)
-			      && !is_isa))
-			    && (addr == address_data->ignore[i + 1])) {
-#ifdef DEBUG
-				printk
-				    (KERN_DEBUG "i2c-proc.o: found ignore parameter for adapter %d, "
-				     "addr %04x\n", adapter_id, addr);
-#endif
+		for (i = 0; !found && (address_data->ignore[i] != SENSORS_I2C_END); i += 2) {
+			if ( ((adapter_id == address_data->ignore[i]) ||
+			      ((address_data->ignore[i] == SENSORS_ANY_I2C_BUS) &&
+			       !is_isa)) &&
+			      (addr == address_data->ignore[i + 1])) {
+				dev_dbg(&adapter->dev, "found ignore parameter for adapter %d, addr %04x\n", adapter_id, addr);
 				found = 1;
 			}
 		}
-		for (i = 0;
-		     !found
-		     && (address_data->ignore_range[i] != SENSORS_I2C_END);
-		     i += 3) {
-			if (
-			    ((adapter_id == address_data->ignore_range[i])
-			     ||
-			     ((address_data->
-			       ignore_range[i] ==
-			       SENSORS_ANY_I2C_BUS) & !is_isa))
-			    && (addr >= address_data->ignore_range[i + 1])
-			    && (addr <= address_data->ignore_range[i + 2])) {
-#ifdef DEBUG
-				printk
-				    (KERN_DEBUG "i2c-proc.o: found ignore_range parameter for adapter %d, "
-				     "addr %04x\n", adapter_id, addr);
-#endif
+		for (i = 0; !found && (address_data->ignore_range[i] != SENSORS_I2C_END); i += 3) {
+			if ( ((adapter_id == address_data->ignore_range[i]) ||
+			      ((address_data-> ignore_range[i] == SENSORS_ANY_I2C_BUS) & 
+			       !is_isa)) &&
+			     (addr >= address_data->ignore_range[i + 1]) &&
+			     (addr <= address_data->ignore_range[i + 2])) {
+				dev_dbg(&adapter->dev,  "found ignore_range parameter for adapter %d, addr %04x\n", adapter_id, addr);
 				found = 1;
 			}
 		}
@@ -673,68 +638,31 @@
 		/* Now, we will do a detection, but only if it is in the normal or 
 		   probe entries */
 		if (is_isa) {
-			for (i = 0;
-			     !found
-			     && (address_data->normal_isa[i] !=
-				 SENSORS_ISA_END); i += 1) {
+			for (i = 0; !found && (address_data->normal_isa[i] != SENSORS_ISA_END); i += 1) {
 				if (addr == address_data->normal_isa[i]) {
-#ifdef DEBUG
-					printk
-					    (KERN_DEBUG "i2c-proc.o: found normal isa entry for adapter %d, "
-					     "addr %04x\n", adapter_id,
-					     addr);
-#endif
+					dev_dbg(&adapter->dev, "found normal isa entry for adapter %d, addr %04x\n", adapter_id, addr);
 					found = 1;
 				}
 			}
-			for (i = 0;
-			     !found
-			     && (address_data->normal_isa_range[i] !=
-				 SENSORS_ISA_END); i += 3) {
-				if ((addr >=
-				     address_data->normal_isa_range[i])
-				    && (addr <=
-					address_data->normal_isa_range[i + 1])
-				    &&
-				    ((addr -
-				      address_data->normal_isa_range[i]) %
-				     address_data->normal_isa_range[i + 2] ==
-				     0)) {
-#ifdef DEBUG
-					printk
-					    (KERN_DEBUG "i2c-proc.o: found normal isa_range entry for adapter %d, "
-					     "addr %04x", adapter_id, addr);
-#endif
+			for (i = 0; !found && (address_data->normal_isa_range[i] != SENSORS_ISA_END); i += 3) {
+				if ((addr >= address_data->normal_isa_range[i]) &&
+				    (addr <= address_data->normal_isa_range[i + 1]) &&
+				    ((addr - address_data->normal_isa_range[i]) % address_data->normal_isa_range[i + 2] == 0)) {
+					dev_dbg(&adapter->dev, "found normal isa_range entry for adapter %d, addr %04x", adapter_id, addr);
 					found = 1;
 				}
 			}
 		} else {
-			for (i = 0;
-			     !found && (address_data->normal_i2c[i] !=
-				 SENSORS_I2C_END); i += 1) {
+			for (i = 0; !found && (address_data->normal_i2c[i] != SENSORS_I2C_END); i += 1) {
 				if (addr == address_data->normal_i2c[i]) {
 					found = 1;
-#ifdef DEBUG
-					printk
-					    (KERN_DEBUG "i2c-proc.o: found normal i2c entry for adapter %d, "
-					     "addr %02x", adapter_id, addr);
-#endif
+					dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, addr %02x", adapter_id, addr);
 				}
 			}
-			for (i = 0;
-			     !found
-			     && (address_data->normal_i2c_range[i] !=
-				 SENSORS_I2C_END); i += 2) {
-				if ((addr >=
-				     address_data->normal_i2c_range[i])
-				    && (addr <=
-					address_data->normal_i2c_range[i + 1]))
-				{
-#ifdef DEBUG
-					printk
-					    (KERN_DEBUG "i2c-proc.o: found normal i2c_range entry for adapter %d, "
-					     "addr %04x\n", adapter_id, addr);
-#endif
+			for (i = 0; !found && (address_data->normal_i2c_range[i] != SENSORS_I2C_END); i += 2) {
+				if ((addr >= address_data->normal_i2c_range[i]) &&
+				    (addr <= address_data->normal_i2c_range[i + 1])) {
+					dev_dbg(&adapter->dev, "found normal i2c_range entry for adapter %d, addr %04x\n", adapter_id, addr);
 					found = 1;
 				}
 			}
@@ -747,30 +675,17 @@
 			     ((address_data->
 			       probe[i] == SENSORS_ANY_I2C_BUS) & !is_isa))
 			    && (addr == address_data->probe[i + 1])) {
-#ifdef DEBUG
-				printk
-				    (KERN_DEBUG "i2c-proc.o: found probe parameter for adapter %d, "
-				     "addr %04x\n", adapter_id, addr);
-#endif
+				dev_dbg(&adapter->dev, "found probe parameter for adapter %d, addr %04x\n", adapter_id, addr);
 				found = 1;
 			}
 		}
-		for (i = 0; !found &&
-		           (address_data->probe_range[i] != SENSORS_I2C_END);
-		     i += 3) {
-			if (
-			    ((adapter_id == address_data->probe_range[i])
-			     ||
-			     ((address_data->probe_range[i] ==
-			       SENSORS_ANY_I2C_BUS) & !is_isa))
-			    && (addr >= address_data->probe_range[i + 1])
-			    && (addr <= address_data->probe_range[i + 2])) {
+		for (i = 0; !found && (address_data->probe_range[i] != SENSORS_I2C_END); i += 3) {
+			if ( ((adapter_id == address_data->probe_range[i]) ||
+			      ((address_data->probe_range[i] == SENSORS_ANY_I2C_BUS) & !is_isa)) &&
+			     (addr >= address_data->probe_range[i + 1]) &&
+			     (addr <= address_data->probe_range[i + 2])) {
 				found = 1;
-#ifdef DEBUG
-				printk
-				    (KERN_DEBUG "i2c-proc.o: found probe_range parameter for adapter %d, "
-				     "addr %04x\n", adapter_id, addr);
-#endif
+				dev_dbg(&adapter->dev, "found probe_range parameter for adapter %d, addr %04x\n", adapter_id, addr);
 			}
 		}
 		if (!found)
@@ -779,8 +694,7 @@
 		/* OK, so we really should examine this address. First check
 		   whether there is some client here at all! */
 		if (is_isa ||
-		    (i2c_smbus_xfer
-		     (adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL) >= 0))
+		    (i2c_smbus_xfer (adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL) >= 0))
 			if ((err = found_proc(adapter, addr, 0, -1)))
 				return err;
 	}

