Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbUKVLcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUKVLcu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 06:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUKVLcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 06:32:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20631 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261263AbUKVLcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 06:32:24 -0500
Date: Mon, 22 Nov 2004 12:31:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Chandler <alan@chandlerfamily.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd problem
Message-ID: <20041122113150.GF10463@suse.de>
References: <200411201842.15091.alan@chandlerfamily.org.uk> <200411211025.11629.alan@chandlerfamily.org.uk> <200411211613.54713.alan@chandlerfamily.org.uk> <200411220752.28264.alan@chandlerfamily.org.uk> <20041122080122.GM26240@suse.de> <E1CWBSN-0003mF-4s@home.chandlerfamily.org.uk> <20041122105157.GB10463@suse.de> <E1CWCOC-0003so-Ao@home.chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CWCOC-0003so-Ao@home.chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22 2004, Alan Chandler wrote:
> Jens Axboe writes: 
> 
> >On Mon, Nov 22 2004, Alan Chandler wrote:
> >>Jens Axboe writes:  
> >>
> >>>On Mon, Nov 22 2004, Alan Chandler wrote:
> >>>>On Sunday 21 November 2004 16:13, Alan Chandler wrote:
> >>>>...
> >>>>>
> >>>>> This seems to be some combination of frequently occuring timing 
> >>problem,
> >>>>> and the difference treatment in cdrom_newpc_intr to cdrom_pc_intr 
> >>>>
> >>>>I put a ndelay(400) at the head of cdrom_newpc_intr and the problem of
> >>>>DRQ being set when there was no data to transfer disappeared.  It
> >>>>appears that my hardware is too slow. 
> >>>>
> >>>>I have been reading the ATA/ATAPI - 6 spec, and it implies that the
> >>>>state of DRQ line need one pio cycle before being correct and that you
> >>>>should read the alternative status register to achieve this.  I tried
> >>>>a simple 
> >>>>
> >>>>HWIF(drive)->INB( IDE_ALTSTATUS_REG); 
> >>>>
> >>>>But that made no difference.
> >>>
> >>>ALTSTATUS read should be fine as well, but the implicit delay is
> >>>probably better. 
> >>> 
> >>
> >>I don't know why, but the ALTSTATUS read did NOT work when I tried it 
> >>yesterday (am currently at work using web mail to access my mail - can't 
> >>do more until this evening).  Its possible I put it in the wrong place 
> >>(ie after the cdrom_decode_status call, but I don't think so.  
> >>
> >>The ndelay(400) did work.  
> >>
> >>>Is this enough to fix it? For ->drq_interrupt we already should have
> >>>an adequate delay, Alan fixed this one recently. 
> >>> 
> >>
> >>Yes, I had included this patch quite early in my process of tracking
> >>the problem down (when I corrected it like you have (add the drive
> >>parameter to the OUTBSYNC macro like you have, you also need to
> >>declare an unsigned long flags at the head of the routine that was
> >>also not in that patch).  Indeed it was this that was the inspiration
> >>for the 400 nanosecs in my change.  I have no idea what the right
> >>number should be 
> >
> >400ns is the correctl value. Your writing is a little unclear to me -
> >did it work or not, with that change alone? 
> >
> 
> To be clear ... 
> 
> 
> I have modified ide-cd.c with 
> 
> 1) ndelay(400) at the head of cdrom_newpc_intr() 
> 
> 2) Alan Cox's patch in the place he originally identified for it to go 
> 
> 3) Some printk's in cdrom_newpc_intr() after the point where it reads the 
> status and IREASON and length registers and just for the purposes of 
> diagnostics. 
> 
> With only those changes it now works. 

You are not answering my question :-)

Here's is Alans patch as I posted some mails ago. Does it work with that
alone?? I'm curious of it is enough. It should not be necessary to incur
extra delay in the interrupt handler, if it is invoked from a real irq.

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

