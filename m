Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273137AbRIUKEH>; Fri, 21 Sep 2001 06:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273213AbRIUKD5>; Fri, 21 Sep 2001 06:03:57 -0400
Received: from mail4.svr.pol.co.uk ([195.92.193.211]:49694 "EHLO
	mail4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S273137AbRIUKDr>; Fri, 21 Sep 2001 06:03:47 -0400
Date: Fri, 21 Sep 2001 11:04:10 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
To: linux-kernel@vger.kernel.org
Cc: sailer@scs.ch
Subject: [PATCH] Midi close race
Message-ID: <20010921110410.B17701@gallimaufry.freeserve.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes a race condition when closing the MIDI input device. The
previous code left the timer running while freeing buffers used by the timer
routine, leading to frequent OOPSes. Thomas: you seem to have been the last
person to touch this file. Any comments?

--- 1.1/drivers/sound/midibuf.c	Sat Jan  6 07:28:25 2001
+++ 1.2/drivers/sound/midibuf.c	Thu Jun 14 16:33:40 2001
@@ -253,13 +253,13 @@
 
 	midi_devs[dev]->close(dev);
 
+	if (open_devs < 2)
+		del_timer(&poll_timer);
+	open_devs--;
 	vfree(midi_in_buf[dev]);
 	vfree(midi_out_buf[dev]);
 	midi_in_buf[dev] = NULL;
 	midi_out_buf[dev] = NULL;
-	if (open_devs < 2)
-		del_timer(&poll_timer);;
-	open_devs--;
 
 	if (midi_devs[dev]->owner)
 		__MOD_DEC_USE_COUNT (midi_devs[dev]->owner);
