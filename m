Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267798AbTBEEqT>; Tue, 4 Feb 2003 23:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267799AbTBEEqT>; Tue, 4 Feb 2003 23:46:19 -0500
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.224]:44497 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S267798AbTBEEqR>; Tue, 4 Feb 2003 23:46:17 -0500
Date: Wed, 5 Feb 2003 00:04:35 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.59 : drivers/media/video/bt856.c
Message-ID: <Pine.LNX.4.44.0302050002400.6158-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following addresses a similar compile error as buzilla bug #169. 
Please review for inclusion.

Regards,
Frank

--- linux/drivers/media/video/bt856.c.old	2003-02-05 00:01:03.000000000 -0500
+++ linux/drivers/media/video/bt856.c	2003-02-05 00:00:54.000000000 -0500
@@ -14,7 +14,6 @@
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation; either version 2 of the License, or
     (at your option) any later version.
-
     This program is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
@@ -82,6 +81,7 @@
 	int contrast;
 	int hue;
 	int sat;
+	struct semaphore lock;
 };
 
 #define   I2C_BT856        0x88
@@ -90,11 +90,6 @@
 
 /* ----------------------------------------------------------------------- */
 
-static int bt856_probe(struct i2c_adapter *adap)
-{
-	return i2c_probe(adap, &addr_data , bt856_attach);
-}
-
 static int bt856_setbit(struct bt856 *dev, int subaddr, int bit, int data)
 {
 	return i2c_smbus_write_byte_data(dev->client, subaddr,(dev->reg[subaddr] & ~(1 << bit)) | (data ? (1 << bit) : 0));
@@ -134,7 +129,7 @@
 	encoder->norm = VIDEO_MODE_NTSC;
 	encoder->enable = 1;
 
-	DEBUG(printk(KERN_INFO "%s-bt856: attach\n", encoder->bus->name));
+	DEBUG(printk(KERN_INFO "%s-bt856: attach\n", encoder->client->name));
 
 	i2c_smbus_write_byte_data(client, 0xdc, 0x18);
 	encoder->reg[0xdc] = 0x18;
@@ -167,6 +162,10 @@
 	return 0;
 }
 
+static int bt856_probe(struct i2c_adapter *adap)
+{
+	return i2c_probe(adap, &addr_data , bt856_attach);
+}
 
 static int bt856_detach(struct i2c_client *client)
 {
@@ -299,21 +298,19 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver i2c_driver_bt856 = {
-	"bt856",		/* name */
-	I2C_DRIVERID_BT856,	/* ID */
-	I2C_DF_NOTIFY,
-	bt856_probe,
-	bt856_detach,
-	bt856_command
+	.owner = THIS_MODULE,
+	.name = "bt856",		/* name */
+	.id = I2C_DRIVERID_BT856,	/* ID */
+	.flags = I2C_DF_NOTIFY,
+	.attach_adapter = bt856_probe,
+	.detach_client = bt856_detach,
+	.command = bt856_command
 };
 
 static struct i2c_client client_template = {
-	"bt856_client",
-	-1,
-	0,
-	0,
-	NULL,
-	&i2c_driver_bt856
+	.name = "bt856_client",
+	.id = -1,
+	.driver = &i2c_driver_bt856
 };
 
 static int bt856_init(void)


