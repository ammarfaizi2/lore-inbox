Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbUKSWVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbUKSWVm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUKSWVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:21:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:31641 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261627AbUKSWA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:00:27 -0500
Date: Fri, 19 Nov 2004 14:00:01 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [PATCH] I2C fixes for 2.6.10-rc2
Message-ID: <20041119220001.GB15956@kroah.com>
References: <20041119215935.GA15956@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119215935.GA15956@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2164, 2004/11/19 09:12:35-08:00, khali@linux-fr.org

[PATCH] I2C: Do not register useless smsc47m1

While verifying my stack of patches against what you sent to Linus last
week, I noticed this one. Looks like I simply forgot to send it to you,
as I cannot find any trace of it in the lm_sensors mailing-list
archives.

The patch prevents an smsc47m1 device from being registered when no
monitoring function is actually active within the chip. See this ticket
for background:
  http://secure.netroedge.com/~lm78/readticket.cgi?ticket=1801
This is certainly better to explicitely fail in this case than leave the
user with an empty sysfs directory (except for alarms), which tends to
make him/her think of a driver bug, which it isn't (what it really is is
a BIOS brokenness).

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/smsc47m1.c |   29 +++++++++++++++++++++--------
 1 files changed, 21 insertions(+), 8 deletions(-)


diff -Nru a/drivers/i2c/chips/smsc47m1.c b/drivers/i2c/chips/smsc47m1.c
--- a/drivers/i2c/chips/smsc47m1.c	2004-11-19 11:40:54 -08:00
+++ b/drivers/i2c/chips/smsc47m1.c	2004-11-19 11:40:54 -08:00
@@ -394,6 +394,7 @@
 	struct i2c_client *new_client;
 	struct smsc47m1_data *data;
 	int err = 0;
+	int fan1, fan2, pwm1, pwm2;
 
 	if (!i2c_is_isa_adapter(adapter)) {
 		return 0;
@@ -423,6 +424,22 @@
 	new_client->id = smsc47m1_id++;
 	init_MUTEX(&data->update_lock);
 
+	/* If no function is properly configured, there's no point in
+	   actually registering the chip. */
+	fan1 = (smsc47m1_read_value(new_client, SMSC47M1_REG_TPIN(0)) & 0x05)
+	       == 0x05;
+	fan2 = (smsc47m1_read_value(new_client, SMSC47M1_REG_TPIN(1)) & 0x05)
+	       == 0x05;
+	pwm1 = (smsc47m1_read_value(new_client, SMSC47M1_REG_PPIN(0)) & 0x05)
+	       == 0x04;
+	pwm2 = (smsc47m1_read_value(new_client, SMSC47M1_REG_PPIN(1)) & 0x05)
+	       == 0x04;
+	if (!(fan1 || fan2 || pwm1 || pwm2)) {
+		dev_warn(&new_client->dev, "Device is not configured, will not use\n");
+		err = -ENODEV;
+		goto error_free;
+	}
+
 	if ((err = i2c_attach_client(new_client)))
 		goto error_free;
 
@@ -434,8 +451,7 @@
 	   function. */
 	smsc47m1_update_device(&new_client->dev, 1);
 
-	if ((smsc47m1_read_value(new_client, SMSC47M1_REG_TPIN(0)) & 0x05)
-	    == 0x05) {
+	if (fan1) {
 		device_create_file(&new_client->dev, &dev_attr_fan1_input);
 		device_create_file(&new_client->dev, &dev_attr_fan1_min);
 		device_create_file(&new_client->dev, &dev_attr_fan1_div);
@@ -443,8 +459,7 @@
 		dev_dbg(&new_client->dev, "Fan 1 not enabled by hardware, "
 			"skipping\n");
 
-	if ((smsc47m1_read_value(new_client, SMSC47M1_REG_TPIN(1)) & 0x05)
-	    == 0x05) {
+	if (fan2) {
 		device_create_file(&new_client->dev, &dev_attr_fan2_input);
 		device_create_file(&new_client->dev, &dev_attr_fan2_min);
 		device_create_file(&new_client->dev, &dev_attr_fan2_div);
@@ -452,15 +467,13 @@
 		dev_dbg(&new_client->dev, "Fan 2 not enabled by hardware, "
 			"skipping\n");
 
-	if ((smsc47m1_read_value(new_client, SMSC47M1_REG_PPIN(0)) & 0x05)
-	    == 0x04) {
+	if (pwm1) {
 		device_create_file(&new_client->dev, &dev_attr_pwm1);
 		device_create_file(&new_client->dev, &dev_attr_pwm1_enable);
 	} else
 		dev_dbg(&new_client->dev, "PWM 1 not enabled by hardware, "
 			"skipping\n");
-	if ((smsc47m1_read_value(new_client, SMSC47M1_REG_PPIN(1)) & 0x05)
-	    == 0x04) {
+	if (pwm2) {
 		device_create_file(&new_client->dev, &dev_attr_pwm2);
 		device_create_file(&new_client->dev, &dev_attr_pwm2_enable);
 	} else
