Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbWA1QCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWA1QCA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 11:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbWA1QCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 11:02:00 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:30686 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965022AbWA1QCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 11:02:00 -0500
Date: Sat, 28 Jan 2006 17:02:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch] warn on release_region() from irq context
Message-ID: <20060128160240.GA21053@elte.hu>
References: <20060128144357.GA6881@elte.hu> <20060128150006.GA10660@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128150006.GA10660@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> the rationale for this patch is that the lock validator (which now 
> tracks rwlock dependencies too, see output below) noticed that 
> floppy.c does a release_region() from softirq context -> ouch. I'm 
> working on the floppy.c fix for that.

ugh. floppy.c is a mess. I did the patch below - but that's not enough, 
it does stupid things like request_region() and release_region() from 
the timer irq - so floppy.c file needs a serious redesign to fix these 
deadlocks :-(

	Ingo

floppy.c does alot of irq-unsafe work within floppy_release_irq_and_dma():
free_irq(), release_region() ... so when executing in irq context, push
the whole function into keventd.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 drivers/block/floppy.c |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

Index: linux/drivers/block/floppy.c
===================================================================
--- linux.orig/drivers/block/floppy.c
+++ linux/drivers/block/floppy.c
@@ -561,6 +561,21 @@ static int floppy_grab_irq_and_dma(void)
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
@@ -824,7 +839,7 @@ static int set_dor(int fdc, char mask, c
 	if (newdor & FLOPPY_MOTOR_MASK)
 		floppy_grab_irq_and_dma();
 	if (olddor & FLOPPY_MOTOR_MASK)
-		floppy_release_irq_and_dma();
+		schedule_work(&floppy_release_irq_and_dma_work);
 	return olddor;
 }
 
@@ -905,6 +920,8 @@ static int _lock_fdc(int drive, int inte
 
 		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&fdc_wait, &wait);
+
+		flush_scheduled_work();
 	}
 	command_status = FD_COMMAND_NONE;
 
@@ -938,7 +955,7 @@ static inline void unlock_fdc(void)
 	if (elv_next_request(floppy_queue))
 		do_fd_request(floppy_queue);
 	spin_unlock_irqrestore(&floppy_lock, flags);
-	floppy_release_irq_and_dma();
+	schedule_work(&floppy_release_irq_and_dma_work);
 	wake_up(&fdc_wait);
 }
 
@@ -4628,6 +4645,12 @@ void cleanup_module(void)
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
 
