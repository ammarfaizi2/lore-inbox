Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWGLCdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWGLCdP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 22:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWGLCdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 22:33:15 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:5552 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S932352AbWGLCdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 22:33:14 -0400
X-IronPort-AV: i="4.06,230,1149490800"; 
   d="scan'208"; a="305058533:sNHT43091918"
To: "Zach Brown" <zach.brown@oracle.com>
Cc: openib-general@openib.org,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Arjan van de Ven" <arjan@infradead.org>, "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [openib-general] ipoib lockdep warning
X-Message-Flag: Warning: May contain useful information
References: <44B405C8.4040706@oracle.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 11 Jul 2006 19:33:07 -0700
In-Reply-To: <44B405C8.4040706@oracle.com> (Zach Brown's message of "Tue, 11 Jul 2006 13:10:48 -0700")
Message-ID: <ada7j2jzh5o.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Jul 2006 02:33:11.0589 (UTC) FILETIME=[84D66D50:01C6A55B]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, the patch to lib/idr.c below is at least one way to fix this.
However, with that applied I get the lockdep warning below, which
seems to be a false positive -- I'm not sure what the right fix is,
but the blame really seems to fall on udp_ioctl for poking into the
sk_buff_head lock itself.

Ingo and/or Arjan, any thoughts on the idr.c change or the
sk_buff_head warning?

Thanks,
  Roland


Here's the idr.c change:

diff --git a/lib/idr.c b/lib/idr.c
index 4d09681..16d2143 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -38,14 +38,15 @@ static kmem_cache_t *idr_layer_cache;
 static struct idr_layer *alloc_layer(struct idr *idp)
 {
 	struct idr_layer *p;
+	unsigned long flags;
 
-	spin_lock(&idp->lock);
+	spin_lock_irqsave(&idp->lock, flags);
 	if ((p = idp->id_free)) {
 		idp->id_free = p->ary[0];
 		idp->id_free_cnt--;
 		p->ary[0] = NULL;
 	}
-	spin_unlock(&idp->lock);
+	spin_unlock_irqrestore(&idp->lock, flags);
 	return(p);
 }
 
@@ -59,12 +60,14 @@ static void __free_layer(struct idr *idp
 
 static void free_layer(struct idr *idp, struct idr_layer *p)
 {
+	unsigned long flags;
+
 	/*
 	 * Depends on the return element being zeroed.
 	 */
-	spin_lock(&idp->lock);
+	spin_lock_irqsave(&idp->lock, flags);
 	__free_layer(idp, p);
-	spin_unlock(&idp->lock);
+	spin_unlock_irqrestore(&idp->lock, flags);
 }
 
 /**
@@ -168,6 +171,7 @@ static int idr_get_new_above_int(struct 
 {
 	struct idr_layer *p, *new;
 	int layers, v, id;
+	unsigned long flags;
 
 	id = starting_id;
 build_up:
@@ -191,14 +195,14 @@ build_up:
 			 * The allocation failed.  If we built part of
 			 * the structure tear it down.
 			 */
-			spin_lock(&idp->lock);
+			spin_lock_irqsave(&idp->lock, flags);
 			for (new = p; p && p != idp->top; new = p) {
 				p = p->ary[0];
 				new->ary[0] = NULL;
 				new->bitmap = new->count = 0;
 				__free_layer(idp, new);
 			}
-			spin_unlock(&idp->lock);
+			spin_unlock_irqrestore(&idp->lock, flags);
 			return -1;
 		}
 		new->ary[0] = p;


And here's the warning I get, which appears to be a false positive:

======================================================
[ INFO: hard-safe -> hard-unsafe lock order detected ]
------------------------------------------------------
swapper/0 [HC0[0]:SC1[2]:HE0:SE0] is trying to acquire:
 (&skb_queue_lock_key){-+..}, at: [<ffffffff8038683e>] skb_queue_tail+0x1d/0x47

and this task is already holding:
 (&priv->lock){.+..}, at: [<ffffffff881efd5b>] ipoib_mcast_send+0x29/0x413 [ib_ipoib]
which would create a new lock dependency:
 (&priv->lock){.+..} -> (&skb_queue_lock_key){-+..}

but this new dependency connects a hard-irq-safe lock:
 (&priv->tx_lock){+...}
... which became hard-irq-safe at:
  [<ffffffff8024172a>] lock_acquire+0x4a/0x69
  [<ffffffff803eb7da>] _spin_lock_irqsave+0x2b/0x3c
  [<ffffffff881ee615>] ipoib_ib_completion+0x340/0x3ff [ib_ipoib]
  [<ffffffff881ca8a5>] mthca_cq_completion+0x65/0x6b [ib_mthca]
  [<ffffffff881ca1bc>] mthca_eq_int+0x70/0x3d2 [ib_mthca]
  [<ffffffff881ca644>] mthca_arbel_interrupt+0x3b/0x98 [ib_mthca]
  [<ffffffff802537de>] handle_IRQ_event+0x28/0x64
  [<ffffffff802538c6>] __do_IRQ+0xac/0x117
  [<ffffffff8020becf>] do_IRQ+0xf7/0x108
  [<ffffffff80209bd8>] common_interrupt+0x64/0x65

to a hard-irq-unsafe lock:
 (&skb_queue_lock_key){-+..}
... which became hard-irq-unsafe at:
...  [<ffffffff8024172a>] lock_acquire+0x4a/0x69
  [<ffffffff803eb349>] _spin_lock_bh+0x26/0x33
  [<ffffffff803c6de8>] udp_ioctl+0x46/0x87
  [<ffffffff803cd1ab>] inet_ioctl+0x8c/0x8f
  [<ffffffff8038203c>] sock_ioctl+0x1c0/0x1ea
  [<ffffffff8028591e>] do_ioctl+0x26/0x74
  [<ffffffff80285bb6>] vfs_ioctl+0x24a/0x264
  [<ffffffff80285c11>] sys_ioctl+0x41/0x68
  [<ffffffff802096a1>] system_call+0x7d/0x83

other info that might help us debug this:

2 locks held by swapper/0:
 #0:  (&priv->tx_lock){+...}, at: [<ffffffff881ed6ef>] ipoib_start_xmit+0x42/0x66d [ib_ipoib]
 #1:  (&priv->lock){.+..}, at: [<ffffffff881efd5b>] ipoib_mcast_send+0x29/0x413 [ib_ipoib]

the hard-irq-safe lock's dependencies:
-> (&priv->tx_lock){+...} ops: 0 {
   initial-use  at:
                        [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                        [<ffffffff803eb644>] _spin_lock_irq+0x28/0x35
                        [<ffffffff881ef705>] ipoib_mcast_join_finish+0x340/0x379 [ib_ipoib]
                        [<ffffffff881ef7e0>] ipoib_mcast_join_complete+0xa2/0x294 [ib_ipoib]
                        [<ffffffff881e6389>] ib_sa_mcmember_rec_callback+0x4b/0x57 [ib_sa]
                        [<ffffffff881e648d>] recv_handler+0x3d/0x4a [ib_sa]
                        [<ffffffff881b9c20>] ib_mad_completion_handler+0x3df/0x5e4 [ib_mad]
                        [<ffffffff80238422>] run_workqueue+0xa0/0xf7
                        [<ffffffff8023861d>] worker_thread+0xee/0x122
                        [<ffffffff8023b661>] kthread+0xd0/0xfb
                        [<ffffffff8020a5f1>] child_rip+0x7/0x12
   in-hardirq-W at:
                        [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                        [<ffffffff803eb7da>] _spin_lock_irqsave+0x2b/0x3c
                        [<ffffffff881ee615>] ipoib_ib_completion+0x340/0x3ff [ib_ipoib]
                        [<ffffffff881ca8a5>] mthca_cq_completion+0x65/0x6b [ib_mthca]
                        [<ffffffff881ca1bc>] mthca_eq_int+0x70/0x3d2 [ib_mthca]
                        [<ffffffff881ca644>] mthca_arbel_interrupt+0x3b/0x98 [ib_mthca]
                        [<ffffffff802537de>] handle_IRQ_event+0x28/0x64
                        [<ffffffff802538c6>] __do_IRQ+0xac/0x117
                        [<ffffffff8020becf>] do_IRQ+0xf7/0x108
                        [<ffffffff80209bd8>] common_interrupt+0x64/0x65
 }
 ... key      at: [<ffffffff881f9a28>] __key.23652+0x0/0xffffffffffff804f [ib_ipoib]
 -> (&priv->lock){.+..} ops: 0 {
    initial-use  at:
                          [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                          [<ffffffff803eb644>] _spin_lock_irq+0x28/0x35
                          [<ffffffff881ef2c6>] ipoib_mcast_start_thread+0x6e/0x87 [ib_ipoib]
                          [<ffffffff881eee7d>] ipoib_ib_dev_up+0x52/0x58 [ib_ipoib]
                          [<ffffffff881ec23f>] ipoib_open+0x65/0x102 [ib_ipoib]
                          [<ffffffff8038c74c>] dev_open+0x3a/0x80
                          [<ffffffff8038ba90>] dev_change_flags+0x65/0x139
                          [<ffffffff803ccb56>] devinet_ioctl+0x240/0x5e2
                          [<ffffffff803cd18f>] inet_ioctl+0x70/0x8f
                          [<ffffffff8038203c>] sock_ioctl+0x1c0/0x1ea
                          [<ffffffff8028591e>] do_ioctl+0x26/0x74
                          [<ffffffff80285bb6>] vfs_ioctl+0x24a/0x264
                          [<ffffffff80285c11>] sys_ioctl+0x41/0x68
                          [<ffffffff802096a1>] system_call+0x7d/0x83
    in-softirq-W at:
                          [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                          [<ffffffff803eb316>] _spin_lock+0x21/0x2e
                          [<ffffffff881efd5a>] ipoib_mcast_send+0x28/0x413 [ib_ipoib]
                          [<ffffffff881eda0e>] ipoib_start_xmit+0x361/0x66d [ib_ipoib]
                          [<ffffffff8038dfc8>] dev_hard_start_xmit+0x1ab/0x221
                          [<ffffffff8039a024>] __qdisc_run+0xfa/0x1cd
                          [<ffffffff8038e174>] dev_queue_xmit+0x136/0x263
                          [<ffffffff80390209>] neigh_connected_output+0xae/0xc7
                          [<ffffffff8813f4de>] ip6_output2+0x254/0x28c [ipv6]
                          [<ffffffff8813fcf8>] ip6_output+0x7e2/0x7f8 [ipv6]
                          [<ffffffff8814dbf7>] ndisc_send_ns+0x38f/0x4c1 [ipv6]
                          [<ffffffff88145048>] addrconf_dad_timer+0xfb/0x11e [ipv6]
                          [<ffffffff80231a8e>] run_timer_softirq+0x150/0x1dc
                          [<ffffffff8022e345>] __do_softirq+0x6b/0xf7
                          [<ffffffff8020a94d>] call_softirq+0x1d/0x28
                          [<ffffffff8022e0bc>] irq_exit+0x56/0x59
                          [<ffffffff802146ee>] smp_apic_timer_interrupt+0x59/0x5f
                          [<ffffffff8020a2c1>] apic_timer_interrupt+0x69/0x70
  }
  ... key      at: [<ffffffff881f9a30>] __key.23651+0x0/0xffffffffffff8047 [ib_ipoib]
  -> (&idr_lock){....} ops: 0 {
     initial-use  at:
                            [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                            [<ffffffff803eb7da>] _spin_lock_irqsave+0x2b/0x3c
                            [<ffffffff881e6161>] send_mad+0x39/0x141 [ib_sa]
                            [<ffffffff881e6a20>] ib_sa_mcmember_rec_query+0x147/0x17c [ib_sa]
                            [<ffffffff881f02a4>] ipoib_mcast_join+0x15f/0x1f2 [ib_ipoib]
                            [<ffffffff881f0582>] ipoib_mcast_join_task+0x24b/0x2e7 [ib_ipoib]
                            [<ffffffff80238422>] run_workqueue+0xa0/0xf7
                            [<ffffffff8023861d>] worker_thread+0xee/0x122
                            [<ffffffff8023b661>] kthread+0xd0/0xfb
                            [<ffffffff8020a5f1>] child_rip+0x7/0x12
   }
   ... key      at: [<ffffffff881ea488>] __key.17990+0x0/0xffffffffffffc8c2 [ib_sa]
   -> (query_idr.lock){....} ops: 0 {
      initial-use  at:
                              [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                              [<ffffffff803eb7da>] _spin_lock_irqsave+0x2b/0x3c
                              [<ffffffff802e4581>] free_layer+0x1c/0x40
                              [<ffffffff802e45d6>] idr_pre_get+0x31/0x42
                              [<ffffffff881e614d>] send_mad+0x25/0x141 [ib_sa]
                              [<ffffffff881e6a20>] ib_sa_mcmember_rec_query+0x147/0x17c [ib_sa]
                              [<ffffffff881f02a4>] ipoib_mcast_join+0x15f/0x1f2 [ib_ipoib]
                              [<ffffffff881f0582>] ipoib_mcast_join_task+0x24b/0x2e7 [ib_ipoib]
                              [<ffffffff80238422>] run_workqueue+0xa0/0xf7
                              [<ffffffff8023861d>] worker_thread+0xee/0x122
                              [<ffffffff8023b661>] kthread+0xd0/0xfb
                              [<ffffffff8020a5f1>] child_rip+0x7/0x12
    }
    ... key      at: [<ffffffff881e9f30>] query_idr+0x30/0xffffffffffffce4a [ib_sa]
   ... acquired at:
   [<ffffffff8024172a>] lock_acquire+0x4a/0x69
   [<ffffffff803eb7da>] _spin_lock_irqsave+0x2b/0x3c
   [<ffffffff802e4530>] alloc_layer+0x18/0x4d
   [<ffffffff802e48de>] idr_get_new_above_int+0x37/0x225
   [<ffffffff802e4adb>] idr_get_new+0xf/0x2f
   [<ffffffff881e6177>] send_mad+0x4f/0x141 [ib_sa]
   [<ffffffff881e6a20>] ib_sa_mcmember_rec_query+0x147/0x17c [ib_sa]
   [<ffffffff881f02a4>] ipoib_mcast_join+0x15f/0x1f2 [ib_ipoib]
   [<ffffffff881f0582>] ipoib_mcast_join_task+0x24b/0x2e7 [ib_ipoib]
   [<ffffffff80238422>] run_workqueue+0xa0/0xf7
   [<ffffffff8023861d>] worker_thread+0xee/0x122
   [<ffffffff8023b661>] kthread+0xd0/0xfb
   [<ffffffff8020a5f1>] child_rip+0x7/0x12

  ... acquired at:
   [<ffffffff8024172a>] lock_acquire+0x4a/0x69
   [<ffffffff803eb7da>] _spin_lock_irqsave+0x2b/0x3c
   [<ffffffff881e6069>] ib_sa_cancel_query+0x1b/0x73 [ib_sa]
   [<ffffffff881eefb5>] wait_for_mcast_join+0x35/0xd2 [ib_ipoib]
   [<ffffffff881ef385>] ipoib_mcast_stop_thread+0xa6/0xe6 [ib_ipoib]
   [<ffffffff881f07da>] ipoib_mcast_restart_task+0x4b/0x3d9 [ib_ipoib]
   [<ffffffff80238422>] run_workqueue+0xa0/0xf7
   [<ffffffff8023861d>] worker_thread+0xee/0x122
   [<ffffffff8023b661>] kthread+0xd0/0xfb
   [<ffffffff8020a5f1>] child_rip+0x7/0x12

  -> (&mad_agent_priv->lock){....} ops: 0 {
     initial-use  at:
                            [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                            [<ffffffff803eb7da>] _spin_lock_irqsave+0x2b/0x3c
                            [<ffffffff881b936d>] ib_post_send_mad+0x3e0/0x512 [ib_mad]
                            [<ffffffff881bb251>] agent_send_response+0x11b/0x155 [ib_mad]
                            [<ffffffff881b9b2b>] ib_mad_completion_handler+0x2ea/0x5e4 [ib_mad]
                            [<ffffffff80238422>] run_workqueue+0xa0/0xf7
                            [<ffffffff8023861d>] worker_thread+0xee/0x122
                            [<ffffffff8023b661>] kthread+0xd0/0xfb
                            [<ffffffff8020a5f1>] child_rip+0x7/0x12
   }
   ... key      at: [<ffffffff881c1424>] __key.17415+0x0/0xffffffffffffaf74 [ib_mad]
   -> (base_lock_keys + cpu){++..} ops: 0 {
      initial-use  at:
                              [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                              [<ffffffff803eb644>] _spin_lock_irq+0x28/0x35
                              [<ffffffff8023197f>] run_timer_softirq+0x41/0x1dc
                              [<ffffffff8022e345>] __do_softirq+0x6b/0xf7
                              [<ffffffff8020a94d>] call_softirq+0x1d/0x28
                              [<ffffffff8022e0bc>] irq_exit+0x56/0x59
                              [<ffffffff8020bed4>] do_IRQ+0xfc/0x108
                              [<ffffffff80209bd8>] common_interrupt+0x64/0x65
      in-hardirq-W at:
                              [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                              [<ffffffff803eb316>] _spin_lock+0x21/0x2e
                              [<ffffffff80231bad>] __mod_timer+0x93/0xc8
                              [<ffffffff80231c0e>] mod_timer+0x2c/0x2f
                              [<ffffffff80377fb2>] i8042_interrupt+0x2a/0x222
                              [<ffffffff802537de>] handle_IRQ_event+0x28/0x64
                              [<ffffffff802538c6>] __do_IRQ+0xac/0x117
                              [<ffffffff8020becf>] do_IRQ+0xf7/0x108
                              [<ffffffff80209bd8>] common_interrupt+0x64/0x65
                              [<7ffffffffffffffd>] 0x7ffffffffffffffd
                              [<ffffffff8020a94d>] call_softirq+0x1d/0x28
                              [<ffffffff8022e0bc>] irq_exit+0x56/0x59
                              [<ffffffff802146ee>] smp_apic_timer_interrupt+0x59/0x5f
                              [<ffffffff8020a2c1>] apic_timer_interrupt+0x69/0x70
      in-softirq-W at:
                              [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                              [<ffffffff803eb644>] _spin_lock_irq+0x28/0x35
                              [<ffffffff8023197f>] run_timer_softirq+0x41/0x1dc
                              [<ffffffff8022e345>] __do_softirq+0x6b/0xf7
                              [<ffffffff8020a94d>] call_softirq+0x1d/0x28
                              [<ffffffff8022e0bc>] irq_exit+0x56/0x59
                              [<ffffffff8020bed4>] do_IRQ+0xfc/0x108
                              [<ffffffff80209bd8>] common_interrupt+0x64/0x65
    }
    ... key      at: [<ffffffff805a16e0>] base_lock_keys+0x0/0x20
   ... acquired at:
   [<ffffffff8024172a>] lock_acquire+0x4a/0x69
   [<ffffffff803eb7da>] _spin_lock_irqsave+0x2b/0x3c
   [<ffffffff80231316>] lock_timer_base+0x21/0x47
   [<ffffffff80231c84>] try_to_del_timer_sync+0x14/0x62
   [<ffffffff80231ce3>] del_timer_sync+0x11/0x1a
   [<ffffffff881b8a7b>] ib_mad_complete_send_wr+0x10b/0x1f8 [ib_mad]
   [<ffffffff881b8c8d>] ib_mad_send_done_handler+0x125/0x17a [ib_mad]
   [<ffffffff881b9db2>] ib_mad_completion_handler+0x571/0x5e4 [ib_mad]
   [<ffffffff80238422>] run_workqueue+0xa0/0xf7
   [<ffffffff8023861d>] worker_thread+0xee/0x122
   [<ffffffff8023b661>] kthread+0xd0/0xfb
   [<ffffffff8020a5f1>] child_rip+0x7/0x12

   -> (base_lock_keys + cpu#4){++..} ops: 0 {
      initial-use  at:
                              [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                              [<ffffffff803eb644>] _spin_lock_irq+0x28/0x35
                              [<ffffffff8023197f>] run_timer_softirq+0x41/0x1dc
                              [<ffffffff8022e345>] __do_softirq+0x6b/0xf7
                              [<ffffffff8020a94d>] call_softirq+0x1d/0x28
                              [<ffffffff8022e0bc>] irq_exit+0x56/0x59
                              [<ffffffff802146ee>] smp_apic_timer_interrupt+0x59/0x5f
                              [<ffffffff8020a2c1>] apic_timer_interrupt+0x69/0x70
      in-hardirq-W at:
                              [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                              [<ffffffff803eb7da>] _spin_lock_irqsave+0x2b/0x3c
                              [<ffffffff80231316>] lock_timer_base+0x21/0x47
                              [<ffffffff80231c2f>] del_timer+0x1e/0x5f
                              [<ffffffff8034f281>] scsi_delete_timer+0x12/0x5d
                              [<ffffffff8034d064>] scsi_done+0xd/0x1e
                              [<ffffffff8035d444>] ata_scsi_qc_complete+0xb1/0xc3
                              [<ffffffff803583e9>] __ata_qc_complete+0x218/0x225
                              [<ffffffff803584c5>] ata_qc_complete+0xcf/0xd5
                              [<ffffffff80359cf0>] ata_hsm_qc_complete+0x1c6/0x1d8
                              [<ffffffff8035a31a>] ata_hsm_move+0x618/0x638
                              [<ffffffff8035a8ba>] ata_interrupt+0x161/0x1ae
                              [<ffffffff802537de>] handle_IRQ_event+0x28/0x64
                              [<ffffffff802538c6>] __do_IRQ+0xac/0x117
                              [<ffffffff8020becf>] do_IRQ+0xf7/0x108
                              [<ffffffff80209bd8>] common_interrupt+0x64/0x65
      in-softirq-W at:
                              [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                              [<ffffffff803eb644>] _spin_lock_irq+0x28/0x35
                              [<ffffffff8023197f>] run_timer_softirq+0x41/0x1dc
                              [<ffffffff8022e345>] __do_softirq+0x6b/0xf7
                              [<ffffffff8020a94d>] call_softirq+0x1d/0x28
                              [<ffffffff8022e0bc>] irq_exit+0x56/0x59
                              [<ffffffff802146ee>] smp_apic_timer_interrupt+0x59/0x5f
                              [<ffffffff8020a2c1>] apic_timer_interrupt+0x69/0x70
    }
    ... key      at: [<ffffffff805a16f8>] base_lock_keys+0x18/0x20
   ... acquired at:
   [<ffffffff8024172a>] lock_acquire+0x4a/0x69
   [<ffffffff803eb316>] _spin_lock+0x21/0x2e
   [<ffffffff80231bad>] __mod_timer+0x93/0xc8
   [<ffffffff802386c6>] queue_delayed_work+0x75/0x7d
   [<ffffffff881b776a>] wait_for_response+0xdf/0xe8 [ib_mad]
   [<ffffffff881b8a31>] ib_mad_complete_send_wr+0xc1/0x1f8 [ib_mad]
   [<ffffffff881b8c8d>] ib_mad_send_done_handler+0x125/0x17a [ib_mad]
   [<ffffffff881b9db2>] ib_mad_completion_handler+0x571/0x5e4 [ib_mad]
   [<ffffffff80238422>] run_workqueue+0xa0/0xf7
   [<ffffffff8023861d>] worker_thread+0xee/0x122
   [<ffffffff8023b661>] kthread+0xd0/0xfb
   [<ffffffff8020a5f1>] child_rip+0x7/0x12

   -> (base_lock_keys + cpu#2){++..} ops: 0 {
      initial-use  at:
                              [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                              [<ffffffff803eb644>] _spin_lock_irq+0x28/0x35
                              [<ffffffff8023197f>] run_timer_softirq+0x41/0x1dc
                              [<ffffffff8022e345>] __do_softirq+0x6b/0xf7
                              [<ffffffff8020a94d>] call_softirq+0x1d/0x28
                              [<ffffffff8022e0bc>] irq_exit+0x56/0x59
                              [<ffffffff802146ee>] smp_apic_timer_interrupt+0x59/0x5f
                              [<ffffffff8020a2c1>] apic_timer_interrupt+0x69/0x70
      in-hardirq-W at:
                              [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                              [<ffffffff803eb316>] _spin_lock+0x21/0x2e
                              [<ffffffff80231bad>] __mod_timer+0x93/0xc8
                              [<ffffffff80231c0e>] mod_timer+0x2c/0x2f
                              [<ffffffff80377fb2>] i8042_interrupt+0x2a/0x222
                              [<ffffffff802537de>] handle_IRQ_event+0x28/0x64
                              [<ffffffff802538c6>] __do_IRQ+0xac/0x117
                              [<ffffffff8020becf>] do_IRQ+0xf7/0x108
                              [<ffffffff80209bd8>] common_interrupt+0x64/0x65
      in-softirq-W at:
                              [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                              [<ffffffff803eb644>] _spin_lock_irq+0x28/0x35
                              [<ffffffff8023197f>] run_timer_softirq+0x41/0x1dc
                              [<ffffffff8022e345>] __do_softirq+0x6b/0xf7
                              [<ffffffff8020a94d>] call_softirq+0x1d/0x28
                              [<ffffffff8022e0bc>] irq_exit+0x56/0x59
                              [<ffffffff802146ee>] smp_apic_timer_interrupt+0x59/0x5f
                              [<ffffffff8020a2c1>] apic_timer_interrupt+0x69/0x70
    }
    ... key      at: [<ffffffff805a16e8>] base_lock_keys+0x8/0x20
   ... acquired at:
   [<ffffffff8024172a>] lock_acquire+0x4a/0x69
   [<ffffffff803eb316>] _spin_lock+0x21/0x2e
   [<ffffffff80231bad>] __mod_timer+0x93/0xc8
   [<ffffffff802386c6>] queue_delayed_work+0x75/0x7d
   [<ffffffff881b776a>] wait_for_response+0xdf/0xe8 [ib_mad]
   [<ffffffff881b8a31>] ib_mad_complete_send_wr+0xc1/0x1f8 [ib_mad]
   [<ffffffff881b8c8d>] ib_mad_send_done_handler+0x125/0x17a [ib_mad]
   [<ffffffff881b9db2>] ib_mad_completion_handler+0x571/0x5e4 [ib_mad]
   [<ffffffff80238422>] run_workqueue+0xa0/0xf7
   [<ffffffff8023861d>] worker_thread+0xee/0x122
   [<ffffffff8023b661>] kthread+0xd0/0xfb
   [<ffffffff8020a5f1>] child_rip+0x7/0x12

  ... acquired at:
   [<ffffffff8024172a>] lock_acquire+0x4a/0x69
   [<ffffffff803eb7da>] _spin_lock_irqsave+0x2b/0x3c
   [<ffffffff881b7a16>] ib_modify_mad+0x27/0x14c [ib_mad]
   [<ffffffff881b7b45>] ib_cancel_mad+0xa/0xd [ib_mad]
   [<ffffffff881e60b8>] ib_sa_cancel_query+0x6a/0x73 [ib_sa]
   [<ffffffff881eefb5>] wait_for_mcast_join+0x35/0xd2 [ib_ipoib]
   [<ffffffff881ef385>] ipoib_mcast_stop_thread+0xa6/0xe6 [ib_ipoib]
   [<ffffffff881f07da>] ipoib_mcast_restart_task+0x4b/0x3d9 [ib_ipoib]
   [<ffffffff80238422>] run_workqueue+0xa0/0xf7
   [<ffffffff8023861d>] worker_thread+0xee/0x122
   [<ffffffff8023b661>] kthread+0xd0/0xfb
   [<ffffffff8020a5f1>] child_rip+0x7/0x12

  -> (modlist_lock){.+..} ops: 0 {
     initial-use  at:
                            [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                            [<ffffffff803eb7da>] _spin_lock_irqsave+0x2b/0x3c
                            [<ffffffff80247f0c>] module_text_address+0x15/0x3b
                            [<ffffffff803ee75b>] __register_kprobe+0x2bc/0x2da
                            [<ffffffff803ee8e3>] register_kprobe+0xc/0xf
                            [<ffffffff80806064>] arch_init_kprobes+0xf/0x12
                            [<ffffffff808094be>] init_kprobes+0x3f/0x52
                            [<ffffffff8020718b>] init+0x143/0x308
                            [<ffffffff8020a5f1>] child_rip+0x7/0x12
     in-softirq-W at:
                            [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                            [<ffffffff803eb7da>] _spin_lock_irqsave+0x2b/0x3c
                            [<ffffffff80247e1e>] is_module_address+0x14/0x80
                            [<ffffffff8023ede1>] static_obj+0x6c/0x79
                            [<ffffffff8023ee8b>] lockdep_init_map+0x7d/0xc3
                            [<ffffffff802f64d2>] __spin_lock_init+0x2e/0x58
                            [<ffffffff881ef221>] ipoib_mcast_alloc+0x97/0xce [ib_ipoib]
                            [<ffffffff881efe3b>] ipoib_mcast_send+0x109/0x413 [ib_ipoib]
                            [<ffffffff881eda0e>] ipoib_start_xmit+0x361/0x66d [ib_ipoib]
                            [<ffffffff8038dfc8>] dev_hard_start_xmit+0x1ab/0x221
                            [<ffffffff8039a024>] __qdisc_run+0xfa/0x1cd
                            [<ffffffff8038e174>] dev_queue_xmit+0x136/0x263
                            [<ffffffff80390209>] neigh_connected_output+0xae/0xc7
                            [<ffffffff8813f4de>] ip6_output2+0x254/0x28c [ipv6]
                            [<ffffffff8813fcf8>] ip6_output+0x7e2/0x7f8 [ipv6]
                            [<ffffffff8814d736>] ndisc_send_rs+0x33d/0x46f [ipv6]
                            [<ffffffff881427b9>] addrconf_dad_completed+0x90/0xe2 [ipv6]
                            [<ffffffff88144fc1>] addrconf_dad_timer+0x74/0x11e [ipv6]
                            [<ffffffff80231a8e>] run_timer_softirq+0x150/0x1dc
                            [<ffffffff8022e345>] __do_softirq+0x6b/0xf7
                            [<ffffffff8020a94d>] call_softirq+0x1d/0x28
                            [<ffffffff8022e0bc>] irq_exit+0x56/0x59
                            [<ffffffff802146ee>] smp_apic_timer_interrupt+0x59/0x5f
                            [<ffffffff8020a2c1>] apic_timer_interrupt+0x69/0x70
   }
   ... key      at: [<ffffffff804cfd98>] modlist_lock+0x18/0x40
  ... acquired at:
   [<ffffffff8024172a>] lock_acquire+0x4a/0x69
   [<ffffffff803eb7da>] _spin_lock_irqsave+0x2b/0x3c
   [<ffffffff80247e1e>] is_module_address+0x14/0x80
   [<ffffffff8023ede1>] static_obj+0x6c/0x79
   [<ffffffff8023ee8b>] lockdep_init_map+0x7d/0xc3
   [<ffffffff802f64d2>] __spin_lock_init+0x2e/0x58
   [<ffffffff881ef221>] ipoib_mcast_alloc+0x97/0xce [ib_ipoib]
   [<ffffffff881f0903>] ipoib_mcast_restart_task+0x174/0x3d9 [ib_ipoib]
   [<ffffffff80238422>] run_workqueue+0xa0/0xf7
   [<ffffffff8023861d>] worker_thread+0xee/0x122
   [<ffffffff8023b661>] kthread+0xd0/0xfb
   [<ffffffff8020a5f1>] child_rip+0x7/0x12

  -> (&qp->sq.lock){.+..} ops: 0 {
     initial-use  at:
                            [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                            [<ffffffff803eb644>] _spin_lock_irq+0x28/0x35
                            [<ffffffff881cdef3>] mthca_modify_qp+0x67/0xd7b [ib_mthca]
                            [<ffffffff881a68fa>] ib_modify_qp+0xc/0xf [ib_core]
                            [<ffffffff881b8394>] ib_mad_init_device+0x2db/0x55c [ib_mad]
                            [<ffffffff881a83fe>] ib_register_device+0x20d/0x300 [ib_core]
                            [<ffffffff881d2f53>] mthca_register_device+0x3e0/0x430 [ib_mthca]
                            [<ffffffff881c4f26>] mthca_init_one+0xbc2/0xcbc [ib_mthca]
                            [<ffffffff802fcab2>] pci_device_probe+0x4b/0x72
                            [<ffffffff803481b7>] driver_probe_device+0x59/0xaf
                            [<ffffffff803482d3>] __driver_attach+0x58/0x90
                            [<ffffffff80347665>] bus_for_each_dev+0x48/0x7a
                            [<ffffffff80348047>] driver_attach+0x1b/0x1e
                            [<ffffffff803479d2>] bus_add_driver+0x74/0x112
                            [<ffffffff80348705>] driver_register+0x8c/0x91
                            [<ffffffff802fc684>] __pci_register_driver+0x60/0x84
                            [<ffffffff88022016>] 0xffffffff88022016
                            [<ffffffff80247a93>] sys_init_module+0x174c/0x1884
                            [<ffffffff802096a1>] system_call+0x7d/0x83
     in-softirq-W at:
                            [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                            [<ffffffff803eb7da>] _spin_lock_irqsave+0x2b/0x3c
                            [<ffffffff881cff9d>] mthca_arbel_post_send+0x2f/0x5be [ib_mthca]
                            [<ffffffff881ee043>] ipoib_send+0x117/0x1d6 [ib_ipoib]
                            [<ffffffff881f012d>] ipoib_mcast_send+0x3fb/0x413 [ib_ipoib]
                            [<ffffffff881eda0e>] ipoib_start_xmit+0x361/0x66d [ib_ipoib]
                            [<ffffffff8038dfc8>] dev_hard_start_xmit+0x1ab/0x221
                            [<ffffffff8039a024>] __qdisc_run+0xfa/0x1cd
                            [<ffffffff8038e174>] dev_queue_xmit+0x136/0x263
                            [<ffffffff80390209>] neigh_connected_output+0xae/0xc7
                            [<ffffffff8813f4de>] ip6_output2+0x254/0x28c [ipv6]
                            [<ffffffff8813fcf8>] ip6_output+0x7e2/0x7f8 [ipv6]
                            [<ffffffff8814dbf7>] ndisc_send_ns+0x38f/0x4c1 [ipv6]
                            [<ffffffff88145048>] addrconf_dad_timer+0xfb/0x11e [ipv6]
                            [<ffffffff80231a8e>] run_timer_softirq+0x150/0x1dc
                            [<ffffffff8022e345>] __do_softirq+0x6b/0xf7
                            [<ffffffff8020a94d>] call_softirq+0x1d/0x28
                            [<ffffffff8022e0bc>] irq_exit+0x56/0x59
                            [<ffffffff802146ee>] smp_apic_timer_interrupt+0x59/0x5f
                            [<ffffffff8020a2c1>] apic_timer_interrupt+0x69/0x70
   }
   ... key      at: [<ffffffff881e4060>] __key.20374+0x0/0xffffffffffff231a [ib_mthca]
   -> (&qp->rq.lock){+...} ops: 0 {
      initial-use  at:
                              [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                              [<ffffffff803eb316>] _spin_lock+0x21/0x2e
                              [<ffffffff881cdf02>] mthca_modify_qp+0x76/0xd7b [ib_mthca]
                              [<ffffffff881a68fa>] ib_modify_qp+0xc/0xf [ib_core]
                              [<ffffffff881b8394>] ib_mad_init_device+0x2db/0x55c [ib_mad]
                              [<ffffffff881a83fe>] ib_register_device+0x20d/0x300 [ib_core]
                              [<ffffffff881d2f53>] mthca_register_device+0x3e0/0x430 [ib_mthca]
                              [<ffffffff881c4f26>] mthca_init_one+0xbc2/0xcbc [ib_mthca]
                              [<ffffffff802fcab2>] pci_device_probe+0x4b/0x72
                              [<ffffffff803481b7>] driver_probe_device+0x59/0xaf
                              [<ffffffff803482d3>] __driver_attach+0x58/0x90
                              [<ffffffff80347665>] bus_for_each_dev+0x48/0x7a
                              [<ffffffff80348047>] driver_attach+0x1b/0x1e
                              [<ffffffff803479d2>] bus_add_driver+0x74/0x112
                              [<ffffffff80348705>] driver_register+0x8c/0x91
                              [<ffffffff802fc684>] __pci_register_driver+0x60/0x84
                              [<ffffffff88022016>] 0xffffffff88022016
                              [<ffffffff80247a93>] sys_init_module+0x174c/0x1884
                              [<ffffffff802096a1>] system_call+0x7d/0x83
      in-hardirq-W at:
                              [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                              [<ffffffff803eb7da>] _spin_lock_irqsave+0x2b/0x3c
                              [<ffffffff881cd749>] mthca_arbel_post_receive+0x35/0x23a [ib_mthca]
                              [<ffffffff881ee183>] ipoib_ib_post_receive+0x81/0xf9 [ib_ipoib]
                              [<ffffffff881ee55b>] ipoib_ib_completion+0x286/0x3ff [ib_ipoib]
                              [<ffffffff881ca8a5>] mthca_cq_completion+0x65/0x6b [ib_mthca]
                              [<ffffffff881ca1bc>] mthca_eq_int+0x70/0x3d2 [ib_mthca]
                              [<ffffffff881ca644>] mthca_arbel_interrupt+0x3b/0x98 [ib_mthca]
                              [<ffffffff802537de>] handle_IRQ_event+0x28/0x64
                              [<ffffffff802538c6>] __do_IRQ+0xac/0x117
                              [<ffffffff8020becf>] do_IRQ+0xf7/0x108
                              [<ffffffff80209bd8>] common_interrupt+0x64/0x65
    }
    ... key      at: [<ffffffff881e4058>] __key.20375+0x0/0xffffffffffff2322 [ib_mthca]
   ... acquired at:
   [<ffffffff8024172a>] lock_acquire+0x4a/0x69
   [<ffffffff803eb316>] _spin_lock+0x21/0x2e
   [<ffffffff881cdf02>] mthca_modify_qp+0x76/0xd7b [ib_mthca]
   [<ffffffff881a68fa>] ib_modify_qp+0xc/0xf [ib_core]
   [<ffffffff881b8394>] ib_mad_init_device+0x2db/0x55c [ib_mad]
   [<ffffffff881a83fe>] ib_register_device+0x20d/0x300 [ib_core]
   [<ffffffff881d2f53>] mthca_register_device+0x3e0/0x430 [ib_mthca]
   [<ffffffff881c4f26>] mthca_init_one+0xbc2/0xcbc [ib_mthca]
   [<ffffffff802fcab2>] pci_device_probe+0x4b/0x72
   [<ffffffff803481b7>] driver_probe_device+0x59/0xaf
   [<ffffffff803482d3>] __driver_attach+0x58/0x90
   [<ffffffff80347665>] bus_for_each_dev+0x48/0x7a
   [<ffffffff80348047>] driver_attach+0x1b/0x1e
   [<ffffffff803479d2>] bus_add_driver+0x74/0x112
   [<ffffffff80348705>] driver_register+0x8c/0x91
   [<ffffffff802fc684>] __pci_register_driver+0x60/0x84
   [<ffffffff88022016>] 0xffffffff88022016
   [<ffffffff80247a93>] sys_init_module+0x174c/0x1884
   [<ffffffff802096a1>] system_call+0x7d/0x83

  ... acquired at:
   [<ffffffff8024172a>] lock_acquire+0x4a/0x69
   [<ffffffff803eb7da>] _spin_lock_irqsave+0x2b/0x3c
   [<ffffffff881cff9d>] mthca_arbel_post_send+0x2f/0x5be [ib_mthca]
   [<ffffffff881ee043>] ipoib_send+0x117/0x1d6 [ib_ipoib]
   [<ffffffff881f012d>] ipoib_mcast_send+0x3fb/0x413 [ib_ipoib]
   [<ffffffff881eda0e>] ipoib_start_xmit+0x361/0x66d [ib_ipoib]
   [<ffffffff8038dfc8>] dev_hard_start_xmit+0x1ab/0x221
   [<ffffffff8039a024>] __qdisc_run+0xfa/0x1cd
   [<ffffffff8038e174>] dev_queue_xmit+0x136/0x263
   [<ffffffff80390209>] neigh_connected_output+0xae/0xc7
   [<ffffffff8813f4de>] ip6_output2+0x254/0x28c [ipv6]
   [<ffffffff8813fcf8>] ip6_output+0x7e2/0x7f8 [ipv6]
   [<ffffffff8814dbf7>] ndisc_send_ns+0x38f/0x4c1 [ipv6]
   [<ffffffff88145048>] addrconf_dad_timer+0xfb/0x11e [ipv6]
   [<ffffffff80231a8e>] run_timer_softirq+0x150/0x1dc
   [<ffffffff8022e345>] __do_softirq+0x6b/0xf7
   [<ffffffff8020a94d>] call_softirq+0x1d/0x28
   [<ffffffff8022e0bc>] irq_exit+0x56/0x59
   [<ffffffff802146ee>] smp_apic_timer_interrupt+0x59/0x5f
   [<ffffffff8020a2c1>] apic_timer_interrupt+0x69/0x70

 ... acquired at:
   [<ffffffff8024172a>] lock_acquire+0x4a/0x69
   [<ffffffff803eb316>] _spin_lock+0x21/0x2e
   [<ffffffff881efd5a>] ipoib_mcast_send+0x28/0x413 [ib_ipoib]
   [<ffffffff881eda0e>] ipoib_start_xmit+0x361/0x66d [ib_ipoib]
   [<ffffffff8038dfc8>] dev_hard_start_xmit+0x1ab/0x221
   [<ffffffff8039a024>] __qdisc_run+0xfa/0x1cd
   [<ffffffff8038e174>] dev_queue_xmit+0x136/0x263
   [<ffffffff80390209>] neigh_connected_output+0xae/0xc7
   [<ffffffff8813f4de>] ip6_output2+0x254/0x28c [ipv6]
   [<ffffffff8813fcf8>] ip6_output+0x7e2/0x7f8 [ipv6]
   [<ffffffff8814dbf7>] ndisc_send_ns+0x38f/0x4c1 [ipv6]
   [<ffffffff88145048>] addrconf_dad_timer+0xfb/0x11e [ipv6]
   [<ffffffff80231a8e>] run_timer_softirq+0x150/0x1dc
   [<ffffffff8022e345>] __do_softirq+0x6b/0xf7
   [<ffffffff8020a94d>] call_softirq+0x1d/0x28
   [<ffffffff8022e0bc>] irq_exit+0x56/0x59
   [<ffffffff802146ee>] smp_apic_timer_interrupt+0x59/0x5f
   [<ffffffff8020a2c1>] apic_timer_interrupt+0x69/0x70


the hard-irq-unsafe lock's dependencies:
-> (&skb_queue_lock_key){-+..} ops: 0 {
   initial-use  at:
                        [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                        [<ffffffff803eb7da>] _spin_lock_irqsave+0x2b/0x3c
                        [<ffffffff8038683d>] skb_queue_tail+0x1c/0x47
                        [<ffffffff8039ff72>] netlink_broadcast+0x212/0x2ea
                        [<ffffffff802e57c4>] kobject_uevent+0x3c9/0x43d
                        [<ffffffff8034897f>] store_uevent+0x16/0x1e
                        [<ffffffff803488ef>] class_device_attr_store+0x1b/0x1e
                        [<ffffffff802b0c33>] sysfs_write_file+0xb7/0xe4
                        [<ffffffff8027448e>] vfs_write+0xad/0x154
                        [<ffffffff80274d8b>] sys_write+0x46/0x6f
                        [<ffffffff802096a1>] system_call+0x7d/0x83
   in-softirq-W at:
                        [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                        [<ffffffff803eb7da>] _spin_lock_irqsave+0x2b/0x3c
                        [<ffffffff80386aca>] skb_dequeue+0x18/0x5c
                        [<ffffffff80387015>] skb_queue_purge+0x18/0x26
                        [<ffffffff80394261>] neigh_timer_handler+0x26f/0x346
                        [<ffffffff80231a8e>] run_timer_softirq+0x150/0x1dc
                        [<ffffffff8022e345>] __do_softirq+0x6b/0xf7
                        [<ffffffff8020a94d>] call_softirq+0x1d/0x28
                        [<ffffffff8022e0bc>] irq_exit+0x56/0x59
                        [<ffffffff802146ee>] smp_apic_timer_interrupt+0x59/0x5f
                        [<ffffffff8020a2c1>] apic_timer_interrupt+0x69/0x70
   hardirq-on-W at:
                        [<ffffffff8024172a>] lock_acquire+0x4a/0x69
                        [<ffffffff803eb349>] _spin_lock_bh+0x26/0x33
                        [<ffffffff803c6de8>] udp_ioctl+0x46/0x87
                        [<ffffffff803cd1ab>] inet_ioctl+0x8c/0x8f
                        [<ffffffff8038203c>] sock_ioctl+0x1c0/0x1ea
                        [<ffffffff8028591e>] do_ioctl+0x26/0x74
                        [<ffffffff80285bb6>] vfs_ioctl+0x24a/0x264
                        [<ffffffff80285c11>] sys_ioctl+0x41/0x68
                        [<ffffffff802096a1>] system_call+0x7d/0x83
 }
 ... key      at: [<ffffffff807ccac8>] skb_queue_lock_key+0x0/0x18

stack backtrace:

Call Trace:
 [<ffffffff8020ac99>] show_trace+0xaa/0x238
 [<ffffffff8020b037>] dump_stack+0x13/0x15
 [<ffffffff8023ff9e>] check_usage+0x282/0x293
 [<ffffffff802412b7>] __lock_acquire+0x85c/0xa29
 [<ffffffff8024172b>] lock_acquire+0x4b/0x69
 [<ffffffff803eb7db>] _spin_lock_irqsave+0x2c/0x3c
 [<ffffffff8038683e>] skb_queue_tail+0x1d/0x47
 [<ffffffff881efecc>] :ib_ipoib:ipoib_mcast_send+0x19a/0x413
 [<ffffffff881eda0f>] :ib_ipoib:ipoib_start_xmit+0x362/0x66d
 [<ffffffff8038dfc9>] dev_hard_start_xmit+0x1ac/0x221
 [<ffffffff8039a025>] __qdisc_run+0xfb/0x1cd
 [<ffffffff8038e175>] dev_queue_xmit+0x137/0x263
 [<ffffffff8039020a>] neigh_connected_output+0xaf/0xc7
 [<ffffffff8813f4df>] :ipv6:ip6_output2+0x255/0x28c
 [<ffffffff8813fcf9>] :ipv6:ip6_output+0x7e3/0x7f8
 [<ffffffff8814d737>] :ipv6:ndisc_send_rs+0x33e/0x46f
 [<ffffffff881427ba>] :ipv6:addrconf_dad_completed+0x91/0xe2
 [<ffffffff88144fc2>] :ipv6:addrconf_dad_timer+0x75/0x11e
 [<ffffffff80231a8f>] run_timer_softirq+0x151/0x1dc
 [<ffffffff8022e346>] __do_softirq+0x6c/0xf7
 [<ffffffff8020a94e>] call_softirq+0x1e/0x28
ib0: no IPv6 routers present
