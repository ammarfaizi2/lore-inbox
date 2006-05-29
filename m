Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWE2ViG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWE2ViG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWE2VZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:25:19 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:42194 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751338AbWE2VYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:24:32 -0400
Date: Mon, 29 May 2006 23:24:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 21/61] lock validator: lockdep: add local_irq_enable_in_hardirq() API.
Message-ID: <20060529212452.GU3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

introduce local_irq_enable_in_hardirq() API. It is currently
aliased to local_irq_enable(), hence has no functional effects.

This API will be used by lockdep, but even without lockdep
this will better document places in the kernel where a hardirq
context enables hardirqs.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/i386/kernel/nmi.c         |    3 ++-
 arch/x86_64/kernel/nmi.c       |    3 ++-
 drivers/ide/ide-io.c           |    6 +++---
 drivers/ide/ide-taskfile.c     |    2 +-
 include/linux/ide.h            |    2 +-
 include/linux/trace_irqflags.h |    2 ++
 kernel/irq/handle.c            |    2 +-
 7 files changed, 12 insertions(+), 8 deletions(-)

Index: linux/arch/i386/kernel/nmi.c
===================================================================
--- linux.orig/arch/i386/kernel/nmi.c
+++ linux/arch/i386/kernel/nmi.c
@@ -188,7 +188,8 @@ static __cpuinit inline int nmi_known_cp
 static __init void nmi_cpu_busy(void *data)
 {
 	volatile int *endflag = data;
-	local_irq_enable();
+
+	local_irq_enable_in_hardirq();
 	/* Intentionally don't use cpu_relax here. This is
 	   to make sure that the performance counter really ticks,
 	   even if there is a simulator or similar that catches the
Index: linux/arch/x86_64/kernel/nmi.c
===================================================================
--- linux.orig/arch/x86_64/kernel/nmi.c
+++ linux/arch/x86_64/kernel/nmi.c
@@ -186,7 +186,8 @@ void nmi_watchdog_default(void)
 static __init void nmi_cpu_busy(void *data)
 {
 	volatile int *endflag = data;
-	local_irq_enable();
+
+	local_irq_enable_in_hardirq();
 	/* Intentionally don't use cpu_relax here. This is
 	   to make sure that the performance counter really ticks,
 	   even if there is a simulator or similar that catches the
Index: linux/drivers/ide/ide-io.c
===================================================================
--- linux.orig/drivers/ide/ide-io.c
+++ linux/drivers/ide/ide-io.c
@@ -689,7 +689,7 @@ static ide_startstop_t drive_cmd_intr (i
 	u8 stat = hwif->INB(IDE_STATUS_REG);
 	int retries = 10;
 
-	local_irq_enable();
+	local_irq_enable_in_hardirq();
 	if ((stat & DRQ_STAT) && args && args[3]) {
 		u8 io_32bit = drive->io_32bit;
 		drive->io_32bit = 0;
@@ -1273,7 +1273,7 @@ static void ide_do_request (ide_hwgroup_
 		if (masked_irq != IDE_NO_IRQ && hwif->irq != masked_irq)
 			disable_irq_nosync(hwif->irq);
 		spin_unlock(&ide_lock);
-		local_irq_enable();
+		local_irq_enable_in_hardirq();
 			/* allow other IRQs while we start this request */
 		startstop = start_request(drive, rq);
 		spin_lock_irq(&ide_lock);
@@ -1622,7 +1622,7 @@ irqreturn_t ide_intr (int irq, void *dev
 	spin_unlock(&ide_lock);
 
 	if (drive->unmask)
-		local_irq_enable();
+		local_irq_enable_in_hardirq();
 	/* service this interrupt, may set handler for next interrupt */
 	startstop = handler(drive);
 	spin_lock_irq(&ide_lock);
Index: linux/drivers/ide/ide-taskfile.c
===================================================================
--- linux.orig/drivers/ide/ide-taskfile.c
+++ linux/drivers/ide/ide-taskfile.c
@@ -223,7 +223,7 @@ ide_startstop_t task_no_data_intr (ide_d
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 stat;
 
-	local_irq_enable();
+	local_irq_enable_in_hardirq();
 	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),READY_STAT,BAD_STAT)) {
 		return ide_error(drive, "task_no_data_intr", stat);
 		/* calls ide_end_drive_cmd */
Index: linux/include/linux/ide.h
===================================================================
--- linux.orig/include/linux/ide.h
+++ linux/include/linux/ide.h
@@ -1361,7 +1361,7 @@ extern struct semaphore ide_cfg_sem;
  * ide_drive_t->hwif: constant, no locking
  */
 
-#define local_irq_set(flags)	do { local_save_flags((flags)); local_irq_enable(); } while (0)
+#define local_irq_set(flags)	do { local_save_flags((flags)); local_irq_enable_in_hardirq(); } while (0)
 
 extern struct bus_type ide_bus_type;
 
Index: linux/include/linux/trace_irqflags.h
===================================================================
--- linux.orig/include/linux/trace_irqflags.h
+++ linux/include/linux/trace_irqflags.h
@@ -66,6 +66,8 @@
 		}						\
 	} while (0)
 
+#define local_irq_enable_in_hardirq()	local_irq_enable()
+
 #define safe_halt()						\
 	do {							\
 		trace_hardirqs_on();				\
Index: linux/kernel/irq/handle.c
===================================================================
--- linux.orig/kernel/irq/handle.c
+++ linux/kernel/irq/handle.c
@@ -83,7 +83,7 @@ fastcall irqreturn_t handle_IRQ_event(un
 	unsigned int status = 0;
 
 	if (!(action->flags & SA_INTERRUPT))
-		local_irq_enable();
+		local_irq_enable_in_hardirq();
 
 	do {
 		ret = action->handler(irq, action->dev_id, regs);
