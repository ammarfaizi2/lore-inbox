Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317022AbSHJPVy>; Sat, 10 Aug 2002 11:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317024AbSHJPVy>; Sat, 10 Aug 2002 11:21:54 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:28942 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S317022AbSHJPVw>; Sat, 10 Aug 2002 11:21:52 -0400
Date: Sat, 10 Aug 2002 19:25:15 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>,
       Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5.30] alpha: IPI update [2/10]
Message-ID: <20020810192515.A20534@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- send_ipi_message() fix from Jeff Wiedemeier:
  The 2.5.30 IPI algorithm (with the to_whom == set test) incorrectly sends
  IPI messages to CPU 0 in a SMP system running with one processor. In this
  case to_whom is often 0 (cpu_present_mask & ~1UL << smp_processor_id()) which
  ends up triggering the to_whom == set case.
- migration IPI removed;

Ivan.

--- 2.5.30/arch/alpha/kernel/smp.c	Fri Aug  2 01:16:16 2002
+++ linux/arch/alpha/kernel/smp.c	Thu Aug  8 19:45:19 2002
@@ -62,7 +63,6 @@ static struct {
 
 enum ipi_message_type {
 	IPI_RESCHEDULE,
-	IPI_MIGRATION,
 	IPI_CALL_FUNC,
 	IPI_CPU_STOP,
 };
@@ -668,33 +658,21 @@ send_ipi_message(unsigned long to_whom, 
 {
 	unsigned long i, set, n;
 
-	set = to_whom & -to_whom;
-	if (to_whom == set) {
+	mb();
+	for (i = to_whom; i ; i &= ~set) {
+		set = i & -i;
 		n = __ffs(set);
-		mb();
 		set_bit(operation, &ipi_data[n].bits);
-		mb();
-		wripir(n);
-	} else {
-		mb();
-		for (i = to_whom; i ; i &= ~set) {
-			set = i & -i;
-			n = __ffs(set);
-			set_bit(operation, &ipi_data[n].bits);
-		}
+	}
 
-		mb();
-		for (i = to_whom; i ; i &= ~set) {
-			set = i & -i;
-			n = __ffs(set);
-			wripir(n);
-		}
+	mb();
+	for (i = to_whom; i ; i &= ~set) {
+		set = i & -i;
+		n = __ffs(set);
+		wripir(n);
 	}
 }
 
-/* Data for IPI_MIGRATION.  */
-static task_t *migration_task;
-
 /* Structure and data for smp_call_function.  This is designed to 
    minimize static memory requirements.  Plus it looks cleaner.  */
 
@@ -768,15 +746,6 @@ handle_ipi(struct pt_regs *regs)
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
@@ -835,19 +804,6 @@ smp_send_reschedule(int cpu)
 }
 
 void
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
-}
-
-void
 smp_send_stop(void)
 {
 	unsigned long to_whom = cpu_present_mask & ~(1UL << smp_processor_id());
