Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263065AbVCDWG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263065AbVCDWG6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 17:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbVCDWEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:04:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:22178 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263173AbVCDUym convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:42 -0500
Cc: adobriyan@mail.ru
Subject: [PATCH] I2C: use time_after instead of comparing jiffies
In-Reply-To: <11099685953642@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:35 -0800
Message-Id: <11099685952343@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2097, 2005/03/02 12:16:37-08:00, adobriyan@mail.ru

[PATCH] I2C: use time_after instead of comparing jiffies

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/adm1021.c    |    5 +++--
 drivers/i2c/chips/adm1025.c    |    5 ++---
 drivers/i2c/chips/adm1026.c    |    7 ++++---
 drivers/i2c/chips/adm1031.c    |    5 +++--
 drivers/i2c/chips/asb100.c     |    4 ++--
 drivers/i2c/chips/ds1621.c     |    5 +++--
 drivers/i2c/chips/eeprom.c     |    4 ++--
 drivers/i2c/chips/fscher.c     |    4 ++--
 drivers/i2c/chips/gl518sm.c    |    5 +++--
 drivers/i2c/chips/it87.c       |    5 +++--
 drivers/i2c/chips/lm63.c       |    5 ++---
 drivers/i2c/chips/lm75.c       |    5 +++--
 drivers/i2c/chips/lm77.c       |    5 +++--
 drivers/i2c/chips/lm78.c       |    5 +++--
 drivers/i2c/chips/lm80.c       |    5 ++---
 drivers/i2c/chips/lm83.c       |    5 ++---
 drivers/i2c/chips/lm85.c       |    5 +++--
 drivers/i2c/chips/lm87.c       |    5 ++---
 drivers/i2c/chips/lm90.c       |    5 ++---
 drivers/i2c/chips/max1619.c    |    6 ++----
 drivers/i2c/chips/pc87360.c    |    4 ++--
 drivers/i2c/chips/smsc47b397.c |    5 ++---
 drivers/i2c/chips/smsc47m1.c   |    4 ++--
 drivers/i2c/chips/via686a.c    |    6 +++---
 drivers/i2c/chips/w83627hf.c   |    5 +++--
 drivers/i2c/chips/w83781d.c    |    6 +++---
 drivers/i2c/chips/w83l785ts.c  |    5 ++---
 27 files changed, 68 insertions(+), 67 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/adm1021.c	2005-03-04 12:24:50 -08:00
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -369,8 +370,8 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 		dev_dbg(&client->dev, "Starting adm1021 update\n");
 
 		data->temp_input = adm1021_read_value(client, ADM1021_REG_TEMP);
diff -Nru a/drivers/i2c/chips/adm1025.c b/drivers/i2c/chips/adm1025.c
--- a/drivers/i2c/chips/adm1025.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/adm1025.c	2005-03-04 12:24:50 -08:00
@@ -49,6 +49,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -505,9 +506,7 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ * 2) ||
-	    (jiffies < data->last_updated) ||
-	    !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
 		int i;
 
 		dev_dbg(&client->dev, "Updating data.\n");
