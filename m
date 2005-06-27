Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVF0NCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVF0NCh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVF0Mzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 08:55:55 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:6629 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262045AbVF0MQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:21 -0400
Message-Id: <20050627121414.278350000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:24 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wolfgang Rohdewald <wolfgang@rohdewald.de>
Content-Disposition: inline; filename=dvb-ttpci-firmware-error-handling-fixes.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 24/51] ttpci: fix error handling for firmware communication
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfgang Rohdewald <wolfgang@rohdewald.de>

o make sure ERESTARTSYS will be propagated
o ReleaseBitmap: starting with Firmware 261e, also release when
  BMP_LOADING
o removes unused #define BMP_LOADINGS
o in many cases changed the return value from -1 to something more
  meaningful like ETIMEDOUT, EINVAL
o changed syslog message timeout waiting for COMMAND such that it
  indicates what command did not complete
o reduce # of arguments for LoadBitmap and BlitBitmap
o av7110_osd_cmd: remove the out: label

Signed-off-by: Wolfgang Rohdewald <wolfgang@rohdewald.de>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttpci/av7110.h    |    3 
 drivers/media/dvb/ttpci/av7110_hw.c |  309 ++++++++++++++++++------------------
 2 files changed, 163 insertions(+), 149 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttpci/av7110.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110.h	2005-06-27 13:24:17.000000000 +0200
@@ -119,8 +119,7 @@ struct av7110 {
 	volatile int		bmp_state;
 #define BMP_NONE     0
 #define BMP_LOADING  1
-#define BMP_LOADINGS 2
-#define BMP_LOADED   3
+#define BMP_LOADED   2
 	wait_queue_head_t	bmpq;
 
 
Index: linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110_hw.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttpci/av7110_hw.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110_hw.c	2005-06-27 13:24:17.000000000 +0200
@@ -137,7 +137,7 @@ static int waitdebi(struct av7110 *av711
 			return 0;
 		udelay(5);
 	}
-	return -1;
+	return -ETIMEDOUT;
 }
 
 static int load_dram(struct av7110 *av7110, u32 *data, int len)
