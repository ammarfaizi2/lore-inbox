Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261708AbTCVA63>; Fri, 21 Mar 2003 19:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261695AbTCVAz1>; Fri, 21 Mar 2003 19:55:27 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:57864 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261696AbTCVAxs>;
	Fri, 21 Mar 2003 19:53:48 -0500
Subject: Re: [PATCH] More i2c driver changes for 2.5.65
In-reply-to: <10482950874081@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Fri, 21 Mar 2003 17:04 -0800
Message-id: <10482950873871@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1194, 2003/03/21 16:26:04-08:00, greg@kroah.com

i2c: actually register the i2c client device with the driver core.

We have to initialize the client structure with 0 to keep the
driver core from oopsing.

Now everything is hooked up enough to start removing the i2c sysctl
and proc crud.


 drivers/i2c/chips/adm1021.c |    2 ++
 drivers/i2c/chips/lm75.c    |    2 ++
 drivers/i2c/i2c-core.c      |   10 ++++++++++
 3 files changed, 14 insertions(+)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Fri Mar 21 16:52:49 2003
+++ b/drivers/i2c/chips/adm1021.c	Fri Mar 21 16:52:49 2003
@@ -221,6 +221,8 @@
 		err = -ENOMEM;
 		goto error0;
 	}
+	memset(new_client, 0x00, sizeof(struct i2c_client) +
+				 sizeof(struct adm1021_data));
 
 	data = (struct adm1021_data *) (new_client + 1);
 	i2c_set_clientdata(new_client, data);
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Fri Mar 21 16:52:49 2003
+++ b/drivers/i2c/chips/lm75.c	Fri Mar 21 16:52:49 2003
@@ -140,6 +140,8 @@
 		err = -ENOMEM;
 		goto error0;
 	}
+	memset(new_client, 0x00, sizeof(struct i2c_client) +
+				 sizeof(struct lm75_data));
 
 	data = (struct lm75_data *) (new_client + 1);
 	i2c_set_clientdata(new_client, data);
diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Fri Mar 21 16:52:49 2003
+++ b/drivers/i2c/i2c-core.c	Fri Mar 21 16:52:49 2003
@@ -378,6 +378,15 @@
 
 	if (client->flags & I2C_CLIENT_ALLOW_USE)
 		client->usage_count = 0;
+
+	client->dev.parent = &client->adapter->dev;
+	client->dev.driver = &client->driver->driver;
+	client->dev.bus = &i2c_bus_type;
+	
+	snprintf(&client->dev.bus_id[0], sizeof(client->dev.bus_id), "i2c_dev_%d", i);
+	printk("registering %s\n", client->dev.bus_id);
+	device_register(&client->dev);
+	
 	return 0;
 }
 
@@ -414,6 +423,7 @@
 	res = -ENODEV;
 
  out_unlock:
+	device_unregister(&client->dev);
 	up(&adapter->list);
  out:
 	return res;

