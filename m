Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262526AbTCMTHi>; Thu, 13 Mar 2003 14:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262527AbTCMTHi>; Thu, 13 Mar 2003 14:07:38 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:56228 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262526AbTCMTHh>;
	Thu, 13 Mar 2003 14:07:37 -0500
Date: Thu, 13 Mar 2003 22:17:31 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [2.5] memleak in OSS emu10k1 driver in emu10k1_audio_open
Message-ID: <20030313191731.GA2821@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   There is a memleak on error exit path in OSS emu10k1 driver, also
   incorrect value is returned.
   And it seems to be not that bad idea to free some grabbed mem before BUG(),
   too.
   See the patch.
   Found with help of smatch + enhanced unfree script.

Bye,
    Oleg

===== sound/oss/emu10k1/audio.c 1.13 vs edited =====
--- 1.13/sound/oss/emu10k1/audio.c	Mon Feb 11 05:50:09 2002
+++ edited/sound/oss/emu10k1/audio.c	Thu Mar 13 22:14:40 2003
@@ -1136,7 +1136,8 @@
 
 		if ((wiinst = (struct wiinst *) kmalloc(sizeof(struct wiinst), GFP_KERNEL)) == NULL) {
 			ERROR();
-			return -ENODEV;
+			kfree(wave_dev);
+			return -ENOMEM;
 		}
 
 		wiinst->recsrc = card->wavein.recsrc;
@@ -1162,6 +1163,8 @@
 			wiinst->format.channels = hweight32(wiinst->fxwc);
 			break;
 		default:
+			kfree(wave_dev);
+			kfree(wiinst);
 			BUG();
 			break;
 		}
