Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262900AbVAQV63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbVAQV63 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 16:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbVAQVz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:55:57 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:49548 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262907AbVAQVtV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:49:21 -0500
Cc: jthiessen@penguincomputing.com
Subject: [PATCH] I2C: adm1026.c fixes
In-Reply-To: <11059983952608@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 17 Jan 2005 13:46:35 -0800
Message-Id: <11059983953842@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2329.2.4, 2005/01/14 14:42:28-08:00, jthiessen@penguincomputing.com

[PATCH] I2C: adm1026.c fixes

Ok, take 3 on the adm1026 patch.

In this patch:

(1) Code has been added which ensures that the fan divisor registers are
    properly read into the data structure before fan minimum speeds are
    determined.  This prevents a possible divide by zero error.  The line
    which reads the hardware default fan divisor values has been reformatted
    as suggested by Andreas Dilger to make the intent of the statement clearer.

(2) In a similar spirit, an unecessary carriage return from a "dev_dbg"
    statement in the adm1026_print_gpio() function has been elminated,
    shortening the statement to a single line and making the code easier
    to read.

Signed-off-by: Justin Thiessen <jthiessen@penguincomputing.com
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/adm1026.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1026.c b/drivers/i2c/chips/adm1026.c
--- a/drivers/i2c/chips/adm1026.c	2005-01-17 13:20:53 -08:00
+++ b/drivers/i2c/chips/adm1026.c	2005-01-17 13:20:53 -08:00
@@ -452,6 +452,14 @@
 		client->id, value);
 	data->config1 = value;
 	adm1026_write_value(client, ADM1026_REG_CONFIG1, value);
+
+	/* initialize fan_div[] to hardware defaults */
+	value = adm1026_read_value(client, ADM1026_REG_FAN_DIV_0_3) |
+		(adm1026_read_value(client, ADM1026_REG_FAN_DIV_4_7) << 8);
+	for (i = 0;i <= 7;++i) {
+		data->fan_div[i] = DIV_FROM_REG(value & 0x03);
+		value >>= 2;
+	}
 }
 
 void adm1026_print_gpio(struct i2c_client *client)
@@ -459,8 +467,7 @@
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int  i;
 
-	dev_dbg(&client->dev, "(%d): GPIO config is:",
-			    client->id);
+	dev_dbg(&client->dev, "(%d): GPIO config is:", client->id);
 	for (i = 0;i <= 7;++i) {
 		if (data->config2 & (1 << i)) {
 			dev_dbg(&client->dev, "\t(%d): %sGP%s%d\n", client->id,

