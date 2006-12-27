Return-Path: <linux-kernel-owner+w=401wt.eu-S964769AbWL0RNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964769AbWL0RNi (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932997AbWL0RNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:13:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41533 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933018AbWL0RNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:13:25 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Thierry MERLE <thierry.merle@free.fr>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 09/28] V4L/DVB (4970): Usbvision memory fixes
Date: Wed, 27 Dec 2006 14:57:28 -0200
Message-id: <20061227165728.PS70472000009@infradead.org>
In-Reply-To: <20061227165016.PS89442900000@infradead.org>
References: <20061227165016.PS89442900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Thierry MERLE <thierry.merle@free.fr>

- fix decompression buffer allocation not done at first driver open
- simplification of USB sbuf allocation (use of usb_buffer_alloc)
- replaced vmalloc by vmalloc_32 (for homogeneity)
- add of saa7111 (i2cAddr=0x48) detection printout in attach_inform

Signed-off-by: Thierry MERLE <thierry.merle@free.fr>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/usbvision/usbvision-core.c  |   48 ++++++-----------------
 drivers/media/video/usbvision/usbvision-i2c.c   |    3 +
 drivers/media/video/usbvision/usbvision-video.c |   14 ++-----
 drivers/media/video/usbvision/usbvision.h       |    2 -
 4 files changed, 19 insertions(+), 48 deletions(-)

