Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273842AbRIXJtS>; Mon, 24 Sep 2001 05:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273850AbRIXJtI>; Mon, 24 Sep 2001 05:49:08 -0400
Received: from mail2.svr.pol.co.uk ([195.92.193.210]:20038 "EHLO
	mail2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S273842AbRIXJs5>; Mon, 24 Sep 2001 05:48:57 -0400
Date: Mon, 24 Sep 2001 10:49:16 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Subject: [PATCH] Race fix for MIDI, take 2
Message-ID: <20010924104916.A21653@gallimaufry.freeserve.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's my second go at a race fix for drivers/sound/midibuf.c.  Given how
unreliable it was before, I wonder if I was the only person using it.

Please apply.

- Adrian

--- 1.1/drivers/sound/midibuf.c	Sat Jan  6 07:28:25 2001
+++ 1.3/drivers/sound/midibuf.c	Mon Sep 24 10:30:28 2001
@@ -253,13 +253,13 @@
 
 	midi_devs[dev]->close(dev);
 
+	open_devs--;
+	if (open_devs == 0)
+		del_timer_sync(&poll_timer);
 	vfree(midi_in_buf[dev]);
 	vfree(midi_out_buf[dev]);
 	midi_in_buf[dev] = NULL;
 	midi_out_buf[dev] = NULL;
-	if (open_devs < 2)
-		del_timer(&poll_timer);;
-	open_devs--;
 
 	if (midi_devs[dev]->owner)
 		__MOD_DEC_USE_COUNT (midi_devs[dev]->owner);
