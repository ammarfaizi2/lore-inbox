Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261165AbSJCVMu>; Thu, 3 Oct 2002 17:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261207AbSJCVMu>; Thu, 3 Oct 2002 17:12:50 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:8367 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261165AbSJCVMt>;
	Thu, 3 Oct 2002 17:12:49 -0400
Message-ID: <3D9CB35D.90503@us.ibm.com>
Date: Thu, 03 Oct 2002 14:15:09 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [rfc][patch] kernel/sched.c oddness?
References: <Pine.LNX.4.44.0210030840110.4477-100000@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------040007060009040909060702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040007060009040909060702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> this was done intentionally, and this scenario (1+2 tasks) is the very
> worst scenario. The problem is that by trying to balance all 3 tasks we
> now have 3 tasks that trash their cache going from one CPU to another.  
> (this is what happens with your patch - even with another approach we'd
> have to trash at least one task)
> 
> By keeping 2 tasks on one CPU and 1 task on the other CPU we avoid
> cross-CPU migration of threads. Think about the 2+3 or 4+5 tasks case
> rather, do we want absolutely perfect balancing, or good SMP affinity and
> good combined performance?
OK...  But what about the (imbalance / 2) part?  Either the comment 
needs to change, or the code.  Attatched is a slightly revised patch for 
the code.  The comment patch would be even easier:

- 
/* It needs an at least ~25% imbalance to trigger balancing. */
+ 
/* It needs an at least ~50% imbalance to trigger balancing. */

Either way works for me.  I'd like to see something done, as the 
comments don't match the code right now...

Cheers!

-Matt

--------------040007060009040909060702
Content-Type: text/plain;
 name="sched_cleanup-2.5.40.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched_cleanup-2.5.40.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.40-vanilla/kernel/sched.c linux-2.5.40-sched_cleanup/kernel/sched.c
--- linux-2.5.40-vanilla/kernel/sched.c	Tue Oct  1 00:07:35 2002
+++ linux-2.5.40-sched_cleanup/kernel/sched.c	Thu Oct  3 14:09:31 2002
@@ -689,10 +689,10 @@
 	if (likely(!busiest))
 		goto out;
 
-	*imbalance = (max_load - nr_running) / 2;
+	*imbalance = max_load - nr_running;
 
 	/* It needs an at least ~25% imbalance to trigger balancing. */
-	if (!idle && (*imbalance < (max_load + 3)/4)) {
+	if (!idle && (*imbalance <= (max_load + 3)/4)) {
 		busiest = NULL;
 		goto out;
 	}
@@ -746,6 +746,11 @@
 	task_t *tmp;
 
 	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance);
+	/*
+	 * We only want to steal a number of tasks equal to 1/2 the imbalance,
+ 	 * otherwise, we'll just shift the imbalance to the new queue.
+	 */
+	imbalance /= 2;
 	if (!busiest)
 		goto out;
 

--------------040007060009040909060702--

