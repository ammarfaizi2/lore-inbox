Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbTEFTm6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 15:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbTEFTm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 15:42:58 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:12225 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261248AbTEFTmp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 15:42:45 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 6 May 2003 21:40:18 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       Frank Davis <fdavis@si.rr.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       Ronald Bultje <R.S.Bultje@pharm.uu.nl>
Subject: [patch] i2c #2/3: add i2c_clients_command
Message-ID: <20030506194018.GB865@bytesex.org>
References: <20030506193430.GA865@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506193430.GA865@bytesex.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is the second of three patches for i2c.

Changes:

  * adds a i2c_clients_command() function to i2c-core which calls
    the ->command() callback of all clients attached to a adapter.
  * make bttv + saa7134 drivers use that function instead of mucking
    with the i2c_adapter struct themself.

Please apply,

  Gerd

diff -urN -X /home/kraxel/.kdontdiff linux-i2c-1-2.5.69/drivers/i2c/i2c-core.c linux-i2c-2-2.5.69/drivers/i2c/i2c-core.c
--- linux-i2c-1-2.5.69/drivers/i2c/i2c-core.c	2003-05-06 13:42:07.000000000 +0200
+++ linux-i2c-2-2.5.69/drivers/i2c/i2c-core.c	2003-05-06 16:25:40.000000000 +0200
@@ -411,6 +411,27 @@
 	return 0;
 }
 
+void i2c_clients_command(struct i2c_adapter *adap, unsigned int cmd, void *arg)
+{
+	struct list_head  *item;
+	struct i2c_client *client;
+
+	down(&adap->clist_lock);
+	list_for_each(item,&adap->clients) {
+		client = list_entry(item, struct i2c_client, list);
+		if (!try_module_get(client->driver->owner))
+			continue;
+		if (NULL != client->driver->command) {
+			up(&adap->clist_lock);
+			client->driver->command(client,cmd,arg);
+			down(&adap->clist_lock);
+		}
+		module_put(client->driver->owner);
+       }
+       up(&adap->clist_lock);
+}
+
+
 /* match always succeeds, as we want the probe() to tell if we really accept this match */
 static int i2c_device_match(struct device *dev, struct device_driver *drv)
 {
@@ -1183,6 +1204,7 @@
 EXPORT_SYMBOL(i2c_detach_client);
 EXPORT_SYMBOL(i2c_use_client);
 EXPORT_SYMBOL(i2c_release_client);
+EXPORT_SYMBOL(i2c_clients_command);
 EXPORT_SYMBOL(i2c_check_addr);
 
 EXPORT_SYMBOL(i2c_master_send);
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-1-2.5.69/drivers/media/video/bttv-if.c linux-i2c-2-2.5.69/drivers/media/video/bttv-if.c
--- linux-i2c-1-2.5.69/drivers/media/video/bttv-if.c	2003-05-06 10:22:00.000000000 +0200
+++ linux-i2c-2-2.5.69/drivers/media/video/bttv-if.c	2003-05-06 16:57:13.000000000 +0200
@@ -7,7 +7,7 @@
 
     Copyright (C) 1996,97,98 Ralph  Metzler (rjkm@thp.uni-koeln.de)
                            & Marcus Metzler (mocm@thp.uni-koeln.de)
-    (c) 1999,2000 Gerd Knorr <kraxel@goldbach.in-berlin.de>
+    (c) 1999-2003 Gerd Knorr <kraxel@bytesex.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -195,51 +195,21 @@
 static int attach_inform(struct i2c_client *client)
 {
         struct bttv *btv = i2c_get_adapdata(client->adapter);
-	int i;
 
-	for (i = 0; i < I2C_CLIENTS_MAX; i++) {
-		if (btv->i2c_clients[i] == NULL) {
-			btv->i2c_clients[i] = client;
-			break;
-		}
-	}
-	if (btv->tuner_type != -1)
+	if (btv->tuner_type != UNSET)
 		bttv_call_i2c_clients(btv,TUNER_SET_TYPE,&btv->tuner_type);
-        if (bttv_verbose)
-		printk("bttv%d: i2c attach [client=%s,%s]\n",btv->nr,
-		       client->dev.name, (i < I2C_CLIENTS_MAX) ?  "ok" : "failed");
-        return 0;
-}
-
-static int detach_inform(struct i2c_client *client)
-{
-        struct bttv *btv = i2c_get_adapdata(client->adapter);
-	int i;
 
-	for (i = 0; i < I2C_CLIENTS_MAX; i++) {
-		if (btv->i2c_clients[i] == client) {
-			btv->i2c_clients[i] = NULL;
-			break;
-		}
-	}
-        if (bttv_verbose)
-		printk("bttv%d: i2c detach [client=%s,%s]\n",btv->nr,
-		       client->dev.name, (i < I2C_CLIENTS_MAX) ?  "ok" : "failed");
+        if (bttv_debug)
+		printk("bttv%d: i2c attach [client=%s]\n",
+		       btv->nr, i2c_clientname(client));
         return 0;
 }
 
 void bttv_call_i2c_clients(struct bttv *btv, unsigned int cmd, void *arg)
 {
-	int i;
-	
-	for (i = 0; i < I2C_CLIENTS_MAX; i++) {
-		if (NULL == btv->i2c_clients[i])
-			continue;
-		if (NULL == btv->i2c_clients[i]->driver->command)
-			continue;
-		btv->i2c_clients[i]->driver->command(
-			btv->i2c_clients[i],cmd,arg);
-	}
+	if (0 != btv->i2c_rc)
+		return;
+	i2c_clients_command(&btv->i2c_adap, cmd, arg);
 }
 
 void bttv_i2c_call(unsigned int card, unsigned int cmd, void *arg)
@@ -260,20 +230,15 @@
 };
 
 static struct i2c_adapter bttv_i2c_adap_template = {
-	.owner          = THIS_MODULE,
+	.owner             = THIS_MODULE,
+	I2C_DEVNAME("bt848"),
 	.id                = I2C_HW_B_BT848,
 	.client_register   = attach_inform,
-	.client_unregister = detach_inform,
-	.dev		= {
-		.name	= "bt848",
-	},
 };
 
 static struct i2c_client bttv_i2c_client_template = {
-        .id	= -1,
-        .dev	= {
-		.name = "bttv internal",
-	},
+	I2C_DEVNAME("bttv internal"),
+        .id       = -1,
 };
 
 
