Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTKCWdS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 17:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbTKCWdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 17:33:18 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:29938 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261957AbTKCWdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 17:33:16 -0500
Subject: [RFC][PATCH] linux-2.4.23-pre9_cyclone-lpj-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: marcelo <marcelo.tosatti@cyclades.com.br>, andrea <andrea@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1067898667.11436.43.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 Nov 2003 14:31:07 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, All,
	In working to resolve an issue in SLES8 SP3, Andrea caught a bug in the
cyclone counter's lost-tick compensation code. In the code, we use the
calibrated loops_per_jiffies to detect the number of ticks that have
passed, however the lost-ticks code begins running before
loops_per_jiffies is calculated. This circular dependency that can cause
loops_per_jiffies to be occasionally mis-calculated.

The fix drops use of loops_per_jiffies and uses code from 2.5 to do the
same thing. This patch only affects x440/x445 machines.

Many thanks for Andrea for catching this. 

Any comments and feedback on the patch is welcome. 

thanks
-john

diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Mon Nov  3 13:47:16 2003
+++ b/arch/i386/kernel/time.c	Mon Nov  3 13:47:16 2003
@@ -279,6 +279,7 @@
 static inline void mark_timeoffset_cyclone(void)
 {
 	int count;
+	unsigned long lost;
 	unsigned long delta = last_cyclone_timer;
 	spin_lock(&i8253_lock);
 	/* quickly read the cyclone timer */
@@ -293,11 +294,12 @@
 	spin_unlock(&i8253_lock);
 
 	/*lost tick compensation*/
-	delta = last_cyclone_timer - delta;
-	if(delta > loops_per_jiffy+2000){
-		delta = (delta/loops_per_jiffy)-1;
-		jiffies += delta;
-	}
+	delta = last_cyclone_timer - delta;	
+	delta /= (CYCLONE_TIMER_FREQ/1000000);
+	delta += delay_at_last_interrupt;
+	lost = delta/(1000000/HZ);
+	if (lost >= 2)
+		jiffies += lost-1;
                
 	count = ((LATCH-1) - count) * TICK_SIZE;
 	delay_at_last_interrupt = (count + LATCH/2) / LATCH;



