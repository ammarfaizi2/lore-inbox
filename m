Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbVAPTgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVAPTgw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 14:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbVAPTgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 14:36:52 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:3857 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262562AbVAPTgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 14:36:41 -0500
Date: Sun, 16 Jan 2005 20:39:09 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH 2.6] I2C: Kill i2c_client.id (3/5)
Message-Id: <20050116203909.3583f239.khali@linux-fr.org>
In-Reply-To: <20050116194653.17c96499.khali@linux-fr.org>
References: <20050116194653.17c96499.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(3/5) Stop using i2c_client.id in misc drivers.

Affected drivers:
* acorn/char/pcf8583
* acorn/char/i2c
* i2c/i2c-dev
* macintosh/therm_windtunnel
* sound/oss/dmasound/dac3550a
* sound/ppc/keywest

The Acorn pcf8583 driver would give the i2c_client id the same value as
the i2c_driver id, and later test that client id (in i2c). I changed it
to test the client's driver id instead. The result is the same and the
client id is then useless and can be removed.

All other drivers here would allocate the client id to some value and
then never use it. They are unaffected by the change.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

diff -ruN linux-2.6.11-rc1.orig/drivers/acorn/char/i2c.c linux-2.6.11-rc1/drivers/acorn/char/i2c.c
--- linux-2.6.11-rc1.orig/drivers/acorn/char/i2c.c	2004-12-24 22:35:49.000000000 +0100
+++ linux-2.6.11-rc1/drivers/acorn/char/i2c.c	2005-01-16 12:50:29.000000000 +0100
@@ -313,7 +313,7 @@
 
 static int ioc_client_reg(struct i2c_client *client)
 {
-	if (client->id == I2C_DRIVERID_PCF8583 &&
+	if (client->driver->id == I2C_DRIVERID_PCF8583 &&
 	    client->addr == 0x50) {
 		struct rtc_tm rtctm;
 		unsigned int year;
diff -ruN linux-2.6.11-rc1.orig/drivers/acorn/char/pcf8583.c linux-2.6.11-rc1/drivers/acorn/char/pcf8583.c
--- linux-2.6.11-rc1.orig/drivers/acorn/char/pcf8583.c	2004-12-24 22:35:28.000000000 +0100
+++ linux-2.6.11-rc1/drivers/acorn/char/pcf8583.c	2005-01-16 12:50:29.000000000 +0100
@@ -51,7 +51,6 @@
 		return -ENOMEM;
 
 	memset(c, 0, sizeof(*c));
-	c->id		= pcf8583_driver.id;
 	c->addr		= addr;
 	c->adapter	= adap;
 	c->driver	= &pcf8583_driver;
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/i2c-dev.c linux-2.6.11-rc1/drivers/i2c/i2c-dev.c
--- linux-2.6.11-rc1.orig/drivers/i2c/i2c-dev.c	2004-12-24 22:35:24.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/i2c-dev.c	2005-01-16 12:50:29.000000000 +0100
@@ -507,7 +507,6 @@
 
 static struct i2c_client i2cdev_client_template = {
 	.name		= "I2C /dev entry",
-	.id		= 1,
 	.addr		= -1,
 	.driver		= &i2cdev_driver,
 };
diff -ruN linux-2.6.11-rc1.orig/drivers/macintosh/therm_windtunnel.c linux-2.6.11-rc1/drivers/macintosh/therm_windtunnel.c
--- linux-2.6.11-rc1.orig/drivers/macintosh/therm_windtunnel.c	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6.11-rc1/drivers/macintosh/therm_windtunnel.c	2005-01-16 12:50:29.000000000 +0100
@@ -47,8 +47,6 @@
 #define LOG_TEMP		0			/* continously log temperature */
 
 #define I2C_DRIVERID_G4FAN	0x9001			/* fixme */
-#define THERMOSTAT_CLIENT_ID	1
-#define FAN_CLIENT_ID		2
 
 static int 			do_probe( struct i2c_adapter *adapter, int addr, int kind);
 
@@ -372,7 +370,6 @@
 		goto out;
 	printk("ADM1030 fan controller [@%02x]\n", cl->addr );
 
-	cl->id = FAN_CLIENT_ID;
 	strlcpy( cl->name, "ADM1030 fan controller", sizeof(cl->name) );
 
 	if( !i2c_attach_client(cl) )
@@ -412,7 +409,6 @@
 	x.overheat_temp = os_temp;
 	x.overheat_hyst = hyst_temp;
 	
-	cl->id = THERMOSTAT_CLIENT_ID;
 	strlcpy( cl->name, "DS1775 thermostat", sizeof(cl->name) );
 
 	if( !i2c_attach_client(cl) )
diff -ruN linux-2.6.11-rc1.orig/sound/oss/dmasound/dac3550a.c linux-2.6.11-rc1/sound/oss/dmasound/dac3550a.c
--- linux-2.6.11-rc1.orig/sound/oss/dmasound/dac3550a.c	2004-12-24 22:34:26.000000000 +0100
+++ linux-2.6.11-rc1/sound/oss/dmasound/dac3550a.c	2005-01-16 12:50:29.000000000 +0100
@@ -40,9 +40,6 @@
 static int daca_detect_client(struct i2c_adapter *adapter, int address);
 static int daca_detach_client(struct i2c_client *client);
 
-/* Unique ID allocation */
-static int daca_id;
-
 struct i2c_driver daca_driver = {  
 	.owner			= THIS_MODULE,
 	.name			= "DAC3550A driver  V " DACA_VERSION,
@@ -176,7 +173,6 @@
 	new_client->driver = &daca_driver;
 	new_client->flags = 0;
 	strcpy(new_client->name, client_name);
-	new_client->id = daca_id++; /* racy... */
 
 	if (daca_init_client(new_client))
 		goto bail;
diff -ruN linux-2.6.11-rc1.orig/sound/ppc/keywest.c linux-2.6.11-rc1/sound/ppc/keywest.c
--- linux-2.6.11-rc1.orig/sound/ppc/keywest.c	2004-12-24 22:35:39.000000000 +0100
+++ linux-2.6.11-rc1/sound/ppc/keywest.c	2005-01-16 12:50:29.000000000 +0100
@@ -76,8 +76,6 @@
 	new_client->flags = 0;
 
 	strcpy(i2c_device_name(new_client), keywest_ctx->name);
-
-	new_client->id = keywest_ctx->id++; /* Automatically unique */
 	keywest_ctx->client = new_client;
 	
 	/* Tell the i2c layer a new client has arrived */


-- 
Jean Delvare
http://khali.linux-fr.org/
