Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbVIKBOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVIKBOy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 21:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbVIKBOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 21:14:54 -0400
Received: from smtp2.brturbo.com.br ([200.199.201.158]:40357 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S964800AbVIKBOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 21:14:54 -0400
Subject: V4L: Experimental Sliced VBI API support
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-Sfv7Hwk1U/OhfQ5O8363"
Date: Sat, 10 Sep 2005 22:14:53 -0300
Message-Id: <1126401293.6807.33.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-8mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Sfv7Hwk1U/OhfQ5O8363
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-Sfv7Hwk1U/OhfQ5O8363
Content-Disposition: attachment; filename=v4l_sliced_api.diff
Content-Type: text/x-patch; name=v4l_sliced_api.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

- adds all defines, ioctls and structs needed for the sliced VBI API

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/include/linux/videodev2.h |  113 +++++++++++++++++++++++++-------
 1 files changed, 89 insertions(+), 24 deletions(-)

diff -u /tmp/dst.12367 linux/include/linux/videodev2.h
--- /tmp/dst.12367	2005-09-10 22:05:21.000000000 -0300
+++ linux/include/linux/videodev2.h	2005-09-10 22:05:21.000000000 -0300
@@ -60,12 +60,17 @@ enum v4l2_field {
 	 (field) == V4L2_FIELD_SEQ_BT)
 
 enum v4l2_buf_type {
-	V4L2_BUF_TYPE_VIDEO_CAPTURE  = 1,
-	V4L2_BUF_TYPE_VIDEO_OUTPUT   = 2,
-	V4L2_BUF_TYPE_VIDEO_OVERLAY  = 3,
-	V4L2_BUF_TYPE_VBI_CAPTURE    = 4,
-	V4L2_BUF_TYPE_VBI_OUTPUT     = 5,
-	V4L2_BUF_TYPE_PRIVATE        = 0x80,
+	V4L2_BUF_TYPE_VIDEO_CAPTURE      = 1,
+	V4L2_BUF_TYPE_VIDEO_OUTPUT       = 2,
+	V4L2_BUF_TYPE_VIDEO_OVERLAY      = 3,
+	V4L2_BUF_TYPE_VBI_CAPTURE        = 4,
+	V4L2_BUF_TYPE_VBI_OUTPUT         = 5,
+#if 1
+	/* Experimental Sliced VBI */
+	V4L2_BUF_TYPE_SLICED_VBI_CAPTURE = 6,
+	V4L2_BUF_TYPE_SLICED_VBI_OUTPUT  = 7,
+#endif
+	V4L2_BUF_TYPE_PRIVATE            = 0x80,
 };
 
 enum v4l2_ctrl_type {
@@ -149,20 +154,24 @@ struct v4l2_capability
 };
 
 /* Values for 'capabilities' field */
-#define V4L2_CAP_VIDEO_CAPTURE	0x00000001  /* Is a video capture device */
-#define V4L2_CAP_VIDEO_OUTPUT	0x00000002  /* Is a video output device */
-#define V4L2_CAP_VIDEO_OVERLAY	0x00000004  /* Can do video overlay */
-#define V4L2_CAP_VBI_CAPTURE	0x00000010  /* Is a VBI capture device */
-#define V4L2_CAP_VBI_OUTPUT	0x00000020  /* Is a VBI output device */
-#define V4L2_CAP_RDS_CAPTURE	0x00000100  /* RDS data capture */
-
-#define V4L2_CAP_TUNER		0x00010000  /* has a tuner */
-#define V4L2_CAP_AUDIO		0x00020000  /* has audio support */
-#define V4L2_CAP_RADIO		0x00040000  /* is a radio device */
-
-#define V4L2_CAP_READWRITE      0x01000000  /* read/write systemcalls */
-#define V4L2_CAP_ASYNCIO        0x02000000  /* async I/O */
-#define V4L2_CAP_STREAMING      0x04000000  /* streaming I/O ioctls */
+#define V4L2_CAP_VIDEO_CAPTURE	        0x00000001  /* Is a video capture device */
+#define V4L2_CAP_VIDEO_OUTPUT	        0x00000002  /* Is a video output device */
+#define V4L2_CAP_VIDEO_OVERLAY	        0x00000004  /* Can do video overlay */
+#define V4L2_CAP_VBI_CAPTURE	        0x00000010  /* Is a raw VBI capture device */
+#define V4L2_CAP_VBI_OUTPUT	        0x00000020  /* Is a raw VBI output device */
+#if 1
+#define V4L2_CAP_SLICED_VBI_CAPTURE	0x00000040  /* Is a sliced VBI capture device */
+#define V4L2_CAP_SLICED_VBI_OUTPUT	0x00000080  /* Is a sliced VBI output device */
+#endif
+#define V4L2_CAP_RDS_CAPTURE	        0x00000100  /* RDS data capture */
+
+#define V4L2_CAP_TUNER		        0x00010000  /* has a tuner */
+#define V4L2_CAP_AUDIO		        0x00020000  /* has audio support */
+#define V4L2_CAP_RADIO		        0x00040000  /* is a radio device */
+
+#define V4L2_CAP_READWRITE              0x01000000  /* read/write systemcalls */
+#define V4L2_CAP_ASYNCIO                0x02000000  /* async I/O */
+#define V4L2_CAP_STREAMING              0x04000000  /* streaming I/O ioctls */
 
 /*
  *	V I D E O   I M A G E   F O R M A T
@@ -809,6 +818,8 @@ struct v4l2_audioout
  *	Data services API by Michael Schimek
  */
 
+/* Raw VBI */
+
 struct v4l2_vbi_format
 {
 	__u32	sampling_rate;		/* in 1 Hz */
@@ -825,6 +836,54 @@ struct v4l2_vbi_format
 #define V4L2_VBI_UNSYNC		(1<< 0)
 #define V4L2_VBI_INTERLACED	(1<< 1)
 
+#if 1
+/* Sliced VBI 
+ *
+ *    This implements is a proposal V4L2 API to allow SLICED VBI
+ * required for some hardware encoders. It should change without
+ * notice in the definitive implementation.
+ */
+
+struct v4l2_sliced_vbi_format
+{
+        __u16   service_set;
+        /* service_lines[0][...] specifies lines 0-23 (1-23 used) of the first field
+           service_lines[1][...] specifies lines 0-23 (1-23 used) of the second field
+                                 (equals frame lines 313-336 for 625 line video
+                                  standards, 263-286 for 525 line standards) */
+        __u16   service_lines[2][24]; 
+        __u32   io_size;
+        __u32   reserved[2];            /* must be zero */
+};
+
+#define V4L2_SLICED_TELETEXT_B          (0x0001)
+#define V4L2_SLICED_VPS                 (0x0400)
+#define V4L2_SLICED_CAPTION_525         (0x1000)
+#define V4L2_SLICED_WSS_625             (0x4000)
+
+#define V4L2_SLICED_VBI_525             (V4L2_SLICED_CAPTION_525)
+#define V4L2_SLICED_VBI_625             (V4L2_SLICED_TELETEXT_B | V4L2_SLICED_VPS | V4L2_SLICED_WSS_625)
+
+struct v4l2_sliced_vbi_cap
+{
+        __u16   service_set;
+        /* service_lines[0][...] specifies lines 0-23 (1-23 used) of the first field
+           service_lines[1][...] specifies lines 0-23 (1-23 used) of the second field
+                                 (equals frame lines 313-336 for 625 line video
+                                  standards, 263-286 for 525 line standards) */
+        __u16   service_lines[2][24];
+        __u32   reserved[4];    /* must be 0 */
+};
+
+struct v4l2_sliced_vbi_data
+{
+        __u32   id;
+        __u32   field;          /* 0: first field, 1: second field */
+        __u32   line;           /* 1-23 */
+        __u32   reserved;       /* must be 0 */
+        __u8    data[48];
+};
+#endif
 
 /*
  *	A G G R E G A T E   S T R U C T U R E S
@@ -837,10 +896,13 @@ struct v4l2_format
 	enum v4l2_buf_type type;
 	union
 	{
-		struct v4l2_pix_format	pix;  // V4L2_BUF_TYPE_VIDEO_CAPTURE
-		struct v4l2_window	win;  // V4L2_BUF_TYPE_VIDEO_OVERLAY
-		struct v4l2_vbi_format	vbi;  // V4L2_BUF_TYPE_VBI_CAPTURE
-		__u8	raw_data[200];        // user-defined
+		struct v4l2_pix_format	        pix;     // V4L2_BUF_TYPE_VIDEO_CAPTURE
+		struct v4l2_window	        win;     // V4L2_BUF_TYPE_VIDEO_OVERLAY
+		struct v4l2_vbi_format	        vbi;     // V4L2_BUF_TYPE_VBI_CAPTURE
+#if 1
+		struct v4l2_sliced_vbi_format	sliced;  // V4L2_BUF_TYPE_SLICED_VBI_CAPTURE
+#endif
+		__u8	raw_data[200];                   // user-defined
 	} fmt;
 };
 
@@ -916,6 +978,9 @@ struct v4l2_streamparm
 #define VIDIOC_ENUMAUDOUT	_IOWR ('V', 66, struct v4l2_audioout)
 #define VIDIOC_G_PRIORITY       _IOR  ('V', 67, enum v4l2_priority)
 #define VIDIOC_S_PRIORITY       _IOW  ('V', 68, enum v4l2_priority)
+#if 1
+#define VIDIOC_G_SLICED_VBI_CAP _IOR  ('V', 69, struct v4l2_sliced_vbi_cap)
+#endif
 
 /* for compatibility, will go away some day */
 #define VIDIOC_OVERLAY_OLD     	_IOWR ('V', 14, int)

--=-Sfv7Hwk1U/OhfQ5O8363--

