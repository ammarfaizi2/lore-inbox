Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263246AbVCDVXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263246AbVCDVXu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263224AbVCDVLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:11:49 -0500
Received: from mail.kroah.org ([69.55.234.183]:21154 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263172AbVCDUyl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:41 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Enable w83781d and w83627hf temperature channels
In-Reply-To: <11099685942479@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:34 -0800
Message-Id: <1109968594643@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2092, 2005/03/02 12:09:28-08:00, khali@linux-fr.org

[PATCH] I2C: Enable w83781d and w83627hf temperature channels

The chips supported by the w83781d and w83627hf drivers might come up
with their temperature channels disabled. Currently, the w83781d driver
does so for temp3 but omits temp2, while the w83627hf driver omits both.
The following patch fixes that, and prints warning messages when the
driver has to enable the channels (normally the BIOS should do it for
us). We also skip this initialization step for the AS99127F chips, for
which we have no documentation.

This should hopefully solve the problem reported here:
http://archives.andrew.net.au/lm-sensors/msg29150.html

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/w83627hf.c |   21 +++++++++++++++++++++
 drivers/i2c/chips/w83781d.c  |   23 ++++++++++++++++++++---
 2 files changed, 41 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	2005-03-04 12:25:24 -08:00
+++ b/drivers/i2c/chips/w83627hf.c	2005-03-04 12:25:24 -08:00
@@ -1321,6 +1321,27 @@
 	data->pwmenable[2] = 1;
 
 	if(init) {
+		/* Enable temp2 */
+		tmp = w83627hf_read_value(client, W83781D_REG_TEMP2_CONFIG);
+		if (tmp & 0x01) {
+			dev_warn(&client->dev, "Enabling temp2, readings "
+				 "might not make sense\n");
+			w83627hf_write_value(client, W83781D_REG_TEMP2_CONFIG,
+				tmp & 0xfe);
+		}
+
+		/* Enable temp3 */
+		if (type != w83697hf) {
+			tmp = w83627hf_read_value(client,
+				W83781D_REG_TEMP3_CONFIG);
+			if (tmp & 0x01) {
+				dev_warn(&client->dev, "Enabling temp3, "
+					 "readings might not make sense\n");
+				w83627hf_write_value(client,
+					W83781D_REG_TEMP3_CONFIG, tmp & 0xfe);
+			}
+		}
+
 		if (type == w83627hf) {
 			/* enable PWM2 control (can't hurt since PWM reg
 		           should have been reset to 0xff) */
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	2005-03-04 12:25:24 -08:00
+++ b/drivers/i2c/chips/w83781d.c	2005-03-04 12:25:24 -08:00
@@ -1562,11 +1562,28 @@
 	}
 #endif				/* W83781D_RT */
 
-	if (init) {
+	if (init && type != as99127f) {
+		/* Enable temp2 */
+		tmp = w83781d_read_value(client, W83781D_REG_TEMP2_CONFIG);
+		if (tmp & 0x01) {
+			dev_warn(&client->dev, "Enabling temp2, readings "
+				 "might not make sense\n");
+			w83781d_write_value(client, W83781D_REG_TEMP2_CONFIG,
+				tmp & 0xfe);
+		}
+
+		/* Enable temp3 */
 		if (type != w83783s && type != w83697hf) {
-			w83781d_write_value(client, W83781D_REG_TEMP3_CONFIG,
-					    0x00);
+			tmp = w83781d_read_value(client,
+				W83781D_REG_TEMP3_CONFIG);
+			if (tmp & 0x01) {
+				dev_warn(&client->dev, "Enabling temp3, "
+					 "readings might not make sense\n");
+				w83781d_write_value(client,
+					W83781D_REG_TEMP3_CONFIG, tmp & 0xfe);
+			}
 		}
+
 		if (type != w83781d) {
 			/* enable comparator mode for temp2 and temp3 so
 			   alarm indication will work correctly */

