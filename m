Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVGaIDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVGaIDw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 04:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVGaIDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 04:03:52 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.27]:18235 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S261833AbVGaIDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 04:03:18 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050730205259.GA24542@elte.hu>
References: <20050730160345.GA3584@elte.hu> <1122756435.29704.2.camel@twins>
	 <20050730205259.GA24542@elte.hu>
Content-Type: multipart/mixed; boundary="=-gAHbMUblxpcsNZt5EuRx"
Date: Sun, 31 Jul 2005 10:03:16 +0200
Message-Id: <1122796996.15033.9.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gAHbMUblxpcsNZt5EuRx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Ingo,

Still on -02;

I'm now running the thing and having some trouble fixing it.
Attached is a patch to the new CFQ iosched that I had lying about in an
old -mm port of the RT patch.

This trace is giving me a headache to fix:

 BUG: scheduling with irqs disabled: IRQ 14/0x20000000/772
 caller is __down_mutex+0x446/0x600
  [<c0104693>] dump_stack+0x23/0x30 (20)
  [<c036defc>] schedule+0xac/0x120 (28)
  [<c036f086>] __down_mutex+0x446/0x600 (120)
  [<c0370a48>] _spin_lock_irqsave+0x28/0x60 (28)
  [<c0121220>] __wake_up+0x20/0x70 (44)
  [<c013fab9>] __wake_up_bit+0x39/0x40 (24)
  [<c013fae4>] wake_up_bit+0x24/0x30 (16)
  [<c01790c6>] unlock_buffer+0x16/0x20 (8)
  [<c0179d19>] end_buffer_async_write+0x69/0x200 (68)
  [<c017d234>] end_bio_bh_io_sync+0x34/0x70 (20)
  [<c017eccd>] bio_endio+0x5d/0x90 (32)
  [<c02890f7>] __end_that_request_first+0xd7/0x250 (52)
  [<c0289297>] end_that_request_first+0x27/0x30 (20)
  [<c029f9ca>] __ide_end_request+0x6a/0x1b0 (36)
  [<c029fb9a>] ide_end_request+0x8a/0xb0 (40)
  [<c02a9ad0>] ide_dma_intr+0xa0/0xf0 (32)
  [<c02a1ba5>] ide_intr+0xb5/0x160 (36)
  [<c01544b6>] handle_IRQ_event+0x76/0x110 (52)
  [<c0154d09>] do_hardirq+0x59/0x110 (44)
  [<c0154e87>] do_irqd+0xc7/0x1e0 (36)
  [<c013f426>] kthread+0xb6/0xf0 (48)
  [<c01015f9>] kernel_thread_helper+0x5/0xc (271781916)
 ---------------------------
 | preempt count: 20000001 ]
 | 1-level deep critical section nesting:
 ----------------------------------------
 .. [<c0149d2c>] .... add_preempt_count+0x1c/0x20
 .....[<c014b0d7>] ..   ( <= print_traces+0x17/0x60)

 ------------------------------
 | showing all locks held by: |  (IRQ 14/772 [efef4660,  53]):
 ------------------------------


because end_buffer_async_read/write use bit_spin_(un)lock and I do not
know how those interact with -RT.

=-=-=-=-=-=-=-=-=-=-=-=

