Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbUC2W3s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 17:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUC2W3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 17:29:48 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:13466
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263163AbUC2W33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 17:29:29 -0500
Date: Tue, 30 Mar 2004 00:29:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Robert Olsson <Robert.Olsson@data.slu.se>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Dave Miller <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Andrew Morton <akpm@osdl.org>
Subject: Re: route cache DoS testing and softirqs
Message-ID: <20040329222926.GF3808@dualathlon.random>
References: <20040329184550.GA4540@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329184550.GA4540@in.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 12:15:50AM +0530, Dipankar Sarma wrote:
> Robert Olsson noticed dst cache overflows while doing DoS stress testing in a
> 2.6 based router setup a few months and davem, alexey, robert and I
> have been discussing this privately since then (198 mails, no less!!).
> Recently, I set up an environment to test Robert's problem and have 
> been characterizing it. My setup is -
>                                                                                 
> pktgen box --- in router out --
> eth0           eth0 <-> dumm0
>                                                                                 
> 10.0.0.1       10.0.0.2  5.0.0.1
>                                                                                 
> The router box is a 2-way P4 xeon 2.4 GHz with 256MB memory. I use
> Robert's pktgen script -
>                                                                                 
> CLONE_SKB="clone_skb 1"
> PKT_SIZE="pkt_size 60"
> #COUNT="count 0"
> COUNT="count 10000000"
> IPG="ipg 0"
>                                                                                 
> PGDEV=/proc/net/pktgen/eth0
> echo "Configuring $PGDEV"
> pgset "$COUNT"
> pgset "$CLONE_SKB"
> pgset "$PKT_SIZE"
> pgset "$IPG"
> pgset "flag IPDST_RND"
> pgset "dst_min 5.0.0.0"
> pgset "dst_max 5.255.255.255"
> pgset "flows 32768"
> pgset "flowlen 10"
>                                                                                 
> With this, wthin a few seconds of starting pktgen, I get dst cache
> overflow messages. I use the following instrumentation patch
> to look at what's happening -
>                                                                                 
> http://lse.sourceforge.net/locking/rcu/rtcache/pktgen/patches/15-rcu-debug.patch                                                                                
> I tried both vanilla 2.6.0 and 2.6.0 + throttle-rcu patch which limits
> RCU to 4 updates per RCU tasklet. The results are here -
> 
> http://lse.sourceforge.net/locking/rcu/rtcache/pktgen/gracedata/cpu-grace.png
> 
> This graph shows the maximum grace period during ~4ms time buckets on x-axis.
> 
> Couple of things are clear from this -
> 
> 1. RCU grace periods of upto 300ms are seen. 300ms + 100Kpps packet
>    amounts to about 30000 pending dst entries which result in route cache
>    overflow.
> 
> 2. throttle-rcu is only marginally better (10% less worst case grace period).
> 
> So, what causes RCU to stall for 300ms odd time ? I did some measurements
> using the following patch -
> 
> http://lse.sourceforge.net/locking/rcu/rtcache/pktgen/patches/25-softirq-debug.patch
> 
> It applies on top of the 15-rcu-debug patch. This counts the number of
> softirqs (in effect and approximation) during ~4ms time buckets. The
> result is here -
> 
> http://lse.sourceforge.net/locking/rcu/rtcache/pktgen/softirq/cpu-softirq.png
> 
> The rcu grace period spikes are always accompanied by softirq frequency
> spikes. So, this indicates that it is the large number of quick-running
> softirqs that cause userland starvation which in turn result in RCU
> delays. This raises a fundamental question - should we work around
> this by providing a quiescent point at the end of every softirq handler
> (giving softirqs its own RCU mechanism) or should we address a wider
> problem, the system getting overwhelmed by heavy softirq load, and
> try to implement a real softirq throttling mechanism that balances
> cpu use. 
> 
> Robert demonstrated to us sometime ago with a small
> timestamping user program to show that it can get starved for
> more than 6 seconds in his system. So userland starvation is an
> issue.

softirqs are already capable of being offloaded to scheduler-friendy
kernel threads to avoid starvation, if this wasn't the case NAPI would
have no way to work in the first place and everything else would fall
apart too, not just the rcu-route-cache. I don't think high latencies
and starvation are the same thing, starvation means for "indefinite
time" and you can't hang userspace for indefinite time using softirqs.
For sure the irq based load, and in turn softirqs too, can take a large
amount of cpu (though not 100%, this is why it cannot be called
starvation).

the only real starvation you can claim is in presence of an _hard_irq
flood, not a softirq one. Ingo had some patch for the hardirq
throttling, unfortunately those pathes were mixed with irrelevant
softirq changes, but the hardirq part of these patches was certainly
valid (though in most business environments I imagine if one is under
hardirq attack in the local ethernet, the last worry is probably the
throttling of hardirqs ;)

