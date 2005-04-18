Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVDRVsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVDRVsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 17:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVDRVsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 17:48:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61961 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261163AbVDRVrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 17:47:42 -0400
Date: Mon, 18 Apr 2005 23:47:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: luc@saillard.org
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: [2.6 patch] drivers/usb/media/pwc/: make code static
Message-ID: <20050418214738.GE5489@stusta.de>
References: <20050418020455.GB3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050418020455.GB3625@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch lacked a small bit.

Updated patch below.

cu
Adrian


<--  snip  -->


This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/media/pwc/pwc-ctrl.c |   78 +++++++++++++++----------------
 drivers/usb/media/pwc/pwc-if.c   |    2 
 drivers/usb/media/pwc/pwc.h      |    6 --
 3 files changed, 41 insertions(+), 45 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/usb/media/pwc/pwc.h.old	2005-04-18 03:11:14.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/usb/media/pwc/pwc.h	2005-04-18 03:13:28.000000000 +0200
@@ -226,9 +226,8 @@
 extern "C" {
 #endif
 
-/* Global variables */
+/* Global variable */
 extern int pwc_trace;
-extern int pwc_preferred_compression;
 
 /** functions in pwc-if.c */
 int pwc_try_video_mode(struct pwc_device *pdev, int width, int height, int new_fps, int new_compression, int new_snapshot);
@@ -243,8 +242,6 @@
 /** Functions in pwc-ctrl.c */
 /* Request a certain video mode. Returns < 0 if not possible */
 extern int pwc_set_video_mode(struct pwc_device *pdev, int width, int height, int frames, int compression, int snapshot);
-/* Calculate the number of bytes per image (not frame) */
-extern void pwc_set_image_buffer_size(struct pwc_device *pdev);
 
 /* Various controls; should be obvious. Value 0..65535, or < 0 on error */
 extern int pwc_get_brightness(struct pwc_device *pdev);
@@ -256,7 +253,6 @@
 extern int pwc_get_saturation(struct pwc_device *pdev);
 extern int pwc_set_saturation(struct pwc_device *pdev, int value);
 extern int pwc_set_leds(struct pwc_device *pdev, int on_value, int off_value);
-extern int pwc_get_leds(struct pwc_device *pdev, int *on_value, int *off_value);
 extern int pwc_get_cmos_sensor(struct pwc_device *pdev, int *sensor);
 
 /* Power down or up the camera; not supported by all models */
--- linux-2.6.12-rc2-mm3-full/drivers/usb/media/pwc/pwc-ctrl.c.old	2005-04-18 03:11:29.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/usb/media/pwc/pwc-ctrl.c	2005-04-18 22:57:34.000000000 +0200
@@ -418,6 +418,44 @@
 
 
 
+static void pwc_set_image_buffer_size(struct pwc_device *pdev)
+{
+	int i, factor = 0, filler = 0;
+
+	/* for PALETTE_YUV420P */
+	switch(pdev->vpalette)
+	{
+	case VIDEO_PALETTE_YUV420P:
+		factor = 6;
+		filler = 128;
+		break;
+	case VIDEO_PALETTE_RAW:
+		factor = 6; /* can be uncompressed YUV420P */
+		filler = 0;
+		break;
+	}
+
+	/* Set sizes in bytes */
+	pdev->image.size = pdev->image.x * pdev->image.y * factor / 4;
+	pdev->view.size  = pdev->view.x  * pdev->view.y  * factor / 4;
+
+	/* Align offset, or you'll get some very weird results in
+	   YUV420 mode... x must be multiple of 4 (to get the Y's in
+	   place), and y even (or you'll mixup U & V). This is less of a
+	   problem for YUV420P.
+	 */
+	pdev->offset.x = ((pdev->view.x - pdev->image.x) / 2) & 0xFFFC;
+	pdev->offset.y = ((pdev->view.y - pdev->image.y) / 2) & 0xFFFE;
+
+	/* Fill buffers with gray or black */
+	for (i = 0; i < MAX_IMAGES; i++) {
+		if (pdev->image_ptr[i] != NULL)
+			memset(pdev->image_ptr[i], filler, pdev->view.size);
+	}
+}
+
+
+
 /**
    @pdev: device structure
    @width: viewport width
@@ -475,44 +513,6 @@
 }
 
 
-void pwc_set_image_buffer_size(struct pwc_device *pdev)
-{
-	int i, factor = 0, filler = 0;
-
-	/* for PALETTE_YUV420P */
-	switch(pdev->vpalette)
-	{
-	case VIDEO_PALETTE_YUV420P:
-		factor = 6;
-		filler = 128;
-		break;
-	case VIDEO_PALETTE_RAW:
-		factor = 6; /* can be uncompressed YUV420P */
-		filler = 0;
-		break;
-	}
-
-	/* Set sizes in bytes */
-	pdev->image.size = pdev->image.x * pdev->image.y * factor / 4;
-	pdev->view.size  = pdev->view.x  * pdev->view.y  * factor / 4;
-
-	/* Align offset, or you'll get some very weird results in
-	   YUV420 mode... x must be multiple of 4 (to get the Y's in
-	   place), and y even (or you'll mixup U & V). This is less of a
-	   problem for YUV420P.
-	 */
-	pdev->offset.x = ((pdev->view.x - pdev->image.x) / 2) & 0xFFFC;
-	pdev->offset.y = ((pdev->view.y - pdev->image.y) / 2) & 0xFFFE;
-
-	/* Fill buffers with gray or black */
-	for (i = 0; i < MAX_IMAGES; i++) {
-		if (pdev->image_ptr[i] != NULL)
-			memset(pdev->image_ptr[i], filler, pdev->view.size);
-	}
-}
-
-
-
 /* BRIGHTNESS */
 
 int pwc_get_brightness(struct pwc_device *pdev)
@@ -949,7 +949,7 @@
 	return SendControlMsg(SET_STATUS_CTL, LED_FORMATTER, 2);
 }
 
-int pwc_get_leds(struct pwc_device *pdev, int *on_value, int *off_value)
+static int pwc_get_leds(struct pwc_device *pdev, int *on_value, int *off_value)
 {
 	unsigned char buf[2];
 	int ret;
--- linux-2.6.12-rc2-mm3-full/drivers/usb/media/pwc/pwc-if.c.old	2005-04-18 03:13:37.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/usb/media/pwc/pwc-if.c	2005-04-18 03:13:53.000000000 +0200
@@ -129,7 +129,7 @@
        int pwc_trace = TRACE_MODULE | TRACE_FLOW | TRACE_PWCX;
 static int power_save = 0;
 static int led_on = 100, led_off = 0; /* defaults to LED that is on while in use */
-       int pwc_preferred_compression = 2; /* 0..3 = uncompressed..high */
+static int pwc_preferred_compression = 2; /* 0..3 = uncompressed..high */
 static struct {
 	int type;
 	char serial_number[30];
