Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267616AbTAXJRX>; Fri, 24 Jan 2003 04:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267617AbTAXJRX>; Fri, 24 Jan 2003 04:17:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21396 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267616AbTAXJRV>;
	Fri, 24 Jan 2003 04:17:21 -0500
Date: Fri, 24 Jan 2003 10:26:16 +0100
From: Jens Axboe <axboe@suse.de>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Can't burn DVD under 2.5.59 with ide-cd
Message-ID: <20030124092616.GH910@suse.de>
References: <200301231752.h0NHqOM5001079@burner.fokus.gmd.de> <20030123180124.GB9141@ulima.unil.ch> <20030123180653.GU910@suse.de> <b0qvta$fo6$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0qvta$fo6$1@forge.intermeta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24 2003, Henning P. Schmiedehausen wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> >In drivers/ide/ide-cd.c:cdrom_end_request(), try to insert something
> >ala:
> 
> >	if ((rq->flags & REQ_SENSE) && uptodate) {
> >                struct request *failed = (struct request *) rq->buffer;
> >                struct cdrom_info *info = drive->driver_data;
> >                void *sense = &info->sense_data;
> 
> >+		if (failed && block_pc_request(failed))
> >+			printk("%s: failed %p\n", __FUNCTION__, failed->sense);
> 
> >                if (failed && failed->sense)
> >                        sense = failed->sense;
> 
> Shouldn't this be below the 2nd if() and then just test "sense" ?
> 
> Like 
> 
> >                if (failed && failed->sense)
> >                        sense = failed->sense;
> 
> >+		if (failed && block_pc_request(failed))
> >+			printk("%s: failed %p\n", __FUNCTION__, sense);
> 
> That makes sure, that you report what is analyzed later here:

The interesting part is whether failed has a sense attached, and if so
what length.
> 
> >                cdrom_analyze_sense_data(drive, failed, sense);

To avoid confusion, I made the patch. Would have been easier to do in
the first place it seems :)

===== drivers/ide/ide-cd.c 1.35 vs edited =====
--- 1.35/drivers/ide/ide-cd.c	Thu Nov 21 22:56:59 2002
+++ edited/drivers/ide/ide-cd.c	Fri Jan 24 10:25:53 2003
@@ -649,6 +649,8 @@
 		struct cdrom_info *info = drive->driver_data;
 		void *sense = &info->sense_data;
 		
+		if (failed && blk_pc_request(failed))
+			printk("%s: failed, sense %p, len=%d\n", __FUNCTION__, failed->sense, failed->sense_len);
 		if (failed && failed->sense)
 			sense = failed->sense;
 
 	

-- 
Jens Axboe

