Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263237AbVCKJNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263237AbVCKJNy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 04:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263238AbVCKJNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 04:13:54 -0500
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:51217 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S263237AbVCKJNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 04:13:41 -0500
Date: Fri, 11 Mar 2005 10:13:58 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: Josh Boyer <jdub@us.ibm.com>, Gred Knorr <kraxel@bytesex.org>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [01/11] fix amd64 2.6.11 oops on modprobe (saa7110)
Message-Id: <20050311101358.79d216e7.khali@linux-fr.org>
In-Reply-To: <20050311075723.GB29099@kroah.com>
References: <20050310230519.GA22112@kroah.com>
	<20050310230753.GB22112@kroah.com>
	<1110505061.8075.3.camel@windu.rchland.ibm.com>
	<20050311075723.GB29099@kroah.com>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, all,

> > Not that I really care, but isn't there a rule that a patch "... can
> > not contain any "trivial" fixes in it (spelling changes, whitespace
> > cleanups, etc.)"?
> 
> Good point.  Jean, care to respin the patch?

Sure, sorry for the trouble.

---

This is a rewrite of the saa7110_write_block function, which was
plain broken in the case where the underlying adapter supports
I2C_FUNC_I2C. It also includes related fixes which ensure that
different parts of the driver agree on the number of registers the
chip has.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- linux-2.6.11/drivers/media/video/saa7110.c.orig	2005-03-03 08:01:14.000000000 +0100
+++ linux-2.6.11/drivers/media/video/saa7110.c	2005-03-11 10:06:09.000000000 +0100
@@ -60,8 +60,10 @@
 
 #define	I2C_SAA7110		0x9C	/* or 0x9E */
 
+#define SAA7110_NR_REG		0x35
+
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


-- 
Jean Delvare
