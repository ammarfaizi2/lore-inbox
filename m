Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWHQAXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWHQAXN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 20:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWHQAXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 20:23:13 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:39333 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932154AbWHQAXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 20:23:11 -0400
Date: Wed, 16 Aug 2006 19:23:07 -0500
To: David Miller <davem@davemloft.net>
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, akpm@osdl.org, jeff@garzik.org,
       netdev@vger.kernel.org, jklewis@us.ibm.com,
       linux-kernel@vger.kernel.org, Jens.Osterkamp@de.ibm.com
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
Message-ID: <20060817002307.GQ20551@austin.ibm.com>
References: <20060816.143203.11626235.davem@davemloft.net> <200608170016.47072.arnd@arndb.de> <20060816233028.GO20551@austin.ibm.com> <20060816.163252.64000941.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816.163252.64000941.davem@davemloft.net>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 04:32:52PM -0700, David Miller wrote:
> From: linas@austin.ibm.com (Linas Vepstas)
> > Why would you want to do this? It seems like a cruddier strategy 
> > than what we can already do  (which is to never get an transmit
> > interrupt, as long as the kernel can shove data into the device fast
> > enough to keep the queue from going empty.)  The whole *point* of a 
> > low-watermark interrupt is to never have to actually get the interrupt, 
> > if the rest of the system is on its toes and is supplying data fast
> > enough.
> 
> As long as TX packets get freed within a certain latency
> boundary, this kind of scheme should be fine.

I just had some fun making sure I wasn't making a liar out of myself.
So far, I'm good.

Did

echo 768111 > /proc/sys/net/core/wmem_max
echo 768111 > /proc/sys/net/core/wmem_default

to make sure that the app never blocked on a full socket.

(If the socket is small, then the app blocks, 
the transmit queue drains, and we do get an interupt -- 
about 1K/sec, which is what is expected).

Ran 'vmstat 10' to watch the interrupts in real time. 
Ran netperf, got 904 Mbits/sec, and *no* interrupts. 
Yahoo!

Ran oprofile to see where he time went:

CPU: ppc64 Cell Broadband Engine, speed 3200 MHz (estimated)
Counted CYCLES events (Processor Cycles) with a unit mask of 0x00 (No unit mask) count 100000
samples  %        image name               app name                 symbol name
13748742 77.6620  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .cbe_idle
936172    5.2881  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .__copy_tofrom_user
569353    3.2161  spidernet.ko             spidernet                .spider_net_xmit
450826    2.5466  spidernet.ko             spidernet                .spider_net_release_tx_chain
220374    1.2448  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       ._spin_unlock_irqrestore
112432    0.6351  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       ._spin_lock
91328     0.5159  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .__qdisc_run
84804     0.4790  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .packet_sendmsg
76167     0.4302  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .kfree
74321     0.4198  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .sock_alloc_send_skb
65323     0.3690  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .kmem_cache_free
60334     0.3408  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       ._read_lock
60071     0.3393  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .dev_queue_xmit
56900     0.3214  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .kmem_cache_alloc_node
55281     0.3123  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .sock_wfree
51242     0.2894  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .dev_get_by_index
50438     0.2849  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .compat_sys_socketcall
49247     0.2782  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .fput
48589     0.2745  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .sync_buffer
46055     0.2601  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       system_call_common
40607     0.2294  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .local_bh_enable
40273     0.2275  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .__might_sleep
38757     0.2189  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .fget_light
38219     0.2159  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .__kfree_skb
36804     0.2079  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .sock_def_write_space
36443     0.2059  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .skb_release_data
32174     0.1817  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .sys_sendto
31828     0.1798  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .sock_sendmsg
30676     0.1733  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .pfifo_fast_dequeue
29607     0.1672  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .add_event_entry
25870     0.1461  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       syscall_exit
25329     0.1431  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .__alloc_skb
23885     0.1349  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .__do_softirq
22046     0.1245  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .kmem_find_general_cachep
21610     0.1221  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .__dev_get_by_index
21059     0.1190  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .dma_map_single
21044     0.1189  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       ._spin_lock_irqsave
20105     0.1136  vmlinux-2.6.18-rc2       vmlinux-2.6.18-rc2       .memset

.__copy_tofrom_user          -- ouch spider does not currently do scatter-gather
.spider_net_xmit             -- hmmm ?? why is it this large ??
.spider_net_release_tx_chain --  ?? a lot of time being spent cleaning up tx queues.
._spin_unlock_irqrestore     -- hmm ? why so high? lock contention?

I presume the rest is normal.

