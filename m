Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUDNWd3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbUDNWcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:32:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:34463 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261937AbUDNWYo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:24:44 -0400
Subject: Re: [PATCH] I2C update for 2.6.5
In-Reply-To: <10819814492866@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:09 -0700
Message-Id: <1081981449409@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.5, 2004/03/26 13:52:39-08:00, khali@linux-fr.org

[PATCH] I2C: adm1021 (probably) does something VERY,VERY BAD

Quoting myself:

> 3* Drop adm1021's limit init. This was already done in the 2.4 driver
> and should have been done in 2.6 as well.

Here is a patch that does that. It also prevents bit 7 (and unused bits)
of configuration register from being reset, as was discussed before:
  http://archives.andrew.net.au/lm-sensors/msg04593.html
That second part needs to be backported to the 2.4 driver, and I will do
so.

Additionally, we get rid of a useless label.

The patch is untested (I don't own any supported chip) but quite
straightforward IMHO.


 drivers/i2c/chips/adm1021.c |   19 +++----------------
 1 files changed, 3 insertions(+), 16 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Wed Apr 14 15:14:38 2004
+++ b/drivers/i2c/chips/adm1021.c	Wed Apr 14 15:14:38 2004
@@ -98,10 +98,6 @@
 they don't quite work like a thermostat the way the LM75 does.  I.e., 
 a lower temp than THYST actually triggers an alarm instead of 
 clearing it.  Weird, ey?   --Phil  */
-#define adm1021_INIT_TOS		60
-#define adm1021_INIT_THYST		20
-#define adm1021_INIT_REMOTE_TOS		60
-#define adm1021_INIT_REMOTE_THYST	20
 
 /* Each client has this additional data */
 struct adm1021_data {
@@ -306,7 +302,7 @@
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
-		goto error3;
+		goto error1;
 
 	/* Initialize the ADM1021 chip */
 	adm1021_init_client(new_client);
@@ -324,7 +320,6 @@
 
 	return 0;
 
-error3:
 error1:
 	kfree(new_client);
 error0:
@@ -333,17 +328,9 @@
 
 static void adm1021_init_client(struct i2c_client *client)
 {
-	/* Initialize the adm1021 chip */
-	adm1021_write_value(client, ADM1021_REG_TOS_W,
-			    adm1021_INIT_TOS);
-	adm1021_write_value(client, ADM1021_REG_THYST_W,
-			    adm1021_INIT_THYST);
-	adm1021_write_value(client, ADM1021_REG_REMOTE_TOS_W,
-			    adm1021_INIT_REMOTE_TOS);
-	adm1021_write_value(client, ADM1021_REG_REMOTE_THYST_W,
-			    adm1021_INIT_REMOTE_THYST);
 	/* Enable ADC and disable suspend mode */
-	adm1021_write_value(client, ADM1021_REG_CONFIG_W, 0);
+	adm1021_write_value(client, ADM1021_REG_CONFIG_W,
+		adm1021_read_value(client, ADM1021_REG_CONFIG_R) & 0xBF);
 	/* Set Conversion rate to 1/sec (this can be tinkered with) */
 	adm1021_write_value(client, ADM1021_REG_CONV_RATE_W, 0x04);
 }

