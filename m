Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966783AbWCTPU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966783AbWCTPU6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWCTPUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:20:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39906 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966758AbWCTPUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:20:46 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 021/141] V4L/DVB (3420): Added iocls to configure VBI on
	tvp5150
Date: Mon, 20 Mar 2006 12:08:40 -0300
Message-id: <20060320150840.PS533114000021@infradead.org>
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
Date: 1138043468 -0200

- Added iocls to configure VBI on tvp5150

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tvp5150.c b/drivers/media/video/tvp5150.c
diff --git a/drivers/media/video/tvp5150.c b/drivers/media/video/tvp5150.c
index df7f304..20e6359 100644
--- a/drivers/media/video/tvp5150.c
+++ b/drivers/media/video/tvp5150.c
@@ -541,7 +541,7 @@ static struct i2c_vbi_ram_value vbi_ram_
 		  0x69, 0x8c, 0x09, 0x00, 0x00, 0x00, 0x27, 0x00 }
 	},
 	{0x110, /* Wide Screen Signal, PAL/SECAM */
-		{V4L2_SLICED_WSS_625,20,21,1},
+		{V4L2_SLICED_WSS_625,23,23,1},
 		{ 0x5b, 0x55, 0xc5, 0xff, 0x00, 0x71, 0x6e, 0x42,
 		  0xa6, 0xcd, 0x0f, 0x00, 0x00, 0x00, 0x3a, 0x00 }
 	},
@@ -649,7 +649,7 @@ static int tvp5150_set_vbi(struct i2c_cl
 
 	if (std == V4L2_STD_ALL) {
 		tvp5150_err("VBI can't be configured without knowing number of lines\n");
-		return -EINVAL;
+		return 0;
 	} else if (std && V4L2_STD_625_50) {
 		/* Don't follow NTSC Line number convension */
 		line += 3;
@@ -686,6 +686,37 @@ static int tvp5150_set_vbi(struct i2c_cl
 	return type;
 }
 
+static int tvp5150_get_vbi(struct i2c_client *c,
+			const struct i2c_vbi_ram_value *regs, int line)
+{
+	struct tvp5150 *decoder = i2c_get_clientdata(c);
+	v4l2_std_id std=decoder->norm;
+	u8 reg;
+	int pos, type=0;
+
+	if (std == V4L2_STD_ALL) {
+		tvp5150_err("VBI can't be configured without knowing number of lines\n");
+		return 0;
+	} else if (std && V4L2_STD_625_50) {
+		/* Don't follow NTSC Line number convension */
+		line += 3;
+	}
+
+	if (line<6||line>27)
+		return 0;
+
+	reg=((line-6)<<1)+TVP5150_LINE_MODE_INI;
+
+	pos=tvp5150_read(c, reg)&0x0f;
+	if (pos<0x0f)
+		type=regs[pos].type.vbi_type;
+
+	pos=tvp5150_read(c, reg+1)&0x0f;
+	if (pos<0x0f)
+		type|=regs[pos].type.vbi_type;
+
+	return type;
+}
 static int tvp5150_set_std(struct i2c_client *c, v4l2_std_id std)
 {
 	struct tvp5150 *decoder = i2c_get_clientdata(c);
@@ -856,9 +887,43 @@ static int tvp5150_command(struct i2c_cl
 					 vbi_ram_default,
 					 svbi->service_lines[0][i],0xf0,i,3);
 			}
+			/* Enables FIFO */
+			tvp5150_write(c, TVP5150_FIFO_OUT_CTRL,1);
+		} else {
+			/* Disables FIFO*/
+			tvp5150_write(c, TVP5150_FIFO_OUT_CTRL,0);
+
+			/* Disable Full Field */
+			tvp5150_write(c, TVP5150_FULL_FIELD_ENA, 0);
+
+			/* Disable Line modes */
+			for (i=TVP5150_LINE_MODE_INI; i<=TVP5150_LINE_MODE_END; i++)
+				tvp5150_write(c, i, 0xff);
+		}
+		break;
+	}
+	case VIDIOC_G_FMT:
+	{
+		struct v4l2_format *fmt;
+		struct v4l2_sliced_vbi_format *svbi;
+
+		int i, mask=0;
+
+		fmt = arg;
+		if (fmt->type != V4L2_BUF_TYPE_SLICED_VBI_CAPTURE)
+			return -EINVAL;
+		svbi = &fmt->fmt.sliced;
+		memset(svbi, 0, sizeof(*svbi));
+
+		for (i = 0; i <= 23; i++) {
+			svbi->service_lines[0][i]=tvp5150_get_vbi(c,
+				vbi_ram_default,i);
+			mask|=svbi->service_lines[0][i];
 		}
+		svbi->service_set=mask;
 		break;
 	}
+
 #ifdef CONFIG_VIDEO_ADV_DEBUG
 	case VIDIOC_INT_G_REGISTER:
 	{
@@ -883,6 +948,7 @@ static int tvp5150_command(struct i2c_cl
 	}
 #endif
 
+	case VIDIOC_LOG_STATUS:
 	case DECODER_DUMP:
 		dump_reg(c);
 		break;
diff --git a/include/media/v4l2-common.h b/include/media/v4l2-common.h
diff --git a/include/media/v4l2-common.h b/include/media/v4l2-common.h
index d4030a7..11728da 100644
--- a/include/media/v4l2-common.h
+++ b/include/media/v4l2-common.h
@@ -160,7 +160,8 @@ struct msp_matrix {
 
 /* Used to generate VBI signals on a video signal. v4l2_sliced_vbi_data is
    filled with the data packets that should be output. Note that if you set
-   the line field to 0, then that VBI signal is disabled. */
+   the line field to 0, then that VBI signal is disabled. If no
+   valid VBI data was found, then the type field is set to 0 on return. */
 #define VIDIOC_INT_S_VBI_DATA 		_IOW ('d', 105, struct v4l2_sliced_vbi_data)
 
 /* Used to obtain the sliced VBI packet from a readback register. Not all

