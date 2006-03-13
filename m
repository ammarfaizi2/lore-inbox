Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWCMUay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWCMUay (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWCMUax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:30:53 -0500
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:54800 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932446AbWCMUaw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:30:52 -0500
Date: Mon, 13 Mar 2006 21:30:53 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Subject: [PATCH 3/8] saa7114: Fix i2c block write
Message-Id: <20060313213053.328ffac0.khali@linux-fr.org>
In-Reply-To: <20060313210933.88a42375.khali@linux-fr.org>
References: <20060313210933.88a42375.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the i2c block write mode of the saa7114 driver. A previous code
change accidentally commented out a local variable increment, which
should have been kept, causing the register writes over the I2C bus
to never be batched, replacing any attempted block write by slower,
individual write transactions.

Also drop the commented out code, as it only adds to confusion.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/media/video/saa7114.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- linux-2.6.16-rc5.orig/drivers/media/video/saa7114.c	2006-03-01 21:09:59.000000000 +0100
+++ linux-2.6.16-rc5/drivers/media/video/saa7114.c	2006-03-01 21:10:10.000000000 +0100
@@ -138,9 +138,6 @@
 	       u8                 reg,
 	       u8                 value)
 {
-	/*struct saa7114 *decoder = i2c_get_clientdata(client);*/
-
-	/*decoder->reg[reg] = value;*/
 	return i2c_smbus_write_byte_data(client, reg, value);
 }
 
@@ -156,7 +153,6 @@
 	 * the adapter understands raw I2C */
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		/* do raw I2C, not smbus compatible */
-		/*struct saa7114 *decoder = i2c_get_clientdata(client);*/
 		struct i2c_msg msg;
 		u8 block_data[32];
 
@@ -167,8 +163,8 @@
 			msg.len = 0;
 			block_data[msg.len++] = reg = data[0];
 			do {
-				block_data[msg.len++] =
-				    /*decoder->reg[reg++] =*/ data[1];
+				block_data[msg.len++] = data[1];
+				reg++;
 				len -= 2;
 				data += 2;
 			} while (len >= 2 && data[0] == reg &&

-- 
Jean Delvare
