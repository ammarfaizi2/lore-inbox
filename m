Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422982AbWJFVjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422982AbWJFVjH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 17:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422983AbWJFVjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 17:39:07 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:17641 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422982AbWJFVjE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 17:39:04 -0400
Subject: [RFC] Avoid PIT SMP lockups
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: =?UTF-8?Q?S=2E=C3=87a=C4=9Flar?= Onur <caglar@pardus.org.tr>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Oct 2006 14:38:56 -0700
Message-Id: <1160170736.6140.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andi,
	Mind testing this patch on the AMD SMP box you were using earlier w/
acpi=off? I have spent a bit of time trying to hunt down the cause of
the reported SMP boxes hanging when they use the PIT for a clocksource,
and have not been able to root cause it. Removing the first three PIT io
instructions from pit_read() seemed to avoid the issue, but I can't see
why.

My current theory is that we're livelocking somehow:

timer_interrupt:
	seq_write_lock_irqsave(xtime_lock)
	spin_lock_irqsave(i8253_lock)
	portio()
	spin_unlock_irqrestore(i8253_lock)
	seq_write_unlock_irqrestore(xtime_lock)

gettime:
	do {
		seq = read_seqbegin(xtime_lock)
		spin_lock_irqsave(i8253_lock)
		portio()
		spin_unlock_irqrestore(i8253_lock)
	} while (read_seqretry(&xtime_lock, seq))


Where maybe one cpu is running gettime, spinning like mad grabbing and
releasing the i8253_lock, while another cpu is in the timer_interrupt
thread already holding the xtime lock, trying to grab the i8253_lock.

Yea.. its a weak theory (and sysrq-t output doesn't support it)... Don't
have a clue otherwise though. Your thoughts? 

Anyway, since I can't figure it out, this patch should avoid the issue,
by disabling the PIT on SMP boxes (and makes a minor change so we
properly fall back to jiffies if the TSC is bad and there's nothing
else).

S.Çağlar: Could you give it a whirl to see if it changes your vmware
issue?

thanks
-john




This patch avoids possible PIT livelock issues seen on SMP systems, by
not allowing it as a clocksource on SMP boxes.

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


