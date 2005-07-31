Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVGaTd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVGaTd0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 15:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVGaTd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 15:33:26 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:8467 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261942AbVGaTdY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 15:33:24 -0400
Date: Sun, 31 Jul 2005 21:33:23 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] (2/11) hwmon vs i2c, second round
Message-Id: <20050731213323.4f6325cf.khali@linux-fr.org>
In-Reply-To: <20050731205933.2e2a957f.khali@linux-fr.org>
References: <20050731205933.2e2a957f.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The way i2c-sensor handles forced addresses could be optimized. It
defines a structure (i2c_force_data) to associate a module parameter
with a given kind value, but in fact this kind value is always the
index of the structure in each array it is used in. So this additional
value can be omitted, and still be deduced in the code handling these
arrays.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/i2c-sensor-detect.c |   13 +--
 include/linux/i2c-sensor.h      |  133 ++++++++++++++++++----------------------
 2 files changed, 67 insertions(+), 79 deletions(-)

--- linux-2.6.13-rc4.orig/drivers/i2c/i2c-sensor-detect.c	2005-07-31 16:03:00.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/i2c-sensor-detect.c	2005-07-31 20:56:04.000000000 +0200
@@ -32,7 +32,6 @@
 	       int (*found_proc) (struct i2c_adapter *, int, int))
 {
 	int addr, i, found, j, err;
-	struct i2c_force_data *this_force;
 	int adapter_id = i2c_adapter_id(adapter);
 	unsigned short *normal_i2c;
 	unsigned short *probe;
@@ -58,13 +57,13 @@
 		/* If it is in one of the force entries, we don't do any
 		   detection at all */
 		found = 0;
-		for (i = 0; !found && (this_force = address_data->forces + i, this_force->force); i++) {
-			for (j = 0; !found && (this_force->force[j] != I2C_CLIENT_END); j += 2) {
-				if ( ((adapter_id == this_force->force[j]) ||
-				      (this_force->force[j] == ANY_I2C_BUS)) &&
-				      (addr == this_force->force[j + 1]) ) {
+		for (i = 0; address_data->forces[i]; i++) {
+			for (j = 0; !found && (address_data->forces[i][j] != I2C_CLIENT_END); j += 2) {
+				if ( ((adapter_id == address_data->forces[i][j]) ||
+				      (address_data->forces[i][j] == ANY_I2C_BUS)) &&
+				      (addr == address_data->forces[i][j + 1]) ) {
 					dev_dbg(&adapter->dev, "found force parameter for adapter %d, addr %04x\n", adapter_id, addr);
-					if ((err = found_proc(adapter, addr, this_force->kind)))
+					if ((err = found_proc(adapter, addr, i)))
 						return err;
 					found = 1;
 				}
--- linux-2.6.13-rc4.orig/include/linux/i2c-sensor.h	2005-07-31 16:03:00.000000000 +0200
+++ linux-2.6.13-rc4/include/linux/i2c-sensor.h	2005-07-31 20:56:04.000000000 +0200
@@ -22,22 +22,6 @@
 #ifndef _LINUX_I2C_SENSOR_H
 #define _LINUX_I2C_SENSOR_H
 
-/* A structure containing detect information.
-   Force variables overrule all other variables; they force a detection on
-   that place. If a specific chip is given, the module blindly assumes this
-   chip type is present; if a general force (kind == 0) is given, the module
-   will still try to figure out what type of chip is present. This is useful
-   if for some reasons the detect for SMBus address space filled fails.
-   probe: insmod parameter. Initialize this list with I2C_CLIENT_END values.
-     A list of pairs. The first value is a bus number (ANY_I2C_BUS for any
-     I2C bus), the second is the address.
-   kind: The kind of chip. 0 equals any chip.
-*/
-struct i2c_force_data {
-	unsigned short *force;
-	unsigned short kind;
-};
-
 /* A structure containing the detect information.
    normal_i2c: filled in by the module writer. Terminated by I2C_CLIENT_END.
      A list of I2C addresses which should normally be examined.
@@ -50,14 +34,18 @@
      I2C bus), the second is the I2C address. These addresses are never
      probed. This parameter overrules 'normal' and  probe', but not the
     'force' lists.
-   force_data: insmod parameters. A list, ending with an element of which
-     the force field is NULL.
+   forces: insmod parameters. A list, ending with a NULL element.
+     Force variables overrule all other variables; they force a detection on
+     that place. If a specific chip is given, the module blindly assumes this
+     chip type is present; if a general force (kind == 0) is given, the module
+     will still try to figure out what type of chip is present. This is useful
+     if for some reasons the detect for SMBus address space filled fails.
 */
 struct i2c_address_data {
 	unsigned short *normal_i2c;
 	unsigned short *probe;
 	unsigned short *ignore;
-	struct i2c_force_data *forces;
+	unsigned short **forces;
 };
 
 #define SENSORS_MODULE_PARM_FORCE(name) \
@@ -88,7 +76,8 @@
   I2C_CLIENT_MODULE_PARM(force, \
                       "List of adapter,address pairs to boldly assume " \
                       "to be present"); \
-  static struct i2c_force_data forces[] = {{force,any_chip},{NULL}}; \
+  static unsigned short *forces[] = { force, \
+				      NULL }; \
   SENSORS_INSMOD
 
 #define SENSORS_INSMOD_1(chip1) \
@@ -97,9 +86,9 @@
                       "List of adapter,address pairs to boldly assume " \
                       "to be present"); \
   SENSORS_MODULE_PARM_FORCE(chip1); \
-  static struct i2c_force_data forces[] = {{force,any_chip},\
-                                                 {force_ ## chip1,chip1}, \
-                                                 {NULL}}; \
+  static unsigned short *forces[] = { force, \
+				      force_##chip1, \
+				      NULL }; \
   SENSORS_INSMOD
 
 #define SENSORS_INSMOD_2(chip1,chip2) \
@@ -109,10 +98,10 @@
                       "to be present"); \
   SENSORS_MODULE_PARM_FORCE(chip1); \
   SENSORS_MODULE_PARM_FORCE(chip2); \
-  static struct i2c_force_data forces[] = {{force,any_chip}, \
-                                                 {force_ ## chip1,chip1}, \
-                                                 {force_ ## chip2,chip2}, \
-                                                 {NULL}}; \
+  static unsigned short *forces[] = { force, \
+				      force_##chip1, \
+				      force_##chip2, \
+				      NULL }; \
   SENSORS_INSMOD
 
 #define SENSORS_INSMOD_3(chip1,chip2,chip3) \
@@ -123,11 +112,11 @@
   SENSORS_MODULE_PARM_FORCE(chip1); \
   SENSORS_MODULE_PARM_FORCE(chip2); \
   SENSORS_MODULE_PARM_FORCE(chip3); \
-  static struct i2c_force_data forces[] = {{force,any_chip}, \
-                                                 {force_ ## chip1,chip1}, \
-                                                 {force_ ## chip2,chip2}, \
-                                                 {force_ ## chip3,chip3}, \
-                                                 {NULL}}; \
+  static unsigned short *forces[] = { force, \
+				      force_##chip1, \
+				      force_##chip2, \
+				      force_##chip3, \
+				      NULL }; \
   SENSORS_INSMOD
 
 #define SENSORS_INSMOD_4(chip1,chip2,chip3,chip4) \
@@ -139,12 +128,12 @@
   SENSORS_MODULE_PARM_FORCE(chip2); \
   SENSORS_MODULE_PARM_FORCE(chip3); \
   SENSORS_MODULE_PARM_FORCE(chip4); \
-  static struct i2c_force_data forces[] = {{force,any_chip}, \
-                                                 {force_ ## chip1,chip1}, \
-                                                 {force_ ## chip2,chip2}, \
-                                                 {force_ ## chip3,chip3}, \
-                                                 {force_ ## chip4,chip4}, \
-                                                 {NULL}}; \
+  static unsigned short *forces[] = { force, \
+				      force_##chip1, \
+				      force_##chip2, \
+				      force_##chip3, \
+				      force_##chip4, \
+				      NULL}; \
   SENSORS_INSMOD
 
 #define SENSORS_INSMOD_5(chip1,chip2,chip3,chip4,chip5) \
@@ -157,13 +146,13 @@
   SENSORS_MODULE_PARM_FORCE(chip3); \
   SENSORS_MODULE_PARM_FORCE(chip4); \
   SENSORS_MODULE_PARM_FORCE(chip5); \
-  static struct i2c_force_data forces[] = {{force,any_chip}, \
-                                                 {force_ ## chip1,chip1}, \
-                                                 {force_ ## chip2,chip2}, \
-                                                 {force_ ## chip3,chip3}, \
-                                                 {force_ ## chip4,chip4}, \
-                                                 {force_ ## chip5,chip5}, \
-                                                 {NULL}}; \
+  static unsigned short *forces[] = { force, \
+				      force_##chip1, \
+				      force_##chip2, \
+				      force_##chip3, \
+				      force_##chip4, \
+				      force_##chip5, \
+				      NULL }; \
   SENSORS_INSMOD
 
 #define SENSORS_INSMOD_6(chip1,chip2,chip3,chip4,chip5,chip6) \
@@ -177,14 +166,14 @@
   SENSORS_MODULE_PARM_FORCE(chip4); \
   SENSORS_MODULE_PARM_FORCE(chip5); \
   SENSORS_MODULE_PARM_FORCE(chip6); \
-  static struct i2c_force_data forces[] = {{force,any_chip}, \
-                                                 {force_ ## chip1,chip1}, \
-                                                 {force_ ## chip2,chip2}, \
-                                                 {force_ ## chip3,chip3}, \
-                                                 {force_ ## chip4,chip4}, \
-                                                 {force_ ## chip5,chip5}, \
-                                                 {force_ ## chip6,chip6}, \
-                                                 {NULL}}; \
+  static unsigned short *forces[] = { force, \
+				      force_##chip1, \
+				      force_##chip2, \
+				      force_##chip3, \
+				      force_##chip4, \
+				      force_##chip5, \
+				      force_##chip6, \
+				      NULL }; \
   SENSORS_INSMOD
 
 #define SENSORS_INSMOD_7(chip1,chip2,chip3,chip4,chip5,chip6,chip7) \
@@ -199,15 +188,15 @@
   SENSORS_MODULE_PARM_FORCE(chip5); \
   SENSORS_MODULE_PARM_FORCE(chip6); \
   SENSORS_MODULE_PARM_FORCE(chip7); \
-  static struct i2c_force_data forces[] = {{force,any_chip}, \
-                                                 {force_ ## chip1,chip1}, \
-                                                 {force_ ## chip2,chip2}, \
-                                                 {force_ ## chip3,chip3}, \
-                                                 {force_ ## chip4,chip4}, \
-                                                 {force_ ## chip5,chip5}, \
-                                                 {force_ ## chip6,chip6}, \
-                                                 {force_ ## chip7,chip7}, \
-                                                 {NULL}}; \
+  static unsigned short *forces[] = { force, \
+				      force_##chip1, \
+				      force_##chip2, \
+				      force_##chip3, \
+				      force_##chip4, \
+				      force_##chip5, \
+				      force_##chip6, \
+				      force_##chip7, \
+				      NULL }; \
   SENSORS_INSMOD
 
 #define SENSORS_INSMOD_8(chip1,chip2,chip3,chip4,chip5,chip6,chip7,chip8) \
@@ -223,16 +212,16 @@
   SENSORS_MODULE_PARM_FORCE(chip6); \
   SENSORS_MODULE_PARM_FORCE(chip7); \
   SENSORS_MODULE_PARM_FORCE(chip8); \
-  static struct i2c_force_data forces[] = {{force,any_chip}, \
-                                                 {force_ ## chip1,chip1}, \
-                                                 {force_ ## chip2,chip2}, \
-                                                 {force_ ## chip3,chip3}, \
-                                                 {force_ ## chip4,chip4}, \
-                                                 {force_ ## chip5,chip5}, \
-                                                 {force_ ## chip6,chip6}, \
-                                                 {force_ ## chip7,chip7}, \
-                                                 {force_ ## chip8,chip8}, \
-                                                 {NULL}}; \
+  static unsigned short *forces[] = { force, \
+				      force_##chip1, \
+				      force_##chip2, \
+				      force_##chip3, \
+				      force_##chip4, \
+				      force_##chip5, \
+				      force_##chip6, \
+				      force_##chip7, \
+				      force_##chip8, \
+				      NULL }; \
   SENSORS_INSMOD
 
 /* Detect function. It iterates over all possible addresses itself. For


-- 
Jean Delvare
