Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbUKFKwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbUKFKwv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 05:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbUKFKwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 05:52:51 -0500
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:45289 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261365AbUKFKwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 05:52:43 -0500
Message-ID: <418CACF5.4070004@kolivas.org>
Date: Sat, 06 Nov 2004 21:52:37 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] [sched experimental] implement cpubound policy
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9C5C485969A1B488FD9CD3EE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9C5C485969A1B488FD9CD3EE
Content-Type: multipart/mixed;
 boundary="------------070907020709010802010705"

This is a multi-part message in MIME format.
--------------070907020709010802010705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

As discussed previously on lkml, implement cpubound policy.


--------------070907020709010802010705
Content-Type: text/x-patch;
 name="sched-implement_cpubound.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-implement_cpubound.diff"

This patch adds support for a scheduling policy based on SCHED_NORMAL without
interactive modification of it's dynamic priority. It has fixed priority
equal to what a dynamic priority fully cpubound task of the same nice level
would have.

It is suited to:
1. Tasks known to be cpubound in advance but are still desired to have
   similar cpu proportion as equal nice level SCHED_NORMAL tasks.
2. As a way of rigidly fixing the cpu distribution of multiple tasks of the
   same importance (such as multiple X sessions).
3. As a way of ensuring multiple threads dependant on each other are
   the same priority to prevent busy-on-wait scenarios where locking is
   difficult (eg multiple threaded java apps).

This scheduling policy can only have at best the same cpu distribution as a
SCHED_NORMAL task so it cannot be used for unfair advantage in multiuser
setups. The name "BOUND" was chosen to represent meaning "cpu bound" and
"priority bound".

Current userspace tools that support setting the policy can be used to set
it. However most have used this policy number for SCHED_BATCH implementations
which we do not yet support in mainline.

This will need some extensive testing mainly to ensure it is a useful policy,
although the code to implement it is trivial. If it does not prove useful
we should not pursue it.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.10-rc1-mm3/include/linux/sched.h
===================================================================
--- linux-2.6.10-rc1-mm3.orig/include/linux/sched.h	2004-11-06 21:04:16.174979723 +1100
+++ linux-2.6.10-rc1-mm3/include/linux/sched.h	2004-11-06 21:11:19.997162978 +1100
@@ -129,6 +129,12 @@ extern unsigned long nr_iowait(void);
 #define SCHED_NORMAL		0
 #define SCHED_FIFO		1
 #define SCHED_RR		2
+#define SCHED_BOUND		3	/* Fixed priority SCHED_NORMAL */
+
+#define SCHED_MAX		3	/* Highest supported policy */
+
+#define RT_POLICY(policy)	(policy == SCHED_FIFO || policy == SCHED_RR)
+#define SUPPORTED_POLICY(policy)	(policy >= 0 && policy <= SCHED_MAX)
 
 struct sched_param {
 	int sched_priority;
Index: linux-2.6.10-rc1-mm3/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm3.orig/kernel/sched.c	2004-11-06 21:11:14.544009827 +1100
+++ linux-2.6.10-rc1-mm3/kernel/sched.c	2004-11-06 21:11:20.000162512 +1100
@@ -151,7 +151,8 @@
 	(SCALE(TASK_NICE(p), 40, MAX_BONUS) + INTERACTIVE_DELTA)
 
 #define TASK_INTERACTIVE(p) \
-	((p)->prio <= (p)->static_prio - DELTA(p))
+	((p)->policy != SCHED_BOUND && \
+		(p)->prio <= (p)->static_prio - DELTA(p))
 
 #define INTERACTIVE_SLEEP(p) \
 	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
@@ -628,7 +629,9 @@ static int effective_prio(task_t *p)
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
+	bonus = - MAX_BONUS / 2;
+	if (p->policy != SCHED_BOUND)
+		bonus += CURRENT_BONUS(p);
 
 	prio = p->static_prio - bonus;
 	if (prio < MAX_RT_PRIO)
@@ -3227,7 +3230,7 @@ static void __setscheduler(struct task_s
 	BUG_ON(p->array);
 	p->policy = policy;
 	p->rt_priority = prio;
-	if (policy != SCHED_NORMAL)
+	if (RT_POLICY(policy))
 		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio = p->static_prio;
@@ -3269,8 +3272,7 @@ recheck:
 		policy = oldpolicy = p->policy;
 	else {
 		retval = -EINVAL;
-		if (policy != SCHED_FIFO && policy != SCHED_RR &&
-				policy != SCHED_NORMAL)
+		if (!SUPPORTED_POLICY(policy))
 			goto out_unlock;
 	}
 	/*
@@ -3280,12 +3282,11 @@ recheck:
 	retval = -EINVAL;
 	if (lp.sched_priority < 0 || lp.sched_priority > MAX_USER_RT_PRIO-1)
 		goto out_unlock;
-	if ((policy == SCHED_NORMAL) != (lp.sched_priority == 0))
+	if ((!RT_POLICY(policy)) != (lp.sched_priority == 0))
 		goto out_unlock;
 
 	retval = -EPERM;
-	if ((policy == SCHED_FIFO || policy == SCHED_RR) &&
-	    !capable(CAP_SYS_NICE))
+	if (RT_POLICY(policy) && !capable(CAP_SYS_NICE))
 		goto out_unlock;
 	if ((current->euid != p->euid) && (current->euid != p->uid) &&
 	    !capable(CAP_SYS_NICE))
@@ -3732,6 +3733,7 @@ asmlinkage long sys_sched_get_priority_m
 		ret = MAX_USER_RT_PRIO-1;
 		break;
 	case SCHED_NORMAL:
+	case SCHED_BOUND:
 		ret = 0;
 		break;
 	}
@@ -3755,6 +3757,7 @@ asmlinkage long sys_sched_get_priority_m
 		ret = 1;
 		break;
 	case SCHED_NORMAL:
+	case SCHED_BOUND:
 		ret = 0;
 	}
 	return ret;


--------------070907020709010802010705--

--------------enig9C5C485969A1B488FD9CD3EE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBjKz1ZUg7+tp6mRURAiCsAJsG+yox3BoPXn7aDd94W5YNAe5N6wCeKrl3
dM7pQUQX8ZdEuSDaJ44tmmM=
=IKFM
-----END PGP SIGNATURE-----

--------------enig9C5C485969A1B488FD9CD3EE--
