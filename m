Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWARQvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWARQvu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWARQvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:51:49 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:12420 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932342AbWARQvs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:51:48 -0500
Date: Wed, 18 Jan 2006 17:51:15 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Jan Glauber <jan.glauber@de.ibm.com>
Subject: [PATCH 2/7] s390: overflow in sched_clock.
Message-ID: <20060118165115.GB29266@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Glauber <jan.glauber@de.ibm.com>

The least significant bit of the TOD clock value returned by get_clock
is the 4096th part of a microsecond. To get to nanoseconds the value
needs to be divided by 4096 and multiplied with 1000. The current
method multiplies first and then shifts the value to make the result
as precise as possible. The disadvantage is that the multiplication
with 1000 will overflow shortly after 52 days. sched_clock is used 
by the scheduler for time stamp deltas, if an overflow occurs between
two time stamps the scheduler will get confused.

With the patch the problem occurs only after approx. one year, so the
chance to run into this overflow is extremly low.

Signed-off-by: Jan Glauber <jan.glauber@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/time.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/time.c linux-2.6-patched/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	2006-01-18 17:25:20.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/time.c	2006-01-18 17:25:49.000000000 +0100
@@ -61,7 +61,7 @@ extern unsigned long wall_jiffies;
  */
 unsigned long long sched_clock(void)
 {
-	return ((get_clock() - jiffies_timer_cc) * 1000) >> 12;
+	return ((get_clock() - jiffies_timer_cc) * 125) >> 9;
 }
 
 void tod_to_timeval(__u64 todval, struct timespec *xtime)
