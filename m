Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263181AbTJJXUT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 19:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbTJJXUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 19:20:19 -0400
Received: from mail.kroah.org ([65.200.24.183]:27106 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263181AbTJJXTy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 19:19:54 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1065827494796@kroah.com>
Subject: [PATCH] i2c driver fixes for 2.6.0-test7
In-Reply-To: <20031010231024.GB18320@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 10 Oct 2003 16:11:34 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1337.1.1, 2003/10/09 13:33:03-07:00, khali@linux-fr.org

[PATCH] I2C: Chip driver initialization fixes

fixes all chip drivers by moving the initialization before any sysfs
entry is created.


 drivers/i2c/chips/adm1021.c |    6 ++++--
 drivers/i2c/chips/it87.c    |    7 ++++---
 drivers/i2c/chips/lm75.c    |    5 ++++-
 drivers/i2c/chips/lm78.c    |    7 ++++---
 drivers/i2c/chips/lm85.c    |    6 ++++--
 drivers/i2c/chips/via686a.c |    7 ++++---
 drivers/i2c/chips/w83781d.c |    6 ++++--
 7 files changed, 28 insertions(+), 16 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Fri Oct 10 16:00:52 2003
+++ b/drivers/i2c/chips/adm1021.c	Fri Oct 10 16:00:52 2003
@@ -322,6 +322,10 @@
 	if ((err = i2c_attach_client(new_client)))
 		goto error3;
 
+	/* Initialize the ADM1021 chip */
+	adm1021_init_client(new_client);
+
+	/* Register sysfs hooks */
 	device_create_file(&new_client->dev, &dev_attr_temp_max1);
 	device_create_file(&new_client->dev, &dev_attr_temp_min1);
 	device_create_file(&new_client->dev, &dev_attr_temp_input1);
@@ -332,8 +336,6 @@
 	if (data->type == adm1021)
 		device_create_file(&new_client->dev, &dev_attr_die_code);
 
-	/* Initialize the ADM1021 chip */
-	adm1021_init_client(new_client);
 	return 0;
 
 error3:
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Fri Oct 10 16:00:52 2003
+++ b/drivers/i2c/chips/it87.c	Fri Oct 10 16:00:52 2003
@@ -701,7 +701,10 @@
 	if ((err = i2c_attach_client(new_client)))
 		goto ERROR1;
 
-	/* register sysfs hooks */
+	/* Initialize the IT87 chip */
+	it87_init_client(new_client, data);
+
+	/* Register sysfs hooks */
 	device_create_file(&new_client->dev, &dev_attr_in_input0);
 	device_create_file(&new_client->dev, &dev_attr_in_input1);
 	device_create_file(&new_client->dev, &dev_attr_in_input2);
@@ -750,8 +753,6 @@
 	device_create_file(&new_client->dev, &dev_attr_fan_div3);
 	device_create_file(&new_client->dev, &dev_attr_alarm);
 
-	/* Initialize the IT87 chip */
-	it87_init_client(new_client, data);
 	return 0;
 
 ERROR1:
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Fri Oct 10 16:00:52 2003
+++ b/drivers/i2c/chips/lm75.c	Fri Oct 10 16:00:52 2003
@@ -204,11 +204,14 @@
 	if ((err = i2c_attach_client(new_client)))
 		goto exit_free;
 
+	/* Initialize the LM75 chip */
+	lm75_init_client(new_client);
+	
+	/* Register sysfs hooks */
 	device_create_file(&new_client->dev, &dev_attr_temp_max);
 	device_create_file(&new_client->dev, &dev_attr_temp_min);
 	device_create_file(&new_client->dev, &dev_attr_temp_input);
 
-	lm75_init_client(new_client);
 	return 0;
 
 exit_free:
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	Fri Oct 10 16:00:52 2003
+++ b/drivers/i2c/chips/lm78.c	Fri Oct 10 16:00:52 2003
@@ -648,7 +648,10 @@
 	if ((err = i2c_attach_client(new_client)))
 		goto ERROR2;
 
-	/* register sysfs hooks */
+	/* Initialize the LM78 chip */
+	lm78_init_client(new_client);
+
+	/* Register sysfs hooks */
 	device_create_file(&new_client->dev, &dev_attr_in_input0);
 	device_create_file(&new_client->dev, &dev_attr_in_min0);
 	device_create_file(&new_client->dev, &dev_attr_in_max0);
@@ -685,8 +688,6 @@
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	device_create_file(&new_client->dev, &dev_attr_vid);
 
-	/* Initialize the LM78 chip */
-	lm78_init_client(new_client);
 	return 0;
 
 ERROR2:
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	Fri Oct 10 16:00:52 2003
+++ b/drivers/i2c/chips/lm85.c	Fri Oct 10 16:00:52 2003
@@ -888,6 +888,10 @@
 	/* Set the VRM version */
 	data->vrm = LM85_INIT_VRM ;
 
+	/* Initialize the LM85 chip */
+	lm85_init_client(new_client);
+
+	/* Register sysfs hooks */
 	device_create_file(&new_client->dev, &dev_attr_fan_input1);
 	device_create_file(&new_client->dev, &dev_attr_fan_input2);
 	device_create_file(&new_client->dev, &dev_attr_fan_input3);
@@ -930,8 +934,6 @@
 	device_create_file(&new_client->dev, &dev_attr_vid);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
-	/* Initialize the LM85 chip */
-	lm85_init_client(new_client);
 	return 0;
 
 	/* Error out and cleanup code */
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Fri Oct 10 16:00:52 2003
+++ b/drivers/i2c/chips/via686a.c	Fri Oct 10 16:00:52 2003
@@ -735,7 +735,10 @@
 	if ((err = i2c_attach_client(new_client)))
 		goto ERROR3;
 	
-	/* register sysfs hooks */
+	/* Initialize the VIA686A chip */
+	via686a_init_client(new_client);
+
+	/* Register sysfs hooks */
 	device_create_file(&new_client->dev, &dev_attr_in_input0);
 	device_create_file(&new_client->dev, &dev_attr_in_input1);
 	device_create_file(&new_client->dev, &dev_attr_in_input2);
@@ -768,8 +771,6 @@
 	device_create_file(&new_client->dev, &dev_attr_fan_div2);
 	device_create_file(&new_client->dev, &dev_attr_alarm);
 
-	/* Initialize the VIA686A chip */
-	via686a_init_client(new_client);
 	return 0;
 
       ERROR3:
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Fri Oct 10 16:00:52 2003
+++ b/drivers/i2c/chips/w83781d.c	Fri Oct 10 16:00:52 2003
@@ -1346,6 +1346,10 @@
 		data->lm75[1] = NULL;
 	}
 
+	/* Initialize the chip */
+	w83781d_init_client(new_client);
+
+	/* Register sysfs hooks */
 	device_create_file_in(new_client, 0);
 	if (kind != w83783s && kind != w83697hf)
 		device_create_file_in(new_client, 1);
@@ -1408,8 +1412,6 @@
 	}
 #endif
 
-	/* Initialize the chip */
-	w83781d_init_client(new_client);
 	return 0;
 
 ERROR3:

