Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262625AbSJIW5t>; Wed, 9 Oct 2002 18:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbSJIW5t>; Wed, 9 Oct 2002 18:57:49 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:6025 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S262625AbSJIW5r>; Wed, 9 Oct 2002 18:57:47 -0400
From: Erich Focht <efocht@ess.nec.de>
To: Andrew Theurer <habanero@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [PATCH] pooling NUMA scheduler with initial load balancing
Date: Thu, 10 Oct 2002 01:02:13 +0200
User-Agent: KMail/1.4.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
References: <200210091826.20759.efocht@ess.nec.de> <1548227964.1034159598@[10.10.2.3]> <200210091258.08379.habanero@us.ibm.com>
In-Reply-To: <200210091258.08379.habanero@us.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_PBLQBI614C5ED6LY5TJN"
Message-Id: <200210100102.13980.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_PBLQBI614C5ED6LY5TJN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> > Starting migration thread for cpu 3
> > Bringing up 4
> > CPU>dividNOWrro!
>
> I got the same thing on 2.5.40-mm1.  It looks like it may be a a divide=
 by
> zero in calc_pool_load.  I am attempting to boot a band-aid version rig=
ht
> now.  OK, got a little further:
This opened my eyes, thanks for all your help and patience!!!

The problem is that the load balancer is called before the CPU pools
were set up. That's fine, I thought, because I define in sched_init
the default pool 0 to include all CPUs. But: in find_busiest_queue()
the cpu_to_node(this_cpu) delivers a non-zero pool which is not set up
yet, therefore pool_nr_cpus[pool]=3D0 and we get a zero divide.

I'm still wondering why this doesn't happen on our architecture. Maybe
the interrupts are disabled longer, I'll check. Anyway, a fix is to
force this_pool to be 0 as long as numpools=3D1. The attached patch is a
quick untested hack, maybe one can do it better. Has to be applied on top
of the other 2.

Going to sleep now...

Bye,
Erich

--------------Boundary-00=_PBLQBI614C5ED6LY5TJN
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="01a-numa_sched_fix-2.5.39.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="01a-numa_sched_fix-2.5.39.patch"

diff -urNp 2.5.39-disc-ns/kernel/sched.c 2.5.39-disc-ns8/kernel/sched.c
--- 2.5.39-disc-ns/kernel/sched.c	Wed Oct  9 17:06:04 2002
+++ 2.5.39-disc-ns8/kernel/sched.c	Thu Oct 10 00:51:20 2002
@@ -774,7 +774,7 @@ static inline runqueue_t *find_busiest_q
 	runqueue_t *busiest = NULL;
 	int imax, best_cpu, pool, max_pool_load, max_pool_idx;
 	int i, del_shift;
-	int avg_load=-1, this_pool = cpu_to_node(this_cpu);
+	int avg_load=-1, this_pool;
 
 	/* Need at least ~25% imbalance to trigger balancing. */
 #define BALANCED(m,t) (((m) <= 1) || (((m) - (t))/2 < (((m) + (t))/2 + 3)/4))
@@ -784,10 +784,13 @@ static inline runqueue_t *find_busiest_q
 	else
 		*nr_running = this_rq->prev_nr_running[this_cpu];
 
+	this_pool = (numpools == 1 ? 0 : cpu_to_node(this_cpu));
 	best_cpu = calc_pool_load(this_rq->load, this_cpu, this_pool, idle);
 	
 	if (best_cpu != this_cpu)
 		goto check_out;
+	else if (numpools == 1)
+		goto out;
 
  scan_all:
 	best_cpu = -1;
@@ -830,7 +833,7 @@ static inline runqueue_t *find_busiest_q
 	if (!BALANCED(this_rq->load[0][best_cpu],*nr_running)) {
 		busiest = cpu_rq(best_cpu);
 		this_rq->wait_node = -1;
-	} else if (avg_load == -1)
+	} else if (avg_load == -1 && numpools > 1)
 		/* only scanned local pool, so let's look at all of them */
 		goto scan_all;
  out:

--------------Boundary-00=_PBLQBI614C5ED6LY5TJN--

