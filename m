Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267508AbUHMTw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267508AbUHMTw5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267425AbUHMTvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:51:41 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41405 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267377AbUHMTqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:46:48 -0400
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040813103151.GH8135@elte.hu>
References: <1090832436.6936.105.camel@mindpipe>
	 <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu>
	 <20040812235116.GA27838@elte.hu> <1092374851.3450.13.camel@mindpipe>
	 <1092375673.3450.15.camel@mindpipe>  <20040813103151.GH8135@elte.hu>
Content-Type: text/plain
Message-Id: <1092426446.3450.57.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 Aug 2004 15:47:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-13 at 06:31, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc4-O6
> > 
> > Ugh, this is a bad one:
> > 
> > preemption latency trace v1.0
> > -----------------------------
> >  latency: 506 us, entries: 157 (157)
> >  process: evolution/3461, uid: 1000
> >  nice: 0, policy: 0, rt_priority: 0
> > =======>
> >  0.000ms (+0.000ms): get_random_bytes (__check_and_rekey)
> [...]
> >  0.493ms (+0.001ms): local_bh_enable (__check_and_rekey)
> 
> indeed this is a new one. Entropy rekeying every 300 seconds. Most of
> the overhead comes from the memcpy's - 10 usecs a pop!

Here's another case where those memcpy's hurt.  This was the biggest
latency reported last night:

preemption latency trace v1.0
-----------------------------
 latency: 683 us, entries: 329 (329)
 process: ksoftirqd/0/2, uid: 0
 nice: -10, policy: 0, rt_priority: 0
