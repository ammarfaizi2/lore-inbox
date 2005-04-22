Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVDVPA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVDVPA3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 11:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVDVPA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 11:00:28 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:16122 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261961AbVDVPAE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 11:00:04 -0400
Date: Fri, 22 Apr 2005 16:59:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 2/12] s390: idle timer setup.
Message-ID: <20050422145931.GB17508@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 2/12] s390: idle timer setup.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Fix overflow in calculation of the new tod value in stop_hz_timer
and fix wrong virtual timer list idle time in case the virtual
timer is already expired in stop_cpu_timer.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/time.c  |   12 +++++++++---
 arch/s390/kernel/vtime.c |   25 +++++++++++++------------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/time.c linux-2.6-patched/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	2005-04-22 15:44:44.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/time.c	2005-04-22 15:45:00.000000000 +0200
@@ -244,7 +244,7 @@ int sysctl_hz_timer = 1;
  */
 static inline void stop_hz_timer(void)
 {
-	__u64 timer;
+	__u64 timer, todval;
 
 	if (sysctl_hz_timer != 0)
 		return;
@@ -265,8 +265,14 @@ static inline void stop_hz_timer(void)
 	 * for the next event.
 	 */
 	timer = (__u64) (next_timer_interrupt() - jiffies) + jiffies_64;
-	timer = jiffies_timer_cc + timer * CLK_TICKS_PER_JIFFY;
-	asm volatile ("SCKC %0" : : "m" (timer));
+	todval = -1ULL;
+	/* Be careful about overflows. */
+	if (timer < (-1ULL / CLK_TICKS_PER_JIFFY)) {
+		timer = jiffies_timer_cc + timer * CLK_TICKS_PER_JIFFY;
+		if (timer >= jiffies_timer_cc)
+			todval = timer;
+	}
+	asm volatile ("SCKC %0" : : "m" (todval));
 }
 
 /*
diff -urpN linux-2.6/arch/s390/kernel/vtime.c linux-2.6-patched/arch/s390/kernel/vtime.c
--- linux-2.6/arch/s390/kernel/vtime.c	2005-04-22 15:44:44.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/vtime.c	2005-04-22 15:45:00.000000000 +0200
@@ -122,12 +122,17 @@ static void start_cpu_timer(void)
 	struct vtimer_queue *vt_list;
 
 	vt_list = &per_cpu(virt_cpu_timer, smp_processor_id());
-	set_vtimer(vt_list->idle);
+
+	/* CPU timer interrupt is pending, don't reprogramm it */
+	if (vt_list->idle & 1LL<<63)
+		return;
+
+	if (!list_empty(&vt_list->list))
+		set_vtimer(vt_list->idle);
 }
 
 static void stop_cpu_timer(void)
 {
-	__u64 done;
 	struct vtimer_queue *vt_list;
 
 	vt_list = &per_cpu(virt_cpu_timer, smp_processor_id());
@@ -138,21 +143,17 @@ static void stop_cpu_timer(void)
 		goto fire;
 	}
 
-	/* store progress */
-	asm volatile ("STPT %0" : "=m" (done));
+	/* store the actual expire value */
+	asm volatile ("STPT %0" : "=m" (vt_list->idle));
 
 	/*
-	 * If done is negative we do not stop the CPU timer
-	 * because we will get instantly an interrupt that
-	 * will start the CPU timer again.
+	 * If the CPU timer is negative we don't reprogramm
+	 * it because we will get instantly an interrupt.
 	 */
-	if (done & 1LL<<63)
+	if (vt_list->idle & 1LL<<63)
 		return;
-	else
-		vt_list->offset += vt_list->to_expire - done;
 
-	/* save the actual expire value */
-	vt_list->idle = done;
+	vt_list->offset += vt_list->to_expire - vt_list->idle;
 
 	/*
 	 * We cannot halt the CPU timer, we just write a value that
