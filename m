Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263410AbVCJXQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263410AbVCJXQt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 18:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbVCJXQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:16:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:20954 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263379AbVCJXKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 18:10:11 -0500
Date: Thu, 10 Mar 2005 15:07:53 -0800
From: Greg KH <greg@kroah.com>
To: khali@linux-fr.org, kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: [01/11] fix amd64 2.6.11 oops on modprobe (saa7110)
Message-ID: <20050310230753.GB22112@kroah.com>
References: <20050310230519.GA22112@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310230519.GA22112@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------

This is a rewrite of the saa7110_write_block function, which was plain
broken in the case where the underlying adapter supports I2C_FUNC_I2C.
It also includes related fixes which ensure that different parts of the
driver agree on the number of registers the chip has.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- linux-2.6.11-bk3/drivers/media/video/saa7110.c.orig	Tue Mar  8 10:27:15 2005
+++ linux-2.6.11-bk3/drivers/media/video/saa7110.c	Tue Mar  8 12:02:45 2005
@@ -58,10 +58,12 @@
 #define SAA7110_MAX_INPUT	9	/* 6 CVBS, 3 SVHS */
 #define SAA7110_MAX_OUTPUT	0	/* its a decoder only */
 
-#define	I2C_SAA7110		0x9C	/* or 0x9E */
+#define I2C_SAA7110		0x9C	/* or 0x9E */
+
+#define SAA7110_NR_REG		0x35
 
 struct saa7110 {
-	unsigned char reg[54];
+	u8 reg[SAA7110_NR_REG];
 
 	int norm;
 	int input;
@@ -95,31 +97,28 @@
 		     unsigned int       len)
 {
 	int ret = -1;
-	u8 reg = *data++;
+	u8 reg = *data;		/* first register to write to */
 
-	len--;
+	/* Sanity check */
+	if (reg + (len - 1) > SAA7110_NR_REG)
+		return ret;
 
 	/* the saa7110 has an autoincrement function, use it if
 	 * the adapter understands raw I2C */
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		struct saa7110 *decoder = i2c_get_clientdata(client);
 		struct i2c_msg msg;
-		u8 block_data[54];
 
-		msg.len = 0;
-		msg.buf = (char *) block_data;
+		msg.len = len;
+		msg.buf = (char *) data;
 		msg.addr = client->addr;
-		msg.flags = client->flags;
-		while (len >= 1) {
-			msg.len = 0;
-			block_data[msg.len++] = reg;
-			while (len-- >= 1 && msg.len < 54)
-				block_data[msg.len++] =
-				    decoder->reg[reg++] = *data++;
-			ret = i2c_transfer(client->adapter, &msg, 1);
-		}
+		msg.flags = 0;
+		ret = i2c_transfer(client->adapter, &msg, 1);
+
+		/* Cache the written data */
+		memcpy(decoder->reg + reg, data + 1, len - 1);
 	} else {
-		while (len-- >= 1) {
+		for (++data, --len; len; len--) {
 			if ((ret = saa7110_write(client, reg++,
 						 *data++)) < 0)
 				break;
@@ -192,7 +191,7 @@
 	return 0;
 }
 
-static const unsigned char initseq[] = {
+static const unsigned char initseq[1 + SAA7110_NR_REG] = {
 	0, 0x4C, 0x3C, 0x0D, 0xEF, 0xBD, 0xF2, 0x03, 0x00,
 	/* 0x08 */ 0xF8, 0xF8, 0x60, 0x60, 0x00, 0x86, 0x18, 0x90,
 	/* 0x10 */ 0x00, 0x59, 0x40, 0x46, 0x42, 0x1A, 0xFF, 0xDA,
