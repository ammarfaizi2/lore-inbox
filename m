Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbUKGR66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbUKGR66 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 12:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUKGR66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 12:58:58 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40719 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261666AbUKGR61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 12:58:27 -0500
Date: Sun, 7 Nov 2004 18:57:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: kraxel@bytesex.org, michael@mihu.de
Cc: linux-kernel@vger.kernel.org
Subject: RFC: [2.6 patch] saa7146 cleanups
Message-ID: <20041107175751.GQ14308@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following saa7146 cleanups:
- make needlessly global code static
- remove unused code

Please comment on this, especially if patches for in-kernel uses of 
currently unused code are pending.


diffstat output:
 drivers/media/common/saa7146_core.c |   22 ++--------------------
 drivers/media/common/saa7146_fops.c |   11 -----------
 drivers/media/common/saa7146_hlp.c  |   21 ++-------------------
 drivers/media/common/saa7146_i2c.c  |    2 +-
 drivers/media/common/saa7146_vbi.c  |    2 +-
 include/media/saa7146_vv.h          |    3 ---
 6 files changed, 6 insertions(+), 55 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/include/media/saa7146_vv.h.old	2004-11-07 18:36:50.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/include/media/saa7146_vv.h	2004-11-07 18:38:07.000000000 +0100
@@ -207,7 +207,6 @@
 void saa7146_set_capture(struct saa7146_dev *dev, struct saa7146_buf *buf, struct saa7146_buf *next);
 void saa7146_write_out_dma(struct saa7146_dev* dev, int which, struct saa7146_video_dma* vdma) ;
 void saa7146_set_hps_source_and_sync(struct saa7146_dev *saa, int source, int sync);
-void saa7146_set_gpio(struct saa7146_dev *saa, u8 pin, u8 data);
 
 /* from saa7146_video.c */
 extern struct saa7146_use_ops saa7146_video_uops;
@@ -219,8 +218,6 @@
 
 /* resource management functions */
 int saa7146_res_get(struct saa7146_fh *fh, unsigned int bit);
-int saa7146_res_check(struct saa7146_fh *fh, unsigned int bit);
-int saa7146_res_locked(struct saa7146_dev *dev, unsigned int bit);
 void saa7146_res_free(struct saa7146_fh *fh, unsigned int bits);
 
 #define RESOURCE_DMA1_HPS	0x1
--- linux-2.6.10-rc1-mm3-full/drivers/media/common/saa7146_core.c.old	2004-11-07 18:37:09.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/common/saa7146_core.c	2004-11-07 18:37:31.000000000 +0100
@@ -25,7 +25,7 @@
 struct semaphore saa7146_devices_lock;
 
 static int initialized = 0;
-int saa7146_num = 0;
+static int saa7146_num = 0;
 
 unsigned int saa7146_debug = 0;
 
@@ -45,27 +45,9 @@
 #endif
 
 /****************************************************************************
- * gpio and debi helper functions
+ * debi helper function
  ****************************************************************************/
 
-/* write "data" to the gpio-pin "pin" */
-void saa7146_set_gpio(struct saa7146_dev *dev, u8 pin, u8 data)
-{
-	u32 value = 0;
-
-	/* sanity check */
-	if(pin > 3)
-		return;
-
-	/* read old register contents */
-	value = saa7146_read(dev, GPIO_CTRL );
-	
-	value &= ~(0xff << (8*pin));
-	value |= (data << (8*pin));
-
-	saa7146_write(dev, GPIO_CTRL, value);
-}
-
 /* This DEBI code is based on the saa7146 Stradis driver by Nathan Laredo */
 int saa7146_wait_for_debi_done(struct saa7146_dev *dev)
 {
--- linux-2.6.10-rc1-mm3-full/drivers/media/common/saa7146_fops.c.old	2004-11-07 18:38:17.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/common/saa7146_fops.c	2004-11-07 18:39:23.000000000 +0100
@@ -32,17 +32,6 @@
 	return 1;
 }
 
