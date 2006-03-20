Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965438AbWCTPqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965438AbWCTPqz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965435AbWCTPqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:46:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43490 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966819AbWCTPVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:21:12 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 013/141] V4L/DVB (3410): Implemented sliced VBI set on
	VIDIOC_S_FMT
Date: Mon, 20 Mar 2006 12:08:39 -0300
Message-id: <20060320150839.PS224965000013@infradead.org>
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
Date: 1138043466 -0200

- Implemented sliced VBI set on VIDIOC_S_FMT

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tvp5150.c b/drivers/media/video/tvp5150.c
diff --git a/drivers/media/video/tvp5150.c b/drivers/media/video/tvp5150.c
index 17a8dd7..df7f304 100644
--- a/drivers/media/video/tvp5150.c
+++ b/drivers/media/video/tvp5150.c
@@ -637,12 +637,15 @@ static void tvp5150_vbi_get_cap(const st
  *	LSB = field1
  *	MSB = field2
  */
-static int tvp5150_set_vbi(struct i2c_client *c, unsigned int type,
-					u8 flags, int line, const int fields)
+static int tvp5150_set_vbi(struct i2c_client *c,
+			const struct i2c_vbi_ram_value *regs,
+			unsigned int type,u8 flags, int line,
+			const int fields)
 {
 	struct tvp5150 *decoder = i2c_get_clientdata(c);
 	v4l2_std_id std=decoder->norm;
 	u8 reg;
+	int pos=0;
 
 	if (std == V4L2_STD_ALL) {
 		tvp5150_err("VBI can't be configured without knowing number of lines\n");
@@ -653,9 +656,23 @@ static int tvp5150_set_vbi(struct i2c_cl
 	}
 
 	if (line<6||line>27)
-		return -EINVAL;
+		return 0;
+
+	while (regs->reg != (u16)-1 ) {
+		if ((type & regs->type.vbi_type) &&
+		    (line>=regs->type.ini_line) &&
+		    (line<=regs->type.end_line)) {
+			type=regs->type.vbi_type;
+			break;
+		}
+
+		regs++;
+		pos++;
+	}
+	if (regs->reg == (u16)-1)
+		return 0;
 
-	type=type | (flags & 0xf0);
+	type=pos | (flags & 0xf0);
 	reg=((line-6)<<1)+TVP5150_LINE_MODE_INI;
 
 	if (fields&1) {
@@ -666,7 +683,7 @@ static int tvp5150_set_vbi(struct i2c_cl
 		tvp5150_write(c, reg+1, type);
 	}
 
-	return 0;
+	return type;
 }
 
 static int tvp5150_set_std(struct i2c_client *c, v4l2_std_id std)
@@ -821,7 +838,27 @@ static int tvp5150_command(struct i2c_cl
 		tvp5150_vbi_get_cap(vbi_ram_default, cap);
 		break;
 	}
+	case VIDIOC_S_FMT:
+	{
+		struct v4l2_format *fmt;
+		struct v4l2_sliced_vbi_format *svbi;
+		int i;
 
+		fmt = arg;
+		if (fmt->type != V4L2_BUF_TYPE_SLICED_VBI_CAPTURE)
+			return -EINVAL;
+		svbi = &fmt->fmt.sliced;
+		if (svbi->service_set != 0) {
+			for (i = 0; i <= 23; i++) {
+				svbi->service_lines[1][i] = 0;
+
+				svbi->service_lines[0][i]=tvp5150_set_vbi(c,
+					 vbi_ram_default,
+					 svbi->service_lines[0][i],0xf0,i,3);
+			}
+		}
+		break;
+	}
 #ifdef CONFIG_VIDEO_ADV_DEBUG
 	case VIDIOC_INT_G_REGISTER:
 	{

