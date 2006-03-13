Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWCMUct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWCMUct (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWCMUct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:32:49 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:23059 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932450AbWCMUcs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:32:48 -0500
Date: Mon, 13 Mar 2006 21:32:49 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Subject: [PATCH 5/8] adv7175: Drop unused register cache
Message-Id: <20060313213249.6f9bd06c.khali@linux-fr.org>
In-Reply-To: <20060313210933.88a42375.khali@linux-fr.org>
References: <20060313210933.88a42375.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the adv7175 register cache, as it is only written to and never
read back from. This saves 128 bytes of memory and slightly speeds up
the register writes.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/media/video/adv7175.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

--- linux-2.6.16-rc5.orig/drivers/media/video/adv7175.c	2006-03-01 21:10:12.000000000 +0100
+++ linux-2.6.16-rc5/drivers/media/video/adv7175.c	2006-03-01 21:10:14.000000000 +0100
@@ -67,8 +67,6 @@
 /* ----------------------------------------------------------------------- */
 
 struct adv7175 {
-	unsigned char reg[128];
-
 	int norm;
 	int input;
 	int enable;
@@ -94,9 +92,6 @@
 	       u8                 reg,
 	       u8                 value)
 {
-	struct adv7175 *encoder = i2c_get_clientdata(client);
-
-	encoder->reg[reg] = value;
 	return i2c_smbus_write_byte_data(client, reg, value);
 }
 
@@ -119,7 +114,6 @@
 	 * the adapter understands raw I2C */
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		/* do raw I2C, not smbus compatible */
-		struct adv7175 *encoder = i2c_get_clientdata(client);
 		struct i2c_msg msg;
 		u8 block_data[32];
 
@@ -130,8 +124,8 @@
 			msg.len = 0;
 			block_data[msg.len++] = reg = data[0];
 			do {
-				block_data[msg.len++] =
-				    encoder->reg[reg++] = data[1];
+				block_data[msg.len++] = data[1];
+				reg++;
 				len -= 2;
 				data += 2;
 			} while (len >= 2 && data[0] == reg &&

-- 
Jean Delvare