diff -Nru a/drivers/i2c/chips/adm1026.c b/drivers/i2c/chips/adm1026.c
--- a/drivers/i2c/chips/adm1026.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/adm1026.c	2005-03-04 12:24:50 -08:00
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -573,7 +574,7 @@
 
 	down(&data->update_lock);
 	if (!data->valid
-	    || (jiffies - data->last_reading > ADM1026_DATA_INTERVAL)) {
+	    || time_after(jiffies, data->last_reading + ADM1026_DATA_INTERVAL)) {
 		/* Things that change quickly */
 		dev_dbg(&client->dev,"Reading sensor values\n");
 		for (i = 0;i <= 16;++i) {
@@ -620,8 +621,8 @@
 		data->last_reading = jiffies;
 	};  /* last_reading */
 
-	if (!data->valid || (jiffies - data->last_config > 
-		ADM1026_CONFIG_INTERVAL)) {
+	if (!data->valid ||
+	    time_after(jiffies, data->last_config + ADM1026_CONFIG_INTERVAL)) {
 		/* Things that don't change often */
 		dev_dbg(&client->dev, "Reading config values\n");
 		for (i = 0;i <= 16;++i) {
diff -Nru a/drivers/i2c/chips/adm1031.c b/drivers/i2c/chips/adm1031.c
--- a/drivers/i2c/chips/adm1031.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/adm1031.c	2005-03-04 12:24:50 -08:00
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -884,8 +885,8 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 
 		dev_dbg(&client->dev, "Starting adm1031 update\n");
 		for (chan = 0;
diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/asb100.c	2005-03-04 12:24:50 -08:00
@@ -965,8 +965,8 @@
 
 	down(&data->update_lock);
 
-	if (time_after(jiffies - data->last_updated, (unsigned long)(HZ+HZ/2))
-		|| time_before(jiffies, data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+		|| !data->valid) {
 
 		dev_dbg(&client->dev, "starting device update...\n");
 
diff -Nru a/drivers/i2c/chips/ds1621.c b/drivers/i2c/chips/ds1621.c
--- a/drivers/i2c/chips/ds1621.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/ds1621.c	2005-03-04 12:24:50 -08:00
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include "lm75.h"
@@ -284,8 +285,8 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 
 		dev_dbg(&client->dev, "Starting ds1621 update\n");
 
diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/eeprom.c	2005-03-04 12:24:50 -08:00
@@ -32,6 +32,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -86,8 +87,7 @@
 	down(&data->update_lock);
 
 	if (!(data->valid & (1 << slice)) ||
-	    (jiffies - data->last_updated[slice] > 300 * HZ) ||
-	    (jiffies < data->last_updated[slice])) {
+	    time_after(jiffies, data->last_updated[slice] + 300 * HZ)) {
 		dev_dbg(&client->dev, "Starting eeprom update, slice %u\n", slice);
 
 		if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
diff -Nru a/drivers/i2c/chips/fscher.c b/drivers/i2c/chips/fscher.c
--- a/drivers/i2c/chips/fscher.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/fscher.c	2005-03-04 12:24:50 -08:00
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -411,8 +412,7 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > 2 * HZ) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
 
 		dev_dbg(&client->dev, "Starting fscher update\n");
 
diff -Nru a/drivers/i2c/chips/gl518sm.c b/drivers/i2c/chips/gl518sm.c
--- a/drivers/i2c/chips/gl518sm.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/gl518sm.c	2005-03-04 12:24:50 -08:00
@@ -40,6 +40,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -505,8 +506,8 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 		dev_dbg(&client->dev, "Starting gl518 update\n");
 
 		data->alarms = gl518_read_value(client, GL518_REG_INT);
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/it87.c	2005-03-04 12:24:50 -08:00
@@ -35,6 +35,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -1083,8 +1084,8 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 
 		if (update_vbat) {
 			/* Cleared after each update, so reenable.  Value
diff -Nru a/drivers/i2c/chips/lm63.c b/drivers/i2c/chips/lm63.c
--- a/drivers/i2c/chips/lm63.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/lm63.c	2005-03-04 12:24:50 -08:00
@@ -41,6 +41,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -492,9 +493,7 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ) ||
-	    (jiffies < data->last_updated) ||
-	    !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
 		if (data->config & 0x04) { /* tachometer enabled  */
 			/* order matters for fan1_input */
 			data->fan1_input = i2c_smbus_read_byte_data(client,
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/lm75.c	2005-03-04 12:24:50 -08:00
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include "lm75.h"
@@ -259,8 +260,8 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 		dev_dbg(&client->dev, "Starting lm75 update\n");
 
 		data->temp_input = lm75_read_value(client, LM75_REG_TEMP);
diff -Nru a/drivers/i2c/chips/lm77.c b/drivers/i2c/chips/lm77.c
--- a/drivers/i2c/chips/lm77.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/lm77.c	2005-03-04 12:24:50 -08:00
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -360,8 +361,8 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 		dev_dbg(&client->dev, "Starting lm77 update\n");
 		data->temp_input =
 			LM77_TEMP_FROM_REG(lm77_read_value(client,
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/lm78.c	2005-03-04 12:24:50 -08:00
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <asm/io.h>
@@ -704,8 +705,8 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 
 		dev_dbg(&client->dev, "Starting lm78 update\n");
 
diff -Nru a/drivers/i2c/chips/lm80.c b/drivers/i2c/chips/lm80.c
--- a/drivers/i2c/chips/lm80.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/lm80.c	2005-03-04 12:24:50 -08:00
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -529,9 +530,7 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > 2 * HZ) ||
-	    (jiffies < data->last_updated) || !data->valid) {
-
+	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
 		dev_dbg(&client->dev, "Starting lm80 update\n");
 		for (i = 0; i <= 6; i++) {
 			data->in[i] =
diff -Nru a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/lm83.c	2005-03-04 12:24:50 -08:00
@@ -31,6 +31,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -362,9 +363,7 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ * 2) ||
-	    (jiffies < data->last_updated) ||
-	    !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
 		int nr;
 
 		dev_dbg(&client->dev, "Updating lm83 data.\n");
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/lm85.c	2005-03-04 12:24:50 -08:00
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -1354,7 +1355,7 @@
 	down(&data->update_lock);
 
 	if ( !data->valid ||
-	     (jiffies - data->last_reading > LM85_DATA_INTERVAL ) ) {
+	     time_after(jiffies, data->last_reading + LM85_DATA_INTERVAL) ) {
 		/* Things that change quickly */
 		dev_dbg(&client->dev, "Reading sensor values\n");
 		
@@ -1408,7 +1409,7 @@
 	};  /* last_reading */
 
 	if ( !data->valid ||
-	     (jiffies - data->last_config > LM85_CONFIG_INTERVAL) ) {
+	     time_after(jiffies, data->last_config + LM85_CONFIG_INTERVAL) ) {
 		/* Things that don't change often */
 		dev_dbg(&client->dev, "Reading config values\n");
 
diff -Nru a/drivers/i2c/chips/lm87.c b/drivers/i2c/chips/lm87.c
--- a/drivers/i2c/chips/lm87.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/lm87.c	2005-03-04 12:24:50 -08:00
@@ -56,6 +56,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -713,9 +714,7 @@
 
 	down(&data->update_lock);
 
-	if (jiffies - data->last_updated > HZ
-	  || jiffies < data->last_updated
-	  || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
 		int i, j;
 
 		dev_dbg(&client->dev, "Updating data.\n");
diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/lm90.c	2005-03-04 12:24:50 -08:00
@@ -66,6 +66,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -488,9 +489,7 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ * 2) ||
-	    (jiffies < data->last_updated) ||
-	    !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
 		u8 oldh, newh;
 
 		dev_dbg(&client->dev, "Updating lm90 data.\n");
diff -Nru a/drivers/i2c/chips/max1619.c b/drivers/i2c/chips/max1619.c
--- a/drivers/i2c/chips/max1619.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/max1619.c	2005-03-04 12:24:50 -08:00
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -324,10 +325,7 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ * 2) ||
-	    (jiffies < data->last_updated) ||
-	    !data->valid) {
-		
+	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
 		dev_dbg(&client->dev, "Updating max1619 data.\n");
 		data->temp_input1 = i2c_smbus_read_byte_data(client,
 					MAX1619_REG_R_LOCAL_TEMP);
diff -Nru a/drivers/i2c/chips/pc87360.c b/drivers/i2c/chips/pc87360.c
--- a/drivers/i2c/chips/pc87360.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/pc87360.c	2005-03-04 12:24:50 -08:00
@@ -37,6 +37,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -1174,8 +1175,7 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ * 2)
-	 || (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
 		dev_dbg(&client->dev, "Data update\n");
 
 		/* Fans */
diff -Nru a/drivers/i2c/chips/smsc47b397.c b/drivers/i2c/chips/smsc47b397.c
--- a/drivers/i2c/chips/smsc47b397.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/smsc47b397.c	2005-03-04 12:24:50 -08:00
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/init.h>
@@ -130,9 +131,7 @@
 
 	down(&data->update_lock);
 
-	if (time_after(jiffies - data->last_updated, (unsigned long)HZ)
-		|| time_before(jiffies, data->last_updated) || !data->valid) {
-
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
 		dev_dbg(&client->dev, "starting device update...\n");
 
 		/* 4 temperature inputs, 4 fan inputs */
diff -Nru a/drivers/i2c/chips/smsc47m1.c b/drivers/i2c/chips/smsc47m1.c
--- a/drivers/i2c/chips/smsc47m1.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/smsc47m1.c	2005-03-04 12:24:50 -08:00
@@ -28,6 +28,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/init.h>
@@ -527,8 +528,7 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || init) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2) || init) {
 		int i;
 
 		for (i = 0; i < 2; i++) {
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/via686a.c	2005-03-04 12:24:50 -08:00
@@ -35,6 +35,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/init.h>
@@ -726,9 +727,8 @@
 
 	down(&data->update_lock);
 
-       if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-           (jiffies < data->last_updated) || !data->valid) {
-
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 		for (i = 0; i <= 4; i++) {
 			data->in[i] =
 			    via686a_read_value(client, VIA686A_REG_IN(i));
diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/w83627hf.c	2005-03-04 12:24:50 -08:00
@@ -40,6 +40,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -1371,8 +1372,8 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 		for (i = 0; i <= 8; i++) {
 			/* skip missing sensors */
 			if (((data->type == w83697hf) && (i == 1)) ||
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/w83781d.c	2005-03-04 12:24:50 -08:00
@@ -39,6 +39,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -1609,9 +1610,8 @@
 
 	down(&data->update_lock);
 
-	if (time_after
-	    (jiffies - data->last_updated, (unsigned long) (HZ + HZ / 2))
-	    || time_before(jiffies, data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 		dev_dbg(dev, "Starting device update\n");
 
 		for (i = 0; i <= 8; i++) {
diff -Nru a/drivers/i2c/chips/w83l785ts.c b/drivers/i2c/chips/w83l785ts.c
--- a/drivers/i2c/chips/w83l785ts.c	2005-03-04 12:24:50 -08:00
+++ b/drivers/i2c/chips/w83l785ts.c	2005-03-04 12:24:50 -08:00
@@ -35,6 +35,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -294,9 +295,7 @@
 
 	down(&data->update_lock);
 
-	if (!data->valid
-	 || (jiffies - data->last_updated > HZ * 2)
-	 || (jiffies < data->last_updated)) {
+	if (!data->valid || time_after(jiffies, data->last_updated + HZ * 2)) {
 		dev_dbg(&client->dev, "Updating w83l785ts data.\n");
 		data->temp = w83l785ts_read_value(client,
 			     W83L785TS_REG_TEMP, data->temp);

