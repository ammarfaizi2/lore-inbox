Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTEIXqz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 19:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTEIXms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 19:42:48 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:58849 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263591AbTEIXmG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 19:42:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10525245943578@kroah.com>
Subject: Re: [PATCH] More i2c driver changes for 2.5.69
In-Reply-To: <10525245942470@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 9 May 2003 16:56:34 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1083.2.3, 2003/05/09 14:54:04-07:00, warp@mercury.d2dc.net

[PATCH] I2C: Another it87 patch.

This is against my last.

While the old code most definitely did /something/ to the register for
setting the fan div, the 'what' is a more interesting question.

To be honest I could not figure out what it was trying to do, because
the way it was inserting values disagreed with not only the data sheet,
but how it parsed the very same register.

This corrects the issue, and allows one to properly control the divisor
on all 3 fans, including the (much more limited) 3rd fan.


 drivers/i2c/chips/it87.c |   34 ++++++++++++++++++++++++++++------
 1 files changed, 28 insertions(+), 6 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Fri May  9 16:48:09 2003
+++ b/drivers/i2c/chips/it87.c	Fri May  9 16:48:09 2003
@@ -159,7 +159,14 @@
 				205-(val)*5)
 #define ALARMS_FROM_REG(val) (val)
 
-#define DIV_TO_REG(val) ((val)==8?3:(val)==4?2:(val)==1?0:1)
+static int log2(int val)
+{
+	int answer = 0;
+	while ((val >>= 1))
+		answer++;
+	return answer;
+}
+#define DIV_TO_REG(val) log2(val)
 #define DIV_FROM_REG(val) (1 << (val))
 
 /* Initial limits. Use the config file to set better limits. */
@@ -520,10 +527,25 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
-	int old = it87_read_value(client, IT87_REG_FAN_DIV);
-	data->fan_div[nr] = DIV_TO_REG(val);
-	old = (old & 0x0f) | (data->fan_div[1] << 6) | (data->fan_div[0] << 4);
-	it87_write_value(client, IT87_REG_FAN_DIV, old);
+	u8 old = it87_read_value(client, IT87_REG_FAN_DIV);
+
+	switch (nr) {
+	case 0:
+	case 1:
+		data->fan_div[nr] = DIV_TO_REG(val);
+		break;
+	case 2:
+		if (val < 8)
+			data->fan_div[nr] = 1;
+		else
+			data->fan_div[nr] = 3;
+	}
+	val = old & 0x100;
+	val |= (data->fan_div[0] & 0x07);
+	val |= (data->fan_div[1] & 0x07) << 3;
+	if (data->fan_div[2] == 3)
+		val |= 0x1 << 6;
+	it87_write_value(client, IT87_REG_FAN_DIV, val);
 	return count;
 }
 
@@ -961,7 +983,7 @@
 		i = it87_read_value(client, IT87_REG_FAN_DIV);
 		data->fan_div[0] = i & 0x07;
 		data->fan_div[1] = (i >> 3) & 0x07;
-		data->fan_div[2] = 1;
+		data->fan_div[2] = (i & 0x40) ? 3 : 1;
 
 		data->alarms =
 			it87_read_value(client, IT87_REG_ALARM1) |

