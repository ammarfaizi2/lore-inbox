Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVCHLTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVCHLTU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 06:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVCHLTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 06:19:04 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:37867 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261978AbVCHLPN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 06:15:13 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 8 Mar 2005 12:09:12 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l2 api: mpeg encoder support
Message-ID: <20050308110912.GA31184@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a ioctl to set mpeg hardware encoder parameters.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 include/linux/videodev2.h |  136 ++++++++++++++++++++++----------------
 1 files changed, 82 insertions(+), 54 deletions(-)

Index: linux-2.6.11-rc4/include/linux/videodev2.h
===================================================================
--- linux-2.6.11-rc4.orig/include/linux/videodev2.h	2005-02-14 15:24:05.000000000 +0100
+++ linux-2.6.11-rc4/include/linux/videodev2.h	2005-02-15 12:37:28.000000000 +0100
@@ -268,64 +268,92 @@ struct v4l2_timecode
 /* The above is based on SMPTE timecodes */
 
 
+#if 1
 /*
- *	C O M P R E S S I O N   P A R A M E T E R S
+ *	M P E G   C O M P R E S S I O N   P A R A M E T E R S
+ *
+ *  ### WARNING: this is still work-in-progress right now, most likely
+ *  ###          there will be some incompatible changes.
+ *
  */
-#if 0
-/* ### generic compression settings don't work, there is too much
- * ### codec-specific stuff.  Maybe reuse that for MPEG codec settings
- * ### later ... */
-struct v4l2_compression
-{
-	__u32	quality;
-	__u32	keyframerate;
-	__u32	pframerate;
-	__u32	reserved[5];
 
-/*  what we'll need for MPEG, extracted from some postings on
-    the v4l list (Gert Vervoort, PlasmaJohn).
 
-system stream:
-  - type: elementary stream(ES), packatised elementary stream(s) (PES)
-    program stream(PS), transport stream(TS)
-  - system bitrate
-  - PS packet size (DVD: 2048 bytes, VCD: 2324 bytes)
-  - TS video PID
-  - TS audio PID
-  - TS PCR PID
-  - TS system information tables (PAT, PMT, CAT, NIT and SIT)
-  - (MPEG-1 systems stream vs. MPEG-2 program stream (TS not supported
-    by MPEG-1 systems)
+enum v4l2_bitrate_mode {
+	V4L2_BITRATE_NONE = 0,	/* not specified */
+	V4L2_BITRATE_CBR,	/* constant bitrate */
+	V4L2_BITRATE_VBR,	/* variable bitrate */
+};
+struct v4l2_bitrate {
+	/* rates are specified in kbit/sec */
+	enum v4l2_bitrate_mode	mode;
+	__u32			min;
+	__u32			target;  /* use this one for CBR */
+	__u32			max;
+};
 
-audio:
-  - type: MPEG (+Layer I,II,III), AC-3, LPCM
-  - bitrate
-  - sampling frequency (DVD: 48 Khz, VCD: 44.1 KHz, 32 kHz)
-  - Trick Modes? (ff, rew)
-  - Copyright
-  - Inverse Telecine
+enum v4l2_mpeg_streamtype {
+	V4L2_MPEG_SS_1,		/* MPEG-1 system stream */
+	V4L2_MPEG_PS_2,		/* MPEG-2 program stream */
+	V4L2_MPEG_TS_2,		/* MPEG-2 transport stream */
+	V4L2_MPEG_PS_DVD,      	/* MPEG-2 program stream with DVD header fixups */
+};
+enum v4l2_mpeg_audiotype {
+	V4L2_MPEG_AU_2_I,	/* MPEG-2 layer 1 */
+	V4L2_MPEG_AU_2_II,	/* MPEG-2 layer 2 */
+	V4L2_MPEG_AU_2_III,	/* MPEG-2 layer 3 */
+	V4L2_MPEG_AC3,		/* AC3 */
+	V4L2_MPEG_LPCM,		/* LPCM */
+};
+enum v4l2_mpeg_videotype {
+	V4L2_MPEG_VI_1,		/* MPEG-1 */
+	V4L2_MPEG_VI_2,		/* MPEG-2 */
+};
+enum v4l2_mpeg_aspectratio {
+	V4L2_MPEG_ASPECT_SQUARE = 1,   /* square pixel */
+	V4L2_MPEG_ASPECT_4_3    = 2,   /*  4 : 3       */
+	V4L2_MPEG_ASPECT_16_9   = 3,   /* 16 : 9       */
+	V4L2_MPEG_ASPECT_1_221  = 4,   /*  1 : 2,21    */
+};
 
