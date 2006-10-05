Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWJEDCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWJEDCX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 23:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWJEDCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 23:02:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:30618 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751426AbWJEDCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 23:02:12 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Trent Piepho <xyzzy@speakeasy.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 2/2] V4L/DVB (4722): Cx88: Add support for
	VIDIOC_INT_[SR]_REGISTER ioctls
Date: Wed, 04 Oct 2006 23:59:55 -0300
Message-id: <20061005025955.PS1161090002@infradead.org>
In-Reply-To: <20061005025847.PS6380080000@infradead.org>
References: <20061005025847.PS6380080000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Trent Piepho <xyzzy@speakeasy.org>

Add support for the advanced debugging ioctls, to allow access to the
cx88 registers from userspace.  Only i2c_id == 0 is supported, for access
to the cx88 adapter itself.  There isn't any support for access to I2C
clients of the adapter.  Most of them don't have R/W registers anyway,
and its necessary to use i2c-dev to talk to them from userspace.

Signed-off-by: Trent Piepho <xyzzy@speakeasy.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/cx88-video.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/cx88/cx88-video.c b/drivers/media/video/cx88/cx88-video.c
index cb0c0ee..264cd29 100644
--- a/drivers/media/video/cx88/cx88-video.c
+++ b/drivers/media/video/cx88/cx88-video.c
@@ -1490,6 +1490,30 @@ int cx88_do_ioctl(struct inode *inode, s
 		mutex_unlock(&core->lock);
 		return 0;
 	}
+#ifdef CONFIG_VIDEO_ADV_DEBUG
+	/* ioctls to allow direct acces to the cx2388x registers */
+	case VIDIOC_INT_G_REGISTER:
+	{
+		struct v4l2_register *reg = arg;
+
+		if (reg->i2c_id != 0)
+			return -EINVAL;
+		/* cx2388x has a 24-bit register space */
+		reg->val = cx_read(reg->reg&0xffffff);
+		return 0;
+	}
+	case VIDIOC_INT_S_REGISTER:
+	{
+		struct v4l2_register *reg = arg;
+
+		if (reg->i2c_id != 0)
+			return -EINVAL;
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		cx_write(reg->reg&0xffffff, reg->val);
+		return 0;
+	}
+#endif
 
 	default:
 		return v4l_compat_translate_ioctl(inode,file,cmd,arg,

