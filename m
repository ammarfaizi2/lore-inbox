Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312415AbSCURV5>; Thu, 21 Mar 2002 12:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312418AbSCURVr>; Thu, 21 Mar 2002 12:21:47 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:8323 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S312406AbSCURVU>; Thu, 21 Mar 2002 12:21:20 -0500
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel@vger.kernel.org
cc: linux-alpha@vger.kernel.org
Subject: [PATCH] Needed to get 2.5.7 to compile and link on Alpha [8/10]
Message-Id: <E16o6CB-0005OK-00@lightning.hereintown.net>
Date: Thu, 21 Mar 2002 12:17:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have no idea if this is right.  I'll have to look more into the patch
where sched_task_migration was removed from sched.h.  I just killed all
the migration code from smp.c.  Hey, it links.

-Chris


--- linux-2.5.7/arch/alpha/kernel/smp.c~	Mon Mar 18 15:37:09 2002
+++ linux-2.5.7/arch/alpha/kernel/smp.c	Thu Mar 21 06:11:37 2002
@@ -62,7 +62,6 @@
 
 enum ipi_message_type {
 	IPI_RESCHEDULE,
-	IPI_MIGRATION,
 	IPI_CALL_FUNC,
 	IPI_CPU_STOP,
 };
@@ -695,9 +694,6 @@
 	}
 }
 
-/* Data for IPI_MIGRATION.  */
-static task_t *migration_task;
-
 /* Structure and data for smp_call_function.  This is designed to 
    minimize static memory requirements.  Plus it looks cleaner.  */
 
@@ -771,15 +767,6 @@
 			   is done by the interrupt return path.  */
 			break;
 
-		case IPI_MIGRATION:
-		    {
-			task_t *t = migration_task;
-			mb();
-			migration_task = 0;
-			sched_task_migrated(t);
-			break;
-		    }
-
 		case IPI_CALL_FUNC:
 		    {
 			struct smp_call_struct *data;
@@ -835,19 +822,6 @@
 		       "smp_send_reschedule: Sending IPI to self.\n");
 #endif
 	send_ipi_message(1UL << cpu, IPI_RESCHEDULE);
-}
-
-void
-smp_migrate_task(int cpu, task_t *t)
-{
-#if DEBUG_IPI_MSG
-	if (cpu == hard_smp_processor_id())
-		printk(KERN_WARNING
-		       "smp_migrate_task: Sending IPI to self.\n");
-#endif
-	/* Acquire the migration_task mutex.  */
-	pointer_lock(&migration_task, t, 1);
-	send_ipi_message(1UL << cpu, IPI_MIGRATION);
 }
 
 void
