Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264388AbUHWUB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbUHWUB5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267544AbUHWT6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:58:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:41667 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266678AbUHWSgL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:11 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860902842@kroah.com>
Date: Mon, 23 Aug 2004 11:34:50 -0700
Message-Id: <10932860901217@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.59.6, 2004/08/05 16:35:57-07:00, greg@kroah.com

I2C: rename i2c-sensor.c file to prepare for Rudolf's VRM patch.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/i2c-sensor.c        |  167 ----------------------------------------
 drivers/i2c/i2c-sensor-detect.c |  167 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 167 insertions(+), 167 deletions(-)


diff -Nru a/drivers/i2c/i2c-sensor-detect.c b/drivers/i2c/i2c-sensor-detect.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/i2c/i2c-sensor-detect.c	2004-08-23 11:05:04 -07:00
@@ -0,0 +1,167 @@
+/*
+    i2c-sensor.c - Part of lm_sensors, Linux kernel modules for hardware
+                monitoring
+    Copyright (c) 1998 - 2001 Frodo Looijaard <frodol@dds.nl> and
+    Mark D. Studebaker <mdsxyz123@yahoo.com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/ctype.h>
+#include <linux/sysctl.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+#include <asm/uaccess.h>
+
+
+/* Very inefficient for ISA detects, and won't work for 10-bit addresses! */
+int i2c_detect(struct i2c_adapter *adapter,
+	       struct i2c_address_data *address_data,
+	       int (*found_proc) (struct i2c_adapter *, int, int))
+{
+	int addr, i, found, j, err;
+	struct i2c_force_data *this_force;
+	int is_isa = i2c_is_isa_adapter(adapter);
+	int adapter_id =
+	    is_isa ? ANY_I2C_ISA_BUS : i2c_adapter_id(adapter);
+
+	/* Forget it if we can't probe using SMBUS_QUICK */
+	if ((!is_isa) &&
+	    !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_QUICK))
+		return -1;
+
+	for (addr = 0x00; addr <= (is_isa ? 0xffff : 0x7f); addr++) {
+		if (!is_isa && i2c_check_addr(adapter, addr))
+			continue;
+
+		/* If it is in one of the force entries, we don't do any
+		   detection at all */
+		found = 0;
+		for (i = 0; !found && (this_force = address_data->forces + i, this_force->force); i++) {
+			for (j = 0; !found && (this_force->force[j] != I2C_CLIENT_END); j += 2) {
+				if ( ((adapter_id == this_force->force[j]) ||
+				      ((this_force->force[j] == ANY_I2C_BUS) && !is_isa)) &&
+				      (addr == this_force->force[j + 1]) ) {
+					dev_dbg(&adapter->dev, "found force parameter for adapter %d, addr %04x\n", adapter_id, addr);
+					if ((err = found_proc(adapter, addr, this_force->kind)))
+						return err;
+					found = 1;
+				}
+			}
+		}
+		if (found)
+			continue;
+
+		/* If this address is in one of the ignores, we can forget about it
+		   right now */
+		for (i = 0; !found && (address_data->ignore[i] != I2C_CLIENT_END); i += 2) {
+			if ( ((adapter_id == address_data->ignore[i]) ||
+			      ((address_data->ignore[i] == ANY_I2C_BUS) &&
+			       !is_isa)) &&
+			      (addr == address_data->ignore[i + 1])) {
+				dev_dbg(&adapter->dev, "found ignore parameter for adapter %d, addr %04x\n", adapter_id, addr);
+				found = 1;
+			}
+		}
+		for (i = 0; !found && (address_data->ignore_range[i] != I2C_CLIENT_END); i += 3) {
+			if ( ((adapter_id == address_data->ignore_range[i]) ||
+			      ((address_data-> ignore_range[i] == ANY_I2C_BUS) & 
+			       !is_isa)) &&
+			     (addr >= address_data->ignore_range[i + 1]) &&
+			     (addr <= address_data->ignore_range[i + 2])) {
+				dev_dbg(&adapter->dev,  "found ignore_range parameter for adapter %d, addr %04x\n", adapter_id, addr);
+				found = 1;
+			}
+		}
+		if (found)
+			continue;
+
+		/* Now, we will do a detection, but only if it is in the normal or 
+		   probe entries */
+		if (is_isa) {
+			for (i = 0; !found && (address_data->normal_isa[i] != I2C_CLIENT_ISA_END); i += 1) {
+				if (addr == address_data->normal_isa[i]) {
+					dev_dbg(&adapter->dev, "found normal isa entry for adapter %d, addr %04x\n", adapter_id, addr);
+					found = 1;
+				}
+			}
+			for (i = 0; !found && (address_data->normal_isa_range[i] != I2C_CLIENT_ISA_END); i += 3) {
+				if ((addr >= address_data->normal_isa_range[i]) &&
+				    (addr <= address_data->normal_isa_range[i + 1]) &&
+				    ((addr - address_data->normal_isa_range[i]) % address_data->normal_isa_range[i + 2] == 0)) {
+					dev_dbg(&adapter->dev, "found normal isa_range entry for adapter %d, addr %04x", adapter_id, addr);
+					found = 1;
+				}
+			}
+		} else {
+			for (i = 0; !found && (address_data->normal_i2c[i] != I2C_CLIENT_END); i += 1) {
+				if (addr == address_data->normal_i2c[i]) {
+					found = 1;
+					dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, addr %02x", adapter_id, addr);
+				}
+			}
+			for (i = 0; !found && (address_data->normal_i2c_range[i] != I2C_CLIENT_END); i += 2) {
+				if ((addr >= address_data->normal_i2c_range[i]) &&
+				    (addr <= address_data->normal_i2c_range[i + 1])) {
+					dev_dbg(&adapter->dev, "found normal i2c_range entry for adapter %d, addr %04x\n", adapter_id, addr);
+					found = 1;
+				}
+			}
+		}
+
+		for (i = 0;
+		     !found && (address_data->probe[i] != I2C_CLIENT_END);
+		     i += 2) {
+			if (((adapter_id == address_data->probe[i]) ||
+			     ((address_data->
+			       probe[i] == ANY_I2C_BUS) && !is_isa))
+			    && (addr == address_data->probe[i + 1])) {
+				dev_dbg(&adapter->dev, "found probe parameter for adapter %d, addr %04x\n", adapter_id, addr);
+				found = 1;
+			}
+		}
+		for (i = 0; !found && (address_data->probe_range[i] != I2C_CLIENT_END); i += 3) {
+			if ( ((adapter_id == address_data->probe_range[i]) ||
+			      ((address_data->probe_range[i] == ANY_I2C_BUS) && !is_isa)) &&
+			     (addr >= address_data->probe_range[i + 1]) &&
+			     (addr <= address_data->probe_range[i + 2])) {
+				found = 1;
+				dev_dbg(&adapter->dev, "found probe_range parameter for adapter %d, addr %04x\n", adapter_id, addr);
+			}
+		}
+		if (!found)
+			continue;
+
+		/* OK, so we really should examine this address. First check
+		   whether there is some client here at all! */
+		if (is_isa ||
+		    (i2c_smbus_xfer (adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL) >= 0))
+			if ((err = found_proc(adapter, addr, -1)))
+				return err;
+	}
+	return 0;
+}
+
+EXPORT_SYMBOL(i2c_detect);
+
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
+MODULE_DESCRIPTION("i2c-sensor driver");
+MODULE_LICENSE("GPL");
diff -Nru a/drivers/i2c/i2c-sensor.c b/drivers/i2c/i2c-sensor.c
--- a/drivers/i2c/i2c-sensor.c	2004-08-23 11:05:04 -07:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,167 +0,0 @@
-/*
-    i2c-sensor.c - Part of lm_sensors, Linux kernel modules for hardware
-                monitoring
-    Copyright (c) 1998 - 2001 Frodo Looijaard <frodol@dds.nl> and
-    Mark D. Studebaker <mdsxyz123@yahoo.com>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/ctype.h>
-#include <linux/sysctl.h>
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
-#include <asm/uaccess.h>
-
-
-/* Very inefficient for ISA detects, and won't work for 10-bit addresses! */
-int i2c_detect(struct i2c_adapter *adapter,
-	       struct i2c_address_data *address_data,
-	       int (*found_proc) (struct i2c_adapter *, int, int))
-{
-	int addr, i, found, j, err;
-	struct i2c_force_data *this_force;
-	int is_isa = i2c_is_isa_adapter(adapter);
-	int adapter_id =
-	    is_isa ? ANY_I2C_ISA_BUS : i2c_adapter_id(adapter);
-
-	/* Forget it if we can't probe using SMBUS_QUICK */
-	if ((!is_isa) &&
-	    !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_QUICK))
-		return -1;
-
-	for (addr = 0x00; addr <= (is_isa ? 0xffff : 0x7f); addr++) {
-		if (!is_isa && i2c_check_addr(adapter, addr))
-			continue;
-
-		/* If it is in one of the force entries, we don't do any
-		   detection at all */
-		found = 0;
-		for (i = 0; !found && (this_force = address_data->forces + i, this_force->force); i++) {
-			for (j = 0; !found && (this_force->force[j] != I2C_CLIENT_END); j += 2) {
-				if ( ((adapter_id == this_force->force[j]) ||
-				      ((this_force->force[j] == ANY_I2C_BUS) && !is_isa)) &&
-				      (addr == this_force->force[j + 1]) ) {
-					dev_dbg(&adapter->dev, "found force parameter for adapter %d, addr %04x\n", adapter_id, addr);
-					if ((err = found_proc(adapter, addr, this_force->kind)))
-						return err;
-					found = 1;
-				}
-			}
-		}
-		if (found)
-			continue;
-
-		/* If this address is in one of the ignores, we can forget about it
-		   right now */
-		for (i = 0; !found && (address_data->ignore[i] != I2C_CLIENT_END); i += 2) {
-			if ( ((adapter_id == address_data->ignore[i]) ||
-			      ((address_data->ignore[i] == ANY_I2C_BUS) &&
-			       !is_isa)) &&
-			      (addr == address_data->ignore[i + 1])) {
-				dev_dbg(&adapter->dev, "found ignore parameter for adapter %d, addr %04x\n", adapter_id, addr);
-				found = 1;
-			}
-		}
-		for (i = 0; !found && (address_data->ignore_range[i] != I2C_CLIENT_END); i += 3) {
-			if ( ((adapter_id == address_data->ignore_range[i]) ||
-			      ((address_data-> ignore_range[i] == ANY_I2C_BUS) & 
-			       !is_isa)) &&
-			     (addr >= address_data->ignore_range[i + 1]) &&
-			     (addr <= address_data->ignore_range[i + 2])) {
-				dev_dbg(&adapter->dev,  "found ignore_range parameter for adapter %d, addr %04x\n", adapter_id, addr);
-				found = 1;
-			}
-		}
-		if (found)
-			continue;
-
-		/* Now, we will do a detection, but only if it is in the normal or 
-		   probe entries */
-		if (is_isa) {
-			for (i = 0; !found && (address_data->normal_isa[i] != I2C_CLIENT_ISA_END); i += 1) {
-				if (addr == address_data->normal_isa[i]) {
-					dev_dbg(&adapter->dev, "found normal isa entry for adapter %d, addr %04x\n", adapter_id, addr);
-					found = 1;
-				}
-			}
-			for (i = 0; !found && (address_data->normal_isa_range[i] != I2C_CLIENT_ISA_END); i += 3) {
-				if ((addr >= address_data->normal_isa_range[i]) &&
-				    (addr <= address_data->normal_isa_range[i + 1]) &&
-				    ((addr - address_data->normal_isa_range[i]) % address_data->normal_isa_range[i + 2] == 0)) {
-					dev_dbg(&adapter->dev, "found normal isa_range entry for adapter %d, addr %04x", adapter_id, addr);
-					found = 1;
-				}
-			}
-		} else {
-			for (i = 0; !found && (address_data->normal_i2c[i] != I2C_CLIENT_END); i += 1) {
-				if (addr == address_data->normal_i2c[i]) {
-					found = 1;
-					dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, addr %02x", adapter_id, addr);
-				}
-			}
-			for (i = 0; !found && (address_data->normal_i2c_range[i] != I2C_CLIENT_END); i += 2) {
-				if ((addr >= address_data->normal_i2c_range[i]) &&
-				    (addr <= address_data->normal_i2c_range[i + 1])) {
-					dev_dbg(&adapter->dev, "found normal i2c_range entry for adapter %d, addr %04x\n", adapter_id, addr);
-					found = 1;
-				}
-			}
-		}
-
-		for (i = 0;
-		     !found && (address_data->probe[i] != I2C_CLIENT_END);
-		     i += 2) {
-			if (((adapter_id == address_data->probe[i]) ||
-			     ((address_data->
-			       probe[i] == ANY_I2C_BUS) && !is_isa))
-			    && (addr == address_data->probe[i + 1])) {
-				dev_dbg(&adapter->dev, "found probe parameter for adapter %d, addr %04x\n", adapter_id, addr);
-				found = 1;
-			}
-		}
-		for (i = 0; !found && (address_data->probe_range[i] != I2C_CLIENT_END); i += 3) {
-			if ( ((adapter_id == address_data->probe_range[i]) ||
-			      ((address_data->probe_range[i] == ANY_I2C_BUS) && !is_isa)) &&
-			     (addr >= address_data->probe_range[i + 1]) &&
-			     (addr <= address_data->probe_range[i + 2])) {
-				found = 1;
-				dev_dbg(&adapter->dev, "found probe_range parameter for adapter %d, addr %04x\n", adapter_id, addr);
-			}
-		}
-		if (!found)
-			continue;
-
-		/* OK, so we really should examine this address. First check
-		   whether there is some client here at all! */
-		if (is_isa ||
-		    (i2c_smbus_xfer (adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL) >= 0))
-			if ((err = found_proc(adapter, addr, -1)))
-				return err;
-	}
-	return 0;
-}
-
-EXPORT_SYMBOL(i2c_detect);
-
-MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
-MODULE_DESCRIPTION("i2c-sensor driver");
-MODULE_LICENSE("GPL");

