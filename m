Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133074AbRDLIzf>; Thu, 12 Apr 2001 04:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133078AbRDLIzZ>; Thu, 12 Apr 2001 04:55:25 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:55225 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S133074AbRDLIzR>; Thu, 12 Apr 2001 04:55:17 -0400
Date: Thu, 12 Apr 2001 01:55:16 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: PATCH(?): linux-2.4.4-pre2: fork should run child first
Message-ID: <20010412015516.A335@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	I remember sometime in the late 80's a fellow at UniSoft
named Don whose last name escapes me just now told me about a
paper presented at a Usenix symposium that had some measurements
that purported that copy-on-write was a performance lose and
better performance would be achieve by having fork() just copy
all of the writable pages of the parent process.

	It turned out that the particular unix-like system on which
these benchmarks were taken had a version of fork that did not run
the child first.  As it was explained to me then, most of the time,
the child process from a fork will do just a few things and then do
an exec(), releasing its copy-on-write references to the parent's
pages, and that is the big win of copy-on-write for fork() in practice.
This oversight was considered a big embarassment for the operating
system in question, so I won't name it here.

	Guess why you're seeing this email.  That's right.  Linux-2.4.3's
fork() does not run the child first.  Consequently, the parent will
probably generate unnecessary copy-on-write page copies until it burns
through its remaining clock ticks (any COW's that the child causes will
basically happen no matter what the order of execution is) or calls
wait() (and while the wait is blocking, the parent's CPU priority will
decay as the scheduler periodically recalculates process priorities, so
that bit of dynamic priority has probably not been allocated where the
user will be able to use it, if we want to look at "fairness" in such
detail).

	I suppose that running the child first also has a minor
advantage for clone() in that it should make programs that spawn lots
of threads to do little bits of work behave better on machines with a
small number of processors, since the threads that do so little work that
they accomplish they finish within their time slice will not pile up
before they have a chance to run.  So, rather than give the parent's CPU
priority to the child only if CLONE_VFORK is not set, I have decided to
do a bit of machete surgery and have the child always inherit all of the
parent's CPU priority all of the time.  It simplifies the code and
probably saves a few clock cycles (and before you say that this will
cost a context switch, consider that the child will almost always run
at least one time slice anyhow).

	I have attached the patch below.  I have also adjusted the
comment describing the code.  Please let me know if this hand waving
explanation is sufficient.  I'm trying to be lazy on not do a measurement
project to justify this relatively simple change.  However, I do know, from
a simple test program ("printf ("%d", fork());"), that this patch has
the intended effect of running the child first.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fork.patch"

--- linux-2.4.4-pre2/kernel/fork.c	Thu Apr 12 01:31:53 2001
+++ linux/kernel/fork.c	Thu Apr 12 01:35:53 2001
@@ -666,15 +666,17 @@
 	p->pdeath_signal = 0;
 
 	/*
-	 * "share" dynamic priority between parent and child, thus the
-	 * total amount of dynamic priorities in the system doesnt change,
-	 * more scheduling fairness. This is only important in the first
-	 * timeslice, on the long run the scheduling behaviour is unchanged.
+	 * Give the parent's dynamic priority entirely to the child.  The
+	 * total amount of dynamic priorities in the system doesn't change
+	 * (more scheduling fairness), but the child will run first, which
+	 * is especially useful in avoiding a lot of copy-on-write faults
+	 * if the child for a fork() just wants to do a few simple things
+	 * and then exec(). This is only important in the first timeslice.
+	 * In the long run, the scheduling behavior is unchanged.
 	 */
-	p->counter = (current->counter + 1) >> 1;
-	current->counter >>= 1;
-	if (!current->counter)
-		current->need_resched = 1;
+	p->counter = current->counter;
+	current->counter = 0;
+	current->need_resched = 1;
 
 	/*
 	 * Ok, add it to the run-queues and make it

--1yeeQ81UyVL57Vl7--
