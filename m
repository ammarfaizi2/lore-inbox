Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVAYWOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVAYWOk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVAYWG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:06:26 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:58382 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262183AbVAYWDo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:03:44 -0500
Date: Tue, 25 Jan 2005 23:03:48 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>
Cc: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>, Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 2.6] I2C: Prevent buffer overflow on SMBus block read in
 i2c-viapro
Message-Id: <20050125230348.294aa0b9.khali@linux-fr.org>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Linus, all,

I just hit a buffer overflow while playing around with i2cdump and
i2c-viapro through i2c-dev. This is caused by a missing length check on
a buffer operation when doing a SMBus block read in the i2c-viapro
driver. The problem was already known and had been fixed upon report by
Sergey Vlasov back in August 2003 in lm_sensors (2.4 kernel version of
the driver) but for some reason it was never ported to the 2.6 kernel
version.

I am not a security expert but I would guess that such a buffer overflow
could possibly be used to run arbitrary code in kernel space from user
space through i2c-dev. The severity obviously depends on the permisions
set on the i2c device files in /dev. Maybe it wouldn't be a bad idea to
push this patch upstream rather sooner than later.

While I was at it, I also changed a similar size check (for SMBus block
write this time) in the same driver to use the correct constant
I2C_SMBUS_BLOCK_MAX instead of its current numerical value. This doesn't
change a thing at the moment but prevents another potential buffer
overflow in case the value of I2C_SMBUS_BLOCK_MAX were to be changed in
the future (admittedly unlikely though).

Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11-rc1-bk8/drivers/i2c/busses/i2c-viapro.c.orig	2005-01-21 20:05:05.000000000 +0100
+++ linux-2.6.11-rc1-bk8/drivers/i2c/busses/i2c-viapro.c	2005-01-25 21:45:01.000000000 +0100
@@ -233,8 +233,8 @@
 			len = data->block[0];
 			if (len < 0)
 				len = 0;
-			if (len > 32)
-				len = 32;
+			if (len > I2C_SMBUS_BLOCK_MAX)
+				len = I2C_SMBUS_BLOCK_MAX;
 			outb_p(len, SMBHSTDAT0);
 			i = inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
 			for (i = 1; i <= len; i++)
@@ -268,6 +268,8 @@
 		break;
 	case VT596_BLOCK_DATA:
 		data->block[0] = inb_p(SMBHSTDAT0);
+		if (data->block[0] > I2C_SMBUS_BLOCK_MAX)
+			data->block[0] = I2C_SMBUS_BLOCK_MAX;
 		i = inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
 		for (i = 1; i <= data->block[0]; i++)
 			data->block[i] = inb_p(SMBBLKDAT);


-- 
Jean Delvare
http://khali.linux-fr.org/
