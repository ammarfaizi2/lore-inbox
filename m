Return-Path: <linux-kernel-owner+w=401wt.eu-S933005AbWL0RRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933005AbWL0RRd (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933003AbWL0RL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:11:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41471 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932997AbWL0RLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:11:49 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 15/28] V4L/DVB (4983): Force temporal filter to 0 when
	scaling to prevent ghosting.
Date: Wed, 27 Dec 2006 14:57:30 -0200
Message-id: <20061227165730.PS10005700015@infradead.org>
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


From: Hans Verkuil <hverkuil@xs4all.nl>

Change the code to unconditionally turn off the temporal filter when scaling.
If the window is not full screen the filter will introduce a nasty ghosting
effect.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx2341x.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/media/video/cx2341x.c b/drivers/media/video/cx2341x.c
index 657e0b9..e796afd 100644
--- a/drivers/media/video/cx2341x.c
+++ b/drivers/media/video/cx2341x.c
@@ -742,7 +742,6 @@ int cx2341x_update(void *priv, cx2341x_m
 
 	if (old == NULL || old->width != new->width || old->height != new->height ||
 			old->video_encoding != new->video_encoding) {
-		int is_scaling;
 		u16 w = new->width;
 		u16 h = new->height;
 
@@ -752,20 +751,18 @@ int cx2341x_update(void *priv, cx2341x_m
 		}
 		err = cx2341x_api(priv, func, CX2341X_ENC_SET_FRAME_SIZE, 2, h, w);
 		if (err) return err;
+	}
 
+	if (new->width != 720 || new->height != (new->is_50hz ? 576 : 480)) {
 		/* Adjust temporal filter if necessary. The problem with the temporal
 		   filter is that it works well with full resolution capturing, but
 		   not when the capture window is scaled (the filter introduces
-		   a ghosting effect). So if the capture window changed, and there is
-		   no updated filter value, then the filter is set depending on whether
-		   the new window is full resolution or not.
+		   a ghosting effect). So if the capture window is scaled, then
+		   force the filter to 0.
 
-		   For full resolution a setting of 8 really improves the video
+		   For full resolution the filter really improves the video
 		   quality, especially if the original video quality is suboptimal. */
-		is_scaling = new->width != 720 || new->height != (new->is_50hz ? 576 : 480);
-		if (old && old->video_temporal_filter == temporal) {
-			temporal = is_scaling ? 0 : 8;
-		}
+		temporal = 0;
 	}
 
 	if (old == NULL || old->stream_type != new->stream_type) {

