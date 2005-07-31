Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVGaRD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVGaRD0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 13:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVGaRDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 13:03:25 -0400
Received: from mailhub.hp.com ([192.151.27.10]:38318 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S261836AbVGaRDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 13:03:13 -0400
Subject: Re: long delays (possibly infinite) in
	time_interpolator_get_counter
From: Alex Williamson <alex.williamson@hp.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0507301105120.25104@schroedinger.engr.sgi.com>
References: <200507292206.j6TM6w4k004594@agluck-lia64.sc.intel.com>
	 <Pine.LNX.4.62.0507291625390.19428@schroedinger.engr.sgi.com>
	 <1122742054.28719.58.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0507301105120.25104@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: OSLO R&D
Date: Sun, 31 Jul 2005 11:02:59 -0600
Message-Id: <1122829379.6946.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Ok, here's an optimization that should help reduce contention on the
cmpxchg, has zero impact on the nojitter path, and doesn't require any
changes to fsys.  When a caller already had the xtime_lock write lock
there's no need to fight with other CPUs for the cmpxchg.  The other
"reader" CPUs will have to fetch it again since a seqlock write is in
progress.  Therefore we can simplify this path as shown below.  The
write is atomic, and we don't care if another CPU has changed last_cycle
since it can't return the value until the write lock is released.  This
has only been compile tested, but I'm interested to hear your opinion.
Thanks,

	Alex


diff -r cff8d3633e9c kernel/timer.c
--- a/kernel/timer.c	Fri Jul 29 22:01:15 2005
+++ b/kernel/timer.c	Sun Jul 31 10:25:41 2005
@@ -1452,10 +1452,34 @@
 		return time_interpolator_get_cycles(src);
 }
 
+static inline u64 time_interpolator_get_counter_locked(void)
+{
+	unsigned int src = time_interpolator->source;
+
+	if (time_interpolator->jitter)
+	{
+		u64 lcycle = time_interpolator->last_cycle;
+		u64 now = time_interpolator_get_cycles(src);
+
+		if (lcycle && time_after(lcycle, now))
+			return lcycle;
+
+		/*
+		 * This path is called when holding the xtime write lock.
+		 * This allows us to avoid the contention of the cmpxchg
+		 * in get_counter, and still ensures jitter protection.
+		 */
+		time_interpolator->last_cycle = now;
+		return now;
+	}
+	else
+		return time_interpolator_get_cycles(src);
+}
+
 void time_interpolator_reset(void)
 {
 	time_interpolator->offset = 0;
-	time_interpolator->last_counter = time_interpolator_get_counter();
+	time_interpolator->last_counter = time_interpolator_get_counter_locked();
 }
 
 #define GET_TI_NSECS(count,i) (((((count) - i->last_counter) & (i)->mask) * (i)->nsec_per_cyc) >> (i)->shift)
@@ -1490,7 +1514,7 @@
 	 * and the tuning logic insures that.
          */
 
-	counter = time_interpolator_get_counter();
+	counter = time_interpolator_get_counter_locked();
 	offset = time_interpolator->offset + GET_TI_NSECS(counter, time_interpolator);
 
 	if (delta_nsec < 0 || (unsigned long) delta_nsec < offset)


