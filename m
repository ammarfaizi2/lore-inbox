Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262350AbUKKSP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbUKKSP6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 13:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbUKKSOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 13:14:04 -0500
Received: from ltgp.iram.es ([150.214.224.138]:13184 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S262327AbUKKSMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 13:12:41 -0500
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 11 Nov 2004 19:09:02 +0100
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Recent I2C "dead code removal" breaks pmac sound.
Message-ID: <20041111180902.GA8697@iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,
	
a recent patch to drivers/i2c/i2c-core.c removed a bunch of
functions because they were unused; i2c_smbus_write_block_data
was in the lot. I happen to have a different definition of dead
code since grepping for it reveals (in sound/ppc/pmac.h):

#define snd_pmac_keywest_write(i2c,cmd,len,data) i2c_smbus_write_block_data((i2c)->client, cmd, len, data)

I only get a link time error since the removed functions are still
declared in include/linux/i2c.h, and that is certainly wrong.

For now I have successfully compiled with the following patch
which ressuscitates the function I need. In a recent pull, the 
offending cset is 1.2114.2.8 from November 5th by arjan.

This patch is _not_ final, but I don't know what sould be done:
excluding the cset, or applying the following and making
the include file match the existing functions, or something
completely different?

	Gabriel


===== drivers/i2c/i2c-core.c 1.58 vs edited =====
--- 1.58/drivers/i2c/i2c-core.c	2004-11-05 20:49:20 +01:00
+++ edited/drivers/i2c/i2c-core.c	2004-11-11 18:33:23 +01:00
@@ -1021,6 +1021,22 @@
 	                      I2C_SMBUS_WORD_DATA,&data);
 }
 
+/* Returns the number of bytes transferred */
+s32 i2c_smbus_write_block_data(struct i2c_client *client, u8 command,
+			       u8 length, u8 *values)
+{
+	union i2c_smbus_data data;
+	int i;
+	if (length > I2C_SMBUS_BLOCK_MAX)
+		length = I2C_SMBUS_BLOCK_MAX;
+	for (i = 1; i <= length; i++)
+		data.block[i] = values[i-1];
+	data.block[0] = length;
+	return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
+			      I2C_SMBUS_WRITE,command,
+			      I2C_SMBUS_BLOCK_DATA,&data);
+}
+
 /* Returns the number of read bytes */
 s32 i2c_smbus_block_process_call(struct i2c_client *client, u8 command, u8 length, u8 *values)
 {
@@ -1279,6 +1295,7 @@
 EXPORT_SYMBOL(i2c_smbus_write_byte_data);
 EXPORT_SYMBOL(i2c_smbus_read_word_data);
 EXPORT_SYMBOL(i2c_smbus_write_word_data);
+EXPORT_SYMBOL(i2c_smbus_write_block_data);
 EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
 
 EXPORT_SYMBOL(i2c_get_functionality);


