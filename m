Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUC1U6b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbUC1U6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:58:31 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:4539 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S262451AbUC1U6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:58:08 -0500
Date: Sun, 28 Mar 2004 22:58:22 +0200
To: Pavel Machek <pavel@ucw.cz>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl,
       kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: Kill IDE debug messages during suspend
Message-ID: <20040328205822.GA846@mars>
References: <20040326001154.GA3353@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040326001154.GA3353@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 01:11:54AM +0100, Pavel Machek wrote:
> Hi!
> 
> Suspend/resume support in ide seems to work okay these days, so this
> should be applied...
> 								Pavel
> 
> --- clean/include/linux/ide.h	2004-03-11 18:11:23.000000000 +0100
> +++ linux/include/linux/ide.h	2004-03-26 01:08:28.000000000 +0100
> @@ -24,8 +24,6 @@
>  #include <asm/io.h>
>  #include <asm/semaphore.h>
>  
> -#define DEBUG_PM
> -
>  /*
>   * This is the multiple IDE interface driver, as evolved from hd.c.
>   * It supports up to four IDE interfaces, on one or more IRQs (usually 14 & 15).
> 
> -- 
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]

What about these stale #ifdefs?

drivers/ide/ide-io.c:126:#ifdef DEBUG_PM
drivers/ide/ide-io.c:220:#ifdef DEBUG_PM
drivers/ide/ide-io.c:638:#ifdef DEBUG_PM
drivers/ide/ide-io.c:662:#ifdef DEBUG_PM


This patch sweeps up both DEBUG_PM and DEBUG #ifdefs in favour of pr_debug()


 ide-io.c |   74 ++++++++++++++++++++++++++-------------------------------------
 1 files changed, 31 insertions(+), 43 deletions(-)


--- a/drivers/ide/ide-io.c	2004-03-22 12:30:36.000000000 +0100
+++ b/drivers/ide/ide-io.c	2004-03-28 19:24:09.000000000 +0200
@@ -23,7 +23,8 @@
  * are deemed to be part of the source code.
  */
  
