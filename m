Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVBANON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVBANON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 08:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVBANON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 08:14:13 -0500
Received: from mx2.mail.ru ([194.67.23.122]:58373 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S262012AbVBANN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 08:13:59 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [PATCH 2.6] I2C: New chip driver: sis5595
Date: Tue, 1 Feb 2005 16:12:27 +0200
User-Agent: KMail/1.6.2
Cc: aurelien@aurel32.net, "Greg KH" <greg@kroah.com>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "LM Sensors" <sensors@Stimpy.netroedge.com>
References: <VJ70nUPw.1107258560.0805790.khali@localhost>
In-Reply-To: <VJ70nUPw.1107258560.0805790.khali@localhost>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502011612.27220.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 February 2005 13:49, Jean Delvare wrote:

> > Maybe you should call sis5595_update_device() in initialization function
> > and get rid of "value" field. It's sole purpose to fill "struct sis5595"
> > when it's known that "last_updated" field contains crap.

> Doesn't work. If you discard the "valid" field and call the update
> function at init time, you cannot be sure that the update function will
> actually do something. It all depends on the jiffies value relative to
> last_updated (0 at this point). This is exactly what "valid" is there
> for.

What about making sis5595_update_device() a simple jiffies-related wrapper
around function that updates "struct sis5595" unconditionally. I'm not sure
I plugged sis5595_do_update_client right, but you'll get the idea.

	Alexey

--- linux-2.6.11-rc2-bk9-i2c/drivers/i2c/chips/sis5595.c.orig	2005-02-01 15:34:43.000000000 +0200
+++ linux-2.6.11-rc2-bk9-i2c/drivers/i2c/chips/sis5595.c	2005-02-01 15:58:39.000000000 +0200
@@ -184,7 +184,6 @@ struct sis5595_data {
 	struct semaphore lock;
 
 	struct semaphore update_lock;
-	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 	char maxins;		/* == 3 if temp enabled, otherwise == 4 */
 	u8 revision;		/* Reg. value */
@@ -209,6 +208,7 @@ static int sis5595_detach_client(struct 
 
 static int sis5595_read_value(struct i2c_client *client, u8 register);
 static int sis5595_write_value(struct i2c_client *client, u8 register, u8 value);
+static void sis5595_do_update_client(struct i2c_client *client);
 static struct sis5595_data *sis5595_update_device(struct device *dev);
 static void sis5595_init_client(struct i2c_client *client);
 static int sis5595_find_sis(int *address);
@@ -586,7 +586,6 @@ int sis5595_detect(struct i2c_adapter *a
 	/* Fill in the remaining client fields and put it into the global list */
 	strlcpy(new_client->name, "sis5595", I2C_NAME_SIZE);
 
-	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
@@ -691,56 +690,52 @@ static void sis5595_init_client(struct i
 	if (!(config & 0x01))
 		sis5595_write_value(client, SIS5595_REG_CONFIG,
 				(config & 0xf7) | 0x01);
+	sis5595_do_update_client(client);
 }
 
-static struct sis5595_data *sis5595_update_device(struct device *dev)
+static void sis5595_do_update_client(struct i2c_client *client)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct sis5595_data *data = i2c_get_clientdata(client);
 	int i;
 
 	down(&data->update_lock);
-
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || !data->valid) {
-
-		for (i = 0; i <= data->maxins; i++) {
-			data->in[i] =
-			    sis5595_read_value(client, SIS5595_REG_IN(i));
-			data->in_min[i] =
-			    sis5595_read_value(client,
-					       SIS5595_REG_IN_MIN(i));
-			data->in_max[i] =
-			    sis5595_read_value(client,
-					       SIS5595_REG_IN_MAX(i));
-		}
-		for (i = 0; i < 2; i++) {
-			data->fan[i] =
-			    sis5595_read_value(client, SIS5595_REG_FAN(i));
-			data->fan_min[i] =
-			    sis5595_read_value(client,
-					       SIS5595_REG_FAN_MIN(i));
-		}
-		if(data->maxins == 3) {
-			data->temp =
-			    sis5595_read_value(client, SIS5595_REG_TEMP);
-			data->temp_over =
-			    sis5595_read_value(client, SIS5595_REG_TEMP_OVER);
-			data->temp_hyst =
-			    sis5595_read_value(client, SIS5595_REG_TEMP_HYST);
-		}
-		i = sis5595_read_value(client, SIS5595_REG_FANDIV);
-		data->fan_div[0] = (i >> 4) & 0x03;
-		data->fan_div[1] = i >> 6;
-		data->alarms =
-		    sis5595_read_value(client, SIS5595_REG_ALARM1) |
-		    (sis5595_read_value(client, SIS5595_REG_ALARM2) << 8);
-		data->last_updated = jiffies;
-		data->valid = 1;
+	for (i = 0; i <= data->maxins; i++) {
+		data->in[i] = sis5595_read_value(client, SIS5595_REG_IN(i));
+		data->in_min[i] = sis5595_read_value(client,
+							SIS5595_REG_IN_MIN(i));
+		data->in_max[i] = sis5595_read_value(client,
+							SIS5595_REG_IN_MAX(i));
 	}
-
+	for (i = 0; i < 2; i++) {
+		data->fan[i] = sis5595_read_value(client, SIS5595_REG_FAN(i));
+		data->fan_min[i] = sis5595_read_value(client,
+							SIS5595_REG_FAN_MIN(i));
+	}
+	if (data->maxins == 3) {
+		data->temp = sis5595_read_value(client, SIS5595_REG_TEMP);
+		data->temp_over = sis5595_read_value(client,
+							SIS5595_REG_TEMP_OVER);
+		data->temp_hyst = sis5595_read_value(client,
+							SIS5595_REG_TEMP_HYST);
+	}
+	i = sis5595_read_value(client, SIS5595_REG_FANDIV);
+	data->fan_div[0] = (i >> 4) & 0x03;
+	data->fan_div[1] = i >> 6;
+	data->alarms = sis5595_read_value(client, SIS5595_REG_ALARM1) |
+			(sis5595_read_value(client, SIS5595_REG_ALARM2) << 8);
+	data->last_updated = jiffies;
 	up(&data->update_lock);
+}
+
+static struct sis5595_data *sis5595_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct sis5595_data *data = i2c_get_clientdata(client);
 
+	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
+	    (jiffies < data->last_updated)) {
+		sis5595_do_update_client(client);
+	}
 	return data;
 }
 
