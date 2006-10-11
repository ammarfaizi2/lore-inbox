Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161189AbWJKTy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161189AbWJKTy0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbWJKTy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:54:26 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:16297 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161189AbWJKTyZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:54:25 -0400
Subject: [PATCH] i386 Time: Avoid PIT SMP lockups
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 12:54:21 -0700
Message-Id: <1160596462.5973.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew: I think this is 2.6.19 material, but probably should go through an -mm or two.

thanks
-john


This patch avoids possible PIT livelock issues seen on SMP systems (and
reported by Andi), by not allowing it as a clocksource on SMP boxes.

However, since the PIT may no longer be present, we have to properly
handle the cases where SMP systems have TSC skew and fall back from the
TSC. Since the PIT isn't there, it would "fall back" to the TSC again.
So this changes the jiffies rating to 1, and the TSC-bad rating value to
0.

Thus you will get the following behavior priority on i386 systems:

tsc		[if present & stable]
hpet		[if present]
cyclone		[if present]
acpi_pm		[if present]
pit		[if UP]
jiffies

Rather then the current more complicated:
tsc		[if present & stable]
hpet		[if present]
cyclone		[if present]
acpi_pm		[if present]
pit		[if cpus < 4]
tsc		[if present & unstable]
jiffies

Signed-off-by: John Stultz <johnstul@us.ibm.com>

diff --git a/arch/i386/kernel/i8253.c b/arch/i386/kernel/i8253.c
index 477b24d..9a0060b 100644
--- a/arch/i386/kernel/i8253.c
+++ b/arch/i386/kernel/i8253.c
@@ -109,7 +109,7 @@ static struct clocksource clocksource_pi
 
 static int __init init_pit_clocksource(void)
 {
-	if (num_possible_cpus() > 4) /* PIT does not scale! */
+	if (num_possible_cpus() > 1) /* PIT does not scale! */
 		return 0;
 
 	clocksource_pit.mult = clocksource_hz2mult(CLOCK_TICK_RATE, 20);
diff --git a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
index b8fa0a8..fbc9582 100644
--- a/arch/i386/kernel/tsc.c
+++ b/arch/i386/kernel/tsc.c
@@ -349,8 +349,8 @@ static int tsc_update_callback(void)
 	int change = 0;
 
 	/* check to see if we should switch to the safe clocksource: */
-	if (clocksource_tsc.rating != 50 && check_tsc_unstable()) {
-		clocksource_tsc.rating = 50;
+	if (clocksource_tsc.rating != 0 && check_tsc_unstable()) {
+		clocksource_tsc.rating = 0;
 		clocksource_reselect();
 		change = 1;
 	}
@@ -461,7 +461,7 @@ static int __init init_tsc_clocksource(v
 							clocksource_tsc.shift);
 		/* lower the rating if we already know its unstable: */
 		if (check_tsc_unstable())
-			clocksource_tsc.rating = 50;
+			clocksource_tsc.rating = 0;
 
 		init_timer(&verify_tsc_freq_timer);
 		verify_tsc_freq_timer.function = verify_tsc_freq;
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 126bb30..a99b2a6 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -57,7 +57,7 @@ static cycle_t jiffies_read(void)
 
 struct clocksource clocksource_jiffies = {
 	.name		= "jiffies",
-	.rating		= 0, /* lowest rating*/
+	.rating		= 1, /* lowest valid rating*/
 	.read		= jiffies_read,
 	.mask		= 0xffffffff, /*32bits*/
 	.mult		= NSEC_PER_JIFFY << JIFFIES_SHIFT, /* details above */