-int saa7146_res_check(struct saa7146_fh *fh, unsigned int bit)
-{
-	return (fh->resources & bit);
-}
-
-int saa7146_res_locked(struct saa7146_dev *dev, unsigned int bit)
-{
-	struct saa7146_vv *vv = dev->vv_data;
-	return (vv->resources & bit);
-}
-
 void saa7146_res_free(struct saa7146_fh *fh, unsigned int bits)
 {
 	struct saa7146_dev *dev = fh->dev;
--- linux-2.6.10-rc1-mm3-full/drivers/media/common/saa7146_hlp.c.old	2004-11-07 18:39:46.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/common/saa7146_hlp.c	2004-11-07 18:45:20.000000000 +0100
@@ -9,11 +9,6 @@
 	*clip_format |=  (( ((palette&0xf00)>>8) << 30) | ((palette&0x00f) << 24) | (((palette&0x0f0)>>4) << 16));
 }
 
-static void calculate_bcs_ctrl_register(struct saa7146_dev *dev, int brightness, int contrast, int colour, u32 *bcs_ctrl)
-{
-	*bcs_ctrl = ((brightness << 24) | (contrast << 16) | (colour <<  0));
-}
-
 static void calculate_hps_source_and_sync(struct saa7146_dev *dev, int source, int sync, u32* hps_ctrl)
 {
 	*hps_ctrl &= ~(MASK_30 | MASK_31 | MASK_28);
@@ -62,7 +57,7 @@
 };
 
 /* table of attenuation values for horizontal scaling */
-u8 h_attenuation[] = { 1, 2, 4, 8, 2, 4, 8, 16, 0};
+static u8 h_attenuation[] = { 1, 2, 4, 8, 2, 4, 8, 16, 0};
 
 /* calculate horizontal scale registers */
 static int calculate_h_scale_registers(struct saa7146_dev *dev,
@@ -208,7 +203,7 @@
 };
 
 /* table of attenuation values for vertical scaling */
-u16 v_attenuation[] = { 2, 4, 8, 16, 32, 64, 128, 256, 0};
+static u16 v_attenuation[] = { 2, 4, 8, 16, 32, 64, 128, 256, 0};
 
 /* calculate vertical scale registers */
 static int calculate_v_scale_registers(struct saa7146_dev *dev, enum v4l2_field field,
@@ -620,18 +615,6 @@
       	saa7146_write(dev, MC2, (MASK_05 | MASK_21));
 }
 
-void saa7146_set_picture_prop(struct saa7146_dev *dev, int brightness, int contrast, int colour)
-{
-	u32	bcs_ctrl = 0;
-	
-	calculate_bcs_ctrl_register(dev, brightness, contrast, colour, &bcs_ctrl);
-	saa7146_write(dev, BCS_CTRL, bcs_ctrl);
-	
-	/* update the bcs register */
-      	saa7146_write(dev, MC2, (MASK_06 | MASK_22));
-}
-
-
 /* select input-source */
 void saa7146_set_hps_source_and_sync(struct saa7146_dev *dev, int source, int sync)
 {
--- linux-2.6.10-rc1-mm3-full/drivers/media/common/saa7146_i2c.c.old	2004-11-07 18:40:26.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/common/saa7146_i2c.c	2004-11-07 18:40:37.000000000 +0100
@@ -1,7 +1,7 @@
 #include <linux/version.h>
 #include <media/saa7146_vv.h>
 
-u32 saa7146_i2c_func(struct i2c_adapter *adapter)
+static u32 saa7146_i2c_func(struct i2c_adapter *adapter)
 {
 //fm	DEB_I2C(("'%s'.\n", adapter->name));
 
--- linux-2.6.10-rc1-mm3-full/drivers/media/common/saa7146_vbi.c.old	2004-11-07 18:41:12.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/common/saa7146_vbi.c	2004-11-07 18:41:20.000000000 +0100
@@ -130,7 +130,7 @@
 	return 0;
 }
 
-void saa7146_set_vbi_capture(struct saa7146_dev *dev, struct saa7146_buf *buf, struct saa7146_buf *next)
+static void saa7146_set_vbi_capture(struct saa7146_dev *dev, struct saa7146_buf *buf, struct saa7146_buf *next)
 {
 	struct saa7146_vv *vv = dev->vv_data;
 

