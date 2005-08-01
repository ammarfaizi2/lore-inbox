Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVHAQM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVHAQM2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 12:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVHAQJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 12:09:39 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:16334 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262169AbVHAQHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 12:07:08 -0400
Date: Mon, 1 Aug 2005 09:06:59 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Alex Williamson <alex.williamson@hp.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, tony.luck@intel.com
Subject: Re: [PATCH] optimize writer path in time_interpolator_get_counter()
In-Reply-To: <1122911571.5243.23.camel@tdi>
Message-ID: <Pine.LNX.4.62.0508010906250.6397@schroedinger.engr.sgi.com>
References: <1122911571.5243.23.camel@tdi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could we remove some code duplication?

--

   When using a time interpolator that is susceptible to jitter there's
potentially contention over a cmpxchg used to prevent time from going
backwards.  This is unnecessary when the caller holds the xtime write
seqlock as all readers will be blocked from returning until the write is
complete.  We can therefore allow writers to insert a new value and exit
rather than fight with CPUs who only hold a reader lock.

Signed-off-by: Alex Williamson <alex.williamson@hp.com>
Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6/kernel/timer.c
===================================================================
--- linux-2.6.orig/kernel/timer.c	2005-07-27 18:29:24.000000000 -0700
+++ linux-2.6/kernel/timer.c	2005-08-01 09:04:21.000000000 -0700
@@ -1428,7 +1428,7 @@
 	}
 }
 
-static inline u64 time_interpolator_get_counter(void)
+static inline u64 time_interpolator_get_counter(int writelock)
 {
 	unsigned int src = time_interpolator->source;
 
@@ -1442,6 +1442,15 @@
 			now = time_interpolator_get_cycles(src);
 			if (lcycle && time_after(lcycle, now))
 				return lcycle;
+
+			/* When holding the xtime write lock, there's no need
+			 * to add the overhead of the cmpxchg.  Readers are
+			 * force to retry until the write lock is released.
+			 */
+			if (writelock) {
+				time_interpolator->last_cycle = now;
+				return now;
+			}
 			/* Keep track of the last timer value returned. The use of cmpxchg here
 			 * will cause contention in an SMP environment.
 			 */
@@ -1455,7 +1464,7 @@
 void time_interpolator_reset(void)
 {
 	time_interpolator->offset = 0;
-	time_interpolator->last_counter = time_interpolator_get_counter();
+	time_interpolator->last_counter = time_interpolator_get_counter(1);
 }
 
 #define GET_TI_NSECS(count,i) (((((count) - i->last_counter) & (i)->mask) * (i)->nsec_per_cyc) >> (i)->shift)
@@ -1467,7 +1476,7 @@
 		return 0;
 
 	return time_interpolator->offset +
-		GET_TI_NSECS(time_interpolator_get_counter(), time_interpolator);
+		GET_TI_NSECS(time_interpolator_get_counter(0), time_interpolator);
 }
 
 #define INTERPOLATOR_ADJUST 65536
@@ -1490,7 +1499,7 @@
 	 * and the tuning logic insures that.
          */
 
-	counter = time_interpolator_get_counter();
+	counter = time_interpolator_get_counter(1);
 	offset = time_interpolator->offset + GET_TI_NSECS(counter, time_interpolator);
 
 	if (delta_nsec < 0 || (unsigned long) delta_nsec < offset)
