Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130168AbRAKARj>; Wed, 10 Jan 2001 19:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130338AbRAKAR3>; Wed, 10 Jan 2001 19:17:29 -0500
Received: from typhoon.mail.pipex.net ([158.43.128.27]:25320 "HELO
	typhoon.mail.pipex.net") by vger.kernel.org with SMTP
	id <S130168AbRAKARQ>; Wed, 10 Jan 2001 19:17:16 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200101110012.f0B0CAM00883@wittsend.ukgateway.net>
Subject: [PATCH]: Keep sound-module usage correct, even if audio_open fails
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Date: Thu, 11 Jan 2001 00:12:10 +0000 (GMT)
Reply-To: rankinc@zip.com.au
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I noticed that if you try to (e.g.) play two WAV file simultaneously,
then not only does the second one fail ("Device or resource busy", of
course) but the sound-card module's usage count breaks.

Here is a patch. And Alan, since you seem to be the person collecting
these sound patches, I should point out that this patch to
drivers/sound/audio.c completely replaces the patch to audio.c that I
submitted earlier. That patch was related to the coprocessor module
locking, but this new patch has reworked the way that audio_open()
cleans up after itself anyway. This clean-up now includes the
coprocessor too.

Cheers,
Chris

--- linux-vanilla/drivers/sound/audio.c	Fri Aug 11 16:26:43 2000
+++ linux-2.4.0-ac3/drivers/sound/audio.c	Wed Jan 10 23:53:23 2001
@@ -21,6 +21,9 @@
  * Daniel Rodriksson: reworked the use of the device specific copy_user
  *                    still generic
  * Horst von Brand:  Add missing #include <linux/string.h>
+ * Chris Rankin    : Update the module-usage counter for the coprocessor,
+ *                   and decrement the counters again if we cannot open
+ *                   the audio device.
  */
 
 #include <linux/stddef.h>
@@ -71,6 +74,8 @@
 	int bits;
 	int dev_type = dev & 0x0f;
 	int mode = translate_mode(file);
+	const struct audio_driver *driver;
+	const struct coproc_operations *coprocessor;
 
 	dev = dev >> 4;
 
@@ -82,18 +87,20 @@
 	if (dev < 0 || dev >= num_audiodevs)
 		return -ENXIO;
 
-	if (audio_devs[dev]->d->owner)
-		__MOD_INC_USE_COUNT (audio_devs[dev]->d->owner);
+	driver = audio_devs[dev]->d;
+	if (driver->owner)
+		__MOD_INC_USE_COUNT(driver->owner);
 
 	if ((ret = DMAbuf_open(dev, mode)) < 0)
-		return ret;
+		goto error_1;
 
-	if (audio_devs[dev]->coproc) {
-		if ((ret = audio_devs[dev]->coproc->
-			open(audio_devs[dev]->coproc->devc, COPR_PCM)) < 0) {
-			audio_release(dev, file);
+	if ( (coprocessor = audio_devs[dev]->coproc) != NULL ) {
+		if (coprocessor->owner)
+			__MOD_INC_USE_COUNT(coprocessor->owner);
+
+		if ((ret = coprocessor->open(coprocessor->devc, COPR_PCM)) < 0) {
 			printk(KERN_WARNING "Sound: Can't access coprocessor device\n");
-			return ret;
+			goto error_2;
 		}
 	}
 	
@@ -106,6 +113,20 @@
 
 	audio_devs[dev]->audio_mode = AM_NONE;
 
+	return 0;
+
+	/*
+	 * Clean-up stack: this is what needs (un)doing if
+	 * we can't open the audio device ...
+	 */
+	error_2:
+	if (coprocessor->owner)
+		__MOD_DEC_USE_COUNT(coprocessor->owner);
+	DMAbuf_release(dev, mode);
+
+	error_1:
+	if (driver->owner)
+		__MOD_DEC_USE_COUNT(driver->owner);
 
 	return ret;
 }
@@ -156,7 +177,8 @@
 
 void audio_release(int dev, struct file *file)
 {
-	int             mode = translate_mode(file);
+	const struct coproc_operations *coprocessor;
+	int mode = translate_mode(file);
 
 	dev = dev >> 4;
 
@@ -176,8 +198,12 @@
 	if (mode & OPEN_WRITE)
 		sync_output(dev);
 
-	if (audio_devs[dev]->coproc)
-		audio_devs[dev]->coproc->close(audio_devs[dev]->coproc->devc, COPR_PCM);
+	if ( (coprocessor = audio_devs[dev]->coproc) != NULL ) {
+		coprocessor->close(coprocessor->devc, COPR_PCM);
+
+		if (coprocessor->owner)
+			__MOD_DEC_USE_COUNT(coprocessor->owner);
+	}
 	DMAbuf_release(dev, mode);
 
 	if (audio_devs[dev]->d->owner)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
