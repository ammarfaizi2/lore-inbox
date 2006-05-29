Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWE2VWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWE2VWg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWE2VWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:22:36 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:48055 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751312AbWE2VWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:22:35 -0400
Date: Mon, 29 May 2006 23:22:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 01/61] lock validator: floppy.c irq-release fix
Message-ID: <20060529212256.GA3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
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

From: Ingo Molnar <mingo@elte.hu>

floppy.c does alot of irq-unsafe work within floppy_release_irq_and_dma():
free_irq(), release_region() ... so when executing in irq context, push
the whole function into keventd.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/block/floppy.c |   27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

Index: linux/drivers/block/floppy.c
===================================================================
--- linux.orig/drivers/block/floppy.c
+++ linux/drivers/block/floppy.c
@@ -573,6 +573,21 @@ static int floppy_grab_irq_and_dma(void)
 static void floppy_release_irq_and_dma(void);
 
 /*
+ * Interrupt, DMA and region freeing must not be done from IRQ
+ * context - e.g. irq-unregistration means /proc VFS work, region
+ * release takes an irq-unsafe lock, etc. So we push this work
+ * into keventd:
+ */
+static void fd_release_fn(void *data)
+{
+	mutex_lock(&open_lock);
+	floppy_release_irq_and_dma();
+	mutex_unlock(&open_lock);
+}
+
+static DECLARE_WORK(floppy_release_irq_and_dma_work, fd_release_fn, NULL);
+
+/*
  * The "reset" variable should be tested whenever an interrupt is scheduled,
  * after the commands have been sent. This is to ensure that the driver doesn't
  * get wedged when the interrupt doesn't come because of a failed command.
@@ -836,7 +851,7 @@ static int set_dor(int fdc, char mask, c
 	if (newdor & FLOPPY_MOTOR_MASK)
 		floppy_grab_irq_and_dma();
 	if (olddor & FLOPPY_MOTOR_MASK)
-		floppy_release_irq_and_dma();
+		schedule_work(&floppy_release_irq_and_dma_work);
 	return olddor;
 }
 
@@ -917,6 +932,8 @@ static int _lock_fdc(int drive, int inte
 
 		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&fdc_wait, &wait);
+
+		flush_scheduled_work();
 	}
 	command_status = FD_COMMAND_NONE;
 
@@ -950,7 +967,7 @@ static inline void unlock_fdc(void)
 	if (elv_next_request(floppy_queue))
 		do_fd_request(floppy_queue);
 	spin_unlock_irqrestore(&floppy_lock, flags);
-	floppy_release_irq_and_dma();
+	schedule_work(&floppy_release_irq_and_dma_work);
 	wake_up(&fdc_wait);
 }
 
@@ -4647,6 +4664,12 @@ void cleanup_module(void)
 	del_timer_sync(&fd_timer);
 	blk_cleanup_queue(floppy_queue);
 
+	/*
+	 * Wait for any asynchronous floppy_release_irq_and_dma()
+	 * calls to finish first:
+	 */
+	flush_scheduled_work();
+
 	if (usage_count)
 		floppy_release_irq_and_dma();
 
