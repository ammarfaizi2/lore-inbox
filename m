Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261320AbTCYB21>; Mon, 24 Mar 2003 20:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbTCYB21>; Mon, 24 Mar 2003 20:28:27 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:9744 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261320AbTCYB2A>;
	Mon, 24 Mar 2003 20:28:00 -0500
Subject: [PATCH] i2c driver changes for 2.5.66
In-reply-to: <20030325013531.GA11158@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Mar 2003 17:38 -0800
X-mailer: gregkh_patchbomb
Message-id: <10485563141404@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.889.355.14, 2003/03/22 23:20:40-08:00, greg@kroah.com

i2c: fix up drivers/media/video/* due to previous i2c changes.


 drivers/media/video/adv7175.c             |   22 ++++++++-------
 drivers/media/video/bt819.c               |   33 ++++++++++++----------
 drivers/media/video/bt856.c               |   27 ++++++++++--------
 drivers/media/video/bttv-if.c             |   22 ++++++++-------
 drivers/media/video/msp3400.c             |   32 +++++++++++----------
 drivers/media/video/saa5249.c             |   13 +++++---
 drivers/media/video/saa7110.c             |   19 +++++++-----
 drivers/media/video/saa7111.c             |   21 ++++++++------
 drivers/media/video/saa7134/saa7134-i2c.c |   10 ++++--
 drivers/media/video/saa7185.c             |   19 +++++++-----
 drivers/media/video/tda7432.c             |   16 ++++++----
 drivers/media/video/tda9875.c             |   16 ++++++----
 drivers/media/video/tda9887.c             |   14 +++++----
 drivers/media/video/tuner-3036.c          |    6 ++--
 drivers/media/video/tuner.c               |   29 ++++++++++---------
 drivers/media/video/tvaudio.c             |   44 +++++++++++++++---------------
 16 files changed, 194 insertions(+), 149 deletions(-)


diff -Nru a/drivers/media/video/adv7175.c b/drivers/media/video/adv7175.c
--- a/drivers/media/video/adv7175.c	Mon Mar 24 17:27:34 2003
+++ b/drivers/media/video/adv7175.c	Mon Mar 24 17:27:34 2003
@@ -170,6 +170,7 @@
 	client=kmalloc(sizeof(*client), GFP_KERNEL);
 	if(client == NULL)
 		return -ENOMEM;
+	memset(client, 0, sizeof(*client));
 
 	client_template.adapter = adap;
 	client_template.addr = addr;
@@ -190,9 +191,10 @@
 		// We should never get here!!!
 		dname = unknown_name;
 	}
-	strcpy(client->name, dname);
+	strncpy(client->dev.name, dname, DEVICE_NAME_SIZE);
 	init_MUTEX(&encoder->lock);
 	encoder->client = client;
+	i2c_set_clientdata(client, encoder);
 	encoder->addr = addr;
 	encoder->norm = VIDEO_MODE_PAL;
 	encoder->input = 0;
@@ -201,7 +203,7 @@
 	for (i=1; i<x_common; i++) {
 		rv = i2c_smbus_write_byte(client,init_common[i]);
 		if (rv < 0) {
-			printk(KERN_ERR "%s_attach: init error %d\n", client->name, rv);
+			printk(KERN_ERR "%s_attach: init error %d\n", client->dev.name, rv);
 			break;
 		}
 	}
@@ -211,7 +213,7 @@
 		i2c_smbus_write_byte_data(client,0x07, TR0MODE);
 		i2c_smbus_read_byte_data(client,0x12);
 		printk(KERN_INFO "%s_attach: %s rev. %d at 0x%02x\n",
-		       client->name, dname, rv & 1, client->addr);
+		       client->dev.name, dname, rv & 1, client->addr);
 	}
 
 	i2c_attach_client(client);
@@ -229,7 +231,7 @@
 static int adv717x_detach(struct i2c_client *client)
 {
 	i2c_detach_client(client);
-	kfree(client->data);
+	i2c_get_clientdata(client);
 	kfree(client);
 	return 0;
 }
@@ -237,7 +239,7 @@
 static int adv717x_command(struct i2c_client *client, unsigned int cmd,
 			   void *arg)
 {
-	struct adv7175 *encoder = client->data;
+	struct adv7175 *encoder = i2c_get_clientdata(client);
 	int i, x_ntsc=13, x_pal=13; 
 		/* x_ntsc is number of entries in init_ntsc -1 */
 		/* x_pal is number of entries in init_pal -1 */
@@ -297,7 +299,7 @@
 				default:
 					printk(KERN_ERR
 					       "%s: illegal norm: %d\n",
-					       client->name, iarg);
+					       client->dev.name, iarg);
 					return -EINVAL;
 
 				}
@@ -353,7 +355,7 @@
 				default:
 					printk(KERN_ERR
 					       "%s: illegal input: %d\n",
-					       client->name, iarg);
+					       client->dev.name, iarg);
 					return -EINVAL;
 
 				}
@@ -419,8 +421,10 @@
 };
 
 static struct i2c_client client_template = {
-	.name		= "adv7175_client",
-	.driver		= &i2c_driver_adv7175
+	.driver		= &i2c_driver_adv7175,
+	.dev		= {
+		.name	= "adv7175_client",
+	},
 };
 
 static int adv717x_init(void)
diff -Nru a/drivers/media/video/bt819.c b/drivers/media/video/bt819.c
--- a/drivers/media/video/bt819.c	Mon Mar 24 17:27:34 2003
+++ b/drivers/media/video/bt819.c	Mon Mar 24 17:27:34 2003
@@ -128,7 +128,7 @@
 
 	struct timing *timing;
 
-	decoder = client->data;
+	decoder = i2c_get_clientdata(client);
 	timing = &timing_data[decoder->norm];
 
 	init[3 * 2 - 1] = (((timing->vdelay >> 8) & 0x03) << 6) |
@@ -159,6 +159,7 @@
 	client = kmalloc(sizeof(*client), GFP_KERNEL);
 	if(client == NULL)
 		return -ENOMEM;
+	memset(client, 0, sizeof(*client));
 	client_template.adapter = adap;
 	client_template.addr = addr;
 	memcpy(client, &client_template, sizeof(*client));
@@ -170,8 +171,8 @@
 	}
 
 	memset(decoder, 0, sizeof(struct bt819));
-	strcpy(client->name, "bt819");
-	client->data = decoder;
+	strncpy(client->dev.name, "bt819", DEVICE_NAME_SIZE);
+	i2c_set_clientdata(client, decoder);
 	decoder->client = client;
 	decoder->addr = addr;
 	decoder->norm = VIDEO_MODE_NTSC;