The softirq issue you mention simply shows how these softirqs keeps
being served  with slightly higher prio than the regular kernel code,
and by doing so they make more progress than regular kernel code during
spike of softirq load. The problem with rcu based softirq load, is that
these softirqs requires the scheduler to keep going or they overflow if
they keep running instead of the scheduler. They require the scheduler
to keep up with the softirq load.  This has never been the case so far,
and serving softirq as fast as possible is normally a good thing for
server/firewalls, the small unfariness (note unfariness != starvation)
it generates has never been an issue, because so far the softirq never
required the scheduler to work in order to do their work, rcu changed
this in the routing cache specific case.

So you're simply asking the ksoftirqd offloading to become more
aggressive, and to make the softirq even more scheduler friendly,
something I never had a reason to do yet, since ksoftirqd already
eliminates the starvation issue, and secondly because I did care about
the performance of softirq first (delaying softirqs is derimental for
performance if it happens frequently w/o this kind of flood-load). I
even got a patch for 2.4 doing this kind of changes to the softirqd for
similar reasons on embedded systems where the cpu spent on the softirqs
would been way too much under attack. I had to back it out since it was
causing drop of performance in specweb or something like that and nobody
but the embdedded people needed it.  But now here we've a case where it
makes even more sense since the hardirq aren't strictly related to this
load, this load with the rcu-routing-cache is just about letting the
scheduler go together witn an intensive softirq load. So we can try
again with a truly userspace throttling of the softirqs (and in 2.4 I
didn't change the nice from 19 to -20 so maybe this will just work
perfectly).

btw, the set_current_state(TASK_INTERRUPTIBLE) before
kthread_should_stop seems overkill w.r.t. smp locking, plus the code is
written in the wrong way around, all set_current_state are in the wrong
place. It's harmless but I cleaned up that bit as well.

I would suggest to give this untested patch a try and see if it fixes
your problem completely or not:

--- sles/kernel/softirq.c.~1~	2004-03-29 19:05:17.140586072 +0200
+++ sles/kernel/softirq.c	2004-03-30 00:28:11.097296968 +0200
@@ -58,6 +58,14 @@ static inline void wakeup_softirqd(void)
 		wake_up_process(tsk);
 }
 
+static inline int local_softirqd_running(void)
+{
+	/* Interrupts are disabled: no need to stop preemption */
+	struct task_struct *tsk = __get_cpu_var(ksoftirqd);
+
+	return tsk && tsk->state == TASK_RUNNING;
+}
+
 /*
  * We restart softirq processing MAX_SOFTIRQ_RESTART times,
  * and we fall back to softirqd after that.
@@ -71,13 +79,15 @@ static inline void wakeup_softirqd(void)
 
 asmlinkage void do_softirq(void)
 {
-	int max_restart = MAX_SOFTIRQ_RESTART;
+	int max_restart;
 	__u32 pending;
 	unsigned long flags;
 
-	if (in_interrupt())
+	if (in_interrupt() || local_softirqd_running())
 		return;
 
+	max_restart = MAX_SOFTIRQ_RESTART;
+
 	local_irq_save(flags);
 
 	pending = local_softirq_pending();
@@ -308,16 +318,14 @@ void __init softirq_init(void)
 
 static int ksoftirqd(void * __bind_cpu)
 {
-	set_user_nice(current, 19);
+	set_user_nice(current, -20);
 	current->flags |= PF_IOTHREAD;
 
-	set_current_state(TASK_INTERRUPTIBLE);
-
 	while (!kthread_should_stop()) {
-		if (!local_softirq_pending())
+		if (!local_softirq_pending()) {
+			__set_current_state(TASK_INTERRUPTIBLE);
 			schedule();
-
-		__set_current_state(TASK_RUNNING);
+		}
 
 		while (local_softirq_pending()) {
 			/* Preempt disable stops cpu going offline.
@@ -331,20 +339,16 @@ static int ksoftirqd(void * __bind_cpu)
 			cond_resched();
 		}
 
-		__set_current_state(TASK_INTERRUPTIBLE);
 	}
-	__set_current_state(TASK_RUNNING);
 	return 0;
 
 wait_to_die:
 	preempt_enable();
 	/* Wait for kthread_stop */
-	__set_current_state(TASK_INTERRUPTIBLE);
 	while (!kthread_should_stop()) {
-		schedule();
 		__set_current_state(TASK_INTERRUPTIBLE);
+		schedule();
 	}
-	__set_current_state(TASK_RUNNING);
 	return 0;
 }
 
