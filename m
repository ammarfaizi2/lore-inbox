Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265555AbUA0Xgt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 18:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265658AbUA0Xgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 18:36:49 -0500
Received: from mail.kroah.org ([65.200.24.183]:38079 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265555AbUA0XeS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 18:34:18 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.2-rc2
In-Reply-To: <1075246453781@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 27 Jan 2004 15:34:13 -0800
Message-Id: <10752464532256@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.148.6, 2004/01/27 14:46:05-08:00, greg@kroah.com

[PATCH] I2C: remove printk() calls in lm85, and clean up debug logic.


 drivers/i2c/chips/lm85.c |   69 ++++++++++++++---------------------------------
 1 files changed, 21 insertions(+), 48 deletions(-)


diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	Tue Jan 27 15:26:35 2004
+++ b/drivers/i2c/chips/lm85.c	Tue Jan 27 15:26:35 2004
@@ -48,9 +48,6 @@
 /* Insmod parameters */
 SENSORS_INSMOD_4(lm85b, lm85c, adm1027, adt7463);
 
-/* Enable debug if true */
-static int	lm85debug = 0;
-
 /* The LM85 registers */
 
 #define	LM85_REG_IN(nr)			(0x20 + (nr))
@@ -802,19 +799,15 @@
 	company = lm85_read_value(new_client, LM85_REG_COMPANY);
 	verstep = lm85_read_value(new_client, LM85_REG_VERSTEP);
 
-	if (lm85debug) {
-		printk("lm85: Detecting device at %d,0x%02x with"
+	dev_dbg(&adapter->dev, "Detecting device at %d,0x%02x with"
 		" COMPANY: 0x%02x and VERSTEP: 0x%02x\n",
 		i2c_adapter_id(new_client->adapter), new_client->addr,
 		company, verstep);
-	}
 
 	/* If auto-detecting, Determine the chip type. */
 	if (kind <= 0) {
-		if (lm85debug) {
-			printk("lm85: Autodetecting device at %d,0x%02x ...\n",
+		dev_dbg(&adapter->dev, "Autodetecting device at %d,0x%02x ...\n",
 			i2c_adapter_id(adapter), address );
-		}
 		if( company == LM85_COMPANY_NATIONAL
 		    && verstep == LM85_VERSTEP_LM85C ) {
 			kind = lm85c ;
@@ -823,8 +816,8 @@
 			kind = lm85b ;
 		} else if( company == LM85_COMPANY_NATIONAL
 		    && (verstep & 0xf0) == LM85_VERSTEP_GENERIC ) {
-			printk("lm85: Unrecgonized version/stepping 0x%02x"
-			    " Defaulting to LM85.\n", verstep );
+			dev_err(&adapter->dev, "Unrecgonized version/stepping 0x%02x"
+				" Defaulting to LM85.\n", verstep);
 			kind = any_chip ;
 		} else if( company == LM85_COMPANY_ANALOG_DEV
 		    && verstep == LM85_VERSTEP_ADM1027 ) {
@@ -834,21 +827,19 @@
 			kind = adt7463 ;
 		} else if( company == LM85_COMPANY_ANALOG_DEV
 		    && (verstep & 0xf0) == LM85_VERSTEP_GENERIC ) {
-			printk("lm85: Unrecgonized version/stepping 0x%02x"
-			    " Defaulting to ADM1027.\n", verstep );
+			dev_err(&adapter->dev, "Unrecgonized version/stepping 0x%02x"
+				" Defaulting to ADM1027.\n", verstep);
 			kind = adm1027 ;
 		} else if( kind == 0 && (verstep & 0xf0) == 0x60) {
-			printk("lm85: Generic LM85 Version 6 detected\n");
+			dev_err(&adapter->dev, "Generic LM85 Version 6 detected\n");
 			/* Leave kind as "any_chip" */
 		} else {
-			if (lm85debug) {
-				printk("lm85: Autodetection failed\n");
-			}
+			dev_dbg(&adapter->dev, "Autodetection failed\n");
 			/* Not an LM85 ... */
 			if( kind == 0 ) {  /* User used force=x,y */
-			    printk("lm85: Generic LM85 Version 6 not"
-				" found at %d,0x%02x. Try force_lm85c.\n",
-				i2c_adapter_id(adapter), address );
+				dev_err(&adapter->dev, "Generic LM85 Version 6 not"
+					" found at %d,0x%02x. Try force_lm85c.\n",
+					i2c_adapter_id(adapter), address );
 			}
 			err = 0 ;
 			goto ERROR1;
@@ -879,12 +870,10 @@
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 
-	if (lm85debug) {
-		printk("lm85: Assigning ID %d to %s at %d,0x%02x\n",
+	dev_dbg(&adapter->dev, "Assigning ID %d to %s at %d,0x%02x\n",
 		new_client->id, new_client->name,
 		i2c_adapter_id(new_client->adapter),
 		new_client->addr);
-	}
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
@@ -1021,31 +1010,24 @@
 	int value;
 	struct lm85_data *data = i2c_get_clientdata(client);
 
-	if (lm85debug) {
-		printk("lm85(%d): Initializing device\n", client->id);
-	}
+	dev_dbg(&client->dev, "Initializing device\n");
 
 	/* Warn if part was not "READY" */
 	value = lm85_read_value(client, LM85_REG_CONFIG);
-	if (lm85debug) {
-		printk("lm85(%d): LM85_REG_CONFIG is: 0x%02x\n", client->id, value );
-	}
+	dev_dbg(&client->dev, "LM85_REG_CONFIG is: 0x%02x\n", value);
 	if( value & 0x02 ) {
-		printk("lm85(%d): Client (%d,0x%02x) config is locked.\n",
-			    client->id,
+		dev_err(&client->dev, "Client (%d,0x%02x) config is locked.\n",
 			    i2c_adapter_id(client->adapter), client->addr );
 	};
 	if( ! (value & 0x04) ) {
-		printk("lm85(%d): Client (%d,0x%02x) is not ready.\n",
-			    client->id,
+		dev_err(&client->dev, "Client (%d,0x%02x) is not ready.\n",
 			    i2c_adapter_id(client->adapter), client->addr );
 	};
 	if( value & 0x10
 	    && ( data->type == adm1027
 		|| data->type == adt7463 ) ) {
-		printk("lm85(%d): Client (%d,0x%02x) VxI mode is set.  "
+		dev_err(&client->dev, "Client (%d,0x%02x) VxI mode is set.  "
 			"Please report this to the lm85 maintainer.\n",
-			    client->id,
 			    i2c_adapter_id(client->adapter), client->addr );
 	};
 
@@ -1061,11 +1043,8 @@
 	value = lm85_read_value(client, LM85_REG_CONFIG);
 	/* Try to clear LOCK, Set START, save everything else */
 	value = (value & ~ 0x02) | 0x01 ;
-	if (lm85debug) {
-		printk("lm85(%d): Setting CONFIG to: 0x%02x\n", client->id, value );
-	}
+	dev_dbg(&client->dev, "Setting CONFIG to: 0x%02x\n", value);
 	lm85_write_value(client, LM85_REG_CONFIG, value);
-
 }
 
 void lm85_update_client(struct i2c_client *client)
@@ -1078,10 +1057,8 @@
 	if ( !data->valid ||
 	     (jiffies - data->last_reading > LM85_DATA_INTERVAL ) ) {
 		/* Things that change quickly */
-
-		if (lm85debug) {
-			printk("lm85(%d): Reading sensor values\n", client->id);
-		}
+		dev_dbg(&client->dev, "Reading sensor values\n");
+		
 		/* Have to read extended bits first to "freeze" the
 		 * more significant bits that are read later.
 		 */
@@ -1125,10 +1102,8 @@
 	if ( !data->valid ||
 	     (jiffies - data->last_config > LM85_CONFIG_INTERVAL) ) {
 		/* Things that don't change often */
+		dev_dbg(&client->dev, "Reading config values\n");
 
-		if (lm85debug) {
-			printk("lm85(%d): Reading config values\n", client->id);
-		}
 		for (i = 0; i <= 4; ++i) {
 			data->in_min[i] =
 			    lm85_read_value(client, LM85_REG_IN_MIN(i));
@@ -1234,8 +1209,6 @@
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Philip Pokorny <ppokorny@penguincomputing.com>, Margit Schubert-While <margitsw@t-online.de>");
 MODULE_DESCRIPTION("LM85-B, LM85-C driver");
-MODULE_PARM(lm85debug, "i");
-MODULE_PARM_DESC(lm85debug, "Enable debugging statements");
 
 module_init(sm_lm85_init);
 module_exit(sm_lm85_exit);

