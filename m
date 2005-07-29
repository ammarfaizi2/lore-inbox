Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbVG3AWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbVG3AWW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbVG2TTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:19:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:64942 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262746AbVG2TQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:16:23 -0400
Date: Fri, 29 Jul 2005 12:15:00 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ladis@linux-mips.org
Subject: [patch 07/29] I2C: ds1337 - fix 12/24 hour mode bug
Message-ID: <20050729191500.GI5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ladislav Michl <ladis@linux-mips.org>

DS1339 manual, page 6, chapter Date and time operation:
  The DS1339 can be run in either 12-hour or 24-hour mode. Bit 6 of the
  hours register is defined as the 12-hour or 24-hour mode-select bit.
  When high, the 12-hour mode is selected.
 
Patch below makes ds1337 driver work as documented in manual.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/i2c/chips/ds1337.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- gregkh-2.6.orig/drivers/i2c/chips/ds1337.c	2005-07-29 11:30:00.000000000 -0700
+++ gregkh-2.6/drivers/i2c/chips/ds1337.c	2005-07-29 11:34:02.000000000 -0700
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

--
