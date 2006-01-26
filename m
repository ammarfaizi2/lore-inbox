Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWAZTSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWAZTSh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWAZTSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:18:37 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:17309 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964837AbWAZTSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:18:36 -0500
Date: Thu, 26 Jan 2006 11:18:09 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: dipankar@in.ibm.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: RCU latency regression in 2.6.16-rc1
Message-ID: <20060126191809.GC6182@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060124080157.GA25855@elte.hu> <1138090078.2771.88.camel@mindpipe> <20060124081301.GC25855@elte.hu> <1138090527.2771.91.camel@mindpipe> <20060124091730.GA31204@us.ibm.com> <20060124092330.GA7060@elte.hu> <1138095856.2771.103.camel@mindpipe> <20060124162846.GA7139@in.ibm.com> <20060124213802.GC7139@in.ibm.com> <1138224506.3087.22.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138224506.3087.22.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 04:28:25PM -0500, Lee Revell wrote:
> On Wed, 2006-01-25 at 03:08 +0530, Dipankar Sarma wrote:
> > On Tue, Jan 24, 2006 at 09:58:46PM +0530, Dipankar Sarma wrote:
> > > On Tue, Jan 24, 2006 at 04:44:15AM -0500, Lee Revell wrote:
> > > > On Tue, 2006-01-24 at 10:23 +0100, Ingo Molnar wrote:
> > > > > * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> > > > > 
> > > > > > This patch was primarily designed to reduce memory overhead, but given 
> > > > > > that it tends to reduce batch size, it should also reduce latency.
> > > > > 
> > > > > if this solves Lee's problem, i think we should apply this as a fix, and 
> > > > > get it into v2.6.16. The patch looks straightforward and correct to me.
> > > > > 
> > > > 
> > > > Does not compile:
> > > > 
> > > >  CC      kernel/rcupdate.o
> > > > kernel/rcupdate.c:76: warning: 'struct rcu_state' declared inside parameter list
> > > 
> > > My original patch was against a much older kernel.
> > > I will send out a more uptodate patch as soon as I am done with some
> > > testing.
> > 
> > Here is an updated version of that patch against 2.6.16-rc1. I have
> > sanity-tested it on ppc64 and x86_64 using dbench and kernbench.
> > I have also tested this for OOM situations - open()/close() in
> > a tight loop in my x86_64 which earlier used to reach file limit
> > if I set batch limit to 10 and found no problem. This patch does set 
> > default RCU batch limit to 10 and changes it only when there is an RCU
> > flood.
> 
> OK this seems to work, I can't tell yet whether it help the latency I
> reported, but rt_run_flush still produces terrible latencies.
> 
> Ingo, should I try the softirq preemption patch + Dipankar's patch +
> latency tracing patch?
> 
> preemption latency trace v1.1.5 on 2.6.16-rc1
> --------------------------------------------------------------------
>  latency: 7418 us, #6397/6397, CPU#0 | (M:rt VP:0, KP:0, SP:0 HP:0)
>     -----------------  
>     | task: gmplayer-8638 (uid:1000 nice:-20 policy:0 rt_prio:0)
>     ----------------- 
>     
>                  _------=> CPU#            
>                 / _-----=> irqs-off        
>                | / _----=> need-resched    
>                || / _---=> hardirq/softirq 
>                ||| / _--=> preempt-depth    
>                |||| /                      
>                |||||     delay              
>    cmd     pid ||||| time  |   caller      
>       \   /    |||||   \   |   /           
>     Xorg-2154  0d.s2    1us : __trace_start_sched_wakeup (try_to_wake_up)
>     Xorg-2154  0d.s2    2us : __trace_start_sched_wakeup <<...>-8638> (64 0)
>     Xorg-2154  0d.s.    3us+: wake_up_process (hrtimer_run_queues)
>     Xorg-2154  0d.s.    6us : rt_secret_rebuild (run_timer_softirq)
>     Xorg-2154  0d.s.    7us : rt_cache_flush (rt_secret_rebuild)
>     Xorg-2154  0d.s1    7us : del_timer (rt_cache_flush)
>     Xorg-2154  0d.s.    9us : local_bh_enable (rt_cache_flush)
>     Xorg-2154  0d.s.   10us : rt_run_flush (rt_cache_flush)
>     Xorg-2154  0d.s.   11us : get_random_bytes (rt_run_flush)
>     Xorg-2154  0d.s.   12us : extract_entropy (get_random_bytes)
>     Xorg-2154  0d.s.   13us : xfer_secondary_pool (extract_entropy)
>     Xorg-2154  0d.s.   15us : extract_entropy (xfer_secondary_pool)
>     Xorg-2154  0d.s.   16us : xfer_secondary_pool (extract_entropy)
>     Xorg-2154  0d.s.   17us+: account (extract_entropy)
>     Xorg-2154  0d.s.   19us : extract_buf (extract_entropy)
>     Xorg-2154  0d.s.   20us : sha_init (extract_buf)
>     Xorg-2154  0d.s.   21us+: sha_transform (extract_buf)
>     Xorg-2154  0d.s.   29us+: __add_entropy_words (extract_buf)
>     Xorg-2154  0d.s.   32us+: sha_transform (extract_buf)
>     Xorg-2154  0d.s.   39us : __add_entropy_words (extract_buf)
>     Xorg-2154  0d.s.   40us+: sha_transform (extract_buf)
>     Xorg-2154  0d.s.   47us : __add_entropy_words (extract_buf)
>     Xorg-2154  0d.s.   48us+: sha_transform (extract_buf)
>     Xorg-2154  0d.s.   55us : __add_entropy_words (extract_buf)
>     Xorg-2154  0d.s.   56us+: sha_transform (extract_buf)
>     Xorg-2154  0d.s.   63us : __add_entropy_words (extract_buf)
>     Xorg-2154  0d.s.   64us+: sha_transform (extract_buf)
>     Xorg-2154  0d.s.   71us : __add_entropy_words (extract_buf)
>     Xorg-2154  0d.s.   73us+: sha_transform (extract_buf)
>     Xorg-2154  0d.s.   79us : __add_entropy_words (extract_buf)
>     Xorg-2154  0d.s.   81us+: sha_transform (extract_buf)
>     Xorg-2154  0d.s.   87us : __add_entropy_words (extract_buf)
>     Xorg-2154  0d.s.   81us+: sha_transform (extract_buf)
>     Xorg-2154  0d.s.   87us : __add_entropy_words (extract_buf)
>     Xorg-2154  0d.s.   89us : __add_entropy_words (extract_buf)
>     Xorg-2154  0d.s.   91us+: sha_transform (extract_buf)
>     Xorg-2154  0d.s.   98us : __add_entropy_words (xfer_secondary_pool)
>     Xorg-2154  0d.s.  100us : credit_entropy_store (xfer_secondary_pool)
>     Xorg-2154  0d.s.  101us : account (extract_entropy)
>     Xorg-2154  0d.s1  102us : __wake_up (account)
>     Xorg-2154  0d.s2  103us : __wake_up_common (__wake_up)
>     Xorg-2154  0d.s.  104us : extract_buf (extract_entropy)
>     Xorg-2154  0d.s.  105us : sha_init (extract_buf)
>     Xorg-2154  0d.s.  106us+: sha_transform (extract_buf)
>     Xorg-2154  0d.s.  113us : __add_entropy_words (extract_buf)
>     Xorg-2154  0d.s.  114us+: sha_transform (extract_buf)
>     Xorg-2154  0d.s.  121us : __add_entropy_words (extract_buf)
>     Xorg-2154  0d.s.  122us : __add_entropy_words (extract_buf)
>     Xorg-2154  0d.s.  124us+: sha_transform (extract_buf)
>     Xorg-2154  0d.s.  132us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  133us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  134us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  135us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  136us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  137us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  139us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  140us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  141us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  142us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  143us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  145us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  146us : call_rcu_bh (rt_run_flush)
>     Xorg-2154  0d.s.  148us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  149us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  150us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  151us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  152us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  154us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  155us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  156us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  157us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  158us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  159us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  161us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  162us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  163us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  164us : call_rcu_bh (rt_run_flush)
>     Xorg-2154  0d.s.  166us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  167us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  168us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  169us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  170us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  172us : call_rcu_bh (rt_run_flush)
>     Xorg-2154  0d.s.  173us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  174us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  175us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  176us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  178us : call_rcu_bh (rt_run_flush)
>     Xorg-2154  0d.s.  179us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  180us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  181us : call_rcu_bh (rt_run_flush)
>     Xorg-2154  0d.s.  182us : call_rcu_bh (rt_run_flush)
>     Xorg-2154  0d.s.  184us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  185us : call_rcu_bh (rt_run_flush)
>     Xorg-2154  0d.s.  186us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  187us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  188us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  190us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  191us : call_rcu_bh (rt_run_flush)
>     Xorg-2154  0d.s.  192us : call_rcu_bh (rt_run_flush)
>     Xorg-2154  0d.s.  193us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  194us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  195us : call_rcu_bh (rt_run_flush)
>     Xorg-2154  0d.s.  197us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  198us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  199us : call_rcu_bh (rt_run_flush)
>     Xorg-2154  0d.s.  200us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  201us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  202us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  204us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  205us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  206us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  207us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  208us : call_rcu_bh (rt_run_flush)
>     Xorg-2154  0d.s.  210us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  211us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  212us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  213us : call_rcu_bh (rt_run_flush)
>     Xorg-2154  0d.s.  215us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  216us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  217us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  218us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  219us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  220us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  222us : local_bh_enable (rt_run_flush)
>     Xorg-2154  0d.s.  223us : call_rcu_bh (rt_run_flush)
> 
> [ zillions of these deleted ]
> 
>     Xorg-2154  0d.s. 7335us : local_bh_enable (rt_run_flush)

Dipankar's latest patch should hopefully address this problem.

Could you please give it a spin when you get a chance?

					Thanx, Paul
