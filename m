Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbVCaXY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVCaXY4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVCaXYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:24:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:19936 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261924AbVCaXYA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:00 -0500
Cc: grant_nospam@dodo.com.au
Subject: [PATCH] I2C: Drop useless w83781d RT feature
In-Reply-To: <11123113952409@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:16 -0800
Message-Id: <1112311396681@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2350, 2005/03/31 14:32:55-08:00, grant_nospam@dodo.com.au

[PATCH] I2C: Drop useless w83781d RT feature

This patch removes useless RT feature from w83781d driver.

Patch applies after the recent "I2C: Fix a common race condition
in hardware monitoring" series.

Signed-off-by: Grant Coady <gcoady@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/w83781d.c |  100 --------------------------------------------
 1 files changed, 100 deletions(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	2005-03-31 15:15:56 -08:00
+++ b/drivers/i2c/chips/w83781d.c	2005-03-31 15:15:56 -08:00
@@ -46,9 +46,6 @@
 #include <asm/io.h>
 #include "lm75.h"
 
-/* RT Table support #defined so we can take it out if it gets bothersome */
-#define W83781D_RT			1
-
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x20, 0x21, 0x22, 0x23, 0x24, 0x25,
 					0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b,
@@ -258,9 +255,6 @@
 				   3000-5000 = thermistor beta.
 				   Default = 3435. 
 				   Other Betas unimplemented */
-#ifdef W83781D_RT
-	u8 rt[3][32];		/* Register value */
-#endif
 	u8 vrm;
 };
 
@@ -834,66 +828,6 @@
 device_create_file(&client->dev, &dev_attr_temp##offset##_type); \
 } while (0)
 
-#ifdef W83781D_RT
-static ssize_t
-show_rt_reg(struct device *dev, char *buf, int nr)
-{
-	struct w83781d_data *data = w83781d_update_device(dev);
-	int i, j = 0;
-
-	for (i = 0; i < 32; i++) {
-		if (i > 0)
-			j += sprintf(buf, " %ld", (long) data->rt[nr - 1][i]);
-		else
-			j += sprintf(buf, "%ld", (long) data->rt[nr - 1][i]);
-	}
-	j += sprintf(buf, "\n");
-
-	return j;
-}
-
-static ssize_t
-store_rt_reg(struct device *dev, const char *buf, size_t count, int nr)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
-	u32 val, i;
-
-	for (i = 0; i < count; i++) {
-		val = simple_strtoul(buf + count, NULL, 10);
-
-		/* fixme: no bounds checking 0-255 */
-		data->rt[nr - 1][i] = val & 0xff;
-		w83781d_write_value(client, W83781D_REG_RT_IDX, i);
-		w83781d_write_value(client, W83781D_REG_RT_VAL,
-				    data->rt[nr - 1][i]);
-	}
-
-	return count;
-}
-
-#define sysfs_rt(offset) \
-static ssize_t show_regs_rt_##offset (struct device *dev, char *buf) \
-{ \
-	return show_rt_reg(dev, buf, offset); \
-} \
-static ssize_t store_regs_rt_##offset (struct device *dev, const char *buf, size_t count) \
-{ \
-    return store_rt_reg(dev, buf, count, offset); \
-} \
-static DEVICE_ATTR(rt##offset, S_IRUGO | S_IWUSR, show_regs_rt_##offset, store_regs_rt_##offset);
-
-sysfs_rt(1);
-sysfs_rt(2);
-sysfs_rt(3);
-
-#define device_create_file_rt(client, offset) \
-do { \
-device_create_file(&client->dev, &dev_attr_rt##offset); \
-} while (0)
-
-#endif				/* ifdef W83781D_RT */
-
 /* This function is called when:
      * w83781d_driver is inserted (when this module is loaded), for each
        available adapter
@@ -1304,13 +1238,6 @@
 		if (kind != w83783s && kind != w83697hf)
 			device_create_file_sensor(new_client, 3);
 	}
-#ifdef W83781D_RT
-	if (kind == w83781d) {
-		device_create_file_rt(new_client, 1);
-		device_create_file_rt(new_client, 2);
-		device_create_file_rt(new_client, 3);
-	}
-#endif
 
 	return 0;
 
@@ -1535,33 +1462,6 @@
 				break;
 		}
 	}
-#ifdef W83781D_RT
-/*
-   Fill up the RT Tables.
-   We assume that they are 32 bytes long, in order for temp 1-3.
-   Data sheet documentation is sparse.
-   We also assume that it is only for the 781D although I suspect
-   that the others support it as well....
-*/
-
-	if (init && type == w83781d) {
-		u16 k = 0;
-/*
-    Auto-indexing doesn't seem to work...
-    w83781d_write_value(client,W83781D_REG_RT_IDX,0);
-*/
-		for (i = 0; i < 3; i++) {
-			int j;
-			for (j = 0; j < 32; j++) {
-				w83781d_write_value(client,
-						    W83781D_REG_RT_IDX, k++);
-				data->rt[i][j] =
-				    w83781d_read_value(client,
-						       W83781D_REG_RT_VAL);
-			}
-		}
-	}
-#endif				/* W83781D_RT */
 
 	if (init && type != as99127f) {
 		/* Enable temp2 */

