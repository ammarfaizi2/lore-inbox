Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265849AbTL3WQj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265335AbTL3WPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:15:10 -0500
Received: from mail.kroah.org ([65.200.24.183]:56257 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265849AbTL3WGj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:06:39 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.0
In-Reply-To: <10728219711872@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Dec 2003 14:06:11 -0800
Message-Id: <10728219711203@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1496.8.34, 2003/12/17 16:06:50-08:00, mhoffman@lightlink.com

[PATCH] I2C: lm75 chip driver conversion routine fixes

This patch is based on the lm_sensors project CVS, from revisions 1.45 and 1.1
of lm75.c and lm75.h, respectively.

The patch fixes the conversion routines (according to datasheet) and moves
them into a header file - as these conversions can be used by several drivers
which emulate LM75s as subclients.  Also, temps are now reported in 1/1000 C
in sysfs as per documentation.


 drivers/i2c/chips/lm75.c |   28 ++++++++------------------
 drivers/i2c/chips/lm75.h |   49 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 19 deletions(-)


diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Tue Dec 30 12:30:01 2003
+++ b/drivers/i2c/chips/lm75.c	Tue Dec 30 12:30:01 2003
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include "lm75.h"
 
 
 /* Addresses to scan */
@@ -44,13 +45,6 @@
 #define LM75_REG_TEMP_HYST	0x02
 #define LM75_REG_TEMP_OS	0x03
 
-/* Conversions. Rounding and limit checking is only done on the TO_REG
-   variants. Note that you should be a bit careful with which arguments
-   these macros are called: arguments may be evaluated more than once.
-   Fixing this is just not worth it. */
-#define TEMP_FROM_REG(val)	((((val & 0x7fff) >> 7) * 5) | ((val & 0x8000)?-256:0))
-#define TEMP_TO_REG(val)	(SENSORS_LIMIT((val<0?(0x200+((val)/5))<<7:(((val) + 2) / 5) << 7),0,0xffff))
-
 /* Each client has this additional data */
 struct lm75_data {
 	struct semaphore	update_lock;
@@ -83,15 +77,12 @@
 static int lm75_id = 0;
 
 #define show(value)	\
-static ssize_t show_##value(struct device *dev, char *buf)	\
-{								\
-	struct i2c_client *client = to_i2c_client(dev);		\
-	struct lm75_data *data = i2c_get_clientdata(client);	\
-	int temp;						\
-								\
-	lm75_update_client(client);				\
-	temp = TEMP_FROM_REG(data->value);			\
-	return sprintf(buf, "%d\n", temp * 100);		\
+static ssize_t show_##value(struct device *dev, char *buf)		\
+{									\
+	struct i2c_client *client = to_i2c_client(dev);			\
+	struct lm75_data *data = i2c_get_clientdata(client);		\
+	lm75_update_client(client);					\
+	return sprintf(buf, "%d\n", LM75_TEMP_FROM_REG(data->value));	\
 }
 show(temp_max);
 show(temp_hyst);
@@ -102,9 +93,8 @@
 {								\
 	struct i2c_client *client = to_i2c_client(dev);		\
 	struct lm75_data *data = i2c_get_clientdata(client);	\
-	int temp = simple_strtoul(buf, NULL, 10) / 100;		\
-								\
-	data->value = TEMP_TO_REG(temp);			\
+	int temp = simple_strtoul(buf, NULL, 10);		\
+	data->value = LM75_TEMP_TO_REG(temp);			\
 	lm75_write_value(client, reg, data->value);		\
 	return count;						\
 }
diff -Nru a/drivers/i2c/chips/lm75.h b/drivers/i2c/chips/lm75.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/chips/lm75.h	Tue Dec 30 12:30:01 2003
@@ -0,0 +1,49 @@
+/*
+    lm75.h - Part of lm_sensors, Linux kernel modules for hardware
+             monitoring
+    Copyright (c) 2003 Mark M. Hoffman <mhoffman@lightlink.com>
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
+/*
+    This file contains common code for encoding/decoding LM75 type
+    temperature readings, which are emulated by many of the chips
+    we support.  As the user is unlikely to load more than one driver
+    which contains this code, we don't worry about the wasted space.
+*/
+
+#include <linux/i2c-sensor.h>
+
+/* straight from the datasheet */
+#define LM75_TEMP_MIN (-55000)
+#define LM75_TEMP_MAX 125000
+
+/* TEMP: 0.001C/bit (-55C to +125C)
+   REG: (0.5C/bit, two's complement) << 7 */
+static inline u16 LM75_TEMP_TO_REG(int temp)
+{
+	int ntemp = SENSORS_LIMIT(temp, LM75_TEMP_MIN, LM75_TEMP_MAX);
+	ntemp += (ntemp<0 ? -250 : 250);
+	return (u16)((ntemp / 500) << 7);
+}
+
+static inline int LM75_TEMP_FROM_REG(u16 reg)
+{
+	/* use integer division instead of equivalent right shift to
+	   guarantee arithmetic shift and preserve the sign */
+	return ((s16)reg / 128) * 500;
+}
+