- 
+#undef DEBUG
+
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -123,10 +124,8 @@
 {
 	unsigned long flags;
 
-#ifdef DEBUG_PM
-	printk("%s: completing PM request, %s\n", drive->name,
-	       blk_pm_suspend_request(rq) ? "suspend" : "resume");
-#endif
+	pr_debug("%s: completing PM request, %s\n", drive->name,
+			blk_pm_suspend_request(rq) ? "suspend" : "resume");
 	spin_lock_irqsave(&ide_lock, flags);
 	if (blk_pm_suspend_request(rq)) {
 		blk_stop_queue(drive->queue);
@@ -217,10 +216,8 @@
 			}
 		}
 	} else if (blk_pm_request(rq)) {
-#ifdef DEBUG_PM
-		printk("%s: complete_power_step(step: %d, stat: %x, err: %x)\n",
-			drive->name, rq->pm->pm_step, stat, err);
-#endif
+		pr_debug("%s: complete_power_step(step: %d, stat: %x, err: %x)\n",
+				drive->name, rq->pm->pm_step, stat, err);
 		DRIVER(drive)->complete_power_step(drive, rq, stat, err);
 		if (rq->pm->pm_step == ide_pm_state_completed)
 			ide_complete_pm_request(drive, rq);
@@ -469,9 +466,7 @@
 {
 	special_t *s = &drive->special;
 
-#ifdef DEBUG
-	printk("%s: do_special: 0x%02x\n", drive->name, s->all);
-#endif
+	pr_debug("%s: do_special: 0x%02x\n", drive->name, s->all);
 	if (s->b.set_tune) {
 		s->b.set_tune = 0;
 		if (HWIF(drive)->tuneproc != NULL)
@@ -514,16 +509,16 @@
  
 		if (!args)
 			goto done;
-#ifdef DEBUG
- 		printk("%s: DRIVE_TASK_CMD ", drive->name);
- 		printk("cmd=0x%02x ", args[0]);
- 		printk("fr=0x%02x ", args[1]);
- 		printk("ns=0x%02x ", args[2]);
- 		printk("sc=0x%02x ", args[3]);
- 		printk("lcyl=0x%02x ", args[4]);
- 		printk("hcyl=0x%02x ", args[5]);
- 		printk("sel=0x%02x\n", args[6]);
-#endif
+
+ 		pr_debug("%s: DRIVE_TASK_CMD ", drive->name);
+ 		pr_debug("cmd=0x%02x ", args[0]);
+ 		pr_debug("fr=0x%02x ", args[1]);
+ 		pr_debug("ns=0x%02x ", args[2]);
+ 		pr_debug("sc=0x%02x ", args[3]);
+ 		pr_debug("lcyl=0x%02x ", args[4]);
+ 		pr_debug("hcyl=0x%02x ", args[5]);
+ 		pr_debug("sel=0x%02x\n", args[6]);
+
  		hwif->OUTB(args[1], IDE_FEATURE_REG);
  		hwif->OUTB(args[3], IDE_SECTOR_REG);
  		hwif->OUTB(args[4], IDE_LCYL_REG);
@@ -539,13 +534,13 @@
 
 		if (!args)
 			goto done;
-#ifdef DEBUG
- 		printk("%s: DRIVE_CMD ", drive->name);
- 		printk("cmd=0x%02x ", args[0]);
- 		printk("sc=0x%02x ", args[1]);
- 		printk("fr=0x%02x ", args[2]);
- 		printk("xx=0x%02x\n", args[3]);
-#endif
+
+ 		pr_debug("%s: DRIVE_CMD ", drive->name);
+ 		pr_debug("cmd=0x%02x ", args[0]);
+ 		pr_debug("sc=0x%02x ", args[1]);
+ 		pr_debug("fr=0x%02x ", args[2]);
+ 		pr_debug("xx=0x%02x\n", args[3]);
+
  		if (args[0] == WIN_SMART) {
  			hwif->OUTB(0x4f, IDE_LCYL_REG);
  			hwif->OUTB(0xc2, IDE_HCYL_REG);
@@ -564,9 +559,7 @@
  	 * NULL is actually a valid way of waiting for
  	 * all current requests to be flushed from the queue.
  	 */
-#ifdef DEBUG
- 	printk("%s: DRIVE_CMD (null)\n", drive->name);
-#endif
+	pr_debug("%s: DRIVE_CMD (null)\n", drive->name);
  	ide_end_drive_cmd(drive,
 			hwif->INB(IDE_STATUS_REG),
 			hwif->INB(IDE_ERROR_REG));
@@ -593,10 +586,8 @@
 
 	BUG_ON(!(rq->flags & REQ_STARTED));
 
-#ifdef DEBUG
-	printk("%s: start_request: current=0x%08lx\n",
-		HWIF(drive)->name, (unsigned long) rq);
-#endif
+	pr_debug("%s: start_request: current=0x%08lx\n",
+			HWIF(drive)->name, (unsigned long) rq);
 
 	/* bail early if we've exceeded max_failures */
 	if (drive->max_failures && (drive->failures > drive->max_failures)) {
@@ -635,9 +626,8 @@
 		 * point.
 		 */
 		int rc;
-#ifdef DEBUG_PM
-		printk("%s: Wakeup request inited, waiting for !BSY...\n", drive->name);
-#endif
+
+		pr_debug("%s: Wakeup request inited, waiting for !BSY...\n", drive->name);
 		rc = ide_wait_not_busy(HWIF(drive), 35000);
 		if (rc)
 			printk(KERN_WARNING "%s: bus not ready on wakeup\n", drive->name);
@@ -659,10 +649,8 @@
 		else if (rq->flags & REQ_DRIVE_TASKFILE)
 			return execute_drive_cmd(drive, rq);
 		else if (blk_pm_request(rq)) {
-#ifdef DEBUG_PM
-			printk("%s: start_power_step(step: %d)\n",
-				drive->name, rq->pm->pm_step);
-#endif
+			pr_debug("%s: start_power_step(step: %d)\n",
+					drive->name, rq->pm->pm_step);
 			startstop = DRIVER(drive)->start_power_step(drive, rq);
 			if (startstop == ide_stopped &&
 			    rq->pm->pm_step == ide_pm_state_completed)
