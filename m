Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136478AbRD3IAb>; Mon, 30 Apr 2001 04:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136479AbRD3IAY>; Mon, 30 Apr 2001 04:00:24 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:12691 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S136478AbRD3IAJ>; Mon, 30 Apr 2001 04:00:09 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 30 Apr 2001 01:00:00 -0700
Message-Id: <200104300800.BAA02079@adam.yggdrasil.com>
To: jgarzik@mandrakesoft.com, mpakovic@fdn.com
Subject: Re: 2.4.4 fork.c changes cause linuxconf to fail
Cc: hahn@coffee.psychology.mcmaster.ca, linux-kernel@vger.kernel.org,
        peter.osterlund@mailbox.swipnet.se, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>Michael Pakovic wrote:
>> The changes to kernel/fork.c from 2.4.4-pre1 to 2.4.4-pre3 (and in
>> 2.4.4) cause the RedHat 6.2 linuxconf utility to fail with the message
>> "broken pipe".  The linuxconf utility will run the first time, but all
>> subsequent runs give the "broken pipe" error.  The error message is
>> generated as a result of a fflush command in linuxconf.  I can provide
>> more information upon request.

>This patch is definitely breaking things, but AFAIK the fork.c change
>only breaks buggy applications...  Adam would you say that assertion is
>correct?

	Yes, and they're probably all bugs that were biting us
sporadically before.  We should take the opportunity to squash them
while they're out in the open.

	We'd better squash those bugs quickly too, because Peter
Osterlund has produced a patch that runs the child first without
giving all of the CPU allocation to the child, and this apparently
is enough to eliminate the problems people have been seeing while
retaining the benefit of running the child first.  So, I imagine
2.4.5 will not expose these problems.

	Peter emailed his patch to linux-kernel, but, for some reason, I
have only seen the copy that was cc'ed directly to me.  I have tried his
patch and added two lines so that the child is still run first even
when current->counter == 0 (stealing some CPU allocation to do so).
I have not benchmarked it, but I do know from testing that without
my addition, the parent would still run first about a 1/4-1/5th of
the time (consistent with the Linux's allocation of 5 ticks to a
regular priority process), and, with this patch, that reduces to about
1/30th.  If the performance benefit of running the child first is
noticible on bencharks, it should be worth doing it the other 20%
of the time as well.  Anyhow, here is my modification of Peter Osterlund's
patch, against 2.4.4:


--- linux-2.4.4/kernel/fork.c	Thu Apr 26 06:11:17 2001
+++ linux/kernel/fork.c	Mon Apr 30 00:37:30 2001
@@ -666,16 +666,20 @@
 	p->pdeath_signal = 0;
 
 	/*
-	 * Give the parent's dynamic priority entirely to the child.  The
-	 * total amount of dynamic priorities in the system doesn't change
-	 * (more scheduling fairness), but the child will run first, which
-	 * is especially useful in avoiding a lot of copy-on-write faults
-	 * if the child for a fork() just wants to do a few simple things
-	 * and then exec(). This is only important in the first timeslice.
-	 * In the long run, the scheduling behavior is unchanged.
+	 * "share" dynamic priority between parent and child, thus the
+	 * total amount of dynamic priorities in the system doesn't change,
+	 * more scheduling fairness. The parent yields to let the child run
+	 * first, which is especially useful in avoiding a lot of
+	 * copy-on-write faults if the child for a fork() just wants to do a
+	 * few simple things and then exec(). This is only important in the
+	 * first timeslice. In the long run, the scheduling behavior is
+	 * unchanged.
 	 */
-	p->counter = current->counter;
-	current->counter = 0;
+	p->counter = (current->counter + 1) >> 1;
+	if (p->counter == 0)
+		p->counter = 1;
+	current->counter >>= 1;
+	current->policy |= SCHED_YIELD;
 	current->need_resched = 1;
 
 	/*
