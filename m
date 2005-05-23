Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVEWXf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVEWXf7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVEWXdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:33:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:27526 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261238AbVEWX1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:27:55 -0400
Date: Mon, 23 May 2005 16:27:14 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, gjasny@web.de,
       annabellesgarden@yahoo.de
Subject: [patch 10/16] usbusx2y: prevent oops & dead keyboard on usb unplugging
Message-ID: <20050523232714.GV27549@shell0.pdx.osdl.net>
References: <20050523231529.GL27549@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523231529.GL27549@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: prevent oops & dead keyboard on usb unplugging while the device is being used

Without this patch, some usb kobjects, which are parents to
the usx2y's kobjects can be freed before the usx2y's.
This led to an oops in get_kobj_path_length() and a dead
keyboard, when the usx2y's kobjects were freed.
The patch ensures the correct sequence.
Tested ok on kernel 2.6.12-rc2.

Present in ALSA cvs

Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 sound/usb/usx2y/usbusx2y.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

--- linux-2.6.11.10.orig/sound/usb/usx2y/usbusx2y.c	2005-05-16 10:52:18.000000000 -0700
+++ linux-2.6.11.10/sound/usb/usx2y/usbusx2y.c	2005-05-20 09:36:42.067778552 -0700
@@ -1,6 +1,11 @@
 /*
  * usbusy2y.c - ALSA USB US-428 Driver
  *
+2005-04-14 Karsten Wiese
+	Version 0.8.7.2:
+	Call snd_card_free() instead of snd_card_free_in_thread() to prevent oops with dead keyboard symptom.
+	Tested ok with kernel 2.6.12-rc2.
+
 2004-12-14 Karsten Wiese
 	Version 0.8.7.1:
 	snd_pcm_open for rawusb pcm-devices now returns -EBUSY if called without rawusb's hwdep device being open.
@@ -143,7 +148,7 @@
 
 
 MODULE_AUTHOR("Karsten Wiese <annabellesgarden@yahoo.de>");
-MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.8.7.1");
+MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.8.7.2");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{TASCAM(0x1604), "NAME_ALLCAPS"(0x8001)(0x8005)(0x8007) }}");
 
@@ -430,8 +435,6 @@
 	if (ptr) {
 		usX2Ydev_t* usX2Y = usX2Y((snd_card_t*)ptr);
 		struct list_head* p;
-		if (usX2Y->chip_status == USX2Y_STAT_CHIP_HUP)	// on 2.6.1 kernel snd_usbmidi_disconnect()
-			return;					// calls us back. better leave :-) .
 		usX2Y->chip.shutdown = 1;
 		usX2Y->chip_status = USX2Y_STAT_CHIP_HUP;
 		usX2Y_unlinkSeq(&usX2Y->AS04);
@@ -443,7 +446,7 @@
 		}
 		if (usX2Y->us428ctls_sharedmem) 
 			wake_up(&usX2Y->us428ctls_wait_queue_head);
-		snd_card_free_in_thread((snd_card_t*)ptr);
+		snd_card_free((snd_card_t*)ptr);
 	}
 }
 
