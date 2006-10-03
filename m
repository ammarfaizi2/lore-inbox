Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbWJCP4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWJCP4v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 11:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWJCP4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 11:56:50 -0400
Received: from homer.mvista.com ([63.81.120.158]:64309 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1030252AbWJCP4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 11:56:49 -0400
Message-Id: <20061003155358.756788000@dwalker1.mvista.com>
User-Agent: quilt/0.45-1
Date: Tue, 03 Oct 2006 08:53:58 -0700
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org
Cc: tglx@linutronix.de
Cc: mgreer@mvista.com
Cc: sshtylyov@ru.mvista.com
Subject: [PATCH -rt] powerpc update
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This updates arch/powerpc/ so that it boots PREEMPT_RT on a Apple 
G4 PowerBook. It should also get other powerpc boards functional to
some extent. 

Pay close attention to the fasteoi interrupt threading. I added usage 
of mask/unmask instead of using level handling, which worked well on PPC.

There is still a todo to update highmems kmap_atomic() for realtime. 
So don't turn on highmem. 

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 arch/powerpc/Kconfig.debug         |    4 ++++
 arch/powerpc/kernel/idle.c         |    2 +-
 drivers/macintosh/adb.c            |   13 +++++++------
 drivers/net/sungem.c               |    4 +---
 include/asm-powerpc/hw_irq.h       |    2 +-
 include/asm-powerpc/pmac_feature.h |    2 +-
 kernel/irq/chip.c                  |   17 +++++++++++------
 7 files changed, 26 insertions(+), 18 deletions(-)

Index: linux-2.6.18/arch/powerpc/Kconfig.debug
===================================================================
--- linux-2.6.18.orig/arch/powerpc/Kconfig.debug
+++ linux-2.6.18/arch/powerpc/Kconfig.debug
@@ -2,6 +2,10 @@ menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
 
+config TRACE_IRQFLAGS_SUPPORT
+	bool
+	default y
+
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL && PPC64
Index: linux-2.6.18/arch/powerpc/kernel/idle.c
===================================================================
--- linux-2.6.18.orig/arch/powerpc/kernel/idle.c
+++ linux-2.6.18/arch/powerpc/kernel/idle.c
@@ -82,7 +82,7 @@ void cpu_idle(void)
 		ppc64_runlatch_on();
 		if (cpu_should_die())
 			cpu_die();
-		preempt_enable_no_resched();
+		__preempt_enable_no_resched();
 		schedule();
 		preempt_disable();
 	}
Index: linux-2.6.18/drivers/macintosh/adb.c
===================================================================
--- linux-2.6.18.orig/drivers/macintosh/adb.c
+++ linux-2.6.18/drivers/macintosh/adb.c
@@ -256,6 +256,8 @@ adb_probe_task(void *x)
 	sigprocmask(SIG_BLOCK, &blocked, NULL);
 	flush_signals(current);
 
+	down(&adb_probe_mutex);
+
 	printk(KERN_INFO "adb: starting probe task...\n");
 	do_adb_reset_bus();
 	printk(KERN_INFO "adb: finished probe task...\n");
@@ -282,7 +284,9 @@ adb_reset_bus(void)
 		return 0;
 	}
 
-	down(&adb_probe_mutex);
+	if (adb_got_sleep)
+		return 0;
+
 	schedule_work(&adb_reset_work);
 	return 0;
 }
