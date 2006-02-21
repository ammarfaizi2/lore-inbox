Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161398AbWBUGW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161398AbWBUGW5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161396AbWBUGW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:22:29 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:26281 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161398AbWBUGVa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:21:30 -0500
Date: Mon, 20 Feb 2006 23:21:28 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       john stultz <johnstul@us.ibm.com>
Message-Id: <20060221062127.13304.36954.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060221062102.13304.81613.sendpatchset@cog.beaverton.ibm.com>
References: <20060221062102.13304.81613.sendpatchset@cog.beaverton.ibm.com>
Subject: [-mm PATCH 4/11] Time: clocksource infrastructure - remove nsec_t
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes nsec_t usage as suggested by Roman Zippel
Also moves the cycle_t definition to clocksource.h

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 include/linux/clocksource.h |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

Index: mm-merge/include/linux/clocksource.h
===================================================================
--- mm-merge.orig/include/linux/clocksource.h
+++ mm-merge/include/linux/clocksource.h
@@ -15,6 +15,9 @@
 #include <asm/div64.h>
 #include <asm/io.h>
 
+/* clocksource cycle base type */
+typedef u64 cycle_t;
+
 /**
  * struct clocksource - hardware abstraction for a free running counter
  *	Provides mostly state-free accessors to the underlying hardware.
@@ -169,14 +172,14 @@ static inline int ppm_to_mult_adj(struct
  *
  * XXX - This could use some mult_lxl_ll() asm optimization
  */
-static inline nsec_t cyc2ns(struct clocksource *cs, int ntp_adj, cycle_t cycles)
+static inline s64 cyc2ns(struct clocksource *cs, int ntp_adj, cycle_t cycles)
 {
-	u64 ret = (u64)cycles;
+	u64 ret = cycles;
 
 	ret *= (cs->mult + ntp_adj);
 	ret >>= cs->shift;
 
-	return (nsec_t)ret;
+	return ret;
 }
 
 /**
@@ -192,10 +195,10 @@ static inline nsec_t cyc2ns(struct clock
  *
  * XXX - This could use some mult_lxl_ll() asm optimization.
  */
-static inline nsec_t cyc2ns_rem(struct clocksource *cs, int ntp_adj,
+static inline s64 cyc2ns_rem(struct clocksource *cs, int ntp_adj,
 				cycle_t cycles, u64* rem)
 {
-	u64 ret = (u64)cycles;
+	u64 ret = cycles;
 
 	ret *= (cs->mult + ntp_adj);
 	if (rem) {
@@ -204,7 +207,7 @@ static inline nsec_t cyc2ns_rem(struct c
 	}
 	ret >>= cs->shift;
 
-	return (nsec_t)ret;
+	return ret;
 }
 
 
@@ -224,7 +227,7 @@ static inline nsec_t cyc2ns_rem(struct c
  */
 struct clocksource_interval {
 	cycle_t cycles;
-	nsec_t nsecs;
+	s64 nsecs;
 	u64 remainder;
 	u64 remainder_ns_overflow;
 };
@@ -278,10 +281,10 @@ calculate_clocksource_interval(struct cl
  *
  * Unless you're the timeofday_periodic_hook, you should not be using this!
  */
-static inline nsec_t cyc2ns_fixed_rem(struct clocksource_interval interval,
+static inline s64 cyc2ns_fixed_rem(struct clocksource_interval interval,
 				      cycle_t *cycles, u64* rem)
 {
-	nsec_t delta_nsec = 0;
+	s64 delta_nsec = 0;
 
 	while (*cycles > interval.cycles) {
 		delta_nsec += interval.nsecs;
