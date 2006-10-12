Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932622AbWJLPXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbWJLPXs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbWJLPXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:23:48 -0400
Received: from brick.kernel.dk ([62.242.22.158]:24878 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932622AbWJLPXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:23:47 -0400
Date: Thu, 12 Oct 2006 17:23:57 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
       olaf@aepfle.de
Subject: Re: 2.6.19-rc1 regression: unable to read dvd's
Message-ID: <20061012152356.GE6515@kernel.dk>
References: <87hcya8fxk.fsf@sycorax.lbl.gov> <20061012065346.GY6515@kernel.dk> <1160648885.5897.6.camel@Homer.simpson.net> <1160662435.6177.3.camel@Homer.simpson.net> <20061012120927.GQ6515@kernel.dk> <20061012122146.GS6515@kernel.dk> <87odshr289.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87odshr289.fsf@sycorax.lbl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12 2006, Alex Romosan wrote:
> Jens Axboe <jens.axboe@oracle.com> writes:
> 
> > Mike/Alex/Olaf, can you give this a spin? Totally untested here, but I
> > think it should fix it.
> >
> > diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> > index 69bbb62..e7513e5 100644
> > --- a/drivers/ide/ide-cd.c
> > +++ b/drivers/ide/ide-cd.c
> > @@ -597,7 +597,7 @@ static void cdrom_prepare_request(ide_dr
> >  	struct cdrom_info *cd = drive->driver_data;
> >  
> >  	ide_init_drive_cmd(rq);
> > -	rq->cmd_type = REQ_TYPE_BLOCK_PC;
> > +	rq->cmd_type = REQ_TYPE_ATA_PC;
> >  	rq->rq_disk = cd->disk;
> >  }
> >  
> > @@ -2023,7 +2023,8 @@ ide_do_rw_cdrom (ide_drive_t *drive, str
> >  		}
> >  		info->last_block = block;
> >  		return action;
> > -	} else if (rq->cmd_type == REQ_TYPE_SENSE) {
> > +	} else if (rq->cmd_type == REQ_TYPE_SENSE ||
> > +		   rq->cmd_type == REQ_TYPE_ATA_PC) {
> >  		return cdrom_do_packet_command(drive);
> >  	} else if (blk_pc_request(rq)) {
> >  		return cdrom_do_block_pc(drive, rq);
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 26f7856..d370d2c 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -157,6 +157,7 @@ enum rq_cmd_type_bits {
> >  	REQ_TYPE_ATA_CMD,
> >  	REQ_TYPE_ATA_TASK,
> >  	REQ_TYPE_ATA_TASKFILE,
> > +	REQ_TYPE_ATA_PC,
> >  };
> >  
> >  /*
> >
> 
> with this patch applied, i can read dvd's now (using mplayer). thanks.
> i see this in syslog as the system boots up (it wasn't there before):

Argh damn, it needs this on top of it as well. Your second problem
likely stems from that missing bit, please retest with this one applied
as well.

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index e7513e5..bddfebd 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -716,7 +716,7 @@ static int cdrom_decode_status(ide_drive
 		ide_error(drive, "request sense failure", stat);
 		return 1;
 
-	} else if (blk_pc_request(rq)) {
+	} else if (blk_pc_request(rq) || rq->cmd_type == REQ_TYPE_ATA_PC) {
 		/* All other functions, except for READ. */
 		unsigned long flags;
 

-- 
Jens Axboe

