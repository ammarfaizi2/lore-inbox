Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422670AbWJLBkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422670AbWJLBkZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 21:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWJLBkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 21:40:25 -0400
Received: from havoc.gtf.org ([69.61.125.42]:55775 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932488AbWJLBkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 21:40:24 -0400
Date: Wed, 11 Oct 2006 21:40:19 -0400
From: Jeff Garzik <jeff@garzik.org>
To: a.zummo@towertech.it, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] RTC: handle sysfs errors
Message-ID: <20061012014019.GA12456@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/rtc/rtc-ds1672.c        |    9 +++++-
 drivers/rtc/rtc-rs5c372.c       |   12 +++++++--
 drivers/rtc/rtc-test.c          |    9 ++++++
 drivers/rtc/rtc-x1205.c         |   12 +++++++--

diff --git a/drivers/rtc/rtc-ds1672.c b/drivers/rtc/rtc-ds1672.c
index 67e816a..dfef163 100644
--- a/drivers/rtc/rtc-ds1672.c
+++ b/drivers/rtc/rtc-ds1672.c
@@ -237,17 +237,22 @@ static int ds1672_probe(struct i2c_adapt
 	/* read control register */
 	err = ds1672_get_control(client, &control);
 	if (err)
-		goto exit_detach;
+		goto exit_devreg;
 
 	if (control & DS1672_REG_CONTROL_EOSC)
 		dev_warn(&client->dev, "Oscillator not enabled. "
 					"Set time to enable.\n");
 
 	/* Register sysfs hooks */
-	device_create_file(&client->dev, &dev_attr_control);
+	err = device_create_file(&client->dev, &dev_attr_control);
+	if (err)
+		goto exit_devreg;
 
 	return 0;
 
+exit_devreg:
+	rtc_device_unregister(rtc);
+
 exit_detach:
 	i2c_detach_client(client);
 
diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index 2a86632..64ef68d 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -238,11 +238,19 @@ static int rs5c372_probe(struct i2c_adap
 
 	i2c_set_clientdata(client, rtc);
 
-	device_create_file(&client->dev, &dev_attr_trim);
-	device_create_file(&client->dev, &dev_attr_osc);
+	err = device_create_file(&client->dev, &dev_attr_trim);
+	if (err) goto exit_devreg;
+	err = device_create_file(&client->dev, &dev_attr_osc);
+	if (err) goto exit_trim;
 
 	return 0;
 
+exit_trim:
+	device_remove_file(&client->dev, &dev_attr_trim);
+
+exit_devreg:
+	rtc_device_unregister(rtc);
+
 exit_detach:
 	i2c_detach_client(client);
 
diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index bc4bd24..f407ade 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -121,11 +121,18 @@ static int test_probe(struct platform_de
 		err = PTR_ERR(rtc);
 		return err;
 	}
-	device_create_file(&plat_dev->dev, &dev_attr_irq);
+
+	err = device_create_file(&plat_dev->dev, &dev_attr_irq);
+	if (err)
+		goto err;
 
 	platform_set_drvdata(plat_dev, rtc);
 
 	return 0;
+
+err:
+	rtc_device_unregister(rtc);
+	return err;
 }
 
 static int __devexit test_remove(struct platform_device *plat_dev)
diff --git a/drivers/rtc/rtc-x1205.c b/drivers/rtc/rtc-x1205.c
index 522c697..9a67487 100644
--- a/drivers/rtc/rtc-x1205.c
+++ b/drivers/rtc/rtc-x1205.c
@@ -562,11 +562,19 @@ static int x1205_probe(struct i2c_adapte
 	else
 		dev_err(&client->dev, "couldn't read status\n");
 
-	device_create_file(&client->dev, &dev_attr_atrim);
-	device_create_file(&client->dev, &dev_attr_dtrim);
+	err = device_create_file(&client->dev, &dev_attr_atrim);
+	if (err) goto exit_devreg;
+	err = device_create_file(&client->dev, &dev_attr_dtrim);
+	if (err) goto exit_atrim;
 
 	return 0;
 
+exit_atrim:
+	device_remove_file(&client->dev, &dev_attr_atrim);
+
+exit_devreg:
+	rtc_device_unregister(rtc);
+
 exit_detach:
 	i2c_detach_client(client);
 
