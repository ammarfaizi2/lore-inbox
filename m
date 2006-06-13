Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWFMVfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWFMVfl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWFMVfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:35:41 -0400
Received: from wx-out-0102.google.com ([66.249.82.204]:51184 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932325AbWFMVfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:35:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=k0AlH0bVSsh7ngRyB4dIzhOZaIcHYCOUbZ7d1KMz5MRElD+2VHswxEF84RlxcbAu94heq5aZIteWevYrZ+E5+4RzmQXBcsk5Rf8fKfvviMcN9kuGAc6wxRKNloVPcE9wTgSdTd/5WKjHsdYkSTTJjXrD2vGUXDQrD3E6CX74eK0=
Message-ID: <a44ae5cd0606131435t569bb64bv6d788d89db028856@mail.gmail.com>
Date: Tue, 13 Jun 2006 14:35:38 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
Subject: 2.6.17-rc6-mm2-lockdep -- BUG: hard-safe -> hard-unsafe lock order detected! [ieee80211softmac]
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[   96.198181] ieee80211_crypt: registered algorithm 'WEP'
[   96.229921] bcm43xx: set security called, .active_key = 0, .enabled
= 1, .encrypt = 1
[   96.238469] ======================================================
[   96.238475] [ BUG: hard-safe -> hard-unsafe lock order detected! ]
[   96.238478] ------------------------------------------------------
[   96.238482] events/0/5 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[   96.238486]  (&softmac->lock){-...}, at: [<f8a27298>]
ieee80211softmac_add_network+0x13/0x31 [ieee80211softmac]
[   96.238508]
[   96.238509] and this task is already holding:
[   96.238512]  (&ieee->lock){.+..}, at: [<f8a28a47>]
ieee80211softmac_assoc_work+0x71/0x3cc [ieee80211softmac]
[   96.238524] which would create a new lock dependency:
[   96.238526]  (&ieee->lock){.+..} -> (&softmac->lock){-...}
[   96.238533]
[   96.238534] but this new dependency connects a hard-irq-safe lock:
[   96.238537]  (&bcm->_lock){++..}
[   96.238540] ... which became hard-irq-safe at:
[   96.238542]   [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.238552]   [<c02fa339>] _spin_lock+0x24/0x32
[   96.238561]   [<f8a78792>] bcm43xx_interrupt_handler+0x1b/0x1b2 [bcm43xx]
[   96.238583]   [<c01469cb>] handle_IRQ_event+0x18/0x4d
[   96.238592]   [<c0147a2f>] handle_fasteoi_irq+0x64/0xa2
[   96.238598]   [<c01054ab>] do_IRQ+0x9e/0xc3
[   96.238605]
[   96.238606] to a hard-irq-unsafe lock:
[   96.238609]  (&softmac->lock){-...}
[   96.238611] ... which became hard-irq-unsafe at:
[   96.238614] ...  [<c0136db0>] trace_hardirqs_on+0xc4/0x107
[   96.238621]   [<c01246b8>] __do_softirq+0x5c/0xee
[   96.238627]   [<c01053af>] do_softirq+0x59/0xb7
[   96.238633]
[   96.238634] which could potentially lead to deadlocks!
[   96.238636]
[   96.238637] other info that might help us debug this:
[   96.238639]
[   96.238642] 1 lock held by events/0/5:
[   96.238644]  #0:  (&ieee->lock){.+..}, at: [<f8a28a47>]
ieee80211softmac_assoc_work+0x71/0x3cc [ieee80211softmac]
[   96.238656]
[   96.238657] the hard-irq-safe lock's dependencies:
[   96.238659] -> (&bcm->_lock){++..} ops: 496 {
[   96.238665]    initial-use  at:
[   96.238667]                                        [<c0137bc3>]
lock_acquire+0x4e/0x67
[   96.238693]                                        [<c02fa668>]
_spin_lock_irqsave+0x2d/0x3c
[   96.238721]                                        [<f8a78990>]
bcm43xx_init_board+0x24/0xb08 [bcm43xx]
[   96.238754]                                        [<f8a79509>]
bcm43xx_net_open+0x10/0x12 [bcm43xx]
[   96.238788]                                        [<c029eda6>]
dev_open+0x2f/0x69
[   96.238817]                                        [<c029e5d8>]
dev_change_flags+0x50/0xf4
[   96.238844]                                        [<c02d9767>]
devinet_ioctl+0x229/0x51e
[   96.238871]                                        [<c02d9cab>]
inet_ioctl+0x79/0x99
[   96.238897]                                        [<c02959ce>]
sock_ioctl+0x19f/0x1c7
[   96.238926]                                        [<c0176704>]
do_ioctl+0x24/0x66
[   96.238955]                                        [<c017699c>]
vfs_ioctl+0x256/0x269
[   96.238981]                                        [<c01769f5>]
sys_ioctl+0x46/0x65
[   96.239007]                                        [<c02fac9d>]
sysenter_past_esp+0x56/0x8d
[   96.239034]    in-hardirq-W at:
[   96.239037]                                        [<c0137bc3>]
lock_acquire+0x4e/0x67
[   96.239063]                                        [<c02fa339>]
_spin_lock+0x24/0x32
[   96.239089]                                        [<f8a78792>]
bcm43xx_interrupt_handler+0x1b/0x1b2 [bcm43xx]
[   96.239122]                                        [<c01469cb>]
handle_IRQ_event+0x18/0x4d
[   96.239149]                                        [<c0147a2f>]
handle_fasteoi_irq+0x64/0xa2
[   96.239175]                                        [<c01054ab>]
do_IRQ+0x9e/0xc3
[   96.239201]    in-softirq-W at:
[   96.239204]                                        [<c0137bc3>]
lock_acquire+0x4e/0x67
[   96.239230]                                        [<c02fa668>]
_spin_lock_irqsave+0x2d/0x3c
[   96.239256]                                        [<f8a76c78>]
bcm43xx_periodic_task_handler+0x16/0x2ce [bcm43xx]
[   96.239290]                                        [<c0127dfd>]
run_timer_softirq+0x10d/0x166
[   96.239318]                                        [<c01246c9>]
__do_softirq+0x6d/0xee
[   96.239344]                                        [<c01053af>]
do_softirq+0x59/0xb7
[   96.239370]  }
[   96.239371]  ... key      at: [<f8a9f900>]
__key.25324+0x0/0xfffec98d [bcm43xx]
[   96.239385]   -> (&base->lock){++..} ops: 128845 {
[   96.239391]      initial-use  at:
[   96.239394]                       [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.239411]                       [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.239428]                       [<c0127564>] lock_timer_base+0x18/0x33
[   96.239445]                       [<c0127b2d>] __mod_timer+0x23/0xa2
[   96.239462]                       [<c0127bd9>] mod_timer+0x2d/0x31
[   96.239478]                       [<c04aadab>] con_init+0xb7/0x1e7
[   96.239497]                       [<c04aa65d>] console_init+0x20/0x30
[   96.239514]                       [<c0495582>] start_kernel+0x1b9/0x3c3
[   96.239532]                       [<c0100210>] 0xc0100210
[   96.239553]      in-hardirq-W at:
[   96.239556]                       [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.239573]                       [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.239590]                       [<c0127564>] lock_timer_base+0x18/0x33
[   96.239607]                       [<c0127bf7>] del_timer+0x1a/0x4c
[   96.239623]                       [<c0270450>] ide_intr+0x139/0x1a8
[   96.239642]                       [<c01469cb>] handle_IRQ_event+0x18/0x4d
[   96.239659]                       [<c0147b2e>] handle_edge_irq+0xc1/0x106
[   96.239676]                       [<c01054ab>] do_IRQ+0x9e/0xc3
[   96.239692]      in-softirq-W at:
[   96.239696]                       [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.239712]                       [<c02fa5b9>] _spin_lock_irq+0x2a/0x38
[   96.239729]                       [<c0127d27>] run_timer_softirq+0x37/0x166
[   96.239746]                       [<c01246c9>] __do_softirq+0x6d/0xee
[   96.239763]                       [<c01053af>] do_softirq+0x59/0xb7
[   96.239779]    }
[   96.239781]    ... key      at: [<c0528d20>] base_lock_keys+0x0/0x40
[   96.239792]  ... acquired at:
[   96.239794]    [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.239800]    [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.239806]    [<c0127564>] lock_timer_base+0x18/0x33
[   96.239813]    [<c0127b2d>] __mod_timer+0x23/0xa2
[   96.239819]    [<c0127bd9>] mod_timer+0x2d/0x31
[   96.239825]    [<f8a76f1a>]
bcm43xx_periodic_task_handler+0x2b8/0x2ce [bcm43xx]
[   96.239840]    [<c0127dfd>] run_timer_softirq+0x10d/0x166
[   96.239846]    [<c01246c9>] __do_softirq+0x6d/0xee
[   96.239852]    [<c01053af>] do_softirq+0x59/0xb7
[   96.239859]
[   96.239860]   -> (&parent->list_lock){++..} ops: 36757 {
[   96.239866]      initial-use  at:
[   96.239870]                       [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.239886]                       [<c02fa339>] _spin_lock+0x24/0x32
[   96.239903]                       [<c0162e3a>] cache_alloc_refill+0x72/0x63c
[   96.239923]                       [<c0163554>] kmem_cache_zalloc+0x75/0xce
[   96.239940]                       [<c0164389>] kmem_cache_create+0x21c/0x533
[   96.239957]                       [<c04a3fd7>] kmem_cache_init+0x139/0x303
[   96.239976]                       [<c04955fb>] start_kernel+0x232/0x3c3
[   96.239993]                       [<c0100210>] 0xc0100210
[   96.240010]      in-hardirq-W at:
[   96.240013]                       [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.240030]                       [<c02fa339>] _spin_lock+0x24/0x32
[   96.240047]                       [<c0162212>] free_block+0x106/0x143
[   96.240064]                       [<c016270d>] __cache_free+0x26a/0x2e4
[   96.240081]                       [<c01628a3>] kmem_cache_free+0x56/0x70
[   96.240098]                       [<c014b47f>] mempool_free_slab+0xe/0x12
[   96.240116]                       [<c014b457>] mempool_free+0x63/0x6d
[   96.240134]                       [<c016a846>] bio_free+0x32/0x3c
[   96.240152]                       [<c016a861>] bio_fs_destructor+0x11/0x15
[   96.240169]                       [<c016af75>] bio_put+0x43/0x49
[   96.240186]                       [<c01678f3>] end_bio_bh_io_sync+0x37/0x41
[   96.240203]                       [<c016ab40>] bio_endio+0x4c/0x56
[   96.240219]                       [<c01eed6f>]
__end_that_request_first+0x18e/0x44c
[   96.240239]                       [<c01ef054>]
end_that_request_first+0x14/0x16
[   96.240256]                       [<c026f1e1>] ide_end_request+0x8a/0xda
[   96.240273]                       [<c0275d14>] ide_dma_intr+0x58/0x99
[   96.240291]                       [<c027045d>] ide_intr+0x146/0x1a8
[   96.240307]                       [<c01469cb>] handle_IRQ_event+0x18/0x4d
[   96.240324]                       [<c0147b2e>] handle_edge_irq+0xc1/0x106
[   96.240341]                       [<c01054ab>] do_IRQ+0x9e/0xc3
[   96.240358]      in-softirq-W at:
[   96.240361]                       [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.240378]                       [<c02fa339>] _spin_lock+0x24/0x32
[   96.240394]                       [<c0162212>] free_block+0x106/0x143
[   96.240411]                       [<c016270d>] __cache_free+0x26a/0x2e4
[   96.240428]                       [<c01628a3>] kmem_cache_free+0x56/0x70
[   96.240445]                       [<c0166e25>] file_free_rcu+0x11/0x15
[   96.240462]                       [<c012f46f>]
__rcu_process_callbacks+0xf5/0x157
[   96.240480]                       [<c012f4f9>]
rcu_process_callbacks+0x28/0x40
[   96.240496]                       [<c0124520>] tasklet_action+0x6e/0xd5
[   96.240513]                       [<c01246c9>] __do_softirq+0x6d/0xee
[   96.240529]                       [<c01053af>] do_softirq+0x59/0xb7
[   96.240546]    }
[   96.240548]    ... key      at: [<c066a528>] __key.15711+0x0/0x8
[   96.240557]  ... acquired at:
[   96.240559]    [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.240565]    [<c02fa339>] _spin_lock+0x24/0x32
[   96.240571]    [<c0162e3a>] cache_alloc_refill+0x72/0x63c
[   96.240578]    [<c01634a9>] __kmalloc_track_caller+0xa5/0xdb
[   96.240585]    [<c0299daf>] __alloc_skb+0x4b/0xfa
[   96.240591]    [<f8a8a688>] setup_rx_descbuffer+0x7d/0x155 [bcm43xx]
[   96.240609]    [<f8a8aca6>] bcm43xx_dma_rx+0x2a1/0x460 [bcm43xx]
[   96.240624]    [<f8a78351>] bcm43xx_interrupt_tasklet+0x61e/0x86e [bcm43xx]
[   96.240638]    [<c0124520>] tasklet_action+0x6e/0xd5
[   96.240645]    [<c01246c9>] __do_softirq+0x6d/0xee
[   96.240651]    [<c01053af>] do_softirq+0x59/0xb7
[   96.240657]
[   96.240658]   -> (&ieee->lock){.+..} ops: 133 {
[   96.240664]      initial-use  at:
[   96.240667]                       [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.240684]                       [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.240701]                       [<f8a75ec9>]
bcm43xx_set_iwmode+0x1f/0x127 [bcm43xx]
[   96.240725]                       [<f8a77b4f>]
bcm43xx_chip_init+0x7a4/0x904 [bcm43xx]
[   96.240749]                       [<f8a78d3c>]
bcm43xx_init_board+0x3d0/0xb08 [bcm43xx]
[   96.240773]                       [<f8a79509>]
bcm43xx_net_open+0x10/0x12 [bcm43xx]
[   96.240797]                       [<c029eda6>] dev_open+0x2f/0x69
[   96.240814]                       [<c029e5d8>] dev_change_flags+0x50/0xf4
[   96.240831]                       [<c02d9767>] devinet_ioctl+0x229/0x51e
[   96.240848]                       [<c02d9cab>] inet_ioctl+0x79/0x99
[   96.240865]                       [<c02959ce>] sock_ioctl+0x19f/0x1c7
[   96.240882]                       [<c0176704>] do_ioctl+0x24/0x66
[   96.240899]                       [<c017699c>] vfs_ioctl+0x256/0x269
[   96.240916]                       [<c01769f5>] sys_ioctl+0x46/0x65
[   96.240932]                       [<c02fac9d>] sysenter_past_esp+0x56/0x8d
[   96.240950]      in-softirq-W at:
[   96.240953]                       [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.240969]                       [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.240987]                       [<f8a016fd>]
ieee80211_process_probe_response+0x1f3/0x61e [ieee80211]
[   96.241010]                       [<f8a01d90>]
ieee80211_rx_mgt+0x268/0x2b6 [ieee80211]
[   96.241029]                       [<f8a88454>]
bcm43xx_rx+0x66a/0x6cb [bcm43xx]
[   96.241055]                       [<f8a8ad5f>]
bcm43xx_dma_rx+0x35a/0x460 [bcm43xx]
[   96.241080]                       [<f8a78351>]
bcm43xx_interrupt_tasklet+0x61e/0x86e [bcm43xx]
[   96.241104]                       [<c0124520>] tasklet_action+0x6e/0xd5
[   96.241121]                       [<c01246c9>] __do_softirq+0x6d/0xee
[   96.241137]                       [<c01053af>] do_softirq+0x59/0xb7
[   96.241154]    }
[   96.241156]    ... key      at: [<f8a06981>]
__key.25640+0x0/0xffffcd2e [ieee80211]
[   96.241166]  ... acquired at:
[   96.241168]    [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.241174]    [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.241181]    [<f8a016fd>]
ieee80211_process_probe_response+0x1f3/0x61e [ieee80211]
[   96.241190]    [<f8a01d90>] ieee80211_rx_mgt+0x268/0x2b6 [ieee80211]
[   96.241199]    [<f8a88454>] bcm43xx_rx+0x66a/0x6cb [bcm43xx]
[   96.241214]    [<f8a8ad5f>] bcm43xx_dma_rx+0x35a/0x460 [bcm43xx]
[   96.241228]    [<f8a78351>] bcm43xx_interrupt_tasklet+0x61e/0x86e [bcm43xx]
[   96.241242]    [<c0124520>] tasklet_action+0x6e/0xd5
[   96.241248]    [<c01246c9>] __do_softirq+0x6d/0xee
[   96.241254]    [<c01053af>] do_softirq+0x59/0xb7
[   96.241261]
[   96.241262]
[   96.241263] the hard-irq-unsafe lock's dependencies:
[   96.241266] -> (&softmac->lock){-...} ops: 180 {
[   96.241271]    initial-use  at:
[   96.241273]                                        [<c0137bc3>]
lock_acquire+0x4e/0x67
[   96.241299]                                        [<c02fa668>]
_spin_lock_irqsave+0x2d/0x3c
[   96.241326]                                        [<f8a28be3>]
ieee80211softmac_assoc_work+0x20d/0x3cc [ieee80211softmac]
[   96.241355]                                        [<c012e6d8>]
run_workqueue+0x84/0xcc
[   96.241381]                                        [<c012e8c0>]
worker_thread+0xd5/0x107
[   96.241407]                                        [<c01315f5>]
kthread+0xa6/0xd4
[   96.241434]                                        [<c0101005>]
kernel_thread_helper+0x5/0xb
[   96.241460]    hardirq-on-W at:
[   96.241463]                                        [<c0136db0>]
trace_hardirqs_on+0xc4/0x107
[   96.241489]                                        [<c01246b8>]
__do_softirq+0x5c/0xee
[   96.241515]                                        [<c01053af>]
do_softirq+0x59/0xb7
[   96.241541]  }
[   96.241542]  ... key      at: [<f8a2cc80>]
__key.20156+0x0/0xffffc3ed [ieee80211softmac]
[   96.241552]   -> (&cwq->lock){++..} ops: 6537 {
[   96.241557]      initial-use  at:
[   96.241561]                       [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.241578]                       [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.241595]                       [<c012e29b>] __queue_work+0xf/0x51
[   96.241611]                       [<c012e9d1>] queue_work+0x58/0x7c
[   96.241627]                       [<c012e059>]
call_usermodehelper_keys+0xd1/0xe3
[   96.241644]                       [<c01f9084>] kobject_uevent+0x37e/0x3ae
[   96.241663]                       [<c01f8b11>] kobject_register+0x2d/0x38
[   96.241680]                       [<c02646c7>] sysdev_register+0x46/0xbb
[   96.241697]                       [<c0267173>] register_cpu+0x25/0x53
[   96.241715]                       [<c0108598>] arch_register_cpu+0x2c/0x2e
[   96.241733]                       [<c0499939>] topology_init+0x19/0x35
[   96.241751]                       [<c01003ed>] init+0x119/0x274
[   96.241767]                       [<c0101005>] kernel_thread_helper+0x5/0xb
[   96.241784]      in-hardirq-W at:
[   96.241787]                       [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.241803]                       [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.241821]                       [<c012e29b>] __queue_work+0xf/0x51
[   96.241837]                       [<c012e9d1>] queue_work+0x58/0x7c
[   96.241853]                       [<c012ea04>] schedule_work+0xf/0x11
[   96.241870]                       [<f89d0110>] schedule_bh+0x1c/0x1e [floppy]
[   96.241895]                       [<f89d1e61>]
floppy_interrupt+0x15b/0x172 [floppy]
[   96.241916]                       [<f89d1e98>]
floppy_hardint+0x20/0xe1 [floppy]
[   96.241936]                       [<c01469cb>] handle_IRQ_event+0x18/0x4d
[   96.241953]                       [<c0147b2e>] handle_edge_irq+0xc1/0x106
[   96.241970]                       [<c01054ab>] do_IRQ+0x9e/0xc3
[   96.241987]      in-softirq-W at:
[   96.241990]                       [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.242007]                       [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.242024]                       [<c012e29b>] __queue_work+0xf/0x51
[   96.242040]                       [<c012ee02>]
delayed_work_timer_fn+0x2b/0x31
[   96.242057]                       [<c0127dfd>] run_timer_softirq+0x10d/0x166
[   96.242074]                       [<c01246c9>] __do_softirq+0x6d/0xee
[   96.242091]                       [<c01053af>] do_softirq+0x59/0xb7
[   96.242107]    }
[   96.242110]    ... key      at: [<c0529598>] __key.10146+0x0/0x8
[   96.242117]     -> (&q->lock){++..} ops: 355994 {
[   96.242123]        initial-use  at:
[   96.242127]                        [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.242144]                        [<c02fa5b9>] _spin_lock_irq+0x2a/0x38
[   96.242162]                        [<c02f8609>] wait_for_completion+0x24/0xd1
[   96.242179]                        [<c013136a>]
keventd_create_kthread+0x2e/0x5e
[   96.242197]                        [<c0131410>] kthread_create+0x76/0xbd
[   96.242214]                        [<c011a7eb>] migration_call+0x4d/0x3f7
[   96.242234]                        [<c04a126a>] migration_init+0x18/0x36
[   96.242251]                        [<c010030c>] init+0x38/0x274
[   96.242268]                        [<c0101005>] kernel_thread_helper+0x5/0xb
[   96.242285]        in-hardirq-W at:
[   96.242289]                        [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.242306]                        [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.242324]                        [<c0117ec5>] complete+0x12/0x3e
[   96.242341]                        [<c01ee3d0>] blk_end_sync_rq+0x21/0x28
[   96.242358]                        [<c01ee395>]
end_that_request_last+0xc5/0xdf
[   96.242376]                        [<c026f717>] ide_end_drive_cmd+0x2d4/0x2eb
[   96.242393]                        [<c027445e>] task_no_data_intr+0x62/0x6f
[   96.242411]                        [<c027045d>] ide_intr+0x146/0x1a8
[   96.242428]                        [<c01469cb>] handle_IRQ_event+0x18/0x4d
[   96.242446]                        [<c0147b2e>] handle_edge_irq+0xc1/0x106
[   96.242463]                        [<c01054ab>] do_IRQ+0x9e/0xc3
[   96.242480]        in-softirq-W at:
[   96.242484]                        [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.242501]                        [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.242519]                        [<c0117ec5>] complete+0x12/0x3e
[   96.242536]                        [<c012f573>] wakeme_after_rcu+0xe/0x10
[   96.242553]                        [<c012f46f>]
__rcu_process_callbacks+0xf5/0x157
[   96.242571]                        [<c012f4f9>]
rcu_process_callbacks+0x28/0x40
[   96.242588]                        [<c0124520>] tasklet_action+0x6e/0xd5
[   96.242605]                        [<c01246c9>] __do_softirq+0x6d/0xee
[   96.242622]                        [<c01053af>] do_softirq+0x59/0xb7
[   96.242639]      }
[   96.242642]      ... key      at: [<c0529934>] waitqueue_lock_key+0x0/0x8
[   96.242649]       -> (&rq->lock){++..} ops: 229774 {
[   96.242656]          initial-use  at:
[   96.242660]                         [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.242678]                         [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.242696]                         [<c0118d42>] init_idle+0x5e/0x7c
[   96.242714]                         [<c04a1248>] sched_init+0x140/0x14a
[   96.242732]                         [<c04954f3>] start_kernel+0x12a/0x3c3
[   96.242750]                         [<c0100210>] 0xc0100210
[   96.242768]          in-hardirq-W at:
[   96.242772]                         [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.242790]                         [<c02fa339>] _spin_lock+0x24/0x32
[   96.242808]                         [<c011b196>] scheduler_tick+0xa5/0x340
[   96.242826]                         [<c01279c7>]
update_process_times+0x57/0x66
[   96.242844]                         [<c0111cff>]
smp_local_timer_interrupt+0x2b/0x33
[   96.242864]                         [<c0106043>] timer_interrupt+0x53/0x7e
[   96.242882]                         [<c01469cb>] handle_IRQ_event+0x18/0x4d
[   96.242900]                         [<c0147cd9>] handle_level_irq+0x81/0xcc
[   96.242919]                         [<c01054ab>] do_IRQ+0x9e/0xc3
[   96.242936]          in-softirq-W at:
[   96.242941]                         [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.242958]                         [<c02fa339>] _spin_lock+0x24/0x32
[   96.242976]                         [<c011b1e4>] scheduler_tick+0xf3/0x340
[   96.242994]                         [<c01279c7>]
update_process_times+0x57/0x66
[   96.243012]                         [<c011241f>]
smp_apic_timer_interrupt+0x61/0x6e
[   96.243031]                         [<c01036ea>]
apic_timer_interrupt+0x2a/0x30
[   96.243049]                         [<c0127e4e>]
run_timer_softirq+0x15e/0x166
[   96.243067]                         [<c01246c9>] __do_softirq+0x6d/0xee
[   96.243084]                         [<c01053af>] do_softirq+0x59/0xb7
[   96.243102]        }
[   96.243106]        ... key      at: [<c2fa5b20>] 0xc2fa5b20
[   96.243113]      ... acquired at:
[   96.243116]    [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.243122]    [<c02fa339>] _spin_lock+0x24/0x32
[   96.243128]    [<c011a44d>] try_to_wake_up+0x37/0x355
[   96.243135]    [<c011a77f>] default_wake_function+0x14/0x16
[   96.243141]    [<c0117dfe>] __wake_up_common+0x2a/0x4f
[   96.243148]    [<c0117ede>] complete+0x2b/0x3e
[   96.243154]    [<c01315dd>] kthread+0x8e/0xd4
[   96.243160]    [<c0101005>] kernel_thread_helper+0x5/0xb
[   96.243166]
[   96.243168]    ... acquired at:
[   96.243170]    [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.243176]    [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.243183]    [<c0117e36>] __wake_up+0x13/0x39
[   96.243189]    [<c012e2cb>] __queue_work+0x3f/0x51
[   96.243195]    [<c012e9d1>] queue_work+0x58/0x7c
[   96.243201]    [<c012e059>] call_usermodehelper_keys+0xd1/0xe3
[   96.243207]    [<c01f9084>] kobject_uevent+0x37e/0x3ae
[   96.243214]    [<c01f8b11>] kobject_register+0x2d/0x38
[   96.243220]    [<c02646c7>] sysdev_register+0x46/0xbb
[   96.243226]    [<c0267173>] register_cpu+0x25/0x53
[   96.243233]    [<c0108598>] arch_register_cpu+0x2c/0x2e
[   96.243239]    [<c0499939>] topology_init+0x19/0x35
[   96.243246]    [<c01003ed>] init+0x119/0x274
[   96.243252]    [<c0101005>] kernel_thread_helper+0x5/0xb
[   96.243258]
[   96.243259]  ... acquired at:
[   96.243261]    [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.243267]    [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.243274]    [<c012e29b>] __queue_work+0xf/0x51
[   96.243280]    [<c012e9d1>] queue_work+0x58/0x7c
[   96.243286]    [<c012ea04>] schedule_work+0xf/0x11
[   96.243292]    [<f8a27db1>]
ieee80211softmac_start_scan_implementation+0xfe/0x119
[ieee80211softmac]
[   96.243303]    [<f8a27a2c>] ieee80211softmac_start_scan+0x74/0x9b
[ieee80211softmac]
[   96.243313]    [<f8a28c16>] ieee80211softmac_assoc_work+0x240/0x3cc
[ieee80211softmac]
[   96.243322]    [<c012e6d8>] run_workqueue+0x84/0xcc
[   96.243328]    [<c012e8c0>] worker_thread+0xd5/0x107
[   96.243335]    [<c01315f5>] kthread+0xa6/0xd4
[   96.243341]    [<c0101005>] kernel_thread_helper+0x5/0xb
[   96.243347]
[   96.243348]   -> (&base->lock){++..} ops: 128845 {
[   96.243354]      initial-use  at:
[   96.243357]                       [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.243374]                       [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.243391]                       [<c0127564>] lock_timer_base+0x18/0x33
[   96.243408]                       [<c0127b2d>] __mod_timer+0x23/0xa2
[   96.243424]                       [<c0127bd9>] mod_timer+0x2d/0x31
[   96.243441]                       [<c04aadab>] con_init+0xb7/0x1e7
[   96.243458]                       [<c04aa65d>] console_init+0x20/0x30
[   96.243474]                       [<c0495582>] start_kernel+0x1b9/0x3c3
[   96.243491]                       [<c0100210>] 0xc0100210
[   96.243508]      in-hardirq-W at:
[   96.243511]                       [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.243528]                       [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.243545]                       [<c0127564>] lock_timer_base+0x18/0x33
[   96.243561]                       [<c0127bf7>] del_timer+0x1a/0x4c
[   96.243578]                       [<c0270450>] ide_intr+0x139/0x1a8
[   96.243595]                       [<c01469cb>] handle_IRQ_event+0x18/0x4d
[   96.243612]                       [<c0147b2e>] handle_edge_irq+0xc1/0x106
[   96.243629]                       [<c01054ab>] do_IRQ+0x9e/0xc3
[   96.243645]      in-softirq-W at:
[   96.243648]                       [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.243665]                       [<c02fa5b9>] _spin_lock_irq+0x2a/0x38
[   96.243682]                       [<c0127d27>] run_timer_softirq+0x37/0x166
[   96.243699]                       [<c01246c9>] __do_softirq+0x6d/0xee
[   96.243715]                       [<c01053af>] do_softirq+0x59/0xb7
[   96.243732]    }
[   96.243734]    ... key      at: [<c0528d20>] base_lock_keys+0x0/0x40
[   96.243741]  ... acquired at:
[   96.243743]    [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.243749]    [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.243756]    [<c0127564>] lock_timer_base+0x18/0x33
[   96.243762]    [<c0127b2d>] __mod_timer+0x23/0xa2
[   96.243768]    [<c012e95a>] queue_delayed_work+0x68/0x74
[   96.243775]    [<c012e977>] schedule_delayed_work+0x11/0x13
[   96.243781]    [<f8a27c48>] ieee80211softmac_scan+0xb2/0x11d
[ieee80211softmac]
[   96.243791]    [<c012e6d8>] run_workqueue+0x84/0xcc
[   96.243797]    [<c012e8c0>] worker_thread+0xd5/0x107
[   96.243803]    [<c01315f5>] kthread+0xa6/0xd4
[   96.243809]    [<c0101005>] kernel_thread_helper+0x5/0xb
[   96.243815]
[   96.243817]   -> (nl_table_wait.lock){....} ops: 1189 {
[   96.243823]      initial-use  at:
[   96.243826]                       [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.243843]                       [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.243860]                       [<c0117e36>] __wake_up+0x13/0x39
[   96.243876]                       [<c02b0714>] netlink_insert+0xfe/0x108
[   96.243895]                       [<c02b0897>]
netlink_kernel_create+0x9e/0x110
[   96.243912]                       [<c04afa3b>] rtnetlink_init+0x62/0xa4
[   96.243930]                       [<c04afe84>] netlink_proto_init+0x13b/0x145
[   96.243948]                       [<c01003ed>] init+0x119/0x274
[   96.243964]                       [<c0101005>] kernel_thread_helper+0x5/0xb
[   96.243980]    }
[   96.243982]    ... key      at: [<c0380c74>] nl_table_wait+0x14/0x60
[   96.243992]  ... acquired at:
[   96.243994]    [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.244000]    [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.244007]    [<c0117e36>] __wake_up+0x13/0x39
[   96.244013]    [<c02b004b>] netlink_broadcast+0x278/0x2b8
[   96.244019]    [<c02a8e10>] wireless_send_event+0x296/0x2aa
[   96.244028]    [<f8a28fa5>]
ieee80211softmac_call_events_locked+0x8c/0x10a [ieee80211softmac]
[   96.244039]    [<f8a29044>] ieee80211softmac_call_events+0x21/0x4a
[ieee80211softmac]
[   96.244048]    [<f8a27b8c>]
ieee80211softmac_scan_finished+0x69/0x73 [ieee80211softmac]
[   96.244058]    [<f8a27c9c>] ieee80211softmac_scan+0x106/0x11d
[ieee80211softmac]
[   96.244068]    [<c012e6d8>] run_workqueue+0x84/0xcc
[   96.244074]    [<c012e8c0>] worker_thread+0xd5/0x107
[   96.244080]    [<c01315f5>] kthread+0xa6/0xd4
[   96.244086]    [<c0101005>] kernel_thread_helper+0x5/0xb
[   96.244092]
[   96.244094]   -> (&list->lock){-...} ops: 2541 {
[   96.244099]      initial-use  at:
[   96.244103]                       [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.244119]                       [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.244137]                       [<c0299985>] skb_queue_tail+0x16/0x34
[   96.244153]                       [<c02aff88>] netlink_broadcast+0x1b5/0x2b8
[   96.244170]                       [<c01f904f>] kobject_uevent+0x349/0x3ae
[   96.244187]                       [<c01f0b51>] disk_uevent_store+0x13/0x18
[   96.244205]                       [<c01f0b39>] disk_attr_store+0x21/0x26
[   96.244222]                       [<c019cfa2>] sysfs_write_file+0xa6/0xce
[   96.244240]                       [<c0166502>] vfs_write+0xa7/0x149
[   96.244257]                       [<c0166d59>] sys_write+0x3a/0x61
[   96.244273]                       [<c02fac9d>] sysenter_past_esp+0x56/0x8d
[   96.244290]      hardirq-on-W at:
[   96.244294]                       [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.244310]                       [<c02fa370>] _spin_lock_bh+0x29/0x37
[   96.244327]                       [<f8a6dbc9>]
packet_poll+0x27/0x76 [af_packet]
[   96.244349]                       [<c0295a0d>] sock_poll+0x17/0x19
[   96.244366]                       [<c0177282>] do_select+0x2f0/0x4bb
[   96.244383]                       [<c017764d>] core_sys_select+0x200/0x2e6
[   96.244400]                       [<c01779f6>] sys_select+0x8f/0x149
[   96.244417]                       [<c02fac9d>] sysenter_past_esp+0x56/0x8d
[   96.244435]    }
[   96.244437]    ... key      at: [<c0691868>] __key.27562+0x0/0x18
[   96.244446]  ... acquired at:
[   96.244448]    [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.244454]    [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.244461]    [<c0299985>] skb_queue_tail+0x16/0x34
[   96.244467]    [<c02aff88>] netlink_broadcast+0x1b5/0x2b8
[   96.244474]    [<c02a8e10>] wireless_send_event+0x296/0x2aa
[   96.244481]    [<f8a28fa5>]
ieee80211softmac_call_events_locked+0x8c/0x10a [ieee80211softmac]
[   96.244491]    [<f8a29044>] ieee80211softmac_call_events+0x21/0x4a
[ieee80211softmac]
[   96.244501]    [<f8a27b8c>]
ieee80211softmac_scan_finished+0x69/0x73 [ieee80211softmac]
[   96.244510]    [<f8a27c9c>] ieee80211softmac_scan+0x106/0x11d
[ieee80211softmac]
[   96.244520]    [<c012e6d8>] run_workqueue+0x84/0xcc
[   96.244526]    [<c012e8c0>] worker_thread+0xd5/0x107
[   96.244532]    [<c01315f5>] kthread+0xa6/0xd4
[   96.244539]    [<c0101005>] kernel_thread_helper+0x5/0xb
[   96.244545]
[   96.244546]   -> (&q->lock){++..} ops: 355994 {
[   96.244552]      initial-use  at:
[   96.244555]                       [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.244572]                       [<c02fa5b9>] _spin_lock_irq+0x2a/0x38
[   96.244589]                       [<c02f8609>] wait_for_completion+0x24/0xd1
[   96.244605]                       [<c013136a>]
keventd_create_kthread+0x2e/0x5e
[   96.244623]                       [<c0131410>] kthread_create+0x76/0xbd
[   96.244639]                       [<c011a7eb>] migration_call+0x4d/0x3f7
[   96.244656]                       [<c04a126a>] migration_init+0x18/0x36
[   96.244673]                       [<c010030c>] init+0x38/0x274
[   96.244689]                       [<c0101005>] kernel_thread_helper+0x5/0xb
[   96.244705]      in-hardirq-W at:
[   96.244709]                       [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.244725]                       [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.244742]                       [<c0117ec5>] complete+0x12/0x3e
[   96.244759]                       [<c01ee3d0>] blk_end_sync_rq+0x21/0x28
[   96.244775]                       [<c01ee395>]
end_that_request_last+0xc5/0xdf
[   96.244792]                       [<c026f717>] ide_end_drive_cmd+0x2d4/0x2eb
[   96.244809]                       [<c027445e>] task_no_data_intr+0x62/0x6f
[   96.244826]                       [<c027045d>] ide_intr+0x146/0x1a8
[   96.244843]                       [<c01469cb>] handle_IRQ_event+0x18/0x4d
[   96.244860]                       [<c0147b2e>] handle_edge_irq+0xc1/0x106
[   96.244877]                       [<c01054ab>] do_IRQ+0x9e/0xc3
[   96.244893]      in-softirq-W at:
[   96.244896]                       [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.244913]                       [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.244930]                       [<c0117ec5>] complete+0x12/0x3e
[   96.244947]                       [<c012f573>] wakeme_after_rcu+0xe/0x10
[   96.244963]                       [<c012f46f>]
__rcu_process_callbacks+0xf5/0x157
[   96.244980]                       [<c012f4f9>]
rcu_process_callbacks+0x28/0x40
[   96.244997]                       [<c0124520>] tasklet_action+0x6e/0xd5
[   96.245013]                       [<c01246c9>] __do_softirq+0x6d/0xee
[   96.245030]                       [<c01053af>] do_softirq+0x59/0xb7
[   96.245046]    }
[   96.245049]    ... key      at: [<c0529934>] waitqueue_lock_key+0x0/0x8
[   96.245055]     -> (&rq->lock){++..} ops: 229774 {
[   96.245061]        initial-use  at:
[   96.245065]                        [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.245082]                        [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.245100]                        [<c0118d42>] init_idle+0x5e/0x7c
[   96.245117]                        [<c04a1248>] sched_init+0x140/0x14a
[   96.245134]                        [<c04954f3>] start_kernel+0x12a/0x3c3
[   96.245151]                        [<c0100210>] 0xc0100210
[   96.245169]        in-hardirq-W at:
[   96.245172]                        [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.245190]                        [<c02fa339>] _spin_lock+0x24/0x32
[   96.245207]                        [<c011b196>] scheduler_tick+0xa5/0x340
[   96.245225]                        [<c01279c7>]
update_process_times+0x57/0x66
[   96.245242]                        [<c0111cff>]
smp_local_timer_interrupt+0x2b/0x33
[   96.245260]                        [<c0106043>] timer_interrupt+0x53/0x7e
[   96.245277]                        [<c01469cb>] handle_IRQ_event+0x18/0x4d
[   96.245295]                        [<c0147cd9>] handle_level_irq+0x81/0xcc
[   96.245312]                        [<c01054ab>] do_IRQ+0x9e/0xc3
[   96.245330]        in-softirq-W at:
[   96.245333]                        [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.245350]                        [<c02fa339>] _spin_lock+0x24/0x32
[   96.245368]                        [<c011b1e4>] scheduler_tick+0xf3/0x340
[   96.245385]                        [<c01279c7>]
update_process_times+0x57/0x66
[   96.245403]                        [<c011241f>]
smp_apic_timer_interrupt+0x61/0x6e
[   96.245421]                        [<c01036ea>]
apic_timer_interrupt+0x2a/0x30
[   96.245438]                        [<c0127e4e>] run_timer_softirq+0x15e/0x166
[   96.245455]                        [<c01246c9>] __do_softirq+0x6d/0xee
[   96.245472]                        [<c01053af>] do_softirq+0x59/0xb7
[   96.245490]      }
[   96.245492]      ... key      at: [<c2fa5b20>] 0xc2fa5b20
[   96.245499]    ... acquired at:
[   96.245501]    [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.245508]    [<c02fa339>] _spin_lock+0x24/0x32
[   96.245514]    [<c011a44d>] try_to_wake_up+0x37/0x355
[   96.245521]    [<c011a77f>] default_wake_function+0x14/0x16
[   96.245527]    [<c0117dfe>] __wake_up_common+0x2a/0x4f
[   96.245533]    [<c0117ede>] complete+0x2b/0x3e
[   96.245539]    [<c01315dd>] kthread+0x8e/0xd4
[   96.245545]    [<c0101005>] kernel_thread_helper+0x5/0xb
[   96.245552]
[   96.245553]  ... acquired at:
[   96.245555]    [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.245561]    [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.245568]    [<c0117e36>] __wake_up+0x13/0x39
[   96.245574]    [<c0298e32>] sock_def_readable+0x3b/0x6b
[   96.245580]    [<c02aff92>] netlink_broadcast+0x1bf/0x2b8
[   96.245587]    [<c02a8e10>] wireless_send_event+0x296/0x2aa
[   96.245594]    [<f8a28fa5>]
ieee80211softmac_call_events_locked+0x8c/0x10a [ieee80211softmac]
[   96.245604]    [<f8a29044>] ieee80211softmac_call_events+0x21/0x4a
[ieee80211softmac]
[   96.245613]    [<f8a27b8c>]
ieee80211softmac_scan_finished+0x69/0x73 [ieee80211softmac]
[   96.245623]    [<f8a27c9c>] ieee80211softmac_scan+0x106/0x11d
[ieee80211softmac]
[   96.245633]    [<c012e6d8>] run_workqueue+0x84/0xcc
[   96.245639]    [<c012e8c0>] worker_thread+0xd5/0x107
[   96.245645]    [<c01315f5>] kthread+0xa6/0xd4
[   96.245651]    [<c0101005>] kernel_thread_helper+0x5/0xb
[   96.245657]
[   96.245659]
[   96.245660] stack backtrace:
[   96.245843]  [<c0103dc4>] show_trace_log_lvl+0x53/0xff
[   96.245862]  [<c0104f70>] show_trace+0x16/0x19
[   96.245880]  [<c0104f8b>] dump_stack+0x18/0x1d
[   96.245898]  [<c01362d0>] check_usage+0x1f3/0x1fd
[   96.246020]  [<c01376f6>] __lock_acquire+0x7f1/0x987
[   96.246144]  [<c0137bc3>] lock_acquire+0x4e/0x67
[   96.246265]  [<c02fa668>] _spin_lock_irqsave+0x2d/0x3c
[   96.246394]  [<f8a27298>] ieee80211softmac_add_network+0x13/0x31
[ieee80211softmac]
[   96.246410]  [<f8a28bae>] ieee80211softmac_assoc_work+0x1d8/0x3cc
[ieee80211softmac]
[   96.246426]  [<c012e6d8>] run_workqueue+0x84/0xcc
[   96.246528]  [<c012e8c0>] worker_thread+0xd5/0x107
[   96.246626]  [<c01315f5>] kthread+0xa6/0xd4
[   96.246732]  [<c0101005>] kernel_thread_helper+0x5/0xb
[   96.257787] SoftMAC: Open Authentication completed with 00:06:25:54:a2:0c
