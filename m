Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263274AbVCEFqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbVCEFqm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 00:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbVCDXHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:07:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:36002 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263181AbVCDUyy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:54 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Kill i2c_client.id (2/5)
In-Reply-To: <11099685933551@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:33 -0800
Message-Id: <11099685932577@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2084, 2005/03/02 11:52:15-08:00, khali@linux-fr.org

[PATCH] I2C: Kill i2c_client.id (2/5)

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
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/media/video/adv7170.c                  |    5 +----
 drivers/media/video/adv7175.c                  |    5 +----
 drivers/media/video/bt819.c                    |   11 +++--------
 drivers/media/video/bt856.c                    |    5 +----
 drivers/media/video/bttv-i2c.c                 |    1 -
 drivers/media/video/cx88/cx88-i2c.c            |    1 -
 drivers/media/video/ovcamchip/ovcamchip_core.c |    1 -
 drivers/media/video/saa5246a.c                 |    1 -
 drivers/media/video/saa5249.c                  |    1 -
 drivers/media/video/saa7110.c                  |    5 +----
 drivers/media/video/saa7111.c                  |    5 +----
 drivers/media/video/saa7114.c                  |    5 +----
 drivers/media/video/saa7134/saa7134-i2c.c      |    1 -
 drivers/media/video/saa7185.c                  |    5 +----
 drivers/media/video/tda7432.c                  |    1 -
 drivers/media/video/tda9840.c                  |    4 ----
 drivers/media/video/tda9875.c                  |    1 -
 drivers/media/video/tea6415c.c                 |    4 ----
 drivers/media/video/tea6420.c                  |    4 ----
 drivers/media/video/tuner-3036.c               |    1 -
 drivers/media/video/vpx3220.c                  |   19 ++++++++-----------
 21 files changed, 18 insertions(+), 68 deletions(-)


diff -Nru a/drivers/media/video/adv7170.c b/drivers/media/video/adv7170.c
--- a/drivers/media/video/adv7170.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/adv7170.c	2005-03-04 12:26:18 -08:00
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
diff -Nru a/drivers/media/video/adv7175.c b/drivers/media/video/adv7175.c
--- a/drivers/media/video/adv7175.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/adv7175.c	2005-03-04 12:26:18 -08:00
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
diff -Nru a/drivers/media/video/bt819.c b/drivers/media/video/bt819.c
--- a/drivers/media/video/bt819.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/bt819.c	2005-03-04 12:26:18 -08:00
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
diff -Nru a/drivers/media/video/bt856.c b/drivers/media/video/bt856.c
--- a/drivers/media/video/bt856.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/bt856.c	2005-03-04 12:26:18 -08:00
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
diff -Nru a/drivers/media/video/bttv-i2c.c b/drivers/media/video/bttv-i2c.c
--- a/drivers/media/video/bttv-i2c.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/bttv-i2c.c	2005-03-04 12:26:18 -08:00
@@ -330,7 +330,6 @@
 
 static struct i2c_client bttv_i2c_client_template = {
 	I2C_DEVNAME("bttv internal"),
-        .id       = -1,
 };
 
 
diff -Nru a/drivers/media/video/cx88/cx88-i2c.c b/drivers/media/video/cx88/cx88-i2c.c
--- a/drivers/media/video/cx88/cx88-i2c.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/cx88/cx88-i2c.c	2005-03-04 12:26:18 -08:00
@@ -141,7 +141,6 @@
 
 static struct i2c_client cx8800_i2c_client_template = {
         I2C_DEVNAME("cx88xx internal"),
-        .id   = -1,
 };
 
 static char *i2c_devs[128] = {
diff -Nru a/drivers/media/video/ovcamchip/ovcamchip_core.c b/drivers/media/video/ovcamchip/ovcamchip_core.c
--- a/drivers/media/video/ovcamchip/ovcamchip_core.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/ovcamchip/ovcamchip_core.c	2005-03-04 12:26:18 -08:00
@@ -422,7 +422,6 @@
 
 static struct i2c_client client_template = {
 	I2C_DEVNAME("(unset)"),
-	.id =		-1,
 	.driver =	&driver,
 };
 
diff -Nru a/drivers/media/video/saa5246a.c b/drivers/media/video/saa5246a.c
--- a/drivers/media/video/saa5246a.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/saa5246a.c	2005-03-04 12:26:18 -08:00
@@ -185,7 +185,6 @@
 };
 
 static struct i2c_client client_template = {
-	.id 		= -1,
 	.driver		= &i2c_driver_videotext,
 	.name		= "(unset)",
 };
