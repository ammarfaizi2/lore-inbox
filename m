Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265419AbSKAJ4U>; Fri, 1 Nov 2002 04:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265600AbSKAJ4U>; Fri, 1 Nov 2002 04:56:20 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:40423 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S265419AbSKAJ4T>; Fri, 1 Nov 2002 04:56:19 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: kernel-janitor-discuss@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: might_sleep() in copy_{from,to}_user and friends?
Date: Fri, 1 Nov 2002 13:02:19 +0100
User-Agent: KMail/1.4.3
Cc: Jaroslav Kysela <perex@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211011302.05461.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been looking for more places in 2.5 that can be marked 
might_sleep() and noticed that all the functions in asm/uaccess.h
are not marked although they sleep if the memory they access
has to be paged in.

After adding might_sleep() in ten places in asm-i386/uaccess.h
and arch/i386/lib/usercopy.c, I have been running this kernel
for about two weeks. So far, I have found only one place where
the kernel actually hits this and that one is trivially
fixable (maintainer cc'd, fix see below).

The question is if we can expect to find more bugs like
that if we have might_sleep() in uaccess.h or if the 
extra cycles and the work of changing ~100 places (for all
architectures) are just not worth it.

	Arnd <><

===== sound/core/pcm_native.c 1.17 vs edited =====
--- 1.17/sound/core/pcm_native.c	Sun Oct 13 21:19:17 2002
+++ edited/sound/core/pcm_native.c	Fri Nov  1 12:43:38 2002
@@ -2014,8 +2014,6 @@
 			n = snd_pcm_playback_hw_avail(runtime);
 		else
 			n = snd_pcm_capture_avail(runtime);
-		if (put_user(n, res))
-			err = -EFAULT;
 		break;
 	case SNDRV_PCM_STATE_XRUN:
 		err = -EPIPE;
@@ -2026,6 +2024,9 @@
 		break;
 	}
 	spin_unlock_irq(&runtime->lock);
+	if (!ret)
+		if (put_user(n, res))
+			err = -EFAULT;
 	return err;
 }
 		