@@ -186,10 +187,10 @@
 	i = bt819_init(client);
 	if (i < 0) {
 		printk(KERN_ERR "%s: bt819_attach: init status %d\n",
-		       decoder->client->name, i);
+		       decoder->client->dev.name, i);
 	} else {
 		printk(KERN_INFO "%s: bt819_attach: chip version %x\n",
-		       decoder->client->name, i2c_smbus_read_byte_data(client,
+		       decoder->client->dev.name, i2c_smbus_read_byte_data(client,
 						      0x17) & 0x0f);
 	}
 	init_MUTEX(&decoder->lock);
@@ -205,7 +206,7 @@
 static int bt819_detach(struct i2c_client *client)
 {
 	i2c_detach_client(client);
-	kfree(client->data);
+	i2c_get_clientdata(client);
 	kfree(client);
 	MOD_DEC_USE_COUNT;
 	return 0;
@@ -215,7 +216,7 @@
 {
 	int temp;
 
-	struct bt819 *decoder = client->data;
+	struct bt819 *decoder = i2c_get_clientdata(client);
 	//return 0;
 
 	if (!decoder->initialized) {	// First call to bt819_init could be
@@ -268,7 +269,7 @@
 			*iarg = res;
 
 			DEBUG(printk(KERN_INFO "%s-bt819: get status %x\n",
-				     decoder->client->name, *iarg));
+				     decoder->client->dev.name, *iarg));
 		}
 		break;
 
@@ -278,7 +279,7 @@
 			struct timing *timing;
 
 			DEBUG(printk(KERN_INFO "%s-bt819: set norm %x\n",
-				     decoder->client->name, *iarg));
+				     decoder->client->dev.name, *iarg));
 
 			if (*iarg == VIDEO_MODE_NTSC) {
 				bt819_setbit(decoder, 0x01, 0, 1);
@@ -319,7 +320,7 @@
 			int *iarg = arg;
 
 			DEBUG(printk(KERN_INFO "%s-bt819: set input %x\n",
-				     decoder->client->name, *iarg));
+				     decoder->client->dev.name, *iarg));
 
 			if (*iarg < 0 || *iarg > 7) {
 				return -EINVAL;
@@ -344,7 +345,7 @@
 			int *iarg = arg;
 
 			DEBUG(printk(KERN_INFO "%s-bt819: set output %x\n",
-				     decoder->client->name, *iarg));
+				     decoder->client->dev.name, *iarg));
 
 			/* not much choice of outputs */
 			if (*iarg != 0) {
@@ -360,7 +361,7 @@
 
 			DEBUG(printk
 			      (KERN_INFO "%s-bt819: enable output %x\n",
-			       decoder->client->name, *iarg));
+			       decoder->client->dev.name, *iarg));
 
 			if (decoder->enable != enable) {
 				decoder->enable = enable;
@@ -381,7 +382,7 @@
 			DEBUG(printk
 			      (KERN_INFO
 			       "%s-bt819: set picture brightness %d contrast %d colour %d\n",
-			       decoder->client->name, pic->brightness,
+			       decoder->client->dev.name, pic->brightness,
 			       pic->contrast, pic->colour));
 
 
@@ -448,9 +449,11 @@
 };
 
 static struct i2c_client client_template = {
-	.name = "bt819_client",
 	.id = -1,
-	.driver = &i2c_driver_bt819
+	.driver = &i2c_driver_bt819,
+	.dev = {
+		.name = "bt819_client",
+	},
 };
 
 static int bt819_setup(void)
diff -Nru a/drivers/media/video/bt856.c b/drivers/media/video/bt856.c
--- a/drivers/media/video/bt856.c	Mon Mar 24 17:27:34 2003
+++ b/drivers/media/video/bt856.c	Mon Mar 24 17:27:34 2003
@@ -106,6 +106,7 @@
 	client = kmalloc(sizeof(*client), GFP_KERNEL);
 	if(client == NULL)
 		return -ENOMEM;
+	memset(client, 0, sizeof(*client));
 	client_template.adapter = adap;
 	client_template.addr = addr;
 	memcpy(client, &client_template, sizeof(*client));	
@@ -123,14 +124,14 @@
 
 
 	memset(encoder, 0, sizeof(struct bt856));
-	strcpy(client->name, "bt856");
+	strncpy(client->dev.name, "bt856", DEVICE_NAME_SIZE);
 	encoder->client = client;
-	client->data = encoder;
+	i2c_set_clientdata(client, encoder);
 	encoder->addr = client->addr;
 	encoder->norm = VIDEO_MODE_NTSC;
 	encoder->enable = 1;
 
-	DEBUG(printk(KERN_INFO "%s-bt856: attach\n", encoder->client->name));
+	DEBUG(printk(KERN_INFO "%s-bt856: attach\n", encoder->client->dev.name));
 
 	i2c_smbus_write_byte_data(client, 0xdc, 0x18);
 	encoder->reg[0xdc] = 0x18;
@@ -171,7 +172,7 @@
 static int bt856_detach(struct i2c_client *client)
 {
 	i2c_detach_client(client);
-	kfree(client->data);
+	i2c_get_clientdata(client);
 	kfree(client);
 	MOD_DEC_USE_COUNT;
 	return 0;
@@ -180,7 +181,7 @@
 static int bt856_command(struct i2c_client *client, unsigned int cmd,
 			 void *arg)
 {
-	struct bt856 *encoder = client->data;
+	struct bt856 *encoder = i2c_get_clientdata(client);
 
 	switch (cmd) {
 
@@ -190,7 +191,7 @@
 
 			DEBUG(printk
 			      (KERN_INFO "%s-bt856: get capabilities\n",
-			       encoder->client->name));
+			       encoder->client->dev.name));
 
 			cap->flags
 			    = VIDEO_ENCODER_PAL
@@ -205,7 +206,7 @@
 			int *iarg = arg;
 
 			DEBUG(printk(KERN_INFO "%s-bt856: set norm %d\n",
-				     encoder->client->name, *iarg));
+				     encoder->client->dev.name, *iarg));
 
 			switch (*iarg) {
 
@@ -232,7 +233,7 @@
 			int *iarg = arg;
 
 			DEBUG(printk(KERN_INFO "%s-bt856: set input %d\n",
-				     encoder->client->name, *iarg));
+				     encoder->client->dev.name, *iarg));
 
 			/*     We only have video bus.
 			   *iarg = 0: input is from bt819
@@ -268,7 +269,7 @@
 			int *iarg = arg;
 
 			DEBUG(printk(KERN_INFO "%s-bt856: set output %d\n",
-				     encoder->client->name, *iarg));
+				     encoder->client->dev.name, *iarg));
 
 			/* not much choice of outputs */
 			if (*iarg != 0) {
@@ -285,7 +286,7 @@
 
 			DEBUG(printk
 			      (KERN_INFO "%s-bt856: enable output %d\n",
-			       encoder->client->name, encoder->enable));
+			       encoder->client->dev.name, encoder->enable));
 		}
 		break;
 
