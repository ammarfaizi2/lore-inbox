Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVAYHlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVAYHlt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 02:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVAYHlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 02:41:49 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:7589 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261856AbVAYHlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 02:41:18 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-input@atrey.karlin.mff.cuni.cz
Subject: i8042 access timings
Date: Tue, 25 Jan 2005 02:41:14 -0500
User-Agent: KMail/1.7.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501250241.14695.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently there was a patch from Alan regarding access timing violations
in i8042. It made me curious as we only wait between accesses to status
register but not data register. I peeked into FreeBSD code and they use
delays to access both registers and I wonder if that's the piece that
makes i8042 mysteriously fail on some boards.

Anyway, regardless of whether access to data register should be done with
delay as well there seem to be another timing access violation - in
i8042_command we do i8042_wait_read which reads STR and then immediately
do i8042_read_status to check AUXDATA bit.

Does the patch below makes any sense?

-- 
Dmitry

===== drivers/input/serio/i8042.c 1.79 vs edited =====
--- 1.79/drivers/input/serio/i8042.c	2005-01-25 00:54:50 -05:00
+++ edited/drivers/input/serio/i8042.c	2005-01-25 02:04:56 -05:00
@@ -137,8 +137,8 @@
 static int i8042_wait_read(void)
 {
 	int i = 0;
-	while ((~i8042_read_status() & I8042_STR_OBF) && (i < I8042_CTL_TIMEOUT)) {
-		udelay(50);
+	while ((~i8042_read_status() & I8042_STR_OBF) && i < I8042_CTL_TIMEOUT) {
+		udelay(I8042_STR_DELAY);
 		i++;
 	}
 	return -(i == I8042_CTL_TIMEOUT);
@@ -147,8 +147,8 @@
 static int i8042_wait_write(void)
 {
 	int i = 0;
-	while ((i8042_read_status() & I8042_STR_IBF) && (i < I8042_CTL_TIMEOUT)) {
-		udelay(50);
+	while ((i8042_read_status() & I8042_STR_IBF) && i < I8042_CTL_TIMEOUT) {
+		udelay(I8042_STR_DELAY);
 		i++;
 	}
 	return -(i == I8042_CTL_TIMEOUT);
@@ -162,17 +162,20 @@
 static int i8042_flush(void)
 {
 	unsigned long flags;
-	unsigned char data;
+	unsigned char str, data;
 	int i = 0;
 
 	spin_lock_irqsave(&i8042_lock, flags);
 
-	while ((i8042_read_status() & I8042_STR_OBF) && (i++ < I8042_BUFFER_SIZE)) {
-		udelay(50);
+	do {
+		str = i8042_read_status();
+		if (~str & I8042_STR_OBF)
+			break;
+		udelay(I8042_DATA_DELAY);
 		data = i8042_read_data();
-		dbg("%02x <- i8042 (flush, %s)", data,
-			i8042_read_status() & I8042_STR_AUXDATA ? "aux" : "kbd");
-	}
+		dbg("%02x <- i8042 (flush, %s)", data, str & I8042_STR_AUXDATA ? "aux" : "kbd");
+		udelay(I8042_STR_DELAY);
+	} while (i++ < I8042_BUFFER_SIZE);
 
 	spin_unlock_irqrestore(&i8042_lock, flags);
 
@@ -190,6 +193,7 @@
 static int i8042_command(unsigned char *param, int command)
 {
 	unsigned long flags;
+	unsigned char str;
 	int retval = 0, i = 0;
 
 	if (i8042_noloop && command == I8042_CMD_AUX_LOOP)
@@ -213,7 +217,10 @@
 	if (!retval)
 		for (i = 0; i < ((command >> 8) & 0xf); i++) {
 			if ((retval = i8042_wait_read())) break;
-			if (i8042_read_status() & I8042_STR_AUXDATA)
+			udelay(I8042_STR_DELAY);
+			str = i8042_read_status();
+			udelay(I8042_DATA_DELAY);
+			if (str & I8042_STR_AUXDATA)
 				param[i] = ~i8042_read_data();
 			else
 				param[i] = i8042_read_data();
@@ -424,6 +431,7 @@
 		ret = 0;
 		goto out;
 	}
+	udelay(I8042_DATA_DELAY);
 	data = i8042_read_data();
 	spin_unlock_irqrestore(&i8042_lock, flags);
 
===== drivers/input/serio/i8042.h 1.12 vs edited =====
--- 1.12/drivers/input/serio/i8042.h	2005-01-22 02:22:51 -05:00
+++ edited/drivers/input/serio/i8042.h	2005-01-25 01:44:36 -05:00
@@ -30,12 +30,19 @@
 #endif
 
 /*
- * This is in 50us units, the time we wait for the i8042 to react. This
+ * i8042 I/O recovery times
+ */
+#define I8042_STR_DELAY		20
+#define I8042_DATA_DELAY	7
+
+
+/*
+ * This is in 20us units, the time we wait for the i8042 to react. This
  * has to be long enough for the i8042 itself to timeout on sending a byte
  * to a non-existent mouse.
  */
 
-#define I8042_CTL_TIMEOUT	10000
+#define I8042_CTL_TIMEOUT	25000
 
 /*
  * When the device isn't opened and it's interrupts aren't used, we poll it at
