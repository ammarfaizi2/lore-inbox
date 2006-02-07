Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbWBGPp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbWBGPp4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWBGPkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:40:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46492 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751120AbWBGPkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:40:31 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Markus Rechberger <mrechberger@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 07/16] Fixed i2c return value, conversion mdelay to msleep
Date: Tue, 07 Feb 2006 13:33:31 -0200
Message-id: <20060207153331.PS65523100007@infradead.org>
In-Reply-To: <20060207153248.PS50860900000@infradead.org>
References: <20060207153248.PS50860900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Rechberger <mrechberger@gmail.com>

fixed i2c return value, conversion mdelay to msleep

Signed-off-by: Markus Rechberger <mrechberger@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/em28xx/em28xx-core.c |   15 +++++++++++++--
 drivers/media/video/em28xx/em28xx-i2c.c  |    8 ++++----
 2 files changed, 17 insertions(+), 6 deletions(-)

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

