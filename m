Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265782AbUGTLVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265782AbUGTLVO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 07:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUGTLVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 07:21:13 -0400
Received: from aun.it.uu.se ([130.238.12.36]:49656 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265782AbUGTLVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 07:21:07 -0400
Date: Tue, 20 Jul 2004 13:20:58 +0200 (MEST)
Message-Id: <200407201120.i6KBKwWG021608@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.8-rc1-mm1] perfctr inheritance illegal sleep bug
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

This patch fixes a "might sleep in illegal context" error in
the per-process performance counter inheritance changes I
sent a few days ago. The write_lock_irq() in release_task()
interferes with semaphore operations potentially done as a
side-effect of freeing the task's perfctr state object.
The fix is to do the final freeing via schedule_work().

CONFIG_DEBUG_SPINLOCK_SLEEP detects the error fairly quickly.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/virtual.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletion(-)

diff -ruN linux-2.6.8-rc1-mm1/drivers/perfctr/virtual.c linux-2.6.8-rc1-mm1.mightsleep-fix/drivers/perfctr/virtual.c
--- linux-2.6.8-rc1-mm1/drivers/perfctr/virtual.c	2004-07-19 18:43:59.822750000 +0200
+++ linux-2.6.8-rc1-mm1.mightsleep-fix/drivers/perfctr/virtual.c	2004-07-19 18:43:38.172750000 +0200
@@ -45,6 +45,7 @@
 	/* protected by task_lock(owner) */
 	unsigned long long inheritance_id;
 	struct perfctr_sum_ctrs children;
+	struct work_struct free_work;
 };
 #define IS_RUNNING(perfctr)	perfctr_cstatus_enabled((perfctr)->cpu_state.cstatus)
 
@@ -160,6 +161,19 @@
 		vperfctr_free(perfctr);
 }
 
+static void scheduled_vperfctr_free(void *perfctr)
+{
+	vperfctr_free((struct vperfctr*)perfctr);
+}
+
+static void schedule_put_vperfctr(struct vperfctr *perfctr)
+{
+	if (!atomic_dec_and_test(&perfctr->count))
+		return;
+	INIT_WORK(&perfctr->free_work, scheduled_vperfctr_free, perfctr);
+	schedule_work(&perfctr->free_work);
+}
+
 static unsigned long long new_inheritance_id(void)
 {
 	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
@@ -383,7 +397,7 @@
 	}
 	task_unlock(parent_tsk);
 	child_tsk->thread.perfctr = NULL;
-	put_vperfctr(child_perfctr);
+	schedule_put_vperfctr(child_perfctr);
 }
 
 /* schedule() --> switch_to() --> .. --> __vperfctr_suspend().
