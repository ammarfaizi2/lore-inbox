Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWAYSto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWAYSto (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 13:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWAYSto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 13:49:44 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:13227 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932094AbWAYStn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 13:49:43 -0500
Date: Wed, 25 Jan 2006 19:50:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: [patch, lock validator] rcu_torture_lock deadlock fix
Message-ID: <20060125185012.GA24258@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_torture_lock is used in a softirq-unsafe manner, but it is also
taken by rcu_torture_cb(), which may execute in softirq-context,
resulting in potential deadlocks.

this bug was found by the lock-validator:

  ============================
  [ BUG: illegal lock usage! ]
  ----------------------------
  illegal {enabled-softirqs} -> {used-in-softirq} usage.
  swapper/0 [HC0[0]:SC1[2]:HE1:SE0] takes {rcu_torture_lock [u:25]}, at:
   [<c014dab3>] rcu_torture_cb+0x49/0x7e
  {enabled-softirqs} state was registered at:
   [<c01269a0>] copy_process+0x25d/0xed5
  hardirqs last enabled at: [<c0137a7a>] __rcu_process_callbacks+0x5f/0x14a
  softirqs last enabled at: [<c012ce90>] irq_exit+0x36/0x38
  
  other info that might help in debugging this:
  ------------------------------
  | showing all locks held by: |  (swapper/0 [f7c06750, 140]): <none>
  ------------------------------
  
   [<c0103e82>] show_trace+0xd/0xf
   [<c0103e99>] dump_stack+0x15/0x17
   [<c013e581>] print_usage_bug+0x176/0x181
   [<c013ea58>] mark_lock+0x9b/0x22b
   [<c013efa2>] debug_lock_chain+0x3ba/0xd0c
   [<c013f925>] debug_lock_chain_spin+0x31/0x48
   [<c041076e>] _raw_spin_lock+0x34/0x7f
   [<c0d29435>] _spin_lock+0x8/0xa
   [<c014dab3>] rcu_torture_cb+0x49/0x7e
   [<c0137b1f>] __rcu_process_callbacks+0x104/0x14a
   [<c0137e33>] rcu_process_callbacks+0x26/0x3f
   [<c012cfc4>] tasklet_action+0x64/0xc8
   [<c012d174>] __do_softirq+0x84/0xff
   [<c0104d72>] do_softirq+0x52/0xbb
   =======================
   [<c012ce90>] irq_exit+0x36/0x38
   [<c0118809>] smp_apic_timer_interrupt+0x4e/0x51
   [<c010376b>] apic_timer_interrupt+0x27/0x2c
   [<c0101b4f>] cpu_idle+0x9a/0xb3
   [<c0117d1e>] start_secondary+0x3c3/0x3cb
   [<00000000>] 0x0
   [<f7c07fb4>] 0xf7c07fb4

the fix is to acquire rcu_torture_lock in a softirq-safe manner.
With this fix applied, the rcu-torture code passes validation.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 kernel/rcutorture.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: linux/kernel/rcutorture.c
===================================================================
--- linux.orig/kernel/rcutorture.c
+++ linux/kernel/rcutorture.c
@@ -114,16 +114,16 @@ rcu_torture_alloc(void)
 {
 	struct list_head *p;
 
-	spin_lock(&rcu_torture_lock);
+	spin_lock_bh(&rcu_torture_lock);
 	if (list_empty(&rcu_torture_freelist)) {
 		atomic_inc(&n_rcu_torture_alloc_fail);
-		spin_unlock(&rcu_torture_lock);
+		spin_unlock_bh(&rcu_torture_lock);
 		return NULL;
 	}
 	atomic_inc(&n_rcu_torture_alloc);
 	p = rcu_torture_freelist.next;
 	list_del_init(p);
-	spin_unlock(&rcu_torture_lock);
+	spin_unlock_bh(&rcu_torture_lock);
 	return container_of(p, struct rcu_torture, rtort_free);
 }
 
@@ -134,9 +134,9 @@ static void
 rcu_torture_free(struct rcu_torture *p)
 {
 	atomic_inc(&n_rcu_torture_free);
-	spin_lock(&rcu_torture_lock);
+	spin_lock_bh(&rcu_torture_lock);
 	list_add_tail(&p->rtort_free, &rcu_torture_freelist);
-	spin_unlock(&rcu_torture_lock);
+	spin_unlock_bh(&rcu_torture_lock);
 }
 
 static void
