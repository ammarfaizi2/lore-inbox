Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314655AbSDTQhw>; Sat, 20 Apr 2002 12:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314656AbSDTQhv>; Sat, 20 Apr 2002 12:37:51 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:28304 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314655AbSDTQht>; Sat, 20 Apr 2002 12:37:49 -0400
Date: Sat, 20 Apr 2002 18:31:59 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix console initialization deadlock for x86-64
Message-ID: <20020420183159.A22349@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When vt_init happens to run before the keyboard is initialized (the order is random
because they're both different initcalls) then set_leds raises an not yet enabled
tasklet. This causes an endless loop on the first schedule() call because the tasklet
handling cannot handle raised but disabled tasklets.

This patch just does not do set_leds in virtual terminal initialization to avoid that.
It is done later anyways. 

Patch for 2.5.8 

-Andi


diff -X ../../KDIFX -x *-o -x *-RESERVE -burpN ../../v2.5/linux/drivers/char/console.c linux/drivers/char/console.c
--- ../../v2.5/linux/drivers/char/console.c	Wed Jan 30 22:38:01 2002
+++ linux/drivers/char/console.c	Thu Apr 18 17:32:23 2002
@@ -1420,7 +1420,8 @@ static void reset_terminal(int currcons,
 	kbd_table[currcons].slockstate = 0;
 	kbd_table[currcons].ledmode = LED_SHOW_FLAGS;
 	kbd_table[currcons].ledflagstate = kbd_table[currcons].default_ledflagstate;
-	set_leds();
+	/* do not do set_leds here because this causes an endless tasklet loop
+	   when the keyboard hasn't been initialized yet */
 
 	cursor_type = CUR_DEFAULT;
 	complement_mask = s_complement_mask;
