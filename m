Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbSKBPhJ>; Sat, 2 Nov 2002 10:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261278AbSKBPhJ>; Sat, 2 Nov 2002 10:37:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39383 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261274AbSKBPhI>;
	Sat, 2 Nov 2002 10:37:08 -0500
Date: Sat, 2 Nov 2002 16:43:23 +0100
From: Jens Axboe <axboe@suse.de>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd still borken for me in 2.5.45
Message-ID: <20021102154323.GB2177@suse.de>
References: <20021102091811.GD31088@suse.de> <Pine.LNX.4.44.0211020847550.876-100000@dad.molina> <20021102145451.GA1820@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021102145451.GA1820@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02 2002, Jens Axboe wrote:
> On Sat, Nov 02 2002, Thomas Molina wrote:
> > On Sat, 2 Nov 2002, Jens Axboe wrote:
> > 
> > > > Well that was quick.  2.5.42 works correctly.  The problems begin with 
> > > > 2.5.43.
> > > 
> > > Ok, so Linus broke it :-)
> > > 
> > > Please boot with this patch, it looks like a command length screwup.
> > 
> > Your patch produced:
> > 
> > hdc: starting 5a, len = 24
> 
> ok looks fine, now please try (on top of the other one):

There's at least one report of that patch fixing the issue. Thomas, I'd
like you to try it too.

Linus, we need something like this for now, your switch to
unconditionally output 16 bytes of cdb broke lots of drives... Please
apply.

===== drivers/ide/ide-cd.c 1.27 vs edited =====
--- 1.27/drivers/ide/ide-cd.c	Fri Oct 18 20:02:55 2002
+++ edited/drivers/ide/ide-cd.c	Sat Nov  2 16:40:33 2002
@@ -863,6 +863,12 @@
 	}
 }
 
+/*
+ * fixme, this breaks for real 16-byte commands. however, lots of drives
+ * currently break if we just send 16-bytes for 10/12 byte commands
+ */
+#define MAX_CDB_BYTES	12
+
 /* Send a packet command to DRIVE described by CMD_BUF and CMD_LEN.
    The device registers must have already been prepared
    by cdrom_start_packet_command.
@@ -877,7 +883,6 @@
 					  ide_handler_t *handler)
 {
 	unsigned char *cmd_buf	= rq->cmd;
-	int cmd_len		= sizeof(rq->cmd);
 	unsigned int timeout	= rq->timeout;
 	struct cdrom_info *info = drive->driver_data;
 	ide_startstop_t startstop;
@@ -904,7 +909,7 @@
 	ide_set_handler(drive, handler, timeout, cdrom_timer_expiry);
 
 	/* Send the command to the device. */
-	HWIF(drive)->atapi_output_bytes(drive, cmd_buf, cmd_len);
+	HWIF(drive)->atapi_output_bytes(drive, cmd_buf, MAX_CDB_BYTES);
 
 	/* Start the DMA if need be */
 	if (info->dma)

-- 
Jens Axboe

