Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbUCPC4b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 21:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbUCPCxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 21:53:45 -0500
Received: from mail.kroah.org ([65.200.24.183]:24751 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262901AbUCPACb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:31 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913912632@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:31 -0800
Message-Id: <10793913911123@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.61.12, 2004/02/23 16:29:51-08:00, khali@linux-fr.org

[PATCH] I2C: fix it87 sensor type

Here comes a patch by Takeru Komoriya which fixes the way the it87
driver handles temperature sensor types selection.

* Use the same values as the CVS driver and sensors program.
* Better comments.
* Get rid of the old setting method (already gone in CVS).
* Handle invalid values correctly.


 drivers/i2c/chips/it87.c |   25 +++++++++++--------------
 1 files changed, 11 insertions(+), 14 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Mon Mar 15 14:36:59 2004
+++ b/drivers/i2c/chips/it87.c	Mon Mar 15 14:36:59 2004
@@ -6,7 +6,7 @@
               IT8712F  Super I/O chip w/LPC interface & SMbus
               Sis950   A clone of the IT8705F
 
-    Copyright (c) 2001 Chris Gauthron <chrisg@0-in.com> 
+    Copyright (C) 2001 Chris Gauthron <chrisg@0-in.com> 
     Largely inspired by lm78.c of the same package
 
     This program is free software; you can redistribute it and/or modify
@@ -57,12 +57,6 @@
 /* Update battery voltage after every reading if true */
 static int update_vbat = 0;
 
-
-/* Enable Temp1 as thermal resistor */
-/* Enable Temp2 as thermal diode */
-/* Enable Temp3 as thermal resistor */
-static int temp_type = 0x2a;
-
 /* Many IT87 constants specified below */
 
 /* Length of ISA address segment */
@@ -422,10 +416,10 @@
 	struct it87_data *data = i2c_get_clientdata(client);
 	it87_update_client(client);
 	if (data->sensor & (1 << nr))
-	    return sprintf(buf, "1\n");
+		return sprintf(buf, "3\n");  /* thermal diode */
 	if (data->sensor & (8 << nr))
-	    return sprintf(buf, "2\n");
-	return sprintf(buf, "0\n");
+		return sprintf(buf, "2\n");  /* thermistor */
+	return sprintf(buf, "0\n");      /* disabled */
 }
 static ssize_t set_sensor(struct device *dev, const char *buf, 
 		size_t count, int nr)
@@ -436,10 +430,13 @@
 
 	data->sensor &= ~(1 << nr);
 	data->sensor &= ~(8 << nr);
-	if (val == 1)
+	/* 3 = thermal diode; 2 = thermistor; 0 = disabled */
+	if (val == 3)
 	    data->sensor |= 1 << nr;
 	else if (val == 2)
 	    data->sensor |= 8 << nr;
+	else if (val != 0)
+		return -1;
 	it87_write_value(client, IT87_REG_TEMP_ENABLE, data->sensor);
 	return count;
 }
@@ -888,7 +885,7 @@
 
 	/* Enable Temp1-Temp3 */
 	data->sensor = (it87_read_value(client, IT87_REG_TEMP_ENABLE) & 0xc0);
-	data->sensor |= temp_type & 0x3f;
+	data->sensor |= 0x2a; /* Temp1,Temp3=thermistor; Temp2=thermal diode */
 	it87_write_value(client, IT87_REG_TEMP_ENABLE, data->sensor);
 
 	/* Enable fans */
@@ -967,6 +964,8 @@
 			(it87_read_value(client, IT87_REG_ALARM2) << 8) |
 			(it87_read_value(client, IT87_REG_ALARM3) << 16);
 
+		data->sensor = it87_read_value(client, IT87_REG_TEMP_ENABLE);
+
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}
@@ -989,8 +988,6 @@
 MODULE_DESCRIPTION("IT8705F, IT8712F, Sis950 driver");
 MODULE_PARM(update_vbat, "i");
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
-MODULE_PARM(temp_type, "i");
-MODULE_PARM_DESC(temp_type, "Temperature sensor type, normally leave unset");
 MODULE_LICENSE("GPL");
 
 module_init(sm_it87_init);

