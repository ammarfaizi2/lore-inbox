Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSFDMFi>; Tue, 4 Jun 2002 08:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316194AbSFDMFh>; Tue, 4 Jun 2002 08:05:37 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:39374 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314707AbSFDMFe>; Tue, 4 Jun 2002 08:05:34 -0400
Subject: Re: [Lse-tech] Re: [RFC] Dynamic percpu data allocator
To: dipankar@beaverton.ibm.com
Cc: BALBIR SINGH <balbir.singh@wipro.com>, linux-kernel@vger.kernel.org,
        "Paul McKenney" <Paul.McKenney@us.ibm.com>,
        "'Rusty Russell'" <rusty@rustcorp.com.au>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF6674079C.AB13B60B-ON85256BCE.00412C60@raleigh.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Tue, 4 Jun 2002 07:05:58 -0500
X-MIMETrack: Serialize by Router on D04NM108/04/M/IBM(Release 5.0.9a |January 7, 2002) at
 06/04/2002 08:05:31 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>> For sometime now, I have been thinking of implementing/supporting
>> PME's (Peformance Monitoring Events and Counters), so that we can
>> get real values (atleast on x86) as compared to our guesses about
>> cacheline bouncing, etc. Do you know if somebody is already doing
>> this?

>You can use SGI kernprof to measure PMCs. See the SGI oss
>website for details. You can count L2_LINES_IN event to
>get a measure of cache line bouncing.

I have profiled L2_LINES_OUT on netperf tcp_stream workload.
The following is the profiling from a 100mb ethernet tcp_stream
4 adapter test baseline 2.4.17 kernel:

poll_idle [c0105280]: 121743
csum_partial_copy_generic [c0277f60]: 27951
schedule [c0114190]: 24853
do_softirq [c011b9e0]: 9130
mod_timer [c011eb10]: 6997
tcp_v4_rcv [c0258b70]: 6449
speedo_interrupt [c01a83e0]: 6262
__wake_up [c0114720]: 6143
tcp_recvmsg [c0249930]: 5199
USER [c0124a70]: 5081
speedo_start_xmit [c01a7fc0]: 4349
tcp_rcv_established [c0250c90]: 3724
tcp_data_wait [c02496d0]: 3610
speedo_rx [c01a8900]: 3358
handle_IRQ_event [c0108a60]: 3339
__kfree_skb [c0230520]: 2716
net_rx_action [c0233f10]: 2510
mcount [c02784e0]: 2261
ip_route_input [c023ee40]: 2028
ip_rcv [c0241180]: 1912
ip_queue_xmit [c0243950]: 1886
tcp_transmit_skb [c0252400]: 1877
__switch_to [c01059d0]: 1522
tcp_prequeue_process [c0249860]: 1461
skb_copy_and_csum_datagram_iovec [c0232590]: 1393
netif_rx [c0233ba0]: 1360
sock_recvmsg [c022cfc0]: 1358
eth_type_trans [c023a260]: 1350
tcp_event_data_recv [c024c320]: 1344
ip_output [c0243810]: 1333
speedo_tx_buffer_gc [c01a81d0]: 1239
tcp_v4_do_rcv [c0258a50]: 1169
kmalloc [c012dda0]: 1154
tcp_copy_to_iovec [c0250ae0]: 1138
fput [c0136d30]: 1124
sys_recvfrom [c022df40]: 1105
speedo_refill_rx_buf [c01a86d0]: 1045
kfree [c012df90]: 1015
dev_queue_xmit [c0233860]: 952
alloc_skb [c02301e0]: 936
do_gettimeofday [c010c520]: 919
system_call [c01070d8]: 918
fget [c0136e30]: 901
sys_socketcall [c022e610]: 887
skb_release_data [c0230420]: 882
ip_local_deliver [c0241020]: 808
skb_copy_and_csum_datagram [c02322a0]: 805
csum_partial [c0277e78]: 781
cleanup_rbuf [c02495d0]: 736
kfree_skbmem [c02304b0]: 696
sock_wfree [c022f380]: 600
inet_recvmsg [c0264720]: 596
speedo_refill_rx_buffers [c01a88b0]: 568
qdisc_restart [c023a4e0]: 568
__generic_copy_from_user [c02781d0]: 501
do_check_pgt_cache [c0112de0]: 494
sys_recv [c022e020]: 488
remove_wait_queue [c0115930]: 487
check_pgt_cache [c0124b30]: 483
add_wait_queue [c01158b0]: 430
__generic_copy_to_user [c0278180]: 429
tcp_send_delayed_ack [c0254e30]: 405
tcp_v4_checksum_init [c0258930]: 391
cpu_idle [c01052b0]: 386
sockfd_lookup [c022cd70]: 370
pfifo_fast_enqueue [c023a940]: 350
schedule_timeout [c0114060]: 314
pfifo_fast_dequeue [c023a9c0]: 304


To eliminate the cache-line bouncing, I applied IRQ and PROCESS
affinity. The L2_CACHE_LINES_OUT profiling with affinity:

poll_idle [c0105280]: 72241
csum_partial_copy_generic [c0289500]: 13838
schedule [c0114190]: 9036
speedo_interrupt [c01b9980]: 5066
do_softirq [c011b9e0]: 3922
USER [c0124c80]: 2573
tcp_recvmsg [c025aed0]: 2154
__wake_up [c0114720]: 1779
speedo_start_xmit [c01b9560]: 1654
mod_timer [c011eb10]: 1551
tcp_rcv_established [c0262230]: 1336
mcount [c0289a80]: 1298
tcp_transmit_skb [c02639a0]: 984
__switch_to [c01059d0]: 927
do_gettimeofday [c010c520]: 876
sys_socketcall [c023fbb0]: 872
ip_rcv [c0252720]: 872
ip_route_input [c02503e0]: 868
ip_queue_xmit [c0254ef0]: 805
system_call [c01070d8]: 772
tcp_data_wait [c025ac70]: 748
__kfree_skb [c0241ac0]: 640
tcp_v4_rcv [c026a110]: 629
do_check_pgt_cache [c0112de0]: 584
ip_output [c0254db0]: 575
net_rx_action [c02454b0]: 565
kfree [c012e1a0]: 556
fput [c0136f40]: 524
csum_partial [c0289418]: 514
handle_IRQ_event [c0108a60]: 507
sock_recvmsg [c023e560]: 479
cleanup_rbuf [c025ab70]: 430
skb_copy_and_csum_datagram [c0243840]: 428
dev_queue_xmit [c0244e00]: 409
sys_recvfrom [c023f4e0]: 404
kfree_skbmem [c0241a50]: 391
speedo_tx_buffer_gc [c01b9770]: 388
skb_copy_and_csum_datagram_iovec [c0243b30]: 383
kmalloc [c012dfb0]: 379
ip_local_deliver [c02525c0]: 362
netif_rx [c0245140]: 361
tcp_copy_to_iovec [c0262080]: 356
tcp_event_data_recv [c025d8c0]: 334
tcp_prequeue_process [c025ae00]: 319
fget [c0137040]: 300
tcp_v4_do_rcv [c0269ff0]: 285
add_wait_queue [c01158b0]: 267
skb_release_data [c02419c0]: 249
alloc_skb [c0241780]: 249
schedule_timeout [c0114060]: 238
remove_wait_queue [c0115930]: 233
sockfd_lookup [c023e310]: 232
__generic_copy_from_user [c0289770]: 224
sys_recv [c023f5c0]: 216


Regards,
    Mala


   Mala Anand
   E-mail:manand@us.ibm.com
   Linux Technology Center - Performance
   Phone:838-8088; Tie-line:678-8088