@@ -155,7 +155,7 @@ static int load_dram(struct av7110 *av71
 	for (i = 0; i < blocks; i++) {
 		if (waitdebi(av7110, BOOT_STATE, BOOTSTATE_BUFFER_EMPTY) < 0) {
 			printk(KERN_ERR "dvb-ttpci: load_dram(): timeout at block %d\n", i);
-			return -1;
+			return -ETIMEDOUT;
 		}
 		dprintk(4, "writing DRAM block %d\n", i);
 		mwdebi(av7110, DEBISWAB, bootblock,
@@ -170,7 +170,7 @@ static int load_dram(struct av7110 *av71
 	if (rest > 0) {
 		if (waitdebi(av7110, BOOT_STATE, BOOTSTATE_BUFFER_EMPTY) < 0) {
 			printk(KERN_ERR "dvb-ttpci: load_dram(): timeout at last block\n");
-			return -1;
+			return -ETIMEDOUT;
 		}
 		if (rest > 4)
 			mwdebi(av7110, DEBISWAB, bootblock,
@@ -185,13 +185,13 @@ static int load_dram(struct av7110 *av71
 	}
 	if (waitdebi(av7110, BOOT_STATE, BOOTSTATE_BUFFER_EMPTY) < 0) {
 		printk(KERN_ERR "dvb-ttpci: load_dram(): timeout after last block\n");
-		return -1;
+		return -ETIMEDOUT;
 	}
 	iwdebi(av7110, DEBINOSWAP, BOOT_SIZE, 0, 2);
 	iwdebi(av7110, DEBINOSWAP, BOOT_STATE, BOOTSTATE_BUFFER_FULL, 2);
 	if (waitdebi(av7110, BOOT_STATE, BOOTSTATE_BOOT_COMPLETE) < 0) {
 		printk(KERN_ERR "dvb-ttpci: load_dram(): final handshake timeout\n");
-		return -1;
+		return -ETIMEDOUT;
 	}
 	return 0;
 }
@@ -263,7 +263,7 @@ int av7110_bootarm(struct av7110 *av7110
 	if (saa7146_wait_for_debi_done(av7110->dev, 1)) {
 		printk(KERN_ERR "dvb-ttpci: av7110_bootarm(): "
 		       "saa7146_wait_for_debi_done() timed out\n");
-		return -1;
+		return -ETIMEDOUT;
 	}
 	saa7146_setgpio(dev, RESET_LINE, SAA7146_GPIO_OUTHI);
 	mdelay(1);
@@ -284,7 +284,7 @@ int av7110_bootarm(struct av7110 *av7110
 	if (saa7146_wait_for_debi_done(av7110->dev, 1)) {
 		printk(KERN_ERR "dvb-ttpci: av7110_bootarm(): "
 		       "saa7146_wait_for_debi_done() timed out after loading DRAM\n");
-		return -1;
+		return -ETIMEDOUT;
 	}
 	saa7146_setgpio(dev, RESET_LINE, SAA7146_GPIO_OUTHI);
 	msleep(30);	/* the firmware needs some time to initialize */
@@ -328,7 +328,7 @@ int av7110_wait_msgstate(struct av7110 *
 		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
 			printk(KERN_ERR "%s: timeout waiting for MSGSTATE %04x\n",
 				__FUNCTION__, stat & flags);
-			return -1;
+			return -ETIMEDOUT;
 		}
 		msleep(1);
 	}
@@ -412,7 +412,7 @@ static int __av7110_send_fw_cmd(struct a
 			if (time_after(jiffies, start + ARM_WAIT_FREE)) {
 				printk(KERN_ERR "%s: timeout waiting on busy %s QUEUE\n",
 					__FUNCTION__, type);
-				return -1;
+				return -ETIMEDOUT;
 			}
 			msleep(1);
 		}
@@ -435,8 +435,10 @@ static int __av7110_send_fw_cmd(struct a
 	while (rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2 )) {
 		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
-			printk(KERN_ERR "dvb-ttpci: %s(): timeout waiting for COMMAND to complete\n",
-			       __FUNCTION__);
+			printk(KERN_ERR "dvb-ttpci: %s(): timeout waiting for COMMAND %d to complete\n",
+			       __FUNCTION__,
+				(buf[0] >> 8) & 0xff
+			       );
 			return -ETIMEDOUT;
 		}
 	}
@@ -470,7 +472,7 @@ static int av7110_send_fw_cmd(struct av7
 
 	ret = __av7110_send_fw_cmd(av7110, buf, length);
 	up(&av7110->dcomlock);
-	if (ret)
+	if (ret && ret!=-ERESTARTSYS)
 		printk(KERN_ERR "dvb-ttpci: %s(): av7110_send_fw_cmd error %d\n",
 		       __FUNCTION__, ret);
 	return ret;
@@ -495,7 +497,7 @@ int av7110_fw_cmd(struct av7110 *av7110,
 	}
 
 	ret = av7110_send_fw_cmd(av7110, buf, num + 2);
-	if (ret)
+	if (ret && ret != -ERESTARTSYS)
 		printk(KERN_ERR "dvb-ttpci: av7110_fw_cmd error %d\n", ret);
 	return ret;
 }
@@ -518,7 +520,7 @@ int av7110_send_ci_cmd(struct av7110 *av
 	}
 
 	ret = av7110_send_fw_cmd(av7110, cmd, 18);
-	if (ret)
+	if (ret && ret != -ERESTARTSYS)
 		printk(KERN_ERR "dvb-ttpci: av7110_send_ci_cmd error %d\n", ret);
 	return ret;
 }
@@ -558,7 +560,7 @@ int av7110_fw_request(struct av7110 *av7
 		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
 			printk(KERN_ERR "%s: timeout waiting for COMMAND to complete\n", __FUNCTION__);
 			up(&av7110->dcomlock);
-			return -1;
+			return -ETIMEDOUT;
 		}
 	}
 
@@ -569,7 +571,7 @@ int av7110_fw_request(struct av7110 *av7
 		if (time_after(jiffies, start + ARM_WAIT_SHAKE)) {
 			printk(KERN_ERR "%s: timeout waiting for HANDSHAKE_REG\n", __FUNCTION__);
 			up(&av7110->dcomlock);
-			return -1;
+			return -ETIMEDOUT;
 		}
 	}
 #endif
@@ -667,10 +669,10 @@ int av7110_diseqc_send(struct av7110 *av
 	for (i = 0; i < len; i++)
 		buf[i + 4] = msg[i];
 
-	if ((ret = av7110_send_fw_cmd(av7110, buf, 18)))
+	ret = av7110_send_fw_cmd(av7110, buf, 18);
+	if (ret && ret!=-ERESTARTSYS)
 		printk(KERN_ERR "dvb-ttpci: av7110_diseqc_send error %d\n", ret);
-
-	return 0;
+	return ret;
 }
 
 
@@ -715,7 +717,7 @@ static int FlushText(struct av7110 *av71
 			printk(KERN_ERR "dvb-ttpci: %s(): timeout waiting for BUFF1_BASE == 0\n",
 			       __FUNCTION__);
 			up(&av7110->dcomlock);
-			return -1;
+			return -ETIMEDOUT;
 		}
 	}
 	up(&av7110->dcomlock);
@@ -739,7 +741,7 @@ static int WriteText(struct av7110 *av71
 			printk(KERN_ERR "dvb-ttpci: %s: timeout waiting for BUFF1_BASE == 0\n",
 			       __FUNCTION__);
 			up(&av7110->dcomlock);
-			return -1;
+			return -ETIMEDOUT;
 		}
 	}
 #ifndef _NOHANDSHAKE
@@ -750,7 +752,7 @@ static int WriteText(struct av7110 *av71
 			printk(KERN_ERR "dvb-ttpci: %s: timeout waiting for HANDSHAKE_REG\n",
 			       __FUNCTION__);
 			up(&av7110->dcomlock);
-			return -1;
+			return -ETIMEDOUT;
 		}
 	}
 #endif
