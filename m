Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319382AbSH2Wfb>; Thu, 29 Aug 2002 18:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319381AbSH2Vve>; Thu, 29 Aug 2002 17:51:34 -0400
Received: from smtpout.mac.com ([204.179.120.85]:42718 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319371AbSH2VvC>;
	Thu, 29 Aug 2002 17:51:02 -0400
Message-Id: <200208292155.g7TLtP72021501@smtp-relay04-en1.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 12/41 sound/oss/nm256_audio.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/nm256_audio.c	Sat Apr 20 18:25:20 2002
+++ linux-2.5-cli-oss/sound/oss/nm256_audio.c	Tue Aug 13 15:38:21 2002
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/delay.h>
+#include <linux/spinlock.h>
 #include "sound_config.h"
 #include "nm256.h"
 #include "nm256_coeff.h"
@@ -262,8 +263,7 @@
 	return;
     }
 
-    save_flags (flags);
-    cli ();
+    spin_lock_irqsave(&card->lock,flags);
     /*
      * If we're not currently recording, set up the start and end registers
      * for the recording engine.
@@ -283,7 +283,7 @@
 	}
 	else {
 	    /* Not sure what else to do here.  */
-	    restore_flags (flags);
+	    spin_unlock_irqrestore(&card->lock,flags);
 	    return;
 	}
     }
@@ -303,7 +303,7 @@
 	nm256_writePort8 (card, 2, NM_RECORD_ENABLE_REG,
 			    NM_RECORD_ENABLE_FLAG | NM_RECORD_FREERUN);
 
-    restore_flags (flags);
+    spin_unlock_irqrestore(&card->lock,flags);
 }
 
 /* Stop the play engine. */
@@ -370,8 +370,7 @@
 
     card->requested_amt = amt;
 
-    save_flags (flags);
-    cli ();
+    spin_lock_irqsave(&card->lock,flags);
 
     if ((card->curPlayPos + amt) >= ringsize) {
 	u32 rem = ringsize - card->curPlayPos;
@@ -418,7 +417,7 @@
     if (! card->playing)
 	startPlay (card);
 
-    restore_flags (flags);
+    spin_unlock_irqrestore(&card->lock,flags);
 }
 
 /*  We just got a card playback interrupt; process it.  */
@@ -829,8 +828,7 @@
 
     base = card->mixer;
 
-    save_flags (flags);
-    cli ();
+    spin_lock_irqsave(&card->lock,flags);
 
     nm256_isReady (dev);
 
@@ -844,7 +842,7 @@
 
     }
 
-    restore_flags (flags);
+    spin_unlock_irqrestore(&card->lock,flags);
     udelay (1000);
 
     return ! done;
@@ -1055,6 +1053,7 @@
     card->playing  = 0;
     card->recording = 0;
     card->rev = rev;
+	spin_lock_init(&card->lock);
 
     /* Init the memory port info.  */
     for (x = 0; x < 2; x++) {

