Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbUKVIEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbUKVIEP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 03:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUKVIDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 03:03:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5556 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261980AbUKVIBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 03:01:54 -0500
Date: Mon, 22 Nov 2004 09:01:23 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Chandler <alan@chandlerfamily.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd problem
Message-ID: <20041122080122.GM26240@suse.de>
References: <200411201842.15091.alan@chandlerfamily.org.uk> <200411211025.11629.alan@chandlerfamily.org.uk> <200411211613.54713.alan@chandlerfamily.org.uk> <200411220752.28264.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411220752.28264.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22 2004, Alan Chandler wrote:
> On Sunday 21 November 2004 16:13, Alan Chandler wrote:
> ...
> >
> > This seems to be some combination of frequently occuring timing problem,
> > and the difference treatment in cdrom_newpc_intr to cdrom_pc_intr
> 
> I put a ndelay(400) at the head of cdrom_newpc_intr and the problem of
> DRQ being set when there was no data to transfer disappeared.  It
> appears that my hardware is too slow.
> 
> I have been reading the ATA/ATAPI - 6 spec, and it implies that the
> state of DRQ line need one pio cycle before being correct and that you
> should read the alternative status register to achieve this.  I tried
> a simple
> 
> HWIF(drive)->INB( IDE_ALTSTATUS_REG);
> 
> But that made no difference.

ALTSTATUS read should be fine as well, but the implicit delay is
probably better.

Is this enough to fix it? For ->drq_interrupt we already should have
an adequate delay, Alan fixed this one recently.

===== drivers/ide/ide-cd.c 1.97 vs edited =====
--- 1.97/drivers/ide/ide-cd.c	2004-11-07 02:54:41 +01:00
+++ edited/drivers/ide/ide-cd.c	2004-11-22 08:58:15 +01:00
@@ -890,8 +890,13 @@
 		ide_execute_command(drive, WIN_PACKETCMD, handler, ATAPI_WAIT_PC, cdrom_timer_expiry);
 		return ide_started;
 	} else {
+		unsigned long flags;
+
 		/* packet command */
-		HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
+		spin_lock_irqsave(&ide_lock, flags);
+		HWIF(drive)->OUTBSYNC(drive, WIN_PACKETCMD, IDE_COMMAND_REG);
+		ndelay(400);
+		spin_unlock_irqrestore(&ide_lock, flags);
 		return (*handler) (drive);
 	}
 }

-- 
Jens Axboe

