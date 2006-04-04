Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWDDSg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWDDSg1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 14:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWDDSg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 14:36:27 -0400
Received: from smtp1.home.se ([212.78.199.21]:30317 "EHLO smtp1.home.se")
	by vger.kernel.org with ESMTP id S1750792AbWDDSg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 14:36:26 -0400
Date: Tue, 4 Apr 2006 20:32:19 +0200
From: Martin Samuelsson <sam@home.se>
To: Adrian Bunk <bunk@stusta.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, mchehab@infradead.org,
       js@linuxtv.org, v4l-dvb-maintainer@linuxtv.org
Subject: Re: [-mm patch] drivers/media/video/bt866.c: small fixes
Message-Id: <20060404203219.40fe6b4c.sam@home.se>
In-Reply-To: <20060404163001.GO6529@stusta.de>
References: <20060404014504.564bf45a.akpm@osdl.org>
	<20060404163001.GO6529@stusta.de>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An extension to Adrian's patch:
- Numerous coding style compliance fixes.
- Obscure defines moved to prominent places.
- sizeof(init) replaced by ARRAY_SIZE(init).
- schedule_timeout() replaced by schedule_timeout_interruptible().

Signed-off-by: Martin Samuelsson <sam@home.se>

---

 bt866.c |   67 +++++++++++++++++++++++++++-------------------------------------
 1 files changed, 29 insertions(+), 38 deletions(-)

This should fix all things Andrew pointed out when I first submitted the 
avs6eyes driver.

--- linux-2.6.17-rc1-mm1-ab-avs6eyes/drivers/media/video/bt866.c	2006-04-04 22:13:01.000000000 +0200
+++ linux-2.6.16-git15-avs6eyes/drivers/media/video/bt866.c	2006-04-04 22:00:32.000000000 +0200
@@ -51,9 +51,12 @@
 
 #include <linux/video_encoder.h>
 
+#define	BT866_DEVNAME	"bt866"
+#define I2C_BT866	0x88
+
 MODULE_LICENSE("GPL");
 
-#define DEBUG(x)   		/* Debug driver */
+#define DEBUG(x)		/* Debug driver */
 
 /* ----------------------------------------------------------------------- */
 
@@ -70,8 +73,6 @@ struct bt866 {
 	int sat;
 };
 
-#define   I2C_BT866	0x88
-
 static int bt866_write(struct bt866 *dev,
 			unsigned char subaddr, unsigned char data);
 
@@ -152,9 +153,8 @@ static int bt866_do_command(struct bt866
 		int i;
 		u8 val;
 
-		for (i = 0; i < sizeof(init) / 2; i += 2) {
+		for (i = 0; i < ARRAY_SIZE(init) / 2; i += 2)
 			bt866_write(encoder, init[i], init[i+1]);
-		}
 
 		val = encoder->reg[0xdc];
 
@@ -162,7 +162,6 @@ static int bt866_do_command(struct bt866
 			val |= 0x40; /* CBSWAP */
 		else
 			val &= ~0x40; /* !CBSWAP */
-		//debug printk("0xdc = 0x%02x\n", val);
 
 		bt866_write(encoder, 0xdc, val);
 
@@ -196,9 +195,8 @@ static int bt866_do_command(struct bt866
 			     encoder->i2c->name, *iarg));
 
 		/* not much choice of outputs */
-		if (*iarg != 0) {
+		if (*iarg != 0)
 			return -EINVAL;
-		}
 	}
 	break;
 
@@ -236,8 +234,6 @@ static int bt866_do_command(struct bt866
 	return 0;
 }
 
