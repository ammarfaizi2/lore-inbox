Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUDNXKP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 19:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUDNWdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:33:41 -0400
Received: from mail.kroah.org ([65.200.24.183]:28319 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261925AbUDNWYd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:24:33 -0400
Subject: Re: [PATCH] I2C update for 2.6.5
In-Reply-To: <10819814532188@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:13 -0700
Message-Id: <1081981453937@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.29, 2004/04/12 15:17:46-07:00, khali@linux-fr.org

[PATCH] I2C: No reset not limit init in via686a

The following patch removes limits initialization in the via686a driver.
It was decided some times ago that this belongs to user-space, not
kernel. See the thread here:
http://archives.andrew.net.au/lm-sensors/msg06134.html

It also prevents the sensor chip from being savagely reset at load time.
This too follows a decision taken long ago that drivers should do as
little as possible in their init procedure. See the thread here:
http://archives.andrew.net.au/lm-sensors/msg04593.html

This should make the driver smaller, safer and faster to load. The same
was done to our 2.4/CVS version of the driver 5 months ago and it seems
to work just fine.


 drivers/i2c/chips/via686a.c |   90 +++-----------------------------------------
 1 files changed, 7 insertions(+), 83 deletions(-)


diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Wed Apr 14 15:12:20 2004
+++ b/drivers/i2c/chips/via686a.c	Wed Apr 14 15:12:20 2004
@@ -329,45 +329,9 @@
 #define DIV_FROM_REG(val) (1 << (val))
 #define DIV_TO_REG(val) ((val)==8?3:(val)==4?2:(val)==1?0:1)
 
-/* Initial limits */
-#define VIA686A_INIT_IN_0 200
-#define VIA686A_INIT_IN_1 250
-#define VIA686A_INIT_IN_2 330
-#define VIA686A_INIT_IN_3 500
-#define VIA686A_INIT_IN_4 1200
-
-#define VIA686A_INIT_IN_PERCENTAGE 10
-
-#define VIA686A_INIT_IN_MIN_0 (VIA686A_INIT_IN_0 - VIA686A_INIT_IN_0 \
-        * VIA686A_INIT_IN_PERCENTAGE / 100)
-#define VIA686A_INIT_IN_MAX_0 (VIA686A_INIT_IN_0 + VIA686A_INIT_IN_0 \
-        * VIA686A_INIT_IN_PERCENTAGE / 100)
-#define VIA686A_INIT_IN_MIN_1 (VIA686A_INIT_IN_1 - VIA686A_INIT_IN_1 \
-        * VIA686A_INIT_IN_PERCENTAGE / 100)
-#define VIA686A_INIT_IN_MAX_1 (VIA686A_INIT_IN_1 + VIA686A_INIT_IN_1 \
-        * VIA686A_INIT_IN_PERCENTAGE / 100)
-#define VIA686A_INIT_IN_MIN_2 (VIA686A_INIT_IN_2 - VIA686A_INIT_IN_2 \
-        * VIA686A_INIT_IN_PERCENTAGE / 100)
-#define VIA686A_INIT_IN_MAX_2 (VIA686A_INIT_IN_2 + VIA686A_INIT_IN_2 \
-        * VIA686A_INIT_IN_PERCENTAGE / 100)
-#define VIA686A_INIT_IN_MIN_3 (VIA686A_INIT_IN_3 - VIA686A_INIT_IN_3 \
-        * VIA686A_INIT_IN_PERCENTAGE / 100)
-#define VIA686A_INIT_IN_MAX_3 (VIA686A_INIT_IN_3 + VIA686A_INIT_IN_3 \
-        * VIA686A_INIT_IN_PERCENTAGE / 100)
-#define VIA686A_INIT_IN_MIN_4 (VIA686A_INIT_IN_4 - VIA686A_INIT_IN_4 \
-        * VIA686A_INIT_IN_PERCENTAGE / 100)
-#define VIA686A_INIT_IN_MAX_4 (VIA686A_INIT_IN_4 + VIA686A_INIT_IN_4 \
-        * VIA686A_INIT_IN_PERCENTAGE / 100)
-
-#define VIA686A_INIT_FAN_MIN	3000
-
-#define VIA686A_INIT_TEMP_OVER 600
-#define VIA686A_INIT_TEMP_HYST 500
-
-/* For the VIA686A, we need to keep some data in memory. That
-   data is pointed to by via686a_list[NR]->data. The structure itself is
-   dynamically allocated, at the same time when a new via686a client is
-   allocated. */
+/* For the VIA686A, we need to keep some data in memory.
+   The structure is dynamically allocated, at the same time when a new
+   via686a client is allocated. */
 struct via686a_data {
 	struct i2c_client client;
 	struct semaphore update_lock;
@@ -773,53 +737,13 @@
 /* Called when we have found a new VIA686A. Set limits, etc. */
 static void via686a_init_client(struct i2c_client *client)
 {
-	int i;
-
-	/* Reset the device */
-	via686a_write_value(client, VIA686A_REG_CONFIG, 0x80);
-
-	/* Have to wait for reset to complete or else the following
-	   initializations won't work reliably. The delay was arrived at
-	   empirically, the datasheet doesn't tell you.
-	   Waiting for the reset bit to clear doesn't work, it
-	   clears in about 2-4 udelays and that isn't nearly enough. */
-	udelay(50);
-
-	via686a_write_value(client, VIA686A_REG_IN_MIN(0),
-			    IN_TO_REG(VIA686A_INIT_IN_MIN_0, 0));
-	via686a_write_value(client, VIA686A_REG_IN_MAX(0),
-			    IN_TO_REG(VIA686A_INIT_IN_MAX_0, 0));
-	via686a_write_value(client, VIA686A_REG_IN_MIN(1),
-			    IN_TO_REG(VIA686A_INIT_IN_MIN_1, 1));
-	via686a_write_value(client, VIA686A_REG_IN_MAX(1),
-			    IN_TO_REG(VIA686A_INIT_IN_MAX_1, 1));
-	via686a_write_value(client, VIA686A_REG_IN_MIN(2),
-			    IN_TO_REG(VIA686A_INIT_IN_MIN_2, 2));
-	via686a_write_value(client, VIA686A_REG_IN_MAX(2),
-			    IN_TO_REG(VIA686A_INIT_IN_MAX_2, 2));
-	via686a_write_value(client, VIA686A_REG_IN_MIN(3),
-			    IN_TO_REG(VIA686A_INIT_IN_MIN_3, 3));
-	via686a_write_value(client, VIA686A_REG_IN_MAX(3),
-			    IN_TO_REG(VIA686A_INIT_IN_MAX_3, 3));
-	via686a_write_value(client, VIA686A_REG_IN_MIN(4),
-			    IN_TO_REG(VIA686A_INIT_IN_MIN_4, 4));
-	via686a_write_value(client, VIA686A_REG_IN_MAX(4),
-			    IN_TO_REG(VIA686A_INIT_IN_MAX_4, 4));
-	via686a_write_value(client, VIA686A_REG_FAN_MIN(1),
-			    FAN_TO_REG(VIA686A_INIT_FAN_MIN, 2));
-	via686a_write_value(client, VIA686A_REG_FAN_MIN(2),
-			    FAN_TO_REG(VIA686A_INIT_FAN_MIN, 2));
-	for (i = 0; i <= 2; i++) {
-		via686a_write_value(client, VIA686A_REG_TEMP_OVER(i),
-				    TEMP_TO_REG(VIA686A_INIT_TEMP_OVER));
-		via686a_write_value(client, VIA686A_REG_TEMP_HYST(i),
-				    TEMP_TO_REG(VIA686A_INIT_TEMP_HYST));
-	}
+	u8 reg;
 
 	/* Start monitoring */
-	via686a_write_value(client, VIA686A_REG_CONFIG, 0x01);
+	reg = via686a_read_value(client, VIA686A_REG_CONFIG);
+	via686a_write_value(client, VIA686A_REG_CONFIG, (reg|0x01)&0x7F);
 
-	/* Cofigure temp interrupt mode for continuous-interrupt operation */
+	/* Configure temp interrupt mode for continuous-interrupt operation */
 	via686a_write_value(client, VIA686A_REG_TEMP_MODE, 
 			    via686a_read_value(client, VIA686A_REG_TEMP_MODE) &
 			    !(VIA686A_TEMP_MODE_MASK | VIA686A_TEMP_MODE_CONTINUOUS));

