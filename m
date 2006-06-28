Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWF1TQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWF1TQD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWF1TQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:16:03 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:37389 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751022AbWF1TQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:16:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nFqL6kbzjyVvcH5WN02F0VGrNVlGG+unQvNQEqacSvKnQOg0T5N4S32SRExZfNcugWqVCDdAEjlIyaa7ou6CwW9m5r600mk3BVuxVZRKjf5rrDFzCSAauwmM0t4sVQuW5X7j3InUSoZhqgDHZWLwWLY2kUHF9FCTObklvSWbsv4=
Message-ID: <a44ae5cd0606281215o7d76af23v84bae1b56aaa24eb@mail.gmail.com>
Date: Wed, 28 Jun 2006 12:15:59 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.17-mm3 -- possible irq lock inversion dependency detected
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ INFO: possible irq lock inversion dependency detected ]
---------------------------------------------------------
swapper/0 just changed the state of lock:
 (tasklist_lock){..-?}, at: [<c10201a8>] send_group_sig_info+0x16/0x34
but this lock took another, soft-irq-unsafe lock in the past:
 (&sig->stats_lock){--..}

and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
no locks held by swapper/0.

the first lock's dependencies:
-> (tasklist_lock){..-?} ops: 11783 {
   initial-use  at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fcb9e>] _write_lock_irq+0x29/0x38
                        [<c1014b51>] copy_process+0xedf/0x138a
                        [<c1015233>] do_fork+0x93/0x19a
                        [<c100136c>] kernel_thread+0x6c/0x74
                        [<c1000412>] rest_init+0x14/0x3a
                        [<c135b6b2>] start_kernel+0x2d1/0x2d3
                        [<c1000199>] 0xc1000199
   in-softirq-R at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fcc43>] _read_lock+0x23/0x32
                        [<c10201a8>] send_group_sig_info+0x16/0x34
                        [<c10197e4>] it_real_fn+0x22/0x6b
                        [<c1029370>] hrtimer_run_queues+0xdd/0x12e
                        [<c101d7fc>] run_timer_softirq+0x14/0x14a
                        [<c101a4aa>] __do_softirq+0x55/0xb0
                        [<c1004a64>] do_softirq+0x58/0xbd
   softirq-on-R at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fcc43>] _read_lock+0x23/0x32
                        [<c1026aaf>] keventd_create_kthread+0x35/0x57
                        [<c1026bac>] kthread_create+0xdb/0x126
                        [<c101a0d7>] cpu_callback+0x49/0x8e
                        [<c13643c3>] spawn_ksoftirqd+0x1c/0x32
                        [<c1000241>] init+0x21/0x1de
                        [<c1001005>] kernel_thread_helper+0x5/0xb
   hardirq-on-R at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fcc43>] _read_lock+0x23/0x32
                        [<c1026aaf>] keventd_create_kthread+0x35/0x57
                        [<c1026bac>] kthread_create+0xdb/0x126
                        [<c101a0d7>] cpu_callback+0x49/0x8e
                        [<c13643c3>] spawn_ksoftirqd+0x1c/0x32
                        [<c1000241>] init+0x21/0x1de
                        [<c1001005>] kernel_thread_helper+0x5/0xb
 }
 ... key      at: [<c12e9a34>] tasklist_lock+0x34/0x80
  -> (init_sighand.siglock){....} ops: 27 {
     initial-use  at:
                      [<c102cbca>] lock_acquire+0x60/0x80
                      [<c11fcac6>] _spin_lock+0x23/0x32
                      [<c1014bd0>] copy_process+0xf5e/0x138a
                      [<c1015233>] do_fork+0x93/0x19a
                      [<c100136c>] kernel_thread+0x6c/0x74
                      [<c1000412>] rest_init+0x14/0x3a
                      [<c135b6b2>] start_kernel+0x2d1/0x2d3
                      [<c1000199>] 0xc1000199
   }
   ... key      at: [<c125f33c>] init_sighand+0x53c/0x580
    -> (&sighand->siglock){....} ops: 57856 {
       initial-use  at:
                       [<c102cbca>] lock_acquire+0x60/0x80
                       [<c11fcc7b>] _spin_lock_irq+0x29/0x38
                       [<c101e9e7>] sigprocmask+0x25/0xd0
                       [<c1026c61>] kthread+0x6a/0xdc
                       [<c1001005>] kernel_thread_helper+0x5/0xb
     }
     ... key      at: [<c139aa84>] __key.22974+0x0/0x8
      -> (&waitqueue_lock_key){++..} ops: 105911 {
         initial-use  at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fcc7b>] _spin_lock_irq+0x29/0x38
                        [<c11faa0a>] wait_for_completion+0x24/0xd0
                        [<c1026aa5>] keventd_create_kthread+0x2b/0x57
                        [<c1026bac>] kthread_create+0xdb/0x126
                        [<c101a0d7>] cpu_callback+0x49/0x8e
                        [<c13643c3>] spawn_ksoftirqd+0x1c/0x32
                        [<c1000241>] init+0x21/0x1de
                        [<c1001005>] kernel_thread_helper+0x5/0xb
         in-hardirq-W at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fccee>] _spin_lock_irqsave+0x2c/0x3c
                        [<c1011d5e>] __wake_up+0x15/0x3b
                        [<c1139fbb>] acpi_ec_gpe_handler+0x81/0xc6
                        [<c112726e>] acpi_ev_gpe_dispatch+0x58/0x122
                        [<c1127583>] acpi_ev_gpe_detect+0xb7/0x10e
                        [<c1125d77>] acpi_ev_sci_xrupt_handler+0x15/0x1d
                        [<c11210a9>] acpi_irq+0xe/0x18
                        [<c103eb6b>] handle_IRQ_event+0x20/0x50
                        [<c103ec10>] __do_IRQ+0x75/0xc9
                        [<c1004b64>] do_IRQ+0x9b/0xaf
                        [<c1002fd9>] common_interrupt+0x25/0x2c
                        [<c1001cda>] cpu_idle+0x41/0x6a
                        [<c1000435>] rest_init+0x37/0x3a
                        [<c135b6b2>] start_kernel+0x2d1/0x2d3
                        [<c1000199>] 0xc1000199
         in-softirq-W at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fccee>] _spin_lock_irqsave+0x2c/0x3c
                        [<c1011cd9>] complete+0x12/0x3e
                        [<c1024cce>] wakeme_after_rcu+0xb/0xd
                        [<c1024f1f>] __rcu_process_callbacks+0xfe/0x154
                        [<c1024f87>] rcu_process_callbacks+0x12/0x23
                        [<c101a2d3>] tasklet_action+0x45/0x76
                        [<c101a4aa>] __do_softirq+0x55/0xb0
                        [<c1004a64>] do_softirq+0x58/0xbd
       }
       ... key      at: [<c13bd4b4>] waitqueue_lock_key+0x0/0x8
        -> (&rq->rq_lock_key){++..} ops: 64390 {
           initial-use  at:
                         [<c102cbca>] lock_acquire+0x60/0x80
                         [<c11fccee>] _spin_lock_irqsave+0x2c/0x3c
                         [<c1011f27>] init_idle+0x4c/0x72
                         [<c1363e6b>] sched_init+0xbb/0xbf
                         [<c135b441>] start_kernel+0x60/0x2d3
                         [<c1000199>] 0xc1000199
           in-hardirq-W at:
                         [<c102cbca>] lock_acquire+0x60/0x80
                         [<c11fcac6>] _spin_lock+0x23/0x32
                         [<c1011ff0>] scheduler_tick+0xa3/0x2ac
                         [<c101e44a>] update_process_times+0x59/0x65
                         [<c1005ae3>] timer_interrupt+0x38/0x5d
                         [<c103eb6b>] handle_IRQ_event+0x20/0x50
                         [<c103ec10>] __do_IRQ+0x75/0xc9
                         [<c1004b64>] do_IRQ+0x9b/0xaf
                         [<c1002fd9>] common_interrupt+0x25/0x2c
                         [<c105b6f5>] cache_alloc_debugcheck_after+0x25/0x135
                         [<c105ca8b>] kmem_cache_alloc+0x97/0xa3
                         [<c107631c>] alloc_inode+0x26/0x18c
                         [<c1076cff>] new_inode+0x17/0x8e
                         [<c1096f65>] sysfs_new_inode+0x17/0xda
                         [<c1097061>] sysfs_create+0x39/0xc0
                         [<c1098043>] create_dir+0x99/0x19c
                         [<c109883a>] sysfs_create_dir+0x48/0x63
                         [<c10f363f>] kobject_add+0xc7/0x171
                         [<c10f3717>] kset_add+0x2e/0x30
                         [<c10f3832>] kset_register+0x12/0x15
                         [<c115f358>] bus_register+0xa3/0x14f
                         [<c136dc4d>] platform_bus_init+0x17/0x19
                         [<c136dc89>] driver_init+0x1c/0x2d
                         [<c100025f>] init+0x3f/0x1de
                         [<c1001005>] kernel_thread_helper+0x5/0xb
           in-softirq-W at:
                         [<c102cbca>] lock_acquire+0x60/0x80
                         [<c11fcac6>] _spin_lock+0x23/0x32
                         [<c10124b4>] task_rq_lock+0x17/0x1e
                         [<c10125c7>] try_to_wake_up+0x18/0x102
                         [<c10126d9>] wake_up_process+0xf/0x11
                         [<c101a4ec>] __do_softirq+0x97/0xb0
                         [<c1004a64>] do_softirq+0x58/0xbd
         }
         ... key      at: [<c139aa4c>] per_cpu__runqueues+0x98c/0x994
       ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fcac6>] _spin_lock+0x23/0x32
   [<c10124b4>] task_rq_lock+0x17/0x1e
   [<c10125c7>] try_to_wake_up+0x18/0x102
   [<c10126bc>] default_wake_function+0xb/0xd
   [<c1011948>] __wake_up_common+0x2f/0x53
   [<c1011cf2>] complete+0x2b/0x3e
   [<c1026c88>] kthread+0x91/0xdc
   [<c1001005>] kernel_thread_helper+0x5/0xb

     ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fccee>] _spin_lock_irqsave+0x2c/0x3c
   [<c1011d1e>] __wake_up_sync+0x19/0x44
   [<c102011a>] do_notify_parent+0x166/0x182
   [<c101898b>] do_exit+0x714/0x80b
   [<c1023ebe>] ____call_usermodehelper+0xee/0xf0
   [<c1001005>] kernel_thread_helper+0x5/0xb

      -> (pidmap_lock){....} ops: 4427 {
         initial-use  at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fcc7b>] _spin_lock_irq+0x29/0x38
                        [<c1024b17>] alloc_pid+0x1ad/0x20b
                        [<c10151b8>] do_fork+0x18/0x19a
                        [<c100136c>] kernel_thread+0x6c/0x74
                        [<c1000412>] rest_init+0x14/0x3a
                        [<c135b6b2>] start_kernel+0x2d1/0x2d3
                        [<c1000199>] 0xc1000199
       }
       ... key      at: [<c1263438>] pidmap_lock+0x38/0x60
     ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fccee>] _spin_lock_irqsave+0x2c/0x3c
   [<c10248c7>] free_pid+0x11/0x69
   [<c1024967>] detach_pid+0x48/0x4b
   [<c10176b5>] release_task+0x146/0x2b2
   [<c1018a03>] do_exit+0x78c/0x80b
   [<c1023ebe>] ____call_usermodehelper+0xee/0xf0
   [<c1001005>] kernel_thread_helper+0x5/0xb

      -> (&parent->list_lock){++..} ops: 48418 {
         initial-use  at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fcac6>] _spin_lock+0x23/0x32
                        [<c105c1e1>] cache_alloc_refill+0x61/0x5f8
                        [<c105c99b>] kmem_cache_zalloc+0x6e/0xc7
                        [<c105d05a>] kmem_cache_create+0x20c/0x51a
                        [<c13667d6>] kmem_cache_init+0x149/0x349
                        [<c135b549>] start_kernel+0x168/0x2d3
                        [<c1000199>] 0xc1000199
         in-hardirq-W at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fcac6>] _spin_lock+0x23/0x32
                        [<c105c1e1>] cache_alloc_refill+0x61/0x5f8
                        [<c105ca62>] kmem_cache_alloc+0x6e/0xa3
                        [<c112192b>] acpi_os_execute+0x3c/0xd0
                        [<c1139fdc>] acpi_ec_gpe_handler+0xa2/0xc6
                        [<c112726e>] acpi_ev_gpe_dispatch+0x58/0x122
                        [<c1127583>] acpi_ev_gpe_detect+0xb7/0x10e
                        [<c1125d77>] acpi_ev_sci_xrupt_handler+0x15/0x1d
                        [<c11210a9>] acpi_irq+0xe/0x18
                        [<c103eb6b>] handle_IRQ_event+0x20/0x50
                        [<c103ec10>] __do_IRQ+0x75/0xc9
                        [<c1004b64>] do_IRQ+0x9b/0xaf
                        [<c1002fd9>] common_interrupt+0x25/0x2c
                        [<c1001cda>] cpu_idle+0x41/0x6a
                        [<c1000435>] rest_init+0x37/0x3a
                        [<c135b6b2>] start_kernel+0x2d1/0x2d3
                        [<c1000199>] 0xc1000199
         in-softirq-W at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fcac6>] _spin_lock+0x23/0x32
                        [<c105be59>] free_block+0x14b/0x184
                        [<c105baf4>] __cache_free+0x248/0x2b2
                        [<c105bbb2>] kmem_cache_free+0x54/0x6e
                        [<c1013c6f>] free_task+0x21/0x24
                        [<c101512a>] __put_task_struct+0xb8/0xbd
                        [<c1016f5e>] delayed_put_task_struct+0x1d/0x1f
                        [<c1024f1f>] __rcu_process_callbacks+0xfe/0x154
                        [<c1024f87>] rcu_process_callbacks+0x12/0x23
                        [<c101a2d3>] tasklet_action+0x45/0x76
                        [<c101a4aa>] __do_softirq+0x55/0xb0
                        [<c1004a64>] do_softirq+0x58/0xbd
       }
       ... key      at: [<c14ffc8c>] __key.15142+0x0/0x8
     ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fcac6>] _spin_lock+0x23/0x32
   [<c105c1e1>] cache_alloc_refill+0x61/0x5f8
   [<c105ca62>] kmem_cache_alloc+0x6e/0xa3
   [<c101f20c>] __sigqueue_alloc+0x3b/0x6e
   [<c101f274>] send_signal+0x35/0xe9
   [<c101f96d>] __group_send_sig_info+0x67/0x85
   [<c10200fc>] do_notify_parent+0x148/0x182
   [<c101898b>] do_exit+0x714/0x80b
   [<c1023ebe>] ____call_usermodehelper+0xee/0xf0
   [<c1001005>] kernel_thread_helper+0x5/0xb

      -> (&rq->rq_lock_key){++..} ops: 64390 {
         initial-use  at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fccee>] _spin_lock_irqsave+0x2c/0x3c
                        [<c1011f27>] init_idle+0x4c/0x72
                        [<c1363e6b>] sched_init+0xbb/0xbf
                        [<c135b441>] start_kernel+0x60/0x2d3
                        [<c1000199>] 0xc1000199
         in-hardirq-W at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fcac6>] _spin_lock+0x23/0x32
                        [<c1011ff0>] scheduler_tick+0xa3/0x2ac
                        [<c101e44a>] update_process_times+0x59/0x65
                        [<c1005ae3>] timer_interrupt+0x38/0x5d
                        [<c103eb6b>] handle_IRQ_event+0x20/0x50
                        [<c103ec10>] __do_IRQ+0x75/0xc9
                        [<c1004b64>] do_IRQ+0x9b/0xaf
                        [<c1002fd9>] common_interrupt+0x25/0x2c
                        [<c105b6f5>] cache_alloc_debugcheck_after+0x25/0x135
                        [<c105ca8b>] kmem_cache_alloc+0x97/0xa3
                        [<c107631c>] alloc_inode+0x26/0x18c
                        [<c1076cff>] new_inode+0x17/0x8e
                        [<c1096f65>] sysfs_new_inode+0x17/0xda
                        [<c1097061>] sysfs_create+0x39/0xc0
                        [<c1098043>] create_dir+0x99/0x19c
                        [<c109883a>] sysfs_create_dir+0x48/0x63
                        [<c10f363f>] kobject_add+0xc7/0x171
                        [<c10f3717>] kset_add+0x2e/0x30
                        [<c10f3832>] kset_register+0x12/0x15
                        [<c115f358>] bus_register+0xa3/0x14f
                        [<c136dc4d>] platform_bus_init+0x17/0x19
                        [<c136dc89>] driver_init+0x1c/0x2d
                        [<c100025f>] init+0x3f/0x1de
                        [<c1001005>] kernel_thread_helper+0x5/0xb
         in-softirq-W at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fcac6>] _spin_lock+0x23/0x32
                        [<c10124b4>] task_rq_lock+0x17/0x1e
                        [<c10125c7>] try_to_wake_up+0x18/0x102
                        [<c10126d9>] wake_up_process+0xf/0x11
                        [<c101a4ec>] __do_softirq+0x97/0xb0
                        [<c1004a64>] do_softirq+0x58/0xbd
       }
       ... key      at: [<c139aa4c>] per_cpu__runqueues+0x98c/0x994
     ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fcac6>] _spin_lock+0x23/0x32
   [<c10124b4>] task_rq_lock+0x17/0x1e
   [<c10125c7>] try_to_wake_up+0x18/0x102
   [<c10126c8>] wake_up_state+0xa/0xc
   [<c101f13a>] signal_wake_up+0x1b/0x1d
   [<c101f8e9>] __group_complete_signal+0x223/0x240
   [<c101f97d>] __group_send_sig_info+0x77/0x85
   [<c10200fc>] do_notify_parent+0x148/0x182
   [<c101898b>] do_exit+0x714/0x80b
   [<c1023ebe>] ____call_usermodehelper+0xee/0xf0
   [<c1001005>] kernel_thread_helper+0x5/0xb

      -> (&base->lock_key){.+..} ops: 9927 {
         initial-use  at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fccee>] _spin_lock_irqsave+0x2c/0x3c
                        [<c10293d7>] hrtimer_try_to_cancel+0x16/0x4f
                        [<c102941d>] hrtimer_cancel+0xd/0x18
                        [<c1018425>] do_exit+0x1ae/0x80b
                        [<c1023ebe>] ____call_usermodehelper+0xee/0xf0
                        [<c1001005>] kernel_thread_helper+0x5/0xb
         in-softirq-W at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fcc7b>] _spin_lock_irq+0x29/0x38
                        [<c102933e>] hrtimer_run_queues+0xab/0x12e
                        [<c101d7fc>] run_timer_softirq+0x14/0x14a
                        [<c101a4aa>] __do_softirq+0x55/0xb0
                        [<c1004a64>] do_softirq+0x58/0xbd
       }
       ... key      at: [<c1263a58>] per_cpu__hrtimer_bases+0x118/0x120
     ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fccee>] _spin_lock_irqsave+0x2c/0x3c
   [<c10295fc>] hrtimer_get_remaining+0x19/0x52
   [<c1018f71>] itimer_get_remtime+0x14/0x56
   [<c101905e>] do_setitimer+0xab/0x4b9
   [<c1019521>] alarm_setitimer+0x35/0x56
   [<c101da5b>] sys_alarm+0xb/0xd
   [<c1002d6d>] sysenter_past_esp+0x56/0x8d

      -> (uidhash_lock){.+..} ops: 3541 {
         initial-use  at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fcac6>] _spin_lock+0x23/0x32
                        [<c10f2c58>] _atomic_dec_and_lock+0x10/0x30
                        [<c101e6c7>] free_uid+0x23/0xa2
                        [<c1015106>] __put_task_struct+0x94/0xbd
                        [<c1016f5e>] delayed_put_task_struct+0x1d/0x1f
                        [<c1024f1f>] __rcu_process_callbacks+0xfe/0x154
                        [<c1024f87>] rcu_process_callbacks+0x12/0x23
                        [<c101a2d3>] tasklet_action+0x45/0x76
                        [<c101a4aa>] __do_softirq+0x55/0xb0
                        [<c1004a64>] do_softirq+0x58/0xbd
         in-softirq-W at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fcac6>] _spin_lock+0x23/0x32
                        [<c10f2c58>] _atomic_dec_and_lock+0x10/0x30
                        [<c101e6c7>] free_uid+0x23/0xa2
                        [<c1015106>] __put_task_struct+0x94/0xbd
                        [<c1016f5e>] delayed_put_task_struct+0x1d/0x1f
                        [<c1024f1f>] __rcu_process_callbacks+0xfe/0x154
                        [<c1024f87>] rcu_process_callbacks+0x12/0x23
                        [<c101a2d3>] tasklet_action+0x45/0x76
                        [<c101a4aa>] __do_softirq+0x55/0xb0
                        [<c1004a64>] do_softirq+0x58/0xbd
       }
       ... key      at: [<c1262f38>] uidhash_lock+0x38/0x60
     ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fcac6>] _spin_lock+0x23/0x32
   [<c10f2c58>] _atomic_dec_and_lock+0x10/0x30
   [<c101e6c7>] free_uid+0x23/0xa2
   [<c101ebc8>] __sigqueue_free+0x22/0x31
   [<c101efc8>] __dequeue_signal+0x113/0x163
   [<c10203b2>] dequeue_signal+0x34/0xac
   [<c102074a>] get_signal_to_deliver+0xf9/0x3f4
   [<c10023e3>] do_notify_resume+0x80/0x6a6
   [<c1002ec9>] work_notifysig+0x13/0x1a

   ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fcac6>] _spin_lock+0x23/0x32
   [<c106925e>] flush_old_exec+0x3db/0x7e3
   [<c1086319>] load_elf_binary+0x48c/0x142b
   [<c1068703>] search_binary_handler+0xe0/0x2d6
   [<c1069f71>] do_execve+0x14f/0x1eb
   [<c10016a8>] sys_execve+0x29/0x79
   [<c1002deb>] syscall_call+0x7/0xb

 ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fcac6>] _spin_lock+0x23/0x32
   [<c1014bd0>] copy_process+0xf5e/0x138a
   [<c1015233>] do_fork+0x93/0x19a
   [<c100136c>] kernel_thread+0x6c/0x74
   [<c1000412>] rest_init+0x14/0x3a
   [<c135b6b2>] start_kernel+0x2d1/0x2d3
   [<c1000199>] 0xc1000199

  -> (&sighand->siglock){....} ops: 57856 {
     initial-use  at:
                      [<c102cbca>] lock_acquire+0x60/0x80
                      [<c11fcc7b>] _spin_lock_irq+0x29/0x38
                      [<c101e9e7>] sigprocmask+0x25/0xd0
                      [<c1026c61>] kthread+0x6a/0xdc
                      [<c1001005>] kernel_thread_helper+0x5/0xb
   }
   ... key      at: [<c139aa84>] __key.22974+0x0/0x8
    -> (&waitqueue_lock_key){++..} ops: 105911 {
       initial-use  at:
                       [<c102cbca>] lock_acquire+0x60/0x80
                       [<c11fcc7b>] _spin_lock_irq+0x29/0x38
                       [<c11faa0a>] wait_for_completion+0x24/0xd0
                       [<c1026aa5>] keventd_create_kthread+0x2b/0x57
                       [<c1026bac>] kthread_create+0xdb/0x126
                       [<c101a0d7>] cpu_callback+0x49/0x8e
                       [<c13643c3>] spawn_ksoftirqd+0x1c/0x32
                       [<c1000241>] init+0x21/0x1de
                       [<c1001005>] kernel_thread_helper+0x5/0xb
       in-hardirq-W at:
                       [<c102cbca>] lock_acquire+0x60/0x80
                       [<c11fccee>] _spin_lock_irqsave+0x2c/0x3c
                       [<c1011d5e>] __wake_up+0x15/0x3b
                       [<c1139fbb>] acpi_ec_gpe_handler+0x81/0xc6
                       [<c112726e>] acpi_ev_gpe_dispatch+0x58/0x122
                       [<c1127583>] acpi_ev_gpe_detect+0xb7/0x10e
                       [<c1125d77>] acpi_ev_sci_xrupt_handler+0x15/0x1d
                       [<c11210a9>] acpi_irq+0xe/0x18
                       [<c103eb6b>] handle_IRQ_event+0x20/0x50
                       [<c103ec10>] __do_IRQ+0x75/0xc9
                       [<c1004b64>] do_IRQ+0x9b/0xaf
                       [<c1002fd9>] common_interrupt+0x25/0x2c
                       [<c1001cda>] cpu_idle+0x41/0x6a
                       [<c1000435>] rest_init+0x37/0x3a
                       [<c135b6b2>] start_kernel+0x2d1/0x2d3
                       [<c1000199>] 0xc1000199
       in-softirq-W at:
                       [<c102cbca>] lock_acquire+0x60/0x80
                       [<c11fccee>] _spin_lock_irqsave+0x2c/0x3c
                       [<c1011cd9>] complete+0x12/0x3e
                       [<c1024cce>] wakeme_after_rcu+0xb/0xd
                       [<c1024f1f>] __rcu_process_callbacks+0xfe/0x154
                       [<c1024f87>] rcu_process_callbacks+0x12/0x23
                       [<c101a2d3>] tasklet_action+0x45/0x76
                       [<c101a4aa>] __do_softirq+0x55/0xb0
                       [<c1004a64>] do_softirq+0x58/0xbd
     }
     ... key      at: [<c13bd4b4>] waitqueue_lock_key+0x0/0x8
      -> (&rq->rq_lock_key){++..} ops: 64390 {
         initial-use  at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fccee>] _spin_lock_irqsave+0x2c/0x3c
                        [<c1011f27>] init_idle+0x4c/0x72
                        [<c1363e6b>] sched_init+0xbb/0xbf
                        [<c135b441>] start_kernel+0x60/0x2d3
                        [<c1000199>] 0xc1000199
         in-hardirq-W at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fcac6>] _spin_lock+0x23/0x32
                        [<c1011ff0>] scheduler_tick+0xa3/0x2ac
                        [<c101e44a>] update_process_times+0x59/0x65
                        [<c1005ae3>] timer_interrupt+0x38/0x5d
                        [<c103eb6b>] handle_IRQ_event+0x20/0x50
                        [<c103ec10>] __do_IRQ+0x75/0xc9
                        [<c1004b64>] do_IRQ+0x9b/0xaf
                        [<c1002fd9>] common_interrupt+0x25/0x2c
                        [<c105b6f5>] cache_alloc_debugcheck_after+0x25/0x135
                        [<c105ca8b>] kmem_cache_alloc+0x97/0xa3
                        [<c107631c>] alloc_inode+0x26/0x18c
                        [<c1076cff>] new_inode+0x17/0x8e
                        [<c1096f65>] sysfs_new_inode+0x17/0xda
                        [<c1097061>] sysfs_create+0x39/0xc0
                        [<c1098043>] create_dir+0x99/0x19c
                        [<c109883a>] sysfs_create_dir+0x48/0x63
                        [<c10f363f>] kobject_add+0xc7/0x171
                        [<c10f3717>] kset_add+0x2e/0x30
                        [<c10f3832>] kset_register+0x12/0x15
                        [<c115f358>] bus_register+0xa3/0x14f
                        [<c136dc4d>] platform_bus_init+0x17/0x19
                        [<c136dc89>] driver_init+0x1c/0x2d
                        [<c100025f>] init+0x3f/0x1de
                        [<c1001005>] kernel_thread_helper+0x5/0xb
         in-softirq-W at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fcac6>] _spin_lock+0x23/0x32
                        [<c10124b4>] task_rq_lock+0x17/0x1e
                        [<c10125c7>] try_to_wake_up+0x18/0x102
                        [<c10126d9>] wake_up_process+0xf/0x11
                        [<c101a4ec>] __do_softirq+0x97/0xb0
                        [<c1004a64>] do_softirq+0x58/0xbd
       }
       ... key      at: [<c139aa4c>] per_cpu__runqueues+0x98c/0x994
     ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fcac6>] _spin_lock+0x23/0x32
   [<c10124b4>] task_rq_lock+0x17/0x1e
   [<c10125c7>] try_to_wake_up+0x18/0x102
   [<c10126bc>] default_wake_function+0xb/0xd
   [<c1011948>] __wake_up_common+0x2f/0x53
   [<c1011cf2>] complete+0x2b/0x3e
   [<c1026c88>] kthread+0x91/0xdc
   [<c1001005>] kernel_thread_helper+0x5/0xb

   ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fccee>] _spin_lock_irqsave+0x2c/0x3c
   [<c1011d1e>] __wake_up_sync+0x19/0x44
   [<c102011a>] do_notify_parent+0x166/0x182
   [<c101898b>] do_exit+0x714/0x80b
   [<c1023ebe>] ____call_usermodehelper+0xee/0xf0
   [<c1001005>] kernel_thread_helper+0x5/0xb

    -> (pidmap_lock){....} ops: 4427 {
       initial-use  at:
                       [<c102cbca>] lock_acquire+0x60/0x80
                       [<c11fcc7b>] _spin_lock_irq+0x29/0x38
                       [<c1024b17>] alloc_pid+0x1ad/0x20b
                       [<c10151b8>] do_fork+0x18/0x19a
                       [<c100136c>] kernel_thread+0x6c/0x74
                       [<c1000412>] rest_init+0x14/0x3a
                       [<c135b6b2>] start_kernel+0x2d1/0x2d3
                       [<c1000199>] 0xc1000199
     }
     ... key      at: [<c1263438>] pidmap_lock+0x38/0x60
   ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fccee>] _spin_lock_irqsave+0x2c/0x3c
   [<c10248c7>] free_pid+0x11/0x69
   [<c1024967>] detach_pid+0x48/0x4b
   [<c10176b5>] release_task+0x146/0x2b2
   [<c1018a03>] do_exit+0x78c/0x80b
   [<c1023ebe>] ____call_usermodehelper+0xee/0xf0
   [<c1001005>] kernel_thread_helper+0x5/0xb

    -> (&parent->list_lock){++..} ops: 48418 {
       initial-use  at:
                       [<c102cbca>] lock_acquire+0x60/0x80
                       [<c11fcac6>] _spin_lock+0x23/0x32
                       [<c105c1e1>] cache_alloc_refill+0x61/0x5f8
                       [<c105c99b>] kmem_cache_zalloc+0x6e/0xc7
                       [<c105d05a>] kmem_cache_create+0x20c/0x51a
                       [<c13667d6>] kmem_cache_init+0x149/0x349
                       [<c135b549>] start_kernel+0x168/0x2d3
                       [<c1000199>] 0xc1000199
       in-hardirq-W at:
                       [<c102cbca>] lock_acquire+0x60/0x80
                       [<c11fcac6>] _spin_lock+0x23/0x32
                       [<c105c1e1>] cache_alloc_refill+0x61/0x5f8
                       [<c105ca62>] kmem_cache_alloc+0x6e/0xa3
                       [<c112192b>] acpi_os_execute+0x3c/0xd0
                       [<c1139fdc>] acpi_ec_gpe_handler+0xa2/0xc6
                       [<c112726e>] acpi_ev_gpe_dispatch+0x58/0x122
                       [<c1127583>] acpi_ev_gpe_detect+0xb7/0x10e
                       [<c1125d77>] acpi_ev_sci_xrupt_handler+0x15/0x1d
                       [<c11210a9>] acpi_irq+0xe/0x18
                       [<c103eb6b>] handle_IRQ_event+0x20/0x50
                       [<c103ec10>] __do_IRQ+0x75/0xc9
                       [<c1004b64>] do_IRQ+0x9b/0xaf
                       [<c1002fd9>] common_interrupt+0x25/0x2c
                       [<c1001cda>] cpu_idle+0x41/0x6a
                       [<c1000435>] rest_init+0x37/0x3a
                       [<c135b6b2>] start_kernel+0x2d1/0x2d3
                       [<c1000199>] 0xc1000199
       in-softirq-W at:
                       [<c102cbca>] lock_acquire+0x60/0x80
                       [<c11fcac6>] _spin_lock+0x23/0x32
                       [<c105be59>] free_block+0x14b/0x184
                       [<c105baf4>] __cache_free+0x248/0x2b2
                       [<c105bbb2>] kmem_cache_free+0x54/0x6e
                       [<c1013c6f>] free_task+0x21/0x24
                       [<c101512a>] __put_task_struct+0xb8/0xbd
                       [<c1016f5e>] delayed_put_task_struct+0x1d/0x1f
                       [<c1024f1f>] __rcu_process_callbacks+0xfe/0x154
                       [<c1024f87>] rcu_process_callbacks+0x12/0x23
                       [<c101a2d3>] tasklet_action+0x45/0x76
                       [<c101a4aa>] __do_softirq+0x55/0xb0
                       [<c1004a64>] do_softirq+0x58/0xbd
     }
     ... key      at: [<c14ffc8c>] __key.15142+0x0/0x8
   ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fcac6>] _spin_lock+0x23/0x32
   [<c105c1e1>] cache_alloc_refill+0x61/0x5f8
   [<c105ca62>] kmem_cache_alloc+0x6e/0xa3
   [<c101f20c>] __sigqueue_alloc+0x3b/0x6e
   [<c101f274>] send_signal+0x35/0xe9
   [<c101f96d>] __group_send_sig_info+0x67/0x85
   [<c10200fc>] do_notify_parent+0x148/0x182
   [<c101898b>] do_exit+0x714/0x80b
   [<c1023ebe>] ____call_usermodehelper+0xee/0xf0
   [<c1001005>] kernel_thread_helper+0x5/0xb

    -> (&rq->rq_lock_key){++..} ops: 64390 {
       initial-use  at:
                       [<c102cbca>] lock_acquire+0x60/0x80
                       [<c11fccee>] _spin_lock_irqsave+0x2c/0x3c
                       [<c1011f27>] init_idle+0x4c/0x72
                       [<c1363e6b>] sched_init+0xbb/0xbf
                       [<c135b441>] start_kernel+0x60/0x2d3
                       [<c1000199>] 0xc1000199
       in-hardirq-W at:
                       [<c102cbca>] lock_acquire+0x60/0x80
                       [<c11fcac6>] _spin_lock+0x23/0x32
                       [<c1011ff0>] scheduler_tick+0xa3/0x2ac
                       [<c101e44a>] update_process_times+0x59/0x65
                       [<c1005ae3>] timer_interrupt+0x38/0x5d
                       [<c103eb6b>] handle_IRQ_event+0x20/0x50
                       [<c103ec10>] __do_IRQ+0x75/0xc9
                       [<c1004b64>] do_IRQ+0x9b/0xaf
                       [<c1002fd9>] common_interrupt+0x25/0x2c
                       [<c105b6f5>] cache_alloc_debugcheck_after+0x25/0x135
                       [<c105ca8b>] kmem_cache_alloc+0x97/0xa3
                       [<c107631c>] alloc_inode+0x26/0x18c
                       [<c1076cff>] new_inode+0x17/0x8e
                       [<c1096f65>] sysfs_new_inode+0x17/0xda
                       [<c1097061>] sysfs_create+0x39/0xc0
                       [<c1098043>] create_dir+0x99/0x19c
                       [<c109883a>] sysfs_create_dir+0x48/0x63
                       [<c10f363f>] kobject_add+0xc7/0x171
                       [<c10f3717>] kset_add+0x2e/0x30
                       [<c10f3832>] kset_register+0x12/0x15
                       [<c115f358>] bus_register+0xa3/0x14f
                       [<c136dc4d>] platform_bus_init+0x17/0x19
                       [<c136dc89>] driver_init+0x1c/0x2d
                       [<c100025f>] init+0x3f/0x1de
                       [<c1001005>] kernel_thread_helper+0x5/0xb
       in-softirq-W at:
                       [<c102cbca>] lock_acquire+0x60/0x80
                       [<c11fcac6>] _spin_lock+0x23/0x32
                       [<c10124b4>] task_rq_lock+0x17/0x1e
                       [<c10125c7>] try_to_wake_up+0x18/0x102
                       [<c10126d9>] wake_up_process+0xf/0x11
                       [<c101a4ec>] __do_softirq+0x97/0xb0
                       [<c1004a64>] do_softirq+0x58/0xbd
     }
     ... key      at: [<c139aa4c>] per_cpu__runqueues+0x98c/0x994
   ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fcac6>] _spin_lock+0x23/0x32
   [<c10124b4>] task_rq_lock+0x17/0x1e
   [<c10125c7>] try_to_wake_up+0x18/0x102
   [<c10126c8>] wake_up_state+0xa/0xc
   [<c101f13a>] signal_wake_up+0x1b/0x1d
   [<c101f8e9>] __group_complete_signal+0x223/0x240
   [<c101f97d>] __group_send_sig_info+0x77/0x85
   [<c10200fc>] do_notify_parent+0x148/0x182
   [<c101898b>] do_exit+0x714/0x80b
   [<c1023ebe>] ____call_usermodehelper+0xee/0xf0
   [<c1001005>] kernel_thread_helper+0x5/0xb

    -> (&base->lock_key){.+..} ops: 9927 {
       initial-use  at:
                       [<c102cbca>] lock_acquire+0x60/0x80
                       [<c11fccee>] _spin_lock_irqsave+0x2c/0x3c
                       [<c10293d7>] hrtimer_try_to_cancel+0x16/0x4f
                       [<c102941d>] hrtimer_cancel+0xd/0x18
                       [<c1018425>] do_exit+0x1ae/0x80b
                       [<c1023ebe>] ____call_usermodehelper+0xee/0xf0
                       [<c1001005>] kernel_thread_helper+0x5/0xb
       in-softirq-W at:
                       [<c102cbca>] lock_acquire+0x60/0x80
                       [<c11fcc7b>] _spin_lock_irq+0x29/0x38
                       [<c102933e>] hrtimer_run_queues+0xab/0x12e
                       [<c101d7fc>] run_timer_softirq+0x14/0x14a
                       [<c101a4aa>] __do_softirq+0x55/0xb0
                       [<c1004a64>] do_softirq+0x58/0xbd
     }
     ... key      at: [<c1263a58>] per_cpu__hrtimer_bases+0x118/0x120
   ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fccee>] _spin_lock_irqsave+0x2c/0x3c
   [<c10295fc>] hrtimer_get_remaining+0x19/0x52
   [<c1018f71>] itimer_get_remtime+0x14/0x56
   [<c101905e>] do_setitimer+0xab/0x4b9
   [<c1019521>] alarm_setitimer+0x35/0x56
   [<c101da5b>] sys_alarm+0xb/0xd
   [<c1002d6d>] sysenter_past_esp+0x56/0x8d

    -> (uidhash_lock){.+..} ops: 3541 {
       initial-use  at:
                       [<c102cbca>] lock_acquire+0x60/0x80
                       [<c11fcac6>] _spin_lock+0x23/0x32
                       [<c10f2c58>] _atomic_dec_and_lock+0x10/0x30
                       [<c101e6c7>] free_uid+0x23/0xa2
                       [<c1015106>] __put_task_struct+0x94/0xbd
                       [<c1016f5e>] delayed_put_task_struct+0x1d/0x1f
                       [<c1024f1f>] __rcu_process_callbacks+0xfe/0x154
                       [<c1024f87>] rcu_process_callbacks+0x12/0x23
                       [<c101a2d3>] tasklet_action+0x45/0x76
                       [<c101a4aa>] __do_softirq+0x55/0xb0
                       [<c1004a64>] do_softirq+0x58/0xbd
       in-softirq-W at:
                       [<c102cbca>] lock_acquire+0x60/0x80
                       [<c11fcac6>] _spin_lock+0x23/0x32
                       [<c10f2c58>] _atomic_dec_and_lock+0x10/0x30
                       [<c101e6c7>] free_uid+0x23/0xa2
                       [<c1015106>] __put_task_struct+0x94/0xbd
                       [<c1016f5e>] delayed_put_task_struct+0x1d/0x1f
                       [<c1024f1f>] __rcu_process_callbacks+0xfe/0x154
                       [<c1024f87>] rcu_process_callbacks+0x12/0x23
                       [<c101a2d3>] tasklet_action+0x45/0x76
                       [<c101a4aa>] __do_softirq+0x55/0xb0
                       [<c1004a64>] do_softirq+0x58/0xbd
     }
     ... key      at: [<c1262f38>] uidhash_lock+0x38/0x60
   ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fcac6>] _spin_lock+0x23/0x32
   [<c10f2c58>] _atomic_dec_and_lock+0x10/0x30
   [<c101e6c7>] free_uid+0x23/0xa2
   [<c101ebc8>] __sigqueue_free+0x22/0x31
   [<c101efc8>] __dequeue_signal+0x113/0x163
   [<c10203b2>] dequeue_signal+0x34/0xac
   [<c102074a>] get_signal_to_deliver+0xf9/0x3f4
   [<c10023e3>] do_notify_resume+0x80/0x6a6
   [<c1002ec9>] work_notifysig+0x13/0x1a

 ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fcac6>] _spin_lock+0x23/0x32
   [<c1014bd0>] copy_process+0xf5e/0x138a
   [<c1015233>] do_fork+0x93/0x19a
   [<c100136c>] kernel_thread+0x6c/0x74
   [<c1023c73>] __call_usermodehelper+0x2b/0x44
   [<c1024198>] run_workqueue+0x86/0xcb
   [<c1024711>] worker_thread+0xe1/0x114
   [<c1026ca7>] kthread+0xb0/0xdc
   [<c1001005>] kernel_thread_helper+0x5/0xb

  -> (&sig->stats_lock){--..} ops: 2186 {
     initial-use  at:
                      [<c102cbca>] lock_acquire+0x60/0x80
                      [<c11fcac6>] _spin_lock+0x23/0x32
                      [<c1013ac5>] __cleanup_signal+0x1a/0x5b
                      [<c1017797>] release_task+0x228/0x2b2
                      [<c1018a03>] do_exit+0x78c/0x80b
                      [<c1023ebe>] ____call_usermodehelper+0xee/0xf0
                      [<c1001005>] kernel_thread_helper+0x5/0xb
     softirq-on-W at:
                      [<c102cbca>] lock_acquire+0x60/0x80
                      [<c11fcac6>] _spin_lock+0x23/0x32
                      [<c1013ac5>] __cleanup_signal+0x1a/0x5b
                      [<c1014e7a>] copy_process+0x1208/0x138a
                      [<c1015233>] do_fork+0x93/0x19a
                      [<c10012c5>] sys_clone+0x25/0x2a
                      [<c1002d6d>] sysenter_past_esp+0x56/0x8d
     hardirq-on-W at:
                      [<c102cbca>] lock_acquire+0x60/0x80
                      [<c11fcac6>] _spin_lock+0x23/0x32
                      [<c1013ac5>] __cleanup_signal+0x1a/0x5b
                      [<c1014e7a>] copy_process+0x1208/0x138a
                      [<c1015233>] do_fork+0x93/0x19a
                      [<c10012c5>] sys_clone+0x25/0x2a
                      [<c1002d6d>] sysenter_past_esp+0x56/0x8d
   }
   ... key      at: [<c139aaa4>] __key.22061+0x0/0x8
 ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fcac6>] _spin_lock+0x23/0x32
   [<c1013ac5>] __cleanup_signal+0x1a/0x5b
   [<c1017797>] release_task+0x228/0x2b2
   [<c1018a03>] do_exit+0x78c/0x80b
   [<c1023ebe>] ____call_usermodehelper+0xee/0xf0
   [<c1001005>] kernel_thread_helper+0x5/0xb

  -> (&rq->rq_lock_key){++..} ops: 64390 {
     initial-use  at:
                      [<c102cbca>] lock_acquire+0x60/0x80
                      [<c11fccee>] _spin_lock_irqsave+0x2c/0x3c
                      [<c1011f27>] init_idle+0x4c/0x72
                      [<c1363e6b>] sched_init+0xbb/0xbf
                      [<c135b441>] start_kernel+0x60/0x2d3
                      [<c1000199>] 0xc1000199
     in-hardirq-W at:
                      [<c102cbca>] lock_acquire+0x60/0x80
                      [<c11fcac6>] _spin_lock+0x23/0x32
                      [<c1011ff0>] scheduler_tick+0xa3/0x2ac
                      [<c101e44a>] update_process_times+0x59/0x65
                      [<c1005ae3>] timer_interrupt+0x38/0x5d
                      [<c103eb6b>] handle_IRQ_event+0x20/0x50
                      [<c103ec10>] __do_IRQ+0x75/0xc9
                      [<c1004b64>] do_IRQ+0x9b/0xaf
                      [<c1002fd9>] common_interrupt+0x25/0x2c
                      [<c105b6f5>] cache_alloc_debugcheck_after+0x25/0x135
                      [<c105ca8b>] kmem_cache_alloc+0x97/0xa3
                      [<c107631c>] alloc_inode+0x26/0x18c
                      [<c1076cff>] new_inode+0x17/0x8e
                      [<c1096f65>] sysfs_new_inode+0x17/0xda
                      [<c1097061>] sysfs_create+0x39/0xc0
                      [<c1098043>] create_dir+0x99/0x19c
                      [<c109883a>] sysfs_create_dir+0x48/0x63
                      [<c10f363f>] kobject_add+0xc7/0x171
                      [<c10f3717>] kset_add+0x2e/0x30
                      [<c10f3832>] kset_register+0x12/0x15
                      [<c115f358>] bus_register+0xa3/0x14f
                      [<c136dc4d>] platform_bus_init+0x17/0x19
                      [<c136dc89>] driver_init+0x1c/0x2d
                      [<c100025f>] init+0x3f/0x1de
                      [<c1001005>] kernel_thread_helper+0x5/0xb
     in-softirq-W at:
                      [<c102cbca>] lock_acquire+0x60/0x80
                      [<c11fcac6>] _spin_lock+0x23/0x32
                      [<c10124b4>] task_rq_lock+0x17/0x1e
                      [<c10125c7>] try_to_wake_up+0x18/0x102
                      [<c10126d9>] wake_up_process+0xf/0x11
                      [<c101a4ec>] __do_softirq+0x97/0xb0
                      [<c1004a64>] do_softirq+0x58/0xbd
   }
   ... key      at: [<c139aa4c>] per_cpu__runqueues+0x98c/0x994
 ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fcac6>] _spin_lock+0x23/0x32
   [<c10124b4>] task_rq_lock+0x17/0x1e
   [<c10132c9>] sched_exit+0x19/0x6b
   [<c10177ea>] release_task+0x27b/0x2b2
   [<c1018a03>] do_exit+0x78c/0x80b
   [<c1023ebe>] ____call_usermodehelper+0xee/0xf0
   [<c1001005>] kernel_thread_helper+0x5/0xb

  -> (uidhash_lock){.+..} ops: 3541 {
     initial-use  at:
                      [<c102cbca>] lock_acquire+0x60/0x80
                      [<c11fcac6>] _spin_lock+0x23/0x32
                      [<c10f2c58>] _atomic_dec_and_lock+0x10/0x30
                      [<c101e6c7>] free_uid+0x23/0xa2
                      [<c1015106>] __put_task_struct+0x94/0xbd
                      [<c1016f5e>] delayed_put_task_struct+0x1d/0x1f
                      [<c1024f1f>] __rcu_process_callbacks+0xfe/0x154
                      [<c1024f87>] rcu_process_callbacks+0x12/0x23
                      [<c101a2d3>] tasklet_action+0x45/0x76
                      [<c101a4aa>] __do_softirq+0x55/0xb0
                      [<c1004a64>] do_softirq+0x58/0xbd
     in-softirq-W at:
                      [<c102cbca>] lock_acquire+0x60/0x80
                      [<c11fcac6>] _spin_lock+0x23/0x32
                      [<c10f2c58>] _atomic_dec_and_lock+0x10/0x30
                      [<c101e6c7>] free_uid+0x23/0xa2
                      [<c1015106>] __put_task_struct+0x94/0xbd
                      [<c1016f5e>] delayed_put_task_struct+0x1d/0x1f
                      [<c1024f1f>] __rcu_process_callbacks+0xfe/0x154
                      [<c1024f87>] rcu_process_callbacks+0x12/0x23
                      [<c101a2d3>] tasklet_action+0x45/0x76
                      [<c101a4aa>] __do_softirq+0x55/0xb0
                      [<c1004a64>] do_softirq+0x58/0xbd
   }
   ... key      at: [<c1262f38>] uidhash_lock+0x38/0x60
 ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fcac6>] _spin_lock+0x23/0x32
   [<c10f2c58>] _atomic_dec_and_lock+0x10/0x30
   [<c101e6c7>] free_uid+0x23/0xa2
   [<c101ebc8>] __sigqueue_free+0x22/0x31
   [<c101f044>] flush_sigqueue+0x2c/0x33
   [<c1017790>] release_task+0x221/0x2b2
   [<c1018a03>] do_exit+0x78c/0x80b
   [<c100100b>] thread_saved_pc+0x0/0xe

  -> (&parent->list_lock/1){++..} ops: 17207 {
     initial-use  at:
                      [<c102cbca>] lock_acquire+0x60/0x80
                      [<c11fca92>] _spin_lock_nested+0x26/0x37
                      [<c105ba9e>] __cache_free+0x1f2/0x2b2
                      [<c105bbb2>] kmem_cache_free+0x54/0x6e
                      [<c1121339>] acpi_os_release_object+0x8/0xc
                      [<c1131bb6>] acpi_ps_free_op+0x1c/0x1e
                      [<c11319a7>] acpi_ps_delete_parse_tree+0x33/0x4c
                      [<c1131020>] acpi_ps_complete_this_op+0x12f/0x147
                      [<c11315ff>] acpi_ps_parse_loop+0x5c7/0x898
                      [<c1130c51>] acpi_ps_parse_aml+0x57/0x1e6
                      [<c1130644>] acpi_ns_one_complete_parse+0x78/0x8d
                      [<c113066b>] acpi_ns_parse_table+0x12/0x23
                      [<c112e8a9>] acpi_ns_load_table+0x79/0x9e
                      [<c112e91c>] acpi_ns_load_table_by_type+0x4e/0xab
                      [<c112e9af>] acpi_ns_load_namespace+0x36/0x57
                      [<c1133eb8>] acpi_load_tables+0x75/0xb1
                      [<c136b314>] acpi_early_init+0x61/0x10a
                      [<c135b6ad>] start_kernel+0x2cc/0x2d3
                      [<c1000199>] 0xc1000199
     in-hardirq-W at:
                      [<c102cbca>] lock_acquire+0x60/0x80
                      [<c11fca92>] _spin_lock_nested+0x26/0x37
                      [<c105ba9e>] __cache_free+0x1f2/0x2b2
                      [<c105bbb2>] kmem_cache_free+0x54/0x6e
                      [<c1044aa0>] mempool_free_slab+0xe/0x10
                      [<c1044aff>] mempool_free+0x5d/0x65
                      [<c1064172>] bio_free+0x31/0x35
                      [<c1064184>] bio_fs_destructor+0xe/0x10
                      [<c1063ea0>] bio_put+0x2a/0x2c
                      [<c106290f>] end_bio_bh_io_sync+0x36/0x3b
                      [<c10641ce>] bio_endio+0x48/0x50
                      [<c10e7fee>] __end_that_request_first+0x1e6/0x474
                      [<c10e8291>] end_that_request_first+0xb/0xd
                      [<c116a44b>] ide_end_request+0x8a/0xd8
                      [<c1171453>] ide_dma_intr+0x58/0x93
                      [<c116ae88>] ide_intr+0x149/0x1a9
                      [<c103eb6b>] handle_IRQ_event+0x20/0x50
                      [<c103ec10>] __do_IRQ+0x75/0xc9
                      [<c1004b64>] do_IRQ+0x9b/0xaf
                      [<c1002fd9>] common_interrupt+0x25/0x2c
                      [<c119c1f6>] skb_release_data+0x7c/0x80
                      [<c119c2dc>] pskb_expand_head+0xe2/0x126
                      [<c11b2173>] netlink_broadcast+0x73/0x288
                      [<c10f3d93>] kobject_uevent+0x345/0x3b6
                      [<c11605be>] class_device_add+0x2c6/0x3dd
                      [<c118de65>] input_register_device+0xdf/0x211
                      [<c1190008>] atkbd_connect+0x1c7/0x1ef
                      [<c1189824>] serio_connect_driver+0x1e/0x2e
                      [<c118984a>] serio_driver_probe+0x16/0x18
                      [<c115f74c>] driver_probe_device+0x45/0x92
                      [<c115f866>] __driver_attach+0x5c/0x85
                      [<c115f1d6>] bus_for_each_dev+0x36/0x5b
                      [<c115f6a4>] driver_attach+0x14/0x17
                      [<c115eeb6>] bus_add_driver+0x6b/0x109
                      [<c115fb1c>] driver_register+0x9d/0xa2
                      [<c118a35e>] serio_thread+0x128/0x24e
                      [<c1026ca7>] kthread+0xb0/0xdc
                      [<c1001005>] kernel_thread_helper+0x5/0xb
     in-softirq-W at:
                      [<c102cbca>] lock_acquire+0x60/0x80
                      [<c11fca92>] _spin_lock_nested+0x26/0x37
                      [<c105ba9e>] __cache_free+0x1f2/0x2b2
                      [<c105c130>] kfree+0x60/0x7d
                      [<c10d22be>] selinux_task_free_security+0x1a/0x1c
                      [<c10150fb>] __put_task_struct+0x89/0xbd
                      [<c1016f5e>] delayed_put_task_struct+0x1d/0x1f
                      [<c1024f1f>] __rcu_process_callbacks+0xfe/0x154
                      [<c1024f87>] rcu_process_callbacks+0x12/0x23
                      [<c101a2d3>] tasklet_action+0x45/0x76
                      [<c101a4aa>] __do_softirq+0x55/0xb0
                      [<c1004a64>] do_softirq+0x58/0xbd
   }
   ... key      at: [<c14ffc8d>] __key.15142+0x1/0x8
 ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fca92>] _spin_lock_nested+0x26/0x37
   [<c105ba9e>] __cache_free+0x1f2/0x2b2
   [<c105bbb2>] kmem_cache_free+0x54/0x6e
   [<c10135b8>] __cleanup_sighand+0x18/0x1a
   [<c1017771>] release_task+0x202/0x2b2
   [<c1017eab>] do_wait+0x68a/0x9c7
   [<c101820e>] sys_wait4+0x26/0x2a
   [<c1018225>] sys_waitpid+0x13/0x15
   [<c1002d6d>] sysenter_past_esp+0x56/0x8d

  -> (&parent->list_lock){++..} ops: 48418 {
     initial-use  at:
                      [<c102cbca>] lock_acquire+0x60/0x80
                      [<c11fcac6>] _spin_lock+0x23/0x32
                      [<c105c1e1>] cache_alloc_refill+0x61/0x5f8
                      [<c105c99b>] kmem_cache_zalloc+0x6e/0xc7
                      [<c105d05a>] kmem_cache_create+0x20c/0x51a
                      [<c13667d6>] kmem_cache_init+0x149/0x349
                      [<c135b549>] start_kernel+0x168/0x2d3
                      [<c1000199>] 0xc1000199
     in-hardirq-W at:
                      [<c102cbca>] lock_acquire+0x60/0x80
                      [<c11fcac6>] _spin_lock+0x23/0x32
                      [<c105c1e1>] cache_alloc_refill+0x61/0x5f8
                      [<c105ca62>] kmem_cache_alloc+0x6e/0xa3
                      [<c112192b>] acpi_os_execute+0x3c/0xd0
                      [<c1139fdc>] acpi_ec_gpe_handler+0xa2/0xc6
                      [<c112726e>] acpi_ev_gpe_dispatch+0x58/0x122
                      [<c1127583>] acpi_ev_gpe_detect+0xb7/0x10e
                      [<c1125d77>] acpi_ev_sci_xrupt_handler+0x15/0x1d
                      [<c11210a9>] acpi_irq+0xe/0x18
                      [<c103eb6b>] handle_IRQ_event+0x20/0x50
                      [<c103ec10>] __do_IRQ+0x75/0xc9
                      [<c1004b64>] do_IRQ+0x9b/0xaf
                      [<c1002fd9>] common_interrupt+0x25/0x2c
                      [<c1001cda>] cpu_idle+0x41/0x6a
                      [<c1000435>] rest_init+0x37/0x3a
                      [<c135b6b2>] start_kernel+0x2d1/0x2d3
                      [<c1000199>] 0xc1000199
     in-softirq-W at:
                      [<c102cbca>] lock_acquire+0x60/0x80
                      [<c11fcac6>] _spin_lock+0x23/0x32
                      [<c105be59>] free_block+0x14b/0x184
                      [<c105baf4>] __cache_free+0x248/0x2b2
                      [<c105bbb2>] kmem_cache_free+0x54/0x6e
                      [<c1013c6f>] free_task+0x21/0x24
                      [<c101512a>] __put_task_struct+0xb8/0xbd
                      [<c1016f5e>] delayed_put_task_struct+0x1d/0x1f
                      [<c1024f1f>] __rcu_process_callbacks+0xfe/0x154
                      [<c1024f87>] rcu_process_callbacks+0x12/0x23
                      [<c101a2d3>] tasklet_action+0x45/0x76
                      [<c101a4aa>] __do_softirq+0x55/0xb0
                      [<c1004a64>] do_softirq+0x58/0xbd
   }
   ... key      at: [<c14ffc8c>] __key.15142+0x0/0x8
 ... acquired at:
   [<c102cbca>] lock_acquire+0x60/0x80
   [<c11fcac6>] _spin_lock+0x23/0x32
   [<c105be59>] free_block+0x14b/0x184
   [<c105baf4>] __cache_free+0x248/0x2b2
   [<c105bbb2>] kmem_cache_free+0x54/0x6e
   [<c10135b8>] __cleanup_sighand+0x18/0x1a
   [<c1017771>] release_task+0x202/0x2b2
   [<c1017eab>] do_wait+0x68a/0x9c7
   [<c101820e>] sys_wait4+0x26/0x2a
   [<c1018225>] sys_waitpid+0x13/0x15
   [<c1002d6d>] sysenter_past_esp+0x56/0x8d