-#define	BT866_DEVNAME "bt866"
-
 static int bt866_write(struct bt866 *encoder,
 			unsigned char subaddr, unsigned char data)
 {
@@ -250,19 +246,20 @@ static int bt866_write(struct bt866 *enc
 	encoder->reg[subaddr] = data;
 
 	DEBUG(printk
-	      ( "%s: write 0x%02X = 0x%02X\n",
+	      ("%s: write 0x%02X = 0x%02X\n",
 	       encoder->i2c->name, subaddr, data));
 
 	for (err = 0; err < 3;) {
-		if (2 == i2c_master_send(encoder->i2c, buffer, 2))
+		if (i2c_master_send(encoder->i2c, buffer, 2) == 2)
 			break;
 		err++;
-		printk(KERN_WARNING "%s: I/O error #%d (write 0x%02x/0x%02x)\n",
+		printk(KERN_WARNING "%s: I/O error #%d "
+		       "(write 0x%02x/0x%02x)\n",
 		       encoder->i2c->name, err, encoder->addr, subaddr);
 		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(HZ/10);
+		schedule_timeout_interruptible(HZ/10);
 	}
-	if (3 == err) {
+	if (err == 3) {
 		printk(KERN_WARNING "%s: giving up\n",
 		       encoder->i2c->name);
 		return -1;
@@ -273,13 +270,14 @@ static int bt866_write(struct bt866 *enc
 
 static int bt866_attach(struct i2c_adapter *adapter);
 static int bt866_detach(struct i2c_client *client);
-static int bt866_command(struct i2c_client *client, unsigned int cmd, void *arg );
+static int bt866_command(struct i2c_client *client,
+			 unsigned int cmd, void *arg);
 
 
 /* Addresses to scan */
-static unsigned short normal_i2c[]	=	{ I2C_BT866>>1, I2C_CLIENT_END };
-static unsigned short probe[2]		= 	{ I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2]		=	{ I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short normal_i2c[]	= {I2C_BT866>>1, I2C_CLIENT_END};
+static unsigned short probe[2]		= {I2C_CLIENT_END, I2C_CLIENT_END};
+static unsigned short ignore[2]		= {I2C_CLIENT_END, I2C_CLIENT_END};
 
 static struct i2c_client_address_data addr_data = {
 	normal_i2c,
@@ -288,12 +286,8 @@ static struct i2c_client_address_data ad
 };
 
 static struct i2c_driver i2c_driver_bt866 = {
-	.driver = {
-		.name = BT866_DEVNAME,
-	},
-
+	.driver.name = BT866_DEVNAME,
 	.id = I2C_DRIVERID_BT866,
-
 	.attach_adapter = bt866_attach,
 	.detach_client = bt866_detach,
 	.command = bt866_command
@@ -302,11 +296,11 @@ static struct i2c_driver i2c_driver_bt86
 
 static struct i2c_client bt866_client_tmpl =
 {
-	name:		"(nil)",
-	addr:		0,
-	adapter:	NULL,
-	driver:		&i2c_driver_bt866,
-	usage_count:	0
+	.name = "(nil)",
+	.addr = 0,
+	.adapter = NULL,
+	.driver = &i2c_driver_bt866,
+	.usage_count = 0
 };
 
 static int bt866_found_proc(struct i2c_adapter *adapter,
@@ -316,13 +310,13 @@ static int bt866_found_proc(struct i2c_a
 	struct i2c_client *client;
 
 	client = kzalloc(sizeof(*client), GFP_KERNEL);
-	if(client == NULL)
+	if (client == NULL)
 		return -ENOMEM;
-	memcpy( client, &bt866_client_tmpl, sizeof(*client) );
+	memcpy(client, &bt866_client_tmpl, sizeof(*client));
 
-	encoder = kzalloc( sizeof(*encoder), GFP_KERNEL );
-	if( encoder == NULL ) {
-		kfree( client );
+	encoder = kzalloc(sizeof(*encoder), GFP_KERNEL);
+	if (encoder == NULL) {
+		kfree(client);
 		return -ENOMEM;
 	}
 
@@ -344,7 +338,7 @@ static int bt866_found_proc(struct i2c_a
 
 static int bt866_attach(struct i2c_adapter *adapter)
 {
-	if ( adapter->id == I2C_HW_B_ZR36067 )
+	if (adapter->id == I2C_HW_B_ZR36067)
 		return i2c_probe(adapter, &addr_data, bt866_found_proc);
 	return 0;
 }
@@ -367,9 +361,6 @@ static int bt866_command(struct i2c_clie
 	return bt866_do_command(encoder, cmd, arg);
 }
 
-/****************************************************************************
-* linux kernel module api
-****************************************************************************/
 static int __devinit bt866_init(void)
 {
 	i2c_add_driver(&i2c_driver_bt866);
