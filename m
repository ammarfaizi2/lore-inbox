Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268131AbUIAVgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268131AbUIAVgQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267604AbUIAVde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:33:34 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11650 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267523AbUIAVab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 17:30:31 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
From: Lee Revell <rlrevell@joe-job.com>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Schmitt <pnambic@unu.nu>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com, tytso@mit.edu
In-Reply-To: <1094053973.2282.2.camel@tux.rsn.bth.se>
References: <200408282210.03568.pnambic@unu.nu>
	 <20040828203116.GA29686@elte.hu>
	 <1093727453.8611.71.camel@krustophenia.net>
	 <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net>
	 <1093737080.1385.2.camel@krustophenia.net>
	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>
	 <20040830090608.GA25443@elte.hu> <1093934448.5403.4.camel@krustophenia.net>
	 <20040831065327.GA30631@elte.hu>
	 <1093993396.3404.17.camel@krustophenia.net>
	 <1094053973.2282.2.camel@tux.rsn.bth.se>
Content-Type: text/plain
Message-Id: <1094074229.1343.7.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 01 Sep 2004 17:30:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-01 at 11:52, Martin Josefsson wrote:
> On Wed, 2004-09-01 at 01:03, Lee Revell wrote:
> 
> Hi Lee
> 
> > This solves the problem with the random driver.  The worst latencies I
> > am seeing are in netif_receive_skb().  With netdev_max_backlog set to 8,
> > the worst is about 160 usecs:
> 
> I'm a bit curious... have you tried these tests with ip_conntrack
> enabled?

OK, loaded the ip_conntrack module.  'cat /proc/net/ip_conntrack'
produced a 2906 usec latency!

preemption latency trace v1.0.2
-------------------------------
 latency: 2906 us, entries: 4000 (7910)
    -----------------
    | task: cat/2091, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: cond_resched+0xd/0x40
 => ended at:   local_bh_enable+0x12/0xa0
=======>
00000101 0.000ms (+0.000ms): touch_preempt_timing (cond_resched)
00000101 0.001ms (+0.001ms): ct_seq_show (seq_read)
00000101 0.002ms (+0.001ms): ct_seq_next (seq_read)
00000101 0.002ms (+0.000ms): ct_seq_show (seq_read)
00000101 0.002ms (+0.000ms): ct_seq_next (seq_read)
00000101 0.003ms (+0.000ms): ct_seq_show (seq_read)
00000101 0.003ms (+0.000ms): ct_seq_next (seq_read)
00000101 0.004ms (+0.000ms): ct_seq_show (seq_read)
00000101 0.004ms (+0.000ms): ct_seq_next (seq_read)
00000101 0.004ms (+0.000ms): ct_seq_show (seq_read)

[ this repeats hundreds of times ]

Full trace:

http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6#/var/www/2.6.9-rc1-Q6/trace1.txt

netif_receive_skb still produces ~150 usec latencies with ip_conntrack,
but the code path is different: 

preemption latency trace v1.0.2
-------------------------------
 latency: 145 us, entries: 145 (145)
    -----------------
    | task: ksoftirqd/0/2, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: netif_receive_skb+0x6a/0x1d0
 => ended at:   netif_receive_skb+0x153/0x1d0
