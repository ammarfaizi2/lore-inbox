Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWDUXd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWDUXd5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 19:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWDUXd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 19:33:56 -0400
Received: from [67.104.119.229] ([67.104.119.229]:11012 "EHLO ssai.us")
	by vger.kernel.org with ESMTP id S1750766AbWDUXd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 19:33:56 -0400
Message-ID: <44496BDB.2090503@ssai.us>
Date: Fri, 21 Apr 2006 16:33:47 -0700
From: Scott Alfter <salfter@ssai.us>
User-Agent: Mail/News 1.5 (X11/20060324)
MIME-Version: 1.0
To: v4l-dvb-maintainer@linuxtv.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] cx25840 driver in 2.6.16 -- adds CX25836 support
Content-Type: multipart/mixed;
 boundary="------------070900020104070200030009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070900020104070200030009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

My company is working on a quad CX23416-based MPEG-2 compressor card.  The
hardware guy decided to use CX25836s to capture video, instead of the CX25840
that most everybody else uses.  The main difference between the '836 and '840
is that the '840 captures both audio and video, while the '836 captures video
only.  The video-related commands between the two are mostly the same, but the
chip needs a different initialization sequence and it'd probably be a good idea
to keep audio-related commands away from it.  It also doesn't need to have
audio firmware loaded.

This is my first attempt at a Linux kernel patch.  I've tested it with NTSC
input at 352x480 and 720x480, and it works well.  I'm currently using it with a
hacked version of ivtv 0.6.1.  Those changes will eventually need to be
released here as well, but the hardware design is still in a bit of flux.  I
also need to put together a driver for the audio capture chips used on the
card, the TI TLV320AIC23B; there appears to be no driver in the kernel for that
chip.

The patch is attached; a test mailing indicated that Thunderbird attaches
patches inline instead of encoded.  The patch is also available from this URL:

http://alfter.us/files/linux-2.6.16-cx25836.patch

Scott Alfter
salfter@ssai.us


--------------070900020104070200030009
Content-Type: text/plain;
 name="linux-2.6.16-cx25836.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.16-cx25836.patch"

