Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWCDD6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWCDD6N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 22:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbWCDD6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 22:58:13 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:62147 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750855AbWCDD6M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 22:58:12 -0500
Subject: [-mm PATCH] time: reduced ntp rework part 2 - remove duplicate
	leapsecond code
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 19:58:09 -0800
Message-Id: <1141444689.9727.105.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andrew,
	Just wanted to sync up with you before I do a B20 release of the TOD
code. 

The reduced ntp rework patch part 2 adds a new ntp_leapsecond() which
should replace the existing leapsecond processing. However somehow the
chunk which removes the old code got dropped. Probably my fault.

Without this patch, its possible the leapsecond TIME_OOP state would not
be set for the second following a insertion.

thanks
-john


Index: mmmerge/kernel/timer.c
===================================================================
--- mmmerge.orig/kernel/timer.c
+++ mmmerge/kernel/timer.c
@@ -694,58 +694,6 @@ static void second_overflow(void)
 	}
 
 	/*
-	 * Leap second processing. If in leap-insert state at the end of the
-	 * day, the system clock is set back one second; if in leap-delete
-	 * state, the system clock is set ahead one second. The microtime()
-	 * routine or external clock driver will insure that reported time is
-	 * always monotonic. The ugly divides should be replaced.
-	 */
-	switch (time_state) {
-	case TIME_OK:
-		if (time_status & STA_INS)
-			time_state = TIME_INS;
-		else if (time_status & STA_DEL)
-			time_state = TIME_DEL;
-		break;
-	case TIME_INS:
-		if (xtime.tv_sec % 86400 == 0) {
-			xtime.tv_sec--;
-			wall_to_monotonic.tv_sec++;
-			/*
-			 * The timer interpolator will make time change
-			 * gradually instead of an immediate jump by one second
-			 */
-			time_interpolator_update(-NSEC_PER_SEC);
-			time_state = TIME_OOP;
-			clock_was_set();
-			printk(KERN_NOTICE "Clock: inserting leap second "
-					"23:59:60 UTC\n");
-		}
-		break;
-	case TIME_DEL:
-		if ((xtime.tv_sec + 1) % 86400 == 0) {
-			xtime.tv_sec++;
-			wall_to_monotonic.tv_sec--;
-			/*
-			 * Use of time interpolator for a gradual change of
-			 * time
-			 */
-			time_interpolator_update(NSEC_PER_SEC);
-			time_state = TIME_WAIT;
-			clock_was_set();
-			printk(KERN_NOTICE "Clock: deleting leap second "
-					"23:59:59 UTC\n");
-		}
-		break;
-	case TIME_OOP:
-		time_state = TIME_WAIT;
-		break;
-	case TIME_WAIT:
-		if (!(time_status & (STA_INS | STA_DEL)))
-		time_state = TIME_OK;
-	}
-
-	/*
 	 * Compute the phase adjustment for the next second. In PLL mode, the
 	 * offset is reduced by a fixed factor times the time constant. In FLL
 	 * mode the offset is used directly. In either mode, the maximum phase