diff --git a/drivers/media/video/usbvision/usbvision-core.c b/drivers/media/video/usbvision/usbvision-core.c
index 6126873..68542f2 100644
--- a/drivers/media/video/usbvision/usbvision-core.c
+++ b/drivers/media/video/usbvision/usbvision-core.c
@@ -374,7 +374,7 @@ static void scratch_reset(struct usb_usb
 
 int usbvision_scratch_alloc(struct usb_usbvision *usbvision)
 {
-	usbvision->scratch = vmalloc(scratch_buf_size);
+	usbvision->scratch = vmalloc_32(scratch_buf_size);
 	scratch_reset(usbvision);
 	if(usbvision->scratch == NULL) {
 		err("%s: unable to allocate %d bytes for scratch",
@@ -485,7 +485,7 @@ static void usbvision_testpattern(struct
 int usbvision_decompress_alloc(struct usb_usbvision *usbvision)
 {
 	int IFB_size = MAX_FRAME_WIDTH * MAX_FRAME_HEIGHT * 3 / 2;
-	usbvision->IntraFrameBuffer = vmalloc(IFB_size);
+	usbvision->IntraFrameBuffer = vmalloc_32(IFB_size);
 	if (usbvision->IntraFrameBuffer == NULL) {
 		err("%s: unable to allocate %d for compr. frame buffer", __FUNCTION__, IFB_size);
 		return -ENOMEM;
@@ -2204,6 +2204,7 @@ int usbvision_power_on(struct usb_usbvis
 	usbvision_write_reg(usbvision, USBVISION_PWR_REG, USBVISION_SSPND_EN);
 	usbvision_write_reg(usbvision, USBVISION_PWR_REG,
 			 USBVISION_SSPND_EN | USBVISION_RES2);
+
 	usbvision_write_reg(usbvision, USBVISION_PWR_REG,
 			 USBVISION_SSPND_EN | USBVISION_PWR_VID);
 	errCode = usbvision_write_reg(usbvision, USBVISION_PWR_REG,
@@ -2351,40 +2352,6 @@ int usbvision_setup(struct usb_usbvision
 	return USBVISION_IS_OPERATIONAL(usbvision);
 }
 
-
-int usbvision_sbuf_alloc(struct usb_usbvision *usbvision)
-{
-	int i, errCode = 0;
-	const int sb_size = USBVISION_URB_FRAMES * USBVISION_MAX_ISOC_PACKET_SIZE;
-
-	/* Clean pointers so we know if we allocated something */
-	for (i = 0; i < USBVISION_NUMSBUF; i++)
-		usbvision->sbuf[i].data = NULL;
-
-	for (i = 0; i < USBVISION_NUMSBUF; i++) {
-		usbvision->sbuf[i].data = kzalloc(sb_size, GFP_KERNEL);
-		if (usbvision->sbuf[i].data == NULL) {
-			err("%s: unable to allocate %d bytes for sbuf", __FUNCTION__, sb_size);
-			errCode = -ENOMEM;
-			break;
-		}
-	}
-	return errCode;
-}
-
-
-void usbvision_sbuf_free(struct usb_usbvision *usbvision)
-{
-	int i;
-
-	for (i = 0; i < USBVISION_NUMSBUF; i++) {
-		if (usbvision->sbuf[i].data != NULL) {
-			kfree(usbvision->sbuf[i].data);
-			usbvision->sbuf[i].data = NULL;
-		}
-	}
-}
-
 /*
  * usbvision_init_isoc()
  *
@@ -2393,6 +2360,7 @@ int usbvision_init_isoc(struct usb_usbvi
 {
 	struct usb_device *dev = usbvision->dev;
 	int bufIdx, errCode, regValue;
+	const int sb_size = USBVISION_URB_FRAMES * USBVISION_MAX_ISOC_PACKET_SIZE;
 
 	if (!USBVISION_IS_OPERATIONAL(usbvision))
 		return -EFAULT;
@@ -2428,6 +2396,7 @@ int usbvision_init_isoc(struct usb_usbvi
 			return -ENOMEM;
 		}
 		usbvision->sbuf[bufIdx].urb = urb;
+		usbvision->sbuf[bufIdx].data = usb_buffer_alloc(usbvision->dev, sb_size, GFP_KERNEL,&urb->transfer_dma);
 		urb->dev = dev;
 		urb->context = usbvision;
 		urb->pipe = usb_rcvisocpipe(dev, usbvision->video_endp);
@@ -2469,6 +2438,7 @@ int usbvision_init_isoc(struct usb_usbvi
 void usbvision_stop_isoc(struct usb_usbvision *usbvision)
 {
 	int bufIdx, errCode, regValue;
+	const int sb_size = USBVISION_URB_FRAMES * USBVISION_MAX_ISOC_PACKET_SIZE;
 
 	if ((usbvision->streaming == Stream_Off) || (usbvision->dev == NULL))
 		return;
@@ -2476,6 +2446,12 @@ void usbvision_stop_isoc(struct usb_usbv
 	/* Unschedule all of the iso td's */
 	for (bufIdx = 0; bufIdx < USBVISION_NUMSBUF; bufIdx++) {
 		usb_kill_urb(usbvision->sbuf[bufIdx].urb);
+		if (usbvision->sbuf[bufIdx].data){
+			usb_buffer_free(usbvision->dev,
+					sb_size,
+					usbvision->sbuf[bufIdx].data,
+					usbvision->sbuf[bufIdx].urb->transfer_dma);
+		}
 		usb_free_urb(usbvision->sbuf[bufIdx].urb);
 		usbvision->sbuf[bufIdx].urb = NULL;
 	}
diff --git a/drivers/media/video/usbvision/usbvision-i2c.c b/drivers/media/video/usbvision/usbvision-i2c.c
index efcd25b..858252c 100644
--- a/drivers/media/video/usbvision/usbvision-i2c.c
+++ b/drivers/media/video/usbvision/usbvision-i2c.c
@@ -319,6 +319,9 @@ static int attach_inform(struct i2c_clie
 		case 0x4a:
 			PDEBUG(DBG_I2C,"attach_inform: saa7113 detected.");
 			break;
+		case 0x48:
+			PDEBUG(DBG_I2C,"attach_inform: saa7111 detected.");
+			break;
 		case 0xa0:
 			PDEBUG(DBG_I2C,"attach_inform: eeprom detected.");
 			break;
diff --git a/drivers/media/video/usbvision/usbvision-video.c b/drivers/media/video/usbvision/usbvision-video.c
index b77e25e..31b133e 100644
--- a/drivers/media/video/usbvision/usbvision-video.c
+++ b/drivers/media/video/usbvision/usbvision-video.c
@@ -353,20 +353,15 @@ static int usbvision_v4l2_open(struct in
 		if(!errCode) {
 			/* Allocate memory for the scratch ring buffer */
 			errCode = usbvision_scratch_alloc(usbvision);
-			if(!errCode) {
-				/* Allocate memory for the USB S buffers */
-				errCode = usbvision_sbuf_alloc(usbvision);
-				if ((!errCode) && (usbvision->isocMode==ISOC_MODE_COMPRESS)) {
-					/* Allocate intermediate decompression buffers only if needed */
-					errCode = usbvision_decompress_alloc(usbvision);
-				}
+			if ((!errCode) && (isocMode==ISOC_MODE_COMPRESS)) {
+				/* Allocate intermediate decompression buffers only if needed */
+				errCode = usbvision_decompress_alloc(usbvision);
 			}
 		}
 		if (errCode) {
 			/* Deallocate all buffers if trouble */
 			usbvision_frames_free(usbvision);
 			usbvision_scratch_free(usbvision);
-			usbvision_sbuf_free(usbvision);
 			usbvision_decompress_free(usbvision);
 		}
 	}
@@ -437,9 +432,8 @@ static int usbvision_v4l2_close(struct i
 	usbvision_stop_isoc(usbvision);
 
 	usbvision_decompress_free(usbvision);
-	usbvision_rvfree(usbvision->fbuf, usbvision->fbuf_size);
+	usbvision_frames_free(usbvision);
 	usbvision_scratch_free(usbvision);
-	usbvision_sbuf_free(usbvision);
 
 	usbvision->user--;
 
diff --git a/drivers/media/video/usbvision/usbvision.h b/drivers/media/video/usbvision/usbvision.h
index b1645f9..e2bcaba 100644
--- a/drivers/media/video/usbvision/usbvision.h
+++ b/drivers/media/video/usbvision/usbvision.h
@@ -495,8 +495,6 @@ int usbvision_frames_alloc(struct usb_us
 void usbvision_frames_free(struct usb_usbvision *usbvision);
 int usbvision_scratch_alloc(struct usb_usbvision *usbvision);
 void usbvision_scratch_free(struct usb_usbvision *usbvision);
-int usbvision_sbuf_alloc(struct usb_usbvision *usbvision);
-void usbvision_sbuf_free(struct usb_usbvision *usbvision);
 int usbvision_decompress_alloc(struct usb_usbvision *usbvision);
 void usbvision_decompress_free(struct usb_usbvision *usbvision);
 

