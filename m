Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261718AbSKCJeg>; Sun, 3 Nov 2002 04:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261715AbSKCJeb>; Sun, 3 Nov 2002 04:34:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64936 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261714AbSKCJea>;
	Sun, 3 Nov 2002 04:34:30 -0500
Date: Sun, 3 Nov 2002 10:40:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Luc Saillard <luc.saillard@fr.alcove.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops when using ide-cd with 2.5.45 and cdrecord
Message-ID: <20021103094052.GI3612@suse.de>
References: <20021102210103.GA25617@cedar.alcove-fr> <20021102213448.GA3612@suse.de> <20021103002346.GA25842@cedar.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103002346.GA25842@cedar.alcove-fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03 2002, Luc Saillard wrote:
> On Sat, Nov 02, 2002 at 10:34:48PM +0100, Jens Axboe wrote:
> > On Sat, Nov 02 2002, Luc Saillard wrote:
> > > Hi,
> > > I'm a using the last cdrecord version (1.11a39) when this oops occurs.
> > > I can't sync my disks with alt-sys-request because we are in interrupt
> > > :(
> > 
> > How are you invoking cdrecord? Using ide-scsi?
> > 
> Like this:
> 
>   ./cdrecord dev=/dev/hdc fs=32m speed=24 -v -eject driveropts=burnfree dump.001

ok

please reproduce with this debug patch and send me the output:

--- /opt/kernel/linux-2.5.45/drivers/ide/ide-cd.c	2002-11-01 11:31:53.000000000 +0100
+++ drivers/ide/ide-cd.c	2002-11-03 10:40:35.000000000 +0100
@@ -906,7 +906,7 @@
 	ide_set_handler(drive, handler, rq->timeout, cdrom_timer_expiry);
 
 	/* Send the command to the device. */
-	HWIF(drive)->atapi_output_bytes(drive, rq->cmd, sizeof(rq->cmd));
+	HWIF(drive)->atapi_output_bytes(drive, rq->cmd, 12);
 
 	/* Start the DMA if need be */
 	if (info->dma)
@@ -1718,6 +1718,8 @@
 		if (blen > thislen)
 			blen = thislen;
 
+		printk("%s: %x, ptr=%p,len=%d,bio=%p\n", drive->name, rq->cmd[0], ptr, blen, rq->bio);
+
 		xferfunc(drive, ptr, blen);
 
 		thislen -= blen;

-- 
Jens Axboe

