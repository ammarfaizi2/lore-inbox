Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUA3Daw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 22:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266537AbUA3Daw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 22:30:52 -0500
Received: from esperance.ozonline.com.au ([203.23.159.248]:34762 "EHLO
	ozonline.com.au") by vger.kernel.org with ESMTP id S266536AbUA3Dao
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 22:30:44 -0500
Date: Fri, 30 Jan 2004 14:34:59 +1100
From: Davin McCall <davmac@ozonline.com.au>
To: Davin McCall <davmac@ozonline.com.au>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] various IDE patches/cleanups
Message-Id: <20040130143459.2c206af9.davmac@ozonline.com.au>
In-Reply-To: <20040130143355.630346cc.davmac@ozonline.com.au>
References: <20040103152802.6e27f5c5.davmac@ozonline.com.au>
	<200401051516.03364.bzolnier@elka.pw.edu.pl>
	<20040106135155.66535c13.davmac@ozonline.com.au>
	<200401061213.39843.bzolnier@elka.pw.edu.pl>
	<20040130142725.1a408f9e.davmac@ozonline.com.au>
	<20040130143041.1eb70817.davmac@ozonline.com.au>
	<20040130143355.630346cc.davmac@ozonline.com.au>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4th patch notes
---------------

choose_drive() selects which drive in a hwgroup will have a request serviced.
It tries not to return a drive whose queue is plugged, but there's a small
mistake which means it might do this sometimes.

Once we've guarenteed that the returned drive is never plugged, it's possible
to remove a check in ide_do_request() (or actually, modify it, seeing as the
drive can still get plugged between requests in the tcq case).

- (ide-io.c)
  - ide_do_request()
    - Move check of blk_queue_plugged() just after the check for the service
      routine returning ide_released. So we only check it between tcq
      requests.
  - choose_drive()
    - A plugged drive can't benefit from "nice" behaviour. Neither can
      a drive with no requests in its queue.

--- linux-2.6.0-patch3/drivers/ide/ide-io.c	Thu Jan 29 12:43:26 2004
+++ linux-2.6.0/drivers/ide/ide-io.c	Thu Jan 29 12:48:09 2004
@@ -776,7 +776,9 @@
 				if (!drive->sleep
 				/* FIXME: use time_before */
 				 && 0 < (signed long)(WAKEUP(drive) - (jiffies - best->service_time))
-				 && 0 < (signed long)((jiffies + t) - WAKEUP(drive)))
+				 && 0 < (signed long)((jiffies + t) - WAKEUP(drive))
+				 && !blk_queue_plugged(drive->queue)
+				 && !elv_queue_empty(drive->queue))
 				{
 					ide_stall_queue(best, IDE_MIN(t, 10 * WAIT_MIN_SLEEP));
 					goto repeat;
@@ -908,14 +910,6 @@
 			break;
 		}
 
-		if (blk_queue_plugged(drive->queue)) {
-			if (drive->using_tcq)
-				break;
-
-			printk(KERN_ERR "ide: huh? queue was plugged!\n");
-			break;
-		}
-
 		/*
 		 * we know that the queue isn't empty, but this can happen
 		 * if the q->prep_rq_fn() decides to kill a request
@@ -967,8 +961,11 @@
 		spin_lock_irq(&ide_lock);
 		if (hwif->irq != masked_irq)
 			enable_irq(hwif->irq);
-		if (startstop == ide_released)
+		if (startstop == ide_released) {
+			if (blk_queue_plugged(drive->queue))
+				break;		
 			goto queue_next;
+		}
 		if (startstop == ide_stopped)
 			hwgroup->busy = 0;
 	}