@@ -347,23 +351,21 @@ adb_notify_sleep(struct pmu_sleep_notifi
 	
 	switch (when) {
 	case PBOOK_SLEEP_REQUEST:
+		/* Signal to discontiue probing  */
 		adb_got_sleep = 1;
-		/* We need to get a lock on the probe thread */
-		down(&adb_probe_mutex);
 		/* Stop autopoll */
 		if (adb_controller->autopoll)
 			adb_controller->autopoll(0);
 		ret = blocking_notifier_call_chain(&adb_client_list,
 				ADB_MSG_POWERDOWN, NULL);
 		if (ret & NOTIFY_STOP_MASK) {
-			up(&adb_probe_mutex);
+			adb_got_sleep = 0;
 			return PBOOK_SLEEP_REFUSE;
 		}
 		break;
 	case PBOOK_SLEEP_REJECT:
 		if (adb_got_sleep) {
 			adb_got_sleep = 0;
-			up(&adb_probe_mutex);
 			adb_reset_bus();
 		}
 		break;
@@ -372,7 +374,6 @@ adb_notify_sleep(struct pmu_sleep_notifi
 		break;
 	case PBOOK_WAKE:
 		adb_got_sleep = 0;
-		up(&adb_probe_mutex);
 		adb_reset_bus();
 		break;
 	}
Index: linux-2.6.18/drivers/net/sungem.c
===================================================================
--- linux-2.6.18.orig/drivers/net/sungem.c
+++ linux-2.6.18/drivers/net/sungem.c
@@ -1037,10 +1037,8 @@ static int gem_start_xmit(struct sk_buff
 			(csum_stuff_off << 21));
 	}
 
-	local_irq_save(flags);
-	if (!spin_trylock(&gp->tx_lock)) {
+	if (!spin_trylock_irqsave(&gp->tx_lock, flags)) {
 		/* Tell upper layer to requeue */
-		local_irq_restore(flags);
 		return NETDEV_TX_LOCKED;
 	}
 	/* We raced with gem_do_stop() */
Index: linux-2.6.18/include/asm-powerpc/hw_irq.h
===================================================================
--- linux-2.6.18.orig/include/asm-powerpc/hw_irq.h
+++ linux-2.6.18/include/asm-powerpc/hw_irq.h
@@ -85,7 +85,7 @@ static inline void raw_local_irq_save_pt
 
 #endif /* CONFIG_PPC_ISERIES */
 
-#include <linux/trace_irqflags.h>
+#include <linux/irqflags.h>
 
 #define mask_irq(irq)						\
 	({							\
Index: linux-2.6.18/include/asm-powerpc/pmac_feature.h
===================================================================
--- linux-2.6.18.orig/include/asm-powerpc/pmac_feature.h
+++ linux-2.6.18/include/asm-powerpc/pmac_feature.h
@@ -378,7 +378,7 @@ extern struct macio_chip* macio_find(str
  * Those are exported by pmac feature for internal use by arch code
  * only like the platform function callbacks, do not use directly in drivers
  */
-extern spinlock_t feature_lock;
+extern raw_spinlock_t feature_lock;
 extern struct device_node *uninorth_node;
 extern u32 __iomem *uninorth_base;
 
Index: linux-2.6.18/kernel/irq/chip.c
===================================================================
--- linux-2.6.18.orig/kernel/irq/chip.c
+++ linux-2.6.18/kernel/irq/chip.c
@@ -386,13 +386,19 @@ handle_fasteoi_irq(unsigned int irq, str
 	}
 
 	desc->status |= IRQ_INPROGRESS;
-	/*
-	 * fasteoi should not be used for threaded IRQ handlers!
-	 */
+
 	if (redirect_hardirq(desc)) {
-		WARN_ON_ONCE(1);
-		goto out_unlock;
+		if (desc->chip->mask)
+			desc->chip->mask(irq);
+		else
+			/*
+			 * Threading on eoi chips w/o a mask/unmask is not
+			 * likely to work well.
+			 */
+			WARN_ON_ONCE(1);
+		goto out;
 	}
+
 	desc->status &= ~IRQ_PENDING;
 	spin_unlock(&desc->lock);
 
@@ -404,7 +410,6 @@ handle_fasteoi_irq(unsigned int irq, str
 	desc->status &= ~IRQ_INPROGRESS;
 out:
 	desc->chip->eoi(irq);
-out_unlock:
 	spin_unlock(&desc->lock);
 }
 
--
