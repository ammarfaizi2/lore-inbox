Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVKRP7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVKRP7a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 10:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbVKRP7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 10:59:30 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:43038 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932078AbVKRP7a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 10:59:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r6GU0upv8euto0I9GzhAI7nq00fMvuKvxH6EP+TOTIy6Hsv/ta2aGKc0CIQgqGMKHHM3tdwKpDGnOpII6MnzNeIyY4Vu1U7JF5EwcWvFww5KTM0PMV37Loy+01V+OSt9dW90X6I3QDCGQfYLAlZ2T93zkeokbEGTcY54XsO6t7E=
Message-ID: <58cb370e0511180759u4cb50535gfd7b96100a0bd70f@mail.gmail.com>
Date: Fri, 18 Nov 2005 16:59:28 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 08/10] blk: update IDE to use new blk_ordered
Cc: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <437DEE35.9060901@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051117153509.B89B4777@htj.dyndns.org>
	 <20051117153509.061D8991@htj.dyndns.org>
	 <58cb370e0511171211p60e7c248mda477015cf1bd7c5@mail.gmail.com>
	 <437DEE35.9060901@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/18/05, Tejun Heo <htejun@gmail.com> wrote:
> Hello, Bartlomiej.
>
> Bartlomiej Zolnierkiewicz wrote:
> > On 11/17/05, Tejun Heo <htejun@gmail.com> wrote:
> >
> > I fail to see how the partial completions (good + bad sectors)
> > are done in your new scheme, please explain.
> >
>
> It doesn't.  I've noted this way back when I posted this patchset the
> second time.

This should be noted in the patch description not in the announcement.

> http://marc.theaimsgroup.com/?l=linux-kernel&m=111795127124020&w=2
>
> Rationales
>
> * The actual barrier IO request is issued as a part of ordered sequence.
>   When any part of this sequence fails (any of leading flush, barrier IO
> or post flush), the whole sequence should be considered to have failed.
>
> e.g. if leading flush fails, there's no point in reporting partial or
> full success of barrier IO.  Ditto for tailing flush.  We can special
> case when only part of barrier IO fails and report partial barrier
> success, but 1. benefits are doubtful  2. even if it's implemented, it
> wouldn't work (see next rationale)
>
> * Barrier requests are not mergeable.  ie. Each barrier bio is turned
> into one barrier request and partially completing the request doesn't
> result in any successfully completed bio.

However your flush request can fail on the sector _completely_
unrelated to the barrier request so in this case old code worked
differently.  Anyway I'm fine with this change (previous logic was
too complicated).

> * SCSI doesn't handle partial completion of barrier IOs.
>
> >
> >>-
> >>-static int idedisk_prepare_flush(request_queue_t *q, struct request *rq)
> >>-{
> >>-       ide_drive_t *drive = q->queuedata;
> >>-
> >>-       if (!drive->wcache)
> >>-               return 0;
> >
> >
> > What does happen if somebody disables drive->wcache later?
> >
>
> Thanks for pointing out.  I've moved ordered configuration into
> write_cache such that ordered is reconfigured when write_cache changes.
> There can be in-flight barrier requests which are inconsistent with the
> newly updated setting, but 1. it's not too unfair to assume that user is
> responsible for that synchronization 2. the original implementation had
> the same issue 3. the consequence is not catastrophic.

The consequence could be increased number of bugreports about
failed IDE commands which wasn't the case with !drive->wcache check
in place - please leave as it was.

> >> static void ide_cacheflush_p(ide_drive_t *drive)
> >>@@ -1034,6 +993,8 @@ static int ide_disk_remove(struct device
> >>        struct ide_disk_obj *idkp = drive->driver_data;
> >>        struct gendisk *g = idkp->disk;
> >>
> >>+       blk_queue_ordered(drive->queue, QUEUE_ORDERED_NONE, NULL, 0);
> >>+
> >
> >
> > Shouldn't this be done in ide_disk_release()?
>
> Hmmm... The thing is that, AFAIK, requests are not supposed to be issued
> after ->remove is called (->remove is called only on module unload
> unless hardware is hot-unplugged and HL driver cannot be unloaded while
> it's still opened).  I think that's why both sd and ide-disk issue the
> last cache flush in ->remove callbacks but not in ->release.

Are you sure?  I think that only calling del_gendisk() assures you
that there won't be outstanding fs requests?

I have also noticed bug in ide_disk_remove() - ide_cacheflush_p()
should be called after del_gendisk() - I will fix it later.

BTW Nowadays you can dynamically dettach/attach driver from/to
device using sysfs interface.

Thanks,
Bartlomiej
