Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264771AbSKEG5y>; Tue, 5 Nov 2002 01:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264782AbSKEG5y>; Tue, 5 Nov 2002 01:57:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2989 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264771AbSKEG5w>;
	Tue, 5 Nov 2002 01:57:52 -0500
Date: Tue, 5 Nov 2002 08:04:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Leopold Gouverneur <lgouv@pi.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cdrom broken in bk current?
Message-ID: <20021105070414.GQ29449@suse.de>
References: <20021103080514.GC748@gouv> <20021103094306.GK3612@suse.de> <20021104233831.GA510@gouv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021104233831.GA510@gouv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05 2002, Leopold Gouverneur wrote:
> On Sun, Nov 03, 2002 at 10:43:06AM +0100, Jens Axboe wrote:
> > On Sun, Nov 03 2002, Leopold Gouverneur wrote:
> > > I see the following during booting:
> > > ...
> > > end_request: I/O error, dev hdc, sector 0
> > > hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
> > > Uniform CD-ROM driver Revision: 3.12
> > > end_request: I/O error, dev hdc, sector 0
> > > end_request: I/O error, dev hdd, sector 0
> > > end_request: I/O error, dev hdd, sector 0
> > > hdd: ATAPI 16X CD-ROM drive, 256kB Cache, DMA
> > > ...
> > > 
> > > If I mount /dev/hd[cd], the system freezes completly.
> > > 
> > > This was not present in 2.5.42 IRC
> > > ny help?
> > 
> > Try with this patch.
> > 
> > -- 
> > Jens Axboe
> > 
> 
> > ===== drivers/ide/ide-cd.c 1.27 vs edited =====
> > --- 1.27/drivers/ide/ide-cd.c	Fri Oct 18 20:02:55 2002
> > +++ edited/drivers/ide/ide-cd.c	Sun Nov  3 10:33:17 2002
> > @@ -310,6 +310,7 @@
> >  #include <linux/completion.h>
> >  
> >  #include <scsi/scsi.h>	/* For SCSI -> ATAPI command conversion */
> > +#include "../scsi/scsi.h"
> >  
> >  #include <asm/irq.h>
> >  #include <asm/io.h>
> > @@ -877,10 +878,10 @@
> >  					  ide_handler_t *handler)
> >  {
> >  	unsigned char *cmd_buf	= rq->cmd;
> > -	int cmd_len		= sizeof(rq->cmd);
> >  	unsigned int timeout	= rq->timeout;
> >  	struct cdrom_info *info = drive->driver_data;
> >  	ide_startstop_t startstop;
> > +	unsigned int cmd_len;
> >  
> >  	if (CDROM_CONFIG_FLAGS(drive)->drq_interrupt) {
> >  		/* Here we should have been called after receiving an interrupt
> > @@ -902,6 +903,11 @@
> >  
> >  	/* Arm the interrupt handler. */
> >  	ide_set_handler(drive, handler, timeout, cdrom_timer_expiry);
> > +
> > +	/* cdb length, pad upto the 12th byte if necessary */
> > +	cmd_len = COMMAND_SIZE(rq->cmd[0]);
> > +	if (cmd_len < 12)
> > +		cmd_len = 12;
> >  
> >  	/* Send the command to the device. */
> >  	HWIF(drive)->atapi_output_bytes(drive, cmd_buf, cmd_len);
> 
> I tried your patch without success. The problem is still there in 2.5.46

Please verify that 2.5.42 works correctly, and send me the boot log of
such a boot.

-- 
Jens Axboe

