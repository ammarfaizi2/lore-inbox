Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWIJJQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWIJJQq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 05:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWIJJQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 05:16:45 -0400
Received: from md2.t-2.net ([84.255.209.71]:33325 "EHLO md2.t-2.net")
	by vger.kernel.org with ESMTP id S1751391AbWIIVi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 17:38:26 -0400
Subject: LTT patch for 2.6.17.4
From: Samo Pogacnik <samo_pogacnik@t-2.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 09 Sep 2006 23:47:38 +0200
Message-Id: <1157838458.10878.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Junkmail-Status: score=10/50, host=md2.t-2.net
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A090202.450332BB.000B,ss=1,fgs=0,
	ip=84.255.254.67,
	so=2006-03-30 10:46:40,
	dmn=5.2.113/2006-07-26
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are LTT patch and tools for the 2.6.17.4 kernel. There are no
major feature changes beside adaptations implied by kernel change. 
The same goes for possible bugs and usability.

Patch URL: http://84.255.254.67/ltt-linux-2.6.17.4.patch
Tools URL: http://84.255.254.67/ltt-0.9.6-pre6.tar.gz

Additionally to the 2.6.16 LTT functionality (see below) the
following changes have been made to enable LTT on 2.6.17.4 kernel:

1. Use of the relay feature over the debugfs filesystem, since the
relayfs as separate filesystem has been abandoned in next versions.

2. Modification of the ltt target tools to look for the debugfs if 
relayfs mount could not be found.

3. Hopefully solved deadlock situation, caused by collecting
LTT_EV_PROCESS event through wake_up_process() called within timer
interrupt context, where xtime structure has been protected by write
sequential lock. Solution enables readers to get xtime values (i.e.
via do_gettimeofday) during this specific wake_up_process() call. On
the other hand writers can not access xtime structure at that time,
since write_seqcount_begin() and write_seqcount_end() functions do
not touch the associated spinlock.
This could also be the solution, how to avoid deadlocks within
different protected sections, where reading xtime correctly is
needed.

LTT example:
------------
diff -Nurp linux-2.6.17.4/kernel/softlockup.c ltt-linux-2.6.17.4/kernel/softlockup.c
--- linux-2.6.17.4/kernel/softlockup.c  2006-07-07 22:52:01.000000000 +0200
+++ ltt-linux-2.6.17.4/kernel/softlockup.c      2006-09-0722:19:15.000000000 +0200
@@ -62,8 +62,17 @@ void softlockup_tick(void)
        }

        /* Wake up the high-prio watchdog task every second: */
-       if (time_after(jiffies, touch_timestamp + HZ))
+       if (time_after(jiffies, touch_timestamp + HZ)) {
+               /* Added to enable timestamping via do_gettimeofday(), which deadlocks
+                * here because of already taken write_seqlock within timer interrupt.
+                */
+               write_seqcount_begin((seqcount_t *)&(xtime_lock.sequence));
                wake_up_process(per_cpu(watchdog_task, this_cpu));
+               /* Added to disable timestamping via do_gettimeofday(), which deadlocks
+                * because of already taken write_seqlock.
+                */
+               write_seqcount_end((seqcount_t *)&(xtime_lock.sequence));
+       }

        /* Warn about unreasonable 10+ seconds delays: */
        if (time_after(jiffies, touch_timestamp + 10*HZ)) {
------------

4. Corrected time stamping header, which included wrong header for
generic time stamping.

------------------------------

linux-2.6.16 LTT functionality:

1. Current patch only supports i386 architecture specifics, since I
wanted to limit the area of needed modifications and I would like to
explore if it is sensible to remove all those spreaded trace points
around the kernel by using different mechanism. Anyway, at current state
other architectures should not be to difficult to add, by adjusting
arcitecture specifics of the 2.6.9 ltt kernel patch, for example.

2. Locking and lockless options of the tracedaemon tool result in the
same operation within the kernel, except for the different startup
requirements mostly enforced by original tracedaemon. Basicaly subbuffer
switches (together with writing start buffer and end buffer events) and
subbuffer space reservation for each event are being hopefully protected
with a spinlock.

3. Multiple starting and stopping of collecting events has been
protected and synchronised via an extra semaphore.

4. Timestamping works via gettimaofday (defined as generic) and via TSC
counter on i386 (defined as arch specific). This functionality was
collected in separate files, that can be patched and used separately
from ltt.

5. Works in either tracer (tracedaemon running for the time duration
specified - no subbuffer overwrite) or flight recorder (tracedaemon run
just to collect current buffer content of circular subbuffers -
overwrite relayfs operation) tracing mode.

6. Only one tracer started at once.

7. SMP - per cpu files need to be checked and cleaned.

8. Both tracer and flight recorder modes collect all events by default.

9. Custom events could be seen in both tracing modes.


regards, Samo





