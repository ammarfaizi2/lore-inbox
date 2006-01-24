Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030416AbWAXQ5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbWAXQ5w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 11:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWAXQ5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 11:57:52 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:12176 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964999AbWAXQ5v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 11:57:51 -0500
Date: Tue, 24 Jan 2006 22:27:27 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: RCU latency regression in 2.6.16-rc1
Message-ID: <20060124165727.GB7139@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <1138089139.2771.78.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138089139.2771.78.camel@mindpipe>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 02:52:18AM -0500, Lee Revell wrote:
> I ported the latency tracer to 2.6.16 and got this 13ms latency within a
> few hours.  This is a regression from 2.6.15.
> 
> It appears that RCU can invoke ipv4_dst_destroy thousands of times in a
> single batch.
> 
>   <idle>-0     0d.s.  143us : tasklet_action (__do_softirq)
>   <idle>-0     0d.s.  143us : rcu_process_callbacks (tasklet_action)
>   <idle>-0     0d.s.  144us : __rcu_process_callbacks (rcu_process_callbacks)
>   <idle>-0     0d.s.  145us : __rcu_process_callbacks (rcu_process_callbacks)
>   <idle>-0     0d.s.  146us : dst_rcu_free (__rcu_process_callbacks)
>   <idle>-0     0d.s.  147us : dst_destroy (dst_rcu_free)
>   <idle>-0     0d.s.  148us : ipv4_dst_destroy (dst_destroy)
>   <idle>-0     0d.s.  149us : kmem_cache_free (dst_destroy)
> 
> [ etc - zillions of dst_rcu_free()s deleted ]

Are these predominantly coming from rt_run_flush() ? I had an old
patch that frees one hash chain per RCU callback. However the
cost of each RCU callback goes up here, so I am not sure whether
that helps. Atleast with shorter RCU callbacks, you get a chance
for preemption after the tasklet softirq has happened a few
times. Can you describe what you are running in your system ?
My old rt-flush-list patch is included below for reference.

Thanks
Dipankar



Reduce the number of RCU callbacks by flushing one hash chain
at a time. This is intended to reduce softirq overhead during
frequent flushing.


 net/ipv4/route.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff -puN net/ipv4/route.c~rcu-rt-flush-list net/ipv4/route.c
--- linux-2.6.0-test2-rcu/net/ipv4/route.c~rcu-rt-flush-list	2003-08-13 21:46:35.000000000 +0530
+++ linux-2.6.0-test2-rcu-dipankar/net/ipv4/route.c	2003-08-27 14:17:54.000000000 +0530
@@ -521,13 +521,22 @@ static void rt_check_expire(unsigned lon
 	mod_timer(&rt_periodic_timer, now + ip_rt_gc_interval);
 }
 
+static void rt_list_free(struct rtable *rth)
+{
+	struct rtable *next;
+	for (; rth; rth = next) {
+		next = rth->u.rt_next;
+		dst_free(&rth->u.dst);
+	}
+}
+
 /* This can run from both BH and non-BH contexts, the latter
  * in the case of a forced flush event.
  */
 static void rt_run_flush(unsigned long dummy)
 {
 	int i;
-	struct rtable *rth, *next;
+	struct rtable *rth;
 
 	rt_deadline = 0;
 
@@ -539,11 +548,9 @@ static void rt_run_flush(unsigned long d
 		if (rth)
 			rt_hash_table[i].chain = NULL;
 		spin_unlock_bh(&rt_hash_table[i].lock);
-
-		for (; rth; rth = next) {
-			next = rth->u.rt_next;
-			rt_free(rth);
-		}
+		if (rth)
+			call_rcu_bh(&rth->u.dst.rcu_head, 
+				(void (*)(void *))rt_list_free, rth);
 	}
 }
 

_
