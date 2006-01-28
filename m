Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWA1RDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWA1RDg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 12:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWA1RDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 12:03:36 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:31914 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751055AbWA1RDf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 12:03:35 -0500
Date: Sat, 28 Jan 2006 22:33:02 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: paulmck@us.ibm.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: RCU latency regression in 2.6.16-rc1
Message-ID: <20060128170302.GB5633@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060124081301.GC25855@elte.hu> <1138090527.2771.91.camel@mindpipe> <20060124091730.GA31204@us.ibm.com> <20060124092330.GA7060@elte.hu> <1138095856.2771.103.camel@mindpipe> <20060124162846.GA7139@in.ibm.com> <20060124213802.GC7139@in.ibm.com> <1138224506.3087.22.camel@mindpipe> <20060126191809.GC6182@us.ibm.com> <1138388123.3131.26.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138388123.3131.26.camel@mindpipe>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 01:55:22PM -0500, Lee Revell wrote:
> On Thu, 2006-01-26 at 11:18 -0800, Paul E. McKenney wrote:
> > >     Xorg-2154  0d.s.  213us : call_rcu_bh (rt_run_flush)
> > >     Xorg-2154  0d.s.  215us : local_bh_enable (rt_run_flush)
> > >     Xorg-2154  0d.s.  222us : local_bh_enable (rt_run_flush)
> > >     Xorg-2154  0d.s.  223us : call_rcu_bh (rt_run_flush)
> > > 
> > > [ zillions of these deleted ]
> > > 
> > >     Xorg-2154  0d.s. 7335us : local_bh_enable (rt_run_flush)
> > 
> > Dipankar's latest patch should hopefully address this problem.
> > 
> > Could you please give it a spin when you get a chance? 
> 
> Nope, no improvement at all, furthermore, the machine locked up once
> under heavy disk activity.
> 
> I just got an 8ms+ latency from rt_run_flush that looks basically
> identical to the above.  It's still flushing routes in huge batches:

I am not supprised that the earlier patch doesn't help your
test. Once you reach the high watermark, the "desperation mode"
latency can be fairly bad since the RCU batch size is pretty
big.

How about trying out the patch included below ? It doesn't reduce
amount of work done from softirq context, but decreases the
*number of RCUs* generated during rt_run_flush() by using
one RCU per hash chain. Can you check if this makes any
difference ?

Thanks
Dipankar


Reduce the number of RCU callbacks by flushing one hash chain
at a time. This is intended to reduce RCU overhead during
frequent flushing.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
---


 net/ipv4/route.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff -puN net/ipv4/route.c~rcu-rt-flush-list net/ipv4/route.c
--- linux-2.6.16-rc1-rcu/net/ipv4/route.c~rcu-rt-flush-list	2006-01-28 20:34:10.000000000 +0530
+++ linux-2.6.16-rc1-rcu-dipankar/net/ipv4/route.c	2006-01-28 21:30:27.000000000 +0530
@@ -670,13 +670,23 @@ static void rt_check_expire(unsigned lon
 	mod_timer(&rt_periodic_timer, jiffies + ip_rt_gc_interval);
 }
 
+static void rt_list_free(struct rcu_head *head)
+{
+	struct rtable *next, *rth;
+	rth = container_of(head, struct rtable, u.dst.rcu_head);
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
 
@@ -689,10 +699,8 @@ static void rt_run_flush(unsigned long d
 			rt_hash_table[i].chain = NULL;
 		spin_unlock_bh(rt_hash_lock_addr(i));
 
-		for (; rth; rth = next) {
-			next = rth->u.rt_next;
-			rt_free(rth);
-		}
+		if (rth)
+			call_rcu_bh(&rth->u.dst.rcu_head, rt_list_free);
 	}
 }
 

_