-video:
-  - picturesize (SIF, 1/2 D1, 2/3 D1, D1) and PAL/NTSC norm can be set
-    through excisting V4L2 controls
-  - noise reduction, parameters encoder specific?
-  - MPEG video version: MPEG-1, MPEG-2
-  - GOP (Group Of Pictures) definition:
-    - N: number of frames per GOP
-    - M: distance between reference (I,P) frames
-    - open/closed GOP
-  - quantiser matrix: inter Q matrix (64 bytes) and intra Q matrix (64 bytes)
-  - quantiser scale: linear or logarithmic
-  - scanning: alternate or zigzag
-  - bitrate mode: CBR (constant bitrate) or VBR (variable bitrate).
-  - target video bitrate for CBR
-  - target video bitrate for VBR
-  - maximum video bitrate for VBR - min. quantiser value for VBR
-  - max. quantiser value for VBR
-  - adaptive quantisation value
-  - return the number of bytes per GOP or bitrate for bitrate monitoring
+struct v4l2_mpeg_compression {
+	/* general */
+	enum v4l2_mpeg_streamtype	st_type;
+	struct v4l2_bitrate		st_bitrate;
 
-*/
+	/* transport streams */
+	__u16				ts_pid_pmt;
+	__u16				ts_pid_audio;
+	__u16				ts_pid_video;
+	__u16				ts_pid_pcr;
+
+	/* program stream */
+	__u16				ps_size;
+	__u16				reserved_1;    /* align */
+
+	/* audio */
+	enum v4l2_mpeg_audiotype	au_type;
+	struct v4l2_bitrate		au_bitrate;
+	__u32				au_sample_rate;
+	__u8                            au_pesid;
+	__u8                            reserved_2[3]; /* align */
+
+	/* video */
+	enum v4l2_mpeg_videotype	vi_type;
+	enum v4l2_mpeg_aspectratio	vi_aspect_ratio;
+	struct v4l2_bitrate		vi_bitrate;
+	__u32				vi_frame_rate;
+	__u16				vi_frames_per_gop;
+	__u16				vi_bframes_count;
+	__u8                            vi_pesid;
+	__u8                            reserved_3[3]; /* align */
+
+	/* misc flags */
+	__u32                           closed_gops:1;
+	__u32                           pulldown:1;
+	__u32                           reserved_4:30; /* align */
+
+	/* I don't expect the above being perfect yet ;) */
+	__u32				reserved_5[8];
 };
 #endif
 
@@ -841,9 +869,9 @@ struct v4l2_streamparm
 #define VIDIOC_ENUM_FMT         _IOWR ('V',  2, struct v4l2_fmtdesc)
 #define VIDIOC_G_FMT		_IOWR ('V',  4, struct v4l2_format)
 #define VIDIOC_S_FMT		_IOWR ('V',  5, struct v4l2_format)
-#if 0
-#define VIDIOC_G_COMP		_IOR  ('V',  6, struct v4l2_compression)
-#define VIDIOC_S_COMP		_IOW  ('V',  7, struct v4l2_compression)
+#if 1 /* experimental */
+#define VIDIOC_G_MPEGCOMP       _IOR  ('V',  6, struct v4l2_mpeg_compression)
+#define VIDIOC_S_MPEGCOMP     	_IOW  ('V',  7, struct v4l2_mpeg_compression)
 #endif
 #define VIDIOC_REQBUFS		_IOWR ('V',  8, struct v4l2_requestbuffers)
 #define VIDIOC_QUERYBUF		_IOWR ('V',  9, struct v4l2_buffer)

-- 
#define printk(args...) fprintf(stderr, ## args)
