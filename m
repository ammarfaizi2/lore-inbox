Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbTFOOKN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 10:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbTFOOKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 10:10:13 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:2453 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262256AbTFOOKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 10:10:09 -0400
Date: Sun, 15 Jun 2003 16:23:55 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: bad: scheduling while atomic!
Message-ID: <20030615142355.GB1063@wohnheim.fh-wedel.de>
References: <20030615142950.A32102@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030615142950.A32102@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 June 2003 14:29:50 +0100, Russell King wrote:
> 
> This instance seems to be caused by the following code in
> drivers/mtd/mtd_blkdevs.c:
> 
>          while (!tr->blkcore_priv->exiting) {
>                  spin_lock_irq(rq->queue_lock);
>  ...
>                  spin_unlock_irq(rq->queue_lock);
>  ...
>                  spin_lock_irq(rq->queue_lock);
>  ...
>          }
> 
> It would be useful if we could balance the spin_locks with the
> spin_unlocks. 8)

How about this mindless guess?

Jörn

-- 
It's just what we asked for, but not what we want!
-- anonymous

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
 
