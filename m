Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVCHTYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVCHTYE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 14:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVCHTVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 14:21:34 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:21774 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261600AbVCHTPB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:15:01 -0500
Date: Tue, 8 Mar 2005 20:15:04 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Daniel Staaf <dst@bostream.nu>, LKML <linux-kernel@vger.kernel.org>,
       Andrei Mikhailovsky <andrei@arhont.com>,
       Ian Campbell <icampbell@arcom.com>,
       Ronald Bultje <rbultje@ronald.bitfreak.net>,
       Gerd Knorr <kraxel@bytesex.org>
Subject: Re: amd64 2.6.11 oops on modprobe
Message-Id: <20050308201504.6aee36d5.khali@linux-fr.org>
In-Reply-To: <422CCBF4.1060902@osdl.org>
References: <1110024688.5494.2.camel@whale.core.arhont.com>
	<422A5473.7030306@osdl.org>
	<1110115990.5611.2.camel@whale.core.arhont.com>
	<422CCBF4.1060902@osdl.org>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Randy Dunlap]
> I've been working on this with Daniel Staaf and Jean Delvare.
> Jean enabled some more/different I2C bit banging code in
> 2.6.11, and that causes callers to use it differently.

Actually credits go to Ian Campbell for noticing that i2c-algo-bit was
reporting less capabilities than it should have. Fixing this uncovered
the bug in the saa7110 driver as a side effect but still was the right
thing to do (this will let i2c chip drivers use faster i2c transfer
commands wherever possible.)

> Jean will be proposing a real patch for that obfuscated loop.

I'd like to add details on what exactly the problems were in the
original code, in the hope it can help make my patch easier to
understand. As a side note, this was by far the crapiest code I read for
the last few months.

Here's the faulty code, with my comments:

	u8 reg = *data++;
	(...)
	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
		struct saa7110 *decoder = i2c_get_clientdata(client);
		struct i2c_msg msg;
*1*		u8 block_data[54];

		msg.len = 0;
		msg.buf = (char *) block_data;
		msg.addr = client->addr;
*2*		msg.flags = client->flags;
		while (len >= 1) {
			msg.len = 0;
			block_data[msg.len++] = reg;
*3*			while (len-- >= 1 && msg.len < 54)
				block_data[msg.len++] =
*4*				    decoder->reg[reg++] = *data++;
*5*			ret = i2c_transfer(client->adapter, &msg, 1);
		}
	} (...)

1* This local buffer is not needed. The original buffer (pointed to by
data) is already properly formated for an i2c_transfer message.

2* i2c message flags and i2c client flags are essentially different
things [1], so this line doesn't make any sense. In fact, it happens
that client->flags contains I2C_CLIENT_ALLOW_USE (0x01) which will be
interpreted as I2C_M_RD as a message flag, resulting in an I2C block
*read* command instead of the expected I2C block write command. So, oops
or not, there is no chance this code would do anything useful [2].

3* The oops is here. When len == 0, the test will fail but len will
still be decreased. Because len is unsigned, this will result in a huge
positive value, so the outer while loop will not be exited as expected.
One hundred iterations later the oops occurs. Mental note: mixing while
loop condition with counter decrement sounds like a generally bad idea.
The code here clearly yields for a clean for loop.

4* Note that reg is not reset in the outer while loop, so it can take
any arbitrarily large value, while decoder->reg is only 54 bytes long.
So there is a potential buffer overrun here. More generally, the code
makes it look like a message of an arbitrarily long length can be
properly handled (split in 54-byte chunks), while several details would
actually make it fail. Also note that sending messages longer than the
number of registers makes no sense anyway, so not only the double while
loop is complex and broken, but it is also totally useless as far as I
can see.

5* Return value is not properly handled.

Considering that this code has been in there since 2003-08-21
(2.6.0-test3-bk9), I find it quite frightening that nobody noticed how
broken it was until yesterday. Another frightening fact is that the
i2c-algo-bit change made the whole Zoran-based family of devices
unusable for the past 3 months or so in -mm and maybe 1.5 month in
-bk/-rc and nobody reported. As far as I know, these boards are rather
popular. The fact that no user of such board actually tested -mm or -rc
for this period of time points out a problem. (And I am not attempting
to revive a flame war of any kind, nor am I blaming anyone in
particular, merely pointing out what I think is a serious problem.)

So here is my patch:

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
+	unsigned char reg[SAA7110_NR_REG];
 
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


I could load the modified driver on my own DC10+ board (just plugged-in
for the tests) without oops. Unfortunately I am not able to test it any
further (crappy motherboad and lack of video source and tv set).

The idea of the patch is to keep everything simple because there is no
reason to do otherwise, and add some checks to prevent buffer overruns.
I would appreciate if people familiar with this video chip could check
that my code does the correct thing. I would also appreciate if users of
Zoran-based boards could test it and confirm it works OK.

Thanks.

[1] Actually I found that there is one common flag between client and
message, but this is a bad idea IMHO and should never be relied upon
outside of i2c-core.

[2] I found 5 other drivers with the same problem: adv7170, adv7175,
bt819, saa7114, saa7185, all used by Zoran-based boards. I'll post a
separate patch for these drivers.

-- 
Jean Delvare
