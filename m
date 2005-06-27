Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVF0Mwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVF0Mwq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 08:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVF0Mur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 08:50:47 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:7141 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262046AbVF0MQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:21 -0400
Message-Id: <20050627121416.884115000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:37 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-usb-philips-fmd1216me-pll.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 37/51] frontend: add FMD1216ME PLL
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

o change dvb-pll desc to take the frequency as parameter for setbw-callback
  into consideration
o added dvb-pll desc for Philips FMD1216ME (needed for cxusb)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/frontends/dvb-pll.c |   35 ++++++++++++++++++++++++++++++----
 drivers/media/dvb/frontends/dvb-pll.h |    3 +-
 2 files changed, 33 insertions(+), 5 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/frontends/dvb-pll.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/frontends/dvb-pll.c	2005-06-27 13:18:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/frontends/dvb-pll.c	2005-06-27 13:26:08.000000000 +0200
@@ -55,7 +55,7 @@ struct dvb_pll_desc dvb_pll_thomson_dtt7
 };
 EXPORT_SYMBOL(dvb_pll_thomson_dtt7610);
 
-static void thomson_dtt759x_bw(u8 *buf, int bandwidth)
+static void thomson_dtt759x_bw(u8 *buf, u32 freq, int bandwidth)
 {
 	if (BANDWIDTH_7_MHZ == bandwidth)
 		buf[3] |= 0x10;
@@ -146,7 +146,7 @@ EXPORT_SYMBOL(dvb_pll_env57h1xd5);
 /* Philips TDA6650/TDA6651
  * used in Panasonic ENV77H11D5
  */
-static void tda665x_bw(u8 *buf, int bandwidth)
+static void tda665x_bw(u8 *buf, u32 freq, int bandwidth)
 {
 	if (bandwidth == BANDWIDTH_8_MHZ)
 		buf[3] |= 0x08;
@@ -178,7 +178,7 @@ EXPORT_SYMBOL(dvb_pll_tda665x);
 /* Infineon TUA6034
  * used in LG TDTP E102P
  */
-static void tua6034_bw(u8 *buf, int bandwidth)
+static void tua6034_bw(u8 *buf, u32 freq, int bandwidth)
 {
 	if (BANDWIDTH_7_MHZ != bandwidth)
 		buf[3] |= 0x08;
@@ -198,6 +198,33 @@ struct dvb_pll_desc dvb_pll_tua6034 = {
 };
 EXPORT_SYMBOL(dvb_pll_tua6034);
 
+/* Philips FMD1216ME
+ * used in Medion Hybrid PCMCIA card and USB Box
+ */
+static void fmd1216me_bw(u8 *buf, u32 freq, int bandwidth)
+{
+	if (bandwidth == BANDWIDTH_8_MHZ && freq >= 158870000)
+		buf[3] |= 0x08;
+}
+
+struct dvb_pll_desc dvb_pll_fmd1216me = {
+	.name = "placeholder",
+	.min = 50870000,
+	.max = 858000000,
+	.setbw = fmd1216me_bw,
+	.count = 7,
+	.entries = {
+		{ 143870000, 36213333, 166667, 0xbc, 0x41 },
+		{ 158870000, 36213333, 166667, 0xf4, 0x41 },
+		{ 329870000, 36213333, 166667, 0xbc, 0x42 },
+		{ 441870000, 36213333, 166667, 0xf4, 0x42 },
+		{ 625870000, 36213333, 166667, 0xbc, 0x44 },
+		{ 803870000, 36213333, 166667, 0xf4, 0x44 },
+		{ 999999999, 36213333, 166667, 0xfc, 0x44 },
+	}
+};
+EXPORT_SYMBOL(dvb_pll_fmd1216me);
+
 /* ----------------------------------------------------------- */
 /* code                                                        */
 
@@ -231,7 +258,7 @@ int dvb_pll_configure(struct dvb_pll_des
 	buf[3] = desc->entries[i].cb2;
 
 	if (desc->setbw)
-		desc->setbw(buf, bandwidth);
+		desc->setbw(buf, freq, bandwidth);
 
 	if (debug)
 		printk("pll: %s: div=%d | buf=0x%02x,0x%02x,0x%02x,0x%02x\n",
Index: linux-2.6.12-git8/drivers/media/dvb/frontends/dvb-pll.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/frontends/dvb-pll.h	2005-06-27 13:18:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/frontends/dvb-pll.h	2005-06-27 13:26:08.000000000 +0200
@@ -9,7 +9,7 @@ struct dvb_pll_desc {
 	char *name;
 	u32  min;
 	u32  max;
-	void (*setbw)(u8 *buf, int bandwidth);
+	void (*setbw)(u8 *buf, u32 freq, int bandwidth);
 	int  count;
 	struct {
 		u32 limit;
@@ -30,6 +30,7 @@ extern struct dvb_pll_desc dvb_pll_tua60
 extern struct dvb_pll_desc dvb_pll_env57h1xd5;
 extern struct dvb_pll_desc dvb_pll_tua6034;
 extern struct dvb_pll_desc dvb_pll_tda665x;
+extern struct dvb_pll_desc dvb_pll_fmd1216me;
 
 int dvb_pll_configure(struct dvb_pll_desc *desc, u8 *buf,
 		      u32 freq, int bandwidth);

--