@@ -761,7 +763,7 @@ static int WriteText(struct av7110 *av71
 		wdebi(av7110, DEBINOSWAP, BUFF1_BASE + i * 2, 0, 2);
 	ret = __av7110_send_fw_cmd(av7110, cbuf, 5);
 	up(&av7110->dcomlock);
-	if (ret)
+	if (ret && ret!=-ERESTARTSYS)
 		printk(KERN_ERR "dvb-ttpci: WriteText error %d\n", ret);
 	return ret;
 }
@@ -816,9 +818,25 @@ static osd_raw_window_t bpp2bit[8] = {
 	OSD_BITMAP1, OSD_BITMAP2, 0, OSD_BITMAP4, 0, 0, 0, OSD_BITMAP8
 };
 
-static inline int LoadBitmap(struct av7110 *av7110, u16 format,
+static inline int WaitUntilBmpLoaded(struct av7110 *av7110)
+{
+	int ret = wait_event_interruptible_timeout(av7110->bmpq,
+				av7110->bmp_state != BMP_LOADING, 10*HZ);
+	if (ret == -ERESTARTSYS)
+		return ret;
+	if (ret == 0) {
+		printk("dvb-ttpci: warning: timeout waiting in LoadBitmap: %d, %d\n",
+		       ret, av7110->bmp_state);
+		av7110->bmp_state = BMP_NONE;
+		return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+static inline int LoadBitmap(struct av7110 *av7110,
 			     u16 dx, u16 dy, int inc, u8 __user * data)
 {
+	u16 format;
 	int bpp;
 	int i;
 	int d, delta;
@@ -827,14 +845,7 @@ static inline int LoadBitmap(struct av71
 
 	dprintk(4, "%p\n", av7110);
 
-	ret = wait_event_interruptible_timeout(av7110->bmpq, av7110->bmp_state != BMP_LOADING, HZ);
-	if (ret == -ERESTARTSYS || ret == 0) {
-		printk("dvb-ttpci: warning: timeout waiting in LoadBitmap: %d, %d\n",
-		       ret, av7110->bmp_state);
-		av7110->bmp_state = BMP_NONE;
-		return -1;
-	}
-	BUG_ON (av7110->bmp_state == BMP_LOADING);
+	format = bpp2bit[av7110->osdbpp[av7110->osdwin]];
 
 	av7110->bmp_state = BMP_LOADING;
 	if	(format == OSD_BITMAP8) {
@@ -847,18 +858,18 @@ static inline int LoadBitmap(struct av71
 		bpp=1; delta = 8;
 	} else {
 		av7110->bmp_state = BMP_NONE;
-		return -1;
+		return -EINVAL;
 	}
 	av7110->bmplen = ((dx * dy * bpp + 7) & ~7) / 8;
 	av7110->bmpp = 0;
 	if (av7110->bmplen > 32768) {
 		av7110->bmp_state = BMP_NONE;
-		return -1;
+		return -EINVAL;
 	}
 	for (i = 0; i < dy; i++) {
 		if (copy_from_user(av7110->bmpbuf + 1024 + i * dx, data + i * inc, dx)) {
 			av7110->bmp_state = BMP_NONE;
-			return -1;
+			return -EINVAL;
 		}
 	}
 	if (format != OSD_BITMAP8) {
@@ -873,37 +884,27 @@ static inline int LoadBitmap(struct av71
 	}
 	av7110->bmplen += 1024;
 	dprintk(4, "av7110_fw_cmd: LoadBmp size %d\n", av7110->bmplen);
-	return av7110_fw_cmd(av7110, COMTYPE_OSD, LoadBmp, 3, format, dx, dy);
+	ret = av7110_fw_cmd(av7110, COMTYPE_OSD, LoadBmp, 3, format, dx, dy);
+	if (!ret)
+		ret = WaitUntilBmpLoaded(av7110);
+	return ret;
 }
 
-static int BlitBitmap(struct av7110 *av7110, u16 win, u16 x, u16 y, u16 trans)
+static int BlitBitmap(struct av7110 *av7110, u16 x, u16 y)
 {
-	int ret;
-
 	dprintk(4, "%p\n", av7110);
 
-	BUG_ON (av7110->bmp_state == BMP_NONE);
-
-	ret = wait_event_interruptible_timeout(av7110->bmpq,
-				av7110->bmp_state != BMP_LOADING, 10*HZ);
-	if (ret == -ERESTARTSYS || ret == 0) {
-		printk("dvb-ttpci: warning: timeout waiting in BlitBitmap: %d, %d\n",
-		       ret, av7110->bmp_state);
-		av7110->bmp_state = BMP_NONE;
-		return (ret == 0) ? -ETIMEDOUT : ret;
-	}
-
-	BUG_ON (av7110->bmp_state != BMP_LOADED);
-
-	return av7110_fw_cmd(av7110, COMTYPE_OSD, BlitBmp, 4, win, x, y, trans);
+	return av7110_fw_cmd(av7110, COMTYPE_OSD, BlitBmp, 4, av7110->osdwin, x, y, 0);
 }
 
 static inline int ReleaseBitmap(struct av7110 *av7110)
 {
 	dprintk(4, "%p\n", av7110);
 
-	if (av7110->bmp_state != BMP_LOADED)
+	if (av7110->bmp_state != BMP_LOADED && FW_VERSION(av7110->arm_app) < 0x261e)
 		return -1;
+	if (av7110->bmp_state == BMP_LOADING)
+		dprintk(1,"ReleaseBitmap called while BMP_LOADING\n");
 	av7110->bmp_state = BMP_NONE;
 	return av7110_fw_cmd(av7110, COMTYPE_OSD, ReleaseBmp, 0);
 }
@@ -924,18 +925,22 @@ static u32 RGB2YUV(u16 R, u16 G, u16 B)
 	return Cr | (Cb << 16) | (Y << 8);
 }
 
-static void OSDSetColor(struct av7110 *av7110, u8 color, u8 r, u8 g, u8 b, u8 blend)
+static int OSDSetColor(struct av7110 *av7110, u8 color, u8 r, u8 g, u8 b, u8 blend)
 {
+	int ret;
+
 	u16 ch, cl;
 	u32 yuv;
 
 	yuv = blend ? RGB2YUV(r,g,b) : 0;
 	cl = (yuv & 0xffff);
 	ch = ((yuv >> 16) & 0xffff);
-	SetColor_(av7110, av7110->osdwin, bpp2pal[av7110->osdbpp[av7110->osdwin]],
-		  color, ch, cl);
-	SetBlend_(av7110, av7110->osdwin, bpp2pal[av7110->osdbpp[av7110->osdwin]],
-		  color, ((blend >> 4) & 0x0f));
+	ret = SetColor_(av7110, av7110->osdwin, bpp2pal[av7110->osdbpp[av7110->osdwin]],
+			color, ch, cl);
+	if (!ret)
+		ret = SetBlend_(av7110, av7110->osdwin, bpp2pal[av7110->osdbpp[av7110->osdwin]],
+				color, ((blend >> 4) & 0x0f));
+	return ret;
 }
 
 static int OSDSetPalette(struct av7110 *av7110, u32 __user * colors, u8 first, u8 last)
@@ -968,14 +973,14 @@ static int OSDSetBlock(struct av7110 *av
 {
 	uint w, h, bpp, bpl, size, lpb, bnum, brest;
 	int i;
-	int rc;
+	int rc,release_rc;
 
 	w = x1 - x0 + 1;
 	h = y1 - y0 + 1;
 	if (inc <= 0)
 		inc = w;
 	if (w <= 0 || w > 720 || h <= 0 || h > 576)
-		return -1;
+		return -EINVAL;
 	bpp = av7110->osdbpp[av7110->osdwin] + 1;
 	bpl = ((w * bpp + 7) & ~7) / 8;
 	size = h * bpl;
@@ -983,176 +988,186 @@ static int OSDSetBlock(struct av7110 *av
 	bnum = size / (lpb * bpl);
 	brest = size - bnum * lpb * bpl;
 
-	for (i = 0; i < bnum; i++) {
-		rc = LoadBitmap(av7110, bpp2bit[av7110->osdbpp[av7110->osdwin]],
-			   w, lpb, inc, data);
+	if (av7110->bmp_state == BMP_LOADING) {
+		/* possible if syscall is repeated by -ERESTARTSYS and if firmware cannot abort */
+		BUG_ON (FW_VERSION(av7110->arm_app) >= 0x261e);
+		rc = WaitUntilBmpLoaded(av7110);
 		if (rc)
 			return rc;
-		rc = BlitBitmap(av7110, av7110->osdwin, x0, y0 + i * lpb, 0);
-		if (rc)
-			return rc;
-		data += lpb * inc;
+		/* just continue. This should work for all fw versions
+		 * if bnum==1 && !brest && LoadBitmap was successful
+		 */
 	}
-	if (brest) {
-		rc = LoadBitmap(av7110, bpp2bit[av7110->osdbpp[av7110->osdwin]],
-			   w, brest / bpl, inc, data);
+
+	rc = 0;
+	for (i = 0; i < bnum; i++) {
+		rc = LoadBitmap(av7110, w, lpb, inc, data);
 		if (rc)
-			return rc;
-		rc = BlitBitmap(av7110, av7110->osdwin, x0, y0 + bnum * lpb, 0);
+			break;
+		rc = BlitBitmap(av7110, x0, y0 + i * lpb);
 		if (rc)
-			return rc;
+			break;
+		data += lpb * inc;
 	}
-	ReleaseBitmap(av7110);
-	return 0;
+	if (!rc && brest) {
+		rc = LoadBitmap(av7110, w, brest / bpl, inc, data);
+		if (!rc)
+			rc = BlitBitmap(av7110, x0, y0 + bnum * lpb);
+	}
+	release_rc = ReleaseBitmap(av7110);
+	if (!rc)
+		rc = release_rc;
+	if (rc)
+		dprintk(1,"returns %d\n",rc);
+	return rc;
 }
 
 int av7110_osd_cmd(struct av7110 *av7110, osd_cmd_t *dc)
 {
 	int ret;
 
-	ret = down_interruptible(&av7110->osd_sema);
-	if (ret)
+	if (down_interruptible(&av7110->osd_sema))
 		return -ERESTARTSYS;
 
-	/* stupid, but OSD functions don't provide a return code anyway */
-	ret = 0;
-
 	switch (dc->cmd) {
 	case OSD_Close:
-		DestroyOSDWindow(av7110, av7110->osdwin);
-		goto out;
+		ret = DestroyOSDWindow(av7110, av7110->osdwin);
+		break;
 	case OSD_Open:
 		av7110->osdbpp[av7110->osdwin] = (dc->color - 1) & 7;
-		CreateOSDWindow(av7110, av7110->osdwin,
+		ret = CreateOSDWindow(av7110, av7110->osdwin,
 				bpp2bit[av7110->osdbpp[av7110->osdwin]],
 				dc->x1 - dc->x0 + 1, dc->y1 - dc->y0 + 1);
+		if (ret)
+			break;
 		if (!dc->data) {
-			MoveWindowAbs(av7110, av7110->osdwin, dc->x0, dc->y0);
-			SetColorBlend(av7110, av7110->osdwin);
+			ret = MoveWindowAbs(av7110, av7110->osdwin, dc->x0, dc->y0);
+			if (ret)
+				break;
+			ret = SetColorBlend(av7110, av7110->osdwin);
 		}
-		goto out;
+		break;
 	case OSD_Show:
-		MoveWindowRel(av7110, av7110->osdwin, 0, 0);
-		goto out;
+		ret = MoveWindowRel(av7110, av7110->osdwin, 0, 0);
+		break;
 	case OSD_Hide:
-		HideWindow(av7110, av7110->osdwin);
-		goto out;
+		ret = HideWindow(av7110, av7110->osdwin);
+		break;
 	case OSD_Clear:
-		DrawBlock(av7110, av7110->osdwin, 0, 0, 720, 576, 0);
-		goto out;
+		ret = DrawBlock(av7110, av7110->osdwin, 0, 0, 720, 576, 0);
+		break;
 	case OSD_Fill:
-		DrawBlock(av7110, av7110->osdwin, 0, 0, 720, 576, dc->color);
-		goto out;
+		ret = DrawBlock(av7110, av7110->osdwin, 0, 0, 720, 576, dc->color);
+		break;
 	case OSD_SetColor:
-		OSDSetColor(av7110, dc->color, dc->x0, dc->y0, dc->x1, dc->y1);
-		goto out;
+		ret = OSDSetColor(av7110, dc->color, dc->x0, dc->y0, dc->x1, dc->y1);
+		break;
 	case OSD_SetPalette:
-	{
-		if (FW_VERSION(av7110->arm_app) >= 0x2618) {
+		if (FW_VERSION(av7110->arm_app) >= 0x2618)
 			ret = OSDSetPalette(av7110, dc->data, dc->color, dc->x0);
-			goto out;
-		} else {
+		else {
 			int i, len = dc->x0-dc->color+1;
 			u8 __user *colors = (u8 __user *)dc->data;
 			u8 r, g, b, blend;
-
+			ret = 0;
 			for (i = 0; i<len; i++) {
 				if (get_user(r, colors + i * 4) ||
 				    get_user(g, colors + i * 4 + 1) ||
 				    get_user(b, colors + i * 4 + 2) ||
 				    get_user(blend, colors + i * 4 + 3)) {
 					ret = -EFAULT;
-					goto out;
+					break;
 				    }
-				OSDSetColor(av7110, dc->color + i, r, g, b, blend);
+				ret = OSDSetColor(av7110, dc->color + i, r, g, b, blend);
+				if (ret)
+					break;
 			}
 		}
-		ret = 0;
-		goto out;
-	}
-	case OSD_SetTrans:
-		goto out;
+		break;
 	case OSD_SetPixel:
-		DrawLine(av7110, av7110->osdwin,
+		ret = DrawLine(av7110, av7110->osdwin,
 			 dc->x0, dc->y0, 0, 0, dc->color);
-		goto out;
-	case OSD_GetPixel:
-		goto out;
+		break;
 	case OSD_SetRow:
 		dc->y1 = dc->y0;
 		/* fall through */
 	case OSD_SetBlock:
 		ret = OSDSetBlock(av7110, dc->x0, dc->y0, dc->x1, dc->y1, dc->color, dc->data);
-		goto out;
+		break;
 	case OSD_FillRow:
-		DrawBlock(av7110, av7110->osdwin, dc->x0, dc->y0,
+		ret = DrawBlock(av7110, av7110->osdwin, dc->x0, dc->y0,
 			  dc->x1-dc->x0+1, dc->y1, dc->color);
-		goto out;
+		break;
 	case OSD_FillBlock:
-		DrawBlock(av7110, av7110->osdwin, dc->x0, dc->y0,
+		ret = DrawBlock(av7110, av7110->osdwin, dc->x0, dc->y0,
 			  dc->x1 - dc->x0 + 1, dc->y1 - dc->y0 + 1, dc->color);
-		goto out;
+		break;
 	case OSD_Line:
-		DrawLine(av7110, av7110->osdwin,
+		ret = DrawLine(av7110, av7110->osdwin,
 			 dc->x0, dc->y0, dc->x1 - dc->x0, dc->y1 - dc->y0, dc->color);
-		goto out;
-	case OSD_Query:
-		goto out;
-	case OSD_Test:
-		goto out;
+		break;
 	case OSD_Text:
 	{
 		char textbuf[240];
 
 		if (strncpy_from_user(textbuf, dc->data, 240) < 0) {
 			ret = -EFAULT;
-			goto out;
+			break;
 		}
 		textbuf[239] = 0;
 		if (dc->x1 > 3)
 			dc->x1 = 3;
-		SetFont(av7110, av7110->osdwin, dc->x1,
+		ret = SetFont(av7110, av7110->osdwin, dc->x1,
 			(u16) (dc->color & 0xffff), (u16) (dc->color >> 16));
-		FlushText(av7110);
-		WriteText(av7110, av7110->osdwin, dc->x0, dc->y0, textbuf);
-		goto out;
+		if (!ret)
+			ret = FlushText(av7110);
+		if (!ret)
+			ret = WriteText(av7110, av7110->osdwin, dc->x0, dc->y0, textbuf);
+		break;
 	}
 	case OSD_SetWindow:
-		if (dc->x0 < 1 || dc->x0 > 7) {
+		if (dc->x0 < 1 || dc->x0 > 7)
 			ret = -EINVAL;
-			goto out;
+		else {
+			av7110->osdwin = dc->x0;
+			ret = 0;
 		}
-		av7110->osdwin = dc->x0;
-		goto out;
+		break;
 	case OSD_MoveWindow:
-		MoveWindowAbs(av7110, av7110->osdwin, dc->x0, dc->y0);
-		SetColorBlend(av7110, av7110->osdwin);
-		goto out;
+		ret = MoveWindowAbs(av7110, av7110->osdwin, dc->x0, dc->y0);
+		if (!ret)
+			ret = SetColorBlend(av7110, av7110->osdwin);
+		break;
 	case OSD_OpenRaw:
 		if (dc->color < OSD_BITMAP1 || dc->color > OSD_CURSOR) {
 			ret = -EINVAL;
-			goto out;
+			break;
 		}
-		if (dc->color >= OSD_BITMAP1 && dc->color <= OSD_BITMAP8HR) {
+		if (dc->color >= OSD_BITMAP1 && dc->color <= OSD_BITMAP8HR)
 			av7110->osdbpp[av7110->osdwin] = (1 << (dc->color & 3)) - 1;
-		}
-		else {
+		else
 			av7110->osdbpp[av7110->osdwin] = 0;
-		}
-		CreateOSDWindow(av7110, av7110->osdwin, (osd_raw_window_t)dc->color,
+		ret = CreateOSDWindow(av7110, av7110->osdwin, (osd_raw_window_t)dc->color,
 				dc->x1 - dc->x0 + 1, dc->y1 - dc->y0 + 1);
+		if (ret)
+			break;
 		if (!dc->data) {
-			MoveWindowAbs(av7110, av7110->osdwin, dc->x0, dc->y0);
-			SetColorBlend(av7110, av7110->osdwin);
+			ret = MoveWindowAbs(av7110, av7110->osdwin, dc->x0, dc->y0);
+			if (!ret)
+				ret = SetColorBlend(av7110, av7110->osdwin);
 		}
-		goto out;
+		break;
 	default:
 		ret = -EINVAL;
-		goto out;
+		break;
 	}
 
-out:
 	up(&av7110->osd_sema);
+	if (ret==-ERESTARTSYS)
+		dprintk(1, "av7110_osd_cmd(%d) returns with -ERESTARTSYS\n",dc->cmd);
+	else if (ret)
+		dprintk(1, "av7110_osd_cmd(%d) returns with %d\n",dc->cmd,ret);
+
 	return ret;
 }
 

--

