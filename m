Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWCTPgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWCTPgA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965290AbWCTP0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:26:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29880 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965274AbWCTPZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:25:30 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Markus Rechberger <mrechberger@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 060/141] V4L/DVB (3306): Fixed i2c return value, conversion
	mdelay to msleep
Date: Mon, 20 Mar 2006 12:08:47 -0300
Message-id: <20060320150846.PS982706000060@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Rechberger <mrechberger@gmail.com>
Date: 1139302151 -0200

fixed i2c return value, conversion mdelay to msleep

Signed-off-by: Markus Rechberger <mrechberger@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/em28xx/em28xx-core.c b/drivers/media/video/em28xx/em28xx-core.c
diff --git a/drivers/media/video/em28xx/em28xx-core.c b/drivers/media/video/em28xx/em28xx-core.c
index 82f0c5f..e5ee8bc 100644
--- a/drivers/media/video/em28xx/em28xx-core.c
+++ b/drivers/media/video/em28xx/em28xx-core.c
@@ -139,6 +139,9 @@ int em28xx_read_reg_req_len(struct em28x
 {
 	int ret, byte;
 
+	if (dev->state & DEV_DISCONNECTED)
+		return(-ENODEV);
+
 	em28xx_regdbg("req=%02x, reg=%02x ", req, reg);
 
 	ret = usb_control_msg(dev->udev, usb_rcvctrlpipe(dev->udev, 0), req,
@@ -165,6 +168,9 @@ int em28xx_read_reg_req(struct em28xx *d
 	u8 val;
 	int ret;
 
+	if (dev->state & DEV_DISCONNECTED)
+		return(-ENODEV);
+
 	em28xx_regdbg("req=%02x, reg=%02x:", req, reg);
 
 	ret = usb_control_msg(dev->udev, usb_rcvctrlpipe(dev->udev, 0), req,
@@ -195,7 +201,12 @@ int em28xx_write_regs_req(struct em28xx 
 	int ret;
 
 	/*usb_control_msg seems to expect a kmalloced buffer */
-	unsigned char *bufs = kmalloc(len, GFP_KERNEL);
+	unsigned char *bufs;
+
+	if (dev->state & DEV_DISCONNECTED)
+		return(-ENODEV);
+
+	bufs = kmalloc(len, GFP_KERNEL);
 
 	em28xx_regdbg("req=%02x reg=%02x:", req, reg);
 
@@ -212,7 +223,7 @@ int em28xx_write_regs_req(struct em28xx 
 	ret = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, 0), req,
 			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 			      0x0000, reg, bufs, len, HZ);
-	mdelay(5);		/* FIXME: magic number */
+	msleep(5);		/* FIXME: magic number */
 	kfree(bufs);
 	return ret;
 }
diff --git a/drivers/media/video/em28xx/em28xx-i2c.c b/drivers/media/video/em28xx/em28xx-i2c.c
diff --git a/drivers/media/video/em28xx/em28xx-i2c.c b/drivers/media/video/em28xx/em28xx-i2c.c
index 0591a70..6ca8631 100644
--- a/drivers/media/video/em28xx/em28xx-i2c.c
+++ b/drivers/media/video/em28xx/em28xx-i2c.c
@@ -78,7 +78,7 @@ static int em2800_i2c_send_max4(struct e
 		ret = dev->em28xx_read_reg(dev, 0x05);
 		if (ret == 0x80 + len - 1)
 			return len;
-		mdelay(5);
+		msleep(5);
 	}
 	em28xx_warn("i2c write timed out\n");
 	return -EIO;
@@ -138,7 +138,7 @@ static int em2800_i2c_check_for_device(s
 			return -ENODEV;
 		else if (msg == 0x84)
 			return 0;
-		mdelay(5);
+		msleep(5);
 	}
 	return -ENODEV;
 }
@@ -278,9 +278,9 @@ static int em28xx_i2c_xfer(struct i2c_ad
 							   msgs[i].buf,
 							   msgs[i].len,
 							   i == num - 1);
-			if (rc < 0)
-				goto err;
 		}
+		if (rc < 0)
+			goto err;
 		if (i2c_debug>=2)
 			printk("\n");
 	}

