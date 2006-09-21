Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751573AbWIUVRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbWIUVRt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbWIUVRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:17:49 -0400
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:58557 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1751572AbWIUVRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:17:48 -0400
Date: Thu, 21 Sep 2006 23:17:38 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: linux-kernel@vger.kernel.org
Cc: kraxel@bytesex.org
Subject: [PATCH] Allow RC5 codes 64 - 127 in ir-kbd-i2c.c
Message-ID: <20060921211738.GA12288@hardeman.nu>
Mail-Followup-To: linux-kernel@vger.kernel.org, kraxel@bytesex.org
References: <20060921203753.GA11551@hardeman.nu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20060921203753.GA11551@hardeman.nu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Content-Transfer-Encoding: 7bit
X-SA-Score: -2.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The RC5 coding has for a long time supported commands 64-127 in addition=20
to 0-63. This is controlled by the second bit of the RC5 packet (see =20
http://www.armory.com/~spcecdt/remote/RC5codes.html for details).

The attached patch modifies ir-kbd-i2c.c to allow for commands 64-127,=20
tested with a PVR350 card in combination with a programmable remote.

This time, attached inline so that it won't be line-wrapped :)

Signed-off-by: David H=E4rdeman <david@hardeman.nu>

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=ir-kbd-i2c-use-all-rc5-codes

diff -ur linux-2.6.18-orig/drivers/media/video/ir-kbd-i2c.c linux-2.6.18/drivers/media/video/ir-kbd-i2c.c
--- linux-2.6.18-orig/drivers/media/video/ir-kbd-i2c.c	2006-09-21 22:05:16.000000000 +0200
+++ linux-2.6.18/drivers/media/video/ir-kbd-i2c.c	2006-09-21 22:25:40.000000000 +0200
@@ -64,23 +64,32 @@
 static int get_key_haup(struct IR_i2c *ir, u32 *ir_key, u32 *ir_raw)
 {
 	unsigned char buf[3];
-	int start, toggle, dev, code;
+	int start, range, toggle, dev, code;
 
 	/* poll IR chip */
 	if (3 != i2c_master_recv(&ir->c,buf,3))
 		return -EIO;
 
 	/* split rc5 data block ... */
-	start  = (buf[0] >> 6) &    3;
+	start  = (buf[0] >> 7) &    1;
+	range  = (buf[0] >> 6) &    1;
 	toggle = (buf[0] >> 5) &    1;
 	dev    =  buf[0]       & 0x1f;
 	code   = (buf[1] >> 2) & 0x3f;
 
-	if (3 != start)
+	/* rc5 has two start bits
+	 * the first bit must be one
+	 * the second bit defines the command range (1 = 0-63, 0 = 64 - 127)
+	 */
+	if (!start)
 		/* no key pressed */
 		return 0;
-	dprintk(1,"ir hauppauge (rc5): s%d t%d dev=%d code=%d\n",
-		start, toggle, dev, code);
+
+	if (!range)
+		code += 64;
+
+	dprintk(1,"ir hauppauge (rc5): s%d r%d t%d dev=%d code=%d\n",
+		start, range, toggle, dev, code);
 
 	/* return key */
 	*ir_key = code;

--BOKacYhQ+x31HxR3--
