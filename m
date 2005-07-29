Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262746AbVG2TUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbVG2TUZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbVG2TT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:19:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:4015 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262756AbVG2TQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:16:26 -0400
Date: Fri, 29 Jul 2005 12:15:12 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, khali@linux-fr.org, marcelo@feitoza.com.br
Subject: [patch 09/29] I2C: use time_after in 3 chip drivers
Message-ID: <20050729191512.GK5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

A few i2c drivers were not updated to use time_after() yet.

Signed-off-by: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/hwmon/atxp1.c   |    5 ++---
 drivers/hwmon/fscpos.c  |    4 ++--
 drivers/hwmon/gl520sm.c |    4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

--- gregkh-2.6.orig/drivers/hwmon/atxp1.c	2005-07-29 11:29:59.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/atxp1.c	2005-07-29 11:34:03.000000000 -0700
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -80,9 +81,7 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ) ||
-	    (jiffies < data->last_updated) ||
-	    !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
 
 		/* Update local register data */
 		data->reg.vid = i2c_smbus_read_byte_data(client, ATXP1_VID);
--- gregkh-2.6.orig/drivers/hwmon/fscpos.c	2005-07-29 11:29:59.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/fscpos.c	2005-07-29 11:34:03.000000000 -0700
@@ -32,6 +32,7 @@
 
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/init.h>
@@ -572,8 +573,7 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > 2 * HZ) ||
-			(jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
 		int i;
 
 		dev_dbg(&client->dev, "Starting fscpos update\n");
--- gregkh-2.6.orig/drivers/hwmon/gl520sm.c	2005-07-29 11:29:59.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/gl520sm.c	2005-07-29 11:34:03.000000000 -0700
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -678,8 +679,7 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > 2 * HZ) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
 
 		dev_dbg(&client->dev, "Starting gl520sm update\n");
 

--
