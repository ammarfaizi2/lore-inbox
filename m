Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVAHGbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVAHGbQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVAHGae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:30:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:14982 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261926AbVAHFsq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:46 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <11051627731563@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:34 -0800
Message-Id: <1105162774441@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.47, 2005/01/06 13:55:26-08:00, khali@linux-fr.org

[PATCH] I2C: Fix MAX6657/8/9 detection in lm90

I received no additional feedback about my MAX6657/8/9 detection fix.
Since it was correct for the only chips I got a report for, I propose we
apply it. After all, maybe people don't know they have such a chip
because the detection was previously not correct.

The patch below is the one I sent to the LM Sensors and Linux Kernel
mailing-lists two weeks ago, unchanged. Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/lm90.c |   28 ++++++++++++++++++++--------
 1 files changed, 20 insertions(+), 8 deletions(-)


diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	2005-01-07 14:54:33 -08:00
+++ b/drivers/i2c/chips/lm90.c	2005-01-07 14:54:33 -08:00
@@ -35,12 +35,13 @@
  * Among others, it has a higher accuracy than the LM90, much like the
  * LM86 does.
  *
- * This driver also supports the MAX6657 and MAX6658, sensor chips made
- * by Maxim. These chips are similar to the LM86. Complete datasheet
- * can be obtained at Maxim's website at:
+ * This driver also supports the MAX6657, MAX6658 and MAX6659 sensor
+ * chips made by Maxim. These chips are similar to the LM86. Complete
+ * datasheet can be obtained at Maxim's website at:
  *   http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
- * Note that there is no way to differenciate between both chips (but
- * no need either).
+ * Note that there is no easy way to differenciate between the three
+ * variants. The extra address and features of the MAX6659 are not
+ * supported by this driver.
  *
  * Since the LM90 was the first chipset supported by this driver, most
  * comments will refer to this chipset, but are actually general and
@@ -70,9 +71,11 @@
 
 /*
  * Addresses to scan
- * Address is fully defined internally and cannot be changed.
+ * Address is fully defined internally and cannot be changed except for
+ * MAX6659.
  * LM86, LM89, LM90, LM99, ADM1032, MAX6657 and MAX6658 have address 0x4c.
  * LM89-1, and LM99-1 have address 0x4d.
+ * MAX6659 can have address 0x4c, 0x4d or 0x4e (unsupported).
  */
 
 static unsigned short normal_i2c[] = { 0x4c, 0x4d, I2C_CLIENT_END };
@@ -386,8 +389,17 @@
 			}
 		} else
 		if (man_id == 0x4D) { /* Maxim */
-			if (address == 0x4C
-			 && (reg_config1 & 0x1F) == 0
+			/*
+			 * The Maxim variants do NOT have a chip_id register.
+			 * Reading from that address will return the last read
+			 * value, which in our case is those of the man_id
+			 * register. Likewise, the config1 register seems to
+			 * lack a low nibble, so the value will be those of the
+			 * previous read, so in our case those of the man_id
+			 * register.
+			 */
+			if (chip_id == man_id
+			 && (reg_config1 & 0x1F) == (man_id & 0x0F)
 			 && reg_convrate <= 0x09) {
 			 	kind = max6657;
 			}

