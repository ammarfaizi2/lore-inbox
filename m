Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbTFOP2V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 11:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbTFOP2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 11:28:21 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:29599 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262299AbTFOP2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 11:28:17 -0400
Date: Sun, 15 Jun 2003 17:42:08 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: bad: scheduling while atomic! (Part Deux)
Message-ID: <20030615154208.GC1063@wohnheim.fh-wedel.de>
References: <20030615160729.A5417@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030615160729.A5417@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 June 2003 16:07:29 +0100, Russell King wrote:
> 
> Sigh.  Another MTD deadlock, and cause of scheduling badness on UP preempt.
> 
> David, I think MTD needs an audit to ensure that no further cases exist.

Could this be done with smatch plus some perl?  Being a lazy bastard,
I like the idea of letting the machines do the boring repetetive job.

> static void cfi_intelext_sync (struct mtd_info *mtd)
> {
>         for (i=0; !ret && i<cfi->numchips; i++) {
>                 chip = &cfi->chips[i];
> 
>                 spin_lock(chip->mutex);
>                 ret = get_chip(map, chip, chip->start, FL_SYNCING);
> ...
>         }
> 
>         /* Unlock the chips again */
> 
>         for (i--; i >=0; i--) {
>                 chip = &cfi->chips[i];
> 
>                 spin_lock(chip->mutex);
> ...
>                 spin_unlock(chip->mutex);
>         }
> }

Mindless guess of a fix part 1 & 2 below.

As an anecdote, the stupid copy of cmdset_0001, cmdset_0020, did it
right.  Interesting.

Jörn

-- 
Courage is not the absence of fear, but rather the judgement that
something else is more important than fear.
-- Ambrose Redmoon

--- linux-2.5.71/drivers/mtd/mtd_blkdevs.c~mtd_spinlocks	2003-06-15 16:05:05.000000000 +0200
+++ linux-2.5.71/drivers/mtd/mtd_blkdevs.c	2003-06-15 16:19:43.000000000 +0200
@@ -93,14 +93,13 @@
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
+	spin_lock_irq(rq->queue_lock);
 	while (!tr->blkcore_priv->exiting) {
 		struct request *req;
 		struct mtd_blktrans_dev *dev;
 		int res = 0;
 		DECLARE_WAITQUEUE(wait, current);
 
-		spin_lock_irq(rq->queue_lock);
-
 		req = elv_next_request(rq);
 
 		if (!req) {
@@ -112,6 +111,7 @@
 			schedule();
 			remove_wait_queue(&tr->blkcore_priv->thread_wq, &wait);
 
+			spin_lock_irq(rq->queue_lock);
 			continue;
 		}
 
--- linux-2.5.71/drivers/mtd/chips/cfi_cmdset_0001.c~mtd_spinlocks	2003-06-15 16:05:03.000000000 +0200
+++ linux-2.5.71/drivers/mtd/chips/cfi_cmdset_0001.c	2003-06-15 17:33:43.000000000 +0200
@@ -1423,6 +1423,7 @@
 			 * with the chip now anyway.
 			 */
 		}
+		spin_unlock(chip->mutex);
 	}
 
 	/* Unlock the chips again */
