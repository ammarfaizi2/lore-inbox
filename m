Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264601AbUENXrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbUENXrg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUENXrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:47:00 -0400
Received: from mail.kroah.org ([65.200.24.183]:21733 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264601AbUENX3z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:29:55 -0400
Subject: Re: [PATCH] I2C update for 2.6.6
In-Reply-To: <10845773573133@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 14 May 2004 16:29:18 -0700
Message-Id: <10845773582979@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.15.13, 2004/05/11 13:44:19-07:00, R.S.Bultje@students.uu.nl

[PATCH] I2C: new i2c video decoder calls

Attached patch adds three new calls to the i2c video decoder API.  The changes
were requested by Michael (CC'ed) and approved by Gerd Knorr (v4l maintainer,
CC'ed).

Short explanation:

* INIT is a general initialization call with optional initialization data.
  Reason for this is that several i2c decoders (or general: clients) are being
  used by several adapters (main drivers), and in some cases, one adapter
  simply needs different settings than the other, either because the adapter
  is completely different or because the card was reverse engineered in a way
  that doesn't allow multiple adapters to run using the same original
  initialization data.  Michael faces such a problem right now.  Both he and
  me lack time to properly sit together and work out the exact details or a
  proper way to merge.

* VBI_BYPASS and GPIO set specific pins on the decoder.  This will be used
  in the saa7111 driver.  My driver (zr36067, original user of the saa7111
  driver) doesn't use any of this, but Michael's does.


 include/linux/video_decoder.h |    7 +++++++
 1 files changed, 7 insertions(+)


diff -Nru a/include/linux/video_decoder.h b/include/linux/video_decoder.h
--- a/include/linux/video_decoder.h	Fri May 14 16:19:20 2004
+++ b/include/linux/video_decoder.h	Fri May 14 16:19:20 2004
@@ -22,6 +22,10 @@
 #define	DECODER_STATUS_NTSC	8	/* auto detected */
 #define	DECODER_STATUS_SECAM	16	/* auto detected */
 
+struct video_decoder_init {
+	unsigned char len;
+	const unsigned char *data;
+};
 
 #define	DECODER_GET_CAPABILITIES _IOR('d', 1, struct video_decoder_capability)
 #define	DECODER_GET_STATUS    	_IOR('d', 2, int)
@@ -30,6 +34,9 @@
 #define	DECODER_SET_OUTPUT	_IOW('d', 5, int)	/* 0 <= output < #outputs */
 #define	DECODER_ENABLE_OUTPUT	_IOW('d', 6, int)	/* boolean output enable control */
 #define	DECODER_SET_PICTURE   	_IOW('d', 7, struct video_picture)
+#define	DECODER_SET_GPIO	_IOW('d', 8, int)	/* switch general purpose pin */
+#define	DECODER_INIT		_IOW('d', 9, struct video_decoder_init)	/* init internal registers at once */
+#define	DECODER_SET_VBI_BYPASS	_IOW('d', 10, int)	/* switch vbi bypass */
 
 #define	DECODER_DUMP		_IO('d', 192)		/* debug hook */
 