@@ -309,9 +310,11 @@
 };
 
 static struct i2c_client client_template = {
-	.name = "bt856_client",
 	.id = -1,
-	.driver = &i2c_driver_bt856
+	.driver = &i2c_driver_bt856,
+	.dev = {
+		.name = "bt856_client",
+	},
 };
 
 static int bt856_init(void)
diff -Nru a/drivers/media/video/bttv-if.c b/drivers/media/video/bttv-if.c
--- a/drivers/media/video/bttv-if.c	Mon Mar 24 17:27:34 2003
+++ b/drivers/media/video/bttv-if.c	Mon Mar 24 17:27:34 2003
@@ -194,7 +194,7 @@
 
 static int attach_inform(struct i2c_client *client)
 {
-        struct bttv *btv = (struct bttv*)client->adapter->data;
+        struct bttv *btv = i2c_get_adapdata(client->adapter);
 	int i;
 
 	for (i = 0; i < I2C_CLIENTS_MAX; i++) {
@@ -207,13 +207,13 @@
 		bttv_call_i2c_clients(btv,TUNER_SET_TYPE,&btv->tuner_type);
         if (bttv_verbose)
 		printk("bttv%d: i2c attach [client=%s,%s]\n",btv->nr,
-		       client->name, (i < I2C_CLIENTS_MAX) ?  "ok" : "failed");
+		       client->dev.name, (i < I2C_CLIENTS_MAX) ?  "ok" : "failed");
         return 0;
 }
 
 static int detach_inform(struct i2c_client *client)
 {
-        struct bttv *btv = (struct bttv*)client->adapter->data;
+        struct bttv *btv = i2c_get_adapdata(client->adapter);
 	int i;
 
 	for (i = 0; i < I2C_CLIENTS_MAX; i++) {
@@ -224,7 +224,7 @@
 	}
         if (bttv_verbose)
 		printk("bttv%d: i2c detach [client=%s,%s]\n",btv->nr,
-		       client->name, (i < I2C_CLIENTS_MAX) ?  "ok" : "failed");
+		       client->dev.name, (i < I2C_CLIENTS_MAX) ?  "ok" : "failed");
         return 0;
 }
 
@@ -261,15 +261,19 @@
 
 static struct i2c_adapter bttv_i2c_adap_template = {
 	.owner          = THIS_MODULE,
-	.name              = "bt848",
 	.id                = I2C_HW_B_BT848,
 	.client_register   = attach_inform,
 	.client_unregister = detach_inform,
+	.dev		= {
+		.name	= "bt848",
+	},
 };
 
 static struct i2c_client bttv_i2c_client_template = {
-        .name = "bttv internal use only",
-        .id   = -1,
+        .id	= -1,
+        .dev	= {
+		.name = "bttv internal",
+	},
 };
 
 
@@ -343,10 +347,10 @@
 	memcpy(&btv->i2c_client, &bttv_i2c_client_template,
 	       sizeof(struct i2c_client));
 
