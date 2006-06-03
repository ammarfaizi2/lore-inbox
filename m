Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbWFCOad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWFCOad (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 10:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWFCOad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 10:30:33 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:25270 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030292AbWFCOad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 10:30:33 -0400
Date: Sat, 3 Jun 2006 16:30:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       "Barry K. Nathan" <barryn@pobox.com>
Subject: [patch, -rc5-mm2] lock validator: drivers/block/floppy.c fixes
Message-ID: <20060603143055.GA2749@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: lock validator: drivers/block/floppy.c fixes
From: Ingo Molnar <mingo@elte.hu>

The lock validator triggered a number of bugs in the floppy driver, all 
related to the floppy driver allocating and freeing irq and dma 
resources from interrupt context. The initial solution was to use 
schedule_work() to push this into process context, but this caused 
further problems: for example the current floppy driver in -mm2 is 
totally broken and all floppy commands time out with an error. (as 
reported by Barry K. Nathan)

This patch tries another solution: simply get rid of all that dynamic 
IRQ and DMA allocation/freeing. I doubt it made much sense back in the 
heydays of floppies (if two devices raced for DMA or IRQ resources then 
we didnt handle those cases too gracefully anyway), and today it makes 
near zero sense.

So the new code does the simplest and most straightforward thing: 
allocate IRQ and DMA resources at module init time, and free them at 
module removal time. Dont try to release while the driver is 
operational. This, besides making the floppy driver functional again has 
an added bonus, floppy IRQ stats are finally persistent and visible in 
/proc/interrupts:

  6: 63 XT-PIC-level floppy

Besides normal floppy IO i have also tested IO error handling, motor-off 
timeouts, etc. - and everything seems to be working fine.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/block/floppy.c |   61 +------------------------------------------------
 1 file changed, 2 insertions(+), 59 deletions(-)

Index: linux/drivers/block/floppy.c
===================================================================
--- linux.orig/drivers/block/floppy.c
+++ linux/drivers/block/floppy.c
@@ -251,18 +251,6 @@ static int irqdma_allocated;
 #include <linux/cdrom.h>	/* for the compatibility eject ioctl */
 #include <linux/completion.h>
 
-/*
- * Interrupt freeing also means /proc VFS work - dont do it
- * from interrupt context. We push this work into keventd:
- */
-static void fd_free_irq_fn(void *data)
-{
-	fd_free_irq();
-}
-
-static DECLARE_WORK(fd_free_irq_work, fd_free_irq_fn, NULL);
-
-
 static struct request *current_req;
 static struct request_queue *floppy_queue;
 static void do_fd_request(request_queue_t * q);
@@ -573,21 +561,6 @@ static int floppy_grab_irq_and_dma(void)
 static void floppy_release_irq_and_dma(void);
 
 /*
- * Interrupt, DMA and region freeing must not be done from IRQ
- * context - e.g. irq-unregistration means /proc VFS work, region
- * release takes an irq-unsafe lock, etc. So we push this work
- * into keventd:
- */
-static void fd_release_fn(void *data)
-{
-	mutex_lock(&open_lock);
-	floppy_release_irq_and_dma();
-	mutex_unlock(&open_lock);
-}
-
-static DECLARE_WORK(floppy_release_irq_and_dma_work, fd_release_fn, NULL);
-
-/*
  * The "reset" variable should be tested whenever an interrupt is scheduled,
  * after the commands have been sent. This is to ensure that the driver doesn't
  * get wedged when the interrupt doesn't come because of a failed command.
@@ -843,15 +816,6 @@ static int set_dor(int fdc, char mask, c
 			UDRS->select_date = jiffies;
 		}
 	}
-	/*
-	 *      We should propagate failures to grab the resources back
-	 *      nicely from here. Actually we ought to rewrite the fd
-	 *      driver some day too.
-	 */
-	if (newdor & FLOPPY_MOTOR_MASK)
-		floppy_grab_irq_and_dma();
-	if (olddor & FLOPPY_MOTOR_MASK)
-		schedule_work(&floppy_release_irq_and_dma_work);
 	return olddor;
 }
 
@@ -909,8 +873,6 @@ static int _lock_fdc(int drive, int inte
 		       line);
 		return -1;
 	}
-	if (floppy_grab_irq_and_dma() == -1)
-		return -EBUSY;
 
 	if (test_and_set_bit(0, &fdc_busy)) {
 		DECLARE_WAITQUEUE(wait, current);
@@ -967,7 +929,6 @@ static inline void unlock_fdc(void)
 	if (elv_next_request(floppy_queue))
 		do_fd_request(floppy_queue);
 	spin_unlock_irqrestore(&floppy_lock, flags);
-	schedule_work(&floppy_release_irq_and_dma_work);
 	wake_up(&fdc_wait);
 }
 
@@ -3714,8 +3675,8 @@ static int floppy_release(struct inode *
 	}
 	if (!UDRS->fd_ref)
 		opened_bdev[drive] = NULL;
-	floppy_release_irq_and_dma();
 	mutex_unlock(&open_lock);
+
 	return 0;
 }
 
@@ -3746,9 +3707,6 @@ static int floppy_open(struct inode *ino
 	if (UDRS->fd_ref == -1 || (UDRS->fd_ref && (filp->f_flags & O_EXCL)))
 		goto out2;
 
-	if (floppy_grab_irq_and_dma())
-		goto out2;
-
 	if (filp->f_flags & O_EXCL)
 		UDRS->fd_ref = -1;
 	else
@@ -3825,7 +3783,6 @@ out:
 		UDRS->fd_ref--;
 	if (!UDRS->fd_ref)
 		opened_bdev[drive] = NULL;
-	floppy_release_irq_and_dma();
 out2:
 	mutex_unlock(&open_lock);
 	return res;
@@ -3842,14 +3799,9 @@ static int check_floppy_change(struct ge
 		return 1;
 
 	if (time_after(jiffies, UDRS->last_checked + UDP->checkfreq)) {
-		if (floppy_grab_irq_and_dma()) {
-			return 1;
-		}
-
 		lock_fdc(drive, 0);
 		poll_drive(0, 0);
 		process_fd_request();
-		floppy_release_irq_and_dma();
 	}
 
 	if (UTESTF(FD_DISK_CHANGED) ||
@@ -4399,7 +4351,6 @@ static int __init floppy_init(void)
 	fdc = 0;
 	del_timer(&fd_timeout);
 	current_drive = 0;
-	floppy_release_irq_and_dma();
 	initialising = 0;
 	if (have_no_fdc) {
 		DPRINT("no floppy controllers found\n");
@@ -4559,7 +4510,7 @@ static void floppy_release_irq_and_dma(v
 	if (irqdma_allocated) {
 		fd_disable_dma();
 		fd_free_dma();
-		schedule_work(&fd_free_irq_work);
+		fd_free_irq();
 		irqdma_allocated = 0;
 	}
 	set_dor(0, ~0, 8);
@@ -4664,20 +4615,12 @@ void cleanup_module(void)
 	del_timer_sync(&fd_timer);
 	blk_cleanup_queue(floppy_queue);
 
-	/*
-	 * Wait for any asynchronous floppy_release_irq_and_dma()
-	 * calls to finish first:
-	 */
-	flush_scheduled_work();
-
 	if (usage_count)
 		floppy_release_irq_and_dma();
 
 	/* eject disk, if any */
 	fd_eject(0);
 
-	flush_scheduled_work();		/* fd_free_irq() might be pending */
-
 	wait_for_completion(&device_release);
 }
 
