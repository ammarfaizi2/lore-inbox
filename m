Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263153AbVCDVXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263153AbVCDVXr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbVCDVMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:12:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:56225 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263145AbVCDUyZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:25 -0500
Cc: bunk@stusta.de
Subject: [PATCH] i2c-core.c: make some code static
In-Reply-To: <11099685952869@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:35 -0800
Message-Id: <11099685953642@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2096, 2005/03/02 12:12:54-08:00, bunk@stusta.de

[PATCH] i2c-core.c: make some code static

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/i2c-core.c |   79 ++++++++++++++++++++++++-------------------------
 include/linux/i2c.h    |    2 -
 2 files changed, 39 insertions(+), 42 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	2005-03-04 12:24:57 -08:00
+++ b/drivers/i2c/i2c-core.c	2005-03-04 12:24:57 -08:00
@@ -38,12 +38,43 @@
 static DECLARE_MUTEX(core_lists);
 static DEFINE_IDR(i2c_adapter_idr);
 
-int i2c_device_probe(struct device *dev)
+/* match always succeeds, as we want the probe() to tell if we really accept this match */
+static int i2c_device_match(struct device *dev, struct device_driver *drv)
+{
+	return 1;
+}
+
+static int i2c_bus_suspend(struct device * dev, pm_message_t state)
+{
+	int rc = 0;
+
+	if (dev->driver && dev->driver->suspend)
+		rc = dev->driver->suspend(dev,state,0);
+	return rc;
+}
+
+static int i2c_bus_resume(struct device * dev)
+{
+	int rc = 0;
+	
+	if (dev->driver && dev->driver->resume)
+		rc = dev->driver->resume(dev,0);
+	return rc;
+}
+
+static struct bus_type i2c_bus_type = {
+	.name =		"i2c",
+	.match =	i2c_device_match,
+	.suspend =      i2c_bus_suspend,
+	.resume =       i2c_bus_resume,
+};
+
+static int i2c_device_probe(struct device *dev)
 {
 	return -ENODEV;
 }
 
-int i2c_device_remove(struct device *dev)
+static int i2c_device_remove(struct device *dev)
 {
 	return 0;
 }
@@ -523,38 +554,6 @@
        up(&adap->clist_lock);
 }
 
-
-/* match always succeeds, as we want the probe() to tell if we really accept this match */
-static int i2c_device_match(struct device *dev, struct device_driver *drv)
-{
-	return 1;
-}
-
-static int i2c_bus_suspend(struct device * dev, u32 state)
-{
-	int rc = 0;
-
-	if (dev->driver && dev->driver->suspend)
-		rc = dev->driver->suspend(dev,state,0);
-	return rc;
-}
-
-static int i2c_bus_resume(struct device * dev)
-{
-	int rc = 0;
-	
-	if (dev->driver && dev->driver->resume)
-		rc = dev->driver->resume(dev,0);
-	return rc;
-}
-
-struct bus_type i2c_bus_type = {
-	.name =		"i2c",
-	.match =	i2c_device_match,
-	.suspend =      i2c_bus_suspend,
-	.resume =       i2c_bus_resume,
-};
-
 static int __init i2c_init(void)
 {
 	int retval;
@@ -860,7 +859,7 @@
 /* CRC over count bytes in the first array plus the bytes in the rest
    array if it is non-null. rest[0] is the (length of rest) - 1
    and is included. */
-u8 i2c_smbus_partial_pec(u8 crc, int count, u8 *first, u8 *rest)
+static u8 i2c_smbus_partial_pec(u8 crc, int count, u8 *first, u8 *rest)
 {
 	int i;
 
@@ -872,7 +871,7 @@
 	return crc;
 }
 
-u8 i2c_smbus_pec(int count, u8 *first, u8 *rest)
+static u8 i2c_smbus_pec(int count, u8 *first, u8 *rest)
 {
 	return i2c_smbus_partial_pec(0, count, first, rest);
 }
@@ -880,8 +879,8 @@
 /* Returns new "size" (transaction type)
    Note that we convert byte to byte_data and byte_data to word_data
    rather than invent new xxx_PEC transactions. */
-int i2c_smbus_add_pec(u16 addr, u8 command, int size,
-                      union i2c_smbus_data *data)
+static int i2c_smbus_add_pec(u16 addr, u8 command, int size,
+			     union i2c_smbus_data *data)
 {
 	u8 buf[3];
 
@@ -910,8 +909,8 @@
 	return size;	
 }
 
-int i2c_smbus_check_pec(u16 addr, u8 command, int size, u8 partial,
-                        union i2c_smbus_data *data)
+static int i2c_smbus_check_pec(u16 addr, u8 command, int size, u8 partial,
+			       union i2c_smbus_data *data)
 {
 	u8 buf[3], rpec, cpec;
 
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	2005-03-04 12:24:57 -08:00
+++ b/include/linux/i2c.h	2005-03-04 12:24:57 -08:00
@@ -134,8 +134,6 @@
 };
 #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)
 
-extern struct bus_type i2c_bus_type;
-
 #define I2C_NAME_SIZE	50
 
 /*