-	sprintf(btv->i2c_adap.name+strlen(btv->i2c_adap.name),
+	sprintf(btv->i2c_adap.dev.name+strlen(btv->i2c_adap.dev.name),
 		" #%d", btv->nr);
         btv->i2c_algo.data = btv;
-        btv->i2c_adap.data = btv;
+        i2c_set_adapdata(&btv->i2c_adap, btv);
         btv->i2c_adap.algo_data = &btv->i2c_algo;
         btv->i2c_client.adapter = &btv->i2c_adap;
 
diff -Nru a/drivers/media/video/msp3400.c b/drivers/media/video/msp3400.c
--- a/drivers/media/video/msp3400.c	Mon Mar 24 17:27:34 2003
+++ b/drivers/media/video/msp3400.c	Mon Mar 24 17:27:34 2003
@@ -349,7 +349,7 @@
 static void
 msp3400c_set_scart(struct i2c_client *client, int in, int out)
 {
-	struct msp3400c *msp = client->data;
+	struct msp3400c *msp = i2c_get_clientdata(client);
 
 	if (-1 == scarts[out][in])
 		return;
@@ -411,7 +411,7 @@
 
 static void msp3400c_setmode(struct i2c_client *client, int type)
 {
-	struct msp3400c *msp = client->data;
+	struct msp3400c *msp = i2c_get_clientdata(client);
 	int i;
 	
 	dprintk("msp3400: setmode: %d\n",type);
@@ -471,7 +471,7 @@
 {
 	static char *strmode[] = { "0", "mono", "stereo", "3",
 				   "lang1", "5", "6", "7", "lang2" };
-	struct msp3400c *msp = client->data;
+	struct msp3400c *msp = i2c_get_clientdata(client);
 	int nicam=0; /* channel source: FM/AM or nicam */
 	int src=0;
 
@@ -599,7 +599,7 @@
 static void
 msp3400c_restore_dfp(struct i2c_client *client)
 {
-	struct msp3400c *msp = client->data;
+	struct msp3400c *msp = i2c_get_clientdata(client);
 	int i;
 
 	for (i = 0; i < DFP_COUNT; i++) {
@@ -627,7 +627,7 @@
 static int
 autodetect_stereo(struct i2c_client *client)
 {
-	struct msp3400c *msp = client->data;
+	struct msp3400c *msp = i2c_get_clientdata(client);
 	int val;
 	int newstereo = msp->stereo;
 	int newnicam  = msp->nicam_on;
@@ -727,7 +727,7 @@
 /* stereo/multilang monitoring */
 static void watch_stereo(struct i2c_client *client)
 {
-	struct msp3400c *msp = client->data;
+	struct msp3400c *msp = i2c_get_clientdata(client);
 
 	if (autodetect_stereo(client)) {
 		if (msp->stereo & VIDEO_SOUND_STEREO)
@@ -746,7 +746,7 @@
 static int msp3400c_thread(void *data)
 {
 	struct i2c_client *client = data;
-	struct msp3400c *msp = client->data;
+	struct msp3400c *msp = i2c_get_clientdata(client);
 	
 	struct CARRIER_DETECT *cd;
 	int count, max1,max2,val1,val2, val,this;
@@ -1002,7 +1002,7 @@
 static int msp3410d_thread(void *data)
 {
 	struct i2c_client *client = data;
-	struct msp3400c *msp = client->data;
+	struct msp3400c *msp = i2c_get_clientdata(client);
 	int mode,val,i,std;
     
 #ifdef CONFIG_SMP
@@ -1226,9 +1226,11 @@
 
 static struct i2c_client client_template = 
 {
-	.name   = "(unset)",
 	.flags  = I2C_CLIENT_ALLOW_USE,
         .driver = &driver,
+	.dev	= {
+		.name   = "(unset)",
+	},
 };
 
 static int msp_attach(struct i2c_adapter *adap, int addr,
@@ -1265,7 +1267,7 @@
 	for (i = 0; i < DFP_COUNT; i++)
 		msp->dfp_regs[i] = -1;
 
-	c->data = msp;
+	i2c_set_clientdata(c, msp);
 	init_waitqueue_head(&msp->wq);
 
 	if (-1 == msp3400c_reset(c)) {
@@ -1291,7 +1293,7 @@
 #endif
 	msp3400c_setvolume(c,msp->muted,msp->left,msp->right);
 
-	sprintf(c->name,"MSP34%02d%c-%c%d",
+	snprintf(c->dev.name, DEVICE_NAME_SIZE, "MSP34%02d%c-%c%d",
 		(rev2>>8)&0xff, (rev1&0xff)+'@', ((rev1>>8)&0xff)+'@', rev2&0x1f);
 	msp->nicam = (((rev2>>8)&0xff) != 00) ? 1 : 0;
 
@@ -1310,7 +1312,7 @@
 	msp->wake_stereo.data     = (unsigned long)msp;
 
 	/* hello world :-) */
-	printk(KERN_INFO "msp34xx: init: chip=%s",c->name);
+	printk(KERN_INFO "msp34xx: init: chip=%s",c->dev.name);
 	if (msp->nicam)
 		printk(", has NICAM support");
 	printk("\n");
@@ -1340,7 +1342,7 @@
 static int msp_detach(struct i2c_client *client)
 {
 	DECLARE_MUTEX_LOCKED(sem);
-	struct msp3400c *msp  = (struct msp3400c*)client->data;
+	struct msp3400c *msp = i2c_get_clientdata(client);
 	int i;
 	
 	/* shutdown control thread */
@@ -1379,7 +1381,7 @@
 
 static void msp_wake_thread(struct i2c_client *client)
 {
-	struct msp3400c *msp  = (struct msp3400c*)client->data;
+	struct msp3400c *msp = i2c_get_clientdata(client);
 
 	msp3400c_setvolume(client,msp->muted,0,0);
 	msp->watch_stereo=0;
@@ -1391,7 +1393,7 @@
 
 static int msp_command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
-	struct msp3400c *msp  = (struct msp3400c*)client->data;
+	struct msp3400c *msp = i2c_get_clientdata(client);
         __u16           *sarg = arg;
 #if 0
 	int             *iarg = (int*)arg;
diff -Nru a/drivers/media/video/saa5249.c b/drivers/media/video/saa5249.c
--- a/drivers/media/video/saa5249.c	Mon Mar 24 17:27:34 2003
+++ b/drivers/media/video/saa5249.c	Mon Mar 24 17:27:34 2003
@@ -171,20 +171,21 @@
 		return -ENOMEM;
 	}
 	memset(t, 0, sizeof(*t));
-	strcpy(client->name, IF_NAME);
+	strncpy(client->dev.name, IF_NAME, DEVICE_NAME_SIZE);
 	init_MUTEX(&t->lock);
 	
 	/*
 	 *	Now create a video4linux device
 	 */
 	 
-	client->data = vd=(struct video_device *)kmalloc(sizeof(struct video_device), GFP_KERNEL);
+	vd = (struct video_device *)kmalloc(sizeof(struct video_device), GFP_KERNEL);
 	if(vd==NULL)
 	{
 		kfree(t);
 		kfree(client);
 		return -ENOMEM;
 	}
+	i2c_set_clientdata(client, vd);
 	memcpy(vd, &saa_template, sizeof(*vd));
 		
 	for (pgbuf = 0; pgbuf < NUM_DAUS; pgbuf++) 
@@ -234,7 +235,7 @@
 
 static int saa5249_detach(struct i2c_client *client)
 {
-	struct video_device *vd=client->data;
+	struct video_device *vd = i2c_get_clientdata(client);
 	i2c_detach_client(client);
 	video_unregister_device(vd);
 	kfree(vd->priv);
@@ -264,9 +265,11 @@
 };
 
 static struct i2c_client client_template = {
-	.name 		= "(unset)",
 	.id 		= -1,
-	.driver 	= &i2c_driver_videotext
+	.driver		= &i2c_driver_videotext,
+	.dev		= {
+		.name	= "(unset)",
+	},
 };
 
 /*
diff -Nru a/drivers/media/video/saa7110.c b/drivers/media/video/saa7110.c
--- a/drivers/media/video/saa7110.c	Mon Mar 24 17:27:34 2003
+++ b/drivers/media/video/saa7110.c	Mon Mar 24 17:27:34 2003
@@ -163,6 +163,7 @@
 	client=kmalloc(sizeof(*client), GFP_KERNEL);
 	if(client == NULL) 
 		return -ENOMEM;
+	memset(client, 0, sizeof(*client));
 	client_template.adapter = adap;
 	client_template.addr = addr;
 	memcpy(client, &client_template, sizeof(*client));
@@ -175,9 +176,9 @@
 
 	/* clear our private data */
 	memset(decoder, 0, sizeof(*decoder));
-	strcpy(client->name, IF_NAME);
+	strncpy(client->dev.name, IF_NAME, DEVICE_NAME_SIZE);
 	decoder->client = client;
-	client->data = decoder;
+	i2c_set_clientdata(client, decoder);
 	decoder->addr = addr;
 	decoder->norm = VIDEO_MODE_PAL;
 	decoder->input = 0;
@@ -189,7 +190,7 @@
 
 	rv = i2c_master_send(client, initseq, sizeof(initseq));
 	if (rv < 0)
-		printk(KERN_ERR "%s_attach: init status %d\n", client->name, rv);
+		printk(KERN_ERR "%s_attach: init status %d\n", client->dev.name, rv);
 	else {
 		i2c_smbus_write_byte_data(client,0x21,0x16);
 		i2c_smbus_write_byte_data(client,0x0D,0x04);
@@ -213,7 +214,7 @@
 static
 int saa7110_detach(struct i2c_client *client)
 {
-	struct saa7110* decoder = client->data;
+	struct saa7110* decoder = i2c_get_clientdata(client);
 
 	i2c_detach_client(client);
 
@@ -232,7 +233,7 @@
 static
 int saa7110_command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
-	struct saa7110* decoder = client->data;
+	struct saa7110* decoder = i2c_get_clientdata(client);
 	int	v;
 
 	switch (cmd) {
@@ -251,7 +252,7 @@
 
 	 case DECODER_GET_STATUS:
 		{
-			struct saa7110* decoder = client->data;
+			struct saa7110* decoder = i2c_get_clientdata(client);
 			int status;
 			int res = 0;
 
@@ -390,9 +391,11 @@
 	.command 	= saa7110_command
 };
 static struct i2c_client client_template = {
-	.name 		= "saa7110_client",
 	.id 		= -1,
-	.driver 	= &i2c_driver_saa7110
+	.driver 	= &i2c_driver_saa7110,
+	.dev		= {
+		.name	= "saa7110_client",
+	},
 };
 
 static int saa7110_init(void)
diff -Nru a/drivers/media/video/saa7111.c b/drivers/media/video/saa7111.c
--- a/drivers/media/video/saa7111.c	Mon Mar 24 17:27:34 2003
+++ b/drivers/media/video/saa7111.c	Mon Mar 24 17:27:34 2003
@@ -120,6 +120,7 @@
 	client = kmalloc(sizeof(*client), GFP_KERNEL);
 	if(client == NULL) 
 		return -ENOMEM;
+	memset(client, 0, sizeof(*client));
 	client_template.adapter = adap;
 	client_template.addr = addr;
 	memcpy(client, &client_template, sizeof(*client));
@@ -132,9 +133,9 @@
 	}
 
 	memset(decoder, 0, sizeof(*decoder));
-	strcpy(client->name, "saa7111");
+	strncpy(client->dev.name, "saa7111", DEVICE_NAME_SIZE);
 	decoder->client = client;
-	client->data = decoder;
+	i2c_set_clientdata(client, decoder);
 	decoder->addr = addr;
 	decoder->norm = VIDEO_MODE_NTSC;
 	decoder->input = 0;
@@ -147,10 +148,10 @@
 	i = i2c_master_send(client, init, sizeof(init));
 	if (i < 0) {
 		printk(KERN_ERR "%s_attach: init status %d\n",
-		       client->name, i);
+		       client->dev.name, i);
 	} else {
 		printk(KERN_INFO "%s_attach: chip version %x\n",
-		       client->name, i2c_smbus_read_byte_data(client, 0x00) >> 4);
+		       client->dev.name, i2c_smbus_read_byte_data(client, 0x00) >> 4);
 	}
 	init_MUTEX(&decoder->lock);
 	i2c_attach_client(client);
@@ -164,7 +165,7 @@
 
 static int saa7111_detach(struct i2c_client *client)
 {
-	struct saa7111 *decoder = client->data;
+	struct saa7111 *decoder = i2c_get_clientdata(client);
 	i2c_detach_client(client);
 	kfree(decoder);
 	kfree(client);
@@ -175,7 +176,7 @@
 static int saa7111_command(struct i2c_client *client, unsigned int cmd,
 			   void *arg)
 {
-	struct saa7111 *decoder = client->data;
+	struct saa7111 *decoder = i2c_get_clientdata(client);
 
 	switch (cmd) {
 
@@ -187,7 +188,7 @@
 			for (i = 0; i < 32; i += 16) {
 				int j;
 
-				printk("KERN_DEBUG %s: %03x", client->name,
+				printk("KERN_DEBUG %s: %03x", client->dev.name,
 				       i);
 				for (j = 0; j < 16; ++j) {
 					printk(" %02x",
@@ -407,9 +408,11 @@
 };
 
 static struct i2c_client client_template = {
-	.name 	= "saa7111_client",
 	.id 	= -1,
-	.driver = &i2c_driver_saa7111
+	.driver	= &i2c_driver_saa7111,
+	.dev	= {
+		.name	= "saa7111_client",
+	},
 };
 
 static int saa7111_init(void)
diff -Nru a/drivers/media/video/saa7134/saa7134-i2c.c b/drivers/media/video/saa7134/saa7134-i2c.c
--- a/drivers/media/video/saa7134/saa7134-i2c.c	Mon Mar 24 17:27:34 2003
+++ b/drivers/media/video/saa7134/saa7134-i2c.c	Mon Mar 24 17:27:34 2003
@@ -334,15 +334,19 @@
 
 static struct i2c_adapter saa7134_adap_template = {
 	.owner         = THIS_MODULE,
-	.name	       = "saa7134",
 	.id            = I2C_ALGO_SAA7134,
 	.algo          = &saa7134_algo,
 	.client_register = attach_inform,
+	.dev		= {
+		.name	= "saa7134",
+	},
 };
 
 static struct i2c_client saa7134_client_template = {
-        .name = "saa7134 internal",
         .id   = -1,
+	.dev	= {
+		.name	= "saa7134 internal",
+	},
 };
 
 /* ----------------------------------------------------------- */
@@ -410,7 +414,7 @@
 int saa7134_i2c_register(struct saa7134_dev *dev)
 {
 	dev->i2c_adap = saa7134_adap_template;
-	strcpy(dev->i2c_adap.name,dev->name);
+	strncpy(dev->i2c_adap.dev.name, dev->name, DEVICE_NAME_SIZE);
 	dev->i2c_adap.algo_data = dev;
 	i2c_add_adapter(&dev->i2c_adap);
 	
diff -Nru a/drivers/media/video/saa7185.c b/drivers/media/video/saa7185.c
--- a/drivers/media/video/saa7185.c	Mon Mar 24 17:27:34 2003
+++ b/drivers/media/video/saa7185.c	Mon Mar 24 17:27:34 2003
@@ -191,6 +191,7 @@
 	client = kmalloc(sizeof(*client), GFP_KERNEL);
 	if (client == NULL)
 		return -ENOMEM;
+	memset(client, 0, sizeof(*client));
 	client_template.adapter = adap;
 	client_template.addr = addr;
 	memcpy(client, &client_template, sizeof(*client));
@@ -202,9 +203,9 @@
 
 
 	memset(encoder, 0, sizeof(*encoder));
-	strcpy(client->name, "saa7185");
+	strncpy(client->dev.name, "saa7185", DEVICE_NAME_SIZE);
 	encoder->client = client;
-	client->data = encoder;
+	i2c_set_clientdata(client, encoder);
 	encoder->addr = addr;
 	encoder->norm = VIDEO_MODE_NTSC;
 	encoder->enable = 1;
@@ -215,11 +216,11 @@
 					sizeof(init_ntsc));
 	}
 	if (i < 0) {
-		printk(KERN_ERR "%s_attach: init error %d\n", client->name,
+		printk(KERN_ERR "%s_attach: init error %d\n", client->dev.name,
 		       i);
 	} else {
 		printk(KERN_INFO "%s_attach: chip version %d\n",
-		       client->name, i2c_smbus_read_byte(client) >> 5);
+		       client->dev.name, i2c_smbus_read_byte(client) >> 5);
 	}
 	init_MUTEX(&encoder->lock);
 	i2c_attach_client(client);
@@ -233,7 +234,7 @@
 
 static int saa7185_detach(struct i2c_client *client)
 {
-	struct saa7185 *encoder = client->data;
+	struct saa7185 *encoder = i2c_get_clientdata(client);
 	i2c_detach_client(client);
 	i2c_smbus_write_byte_data(client, 0x61, (encoder->reg[0x61]) | 0x40);	/* SW: output off is active */
 	//i2c_smbus_write_byte_data(client, 0x3a, (encoder->reg[0x3a]) | 0x80); /* SW: color bar */
@@ -246,7 +247,7 @@
 static int saa7185_command(struct i2c_client *client, unsigned int cmd,
 			   void *arg)
 {
-	struct saa7185 *encoder = client->data;
+	struct saa7185 *encoder = i2c_get_clientdata(client);
 
 	switch (cmd) {
 
@@ -365,9 +366,11 @@
 };
 
 static struct i2c_client client_template = {
-	.name 	= "saa7185_client",
 	.id 	= -1,
-	.driver = &i2c_driver_saa7185
+	.driver = &i2c_driver_saa7185,
+	.dev	= {
+		.name	= "saa7185_client",
+	},
 };
 
 static int saa7185_init(void)
diff -Nru a/drivers/media/video/tda7432.c b/drivers/media/video/tda7432.c
--- a/drivers/media/video/tda7432.c	Mon Mar 24 17:27:34 2003
+++ b/drivers/media/video/tda7432.c	Mon Mar 24 17:27:34 2003
@@ -260,7 +260,7 @@
 
 static int tda7432_set(struct i2c_client *client)
 {
-	struct tda7432 *t = client->data;
+	struct tda7432 *t = i2c_get_clientdata(client);
 	unsigned char buf[16];
 	d2printk("tda7432: In tda7432_set\n");
 	
@@ -287,7 +287,7 @@
 
 static void do_tda7432_init(struct i2c_client *client)
 {
-	struct tda7432 *t = client->data;
+	struct tda7432 *t = i2c_get_clientdata(client);
 	d2printk("tda7432: In tda7432_init\n");
 
 	t->input  = TDA7432_STEREO_IN |  /* Main (stereo) input   */
@@ -328,11 +328,11 @@
         memcpy(client,&client_template,sizeof(struct i2c_client));
         client->adapter = adap;
         client->addr = addr;
-	client->data = t;
+	i2c_set_clientdata(client, t);
 	
 	do_tda7432_init(client);
 	MOD_INC_USE_COUNT;
-	strcpy(client->name,"TDA7432");
+	strncpy(client->dev.name, "TDA7432", DEVICE_NAME_SIZE);
 	printk(KERN_INFO "tda7432: init\n");
 
 	i2c_attach_client(client);
@@ -348,7 +348,7 @@
 
 static int tda7432_detach(struct i2c_client *client)
 {
-	struct tda7432 *t  = client->data;
+	struct tda7432 *t = i2c_get_clientdata(client);
 
 	do_tda7432_init(client);
 	i2c_detach_client(client);
@@ -361,7 +361,7 @@
 static int tda7432_command(struct i2c_client *client,
 			   unsigned int cmd, void *arg)
 {
-	struct tda7432 *t = client->data;
+	struct tda7432 *t = i2c_get_clientdata(client);
 	d2printk("tda7432: In tda7432_command\n");
 
 	switch (cmd) {
@@ -526,9 +526,11 @@
 
 static struct i2c_client client_template =
 {
-        .name   = "tda7432",
         .id     = -1,
 	.driver = &driver, 
+        .dev	= {
+		.name	= "tda7432",
+	},
 };
 
 static int tda7432_init(void)
diff -Nru a/drivers/media/video/tda9875.c b/drivers/media/video/tda9875.c
--- a/drivers/media/video/tda9875.c	Mon Mar 24 17:27:34 2003
+++ b/drivers/media/video/tda9875.c	Mon Mar 24 17:27:34 2003
@@ -158,7 +158,7 @@
 
 static void tda9875_set(struct i2c_client *client)
 {
-	struct tda9875 *tda = client->data;
+	struct tda9875 *tda = i2c_get_clientdata(client);
 	unsigned char a;
 
 	dprintk(KERN_DEBUG "tda9875_set(%04x,%04x,%04x,%04x)\n",tda->lvol,tda->rvol,tda->bass,tda->treble);
@@ -176,7 +176,7 @@
 
 static void do_tda9875_init(struct i2c_client *client)
 {
-	struct tda9875 *t = client->data;
+	struct tda9875 *t = i2c_get_clientdata(client);
 	dprintk("In tda9875_init\n"); 
 	tda9875_write(client, TDA9875_CFG, 0xd0 ); /*reg de config 0 (reset)*/
     	tda9875_write(client, TDA9875_MSR, 0x03 );    /* Monitor 0b00000XXX*/
@@ -256,7 +256,7 @@
         memcpy(client,&client_template,sizeof(struct i2c_client));
         client->adapter = adap;
         client->addr = addr;
-	client->data = t;
+	i2c_set_clientdata(client, t);
 
 	if(!tda9875_checkit(adap,addr)) {
 		kfree(t);
@@ -265,7 +265,7 @@
 	
 	do_tda9875_init(client);
 	MOD_INC_USE_COUNT;
-	strcpy(client->name,"TDA9875");
+	strncpy(client->dev.name, "TDA9875", DEVICE_NAME_SIZE);
 	printk(KERN_INFO "tda9875: init\n");
 
 	i2c_attach_client(client);
@@ -281,7 +281,7 @@
 
 static int tda9875_detach(struct i2c_client *client)
 {
-	struct tda9875 *t  = client->data;
+	struct tda9875 *t = i2c_get_clientdata(client);
 
 	do_tda9875_init(client);
 	i2c_detach_client(client);
@@ -294,7 +294,7 @@
 static int tda9875_command(struct i2c_client *client,
 				unsigned int cmd, void *arg)
 {
-	struct tda9875 *t = client->data;
+	struct tda9875 *t = i2c_get_clientdata(client);
 
 	dprintk("In tda9875_command...\n"); 
 
@@ -396,9 +396,11 @@
 
 static struct i2c_client client_template =
 {
-        .name    = "tda9875",
         .id      = -1,
         .driver  = &driver,
+        .dev	= {
+		.name	= "tda9875",
+	},
 };
 
 static int tda9875_init(void)
diff -Nru a/drivers/media/video/tda9887.c b/drivers/media/video/tda9887.c
--- a/drivers/media/video/tda9887.c	Mon Mar 24 17:27:34 2003
+++ b/drivers/media/video/tda9887.c	Mon Mar 24 17:27:34 2003
@@ -359,7 +359,7 @@
                 return -ENOMEM;
 	memset(t,0,sizeof(*t));
 	t->client = client_template;
-        t->client.data = t;
+        i2c_set_clientdata(&t->client, t);
 	t->pinnacle_id = -1;
         i2c_attach_client(&t->client);
         
@@ -376,12 +376,12 @@
 	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
 	case I2C_ALGO_SAA7134:
 		printk("tda9887: probing %s i2c adapter [id=0x%x]\n",
-		       adap->name,adap->id);
+		       adap->dev.name,adap->id);
 		rc = i2c_probe(adap, &addr_data, tda9887_attach);
 		break;
 	default:
 		printk("tda9887: ignoring %s i2c adapter [id=0x%x]\n",
-		       adap->name,adap->id);
+		       adap->dev.name,adap->id);
 		rc = 0;
 		/* nothing */
 	}
@@ -390,7 +390,7 @@
 
 static int tda9887_detach(struct i2c_client *client)
 {
-	struct tda9887 *t = (struct tda9887*)client->data;
+	struct tda9887 *t = i2c_get_clientdata(client);
 
 	i2c_detach_client(client);
 	kfree(t);
@@ -401,7 +401,7 @@
 static int
 tda9887_command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
-	struct tda9887 *t = (struct tda9887*)client->data;
+	struct tda9887 *t = i2c_get_clientdata(client);
 
         switch (cmd) {
 
@@ -456,9 +456,11 @@
 };
 static struct i2c_client client_template =
 {
-        .name   = "tda9887",
 	.flags  = I2C_CLIENT_ALLOW_USE,
         .driver = &driver,
+        .dev	= {
+		.name	= "tda9887",
+	},
 };
 
 static int tda9887_init_module(void)
diff -Nru a/drivers/media/video/tuner-3036.c b/drivers/media/video/tuner-3036.c
--- a/drivers/media/video/tuner-3036.c	Mon Mar 24 17:27:34 2003
+++ b/drivers/media/video/tuner-3036.c	Mon Mar 24 17:27:34 2003
@@ -196,9 +196,11 @@
 
 static struct i2c_client client_template =
 {
-        .name 		= "SAB3036",
         .id 		= -1,
-        .driver		= &i2c_driver_tuner
+        .driver		= &i2c_driver_tuner,
+        .dev		= {
+		.name	= "SAB3036",
+	},
 };
 
 int __init
diff -Nru a/drivers/media/video/tuner.c b/drivers/media/video/tuner.c
--- a/drivers/media/video/tuner.c	Mon Mar 24 17:27:34 2003
+++ b/drivers/media/video/tuner.c	Mon Mar 24 17:27:34 2003
@@ -226,7 +226,7 @@
 {
 	unsigned char byte;
 
-	struct tuner *t = (struct tuner*)c->data;
+	struct tuner *t = i2c_get_clientdata(c);
 
         if (t->type == TUNER_MT2032)
 		return 0;
@@ -276,7 +276,7 @@
 {
         unsigned char buf[21];
         int ret,xogc,xok=0;
-	struct tuner *t = (struct tuner*)c->data;
+	struct tuner *t = i2c_get_clientdata(c);
 
         buf[0]=0;
         ret=i2c_master_send(c,buf,1);
@@ -517,7 +517,7 @@
 {
 	unsigned char buf[21];
 	int lint_try,ret,sel,lock=0;
-	struct tuner *t = (struct tuner*)c->data;
+	struct tuner *t = i2c_get_clientdata(c);
 
 	dprintk("mt2032_set_if_freq rfin=%d if1=%d if2=%d from=%d to=%d\n",rfin,if1,if2,from,to);
 
@@ -594,7 +594,7 @@
 	u8 config;
 	u16 div;
 	struct tunertype *tun;
-	struct tuner *t = c->data;
+	struct tuner *t = i2c_get_clientdata(c);
         unsigned char buffer[4];
 	int rc;
 
@@ -733,7 +733,7 @@
 static void set_radio_freq(struct i2c_client *c, int freq)
 {
 	struct tunertype *tun;
-	struct tuner *t = (struct tuner*)c->data;
+	struct tuner *t = i2c_get_clientdata(c);
         unsigned char buffer[4];
 	int rc,div;
 
@@ -794,16 +794,17 @@
         if (NULL == (client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL)))
                 return -ENOMEM;
         memcpy(client,&client_template,sizeof(struct i2c_client));
-        client->data = t = kmalloc(sizeof(struct tuner),GFP_KERNEL);
+        t = kmalloc(sizeof(struct tuner),GFP_KERNEL);
         if (NULL == t) {
                 kfree(client);
                 return -ENOMEM;
         }
+	i2c_set_clientdata(client, t);
         memset(t,0,sizeof(struct tuner));
 	if (type >= 0 && type < TUNERS) {
 		t->type = type;
 		printk("tuner(bttv): type forced to %d (%s) [insmod]\n",t->type,tuners[t->type].name);
-		strncpy(client->name, tuners[t->type].name, sizeof(client->name));
+		strncpy(client->dev.name, tuners[t->type].name, DEVICE_NAME_SIZE);
 	} else {
 		t->type = -1;
 	}
@@ -830,12 +831,12 @@
 	case I2C_ALGO_SAA7134:
 	case I2C_ALGO_SAA7146:
 		printk("tuner: probing %s i2c adapter [id=0x%x]\n",
-		       adap->name,adap->id);
+		       adap->dev.name,adap->id);
 		rc = i2c_probe(adap, &addr_data, tuner_attach);
 		break;
 	default:
 		printk("tuner: ignoring %s i2c adapter [id=0x%x]\n",
-		       adap->name,adap->id);
+		       adap->dev.name,adap->id);
 		rc = 0;
 		/* nothing */
 	}
@@ -844,7 +845,7 @@
 
 static int tuner_detach(struct i2c_client *client)
 {
-	struct tuner *t = (struct tuner*)client->data;
+	struct tuner *t = i2c_get_clientdata(client);
 
 	i2c_detach_client(client);
 	kfree(t);
@@ -856,7 +857,7 @@
 static int
 tuner_command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
-	struct tuner *t = (struct tuner*)client->data;
+	struct tuner *t = i2c_get_clientdata(client);
         int   *iarg = (int*)arg;
 #if 0
         __u16 *sarg = (__u16*)arg;
@@ -875,7 +876,7 @@
 		t->type = *iarg;
 		printk("tuner: type set to %d (%s)\n",
                         t->type,tuners[t->type].name);
-		strncpy(client->name, tuners[t->type].name, sizeof(client->name));
+		strncpy(client->dev.name, tuners[t->type].name, DEVICE_NAME_SIZE);
 		if (t->type == TUNER_MT2032)
                         mt2032_init(client);
 		break;
@@ -977,9 +978,11 @@
 };
 static struct i2c_client client_template =
 {
-        .name   = "(tuner unset)",
 	.flags  = I2C_CLIENT_ALLOW_USE,
         .driver = &driver,
+        .dev	= {
+		.name	= "(tuner unset)",
+	},
 };
 
 static int tuner_init_module(void)
diff -Nru a/drivers/media/video/tvaudio.c b/drivers/media/video/tvaudio.c
--- a/drivers/media/video/tvaudio.c	Mon Mar 24 17:27:34 2003
+++ b/drivers/media/video/tvaudio.c	Mon Mar 24 17:27:34 2003
@@ -161,22 +161,22 @@
 	unsigned char buffer[2];
 
 	if (-1 == subaddr) {
-		dprintk("%s: chip_write: 0x%x\n", chip->c.name, val);
+		dprintk("%s: chip_write: 0x%x\n", chip->c.dev.name, val);
 		chip->shadow.bytes[1] = val;
 		buffer[0] = val;
 		if (1 != i2c_master_send(&chip->c,buffer,1)) {
 			printk(KERN_WARNING "%s: I/O error (write 0x%x)\n",
-			       chip->c.name, val);
+			       chip->c.dev.name, val);
 			return -1;
 		}
 	} else {
-		dprintk("%s: chip_write: reg%d=0x%x\n", chip->c.name, subaddr, val);
+		dprintk("%s: chip_write: reg%d=0x%x\n", chip->c.dev.name, subaddr, val);
 		chip->shadow.bytes[subaddr+1] = val;
 		buffer[0] = subaddr;
 		buffer[1] = val;
 		if (2 != i2c_master_send(&chip->c,buffer,2)) {
 			printk(KERN_WARNING "%s: I/O error (write reg%d=0x%x)\n",
-			       chip->c.name, subaddr, val);
+			       chip->c.dev.name, subaddr, val);
 			return -1;
 		}
 	}
@@ -201,10 +201,10 @@
 
 	if (1 != i2c_master_recv(&chip->c,&buffer,1)) {
 		printk(KERN_WARNING "%s: I/O error (read)\n",
-		       chip->c.name);
+		       chip->c.dev.name);
 		return -1;
 	}
-	dprintk("%s: chip_read: 0x%x\n",chip->c.name,buffer); 
+	dprintk("%s: chip_read: 0x%x\n",chip->c.dev.name,buffer); 
 	return buffer;
 }
 
@@ -220,11 +220,11 @@
 
 	if (2 != i2c_transfer(chip->c.adapter,msgs,2)) {
 		printk(KERN_WARNING "%s: I/O error (read2)\n",
-		       chip->c.name);
+		       chip->c.dev.name);
 		return -1;
 	}
 	dprintk("%s: chip_read2: reg%d=0x%x\n",
-		chip->c.name,subaddr,read[0]); 
+		chip->c.dev.name,subaddr,read[0]); 
 	return read[0];
 }
 
@@ -237,7 +237,7 @@
 
 	/* update our shadow register set; print bytes if (debug > 0) */
 	dprintk("%s: chip_cmd(%s): reg=%d, data:",
-		chip->c.name,name,cmd->bytes[0]);
+		chip->c.dev.name,name,cmd->bytes[0]);
 	for (i = 1; i < cmd->count; i++) {
 		dprintk(" 0x%x",cmd->bytes[i]);
 		chip->shadow.bytes[i+cmd->bytes[0]] = cmd->bytes[i];
@@ -246,7 +246,7 @@
 
 	/* send data to the chip */
 	if (cmd->count != i2c_master_send(&chip->c,cmd->bytes,cmd->count)) {
-		printk(KERN_WARNING "%s: I/O error (%s)\n", chip->c.name, name);
+		printk(KERN_WARNING "%s: I/O error (%s)\n", chip->c.dev.name, name);
 		return -1;
 	}
 	return 0;
@@ -273,19 +273,19 @@
 #ifdef CONFIG_SMP
 	lock_kernel();
 #endif
-	daemonize("%s", chip->c.name);
+	daemonize("%s", chip->c.dev.name);
 	chip->thread = current;
 #ifdef CONFIG_SMP
 	unlock_kernel();
 #endif
 
-	dprintk("%s: thread started\n", chip->c.name);
+	dprintk("%s: thread started\n", chip->c.dev.name);
 	if(chip->notify != NULL)
 		up(chip->notify);
 
 	for (;;) {
 		interruptible_sleep_on(&chip->wq);
-		dprintk("%s: thread wakeup\n", chip->c.name);
+		dprintk("%s: thread wakeup\n", chip->c.dev.name);
 		if (chip->done || signal_pending(current))
 			break;
 
@@ -301,7 +301,7 @@
 	}
 
 	chip->thread = NULL;
-	dprintk("%s: thread exiting\n", chip->c.name);
+	dprintk("%s: thread exiting\n", chip->c.dev.name);
 	if(chip->notify != NULL)
 		up(chip->notify);
 
@@ -316,7 +316,7 @@
 	if (mode == chip->prevmode)
 	    return;
 
-	dprintk("%s: thread checkmode\n", chip->c.name);
+	dprintk("%s: thread checkmode\n", chip->c.dev.name);
 	chip->prevmode = mode;
 
 	if (mode & VIDEO_SOUND_STEREO)
@@ -1339,7 +1339,7 @@
 	memcpy(&chip->c,&client_template,sizeof(struct i2c_client));
         chip->c.adapter = adap;
         chip->c.addr = addr;
-	chip->c.data = chip;
+	i2c_set_clientdata(&chip->c, chip);
 
 	/* find description for the chip */
 	dprintk("tvaudio: chip found @ i2c-addr=0x%x\n", addr<<1);
@@ -1364,7 +1364,7 @@
 		(desc->flags & CHIP_HAS_INPUTSEL)   ? " audiomux"    : "");
 
 	/* fill required data structures */
-	strcpy(chip->c.name,desc->name);
+	strncpy(chip->c.dev.name, desc->name, DEVICE_NAME_SIZE);
 	chip->type = desc-chiplist;
 	chip->shadow.count = desc->registers+1;
         chip->prevmode = -1;
@@ -1421,7 +1421,7 @@
 
 static int chip_detach(struct i2c_client *client)
 {
-	struct CHIPSTATE *chip = client->data;
+	struct CHIPSTATE *chip = i2c_get_clientdata(client);
 
 	del_timer(&chip->wt);
 	if (NULL != chip->thread) {
@@ -1447,10 +1447,10 @@
 			unsigned int cmd, void *arg)
 {
         __u16 *sarg = arg;
-	struct CHIPSTATE *chip = client->data;
+	struct CHIPSTATE *chip = i2c_get_clientdata(client);
 	struct CHIPDESC  *desc = chiplist + chip->type;
 
-	dprintk("%s: chip_command 0x%x\n",chip->c.name,cmd);
+	dprintk("%s: chip_command 0x%x\n",chip->c.dev.name,cmd);
 
 	switch (cmd) {
 	case AUDC_SET_INPUT:
@@ -1558,9 +1558,11 @@
 
 static struct i2c_client client_template =
 {
-        .name   = "(unset)",
 	.flags  = I2C_CLIENT_ALLOW_USE,
         .driver = &driver,
+        .dev	= {
+		.name	= "(unset)",
+	},
 };
 
 static int audiochip_init_module(void)

