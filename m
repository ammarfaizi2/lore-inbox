Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135695AbRD2I2U>; Sun, 29 Apr 2001 04:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135698AbRD2I2K>; Sun, 29 Apr 2001 04:28:10 -0400
Received: from fep03.swip.net ([130.244.199.131]:20934 "EHLO
	fep03-svc.swip.net") by vger.kernel.org with ESMTP
	id <S135695AbRD2I1x>; Sun, 29 Apr 2001 04:27:53 -0400
Date: Sun, 29 Apr 2001 10:26:57 +0200 (CEST)
From: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
X-X-Sender: <petero@ppro.localdomain>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 sluggish under fork load
In-Reply-To: <Pine.LNX.4.21.0104281928080.10759-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0104291017370.2060-100000@ppro.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Apr 2001, Linus Torvalds wrote:

> > could we leave it at half, but set the parent to SCHED_YIELD?
>
> Sounds like a good idea. Peter, how does that feel to you? I bet that I'v
> enever seen it simply because all my machines are (a) much too powerful
> for any reasonable use and (b) SMP.

That seems to work. The scheduling delays are back to 20ms and the
sluggishness feeling is gone. I wrote a simple test program to verify that
the child is still scheduled before the parent, so the performance
advantage should still be there. The only annoying thing is that it hides
the bash bug ;)

Patch below:

--- linux-2.4.4.orig/kernel/fork.c	Sat Apr 28 10:17:00 2001
+++ linux-2.4.4/kernel/fork.c	Sun Apr 29 10:06:42 2001
@@ -666,16 +666,18 @@
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
+	current->counter >>= 1;
+	current->policy |= SCHED_YIELD;
 	current->need_resched = 1;

 	/*

-- 
Peter Österlund             peter.osterlund@mailbox.swipnet.se
Sköndalsvägen 35            http://home1.swipnet.se/~w-15919
S-128 66 Sköndal            +46 8 942647
Sweden


