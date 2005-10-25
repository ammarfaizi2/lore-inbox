Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbVJYWQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVJYWQO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVJYWQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:16:14 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:13267 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932443AbVJYWQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:16:13 -0400
Subject: ktimers in RT causing bad bogomips and more.
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 25 Oct 2005 18:15:41 -0400
Message-Id: <1130278541.21118.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

A colleague of mine at my customer site (also named Thomas), noticed
that the Bogomips of Ingo's kernel did not match the Bogomips of the
2.6.14-rc5 kernel.  I had other problems at the time to take a look, but
my machine at home is showing weirdness that was seen on that machine
the other Thomas had.  So I started taking a look into the cause for the
differences in the bogomips.

Well, you seem to have the jiffies running wild.  At least for start up.

First, lets take a look at where jiffies is incremented.  That's done by
do_timer, which is called in clockevents.c by handle_tick,
handle_tick_update and handle_tick_update_profile.  So when any of these
functions are called, jiffies is incremented. Is that expected?

This gets even more complex, since handle_tick is called by
handle_next_event_tick, handle_next_event_tick_update and
handle_next_event_all.

Now these functions call handle_tick several times, determined by the
value returned by ktimer_interrupt. 

For example:

static void handle_nextevent_tick(struct pt_regs *regs)
{
	int res;

	res = ktimer_interrupt();
	for (; res > 0; res--)
		handle_tick(regs);
}

Now looking at ktimer_interrupt, the beginning looks like this:

int ktimer_interrupt(void)
{
	struct ktimer_base *base;
	ktime_t expires_next, now;
	int i, raise = 0, ret = 0;
	int cpu = smp_processor_id();
	struct ktimer_hres *hres = &per_cpu(ktimer_hres, cpu);

	/* As long as we did not switch over to high resolution mode
	 * we expect, that the event source is running in periodic
	 * mode when it is a source serving other (tick based)
	 * functionality than next event
	 *
	 */
	if (!hres->active)
		return CLOCK_EVT_RUN_CYCLIC;

Is it really expected to call handle_ticks CLOCK_EVT_RUN_CYCLIC
times? :-)  I don't think so (It's seven BTW).

So, I figured the following patch might be in order. Thomas, what do you
think?

It at least makes my bogomips go back to 736.41 from 74.27 :-)

-- Steve

Index: rt_linux_ernie/kernel/ktimers.c
===================================================================
--- rt_linux_ernie.orig/kernel/ktimers.c	2005-10-25 08:49:42.000000000 -0400
+++ rt_linux_ernie/kernel/ktimers.c	2005-10-25 18:03:21.000000000 -0400
@@ -341,7 +341,7 @@
 	 *
 	 */
 	if (!hres->active)
-		return CLOCK_EVT_RUN_CYCLIC;
+		return -CLOCK_EVT_RUN_CYCLIC;
 
 	now = do_ktime_get();
 
Index: rt_linux_ernie/kernel/time/clockevents.c
===================================================================
--- rt_linux_ernie.orig/kernel/time/clockevents.c	2005-10-25 18:02:33.000000000 -0400
+++ rt_linux_ernie/kernel/time/clockevents.c	2005-10-25 18:07:07.000000000 -0400
@@ -167,6 +167,10 @@
 	int res;
 
 	res = ktimer_interrupt();
+
+	if (res == -CLOCK_EVT_RUN_CYCLIC)
+		res = 1;
+
 	for (; res > 0; res--)
 		handle_tick(regs);
 }
@@ -190,6 +194,9 @@
 	if ((res = ktimer_interrupt()) == 0)
 		return;
 
+	if (res == -CLOCK_EVT_RUN_CYCLIC)
+		res = 1;
+
 	for (; res > 0; res--)
 		handle_tick(regs);
 
@@ -224,6 +231,9 @@
 	if ((res = ktimer_interrupt()) == 0)
 		return;
 
+	if (res == -CLOCK_EVT_RUN_CYCLIC)
+		res = 1;
+
 	for (; res > 0; res--)
 		handle_tick(regs);
 

Either the above patch, or just have ktimer_interrupt return 1.  But I
figured that you want to differentiate this. But maybe not.

