Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWCTPVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWCTPVk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966837AbWCTPVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:21:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47074 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966842AbWCTPVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:21:37 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 010/141] V4L/DVB (3407): added some code for VBI processing
	and cleanup debug dump
Date: Mon, 20 Mar 2006 12:08:38 -0300
Message-id: <20060320150838.PS726765000010@infradead.org>
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

From: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: 1138043465 -0200

- Renamed some registers and improved register debug message
- Some cleanups at register dump
- Added code to set VBI processor (VDP)
- VBI code still incomplete

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tvp5150.c b/drivers/media/video/tvp5150.c
diff --git a/drivers/media/video/tvp5150.c b/drivers/media/video/tvp5150.c
index a6330a3..f7fa93c 100644
--- a/drivers/media/video/tvp5150.c
+++ b/drivers/media/video/tvp5150.c
@@ -29,6 +29,9 @@ static int debug = 0;
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "Debug level (0-1)");
 
+#define tvp5150_err(fmt, arg...) do { \
+	printk(KERN_ERR "%s %d-%04x: " fmt, c->driver->driver.name, \
+	       i2c_adapter_id(c->adapter), c->addr , ## arg); } while (0)
 #define tvp5150_info(fmt, arg...) do { \
 	printk(KERN_INFO "%s %d-%04x: " fmt, c->driver->driver.name, \
 	       i2c_adapter_id(c->adapter), c->addr , ## arg); } while (0)
@@ -84,7 +87,7 @@ static struct v4l2_queryctrl tvp5150_qct
 struct tvp5150 {
 	struct i2c_client *client;
 
-	int norm;
+	v4l2_std_id norm;	/* Current set standard */
 	int input;
 	int enable;
 	int bright;
@@ -125,310 +128,155 @@ static inline void tvp5150_write(struct 
 		tvp5150_dbg(0, "i2c i/o error: rc == %d (should be 2)\n", rc);
 }
 
+static void dump_reg_range(struct i2c_client *c, char *s, u8 init, const u8 end,int max_line)
+{
+	int i=0;
+
+	while (init!=(u8)(end+1)) {
+		if ((i%max_line) == 0) {
+			if (i>0)
+				printk("\n");
+			printk("tvp5150: %s reg 0x%02x = ",s,init);
+		}
+		printk("%02x ",tvp5150_read(c, init));
+
+		init++;
+		i++;
+	}
+	printk("\n");
+}
+
 static void dump_reg(struct i2c_client *c)
 {
 	printk("tvp5150: Video input source selection #1 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VD_IN_SRC_SEL_1));
+					tvp5150_read(c, TVP5150_VD_IN_SRC_SEL_1));
 	printk("tvp5150: Analog channel controls = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_ANAL_CHL_CTL));
+					tvp5150_read(c, TVP5150_ANAL_CHL_CTL));
 	printk("tvp5150: Operation mode controls = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_OP_MODE_CTL));
+					tvp5150_read(c, TVP5150_OP_MODE_CTL));
 	printk("tvp5150: Miscellaneous controls = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_MISC_CTL));
-	printk("tvp5150: Autoswitch mask: TVP5150A / TVP5150AM = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_AUTOSW_MSK));
+					tvp5150_read(c, TVP5150_MISC_CTL));
+	printk("tvp5150: Autoswitch mask= 0x%02x\n",
+					tvp5150_read(c, TVP5150_AUTOSW_MSK));
 	printk("tvp5150: Color killer threshold control = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_COLOR_KIL_THSH_CTL));
-	printk("tvp5150: Luminance processing control #1 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LUMA_PROC_CTL_1));
-	printk("tvp5150: Luminance processing control #2 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LUMA_PROC_CTL_2));
+					tvp5150_read(c, TVP5150_COLOR_KIL_THSH_CTL));
+	printk("tvp5150: Luminance processing controls #1 #2 and #3 = %02x %02x %02x\n",
+					tvp5150_read(c, TVP5150_LUMA_PROC_CTL_1),
+					tvp5150_read(c, TVP5150_LUMA_PROC_CTL_2),
+					tvp5150_read(c, TVP5150_LUMA_PROC_CTL_3));
 	printk("tvp5150: Brightness control = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_BRIGHT_CTL));
+					tvp5150_read(c, TVP5150_BRIGHT_CTL));
 	printk("tvp5150: Color saturation control = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_SATURATION_CTL));
+					tvp5150_read(c, TVP5150_SATURATION_CTL));
 	printk("tvp5150: Hue control = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_HUE_CTL));
+					tvp5150_read(c, TVP5150_HUE_CTL));
 	printk("tvp5150: Contrast control = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_CONTRAST_CTL));
+					tvp5150_read(c, TVP5150_CONTRAST_CTL));
 	printk("tvp5150: Outputs and data rates select = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_DATA_RATE_SEL));
-	printk("tvp5150: Luminance processing control #3 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LUMA_PROC_CTL_3));
+					tvp5150_read(c, TVP5150_DATA_RATE_SEL));
 	printk("tvp5150: Configuration shared pins = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_CONF_SHARED_PIN));
-	printk("tvp5150: Active video cropping start MSB = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_ACT_VD_CROP_ST_MSB));
-	printk("tvp5150: Active video cropping start LSB = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_ACT_VD_CROP_ST_LSB));
-	printk("tvp5150: Active video cropping stop MSB = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_ACT_VD_CROP_STP_MSB));
-	printk("tvp5150: Active video cropping stop LSB = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_ACT_VD_CROP_STP_LSB));
+					tvp5150_read(c, TVP5150_CONF_SHARED_PIN));
+	printk("tvp5150: Active video cropping start = 0x%02x%02x\n",
+					tvp5150_read(c, TVP5150_ACT_VD_CROP_ST_MSB),
+					tvp5150_read(c, TVP5150_ACT_VD_CROP_ST_LSB));
+	printk("tvp5150: Active video cropping stop  = 0x%02x%02x\n",
+					tvp5150_read(c, TVP5150_ACT_VD_CROP_STP_MSB),
+					tvp5150_read(c, TVP5150_ACT_VD_CROP_STP_LSB));
 	printk("tvp5150: Genlock/RTC = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_GENLOCK));
+					tvp5150_read(c, TVP5150_GENLOCK));
 	printk("tvp5150: Horizontal sync start = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_HORIZ_SYNC_START));
+					tvp5150_read(c, TVP5150_HORIZ_SYNC_START));
 	printk("tvp5150: Vertical blanking start = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VERT_BLANKING_START));
+					tvp5150_read(c, TVP5150_VERT_BLANKING_START));
 	printk("tvp5150: Vertical blanking stop = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VERT_BLANKING_STOP));
-	printk("tvp5150: Chrominance processing control #1 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_CHROMA_PROC_CTL_1));
-	printk("tvp5150: Chrominance processing control #2 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_CHROMA_PROC_CTL_2));
+					tvp5150_read(c, TVP5150_VERT_BLANKING_STOP));
+	printk("tvp5150: Chrominance processing control #1 and #2 = %02x %02x\n",
+					tvp5150_read(c, TVP5150_CHROMA_PROC_CTL_1),
+					tvp5150_read(c, TVP5150_CHROMA_PROC_CTL_2));
 	printk("tvp5150: Interrupt reset register B = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_INT_RESET_REG_B));
+					tvp5150_read(c, TVP5150_INT_RESET_REG_B));
 	printk("tvp5150: Interrupt enable register B = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_INT_ENABLE_REG_B));
+					tvp5150_read(c, TVP5150_INT_ENABLE_REG_B));
 	printk("tvp5150: Interrupt configuration register B = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_INTT_CONFIG_REG_B));
+					tvp5150_read(c, TVP5150_INTT_CONFIG_REG_B));
 	printk("tvp5150: Video standard = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VIDEO_STD));
-	printk("tvp5150: Cb gain factor = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_CB_GAIN_FACT));
-	printk("tvp5150: Cr gain factor = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_CR_GAIN_FACTOR));
+					tvp5150_read(c, TVP5150_VIDEO_STD));
+	printk("tvp5150: Chroma gain factor: Cb=0x%02x Cr=0x%02x\n",
+					tvp5150_read(c, TVP5150_CB_GAIN_FACT),
+					tvp5150_read(c, TVP5150_CR_GAIN_FACTOR));
 	printk("tvp5150: Macrovision on counter = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_MACROVISION_ON_CTR));
+					tvp5150_read(c, TVP5150_MACROVISION_ON_CTR));
 	printk("tvp5150: Macrovision off counter = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_MACROVISION_OFF_CTR));
-	printk("tvp5150: revision select (TVP5150AM1 only) = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_REV_SELECT));
-	printk("tvp5150: MSB of device ID = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_MSB_DEV_ID));
-	printk("tvp5150: LSB of device ID = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LSB_DEV_ID));
-	printk("tvp5150: ROM major version = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_ROM_MAJOR_VER));
-	printk("tvp5150: ROM minor version = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_ROM_MINOR_VER));
-	printk("tvp5150: Vertical line count MSB = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VERT_LN_COUNT_MSB));
-	printk("tvp5150: Vertical line count LSB = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VERT_LN_COUNT_LSB));
+					tvp5150_read(c, TVP5150_MACROVISION_OFF_CTR));
+	printk("tvp5150: ITU-R BT.656.%d timing(TVP5150AM1 only)\n",
+					(tvp5150_read(c, TVP5150_REV_SELECT)&1)?3:4);
+	printk("tvp5150: Device ID = %02x%02x\n",
+					tvp5150_read(c, TVP5150_MSB_DEV_ID),
+					tvp5150_read(c, TVP5150_LSB_DEV_ID));
+	printk("tvp5150: ROM version = (hex) %02x.%02x\n",
+					tvp5150_read(c, TVP5150_ROM_MAJOR_VER),
+					tvp5150_read(c, TVP5150_ROM_MINOR_VER));
+	printk("tvp5150: Vertical line count = 0x%02x%02x\n",
+					tvp5150_read(c, TVP5150_VERT_LN_COUNT_MSB),
+					tvp5150_read(c, TVP5150_VERT_LN_COUNT_LSB));
 	printk("tvp5150: Interrupt status register B = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_INT_STATUS_REG_B));
+					tvp5150_read(c, TVP5150_INT_STATUS_REG_B));
 	printk("tvp5150: Interrupt active register B = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_INT_ACTIVE_REG_B));
-	printk("tvp5150: Status register #1 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_STATUS_REG_1));
-	printk("tvp5150: Status register #2 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_STATUS_REG_2));
-	printk("tvp5150: Status register #3 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_STATUS_REG_3));
-	printk("tvp5150: Status register #4 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_STATUS_REG_4));
-	printk("tvp5150: Status register #5 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_STATUS_REG_5));
-	printk("tvp5150: Closed caption data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_CC_DATA_REG1));
-	printk("tvp5150: Closed caption data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_CC_DATA_REG2));
-	printk("tvp5150: Closed caption data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_CC_DATA_REG3));
-	printk("tvp5150: Closed caption data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_CC_DATA_REG4));
-	printk("tvp5150: WSS data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_WSS_DATA_REG1));
-	printk("tvp5150: WSS data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_WSS_DATA_REG2));
-	printk("tvp5150: WSS data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_WSS_DATA_REG3));
-	printk("tvp5150: WSS data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_WSS_DATA_REG4));
-	printk("tvp5150: WSS data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_WSS_DATA_REG5));
-	printk("tvp5150: WSS data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_WSS_DATA_REG6));
-	printk("tvp5150: VPS data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VPS_DATA_REG1));
-	printk("tvp5150: VPS data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VPS_DATA_REG2));
-	printk("tvp5150: VPS data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VPS_DATA_REG3));
-	printk("tvp5150: VPS data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VPS_DATA_REG4));
-	printk("tvp5150: VPS data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VPS_DATA_REG5));
-	printk("tvp5150: VPS data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VPS_DATA_REG6));
-	printk("tvp5150: VPS data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VPS_DATA_REG7));
-	printk("tvp5150: VPS data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VPS_DATA_REG8));
-	printk("tvp5150: VPS data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VPS_DATA_REG9));
-	printk("tvp5150: VPS data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VPS_DATA_REG10));
-	printk("tvp5150: VPS data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VPS_DATA_REG11));
-	printk("tvp5150: VPS data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VPS_DATA_REG12));
-	printk("tvp5150: VPS data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VPS_DATA_REG13));
-	printk("tvp5150: VITC data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VITC_DATA_REG1));
-	printk("tvp5150: VITC data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VITC_DATA_REG2));
-	printk("tvp5150: VITC data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VITC_DATA_REG3));
-	printk("tvp5150: VITC data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VITC_DATA_REG4));
-	printk("tvp5150: VITC data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VITC_DATA_REG5));
-	printk("tvp5150: VITC data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VITC_DATA_REG6));
-	printk("tvp5150: VITC data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VITC_DATA_REG7));
-	printk("tvp5150: VITC data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VITC_DATA_REG8));
-	printk("tvp5150: VITC data registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VITC_DATA_REG9));
-	printk("tvp5150: VBI FIFO read data = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VBI_FIFO_READ_DATA));
-	printk("tvp5150: Teletext filter 1 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_TELETEXT_FIL_1_1));
-	printk("tvp5150: Teletext filter 1 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_TELETEXT_FIL_1_2));
-	printk("tvp5150: Teletext filter 1 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_TELETEXT_FIL_1_3));
-	printk("tvp5150: Teletext filter 1 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_TELETEXT_FIL_1_4));
-	printk("tvp5150: Teletext filter 1 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_TELETEXT_FIL_1_5));
-	printk("tvp5150: Teletext filter 2 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_TELETEXT_FIL_2_1));
-	printk("tvp5150: Teletext filter 2 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_TELETEXT_FIL_2_2));
-	printk("tvp5150: Teletext filter 2 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_TELETEXT_FIL_2_3));
-	printk("tvp5150: Teletext filter 2 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_TELETEXT_FIL_2_4));
-	printk("tvp5150: Teletext filter 2 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_TELETEXT_FIL_2_5));
+					tvp5150_read(c, TVP5150_INT_ACTIVE_REG_B));
+	printk("tvp5150: Status regs #1 to #5 = %02x %02x %02x %02x %02x\n",
+					tvp5150_read(c, TVP5150_STATUS_REG_1),
+					tvp5150_read(c, TVP5150_STATUS_REG_2),
+					tvp5150_read(c, TVP5150_STATUS_REG_3),
+					tvp5150_read(c, TVP5150_STATUS_REG_4),
+					tvp5150_read(c, TVP5150_STATUS_REG_5));
+
+	dump_reg_range(c,"Teletext filter 1",   TVP5150_TELETEXT_FIL1_INI,
+						TVP5150_TELETEXT_FIL1_END,8);
+	dump_reg_range(c,"Teletext filter 2",   TVP5150_TELETEXT_FIL2_INI,
+						TVP5150_TELETEXT_FIL2_END,8);
+
 	printk("tvp5150: Teletext filter enable = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_TELETEXT_FIL_ENA));
+					tvp5150_read(c, TVP5150_TELETEXT_FIL_ENA));
 	printk("tvp5150: Interrupt status register A = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_INT_STATUS_REG_A));
+					tvp5150_read(c, TVP5150_INT_STATUS_REG_A));
 	printk("tvp5150: Interrupt enable register A = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_INT_ENABLE_REG_A));
+					tvp5150_read(c, TVP5150_INT_ENABLE_REG_A));
 	printk("tvp5150: Interrupt configuration = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_INT_CONF));
-	printk("tvp5150: VDP configuration RAM data = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VDP_CONF_RAM_DATA));
-	printk("tvp5150: Configuration RAM address low byte = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_CONF_RAM_ADDR_LOW));
-	printk("tvp5150: Configuration RAM address high byte = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_CONF_RAM_ADDR_HIGH));
+					tvp5150_read(c, TVP5150_INT_CONF));
 	printk("tvp5150: VDP status register = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_VDP_STATUS_REG));
+					tvp5150_read(c, TVP5150_VDP_STATUS_REG));
 	printk("tvp5150: FIFO word count = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_FIFO_WORD_COUNT));
+					tvp5150_read(c, TVP5150_FIFO_WORD_COUNT));
 	printk("tvp5150: FIFO interrupt threshold = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_FIFO_INT_THRESHOLD));
+					tvp5150_read(c, TVP5150_FIFO_INT_THRESHOLD));
 	printk("tvp5150: FIFO reset = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_FIFO_RESET));
+					tvp5150_read(c, TVP5150_FIFO_RESET));
 	printk("tvp5150: Line number interrupt = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_NUMBER_INT));
-	printk("tvp5150: Pixel alignment register low byte = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_PIX_ALIGN_REG_LOW));
-	printk("tvp5150: Pixel alignment register high byte = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_PIX_ALIGN_REG_HIGH));
+					tvp5150_read(c, TVP5150_LINE_NUMBER_INT));
+	printk("tvp5150: Pixel alignment register = 0x%02x%02x\n",
+					tvp5150_read(c, TVP5150_PIX_ALIGN_REG_HIGH),
+					tvp5150_read(c, TVP5150_PIX_ALIGN_REG_LOW));
 	printk("tvp5150: FIFO output control = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_FIFO_OUT_CTRL));
-	printk("tvp5150: Full field enable 1 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_FULL_FIELD_ENA_1));
-	printk("tvp5150: Full field enable 2 = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_FULL_FIELD_ENA_2));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_1));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_2));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_3));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_4));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_5));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_6));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_7));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_8));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_9));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_10));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_11));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_12));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_13));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_14));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_15));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_16));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_17));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_18));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_19));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_20));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_21));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_22));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_23));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_24));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_25));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_27));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_28));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_29));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_30));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_31));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_32));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_33));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_34));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_35));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_36));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_37));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_38));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_39));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_40));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_41));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_42));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_43));
-	printk("tvp5150: Line mode registers = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_LINE_MODE_REG_44));
+					tvp5150_read(c, TVP5150_FIFO_OUT_CTRL));
+	printk("tvp5150: Full field enable = 0x%02x\n",
+					tvp5150_read(c, TVP5150_FULL_FIELD_ENA));
 	printk("tvp5150: Full field mode register = 0x%02x\n",
-	       tvp5150_read(c, TVP5150_FULL_FIELD_MODE_REG));
+					tvp5150_read(c, TVP5150_FULL_FIELD_MODE_REG));
+
+	dump_reg_range(c,"CC   data",   TVP5150_CC_DATA_INI,
+					TVP5150_CC_DATA_END,8);
+
+	dump_reg_range(c,"WSS  data",   TVP5150_WSS_DATA_INI,
+					TVP5150_WSS_DATA_END,8);
+
+	dump_reg_range(c,"VPS  data",   TVP5150_VPS_DATA_INI,
+					TVP5150_VPS_DATA_END,8);
+
+	dump_reg_range(c,"VITC data",   TVP5150_VITC_DATA_INI,
+					TVP5150_VITC_DATA_END,10);
+
+	dump_reg_range(c,"Line mode",   TVP5150_LINE_MODE_INI,
+					TVP5150_LINE_MODE_END,8);
 }
 
 /****************************************************************************
@@ -593,10 +441,10 @@ static const struct i2c_reg_value tvp515
 		TVP5150_FIFO_OUT_CTRL,0x01
 	},
 	{ /* 0xcf */
-		TVP5150_FULL_FIELD_ENA_1,0x00
+		TVP5150_FULL_FIELD_ENA,0x00
 	},
 	{ /* 0xd0 */
-		TVP5150_FULL_FIELD_ENA_2,0x00
+		TVP5150_LINE_MODE_INI,0x00
 	},
 	{ /* 0xfc */
 		TVP5150_FULL_FIELD_MODE_REG,0x7f
@@ -634,45 +482,73 @@ struct i2c_vbi_ram_value {
 	unsigned char values[26];
 };
 
+/* tvp5150_vbi_types should follow the same order as vbi_ram_default
+ * value 0 means rom position 0x10, value 1 means rom position 0x30
+ * and so on. There are 16 possible locations from 0 to 15.
+ */
+enum tvp5150_vbi_types {	/* Video line number  Description */
+	VBI_WST_SECAM,		/* 6-23  (field 1,2)  Teletext, SECAM */
+	VBI_WST_PAL_B,		/* 6-22  (field 1,2)  Teletext, PAL, System B */
+	VBI_WST_PAL_C,		/* 6-22  (field 1,2)  Teletext, PAL, System C */
+	VBI_WST_NTSC_B,		/* 10-21 (field 1,2)  Teletext, NTSC, System B */
+	VBI_NABTS_NTSC_C,	/* 10-21 (field 1,2)  Teletext, NTSC, System C */
+	VBI_NABTS_NTSC_D,	/* 10-21 (field 1,2)  Teletext, NTSC, System D */
+	VBI_CC_PAL_SECAM,	/* 22    (field 1,2)  Closed Caption PAL/SECAM */
+	VBI_CC_NTSC,		/* 21    (field 1,2)  Closed Caption NTSC */
+	VBI_WSS_PAL_SECAM,	/* 23    (field 1,2)  Wide Screen Signal PAL/SECAM */
+	VBI_WSS_NTSC,		/* 20    (field 1,2)  Wide Screen Signal NTSC */
+	VBI_VITC_PAL_SECAM,	/* 6-22               Vertical Interval Timecode PAL/SECAM */
+	VBI_VITC_NTSC,		/* 10-20              Vertical Interval Timecode NTSC */
+	VBI_VPS_PAL,		/* 16                 Video Program System PAL */
+	VBI_EPG_GEMSTAR,	/*                    EPG/Gemstar Electronic program guide */
+	VBI_RESERVED,		/*                    not in use on vbi_ram_default table */
+	VBI_FULL_FIELD		/*                    Active video/Full Field */
+};
+
 static struct i2c_vbi_ram_value vbi_ram_default[] =
 {
-	{0x010, /* WST SECAM 6 */
+	{0x010, /* WST SECAM */
 		{ 0xaa, 0xaa, 0xff, 0xff , 0xe7, 0x2e, 0x20, 0x26, 0xe6, 0xb4, 0x0e, 0x0, 0x0, 0x0, 0x10, 0x0 }
 	},
-	{0x030, /* WST PAL B 6 */
+	{0x030, /* WST PAL B */
 		{ 0xaa, 0xaa, 0xff, 0xff , 0x27, 0x2e, 0x20, 0x2b, 0xa6, 0x72, 0x10, 0x0, 0x0, 0x0, 0x10, 0x0 }
 	},
-	{0x050, /* WST PAL C 6 */
+	{0x050, /* WST PAL C */
 		{ 0xaa, 0xaa, 0xff, 0xff , 0xe7, 0x2e, 0x20, 0x22, 0xa6, 0x98, 0x0d, 0x0, 0x0, 0x0, 0x10, 0x0 }
 	},
-	{0x070, /* WST NTSC 6 */
+	{0x070, /* WST NTSC B */
 		{ 0xaa, 0xaa, 0xff, 0xff , 0x27, 0x2e, 0x20, 0x23, 0x69, 0x93, 0x0d, 0x0, 0x0, 0x0, 0x10, 0x0 }
 	},
-	{0x090, /* NABTS, NTSC 6 */
+	{0x090, /* NABTS, NTSC */
 		{ 0xaa, 0xaa, 0xff, 0xff , 0xe7, 0x2e, 0x20, 0x22, 0x69, 0x93, 0x0d, 0x0, 0x0, 0x0, 0x15, 0x0 }
 	},
-	{0x0b0, /* NABTS, NTSC-J 6 */
+	{0x0b0, /* NABTS, NTSC-J */
 		{ 0xaa, 0xaa, 0xff, 0xff , 0xa7, 0x2e, 0x20, 0x23, 0x69, 0x93, 0x0d, 0x0, 0x0, 0x0, 0x10, 0x0 }
 	},
-	{0x0d0, /* CC, PAL/SECAM 6 */
+	{0x0d0, /* CC, PAL/SECAM */
 		{ 0xaa, 0x2a, 0xff, 0x3f , 0x04, 0x51, 0x6e, 0x02, 0xa6, 0x7b, 0x09, 0x0, 0x0, 0x0, 0x27, 0x0 }
 	},
-	{0x0f0, /* CC, NTSC 6 */
+	{0x0f0, /* CC, NTSC */
 		{ 0xaa, 0x2a, 0xff, 0x3f , 0x04, 0x51, 0x6e, 0x02, 0x69, 0x8c, 0x09, 0x0, 0x0, 0x0, 0x27, 0x0 }
 	},
-	{0x110, /* WSS, PAL/SECAM 6 */
+	{0x110, /* WSS, PAL/SECAM */
 		{ 0x5b, 0x55, 0xc5, 0xff , 0x0, 0x71, 0x6e, 0x42, 0xa6, 0xcd, 0x0f, 0x0, 0x0, 0x0, 0x3a, 0x0 }
 	},
 	{0x130, /* WSS, NTSC C */
 		{ 0x38, 0x00, 0x3f, 0x00 , 0x0, 0x71, 0x6e, 0x43, 0x69, 0x7c, 0x08, 0x0, 0x0, 0x0, 0x39, 0x0 }
 	},
-	{0x150, /* VITC, PAL/SECAM 6 */
+	{0x150, /* VITC, PAL/SECAM */
 		{ 0x0, 0x0, 0x0, 0x0 , 0x0, 0x8f, 0x6d, 0x49, 0xa6, 0x85, 0x08, 0x0, 0x0, 0x0, 0x4c, 0x0 }
 	},
-	{0x170, /* VITC, NTSC 6 */
+	{0x170, /* VITC, NTSC */
 		{ 0x0, 0x0, 0x0, 0x0 , 0x0, 0x8f, 0x6d, 0x49, 0x69, 0x94, 0x08, 0x0, 0x0, 0x0, 0x4c, 0x0 }
 	},
-	{ (u16)-1 }
+	{0x190, /* VPS, PAL */
+		{ 0xaa, 0xaa, 0xff, 0xff, 0xba, 0xce, 0x2b, 0x0d, 0xa6, 0xda, 0x0b, 0x0, 0x0, 0x0, 0x60, 0x0 }
+	},
+	{0x1b0, /* Gemstar Custom 1 */
+		{ 0xcc, 0xcc, 0xff, 0xff, 0x05, 0x51, 0x6e, 0x05, 0x69, 0x19, 0x13, 0x0, 0x0, 0x0, 0x60, 0x0 }
+	},
 };
 
 static int tvp5150_write_inittab(struct i2c_client *c,
@@ -691,10 +567,10 @@ static int tvp5150_vdp_init(struct i2c_c
 	unsigned int i;
 
 	/* Disable Full Field */
-	tvp5150_write(c, TVP5150_FULL_FIELD_ENA_1, 0);
+	tvp5150_write(c, TVP5150_FULL_FIELD_ENA, 0);
 
 	/* Before programming, Line mode should be at 0xff */
-	for (i=TVP5150_FULL_FIELD_ENA_2; i<=TVP5150_LINE_MODE_REG_44; i++)
+	for (i=TVP5150_LINE_MODE_INI; i<=TVP5150_LINE_MODE_END; i++)
 		tvp5150_write(c, i, 0xff);
 
 	/* Load Ram Table */
@@ -710,6 +586,51 @@ static int tvp5150_vdp_init(struct i2c_c
 	return 0;
 }
 
+/* Set vbi processing
+ * type - one of tvp5150_vbi_types
+ * line - line to gather data
+ * fields: bit 0 field1, bit 1, field2
+ * flags (default=0xf0) is a bitmask, were set means:
+ *	bit 7: enable filtering null bytes on CC
+ *	bit 6: send data also to FIFO
+ *	bit 5: don't allow data with errors on FIFO
+ *	bit 4: enable ECC when possible
+ * pix_align = pix alignment:
+ *	LSB = field1
+ *	MSB = field2
+ */
+static int tvp5150_set_vbi(struct i2c_client *c, enum tvp5150_vbi_types type,
+					u8 flags, int line, const int fields)
+{
+	struct tvp5150 *decoder = i2c_get_clientdata(c);
+	v4l2_std_id std=decoder->norm;
+	u8 reg;
+
+	if (std == V4L2_STD_ALL) {
+		tvp5150_err("VBI can't be configured without knowing number of lines\n");
+		return -EINVAL;
+	} else if (std && V4L2_STD_625_50) {
+		/* Don't follow NTSC Line number convension */
+		line += 3;
+	}
+
+	if (line<6||line>27)
+		return -EINVAL;
+
+	type=type | (flags & 0xf0);
+	reg=((line-6)<<1)+TVP5150_LINE_MODE_INI;
+
+	if (fields&1) {
+		tvp5150_write(c, reg, type);
+	}
+
+	if (fields&2) {
+		tvp5150_write(c, reg+1, type);
+	}
+
+	return 0;
+}
+
 static int tvp5150_set_std(struct i2c_client *c, v4l2_std_id std)
 {
 	struct tvp5150 *decoder = i2c_get_clientdata(c);
@@ -1086,7 +1007,7 @@ static int tvp5150_detect_client(struct 
 
 	rv = i2c_attach_client(c);
 
-	core->norm = V4L2_STD_ALL;
+	core->norm = V4L2_STD_ALL;	/* Default is autodetect */
 	core->input = 2;
 	core->enable = 1;
 	core->bright = 32768;
diff --git a/drivers/media/video/tvp5150_reg.h b/drivers/media/video/tvp5150_reg.h
diff --git a/drivers/media/video/tvp5150_reg.h b/drivers/media/video/tvp5150_reg.h
index cd45c1d..c81587e 100644
--- a/drivers/media/video/tvp5150_reg.h
+++ b/drivers/media/video/tvp5150_reg.h
@@ -64,49 +64,32 @@
 #define TVP5150_STATUS_REG_4        0x8b /* Status register #4 */
 #define TVP5150_STATUS_REG_5        0x8c /* Status register #5 */
 /* Reserved	8Dh-8Fh */
-#define TVP5150_CC_DATA_REG1        0x90 /* Closed caption data registers */
-#define TVP5150_CC_DATA_REG2        0x91 /* Closed caption data registers */
-#define TVP5150_CC_DATA_REG3        0x92 /* Closed caption data registers */
-#define TVP5150_CC_DATA_REG4        0x93 /* Closed caption data registers */
-#define TVP5150_WSS_DATA_REG1       0X94 /* WSS data registers */
-#define TVP5150_WSS_DATA_REG2       0X95 /* WSS data registers */
-#define TVP5150_WSS_DATA_REG3       0X96 /* WSS data registers */
-#define TVP5150_WSS_DATA_REG4       0X97 /* WSS data registers */
-#define TVP5150_WSS_DATA_REG5       0X98 /* WSS data registers */
-#define TVP5150_WSS_DATA_REG6       0X99 /* WSS data registers */
-#define TVP5150_VPS_DATA_REG1       0x9a /* VPS data registers */
-#define TVP5150_VPS_DATA_REG2       0x9b /* VPS data registers */
-#define TVP5150_VPS_DATA_REG3       0x9c /* VPS data registers */
-#define TVP5150_VPS_DATA_REG4       0x9d /* VPS data registers */
-#define TVP5150_VPS_DATA_REG5       0x9e /* VPS data registers */
-#define TVP5150_VPS_DATA_REG6       0x9f /* VPS data registers */
-#define TVP5150_VPS_DATA_REG7       0xa0 /* VPS data registers */
-#define TVP5150_VPS_DATA_REG8       0xa1 /* VPS data registers */
-#define TVP5150_VPS_DATA_REG9       0xa2 /* VPS data registers */
-#define TVP5150_VPS_DATA_REG10      0xa3 /* VPS data registers */
-#define TVP5150_VPS_DATA_REG11      0xa4 /* VPS data registers */
-#define TVP5150_VPS_DATA_REG12      0xa5 /* VPS data registers */
-#define TVP5150_VPS_DATA_REG13      0xa6 /* VPS data registers */
-#define TVP5150_VITC_DATA_REG1      0xa7 /* VITC data registers */
-#define TVP5150_VITC_DATA_REG2      0xa8 /* VITC data registers */
-#define TVP5150_VITC_DATA_REG3      0xa9 /* VITC data registers */
-#define TVP5150_VITC_DATA_REG4      0xaa /* VITC data registers */
-#define TVP5150_VITC_DATA_REG5      0xab /* VITC data registers */
-#define TVP5150_VITC_DATA_REG6      0xac /* VITC data registers */
-#define TVP5150_VITC_DATA_REG7      0xad /* VITC data registers */
-#define TVP5150_VITC_DATA_REG8      0xae /* VITC data registers */
-#define TVP5150_VITC_DATA_REG9      0xaf /* VITC data registers */
+ /* Closed caption data registers */
+#define TVP5150_CC_DATA_INI         0x90
+#define TVP5150_CC_DATA_END         0x93
+
+ /* WSS data registers */
+#define TVP5150_WSS_DATA_INI        0x94
+#define TVP5150_WSS_DATA_END        0x99
+
+/* VPS data registers */
+#define TVP5150_VPS_DATA_INI        0x9a
+#define TVP5150_VPS_DATA_END        0xa6
+
+/* VITC data registers */
+#define TVP5150_VITC_DATA_INI       0xa7
+#define TVP5150_VITC_DATA_END       0xaf
+
 #define TVP5150_VBI_FIFO_READ_DATA  0xb0 /* VBI FIFO read data */
-#define TVP5150_TELETEXT_FIL_1_1    0xb1 /* Teletext filter 1 */
-#define TVP5150_TELETEXT_FIL_1_2    0xb2 /* Teletext filter 1 */
-#define TVP5150_TELETEXT_FIL_1_3    0xb3 /* Teletext filter 1 */
-#define TVP5150_TELETEXT_FIL_1_4    0xb4 /* Teletext filter 1 */
-#define TVP5150_TELETEXT_FIL_1_5    0xb5 /* Teletext filter 1 */
-#define TVP5150_TELETEXT_FIL_2_1    0xb6 /* Teletext filter 2 */
-#define TVP5150_TELETEXT_FIL_2_2    0xb7 /* Teletext filter 2 */
-#define TVP5150_TELETEXT_FIL_2_3    0xb8 /* Teletext filter 2 */
-#define TVP5150_TELETEXT_FIL_2_4    0xb9 /* Teletext filter 2 */
-#define TVP5150_TELETEXT_FIL_2_5    0xba /* Teletext filter 2 */
+
+/* Teletext filter 1 */
+#define TVP5150_TELETEXT_FIL1_INI  0xb1
+#define TVP5150_TELETEXT_FIL1_END  0xb5
+
+/* Teletext filter 2 */
+#define TVP5150_TELETEXT_FIL2_INI  0xb6
+#define TVP5150_TELETEXT_FIL2_END  0xba
+
 #define TVP5150_TELETEXT_FIL_ENA    0xbb /* Teletext filter enable */
 /* Reserved	BCh-BFh */
 #define TVP5150_INT_STATUS_REG_A    0xc0 /* Interrupt status register A */
@@ -124,50 +107,11 @@
 #define TVP5150_PIX_ALIGN_REG_HIGH  0xcc /* Pixel alignment register high byte */
 #define TVP5150_FIFO_OUT_CTRL       0xcd /* FIFO output control */
 /* Reserved	CEh */
-#define TVP5150_FULL_FIELD_ENA_1    0xcf /* Full field enable 1 */
-#define TVP5150_FULL_FIELD_ENA_2    0xd0 /* Full field enable 2 */
-#define TVP5150_LINE_MODE_REG_1     0xd1 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_2     0xd2 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_3     0xd3 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_4     0xd4 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_5     0xd5 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_6     0xd6 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_7     0xd7 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_8     0xd8 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_9     0xd9 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_10    0xda /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_11    0xdb /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_12    0xdc /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_13    0xdd /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_14    0xde /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_15    0xdf /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_16    0xe0 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_17    0xe1 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_18    0xe2 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_19    0xe3 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_20    0xe4 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_21    0xe5 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_22    0xe6 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_23    0xe7 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_24    0xe8 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_25    0xe9 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_27    0xea /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_28    0xeb /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_29    0xec /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_30    0xed /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_31    0xee /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_32    0xef /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_33    0xf0 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_34    0xf1 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_35    0xf2 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_36    0xf3 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_37    0xf4 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_38    0xf5 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_39    0xf6 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_40    0xf7 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_41    0xf8 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_42    0xf9 /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_43    0xfa /* Line mode registers */
-#define TVP5150_LINE_MODE_REG_44    0xfb /* Line mode registers */
+#define TVP5150_FULL_FIELD_ENA      0xcf /* Full field enable 1 */
+
+/* Line mode registers */
+#define TVP5150_LINE_MODE_INI       0xd0
+#define TVP5150_LINE_MODE_END       0xfb
+
 #define TVP5150_FULL_FIELD_MODE_REG 0xfc /* Full field mode register */
 /* Reserved	FDh-FFh */

