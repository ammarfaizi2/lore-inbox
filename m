Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263191AbTDCAD7>; Wed, 2 Apr 2003 19:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263227AbTDCACe>; Wed, 2 Apr 2003 19:02:34 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:44542 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263206AbTDCACL> convert rfc822-to-8bit; Wed, 2 Apr 2003 19:02:11 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10493289592304@kroah.com>
Subject: Re: [PATCH] More i2c driver changes for 2.5.66
In-Reply-To: <10493289593301@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 2 Apr 2003 16:15:59 -0800
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.977.29.13, 2003/04/02 14:18:09-08:00, greg@kroah.com

i2c: clean up previous w83781d patch due to changes I made to i2c core and build.


 drivers/i2c/chips/Kconfig   |   30 +++++++++++++++---------------
 drivers/i2c/chips/Makefile  |    1 +
 drivers/i2c/chips/w83781d.c |    8 +++-----
 include/linux/i2c-vid.h     |    4 ++--
 4 files changed, 21 insertions(+), 22 deletions(-)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	Wed Apr  2 16:00:19 2003
+++ b/drivers/i2c/chips/Kconfig	Wed Apr  2 16:00:19 2003
@@ -37,20 +37,6 @@
 	  in the lm_sensors package, which you can download at 
 	  http://www.lm-sensors.nu
 	  
-config SENSORS_W83781D
-	tristate "  Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F"
-	depends on I2C && I2C_PROC
-	help
-	  If you say yes here you get support for the Winbond W8378x series
-	  of sensor chips: the W83781D, W83782D, W83783S and W83682HF,
-	  and the similar Asus AS99127F. This
-	  can also be built as a module which can be inserted and removed
-	  while the kernel is running.
-	  
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at
-	  http://www.lm-sensors.nu
-
 config SENSORS_VIA686A
 	tristate "  VIA686A"
 	depends on I2C && EXPERIMENTAL
@@ -64,9 +50,23 @@
 	  in the lm_sensors package, which you can download at
 	  http://www.lm-sensors.nu
 
+config SENSORS_W83781D
+	tristate "  Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the Winbond W8378x series
+	  of sensor chips: the W83781D, W83782D, W83783S and W83682HF,
+	  and the similar Asus AS99127F. This
+	  can also be built as a module which can be inserted and removed
+	  while the kernel is running.
+	  
+	  You will also need the latest user-space utilties: you can find them
+	  in the lm_sensors package, which you can download at
+	  http://www.lm-sensors.nu
+
 config I2C_SENSOR
 	tristate
-	depends on SENSORS_ADM1021 || SENSORS_LM75 || SENSORS_VIA686A
+	depends on SENSORS_ADM1021 || SENSORS_LM75 || SENSORS_VIA686A || SENSORS_W83781D
 	default m
 
 endmenu
diff -Nru a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile	Wed Apr  2 16:00:19 2003
+++ b/drivers/i2c/chips/Makefile	Wed Apr  2 16:00:19 2003
@@ -5,3 +5,4 @@
 obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
 obj-$(CONFIG_SENSORS_LM75)	+= lm75.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
+obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Wed Apr  2 16:00:19 2003
+++ b/drivers/i2c/chips/w83781d.c	Wed Apr  2 16:00:19 2003
@@ -38,7 +38,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
-#include <linux/i2c-proc.h>
+#include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <asm/io.h>
 
@@ -332,8 +332,7 @@
 };
 
 static int w83781d_attach_adapter(struct i2c_adapter *adapter);
-static int w83781d_detect(struct i2c_adapter *adapter, int address,
-			  unsigned short flags, int kind);
+static int w83781d_detect(struct i2c_adapter *adapter, int address, int kind);
 static int w83781d_detach_client(struct i2c_client *client);
 
 static int w83781d_read_value(struct i2c_client *client, u16 register);
@@ -1031,8 +1030,7 @@
 }
 
 static int
-w83781d_detect(struct i2c_adapter *adapter, int address,
-	       unsigned short flags, int kind)
+w83781d_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i = 0, val1 = 0, val2, id;
 	struct i2c_client *new_client;
diff -Nru a/include/linux/i2c-vid.h b/include/linux/i2c-vid.h
--- a/include/linux/i2c-vid.h	Wed Apr  2 16:00:19 2003
+++ b/include/linux/i2c-vid.h	Wed Apr  2 16:00:19 2003
@@ -1,6 +1,6 @@
 /*
-    vrm.c - Part of lm_sensors, Linux kernel modules for hardware
-               monitoring
+    i2c-vid.h - Part of lm_sensors, Linux kernel modules for hardware
+                monitoring
     Copyright (c) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
     With assistance from Trent Piepho <xyzzy@speakeasy.org>
 

