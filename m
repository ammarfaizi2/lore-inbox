Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVFKFW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVFKFW6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 01:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVFKFW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 01:22:58 -0400
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:61103 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261246AbVFKFWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 01:22:53 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: 2.6.12-rc6-mm1
Date: Sat, 11 Jun 2005 15:22:30 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Nick Piggin <piggin@cyberone.com.au>
References: <20050607170853.3f81007a.akpm@osdl.org> <1155200000.1118447440@flay> <656430000.1118463292@[10.10.2.4]>
In-Reply-To: <656430000.1118463292@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WUnqC9xkEkYUkij"
Message-Id: <200506111522.30765.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_WUnqC9xkEkYUkij
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, 11 Jun 2005 14:14, Martin J. Bligh wrote:
> --"Martin J. Bligh" <mbligh@mbligh.org> wrote (on Friday, June 10, 2005 > > 
OK, I backed out those 4, and the degredation mostly went away.
> > See
> > http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/perf/kernbench.
> >moe.png
> >
> > and more specifically, see the +p5150 near the right hand side.
> > I don't think it's quite as good as mainline, but much closer.
> > I did this run with HZ=1000, and the the one with no scheduler
> > patches at all with HZ=250, so I'll try to do a run that's more
> > directly comparable as well
>
> OK, that makes it look much more like mainline. Looks like you were still
> revising the details of your patch Con ... once you're ready, drop me a
> URL for it, and I'll make the system whack on that too.

Great thanks. Here are rolled up all the reconsidered changes that apply 
directly to 2.6.12-rc6-mm1 -purely for testing purposes-. I'd be very 
grateful to see how this performed; it has been boot and stress tested at 
this end. If it shows detriment I'll have to make the smp nice changes more 
complex.

Cheers,
Con

--Boundary-00=_WUnqC9xkEkYUkij
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.12-rc6-mm1-mjbtest.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="2.6.12-rc6-mm1-mjbtest.patch"

Index: linux-2.6.12-rc6-mm1/kernel/sched.c
===================================================================
--- linux-2.6.12-rc6-mm1.orig/kernel/sched.c	2005-06-10 23:56:56.000000000 +1000
+++ linux-2.6.12-rc6-mm1/kernel/sched.c	2005-06-11 11:48:09.000000000 +1000
@@ -978,7 +978,7 @@ static inline unsigned long __source_loa
 	else
 		source_load = min(cpu_load, load_now);
 
-	if (idle == NOT_IDLE || rq->nr_running > 1)
+	if (rq->nr_running > 1 || (idle == NOT_IDLE && rq->nr_running))
 		/*
 		 * If we are busy rebalancing the load is biased by
 		 * priority to create 'nice' support across cpus. When
@@ -987,7 +987,7 @@ static inline unsigned long __source_loa
 		 * prevent idle rebalance from trying to pull tasks from a
 		 * queue with only one running task.
 		 */
-		source_load *= rq->prio_bias;
+		source_load = source_load * rq->prio_bias / rq->nr_running;
 
 	return source_load;
 }
@@ -1011,8 +1011,8 @@ static inline unsigned long __target_loa
 	else
 		target_load = max(cpu_load, load_now);
 
-	if (idle == NOT_IDLE || rq->nr_running > 1)
-		target_load *= rq->prio_bias;
+	if (rq->nr_running > 1 || (idle == NOT_IDLE && rq->nr_running))
+		target_load = target_load * rq->prio_bias / rq->nr_running;
 
 	return target_load;
 }

--Boundary-00=_WUnqC9xkEkYUkij--
