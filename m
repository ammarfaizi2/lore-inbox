Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261720AbTCLPJJ>; Wed, 12 Mar 2003 10:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261726AbTCLPJJ>; Wed, 12 Mar 2003 10:09:09 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:23010 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S261720AbTCLPJD>; Wed, 12 Mar 2003 10:09:03 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 12 Mar 2003 16:19:34 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Michael Hunold <m.hunold@gmx.de>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: crunch MIN/MAX macros.
Message-ID: <20030312151934.GA13235@bytesex.org>
References: <20030310200852.GA6397@bytesex.org> <20030310220233.A13923@infradead.org> <20030311181240.GB7186@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030311181240.GB7186@bytesex.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> mail the old patch version :-/  I'll resort stuff and mail a new
> patch later today or tomorrow.

Ok, here we go.  This is patch #1 which just removes the private
MIN/MAX macos.

  Gerd

==============================[ cut here ]==============================
This patch deletes the MIN/MAX macros from audiochip.h
and fixes all users of these macros to use the kernels
min/max macros instead.

--- linux-2.5.64drivers/media/video/audiochip.h	2003-03-12 15:04:36.000000000 +0100
+++ linuxdrivers/media/video/audiochip.h	2003-03-12 15:04:47.000000000 +0100
@@ -3,9 +3,6 @@
 
 /* ---------------------------------------------------------------------- */
 
-#define MIN(a,b) (((a)>(b))?(b):(a))
-#define MAX(a,b) (((a)>(b))?(a):(b))
-
 /* v4l device was opened in Radio mode */
 #define AUDC_SET_RADIO        _IO('m',2)
 /* select from TV,radio,extern,MUTE */
@@ -21,15 +18,6 @@
 #define AUDIO_MUTE         0x80
 #define AUDIO_UNMUTE       0x81
 
-/* all the stuff below is obsolete and just here for reference.  I'll
- * remove it once the driver is tested and works fine.
- *
- * Instead creating alot of tiny API's for all kinds of different
- * chips, we'll just pass throuth the v4l ioctl structs (v4l2 not
- * yet...).  It is a bit less flexible, but most/all used i2c chips
- * make sense in v4l context only.  So I think that's acceptable...
- */
-
 /* misc stuff to pass around config info to i2c chips */
 #define AUDC_CONFIG_PINNACLE  _IOW('m',32,int)
 
--- linux-2.5.64drivers/media/video/msp3400.c	2003-03-12 14:42:52.000000000 +0100
+++ linuxdrivers/media/video/msp3400.c	2003-03-12 15:03:51.000000000 +0100
@@ -1495,8 +1495,8 @@
 			VIDEO_AUDIO_MUTABLE;
 		if (msp->muted)
 			va->flags |= VIDEO_AUDIO_MUTE;
-		va->volume=MAX(msp->left,msp->right);
-		va->balance=(32768*MIN(msp->left,msp->right))/
+		va->volume=max(msp->left,msp->right);
+		va->balance=(32768*min(msp->left,msp->right))/
 			(va->volume ? va->volume : 1);
 		va->balance=(msp->left<msp->right)?
 			(65535-va->balance) : va->balance;
@@ -1517,9 +1517,9 @@
 
 		dprintk(KERN_DEBUG "msp34xx: VIDIOCSAUDIO\n");
 		msp->muted = (va->flags & VIDEO_AUDIO_MUTE);
