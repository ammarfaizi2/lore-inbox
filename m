Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265931AbTF3WVS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 18:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbTF3WVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 18:21:18 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:13038 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265931AbTF3WVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 18:21:09 -0400
Subject: [PATCH SET - 3/3] linux-2.5.73_lost-tick-corner-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1057011938.28320.345.camel@w-jstultz2.beaverton.ibm.com>
References: <1057011774.28320.340.camel@w-jstultz2.beaverton.ibm.com>
	 <1057011840.28319.342.camel@w-jstultz2.beaverton.ibm.com>
	 <1057011938.28320.345.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1057011983.28312.347.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Jun 2003 15:26:23 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This patch catches a corner case in the lost-tick compensation code.
There is a check to see if we overflowed between reads of the two time
sources, however should the high res time source be slightly slower then
what we calibrated, its possible to trigger this code when no ticks have
been lost. This patch adds an extra check to insure we have seen more
then one tick before we check for this overflow.  This seems to resolve
the remaining "time doubling" issues that I've seen reported. This patch
applies ontop of lost-tick-speedstep-fix_A1.

Please consider for inclusion in your tree.

thanks
-john

 timer_cyclone.c |    2 +-
 timer_tsc.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Mon Jun 30 13:53:56 2003
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Mon Jun 30 13:53:56 2003
@@ -88,7 +88,7 @@
 	 * between cyclone and pit reads (as noted when 
 	 * usec delta is > 90% # of usecs/tick)
 	 */
-	if (abs(delay - delay_at_last_interrupt) > (900000/HZ)) 
+	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ)) 
 		jiffies++;
 }
 
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Mon Jun 30 13:53:56 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Mon Jun 30 13:53:56 2003
@@ -205,7 +205,7 @@
 	 * between tsc and pit reads (as noted when 
 	 * usec delta is > 90% # of usecs/tick)
 	 */
-	if (abs(delay - delay_at_last_interrupt) > (900000/HZ))
+	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
 		jiffies++;
 }
 



