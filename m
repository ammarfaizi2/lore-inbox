Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUDNWs1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUDNWmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:42:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:55967 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261993AbUDNWZV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:25:21 -0400
Subject: Re: [PATCH] I2C update for 2.6.5
In-Reply-To: <10819814504116@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:10 -0700
Message-Id: <10819814503946@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.7, 2004/03/30 14:26:19-08:00, khali@linux-fr.org

[PATCH] I2C: Prevent misdetections in adm1021 driver

Yet another patch for the adm1021 chip driver. I refined the detection
code a bit in order to prevent chip misdetection. Some chips handled
by the adm1021 driver are hard to detect and identify (LM84 and
MAX1617) so we tend to accept any chip it the valid I2C address range
as one of these. It has caused much, much trouble already. See these
threads for example:

http://archives.andrew.net.au/lm-sensors/msg04448.html
http://archives.andrew.net.au/lm-sensors/msg04624.html
http://archives.andrew.net.au/lm-sensors/msg05560.html
http://archives.andrew.net.au/lm-sensors/msg05871.html
http://archives.andrew.net.au/lm-sensors/msg06754.html
http://archives.andrew.net.au/lm-sensors/msg07181.html

And this ticket:

http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=1434

So I thought it would be good to prevent this kind of problems if
possible, and read the 8 datasheets again in search for ways to refine
the detection method.

I changed it in sensors-detect already, and had positive feedback from
one user. I will also backport the changes to the driver to the 2.4
version we have in CVS.

What the patch does:

* Use unused bits of two more registers (configuration and conversion
rate) to reduce misdetections.

* Return with -ENODEV if the detection fails.

* Change the order in which we try to identify the chips. We better
finish with the LM84 and the MAX1617, in this order, because they are
harder to identify and are more likely to result in false positives.

* Refine LM84 detection. The LM84 has less features than the other
chips(chip cannot be stopped, conversion rate cannot be set, no low
limits) so it has extra unused bits.

* Do not intialize the chip if it was detected as an LM84. This one
cannot be stopped so why would we try to start it again? And as said
right before, conversion rate isn't changeable either.

Note that I couldn't test the changes on any supported chip since I
don't own any. Still I believe that they should be applied, since the
current code already broke one system and seriously harmed several
others. I believe it's not critical if it turns out that we reject
valid chips (which shouldn't happen if the datasheets are correct,
anyway). People will simply let us know and we'll be less restrictive.
In the meantime they can force the driver. That said, testers are
welcome, as usual.


 drivers/i2c/chips/adm1021.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Wed Apr 14 15:14:28 2004
+++ b/drivers/i2c/chips/adm1021.c	Wed Apr 14 15:14:28 2004
@@ -246,8 +246,12 @@
 
 	/* Now, we do the remaining detection. */
 	if (kind < 0) {
-		if ((adm1021_read_value(new_client, ADM1021_REG_STATUS) & 0x03) != 0x00)
+		if ((adm1021_read_value(new_client, ADM1021_REG_STATUS) & 0x03) != 0x00
+		 || (adm1021_read_value(new_client, ADM1021_REG_CONFIG_R) & 0x3F) != 0x00
+		 || (adm1021_read_value(new_client, ADM1021_REG_CONV_RATE_R) & 0xF8) != 0x00) {
+			err = -ENODEV;
 			goto error1;
+		}
 	}
 
 	/* Determine the chip type. */
@@ -265,11 +269,14 @@
 		else if ((i == 0x4d) &&
 			 (adm1021_read_value(new_client, ADM1021_REG_DEV_ID) == 0x01))
 			kind = max1617a;
-		/* LM84 Mfr ID in a different place */
-		else if (adm1021_read_value(new_client, ADM1021_REG_CONV_RATE_R) == 0x00)
-			kind = lm84;
 		else if (i == 0x54)
 			kind = mc1066;
+		/* LM84 Mfr ID in a different place, and it has more unused bits */
+		else if (adm1021_read_value(new_client, ADM1021_REG_CONV_RATE_R) == 0x00
+		      && (kind == 0 /* skip extra detection */
+		       || ((adm1021_read_value(new_client, ADM1021_REG_CONFIG_R) & 0x7F) == 0x00
+			&& (adm1021_read_value(new_client, ADM1021_REG_STATUS) & 0xAB) == 0x00)))
+			kind = lm84;
 		else
 			kind = max1617;
 	}
@@ -305,7 +312,8 @@
 		goto error1;
 
 	/* Initialize the ADM1021 chip */
-	adm1021_init_client(new_client);
+	if (kind != lm84)
+		adm1021_init_client(new_client);
 
 	/* Register sysfs hooks */
 	device_create_file(&new_client->dev, &dev_attr_temp1_max);

