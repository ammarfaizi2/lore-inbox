Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266896AbUJTCkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbUJTCkd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 22:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267923AbUJTAi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:38:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:17076 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267988AbUJTATe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:34 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <1098231505320@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:25 -0700
Message-Id: <10982315051069@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1939.9.5, 2004/09/29 13:29:06-07:00, khali@linux-fr.org

[PATCH] I2C: Store lm83 and lm90 temperatures in signed

Back when I wrote the lm83 and lm90 drivers, I decided to use unsigned
variables to store temperature values as mirrored from the chipset
registers. I wonder why, since the registers use signed values
themselves. The patch below changes the variables back to signed types,
so as to simplify the conversions made by the driver, making them faster
and easier to understand.

Additionally, the lm90 driver was lacking boundary checkings and proper
rounding when writing temperature limits to the chipset, so I added
these. I also reworded the comments about internal temperature values
representation for all chipsets.

Tested to work fine on my (LM90-compatible) ADM1032 chip. lm83 patch
untested, but it is more simple and directly copied from the lm90, so I
am confident it works fine too.


Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/lm83.c |   17 +++++++++--------
 drivers/i2c/chips/lm90.c |   39 ++++++++++++++++++++++-----------------
 2 files changed, 31 insertions(+), 25 deletions(-)


diff -Nru a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c	2004-10-19 16:54:35 -07:00
+++ b/drivers/i2c/chips/lm83.c	2004-10-19 16:54:35 -07:00
@@ -80,13 +80,14 @@
 
 /*
  * Conversions and various macros
- * The LM83 uses signed 8-bit values.
+ * The LM83 uses signed 8-bit values with LSB = 1 degree Celcius.
  */
 
-#define TEMP_FROM_REG(val)	(((val) > 127 ? (val) - 0x100 : (val)) * 1000)
-#define TEMP_TO_REG(val)	((val) <= -50000 ? -50 + 0x100 : (val) >= 127000 ? 127 : \
-				 (val) > -500 ? ((val)+500) / 1000 : \
-				 ((val)-500) / 1000 + 0x100)
+#define TEMP_FROM_REG(val)	((val) * 1000)
+#define TEMP_TO_REG(val)	((val) <= -128000 ? -128 : \
+				 (val) >= 127000 ? 127 : \
+				 (val) < 0 ? ((val) - 500) / 1000 : \
+				 ((val) + 500) / 1000)
 
 static const u8 LM83_REG_R_TEMP[] = {
 	LM83_REG_R_LOCAL_TEMP,
@@ -142,9 +143,9 @@
 	unsigned long last_updated; /* in jiffies */
 
 	/* registers values */
-	u8 temp_input[4];
-	u8 temp_high[4];
-	u8 temp_crit;
+	s8 temp_input[4];
+	s8 temp_high[4];
+	s8 temp_crit;
 	u16 alarms; /* bitvector, combined */
 };
 
diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	2004-10-19 16:54:35 -07:00
+++ b/drivers/i2c/chips/lm90.c	2004-10-19 16:54:35 -07:00
@@ -127,19 +127,24 @@
 
 /*
  * Conversions and various macros
- * The LM90 uses signed 8-bit values for the local temperatures,
- * and signed 11-bit values for the remote temperatures (except
- * T_CRIT). Note that TEMP2_TO_REG does not round values, but
- * stick to the nearest lower value instead. Fixing it is just
- * not worth it.
- */
-
-#define TEMP1_FROM_REG(val)	((val & 0x80 ? val-0x100 : val) * 1000)
-#define TEMP1_TO_REG(val)	((val < 0 ? val+0x100*1000 : val) / 1000)
-#define TEMP2_FROM_REG(val)	(((val & 0x8000 ? val-0x10000 : val) >> 5) * 125)
-#define TEMP2_TO_REG(val)	((((val / 125) << 5) + (val < 0 ? 0x10000 : 0)) & 0xFFE0)
-#define HYST_FROM_REG(val)	(val * 1000)
-#define HYST_TO_REG(val)	(val <= 0 ? 0 : val >= 31000 ? 31 : val / 1000)
+ * For local temperatures and limits, critical limits and the hysteresis
+ * value, the LM90 uses signed 8-bit values with LSB = 1 degree Celcius.
+ * For remote temperatures and limits, it uses signed 11-bit values with
+ * LSB = 0.125 degree Celcius, left-justified in 16-bit registers.
+ */
+
+#define TEMP1_FROM_REG(val)	((val) * 1000)
+#define TEMP1_TO_REG(val)	((val) <= -128000 ? -128 : \
+				 (val) >= 127000 ? 127 : \
+				 (val) < 0 ? ((val) - 500) / 1000 : \
+				 ((val) + 500) / 1000)
+#define TEMP2_FROM_REG(val)	((val) / 32 * 125)
+#define TEMP2_TO_REG(val)	((val) <= -128000 ? 0x8000 : \
+				 (val) >= 127875 ? 0x7FE0 : \
+				 (val) < 0 ? ((val) - 62) / 125 * 32 : \
+				 ((val) + 62) / 125 * 32)
+#define HYST_TO_REG(val)	((val) <= 0 ? 0 : (val) >= 30500 ? 31 : \
+				 ((val) + 500) / 1000)
 
 /*
  * Functions declaration
@@ -176,9 +181,9 @@
 	unsigned long last_updated; /* in jiffies */
 
 	/* registers values */
-	u8 temp_input1, temp_low1, temp_high1; /* local */
-	u16 temp_input2, temp_low2, temp_high2; /* remote, combined */
-	u8 temp_crit1, temp_crit2;
+	s8 temp_input1, temp_low1, temp_high1; /* local */
+	s16 temp_input2, temp_low2, temp_high2; /* remote, combined */
+	s8 temp_crit1, temp_crit2;
 	u8 temp_hyst;
 	u16 alarms; /* bitvector, combined */
 };
@@ -243,7 +248,7 @@
 { \
 	struct lm90_data *data = lm90_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP1_FROM_REG(data->basereg) \
-		       - HYST_FROM_REG(data->temp_hyst)); \
+		       - TEMP1_FROM_REG(data->temp_hyst)); \
 }
 show_temp_hyst(temp_hyst1, temp_crit1);
 show_temp_hyst(temp_hyst2, temp_crit2);

