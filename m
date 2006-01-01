Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWAAIcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWAAIcc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 03:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWAAIcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 03:32:32 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:59777 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751098AbWAAIcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 03:32:31 -0500
Subject: Re: [patch] latency tracer, 2.6.15-rc7
From: Lee Revell <rlrevell@joe-job.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@redhat.com>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       NetDev <netdev@vger.kernel.org>
In-Reply-To: <1135991732.31111.57.camel@mindpipe>
References: <1135726300.22744.25.camel@mindpipe>
	 <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
	 <1135814419.7680.13.camel@mindpipe> <20051229082217.GA23052@elte.hu>
	 <20051229100233.GA12056@redhat.com> <20051229101736.GA2560@elte.hu>
	 <1135887072.6804.9.camel@mindpipe> <1135887966.6804.11.camel@mindpipe>
	 <20051229202848.GC29546@elte.hu> <1135908980.4568.10.camel@mindpipe>
	 <20051230080032.GA26152@elte.hu> <1135990270.31111.46.camel@mindpipe>
	 <Pine.LNX.4.64.0512301701320.3249@g5.osdl.org>
	 <1135991732.31111.57.camel@mindpipe>
Content-Type: text/plain
Date: Sun, 01 Jan 2006 03:32:22 -0500
Message-Id: <1136104343.13079.43.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 20:15 -0500, Lee Revell wrote: 
> On Fri, 2005-12-30 at 17:02 -0800, Linus Torvalds wrote:
> > 
> > On Fri, 30 Dec 2005, Lee Revell wrote:
> > > 
> > > It seems that the networking code's use of RCU can cause 10ms+
> > > latencies:
> > 
> > Hmm. Is there a big jump at the 10ms mark? Do you have a 100Hz timer 
> > source? 
> > 
> > A latency jump at 10ms would tend to indicate a missed wakeup that 
> > was "picked up" by the next timer tick.
> 
> No there are no large jumps, it really seems that this was the network
> code causing an RCU callback to drop ~2K routes at once.  Specifically
> RCU invokes dst_rcu_free 2085 times in a single batch
> (call_rcu_bh(&rt->u.dst.rcu_head, dst_rcu_free) is only called from
> rt_free() and rt_drop()).
> 
> I have found that many of the paths in the network stack that can cause
> high latencies can be tuned via sysctls (for example
> net.ipv4.route.gc_thresh); this one may be the same.

On a related topic:

I thought I had solved the route cache flushing problem by tuning these
sysctls, but it does not seems to help.

The short version is that rt_run_flush and rt_garbage_collect can cause
15ms+ latencies when a lot of routes (up to 4096 it seems) are flushed
in one go:

$ grep "local_bh_enable (rt_run_flush)" /proc/latency_trace | wc -l
4096

$ grep "local_bh_enable (rt_garbage_collect)" /proc/latency_trace | wc
-l
4096

(rt_run_flush and rt_garbage_collect call spin_lock_bh/spin_unlock_bh
once for each flushed route so the above grep effectively counts the
number of routes flushed at once)

I reported this a year or so ago and it led to Ingo adding an option to
-rt (then called the voluntary preempt patch) to always run softirqs in
threads which makes rt_run_flush preemptible.

Anyway I thought I could work around this with mainline by tuning the
network stack to minimize the effect of route cache flushing on
scheduler latency using these sysctls to cause the route cache to be
flushed more often and/or limit the maximum size of the route cache:

$ sudo /sbin/sysctl -a | grep route
net.ipv4.route.gc_elasticity = 8
net.ipv4.route.gc_interval = 60
net.ipv4.route.gc_timeout = 300
net.ipv4.route.gc_min_interval_ms = 20
net.ipv4.route.gc_min_interval = 0
net.ipv4.route.max_size = 65536
net.ipv4.route.gc_thresh = 256
net.ipv4.route.max_delay = 10
net.ipv4.route.min_delay = 2

