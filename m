Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265650AbTAWR6C>; Thu, 23 Jan 2003 12:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267118AbTAWR6C>; Thu, 23 Jan 2003 12:58:02 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20903 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265650AbTAWR6B>;
	Thu, 23 Jan 2003 12:58:01 -0500
Date: Thu, 23 Jan 2003 19:06:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Gregoire Favre <greg@ulima.unil.ch>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: cdwrite@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: Can't burn DVD under 2.5.59 with ide-cd
Message-ID: <20030123180653.GU910@suse.de>
References: <200301231752.h0NHqOM5001079@burner.fokus.gmd.de> <20030123180124.GB9141@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030123180124.GB9141@ulima.unil.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23 2003, Gregoire Favre wrote:
> On Thu, Jan 23, 2003 at 06:52:24PM +0100, Joerg Schilling wrote:
> 
> > In one of my mails, I decribed why there are 2 bugs in the kernel.
> > Only one of them so far has been fixed. The sense data is still missing.
> 
> Oups, sorry I didn't read enough carefully!!!
> 
> Does someone know how to fix the sense data bug?

In drivers/ide/ide-cd.c:cdrom_end_request(), try to insert something
ala:

	if ((rq->flags & REQ_SENSE) && uptodate) {
                struct request *failed = (struct request *) rq->buffer;
                struct cdrom_info *info = drive->driver_data;
                void *sense = &info->sense_data;

+		if (failed && block_pc_request(failed))
+			printk("%s: failed %p\n", __FUNCTION__, failed->sense);

                if (failed && failed->sense)
                        sense = failed->sense;

                cdrom_analyze_sense_data(drive, failed, sense);
	}

in pseudo-patch form.

-- 
Jens Axboe

