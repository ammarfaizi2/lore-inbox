Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbTEGAUv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 20:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbTEGAUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 20:20:15 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:65420 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262150AbTEGATL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 20:19:11 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10522676141842@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.69
In-Reply-To: <10522676142536@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 6 May 2003 17:33:34 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1083, 2003/05/06 17:16:26-07:00, kraxel@bytesex.org

[PATCH] i2c #2/3: add i2c_clients_command

Changes:

  * adds a i2c_clients_command() function to i2c-core which calls
    the ->command() callback of all clients attached to a adapter.
  * make bttv + saa7134 drivers use that function instead of mucking
    with the i2c_adapter struct themself.


 drivers/i2c/i2c-core.c                    |   22 ++++++++++
 drivers/media/video/bttv-if.c             |   63 ++++++------------------------
 drivers/media/video/bttv.h                |    1 
 drivers/media/video/bttvp.h               |    3 -
 drivers/media/video/saa7134/saa7134-i2c.c |   23 ++--------
 include/linux/i2c.h                       |    5 ++
 6 files changed, 48 insertions(+), 69 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Tue May  6 17:24:37 2003
+++ b/drivers/i2c/i2c-core.c	Tue May  6 17:24:37 2003
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
diff -Nru a/drivers/media/video/bttv-if.c b/drivers/media/video/bttv-if.c
--- a/drivers/media/video/bttv-if.c	Tue May  6 17:24:37 2003
+++ b/drivers/media/video/bttv-if.c	Tue May  6 17:24:37 2003
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
diff -Nru a/drivers/media/video/bttv.h b/drivers/media/video/bttv.h
--- a/drivers/media/video/bttv.h	Tue May  6 17:24:37 2003
+++ b/drivers/media/video/bttv.h	Tue May  6 17:24:37 2003
@@ -243,7 +243,6 @@
 
 
 /* i2c */
-#define I2C_CLIENTS_MAX 16
 extern void bttv_bit_setscl(void *data, int state);
 extern void bttv_bit_setsda(void *data, int state);
 extern void bttv_call_i2c_clients(struct bttv *btv, unsigned int cmd, void *arg);
diff -Nru a/drivers/media/video/bttvp.h b/drivers/media/video/bttvp.h
--- a/drivers/media/video/bttvp.h	Tue May  6 17:24:37 2003
+++ b/drivers/media/video/bttvp.h	Tue May  6 17:24:37 2003
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
diff -Nru a/drivers/media/video/saa7134/saa7134-i2c.c b/drivers/media/video/saa7134/saa7134-i2c.c
--- a/drivers/media/video/saa7134/saa7134-i2c.c	Tue May  6 17:24:37 2003
+++ b/drivers/media/video/saa7134/saa7134-i2c.c	Tue May  6 17:24:37 2003
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
 	
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Tue May  6 17:24:37 2003
+++ b/include/linux/i2c.h	Tue May  6 17:24:37 2003
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

