Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311739AbSDPK1u>; Tue, 16 Apr 2002 06:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312316AbSDPK1t>; Tue, 16 Apr 2002 06:27:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55569 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S311739AbSDPK1r>;
	Tue, 16 Apr 2002 06:27:47 -0400
Date: Tue, 16 Apr 2002 12:25:01 +0200
From: Jens Axboe <axboe@suse.de>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
Message-ID: <20020416102501.GG17043@suse.de>
In-Reply-To: <27670700DF5@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15 2002, Petr Vandrovec wrote:
> On 15 Apr 02 at 21:11, Petr Vandrovec wrote:
> > On 15 Apr 02 at 21:00, Jens Axboe wrote:
> > > > 
> > > > NULL pointer ...
> > > 
> > > Could you decode that? It doesn't look like any of your drives support
> > > TCQ, it should have enabled them right here:
> > 
> > They were already decoded... Also others reported that - after accessing
> > /proc/ide/ide0/hda/identify system dies... I believe that passing
> > hand-created request to ide_raw_taskfile corrupts drive->free_req,
> > and so subsequent drive command after this cat finds that 
> > drive->free_req.next is NULL and dies.
> 
> ide_raw_taskfile() sets rq.special to &ar - and &ar is on the stack,
> in this function. Later it falls through to __ide_end_request(), which
> does
> 
>   ar = rq->special;
>   ...
>   if (ar)
>     ata_ar_put(drive, ar);
>     
> which adds this ar into drive's free_req chain unconditionally. Maybe 
> ata_ar_put should check for ar_queue validity. And where ar_queue
> member is initialized (or at least cleared) in this case at all?

yes this looks like a silly problem. the fix should be to have
ata_ar_get() set ATA_AR_RETURN in ar_flags:

        if (!list_empty(&drive->free_req)) {
                ar = list_ata_entry(drive->free_req.next);
                list_del(&ar->ar_queue);
                ata_ar_init(drive, ar);
                ar->ar_flags |= ATA_AR_RETURN;
        }

and then only have ata_ar_put() readd it to the list when it is set:

static inline void ata_ar_put(ide_drive_t *drive, struct ata_request
*ar)
{
        if (ar->ar_flags & ATA_AR_RETURN)
                list_add(&ar->ar_queue, &drive->free_req);
	...

Then you can also remove the ata_ar_put() conditional in
ide_end_drive_cmd(), just call ata_ar_put() unconditionally.

> Unfortunately here my knowledge ends.

it was very helpful :-)

-- 
Jens Axboe

