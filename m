Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319380AbSH2Wgr>; Thu, 29 Aug 2002 18:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319371AbSH2Wfq>; Thu, 29 Aug 2002 18:35:46 -0400
Received: from smtpout.mac.com ([204.179.120.88]:22520 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319356AbSH2Vvd>;
	Thu, 29 Aug 2002 17:51:33 -0400
Message-Id: <200208292155.g7TLtuZH003796@smtp-relay02.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 16/41 sound/oss/v_midi.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/v_midi.c	Sat Apr 20 18:25:21 2002
+++ linux-2.5-cli-oss/sound/oss/v_midi.c	Tue Aug 13 16:00:57 2002
@@ -21,7 +21,7 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
-
+#include <linux/spinlock.h>
 #include "sound_config.h"
 
 #include "v_midi.h"
@@ -52,15 +52,14 @@
 	if (devc == NULL)
 		return -(ENXIO);
 
-	save_flags (flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 	if (devc->opened)
 	{
-		restore_flags (flags);
+		spin_unlock_irqrestore(&devc->lock,flags);
 		return -(EBUSY);
 	}
 	devc->opened = 1;
-	restore_flags (flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 
 	devc->intr_active = 1;
 
@@ -81,12 +80,11 @@
 	if (devc == NULL)
 		return;
 
-	save_flags (flags);
-	cli ();
+	spin_lock_irqsave(&devc->lock,flags);
 	devc->intr_active = 0;
 	devc->input_opened = 0;
 	devc->opened = 0;
-	restore_flags (flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 static int v_midi_out (int dev, unsigned char midi_byte)
@@ -222,6 +220,7 @@
 	v_devc[0]->opened = v_devc[0]->input_opened = 0;
 	v_devc[0]->intr_active = 0;
 	v_devc[0]->midi_input_intr = NULL;
+	spin_lock_init(&v_devc[0]->lock);
 
 	midi_devs[midi1]->devc = v_devc[0];
 
@@ -242,6 +241,7 @@
 	v_devc[1]->opened = v_devc[1]->input_opened = 0;
 	v_devc[1]->intr_active = 0;
 	v_devc[1]->midi_input_intr = NULL;
+	spin_lock_init(&v_devc[1]->lock);
 
 	midi_devs[midi2]->devc = v_devc[1];
 	midi_devs[midi2]->converter = &m->s_ops[1];

