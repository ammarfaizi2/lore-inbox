Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVGaUNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVGaUNY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 16:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVGaUMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 16:12:33 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:56068 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261984AbVGaUMS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 16:12:18 -0400
Date: Sun, 31 Jul 2005 22:12:09 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] (11/11) hwmon vs i2c, second round
Message-Id: <20050731221209.43c7f55d.khali@linux-fr.org>
In-Reply-To: <20050731205933.2e2a957f.khali@linux-fr.org>
References: <20050731205933.2e2a957f.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the common vid_from_reg function in lm78 rather than
reimplementing it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/Kconfig |    1 +
 drivers/hwmon/lm78.c  |   10 ++--------
 2 files changed, 3 insertions(+), 8 deletions(-)

--- linux-2.6.13-rc4.orig/drivers/hwmon/lm78.c	2005-07-31 16:59:10.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm78.c	2005-07-31 20:55:46.000000000 +0200
@@ -25,6 +25,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-isa.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <asm/io.h>
 
@@ -106,13 +107,6 @@
 	return val * 1000;
 }
 
-/* VID: mV
-   REG: (see doc/vid) */
-static inline int VID_FROM_REG(u8 val)
-{
-	return val==0x1f ? 0 : val>=0x10 ? 5100-val*100 : 2050-val*50;
-}
-
 #define DIV_FROM_REG(val) (1 << (val))
 
 /* There are some complications in a module like this. First off, LM78 chips
@@ -457,7 +451,7 @@
 static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lm78_data *data = lm78_update_device(dev);
-	return sprintf(buf, "%d\n", VID_FROM_REG(data->vid));
+	return sprintf(buf, "%d\n", vid_from_reg(82, data->vid));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
--- linux-2.6.13-rc4.orig/drivers/hwmon/Kconfig	2005-07-31 16:59:30.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/Kconfig	2005-07-31 20:55:46.000000000 +0200
@@ -207,6 +207,7 @@
 	tristate "National Semiconductor LM78 and compatibles"
 	depends on HWMON && I2C && EXPERIMENTAL
 	select I2C_ISA
+	select HWMON_VID
 	help
 	  If you say yes here you get support for National Semiconductor LM78,
 	  LM78-J and LM79.


-- 
Jean Delvare
