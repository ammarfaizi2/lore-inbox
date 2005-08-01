Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbVHAPzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVHAPzQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 11:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVHAPx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 11:53:28 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:55251 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S262240AbVHAPwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 11:52:54 -0400
Subject: [PATCH] optimize writer path in time_interpolator_get_counter()
From: Alex Williamson <alex.williamson@hp.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, tony.luck@intel.com, clameter@engr.sgi.com
Content-Type: text/plain
Organization: LOSL
Date: Mon, 01 Aug 2005 09:52:51 -0600
Message-Id: <1122911571.5243.23.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   When using a time interpolator that is susceptible to jitter there's
potentially contention over a cmpxchg used to prevent time from going
backwards.  This is unnecessary when the caller holds the xtime write
seqlock as all readers will be blocked from returning until the write is
complete.  We can therefore allow writers to insert a new value and exit
rather than fight with CPUs who only hold a reader lock.

Signed-off-by: Alex Williamson <alex.williamson@hp.com>

diff -r cff8d3633e9c kernel/timer.c
--- a/kernel/timer.c	Fri Jul 29 22:01:15 2005
+++ b/kernel/timer.c	Mon Aug  1 08:39:44 2005
@@ -1428,7 +1428,7 @@
 	}
 }
 
-static inline u64 time_interpolator_get_counter(void)
+static inline u64 time_interpolator_get_counter(int writelock)
 {
 	unsigned int src = time_interpolator->source;
 
@@ -1436,6 +1436,20 @@
 	{
 		u64 lcycle;
 		u64 now;
+
+		if (writelock) {
+			lcycle = time_interpolator->last_cycle;
+			now = time_interpolator_get_cycles(src);
+			if (lcycle && time_after(lcycle, now))
+				return lcycle;
+
+			/* When holding the xtime write lock, there's no need
+			 * to add the overhead of the cmpxchg.  Readers are
+			 * force to retry until the write lock is released.
+			 */
+			time_interpolator->last_cycle = now;
+			return now;
+		}
 
 		do {
 			lcycle = time_interpolator->last_cycle;
@@ -1455,7 +1469,7 @@
 void time_interpolator_reset(void)
 {
 	time_interpolator->offset = 0;
-	time_interpolator->last_counter = time_interpolator_get_counter();
+	time_interpolator->last_counter = time_interpolator_get_counter(1);
 }
 
 #define GET_TI_NSECS(count,i) (((((count) - i->last_counter) & (i)->mask) * (i)->nsec_per_cyc) >> (i)->shift)
@@ -1467,7 +1481,7 @@
 		return 0;
 
 	return time_interpolator->offset +
-		GET_TI_NSECS(time_interpolator_get_counter(), time_interpolator);
+		GET_TI_NSECS(time_interpolator_get_counter(0), time_interpolator);
 }
 
 #define INTERPOLATOR_ADJUST 65536
@@ -1490,7 +1504,7 @@
 	 * and the tuning logic insures that.
          */
 
-	counter = time_interpolator_get_counter();
+	counter = time_interpolator_get_counter(1);
 	offset = time_interpolator->offset + GET_TI_NSECS(counter, time_interpolator);
 
 	if (delta_nsec < 0 || (unsigned long) delta_nsec < offset)


