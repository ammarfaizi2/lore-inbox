Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWJHSmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWJHSmt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 14:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWJHSmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 14:42:24 -0400
Received: from thing.hostingexpert.com ([67.15.235.34]:63405 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751325AbWJHSmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 14:42:21 -0400
Message-ID: <45294689.80706@linuxtv.org>
Date: Sun, 08 Oct 2006 14:42:17 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: stable@kernel.org
CC: linux-kernel@vger.kernel.org,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Mike Isely <isely@pobox.com>
Subject: [2.6.18.y PATCH 6/6] pvrusb2: Limit hor res for 24xxx devices
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 170020921b8170c08da7460995ee8f3070fc2462 Mon Sep 17 00:00:00 2001
From: Mike Isely <isely@pobox.com>
Date: Thu, 5 Oct 2006 13:38:09 -0400
Subject: [PATCH] pvrusb2: Limit hor res for 24xxx devices

Currently it is not understood how to properly control the horizontal
capture resolution on 24xxx devices.  The pvrusb2 driver is doing
everything it should (pass resolution paramter(s) to cx2341x and
cx25840 modules) but for some reason the result is corrupted video if
any resolution other than 720 is used.  This patch causes the driver
to only permit a horizontal resolution of 720 to be used on 24xxx
devices.  Even if the app requests something else, the driver will
force the resolution back to 720.  This patch still allows full
control of the resolution for 29xxx devices.

Signed-off-by: Mike Isely <isely@pobox.com>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
---
 drivers/media/video/pvrusb2/pvrusb2-ctrl.c         |   21 ++++++++----
 drivers/media/video/pvrusb2/pvrusb2-hdw-internal.h |    2 +
 drivers/media/video/pvrusb2/pvrusb2-hdw.c          |   30 +++++++++++++++++
 drivers/media/video/pvrusb2/pvrusb2-v4l2.c         |   36 +++++++++++---------
 4 files changed, 66 insertions(+), 23 deletions(-)

diff --git a/drivers/media/video/pvrusb2/pvrusb2-ctrl.c b/drivers/media/video/pvrusb2/pvrusb2-ctrl.c
index fb6198f..c77de85 100644
--- a/drivers/media/video/pvrusb2/pvrusb2-ctrl.c
+++ b/drivers/media/video/pvrusb2/pvrusb2-ctrl.c
@@ -43,12 +43,17 @@ int pvr2_ctrl_set_mask_value(struct pvr2
 			if (cptr->info->type == pvr2_ctl_bitmask) {
 				mask &= cptr->info->def.type_bitmask.valid_bits;
 			} else if (cptr->info->type == pvr2_ctl_int) {
-				if (val < cptr->info->def.type_int.min_value) {
-					break;
+				int lim;
+				lim = cptr->info->def.type_int.min_value;
+				if (cptr->info->get_min_value) {
+					cptr->info->get_min_value(cptr,&lim);
 				}
-				if (val > cptr->info->def.type_int.max_value) {
-					break;
+				if (val < lim) break;
+				lim = cptr->info->def.type_int.max_value;
+				if (cptr->info->get_max_value) {
+					cptr->info->get_max_value(cptr,&lim);
 				}
+				if (val > lim) break;
 			} else if (cptr->info->type == pvr2_ctl_enum) {
 				if (val >= cptr->info->def.type_enum.count) {
 					break;
@@ -91,7 +96,9 @@ int pvr2_ctrl_get_max(struct pvr2_ctrl *
 	int ret = 0;
 	if (!cptr) return 0;
 	LOCK_TAKE(cptr->hdw->big_lock); do {
-		if (cptr->info->type == pvr2_ctl_int) {
+		if (cptr->info->get_max_value) {
+			cptr->info->get_max_value(cptr,&ret);
+		} else if (cptr->info->type == pvr2_ctl_int) {
 			ret = cptr->info->def.type_int.max_value;
 		}
 	} while(0); LOCK_GIVE(cptr->hdw->big_lock);
@@ -105,7 +112,9 @@ int pvr2_ctrl_get_min(struct pvr2_ctrl *
 	int ret = 0;
 	if (!cptr) return 0;
 	LOCK_TAKE(cptr->hdw->big_lock); do {
-		if (cptr->info->type == pvr2_ctl_int) {
+		if (cptr->info->get_min_value) {
+			cptr->info->get_min_value(cptr,&ret);
+		} else if (cptr->info->type == pvr2_ctl_int) {
 			ret = cptr->info->def.type_int.min_value;
 		}
 	} while(0); LOCK_GIVE(cptr->hdw->big_lock);
diff --git a/drivers/media/video/pvrusb2/pvrusb2-hdw-internal.h b/drivers/media/video/pvrusb2/pvrusb2-hdw-internal.h
index 0d6dc33..9a72e6a 100644
--- a/drivers/media/video/pvrusb2/pvrusb2-hdw-internal.h
+++ b/drivers/media/video/pvrusb2/pvrusb2-hdw-internal.h
@@ -107,6 +107,8 @@ struct pvr2_ctl_info {
 
 	/* Control's implementation */
 	pvr2_ctlf_get_value get_value;      /* Get its value */
+	pvr2_ctlf_get_value get_min_value;  /* Get minimum allowed value */
+	pvr2_ctlf_get_value get_max_value;  /* Get maximum allowed value */
 	pvr2_ctlf_set_value set_value;      /* Set its value */
 	pvr2_ctlf_val_to_sym val_to_sym;    /* Custom convert value->symbol */
 	pvr2_ctlf_sym_to_val sym_to_val;    /* Custom convert symbol->value */
diff --git a/drivers/media/video/pvrusb2/pvrusb2-hdw.c b/drivers/media/video/pvrusb2/pvrusb2-hdw.c
index be1e5cc..a36a69d 100644
--- a/drivers/media/video/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/video/pvrusb2/pvrusb2-hdw.c
@@ -362,6 +362,30 @@ static int ctrl_freq_set(struct pvr2_ctr
 	return 0;
 }
 
+#ifdef CONFIG_VIDEO_PVRUSB2_24XXX
+static int ctrl_hres_max_get(struct pvr2_ctrl *cptr,int *vp)
+{
+	/* If we're dealing with a 24xxx device, force the horizontal
+	   maximum to be 720 no matter what, since we can't get the device
+	   to work properly with any other value.  Otherwise just return
+	   the normal value. */
+	*vp = cptr->info->def.type_int.max_value;
+	if (cptr->hdw->hdw_type == PVR2_HDW_TYPE_24XXX) *vp = 720;
+	return 0;
+}
+
+static int ctrl_hres_min_get(struct pvr2_ctrl *cptr,int *vp)
+{
+	/* If we're dealing with a 24xxx device, force the horizontal
+	   minimum to be 720 no matter what, since we can't get the device
+	   to work properly with any other value.  Otherwise just return
+	   the normal value. */
+	*vp = cptr->info->def.type_int.min_value;
+	if (cptr->hdw->hdw_type == PVR2_HDW_TYPE_24XXX) *vp = 720;
+	return 0;
+}
+#endif
+
 static int ctrl_cx2341x_is_dirty(struct pvr2_ctrl *cptr)
 {
 	return cptr->hdw->enc_stale != 0;
@@ -720,6 +744,12 @@ static const struct pvr2_ctl_info contro
 		.default_value = 720,
 		DEFREF(res_hor),
 		DEFINT(320,720),
+#ifdef CONFIG_VIDEO_PVRUSB2_24XXX
+		/* Hook in check for clamp on horizontal resolution in
+		   order to avoid unsolved problem involving cx25840. */
+		.get_max_value = ctrl_hres_max_get,
+		.get_min_value = ctrl_hres_min_get,
+#endif
 	},{
 		.desc = "Vertical capture resolution",
 		.name = "resolution_ver",
diff --git a/drivers/media/video/pvrusb2/pvrusb2-v4l2.c b/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
index 385b715..72f444c 100644
--- a/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
@@ -456,18 +456,26 @@ static int pvr2_v4l2_do_ioctl(struct ino
 		ret = 0;
 		switch(vf->type) {
 		case V4L2_BUF_TYPE_VIDEO_CAPTURE: {
+			int lmin,lmax;
+			struct pvr2_ctrl *hcp,*vcp;
 			int h = vf->fmt.pix.height;
 			int w = vf->fmt.pix.width;
-
-			if (h < 200) {
-				h = 200;
-			} else if (h > 625) {
-				h = 625;
+			hcp = pvr2_hdw_get_ctrl_by_id(hdw,PVR2_CID_HRES);
+			vcp = pvr2_hdw_get_ctrl_by_id(hdw,PVR2_CID_VRES);
+
+			lmin = pvr2_ctrl_get_min(hcp);
+			lmax = pvr2_ctrl_get_max(hcp);
+			if (w < lmin) {
+				w = lmin;
+			} else if (w > lmax) {
+				w = lmax;
 			}
-			if (w < 320) {
-				w = 320;
-			} else if (w > 720) {
-				w = 720;
+			lmin = pvr2_ctrl_get_min(vcp);
+			lmax = pvr2_ctrl_get_max(vcp);
+			if (h < lmin) {
+				h = lmin;
+			} else if (h > lmax) {
+				h = lmax;
 			}
 
 			memcpy(vf, &pvr_format[PVR_FORMAT_PIX],
@@ -476,14 +484,8 @@ static int pvr2_v4l2_do_ioctl(struct ino
 			vf->fmt.pix.height = h;
 
 			if (cmd == VIDIOC_S_FMT) {
-				pvr2_ctrl_set_value(
-					pvr2_hdw_get_ctrl_by_id(hdw,
-								PVR2_CID_HRES),
-					vf->fmt.pix.width);
-				pvr2_ctrl_set_value(
-					pvr2_hdw_get_ctrl_by_id(hdw,
-								PVR2_CID_VRES),
-					vf->fmt.pix.height);
+				pvr2_ctrl_set_value(hcp,vf->fmt.pix.width);
+				pvr2_ctrl_set_value(vcp,vf->fmt.pix.height);
 			}
 		} break;
 		case V4L2_BUF_TYPE_VBI_CAPTURE:
