Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbVAPT0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbVAPT0D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 14:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbVAPT0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 14:26:03 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:12304 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262579AbVAPTZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 14:25:15 -0500
Date: Sun, 16 Jan 2005 20:27:42 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Michael Hunold <michael@mihu.de>,
       Gerd Knorr <kraxel@bytesex.org>
Subject: [PATCH 2.6] I2C: Kill i2c_client.id (2/5)
Message-Id: <20050116202742.64524d6a.khali@linux-fr.org>
In-Reply-To: <20050116194653.17c96499.khali@linux-fr.org>
References: <20050116194653.17c96499.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(2/5) Stop using i2c_client.id in media/video drivers.

Affected drivers:
* adv7170
* adv7175
* bt819
* bt856
* bttv
* cx88
* ovcamchip
* saa5246a
* saa5249
* saa7110
* saa7111
* saa7114
* saa7134
* saa7185
* tda7432
* tda9840
* tda9875
* tea6415c
* tea6420
* tuner-3036
* vpx3220

Most drivers here would include the id as part of their i2c client name
(e.g. adv7170[0]). This looks more like an habit than something really
needed, so I replaced the various printf by strlcpy, which should be
slightly faster. As said earlier, clients can be differenciated thanks
to their bus id and address if needed, so I don't think that including
this information in the client name is wise anyway.

Other drivers would either set the id to -1 or to a unique value but
then never use it. These drivers are unaffected by the changes.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/adv7170.c linux-2.6.11-rc1/drivers/media/video/adv7170.c
--- linux-2.6.11-rc1.orig/drivers/media/video/adv7170.c	2005-01-14 18:36:52.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/adv7170.c	2005-01-16 12:50:29.000000000 +0100
@@ -402,7 +402,6 @@
 	.force			= force
 };
 
-static int adv7170_i2c_id = 0;
 static struct i2c_driver i2c_driver_adv7170;
 
 static int
@@ -432,7 +431,6 @@
 	client->adapter = adapter;
 	client->driver = &i2c_driver_adv7170;
 	client->flags = I2C_CLIENT_ALLOW_USE;
-	client->id = adv7170_i2c_id++;
 	if ((client->addr == I2C_ADV7170 >> 1) ||
 	    (client->addr == (I2C_ADV7170 >> 1) + 1)) {
 		dname = adv7170_name;
@@ -444,8 +442,7 @@
 		kfree(client);
 		return 0;
 	}
-	snprintf(I2C_NAME(client), sizeof(I2C_NAME(client)) - 1,
-		"%s[%d]", dname, client->id);
+	strlcpy(I2C_NAME(client), dname, sizeof(I2C_NAME(client)));
 
 	encoder = kmalloc(sizeof(struct adv7170), GFP_KERNEL);
 	if (encoder == NULL) {
diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/adv7175.c linux-2.6.11-rc1/drivers/media/video/adv7175.c
--- linux-2.6.11-rc1.orig/drivers/media/video/adv7175.c	2005-01-14 18:36:52.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/adv7175.c	2005-01-16 12:50:29.000000000 +0100
@@ -452,7 +452,6 @@
 	.force			= force
 };
 
-static int adv7175_i2c_id = 0;
 static struct i2c_driver i2c_driver_adv7175;
 
 static int
@@ -482,7 +481,6 @@
 	client->adapter = adapter;
 	client->driver = &i2c_driver_adv7175;
 	client->flags = I2C_CLIENT_ALLOW_USE;
-	client->id = adv7175_i2c_id++;
 	if ((client->addr == I2C_ADV7175 >> 1) ||
 	    (client->addr == (I2C_ADV7175 >> 1) + 1)) {
 		dname = adv7175_name;
@@ -494,8 +492,7 @@
 		kfree(client);
 		return 0;
 	}
-	snprintf(I2C_NAME(client), sizeof(I2C_NAME(client)) - 1,
-		"%s[%d]", dname, client->id);
+	strlcpy(I2C_NAME(client), dname, sizeof(I2C_NAME(client)));
 
 	encoder = kmalloc(sizeof(struct adv7175), GFP_KERNEL);
 	if (encoder == NULL) {
diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/bt819.c linux-2.6.11-rc1/drivers/media/video/bt819.c
--- linux-2.6.11-rc1.orig/drivers/media/video/bt819.c	2005-01-14 18:36:52.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/bt819.c	2005-01-16 12:50:29.000000000 +0100
@@ -517,7 +517,6 @@
 	.force			= force
 };
 
