Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUBHAn2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 19:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbUBHAn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 19:43:28 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:22466 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261567AbUBHAn1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 19:43:27 -0500
Message-Id: <200402080040.i180eY811893@owlet.beaverton.ibm.com>
To: Anton Blanchard <anton@samba.org>
cc: Nick Piggin <piggin@cyberone.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1 
In-reply-to: Your message of "Sat, 07 Feb 2004 20:50:57 +1100."
             <20040207095057.GS19011@krispykreme> 
Date: Sat, 07 Feb 2004 16:40:33 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Its got to be an overly enthuiastic active balance, the migration threads 
    have used about 10 minutes of cpu time and a single cpu bound process
    will never sleep (assuming there is nothing else to run) and so cannot be
    moved by normal means.

The current imbalance code rounds up to 1, meaning that we'll often
see an "imbalance" of 1 even when it's 1 to 0 and just been moved.
Did you see these results even with Martin's patch to not round up to 1?

Easiest way to turn off the active balance (for this test, at least)
is this patch which just turns off that code:

diff -rup linux-2.6.2-mm1/kernel/sched.c linux-2.6.2-mm1+/kernel/sched.c
--- linux-2.6.2-mm1/kernel/sched.c	Thu Feb  5 14:47:17 2004
+++ linux-2.6.2-mm1+/kernel/sched.c	Sat Feb  7 16:39:18 2004
@@ -1525,6 +1525,7 @@ out:
 	if (!balanced && nr_moved == 0)
 		failed = 1;
 
+#if 0
 	if (domain->flags & SD_FLAG_IDLE && failed && busiest &&
 	   		domain->nr_balance_failed > domain->cache_nice_tries) {
 		int i;
@@ -1546,6 +1547,7 @@ out:
 				wake_up_process(busiest->migration_thread);
 		}
 	}
+#endif
 
 	if (failed)
 		domain->nr_balance_failed++;

Not the right long-term solution but at least we can pin down where this
obviously incorrect behavior is coming from.

Rick
