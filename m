Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263360AbVCDXRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263360AbVCDXRz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVCDXMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:12:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:37538 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263183AbVCDUyz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:55 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Kill i2c_client.id (3/5)
In-Reply-To: <11099685932577@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:33 -0800
Message-Id: <11099685933363@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2085, 2005/03/02 11:52:31-08:00, khali@linux-fr.org

[PATCH] I2C: Kill i2c_client.id (3/5)

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
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/acorn/char/i2c.c             |    2 +-
 drivers/acorn/char/pcf8583.c         |    1 -
 drivers/i2c/i2c-dev.c                |    1 -
 drivers/macintosh/therm_windtunnel.c |    4 ----
 sound/oss/dmasound/dac3550a.c        |    4 ----
 sound/ppc/keywest.c                  |    2 --
 6 files changed, 1 insertion(+), 13 deletions(-)


diff -Nru a/drivers/acorn/char/i2c.c b/drivers/acorn/char/i2c.c
--- a/drivers/acorn/char/i2c.c	2005-03-04 12:26:11 -08:00
+++ b/drivers/acorn/char/i2c.c	2005-03-04 12:26:11 -08:00
@@ -313,7 +313,7 @@
 
 static int ioc_client_reg(struct i2c_client *client)
 {
-	if (client->id == I2C_DRIVERID_PCF8583 &&
+	if (client->driver->id == I2C_DRIVERID_PCF8583 &&
 	    client->addr == 0x50) {
 		struct rtc_tm rtctm;
 		unsigned int year;
diff -Nru a/drivers/acorn/char/pcf8583.c b/drivers/acorn/char/pcf8583.c
--- a/drivers/acorn/char/pcf8583.c	2005-03-04 12:26:11 -08:00
+++ b/drivers/acorn/char/pcf8583.c	2005-03-04 12:26:11 -08:00
@@ -51,7 +51,6 @@
 		return -ENOMEM;
 
 	memset(c, 0, sizeof(*c));
-	c->id		= pcf8583_driver.id;
 	c->addr		= addr;
 	c->adapter	= adap;
 	c->driver	= &pcf8583_driver;
diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	2005-03-04 12:26:11 -08:00
+++ b/drivers/i2c/i2c-dev.c	2005-03-04 12:26:11 -08:00
@@ -507,7 +507,6 @@
 
 static struct i2c_client i2cdev_client_template = {
 	.name		= "I2C /dev entry",
-	.id		= 1,
 	.addr		= -1,
 	.driver		= &i2cdev_driver,
 };
diff -Nru a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
--- a/drivers/macintosh/therm_windtunnel.c	2005-03-04 12:26:11 -08:00
+++ b/drivers/macintosh/therm_windtunnel.c	2005-03-04 12:26:11 -08:00
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
diff -Nru a/sound/oss/dmasound/dac3550a.c b/sound/oss/dmasound/dac3550a.c
--- a/sound/oss/dmasound/dac3550a.c	2005-03-04 12:26:11 -08:00
+++ b/sound/oss/dmasound/dac3550a.c	2005-03-04 12:26:11 -08:00
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
diff -Nru a/sound/ppc/keywest.c b/sound/ppc/keywest.c
--- a/sound/ppc/keywest.c	2005-03-04 12:26:11 -08:00
+++ b/sound/ppc/keywest.c	2005-03-04 12:26:11 -08:00
@@ -76,8 +76,6 @@
 	new_client->flags = 0;
 
 	strcpy(i2c_device_name(new_client), keywest_ctx->name);
-
-	new_client->id = keywest_ctx->id++; /* Automatically unique */
 	keywest_ctx->client = new_client;
 	
 	/* Tell the i2c layer a new client has arrived */

