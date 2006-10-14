Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWJNMKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWJNMKY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWJNMIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:08:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64972 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932182AbWJNMHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:07:17 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Jonathan Corbet <corbet-v4l@lwn.net>,
       Jonathan Corbet <corbet@lwn.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 14/18] V4L/DVB (4743): Fix oops in VIDIOC_G_PARM
Date: Sat, 14 Oct 2006 09:00:51 -0300
Message-id: <20061014120051.PS41391600014@infradead.org>
In-Reply-To: <20061014115356.PS36551000000@infradead.org>
References: <20061014115356.PS36551000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jonathan Corbet <corbet-v4l@lwn.net>

The call to v4l2_std_construct() in the VIDIOC_G_PARM handler treats
vfd->current_norm as if it were an index - but it's not.  The result is
an oops if the driver has no vidioc_g_parm() method defined.  Here's the
fix.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/videodev.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/videodev.c b/drivers/media/video/videodev.c
index 98de872..d424a41 100644
--- a/drivers/media/video/videodev.c
+++ b/drivers/media/video/videodev.c
@@ -1288,6 +1288,7 @@ #endif
 			ret=vfd->vidioc_g_parm(file, fh, p);
 		} else {
 			struct v4l2_standard s;
+			int i;
 
 			if (!vfd->tvnormsize) {
 				printk (KERN_WARNING "%s: no TV norms defined!\n",
@@ -1298,8 +1299,14 @@ #endif
 			if (p->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
 				return -EINVAL;
 
-			v4l2_video_std_construct(&s, vfd->tvnorms[vfd->current_norm].id,
-						 vfd->tvnorms[vfd->current_norm].name);
+			for (i = 0; i < vfd->tvnormsize; i++)
+				if (vfd->tvnorms[i].id == vfd->current_norm)
+					break;
+			if (i >= vfd->tvnormsize)
+				return -EINVAL;
+
+			v4l2_video_std_construct(&s, vfd->current_norm,
+						 vfd->tvnorms[i].name);
 
 			memset(p,0,sizeof(*p));
 

