Return-Path: <linux-kernel-owner+w=401wt.eu-S1753148AbWLWLBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148AbWLWLBx (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 06:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753239AbWLWLBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 06:01:53 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:57705 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753148AbWLWLBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 06:01:52 -0500
Date: Sat, 23 Dec 2006 11:59:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Tim C" <tim.c.chen@intel.com>
Cc: linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: 2.6.19-rt14 slowdown compared to 2.6.19
Message-ID: <20061223105937.GA21172@elte.hu>
References: <9D2C22909C6E774EBFB8B5583AE5291C0199950A@fmsmsx414.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <9D2C22909C6E774EBFB8B5583AE5291C0199950A@fmsmsx414.amr.corp.intel.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Chen, Tim C <tim.c.chen@intel.com> wrote:

> Ingo,
>  
> We did some benchmarking on 2.6.19-rt14, compared it with 2.6.19 
> kernel and noticed several slowdowns.  The test machine is a 2 socket 
> woodcrest machine with your default configuration.

cool - thanks for the feedback! Running the 64-bit kernel, right?

> Netperf TCP Streaming was slower by 40% ( 1 server and 1 client each 
> bound to separate cpu cores on different socket, network loopback mode 
> was used).
> 
> Volanomark was slower by 80% (Server and Clients communicate with 
> network loopback mode. Idle time goes from 1% to 60%)
> 
> Re-Aim7 was slower by 40% (idle time goes from 0% to 20%)
> 
> Wonder if you have any suggestions on what could cause the slowdown.  
> We've tried disabling CONFIG_NO_HZ and it didn't help much.

while some slowdown is to be expected, did in each case idle time 
increase significantly? If yes then this is the effect of lock 
contention. Lock contention effects are 'magnified' by PREEMPT_RT. For 
example if you run 128 threads workload that all use the same lock then 
the -rt kernel can act as if it were a 128-way box (!). This way by 
running -rt you'll see scalability problems alot sooner than on real 
hardware. In other words: PREEMPT_RT in essence simulates the 
scalability behavior of up to an infinite amount of CPUs. (with the 
exception of cachemiss emulation ;) [the effect is not this precise, but 
that's the rough trend]

the good news: any fix for such problems in -rt is useful for the 
upstream kernel too, because it improves scalability on real hardware as 
well. The bad news: this work hasnt been finished yet ;-)

We've fixed a couple of contention points discovered by -rt this way, in 
particular Peter's excellent scalability patches at:

  http://programming.kicks-ass.net/kernel-patches/

were done based on lock-contention profiling feedback. I've included the 
lockless pagecache and the s_files scalability patches which were very 
useful already. The lru_cache_add one is the next one for me to try, 
plus on i686 -rt kernels highmem locking hurts, hence the 
highmem_rewrite.patch (not in -rt yet either). Plus there's the really 
exciting concurrent-pagecache patch-queue from Peter, which will be 
interesting to try too.

If you'd like to profile this yourself then the lowest-cost way of 
profiling lock contention on -rt is to use the yum kernel and run the 
attached trace-it-lock-prof.c code on the box while your workload is in 
'steady state' (and is showing those extended idle times):

  ./trace-it-lock-prof > trace.txt

this captures up to 1 second worth of system activity, on the current 
CPU. Then you can construct the histogram via:

  grep -A 1 ' __schedule()<-' trace.txt | cut -d: -f2- | sort |
                                  uniq -c | sort -n > prof.txt

i just did this for "hackbench 20", and it gave me:

     38  kfree()<-skb_release_data()<-kfree_skbmem()<-(-1)()
     40  kmem_cache_free()<-kfree_skbmem()<-__kfree_skb()<-(-1)()
     47  __schedule()<-preempt_schedule_irq()<-retint_kernel()<-__spin_unlock_irqrestore()
    173  rt_read_lock()<-sock_def_readable()<-unix_stream_sendmsg()<-(-1)()
    173  __schedule()<-schedule()<-rt_spin_lock_slowlock()<-__lock_text_start()
    274  __schedule()<-schedule()<-posix_cpu_timers_thread()<-kthread()
    277  __schedule()<-schedule()<-ksoftirqd()<-kthread()
    365  kmem_cache_alloc_node()<-__alloc_skb()<-sock_alloc_send_skb()<-(-1)()
    366  kmem_cache_alloc_node()<-__kmalloc_node()<-__alloc_skb()<-(-1)()
    814  __schedule()<-schedule()<-rt_spin_lock_slowlock()<-rt_spin_lock()
   1819  __schedule()<-schedule()<-int_careful()<-<ffffe405>()
   2346  __schedule()<-schedule()<-schedule_timeout()<-unix_stream_recvmsg()
   2346  sock_aio_read()<-do_sync_read()<-vfs_read()<-(-1)()

(note the output mixes the two lines of symbolic stack backtrace entries 
that are generated by the tracer, so the last two lines for example are 
for the same contention/preemption point.)

this means that the biggest contention points (or natural rescheduling 
points) in this workload are sock_aio_read()->unix_stream_recvmsg() - 
not unexpected. But there's also ~10% of contention in the kmalloc code, 
meaning that for this workload the per-CPU slabs are probably set a bit 
too low. There's also ~5% of contention from sock_def_readable()'s use 
of an rwlock.

with more CPUs and more tasks you'll see these effects in a more drastic 
way.

	Ingo

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="trace-it-lock-prof.c"


/*
 * Copyright (C) 2005, Ingo Molnar <mingo@redhat.com>
 *
 * user-triggered tracing.
 *
 * The -rt kernel has a built-in kernel tracer, which will trace
 * all kernel function calls (and a couple of special events as well),
 * by using a build-time gcc feature that instruments all kernel
 * functions.
 * 
 * The tracer is highly automated for a number of latency tracing purposes,
 * but it can also be switched into 'user-triggered' mode, which is a
 * half-automatic tracing mode where userspace apps start and stop the
 * tracer. This file shows a dumb example how to turn user-triggered
 * tracing on, and how to start/stop tracing. Note that if you do
 * multiple start/stop sequences, the kernel will do a maximum search
 * over their latencies, and will keep the trace of the largest latency
 * in /proc/latency_trace. The maximums are also reported to the kernel
 * log. (but can also be read from /proc/sys/kernel/preempt_max_latency)
 *
 * For the tracer to be activated, turn on CONFIG_WAKEUP_TIMING and
 * CONFIG_LATENCY_TRACE in the .config, rebuild the kernel and boot
 * into it. Note that the tracer can have significant runtime overhead,
 * so you dont want to use it for performance testing :)
 */

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/wait.h>
#include <sys/prctl.h>
#include <linux/unistd.h>

int main (int argc, char **argv)
{
	int ret;

	if (getuid() != 0) {
		fprintf(stderr, "needs to run as root.\n");
		exit(1);
	}
	ret = system("cat /proc/sys/kernel/mcount_enabled >/dev/null 2>/dev/null");
	if (ret) {
		fprintf(stderr, "CONFIG_LATENCY_TRACING not enabled?\n");
		exit(1);
	}
	system("echo 1 > /proc/sys/kernel/trace_enabled");
	system("echo 0 > /proc/sys/kernel/trace_freerunning");
	system("echo 0 > /proc/sys/kernel/trace_print_at_crash");
	system("echo 1 > /proc/sys/kernel/trace_user_triggered");
	system("echo 1 > /proc/sys/kernel/stackframe_tracing");
	system("echo 0 > /proc/sys/kernel/trace_verbose");
	system("echo 0 > /proc/sys/kernel/preempt_max_latency");
	system("echo 0 > /proc/sys/kernel/preempt_thresh");
	system("[ -e /proc/sys/kernel/wakeup_timing ] && echo 1 > /proc/sys/kernel/wakeup_timing");
	system("echo 0 > /proc/sys/kernel/mcount_enabled");

	// start tracing
	if (prctl(0, 1)) {
		fprintf(stderr, "trace-it: couldnt start tracing!\n");
		return 1;
	}
	usleep(1000000);
	if (prctl(0, 0)) {
		fprintf(stderr, "trace-it: couldnt start tracing!\n");
		return 1;
	}

	system("cat /proc/latency_trace");

	return 0;
}



--sdtB3X0nJg68CQEu--