the second lock's dependencies:
-> (&sig->stats_lock){--..} ops: 2186 {
   initial-use  at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fcac6>] _spin_lock+0x23/0x32
                        [<c1013ac5>] __cleanup_signal+0x1a/0x5b
                        [<c1017797>] release_task+0x228/0x2b2
                        [<c1018a03>] do_exit+0x78c/0x80b
                        [<c1023ebe>] ____call_usermodehelper+0xee/0xf0
                        [<c1001005>] kernel_thread_helper+0x5/0xb
   softirq-on-W at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fcac6>] _spin_lock+0x23/0x32
                        [<c1013ac5>] __cleanup_signal+0x1a/0x5b
                        [<c1014e7a>] copy_process+0x1208/0x138a
                        [<c1015233>] do_fork+0x93/0x19a
                        [<c10012c5>] sys_clone+0x25/0x2a
                        [<c1002d6d>] sysenter_past_esp+0x56/0x8d
   hardirq-on-W at:
                        [<c102cbca>] lock_acquire+0x60/0x80
                        [<c11fcac6>] _spin_lock+0x23/0x32
                        [<c1013ac5>] __cleanup_signal+0x1a/0x5b
                        [<c1014e7a>] copy_process+0x1208/0x138a
                        [<c1015233>] do_fork+0x93/0x19a
                        [<c10012c5>] sys_clone+0x25/0x2a
                        [<c1002d6d>] sysenter_past_esp+0x56/0x8d
 }
 ... key      at: [<c139aaa4>] __key.22061+0x0/0x8

stack backtrace:
 [<c1003502>] show_trace_log_lvl+0x54/0xfd
 [<c1003b6a>] show_trace+0xd/0x10
 [<c1003c0e>] dump_stack+0x19/0x1b
 [<c102b15d>] print_irq_inversion_bug+0xe3/0xf0
 [<c102b5ac>] check_usage_forwards+0x32/0x3b
 [<c102b764>] mark_lock+0x1af/0x360
 [<c102c34c>] __lock_acquire+0x3a5/0x95e
 [<c102cbca>] lock_acquire+0x60/0x80
 [<c11fcc43>] _read_lock+0x23/0x32
 [<c10201a8>] send_group_sig_info+0x16/0x34
 [<c10197e4>] it_real_fn+0x22/0x6b
 [<c1029370>] hrtimer_run_queues+0xdd/0x12e
 [<c101d7fc>] run_timer_softirq+0x14/0x14a
 [<c101a4aa>] __do_softirq+0x55/0xb0
 [<c1004a64>] do_softirq+0x58/0xbd
 [<c101a544>] irq_exit+0x3f/0x4b
 [<c1004b69>] do_IRQ+0xa0/0xaf
 [<c1002fd9>] common_interrupt+0x25/0x2c
pccard: card ejected from slot 0