Also (just for fun) I enabled CONFIG_HOTPLUG_CPU and tried to offline a
cpu. This is what happened:

 kstopmachine/14814[CPU#1]: BUG in __activate_idle_task at kernel/sched.c:871
  [<c0104693>] dump_stack+0x23/0x30 (20)
  [<c0128473>] __WARN_ON+0x63/0x80 (44)
  [<c01230bd>] sched_idle_next+0xfd/0x100 (40)
  [<c014c276>] take_cpu_down+0x16/0x20 (8)
  [<c0153e5e>] do_stop+0x6e/0x80 (20)
  [<c013f426>] kthread+0xb6/0xf0 (48)
  [<c01015f9>] kernel_thread_helper+0x5/0xc (288305180)
 ---------------------------
 | preempt count: 20000003 ]
 | 3-level deep critical section nesting:
 ----------------------------------------
 .. [<c0149d2c>] .... add_preempt_count+0x1c/0x20
 .....[<c012300d>] ..   ( <= sched_idle_next+0x4d/0x100)
 .. [<c0149d2c>] .... add_preempt_count+0x1c/0x20
 .....[<c0128427>] ..   ( <= __WARN_ON+0x17/0x80)
 .. [<c0149d2c>] .... add_preempt_count+0x1c/0x20
 .....[<c014b0d7>] ..   ( <= print_traces+0x17/0x60)

 ------------------------------
 | showing all locks held by: |  (kstopmachine/14814 [ee9226a0,   0]):
 ------------------------------

 BUG: scheduling with irqs disabled: kstopmachine/0x00000000/14814
 caller is do_stop+0x3c/0x80
  [<c0104693>] dump_stack+0x23/0x30 (20)
  [<c036defc>] schedule+0xac/0x120 (28)
  [<c0153e2c>] do_stop+0x3c/0x80 (20)
  [<c013f426>] kthread+0xb6/0xf0 (48)
  [<c01015f9>] kernel_thread_helper+0x5/0xc (288305180)
 ---------------------------
 | preempt count: 00000001 ]
 | 1-level deep critical section nesting:
 ----------------------------------------
 .. [<c0149d2c>] .... add_preempt_count+0x1c/0x20
 .....[<c014b0d7>] ..   ( <= print_traces+0x17/0x60)

 ------------------------------
 | showing all locks held by: |  (kstopmachine/14814 [ee9226a0,   0]):
 ------------------------------

 CPU 1 is now offline
 bash/14800[CPU#0]: BUG in dec_rt_tasks at kernel/sched.c:647
  [<c0104693>] dump_stack+0x23/0x30 (20)
  [<c0128473>] __WARN_ON+0x63/0x80 (44)
  [<c011e01d>] dequeue_task+0x8d/0xa0 (28)
  [<c011e4c4>] deactivate_task+0x24/0x40 (20)
  [<c0123441>] migration_call+0xe1/0x2e0 (44)
  [<c0136ad5>] notifier_call_chain+0x25/0x40 (32)
  [<c014c40c>] cpu_down+0x18c/0x2d0 (52)
  [<c028194f>] store_online+0x3f/0xa0 (24)
  [<c027e533>] sysdev_store+0x33/0x40 (20)
  [<c01b5a67>] flush_write_buffer+0x47/0x50 (32)
  [<c01b5ac9>] sysfs_write_file+0x59/0x80 (32)
  [<c0177d52>] vfs_write+0xe2/0x1b0 (40)
  [<c0177ef0>] sys_write+0x50/0x80 (44)
  [<c0103698>] sysenter_past_esp+0x61/0x89 (-4020)
 ---------------------------
 | preempt count: 00000003 ]
 | 3-level deep critical section nesting:
 ----------------------------------------
 .. [<c0149d2c>] .... add_preempt_count+0x1c/0x20
 .....[<c0154632>] ..   ( <= __do_IRQ+0xe2/0x170)
 .. [<c0149d2c>] .... add_preempt_count+0x1c/0x20
 .....[<c0119c26>] ..   ( <= unmask_IO_APIC_irq+0x16/0x50)
 .. [<c0149d2c>] .... add_preempt_count+0x1c/0x20
 .....[<c014b0d7>] ..   ( <= print_traces+0x17/0x60)

 ------------------------------
 | showing all locks held by: |  (bash/14800 [ee044660, 115]):
 ------------------------------

 #001:             [eaff1078] {(struct semaphore *)(&buffer->sem)}
 ... acquired at:               sysfs_write_file+0x27/0x80

 #002:             [c03d0204] {cpucontrol.lock}
 ... acquired at:               cpu_down+0x21/0x2d0


and a shitload of smp_processor_id in preemptible section thingies.
And as expected getting the cpu back online didn't work :-)

I haven't looked at these traces yet; but since I am writing this email
anyway I might as well include them.

Kind regards,

Peter Zijlstra

--=-gAHbMUblxpcsNZt5EuRx
Content-Disposition: attachment; filename=linux-2.6.13-rc4-RT-V0.7.52-02_fixups.diff
Content-Type: text/x-patch; name=linux-2.6.13-rc4-RT-V0.7.52-02_fixups.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

 kernel: BUG: scheduling with irqs disabled: uname/0x20000000/983
 kernel: caller is __down_mutex+0x446/0x600
 kernel:  [<c0104693>] dump_stack+0x23/0x30 (20)
 kernel:  [<c036defc>] schedule+0xac/0x120 (28)
 kernel:  [<c036f086>] __down_mutex+0x446/0x600 (120)
 kernel:  [<c0370888>] _spin_lock+0x28/0x50 (28)
 kernel:  [<c0292df4>] cfq_exit_single_io_context+0x34/0xc0 (32)
 kernel:  [<c0292ebc>] cfq_exit_io_context+0x3c/0x50 (24)
 kernel:  [<c028975c>] exit_io_context+0x8c/0xb0 (24)
 kernel:  [<c012ac41>] do_exit+0x411/0x460 (44)
 kernel:  [<c012ad2e>] do_group_exit+0x3e/0xd0 (40)
 kernel:  [<c012adda>] sys_exit_group+0x1a/0x20 (12)
 kernel:  [<c0103698>] sysenter_past_esp+0x61/0x89 (-4020)
 kernel: ---------------------------
 kernel: | preempt count: 20000001 ]
 kernel: | 1-level deep critical section nesting:
 kernel: ----------------------------------------
 kernel: .. [<c0149d2c>] .... add_preempt_count+0x1c/0x20
 kernel: .....[<c014b0d7>] ..   ( <= print_traces+0x17/0x60)
 kernel:
 kernel: ------------------------------
 kernel: | showing all locks held by: |  (uname/983 [ee9fa720, 114]):
 kernel: ------------------------------
 kernel:

--- linux-2.6.13-rc4-RT-V0.7.52-02/drivers/block/cfq-iosched.c~	2005-07-30 20:45:57.000000000 +0200
+++ linux-2.6.13-rc4-RT-V0.7.52-02/drivers/block/cfq-iosched.c	2005-07-31 09:38:35.000000000 +0200
@@ -1376,7 +1376,7 @@
 	struct cfq_data *cfqd = cic->cfqq->cfqd;
 	request_queue_t *q = cfqd->queue;
 
-	WARN_ON(!irqs_disabled());
+	WARN_ON_NONRT(!irqs_disabled());
 
 	spin_lock(q->queue_lock);
 
@@ -1400,7 +1400,7 @@
 	struct list_head *entry;
 	unsigned long flags;
 
-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 
 	/*
 	 * put the reference this task is holding to the various queues
@@ -1411,7 +1411,7 @@
 	}
 
 	cfq_exit_single_io_context(cic);
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 }
 
 static struct cfq_io_context *

--=-gAHbMUblxpcsNZt5EuRx--