=======>
 0.000ms (+0.000ms): process_backlog (net_rx_action)
 0.000ms (+0.000ms): netif_receive_skb (process_backlog)
 0.002ms (+0.002ms): packet_rcv_spkt (netif_receive_skb)
 0.003ms (+0.000ms): skb_clone (packet_rcv_spkt)
 0.003ms (+0.000ms): kmem_cache_alloc (skb_clone)
 0.004ms (+0.000ms): memcpy (skb_clone)
 0.006ms (+0.001ms): strlcpy (packet_rcv_spkt)
 0.007ms (+0.001ms): sk_run_filter (packet_rcv_spkt)
 0.010ms (+0.002ms): __kfree_skb (packet_rcv_spkt)
 0.010ms (+0.000ms): kfree_skbmem (__kfree_skb)
 0.010ms (+0.000ms): skb_release_data (kfree_skbmem)
 0.011ms (+0.000ms): kmem_cache_free (kfree_skbmem)
 0.011ms (+0.000ms): ip_rcv (netif_receive_skb)
 0.013ms (+0.001ms): ip_route_input (ip_rcv)
 0.014ms (+0.000ms): rt_hash_code (ip_route_input)
 0.015ms (+0.001ms): ip_route_input_slow (ip_rcv)
 0.017ms (+0.001ms): rt_hash_code (ip_route_input_slow)
 0.018ms (+0.001ms): fn_hash_lookup (ip_route_input_slow)
 0.020ms (+0.001ms): fib_semantic_match (fn_hash_lookup)
 0.022ms (+0.002ms): fib_validate_source (ip_route_input_slow)
 0.023ms (+0.001ms): fn_hash_lookup (fib_validate_source)
 0.024ms (+0.001ms): fn_hash_lookup (fib_validate_source)
 0.026ms (+0.001ms): fib_semantic_match (fn_hash_lookup)
 0.027ms (+0.000ms): __fib_res_prefsrc (fib_validate_source)
 0.027ms (+0.000ms): inet_select_addr (__fib_res_prefsrc)
 0.030ms (+0.002ms): do_IRQ (common_interrupt)
 0.030ms (+0.000ms): mask_and_ack_8259A (do_IRQ)
 0.034ms (+0.003ms): generic_redirect_hardirq (do_IRQ)
 0.034ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
 0.034ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
 0.035ms (+0.000ms): mark_offset_tsc (timer_interrupt)
 0.041ms (+0.005ms): do_timer (timer_interrupt)
 0.041ms (+0.000ms): update_process_times (do_timer)
 0.041ms (+0.000ms): update_one_process (update_process_times)
 0.042ms (+0.000ms): run_local_timers (update_process_times)
 0.042ms (+0.000ms): raise_softirq (update_process_times)
 0.043ms (+0.000ms): scheduler_tick (update_process_times)
 0.043ms (+0.000ms): sched_clock (scheduler_tick)
 0.044ms (+0.001ms): task_timeslice (scheduler_tick)
 0.045ms (+0.000ms): update_wall_time (do_timer)
 0.045ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 0.046ms (+0.000ms): generic_note_interrupt (do_IRQ)
 0.046ms (+0.000ms): end_8259A_irq (do_IRQ)
 0.046ms (+0.000ms): enable_8259A_irq (do_IRQ)
 0.048ms (+0.001ms): dst_alloc (ip_route_input_slow)
 0.049ms (+0.000ms): kmem_cache_alloc (dst_alloc)
 0.050ms (+0.000ms): cache_alloc_refill (kmem_cache_alloc)
 0.055ms (+0.005ms): rt_intern_hash (ip_route_input_slow)
 0.056ms (+0.001ms): local_bh_enable (rt_intern_hash)
 0.058ms (+0.001ms): ip_local_deliver (ip_rcv)
 0.059ms (+0.001ms): tcp_v4_rcv (ip_local_deliver)
 0.060ms (+0.000ms): tcp_v4_checksum_init (tcp_v4_rcv)
 0.060ms (+0.000ms): skb_checksum (tcp_v4_checksum_init)
 0.065ms (+0.004ms): tcp_v4_do_rcv (tcp_v4_rcv)
 0.066ms (+0.000ms): tcp_v4_hnd_req (tcp_v4_do_rcv)
 0.066ms (+0.000ms): tcp_v4_search_req (tcp_v4_hnd_req)
 0.068ms (+0.002ms): tcp_rcv_state_process (tcp_v4_do_rcv)
 0.069ms (+0.001ms): tcp_v4_conn_request (tcp_rcv_state_process)
 0.070ms (+0.000ms): kmem_cache_alloc (tcp_v4_conn_request)
 0.071ms (+0.000ms): cache_alloc_refill (kmem_cache_alloc)
 0.072ms (+0.001ms): cache_grow (cache_alloc_refill)
 0.073ms (+0.000ms): kmem_flagcheck (cache_grow)
 0.073ms (+0.000ms): kmem_getpages (cache_grow)
 0.073ms (+0.000ms): __get_free_pages (kmem_getpages)
 0.074ms (+0.000ms): __alloc_pages (__get_free_pages)
 0.074ms (+0.000ms): buffered_rmqueue (__alloc_pages)
 0.075ms (+0.000ms): bad_range (buffered_rmqueue)
 0.076ms (+0.000ms): prep_new_page (buffered_rmqueue)
 0.076ms (+0.000ms): zone_statistics (__alloc_pages)
 0.077ms (+0.000ms): alloc_slabmgmt (cache_grow)
 0.077ms (+0.000ms): set_slab_attr (cache_grow)
 0.078ms (+0.000ms): cache_init_objs (cache_grow)
 0.084ms (+0.005ms): tcp_parse_options (tcp_v4_conn_request)
 0.087ms (+0.003ms): secure_tcp_sequence_number (tcp_v4_conn_request)
 0.087ms (+0.000ms): do_gettimeofday (secure_tcp_sequence_number)
 0.088ms (+0.000ms): get_offset_tsc (do_gettimeofday)
 0.089ms (+0.000ms): __check_and_rekey (secure_tcp_sequence_number)
 0.089ms (+0.000ms): get_random_bytes (__check_and_rekey)
 0.090ms (+0.000ms): extract_entropy (get_random_bytes)
 0.091ms (+0.001ms): extract_entropy (extract_entropy)
 0.093ms (+0.001ms): SHATransform (extract_entropy)
 0.093ms (+0.000ms): memcpy (SHATransform)
 0.103ms (+0.009ms): add_entropy_words (extract_entropy)

