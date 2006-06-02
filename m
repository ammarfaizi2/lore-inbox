Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWFBDIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWFBDIj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 23:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWFBDIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 23:08:39 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:21916 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751169AbWFBDIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 23:08:38 -0400
Date: Thu, 1 Jun 2006 23:08:25 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: "Christopher S. Aker" <caker@theshore.net>,
       user-mode-linux-devel@lists.sourceforge.net
Subject: non-scalar ktime addition and subtraction broken
Message-ID: <20060602030825.GA8006@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The use of 64-bit additions and subtractions on something which is
nominally a struct containing 32-bit second and nanosecond field is
broken when a negative time is involved.  When the structure is
treated as a 64-bit integer, the increment of the upper 32 bits that's
part of two's-complement subtraction is lost.  This leaves the end
result off by one second.

This manifested itself with sleeps inside UML lasting about 1 second
shorter than expected.

The patch below is more a problem statement than a real fix.  People
thought about performance, and I don't know what this does to that
work.

I'm not sure why the hrtimer.c part is needed - I had done that before
tracking down the ktime_add problem.  I see short sleeps without it,
so it is needed somehow.

The ktime_sub piece was done for completeness - UML compiles and boots
with no apparent ill effects, but it's otherwise untested.

As an aside, I fail to see how it can be correct for ktime_sub to add
NSEC_PER_SEC to something without compensating somewhere else for it.

Andrew - please don't drop this into -mm without an OK from Thomas or
someone else who's familiar with this code :-)

				Jeff

Index: linux-2.6.17-mm/include/linux/ktime.h
===================================================================
--- linux-2.6.17-mm.orig/include/linux/ktime.h	2006-06-01 22:15:44.000000000 -0400
+++ linux-2.6.17-mm/include/linux/ktime.h	2006-06-01 23:00:32.000000000 -0400
@@ -148,7 +148,8 @@ static inline ktime_t ktime_sub(const kt
 {
 	ktime_t res;
 
-	res.tv64 = lhs.tv64 - rhs.tv64;
+	res.tv.sec = lhs.tv.sec - rhs.tv.sec;
+	res.tv.nsec = lhs.tv.nsec - rhs.tv.nsec;
 	if (res.tv.nsec < 0)
 		res.tv.nsec += NSEC_PER_SEC;
 
@@ -167,7 +168,8 @@ static inline ktime_t ktime_add(const kt
 {
 	ktime_t res;
 
-	res.tv64 = add1.tv64 + add2.tv64;
+	res.tv.sec = add1.tv.sec + add2.tv.sec;
+	res.tv.nsec = add1.tv.nsec + add2.tv.nsec;
 	/*
 	 * performance trick: the (u32) -NSEC gives 0x00000000Fxxxxxxx
 	 * so we subtract NSEC_PER_SEC and add 1 to the upper 32 bit.
Index: linux-2.6.17-mm/kernel/hrtimer.c
===================================================================
--- linux-2.6.17-mm.orig/kernel/hrtimer.c	2006-06-01 22:15:44.000000000 -0400
+++ linux-2.6.17-mm/kernel/hrtimer.c	2006-06-01 22:57:24.000000000 -0400
@@ -627,7 +627,8 @@ static inline void run_hrtimer_queue(str
 		int restart;
 
 		timer = rb_entry(node, struct hrtimer, node);
-		if (base->softirq_time.tv64 <= timer->expires.tv64)
+		if(ktime_to_ns(base->softirq_time) <=
+		   ktime_to_ns(timer->expires))
 			break;
 
 		fn = timer->function;