-		msp->left = (MIN(65536 - va->balance,32768) *
+		msp->left = (min(65536 - va->balance,32768) *
 			     va->volume) / 32768;
-		msp->right = (MIN(va->balance,32768) *
+		msp->right = (min(va->balance,(__u16)32768) *
 			      va->volume) / 32768;
 		msp->bass = va->bass;
 		msp->treble = va->treble;
--- linux-2.5.64drivers/media/video/tda9875.c	2003-03-12 14:42:39.000000000 +0100
+++ linuxdrivers/media/video/tda9875.c	2003-03-12 15:03:51.000000000 +0100
@@ -316,17 +316,15 @@
 		/* min is -84 max is 24 */
 		left = (t->lvol+84)*606;
 		right = (t->rvol+84)*606;
-		va->volume=MAX(left,right);
-		va->balance=(32768*MIN(left,right))/
+		va->volume=max(left,right);
+		va->balance=(32768*min(left,right))/
 			(va->volume ? va->volume : 1);
 		va->balance=(left<right)?
 			(65535-va->balance) : va->balance;
 		va->bass = (t->bass+12)*2427;    /* min -12 max +15 */
 		va->treble = (t->treble+12)*2730;/* min -12 max +12 */
-
 		va->mode |= VIDEO_SOUND_MONO;
 
-
 		break; /* VIDIOCGAUDIO case */
 	}
 
@@ -336,9 +334,9 @@
 		int left,right;
 
 		dprintk("VIDEOCSAUDIO...\n"); 
-		left = (MIN(65536 - va->balance,32768) *
+		left = (min(65536 - va->balance,32768) *
 			va->volume) / 32768;
-		right = (MIN(va->balance,32768) *
+		right = (min(va->balance,(__u16)32768) *
 			 va->volume) / 32768;
 		t->lvol = ((left/606)-84) & 0xff;
 		if (t->lvol > 24)
--- linux-2.5.64drivers/media/video/tvaudio.c	2003-03-12 14:42:22.000000000 +0100
+++ linuxdrivers/media/video/tvaudio.c	2003-03-12 15:03:51.000000000 +0100
@@ -1477,8 +1477,8 @@
 
 		if (desc->flags & CHIP_HAS_VOLUME) {
 			va->flags  |= VIDEO_AUDIO_VOLUME;
-			va->volume  = MAX(chip->left,chip->right);
-			va->balance = (32768*MIN(chip->left,chip->right))/
+			va->volume  = max(chip->left,chip->right);
+			va->balance = (32768*min(chip->left,chip->right))/
 				(va->volume ? va->volume : 1);
 		}
 		if (desc->flags & CHIP_HAS_BASSTREBLE) {
@@ -1500,9 +1500,9 @@
 		struct video_audio *va = arg;
 		
 		if (desc->flags & CHIP_HAS_VOLUME) {
-			chip->left = (MIN(65536 - va->balance,32768) *
+			chip->left = (min(65536 - va->balance,32768) *
 				      va->volume) / 32768;
-			chip->right = (MIN(va->balance,32768) *
+			chip->right = (min(va->balance,(__u16)32768) *
 				       va->volume) / 32768;
 			chip_write(chip,desc->leftreg,desc->volfunc(chip->left));
 			chip_write(chip,desc->rightreg,desc->volfunc(chip->right));
--- linux-2.5.64drivers/media/video/tvmixer.c	2003-03-12 14:43:25.000000000 +0100
+++ linuxdrivers/media/video/tvmixer.c	2003-03-12 15:03:51.000000000 +0100
@@ -16,8 +16,6 @@
 #include <linux/soundcard.h>
 #include <asm/uaccess.h>
 
-#include "audiochip.h"
-#include "id.h"
 
 #define DEV_MAX  4
 
@@ -136,16 +134,16 @@
 	case MIXER_WRITE(SOUND_MIXER_VOLUME):
 		left  = mix_to_v4l(val);
 		right = mix_to_v4l(val >> 8);
-		va.volume  = MAX(left,right);
-		va.balance = (32768*MIN(left,right)) / (va.volume ? va.volume : 1);
+		va.volume  = max(left,right);
+		va.balance = (32768*min(left,right)) / (va.volume ? va.volume : 1);
 		va.balance = (left<right) ? (65535-va.balance) : va.balance;
 		client->driver->command(client,VIDIOCSAUDIO,&va);
 		client->driver->command(client,VIDIOCGAUDIO,&va);
 		/* fall throuth */
 	case MIXER_READ(SOUND_MIXER_VOLUME):
-		left  = (MIN(65536 - va.balance,32768) *
+		left  = (min(65536 - va.balance,32768) *
 			 va.volume) / 32768;
-		right = (MIN(va.balance,32768) *
+		right = (min(va.balance,32768) *
 			 va.volume) / 32768;
 		ret = v4l_to_mix2(left,right);
 		break;
