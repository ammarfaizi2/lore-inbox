Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWBPBRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWBPBRv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 20:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWBPBRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 20:17:51 -0500
Received: from ozlabs.org ([203.10.76.45]:4016 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932222AbWBPBRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 20:17:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17395.53939.795908.336324@cargo.ozlabs.ibm.com>
Date: Thu, 16 Feb 2006 12:17:39 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org, akpm@osdl.org
CC: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: [PATCH] Provide an interface for getting the current tick length
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This provides an interface for arch code to find out how many
nanoseconds are going to be added on to xtime by the next call to
do_timer.  The value returned is a fixed-point number in 52.12 format
in nanoseconds.  The reason for this format is that it gives the
full precision that the timekeeping code is using internally.

The motivation for this is to fix a problem that has arisen on 32-bit
powerpc in that the value returned by do_gettimeofday drifts apart
from xtime if NTP is being used.  PowerPC is now using a lockless
do_gettimeofday based on reading the timebase register and performing
some simple arithmetic.  (This method of getting the time is also
exported to userspace via the VDSO.)  However, the factor and offset
it uses were calculated based on the nominal tick length and weren't
being adjusted when NTP varied the tick length.

Note that 64-bit powerpc has had the lockless do_gettimeofday for a
long time now.  It also had an extremely hairy routine that got called
from the 32-bit compat routine for adjtimex, which adjusted the
factor and offset according to what it thought the timekeeping code
was going to do.  Not only was this only called if a 32-bit task did
adjtimex (i.e. not if a 64-bit task did adjtimex), it was also
duplicating computations from kernel/timer.c and it wasn't clear that
it was (still) correct.

The simple solution is to ask the timekeeping code how long the
current jiffy will be on each timer interrupt, after calling
do_timer.  If this jiffy will be a different length from the last one,
we then need to compute new values for the factor and offset used in
the lockless do_gettimeofday.  In this way we can keep xtime and
do_gettimeofday in sync, even when NTP is varying the tick length.

Note that when adjtimex varies the tick length, it almost always
introduces the variation from the next tick on.  The only case I could
see where adjtimex would vary the length of the current tick is when
an old-style adjtime adjustment is being cancelled.  (It's not clear
to me why the adjustment has to be cancelled immediately rather than
from the next tick on.)  Thus I don't see any real need for a hook in
adjtimex; the rare case of an old-style adjustment being cancelled can
be fixed up at the next tick.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
Linus, Andrew:

This is the generic part of a patch that I posted recently in response
to reports of a regression on 32-bit powerpc, where xtime and
gettimeofday were getting out of sync.  I want this to go into 2.6.16
so that I can then put in the powerpc-specific part of the patch and
fix the regression.  This will also let me remove the extremely hairy
ppc_adjtimex routine from arch/powerpc/kernel/time.c, which nobody on
the planet really understands (except possibly one person in IBM
Rochester :).

This patch doesn't affect other architectures at all, so I think it
should be safe to put in.

diff -urN linux-2.6/include/linux/timex.h ntpfix/include/linux/timex.h
--- linux-2.6/include/linux/timex.h	2005-10-31 13:10:39.000000000 +1100
+++ ntpfix/include/linux/timex.h	2006-02-13 15:07:52.000000000 +1100
@@ -345,6 +345,9 @@
 
 #endif /* !CONFIG_TIME_INTERPOLATION */
 
+/* Returns how long ticks are at present, in ns / 2^(SHIFT_SCALE-10). */
+extern u64 current_tick_length(void);
+
 #endif /* KERNEL */
 
 #endif /* LINUX_TIMEX_H */
diff -urN linux-2.6/kernel/timer.c ntpfix/kernel/timer.c
--- linux-2.6/kernel/timer.c	2006-02-09 11:39:05.000000000 +1100
+++ ntpfix/kernel/timer.c	2006-02-13 15:07:54.000000000 +1100
@@ -759,6 +759,30 @@
 }
 
 /*
+ * Return how long ticks are at the moment, that is, how much time
+ * update_wall_time_one_tick will add to xtime next time we call it
+ * (assuming no calls to do_adjtimex in the meantime).
+ * The return value is in fixed-point nanoseconds with SHIFT_SCALE-10
+ * bits to the right of the binary point.
+ * This function has no side-effects.
+ */
+u64 current_tick_length(void)
+{
+	long time_adjust_step, delta_nsec;
+
+	if ((time_adjust_step = time_adjust) != 0 ) {
+		/*
+		 * Limit the amount of the step to be in the range
+		 * -tickadj .. +tickadj
+		 */
+		time_adjust_step = min(time_adjust_step, (long)tickadj);
+		time_adjust_step = max(time_adjust_step, (long)-tickadj);
+	}
+	delta_nsec = tick_nsec + time_adjust_step * 1000;
+	return ((u64) delta_nsec << (SHIFT_SCALE - 10)) + time_adj;
+}
+
+/*
  * Using a loop looks inefficient, but "ticks" is
  * usually just one (we shouldn't be losing ticks,
  * we're doing this this way mainly for interrupt