=======>
00000001 0.000ms (+0.000ms): netif_receive_skb (process_backlog)
00000001 0.001ms (+0.001ms): packet_rcv_spkt (netif_receive_skb)
00000001 0.002ms (+0.000ms): skb_clone (packet_rcv_spkt)
00000001 0.003ms (+0.000ms): kmem_cache_alloc (skb_clone)
00000001 0.004ms (+0.001ms): memcpy (skb_clone)
00000001 0.006ms (+0.002ms): strlcpy (packet_rcv_spkt)
00000002 0.008ms (+0.001ms): sk_run_filter (packet_rcv_spkt)
00000001 0.011ms (+0.002ms): __kfree_skb (packet_rcv_spkt)
00000001 0.012ms (+0.000ms): kfree_skbmem (__kfree_skb)
00000001 0.012ms (+0.000ms): skb_release_data (kfree_skbmem)
00000001 0.012ms (+0.000ms): kmem_cache_free (kfree_skbmem)
00000001 0.013ms (+0.000ms): ip_rcv (netif_receive_skb)
00000001 0.015ms (+0.001ms): nf_hook_slow (ip_rcv)
00000002 0.016ms (+0.000ms): nf_iterate (nf_hook_slow)
00000002 0.017ms (+0.001ms): ip_conntrack_defrag (nf_iterate)
00000002 0.018ms (+0.000ms): ip_conntrack_in (nf_iterate)
00000002 0.018ms (+0.000ms): ip_ct_find_proto (ip_conntrack_in)
00000103 0.019ms (+0.000ms): __ip_ct_find_proto (ip_ct_find_proto)
00000102 0.019ms (+0.000ms): local_bh_enable (ip_ct_find_proto)
00000002 0.021ms (+0.001ms): tcp_error (ip_conntrack_in)
00000002 0.022ms (+0.001ms): skb_checksum (tcp_error)
00000002 0.031ms (+0.008ms): ip_ct_get_tuple (ip_conntrack_in)
00000002 0.031ms (+0.000ms): tcp_pkt_to_tuple (ip_ct_get_tuple)
00000002 0.032ms (+0.000ms): ip_conntrack_find_get (ip_conntrack_in)
00000103 0.033ms (+0.000ms): __ip_conntrack_find (ip_conntrack_find_get)
00000103 0.033ms (+0.000ms): hash_conntrack (__ip_conntrack_find)
00000102 0.035ms (+0.002ms): local_bh_enable (ip_conntrack_find_get)
00000002 0.036ms (+0.000ms): tcp_packet (ip_conntrack_in)
00000103 0.037ms (+0.000ms): get_conntrack_index (tcp_packet)
00000103 0.038ms (+0.001ms): tcp_in_window (tcp_packet)
00000103 0.039ms (+0.000ms): tcp_sack (tcp_in_window)
00000102 0.041ms (+0.002ms): local_bh_enable (tcp_packet)
00000002 0.042ms (+0.000ms): ip_ct_refresh_acct (tcp_packet)
00000103 0.043ms (+0.000ms): del_timer (ip_ct_refresh_acct)
00000103 0.044ms (+0.000ms): __mod_timer (ip_ct_refresh_acct)
00000105 0.045ms (+0.001ms): internal_add_timer (__mod_timer)
00000102 0.046ms (+0.001ms): local_bh_enable (tcp_packet)
00000002 0.047ms (+0.001ms): ip_rcv_finish (nf_hook_slow)
00000002 0.048ms (+0.000ms): ip_route_input (ip_rcv_finish)
00000002 0.048ms (+0.000ms): rt_hash_code (ip_route_input)
00000002 0.051ms (+0.003ms): ip_local_deliver (ip_rcv_finish)
00000002 0.052ms (+0.000ms): nf_hook_slow (ip_local_deliver)
00000003 0.052ms (+0.000ms): nf_iterate (nf_hook_slow)
00000003 0.053ms (+0.000ms): ip_confirm (nf_iterate)
00000003 0.054ms (+0.000ms): ip_local_deliver_finish (nf_hook_slow)
00000004 0.055ms (+0.001ms): tcp_v4_rcv (ip_local_deliver_finish)
00000004 0.056ms (+0.000ms): tcp_v4_checksum_init (tcp_v4_rcv)
00000005 0.060ms (+0.004ms): tcp_v4_do_rcv (tcp_v4_rcv)
00000005 0.061ms (+0.000ms): tcp_rcv_established (tcp_v4_do_rcv)
00000005 0.062ms (+0.001ms): __tcp_checksum_complete_user (tcp_rcv_established)
00000005 0.063ms (+0.000ms): skb_checksum (__tcp_checksum_complete_user)
00000005 0.065ms (+0.001ms): tcp_rcv_rtt_update (tcp_rcv_established)
00000005 0.066ms (+0.001ms): tcp_event_data_recv (tcp_rcv_established)
00000005 0.069ms (+0.002ms): __tcp_ack_snd_check (tcp_rcv_established)
00000005 0.070ms (+0.000ms): __tcp_select_window (__tcp_ack_snd_check)
00000005 0.070ms (+0.000ms): tcp_send_ack (tcp_rcv_established)
00000005 0.071ms (+0.000ms): alloc_skb (tcp_send_ack)
00000005 0.071ms (+0.000ms): kmem_cache_alloc (alloc_skb)
00000005 0.072ms (+0.000ms): __kmalloc (alloc_skb)
00000005 0.074ms (+0.002ms): tcp_transmit_skb (tcp_send_ack)
00000005 0.076ms (+0.001ms): __tcp_select_window (tcp_transmit_skb)
00000005 0.078ms (+0.001ms): tcp_v4_send_check (tcp_transmit_skb)
00000005 0.079ms (+0.001ms): ip_queue_xmit (tcp_transmit_skb)
00000005 0.082ms (+0.003ms): nf_hook_slow (ip_queue_xmit)
00000006 0.083ms (+0.000ms): nf_iterate (nf_hook_slow)
00000006 0.084ms (+0.000ms): ip_conntrack_defrag (nf_iterate)
00000006 0.084ms (+0.000ms): ip_conntrack_local (nf_iterate)
00000006 0.085ms (+0.000ms): ip_conntrack_in (nf_iterate)
00000006 0.085ms (+0.000ms): ip_ct_find_proto (ip_conntrack_in)
00000107 0.086ms (+0.000ms): __ip_ct_find_proto (ip_ct_find_proto)
00000106 0.086ms (+0.000ms): local_bh_enable (ip_ct_find_proto)
00000006 0.087ms (+0.000ms): tcp_error (ip_conntrack_in)
00000006 0.088ms (+0.000ms): ip_ct_get_tuple (ip_conntrack_in)
00000006 0.088ms (+0.000ms): tcp_pkt_to_tuple (ip_ct_get_tuple)
00000006 0.089ms (+0.000ms): ip_conntrack_find_get (ip_conntrack_in)
00000107 0.089ms (+0.000ms): __ip_conntrack_find (ip_conntrack_find_get)
00000107 0.089ms (+0.000ms): hash_conntrack (__ip_conntrack_find)
00000106 0.090ms (+0.000ms): local_bh_enable (ip_conntrack_find_get)
00000006 0.091ms (+0.000ms): tcp_packet (ip_conntrack_in)
00000107 0.091ms (+0.000ms): get_conntrack_index (tcp_packet)
00000107 0.092ms (+0.000ms): tcp_in_window (tcp_packet)
00000107 0.093ms (+0.000ms): tcp_sack (tcp_in_window)
00000106 0.094ms (+0.001ms): local_bh_enable (tcp_packet)
00000006 0.094ms (+0.000ms): ip_ct_refresh_acct (tcp_packet)
00000107 0.095ms (+0.000ms): del_timer (ip_ct_refresh_acct)
00000107 0.095ms (+0.000ms): __mod_timer (ip_ct_refresh_acct)
00000109 0.096ms (+0.000ms): internal_add_timer (__mod_timer)
00000106 0.097ms (+0.000ms): local_bh_enable (tcp_packet)
00000006 0.098ms (+0.000ms): dst_output (nf_hook_slow)
00000006 0.098ms (+0.000ms): ip_output (dst_output)
00000006 0.099ms (+0.000ms): ip_finish_output (dst_output)
00000006 0.099ms (+0.000ms): nf_hook_slow (ip_finish_output)
00000007 0.100ms (+0.000ms): nf_iterate (nf_hook_slow)
00000007 0.100ms (+0.000ms): ip_refrag (nf_iterate)
00000007 0.101ms (+0.000ms): ip_confirm (ip_refrag)
00000007 0.101ms (+0.000ms): ip_finish_output2 (nf_hook_slow)
00000107 0.102ms (+0.001ms): local_bh_enable (ip_finish_output2)
00000007 0.103ms (+0.000ms): neigh_resolve_output (ip_finish_output2)
00000108 0.104ms (+0.001ms): eth_header (neigh_resolve_output)
00000107 0.106ms (+0.001ms): local_bh_enable (neigh_resolve_output)
00000007 0.107ms (+0.001ms): dev_queue_xmit (neigh_resolve_output)
00000109 0.108ms (+0.001ms): pfifo_fast_enqueue (dev_queue_xmit)
00000109 0.109ms (+0.000ms): qdisc_restart (dev_queue_xmit)
00000109 0.110ms (+0.000ms): pfifo_fast_dequeue (qdisc_restart)
00000109 0.111ms (+0.001ms): dev_queue_xmit_nit (qdisc_restart)
0000010a 0.112ms (+0.000ms): skb_clone (dev_queue_xmit_nit)
0000010a 0.112ms (+0.000ms): kmem_cache_alloc (skb_clone)
0000010a 0.113ms (+0.000ms): memcpy (skb_clone)
0000010a 0.114ms (+0.001ms): packet_rcv_spkt (dev_queue_xmit_nit)
0000010a 0.114ms (+0.000ms): strlcpy (packet_rcv_spkt)
0000010b 0.115ms (+0.000ms): sk_run_filter (packet_rcv_spkt)
0000010a 0.116ms (+0.000ms): __kfree_skb (packet_rcv_spkt)
0000010a 0.116ms (+0.000ms): kfree_skbmem (__kfree_skb)
0000010a 0.117ms (+0.000ms): skb_release_data (kfree_skbmem)
0000010a 0.117ms (+0.000ms): kmem_cache_free (kfree_skbmem)
00000109 0.118ms (+0.000ms): rhine_start_tx (qdisc_restart)
00000109 0.122ms (+0.004ms): qdisc_restart (dev_queue_xmit)
00000109 0.122ms (+0.000ms): pfifo_fast_dequeue (qdisc_restart)
00000108 0.123ms (+0.000ms): local_bh_enable (dev_queue_xmit)
00000005 0.124ms (+0.001ms): sock_def_readable (tcp_rcv_established)
00000006 0.125ms (+0.000ms): __wake_up (sock_def_readable)
00000007 0.126ms (+0.000ms): __wake_up_common (__wake_up)
00000007 0.127ms (+0.000ms): default_wake_function (__wake_up_common)
00000007 0.127ms (+0.000ms): try_to_wake_up (__wake_up_common)
00000007 0.128ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000008 0.129ms (+0.000ms): activate_task (try_to_wake_up)
00000008 0.129ms (+0.000ms): sched_clock (activate_task)
00000008 0.130ms (+0.000ms): recalc_task_prio (activate_task)
00000008 0.131ms (+0.000ms): effective_prio (recalc_task_prio)
00000008 0.131ms (+0.000ms): enqueue_task (activate_task)
00010007 0.133ms (+0.001ms): do_IRQ (__wake_up)
00010008 0.134ms (+0.000ms): mask_and_ack_8259A (do_IRQ)
00010008 0.138ms (+0.004ms): generic_redirect_hardirq (do_IRQ)
00010008 0.138ms (+0.000ms): wake_up_process (generic_redirect_hardirq)
00010008 0.139ms (+0.000ms): try_to_wake_up (wake_up_process)
00010008 0.139ms (+0.000ms): task_rq_lock (try_to_wake_up)
00010009 0.140ms (+0.000ms): activate_task (try_to_wake_up)
00010009 0.140ms (+0.000ms): sched_clock (activate_task)
00010009 0.140ms (+0.000ms): recalc_task_prio (activate_task)
00010009 0.141ms (+0.000ms): effective_prio (recalc_task_prio)
00010009 0.141ms (+0.000ms): enqueue_task (activate_task)
00000001 0.145ms (+0.003ms): sub_preempt_count (netif_receive_skb)
00000001 0.146ms (+0.000ms): update_max_trace (check_preempt_timing)
00000001 0.146ms (+0.000ms): _mmx_memcpy (update_max_trace)
00000001 0.147ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)

Lee