[...]

 0.572ms (+0.000ms): SHATransform (extract_entropy)
 0.572ms (+0.000ms): memcpy (SHATransform)
 0.581ms (+0.008ms): add_entropy_words (extract_entropy)
 0.582ms (+0.001ms): local_bh_enable (__check_and_rekey)
 0.583ms (+0.000ms): halfMD4Transform (secure_tcp_sequence_number)
 0.584ms (+0.001ms): tcp_v4_send_synack (tcp_v4_conn_request)
 0.585ms (+0.000ms): tcp_v4_route_req (tcp_v4_send_synack)
 0.586ms (+0.001ms): do_IRQ (common_interrupt)
 0.587ms (+0.000ms): mask_and_ack_8259A (do_IRQ)
 0.591ms (+0.004ms): generic_redirect_hardirq (do_IRQ)
 0.592ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
 0.592ms (+0.000ms): rtc_interrupt (generic_handle_IRQ_event)
 0.592ms (+0.000ms): is_hpet_enabled (rtc_interrupt)
 0.596ms (+0.004ms): mod_timer (rtc_interrupt)
 0.597ms (+0.000ms): __mod_timer (rtc_interrupt)
 0.597ms (+0.000ms): internal_add_timer (__mod_timer)
 0.598ms (+0.000ms): __wake_up (rtc_interrupt)
 0.598ms (+0.000ms): __wake_up_common (__wake_up)
 0.599ms (+0.000ms): kill_fasync (rtc_interrupt)
 0.599ms (+0.000ms): generic_note_interrupt (do_IRQ)
 0.599ms (+0.000ms): end_8259A_irq (do_IRQ)
 0.600ms (+0.000ms): enable_8259A_irq (do_IRQ)
 0.601ms (+0.001ms): ip_route_output_flow (tcp_v4_route_req)
 0.602ms (+0.000ms): __ip_route_output_key (ip_route_output_flow)
 0.602ms (+0.000ms): rt_hash_code (__ip_route_output_key)
 0.603ms (+0.000ms): ip_route_output_slow (ip_route_output_flow)
 0.604ms (+0.001ms): ip_dev_find (ip_route_output_slow)
 0.604ms (+0.000ms): fn_hash_lookup (ip_dev_find)
 0.605ms (+0.000ms): fib_semantic_match (fn_hash_lookup)
 0.606ms (+0.000ms): fn_hash_lookup (ip_route_output_slow)
 0.607ms (+0.000ms): fn_hash_lookup (ip_route_output_slow)
 0.607ms (+0.000ms): fib_semantic_match (fn_hash_lookup)
 0.608ms (+0.000ms): fn_hash_select_default (ip_route_output_slow)
 0.610ms (+0.001ms): dst_alloc (ip_route_output_slow)
 0.610ms (+0.000ms): kmem_cache_alloc (dst_alloc)
 0.613ms (+0.002ms): rt_set_nexthop (ip_route_output_slow)
 0.613ms (+0.000ms): memcpy (rt_set_nexthop)
 0.614ms (+0.000ms): rt_hash_code (ip_route_output_slow)
 0.614ms (+0.000ms): rt_intern_hash (ip_route_output_slow)
 0.615ms (+0.000ms): arp_bind_neighbour (rt_intern_hash)
 0.615ms (+0.000ms): neigh_lookup (arp_bind_neighbour)
 0.616ms (+0.000ms): arp_hash (neigh_lookup)
 0.618ms (+0.001ms): local_bh_enable (neigh_lookup)
 0.618ms (+0.000ms): local_bh_enable (rt_intern_hash)
 0.619ms (+0.001ms): tcp_make_synack (tcp_v4_send_synack)
 0.619ms (+0.000ms): sock_wmalloc (tcp_make_synack)
 0.620ms (+0.000ms): alloc_skb (sock_wmalloc)
 0.620ms (+0.000ms): kmem_cache_alloc (alloc_skb)
 0.621ms (+0.000ms): __kmalloc (alloc_skb)
 0.626ms (+0.005ms): ip_build_and_send_pkt (tcp_v4_send_synack)
 0.628ms (+0.001ms): ip_output (ip_build_and_send_pkt)
 0.628ms (+0.000ms): ip_finish_output (ip_build_and_send_pkt)
 0.629ms (+0.000ms): neigh_resolve_output (ip_finish_output)
 0.630ms (+0.000ms): neigh_hh_init (neigh_resolve_output)
 0.631ms (+0.001ms): eth_header (neigh_resolve_output)
 0.632ms (+0.001ms): local_bh_enable (neigh_resolve_output)
 0.633ms (+0.000ms): dev_queue_xmit (neigh_resolve_output)
 0.634ms (+0.001ms): pfifo_fast_enqueue (dev_queue_xmit)
 0.635ms (+0.000ms): qdisc_restart (dev_queue_xmit)
 0.635ms (+0.000ms): pfifo_fast_dequeue (qdisc_restart)
 0.636ms (+0.000ms): dev_queue_xmit_nit (qdisc_restart)
 0.637ms (+0.000ms): skb_clone (dev_queue_xmit_nit)
 0.637ms (+0.000ms): kmem_cache_alloc (skb_clone)
 0.638ms (+0.000ms): memcpy (skb_clone)
 0.639ms (+0.001ms): packet_rcv_spkt (dev_queue_xmit_nit)
 0.639ms (+0.000ms): strlcpy (packet_rcv_spkt)
 0.640ms (+0.000ms): sk_run_filter (packet_rcv_spkt)
 0.641ms (+0.001ms): __kfree_skb (packet_rcv_spkt)
 0.642ms (+0.000ms): kfree_skbmem (__kfree_skb)
 0.642ms (+0.000ms): skb_release_data (kfree_skbmem)
 0.642ms (+0.000ms): kmem_cache_free (kfree_skbmem)
 0.643ms (+0.000ms): rhine_start_tx (qdisc_restart)
 0.646ms (+0.003ms): qdisc_restart (dev_queue_xmit)
 0.646ms (+0.000ms): pfifo_fast_dequeue (qdisc_restart)
 0.647ms (+0.000ms): local_bh_enable (dev_queue_xmit)
 0.648ms (+0.001ms): tcp_v4_synq_add (tcp_v4_conn_request)
 0.649ms (+0.000ms): tcp_reset_keepalive_timer (tcp_v4_synq_add)
 0.649ms (+0.000ms): sk_reset_timer (tcp_reset_keepalive_timer)
 0.650ms (+0.000ms): mod_timer (sk_reset_timer)
 0.650ms (+0.000ms): __mod_timer (sk_reset_timer)
 0.651ms (+0.000ms): internal_add_timer (__mod_timer)
 0.652ms (+0.001ms): init_westwood (tcp_rcv_state_process)
 0.652ms (+0.000ms): init_bictcp (tcp_rcv_state_process)
 0.653ms (+0.000ms): __kfree_skb (tcp_rcv_state_process)
 0.654ms (+0.000ms): kfree_skbmem (__kfree_skb)
 0.654ms (+0.000ms): skb_release_data (kfree_skbmem)
 0.654ms (+0.000ms): kfree (kfree_skbmem)
 0.656ms (+0.001ms): do_IRQ (common_interrupt)
 0.656ms (+0.000ms): mask_and_ack_8259A (do_IRQ)
 0.660ms (+0.004ms): generic_redirect_hardirq (do_IRQ)
 0.661ms (+0.000ms): wake_up_process (generic_redirect_hardirq)
 0.661ms (+0.000ms): try_to_wake_up (wake_up_process)
 0.661ms (+0.000ms): task_rq_lock (try_to_wake_up)
 0.662ms (+0.000ms): activate_task (try_to_wake_up)
 0.662ms (+0.000ms): sched_clock (activate_task)
 0.662ms (+0.000ms): recalc_task_prio (activate_task)
 0.663ms (+0.000ms): effective_prio (recalc_task_prio)
 0.663ms (+0.000ms): enqueue_task (activate_task)
 0.664ms (+0.001ms): kmem_cache_free (kfree_skbmem)
 0.666ms (+0.001ms): check_preempt_timing (touch_preempt_timing)

Lee

