Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317157AbSFBJXI>; Sun, 2 Jun 2002 05:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317158AbSFBJXH>; Sun, 2 Jun 2002 05:23:07 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:43427 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317157AbSFBJXH>;
	Sun, 2 Jun 2002 05:23:07 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15609.58274.499517.16643@argo.ozlabs.ibm.com>
Date: Sun, 2 Jun 2002 19:21:38 +1000 (EST)
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.19 IDE 78
In-Reply-To: <3CF9B58B.9080509@evision-ventures.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

I think you have a typo here:

> diff -urN linux-2.5.19/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
> --- linux-2.5.19/drivers/ide/ide-pmac.c	2002-06-01 18:53:06.000000000 +0200
> +++ linux/drivers/ide/ide-pmac.c	2002-06-01 18:17:36.000000000 +0200
> @@ -434,7 +434,7 @@
>  		goto out;
>  	}
>  	udelay(10);
> -	OUT_BYTE(drive->ctl | 2, IDE_CONTROL_REG);
> +	ata_irq_enale(drive, 0);

ata_irq_enable surely?

Also, we need the patch below now that ata_channel.active is a
pointer.

Paul.

diff -urN linux-2.5/drivers/ide/ide-pmac.c pmac-2.5/drivers/ide/ide-pmac.c
--- linux-2.5/drivers/ide/ide-pmac.c	Sun Jun  2 14:45:47 2002
+++ pmac-2.5/drivers/ide/ide-pmac.c	Sun Jun  2 15:41:31 2002
@@ -1584,9 +1584,9 @@
 	 */
 	if (used_dma && !ide_spin_wait_hwgroup(drive)) {
 		/* Lock HW group */
-		set_bit(IDE_BUSY, &drive->channel->active);
+		set_bit(IDE_BUSY, drive->channel->active);
 		pmac_ide_check_dma(drive);
-		clear_bit(IDE_BUSY, &drive->channel->active);
+		clear_bit(IDE_BUSY, drive->channel->active);
 		spin_unlock_irq(drive->channel->lock);
 	}
 #endif
@@ -1633,7 +1633,7 @@
 		return;
 	else {
 		/* Lock HW group */
-		set_bit(IDE_BUSY, &drive->channel->active);
+		set_bit(IDE_BUSY, drive->channel->active);
 		/* Stop the device */
 		idepmac_sleep_device(drive, idx, base);
 		spin_unlock_irq(drive->channel->lock);
@@ -1663,7 +1663,7 @@
 
 	/* We resume processing on the lock group */
 	spin_lock_irq(drive->channel->lock);
-	clear_bit(IDE_BUSY, &drive->channel->active);
+	clear_bit(IDE_BUSY, drive->channel->active);
 	if (!list_empty(&drive->queue.queue_head))
 		do_ide_request(&drive->queue);
 	spin_unlock_irq(drive->channel->lock);
