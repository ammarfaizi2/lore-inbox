Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318085AbSIABrK>; Sat, 31 Aug 2002 21:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318086AbSIABrK>; Sat, 31 Aug 2002 21:47:10 -0400
Received: from e166066.upc-e.chello.nl ([213.93.166.66]:56584 "EHLO
	crawl.var.cx") by vger.kernel.org with ESMTP id <S318085AbSIABrJ>;
	Sat, 31 Aug 2002 21:47:09 -0400
Date: Sun, 1 Sep 2002 03:51:35 +0200
From: Frank v Waveren <fvw@var.cx>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: auto-muting pcm when not in use
Message-ID: <1030845088TRI.fvw@yendor.var.cx>
References: <1030226923OGI.fvw@yendor.var.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <1030226923OGI.fvw@yendor.var.cx>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 25, 2002 at 12:13:36AM +0200, Frank v Waveren wrote:
> I have an el-cheapo sound card in my desktop machine, which works
> fine for the odd mail notification sound. However, it tends to
> produce quite some white noise and a highpitched tone when not in
> use.  [I recall a patch doing this] and if not, would anyone be
> interested in one?

Well, I've made the patch, it's rather kludgy but to do this
properly would require modify quite a lot of the code and possibly
API's (I'd hoped to be easily able to create an extra mixer channel
that was visible to userspace instead of pcm, and whose level would
get written to the pcm mixer channel when the audio device was
opened), but it does work rather nicely for me.

If there's any interest in having it in the main tree (as I said, it's
a kludge, but one that's needed/useful on a lot of machines) I'll put
some kernel option or module paramater if's around it, let me know.

As always, suggestions/fixes/flames welcome.

-- 
Frank v Waveren                                      Fingerprint: 0EDB 8787
fvw@[var.cx|stack.nl|dse.nl|chello.nl] ICQ#10074100     09B9 6EF5 6425 B855
Public key: hkp://wwwkeys.pgp.net/fvw@var.cx            7179 3036 E136 B85D

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.19-sb-automute-pcm.diff"

diff -urNbB linux/drivers/sound/sb.h linux-fvw/drivers/sound/sb.h
--- linux/drivers/sound/sb.h	Sun Sep  1 02:53:53 2002
+++ linux-fvw/drivers/sound/sb.h	Sun Sep  1 02:38:24 2002
@@ -114,6 +114,8 @@
 	   int supported_rec_devices, supported_out_devices;
 	   int my_mixerdev;
 	   int sbmixnum;
+       int saved_level_pcm; // for auto-muted pcm
+
 
 	/* Audio fields */
 	   unsigned long trg_buf;
diff -urNbB /home/fvw/linux/drivers/sound/sb_audio.c /tmp/linux-fvw/drivers/sound/sb_audio.c
--- linux/drivers/sound/sb_audio.c	Sun Sep  1 02:48:08 2002
+++ linux-fvw/drivers/sound/sb_audio.c	Sun Sep  1 02:43:23 2002
@@ -60,6 +60,10 @@
 			return -EBUSY;
 		}
 	}
+   
+    if (!sb_getmixer(devc, SOUND_MIXER_PCM))
+       sb_setmixer(devc, SOUND_MIXER_PCM, devc->saved_level_pcm);
+   
 	devc->opened = mode;
 	spin_unlock_irqrestore(&devc->lock, flags);
 
@@ -122,6 +126,10 @@
 		sb_setmixer(devc,ALS007_OUTPUT_CTRL2,
 			sb_getmixer(devc,ALS007_OUTPUT_CTRL2) | 0x06);
 	}
+
+   devc->saved_level_pcm=sb_getmixer(devc, SOUND_MIXER_PCM);
+   sb_setmixer(devc, SOUND_MIXER_PCM, 0);
+
 	devc->opened = 0;
 }
 
@@ -1090,4 +1098,10 @@
 	}
 	audio_devs[devc->dev]->mixer_dev = devc->my_mixerdev;
 	audio_devs[devc->dev]->min_fragment = 5;
+   
+    sb_setmixer(devc, SOUND_MIXER_PCM, 0);
+    devc->saved_level_pcm=0x0000; /* This should be the *_default_levels value
+                                     from sb_mixer.c which we can't get at 
+                                     from here */
+    
 }

--3V7upXqbjpZ4EhLz--
