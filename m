Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313302AbSDPM2T>; Tue, 16 Apr 2002 08:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313322AbSDPM2S>; Tue, 16 Apr 2002 08:28:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:44556 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313302AbSDPM2R>;
	Tue, 16 Apr 2002 08:28:17 -0400
Date: Tue, 16 Apr 2002 14:28:01 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
Message-ID: <20020416122801.GB1097@suse.de>
In-Reply-To: <27670700DF5@vcnet.vc.cvut.cz> <20020416102501.GG17043@suse.de> <3CBC04A5.1040201@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16 2002, Martin Dalecki wrote:
> Jens Axboe wrote:
> 
> 
> >yes this looks like a silly problem. the fix should be to have
> >ata_ar_get() set ATA_AR_RETURN in ar_flags:
> >
> >        if (!list_empty(&drive->free_req)) {
> >                ar = list_ata_entry(drive->free_req.next);
> >                list_del(&ar->ar_queue);
> >                ata_ar_init(drive, ar);
> >                ar->ar_flags |= ATA_AR_RETURN;
> >        }
> >
> >and then only have ata_ar_put() readd it to the list when it is set:
> >
> >static inline void ata_ar_put(ide_drive_t *drive, struct ata_request
> >*ar)
> >{
> >        if (ar->ar_flags & ATA_AR_RETURN)
> >                list_add(&ar->ar_queue, &drive->free_req);
> >	...
> >
> >Then you can also remove the ata_ar_put() conditional in
> >ide_end_drive_cmd(), just call ata_ar_put() unconditionally.
> 
> Well something similar is already in IDE 37... I have just
> invented a flag ATA_AR_STATIC which get's set in ide_raw_taskfile
> ata_ar_put ich then checking for if (!(ar->ar_flags & ATA_AR_STATIC))...
> 
> It has the desired effect in practice.

sure, just used ATA_AR_RETURN since it was there already. I'm not
particularly fond of that name though, and ATA_AR_STATIC isn't too good
either imo. how about ATA_AR_POOL? with the same semantics as
ATA_AR_RETURN, ie return to pool if flag is set.

-- 
Jens Axboe

