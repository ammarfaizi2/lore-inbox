Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161379AbWJKVEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161379AbWJKVEf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161384AbWJKVEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:04:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:9886 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161379AbWJKVEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:04:33 -0400
Date: Wed, 11 Oct 2006 14:04:08 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Mike Isely <isely@pobox.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 10/67] Video: pvrusb2: Limit hor res for 24xxx devices
Message-ID: <20061011210408.GK16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="video-pvrusb2-limit-hor-res-for-24xxx-devices.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Mike Isely <isely@pobox.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/media/video/pvrusb2/pvrusb2-ctrl.c         |   21 +++++++++---
 drivers/media/video/pvrusb2/pvrusb2-hdw-internal.h |    2 +
 drivers/media/video/pvrusb2/pvrusb2-hdw.c          |   30 ++++++++++++++++++
 drivers/media/video/pvrusb2/pvrusb2-v4l2.c         |   34 +++++++++++----------
 4 files changed, 65 insertions(+), 22 deletions(-)

--- linux-2.6.18.orig/drivers/media/video/pvrusb2/pvrusb2-ctrl.c
+++ linux-2.6.18/drivers/media/video/pvrusb2/pvrusb2-ctrl.c
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
--- linux-2.6.18.orig/drivers/media/video/pvrusb2/pvrusb2-hdw-internal.h
+++ linux-2.6.18/drivers/media/video/pvrusb2/pvrusb2-hdw-internal.h
@@ -107,6 +107,8 @@ struct pvr2_ctl_info {
 
 	/* Control's implementation */
 	pvr2_ctlf_get_value get_value;      /* Get its value */
+	pvr2_ctlf_get_value get_min_value;  /* Get minimum allowed value */
+	pvr2_ctlf_get_value get_max_value;  /* Get maximum allowed value */
 	pvr2_ctlf_set_value set_value;      /* Set its value */
 	pvr2_ctlf_val_to_sym val_to_sym;    /* Custom convert value->symbol */
 	pvr2_ctlf_sym_to_val sym_to_val;    /* Custom convert symbol->value */
--- linux-2.6.18.orig/drivers/media/video/pvrusb2/pvrusb2-hdw.c
+++ linux-2.6.18/drivers/media/video/pvrusb2/pvrusb2-hdw.c
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
--- linux-2.6.18.orig/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
+++ linux-2.6.18/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
@@ -456,18 +456,26 @@ static int pvr2_v4l2_do_ioctl(struct ino
 		ret = 0;
 		switch(vf->type) {
 		case V4L2_BUF_TYPE_VIDEO_CAPTURE: {
+			int lmin,lmax;
+			struct pvr2_ctrl *hcp,*vcp;
 			int h = vf->fmt.pix.height;
 			int w = vf->fmt.pix.width;
+			hcp = pvr2_hdw_get_ctrl_by_id(hdw,PVR2_CID_HRES);
+			vcp = pvr2_hdw_get_ctrl_by_id(hdw,PVR2_CID_VRES);
 
-			if (h < 200) {
-				h = 200;
-			} else if (h > 625) {
-				h = 625;
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

--
