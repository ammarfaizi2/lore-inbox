Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTJIIvX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 04:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbTJIIvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 04:51:22 -0400
Received: from dp.samba.org ([66.70.73.150]:53672 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261939AbTJIIvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 04:51:15 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] More barriers in module code.
Date: Thu, 09 Oct 2003 18:50:28 +1000
Message-Id: <20031009085114.231B52C23B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul McKenney convinced me that there's no *guarantee* that all archs
will refuse the speculate the atomic ops above the state test, eg:

CPU0 (stopref_set_state)		CPU1 (stopref)

 atomic_set(&ack, 0);			if (state == XXX)
 wmb();						atomic_inc(&ack);
 state = XXX;

Certainly Alpha needs a rmb() inside stopref to guarantee it sees
the same ordering.
---
Linus, please apply.

Name: More Barriers for Module Stopref Threads
Author: Rusty Russell
Status: Trivial

D: Paul McKenney convinced me that there's no *guarantee* that all archs
D: will refuse the speculate the atomic ops above the state test, eg:
D:
D:  CPU0 (stopref_set_state)			CPU1 (stopref)
D: 
D:  atomic_set(&ack, 0);			if (state == XXX)
D:  wmb();						atomic_inc(&ack);
D:  state = XXX;
D:
D: Certainly Alpha needs a rmb() inside stopref to guarantee it sees
D: the same ordering.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.69-bk6/kernel/module.c working-2.5.69-bk6-stopref/kernel/module.c
--- linux-2.5.69-bk6/kernel/module.c	2003-05-05 12:37:13.000000000 +1000
+++ working-2.5.69-bk6-stopref/kernel/module.c	2003-05-12 14:26:58.000000000 +1000
@@ -311,6 +311,7 @@ static int stopref(void *cpu)
 	set_cpus_allowed(current, 1UL << (unsigned long)cpu);
 
 	/* Ack: we are alive */
+	mb(); /* Theoretically the ack = 0 might not be on this CPU yet. */
 	atomic_inc(&stopref_thread_ack);
 
 	/* Simple state machine */
@@ -319,11 +320,13 @@ static int stopref(void *cpu)
 			local_irq_disable();
 			irqs_disabled = 1;
 			/* Ack: irqs disabled. */
+			mb(); /* Must read state first. */
 			atomic_inc(&stopref_thread_ack);
 		} else if (stopref_state == STOPREF_PREPARE && !prepared) {
 			/* Everyone is in place, hold CPU. */
 			preempt_disable();
 			prepared = 1;
+			mb(); /* Must read state first. */
 			atomic_inc(&stopref_thread_ack);
 		}
 		if (irqs_disabled || prepared)
@@ -333,6 +336,7 @@ static int stopref(void *cpu)
 	}
 
 	/* Ack: we are exiting. */
+	mb(); /* Must read state first. */
 	atomic_inc(&stopref_thread_ack);
 
 	if (irqs_disabled)

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
