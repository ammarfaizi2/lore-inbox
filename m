Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVGYIYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVGYIYn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 04:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVGYIYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 04:24:42 -0400
Received: from smtp.seznam.cz ([212.80.76.43]:58090 "HELO smtp.seznam.cz")
	by vger.kernel.org with SMTP id S261812AbVGYIYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 04:24:40 -0400
Date: Mon, 25 Jul 2005 10:24:36 +0200
To: Greg KH <gregkh@suse.de>
Cc: James Chapman <jchapman@katalix.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] I2C: ds1337 - fix 12/24 hour mode bug
Message-ID: <20050725082436.GA10186@orphique>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Ladislav Michl <ladis@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DS1339 manual, page 6, chapter Date and time operation:
  The DS1339 can be run in either 12-hour or 24-hour mode. Bit 6 of the
  hours register is defined as the 12-hour or 24-hour mode-select bit.
  When high, the 12-hour mode is selected.
 
Patch below makes ds1337 driver work as documented in manual.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

drivers/i2c/chips/ds1337.c: needs update
Index: drivers/i2c/chips/ds1337.c
===================================================================
--- 19f75ba1af6b4b16744159e62fbb7decab5553ef/drivers/i2c/chips/ds1337.c  (mode:100644)
+++ uncommitted/drivers/i2c/chips/ds1337.c  (mode:100644)
@@ -165,7 +165,7 @@
 	buf[0] = 0;		/* reg offset */
 	buf[1] = BIN2BCD(dt->tm_sec);
 	buf[2] = BIN2BCD(dt->tm_min);
-	buf[3] = BIN2BCD(dt->tm_hour) | (1 << 6);
+	buf[3] = BIN2BCD(dt->tm_hour);
 	buf[4] = BIN2BCD(dt->tm_wday) + 1;
 	buf[5] = BIN2BCD(dt->tm_mday);
 	buf[6] = BIN2BCD(dt->tm_mon) + 1;
@@ -344,9 +344,9 @@
 
 	/* Ensure that device is set in 24-hour mode */
 	val = i2c_smbus_read_byte_data(client, DS1337_REG_HOUR);
-	if ((val >= 0) && (val & (1 << 6)) == 0)
+	if ((val >= 0) && (val & (1 << 6)))
 		i2c_smbus_write_byte_data(client, DS1337_REG_HOUR,
-					  val | (1 << 6));
+					  val & 0x3f);
 }
 
 static int ds1337_detach_client(struct i2c_client *client)
