Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277048AbRJNTVI>; Sun, 14 Oct 2001 15:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277041AbRJNTU7>; Sun, 14 Oct 2001 15:20:59 -0400
Received: from hermes.toad.net ([162.33.130.251]:1432 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S276990AbRJNTUq>;
	Sun, 14 Oct 2001 15:20:46 -0400
Subject: APM driver thoughts
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 14 Oct 2001 15:20:28 -0400
Message-Id: <1003087230.1124.39.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These thoughts are directed mainly at Alan, since he's
been into the APM driver code recently.  

0) The APM driver is, I take it, not supposed to be SMP safe or
   reentrant.  So all those global variables are okay, right?

1) I append a minor patch that moves one static global variable,
"waiting_for_resume", inside the check_events() function
where it belongs.  (This variable indicates that a suspend has
been received and is being processed, so further suspends
should be silently ignored.)

2) I wonder about another global variable, "ignore_normal_resume".
This gets set when suspend() is called.  The reason for setting
it seems to be that suspend() itself sends (to PM) and queues
(to users) a NORMAL_RESUME event after it returns from the
apm_set_power_state(APM_STATE_SUSPEND) call; so the subsequent
NORMAL_RESUME event from the BIOS (which the driver anticipates)
should be ignored.

The way the code is written now, ignore_normal_resume is cleared
when an event other than NORMAL_RESUME is received.  That means
that the driver will ignore any number of NORMAL_RESUME events
immediately after a suspend, but accept any number of such
events after it receives something other than NORMAL_RESUME
from the BIOS.

This does not behave correctly on my ThinkPad 600.  What
sometimes happens is that after a resume the BIOS sends
a POWER_STATUS_CHANGE event first, then a RESUME event.
The P_S_C event clears the ignore_normal_resume flag,
so I end up with two RESUME events.  I think the driver
should at least ignore the first RESUME event after a
suspend whether or not other events precede it.

On the other hand, I wonder whether we really want to
ignore repeated resume events.  If we do, then the
simple thing to do is to ignore _all_ RESUME events,
except _one_ following a standby().  That is, initialize
the ignore_normal_resume flag to 1, clear it in standby()
and set it again in the RESUME handler and in suspend()
(which generates its own pseudo RESUME event).  That way,
the driver will reject all but the first RESUME that
occurs after a STANDBY.

3) Should the "ignore_normal_resume = 1;" in suspend()
be put before the sti()?  That is, can the function be
interrupted after the sti() and scheduled out, and 
check_events() scheduled in, so that it checks
ignore_normal_resume before suspend() sets it to 1?

Here's the patch to move the variable definition mentioned
earlier.  It's harmless, provided static variables are
initialized to zero when they're defined inside functions.

--- linux-2.4.10-ac12/arch/i386/kernel/apm.c	Thu Oct 11 21:56:08 2001
+++ linux-2.4.10-ac12-fix/arch/i386/kernel/apm.c	Sun Oct 14 15:04:42 2001
@@ -334,11 +334,10 @@
 #ifdef CONFIG_APM_CPU_IDLE
 static int			clock_slowed;
 #endif
 static int			suspends_pending;
 static int			standbys_pending;
-static int			waiting_for_resume;
 static int			ignore_normal_resume;
 static int			bounce_interval = DEFAULT_BOUNCE_INTERVAL;
 
 #ifdef CONFIG_APM_RTC_IS_GMT
 #	define	clock_cmos_diff	0
@@ -1015,10 +1014,11 @@
 static void check_events(void)
 {
 	apm_event_t		event;
 	static unsigned long	last_resume;
 	static int		ignore_bounce;
+	static int		waiting_for_resume;
 
 	while ((event = get_event()) != 0) {
 		if (debug) {
 			if (event <= NR_APM_EVENT_NAME)
 				printk(KERN_DEBUG "apm: received %s notify\n",



