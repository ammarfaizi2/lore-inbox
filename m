Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262493AbTCMTDv>; Thu, 13 Mar 2003 14:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262497AbTCMTDv>; Thu, 13 Mar 2003 14:03:51 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:52644 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262493AbTCMTDu>;
	Thu, 13 Mar 2003 14:03:50 -0500
Date: Thu, 13 Mar 2003 22:13:42 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.4] Memleak and incorrect return value in emu10k1 emu10k1_audio_open()
Message-ID: <20030313191342.GA2787@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   There is trivial memleak ion error exit path and incorrect value returned.
   Also seems it is not so bad idea to free allocated RAM before BUG(), too.
   See the patch.
   Found with help of smatch + enhanced unfree script.

Bye,
    Oleg

===== drivers/sound/emu10k1/audio.c 1.13 vs edited =====
--- 1.13/drivers/sound/emu10k1/audio.c	Sun May 26 17:49:32 2002
+++ edited/drivers/sound/emu10k1/audio.c	Thu Mar 13 22:10:39 2003
@@ -1135,7 +1135,8 @@
 
 		if ((wiinst = (struct wiinst *) kmalloc(sizeof(struct wiinst), GFP_KERNEL)) == NULL) {
 			ERROR();
-			return -ENODEV;
+			kfree(wave_dev);
+			return -ENOMEM;
 		}
 
 		wiinst->recsrc = card->wavein.recsrc;
@@ -1161,6 +1162,8 @@
 			wiinst->format.channels = hweight32(wiinst->fxwc);
 			break;
 		default:
+			kfree(wave_dev);
+			kfree(wiinst);
 			BUG();
 			break;
 		}