@@ -347,8 +312,8 @@
 	memcpy(&btv->i2c_client, &bttv_i2c_client_template,
 	       sizeof(struct i2c_client));
 
-	sprintf(btv->i2c_adap.dev.name+strlen(btv->i2c_adap.dev.name),
-		" #%d", btv->nr);
+	sprintf(btv->i2c_adap.dev.name, "bt848 #%d", btv->nr);
+
         btv->i2c_algo.data = btv;
         i2c_set_adapdata(&btv->i2c_adap, btv);
         btv->i2c_adap.algo_data = &btv->i2c_algo;
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-1-2.5.69/drivers/media/video/bttv.h linux-i2c-2-2.5.69/drivers/media/video/bttv.h
--- linux-i2c-1-2.5.69/drivers/media/video/bttv.h	2003-05-06 10:22:00.000000000 +0200
+++ linux-i2c-2-2.5.69/drivers/media/video/bttv.h	2003-05-06 17:00:34.000000000 +0200
@@ -243,7 +243,6 @@
 
 
 /* i2c */
-#define I2C_CLIENTS_MAX 16
 extern void bttv_bit_setscl(void *data, int state);
 extern void bttv_bit_setsda(void *data, int state);
 extern void bttv_call_i2c_clients(struct bttv *btv, unsigned int cmd, void *arg);
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-1-2.5.69/drivers/media/video/bttvp.h linux-i2c-2-2.5.69/drivers/media/video/bttvp.h
--- linux-i2c-1-2.5.69/drivers/media/video/bttvp.h	2003-05-06 10:22:26.000000000 +0200
+++ linux-i2c-2-2.5.69/drivers/media/video/bttvp.h	2003-05-06 16:55:01.000000000 +0200
@@ -62,6 +62,8 @@
 #define RAW_LINES            640
 #define RAW_BPL             1024
 
