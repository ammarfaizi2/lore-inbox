Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbVKYWBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbVKYWBJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 17:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbVKYWBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 17:01:09 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:37032 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751483AbVKYWBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 17:01:08 -0500
Date: Fri, 25 Nov 2005 14:01:17 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, levon@movementarian.org
Subject: Re: BUG: spinlock recursion on 2.6.14-mm2 when oprofiling
Message-ID: <20051125220117.GA1836@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051118152101.GA4690@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118152101.GA4690@mail.ustc.edu.cn>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 11:21:01PM +0800, Wu Fengguang wrote:
> [4300983.573000] BUG: spinlock recursion on CPU#0, sh/32089
> [4300983.573000]  lock: f8f46418, .magic: dead4ead, .owner: sh/32089, .owner_cpu: 0
> [4300983.573000]  [dump_stack+23/32] dump_stack+0x17/0x20
> [4300983.573000]  [spin_bug+134/144] spin_bug+0x86/0x90
> [4300983.573000]  [_raw_spin_lock+100/128] _raw_spin_lock+0x64/0x80
> [4300983.573000]  [_spin_lock+9/16] _spin_lock+0x9/0x10
> [4300983.573000]  [pg0+950630577/1068852224] task_free_notify+0x11/0x40 [oprofile]
> [4300983.573000]  [notifier_call_chain+28/64] notifier_call_chain+0x1c/0x40
> [4300983.573000]  [profile_handoff_task+30/64] profile_handoff_task+0x1e/0x40
> [4300983.575000]  [__put_task_struct+99/272] __put_task_struct+0x63/0x110
> [4300983.575000]  [__put_task_struct_cb+17/32] __put_task_struct_cb+0x11/0x20
> [4300983.575000]  [rcu_do_batch+28/112] rcu_do_batch+0x1c/0x70
> [4300983.575000]  [__rcu_process_callbacks+150/192] __rcu_process_callbacks+0x96/0xc0
> [4300983.575000]  [rcu_process_callbacks+46/96] rcu_process_callbacks+0x2e/0x60
> [4300983.575000]  [tasklet_action+113/208] tasklet_action+0x71/0xd0
> [4300983.575000]  [__do_softirq+216/240] __do_softirq+0xd8/0xf0
> [4300983.575000]  [do_softirq+56/64] do_softirq+0x38/0x40
> [4300983.575000]  [irq_exit+58/64] irq_exit+0x3a/0x40
> [4300983.575000]  [smp_apic_timer_interrupt+102/224] smp_apic_timer_interrupt+0x66/0xe0
> [4300983.575000]  [apic_timer_interrupt+28/48] apic_timer_interrupt+0x1c/0x30
> [4300983.575000]  [pg0+950632344/1068852224] mark_done+0x68/0x80 [oprofile]
> [4300983.576000]  [pg0+950632568/1068852224] sync_buffer+0xc8/0x172 [oprofile]
> [4300983.576000]  [pg0+950630643/1068852224] task_exit_notify+0x13/0x20 [oprofile]
> [4300983.576000]  [notifier_call_chain+28/64] notifier_call_chain+0x1c/0x40
> [4300983.576000]  [profile_task_exit+50/80] profile_task_exit+0x32/0x50
> [4300983.576000]  [do_exit+26/1040] do_exit+0x1a/0x410
> [4300983.576000]  [do_group_exit+51/176] do_group_exit+0x33/0xb0
> [4300983.576000]  [sys_exit_group+17/32] sys_exit_group+0x11/0x20
> [4300983.576000]  [syscall_call+7/11] syscall_call+0x7/0xb

Does the attached patch help?  (Andrew asked me to look into this.)
The patch disables irq while holding the task_mortuary lock, thus
avoiding the self-recursion via RCU callbacks.

One concern on the attached patch is the possible effect on latency.

John, any reason why the dead_tasks list cannot be spliced onto a
local list, then freed outside of the task_mortuary lock?  Any reason
why the dying_tasks list cannot be spliced onto the dead_tasks list
(an O(1) operation)?

							Thanx, Paul

Signed-off-by: <paulmck@us.ibm.com>

 buffer_sync.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff -urpNa -X dontdiff linux-2.6.14-mm2/drivers/oprofile/buffer_sync.c linux-2.6.14-mm2-fixmortuary/drivers/oprofile/buffer_sync.c
--- linux-2.6.14-mm2/drivers/oprofile/buffer_sync.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14-mm2-fixmortuary/drivers/oprofile/buffer_sync.c	2005-11-25 13:10:46.000000000 -0800
@@ -46,10 +46,11 @@ static void process_task_mortuary(void);
  */
 static int task_free_notify(struct notifier_block * self, unsigned long val, void * data)
 {
+	unsigned long flags;
 	struct task_struct * task = data;
-	spin_lock(&task_mortuary);
+	spin_lock_irqsave(&task_mortuary, flags);
 	list_add(&task->tasks, &dying_tasks);
-	spin_unlock(&task_mortuary);
+	spin_unlock_irqrestore(&task_mortuary, flags);
 	return NOTIFY_OK;
 }
 
@@ -431,11 +432,12 @@ static void increment_tail(struct oprofi
  */
 static void process_task_mortuary(void)
 {
+	unsigned long flags;
 	struct list_head * pos;
 	struct list_head * pos2;
 	struct task_struct * task;
 
-	spin_lock(&task_mortuary);
+	spin_lock_irqsave(&task_mortuary, flags);
 
 	list_for_each_safe(pos, pos2, &dead_tasks) {
 		task = list_entry(pos, struct task_struct, tasks);
@@ -449,7 +451,7 @@ static void process_task_mortuary(void)
 		list_add_tail(&task->tasks, &dead_tasks);
 	}
 
-	spin_unlock(&task_mortuary);
+	spin_unlock_irqrestore(&task_mortuary, flags);
 }
 
 
