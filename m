Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315616AbSENLkX>; Tue, 14 May 2002 07:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315623AbSENLkV>; Tue, 14 May 2002 07:40:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:21238 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315616AbSENLjL>;
	Tue, 14 May 2002 07:39:11 -0400
Date: Tue, 14 May 2002 17:12:03 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockfree rtcache lookup using RCU
Message-ID: <20020514171203.C9918@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020508142433.D10505@in.ibm.com> <20020508.020932.128330582.davem@redhat.com> <20020508185457.I10505@in.ibm.com> <20020508.064528.27619995.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 06:45:28AM -0700, David S. Miller wrote:
>    From: Dipankar Sarma <dipankar@in.ibm.com>
>    Date: Wed, 8 May 2002 18:54:57 +0530
>    
>    A large number of processes of which small sets may look up the same
>    ip address. dst ip addresses change after every 50 packets or
>    so.
>    
>    Is this more realistic ?
> 
> More like every 4 or 5 packets.

Ok, here are some results from a test like that on a 8-way PIII
xeon with 1MB L2 cache. The test has 32 processes sending
random sized packets with dst ip changing every 5 packets.
There results are probably a bit skewed because of the neighbor
table overflows as seen in by the high profile count in
__write_lock_failed and neigh_forced_gc. It does seem that
the packet rate in this test is very high.

ip_route_output_key() is 22% faster with rt_rcu. I will publish 
the results on a 16way NUMA later.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.



base (2.5.3)
----
__write_lock_failed [c0107af0]: 602749
stext_lock [c024eb18]: 178874
neigh_forced_gc [c020a430]: 104295
USER [c01263d0]: 49856
qdisc_restart [c020f070]: 45435
__read_lock_failed [c0107b10]: 35868
dev_queue_xmit [c0207d00]: 27545
__generic_copy_from_user [c0193b10]: 18680
ace_start_xmit [c01bf670]: 14331
nf_hook_slow [c020e940]: 8365
__kfree_skb [c0204180]: 6919
default_idle [c0106ed0]: 6511
sock_alloc_send_pskb [c02032d0]: 6420
ace_interrupt [c01bf180]: 6254
pfifo_fast_dequeue [c020f550]: 4466
net_tx_action [c0208230]: 4228
ip_finish_output2 [c0219520]: 3747
kfree_skbmem [c0204110]: 3436
ip_route_output_key [c0214470]: 3034



rt_rcu (2.5.3)
-------

__write_lock_failed [c0107af0]: 558354
stext_lock [c024ef58]: 227526
neigh_forced_gc [c020aaa0]: 100893
USER [c0126a40]: 49559
qdisc_restart [c020f6e0]: 45950
dev_queue_xmit [c0208370]: 27353
__read_lock_failed [c0107b10]: 24113
__generic_copy_from_user [c0194180]: 18375
ace_start_xmit [c01bfce0]: 15677
nf_hook_slow [c020efb0]: 8865
__kfree_skb [c02047f0]: 6890
sock_alloc_send_pskb [c0203940]: 6239
ace_interrupt [c01bf7f0]: 5982
default_idle [c0106ed0]: 4679
pfifo_fast_dequeue [c020fbc0]: 4067
ip_finish_output2 [c0219940]: 3886
kfree_skbmem [c0204780]: 3496 
pfifo_fast_enqueue [c020fb40]: 3003
net_tx_action [c02088a0]: 2994
sock_def_write_space [c0204230]: 2552
sock_wfree [c0203700]: 2408
skb_release_data [c02046f0]: 2395
ip_route_output_key [c0214990]: 2358


