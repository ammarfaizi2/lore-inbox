Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264326AbTLPELW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 23:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbTLPELW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 23:11:22 -0500
Received: from smtp-relay.dca.net ([216.158.48.66]:10932 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S264326AbTLPELK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 23:11:10 -0500
Date: Mon, 15 Dec 2003 23:04:39 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@Stimpy.netroedge.com>
Subject: Re: [PATCH 2.6] sensors chip updates (4 of 4)
Message-ID: <20031216040439.GE1658@earth.solarsys.private>
References: <20031216035219.GA1658@earth.solarsys.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031216035219.GA1658@earth.solarsys.private>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is based on the lm_sensors project CVS, from revisions 1.45 and 1.1
of lm75.c and lm75.h, respectively.

The patch fixes the conversion routines (according to datasheet) and moves
them into a header file - as these conversions can be used by several drivers
which emulate LM75s as subclients.  Also, temps are now reported in 1/1000 C
in sysfs as per documentation.

--- linux-2.6.0-test11-mmh/drivers/i2c/chips/lm75.c.old	2003-12-14 18:02:18.000000000 -0500
+++ linux-2.6.0-test11-mmh/drivers/i2c/chips/lm75.c	2003-12-14 19:28:08.000000000 -0500
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
--- linux-2.6.0-test11-mmh/drivers/i2c/chips/lm75.h.old	2003-12-14 18:05:09.000000000 -0500
+++ linux-2.6.0-test11-mmh/drivers/i2c/chips/lm75.h	2003-12-14 18:32:46.000000000 -0500
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

-- 
Mark M. Hoffman
mhoffman@lightlink.com