diff -upr -X dontdiff linux-2.6.16/drivers/media/video/cx25840/cx25840-core.c linux-2.6.16-gentoo-r1/drivers/media/video/cx25840/cx25840-core.c
--- linux-2.6.16/drivers/media/video/cx25840/cx25840-core.c	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16-gentoo-r1/drivers/media/video/cx25840/cx25840-core.c	2006-04-21 10:13:29.000000000 -0700
@@ -150,56 +150,91 @@ static void init_dll2(struct i2c_client 
 static void cx25840_initialize(struct i2c_client *client, int loadfw)
 {
 	struct cx25840_state *state = i2c_get_clientdata(client);
+//	int delay;
 
-	/* datasheet startup in numbered steps, refer to page 3-77 */
-	/* 2. */
-	cx25840_and_or(client, 0x803, ~0x10, 0x00);
-	/* The default of this register should be 4, but I get 0 instead.
-	 * Set this register to 4 manually. */
-	cx25840_write(client, 0x000, 0x04);
-	/* 3. */
-	init_dll1(client);
-	init_dll2(client);
-	cx25840_write(client, 0x136, 0x0a);
-	/* 4. */
-	cx25840_write(client, 0x13c, 0x01);
-	cx25840_write(client, 0x13c, 0x00);
-	/* 5. */
-	if (loadfw)
-		cx25840_loadfw(client);
-	/* 6. */
-	cx25840_write(client, 0x115, 0x8c);
-	cx25840_write(client, 0x116, 0x07);
-	cx25840_write(client, 0x118, 0x02);
-	/* 7. */
-	cx25840_write(client, 0x4a5, 0x80);
-	cx25840_write(client, 0x4a5, 0x00);
-	cx25840_write(client, 0x402, 0x00);
-	/* 8. */
-	cx25840_write(client, 0x401, 0x18);
-	cx25840_write(client, 0x4a2, 0x10);
-	cx25840_write(client, 0x402, 0x04);
-	/* 10. */
-	cx25840_write(client, 0x8d3, 0x1f);
-	cx25840_write(client, 0x8e3, 0x03);
-
-	cx25840_vbi_setup(client);
-
-	/* trial and error says these are needed to get audio */
-	cx25840_write(client, 0x914, 0xa0);
-	cx25840_write(client, 0x918, 0xa0);
-	cx25840_write(client, 0x919, 0x01);
-
-	/* stereo prefered */
-	cx25840_write(client, 0x809, 0x04);
-	/* AC97 shift */
-	cx25840_write(client, 0x8cf, 0x0f);
-
-	/* (re)set input */
-	set_input(client, state->vid_input, state->aud_input);
-
-	/* start microcontroller */
-	cx25840_and_or(client, 0x803, ~0x10, 0x10);
+	switch (state->is_cx25836)
+	{
+		case 0:
+			v4l_dbg(1,cx25840_debug,client,"sending init for CX25840\n");
+			/* datasheet startup in numbered steps, refer to page 3-77 */
+			/* 2. */
+ 			cx25840_and_or(client, 0x803, ~0x10, 0x00);
+			/* The default of this register should be 4, but I get 0 instead.
+			* Set this register to 4 manually. */
+			cx25840_write(client, 0x000, 0x04);
+			/* 3. */
+			init_dll1(client);
+			init_dll2(client);
+			cx25840_write(client, 0x136, 0x0a);
+			/* 4. */
+			cx25840_write(client, 0x13c, 0x01);
+			cx25840_write(client, 0x13c, 0x00);
+			/* 5. */
+			cx25840_loadfw(client);
+			/* 6. */
+			cx25840_write(client, 0x115, 0x8c);
+			cx25840_write(client, 0x116, 0x07);
+			cx25840_write(client, 0x118, 0x02);
+			/* 7. */
+			cx25840_write(client, 0x4a5, 0x80);
+			cx25840_write(client, 0x4a5, 0x00);
+			cx25840_write(client, 0x402, 0x00);
+			/* 8. */
+			cx25840_write(client, 0x401, 0x18);
+			cx25840_write(client, 0x4a2, 0x10);
+			cx25840_write(client, 0x402, 0x04);
+			/* 10. */
+			cx25840_write(client, 0x8d3, 0x1f);
+			cx25840_write(client, 0x8e3, 0x03);
+		
+			cx25840_vbi_setup(client);
+		
+			/* trial and error says these are needed to get audio */
+			cx25840_write(client, 0x914, 0xa0);
+			cx25840_write(client, 0x918, 0xa0);
+			cx25840_write(client, 0x919, 0x01);
+		
+			/* stereo prefered */
+			cx25840_write(client, 0x809, 0x04);
+			/* AC97 shift */
+			cx25840_write(client, 0x8cf, 0x0f);
+		
+			/* (re)set input */
+			set_input(client, state->vid_input, state->aud_input);
+		
+			/* start microcontroller */
+			cx25840_and_or(client, 0x803, ~0x10, 0x10);
+			v4l_dbg(1,cx25840_debug,client,"CX25840 init complete\n");
+			break;
+		case 1:
+			v4l_dbg(1,cx25840_debug,client,"sending init for CX25836\n");
+			/* reset configuration is described on page 3-77 of the CX25836 datasheet */
+			/* 2. */
+			cx25840_and_or(client,0x000,~0x01,0x01);
+			cx25840_and_or(client,0x000,~0x01,0x00);
+			/* 3a. */
+			cx25840_and_or(client,0x15A,~0x70,0x00);
+			/* 3b. */
+			cx25840_and_or(client,0x15B,~0x1E,0x06);
+			/* 3c. */
+			cx25840_and_or(client,0x159,~0x02,0x02);
+			/* 3d. */
+			/* FIXME: should have a 10-us delay here
+			for (delay=0; delay<10; delay++)
+				inb(0x80);
+			*/
+			/* 3e. */
+			cx25840_and_or(client,0x159,~0x02,0x00);
+			/* 3f. */
+			cx25840_and_or(client,0x159,~0xC0,0xC0);
+			/* 3g. */
+			cx25840_and_or(client,0x159,~0x01,0x00);
+			cx25840_and_or(client,0x159,~0x01,0x01);
+			/* 3h. */
+			cx25840_and_or(client,0x15B,~0x1E,0x10);
+			v4l_dbg(1,cx25840_debug,client,"CX25836 init complete\n");
+			break;
+	}
 }
 
 /* ----------------------------------------------------------------------- */
@@ -308,8 +343,11 @@ static int set_input(struct i2c_client *
 
 	state->vid_input = vid_input;
 	state->aud_input = aud_input;
-	cx25840_audio_set_path(client);
-	input_change(client);
+	if (!state->is_cx25836)
+	{
+		cx25840_audio_set_path(client);
+		input_change(client);
+	}
 	return 0;
 }
 
@@ -676,10 +714,19 @@ static int cx25840_command(struct i2c_cl
 	case VIDIOC_INT_AUDIO_CLOCK_FREQ:
 		return cx25840_audio(client, cmd, arg);
 
-	case VIDIOC_STREAMON:
+		case VIDIOC_STREAMON:		if (!state->is_cx25836)
+
 		v4l_dbg(1, cx25840_debug, client, "enable output\n");
-		cx25840_write(client, 0x115, 0x8c);
-		cx25840_write(client, 0x116, 0x07);
+		if (!state->is_cx25836)
+		{
+			cx25840_write(client, 0x115, 0x8c);
+			cx25840_write(client, 0x116, 0x07);
+		}
+		else
+		{
+			cx25840_write(client, 0x115, 0x0c);
+			cx25840_write(client, 0x116, 0x04);
+		}
 		break;
 
 	case VIDIOC_STREAMOFF:
@@ -796,20 +843,23 @@ static int cx25840_command(struct i2c_cl
 	}
 
 	case VIDIOC_S_TUNER:
-		switch (vt->audmode) {
-		case V4L2_TUNER_MODE_MONO:
-		case V4L2_TUNER_MODE_LANG1:
-			/* Force PREF_MODE to MONO */
-			cx25840_and_or(client, 0x809, ~0xf, 0x00);
-			break;
-		case V4L2_TUNER_MODE_STEREO:
-			/* Force PREF_MODE to STEREO */
-			cx25840_and_or(client, 0x809, ~0xf, 0x04);
-			break;
-		case V4L2_TUNER_MODE_LANG2:
-			/* Force PREF_MODE to LANG2 */
-			cx25840_and_or(client, 0x809, ~0xf, 0x01);
-			break;
+		if (~state->is_cx25836)
+		{
+			switch (vt->audmode) {
+			case V4L2_TUNER_MODE_MONO:
+			case V4L2_TUNER_MODE_LANG1:
+				/* Force PREF_MODE to MONO */
+				cx25840_and_or(client, 0x809, ~0xf, 0x00);
+				break;
+			case V4L2_TUNER_MODE_STEREO:
+				/* Force PREF_MODE to STEREO */
+				cx25840_and_or(client, 0x809, ~0xf, 0x04);
+				break;
+			case V4L2_TUNER_MODE_LANG2:
+				/* Force PREF_MODE to LANG2 */
+				cx25840_and_or(client, 0x809, ~0xf, 0x01);
+				break;
+			}
 		}
 		break;
 
@@ -867,8 +917,8 @@ static int cx25840_detect_client(struct 
 	device_id |= cx25840_read(client, 0x100);
 
 	/* The high byte of the device ID should be
-	 * 0x84 if chip is present */
-	if ((device_id & 0xff00) != 0x8400) {
+	 * 0x84 if chip is present (0x83 for CX25836/37) */
+	if (((device_id & 0xff00) != 0x8400) && ((device_id & 0xff00) != 0x8300)) {
 		v4l_dbg(1, cx25840_debug, client, "cx25840 not found\n");
 		kfree(client);
 		return 0;
@@ -891,8 +941,10 @@ static int cx25840_detect_client(struct 
 	state->aud_input = CX25840_AUDIO8;
 	state->audclk_freq = 48000;
 	state->pvr150_workaround = 0;
+	state->is_cx25836=((device_id&0xFF00)==0x8300);
 
-	cx25840_initialize(client, 1);
+	/* only load firmware into CX2584x devices */
+	cx25840_initialize(client, !state->is_cx25836);
 
 	i2c_attach_client(client);
 
diff -upr -X dontdiff linux-2.6.16/drivers/media/video/cx25840/cx25840.h linux-2.6.16-gentoo-r1/drivers/media/video/cx25840/cx25840.h
--- linux-2.6.16/drivers/media/video/cx25840/cx25840.h	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16-gentoo-r1/drivers/media/video/cx25840/cx25840.h	2006-04-18 10:47:56.000000000 -0700
@@ -78,6 +78,7 @@ struct cx25840_state {
 	enum cx25840_video_input vid_input;
 	enum cx25840_audio_input aud_input;
 	u32 audclk_freq;
+	int is_cx25836;
 };
 
 /* ----------------------------------------------------------------------- */

--------------070900020104070200030009--
