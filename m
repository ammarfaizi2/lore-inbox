Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266919AbUHDApa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266919AbUHDApa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 20:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266917AbUHDAp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 20:45:29 -0400
Received: from mail012.syd.optusnet.com.au ([211.29.132.66]:49370 "EHLO
	mail012.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266925AbUHDAmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 20:42:10 -0400
Message-ID: <cone.1091580127.491907.9775.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][1/3] Schedrange
Date: Wed, 04 Aug 2004 10:42:07 +1000
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_pc.kolivas.org-1091580127-0000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_pc.kolivas.org-1091580127-0000
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

This patch is to make it easier in code to implement more scheduling 
policies.

Patch against 2.6.8-rc2-mm2
Signed-off-by: Con Kolivas <kernel@kolivas.org>


--=_pc.kolivas.org-1091580127-0000
Content-Description: schedrange
Content-Disposition: inline;
  FILENAME="schedrange.diff"
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Index: linux-2.6.8-rc2-mm1/include/linux/sched.h
===================================================================
--- linux-2.6.8-rc2-mm1.orig/include/linux/sched.h	2004-08-02 13:44:05.000000000 +1000
+++ linux-2.6.8-rc2-mm1/include/linux/sched.h	2004-08-02 15:41:06.666863796 +1000
@@ -127,6 +127,14 @@
 #define SCHED_FIFO		1
 #define SCHED_RR		2
 
+#define SCHED_MIN		0
+#define SCHED_MAX		2
+
+#define SCHED_RANGE(policy)	((policy) >= SCHED_MIN && \
+					(policy) <= SCHED_MAX)
+#define SCHED_RT(policy)	((policy) == SCHED_FIFO || \
+					(policy) == SCHED_RR)
+					
 struct sched_param {
 	int sched_priority;
 };
Index: linux-2.6.8-rc2-mm1/kernel/sched.c
===================================================================
--- linux-2.6.8-rc2-mm1.orig/kernel/sched.c	2004-08-02 13:44:11.000000000 +1000
+++ linux-2.6.8-rc2-mm1/kernel/sched.c	2004-08-02 15:41:06.695859473 +1000
@@ -2339,7 +2339,7 @@
 	BUG_ON(task_queued(p));
 	p->policy = policy;
 	p->rt_priority = prio;
-	if (policy != SCHED_NORMAL)
+	if (SCHED_RT(policy))
 		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio = p->static_prio;
@@ -2385,9 +2385,8 @@
 		policy = p->policy;
 	else {
 		retval = -EINVAL;
-		if (policy != SCHED_FIFO && policy != SCHED_RR &&
-				policy != SCHED_NORMAL)
-			goto out_unlock;
+		if (!SCHED_RANGE(policy))
+				goto out_unlock;
 	}
 
 	/*
@@ -2397,12 +2396,11 @@
 	retval = -EINVAL;
 	if (lp.sched_priority < 0 || lp.sched_priority > MAX_USER_RT_PRIO-1)
 		goto out_unlock;
-	if ((policy == SCHED_NORMAL) != (lp.sched_priority == 0))
-		goto out_unlock;
+	if (!SCHED_RT(policy) != (lp.sched_priority == 0))
+			goto out_unlock;
 
 	retval = -EPERM;
-	if ((policy == SCHED_FIFO || policy == SCHED_RR) &&
-	    !capable(CAP_SYS_NICE))
+	if (SCHED_RT(policy) && !capable(CAP_SYS_NICE))
 		goto out_unlock;
 	if ((current->euid != p->euid) && (current->euid != p->uid) &&
 	    !capable(CAP_SYS_NICE))

--=_pc.kolivas.org-1091580127-0000--
