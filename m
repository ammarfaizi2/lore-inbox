Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266185AbUGZXoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266185AbUGZXoL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 19:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266187AbUGZXoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 19:44:10 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:55257 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266185AbUGZXoE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 19:44:04 -0400
Subject: [PATCH] fixes for rcu_offline_cpu, rcu_move_batch (2.6.8-rc2)
From: Nathan Lynch <nathanl@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1090870667.22306.40.camel@pants.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Jul 2004 14:37:47 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

rcu_offline_cpu and rcu_move_batch have been broken since the
list_head's in struct rcu_head and struct rcu_data were replaced with
singly-linked lists:

  CC      kernel/rcupdate.o
kernel/rcupdate.c: In function `rcu_move_batch':
kernel/rcupdate.c:222: warning: passing arg 2 of `list_add_tail' from
incompatible pointer type
kernel/rcupdate.c: In function `rcu_offline_cpu':
kernel/rcupdate.c:239: warning: passing arg 1 of `rcu_move_batch' from
incompatible pointer type
kernel/rcupdate.c:240: warning: passing arg 1 of `rcu_move_batch' from
incompatible pointer type
kernel/rcupdate.c:236: warning: label `unlock' defined but not used

Kernel crashes when you try to offline a cpu, not surprisingly.

It also looks like rcu_move_batch isn't preempt-safe so I touched that
up, and got rid of an unused label in rcu_offline_cpu.

This fixes the crash for me; does it look ok?


Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>

diff -prauNX /home/nathanl/working/dontdiff 2.6.8-rc2/kernel/rcupdate.c 2.6.8-rc2-ntl/kernel/rcupdate.c
--- 2.6.8-rc2/kernel/rcupdate.c	2004-07-23 19:58:35.000000000 -0500
+++ 2.6.8-rc2-ntl/kernel/rcupdate.c	2004-07-26 13:41:15.000000000 -0500
@@ -210,16 +210,18 @@ static void rcu_check_quiescent_state(vo
  * locking requirements, the list it's pulling from has to belong to a cpu
  * which is dead and hence not processing interrupts.
  */
-static void rcu_move_batch(struct list_head *list)
+static void rcu_move_batch(struct rcu_head *list)
 {
-	struct list_head *entry;
-	int cpu = smp_processor_id();
+	int cpu;
 
 	local_irq_disable();
-	while (!list_empty(list)) {
-		entry = list->next;
-		list_del(entry);
-		list_add_tail(entry, &RCU_nxtlist(cpu));
+
+	cpu = smp_processor_id();
+
+	while (list != NULL) {
+		*RCU_nxttail(cpu) = list;
+		RCU_nxttail(cpu) = &list->next;
+		list = list->next;
 	}
 	local_irq_enable();
 }
@@ -233,11 +235,10 @@ static void rcu_offline_cpu(int cpu)
 	spin_lock_bh(&rcu_state.mutex);
 	if (rcu_ctrlblk.cur != rcu_ctrlblk.completed)
 		cpu_quiet(cpu);
-unlock:
 	spin_unlock_bh(&rcu_state.mutex);
 
-	rcu_move_batch(&RCU_curlist(cpu));
-	rcu_move_batch(&RCU_nxtlist(cpu));
+	rcu_move_batch(RCU_curlist(cpu));
+	rcu_move_batch(RCU_nxtlist(cpu));
 
 	tasklet_kill_immediate(&RCU_tasklet(cpu), cpu);
 }


