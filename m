Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262886AbSJWGeH>; Wed, 23 Oct 2002 02:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262885AbSJWGeF>; Wed, 23 Oct 2002 02:34:05 -0400
Received: from air-2.osdl.org ([65.172.181.6]:3051 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262886AbSJWGeC>;
	Wed, 23 Oct 2002 02:34:02 -0400
Date: Tue, 22 Oct 2002 23:37:11 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Kristis Makris <devcore@freeuk.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] niceness magic numbers, 2.4.20-pre11
In-Reply-To: <1035349158.491.29.camel@mcmicro>
Message-ID: <Pine.LNX.4.33L2.0210222332480.15859-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Oct 2002, Kristis Makris wrote:

| This untested patch removes use of process priority magic numbers in
| sys_nice, sys_setpriority, sys_getpriority, and properly uses their
| #define'd values.
|
| It would be nice if someone tested if it applies against 2.5.

Nope, it doesn't apply cleanly to 2.5.44:

[rddunlap@midway linux-2544]$ patch -p1 -b --dry-run <
~/patches/niceness_magic_numbers.patch
patching file include/linux/resource.h
patching file kernel/sched.c
Hunk #1 FAILED at 870.
1 out of 1 hunk FAILED -- saving rejects to file kernel/sched.c.rej
patching file kernel/sys.c
Hunk #1 succeeded at 236 with fuzz 1 (offset 32 lines).
Hunk #2 FAILED at 281.
1 out of 2 hunks FAILED -- saving rejects to file kernel/sys.c.rej



Here is a working version for 2.5.44,
with a small change so that
	-(A - (B + 1))
is written as
	B - A + 1

so go push it. :)



--- ./include/linux/resource.h.nice	Tue Jun 18 20:10:36 2002
+++ ./include/linux/resource.h	Sat Oct 19 13:55:10 2002
@@ -43,7 +43,7 @@
 };

 #define	PRIO_MIN	(-20)
-#define	PRIO_MAX	20
+#define	PRIO_MAX	19

 #define	PRIO_PROCESS	0
 #define	PRIO_PGRP	1
--- ./kernel/sys.c.nice	Fri Oct 18 21:01:11 2002
+++ ./kernel/sys.c	Tue Oct 22 22:57:49 2002
@@ -236,10 +236,10 @@

 	/* normalize: avoid signed division (rounding problems) */
 	error = -ESRCH;
-	if (niceval < -20)
-		niceval = -20;
-	if (niceval > 19)
-		niceval = 19;
+	if (niceval < PRIO_MIN)
+		niceval = PRIO_MIN;
+	if (niceval > PRIO_MAX)
+		niceval = PRIO_MAX;

 	read_lock(&tasklist_lock);
 	switch (which) {
@@ -301,7 +301,7 @@
 				who = current->pid;
 			p = find_task_by_pid(who);
 			if (p) {
-				niceval = 20 - task_nice(p);
+				niceval = PRIO_MAX + 1 - task_nice(p);
 				if (niceval > retval)
 					retval = niceval;
 			}
@@ -310,7 +310,7 @@
 			if (!who)
 				who = current->pgrp;
 			for_each_task_pid(who, PIDTYPE_PGID, p, l, pid) {
-				niceval = 20 - task_nice(p);
+				niceval = PRIO_MAX + 1 - task_nice(p);
 				if (niceval > retval)
 					retval = niceval;
 			}
@@ -326,7 +326,7 @@

 			do_each_thread(g, p)
 				if (p->uid == who) {
-					niceval = 20 - task_nice(p);
+					niceval = PRIO_MAX + 1 - task_nice(p);
 					if (niceval > retval)
 						retval = niceval;
 				}
--- ./kernel/sched.c.nice	Fri Oct 18 21:02:28 2002
+++ ./kernel/sched.c	Tue Oct 22 22:51:43 2002
@@ -1317,17 +1317,19 @@
 	if (increment < 0) {
 		if (!capable(CAP_SYS_NICE))
 			return -EPERM;
-		if (increment < -40)
-			increment = -40;
+
+		/* +1 to account for 0 in min<-->max range */
+		if (increment < PRIO_MIN - PRIO_MAX + 1)
+			increment = PRIO_MIN - PRIO_MAX + 1;
 	}
-	if (increment > 40)
-		increment = 40;
+	if (increment > (PRIO_MAX - PRIO_MIN + 1))
+		increment = PRIO_MAX - PRIO_MIN + 1;

 	nice = PRIO_TO_NICE(current->static_prio) + increment;
-	if (nice < -20)
-		nice = -20;
-	if (nice > 19)
-		nice = 19;
+	if (nice < PRIO_MIN)
+		nice = PRIO_MIN;
+	if (nice > PRIO_MAX)
+		nice = PRIO_MAX;

 	retval = security_ops->task_setnice(current, nice);
 	if (retval)

-- 
~Randy

