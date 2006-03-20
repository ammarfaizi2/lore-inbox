Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965311AbWCTP1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965311AbWCTP1P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965310AbWCTP0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:26:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38072 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964875AbWCTP0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:26:30 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 028/141] V4L/DVB (3430): Add new internal VIDIOC_INT
	commands
Date: Mon, 20 Mar 2006 12:08:41 -0300
Message-id: <20060320150841.PS689813000028@infradead.org>
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

From: Hans Verkuil <hverkuil@xs4all.nl>
Date: 1138043470 -0200

- Add new internal VIDIOC_INT commands for setting the tuner mode,
for putting a chip into standby mode and to set/get the routing
of inputs/outputs of audio or video of a chip. These new commands
will replace older commands that are no longer up to the task.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/include/media/v4l2-common.h b/include/media/v4l2-common.h
diff --git a/include/media/v4l2-common.h b/include/media/v4l2-common.h
index 11728da..234e9cf 100644
--- a/include/media/v4l2-common.h
+++ b/include/media/v4l2-common.h
@@ -115,12 +115,15 @@ enum v4l2_chip_ident {
 };
 
 /* audio ioctls */
-/* v4l device was opened in Radio mode */
+
+/* v4l device was opened in Radio mode, to be replaced by VIDIOC_INT_S_TUNER_MODE */
 #define AUDC_SET_RADIO        _IO('d',88)
-/* select from TV,radio,extern,MUTE */
+
+/* select from TV,radio,extern,MUTE, to be replaced with VIDIOC_INT_S_AUDIO_ROUTING */
 #define AUDC_SET_INPUT        _IOW('d',89,int)
 
-/* msp3400 ioctl: will be removed in the near future */
+/* msp3400 ioctl: will be removed in the near future, to be replaced by
+   VIDIOC_INT_S_AUDIO_ROUTING. */
 struct msp_matrix {
   int input;
   int output;
@@ -128,12 +131,25 @@ struct msp_matrix {
 #define MSP_SET_MATRIX     _IOW('m',17,struct msp_matrix)
 
 /* tuner ioctls */
+
 /* Sets tuner type and its I2C addr */
-#define TUNER_SET_TYPE_ADDR          _IOW('d',90,int)
-/* Puts tuner on powersaving state, disabling it, except for i2c */
-#define TUNER_SET_STANDBY            _IOW('d',91,int)
+#define TUNER_SET_TYPE_ADDR          _IOW('d', 90, int)
+
+/* Puts tuner on powersaving state, disabling it, except for i2c. To be replaced
+   by VIDIOC_INT_S_STANDBY. */
+#define TUNER_SET_STANDBY            _IOW('d', 91, int)
+
 /* Sets tda9887 specific stuff, like port1, port2 and qss */
-#define TDA9887_SET_CONFIG           _IOW('d',92,int)
+#define TDA9887_SET_CONFIG           _IOW('d', 92, int)
+
+/* Switch the tuner to a specific tuner mode. Replacement of AUDC_SET_RADIO */
+#define VIDIOC_INT_S_TUNER_MODE	     _IOW('d', 93, enum v4l2_tuner_type)
+
+/* Generic standby command. Passing -1 (all bits set to 1) will put the whole
+   chip into standby mode, value 0 will make the chip fully active. Specific
+   bits can be used by certain chips to enable/disable specific subsystems.
+   Replacement of TUNER_SET_STANDBY. */
+#define VIDIOC_INT_S_STANDBY 	     _IOW('d', 94, u32)
 
 /* only implemented if CONFIG_VIDEO_ADV_DEBUG is defined */
 #define	VIDIOC_INT_S_REGISTER 		_IOR ('d', 100, struct v4l2_register)
@@ -181,4 +197,25 @@ struct msp_matrix {
    If the frequency is not supported, then -EINVAL is returned. */
 #define VIDIOC_INT_I2S_CLOCK_FREQ 	_IOW ('d', 108, u32)
 
+/* Routing definition, device dependent. It specifies which inputs (if any)
+   should be routed to which outputs (if any). */
+struct v4l2_routing {
+	u32 input;
+	u32 output;
+};
+
+/* These internal commands should be used to define the inputs and outputs
+   of an audio/video chip. They will replace AUDC_SET_INPUT.
+   The v4l2 API commands VIDIOC_S/G_INPUT, VIDIOC_S/G_OUTPUT,
+   VIDIOC_S/G_AUDIO and VIDIOC_S/G_AUDOUT are meant to be used by the
+   user. Internally these commands should be used to switch inputs/outputs
+   because only the driver knows how to map a 'Television' input to the precise
+   input/output routing of an A/D converter, or a DSP, or a video digitizer.
+   These four commands should only be sent directly to an i2c device, they
+   should not be broadcast as the routing is very device specific. */
+#define	VIDIOC_INT_S_AUDIO_ROUTING	_IOW ('d', 109, struct v4l2_routing)
+#define	VIDIOC_INT_G_AUDIO_ROUTING	_IOR ('d', 110, struct v4l2_routing *)
+#define	VIDIOC_INT_S_VIDEO_ROUTING	_IOW ('d', 111, struct v4l2_routing)
+#define	VIDIOC_INT_G_VIDEO_ROUTING	_IOR ('d', 112, struct v4l2_routing *)
+
 #endif /* V4L2_COMMON_H_ */

