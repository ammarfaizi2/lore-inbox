Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318718AbSHAMEb>; Thu, 1 Aug 2002 08:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318719AbSHAMEb>; Thu, 1 Aug 2002 08:04:31 -0400
Received: from [195.39.17.254] ([195.39.17.254]:9600 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318718AbSHAMEa>;
	Thu, 1 Aug 2002 08:04:30 -0400
Date: Thu, 1 Aug 2002 12:39:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: Vojtech pointed error in usb/hub.c
Message-ID: <20020801103957.GA128@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

We do not want threads exiting because of suspend, so refrigerator
should be just before test for signals pending (so it has chance to
kill them).

								Pavel

--- clean/drivers/usb/core/hub.c	Wed Jul 24 17:54:21 2002
+++ linux-swsusp/drivers/usb/core/hub.c	Tue Jul 30 21:28:49 2002
@@ -1059,9 +1059,9 @@
 	/* Send me a signal to get me die (for debugging) */
 	do {
 		usb_hub_events();
+		wait_event_interruptible(khubd_wait, !list_empty(&hub_event_list)); 
 		if (current->flags & PF_FREEZE)
 			refrigerator(PF_IOTHREAD);
-		wait_event_interruptible(khubd_wait, !list_empty(&hub_event_list)); 
 	} while (!signal_pending(current));
 
 	dbg("usb_hub_thread exiting");

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
