Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263809AbTEODbd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbTEODWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:22:41 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:23020 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263810AbTEODSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:25 -0400
Date: Thu, 15 May 2003 04:31:13 +0100
Message-Id: <200305150331.h4F3VDIJ000712@deviant.impure.org.uk>
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Shorten rcu_check_quiescent_state.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Single spin_unlock path cuts this down a little..

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/kernel/rcupdate.c linux-2.5/kernel/rcupdate.c
--- bk-linus/kernel/rcupdate.c	2003-04-10 06:01:42.000000000 +0100
+++ linux-2.5/kernel/rcupdate.c	2003-04-03 06:02:38.000000000 +0100
@@ -121,9 +121,8 @@ static void rcu_check_quiescent_state(vo
 {
 	int cpu = smp_processor_id();
 
-	if (!test_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask)) {
+	if (!test_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask))
 		return;
-	}
 
 	/* 
 	 * Races with local timer interrupt - in the worst case
@@ -134,23 +133,22 @@ static void rcu_check_quiescent_state(vo
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
 
