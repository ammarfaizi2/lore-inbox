Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbUKZXqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbUKZXqL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbUKZXoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 18:44:03 -0500
Received: from 82-43-72-5.cable.ubr06.croy.blueyonder.co.uk ([82.43.72.5]:9716
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S263159AbUKZXjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 18:39:07 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: Jens Axboe <axboe@suse.de>
Subject: Re: ide-cd problem
Date: Fri, 26 Nov 2004 23:39:01 +0000
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200411201842.15091.alan@chandlerfamily.org.uk> <20041123145112.GC13174@suse.de> <200411232149.31701.alan@chandlerfamily.org.uk>
In-Reply-To: <200411232149.31701.alan@chandlerfamily.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411262339.01306.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 November 2004 21:49, Alan Chandler wrote:

>
> Before, I thought my hardware was a little out of spec - now I think there
> is something else at play here.
>

Firstly, I think there might be another race condition like the one Alan Cox 
found.  I attach a patch below with the fix for that (against 2.6.10-rc2, an 
including Alan's patch)   I'm not 100% sure its necessary, but it seems fix a 
variation I have been seeing.

With it in place, and apart from the ongoing issue - see below, I have managed 
to remove the delay in drive_is_ready() altogether without any ill effects.

[my reading of the ATA spec is that 400ns is needed after reading the status 
reg before IRQ is removed, I had wondered whether it would be better to 
record the time here and then check whether we had used up the 400ns just 
before returning from the interrupt state]

> Nov 23 20:37:33 kanger kernel: ide-cd:cdrom_newpc_intr - cmd=0x0 stat=0x50
> ireason=3 len=2048 rq len=0
..
> Nov 23 20:37:33 kanger kernel: ide-cd:cdrom_newpc_intr - cmd=0x1b stat=0x58
> ireason=2 len=0 rq len=0

I think these two lines hold the crux of the problem.  They are the result of 
a printk in cdrom_newpc_intr just after reading the interrupt reason register 
and byte count registers.

However, I have been unable to get any closer as to why DRQ gets set.

The patch

--- ide-cd.c 2004-11-26 20:29:59.000000000 +0000
+++ ide-cd.patch.c 2004-11-26 20:51:23.000000000 +0000
@@ -890,8 +890,12 @@
   ide_execute_command(drive, WIN_PACKETCMD, handler, ATAPI_WAIT_PC, 
cdrom_timer_expiry);
   return ide_started;
  } else {
+  unsigned long flags; 
+  spin_lock_irqsave(&ide_lock, flags);
+  HWIF(drive)->OUTBSYNC(drive, WIN_PACKETCMD, IDE_COMMAND_REG);
+  ndelay(400);
+  spin_unlock_irqrestore(&ide_lock, flags);
   /* packet command */
-  HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
   return (*handler) (drive);
  }
 }
@@ -938,8 +942,12 @@
   cmd_len = ATAPI_MIN_CDB_BYTES;
 
  /* Send the command to the device. */
+ unsigned long flags; 
+ spin_lock_irqsave(&ide_lock, flags);
  HWIF(drive)->atapi_output_bytes(drive, rq->cmd, cmd_len);
-
+ ndelay(400);
+ spin_unlock_irqrestore(&ide_lock, flags);
+ 
  /* Start the DMA if need be */
  if (info->dma)
   hwif->dma_start(drive);

-- 
Alan Chandler
alan@chandlerfamily.org.uk
First they ignore you, then they laugh at you,
 then they fight you, then you win. --Gandhi
