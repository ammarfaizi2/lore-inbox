Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265042AbSJWXre>; Wed, 23 Oct 2002 19:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265047AbSJWXrd>; Wed, 23 Oct 2002 19:47:33 -0400
Received: from air-2.osdl.org ([65.172.181.6]:25825 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265042AbSJWXrc>;
	Wed, 23 Oct 2002 19:47:32 -0400
Date: Wed, 23 Oct 2002 16:50:27 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Robert Love <rml@tech9.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Kristis Makris <devcore@freeuk.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] niceness magic numbers, 2.5.44 now.
In-Reply-To: <1035402772.3171.1550.camel@phantasy>
Message-ID: <Pine.LNX.4.33L2.0210231646060.17702-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Oct 2002, Robert Love wrote:

| On Wed, 2002-10-23 at 04:16, Alan Cox wrote:
|
| > On Wed, 2002-10-23 at 07:37, Randy.Dunlap wrote:
| > > --- ./include/linux/resource.h.nice	Tue Jun 18 20:10:36 2002
| > > +++ ./include/linux/resource.h	Sat Oct 19 13:55:10 2002
| > > @@ -43,7 +43,7 @@
| > >  };
| > >
| > >  #define	PRIO_MIN	(-20)
| > > -#define	PRIO_MAX	20
| > > +#define	PRIO_MAX	19
| >
| > I suspect this isnt correct
|
| Agreed.  Its not.
|
| It should remain 20 and places that truly want 19 should do PRIO_MAX-1.
|
| The idea of cleaning up the magic numbers is fine, otherwise..

Thanks Alan and Robert.
Yes, I also prefer to remove magic numbers like these.
Here's a corrected patch to 2.5.44 with an additional magic#
instance removal.  See any other problems with it?

-- 
~Randy



--- ./kernel/sys.c.nice	Fri Oct 18 21:01:11 2002
+++ ./kernel/sys.c	Wed Oct 23 16:20:54 2002
@@ -236,10 +236,10 @@

 	/* normalize: avoid signed division (rounding problems) */
 	error = -ESRCH;
-	if (niceval < -20)
-		niceval = -20;
-	if (niceval > 19)
-		niceval = 19;
+	if (niceval < PRIO_MIN)
+		niceval = PRIO_MIN;
+	if (niceval > PRIO_MAX - 1)
+		niceval = PRIO_MAX - 1;

 	read_lock(&tasklist_lock);
 	switch (which) {
@@ -301,7 +301,7 @@
 				who = current->pid;
 			p = find_task_by_pid(who);
 			if (p) {
-				niceval = 20 - task_nice(p);
+				niceval = PRIO_MAX - task_nice(p);
 				if (niceval > retval)
 					retval = niceval;
 			}
@@ -310,7 +310,7 @@
 			if (!who)
 				who = current->pgrp;
 			for_each_task_pid(who, PIDTYPE_PGID, p, l, pid) {
-				niceval = 20 - task_nice(p);
+				niceval = PRIO_MAX - task_nice(p);
 				if (niceval > retval)
 					retval = niceval;
 			}
@@ -326,7 +326,7 @@

 			do_each_thread(g, p)
 				if (p->uid == who) {
-					niceval = 20 - task_nice(p);
+					niceval = PRIO_MAX - task_nice(p);
 					if (niceval > retval)
 						retval = niceval;
 				}
--- ./kernel/sched.c.nice	Tue Oct 22 17:56:13 2002
+++ ./kernel/sched.c	Wed Oct 23 16:28:01 2002
@@ -45,7 +45,7 @@
 /*
  * 'User priority' is the nice value converted to something we
  * can work with better when scaling various scheduler parameters,
- * it's a [ 0 ... 39 ] range.
+ * it's in [ 0 ... 39 ] range.
  */
 #define USER_PRIO(p)		((p)-MAX_RT_PRIO)
 #define TASK_USER_PRIO(p)	USER_PRIO((p)->static_prio)
@@ -1265,7 +1265,7 @@
 	prio_array_t *array;
 	runqueue_t *rq;

-	if (TASK_NICE(p) == nice || nice < -20 || nice > 19)
+	if (TASK_NICE(p) == nice || nice < PRIO_MIN || nice > PRIO_MAX - 1)
 		return;
 	/*
 	 * We have to be careful, if called from sys_setpriority(),
@@ -1317,17 +1317,18 @@
 	if (increment < 0) {
 		if (!capable(CAP_SYS_NICE))
 			return -EPERM;
-		if (increment < -40)
-			increment = -40;
+
+		if (increment < PRIO_MIN - PRIO_MAX)
+			increment = PRIO_MIN - PRIO_MAX;
 	}
-	if (increment > 40)
-		increment = 40;
+	if (increment > (PRIO_MAX - PRIO_MIN))
+		increment = PRIO_MAX - PRIO_MIN;

 	nice = PRIO_TO_NICE(current->static_prio) + increment;
-	if (nice < -20)
-		nice = -20;
-	if (nice > 19)
-		nice = 19;
+	if (nice < PRIO_MIN)
+		nice = PRIO_MIN;
+	if (nice > PRIO_MAX - 1)
+		nice = PRIO_MAX - 1;

 	retval = security_ops->task_setnice(current, nice);
 	if (retval)

###

