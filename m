Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbVK3F7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbVK3F7u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 00:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbVK3F7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 00:59:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:32667 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750763AbVK3F6s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 00:58:48 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] hwmon: w83792d fix unused fan pins
In-Reply-To: <1133330317815@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 29 Nov 2005 21:58:37 -0800
Message-Id: <11333303173652@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] hwmon: w83792d fix unused fan pins

1. This patch add check for fan4,5,6,7 and do not create device file
   if their pins are not configured as fan.
2. Fix the issue that can not set fan divisor to 128.
3. Fix the index out of bounds bug in w83792d_detect function.

Signed-off-by: Yuan Mu <ymu@winbond.com.tw>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 9632051963cb6e6f7412990f8b962209b9334e13
tree 1f1fe030107d06e4b43dbee90e95b374ccec7fc2
parent d2ef5ebb4c4fe141a82252d4db8d8521e6765c5a
author Jean Delvare <khali@linux-fr.org> Tue, 29 Nov 2005 22:27:14 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 29 Nov 2005 21:39:22 -0800

 drivers/hwmon/w83792d.c |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index 4be59db..1ba0726 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -193,6 +193,7 @@ static const u8 W83792D_REG_LEVELS[3][4]
 	  0xE2 }	/* (bit3-0) SmartFanII: Fan3 Level 3 */
 };
 
+#define W83792D_REG_GPIO_EN		0x1A
 #define W83792D_REG_CONFIG		0x40
 #define W83792D_REG_VID_FANDIV		0x47
 #define W83792D_REG_CHIPID		0x49
@@ -257,7 +258,7 @@ DIV_TO_REG(long val)
 {
 	int i;
 	val = SENSORS_LIMIT(val, 1, 128) >> 1;
-	for (i = 0; i < 6; i++) {
+	for (i = 0; i < 7; i++) {
 		if (val == 0)
 			break;
 		val >>= 1;
@@ -1282,8 +1283,8 @@ w83792d_detect(struct i2c_adapter *adapt
 	w83792d_init_client(new_client);
 
 	/* A few vars need to be filled upon startup */
-	for (i = 1; i <= 7; i++) {
-		data->fan_min[i - 1] = w83792d_read_value(new_client,
+	for (i = 0; i < 7; i++) {
+		data->fan_min[i] = w83792d_read_value(new_client,
 					W83792D_REG_FAN_MIN[i]);
 	}
 
@@ -1306,10 +1307,20 @@ w83792d_detect(struct i2c_adapter *adapt
 	device_create_file_fan(new_client, 1);
 	device_create_file_fan(new_client, 2);
 	device_create_file_fan(new_client, 3);
-	device_create_file_fan(new_client, 4);
-	device_create_file_fan(new_client, 5);
-	device_create_file_fan(new_client, 6);
-	device_create_file_fan(new_client, 7);
+
+	/* Read GPIO enable register to check if pins for fan 4,5 are used as
+	   GPIO */
+	val1 = w83792d_read_value(new_client, W83792D_REG_GPIO_EN);
+	if (!(val1 & 0x40))
+		device_create_file_fan(new_client, 4);
+	if (!(val1 & 0x20))
+		device_create_file_fan(new_client, 5);
+
+	val1 = w83792d_read_value(new_client, W83792D_REG_PIN);
+	if (val1 & 0x40)
+		device_create_file_fan(new_client, 6);
+	if (val1 & 0x04)
+		device_create_file_fan(new_client, 7);
 
 	device_create_file_temp1(new_client);		/* Temp1 */
 	device_create_file_temp_add(new_client, 2);	/* Temp2 */

