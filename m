Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262935AbTCKOmV>; Tue, 11 Mar 2003 09:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262936AbTCKOmV>; Tue, 11 Mar 2003 09:42:21 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:58375 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S262935AbTCKOmT>;
	Tue, 11 Mar 2003 09:42:19 -0500
Date: Tue, 11 Mar 2003 17:02:49 +0300
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] kernel/rcupdate.c microcleanup
Message-ID: <20030311140249.GB756@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

attached patch (2.5.64) contains small cleanup of RCU code:
    - move smp_processor_id() outside of irq disabled region in call_rcu();
    - consolidate multiple spin_unlock() in the rcu_check_quiescent_state(),
      remove some unneeded {} and make this function inline.

Tested and works (at least doesn't crash). Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-rcu

diff -urN -X /usr/share/dontdiff linux-2.5.64.vanilla/kernel/rcupdate.c linux-2.5.64/kernel/rcupdate.c
--- linux-2.5.64.vanilla/kernel/rcupdate.c	Thu Nov 28 01:35:46 2002
+++ linux-2.5.64/kernel/rcupdate.c	Mon Mar 10 20:18:48 2003
@@ -67,13 +67,12 @@
  */
 void call_rcu(struct rcu_head *head, void (*func)(void *arg), void *arg)
 {
-	int cpu;
+	int cpu = smp_processor_id();
 	unsigned long flags;
 
 	head->func = func;
 	head->arg = arg;
 	local_irq_save(flags);
-	cpu = smp_processor_id();
 	list_add_tail(&head->list, &RCU_nxtlist(cpu));
 	local_irq_restore(flags);
 }
@@ -117,13 +116,12 @@
  * switch). If so and if it already hasn't done so in this RCU
  * quiescent cycle, then indicate that it has done so.
  */
-static void rcu_check_quiescent_state(void)
+static inline void rcu_check_quiescent_state(void)
 {
 	int cpu = smp_processor_id();
 
-	if (!test_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask)) {
+	if (!test_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask))
 		return;
-	}
 
 	/* 
 	 * Races with local timer interrupt - in the worst case
@@ -134,23 +132,22 @@
 		RCU_last_qsctr(cpu) = RCU_qsctr(cpu);
 		return;
 	}
-	if (RCU_qsctr(cpu) == RCU_last_qsctr(cpu)) {
+	if (RCU_qsctr(cpu) == RCU_last_qsctr(cpu))
 		return;
-	}
 
 	spin_lock(&rcu_ctrlblk.mutex);
-	if (!test_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask)) {
-		spin_unlock(&rcu_ctrlblk.mutex);
-		return;
-	}
+	if (!test_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask))
+		goto out_unlock;
+
 	clear_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask);
 	RCU_last_qsctr(cpu) = RCU_QSCTR_INVALID;
-	if (rcu_ctrlblk.rcu_cpu_mask != 0) {
-		spin_unlock(&rcu_ctrlblk.mutex);
-		return;
-	}
+	if (rcu_ctrlblk.rcu_cpu_mask != 0)
+		goto out_unlock;
+
 	rcu_ctrlblk.curbatch++;
 	rcu_start_batch(rcu_ctrlblk.maxbatch);
+
+out_unlock:
 	spin_unlock(&rcu_ctrlblk.mutex);
 }
 

--ADZbWkCsHQ7r3kzd--
