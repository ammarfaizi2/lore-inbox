Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVGaTg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVGaTg0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 15:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbVGaTgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 15:36:25 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:15379 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261943AbVGaTgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 15:36:24 -0400
Date: Sun, 31 Jul 2005 21:36:24 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] (3/11) hwmon vs i2c, second round
Message-Id: <20050731213624.0ebc73d3.khali@linux-fr.org>
In-Reply-To: <20050731205933.2e2a957f.khali@linux-fr.org>
References: <20050731205933.2e2a957f.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We now have two identical structures, i2c_address_data in i2c-sensor.h
and i2c_client_address_data in i2c.h. We can kill one of them, I choose
to keep the one in i2c.h as it makes more sense (this structure is not
specific to sensors.)

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/i2c-sensor-detect.c |    2 +-
 include/linux/i2c-sensor.h      |   30 +++---------------------------
 2 files changed, 4 insertions(+), 28 deletions(-)

--- linux-2.6.13-rc4.orig/drivers/i2c/i2c-sensor-detect.c	2005-07-31 16:07:56.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/i2c-sensor-detect.c	2005-07-31 20:56:02.000000000 +0200
@@ -28,7 +28,7 @@
 
 /* Won't work for 10-bit addresses! */
 int i2c_detect(struct i2c_adapter *adapter,
-	       struct i2c_address_data *address_data,
+	       struct i2c_client_address_data *address_data,
 	       int (*found_proc) (struct i2c_adapter *, int, int))
 {
 	int addr, i, found, j, err;
--- linux-2.6.13-rc4.orig/include/linux/i2c-sensor.h	2005-07-31 16:07:56.000000000 +0200
+++ linux-2.6.13-rc4/include/linux/i2c-sensor.h	2005-07-31 20:56:02.000000000 +0200
@@ -22,31 +22,7 @@
 #ifndef _LINUX_I2C_SENSOR_H
 #define _LINUX_I2C_SENSOR_H
 
-/* A structure containing the detect information.
-   normal_i2c: filled in by the module writer. Terminated by I2C_CLIENT_END.
-     A list of I2C addresses which should normally be examined.
-   probe: insmod parameter. Initialize this list with I2C_CLIENT_END values.
-     A list of pairs. The first value is a bus number (ANY_I2C_BUS for any
-     I2C bus), the second is the address. These addresses are also probed,
-     as if they were in the 'normal' list.
-   ignore: insmod parameter. Initialize this list with I2C_CLIENT_END values.
-     A list of pairs. The first value is a bus number (ANY_I2C_BUS for any
-     I2C bus), the second is the I2C address. These addresses are never
-     probed. This parameter overrules 'normal' and  probe', but not the
-    'force' lists.
-   forces: insmod parameters. A list, ending with a NULL element.
-     Force variables overrule all other variables; they force a detection on
-     that place. If a specific chip is given, the module blindly assumes this
-     chip type is present; if a general force (kind == 0) is given, the module
-     will still try to figure out what type of chip is present. This is useful
-     if for some reasons the detect for SMBus address space filled fails.
-*/
-struct i2c_address_data {
-	unsigned short *normal_i2c;
-	unsigned short *probe;
-	unsigned short *ignore;
-	unsigned short **forces;
-};
+#include <linux/i2c.h>
 
 #define SENSORS_MODULE_PARM_FORCE(name) \
   I2C_CLIENT_MODULE_PARM(force_ ## name, \
@@ -60,7 +36,7 @@
                       "List of adapter,address pairs to scan additionally"); \
   I2C_CLIENT_MODULE_PARM(ignore, \
                       "List of adapter,address pairs not to scan"); \
-	static struct i2c_address_data addr_data = {			\
+	static struct i2c_client_address_data addr_data = {		\
 			.normal_i2c =		normal_i2c,		\
 			.probe =		probe,			\
 			.ignore =		ignore,			\
@@ -228,7 +204,7 @@
    SMBus addresses, it will only call found_proc if some client is connected
    to the SMBus (unless a 'force' matched). */
 extern int i2c_detect(struct i2c_adapter *adapter,
-		      struct i2c_address_data *address_data,
+		      struct i2c_client_address_data *address_data,
 		      int (*found_proc) (struct i2c_adapter *, int, int));
 
 #endif				/* def _LINUX_I2C_SENSOR_H */


-- 
Jean Delvare
