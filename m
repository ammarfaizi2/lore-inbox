Return-Path: <linux-kernel-owner+w=401wt.eu-S1762678AbWLKJ2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762678AbWLKJ2y (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 04:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762680AbWLKJ2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 04:28:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51939 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762678AbWLKJ2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 04:28:53 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 1/1] V4L/DVB (4954): Fix: On ia64, i2c adap->inb/adap->outb
	are wrongly evaluated
Date: Mon, 11 Dec 2006 07:20:39 -0200
Message-id: <20061211092039.PS4064480001@infradead.org>
In-Reply-To: <20061211091850.PS6310420000@infradead.org>
References: <20061211091850.PS6310420000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mauro Carvalho Chehab <mchehab@infradead.org>

i2c defines two callbacks (inb/outb). On ia64, since it defines also two macros
with those names, it causes the following errors:
drivers/media/video/usbvision/usbvision-i2c.c:64:39: macro "outb" passed 4 arguments, but takes just 2
drivers/media/video/usbvision/usbvision-i2c.c: In function `try_write_address':
drivers/media/video/usbvision/usbvision-i2c.c:64: warning: assignment makes integer from pointer without a cast
drivers/media/video/usbvision/usbvision-i2c.c:89:38: macro "inb" passed 4 arguments, but takes just 1
drivers/media/video/usbvision/usbvision-i2c.c: In function `try_read_address':
drivers/media/video/usbvision/usbvision-i2c.c:89: warning: assignment makes integer from pointer without a cast
drivers/media/video/usbvision/usbvision-i2c.c:85: warning: unused variable `buf'
drivers/media/video/usbvision/usbvision-i2c.c:173:53: macro "inb" passed 4 arguments, but takes just 1
drivers/media/video/usbvision/usbvision-i2c.c: In function `usb_xfer':
drivers/media/video/usbvision/usbvision-i2c.c:173: warning: assignment makes integer from pointer without a cast
drivers/media/video/usbvision/usbvision-i2c.c:179:54: macro "outb" passed 4 arguments, but takes just 2
drivers/media/video/usbvision/usbvision-i2c.c:179: warning: assignment makes integer from pointer without a cast
thanks to Andrew Morton for pointing this.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/media/video/usbvision/usbvision-i2c.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/media/video/usbvision/usbvision-i2c.c b/drivers/media/video/usbvision/usbvision-i2c.c
index 92bf9a1..0f3fba7 100644
--- a/drivers/media/video/usbvision/usbvision-i2c.c
+++ b/drivers/media/video/usbvision/usbvision-i2c.c
@@ -50,6 +50,11 @@ MODULE_PARM_DESC(i2c_debug, "enable debu
 #define PDEBUG(level, fmt, args...) \
 		if (i2c_debug & (level)) info("[%s:%d] " fmt, __PRETTY_FUNCTION__, __LINE__ , ## args)
 
+static int usbvision_i2c_write(void *data, unsigned char addr, char *buf,
+			    short len);
+static int usbvision_i2c_read(void *data, unsigned char addr, char *buf,
+			   short len);
+
 static inline int try_write_address(struct i2c_adapter *i2c_adap,
 				    unsigned char addr, int retries)
 {
@@ -61,7 +66,7 @@ static inline int try_write_address(stru
 	data = i2c_get_adapdata(i2c_adap);
 	buf[0] = 0x00;
 	for (i = 0; i <= retries; i++) {
-		ret = (adap->outb(data, addr, buf, 1));
+		ret = (usbvision_i2c_write(data, addr, buf, 1));
 		if (ret == 1)
 			break;	/* success! */
 		udelay(5 /*adap->udelay */ );
@@ -86,7 +91,7 @@ static inline int try_read_address(struc
 
 	data = i2c_get_adapdata(i2c_adap);
 	for (i = 0; i <= retries; i++) {
-		ret = (adap->inb(data, addr, buf, 1));
+		ret = (usbvision_i2c_read(data, addr, buf, 1));
 		if (ret == 1)
 			break;	/* success! */
 		udelay(5 /*adap->udelay */ );
@@ -153,7 +158,6 @@ static int
 usb_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num)
 {
 	struct i2c_msg *pmsg;
-	struct i2c_algo_usb_data *adap = i2c_adap->algo_data;
 	void *data;
 	int i, ret;
 	unsigned char addr;
@@ -170,13 +174,13 @@ usb_xfer(struct i2c_adapter *i2c_adap, s
 
 		if (pmsg->flags & I2C_M_RD) {
 			/* read bytes into buffer */
-			ret = (adap->inb(data, addr, pmsg->buf, pmsg->len));
+			ret = (usbvision_i2c_read(data, addr, pmsg->buf, pmsg->len));
 			if (ret < pmsg->len) {
 				return (ret < 0) ? ret : -EREMOTEIO;
 			}
 		} else {
 			/* write bytes from buffer */
-			ret = (adap->outb(data, addr, pmsg->buf, pmsg->len));
+			ret = (usbvision_i2c_write(data, addr, pmsg->buf, pmsg->len));
 			if (ret < pmsg->len) {
 				return (ret < 0) ? ret : -EREMOTEIO;
 			}