I tried lowering gc_min_interval_ms, gc_timeout, max_size, and gc_thresh
but rt_run_flush will still process up to 4096 (the size of the route
hash table?) routes at once.

(stop here if you don't care to interpret long latency_trace reports)

17ms+ latency caused by rt_run_flush then rt_garbage_collect processing
4096 routes:

preemption latency trace v1.1.5 on 2.6.15-rc7
--------------------------------------------------------------------
 latency: 17286 us, #19154/19154, CPU#0 | (M:rt VP:0, KP:0, SP:0 HP:0)
    -----------------  
    | task: gtk-gnutella-8581 (uid:1000 nice:0 policy:0 rt_prio:0)
    -----------------  

                 _------=> CPU#            
                / _-----=> irqs-off        
               | / _----=> need-resched    
               || / _---=> hardirq/softirq 
               ||| / _--=> preempt-depth   
               |||| /                      
               |||||     delay             
   cmd     pid ||||| time  |   caller      
      \   /    |||||   \   |   /           
epiphany-8742  0dns8    0us : __trace_start_sched_wakeup (try_to_wake_up)
epiphany-8742  0dns8    1us : __trace_start_sched_wakeup <<...>-8581> (73 0)
epiphany-8742  0dns7    2us : preempt_schedule (__trace_start_sched_wakeup)
epiphany-8742  0dns6    2us : preempt_schedule (try_to_wake_up)
epiphany-8742  0dns5    3us : preempt_schedule (__wake_up)
epiphany-8742  0dns5    4us : preempt_schedule (ep_poll_safewake)
epiphany-8742  0dnH5    6us : do_IRQ (c011223e b 0)
epiphany-8742  0d.h.    6us : __do_IRQ (do_IRQ)
epiphany-8742  0d.h1    7us+: mask_and_ack_8259A (__do_IRQ)
epiphany-8742  0d.h.   12us : handle_IRQ_event (__do_IRQ)
epiphany-8742  0d.h.   13us : usb_hcd_irq (handle_IRQ_event)
epiphany-8742  0d.h.   13us : uhci_irq (usb_hcd_irq)
epiphany-8742  0d.h.   14us : via_driver_irq_handler (handle_IRQ_event)
epiphany-8742  0d.h.   16us : rhine_interrupt (handle_IRQ_event)
epiphany-8742  0d.h.   16us : ioread16 (rhine_interrupt)
epiphany-8742  0d.h.   17us : ioread8 (rhine_interrupt)
epiphany-8742  0d.h.   18us : iowrite16 (rhine_interrupt)
epiphany-8742  0d.h.   19us : ioread8 (rhine_interrupt)
epiphany-8742  0d.h.   20us : rhine_tx (rhine_interrupt)
epiphany-8742  0d.h1   21us : raise_softirq_irqoff (rhine_tx)
epiphany-8742  0d.h.   22us : ioread16 (rhine_interrupt)
epiphany-8742  0d.h.   23us : ioread8 (rhine_interrupt)
epiphany-8742  0d.h1   25us : note_interrupt (__do_IRQ)
epiphany-8742  0d.h1   25us : end_8259A_irq (__do_IRQ)
epiphany-8742  0d.h1   26us : enable_8259A_irq (end_8259A_irq)
epiphany-8742  0dnH5   28us : irq_exit (do_IRQ)
epiphany-8742  0dns5   28us < (2097760)
epiphany-8742  0dns4   29us : preempt_schedule (__wake_up)
epiphany-8742  0dns3   30us : preempt_schedule (sock_def_readable)
epiphany-8742  0dns2   31us : preempt_schedule (tcp_v4_rcv)
epiphany-8742  0dns1   32us : preempt_schedule (ip_local_deliver)
epiphany-8742  0dns.   33us : preempt_schedule (netif_receive_skb)
epiphany-8742  0dns.   33us : net_tx_action (__do_softirq)
epiphany-8742  0dns.   34us : __kfree_skb (net_tx_action)
epiphany-8742  0dns.   35us : sock_wfree (__kfree_skb)
epiphany-8742  0dns.   35us : kfree_skbmem (__kfree_skb)
epiphany-8742  0dns.   36us : skb_release_data (kfree_skbmem)
epiphany-8742  0dns.   37us : kfree (skb_release_data)
epiphany-8742  0dns.   38us : kmem_cache_free (kfree_skbmem)
epiphany-8742  0dn..   39us : schedule (work_resched)
epiphany-8742  0dn..   40us : stop_trace (schedule)
epiphany-8742  0dn..   40us : profile_hit (schedule)
epiphany-8742  0dn.1   41us : sched_clock (schedule)
epiphany-8742  0dn.2   43us : recalc_task_prio (schedule)
epiphany-8742  0dn.2   44us : effective_prio (recalc_task_prio)
epiphany-8742  0dn.2   45us : requeue_task (schedule)
   <...>-8581  0d..2   47us : __switch_to (schedule)
   <...>-8581  0d..2   49us : schedule <epiphany-8742> (7d 73)
   <...>-8581  0d.h2   50us : do_IRQ (c022ecf4 0 0)
   <...>-8581  0d.h.   51us : __do_IRQ (do_IRQ)
   <...>-8581  0d.h1   52us+: mask_and_ack_8259A (__do_IRQ)
   <...>-8581  0d.h.   56us : handle_IRQ_event (__do_IRQ)
   <...>-8581  0d.h.   56us : timer_interrupt (handle_IRQ_event)
   <...>-8581  0d.h1   57us+: mark_offset_tsc (timer_interrupt)
   <...>-8581  0d.h1   64us : do_timer (timer_interrupt)
   <...>-8581  0d.h1   64us : update_wall_time (do_timer)
   <...>-8581  0d.h1   65us : update_wall_time_one_tick (update_wall_time)
   <...>-8581  0d.h1   66us : update_process_times (timer_interrupt)
   <...>-8581  0d.h1   66us : account_system_time (update_process_times)
   <...>-8581  0d.h1   67us : acct_update_integrals (account_system_time)
   <...>-8581  0d.h1   69us : run_local_timers (update_process_times)
   <...>-8581  0d.h1   69us : raise_softirq (run_local_timers)
   <...>-8581  0d.h1   70us : scheduler_tick (update_process_times)
   <...>-8581  0d.h1   71us : sched_clock (scheduler_tick)
   <...>-8581  0d.h2   72us : task_timeslice (scheduler_tick)
   <...>-8581  0d.h1   73us : run_posix_cpu_timers (update_process_times)
   <...>-8581  0d.h1   74us : smp_local_timer_interrupt (timer_interrupt)
   <...>-8581  0d.h1   75us : profile_tick (smp_local_timer_interrupt)
   <...>-8581  0d.h1   76us : profile_hit (profile_tick)
   <...>-8581  0d.h1   77us : note_interrupt (__do_IRQ)
   <...>-8581  0d.h1   77us : end_8259A_irq (__do_IRQ)
   <...>-8581  0d.h1   78us+: enable_8259A_irq (end_8259A_irq)
   <...>-8581  0d.h2   80us : irq_exit (do_IRQ)
   <...>-8581  0d..3   81us : do_softirq (irq_exit)
   <...>-8581  0dns.   81us : __do_softirq (do_softirq)
   <...>-8581  0dns.   82us : run_timer_softirq (__do_softirq)
   <...>-8581  0dns.   83us : preempt_schedule (run_timer_softirq)
   <...>-8581  0dns.   84us : rt_secret_rebuild (run_timer_softirq)
   <...>-8581  0dns.   85us : rt_cache_flush (rt_secret_rebuild)
   <...>-8581  0dns1   86us : del_timer (rt_cache_flush)
   <...>-8581  0dns.   87us : local_bh_enable (rt_cache_flush)
   <...>-8581  0dns.   88us : preempt_schedule (local_bh_enable)
   <...>-8581  0dns.   88us : rt_run_flush (rt_cache_flush)
   <...>-8581  0dns.   89us : get_random_bytes (rt_run_flush)
   <...>-8581  0dns.   90us : extract_entropy (get_random_bytes)
   <...>-8581  0dns.   91us : xfer_secondary_pool (extract_entropy)
   <...>-8581  0dns.   92us : extract_entropy (xfer_secondary_pool)
   <...>-8581  0dns.   93us : xfer_secondary_pool (extract_entropy)
   <...>-8581  0dns.   94us : account (extract_entropy)
   <...>-8581  0dns.   95us : preempt_schedule (account)
   <...>-8581  0dns.   96us : extract_buf (extract_entropy)
   <...>-8581  0dns.   97us : sha_init (extract_buf)
   <...>-8581  0dns.   98us+: sha_transform (extract_buf)
   <...>-8581  0dns.  106us+: __add_entropy_words (extract_buf)
   <...>-8581  0dns.  108us : preempt_schedule (__add_entropy_words)
   <...>-8581  0dns.  109us+: sha_transform (extract_buf)
   <...>-8581  0dns.  116us : __add_entropy_words (extract_buf)
   <...>-8581  0dns.  117us : preempt_schedule (__add_entropy_words)
   <...>-8581  0dns.  118us+: sha_transform (extract_buf)
   <...>-8581  0dns.  125us : __add_entropy_words (extract_buf)
   <...>-8581  0dns.  126us : preempt_schedule (__add_entropy_words)
   <...>-8581  0dns.  127us+: sha_transform (extract_buf)
   <...>-8581  0dns.  134us : __add_entropy_words (extract_buf)
   <...>-8581  0dns.  135us : preempt_schedule (__add_entropy_words)
   <...>-8581  0dns.  136us+: sha_transform (extract_buf)
   <...>-8581  0dns.  143us : __add_entropy_words (extract_buf)
   <...>-8581  0dns.  144us : preempt_schedule (__add_entropy_words)
   <...>-8581  0dns.  144us+: sha_transform (extract_buf)
   <...>-8581  0dns.  151us : __add_entropy_words (extract_buf)
   <...>-8581  0dns.  152us : preempt_schedule (__add_entropy_words)
   <...>-8581  0dns.  153us+: sha_transform (extract_buf)
   <...>-8581  0dns.  160us : __add_entropy_words (extract_buf)
   <...>-8581  0dns.  161us : preempt_schedule (__add_entropy_words)
   <...>-8581  0dns.  162us+: sha_transform (extract_buf)
   <...>-8581  0dns.  169us : __add_entropy_words (extract_buf)
   <...>-8581  0dns.  170us : preempt_schedule (__add_entropy_words)
   <...>-8581  0dns.  171us : __add_entropy_words (extract_buf)
   <...>-8581  0dns.  172us : preempt_schedule (__add_entropy_words)
   <...>-8581  0dns.  173us+: sha_transform (extract_buf)
   <...>-8581  0dns.  180us : __add_entropy_words (xfer_secondary_pool)
   <...>-8581  0dns.  182us : preempt_schedule (__add_entropy_words)
   <...>-8581  0dns.  183us : credit_entropy_store (xfer_secondary_pool)
   <...>-8581  0dns.  184us : preempt_schedule (credit_entropy_store)
   <...>-8581  0dns.  185us : account (extract_entropy)
   <...>-8581  0dns1  186us : __wake_up (account)
   <...>-8581  0dns2  186us : __wake_up_common (__wake_up)
   <...>-8581  0dns1  187us : preempt_schedule (__wake_up)
   <...>-8581  0dns.  188us : preempt_schedule (account)
   <...>-8581  0dns.  188us : extract_buf (extract_entropy)
   <...>-8581  0dns.  189us : sha_init (extract_buf)
   <...>-8581  0dns.  190us+: sha_transform (extract_buf)
   <...>-8581  0dns.  197us : __add_entropy_words (extract_buf)
   <...>-8581  0dns.  198us : preempt_schedule (__add_entropy_words)
   <...>-8581  0dns.  198us+: sha_transform (extract_buf)
   <...>-8581  0dns.  205us : __add_entropy_words (extract_buf)
   <...>-8581  0dns.  206us : preempt_schedule (__add_entropy_words)
   <...>-8581  0dns.  207us : __add_entropy_words (extract_buf)
   <...>-8581  0dns.  209us : preempt_schedule (__add_entropy_words)
   <...>-8581  0dns.  209us+: sha_transform (extract_buf)
   <...>-8581  0dns.  217us : local_bh_enable (rt_run_flush)
   <...>-8581  0dns.  218us : preempt_schedule (local_bh_enable)
   <...>-8581  0dns.  219us : call_rcu_bh (rt_run_flush)
   <...>-8581  0dns.  220us : local_bh_enable (rt_run_flush)
   <...>-8581  0dns.  221us : preempt_schedule (local_bh_enable)
   <...>-8581  0dns.  222us : call_rcu_bh (rt_run_flush)
   <...>-8581  0dns.  223us : call_rcu_bh (rt_run_flush)

   <...>-8581  0dns.  224us : local_bh_enable (rt_run_flush)
   <...>-8581  0dns.  225us : preempt_schedule (local_bh_enable)

   <...>-8581  0dns.  226us : local_bh_enable (rt_run_flush)
   <...>-8581  0dns.  227us : preempt_schedule (local_bh_enable)

  [ rt_run_flush x 4096 routes ]

   <...>-8581  0dns. 8763us : local_bh_enable (rt_run_flush)
   <...>-8581  0dns. 8764us : preempt_schedule (local_bh_enable)
   <...>-8581  0dns. 8765us : mod_timer (rt_secret_rebuild)
   <...>-8581  0dns. 8766us : __mod_timer (mod_timer)
   <...>-8581  0dns. 8766us : lock_timer_base (__mod_timer)
   <...>-8581  0dns1 8767us : internal_add_timer (__mod_timer)
   <...>-8581  0dns. 8769us+: preempt_schedule (__mod_timer)
   <...>-8581  0dns. 8771us : preempt_schedule (run_timer_softirq)
   <...>-8581  0dns. 8772us : tcp_delack_timer (run_timer_softirq)
    
  [ tcp_delack_timer ... ]
 
   <...>-8581  0dns. 8841us : preempt_schedule (tcp_delack_timer)
   <...>-8581  0dns. 8842us+: preempt_schedule (run_timer_softirq)

   <...>-8581  0dnH. 8845us : do_IRQ (c010dc95 b 0)
   
  [ network irq ]

   <...>-8581  0dnH. 8871us : irq_exit (do_IRQ)

   <...>-8581  0dns. 8871us < (2097760)
   <...>-8581  0dns. 8872us : run_timer_softirq (__do_softirq)
   <...>-8581  0dns. 8873us : net_rx_action (__do_softirq)
   <...>-8581  0dns. 8874us : process_backlog (net_rx_action)
   <...>-8581  0dns. 8875us : netif_receive_skb (process_backlog)
   <...>-8581  0dns1 8877us : packet_rcv_spkt (netif_receive_skb)
   <...>-8581  0dns1 8878us : skb_clone (packet_rcv_spkt)
   <...>-8581  0dns1 8878us : kmem_cache_alloc (skb_clone)
   <...>-8581  0dns1 8880us : strlcpy (packet_rcv_spkt)
   <...>-8581  0dns2 8881us : sk_run_filter (packet_rcv_spkt)
   <...>-8581  0dns1 8882us : preempt_schedule (packet_rcv_spkt)
   <...>-8581  0dns1 8883us : __kfree_skb (packet_rcv_spkt)
   <...>-8581  0dns1 8884us : skb_release_data (kfree_skbmem)
   <...>-8581  0dns1 8884us : kmem_cache_free (kfree_skbmem)
   <...>-8581  0dns1 8885us : ip_rcv (netif_receive_skb)
   <...>-8581  0dns1 8886us : ip_route_input (ip_rcv)
   <...>-8581  0dns1 8887us : rt_hash_code (ip_route_input)
   <...>-8581  0dns1 8888us : preempt_schedule (ip_route_input)
   <...>-8581  0dns1 8889us : ip_route_input_slow (ip_route_input)
   <...>-8581  0dns1 8890us : preempt_schedule (ip_route_input_slow)
   <...>-8581  0dns1 8891us+: memset (ip_route_input_slow)
   <...>-8581  0dns1 8893us+: fn_hash_lookup (ip_route_input_slow)
   <...>-8581  0dns2 8895us : fib_semantic_match (fn_hash_lookup)
   <...>-8581  0dns1 8897us : preempt_schedule (fn_hash_lookup)
   <...>-8581  0dns1 8899us : fib_validate_source (ip_route_input_slow)
   <...>-8581  0dns1 8900us : memset (fib_validate_source)
   <...>-8581  0dns1 8901us : preempt_schedule (fib_validate_source)
   <...>-8581  0dns1 8902us : fn_hash_lookup (fib_validate_source)
   <...>-8581  0dns1 8903us : preempt_schedule (fn_hash_lookup)
   <...>-8581  0dns1 8904us : fn_hash_lookup (fib_validate_source)
   <...>-8581  0dns2 8906us : fib_semantic_match (fn_hash_lookup)
   <...>-8581  0dns1 8907us : preempt_schedule (fn_hash_lookup)
   <...>-8581  0dns1 8908us : __fib_res_prefsrc (fib_validate_source)
   <...>-8581  0dns1 8909us : inet_select_addr (__fib_res_prefsrc)
   <...>-8581  0dns1 8910us+: preempt_schedule (inet_select_addr)
   <...>-8581  0dns1 8912us : dst_alloc (ip_route_input_slow)
   <...>-8581  0dns1 8913us+: rt_garbage_collect (dst_alloc)
 
   <...>-8581  0dns1 8916us : local_bh_enable (rt_garbage_collect)
   <...>-8581  0dns1 8917us : preempt_schedule (local_bh_enable)

   <...>-8581  0dns1 8918us : local_bh_enable (rt_garbage_collect)
   <...>-8581  0dns1 8919us : preempt_schedule (local_bh_enable)
 
[ rt_garbage_collect x 4096 routes ]

   <...>-8581  0dns1 16460us : local_bh_enable (rt_garbage_collect)
   <...>-8581  0dns1 16461us : preempt_schedule (local_bh_enable)
   <...>-8581  0dns1 16462us+: kmem_cache_alloc (dst_alloc)
   <...>-8581  0dns1 16468us : preempt_schedule (ip_route_input_slow)
   <...>-8581  0dns1 16469us : rt_hash_code (ip_route_input_slow)
   <...>-8581  0dns1 16470us : rt_intern_hash (ip_route_input_slow)
   <...>-8581  0dns1 16472us : local_bh_enable (rt_intern_hash)
   <...>-8581  0dns1 16473us+: preempt_schedule (local_bh_enable)

   <...>-8581  0dns1 16476us+: ip_local_deliver (ip_rcv)

[ ~1ms more network softirqs ]

   <...>-8581  0dns. 17278us+: preempt_schedule (rcu_check_quiescent_state)
   <...>-8581  0dn.2 17280us < (2097760)
   <...>-8581  0dn.1 17281us : preempt_schedule (schedule)
   <...>-8581  0dn.1 17282us : trace_stop_sched_switched (schedule)
   <...>-8581  0dn.2 17283us+: trace_stop_sched_switched <<...>-8581> (73 0)
   <...>-8581  0dn.2 17285us : trace_stop_sched_switched (schedule)

Lee