diff -Nru a/drivers/media/video/saa5249.c b/drivers/media/video/saa5249.c
--- a/drivers/media/video/saa5249.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/saa5249.c	2005-03-04 12:26:18 -08:00
@@ -258,7 +258,6 @@
 };
 
 static struct i2c_client client_template = {
-	.id 		= -1,
 	.driver		= &i2c_driver_videotext,
 	.name		= "(unset)",
 };
diff -Nru a/drivers/media/video/saa7110.c b/drivers/media/video/saa7110.c
--- a/drivers/media/video/saa7110.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/saa7110.c	2005-03-04 12:26:18 -08:00
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
diff -Nru a/drivers/media/video/saa7111.c b/drivers/media/video/saa7111.c
--- a/drivers/media/video/saa7111.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/saa7111.c	2005-03-04 12:26:18 -08:00
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
diff -Nru a/drivers/media/video/saa7114.c b/drivers/media/video/saa7114.c
--- a/drivers/media/video/saa7114.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/saa7114.c	2005-03-04 12:26:18 -08:00
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
diff -Nru a/drivers/media/video/saa7134/saa7134-i2c.c b/drivers/media/video/saa7134/saa7134-i2c.c
--- a/drivers/media/video/saa7134/saa7134-i2c.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/saa7134/saa7134-i2c.c	2005-03-04 12:26:18 -08:00
@@ -362,7 +362,6 @@
 
 static struct i2c_client saa7134_client_template = {
 	I2C_DEVNAME("saa7134 internal"),
-        .id        = -1,
 };
 
 /* ----------------------------------------------------------- */
diff -Nru a/drivers/media/video/saa7185.c b/drivers/media/video/saa7185.c
--- a/drivers/media/video/saa7185.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/saa7185.c	2005-03-04 12:26:18 -08:00
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
diff -Nru a/drivers/media/video/tda7432.c b/drivers/media/video/tda7432.c
--- a/drivers/media/video/tda7432.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/tda7432.c	2005-03-04 12:26:18 -08:00
@@ -528,7 +528,6 @@
 static struct i2c_client client_template =
 {
 	I2C_DEVNAME("tda7432"),
-        .id         = -1,
 	.driver     = &driver,
 };
 
diff -Nru a/drivers/media/video/tda9840.c b/drivers/media/video/tda9840.c
--- a/drivers/media/video/tda9840.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/tda9840.c	2005-03-04 12:26:18 -08:00
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
 
diff -Nru a/drivers/media/video/tda9875.c b/drivers/media/video/tda9875.c
--- a/drivers/media/video/tda9875.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/tda9875.c	2005-03-04 12:26:18 -08:00
@@ -399,7 +399,6 @@
 static struct i2c_client client_template =
 {
         I2C_DEVNAME("tda9875"),
-        .id        = -1,
         .driver    = &driver,
 };
 
diff -Nru a/drivers/media/video/tea6415c.c b/drivers/media/video/tea6415c.c
--- a/drivers/media/video/tea6415c.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/tea6415c.c	2005-03-04 12:26:18 -08:00
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
 
diff -Nru a/drivers/media/video/tea6420.c b/drivers/media/video/tea6420.c
--- a/drivers/media/video/tea6420.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/tea6420.c	2005-03-04 12:26:18 -08:00
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
 
diff -Nru a/drivers/media/video/tuner-3036.c b/drivers/media/video/tuner-3036.c
--- a/drivers/media/video/tuner-3036.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/tuner-3036.c	2005-03-04 12:26:18 -08:00
@@ -192,7 +192,6 @@
 
 static struct i2c_client client_template =
 {
-        .id 		= -1,
         .driver		= &i2c_driver_tuner,
 	.name		= "SAB3036",
 };
diff -Nru a/drivers/media/video/vpx3220.c b/drivers/media/video/vpx3220.c
--- a/drivers/media/video/vpx3220.c	2005-03-04 12:26:18 -08:00
+++ b/drivers/media/video/vpx3220.c	2005-03-04 12:26:18 -08:00
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

