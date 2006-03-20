Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966757AbWCTPUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966757AbWCTPUz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966777AbWCTPUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:20:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40930 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966761AbWCTPUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:20:51 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 105/141] V4L/DVB (3373): Debug messages for ioctl improved
Date: Mon, 20 Mar 2006 12:08:54 -0300
Message-id: <20060320150854.PS487301000105@infradead.org>
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
Date: 1141009735 -0300

Adds field and type name to debug message.
Also prints now format for type=capture.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/v4l2-common.c b/drivers/media/video/v4l2-common.c
diff --git a/drivers/media/video/v4l2-common.c b/drivers/media/video/v4l2-common.c
index 4908dab..9e41ab7 100644
--- a/drivers/media/video/v4l2-common.c
+++ b/drivers/media/video/v4l2-common.c
@@ -323,6 +323,16 @@ static const char *v4l2_int_ioctls[] = {
 };
 #define V4L2_INT_IOCTLS ARRAY_SIZE(v4l2_int_ioctls)
 
+static void v4l_print_pix_fmt (char *s, struct v4l2_pix_format *fmt)
+{
+	printk ("%s: width=%d, height=%d, format=%d, field=%s, "
+		"bytesperline=%d sizeimage=%d, colorspace=%d\n", s,
+		fmt->width,fmt->height,fmt->pixelformat,
+		((fmt->field>=0)&&(fmt->field<ARRAY_SIZE(v4l2_field_names)))?
+		v4l2_field_names[fmt->field]:"unknown",
+		fmt->bytesperline,fmt->sizeimage,fmt->colorspace);
+};
+
 /* Common ioctl debug function. This function can be used by
    external ioctl messages as well as internal V4L ioctl */
 void v4l_printk_ioctl(unsigned int cmd)
@@ -449,15 +459,18 @@ void v4l_printk_ioctl_arg(char *s,unsign
 	{
 		struct v4l2_buffer *p=arg;
 		struct v4l2_timecode *tc=&p->timecode;
-		printk ("%s: %02ld:%02d:%02d.%08ld index=%d, type=%d, "
+		printk ("%s: %02ld:%02d:%02d.%08ld index=%d, type=%s, "
 			"bytesused=%d, flags=0x%08d, "
-			"field=%0d, sequence=%d, memory=%d, offset/userptr=0x%08lx,",
+			"field=%0d, sequence=%d, memory=%d, offset/userptr=0x%08lx\n",
 				s,
 				(p->timestamp.tv_sec/3600),
 				(int)(p->timestamp.tv_sec/60)%60,
 				(int)(p->timestamp.tv_sec%60),
 				p->timestamp.tv_usec,
-				p->index,p->type,p->bytesused,p->flags,
+				p->index,
+				((p->type>=0)&&(p->type<ARRAY_SIZE(v4l2_type_names)))?
+				v4l2_type_names[p->type]:"unknown",
+				p->bytesused,p->flags,
 				p->field,p->sequence,p->memory,p->m.userptr);
 		printk ("%s: timecode= %02d:%02d:%02d type=%d, "
 			"flags=0x%08d, frames=%d, userbits=0x%08x",
@@ -522,17 +535,24 @@ void v4l_printk_ioctl_arg(char *s,unsign
 	case VIDIOC_TRY_FMT:
 	{
 		struct v4l2_format *p=arg;
-		/* FIXME: Should be one dump per type*/
-		printk ("%s: type=%d\n", s,p->type);
-		break;
+		printk ("%s: type=%s\n", s,
+				((p->type>=0)&&(p->type<ARRAY_SIZE(v4l2_type_names)))?
+				v4l2_type_names[p->type]:"unknown");
+		switch (p->type) {
+		case V4L2_BUF_TYPE_VIDEO_CAPTURE:
+			v4l_print_pix_fmt (s, &p->fmt.pix);
+			break;
+		default:
+			break;
+		}
 	}
 	case VIDIOC_G_FBUF:
 	case VIDIOC_S_FBUF:
 	{
 		struct v4l2_framebuffer *p=arg;
-		/*FIXME: should show also struct v4l2_pix_format p->fmt field */
 		printk ("%s: capability=%d, flags=%d, base=0x%08lx\n", s,
 				p->capability,p->flags, (unsigned long)p->base);
+		v4l_print_pix_fmt (s, &p->fmt);
 		break;
 	}
 	case VIDIOC_G_FREQUENCY:

