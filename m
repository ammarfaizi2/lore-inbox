Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266925AbUHDAxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266925AbUHDAxq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 20:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266917AbUHDAxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 20:53:46 -0400
Received: from mail019.syd.optusnet.com.au ([211.29.132.73]:34980 "EHLO
	mail019.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267171AbUHDAvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 20:51:13 -0400
Message-ID: <cone.1091580668.916240.9775.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][3/3] Isochronous scheduling for staircase scheduler
Date: Wed, 04 Aug 2004 10:51:08 +1000
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_pc.kolivas.org-1091580668-0000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_pc.kolivas.org-1091580668-0000
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

This patch adds soft real time support to the staircase scheduler.

Soft real time allows low latency scheduling for non heavily cpu bound tasks 
by non-privileged users.

It does this by elevating the effective priority within the staircase 
scheduler, but penalising prolonged cpu usage more heavily by demoting them 
down the staircase faster. This allows non root users to have low latency 
scheduling without the risk of starvation of true real time policies.

This scheduling class is suitable for use only for not very cpu bound tasks 
such as audio playback, and the capture thread in audio and video sampling. 
It is _not_ suitable for high performance gaming.

This scheduling class is currently supported in userspace by schedtools and 
the heirloom toolchest.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


--=_pc.kolivas.org-1091580668-0000
Content-Description: schediso
Content-Disposition: inline;
  FILENAME="schediso2.4.diff"
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Index: linux-2.6.8-rc2-mm2/include/linux/sched.h
===================================================================
--- linux-2.6.8-rc2-mm2.orig/include/linux/sched.h	2004-08-03 01:30:27.149099800 +1000
+++ linux-2.6.8-rc2-mm2/include/linux/sched.h	2004-08-03 01:34:04.180800989 +1000
@@ -127,9 +127,10 @@
 #define SCHED_FIFO		1
 #define SCHED_RR		2
 #define SCHED_BATCH		3
+#define SCHED_ISO		4
 
 #define SCHED_MIN		0
-#define SCHED_MAX		3
+#define SCHED_MAX		4
 
 #define SCHED_RANGE(policy)	((policy) >= SCHED_MIN && \
 					(policy) <= SCHED_MAX)
@@ -332,6 +333,7 @@
 
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
 #define batch_task(p)		((p)->policy == SCHED_BATCH)
+#define iso_task(p)		((p)->policy == SCHED_ISO)
 
 /*
  * Some day this will be a full-fledged user tracking system..
Index: linux-2.6.8-rc2-mm2/kernel/sched.c
===================================================================
--- linux-2.6.8-rc2-mm2.orig/kernel/sched.c	2004-08-03 01:33:53.426735074 +1000
+++ linux-2.6.8-rc2-mm2/kernel/sched.c	2004-08-03 01:34:40.376607323 +1000
@@ -248,6 +248,8 @@
 {
 	if (likely(!rt_task(p))) {
 		unsigned int task_user_prio = TASK_USER_PRIO(p);
+		if (iso_task(p))
+			task_user_prio /= 2;
 		return 39 - task_user_prio;
 	} else
 		return p->burst;
@@ -286,6 +288,18 @@
  */
 int sched_interactive = 1;
 
+static int rr_interval(task_t * p)
+{
+	int rr_interval = RR_INTERVAL();
+	if (batch_task(p))
+		rr_interval *= 10;
+	else if (iso_task(p))
+		rr_interval /= 2;
+	if (!rr_interval)
+		rr_interval = 1;
+	return rr_interval;
+}
+
 /*
  * effective_prio - dynamic priority dependent on burst.
  * The priority normally decreases by one each RR_INTERVAL.
@@ -294,7 +308,7 @@
  */
 static int effective_prio(task_t *p)
 {
-	int prio;
+	int prio, rr;
 	unsigned int full_slice, used_slice, first_slice;
 	unsigned int best_burst;
 	if (rt_task(p))
@@ -313,17 +327,18 @@
 
 	best_burst = burst(p);
 	full_slice = slice(p);
+	rr = rr_interval(p);
 	used_slice = full_slice - p->slice;
 	if (p->burst > best_burst)
 		p->burst = best_burst;
-	first_slice = RR_INTERVAL();
-	if (sched_interactive && !sched_compute)
+	first_slice = rr;
+	if (sched_interactive && !sched_compute && !iso_task(p))
 		first_slice *= (p->burst + 1);
 	prio = MAX_PRIO - 2 - best_burst;
 
 	if (used_slice < first_slice)
 		return prio;
-	prio += 1 + (used_slice - first_slice) / RR_INTERVAL();
+	prio += 1 + (used_slice - first_slice) / rr;
 	if (prio > MAX_PRIO - 2)
 		prio = MAX_PRIO - 2;
 	return prio;
@@ -341,7 +356,7 @@
 	unsigned long total_run = NS_TO_JIFFIES(ns_totalrun);
 	if (p->flags & PF_FORKED || ((!(NS_TO_JIFFIES(p->runtime)) ||
 		!sched_interactive || sched_compute) &&
-		NS_TO_JIFFIES(p->runtime + sleep_time) < RR_INTERVAL())) {
+		NS_TO_JIFFIES(p->runtime + sleep_time) < rr_interval(p))) {
 			p->flags &= ~PF_FORKED;
 			if (p->slice - total_run < 1) {
 				p->totalrun = 0;
@@ -376,7 +391,7 @@
 	recalc_task_prio(p, now);
 	p->prio = effective_prio(p);
 	p->flags &= ~PF_UISLEEP;
-	p->time_slice = RR_INTERVAL();
+	p->time_slice = rr_interval(p);
 	if (batch_task(p))
 		p->time_slice = p->slice;
 	p->timestamp = now;
@@ -1754,19 +1769,19 @@
 		dec_burst(p);
 		p->slice = slice(p);
 		p->prio = effective_prio(p);
-		p->time_slice = RR_INTERVAL();
+		p->time_slice = rr_interval(p);
 		enqueue_task(p, rq);
 		goto out_unlock;
 	}
 	/*
 	 * Tasks that run out of time_slice but still have slice left get
-	 * requeued with a lower priority && RR_INTERVAL time_slice.
+	 * requeued with a lower priority && rr_interval time_slice.
 	 */
 	if (!--p->time_slice) {
 		set_tsk_need_resched(p);
 		dequeue_task(p, rq);
 		p->prio = effective_prio(p);
-		p->time_slice = RR_INTERVAL();
+		p->time_slice = rr_interval(p);
 		enqueue_task(p, rq);
 		goto out_unlock;
 	}
@@ -2419,7 +2434,11 @@
 
 	retval = -EPERM;
 	if (SCHED_RT(policy) && !capable(CAP_SYS_NICE))
-		goto out_unlock;
+		/*
+		 * If the caller requested an RT policy without having the
+		 * necessary rights, we downgrade the policy to SCHED_ISO.
+		 */
+		policy = SCHED_ISO;
 	if ((current->euid != p->euid) && (current->euid != p->uid) &&
 	    !capable(CAP_SYS_NICE))
 		goto out_unlock;
@@ -2752,6 +2771,7 @@
 		break;
 	case SCHED_NORMAL:
 	case SCHED_BATCH:
+	case SCHED_ISO:
 		ret = 0;
 		break;
 	}
@@ -2776,6 +2796,7 @@
 		break;
 	case SCHED_NORMAL:
 	case SCHED_BATCH:
+	case SCHED_ISO:
 		ret = 0;
 	}
 	return ret;

--=_pc.kolivas.org-1091580668-0000--
