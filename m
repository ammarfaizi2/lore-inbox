Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261543AbTCGMbt>; Fri, 7 Mar 2003 07:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261546AbTCGMbt>; Fri, 7 Mar 2003 07:31:49 -0500
Received: from mx1.elte.hu ([157.181.1.137]:36020 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261543AbTCGMbs>;
	Fri, 7 Mar 2003 07:31:48 -0500
Date: Fri, 7 Mar 2003 13:41:50 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: NUMA scheduler broken 
In-Reply-To: <200303071151.h27BpB415705@owlet.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0303071339090.10744-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Mar 2003, Rick Lindsley wrote:

> Looks like __activate_task() should call nr_running_inc(rq) rather than
> rq->nr_running++, and the same in wake_up_forked_process().  My guess is
> that the bogus node_nr_running value is causing some really poor
> scheduling decisions to be made on NUMA.  See if that changes your
> result.

indeed. The attached patch (against BK-curr) fixes this.

	Ingo

--- kernel/sched.c.orig	2003-03-07 13:40:53.000000000 +0100
+++ kernel/sched.c	2003-03-07 13:41:19.000000000 +0100
@@ -325,7 +325,7 @@
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
 	enqueue_task(p, rq->active);
-	rq->nr_running++;
+	nr_running_inc(rq);
 }
 
 static inline void activate_task(task_t *p, runqueue_t *rq)
@@ -545,7 +545,7 @@
 		list_add_tail(&p->run_list, &current->run_list);
 		p->array = current->array;
 		p->array->nr_active++;
-		rq->nr_running++;
+		nr_running_inc(rq);
 	}
 	task_rq_unlock(rq, &flags);
 }

