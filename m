Return-Path: <linux-kernel-owner+w=401wt.eu-S1754302AbWL3KG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302AbWL3KG7 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 05:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754303AbWL3KG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 05:06:59 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:40347 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754291AbWL3KG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 05:06:57 -0500
Date: Sat, 30 Dec 2006 11:04:21 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Tim C" <tim.c.chen@intel.com>
Cc: linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: 2.6.19-rt14 slowdown compared to 2.6.19
Message-ID: <20061230100421.GB26996@elte.hu>
References: <20061223105937.GA21172@elte.hu> <9D2C22909C6E774EBFB8B5583AE5291C019F9B16@fmsmsx414.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D2C22909C6E774EBFB8B5583AE5291C019F9B16@fmsmsx414.amr.corp.intel.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chen, Tim C <tim.c.chen@intel.com> wrote:

> Ingo Molnar wrote:
> > 
> > If you'd like to profile this yourself then the lowest-cost way of
> > profiling lock contention on -rt is to use the yum kernel and run the
> > attached trace-it-lock-prof.c code on the box while your workload is
> > in 'steady state' (and is showing those extended idle times):
> > 
> >   ./trace-it-lock-prof > trace.txt
> > 
> > this captures up to 1 second worth of system activity, on the current
> > CPU. Then you can construct the histogram via:
> > 
> >   grep -A 1 ' __schedule()<-' trace.txt | cut -d: -f2- | sort |
> >                                   uniq -c | sort -n > prof.txt
> > 
> 
> I did lock profiling on Volanomark as suggested and obtained the 
> profile that is listed below.

thanks - this is really useful!

>     246  __sched_text_start()<-schedule()<-rt_spin_lock_slowlock()<-__lock_text_start()
>     264  rt_mutex_slowunlock()<-rt_mutex_unlock()<-rt_up_read()<-(-1)()
>     334  __sched_text_start()<-schedule()<-posix_cpu_timers_thread()<-kthread()
>     437  __sched_text_start()<-schedule()<-do_futex()<-sys_futex()
>     467  (-1)()<-(0)()<-(0)()<-(0)()
>     495  __sched_text_start()<-preempt_schedule()<-__spin_unlock_irqrestore()<-rt_mutex_adjust_prio()
>     497  __netif_rx_schedule()<-netif_rx()<-loopback_xmit()<-(-1)()
>     499  __sched_text_start()<-schedule()<-schedule_timeout()<-sk_wait_data()
>     500  tcp_recvmsg()<-sock_common_recvmsg()<-sock_recvmsg()<-(-1)()
>     503  __rt_down_read()<-rt_down_read()<-do_futex()<-(-1)()
>    1160  __sched_text_start()<-schedule()<-ksoftirqd()<-kthread()
>    1433  __rt_down_read()<-rt_down_read()<-futex_wake()<-(-1)()
>    1497  child_rip()<-(-1)()<-(0)()<-(0)()
>    1936  __sched_text_start()<-schedule()<-rt_mutex_slowlock()<-rt_mutex_lock()
> 
> Looks like the idle time I saw was due to lock contention during call 
> to futex_wake, which requires acquisition of current->mm->mmap_sem. 
> Many of the java threads share mm and result in concurrent access to 
> common mm. [...]

ah. This explains why i'm not seeing this bad contention in a comparable 
workload (hackbench.c): because hackbench uses processes not threads.

> [...] Looks like under rt case there is no special treatment to read 
> locking so the read lock accesses are contended under __rt_down_read.  
> For non rt case, __down_read makes the distinction for read lock 
> access and the read lockings do not contend.

yeah, makes sense. I'll do something about this.

> Things are made worse here as this delayed waking up processes locked 
> by the futex. See also a snippet of the latency_trace below.
> 
>   <idle>-0     2D..2 5821us!: thread_return <softirq--31> (150 20)
>   <idle>-0     2DN.1 6278us : __sched_text_start()<-cpu_idle()<-start_secondary()<-(-1)()
>   <idle>-0     2DN.1 6278us : (0)()<-(0)()<-(0)()<-(0)()
>     java-6648  2D..2 6280us+: thread_return <<idle>-0> (20 -4)
>     java-6648  2D..1 6296us : try_to_wake_up()<-wake_up_process()<-wakeup_next_waiter()<-rt_mutex_slowunlock()
>     java-6648  2D..1 6296us : rt_mutex_unlock()<-rt_up_read()<-do_futex()<-(-1)()
>     java-6648  2D..2 6297us : effective_prio <<...>-6673> (-4 -4)
>     java-6648  2D..2 6297us : __activate_task <<...>-6673> (-4 1)
>     java-6648  2.... 6297us < (-11)
>     java-6648  2.... 6298us+> sys_futex (0000000000afaf50 0000000000000001 0000000000000001)
>     java-6648  2...1 6315us : __sched_text_start()<-schedule()<-rt_mutex_slowlock()<-rt_mutex_lock()
>     java-6648  2...1 6315us : __rt_down_read()<-rt_down_read()<-futex_wake()<-(-1)()
>     java-6648  2D..2 6316us+: deactivate_task <java-6648> (-4 1)
>   <idle>-0     2D..2 6318us+: thread_return <java-6648> (-4 20)
>   <idle>-0     2DN.1 6327us : __sched_text_start()<-cpu_idle()<-start_secondary()<-(-1)()
>   <idle>-0     2DN.1 6328us+: (0)()<-(0)()<-(0)()<-(0)()
>     java-6629  2D..2 6330us+: thread_return <<idle>-0> (20 -4)
>     java-6629  2D..1 6347us : try_to_wake_up()<-wake_up_process()<-wakeup_next_waiter()<-rt_mutex_slowunlock()
>     java-6629  2D..1 6347us : rt_mutex_unlock()<-rt_up_read()<-futex_wake()<-(-1)()
>     java-6629  2D..2 6348us : effective_prio <java-6235> (-4 -4)
>     java-6629  2D..2 6349us : __activate_task <java-6235> (-4 1)
>     java-6629  2.... 6350us+< (0)
>     java-6629  2.... 6352us+> sys_futex (0000000000afc1dc 0000000000000001 0000000000000001)
>     java-6629  2...1 6368us : __sched_text_start()<-schedule()<-rt_mutex_slowlock()<-rt_mutex_lock()
>     java-6629  2...1 6368us : __rt_down_read()<-rt_down_read()<-futex_wake()<-(-1)()
>     java-6629  2D..2 6369us+: deactivate_task <java-6629> (-4 1)
>   <idle>-0     2D..2 6404us!: thread_return <java-6629> (-4 20)
>   <idle>-0     2DN.1 6584us : __sched_text_start()<-cpu_idle()<-start_secondary()<-(-1)()

indeed - basically the mm semaphore is a common resource here. I suspect 
you'll see somewhat better numbers by using idle=poll or idle=mwait (or 
are using those options already?).

(could you send me the whole trace if you still have it? It would be 
interesting to see a broader snippet from the life of individual java 
threads.)

	Ingo