-static int bt819_i2c_id = 0;
 static struct i2c_driver i2c_driver_bt819;
 
 static int
@@ -546,7 +545,6 @@
 	client->adapter = adapter;
 	client->driver = &i2c_driver_bt819;
 	client->flags = I2C_CLIENT_ALLOW_USE;
-	client->id = bt819_i2c_id++;
 
 	decoder = kmalloc(sizeof(struct bt819), GFP_KERNEL);
 	if (decoder == NULL) {
@@ -568,16 +566,13 @@
 	id = bt819_read(client, 0x17);
 	switch (id & 0xf0) {
 	case 0x70:
-	        snprintf(I2C_NAME(client), sizeof(I2C_NAME(client)) - 1,
-			 "bt819a[%d]", client->id);
+		strlcpy(I2C_NAME(client), "bt819a", sizeof(I2C_NAME(client)));
 		break;
 	case 0x60:
-		snprintf(I2C_NAME(client), sizeof(I2C_NAME(client)) - 1,
-			 "bt817a[%d]", client->id);
+		strlcpy(I2C_NAME(client), "bt817a", sizeof(I2C_NAME(client)));
 		break;
 	case 0x20:
-		snprintf(I2C_NAME(client), sizeof(I2C_NAME(client)) - 1,
-			 "bt815a[%d]", client->id);
+		strlcpy(I2C_NAME(client), "bt815a", sizeof(I2C_NAME(client)));
 		break;
 	default:
 		dprintk(1,
diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/bt856.c linux-2.6.11-rc1/drivers/media/video/bt856.c
--- linux-2.6.11-rc1.orig/drivers/media/video/bt856.c	2005-01-14 18:36:52.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/bt856.c	2005-01-16 12:50:29.000000000 +0100
@@ -306,7 +306,6 @@
 	.force			= force
 };
 
-static int bt856_i2c_id = 0;
 static struct i2c_driver i2c_driver_bt856;
 
 static int
@@ -335,9 +334,7 @@
 	client->adapter = adapter;
 	client->driver = &i2c_driver_bt856;
 	client->flags = I2C_CLIENT_ALLOW_USE;
-	client->id = bt856_i2c_id++;
-	snprintf(I2C_NAME(client), sizeof(I2C_NAME(client)) - 1,
-		"bt856[%d]", client->id);
+	strlcpy(I2C_NAME(client), "bt856", sizeof(I2C_NAME(client)));
 
 	encoder = kmalloc(sizeof(struct bt856), GFP_KERNEL);
 	if (encoder == NULL) {
diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/bttv-i2c.c linux-2.6.11-rc1/drivers/media/video/bttv-i2c.c
--- linux-2.6.11-rc1.orig/drivers/media/video/bttv-i2c.c	2005-01-14 18:36:52.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/bttv-i2c.c	2005-01-16 12:50:29.000000000 +0100
@@ -336,7 +336,6 @@
 
 static struct i2c_client bttv_i2c_client_template = {
 	I2C_DEVNAME("bttv internal"),
-        .id       = -1,
 };
 
 
diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/cx88/cx88-i2c.c linux-2.6.11-rc1/drivers/media/video/cx88/cx88-i2c.c
--- linux-2.6.11-rc1.orig/drivers/media/video/cx88/cx88-i2c.c	2004-12-24 22:34:31.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/cx88/cx88-i2c.c	2005-01-16 12:50:29.000000000 +0100
@@ -141,7 +141,6 @@
 
 static struct i2c_client cx8800_i2c_client_template = {
         I2C_DEVNAME("cx88xx internal"),
-        .id   = -1,
 };
 
 static char *i2c_devs[128] = {
diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/ovcamchip/ovcamchip_core.c linux-2.6.11-rc1/drivers/media/video/ovcamchip/ovcamchip_core.c
--- linux-2.6.11-rc1.orig/drivers/media/video/ovcamchip/ovcamchip_core.c	2004-12-24 22:35:28.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/ovcamchip/ovcamchip_core.c	2005-01-16 12:50:29.000000000 +0100
@@ -422,7 +422,6 @@
 
 static struct i2c_client client_template = {
 	I2C_DEVNAME("(unset)"),
-	.id =		-1,
 	.driver =	&driver,
 };
 
diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/saa5246a.c linux-2.6.11-rc1/drivers/media/video/saa5246a.c
--- linux-2.6.11-rc1.orig/drivers/media/video/saa5246a.c	2004-12-24 22:34:33.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/saa5246a.c	2005-01-16 12:50:29.000000000 +0100
@@ -185,7 +185,6 @@
 };
 
 static struct i2c_client client_template = {
-	.id 		= -1,
 	.driver		= &i2c_driver_videotext,
 	.name		= "(unset)",
 };
diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/saa5249.c linux-2.6.11-rc1/drivers/media/video/saa5249.c
--- linux-2.6.11-rc1.orig/drivers/media/video/saa5249.c	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/saa5249.c	2005-01-16 12:50:29.000000000 +0100
@@ -255,7 +255,6 @@
 };
 
 static struct i2c_client client_template = {
-	.id 		= -1,
 	.driver		= &i2c_driver_videotext,
 	.name		= "(unset)",
 };
diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/saa7110.c linux-2.6.11-rc1/drivers/media/video/saa7110.c
--- linux-2.6.11-rc1.orig/drivers/media/video/saa7110.c	2005-01-14 18:36:52.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/saa7110.c	2005-01-16 12:50:29.000000000 +0100
@@ -476,7 +476,6 @@
 	.force			= force
 };
 
-static int saa7110_i2c_id = 0;
 static struct i2c_driver i2c_driver_saa7110;
 
 static int
@@ -507,9 +506,7 @@
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7110;
 	client->flags = I2C_CLIENT_ALLOW_USE;
-	client->id = saa7110_i2c_id++;
-	snprintf(I2C_NAME(client), sizeof(I2C_NAME(client)) - 1,
-		"saa7110[%d]", client->id);
+	strlcpy(I2C_NAME(client), "saa7110", sizeof(I2C_NAME(client)));
 
 	decoder = kmalloc(sizeof(struct saa7110), GFP_KERNEL);
 	if (decoder == 0) {
diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/saa7111.c linux-2.6.11-rc1/drivers/media/video/saa7111.c
--- linux-2.6.11-rc1.orig/drivers/media/video/saa7111.c	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/saa7111.c	2005-01-16 12:50:29.000000000 +0100
@@ -500,7 +500,6 @@
 	.force			= force
 };
 
-static int saa7111_i2c_id = 0;
 static struct i2c_driver i2c_driver_saa7111;
 
 static int
@@ -530,9 +529,7 @@
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7111;
 	client->flags = I2C_CLIENT_ALLOW_USE;
-	client->id = saa7111_i2c_id++;
-	snprintf(I2C_NAME(client), sizeof(I2C_NAME(client)) - 1,
-		"saa7111[%d]", client->id);
+	strlcpy(I2C_NAME(client), "saa7111", sizeof(I2C_NAME(client)));
 
 	decoder = kmalloc(sizeof(struct saa7111), GFP_KERNEL);
 	if (decoder == NULL) {
diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/saa7114.c linux-2.6.11-rc1/drivers/media/video/saa7114.c
--- linux-2.6.11-rc1.orig/drivers/media/video/saa7114.c	2005-01-14 18:36:52.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/saa7114.c	2005-01-16 12:50:29.000000000 +0100
@@ -838,7 +838,6 @@
 	.force			= force
 };
 
-static int saa7114_i2c_id = 0;
 static struct i2c_driver i2c_driver_saa7114;
 
 static int
@@ -871,9 +870,7 @@
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7114;
 	client->flags = I2C_CLIENT_ALLOW_USE;
-	client->id = saa7114_i2c_id++;
-	snprintf(I2C_NAME(client), sizeof(I2C_NAME(client)) - 1,
-		"saa7114[%d]", client->id);
+	strlcpy(I2C_NAME(client), "saa7114", sizeof(I2C_NAME(client)));
 
 	decoder = kmalloc(sizeof(struct saa7114), GFP_KERNEL);
 	if (decoder == NULL) {
diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/saa7134/saa7134-i2c.c linux-2.6.11-rc1/drivers/media/video/saa7134/saa7134-i2c.c
--- linux-2.6.11-rc1.orig/drivers/media/video/saa7134/saa7134-i2c.c	2004-12-24 22:34:01.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/saa7134/saa7134-i2c.c	2005-01-16 12:50:29.000000000 +0100
@@ -362,7 +362,6 @@
 
 static struct i2c_client saa7134_client_template = {
 	I2C_DEVNAME("saa7134 internal"),
-        .id        = -1,
 };
 
 /* ----------------------------------------------------------- */
diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/saa7185.c linux-2.6.11-rc1/drivers/media/video/saa7185.c
--- linux-2.6.11-rc1.orig/drivers/media/video/saa7185.c	2005-01-14 18:36:52.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/saa7185.c	2005-01-16 12:50:29.000000000 +0100
@@ -398,7 +398,6 @@
 	.force			= force
 };
 
-static int saa7185_i2c_id = 0;
 static struct i2c_driver i2c_driver_saa7185;
 
 static int
@@ -427,9 +426,7 @@
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7185;
 	client->flags = I2C_CLIENT_ALLOW_USE;
-	client->id = saa7185_i2c_id++;
-	snprintf(I2C_NAME(client), sizeof(I2C_NAME(client)) - 1,
-		"saa7185[%d]", client->id);
+	strlcpy(I2C_NAME(client), "saa7185", sizeof(I2C_NAME(client)));
 
 	encoder = kmalloc(sizeof(struct saa7185), GFP_KERNEL);
 	if (encoder == NULL) {
diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/tda7432.c linux-2.6.11-rc1/drivers/media/video/tda7432.c
--- linux-2.6.11-rc1.orig/drivers/media/video/tda7432.c	2005-01-14 18:36:52.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/tda7432.c	2005-01-16 12:50:29.000000000 +0100
@@ -528,7 +528,6 @@
 static struct i2c_client client_template =
 {
 	I2C_DEVNAME("tda7432"),
-        .id         = -1,
 	.driver     = &driver,
 };
 
diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/tda9840.c linux-2.6.11-rc1/drivers/media/video/tda9840.c
--- linux-2.6.11-rc1.orig/drivers/media/video/tda9840.c	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/tda9840.c	2005-01-16 12:50:29.000000000 +0100
@@ -51,9 +51,6 @@
 static struct i2c_driver driver;
 static struct i2c_client client_template;
 
-/* unique ID allocation */
-static int tda9840_id = 0;
-
 static int command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
 	int result;
@@ -179,7 +176,6 @@
 
 	/* fill client structure */
 	memcpy(client, &client_template, sizeof(struct i2c_client));
-	client->id = tda9840_id++;
 	client->addr = address;
 	client->adapter = adapter;
 
diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/tda9875.c linux-2.6.11-rc1/drivers/media/video/tda9875.c
--- linux-2.6.11-rc1.orig/drivers/media/video/tda9875.c	2005-01-14 18:36:52.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/tda9875.c	2005-01-16 12:50:29.000000000 +0100
@@ -399,7 +399,6 @@
 static struct i2c_client client_template =
 {
         I2C_DEVNAME("tda9875"),
-        .id        = -1,
         .driver    = &driver,
 };
 
diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/tea6415c.c linux-2.6.11-rc1/drivers/media/video/tea6415c.c
--- linux-2.6.11-rc1.orig/drivers/media/video/tea6415c.c	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/tea6415c.c	2005-01-16 12:50:29.000000000 +0100
@@ -51,9 +51,6 @@
 static struct i2c_driver driver;
 static struct i2c_client client_template;
 
-/* unique ID allocation */
-static int tea6415c_id = 0;
-
 /* this function is called by i2c_probe */
 static int detect(struct i2c_adapter *adapter, int address, int kind)
 {
@@ -73,7 +70,6 @@
 
 	/* fill client structure */
 	memcpy(client, &client_template, sizeof(struct i2c_client));
-	client->id = tea6415c_id++;
 	client->addr = address;
 	client->adapter = adapter;
 
diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/tea6420.c linux-2.6.11-rc1/drivers/media/video/tea6420.c
--- linux-2.6.11-rc1.orig/drivers/media/video/tea6420.c	2004-12-24 22:34:45.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/tea6420.c	2005-01-16 12:50:29.000000000 +0100
@@ -48,9 +48,6 @@
 static struct i2c_driver driver;
 static struct i2c_client client_template;
 
-/* unique ID allocation */
-static int tea6420_id = 0;
-
 /* make a connection between the input 'i' and the output 'o'
    with gain 'g' for the tea6420-client 'client' (note: i = 6 means 'mute') */
 static int tea6420_switch(struct i2c_client *client, int i, int o, int g)
@@ -111,7 +108,6 @@
 
 	/* fill client structure */
 	memcpy(client, &client_template, sizeof(struct i2c_client));
-	client->id = tea6420_id++;
 	client->addr = address;
 	client->adapter = adapter;
 
diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/tuner-3036.c linux-2.6.11-rc1/drivers/media/video/tuner-3036.c
--- linux-2.6.11-rc1.orig/drivers/media/video/tuner-3036.c	2005-01-14 18:36:52.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/tuner-3036.c	2005-01-16 12:50:29.000000000 +0100
@@ -192,7 +192,6 @@
 
 static struct i2c_client client_template =
 {
-        .id 		= -1,
         .driver		= &i2c_driver_tuner,
 	.name		= "SAB3036",
 };
diff -ruN linux-2.6.11-rc1.orig/drivers/media/video/vpx3220.c linux-2.6.11-rc1/drivers/media/video/vpx3220.c
--- linux-2.6.11-rc1.orig/drivers/media/video/vpx3220.c	2005-01-14 18:36:52.000000000 +0100
+++ linux-2.6.11-rc1/drivers/media/video/vpx3220.c	2005-01-16 12:50:29.000000000 +0100
@@ -587,7 +587,6 @@
 	.force			= force
 };
 
-static int vpx3220_i2c_id = 0;
 static struct i2c_driver vpx3220_i2c_driver;
 
 static int
@@ -634,7 +633,6 @@
 	client->adapter = adapter;
 	client->driver = &vpx3220_i2c_driver;
 	client->flags = I2C_CLIENT_ALLOW_USE;
-	client->id = vpx3220_i2c_id++;
 
 	/* Check for manufacture ID and part number */
 	if (kind < 0) {
@@ -655,16 +653,16 @@
 		    vpx3220_read(client, 0x01);
 		switch (pn) {
 		case 0x4680:
-			snprintf(I2C_NAME(client), sizeof(I2C_NAME(client)) - 1,
-				 "vpx3220a[%d]", client->id);
+			strlcpy(I2C_NAME(client), "vpx3220a",
+				sizeof(I2C_NAME(client)));
 			break;
 		case 0x4260:
-			snprintf(I2C_NAME(client), sizeof(I2C_NAME(client)) - 1,
-				 "vpx3216b[%d]", client->id);
+			strlcpy(I2C_NAME(client), "vpx3216b",
+				sizeof(I2C_NAME(client)));
 			break;
 		case 0x4280:
-			snprintf(I2C_NAME(client), sizeof(I2C_NAME(client)) - 1,
-				 "vpx3214c[%d]", client->id);
+			strlcpy(I2C_NAME(client), "vpx3214c",
+				sizeof(I2C_NAME(client)));
 			break;
 		default:
 			dprintk(1,
@@ -675,9 +673,8 @@
 			return 0;
 		}
 	} else {
-		snprintf(I2C_NAME(client), sizeof(I2C_NAME(client)) - 1,
-			 "forced vpx32xx[%d]",
-		client->id);
+		strlcpy(I2C_NAME(client), "forced vpx32xx",
+			sizeof(I2C_NAME(client)));
 	}
 
 	decoder = kmalloc(sizeof(struct vpx3220), GFP_KERNEL);


-- 
Jean Delvare
http://khali.linux-fr.org/