+#define UNSET (-1U)
+
 /* ---------------------------------------------------------- */
 
 struct bttv_tvnorm 
@@ -276,7 +278,6 @@
 	struct i2c_algo_bit_data   i2c_algo;
 	struct i2c_client          i2c_client;
 	int                        i2c_state, i2c_rc;
-	struct i2c_client         *i2c_clients[I2C_CLIENTS_MAX];
 
 	/* video4linux (1) */
 	struct video_device video_dev;
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-1-2.5.69/drivers/media/video/saa7134/saa7134-i2c.c linux-i2c-2-2.5.69/drivers/media/video/saa7134/saa7134-i2c.c
--- linux-i2c-1-2.5.69/drivers/media/video/saa7134/saa7134-i2c.c	2003-05-06 10:22:02.000000000 +0200
+++ linux-i2c-2-2.5.69/drivers/media/video/saa7134/saa7134-i2c.c	2003-05-06 16:51:55.000000000 +0200
@@ -334,19 +334,15 @@
 
 static struct i2c_adapter saa7134_adap_template = {
 	.owner         = THIS_MODULE,
+	I2C_DEVNAME("saa7134"),
 	.id            = I2C_ALGO_SAA7134,
 	.algo          = &saa7134_algo,
 	.client_register = attach_inform,
-	.dev		= {
-		.name	= "saa7134",
-	},
 };
 
 static struct i2c_client saa7134_client_template = {
-        .id   = -1,
-	.dev	= {
-		.name	= "saa7134 internal",
-	},
+	I2C_DEVNAME("saa7134 internal"),
+        .id        = -1,
 };
 
 /* ----------------------------------------------------------- */
@@ -399,22 +395,13 @@
 void saa7134_i2c_call_clients(struct saa7134_dev *dev,
 			      unsigned int cmd, void *arg)
 {
-	int i;
-
-	for (i = 0; i < I2C_CLIENT_MAX; i++) {
-		if (NULL == dev->i2c_adap.clients[i])
-			continue;
-		if (NULL == dev->i2c_adap.clients[i]->driver->command)
-			continue;
-		dev->i2c_adap.clients[i]->driver->command
-			(dev->i2c_adap.clients[i],cmd,arg);
-	}
+	i2c_clients_command(&dev->i2c_adap, cmd, arg);
 }
 
 int saa7134_i2c_register(struct saa7134_dev *dev)
 {
 	dev->i2c_adap = saa7134_adap_template;
-	strncpy(dev->i2c_adap.dev.name, dev->name, DEVICE_NAME_SIZE);
+	strcpy(dev->i2c_adap.dev.name,dev->name);
 	dev->i2c_adap.algo_data = dev;
 	i2c_add_adapter(&dev->i2c_adap);
 	
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-1-2.5.69/include/linux/i2c.h linux-i2c-2-2.5.69/include/linux/i2c.h
--- linux-i2c-1-2.5.69/include/linux/i2c.h	2003-05-06 13:41:07.000000000 +0200
+++ linux-i2c-2-2.5.69/include/linux/i2c.h	2003-05-06 14:03:04.000000000 +0200
@@ -334,6 +334,11 @@
 extern int i2c_use_client(struct i2c_client *);
 extern int i2c_release_client(struct i2c_client *);
 
+/* call the i2c_client->command() of all attached clients with
+ * the given arguments */
+extern void i2c_clients_command(struct i2c_adapter *adap,
+				unsigned int cmd, void *arg);
+
 /* returns -EBUSY if address has been taken, 0 if not. Note that the only
    other place at which this is called is within i2c_attach_client; so
    you can cheat by simply not registering. Not recommended, of course! */
