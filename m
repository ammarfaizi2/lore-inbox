Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965063AbVKAIRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbVKAIRQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbVKAIRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:17:12 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:33900 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S965077AbVKAIQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:16:52 -0500
Message-ID: <43672452.6040306@m1k.net>
Date: Tue, 01 Nov 2005 03:16:18 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 33/37] dvb: determine tuner write method based on nxt chip
Content-Type: multipart/mixed;
 boundary="------------070304010800080901050703"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070304010800080901050703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------070304010800080901050703
Content-Type: text/x-patch;
 name="2410.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2410.patch"

- Add support for AVerTVHD MCE a180.
- Instead of determining how to write to the tuner based on which NIM
  is being used, make this determination based on whether the chip is a
  NXT2002 or NXT2004.
- If NXT2004, write directly to tuner. If NXT2002, write through NXT chip.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 drivers/media/dvb/frontends/nxt200x.c |   92 ++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 43 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/frontends/nxt200x.c
+++ linux-2.6.14-git3/drivers/media/dvb/frontends/nxt200x.c
@@ -342,50 +342,56 @@
 
 	dprintk("Tuner Bytes: %02X %02X %02X %02X\n", data[0], data[1], data[2], data[3]);
 
-	/* if pll is a Philips TUV1236D then write directly to tuner */
-	if (strcmp(state->config->pll_desc->name, "Philips TUV1236D") == 0) {
-	        if (i2c_writebytes(state, state->config->pll_address, data, 4))
-        	        printk(KERN_WARNING "nxt200x: error writing to tuner\n");
-		/* wait until we have a lock */
-		while (count < 20) {
-			i2c_readbytes(state, state->config->pll_address, &buf, 1);
-			if (buf & 0x40)
-				return 0;
-			msleep(100);
-			count++;
-		}
-		printk("nxt200x: timeout waiting for tuner lock\n");
-		return 0;
-	} else {
-		/* set the i2c transfer speed to the tuner */
-		buf = 0x03;
-		nxt200x_writebytes(state, 0x20, &buf, 1);
-
-		/* setup to transfer 4 bytes via i2c */
-		buf = 0x04;
-		nxt200x_writebytes(state, 0x34, &buf, 1);
-
-		/* write actual tuner bytes */
-		nxt200x_writebytes(state, 0x36, data, 4);
-
-		/* set tuner i2c address */
-		buf = state->config->pll_address;
-		nxt200x_writebytes(state, 0x35, &buf, 1);
-
-		/* write UC Opmode to begin transfer */
-		buf = 0x80;
-		nxt200x_writebytes(state, 0x21, &buf, 1);
-
-		while (count < 20) {
-			nxt200x_readbytes(state, 0x21, &buf, 1);
-			if ((buf & 0x80)== 0x00)
-				return 0;
-			msleep(100);
-			count++;
-		}
-		printk("nxt200x: timeout error writing tuner\n");
-		return 0;
+	/* if NXT2004, write directly to tuner. if NXT2002, write through NXT chip.
+	 * direct write is required for Philips TUV1236D and ALPS TDHU2 */
+	switch (state->demod_chip) {
+		case NXT2004:
+			if (i2c_writebytes(state, state->config->pll_address, data, 4))
+	        	        printk(KERN_WARNING "nxt200x: error writing to tuner\n");
+			/* wait until we have a lock */
+			while (count < 20) {
+				i2c_readbytes(state, state->config->pll_address, &buf, 1);
+				if (buf & 0x40)
+					return 0;
+				msleep(100);
+				count++;
+			}
+			printk("nxt2004: timeout waiting for tuner lock\n");
+			break;
+		case NXT2002:
+			/* set the i2c transfer speed to the tuner */
+			buf = 0x03;
+			nxt200x_writebytes(state, 0x20, &buf, 1);
+
+			/* setup to transfer 4 bytes via i2c */
+			buf = 0x04;
+			nxt200x_writebytes(state, 0x34, &buf, 1);
+
+			/* write actual tuner bytes */
+			nxt200x_writebytes(state, 0x36, data, 4);
+
+			/* set tuner i2c address */
+			buf = state->config->pll_address;
+			nxt200x_writebytes(state, 0x35, &buf, 1);
+
+			/* write UC Opmode to begin transfer */
+			buf = 0x80;
+			nxt200x_writebytes(state, 0x21, &buf, 1);
+
+			while (count < 20) {
+				nxt200x_readbytes(state, 0x21, &buf, 1);
+				if ((buf & 0x80)== 0x00)
+					return 0;
+				msleep(100);
+				count++;
+			}
+			printk("nxt2002: timeout error writing tuner\n");
+			break;
+		default:
+			return -EINVAL;
+			break;
 	}
+	return 0;
 }
 
 static void nxt200x_agc_reset(struct nxt200x_state* state)


--------------070304010800080901050703--
