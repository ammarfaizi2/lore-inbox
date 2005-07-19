Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVGSVpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVGSVpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 17:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVGSVpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 17:45:30 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:19716 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261692AbVGSVp2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 17:45:28 -0400
Date: Tue, 19 Jul 2005 23:45:40 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] I2C: Separate non-i2c hwmon drivers from i2c-core (1/9)
Message-Id: <20050719234540.78a3f8ea.khali@linux-fr.org>
In-Reply-To: <20050719233902.40282559.khali@linux-fr.org>
References: <20050719233902.40282559.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Temporarily export a few structures and functions from i2c-core, because
we will soon need them in i2c-isa.

 drivers/i2c/i2c-core.c |   14 ++++++++++----
 include/linux/i2c.h    |    7 +++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

--- linux-2.6.13-rc3.orig/drivers/i2c/i2c-core.c	2005-07-13 23:34:12.000000000 +0200
+++ linux-2.6.13-rc3/drivers/i2c/i2c-core.c	2005-07-16 18:37:09.000000000 +0200
@@ -61,7 +61,7 @@
 	return rc;
 }
 
-static struct bus_type i2c_bus_type = {
+struct bus_type i2c_bus_type = {
 	.name =		"i2c",
 	.match =	i2c_device_match,
 	.suspend =      i2c_bus_suspend,
@@ -78,13 +78,13 @@
 	return 0;
 }
 
-static void i2c_adapter_dev_release(struct device *dev)
+void i2c_adapter_dev_release(struct device *dev)
 {
 	struct i2c_adapter *adap = dev_to_i2c_adapter(dev);
 	complete(&adap->dev_released);
 }
 
-static struct device_driver i2c_adapter_driver = {
+struct device_driver i2c_adapter_driver = {
 	.name =	"i2c_adapter",
 	.bus = &i2c_bus_type,
 	.probe = i2c_device_probe,
@@ -97,7 +97,7 @@
 	complete(&adap->class_dev_released);
 }
 
-static struct class i2c_adapter_class = {
+struct class i2c_adapter_class = {
 	.name =		"i2c-adapter",
 	.release =	&i2c_adapter_class_dev_release,
 };
@@ -1171,6 +1171,12 @@
 }
 
 
+/* Next four are needed by i2c-isa */
+EXPORT_SYMBOL(i2c_adapter_dev_release);
+EXPORT_SYMBOL(i2c_adapter_driver);
+EXPORT_SYMBOL(i2c_adapter_class);
+EXPORT_SYMBOL(i2c_bus_type);
+
 EXPORT_SYMBOL(i2c_add_adapter);
 EXPORT_SYMBOL(i2c_del_adapter);
 EXPORT_SYMBOL(i2c_add_driver);
--- linux-2.6.13-rc3.orig/include/linux/i2c.h	2005-07-13 23:34:37.000000000 +0200
+++ linux-2.6.13-rc3/include/linux/i2c.h	2005-07-16 18:34:02.000000000 +0200
@@ -34,6 +34,13 @@
 #include <linux/device.h>	/* for struct device */
 #include <asm/semaphore.h>
 
+/* --- For i2c-isa ---------------------------------------------------- */
+
+extern void i2c_adapter_dev_release(struct device *dev);
+extern struct device_driver i2c_adapter_driver;
+extern struct class i2c_adapter_class;
+extern struct bus_type i2c_bus_type;
+
 /* --- General options ------------------------------------------------	*/
 
 struct i2c_msg;

-- 
Jean Delvare
